#include "Include\serial.h"
#include "Include\random.h"

#include <stdint.h>
#include "Include\drawGlcd.h"
#include "Include\hit.h"
#include "Include\keys.h"


#define TITLE           0
#define MENU            1
#define ONEPLAYER       2
#define MULTIPLAYER     3

uint8_t state, modeGame, i;

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


Rect m[NUM_ASTEROIDS], timer;//cuidado
uint8_t flag = 0, flagScore = 0, flagTimeOut = 0;

Splite playerOne, playerPC, playerTwo;
Keys key;



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

        n = Serial_available();

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
            playerOne.rect.y = 55;
            Serial_Write(&SendPlayer, 2);
            Serial_Write(&playerOne.rect, sizeof(Rect));
        }
        
        draw_horizontal_line(s[i], ERASE);

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
        draw_horizontal_line(s[i], DRAW);
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
    
        n = Serial_available();
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


void main() {
    
    state = 0;

    ADCON1 = 0x0F; 
    Serial_Init();
    Serial_clear();
    randomSeed(33);
    init_game();
    Glcd_Init();
    Glcd_Fill(0x00);
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
                Delay_ms(60);
                draw_box(timer, ERASE);
                draw_partial_image(playerOne.rect, parche);
                draw_partial_image(playerPC.rect, parche);
                //draw_dot(playerPC, ERASE);

                
                
            }
            
            break;

        case MULTIPLAYER:
            randomSeed(33);
            init_game();
            TMR0IE_bit    = 0;     //deshabilito la interrupcion por timer0, ya que me hace freezeado el micro
            syncGame();    
            draw_score(scoreA, scoreB);
            while (1)
            {
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
                    playerOne.rect.y--;
                    if (playerOne.rect.y <= 0){
                        playerOne.rect.x = 32;
                        playerOne.rect.y = 55;
                        scoreA++;
                        Serial_Write(&SendScore, 2);
                        draw_score(scoreA, scoreB);
                    }
                    Serial_Write(&SendPlayer, 2);
                    Serial_Write(&playerOne.rect, sizeof(Rect));
                }
                
                if (key.down)
                {
                    playerOne.rect.y++;
                    if (playerOne.rect.y + (playerOne.rect.h - 1) >= 63){
                        playerOne.rect.y = 55;
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
                draw_partial_image(playerOne.rect, ship);
                draw_partial_image(playerTwo.rect, ship);
                Delay_ms(60);
                draw_box(timer, ERASE);
                draw_partial_image(playerOne.rect, parche);
                draw_partial_image(playerTwo.rect, parche);
                
            }
            
            break;

        default:
            break;
        }
    }
    

    
}