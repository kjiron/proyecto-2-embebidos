
//Using libs SDL, glibc
#include <SDL.h>	//SDL version 2.0
#include "serial.h"
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include <unistd.h>
#include <termios.h>
#include <sys/ioctl.h>
#include <time.h>
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


typedef struct 
{
  uint8_t dx, dy;
} Vec2;

typedef struct 
{
  Rect rect;
  Vec2 vel;
} Splite;


//Constants for UART--------------------------------------------------------

uint16_t bufferRead;
uint16_t bufferWrite;

//--------------------------------------------------------------------------

// Program globals

uint8_t whoAmI;
Splite playerOne, playerTwo, lastPosPlayer, newPlayer;
uint16_t SendPlayer = 0x9669;
uint16_t IamPlayer1 = 0x9666;
uint16_t IamPlayer2 = 0x9667;

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



bool isPlayerNeedSend(Splite player) {
    if (player.rect.y != lastPosPlayer.rect.y) {
        lastPosPlayer = player;
        return true;
    }
    return false;
}



/* 
intenta obtener player durante 1s
return 
    0, 1, 2
*/
int recvPlayer() {
    int i = 0, n;
    uint16_t mark;
    while (1)
    {
		//lee la cantidad de bytes en el puerto serial
        ioctl(puerto_serial, FIONREAD, &n);

        if (n >= 2) {
            Serial_Read(&mark, 2);
            if (mark == IamPlayer1) {
                return 1;
            }
            if (mark == IamPlayer2) {
                return 2;
            }

            // esto nunca deberia de pasar
        }

        if (i == 5) {
            return 0;
        }
        i++;
        usleep(200);
    }
    
}

/*
sincroniza toda la ostia
return 
    1, 2
*/

int syncPlayer() {
    int player;

	//limpia el buffer del puerto serial
	usleep(20);
    tcflush(puerto_serial, TCIOFLUSH);

    while (1)
    {
        player = recvPlayer();
        if (player == 1) {
            Serial_Write(&IamPlayer2, 2);
            return 2;
        }
        if (player == 2) {
            return 1;
        }
        Serial_Write(&IamPlayer1, 2);
    }
}

Splite moveAnother(Splite s) {
    return newPlayer;
}


void forceSendPlayer() {

    if (whoAmI == 1) {

        if (isPlayerNeedSend(playerOne) || 1) {
            Serial_Write(&SendPlayer, 2);
            Serial_Write(&playerOne, sizeof(Splite));                
        }

    }
    if (whoAmI == 2) {
        if (isPlayerNeedSend(playerTwo) || 1) {
            Serial_Write(&SendPlayer, 2);
            Serial_Write(&playerTwo, sizeof(Splite));                
        }
    }

}



void updateData() {
    int n, amount;
    uint16_t mark;

    while (1)
    {
		n = select(ndfs, &r_set, NULL, NULL, &tv);
		if (n < 0)
		{
			printf("select fallo");
		}
		else if (n == 0)
		{
			printf("TIMEOUT");
		}

		else
		{
			//leo los bytes

			/*
			if (ioctl(puerto_serial, FIONREAD, &amount) == -1)
			{
				printf("Erros leyendos los bytes\n");
			}
			
			
			
			if (amount >= (2 + sizeof(Splite)))
			{
				//read(puerto_serial, &bufferRead, sizeof(int16_t));
				Serial_Read(&mark, 2);
				
				if (mark == SendPlayer)
				{
					Serial_Read(&newPlayer, sizeof(Splite));
					printf("newPlayer : {%d}, {%d}, {%d}, {%d}\n", newPlayer.rect.x, newPlayer.rect.y, newPlayer.rect.w, newPlayer.rect.h);
					continue;
				}

				//limpia el buffer del puerto serial
				usleep(10);
				tcflush(puerto_serial, TCIOFLUSH);
			}
			*/

			if(FD_ISSET(puerto_serial, &r_set))
			{
				//read(puerto_serial, &bufferRead, sizeof(int16_t));
				Serial_Read(&bufferRead, 2);
				
				if (bufferRead == SendPlayer)
				{
					Serial_Read(&newPlayer, sizeof(Splite));
					printf("newPlayer : {%d}, {%d}, {%d}, {%d}\n", newPlayer.rect.x, newPlayer.rect.y, newPlayer.rect.w, newPlayer.rect.h);
				}

				
			}



		}

		return;
    }

}



static void init_game() {
	playerOne.rect.x = 32;
	playerOne.rect.y = 55;
	playerOne.rect.w = 9;
	playerOne.rect.h = 9;
	playerOne.vel.dx = 0;
	playerOne.vel.dy = 1;



	playerTwo.rect.x = 94;
	playerTwo.rect.y = 55;
	playerTwo.rect.w = 9;
	playerTwo.rect.h = 9;
	playerTwo.vel.dx = 0;
	playerTwo.vel.dy = 1;

}


