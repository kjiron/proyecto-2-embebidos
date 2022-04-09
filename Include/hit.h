#ifndef __HIT__
#define __HIT__


#include "drawGlcd.h"
#include "random.h"
#include "keys.h"

#define ERASE           0
#define DRAW            1
#define NUM_ASTEROIDS   13

uint8_t x = 0;
uint8_t scoreA = 0, scoreB = 0;



static inline bool check_collision00(Rect rect1, Rect rect2)
{
    return rect1.x < rect2.x + rect2.w &&
       rect1.x + rect1.w > rect2.x &&
       rect1.y < rect2.y + rect2.h &&
       rect1.h + rect1.y > rect2.y;
}


bool check_collision(Rect asteroid, Rect player)
{
   return check_collision00(asteroid, player);
}



Splite move_player(Splite player, Rect *a)
{
   Keys key;
   uint8_t i;
   key = readKeys();

   for (i = 0; i <= NUM_ASTEROIDS - 1; i++){
      if (check_collision(a[i], player.rect))
      {
         player.rect.x = 32;
         player.rect.y = 55;
         return player;
      }
      
   }

   
   

   if (key.down){
      player.rect.y += player.vel.dy;
      
      if (player.rect.y + (player.rect.h - 1) >= 63){
         player.rect.y = 55;
      }
   }

   else if (key.up){
      player.rect.y -= player.vel.dy;
      if (player.rect.y <= 0){
         player.rect.x = 32;
         player.rect.y = 55;
         scoreA++;
         draw_score(scoreA, scoreB);

         return player;
      }
   }
   else{
      return player;
   }


   return player;

}

Splite move_ai(Splite pc, Rect *a)
{
   uint8_t i, luck;
   luck = randint(0, 200);
   for (i = 0; i < NUM_ASTEROIDS; i++)
   {

      if (check_collision(a[i], pc.rect))
      {
         pc.rect.x = 94;
         pc.rect.y = 55;
         return pc;
      }
   }


   if (luck > 185)
   {
      pc.rect.y += pc.vel.dy;
      return pc;
   }

   else if (luck < 15)
   {
      pc.rect.y -= pc.vel.dy;
      return pc;
   }
   
   


   pc.rect.y -= pc.vel.dy;

   if (pc.rect.y <= 0)
   {
      pc.rect.x = 94;
      pc.rect.y = 55;
      scoreB++;
      draw_score(scoreA, scoreB);  
      return pc;
   }

   else if (pc.rect.y + (pc.rect.h - 1) >= 63){
      pc.rect.y = 55;
      return pc;
   }

   else
   {
      return pc;
   }   
}



void initEnvironment(Rect *s)
{
    uint8_t i, offset_x, offset_y;
    offset_y = 53;
    for (i = 0; i < NUM_ASTEROIDS; i++)
    {      
        offset_x = randint(0, 123);  
        s[i].x = offset_x;
        s[i].y = offset_y;
        s[i].w = 3;
        s[i].h = 1;

        
        offset_y = offset_y - 4;
    }
}


void environment(Rect *s)
{
    uint8_t i;
    for (i = 0; i < NUM_ASTEROIDS; i++)
    {
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
    
}

#endif