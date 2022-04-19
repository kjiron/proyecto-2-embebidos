#ifndef __KEYS__
#define __KEYS__

#include <stdbool.h>

typedef struct
{
  bool up, down, enter, quit;
} Keys;

int quit = 0;

Keys readKeys()
{

  Keys tmp;

  SDL_PumpEvents();
  
  const Uint8 *keystate = SDL_GetKeyboardState(NULL);

  tmp.up    = keystate[SDL_SCANCODE_UP];
  tmp.down  = keystate[SDL_SCANCODE_DOWN];
  tmp.enter = keystate[SDL_SCANCODE_RETURN];
  quit  = keystate[SDL_SCANCODE_ESCAPE];
  return tmp;
  
}

#endif