#include <SDL.h>	//SDL version 2.0
#include "Include/serial.h"
#include "Include/random.h"
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include <unistd.h>
#include <time.h>

#include "Include/keys.h"
#include "Include/drawSDL2.h"
#include "Include/hit.h"


#define TITLE           0
#define MENU            1
#define ONEPLAYER       2
#define MULTIPLAYER     3

//--------------------------------------------------------------------------

int state = 0, modeGame = 0, i, timeFlag = 0, second = 0, lastsecond = 0;

/*
banderas ha utilizar en multiplayer
*/

uint16_t SendAck        = 0x9111;
uint16_t SendInit       = 0x9222;
uint16_t SendUpdateAst  = 0x9333;
uint16_t SendPlayer     = 0x9444;
uint16_t SendTime       = 0x9555;
uint16_t SendPlayerX    = 0x9666;
uint16_t SendScore      = 0x9777;
uint16_t SendTimeOut    = 0x9888;

//int width, height;		//used if fullscreen

Rect m[NUM_ASTEROIDS], timer;//cuidado

uint8_t flag = 0, flagScore = 0, flagTimeOut = 0;

Splite playerOne, playerPC, playerTwo;
Keys key;


Recta Uart_playerOne, Uart_playerTwo;

/*
Intenta replicar el delay en pic
*/
void Delay_ms(uint32_t s) {
	SDL_Delay(s);
}

void init_game()
{
    //variables necesarias para el control del juego
    scoreA = 0;
    scoreB = 0;
    timeFlag = 0;
    modeGame = 0;
    //playerOne
    playerOne.rect.x = 320;
    playerOne.rect.y = 550;
    playerOne.rect.w = 90;
    playerOne.rect.h = 90;
    playerOne.vel.dx = 0;
    playerOne.vel.dy = 1;
    //playerPC
    playerPC.rect.x = 940;
    playerPC.rect.y = 550;
    playerPC.rect.w = 90;
    playerPC.rect.h = 90;
    playerPC.vel.dx = 0;
    playerPC.vel.dy = 1;
    //playerTwo
    playerTwo = playerPC;
    //timer
    timer.x = 620;
    timer.y = 30;
    timer.w = 10;
    timer.h = 600;    
    //seteo las pocisiones de los asteroides
    initEnvironment(m);

    //para enviar por uart
    Uart_playerOne.x = 94;
    Uart_playerOne.y = 55;
    Uart_playerOne.w = 9;
    Uart_playerOne.h = 9;

    Uart_playerTwo.x = 32;
    Uart_playerTwo.y = 55;
    Uart_playerTwo.w = 9;
    Uart_playerTwo.h = 9;

}

void updateGameTime(Rect *t)
{
    		
		if (second != lastsecond)
		{
			lastsecond = second;
			timeFlag = 1;
		}
		else
		{
			second = SDL_GetTicks()/1000;
			timeFlag = 0;
		}

    if (t->y >= 630)
    {
        if (scoreA > scoreB)
        {
            draw_winFrame();
            init_game();
            state = MENU;
        }

        else
        {
            draw_loseFrame();
            init_game();
            state = MENU;
        }

        //empate
        
    }
    
    //llama a la interrupcion cada un segundo
    if (timeFlag)
    {
        t->y = t->y  + scale_y;
        timeFlag = 0;
    }

}


/*
Sincroniza el inicio del juego, ya que necesitamos que los cohetes empiecen 
a moverse según el tiempo del PIC que es el más lerdo
*/
void syncGame()
{
    int i, n;
    uint16_t mark;
    while (1)
    {
        Serial_Write(&SendInit, 2);

        n = Serial_Available();

        if (n > 2)
        {
            Serial_Read(&mark, 2);

            if (mark == SendAck)
            {
                break;
            }

            Serial_clear();
        }
        
        Delay_ms(200);
               
    }
    
}

