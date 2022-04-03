#include <stdint.h>
#include <stdbool.h>
#include "Include\serial.h"



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


uint8_t SendAsteroid = 0xBB;
uint8_t SendAsteroid2 = 0xEE;
uint8_t SendAsteroid3 = 0xAA;
uint8_t SendAsteroid4 = 0xA9;
uint8_t SendAsteroid5 = 0xA8;
uint8_t SendAsteroid6 = 0xA7;
uint8_t SendAsteroid7 = 0xA6;
uint8_t SendAsteroid8 = 0xA5;
uint8_t SendAsteroid9 = 0xA4;
uint8_t SendAsteroid10 = 0xA3;
uint8_t SendAsteroid11 = 0xA2;
uint8_t SendAsteroid12 = 0xA1;
uint8_t SendAsteroid13 = 0xA0;
uint16_t SendTime = 0x9555;



typedef struct
{
  int8_t x, y;
  int8_t w, h;
} Rect;

Rect asteroids[NUM_ASTEROIDS], lastAsteroid[NUM_ASTEROIDS], timer;
uint8_t flag;
void draw_horizontal_line(Rect asteroid, uint8_t color);

// randint(10) -> 0 .. 10
uint8_t randint(uint8_t n)
{
    return (uint8_t)(rand() % (n+1));
}

void Asteroids_Init(Rect *s)
{
    uint8_t i, offset_x, offset_y;
    offset_x = 0;
    offset_y = 53;
    for (i = 0; i < NUM_ASTEROIDS; i++)
    {        
        s[i].x = offset_x;
        s[i].y = offset_y;
        s[i].w = 3;
        s[i].h = 1;

        offset_x = randint(123); 
        offset_y = offset_y - 4;
    }

    timer.x = 62;
    timer.y = 3;
    timer.w = 1;
    timer.h = 60;  
}


void Update_Asteroids(Rect *s)
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


void updateData() {
    int n;
    uint16_t mark;

    while (1)
    {
    
        n = Serial_available();
        if (n >= (2)) {
            Serial_Read(&mark, 2);

            if (mark == SendTime) {
                flag = 1;
                continue;
            }

            Serial_clear();
        }

        return;
    }

}

void draw_box(Rect r, uint8_t color)
{
  //void Glcd_Rectangle(unsigned short x_upper_left, unsigned short y_upper_left, unsigned short x_bottom_right, unsigned short y_bottom_right, unsigned short color);
    Glcd_Box(r.x, r.y, r.x + r.w, r.y + r.h, color);  
}


void main()
{
    
    Rect m[NUM_ASTEROIDS];//cuidado
    uint16_t mark;
    uint16_t ok;
    uint8_t i;
    //seteo las pocisiones
    
    
    Serial_Init();

    Serial_clear();

    Asteroids_Init(asteroids);


    Glcd_Init();
    Glcd_Fill(0x00);

    while (1)
    {
        //así se deberia de llamar la funcion que lee los asteroides de uart
        Update_Asteroids(asteroids);
        updateData();
        
        if (flag)
        {
            timer.y++;
            flag = 0;
            Serial_clear();
        }
        
        for (i = 0; i < NUM_ASTEROIDS; i++)
        {    
            if (i == 0)
            {
                Serial_Write(&SendAsteroid, 1);
                Serial_Write(&asteroids[i].x, 1);
            }
            else if (i == 1)
            {
                Serial_Write(&SendAsteroid2, 1);
                Serial_Write(&asteroids[i].x, 1);
            }

            else if (i == 2)
            {
                Serial_Write(&SendAsteroid3, 1);
                Serial_Write(&asteroids[i].x, 1);
            }

            else if (i == 3)
            {
                Serial_Write(&SendAsteroid4, 1);
                Serial_Write(&asteroids[i].x, 1);
            }

            else if (i == 4)
            {
                Serial_Write(&SendAsteroid5, 1);
                Serial_Write(&asteroids[i].x, 1);
            }

            else if (i == 5)
            {
                Serial_Write(&SendAsteroid6, 1);
                Serial_Write(&asteroids[i].x, 1);
            }                        

            else if (i == 6)
            {
                Serial_Write(&SendAsteroid7, 1);
                Serial_Write(&asteroids[i].x, 1);
            }

            else if (i == 7)
            {
                Serial_Write(&SendAsteroid8, 1);
                Serial_Write(&asteroids[i].x, 1);
            }                        

            else if (i == 8)
            {
                Serial_Write(&SendAsteroid9, 1);
                Serial_Write(&asteroids[i].x, 1);
            }   

            else if (i == 9)
            {
                Serial_Write(&SendAsteroid10, 1);
                Serial_Write(&asteroids[i].x, 1);
            }   


            else if (i == 10)
            {
                Serial_Write(&SendAsteroid11, 1);
                Serial_Write(&asteroids[i].x, 1);
            }   


            else if (i == 11)
            {
                Serial_Write(&SendAsteroid12, 1);
                Serial_Write(&asteroids[i].x, 1);
            }   
            
            else if (i == 12)
            {
                Serial_Write(&SendAsteroid13, 1);
                Serial_Write(&asteroids[i].x, 1);
            }   
        }

        draw_box(timer, DRAW);
        Delay_ms(60);
        draw_box(timer, ERASE);
        
    }    
}


void draw_horizontal_line(Rect asteroid, uint8_t color)
{
  Glcd_H_Line(asteroid.x, asteroid.x + asteroid.w, asteroid.y,  color);
}