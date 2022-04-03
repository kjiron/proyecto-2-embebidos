
//Using libs SDL, glibc
#include <SDL.h>	//SDL version 2.0
#include "serial.h"
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include <unistd.h>
#include <time.h>
//------------------------------------------------------------------------

#define SCREEN_WIDTH 128	//window height
#define SCREEN_HEIGHT 64	//window width
#define NUM_ASTEROIDS 13
//function prototypes
//initilise SDL
int init(int w, int h, int argc, char *args[]);



void Delay_ms(uint32_t s) {
	SDL_Delay(s);
}


typedef struct
{
  int8_t x, y;
  int8_t w, h;
} Rect;


//Constants for UART--------------------------------------------------------

uint16_t bufferRead;
uint16_t bufferWrite;


//--------------------------------------------------------------------------

// Program globals

uint8_t SendAsteroid = 0xBB;
uint8_t SendAsteroid2 = 0xEE;
uint8_t SendAsteroid3 = 0xAA;
uint8_t SendAsteroid4 = 0xA9;
uint8_t SendAsteroid5 = 0xA8;
uint8_t SendAsteroid6 = 0xA7;
uint8_t SendAsteroid7 = 0xA6;
uint8_t SendAsteroid8 = 0xA5;
uint8_t SendAsteroid9 = 0xA4;
uint8_t SendAsteroid10 = 0xA3;
uint8_t SendAsteroid11 = 0xA2;
uint8_t SendAsteroid12 = 0xA1;
uint8_t SendAsteroid13 = 0xA0;
uint16_t SendTime = 0x9555;




int width, height;		//used if fullscreen

SDL_Window* window = NULL;	//The window we'll be rendering to
SDL_Renderer *renderer;		//The renderer SDL will use to draw to the screen
Rect timer;
//surfaces
static SDL_Surface *screen;
static SDL_Surface *title;
static SDL_Surface *numbermap;
static SDL_Surface *end;

//textures
SDL_Texture *screen_texture;


static void draw_horizontal_line(Rect *s) {

	SDL_Rect src;
	//printf("pintando la ostia\n");
	
	for (int i = 0; i < NUM_ASTEROIDS; i++)
    {
        src.x = s[i].x;
        src.y = s[i].y;
        src.w = s[i].w;
        src.h = s[i].h;
        int r = SDL_FillRect(screen, &src, 0xffffffff);
    }
	

}

void draw_box(Rect t)
{
	SDL_Rect src;
    src.x = t.x;
    src.y = t.y;
    src.w = t.w;
    src.h = t.h;

    int r = SDL_FillRect(screen, &src, 0xffffffff);


}




// randint(10) -> 0 .. 10
uint8_t randint(uint8_t n)
{
    return (uint8_t)(rand() % (n+1));
}

void initEnvironment(Rect *s)
{
    uint8_t i, offset_x, offset_y;
    offset_x = 0;
    offset_y = 53;
    for (i = 0; i < NUM_ASTEROIDS; i++)
    {        
        s[i].x = offset_x;
        s[i].y = offset_y;
        s[i].w = 3;
        s[i].h = 1;

        offset_x = randint(123); 
        
        offset_y = offset_y - 4;
    }

    timer.x = 62;
    timer.y = 3;
    timer.w = 1;
    timer.h = 60;  
}


void environment(Rect *s)
{
    uint8_t i;
    for (i = 0; i < NUM_ASTEROIDS; i++)
    {
        //draw_horizontal_line(s[i], ERASE);

        if ((i % 2) == 1)
        {
            if (s[i].x <= 0)
            {
                s[i].x = 124;
            }
            s[i].x--;
        }
        else
        {
            if (s[i].x >= 124)
            {
                s[i].x = 0;
            }
            s[i].x++;
        }
        //draw_horizontal_line(s[i], DRAW);
    }
    
}



