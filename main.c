#include "\Include\configPins.h"
#include "\Include\drawGlcd.h"




void main() {
    Glcd_Init();

    while (1)
    {
        Glcd_Fill(0x00);
        draw_InitFrame();
    }
    

    
}