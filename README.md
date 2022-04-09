# Sistemas empotrados heterogéneos

## ToDo KJiron
- [x] [environment](/asteroidsDBG.c)  
- [x] [time](/timerDBG.c) esta hecho por interrupción, hay que ver si da problema con el UART. Lo mejor sería implementar la función milis() para no tener 500ms quemados. 
- [x] [hit](/hit.h) se detecta colision con el player y se reinicia en su posicion inicial.
- [x] [moveAI](/hit.h) la AI no es la mejor del mundo pero funciona.
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
- [x] recv asteroides, [asteroidesMikroC](/asteroidsDBG.c) y [asteroidesLinux](/gameLinux/src/asteroids.c), esto funciona pero no es la forma ideal.
- [x] crear pseudo-aleatorio para replicar la misma serie en linux C y en el PIC
- [x] sincronizar tiempo para mover los asteroides, según el delay del PIC
- [x] agregar a los jugadores, enviados y recibidos
- [x] recv score
- [x] recv collision
- [x] se puede enviar cuando hay una tecla presionada en el teclado de la PC o RAS para dejar de estar intentado tener el mejor delay a punta de prueba y error
