#include <SDL.h>	//SDL version 2.0
#include "Include/serial.h"
#include "Include/random.h"
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include <unistd.h>
#include <time.h>
#include <sys/utsname.h>

#include "Include/drawSDL2.h"
#include "Include/keys.h"
#include "Include/hit.h"


#define TITLE           0
#define MENU            1
#define ONEPLAYER       2
#define MULTIPLAYER     3

//--------------------------------------------------------------------------

/*
Intenta replicar el delay en pic
*/
void Delay_ms(uint32_t s) 
{

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

void init_game_slave()
{
    //variables necesarias para el control del juego
    scoreA = 0;
    scoreB = 0;
    timeFlag = 0;
    modeGame = 0;
    //playerOne
    playerOne.rect.x = 940;
    playerOne.rect.y = 550;
    playerOne.rect.w = 90;
    playerOne.rect.h = 90;
    playerOne.vel.dx = 0;
    playerOne.vel.dy = 1;
    //playerPC
    playerTwo.rect.x = 320;
    playerTwo.rect.y = 550;
    playerTwo.rect.w = 90;
    playerTwo.rect.h = 90;
    playerTwo.vel.dx = 0;
    playerTwo.vel.dy = 1;
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
                playerTwo.rect.y = Uart_playerTwo.y*scale_y;
                continue;
            }

            if (mark == SendPlayerX)
            {
                //printf("Recv NEW player from PIC\n");
                Serial_Read(&Uart_playerOne, sizeof(Recta));
                playerOne.rect.y = Uart_playerOne.y*scale_y;
                continue;
            }

            if (mark == SendScore)
            {
                scoreA++;
                continue;
            }
            //printf("playerTwo_slave.y: %i\nplayerTwo_slave.x: %i\n",playerTwo_slave.y, playerTwo_slave.x);

            Serial_clear();
        }
        return;
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
aqui vamos a sincronizar el inicio
*/
void syncGame_slave()
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
            //printf("mark: {%d}\n", mark);
            
            if (mark == SendInit)
            {

                //printf("Sincronizados\n");
                Serial_Write(&SendAck, 2);
                //printf("Enviando ACK {%d}\n", SendAck);

                break;
            }

            Serial_clear();

        }
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
            Serial_Write(&Uart_playerOne, sizeof(Recta));
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
                Serial_Read(&Uart_playerTwo, sizeof(Recta));
                playerTwo.rect.y = Uart_playerTwo.y*scale_y;
                continue;
            }

            if (mark == SendPlayerX)
            {
                Serial_Read(&Uart_playerOne, sizeof(Recta));
                playerOne.rect.y = Uart_playerOne.y*scale_y;
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
        //printf("playerTwo.y: %i\n", playerTwo.rect.y );
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

void multiplayer_master()
{
	draw_clear();
	refresh_sdl();

	randomSeed(33);
	init_game();
	syncGame();

	while(quit==0)
	{
		draw_clear();

		moveAndCheckAsteroids(m);
		updateData();

		if (flag)
		{
      		timer.y = timer.y + scale_y;
			flag = 0;
		}

		if (flagScore)
		{
		  flagScore = 0;
		  scoreB++;
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
			}
			Serial_Write(&SendPlayer, 2);
			Uart_playerOne.y = playerOne.rect.y/scale_y;
			Serial_Write(&Uart_playerOne, sizeof(Recta));
		}

		if (key.down)
		{
			playerOne.rect.y = playerOne.rect.y + scale_y;
			if(playerOne.rect.y + (playerOne.rect.h - 10) >= 630){
				playerOne.rect.y = 550;
			}
			Serial_Write(&SendPlayer, 2);
			Uart_playerOne.y = playerOne.rect.y/scale_y;
			Serial_Write(&Uart_playerOne, sizeof(Recta));
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
  		draw_score(scoreA, scoreB);
		Delay_ms(140);
    	refresh_sdl();
	}
}

void multiplayer_slave()
{

    time_t begin_s, end_s;
    double elapsed;

	draw_clear();
	refresh_sdl();

	randomSeed(33);
	syncGame_slave();
	time(&begin_s);
	init_game_slave();

	while(quit == 0)
	{
		draw_clear();

		updateAsteroids();

		key = readKeys();

		if (key.down && flagMove)
		{
			move_player_multi(0);
			Serial_Write(&SendPlayer, 2);
			Uart_playerOne.y = playerOne.rect.y/scale_y;
			Serial_Write(&Uart_playerOne, sizeof(Recta));
            //SDL_Delay(15);
		}

		if (key.up && flagMove)
		{
			move_player_multi(1);
			Serial_Write(&SendPlayer, 2);
			Uart_playerOne.y = playerOne.rect.y/scale_y;
			Serial_Write(&Uart_playerOne, sizeof(Recta));
            //SDL_Delay(15);
		}

        moveAsteroids(m);
        draw_asteroids(m);
        draw_box(timer,DRAW);
		draw_partial_image(playerTwo.rect);
		draw_partial_image(playerOne.rect);
  		draw_score(scoreA, scoreB);
  		refresh_sdl();

  		time(&end_s);
        elapsed = difftime(end_s, begin_s);
        if (elapsed >= 1.0)
        {
            Serial_Write(&SendTime, 2);
            i++;

            timer.y = timer.y + scale_y;
            //printf("{%i} \n", i );
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

				init_game();
				state = MENU;
				i=0;
				if (state == MENU)
				{
					draw_clear();
					break;
				}   
            }

            time(&begin_s);
        }
	}	

}

void detect_os()
{

	struct utsname uts;
	uname(&uts);

	if (!strcmp(uts.machine, "x86_64"))
	{
	    //printf("Linux\n");
		Serial_Init("/dev/ttyUSB0", B19200);
	}
	else if (!strcmp(uts.machine, "armv7l"))
	{
	    //printf("Rasp\n");
		Serial_Init("/dev/ttyS0", B19200);
	}
	else
	{
		printf("Unrecognizable OS.\n");
	}
}

int main (int argc, char **args) {

	if ((args[1] == NULL)||(argc<2))
	{ 
		printf("%s Error, hierarchy not specified.\n Specify with slave=S or slave=Y",args[0]);
		return 1;
	}
	else
	{
		if (!strcmp(args[1], "Y")||!strcmp(args[1], "S")||!strcmp(args[1], "y"))
		{
			printf("Settings as slave.\n");
			slave = 1;
		}
		else
		{
			printf("Settings as master.\n");
			slave = 0;
		}
	}

	int sleep = 0;

	//SDL Window setup
	if (SDL_init(SCREEN_WIDTH, SCREEN_HEIGHT, argc, args) == 1) {
		
		return 0;
	}
	
	//SDL_GetWindowSize(window, &width, &height);
	Uint32 next_game_tick = SDL_GetTicks();
	
	detect_os();

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
			if (slave)
			{
				//printf("MULTIPLAYER as slave\n");
				multiplayer_slave();
			}
			else
			{
				//printf("MULTIPLAYER as master\n");
			    multiplayer_master();
			}
		    break;
		default:
		    break;
		}

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

