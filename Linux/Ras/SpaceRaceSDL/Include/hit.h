#ifndef __HIT__
#define __HIT__

#include "drawSDL2.h"
#include "keys.h"

#define ERASE           0
#define DRAW            1
#define NUM_ASTEROIDS   13

int x = 0;
int scoreA = 0, scoreB = 0;

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

int randint(int n)
{
  return (int)(rand() % (n+1));
}

Splite move_player(Splite player, Rect *a)
{
   Keys key;
   int i;
   key = readKeys();

   for (i = 0; i <= NUM_ASTEROIDS - 1; i++){
      if (check_collision(a[i], player.rect))
      {
         player.rect.x = 320;
         player.rect.y = 550;
         return player;
      }
   }

   if (key.down){
      player.rect.y += player.vel.dy*scale_y;
      
      if (player.rect.y + (player.rect.h - 1) >= 630){
         player.rect.y = 550;
      }
   }
   else if (key.up){
      player.rect.y -= player.vel.dy*scale_y;
      if (player.rect.y <= 0){
         player.rect.x = 320;
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

Splite move_ai(Splite pc, Rect *a)
{
   int i, luck;
   luck = randint(200);
   for (i = 0; i <= NUM_ASTEROIDS - 1; i++)
   {
      if (check_collision(a[i], pc.rect))
      {
         pc.rect.x = 940;
         pc.rect.y = 550;
         return pc;
      }
   }

   /*
   for (i = 0; i <= NUM_ASTEROIDS - 1; i++)
   {

      if (((a[i].x + 9) > (pc.rect.x)) && ((a[i].y) == (pc.rect.y + (pc.rect.h / 2)))) 
      {
         pc.rect.y += pc.vel.dy;
         return pc;
      }
   }
   */

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
      pc.rect.x = 940;
      pc.rect.y = 550;
      scoreB++;
      //draw_score(scoreA, scoreB);  
      return pc;
   }

   else if (pc.rect.y + (pc.rect.h - 1) >= 630){
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
    for (i = 0; i <= 12; i++)
    {        
        s[i].x = offset_x;
        s[i].y = offset_y;
        s[i].w = 30;
        s[i].h = 10;

        offset_x = randint(123)*scale_x; 
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

void checkWallCollision(Splite *ball)
{
   if (ball->rect.y >= 60)
   {
      ball->vel.dy = -ball->vel.dy; 
   }

   if (ball->rect.y <= 9)
   {
      ball->vel.dy = -ball->vel.dy; 
   }
}

Splite move_ball(Splite ball)
{
   
   ball.rect.x += ball.vel.dx;
   ball.rect.y += ball.vel.dy; 
   
   checkWallCollision(&ball);

   return ball;
}

Splite move_ai(Splite pc, Splite ball)
{
   uint8_t center = pc.rect.y + pc.rect.w/2;
   if (ball.rect.x < 62)
   {
      if (ball.rect.y > center) 
      { 
         pc.rect.y++;
         if (pc.rect.y >= 50)
         {
            pc.rect.y = 50;
         }
      } 
      else 
      { 
         pc.rect.y--;
         if (pc.rect.y <= 9)
         {
            pc.rect.y = 9;
         }
         
      }
      return pc;      
   }
   return pc;
}

bool goal(Splite *ball, uint8 *a, uint8 *b)
{
   if (ball->rect.x >= 123)
   {
      ball->vel.dx = -1;
      ball->vel.dy = 1;
      (*b) = (*b) + 2; 
      //(*b)++;
      return 1;
   }
   
   if (ball->rect.x <= 5)
   {
      ball->vel.dx = 1;
      ball->vel.dy = -1;
      (*a) = (*a) + 2;  
      //(*a)++;
      return 1;
   }      
   
   return 0;
}

void checkWallCollision(Generic *ball_tmp, uint8 velocity)
{
  if (ball_tmp->posY >= 61){
      ball_tmp->dy = -velocity;
  }
  if (ball_tmp->posY <= 7){
      ball_tmp->dy = velocity;
  }
  if (ball_tmp->posX >= 125){
      ball_tmp->dx = -velocity;
  }
  if (ball_tmp->posX <= 0){
      ball_tmp->dx = velocity;
  }
}

void changeDirectionMode1(uint8 randNum, Generic *ball, uint8 velocity){
   if (randNum == 0){
      ball->dx = -velocity;
      ball->dy = velocity;
   }
   if (randNum == 1){
      ball->dx = -velocity;
      ball->dy = -velocity;
   }
   if (randNum == 2)
   {
      ball->dx = -velocity;
      ball->dy = 0;
   }
}

void changeDirectionMode2(uint8 randNum, Generic *ball, uint8 velocity){
   if (randNum == 0){
      ball->dx = velocity;
      ball->dy = velocity;
   }
   if (randNum == 1){
      ball->dx = velocity;
      ball->dy = -velocity;
   }
   if (randNum == 2){
      ball->dx = velocity;
      ball->dy = velocity;
   }
}

uint8 checkVerticalWall(Generic *ball_tmp){
  if (ball_tmp->posX <= 0){
      ball_tmp->posX = 64;
      ball_tmp->posY = 32;
      ball_tmp->dx = 1;
      ball_tmp->dy = -1;
      return 0;
  }
  if (ball_tmp->posX >= 125){
      ball_tmp->posX = 64;
      ball_tmp->posY = 32;
      ball_tmp->dx = -1;
      ball_tmp->dy = 1;
      return 1;
  }

  return 2;
}



bool check_collision(Generic _ball, Objeto player)
{
   return _ball.posX < (player.positionX + 2) &&
      (_ball.posX + 3) > player.positionX &&
      _ball.posY < (player.positionY + 14) &&
      (3 + _ball.posY) > player.positionY;
}


Objeto movePlayer(Objeto player)
{
  Keys key;
  key = readKeys();

  if (key.right){
    player.positionX = player.positionX + 1;
  }

  if (key.left){
    player.positionX = player.positionX - 1;
  }

  if (key.down){
    player.positionY = player.positionY + 1;
    if (player.positionY >= 49){
       player.positionY = 49;
    }
  }

  if (key.up){
    player.positionY = player.positionY - 1;
    if (player.positionY <= 7){
       player.positionY = 7;
    }
  }

  return player;
}

*/
#endif



