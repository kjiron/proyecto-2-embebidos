#include <stdint.h>
#include <stdbool.h>
#include "Include\serial.h"
#include "Include\random.h" 



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

/*
banderas ha utilizar en multiplayer
*/
uint16_t SendAck        = 0x9111;
uint16_t SendInit       = 0x9222;
uint16_t SendUpdateAst  = 0x9333;
uint16_t SendPlayer     = 0x9444;
uint16_t SendTime       = 0x9555;
uint16_t SendPlayerX    = 0x9666;
uint16_t SendScore      = 0x9777;
uint16_t SendTimeOut    = 0x9888;


/*
imagen del ganador
*/
const code char winScreen[1024] = {
  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 
  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 
  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 128, 128, 128, 128, 128, 128, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 240, 128, 128, 128, 128, 128, 128,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 
  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   1,   1,   1,   4,   4,   6,   7,   7,  15, 143,  15, 255, 255, 255, 255, 255, 255,  15, 143,   7,   7,   7,   4,   4,   4,   0,   1,   1,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 
  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 192, 192,   0,   0,   0,   0,   0,   0, 192, 192, 192, 192,   0, 128, 128,  64,  64,  64,  64, 192, 192, 128, 128,   0,   0, 192, 192,   0,   0,   0, 192, 192, 192, 192,   0,   0,   0,   0,   0,   0, 192, 192,   0,   0,   0,   0,   0, 192, 192, 192, 192,   0,   0, 192, 192, 192, 192,   0,   0, 192, 192, 128, 128,   0,   0,   0, 192, 192, 192, 192,   0,   0, 192, 192, 192, 192,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 
  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   1,   1,   2,   2,  30,  30,  31,  31,   3,   3,   1,   1,   0,   7,  15,   8,  16,  16,  16,  31,  31,  15,  15,   0,   0,  15,  15,  16,  16,  16,  31,  31,  15,  15,   0,   0,   0,   0,   0,   0,  15,  15,  16,   0,  14,  14,  16,  31,  31,  15,  15,   0,   0,  31,  31,  31,  31,   0,   0,  31,  15,   0,   0,   1,   1,   2,  15,  31,  31,  31,   0,   0,  23,  23,  23,  23,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 
  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 
  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0
};

/*
imagen para el perdedor
*/
const code char loseScreen[1024] = {
  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 
  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 
  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 
  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 224, 240, 208,  16,  16,  16, 112,  96,   0, 192, 224,  48,  16,  16, 240, 224, 192,   0, 240, 240, 224, 192, 192, 240, 240, 240,   0,  16, 240, 240, 144, 144, 176,  48,  16,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 240, 240,  16,  16,  16, 240, 240,   0,  16, 240, 240,   0,   0,   0, 240, 240,   0,   0, 240, 240, 240, 144, 144, 176,  48,   0,  16, 240, 240, 240, 144, 144, 240, 224,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 
  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   7,  15,  15,   8,   8,  11,  15,   7,   0,  15,  15,   3,   3,   3,  15,  15,  15,   0,  15,  15,   0,   3,   0,  15,  15,  15,   0,   8,  15,  15,   9,   9,  13,  12,   8,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,  15,  15,   8,   8,   8,  15,  15,   0,   1,   3,   7,  14,  12,   6,   7,   3,   0,   8,  15,  15,  15,   9,   9,  13,  12,   0,   8,  15,  15,  15,   3,   7,  15,  12,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 
  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 
  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 
  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0
};


/*
nave jugador
*/
const code char ship[18] = {
128, 192, 228, 246, 255, 246, 228, 192, 128, 
  0,   0,   0,   1,   0,   1,   0,   0,   0
};

/*
borrador
*/
const code char parche[18] = {
  0,   0,   0,   0,   0,   0,   0,   0,   0,
  0,   0,   0,   0,   0,   0,   0,   0,   0
};




typedef struct
{
  int8_t x, y;
  int8_t w, h;
} Rect;

Rect asteroids[NUM_ASTEROIDS], timer, playerOne, playerTwo;
uint8_t flag = 0, flagScore = 0, flagTimeOut = 0;
char score_text[5];
uint8_t scoreA = 0, scoreB = 0;


void draw_horizontal_line(Rect asteroid, uint8_t color);
void draw_dot(Rect player, uint8_t color);
void draw_partial_image(Rect player, code const unsigned short * image);
void draw_winFrame();
void draw_loseFrame();


/*
inicializa las posiciones de los asteroides con pseudo-aleatorio y el timer
*/
void Asteroids_Init(Rect *s)
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

    timer.x = 62;
    timer.y = 3;
    timer.w = 1;
    timer.h = 60;  
}

/*
Verifico colision con dos estrucutas Rect
*/
bool check_collision(Rect rect1, Rect rect2)
{
    return rect1.x < rect2.x + rect2.w &&
       rect1.x + rect1.w > rect2.x &&
       rect1.y < rect2.y + rect2.h &&
       rect1.h + rect1.y > rect2.y;
}

