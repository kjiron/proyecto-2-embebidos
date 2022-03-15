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
    //Rect eraser;

    //Keys key;

    playerOne.rect.x = 32;
    playerOne.rect.y = 55;
    playerOne.rect.w = 9;
    playerOne.rect.h = 9;
    playerOne.vel.dx = 0;
    playerOne.vel.dy = 1;

    //eraser = playerOne.rect;

    
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
            draw_ship(playerOne.rect, ship);

            while (1)
            {
                //draw_ship(eraser, parche);
                
                playerOne = move_player(playerOne);
                //eraser = playerOne.rect;
                
                
                //mueve y pinto los Rect (asteroides)
                environment(m);
                
                draw_ship(playerOne.rect, ship);
                Delay_ms(60);
                
                
            }
            
            break;


        default:
            break;
        }
    }
    

    
}