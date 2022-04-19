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
#include <sys/socket.h>
#include <arpa/inet.h> //inet_addr
#include <netinet/in.h>
#include <netdb.h>

#define Tam_buffer 100
#define LARGO 1024
int skS = 0, skC = 0;
char nombre[16];
int puerto_serial,ndfs;
fd_set all_set, r_set; //file descriptors to use on select()
struct timeval tv;
int TamMsj;
int sizeImg = 0;
int n,writeC,total,readC;
int numBytes;
int sumador;
int numEnvios = 0;
//bufferMsj buffer related delcartions/macros
static int inbuf; // how many bytes are currently in the buffer?
static int room; // how much room left in buffer?
char bufferMsj[LARGO] ;
unsigned char bufferImg[20];
char bufferEntrante[Tam_buffer];
unsigned char botones[21];
char banner[3];
float multiplodecien;
int perdido;

long error;
long sentData;
long totalData;

void enviadorjpg();

// Open the serial port. Change device path as needed (currently set to an standard FTDI USB-UART cable type device)
int main(int argc, char **argv){

    //system("clear");

	char header[] = "CABECERA";
    char final[] = "FIN";
    char msjconfg[9]="Recibido";
    char bufferMensaje[Tam_buffer];
	char bufferdos[LARGO];
	char buffertres[LARGO + 2];
    char bufferConfirmador[9];
    char percentajebar[10];	
    int pasado = 0;
//////////////////////////////////////////////////////////////////////////////
///Sockets


	struct timeval timeout;    
	timeout.tv_sec = 1;
	timeout.tv_usec = 0;

	if(argc<2)
	{
		printf("No se ha introducido ni el servidor ni el puerto ni el nombre ni nada.\n");
		return 1;
	}

	int puerto;
	if (argc<3)
	{    
		printf("\nPuerto: ");
		fgets(nombre, 16, stdin); 
		nombre[strcspn(nombre, "\n")] = '\0';
		puerto = (atoi(nombre));
		memset((char *)&nombre, 0, sizeof(nombre));//zero nombre
		printf("Puerto: %i\n", puerto);
		while(!puerto)
		{
			printf("Error, digite un puerto valido..\n");
			printf("\nPuerto: ");
			fgets(nombre, 16, stdin); 
			nombre[strcspn(nombre, "\n")] = '\0';
			puerto = (atoi(nombre));
			memset((char *)&nombre, 0, sizeof(nombre));//zero nombre
		}
		printf("Puerto a conectar: %i\n",puerto );

	}

	else 
	{
		puerto = (atoi(argv[2]));
		while(!puerto)
		{
		  printf("Error, digite un puerto valido..\n");
		  printf("\nPuerto: ");
		  fgets(nombre, 16, stdin); 
		  nombre[strcspn(nombre, "\n")] = '\0';
		  puerto = (atoi(nombre));
		  memset((char *)&nombre, 0, sizeof(nombre));//zero nombre
		}
		printf("Puerto a conectar: %i\n",puerto );
	}
	if ((argv[3] == NULL)||(argc<3) )
	{
		memset((char *)&nombre, '\0', sizeof(nombre));
		sprintf(nombre,"%s","Celular");
		printf("\nNombre del cliente: %s",nombre);
	}

	else {memmove(nombre,argv[3], strlen(argv[3]));}

	if (strlen(nombre) > 16 || strlen(nombre) < 2)
	{
		printf("Error el nombre debe tener entre 2 y 16 caracteres...\n");
		return 1;
	}

	struct sockaddr_in cliente; //estructura cliente
	struct hostent *servidor; //estructura servidor
	servidor = gethostbyname(argv[1]); //se asigna el argumento [1] como servidor
	if(servidor == NULL)
	{ //Se comprueba que el servidor exista
		printf("Error, servidor vacío\n");
		return 1;
	}
	skC = socket(AF_INET, SOCK_STREAM, 0); //socket cliente

	memset((char *)&cliente, 0, sizeof(cliente));//zero cliente
	cliente.sin_family = AF_INET; 
	cliente.sin_port = htons(puerto);
	memmove((char *)&cliente.sin_addr.s_addr,(char *)servidor->h_addr,sizeof(servidor->h_length));//copia el segundo elemento en el primero con el largo del tercero

	if(connect(skC,(struct sockaddr *)&cliente, sizeof(cliente)) < 0)
	{ //verifica si conecta con el servidor
		printf("Error al conectar con el servidor.\n");
		close(skC);
		return 1;
	}

	if (setsockopt (skC, SOL_SOCKET, SO_RCVTIMEO, (char *)&timeout,sizeof(timeout)) < 0)
	{
		perror("setsockopt failed\n");
	}

	send(skC, nombre, strlen(nombre), 0);

	system("clear");


///Sockets
///////////////////////////////////////////////////////////////////////
///Transceivers

	puerto_serial = open("/dev/ttyUSB0", O_RDWR);  // /dev/ttyS0
	ndfs = puerto_serial + 1;
	
	//////preparing select()
	FD_ZERO(&all_set);
	FD_SET(skC,&all_set);
	FD_SET(puerto_serial, &all_set);
	r_set = all_set;
	tv.tv_sec = 1; 
	tv.tv_usec = 0;
	
	struct termios tty;

	// Read in existing settings, and handle any error
	if(tcgetattr(puerto_serial, &tty) != 0) {
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

	cfsetispeed(&tty, B19200);
	cfsetospeed(&tty, B19200);


	if (tcsetattr(puerto_serial, TCSANOW, &tty) != 0) {
		printf("Error %i from tcsetattr: %s\n", errno, strerror(errno));
	}
	
    int parche = 0;
	while(1)
	{
		r_set = all_set;
        tv.tv_sec = 10;

		select(ndfs, &r_set, NULL, NULL, &tv);
		
		if(FD_ISSET(skC, &r_set))
		{
			memset(bufferMsj, '\0', sizeof(bufferMsj));
			memset(bufferdos, '\0', sizeof(bufferdos));
			memset(buffertres, '\0', sizeof(buffertres));
		    int receive;
		    while(((receive = recv(skC, bufferdos, sizeof bufferdos, 0))>0)&&(parche==0))
		    {
		    	if (!(strcmp(bufferdos,"rimg")))
		    	{
		    		//printf("%s\n", bufferdos);
		    		parche = 1;
				    strcat(bufferMsj, bufferdos);
		    		break;
		    	}
			    strcat(bufferMsj, bufferdos);
    			//bufferMsj[strcspn(bufferMsj, "\n")] = 0;
    			//printf("%s\n", bufferMsj );
    		}
    		
			memset(bufferdos, '\0', sizeof(bufferdos));
			memset(buffertres, '\0', sizeof(buffertres));
    		printf("%s",bufferMsj);
    		int recibidos = strlen(bufferMsj);
    		if ((strcmp(bufferMsj,"rimg")))
		    {
		    	if(bufferMsj[recibidos - 1]=='\n')
		    	{
					bufferMsj[recibidos - 1]='\0';
		    	}
				recibidos = strlen(bufferMsj);
			}
    		//printf("bufferMsj %s\n", bufferMsj );
    		//printf("receive => %i con bufferMsj => %i\n", receive, bufferMsj[0]);
	    	if (receive == 0)
	        {
	        	printf("Se ha desconectado el servidor, cerrando...\n");
	        	close(skC);
	        	close(puerto_serial);
	        	break;
	        }

	        if (bufferMsj[0] == 0)
	        {
	        	//printf("goto exitdos\n");
	        	goto exitdos;
	        }

	        if (!(strcmp(bufferMsj,"rimg")))
	        {
	        	printf("Preparando para enviar imagen...\n");
	        	FILE *fp = fopen("temp", "wb");

	            int total = 0;
	            int rcv = 0;
				unsigned int size_img = 0;

	            memset(bufferMsj, '\0', sizeof(bufferMsj));
	            //memset(bufferdos, '\0', sizeof(bufferdos));
				//recv(skC, bufferdos, sizeof(bufferdos), 0);//esto vacía basura del buffer
	            //printf("%s\n",bufferdos );
	            memset(bufferdos, '\0', sizeof(bufferdos));
				while(recv(skC, &size_img, sizeof(int), 0))
	            {
	              if (size_img>0)
	              {
	                break;
	              }
	            }
				printf("La imagen tiene un tamaño de %i bytes.\n", size_img);

	            while((rcv = recv(skC, bufferdos, 1,0)) > 0)
	            {
	              total += rcv;
	              fwrite(bufferdos, 1, rcv, fp);
	              if (total == size_img)
	              {
	              	break;
	              }
	            }
	            
	            fclose(fp);
	            memset(bufferdos, '\0', sizeof(bufferdos));
	            memset(bufferMsj, '\0', sizeof(bufferMsj));
	            bufferMsj[0] = '|';
	            recibidos  = strlen (bufferMsj);

	        }
        	while(1)
        	{
		        TamMsj = write(puerto_serial,header,strlen(header));
				totalData+=TamMsj;
				r_set = all_set;
				tv.tv_sec = 2; 
				if(select(ndfs, &r_set, NULL, NULL, &tv)==0){
					sumador++;
					error+=TamMsj;
					printf("Intentado reconectar.\n");
					if(sumador == 3){
						sumador = 0;
						printf("ERROR. No se ha podido establecer la conexión mediante los transceivers...\n");
						
						goto exit;
					}
					continue;
				}
                sumador = 0;
                break;
		
			}


           	memset(bufferConfirmador,'\0',sizeof bufferConfirmador);
            printf("\nIniciando el protocolo...\nConfirmando la conexión...\n\n");	
            int bytesConfirmador = read(puerto_serial, &bufferConfirmador, sizeof(bufferConfirmador));
			//system("clear");
            //printf("bufferConfirmador: %s\n", bufferConfirmador );
			
            if(!(strcmp(msjconfg, bufferConfirmador)))
            {
                printf("Conexión confirmada...\nLa conexión se ha establecido correctamente...\n");
				char sizeMSJ[10];
				//receive = receive - 1;
				printf("%i\n",recibidos );
				sprintf(sizeMSJ,"%d", recibidos);

				sentData = write(puerto_serial, sizeMSJ, strlen(sizeMSJ));
				
				sleep(1);

				int cantidad = 0;
				char seg[21];
				memset(seg,'\0', sizeof(seg));

            	while(1)
            	{
            		
            		while(cantidad<recibidos)
            		{
            			memcpy(seg, bufferMsj + cantidad, 20);
			        	//printf("%s\n",seg );
			        	TamMsj = write(puerto_serial,seg,strlen(seg));
			        	cantidad = cantidad + TamMsj;
			        	totalData+=TamMsj;
			        	usleep(100000);
					}
					cantidad = 0;
					printf("\nEl mensaje a enviar es: %s \nCon un tamaño de: %d bytes\n",bufferMsj,recibidos);
					r_set = all_set;
					tv.tv_sec = 2;
					if(select(ndfs, &r_set, NULL, NULL, &tv)==0)
					{
						sumador ++;
						error+=TamMsj;
						printf("Intentado reconectar.\n");
						if(sumador == 3){
							sumador = 0;
							printf("ERROR. No se ha podido establecer la conexión mediante los transceivers...\n");
							goto exit;
						}
						continue;
					}

    				printf("\nEnviando mensaje...\n\n");
                    sumador = 0;
		
					memset(bufferMensaje,'\0',sizeof bufferMensaje);


					while(cantidad<recibidos)
					{
						//printf("%i < %i \n", cantidad, recibidos);
						memset(seg,'\0', sizeof(seg));
						bytesConfirmador = read(puerto_serial, seg, sizeof(seg));
						cantidad = cantidad + bytesConfirmador;
						strcat(bufferMensaje, seg);
					}
		            printf("Comparando => ");

					usleep(10000);

                    if (!(strcmp(bufferMensaje, bufferMsj))){
                        sentData = write(puerto_serial, "1", 2);
                        printf("%s = %s => Correcto\n", bufferMensaje, bufferMsj);

                    }
                    else{
                        sentData = write(puerto_serial, "0", 2);
                        printf("%s != %s => Incorrecto!\n\nReenviando...\n", bufferMensaje, bufferMsj);
                        numEnvios++;
                        if(numEnvios == 3){
                            printf("Maximo de reintentos alcanzado...\nTerminando protocolo...\n");
                    		numEnvios = 0;
                            goto exit;
                        }        
                        continue;
                    }
                    
                    break;
			
				}
				
				//printf("%s\n", bufferMsj );
					
				if(bufferMsj[0] == '|')
				{
					memset(bufferMsj,'\0',sizeof(bufferMsj));
					
					printf("\nEnviando imagen...\n\n");
					
					FILE *fp = fopen("temp", "rb");
					if(fp == NULL)
					{
						perror("File");
					}
					int size=0;
					fseek(fp,0,SEEK_END);
					size = ftell(fp);
					usleep(1000000);
					write(puerto_serial,&size,sizeof(int));
					fseek(fp,0,SEEK_SET);
					total = 0;
					sumador = 0;

					//read(puerto_serial,bufferEntrante,sizeof(bufferEntrante));
					//printf("aqui %s\n", bufferEntrante );
					unsigned char buffer[20];
					memset(buffer,'\0',sizeof(buffer));
					memset(bufferImg,'\0',sizeof(bufferImg));
					memset(percentajebar,'\0',sizeof(percentajebar));
					
					while( (n = fread(bufferImg, 1, sizeof bufferImg, fp)) > 0 )
					{ 					
						while(1)
						{
							writeC=write(puerto_serial, bufferImg,n);
							totalData+=writeC;
							r_set = all_set;
							tv.tv_sec = 2; 
							if(select(ndfs, &r_set, NULL, NULL, &tv) == 0){
								error+=writeC;
								sumador++;
								printf("Intentado reconectar...\n");
								if(sumador == 10){
									sumador = 0;
									printf("Máximo de reintentos alcanzado...\n Cerrando conexión...\n\n");
									fclose(fp);
									goto exit;
								}
								continue;
							}
							sumador=0;
							
							readC=read(puerto_serial,buffer,n);
							
							if(memcmp(bufferImg,buffer,n) == 0){
								
								sentData = write(puerto_serial,"1",3);
								break;
							}
							sentData += write(puerto_serial,"N",3);
							error += readC;

							printf("Paquete Incorrecto. Reintentando.\n");
							perdido++;
							if (perdido==20)
							{
								perdido=0;
								fclose(fp);
								printf("Error. Conexión perdida\n");
								goto exitdos;
							}
							
						}
						total = total + n;
	                    multiplodecien = (float)total/size * 100;

						if (((int)multiplodecien%10)!=pasado & ((int)multiplodecien%10)==0)
						{
							strcat(percentajebar," ");
						}

						pasado = ((int)multiplodecien)%10;
						printf("%23s Bytes recibidos: %d\r"," ",total);
						printf("%14s %3.2f %% \r","]", multiplodecien);
						printf(" [\033[%dm %s\033[m\r", 42, percentajebar);

				        fflush(stdout);
					}
					
					printf("\n\nTotal de bytes enviados: %d\n", total);
					
			    	memset(percentajebar, '\0', sizeof(percentajebar));
			    	pasado = 0;
					if(fclose(fp))
					{
						printf("Error closing the file\n");	
					}
					remove("temp");
					
					printf("\nImagen enviada.\n");

					parche = 0;

				}

                printf("\nProtocolo de finalizacion enviado correctamente.\n");
                usleep(500000);
                write(puerto_serial, final, sizeof(final)); 
				//usleep(500000);

			}
			else
			{
				printf("Confirmación Incorrecta...");
			}

			exit:
			printf("\nConexión finalizada.\n\nEscriba un mensaje para enviar...\n");
			FD_CLR(puerto_serial, &r_set);
			FD_CLR(skC,&r_set);
		}//close if(FD_ISSET(STDIN_FILENO, &r_set))

		if(FD_ISSET(puerto_serial, &r_set))
		{
			memset(bufferEntrante, '\0', sizeof(bufferEntrante));
			numBytes = read(puerto_serial, &bufferEntrante, sizeof(bufferEntrante));

            printf("bufferEntrante: %s\n", bufferEntrante );
			if(!(strcmp(bufferEntrante, header)))
			{
		
				int cont_numReEnvios = 0;
				//system("clear");
				printf("\nIniciando el protocolo...\nConfirmando la conexión...\n\n");
				sleep(1);
				write(puerto_serial, msjconfg, strlen(msjconfg)+1);
				printf("Conexión confirmada...\nLa conexión se ha establecido correctamente...\n");

				memset(bufferEntrante, '\0', sizeof(bufferEntrante));
				read(puerto_serial, bufferEntrante, sizeof(bufferEntrante));
				int tamMSJ = atoi(bufferEntrante);
				
				int cant = 0;
				char seg[100];
				memset(bufferEntrante, '\0', sizeof(bufferEntrante));

				int correcto = 0;

				do{
					while(1)
					{
						r_set = all_set;
						tv.tv_sec = 2; 
						if(select(ndfs, &r_set, NULL, NULL, &tv) == 0)
						{	
							sumador++;
							printf("Intentado reconectar...\n");
							if(sumador == 3)
							{
								sumador = 0;
								printf("Tercer reintento fallido...\n Cerrando conexión...\n");
								memset(bufferEntrante, '\0', sizeof(bufferEntrante));
								goto exitdos;
							}
							continue;
						}
						else
						{
							sumador = 0;

							while(cant<tamMSJ)
							{
								memset(seg,'\0', sizeof(seg));
								numBytes = read(puerto_serial,seg,sizeof(seg));
								cant = cant + numBytes;
								strcat(bufferEntrante, seg);
							}
							cant = 0;
							printf("\nEl mensaje recibido es: ''%s'' de %i bytes. ",bufferEntrante,numBytes);
							break;
						}
					}

					TamMsj = 0;

					while(cant<tamMSJ)
					{
						memcpy(seg, bufferEntrante + cant, 20);
						TamMsj = write(puerto_serial, seg,strlen(seg));
						cant = cant + TamMsj;
						usleep(100000);
					}
					totalData += cant;
					
					read(puerto_serial, botones, sizeof(botones));

					if (botones[0] == '0')
					{ 
						numEnvios++;
						error+=cant;
						if(numEnvios == 3){ 		
							printf("Maximo de reintentos alcanzado...\nCerrando conexión...\n");
							numEnvios = 0;
							goto exitdos;					
						}

						printf("\nMensaje erroneo...\n\n");
						correcto = 0;
					}
					correcto = 1;
				} while(correcto == 0);
				
				printf("%s => Correcto\n\n", bufferEntrante);

				if(bufferEntrante[0]=='|')
				{
			    	memset(percentajebar, '\0', sizeof(percentajebar));
					memset(bufferEntrante,'\0',sizeof bufferEntrante);
           			printf("Creando la imagen entrante...\n\n");

					read(puerto_serial, &sizeImg,sizeof(int));

					//printf("%i\n", sizeImg );

					//write(puerto_serial,'\0',2);
					FILE* fp = fopen( "temp2", "wb");
					int tot=0;
					int a;
					perdido = 0;
					if(fp != NULL)
					{
				
						while(tot < sizeImg) 
						{ 
							
							while(1)
							{
								r_set = all_set;
								tv.tv_sec = 2; 
								if(select(ndfs, &r_set, NULL, NULL, &tv)==0)
								{
									sumador++;
									printf("Intentado reconectar...\n");
									if(sumador == 10)
									{
										sumador = 0;
										printf("Máximo de reintentos alcanzado...\n Cerrando conexión...\n\n");
										fclose(fp);
										goto exitdos;
									}
									continue;
								}
								sumador = 0;
								a = read(puerto_serial, botones, sizeof(botones));
								writeC = write(puerto_serial, botones, a);
								
								r_set = all_set;
								tv.tv_usec = 10000;
								if(select(ndfs, &r_set, NULL, NULL, &tv)==0){
									continue;
								}

								read(puerto_serial, banner, sizeof(banner));

								totalData+=writeC;

								if(banner[0]=='1')
								{
									break;
								}

								error+=writeC;

								perdido++;
								printf("Paquete Incorrecto. Reintentando\n");
								if (perdido==20)
								{
									perdido = 0;
									fclose(fp);
									printf("Error. Conexión perdida.\n");
									goto exitdos;
								}
								printf("Paquete Incorrecto. Reintentando.\n");				
							}
							tot+=a;
							multiplodecien = (float)tot/sizeImg *100;

							if (((int)multiplodecien%10)!=pasado & ((int)multiplodecien%10)==0)
							{
								strcat(percentajebar," ");
							}

							pasado = ((int)multiplodecien)%10;
							printf("%23s Bytes recibidos: %d\r"," ",tot);
							printf("%14s %3.2f %% \r","]", multiplodecien);
							printf(" [\033[%dm %s\033[m\r", 42, percentajebar);

					        fflush(stdout);
							fwrite(botones, 1, a, fp);
						}
				    	memset(percentajebar, '\0', sizeof(percentajebar));
				    	pasado = 0;

						printf("\n\nLa imagen recibida es de %i bytes.\n",sizeImg);
						if(fclose(fp)!=0){
							printf("Error closing the file\n");
						}
        			    printf("\nImagen creada.\n\n");

        			    printf("Enviando imagen por sockets...\n");

						send(skC, "rimg", LARGO, 0);
						enviadorjpg();
						parche = 0;
					}
					else
					{
						perror("File");
					}
				}
				else
				{

					sprintf(bufferdos, "%s", bufferEntrante);
					printf("Enviando %s por socket...\n", bufferdos );
					send(skC, bufferdos, sizeof(bufferdos), 0);
				}

				sumador = 0;

				printf("Iniciando protocolo de salida.\n");
				memset(bufferEntrante, '\0', sizeof(bufferEntrante));
				
				while(1)
				{
					r_set = all_set;
					tv.tv_sec = 2; 
					if(select(ndfs, &r_set, NULL, NULL, &tv)==0)
					{
						sumador++;
						printf("Intentado reconectar...\n");
						if(sumador == 3)
						{
							sumador = 0;
							printf("Máximo de reintentos alcanzado...\n Cerrando conexión...\n\n");
							goto exitdos;
						}
						continue;
					}
					else
					{
						sumador = 0;
						numBytes = read(puerto_serial, bufferEntrante, sizeof(bufferEntrante));
						if(!(strcmp(bufferEntrante, final)))
						{
							printf("Protocolo de finalizacion recibido correctamente.\n");
							printf("\nConexión finalizada.\n\nEscriba un mensaje para enviar...\n");
							parche = 0;
							break;
						}
						else
						{
							printf("Protocolo de finalizacion recibido incorrectamente.\n\n");
							printf("\nConexión finalizada.\n\nEscriba un mensaje para enviar...\n");
							parche = 0;
						}
					}
					break;
				}
			}
			exitdos:
			FD_CLR(puerto_serial, &r_set);
			FD_CLR(skC, &r_set);
			printf("\r");
			memset(bufferEntrante,'\0', sizeof(bufferEntrante));
		}
	}
}



void enviadorjpg()
{
  int n = 0, total = 0, pasado = 0;
  char sendbuffer[100], percentajebar[10]; 
  FILE *fp = fopen("temp2","rb");
  if(fp == NULL){
      printf("NO se pudo abrir el archivo. \n");
      return;
  }
  fseek(fp,0L,SEEK_END);
  unsigned int size = ftell(fp);
  fseek(fp,0L,SEEK_SET);

  send(skC, &size, sizeof(unsigned int), 0); //envio
  memset(sendbuffer, '\0', sizeof(sendbuffer));

  while((n = fread(sendbuffer, 1,1,fp)) > 0)
  {
    //printf("%s\n", sendbuffer);
    send(skC, sendbuffer, n, 0);
    total += n;
    multiplodecien = ((float)total/size) * 100;

    if (((int)multiplodecien%10)!=pasado & ((int)multiplodecien%10) == 0)
    {
      strcat(percentajebar," ");
    }

    pasado = ((int)multiplodecien)%10;
    printf("%23s Bytes enviados: %d\r"," ",total);
    printf("%14s %3.2f %% \r","]", multiplodecien);
    printf(" [\033[%dm %s\033[m\r", 42, percentajebar);

    fflush(stdout);
  }

  printf("\nTotal de bytes enviados: %d\n", total);
  memset(percentajebar, '\0', sizeof(percentajebar));
  pasado = 0;
  memset(sendbuffer, '\0', sizeof(sendbuffer));

  fclose(fp);
  remove("temp2");

  printf("Imagen enviada.\n");
  return;
}