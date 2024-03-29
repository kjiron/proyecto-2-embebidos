
//Using libs SDL, glibc
#include <SDL.h>	//SDL version 2.0
#include <stdlib.h>
#include <stdio.h>

//Includes for UART--------------------------------------------------------
#include <string.h>
#include <stdbool.h>

// Linux headers
#include <fcntl.h> // Contains file controls like O_RDWR
#include <errno.h> // Error integer and strerror() function
#include <termios.h> // Contains POSIX terminal control definitions
#include <unistd.h> // write(), read(), close()
#include <pthread.h>
#include <sys/select.h>
#include <arpa/inet.h> //inet_addr
//------------------------------------------------------------------------

#define SCREEN_WIDTH 256	//window height
#define SCREEN_HEIGHT 128	//window width

//function prototypes
//initilise SDL
int init(int w, int h, int argc, char *args[]);

typedef struct objeto
{
  uint8_t x, y, w, h, dx, dy;

} Objeto;


//Constants for UART--------------------------------------------------------

int puerto_serial,ndfs;

fd_set all_set, r_set; //file descriptors to use on select()

struct timeval tv;

int TamMsj;

char bufferRead;
char bufferWrite;

//--------------------------------------------------------------------------

// Program globals
static Objeto paddle[2];
static Objeto ball;
static Objeto wall;
uint8_t score[2];
uint8_t Master;          // 0 if Slave else Master
uint8_t Multi = 0;           // 0 if single player
uint8_t paddles_width = 2;
uint8_t paddles_height = 24;
uint8_t ball_size = 2;
int width, height;		//used if fullscreen

SDL_Window* window = NULL;	//The window we'll be rendering to
SDL_Renderer *renderer;		//The renderer SDL will use to draw to the screen

//surfaces
static SDL_Surface *screen;
static SDL_Surface *title;
static SDL_Surface *numbermap;
static SDL_Surface *end;

//textures
SDL_Texture *screen_texture;

//inisilise starting position and sizes of game elemements

void Serial_activation()
{

	struct timeval timeout;    
	timeout.tv_sec = 1;
	timeout.tv_usec = 0;

	//puerto_serial = open("/dev/ttyUSB0", O_RDWR);  // /dev/ttyS0
	puerto_serial = open("/dev/ttyS0", O_RDWR);  // /dev/ttyS0
	ndfs = puerto_serial + 1;
	
	//////preparing select()
	FD_ZERO(&all_set);
	FD_SET(puerto_serial, &all_set);
	r_set = all_set;
	tv.tv_sec = 1; 
	tv.tv_usec = 0;
	
	struct termios tty;

	// Read in existing settings, and handle any error
	if(tcgetattr(puerto_serial, &tty) != 0) 
	{
		printf("Error %i from tcgetattr: %s\n", errno, strerror(errno));
	}

	tty.c_cflag &= ~PARENB; // Clear parity bit, disabling parity (most common)
	tty.c_cflag &= ~CSTOPB; // Clear stop field, only one stop bit used in communication (most common)
	tty.c_cflag |= CS8; // 8 bits per byte (most common)
	tty.c_cflag &= ~CRTSCTS; // Disable RTS/CTS hardware flow control (most common)
	tty.c_cflag |= CREAD | CLOCAL; // Turn on READ & ignore ctrl lines (CLOCAL = 1)

	tty.c_lflag &= ~ICANON;
	tty.c_lflag &= ~ECHO; // Disable echo
	tty.c_lflag &= ~ECHOE; // Disable erasure
	tty.c_lflag &= ~ECHONL; // Disable new-line echo
	tty.c_lflag &= ~ISIG; // Disable interpretation of INTR, QUIT and SUSP
	tty.c_iflag &= ~(IXON | IXOFF | IXANY); // Turn off s/w flow ctrl
	tty.c_iflag &= ~(IGNBRK|BRKINT|PARMRK|ISTRIP|INLCR|IGNCR|ICRNL); // Disable any special handling of received bytes

	tty.c_oflag &= ~OPOST; // Prevent special interpretation of output bytes (e.g. newline chars)
	tty.c_oflag &= ~ONLCR; // Prevent conversion of newline to carriage return/line feed
	// tty.c_oflag &= ~OXTABS; // Prevent conversion of tabs to spaces (NOT PRESENT ON LINUX)
	// tty.c_oflag &= ~ONOEOT; // Prevent removal of C-d chars (0x004) in output (NOT PRESENT ON LINUX)

	tty.c_cc[VTIME] = 1;    // Wait for up to 1s (10 deciseconds), returning as soon as any data is received.
	tty.c_cc[VMIN] = 20;

	cfsetispeed(&tty, B9600);
	cfsetospeed(&tty, B9600);

	if (tcsetattr(puerto_serial, TCSANOW, &tty) != 0) 
	{
		printf("Error %i from tcsetattr: %s\n", errno, strerror(errno));
	}

}

