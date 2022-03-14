#include <stdint.h>
#include "\Include\drawGlcd.h"
#include "\Include\hit.h"



#define TITLE     0
#define MENU      1
#define ONEPLAYER 2


void initAsteroids(Rect *tmp)
{
    uint8_t i, offset_x, offset_y;
    offset_x = 20;
    offset_y = 15;


    for (i = 0; i <= 3; i++)
    {
        if ((i % 2) == 0)
        {
            tmp[i].w = 3;
            tmp[i].h = 1;

            if (i == 0)
            {
                tmp[i].x = 0;
                tmp[i].y = 60;
            }

            else
            {
                tmp[i].x = tmp[i - 1].x + offset_x;
                tmp[i].y = tmp[i - 1].y - offset_y;
            }
            
        }
        else
        {

            tmp[i].x = 124;
            tmp[i].y = 55;            
            tmp[i].w = 3;
            tmp[i].h = 1;
        }
        
        
    }
    
}


void move_asteroids(Rect *tmp)
{

    uint8_t i;
    for (i = 0; i <= 3; i++)
    {
        //los asteroides de izquierda a derecha

        if ((i % 2) == 0)
        {
            draw_horizontal_line(tmp[i], 0);
            if (tmp[i].x >= 124)
            {
                tmp[i].x = 0;
            }
            
            tmp[i].x++;
            draw_horizontal_line(tmp[i], 1);
        }
        else
        //los asteroides de derecha a izquierda
        {
            draw_horizontal_line(tmp[i], 0);
            if (tmp[i].x <= 0)
            {
                tmp[i].x = 124;
            }
            
            tmp[i].x--;
            draw_horizontal_line(tmp[i], 1);

        }
        
    }
    
}



void main() {
    uint8_t state = 2;
    uint8_t modeGame = 0;
    Splite playerOne;
    Keys key;
    Rect asteroids[3];

    playerOne.rect.x = 64;
    playerOne.rect.y = 32;
    playerOne.rect.w = 1;
    playerOne.rect.h = 1;
    playerOne.vel.dx = 0;
    playerOne.vel.dy = 1;


    initAsteroids(asteroids);

    

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

                //environment();
                move_asteroids(asteroids);
                
                draw_dot(playerOne, 1);
                Delay_ms(60);
                
                
            }
            
            break;


        default:
            break;
        }
    }
    

    
}