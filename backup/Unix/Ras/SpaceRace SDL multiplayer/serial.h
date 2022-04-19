#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h> // write(), read(), close()
#include <fcntl.h> // Contains file controls like O_RDWR
#include <errno.h> // Error integer and strerror() function
#include <termios.h> // Contains POSIX terminal control definitions
// Linux headers
#include <sys/select.h>
#include <sys/ioctl.h>

void Serial_clear();
void Serial_Init(const char *url, uint32_t baudrate);
size_t Serial_Write(void *buf, int n);
size_t Serial_Read(void *buf, size_t n);
size_t Serial_Available();
