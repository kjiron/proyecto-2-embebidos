#include "\Include\serial.h"
#include <stdint.h>
#include "\Include\drawGlcd.h"
#include "\Include\hit.h"
#include "\Include\keys.h"


#define TITLE           0
#define MENU            1
#define ONEPLAYER       2
#define MULTIPLAYER     3


uint8_t state, modeGame, i;
Rect m[NUM_ASTEROIDS], timer;//cuidado
uint16_t mark;
uint8_t num = 0;
Splite playerOne, playerPC, playerTwo;
Keys key;
uint16_t SendPlayer = 0x9669;




void init_game()
{
    //variables necesarias para el control del juego
    scoreA = 0;
    scoreB = 0;
    timeFlag = 0;
    contador_ms = 0;
    modeGame = 0;
    //playerOne
    playerOne.rect.x = 32;
    playerOne.rect.y = 55;
    playerOne.rect.w = 9;
    playerOne.rect.h = 9;
    playerOne.vel.dx = 0;
    playerOne.vel.dy = 1;
    //playerPC
    playerPC.rect.x = 94;
    playerPC.rect.y = 55;
    playerPC.rect.w = 9;
    playerPC.rect.h = 9;
    playerPC.vel.dx = 0;
    playerPC.vel.dy = 1;
    //playerTwo
    playerTwo = playerPC;
    //timer
    timer.x = 62;
    timer.y = 3;
    timer.w = 1;
    timer.h = 60;    
    //seteo las pocisiones de los asteroides
    initEnvironment(m);
}



void updateGameTime(Rect *t)
{
    
    if (t->y >= 63)
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
        t->y++;
        timeFlag = 0;
    }

}




void main() {
    
    state = 0;

    init_game();
    ADCON1 = 0x0F; 
    Glcd_Init();
    Serial_Init();
    InitTimer0();

    while (1)
    {
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
            init_game();
            draw_clear();
            draw_score(scoreA, scoreB);
            TMR0IE_bit    = 1; //lo vuelvo a habilitar ya que si salto de dos jugadores a uno, esta apagado
            while (1)
            {
                //aqui verifico si el tiempo se acabo, reinicia todo y lanza un frame
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
                draw_box(timer, DRAW);
                draw_partial_image(playerPC.rect, ship);
                draw_partial_image(playerOne.rect, ship);
                for (i = 0; i <= NUM_ASTEROIDS - 1; i++){
                    draw_horizontal_line(m[i], DRAW);
                }
                Delay_ms(60);
                for (i = 0; i <= NUM_ASTEROIDS - 1; i++){
                    draw_horizontal_line(m[i], ERASE);
                }
                draw_box(timer, ERASE);
                draw_partial_image(playerOne.rect, parche);
                draw_partial_image(playerPC.rect, parche);
                //draw_dot(playerPC, ERASE);

                
                
            }
            
            break;

        case MULTIPLAYER:
            init_game();
            draw_clear();
            TMR0IE_bit    = 0;     //deshabilito la interrupcion por timer0, ya que me hace freezeado el micro
            while (1)
            {


                //aqui verifico si el tiempo se acabo, reinicia todo y lanza un frame
                //ahora en este modo tengo que recivir el flag por uart
                //updateGameTime(&timer);
                if (state == MENU)
                {
                    draw_clear();
                    break;
                }



                key = readKeys();
                if (key.up)
                {
                    playerOne.rect.y--;
                }
                else if (key.down)
                {
                    playerOne.rect.y++;
                } 
            
                
                Serial_Write(&SendPlayer , 2);
                Serial_Write(&playerOne, sizeof(Splite));


                while(1)
                {
                    num = Serial_available();
                    //draw_score(playerOne.y, num);
                    if (num >= (2 + sizeof(Splite)))
                    {
                        Serial_Read(&mark, 2);
                        //draw_score(playerTwo.y, markUART);

                        if (mark == SendPlayer)
                        {
                            Serial_Read(&playerTwo, sizeof(Splite));
                            continue;
                        }
                        Serial_clear();
                    }
                    break;  
                }

                if (playerOne.rect.y == 0)
                {
                    init_game();
                    state = MENU;
                }
                
                draw_partial_image(playerTwo.rect, ship);
                draw_partial_image(playerOne.rect, ship);
                Delay_ms(45);
                draw_partial_image(playerOne.rect, parche);
                draw_partial_image(playerTwo.rect, parche);

            }
            
            break;

        default:
            break;
        }
    }
    

    
}