#include <SDL.h>	//SDL version 2.0
#include "serial.h"
#include "random.h"
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include <unistd.h>
#include <time.h>

#include "Include/drawSDL2.h"
/*
#define SCREEN_WIDTH 128	//window height
#define SCREEN_HEIGHT 64	//window width
*/
#define NUM_ASTEROIDS 13

//int init(int w, int h, int argc, char *args[]);

/*
Intenta replicar el delay en pic
*/
void Delay_ms(uint32_t s) {
	SDL_Delay(s);
}

/*
Estructura generica ligera
*/
typedef struct
{
  int8_t x, y;
  int8_t w, h;
} Recta;

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

//int width, height;		//used if fullscreen
int delaysist = 0;
//SDL_Window* window = NULL;	//The window we'll be rendering to
//SDL_Renderer *renderer;		//The renderer SDL will use to draw to the screen

Rect timer, playerOne, playerTwo;
Recta Uart_playerOne, Uart_playerTwo;
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
    int i, offset_x, offset_y;
    offset_x = 0;
    offset_y = 53*scale_y;
    for (i = 0; i < NUM_ASTEROIDS; i++)
    {       
        offset_x = randint(0, 123)*scale_x;  
        s[i].x = offset_x;
        s[i].y = offset_y;
        s[i].w = 30;
        s[i].h = 10;

        
        
        offset_y = offset_y - 40;
    }

    timer.x = 620;
    timer.y = 30;
    timer.w = 10;
    timer.h = 600;  
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
                //printf("Tick from PIC\n");
                continue;
            }
            
            if (mark == SendPlayer)
            {
                //printf("Recv player from PIC\n");
                Serial_Read(&Uart_playerTwo, sizeof(Recta));
                playerTwo.y = Uart_playerTwo.y*scale_y;
                continue;
            }

            if (mark == SendPlayerX)
            {
                //printf("Recv NEW player from PIC\n");
                Serial_Read(&Uart_playerOne, sizeof(Recta));
                playerOne.y = Uart_playerOne.y*scale_y;
                continue;
            }

            if (mark == SendScore)
            {
                scoreA++;
                continue;
            }
            //printf("playerTwo.y: %i\nplayerTwo.x: %i\n",playerTwo.y, playerTwo.x);

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

                playerOne.y = 550;
                Uart_playerOne.y = playerOne.y/scale_y;
                Serial_Write(&SendPlayerX, 2);
                Serial_Write(&Uart_playerOne, sizeof(Recta));

            }
            
            if ((i % 2) == 1)
            {

                if (s[i].x <= 0)
                {
                    s[i].x = 1240;
                }
            	s[i].x = s[i].x - scale_x;
            
            }

            else
            {

                if (s[i].x >= 1240)
                {
                    s[i].x = 0;
                }
                s[i].x = s[i].x + scale_x;
            
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
        //printf("n: {%d}\n", n);

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

    playerOne.x = 940;
    playerOne.y = 550;
    playerOne.w = 90;
    playerOne.h = 90;

    playerTwo.x = 320;
    playerTwo.y = 550;
    playerTwo.w = 90;
    playerTwo.h = 90;

    Uart_playerOne.x = 94;
    Uart_playerOne.y = 55;
    Uart_playerOne.w = 9;
    Uart_playerOne.h = 9;

    Uart_playerTwo.x = 32;
    Uart_playerTwo.y = 55;
    Uart_playerTwo.w = 9;
    Uart_playerTwo.h = 9;

}


/*
muevo los jugadores, se podria mejorar con una estrucuta de keys
*/
void move_player(int d) {
	if (d == 1)
    {
        playerOne.y = playerOne.y - scale_y;
        
        if (playerOne.y <= 0)
        {
            scoreB++;
            Serial_Write(&SendScore, 2);
            playerOne.y = 550;
			//printf("player.y %i\n", playerOne.y );
        }

        //SDL_Delay(delaysist);

    }

    else
    {
        
        playerOne.y = playerOne.y + scale_y;

        if ((playerOne.y + (playerOne.h - 10)) >= 630) 
        {
            playerOne.y = 550;
        }
        
        //SDL_Delay(delaysist);

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
	if (SDL_init(SCREEN_WIDTH, SCREEN_HEIGHT, argc, args) == 1) {
		
		return 0;
	}
	//SDL_GetWindowSize(window, &width, &height);
	Uint32 next_game_tick = SDL_GetTicks();

    Serial_Init("/dev/ttyUSB0", B19200);//PC
    //delaysist = 10;//delay del juego en ms
    //Serial_Init("/dev/ttyS0", B19200);//Ras


    randomSeed(33);
    initEnvironment(m);
    initGame();
    syncGame();
    //dejo la marca de inicio
    time(&begin_s); 
    //printf("{%d}s\n", i);

	while (quit == 0)
	{
        
        //parte de pintado en SDL
        SDL_RenderClear(renderer);
        SDL_FillRect(screen, NULL, 0x000000ff);

		SDL_PumpEvents();

		const Uint8 *keystate = SDL_GetKeyboardState(NULL);

		if (keystate[SDL_SCANCODE_ESCAPE]) {
		
			quit = 1;
		}
		
        updateAsteroids();

		if (keystate[SDL_SCANCODE_DOWN]&&flagMove) {
			
			move_player(0);
			Serial_Write(&SendPlayer, 2);
			Uart_playerOne.y = playerOne.y/scale_y;
			Serial_Write(&Uart_playerOne, sizeof(Recta));
            //SDL_Delay(15);

		}

		if (keystate[SDL_SCANCODE_UP]&&flagMove) {

			move_player(1);
			Serial_Write(&SendPlayer, 2);
			Uart_playerOne.y = playerOne.y/scale_y;
			Serial_Write(&Uart_playerOne, sizeof(Recta));
            //SDL_Delay(15);
		}

        moveAsteroids(m);

        //pinto asteroides, tiempo y jugadores
		draw_horizontal_line(m);
        
        draw_box(timer);
		//draw_pixel();
		draw_partial_image(playerTwo);
		draw_partial_image(playerOne);
		draw_score(scoreA, scoreB);
        //printf("Score: {%i},{%i}\n", scoreA, scoreB);

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
            //printf("{%i}s\n", i);
            timer.y = timer.y + scale_y;

            if (i == 60)
            {
                //le mando una marca diciendo que el juego acabo
                Serial_Write(&SendTimeOut, 2);

                if (scoreA > scoreB)
                {
                    draw_loseFrame();
                }

                else if (scoreB > scoreA)
                {
                    draw_winFrame();

                }

                else
                {
                    draw_loseFrame();
                }

                quit = 1;
            }

            time(&begin_s);
        }
        //Delay_ms(delaysist);
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
