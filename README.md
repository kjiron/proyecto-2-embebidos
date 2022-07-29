# Sistemas empotrados heterogéneos

Este proyecto consiste en el desarrollo de un juego llamado space race, puede ver el original [aquí](https://www.youtube.com/watch?v=0eBUoY6W8BY). La idea es lograr la comunicación entre sistemas heterogéneos, como es el caso de PIC8, Raspberry Pi y Linux. Este proyecto permite la comunicación entre estas plataformas para poder jugar en el modo de dos jugadores, por medio del protocolo UART. Este se desarrolló en la placa de desarrollo de [MikroE easypic](https://www.mikroe.com/easypic-dspic30).


## ToDo KJiron
- [x] [environment](/backup/PIC/asteroidsDBG.c)  
- [x] [time](/backup/PIC/timerDBG.c) esta hecho por interrupción, hay que ver si da problema con el UART. Lo mejor sería implementar la función milis() para no tener 500ms quemados. 
- [x] [hit](/backup/PIC/Include/hit.h) se detecta colision con el player y se reinicia en su posicion inicial.
- [x] [moveAI](/backup/PIC/Include/hit.h) la AI no es la mejor del mundo pero funciona.
- [x] recv posicion
- [x] enviar por Uart posicion
- [x] sincronizar, hay un pequeño bug, el cual es que muetra el player que lee por UART solo hasta que del otro lado se hizo un movimiento con el teclado.
- [x] read another key

## ToDo RBrenes

- [x] dibujar/mover pixel en GLCD
- [x] dibujar/mover pixel en SDL
- [x] mover pixel de placa desde PC
- [x] mover pixel de PC desde placa
- [x] Traducir las imagenes del SpaceRace a SDL2 en 1280x640
- [x] Traducir las funciones de PIC a SDL
- [x] Implementar el modo de Single Player a SDL2.


## ToDo General

- [x] recv time
- [x] recv asteroides, [asteroidesMikroC](/backup/asteroidsDBG.c) y [asteroidesLinux](/backup/gameLinux/src/asteroids.c), esto funciona pero no es la forma ideal.
- [x] crear pseudo-aleatorio para replicar la misma serie en linux C y en el PIC
- [x] sincronizar tiempo para mover los asteroides, según el delay del PIC
- [x] agregar a los jugadores, enviados y recibidos
- [x] recv score
- [x] recv collision
- [x] se puede enviar cuando hay una tecla presionada en el teclado de la PC o RAS para dejar de estar intentado tener el mejor delay a punta de prueba y error


## Aclaraciones Finales

- Al final del proyecto se concentró toda la programación de sistemas Unix en un solo código [SpaceRaceSDL-Unix](/Final/SpaceRaceSDL-Unix) con la forma de ejecución "make" para compilar y "make run slave=y/n" para ejecutar el juego en modo esclavo/maestro segun slave=y o slave=n respectivamente.
- Se separaron las programaciones finales del [PIC](/Final/PIC) y [Unix](/Final/SpaceRaceSDL-Unix) en la carpeta [Final](/Final) y se guardaron las demás programaciones del proceso de creacion del proyecto dentro de la carpeta [backup](/backup)
- Ya se probó exitosamente los casos PC-PIC, Ras-PIC y PC-Ras ejecutando para todos los casos las condiciones donde el jugador gana, el jugador pierde y el jugador empata, todas las condiciones en una misma partida sin reiniciar la programación.
