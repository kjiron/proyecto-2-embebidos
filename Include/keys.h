#ifndef __KEYS__
#define __KEYS__

#include <stdbool.h>
//ADC_Init();


typedef struct
{
  bool up, down, enter;
} Keys;




static inline Keys readKeys()
{

  Keys tmp;
  /*
  This is for the joystick
  uint32_t s = 0;

  tmp.up = 0;
  tmp.down = 0;
  tmp.enter = 0;


  tmp.enter = PORTA.B4 == 1;
  s = ADC_Read(3);

  if (s >= 800) 
  {
    tmp.up = 1;
  }

  else if (s <= 200)
  {
    tmp.down = 1;
  }

  else
  {
    return tmp;
  }
  
  return tmp;

  */
  
  tmp.up    = PORTA.B2 == 1;
  tmp.down  = PORTA.B3 == 1;
  tmp.enter = PORTA.B4 == 1;
  return tmp;
  
}


#endif