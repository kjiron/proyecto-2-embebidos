#include "Include/random.h"
#include <stdint.h>

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

char score_text[5];

//function to draw the score
void draw_score(uint8_t a, uint8_t b){ 
    char *fix_text;

    //draw the score
    ShortToStr(a, score_text);
    fix_text = Ltrim(score_text);
    Glcd_Write_Text(fix_text, 15, 7, 1);
    ShortToStr(b, score_text);
    fix_text = Ltrim(score_text);
    Glcd_Write_Text(fix_text, 107, 7, 1);
}

void draw_horizontal_line(Rect asteroid, uint8_t color)
{
    Glcd_H_Line(asteroid.x, asteroid.x + asteroid.w, asteroid.y,  color);
}


void main() {
    uint32_t i, e;
    i = 0;
    e = 0;
    Glcd_Init();
    Glcd_Fill(0x00);

    randomSeed(33);

    while (1)
    {
        draw_score(i, e);
        i = randint(0, 123);
        Delay_ms(2000);
        Glcd_Fill(0x00);

    }
    
}