static void init_game() {
	
	wall.x = 0;
	wall.y = 8;
	wall.w = 126;
	wall.h = 54;

	ball.x = screen->w / 2;
	ball.y = screen->h / 2;
	ball.w = 10;
	ball.h = 10;
	ball.dy = 1;
	ball.dx = 1;
	
	paddle[1].x = 2*3;
	paddle[1].y = 2*29 ;
	paddle[1].w = paddles_width;
	paddle[1].h = paddles_height;
    paddle[1].dx = 0;
    paddle[1].dy = 0;

	paddle[0].x = 2*(screen->w - 4);
	paddle[0].y = 2*29;
	paddle[0].w = paddles_width;
	paddle[0].h = paddles_height;
    paddle[0].dx = 0;
    paddle[0].dy = 0;
}

static void move_paddle(int d) {

	// if the down arrow is pressed move paddle down
	if (d == 0) {
		
		if(paddle[0].y >= 2*(wall.h - 5)) {
		
			paddle[0].y = 2*(wall.h - 5);
		
		} else { 
		
			paddle[0].y += 2;
		}
	}
	
	// if the up arrow is pressed move paddle up
	if (d == 1) {

		if(paddle[0].y <= 2*(wall.y + 1)) {
		
			paddle[0].y = 2*(wall.y + 1);

		} else {
		
			paddle[0].y -= 2;
		}
	}
}


static void draw_background() {
 
	SDL_Rect src;
	
	//draw bg with net
	src.x = 0;
	src.y = 0;
	src.w = screen->w;
	src.h = screen->h;

	//draw the backgorund
	//int r = SDL_FillRect(screen,&src,0);
	
	//if (r !=0){
		
	//	printf("fill rectangle faliled in func draw_background()");
	//}
}

static void draw_ball() {
	
	SDL_Rect src;

	src.x = ball.x;
	src.y = ball.y;
	src.w = ball.w;
	src.h = ball.h;
	
	int r = SDL_FillRect(screen , &src, 0xffffffff);

	if (r !=0){
	
		printf("fill rectangle faliled in func drawball()");
	}
}

static void draw_paddle() {

	SDL_Rect src;
	int i;

	for (i = 0; i < 2; i++) {
	
		src.x = paddle[i].x;
		src.y = paddle[i].y;
		src.w = paddle[i].w;
		src.h = paddle[i].h;
	
		int r = SDL_FillRect(screen, &src, 0xffffffff);
		
		if (r !=0){
		
			printf("fill rectangle faliled in func draw_paddle()");
		}
	}
}

