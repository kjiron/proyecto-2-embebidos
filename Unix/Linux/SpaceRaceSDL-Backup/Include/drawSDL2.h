#ifndef __DRAWGLCD__
#define __DRAWGLCD__

#include "keys.h"
#include <SDL.h>  //SDL version 2.0

#define SCREEN_WIDTH 1280 //window height
#define SCREEN_HEIGHT 640 //window width

int scale_x = SCREEN_WIDTH/128;
int scale_y = SCREEN_HEIGHT/64;
char score_text[5];
SDL_Window* window = NULL;  //The window we'll be rendering to
SDL_Renderer *renderer;   //The renderer SDL will use to draw to the screen

//surfaces
static SDL_Surface *screen;
static SDL_Surface *pantallaDeInicio;
static SDL_Surface *seleccionDeJuego;
static SDL_Surface *sprites;
static SDL_Surface *winScreen;
static SDL_Surface *loseScreen;

//textures
SDL_Texture *screen_texture;

typedef struct objeto
{
  int x, y, w, h, dx, dy;

} Objeto;

typedef struct
{
  int8_t x, y;
  int8_t w, h;
} Rect;

typedef struct
{
  int dx, dy;
} Vec2;

typedef struct
{
  Rect rect;
  Vec2 vel;
} Splite;

void draw_clear(){
  SDL_RenderClear(renderer);
  SDL_FillRect(screen, NULL, 0x000000ff);
}

void refresh_sdl(){
  SDL_UpdateTexture(screen_texture, NULL, screen->pixels, screen->w * sizeof (Uint32));
  SDL_RenderCopy(renderer, screen_texture, NULL, NULL);
  SDL_RenderPresent(renderer);
}

void draw_on_SDL_screen(SDL_Surface *temp) {  
  SDL_Rect src;
  SDL_Rect dest;

  src.x = 0;//Pos imagen
  src.y = 0;
  src.w = temp->w;
  src.h = temp->h;

  dest.x = 0;//pos pantalla
  dest.y = 0;
  dest.w = temp->w;
  dest.h = temp->h;

  SDL_BlitSurface(temp, &src, screen, &dest);
  refresh_sdl();
}

void draw_InitFrame(){
  draw_on_SDL_screen(pantallaDeInicio);
  SDL_Delay(4000);
}

void draw_MenuFrame(){
  draw_on_SDL_screen(seleccionDeJuego);
}

void draw_winFrame(){
  draw_on_SDL_screen(winScreen);
  SDL_Delay(4000);
}

void draw_loseFrame(){
  draw_on_SDL_screen(loseScreen);
  SDL_Delay(4000);
}

void draw_box( Rect r, int color) {
  
  int a,b = 0xffffffff;

  SDL_Rect src;

  src.x = r.x;
  src.y = r.y;
  src.w = r.w;
  src.h = r.h;

  //printf("r.x = %i\nr.y = %i\nr.w = %i\nr.h = %i\n", r.x,r.y,r.w,r.h );
  
  if (color == 0)
  {
    SDL_RenderClear(renderer);
    b = 0x000000ff;
  }

  a = SDL_FillRect(screen , &src, b);

  if (a !=0){
  
    printf("fill rectangle faliled in func draw_box()");
  }
}

void draw_circle(Rect circle, int color) {
  SDL_Rect src;
  SDL_Rect dest;

  //pos pantalla
  src.x = 0;
  src.y = 11*90;
  src.w = 90;
  src.h = 90;
  
  dest.x = circle.x;
  dest.y = circle.y;
  dest.w = circle.w;
  dest.h = circle.h;

  if (color == 1)
  {
    int r = SDL_BlitSurface(sprites, &src,screen,&dest);
  
    if (r !=0){
    
      printf("fill rectangle faliled in func draw_partial_image()");
    }
  }

  else if (color == 0)
  {
    draw_box(circle,0);
  }
}

void draw_horizontal_line(Rect asteroid, int color){
  draw_box(asteroid, color);
}

int draw_MenuGame(int modeGame)
{
  Keys key;
  Rect select = {250, 300, 90, 90};
  draw_clear();
  draw_MenuFrame();
  draw_circle(select,1);
  
  while (quit==0)
  {

    key = readKeys();

    if ((key.enter) && (modeGame == 0))
    {
      return 2;
    }
    if ((key.up || key.down)  && (modeGame == 0))
    {
      draw_circle(select, 0);
      select.y = 440;  //offset
      draw_circle(select, 1);
      modeGame = 1;
      SDL_Delay(666);
      continue;
    }
    if ((key.enter) && (modeGame == 1))
    {
      return 3;
    }
    if ((key.up || key.down ) && (modeGame == 1)) 
    {   
      draw_circle(select, 0);
      select.y = 300;  //offset
      draw_circle(select, 1);
      modeGame = 0;
      SDL_Delay(666);
    }
    refresh_sdl();
  }
}

