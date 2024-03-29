#include "serial.h"

int fileDesc;
fd_set all_set, r_set;
struct timeval tv;

void Serial_Init(const char *url, uint32_t baudrate)
{
    struct timeval timeout;    
	timeout.tv_sec = 1;
	timeout.tv_usec = 0;

	//fileDesc = open("/dev/ttyUSB0", O_RDWR);  // /dev/ttyS0
	fileDesc = open(url, O_RDWR);  // /dev/ttyS0
	
	//////preparing select()
	FD_ZERO(&all_set);
	FD_SET(fileDesc, &all_set);
	r_set = all_set;
	tv.tv_sec = 1; 
	tv.tv_usec = 0;
	
	struct termios tty;

	// Read in existing settings, and handle any error
	if(tcgetattr(fileDesc, &tty) != 0) 
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

	cfsetispeed(&tty, baudrate);
	cfsetospeed(&tty, baudrate);

	sleep(1);
	tcflush(fileDesc, TCIOFLUSH);

	if (tcsetattr(fileDesc, TCSANOW, &tty) != 0) 
	{
		printf("Error %i from tcsetattr: %s\n", errno, strerror(errno));
		exit(1);
	}
}


size_t Serial_Write(void *buf, int n)
{
    n = write(fileDesc, buf, n);
	if (n < 0) {
		return 0;
	}
	return n;
}

size_t Serial_Read(void *buf, size_t n)
{
    return read(fileDesc, buf, n);
}


size_t Serial_Available() {
	size_t n = 0;
	//lee la cantidad de bytes en el puerto serial
	ioctl(fileDesc, FIONREAD, &n);
	return n;
}


void Serial_clear() {
	static char tmp[8*1024];
	Serial_Read(tmp, sizeof(tmp));
}
