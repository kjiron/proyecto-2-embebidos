
//Using libs SDL, glibc
#include <SDL.h>	//SDL version 2.0
#include <stdlib.h>
#include <stdio.h>

#define SCREEN_WIDTH 128	//window height
#define SCREEN_HEIGHT 64	//window width

//function prototypes
//initilise SDL
int init(int w, int h, int argc, char *args[]);

typedef struct ball_s {

	int x, y; /* position on the screen */
	int w,h; // ball width and height
} ball_t;

// Program globals
static ball_t ball;
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
static void init_game() {
	
	ball.x = screen->w / 2;
	ball.y = screen->h / 2;
	ball.w = 1;
	ball.h = 1;
}

static void move_paddle(int d) {

	// if the down arrow is pressed move paddle down
	if (d == 0) {

		if(ball.y <= 0) {
		
			ball.y = 0;

		} else {
		
			ball.y -= 1;
		}
	}
	
	// if the up arrow is pressed move paddle up
	if (d == 1) {

		if(ball.x >= screen->w - ball.w) {
		
			ball.x = screen->w - ball.w;

		} else {
		
			ball.x += 1;
		}
	}
	
	if (d == 2) {
		
		if(ball.y >= screen->h - ball.h) {
		
			ball.y = screen->h - ball.h;
		
		} else { 
		
			ball.y += 1;
		}
	}

	if (d == 3) {

		if(ball.x <= 0) {
		
			ball.x = 0;

		} else {
		
			ball.x -= 1;
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

int main (int argc, char *args[]) {
		
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
	
		//check for new events every frame
		SDL_PumpEvents();

		const Uint8 *keystate = SDL_GetKeyboardState(NULL);
		
		if (keystate[SDL_SCANCODE_ESCAPE]) {
		
			quit = 1;
		}
		
		if (keystate[SDL_SCANCODE_UP]) {
			
			move_paddle(0);
		}

		if (keystate[SDL_SCANCODE_RIGHT]) {
			
			move_paddle(1);
		}

		if (keystate[SDL_SCANCODE_DOWN]) {
			
			move_paddle(2);
		}

		if (keystate[SDL_SCANCODE_LEFT]) {
			
			move_paddle(3);
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
			
			//* Put the ball on the screen.
			draw_ball();
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
