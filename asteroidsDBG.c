#include <stdint.h>

#define ERASE 0
#define DRAW  1
#define NUM_ASTEROIDS 13
// Glcd module connections
char GLCD_DataPort at PORTD;

sbit GLCD_CS1 at LATB0_bit;
sbit GLCD_CS2 at LATB1_bit;
sbit GLCD_RS  at LATB2_bit;
sbit GLCD_RW  at LATB3_bit;
sbit GLCD_EN  at LATB4_bit;
sbit GLCD_RST at LATB5_bit;

sbit GLCD_CS1_Direction at TRISB0_bit;
sbit GLCD_CS2_Direction at TRISB1_bit;
sbit GLCD_RS_Direction  at TRISB2_bit;
sbit GLCD_RW_Direction  at TRISB3_bit;
sbit GLCD_EN_Direction  at TRISB4_bit;
sbit GLCD_RST_Direction at TRISB5_bit;
// End Glcd module connections

typedef struct
{
  int8_t x, y;
  int8_t w, h;
} Rect;

void draw_horizontal_line(Rect asteroid, uint8_t color);

// randint(10) -> 0 .. 10
uint8_t randint(uint8_t n)
{
    return (uint8_t)(rand() % (n+1));
}

void initEnvironment(Rect *s)
{
    uint8_t i, offset_x, offset_y;
    offset_x = 0;
    offset_y = 53;
    for (i = 0; i <= 12; i++)
    {        
        s[i].x = offset_x;
        s[i].y = offset_y;
        s[i].w = 3;
        s[i].h = 1;

        offset_x = randint(123); 
        offset_y = offset_y - 4;
    }
}


void environment(Rect *s)
{
    uint8_t i;
    for (i = 0; i <= NUM_ASTEROIDS - 1; i++)
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





void main()
{
    
    Rect m[NUM_ASTEROIDS];//cuidado
    
    //seteo las pocisiones
    initEnvironment(m);
    
    
    Glcd_Init();
    Glcd_Fill(0x00);


    while (1)
    {
        //mueve y pinto los Rect
        environment(m);
        Delay_ms(60);

    }
    
}


void draw_horizontal_line(Rect asteroid, uint8_t color)
{
  Glcd_H_Line(asteroid.x, asteroid.x + asteroid.w, asteroid.y,  color);
}