int main (int argc, char *args[]) {
	
	Serial_activation();

	//SDL Window setup
	if (init(SCREEN_WIDTH, SCREEN_HEIGHT, argc, args) == 1) {
		
		return 0;
	}
	
	SDL_GetWindowSize(window, &width, &height);
	
	int sleep = 0;
	int quit = 0;
	int state = 1;
	int r = 0;
	Uint32 next_game_tick = SDL_GetTicks();
	
	// Initialize the ball position data. 
	init_game();
	
	//render loop
	while(quit == 0) {
	
		r_set = all_set;
        tv.tv_usec = 100000;

		select(ndfs, &r_set, NULL, NULL, &tv);
		//check for new events every frame
		SDL_PumpEvents();

		const Uint8 *keystate = SDL_GetKeyboardState(NULL);
		
		if (keystate[SDL_SCANCODE_ESCAPE]) {
		
			quit = 1;
		}
		
		
		if (keystate[SDL_SCANCODE_DOWN]) {
			
			move_paddle(0);

			bufferWrite=0xBB;
			write(puerto_serial, &bufferWrite, sizeof(char));
			SDL_Delay(10);
			bufferWrite = paddle[0].y/2;
			write(puerto_serial, &bufferWrite, sizeof(char));
			SDL_Delay(10);
		}

		if (keystate[SDL_SCANCODE_UP]) {

			move_paddle(1);

			bufferWrite=0xBB;
			write(puerto_serial, &bufferWrite, sizeof(char));
			SDL_Delay(10);
			bufferWrite = paddle[0].y/2;
			write(puerto_serial, &bufferWrite, sizeof(char));
			SDL_Delay(10);
		}
		
		if(FD_ISSET(puerto_serial, &r_set))
		{
			read(puerto_serial, &bufferRead, sizeof(char));
			if (bufferRead==0xBB)
			{
				read(puerto_serial, &bufferRead, sizeof(char));
				paddle[1].y = 2*(int)bufferRead;
			}
		}
		//draw background
		SDL_RenderClear(renderer);
		SDL_FillRect(screen, NULL, 0x000000ff);
		
		//display main menu
		if (state == 0 ) {
		
			if (keystate[SDL_SCANCODE_SPACE]) {
				
				state = 1;
			}
		
		//display gameover
		} else if (state == 2) {
		
			if (keystate[SDL_SCANCODE_SPACE]) {
				state = 0;
				//delay for a little bit so the space bar press dosnt get triggered twice
				//while the main menu is showing
            	SDL_Delay(500);
			}
				
		//display the game
		} else if (state == 1) {
			
			//draw paddles
			draw_paddle();

			//printf("paddle[0].y = %i \npaddle[1].y = %i \n",paddle[0].y/2,paddle[1].y/2 );
		}
	
		SDL_UpdateTexture(screen_texture, NULL, screen->pixels, screen->w * sizeof (Uint32));
		SDL_RenderCopy(renderer, screen_texture, NULL, NULL);

		//draw to the display
		SDL_RenderPresent(renderer);
				
		//time it takes to render  frame in milliseconds
		next_game_tick += 1000 / 60;
		sleep = next_game_tick - SDL_GetTicks();
	
		if( sleep >= 0 ) {
            				
			SDL_Delay(sleep);
		}
	}

	//free loaded images
	SDL_FreeSurface(screen);
	SDL_FreeSurface(title);
	SDL_FreeSurface(numbermap);
	SDL_FreeSurface(end);

	//free renderer and all textures used with it
	SDL_DestroyRenderer(renderer);
	
	//Destroy window 
	SDL_DestroyWindow(window);

	//Quit SDL subsystems 
	SDL_Quit(); 
	 
	return 0;
	
}

int init(int width, int height, int argc, char *args[]) {

	//Initialize SDL
	if (SDL_Init(SDL_INIT_VIDEO) < 0) {

		printf("SDL could not initialize! SDL_Error: %s\n", SDL_GetError());
		
		return 1;
	} 
	
	int i;
	
	for (i = 0; i < argc; i++) {
		
		//Create window	
		if(strcmp(args[i], "-f")) {
			
			SDL_CreateWindowAndRenderer(SCREEN_WIDTH, SCREEN_HEIGHT, SDL_WINDOW_SHOWN, &window, &renderer);
		
		} else {
		
			SDL_CreateWindowAndRenderer(SCREEN_WIDTH, SCREEN_HEIGHT, SDL_WINDOW_FULLSCREEN_DESKTOP, &window, &renderer);
		}
	}

	if (window == NULL) { 
		
		printf("Window could not be created! SDL_Error: %s\n", SDL_GetError());
		
		return 1;
	}

	//create the screen sruface where all the elemnts will be drawn onto (ball, paddles, net etc)
	screen = SDL_CreateRGBSurfaceWithFormat(0, width, height, 32, SDL_PIXELFORMAT_RGBA32);
	
	if (screen == NULL) {
		
		printf("Could not create the screen surfce! SDL_Error: %s\n", SDL_GetError());

		return 1;
	}

	//create the screen texture to render the screen surface to the actual display
	screen_texture = SDL_CreateTextureFromSurface(renderer, screen);

	if (screen_texture == NULL) {
		
		printf("Could not create the screen_texture! SDL_Error: %s\n", SDL_GetError());

		return 1;
	}

	//Load the title image
	title = SDL_LoadBMP("title.bmp");

	if (title == NULL) {
		
		printf("Could not Load title image! SDL_Error: %s\n", SDL_GetError());

		return 1;
	}
	
	//Load the numbermap image
	numbermap = SDL_LoadBMP("numbermap.bmp");

	if (numbermap == NULL) {
		
		printf("Could not Load numbermap image! SDL_Error: %s\n", SDL_GetError());

		return 1;
	}
	
	//Load the gameover image
	end = SDL_LoadBMP("gameover.bmp");

	if (end == NULL) {
		
		printf("Could not Load title image! SDL_Error: %s\n", SDL_GetError());

		return 1;
	}
	
	// Set the title colourkey. 
	Uint32 colorkey = SDL_MapRGB(title->format, 255, 0, 255);
	SDL_SetColorKey(title, SDL_TRUE, colorkey);
	SDL_SetColorKey(numbermap, SDL_TRUE, colorkey);
	
	return 0;
}
