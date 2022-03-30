
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

#include "Include/keys.h"
#include "Include/drawSDL2.h"
#include "Include/hit.h"


#define TITLE           0
#define MENU            1
#define ONEPLAYER       2
#define MULTIPLAYER     3

//--------------------------------------------------------------------------

// Program globals

int whoAmI;
int num = 0;
int state = 0, modeGame = 0, i, timeFlag = 0, second = 0, lastsecond = 0;


uint16_t mark;
uint16_t SendPlayer = 0x9669;
uint16_t IamPlayer1 = 0x9666;
uint16_t IamPlayer2 = 0x9667;
int width, height;		//used if fullscreen

Rect m[NUM_ASTEROIDS], timer;//cuidado


Splite playerOne, playerPC, playerTwo;
Splite lastPosPlayer;
Splite newPlayer;
Keys key;

void init_game()
{
    //variables necesarias para el control del juego
    scoreA = 0;
    scoreB = 0;
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

        else if (scoreB > scoreA)
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
      draw_box(timer,1);
      draw_partial_image(playerPC.rect);
      draw_partial_image(playerOne.rect);
      for (i = 0; i <= NUM_ASTEROIDS - 1; i++){
          draw_horizontal_line(m[i],1);
      }
  		draw_score(scoreA, scoreB);
      SDL_Delay(150);
      refresh_sdl();
  }
}

int main (int argc, char *args[]) {
	
	//SDL Window setup
	if (SDL_init(SCREEN_WIDTH, SCREEN_HEIGHT, argc, args) == 1) {
		
		return 0;
	}
	
	SDL_GetWindowSize(window, &width, &height);
	
	int sleep = 0;
	Uint32 next_game_tick = SDL_GetTicks();
	
	// Initialize the ball position data. 
	init_game();

  Rect select_n = {250, 300, 30, 0};
	
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
		    printf("MULTIPLAYER\n");
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

