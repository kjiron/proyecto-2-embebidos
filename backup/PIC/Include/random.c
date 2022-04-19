#include "random.h"


typedef struct { uint32_t state;  uint32_t inc; } pcg32_random_t;

static uint32_t pcg32_random_r(pcg32_random_t *rng)
{
    uint32_t oldstate, xorshifted, rot;
    
    oldstate = rng->state;
    // Advance internal state
    rng->state = oldstate * 636413623u + (rng->inc|1);
    // Calculate output function (XSH RR), uses old state for max ILP
    xorshifted = ((oldstate >> 7u) ^ oldstate) >> 18u;
    rot = oldstate >> 27u;
    return (xorshifted >> rot) | (xorshifted << ((-rot) & 15u));
}

static pcg32_random_t rng;

void randomSeed(uint32_t seed)
{   
    rng.state = seed << 16;
    rng.inc = seed & 0xffff;
}

int randint(int min, int max)
{
    uint32_t rand = pcg32_random_r(&rng);
    return min + rand % (max - min + 1);
}