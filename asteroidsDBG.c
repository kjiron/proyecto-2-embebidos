#include <stdint.h>

#define ERASE 0
#define DRAW  1
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




void main()
{
    
    Rect m[13];//cuidado
    uint8_t i, offset_x, offset_y;
    offset_x = 0;
    offset_y = 53;

    //init de cohetes ****n-1
    for (i = 0; i <= 12; i++)
    {        
        m[i].x = offset_x;
        m[i].y = offset_y;
        m[i].w = 3;
        m[i].h = 1;

        offset_x = randint(123); 
        offset_y = offset_y - 4;
    }
    
    Glcd_Init();
    Glcd_Fill(0x00);


    while (1)
    {
        
        for (i = 0; i <= 12; i++)
        {
            draw_horizontal_line(m[i], ERASE);

            if ((i % 2) == 1)
            {
                if (m[i].x <= 0)
                {
                    m[i].x = 124;
                }
                m[i].x--;
            }
            else
            {
                if (m[i].x >= 124)
                {
                    m[i].x = 0;
                }
                m[i].x++;
            }
            draw_horizontal_line(m[i], DRAW);
        }        

        Delay_ms(60);

    }
    
}


void draw_horizontal_line(Rect asteroid, uint8_t color)
{
  Glcd_H_Line(asteroid.x, asteroid.x + asteroid.w, asteroid.y,  color);
}