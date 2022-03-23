# Sistemas empotrados heterogéneos

## ToDo KJiron
- [x] [environment](/asteroidsDBG.c)  
- [x] [time](/timerDBG.c) esta hecho por interrupción, hay que ver si da problema con el UART. Lo mejor sería implementar la función milis() para no tener 500ms quemados. 
- [x] [hit](/hit.h) se detecta colision con el player y se reinicia en su posicion inicial.
- [x] [moveAI](/hit.h) la AI no es la mejor del mundo pero funciona.
- [x] recv posicion
- [] recv time
- [] recv score
- [] recv collision
- [x] enviar por Uart posicion
- [x] sincronizar, hay un pequeño bug, el cual es que muetra el player que lee por UART solo hasta que del otro lado se hizo un movimiento con el teclado.
- [x] read another key

## ToDo RBrenes

- [x] dibujar/mover pixel en GLCD
- [x] dibujar/mover pixel en SDL
- [x] mover pixel de placa desde PC
- [x] mover pixel de PC desde placa
- [x] Traducir las imagenes del SpaceRace a SDL2 en 1280x640
- [] Traducir las funciones de PIC a SDL
- [] Implementar el modo de Single Player a SDL2.