/*
Pinto, borro y MUEVO los asteroides, además, cada que termina de hacer esto
mando una marca por UART->SendUpdateAst
Por si fuera poco, aqui tambien verifico colision de los cohetes con jugadores
*/
void moveAndCheckAsteroids(Rect *s)
{
    uint8_t i;
    for (i = 0; i < NUM_ASTEROIDS; i++)
    {
        if (check_collision(s[i], playerOne.rect))
        {
            playerOne.rect.y = 550;
            Uart_playerOne.y = playerOne.rect.y/scale_y;
            Serial_Write(&SendPlayer, 2);
            Serial_Write(&Uart_playerOne, sizeof(Rect));
        }
        
        //draw_horizontal_line(s[i], ERASE);

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

        //draw_horizontal_line(s[i], DRAW);
    }
    //aqui debo de enviar marca de tiempo, siempre, ya que sincroniza la jugada
    Serial_Write(&SendUpdateAst, 2);
}


/*
lee de UART la marca:
-> SendTime, que permite activar un flag para actualizar el tiempo
-> SendPlayer, actualiza la posicion del player dos
*/
void updateData() {
    int n;
    uint16_t mark;

    while (1)
    {
    
        n = Serial_Available();
        if (n >= (2)) {
            Serial_Read(&mark, 2);

            if (mark == SendTime) {
                flag = 1;
                continue;
            }

            if (mark == SendPlayer)
            {
                Serial_Read(&playerTwo.rect, sizeof(Rect));
                continue;
            }

            if (mark == SendPlayerX)
            {
                Serial_Read(&playerTwo.rect, sizeof(Rect));
                continue;
            }
            
            if (mark == SendScore)
            {
                flagScore = 1;
                continue;
            }

            if (mark == SendTimeOut)
            {
                flagTimeOut = 1;
                continue;
            }

            Serial_clear();
        }

        return;
    }
}

void one_player()
{
	init_game();
  //TMR0IE_bit    = 1; //lo vuelvo a habilitar ya que si salto de dos jugadores a uno, esta apagado
  while (quit == 0)
  {
      //aqui verifico si el tiempo se acabo, reinicia todo y lanza un frame
      draw_clear();
      updateGameTime(&timer);
      if (state == MENU)
      {
      		draw_clear();
          break;
      }
      //en move_player actualizo score ya que muevo el player ahi tambien
      playerOne = move_player(playerOne, m);
      environment(m);
      playerPC = move_ai(playerPC, m);

      //draw_dot(playerPC, DRAW);
      draw_box(timer,DRAW);
      draw_partial_image(playerPC.rect);
      draw_partial_image(playerOne.rect);
      draw_asteroids(m);
  		draw_score(scoreA, scoreB);
      SDL_Delay(140);
      refresh_sdl();
  }
}

void multiplayer()
{
	draw_clear();
  refresh_sdl();
	randomSeed(33);
	init_game();
	syncGame();
	draw_score(scoreA, scoreB);

	while(quit==0)
	{
		draw_clear();
		moveAndCheckAsteroids(m);
		updateData();

		if (flag)
		{
			timer.y++;
			flag = 0;
		}

		if (flagScore)
		{
		  flagScore = 0;
		  scoreB++;
		  draw_score(scoreA, scoreB);
		}

		key = readKeys();

		if (key.up)
		{
			//puede crearse la funcion move_player
			playerOne.rect.y = playerOne.rect.y - scale_y;
			if (playerOne.rect.y <= 0){
				playerOne.rect.y = 550;
				scoreA++;
				Serial_Write(&SendScore, 2);
				draw_score(scoreA, scoreB);
			}
			Serial_Write(&SendPlayer, 2);
			Uart_playerOne.y = playerOne.rect.y/scale_y;
			Serial_Write(&Uart_playerOne, sizeof(Rect));
		}

		if (key.down)
		{
			playerOne.rect.y = playerOne.rect.y + scale_y;
			if(playerOne.rect.y + (playerOne.rect.h - 10) >= 630){
				playerOne.rect.y = 550;
			}
			Serial_Write(&SendPlayer, 2);
			Serial_Write(&playerOne.rect, sizeof(Rect));
		}

		if (flagTimeOut)
		{
			flagTimeOut = 0;
			if (scoreA > scoreB)
			{
			    draw_winFrame();
			}

			else if (scoreB > scoreA)
			{
			    draw_loseFrame();
			}

			else
			{
			    draw_loseFrame();
			}  

			init_game();
			state = MENU;   
		}
		if (state == MENU)
		{
			draw_clear();
			break;
		}

		//pinto y borro, el tiempo y jugadores
		draw_box(timer, DRAW);
		draw_partial_image(playerOne.rect);
		draw_partial_image(playerTwo.rect);
		draw_asteroids(m);
  	//draw_score(scoreA, scoreB);
		Delay_ms(60);
    refresh_sdl();

	}
}

