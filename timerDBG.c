#include <stdint.h>

#define ERASE 0
#define DRAW  1


uint8_t TIME_FLAG = 0;
uint8_t contador_ms = 0;


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


//Timer0
//Prescaler 1:16; TMR0 Preload = 3036; Actual Interrupt Time : 500 ms
 
//Place/Copy this part in declaration section
void InitTimer0(){
  T0CON	 = 0x83;
  TMR0H	 = 0x0B;
  TMR0L	 = 0xDC;
  GIE_bit	 = 1;
  TMR0IE_bit	 = 1;
}
 
void Interrupt(){
  if (TMR0IF_bit){ 
    TMR0IF_bit = 0;
    TMR0H	 = 0x0B;
    TMR0L	 = 0xDC;
    //Enter your code here
    contador_ms++;
    if (contador_ms >= 2)
    {
      TIME_FLAG = 1;
      contador_ms = 0;
    }
    
  }
} 


void draw_box(Rect asteroid, uint8_t color);

void main()
{
    
  Rect timer;
  timer.x = 62;
  timer.y = 3;
  timer.w = 1;
  timer.h = 60;

  Glcd_Init();
  Glcd_Fill(0x00);

  draw_box(timer, DRAW);
  InitTimer0();
  //60s
  while (1)
  {

    draw_box(timer, ERASE);

    if (timer.y >= 63)
    {
      timer.y = 23;
    }

    //llama a la interrupcion cada un segundo
    if (TIME_FLAG)
    {
      timer.y++;
      TIME_FLAG = 0;
    }
    
    

    draw_box(timer, DRAW);

    
    
    
    Delay_ms(60);

  }

}

void draw_box(Rect r, uint8_t color)
{
  //void Glcd_Rectangle(unsigned short x_upper_left, unsigned short y_upper_left, unsigned short x_bottom_right, unsigned short y_bottom_right, unsigned short color);
  Glcd_Box(r.x, r.y, r.x + r.w, r.y + r.h, color);  
}