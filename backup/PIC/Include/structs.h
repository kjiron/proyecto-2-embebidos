#ifndef __STRUCTS__
#define __STRUCTS__

#include <stdbool.h>
#include <stdint.h>

typedef struct
{
  bool up, down, enter;
} Keys;


typedef struct
{
  int8_t x, y;
  int8_t w, h;
} Rect;


typedef struct
{
  int8_t dx, dy;
} Vec2;

typedef struct
{
  Rect rect;
  Vec2 vel;
} Splite;


#endif