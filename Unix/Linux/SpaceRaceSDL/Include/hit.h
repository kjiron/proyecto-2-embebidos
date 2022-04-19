#ifndef __HIT__
#define __HIT__

#include "drawSDL2.h"
#include "random.h"
#include "keys.h"


int x = 0;
uint8_t scoreA = 0, scoreB = 0;

bool check_collision(Rect rect1, Rect rect2)
{
    return rect1.x < rect2.x + rect2.w &&
       rect1.x + rect1.w > rect2.x &&
       rect1.y < rect2.y + rect2.h &&
       rect1.h + rect1.y > rect2.y;
}

Splite move_player(Splite player, Rect *a)
{
   Keys key;
   int i;
   key = readKeys();

   for (i = 0; i <= NUM_ASTEROIDS - 1; i++){
      if (check_collision(a[i], player.rect))
      {
         //player.rect.x = 320;
         player.rect.y = 550;
         return player;
      }
   }

   if (key.down){
      player.rect.y += player.vel.dy*scale_y;
      
      if (player.rect.y + (player.rect.h - 10) >= 630){
         player.rect.y = 550;
      }
   }
   else if (key.up){
      player.rect.y -= player.vel.dy*scale_y;
      if (player.rect.y <= 0){
         //player.rect.x = 320;
         player.rect.y = 550;
         scoreA++;
         //draw_score(scoreA, scoreB);

         return player;
      }
   }
   else{
      return player;
   }

   return player;

}

/*
muevo los jugadores, se podria mejorar con una estrucuta de keys
*/
void move_player_multi(int d) 
{
   if (d == 1)
    {
        playerOne.rect.y = playerOne.rect.y - scale_y;
        
        if (playerOne.rect.y <= 0)
        {
            scoreB++;
            Serial_Write(&SendScore, 2);
            playerOne.rect.y = 550;
         //printf("playerOne.rect.y %i\n", playerOne.rect.y );
        }

        //SDL_Delay(delaysist);

    }

    else
    {
        playerOne.rect.y = playerOne.rect.y + scale_y;

        if ((playerOne.rect.y + (playerOne.rect.h - 10)) >= 630) 
        {
            playerOne.rect.y = 550;
        }
        //SDL_Delay(delaysist);
    }
}

Splite move_ai(Splite pc, Rect *a)
{
   int i, luck;
   luck = randint(0, 200);
   for (i = 0; i <= NUM_ASTEROIDS - 1; i++)
   {
      if (check_collision(a[i], pc.rect))
      {
         //pc.rect.x = 940;
         pc.rect.y = 550;
         return pc;
      }
   }

   if (luck > 185)
   {
      pc.rect.y += pc.vel.dy*scale_y;
      return pc;
   }

   else if (luck < 15)
   {
      pc.rect.y -= pc.vel.dy*scale_y;
      return pc;
   }

   pc.rect.y -= pc.vel.dy*scale_y;

   if (pc.rect.y <= 0)
   {
      //pc.rect.x = 940;
      pc.rect.y = 550;
      scoreB++;
      //draw_score(scoreA, scoreB);  
      return pc;
   }

   else if (pc.rect.y + (pc.rect.h - 10) >= 630){
      pc.rect.y = 550;
      return pc;
   }

   else
   {
      return pc;
   }   
}

void initEnvironment(Rect *s)
{
    int i, offset_x, offset_y;
    offset_x = 0;
    offset_y = 53*scale_y;
    for (i = 0; i <= NUM_ASTEROIDS; i++)
    {        
        offset_x = randint(0, 123)*scale_x; 
        s[i].x = offset_x;
        s[i].y = offset_y;
        s[i].w = 30;
        s[i].h = 10;

        offset_y = offset_y - 40;
    }
}

void environment(Rect *s)
{
    int i;
    for (i = 0; i <= NUM_ASTEROIDS - 1; i++)
    {
        if ((i % 2) == 1)
        {
            if (s[i].x <= 0)
            {
                s[i].x = 1240;
            }
            s[i].x = s[i].x - scale_x;
        }
        else
        {
            if (s[i].x >= 1240)
            {
                s[i].x = 0;
            }
            s[i].x = s[i].x + scale_x;
        }
    }
}

/*
muevo los asteroides segun la marca de tiempo y envio si existe una colision con los cohetes
*/
void moveAsteroids(Rect *s)
{
    if (flagMove)
    {

        flagMove = 0;

        for (size_t i = 0; i < NUM_ASTEROIDS; i++)
        {

            if (check_collision(s[i], playerOne.rect))
            {

                playerOne.rect.y = 550;
                Uart_playerOne.y = playerOne.rect.y/scale_y;
                Serial_Write(&SendPlayerX, 2);
                Serial_Write(&Uart_playerOne, sizeof(Recta));

            }
            
            if ((i % 2) == 1)
            {

                if (s[i].x <= 0)
                {
                    s[i].x = 1240;
                }
               s[i].x = s[i].x - scale_x;
            
            }

            else
            {

                if (s[i].x >= 1240)
                {
                    s[i].x = 0;
                }
                s[i].x = s[i].x + scale_x;
            
            }
        }
    }
}

#endif