Splite move_player(Splite p) {
	const uint8_t *key = SDL_GetKeyboardState(NULL);


	if (key[SDL_SCANCODE_DOWN])
	{
		p.rect.y++;
		SDL_Delay(30);
	}

	if (key[SDL_SCANCODE_UP])
	{
		p.rect.y--;
		SDL_Delay(30);
	}

	return p;

}


static void draw_pixel() {

	SDL_Rect srcOne, srcTwo;
	
	srcOne.x = playerOne.rect.x;
	srcOne.y = playerOne.rect.y;
	srcOne.w = playerOne.rect.w;
	srcOne.h = playerOne.rect.h;

	srcTwo.x = playerTwo.rect.x;
	srcTwo.y = playerTwo.rect.y;
	srcTwo.w = playerTwo.rect.w;
	srcTwo.h = playerTwo.rect.h;

	int r = SDL_FillRect(screen, &srcOne, 0xffffffff);
	int a = SDL_FillRect(screen, &srcTwo, 0xffffffff);

		
	if (r !=0){
	
		printf("fill rectangle faliled in func draw_paddle()");
	}

}





int main (int argc, char *args[]) {
	
	int sleep_sdl = 0;
	int quit = 0;
	int state = 1;
	int r = 0;
	int n = 0;


	Serial_Init(B9600);
	//SDL Window setup
	if (init(SCREEN_WIDTH, SCREEN_HEIGHT, argc, args) == 1) {
		
		return 0;
	}
	SDL_GetWindowSize(window, &width, &height);
	Uint32 next_game_tick = SDL_GetTicks();
	
	init_game();
	whoAmI = syncPlayer();
	//limpia el buffer del puerto serial
	usleep(20);
    tcflush(puerto_serial, TCIOFLUSH);
	usleep(2000);
	//sleep(2);
	forceSendPlayer();

	while (quit == 0)
	{
		
		r_set = all_set;
        tv.tv_usec = 100000;

		
		SDL_PumpEvents();

		const Uint8 *keystate = SDL_GetKeyboardState(NULL);

		if (keystate[SDL_SCANCODE_ESCAPE]) {
		
			quit = 1;
		}


		updateData();

		if (whoAmI == 1)
		{
			playerTwo = moveAnother(playerTwo);
			playerOne = move_player(playerOne);

			if (isPlayerNeedSend(playerOne)) {
				Serial_Write(&SendPlayer, 2);
				Serial_Write(&playerOne, sizeof(Splite));                
			}
		}

		if (whoAmI == 2)
		{
			playerOne = moveAnother(playerOne);
			playerTwo = move_player(playerTwo);

			if (isPlayerNeedSend(playerTwo)) {
				Serial_Write(&SendPlayer, 2);
				Serial_Write(&playerTwo, sizeof(Splite));                
			}
		}
		
		


		/*

		if (keystate[SDL_SCANCODE_DOWN]) {
			
			move_player(0);
			Serial_Write(&SendPlayer, 2);
			SDL_Delay(30);
			Serial_Write(&playerOne, sizeof(Splite));
			SDL_Delay(30);
		}

		if (keystate[SDL_SCANCODE_UP]) {

			move_player(1);
			Serial_Write(&SendPlayer, 2);
			SDL_Delay(30);
			Serial_Write(&playerOne, sizeof(Splite));
			SDL_Delay(30);
		}
		
		//n mayor a cero significa que hay datos pendientes o fd
		n = select(ndfs, &r_set, NULL, NULL, &tv);
		if (n < 0)
		{
			printf("select fallo");
		}
		else if (n == 0)
		{
			printf("TIMEOUT");
		}

		else
		{
			if(FD_ISSET(puerto_serial, &r_set))
			{
				//read(puerto_serial, &bufferRead, sizeof(int16_t));
				Serial_Read(&bufferRead, 2);
				
				if (bufferRead == SendPlayer)
				{
					Serial_Read(&playerTwo, sizeof(Splite));
					printf("Player One : {%d}, {%d}, {%d}, {%d}\n", playerTwo.rect.x, playerTwo.rect.y, playerTwo.rect.w, playerTwo.rect.h);
				}
			}
		}
		*/
		

		



		//draw background
		SDL_RenderClear(renderer);
		SDL_FillRect(screen, NULL, 0x000000ff);
		draw_pixel();
	
		SDL_UpdateTexture(screen_texture, NULL, screen->pixels, screen->w * sizeof (Uint32));
		SDL_RenderCopy(renderer, screen_texture, NULL, NULL);
		//draw to the display
		SDL_RenderPresent(renderer);
		next_game_tick += 1000 / 60;
		sleep_sdl = next_game_tick - SDL_GetTicks();
	
		if( sleep_sdl >= 0 ) {
            				
			SDL_Delay(sleep_sdl);
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