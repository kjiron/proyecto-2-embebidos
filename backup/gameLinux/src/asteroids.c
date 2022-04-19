#include <SDL.h>	//SDL version 2.0
#include "serial.h"
#include "random.h"
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include <unistd.h>
#include <time.h>

#define SCREEN_WIDTH 128	//window height
#define SCREEN_HEIGHT 64	//window width
#define NUM_ASTEROIDS 13



int init(int w, int h, int argc, char *args[]);


/*
Intenta replicar el delay en pic
*/
void Delay_ms(uint32_t s) {
	SDL_Delay(s);
}

/*
Estructura generica
*/
typedef struct
{
  int8_t x, y;
  int8_t w, h;
} Rect;




/*
marcas necesarias para el juego
*/
uint16_t SendAck        = 0x9111;
uint16_t SendInit       = 0x9222;
uint16_t SendUpdateAst  = 0x9333;
uint16_t SendPlayer 	= 0x9444;
uint16_t SendTime       = 0x9555;
uint16_t SendPlayerX    = 0x9666;
uint16_t SendScore      = 0x9777;
uint16_t SendTimeOut    = 0x9888;







int width, height;		//used if fullscreen

SDL_Window* window = NULL;	//The window we'll be rendering to
SDL_Renderer *renderer;		//The renderer SDL will use to draw to the screen


Rect timer, playerOne, playerTwo;
uint8_t flagMove = 0;
uint8_t scoreA, scoreB;

//surfaces
static SDL_Surface *screen;
static SDL_Surface *title;
static SDL_Surface *numbermap;
static SDL_Surface *end;

//textures
SDL_Texture *screen_texture;

/*
dibujos los asteroides
*/
static void draw_horizontal_line(Rect *s) {
	SDL_Rect src;
	//printf("pintando la picha\n");
	
	for (int i = 0; i < NUM_ASTEROIDS; i++)
    {
        src.x = s[i].x;
        src.y = s[i].y;
        src.w = s[i].w;
        src.h = s[i].h;
        int r = SDL_FillRect(screen, &src, 0xffffffff);
    }
}

/*
dibuja el timer
*/
void draw_box(Rect t)
{
	SDL_Rect src;
    src.x = t.x;
    src.y = t.y;
    src.w = t.w;
    src.h = t.h;

    int r = SDL_FillRect(screen, &src, 0xffffffff);
}


/*
recreo el mismo entorno para los cohetes, utilizando randint(min, max)
*/
void initEnvironment(Rect *s)
{
    uint8_t i, offset_x, offset_y;
    offset_y = 53;
    for (i = 0; i < NUM_ASTEROIDS; i++)
    {       
        offset_x = randint(0, 123);  
        s[i].x = offset_x;
        s[i].y = offset_y;
        s[i].w = 3;
        s[i].h = 1;

        
        
        offset_y = offset_y - 4;
    }

    timer.x = 62;
    timer.y = 3;
    timer.w = 1;
    timer.h = 60;  
}


/*
actualizo la bandera para mover los asteroides , el jugador leido por uart y el score
*/
void updateAsteroids()
{
    int n, i;
    i = 0;
    uint16_t mark;


    while (1)
    {
        n = Serial_Available();
        //printf("n > {%d}\n", n);

        if (n >= 2)
        {
            Serial_Read(&mark, 2);

            if (mark == SendUpdateAst)
            {
                flagMove = 1;
                printf("Tick from PIC\n");
                continue;
            }
            
            if (mark == SendPlayer)
            {
                printf("Recv player from PIC\n");
                Serial_Read(&playerTwo, sizeof(Rect));
                continue;
            }

            if (mark == SendPlayerX)
            {
                printf("Recv NEW player from PIC\n");
                Serial_Read(&playerOne, sizeof(Rect));
                continue;
            }

            if (mark == SendScore)
            {
                scoreA++;
                continue;
            }
            

            Serial_clear();
        }
        return;
    }
    
}


/*
detecto colision
*/
bool check_collision(Rect rect1, Rect rect2)
{
    return rect1.x < rect2.x + rect2.w &&
       rect1.x + rect1.w > rect2.x &&
       rect1.y < rect2.y + rect2.h &&
       rect1.h + rect1.y > rect2.y;
}


