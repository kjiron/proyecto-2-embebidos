
//Using libs SDL, glibc
#include <SDL.h>	//SDL version 2.0
#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>


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

#define SCREEN_WIDTH 128	//window height
#define SCREEN_HEIGHT 64	//window width

//function prototypes
//initilise SDL
int init(int w, int h, int argc, char *args[]);



typedef struct 
{
  uint8_t x, y, w, h;

} Rect;

//Constants for UART--------------------------------------------------------

int puerto_serial,ndfs;
fd_set all_set, r_set; //file descriptors to use on select()
struct timeval tv;


uint16_t bufferRead;
uint16_t bufferWrite;

//--------------------------------------------------------------------------

// Program globals

Rect playerOne, playerTwo;
uint16_t SendPlayer = 0x9669;
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
	puerto_serial = open("/dev/ttyUSB0", O_RDWR);  // /dev/ttyS0
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
	playerOne.x = 94;
	playerOne.y = 55;
	playerOne.w = 1;
	playerOne.h = 1;


	playerTwo.x = 32;
	playerTwo.y = 55;
	playerTwo.w = 1;
	playerTwo.h = 1;
}


static void move_player(int d) {

	// if the down arrow is pressed move paddle down
	if (d == 0) {
		
		playerOne.y++;
	}
	
	// if the up arrow is pressed move paddle up
	if (d == 1) {

		playerOne.y--;
	}

}


static void draw_pixel() {

	SDL_Rect srcOne, srcTwo;
	
	srcOne.x = playerOne.x;
	srcOne.y = playerOne.y;
	srcOne.w = playerOne.w;
	srcOne.h = playerOne.h;

	srcTwo.x = playerTwo.x;
	srcTwo.y = playerTwo.y;
	srcTwo.w = playerTwo.w;
	srcTwo.h = playerTwo.h;

	int r = SDL_FillRect(screen, &srcOne, 0xffffffff);
	int a = SDL_FillRect(screen, &srcTwo, 0xffffffff);

		
	if (r !=0){
	
		printf("fill rectangle faliled in func draw_paddle()");
	}

}





int main (int argc, char *args[]) {
	
	Serial_activation();
	//printf("hola12313\n");

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
	
	init_game();


	while (quit == 0)
	{
		//printf("asdasd\n");
		
		r_set = all_set;
        tv.tv_usec = 100000;

		select(ndfs, &r_set, NULL, NULL, &tv);
		SDL_PumpEvents();

		const Uint8 *keystate = SDL_GetKeyboardState(NULL);

		if (keystate[SDL_SCANCODE_ESCAPE]) {
		
			quit = 1;
		}

	

		if (keystate[SDL_SCANCODE_DOWN]) {
			
			move_player(0);

			bufferWrite = SendPlayer;
			//printf("aqui estoy: %d\n", bufferWrite);
			write(puerto_serial, &bufferWrite, sizeof(int16_t));
			//SDL_Delay(10);
			//bufferWrite = playerOne.y;
			write(puerto_serial, &playerOne, sizeof(Rect));
			
			SDL_Delay(10);
		}

		if (keystate[SDL_SCANCODE_UP]) {

			move_player(1);

			bufferWrite = SendPlayer;
			//printf("aqui estoy: %d\n", bufferWrite);

			write(puerto_serial, &bufferWrite, sizeof(int16_t));
			//SDL_Delay(10);
			//bufferWrite = (uint8_t)playerOne.y;
			//printf("bufferWrite: %d\n", bufferWrite);

			write(puerto_serial, &playerOne, sizeof(Rect));
			
			SDL_Delay(10);
		}


		if(FD_ISSET(puerto_serial, &r_set))
		{
			printf("11111\n");

			read(puerto_serial, &bufferRead, sizeof(int16_t));
			printf("buffer : %d\n", bufferRead);
			
			if (bufferRead == SendPlayer)
			{
				//printf("2222\n");

				read(puerto_serial, &playerTwo, sizeof(Rect));
				printf("Player One : {%d}, {%d}, {%d}, {%d}\n", playerTwo.x, playerTwo.y, playerTwo.w, playerTwo.h);
				
				//playerTwo.y = bufferRead;
			}
		}



		//draw background
		SDL_RenderClear(renderer);
		SDL_FillRect(screen, NULL, 0x000000ff);
		draw_pixel();
	
		SDL_UpdateTexture(screen_texture, NULL, screen->pixels, screen->w * sizeof (Uint32));
		SDL_RenderCopy(renderer, screen_texture, NULL, NULL);
		//draw to the display
		SDL_RenderPresent(renderer);
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