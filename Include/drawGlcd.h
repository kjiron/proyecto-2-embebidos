#ifndef __DRAWGLCD__
#define __DRAWGLCD__

#include "configPins.h"
#include "frames.h"

void draw_InitFrame(){
  Glcd_Image(pantallaDeInicio);
  Delay_ms(4000);
  Glcd_Fill(0x00);

}


#endif