/*
muevo los asteroides segun la marca de tiempo y envio si existe una colision con los cohetes
*/
void moveAsteroids(Rect *s)
{
    if (flagMove)
    {
        flagMove = 0;

        
        

        for (size_t i = 0; i < NUM_ASTEROIDS; i++)
        {

            if (check_collision(s[i], playerOne))
            {
                playerOne.y = 55;
                Serial_Write(&SendPlayerX, 2);
                Serial_Write(&playerOne, sizeof(Rect));

            }

            
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
            
        }
        
    }
    
    
}

/*
aqui vamos a sincronizar el inicio
*/
void syncGame()
{
    int n;
    uint16_t mark;

    while (1)
    {
        n = Serial_Available();
        printf("n: {%d}\n", n);

        if (n >= 2)
        {
            Serial_Read(&mark, 2);
            printf("mark: {%d}\n", mark);
            
            if (mark == SendInit)
            {
                printf("Sincronizados\n");
                Serial_Write(&SendAck, 2);
                printf("Enviando ACK {%d}\n", SendAck);

                break;
            }
            Serial_clear();
        }
    }
}

/*
seteo las posiciones iniciales, se ponen h y w en 9 debido a que las
imagenes en PIC son 9x9
*/
void initGame()
{
    playerOne.x = 94;
    playerOne.y = 55;
    playerOne.w = 9;
    playerOne.h = 9;

    playerTwo.x = 32;
    playerTwo.y = 55;
    playerTwo.w = 9;
    playerTwo.h = 9;

}


/*
muevo los jugadores, se podria mejorar con una estrucuta de keys
*/
void move_player(int d) {
	if (d == 1)
    {
        playerOne.y--;
        if (playerOne.y <= 0)
        {
            scoreB++;
            Serial_Write(&SendScore, 2);
            playerOne.y = 55;
        }

        
        
        SDL_Delay(75);

    }

    else
    {
        playerOne.y++;

        if ((playerOne.y + (playerOne.h - 1)) >= 63) 
        {
            playerOne.y = 55;
        }
        SDL_Delay(75);

    }

}

/*
pinta a los jugadores
*/
static void draw_pixel() {

	SDL_Rect srcOne, srcTwo;
	//printf("pintando la picha\n");
	
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
	
	int sleep_sdl = 0;
	int quit = 0;
    int i = 0;
    time_t begin_s, end_s;
    double elapsed;
    Rect m[NUM_ASTEROIDS];



	//SDL Window setup
	if (init(SCREEN_WIDTH, SCREEN_HEIGHT, argc, args) == 1) {
		
		return 0;
	}
	SDL_GetWindowSize(window, &width, &height);
	Uint32 next_game_tick = SDL_GetTicks();


    Serial_Init("/dev/ttyUSB0", B19200);
    randomSeed(33);
    initEnvironment(m);
    initGame();
    syncGame();
    //dejo la marca de inicio
    time(&begin_s); 
    printf("{%d}s\n", i);



	while (quit == 0)
	{
        


		SDL_PumpEvents();

		const Uint8 *keystate = SDL_GetKeyboardState(NULL);

		if (keystate[SDL_SCANCODE_ESCAPE]) {
		
			quit = 1;
		}
		
        updateAsteroids();
        moveAsteroids(m);

		if (keystate[SDL_SCANCODE_DOWN]) {
			
			move_player(0);
			Serial_Write(&SendPlayer, 2);
			Serial_Write(&playerOne, sizeof(Rect));
            //SDL_Delay(15);

		}

		if (keystate[SDL_SCANCODE_UP]) {

			move_player(1);
			Serial_Write(&SendPlayer, 2);
			Serial_Write(&playerOne, sizeof(Rect));
            //SDL_Delay(15);
		}

        //parte de pintado en SDL
		SDL_RenderClear(renderer);
		SDL_FillRect(screen, NULL, 0x000000ff);

        //pinto asteroides, tiempo y jugadores
		draw_horizontal_line(m);
        draw_box(timer);
        draw_pixel();
        printf("Score: {%d},{%d}\n", scoreA, scoreB);



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
                //le mando una marca diciendo que el juego acabo
                Serial_Write(&SendTimeOut, 2);

                if (scoreA > scoreB)
                {
                    printf("YOU LOSE\n");
                }

                else if (scoreB > scoreA)
                {
                    printf("YOU WIN\n");

                }

                else
                {
                    printf("YOU LOSE\n");
                }
                
                
                

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
	SDL_DestroyRenderer(renderer);
	SDL_DestroyWindow(window);
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