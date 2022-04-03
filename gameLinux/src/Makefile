CC = gcc
CFLAGS = `pkg-config --cflags --libs sdl2`

all: main.c serial.o
	$(CC) main.c $(CFLAGS) -o main serial.o

serial.o: serial.h serial.c
	$(CC) -c serial.h serial.c

run:
	./main


allAst: asteroids.c serial.o
	$(CC) asteroids.c $(CFLAGS) -o asteroids serial.o

serial.o: serial.h serial.c
	$(CC) -c serial.h serial.c

runAst:
	./asteroids

.PHONY: clean
clean:
	rm -rf *.o

