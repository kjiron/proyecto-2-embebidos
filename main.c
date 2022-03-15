#include <stdint.h>
//#include <stdbool.h>
#include "\Include\drawGlcd.h"
#include "\Include\hit.h"



#define TITLE           0
#define MENU            1
#define ONEPLAYER       2

uint8_t timeFlag = 0;
uint8_t contador_ms = 0;

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




void main() {
    Rect m[NUM_ASTEROIDS], timer;//cuidado
    uint8_t state = 2;
    uint8_t modeGame = 0;
    uint8_t i;
    Splite playerOne;
    //Rect eraser;

    //Keys key;

    playerOne.rect.x = 32;
    playerOne.rect.y = 55;
    playerOne.rect.w = 9;
    playerOne.rect.h = 9;
    playerOne.vel.dx = 0;
    playerOne.vel.dy = 1;

    //eraser = playerOne.rect;
    
    //timer
    timer.x = 62;
    timer.y = 3;
    timer.w = 1;
    timer.h = 60;
    
    //seteo las pocisiones
    initEnvironment(m);
    

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
            draw_partial_image(playerOne.rect, ship);
            //draw_dot(playerOne, DRAW);
            draw_box(timer, DRAW);

            while (1)
            {
                if (timer.y >= 63)
                {
                    timer.y = 3;
                }
                //llama a la interrupcion cada un segundo
                if (timeFlag)
                {
                    timer.y++;
                    timeFlag = 0;
                }

                playerOne = move_player(playerOne, m);
                //ToDo: aqui deberia de verificar si el jugador ha cambiado de posicion respecto a su info anterior
                environment(m);
                draw_box(timer, DRAW);
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
            }
            
            break;


        default:
            break;
        }
    }
    

    
}