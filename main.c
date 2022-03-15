#include <stdint.h>
#include "\Include\drawGlcd.h"
#include "\Include\hit.h"



#define TITLE           0
#define MENU            1
#define ONEPLAYER       2






void main() {
    Rect m[NUM_ASTEROIDS];//cuidado
    uint8_t state = 2;
    uint8_t modeGame = 0;
    Splite playerOne;
    Keys key;

    playerOne.rect.x = 64;
    playerOne.rect.y = 32;
    playerOne.rect.w = 1;
    playerOne.rect.h = 1;
    playerOne.vel.dx = 0;
    playerOne.vel.dy = 1;



    
    //seteo las pocisiones
    initEnvironment(m);
    

    ADCON1 = 0x0F; 
    Glcd_Init();


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
            draw_dot(playerOne, 1);
            while (1)
            {
                draw_dot(playerOne, 0);

                playerOne = move_player(playerOne);

                //mueve y pinto los Rect (asteroides)
                environment(m);
                
                draw_dot(playerOne, 1);
                Delay_ms(60);
                
                
            }
            
            break;


        default:
            break;
        }
    }
    

    
}