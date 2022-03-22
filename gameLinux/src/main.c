
//Using libs SDL, glibc
#include <SDL.h>	//SDL version 2.0
#include "serial.h"
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
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
	
	//Serial_activation();
	//printf("hola12313\n");
	Serial_Init(B9600);
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
			Serial_Write(&SendPlayer, 2);
			SDL_Delay(30);
			Serial_Write(&playerOne, sizeof(Rect));
			SDL_Delay(30);
		}

		if (keystate[SDL_SCANCODE_UP]) {

			move_player(1);
			Serial_Write(&SendPlayer, 2);
			SDL_Delay(30);
			Serial_Write(&playerOne, sizeof(Rect));
			SDL_Delay(30);
		}


		if(FD_ISSET(puerto_serial, &r_set))
		{
			//read(puerto_serial, &bufferRead, sizeof(int16_t));
			Serial_Read(&bufferRead, 2);
			
			if (bufferRead == SendPlayer)
			{
				Serial_Read(&playerTwo, sizeof(Rect));
				printf("Player One : {%d}, {%d}, {%d}, {%d}\n", playerTwo.x, playerTwo.y, playerTwo.w, playerTwo.h);
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