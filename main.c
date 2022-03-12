#include <stdint.h>
#include "\Include\drawGlcd.h"


#define TITLE   0
#define MENU    1




void main() {
    uint8_t state = 0;
    uint8_t modeGame = 0;

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
        
        default:
            break;
        }
    }
    

    
}