void Update_Asteroids(Rect *s)
{
    int n, i;
    i = 0;
    uint8_t mark;
    //printf("nuevo\n");

    while (1)
    {
        n = Serial_Available();
        //printf("n > {%d}\n", n);

        if (n >= (1 + sizeof(Rect)))
        {
            Serial_Read(&mark, 1);
            //printf("mark > {%d}\n", mark);

            if (mark == SendAsteroid)
            {
                Serial_Read(&s[0].x, 1);
                //printf("a = {%d}, {%d}, {%d}, {%d}\n", s[0].x, s[0].y, s[0].w, s[0].h);
                //i++;
                continue;
                
            }
            if (mark == SendAsteroid2)
            {
                Serial_Read(&s[1].x, 1);
                //printf("b = {%d}, {%d}, {%d}, {%d}\n", s[1].x, s[1].y, s[1].w, s[1].h);
                //i++;
                continue;
                
            }

            if (mark == SendAsteroid3)
            {
                
                Serial_Read(&s[2].x, 1);

                //printf("c = {%d}, {%d}, {%d}, {%d}\n", s[2].x, s[2].y, s[2].w, s[2].h);
                //i++;
                continue;
                
            }

            if (mark == SendAsteroid4)
            {
                
                Serial_Read(&s[3].x, 1);
                //printf("d = {%d}, {%d}, {%d}, {%d}\n", s[3].x, s[3].y, s[3].w, s[3].h);
                //i++;
                continue;
                
            }

            if (mark == SendAsteroid5)
            {
                Serial_Read(&s[4].x, 1);
                //printf("e = {%d}, {%d}, {%d}, {%d}\n", s[4].x, s[4].y, s[4].w, s[4].h);
                //i++;
                continue;
                
            }

            if (mark == SendAsteroid6)
            {
                Serial_Read(&s[5].x, 1);
                //printf("f = {%d}, {%d}, {%d}, {%d}\n", s[5].x, s[5].y, s[5].w, s[5].h);
                //i++;
                continue;
                
            }

            if (mark == SendAsteroid7)
            {
                Serial_Read(&s[6].x, 1);
                //printf("g = {%d}, {%d}, {%d}, {%d}\n", s[6].x, s[6].y, s[6].w, s[6].h);
                //i++;
                continue;
                
            }

            if (mark == SendAsteroid8)
            {
                Serial_Read(&s[7].x, 1);
                //printf("h = {%d}, {%d}, {%d}, {%d}\n", s[7].x, s[7].y, s[7].w, s[7].h);
                //i++;
                continue;
                
            }

            if (mark == SendAsteroid9)
            {
                Serial_Read(&s[8].x, 1);
                //printf("i = {%d}, {%d}, {%d}, {%d}\n", s[8].x, s[8].y, s[8].w, s[8].h);
                //i++;
                continue;
                
            }

            if (mark == SendAsteroid10)
            {
                Serial_Read(&s[9].x, 1);
                //printf("j = {%d}, {%d}, {%d}, {%d}\n", s[9].x, s[9].y, s[9].w, s[9].h);
                //i++;
                continue;
                
            }

            if (mark == SendAsteroid11)
            {
                Serial_Read(&s[10].x, 1);
                //printf("k = {%d}, {%d}, {%d}, {%d}\n", s[10].x, s[10].y, s[10].w, s[10].h);
                //i++;
                continue;
                
            }

            if (mark == SendAsteroid12)
            {
                Serial_Read(&s[11].x, 1);
                //printf("l = {%d}, {%d}, {%d}, {%d}\n", s[11].x, s[11].y, s[11].w, s[11].h);
                //i++;
                continue;
                
            }

            if (mark == SendAsteroid13)
            {
                Serial_Read(&s[12].x, 1);
                //printf("m = {%d}, {%d}, {%d}, {%d}\n", s[12].x, s[12].y, s[12].w, s[12].h);
                //i++;
                continue;
                
            }

            
            Serial_clear();
        }
        return;
    }
    
}




int main (int argc, char *args[]) {
	
	int sleep_sdl = 0;
	int quit = 0;
	int state = 1;
	int r = 0;
	int n = 0;
    int i = 0;
    time_t begin_s, end_s;
    double elapsed, prev_elapsed = 0.0;
    Rect m[NUM_ASTEROIDS];//cuidado
    int aux;
    aux = sizeof(Rect);
	//printf("holaaaa {%d}", aux);
    //return 0;
	//SDL Window setup
	if (init(SCREEN_WIDTH, SCREEN_HEIGHT, argc, args) == 1) {
		
		return 0;
	}
	SDL_GetWindowSize(window, &width, &height);
	Uint32 next_game_tick = SDL_GetTicks();
    Serial_Init("/dev/ttyUSB0", B9600);
    initEnvironment(m);

    //printf("carepicha\n");
    
    time(&begin_s); 
    printf("{%d}s\n", i);

	while (quit == 0)
	{
        


		SDL_PumpEvents();

		const Uint8 *keystate = SDL_GetKeyboardState(NULL);

		if (keystate[SDL_SCANCODE_ESCAPE]) {
		
			quit = 1;
		}
		//logica de asteroides
        //environment(m);
        
        Update_Asteroids(m);


		


        //parte de pintado en SDL
		SDL_RenderClear(renderer);
		SDL_FillRect(screen, NULL, 0x000000ff);
		draw_horizontal_line(m);
        draw_box(timer);
		SDL_UpdateTexture(screen_texture, NULL, screen->pixels, screen->w * sizeof (Uint32));
		SDL_RenderCopy(renderer, screen_texture, NULL, NULL);
		//draw to the display
		SDL_RenderPresent(renderer);
		next_game_tick += 1000 / 60;
		sleep_sdl = next_game_tick - SDL_GetTicks();
	
		if( sleep_sdl >= 0 ) {
            				
			SDL_Delay(sleep_sdl);
		}


        time(&end_s);
        elapsed = difftime(end_s, begin_s);
        if (elapsed >= 1.0)
        {
            Serial_Write(&SendTime, 2);
            i++;
            printf("{%d}s\n", i);
            timer.y++;
            if (i == 60)
            {
                quit = 1;
            }
            
            time(&begin_s);


        }
        
	}
	//liberar memoria
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