/*
Pinto, borro y MUEVO los asteroides, además, cada que termina de hacer esto
mando una marca por UART->SendUpdateAst
Por si fuera poco, aqui tambien verifico colision de los cohetes con jugadores
*/
void moveAndCheckAsteroids(Rect *s)
{
    uint8_t i;
    for (i = 0; i < NUM_ASTEROIDS; i++)
    {
        if (check_collision(s[i], playerOne))
        {
            playerOne.y = 55;
            Serial_Write(&SendPlayer, 2);
            Serial_Write(&playerOne, sizeof(Rect));
        }
        
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
    //aqui debo de enviar marca de tiempo, siempre, ya que sincroniza la jugada
    Serial_Write(&SendUpdateAst, 2);
}

/*
pinto el score en la GLCD, hay que buscar una mejor forma de hacerlo,
con imagenes por ejemplo, ya que este acapará mucho de memoria
*/
void draw_score(uint8_t a, uint8_t b){ //function to draw the score
    char *fix_text;
    //draw the score
    ShortToStr(a, score_text);
    fix_text = Ltrim(score_text);
    Glcd_Write_Text(fix_text, 15, 7, 1);
    ShortToStr(b, score_text);
    fix_text = Ltrim(score_text);
    Glcd_Write_Text(fix_text, 107, 7, 1);
}



/*
lee de UART la marca:
-> SendTime, que permite activar un flag para actualizar el tiempo
-> SendPlayer, actualiza la posicion del player dos
*/
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

            if (mark == SendPlayer)
            {
                Serial_Read(&playerTwo, sizeof(Rect));
                continue;
            }

            if (mark == SendPlayerX)
            {
                Serial_Read(&playerTwo, sizeof(Rect));
                continue;
            }
            
            if (mark == SendScore)
            {
                flagScore = 1;
                continue;
            }

            if (mark == SendTimeOut)
            {
                flagTimeOut = 1;
                continue;
            }

            Serial_clear();
        }

        return;
    }

}


/*
Sincroniza el inicio del juego, ya que necesitamos que los cohetes empiecen 
a moverse según el tiempo del PIC que es el más lerdo
*/
void syncGame()
{
    int i, n;
    uint16_t mark;
    while (1)
    {
        Serial_Write(&SendInit, 2);

        n = Serial_available();

        if (n > 2)
        {
            Serial_Read(&mark, 2);

            if (mark == SendAck)
            {
                break;
            }

            Serial_clear();
        }
        
        Delay_ms(200);
        
        
    }
    
}

void draw_box(Rect r, uint8_t color)
{
  //void Glcd_Rectangle(unsigned short x_upper_left, unsigned short y_upper_left, unsigned short x_bottom_right, unsigned short y_bottom_right, unsigned short color);
    Glcd_Box(r.x, r.y, r.x + r.w, r.y + r.h, color);  
}


/*
inicializa playerOne y playerTwo
*/
void initGame()
{
    playerOne.x = 32;
    playerOne.y = 55;
    playerOne.w = 9;
    playerOne.h = 9;

    playerTwo.x = 94;
    playerTwo.y = 55;
    playerTwo.w = 9;
    playerTwo.h = 9;
}



void main()
{
    //variables del juego
    Rect m[NUM_ASTEROIDS];
    uint16_t mark;
    uint8_t i, n;
    //entradas digitales
    ADCON1 = 0x0F;
    //inicializo serial, posicion de player, random, asteroides, la GLCD y sincronizo
    Serial_Init();
    Serial_clear();
    initGame();
    randomSeed(33);
    Asteroids_Init(asteroids);
    Glcd_Init();
    Glcd_Fill(0x00);
    syncGame();    
    draw_score(scoreA, scoreB); 

    while (1)
    {
        //así se deberia de llamar la funcion que lee los asteroides de uart
        moveAndCheckAsteroids(asteroids);
        updateData();
        
        if (flag)
        {
            timer.y++;
            flag = 0;
        }

        if (flagScore)
        {
            flagScore = 0;
            scoreB++;
            draw_score(scoreA, scoreB);
        }
        
        

        if (PORTA.B2 == 1) //up
        {
            playerOne.y--;
            if (playerOne.y <= 0){
                playerOne.x = 32;
                playerOne.y = 55;
                scoreA++;
                Serial_Write(&SendScore, 2);
                draw_score(scoreA, scoreB);
            }
            Serial_Write(&SendPlayer, 2);
            Serial_Write(&playerOne, sizeof(Rect));
        }

        if (PORTA.B3 == 1) //down
        {
            playerOne.y++;
            if (playerOne.y + (playerOne.h - 1) >= 63){
                playerOne.y = 55;
            }
            Serial_Write(&SendPlayer, 2);
            Serial_Write(&playerOne, sizeof(Rect)); 
        }

        if (flagTimeOut)
        {
            flagTimeOut = 0;
            if (scoreA > scoreB)
            {
                draw_winFrame();
            }

            else if (scoreB > scoreA)
            {
                draw_loseFrame();
            }

            else
            {
                draw_loseFrame();
            }     
        }
        
        
        //pinto y borro, el tiempo y jugadores
        draw_box(timer, DRAW);
        draw_partial_image(playerOne, ship);
        draw_partial_image(playerTwo, ship);
        Delay_ms(60);
        draw_box(timer, ERASE);
        draw_partial_image(playerOne, parche);
        draw_partial_image(playerTwo, parche);
        
    }    
}


void draw_horizontal_line(Rect asteroid, uint8_t color)
{
    Glcd_H_Line(asteroid.x, asteroid.x + asteroid.w, asteroid.y,  color);
}

void draw_dot(Rect player, uint8_t color)
{
    Glcd_Dot(player.x, player.y, color);
}

void draw_partial_image(Rect player, code const unsigned short * image)
{
    Glcd_PartialImage(player.x, player.y, player.w, player.h, player.w, player.h, image); 
}


void draw_winFrame(){
    Glcd_Image(winScreen);
    Delay_ms(4000);
    Glcd_Fill(0x00);
}

void draw_loseFrame(){
    Glcd_Image(loseScreen);
    Delay_ms(4000);
    Glcd_Fill(0x00);
}