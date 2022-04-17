CC = gcc
CFLAGS = `pkg-config --cflags --libs sdl2`

all: SpaceRaceSDL.c Include/serial.o Include/random.o 
	$(CC) SpaceRaceSDL.c $(CFLAGS) -o SpaceRaceSDL Include/serial.o Include/random.o

serial.o: Include/serial.h Include/serial.c
	$(CC) -c Include/serial.h Include/serial.c

random.o: Include/random.h Include/random.c
	$(CC) -c Include/random.h Include/random.c

runf:
	./SpaceRaceSDL -f

run:
	./SpaceRaceSDL