int main (int argc, char *args[]) {

	int sleep = 0;

	//SDL Window setup
	if (SDL_init(SCREEN_WIDTH, SCREEN_HEIGHT, argc, args) == 1) {
		
		return 0;
	}
	
	//SDL_GetWindowSize(window, &width, &height);
	Uint32 next_game_tick = SDL_GetTicks();
	
	Serial_Init("/dev/ttyUSB0", B19200);
  randomSeed(33);
  initEnvironment(m);
	init_game();

	//render loop
	while(quit == 0) {
	
		//check for new events every frame
		SDL_PumpEvents();

		const Uint8 *keystate = SDL_GetKeyboardState(NULL);
		
		if (keystate[SDL_SCANCODE_ESCAPE]){quit = 1;}

		//draw background
		SDL_RenderClear(renderer);
		SDL_FillRect(screen, NULL, 0x000000ff);
		
		//display main menu
		switch (state)
		{
		case TITLE:
		    draw_InitFrame();
		    state = MENU;
		    break;

		case MENU:
		    state = draw_MenuGame(modeGame);
		    break;

		case ONEPLAYER: 
		    //printf("ONEPLAYER\n");
				one_player();
		    break;

		case MULTIPLAYER: 
		    multiplayer();
		    break;
		default:
		    break;
		}
/*
		if (state == 3){		
			if (keystate[SDL_SCANCODE_SPACE]) {
				state = 0;
				//delay for a little bit so the space bar press dosnt get triggered twice
				//while the main menu is showing
            	SDL_Delay(500);
			}
				
		//display the game
		}
		if (state == 2){
			
			//draw paddles

			draw_partial_image(playerOne.rect);
			draw_partial_image(playerPC.rect);
			draw_box(timer,1);
			draw_score(0,0);
			for (int i = 0; i <= NUM_ASTEROIDS - 1; i++){
          draw_horizontal_line(m[i],1);
      }
		//State_Machine(ONEPLAYER);
			//printf("paddle[0].y = %i \npaddle[1].y = %i \n",paddle[0].y/2,paddle[1].y/2 );
		}
	*/
		refresh_sdl();

		//time it takes to render  frame in milliseconds
		next_game_tick += 1000 / 60;
		sleep = next_game_tick - SDL_GetTicks();
		if( sleep >= 0 ) {
            				
			SDL_Delay(sleep);
		}
	}

	//free loaded images
	SDL_FreeSurface(screen);
	SDL_FreeSurface(pantallaDeInicio);
	SDL_FreeSurface(seleccionDeJuego);
	SDL_FreeSurface(sprites);
	SDL_FreeSurface(winScreen);
	SDL_FreeSurface(loseScreen);

	//free renderer and all textures used with it
	SDL_DestroyRenderer(renderer);
	
	//Destroy window 
	SDL_DestroyWindow(window);

	//Quit SDL subsystems 
	SDL_Quit(); 
	 
	return 0;
	
}

