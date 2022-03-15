#ifndef __DRAWGLCD__
#define __DRAWGLCD__

#include "configPins.h"
#include "frames.h"
#include "keys.h"

typedef struct
{
  int8_t x, y;
  int8_t w, h;
} Rect;


typedef struct
{
  int8_t dx, dy;
} Vec2;

typedef struct
{
  Rect rect;
  Vec2 vel;
} Splite;





void draw_clear()
{
  Glcd_Fill(0x00);
}


void draw_InitFrame(){
  Glcd_Image(titleFrame);
  Delay_ms(4000);
  draw_clear();
}

void draw_MenuFrame(){
  Glcd_Image(menuFrame);
}


void draw_circle(Rect circle, uint8_t color)
{ 
  //if (circle.x < 0 || circle.x > 128 || )
  Glcd_Circle(circle.x, circle.y, circle.w, color);
}

void draw_dot(Splite player, uint8_t color)
{
  Glcd_Dot(player.rect.x, player.rect.y, color);
}

void draw_horizontal_line(Rect asteroid, uint8_t color)
{
  Glcd_H_Line(asteroid.x, asteroid.x + asteroid.w, asteroid.y,  color);
}



int draw_MenuGame(uint8_t modeGame)
{
  Keys key;
  Rect select = {25, 34, 3, 0};
  draw_MenuFrame();
  draw_circle(select, 1);

  while (1)
  {
    key = readKeys();

    if ((key.enter) && (modeGame == 0))
    {
      draw_clear();
      return 2;
    }
    if ((key.up || key.down)  && (modeGame == 0))
    {
      draw_circle(select, 0);
      select.y = select.y + 14;  //offset
      draw_circle(select, 1);
      modeGame = 1;
      Delay_ms(666);
      continue;
    }
    if ((key.enter) && (modeGame == 1))
    {
      draw_clear();
      return 3;
    }
    if ((key.up || key.down ) && (modeGame == 1)) 
    {
      draw_circle(select, 0);     
      select.y = select.y - 14;  //offset
      draw_circle(select, 1);     
      modeGame = 0;
      Delay_ms(666);
    }
  }
}


void draw_ship(Rect player, code const unsigned short * image)
{
  //forma sencilla
  //void Glcd_PartialImage(unsigned int x_left, unsigned int y_top, unsigned int width, unsigned int height, unsigned int picture_width, unsigned int picture_height, code const unsigned short * image);
  Glcd_PartialImage(player.x, player.y, player.w, player.h, player.w, player.h, image);
  
  

  
  
}


#endif