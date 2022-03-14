#ifndef __DYNAMICS__
#define __DYNAMICS__


#include "keys.h"
#include "structs.h"

void movePlayer(Splite *player)
{
    Keys key;
    key = readKeys();

    if (key.up)
    {
        playerOne->rect->y -= playerOne->vel->dy;  
        if (playerOne->rect->y <= 0)
        {
            playerOne->rect->y = 0;
        }
            
    }

    else if (key->down)
    {
        playerOne->rect->y += playerOne->vel->dy;
        if (playerOne->rect->y >= 64)
        {
            playerOne->rect.y = 63;
        }
        
    }

}


#endif