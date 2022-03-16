#include <stdint.h>
#include "\Include\drawGlcd.h"
#include "\Include\hit.h"



#define TITLE           0
#define MENU            1
#define ONEPLAYER       2

uint8_t timeFlag    = 0;
uint8_t contador_ms = 0;
uint8_t state, modeGame, i;
Rect m[NUM_ASTEROIDS], timer;//cuidado
Splite playerOne, playerPC;


void InitTimer0(){
  T0CON         = 0x83;
  TMR0H         = 0x0B;
  TMR0L         = 0xDC;
  GIE_bit       = 1;
  TMR0IE_bit    = 1;
}
 
void Interrupt(){
  if (TMR0IF_bit){ 
    TMR0IF_bit = 0;
    TMR0H         = 0x0B;
    TMR0L         = 0xDC;
    //Enter your code here
    contador_ms++;  
    if (contador_ms >= 2)
    {
      timeFlag = 1;
      contador_ms = 0;
    }
  }
} 

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
            draw_clear();
            draw_score(scoreA, scoreB);
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


        default:
            break;
        }
    }
    

    
}