CC = gcc
CFLAGS = `pkg-config --cflags --libs sdl2`

all: main.c serial.o random.o 
	$(CC) main.c $(CFLAGS) -o main serial.o random.o

allAst: asteroids.c serial.o random.o 
	$(CC) asteroids.c $(CFLAGS) -o asteroids serial.o random.o

serial.o: serial.h serial.c
	$(CC) -c serial.h serial.c

random.o: random.h random.c
	$(CC) -c random.h random.c


run:
	./main

runAst:
	./asteroids

.PHONY: clean
clean:
	rm -rf *.o

