#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

// Linux headers
#include <fcntl.h> // Contains file controls like O_RDWR
#include <errno.h> // Error integer and strerror() function
#include <termios.h> // Contains POSIX terminal control definitions
#include <unistd.h> // write(), read(), close()
#include <pthread.h>
#include <sys/select.h>
#include <arpa/inet.h> //inet_addr

#define Tam_buffer 100
#define LARGO 1024

int puerto_serial,ndfs;
fd_set all_set, r_set; //file descriptors to use on select()
struct timeval tv;
int TamMsj;
int numBytes;

char bufferEntrante[Tam_buffer];

long error;

// Open the serial port. Change device path as needed (currently set to an standard FTDI USB-UART cable type device)
int main(int argc, char **argv){

    //system("clear");

	struct timeval timeout;    
	timeout.tv_sec = 1;
	timeout.tv_usec = 0;

	//puerto_serial = open("/dev/ttyUSB0", O_RDWR);  // /dev/ttyS0
	puerto_serial = open("/dev/ttyS0", O_RDWR);  // /dev/ttyS0
	ndfs = puerto_serial + 1;
	
	//////preparing select()
	FD_ZERO(&all_set);
	FD_SET(puerto_serial, &all_set);
	r_set = all_set;
	tv.tv_sec = 1; 
	tv.tv_usec = 0;
	
	struct termios tty;

	// Read in existing settings, and handle any error
	if(tcgetattr(puerto_serial, &tty) != 0) 
	{
		printf("Error %i from tcgetattr: %s\n", errno, strerror(errno));
	}

	tty.c_cflag &= ~PARENB; // Clear parity bit, disabling parity (most common)
	tty.c_cflag &= ~CSTOPB; // Clear stop field, only one stop bit used in communication (most common)
	tty.c_cflag |= CS8; // 8 bits per byte (most common)
	tty.c_cflag &= ~CRTSCTS; // Disable RTS/CTS hardware flow control (most common)
	tty.c_cflag |= CREAD | CLOCAL; // Turn on READ & ignore ctrl lines (CLOCAL = 1)

	tty.c_lflag &= ~ICANON;
	tty.c_lflag &= ~ECHO; // Disable echo
	tty.c_lflag &= ~ECHOE; // Disable erasure
	tty.c_lflag &= ~ECHONL; // Disable new-line echo
	tty.c_lflag &= ~ISIG; // Disable interpretation of INTR, QUIT and SUSP
	tty.c_iflag &= ~(IXON | IXOFF | IXANY); // Turn off s/w flow ctrl
	tty.c_iflag &= ~(IGNBRK|BRKINT|PARMRK|ISTRIP|INLCR|IGNCR|ICRNL); // Disable any special handling of received bytes

	tty.c_oflag &= ~OPOST; // Prevent special interpretation of output bytes (e.g. newline chars)
	tty.c_oflag &= ~ONLCR; // Prevent conversion of newline to carriage return/line feed
	// tty.c_oflag &= ~OXTABS; // Prevent conversion of tabs to spaces (NOT PRESENT ON LINUX)
	// tty.c_oflag &= ~ONOEOT; // Prevent removal of C-d chars (0x004) in output (NOT PRESENT ON LINUX)

	tty.c_cc[VTIME] = 1;    // Wait for up to 1s (10 deciseconds), returning as soon as any data is received.
	tty.c_cc[VMIN] = 20;

	cfsetispeed(&tty, B9600);
	cfsetospeed(&tty, B9600);

	if (tcsetattr(puerto_serial, TCSANOW, &tty) != 0) 
	{
		printf("Error %i from tcsetattr: %s\n", errno, strerror(errno));
	}

	while(1)
	{

		r_set = all_set;
        tv.tv_sec = 10;

		select(ndfs, &r_set, NULL, NULL, &tv);

		if(FD_ISSET(puerto_serial, &r_set))
		{

			memset(bufferEntrante, '\0', sizeof(bufferEntrante));
			numBytes = read(puerto_serial, &bufferEntrante, sizeof(bufferEntrante)); // lee el UART y cae sobre bufferEntrante

			// TamMsj = write(puerto_serial, seg,strlen(seg));
			//guarda en TamMsj el tamaño en bytes del write y envia por uart "seg" con tamaño efectivo de "seg"

            printf("bufferEntrante: %s\n", bufferEntrante );// imprime la entrada del UART 
		
			FD_CLR(puerto_serial, &r_set);
			printf("\r");
			memset(bufferEntrante,'\0', sizeof(bufferEntrante));

		}
	}
}