void draw_partial_image(Rect player) {

  SDL_Rect src;
  SDL_Rect dest;
  int i;

  //pos pantalla
  src.x = 0;
  src.y = 0;
  src.w = 90;
  src.h = 90;

  for (i = 0; i < 2; i++) {
  
    dest.x = player.x;
    dest.y = player.y;
    dest.w = player.w;
    dest.h = player.h;
  
    int r = SDL_BlitSurface(sprites, &src,screen,&dest);
    
    if (r !=0){
    
      printf("fill rectangle faliled in func draw_partial_image()");
    }
  }
}

void draw_score(uint8_t a, uint8_t b){

  SDL_Rect src_a;
  SDL_Rect src_b;
  SDL_Rect dest_a;
  SDL_Rect dest_b;

  src_a.x = 0;
  src_a.y = (a+1)*90;
  src_a.w = 90;
  src_a.h = 90;

  src_b.x = 0;
  src_b.y = (b+1)*90;
  src_b.w = 90;
  src_b.h = 90;

  
  dest_a.x = 150;
  dest_a.y = 550;
  dest_a.w = 90;
  dest_a.h = 90;

  dest_b.x = 1070;
  dest_b.y = 550;
  dest_b.w = 90;
  dest_b.h = 90;

  int r = SDL_BlitSurface(sprites, &src_a,screen,&dest_a);

  if (r !=0)
  {
    printf("fill rectangle faliled in func draw_score(a)");
  }
  r = SDL_BlitSurface(sprites, &src_b,screen,&dest_b);
  if (r !=0)
  {
    printf("fill rectangle faliled in func draw_score(b)");
  }
}


int SDL_init(int width, int height, int argc, char *args[]) {

  //Initialize SDL
  if (SDL_Init(SDL_INIT_VIDEO) < 0) {

    printf("SDL could not initialize! SDL_Error: %s\n", SDL_GetError());
    
    return 1;
  } 
  
  int i;
  
  for (i = 0; i < argc; i++) {
    
    //Create window 
    if(strcmp(args[i], "-f")) {
      
      SDL_CreateWindowAndRenderer(SCREEN_WIDTH, SCREEN_HEIGHT, SDL_WINDOW_SHOWN, &window, &renderer);
    
    } else {
    
      SDL_CreateWindowAndRenderer(SCREEN_WIDTH, SCREEN_HEIGHT, SDL_WINDOW_FULLSCREEN, &window, &renderer);
    }
  }

  if (window == NULL) { 
    
    printf("Window could not be created! SDL_Error: %s\n", SDL_GetError());
    
    return 1;
  }

  //create the screen sruface where all the elemnts will be drawn onto (ball, paddles, net etc)
  screen = SDL_CreateRGBSurfaceWithFormat(0, width, height, 32, SDL_PIXELFORMAT_RGBA32);
  
  if (screen == NULL) {
    
    printf("Could not create the screen surfce! SDL_Error: %s\n", SDL_GetError());

    return 1;
  }

  //create the screen texture to render the screen surface to the actual display
  screen_texture = SDL_CreateTextureFromSurface(renderer, screen);

  if (screen_texture == NULL) {
    
    printf("Could not create the screen_texture! SDL_Error: %s\n", SDL_GetError());

    return 1;
  }

  //Load the pantallaDeInicio image
  pantallaDeInicio = SDL_LoadBMP("res/pantallaDeInicio.bmp");

  if (pantallaDeInicio == NULL) {
    
    printf("Could not Load pantallaDeInicio image! SDL_Error: %s\n", SDL_GetError());

    return 1;
  }
  
  //Load the seleccionDeJuego image
  seleccionDeJuego = SDL_LoadBMP("res/seleccionDeJuego.bmp");

  if (seleccionDeJuego == NULL) {
    
    printf("Could not Load seleccionDeJuego image! SDL_Error: %s\n", SDL_GetError());

    return 1;
  }
  //Load the sprites image
  sprites = SDL_LoadBMP("res/sprites.bmp");

  if (sprites == NULL) {
    
    printf("Could not Load sprites image! SDL_Error: %s\n", SDL_GetError());

    return 1;
  }
  //Load the win image
  winScreen = SDL_LoadBMP("res/winScreen.bmp");

  if (winScreen == NULL) {
    
    printf("Could not Load winScreen image! SDL_Error: %s\n", SDL_GetError());

    return 1;
  }
  
  //Load the lose image
  loseScreen = SDL_LoadBMP("res/loseScreen.bmp");

  if (loseScreen == NULL) {
    
    printf("Could not Load loseScreen image! SDL_Error: %s\n", SDL_GetError());

    return 1;
  }

  // Set the pantallaDeInicio colourkey. 
  Uint32 colorkey = SDL_MapRGB(pantallaDeInicio->format, 255, 0, 255);
  SDL_SetColorKey(sprites, SDL_TRUE, colorkey);
  
  return 0;
}

#endif