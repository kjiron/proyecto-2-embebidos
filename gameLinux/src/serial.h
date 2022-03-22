#include <stdio.h>
#include <string.h>
#include <unistd.h> // write(), read(), close()
#include <fcntl.h> // Contains file controls like O_RDWR
#include <errno.h> // Error integer and strerror() function
#include <termios.h> // Contains POSIX terminal control definitions
// Linux headers
#include <sys/select.h>
#include <arpa/inet.h> //inet_addr


int puerto_serial, ndfs;
fd_set all_set, r_set; //file descriptors to use on select()
struct timeval tv;



void Serial_Init(unsigned int b);
size_t Serial_Write(void *buf, size_t n);
size_t Serial_Read(void *buf, size_t n);