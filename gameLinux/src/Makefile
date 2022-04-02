CC = gcc
CFLAGS = `pkg-config --cflags --libs sdl2`

all: main.c serial.o
	$(CC) main.c $(CFLAGS) -o main serial.o

serial.o: serial.h serial.c
	$(CC) -c serial.h serial.c

run:
	./main

.PHONY: clean
clean:
	rm -rf *.o

