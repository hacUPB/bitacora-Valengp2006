### Actividad 1 - 28/07/2025

#### ¿Qué es la entrada-salida mapeada a memoria?

La entrada/salida mapeada a memoria (*memory-mapped I/O*) es un mecanismo mediante el cual los dispositivos de entrada y salida (como la pantalla o el teclado) están conectados a ubicaciones específicas en la memoria RAM. En lugar de tener instrucciones especiales para interactuar con estos dispositivos, se accede a ellos como si fueran posiciones de memoria normales. Es decir, escribir o leer en ciertas direcciones de la RAM tiene como efecto escribir o leer en dispositivos físicos.


#### ¿Cómo se implementa en la plataforma Hack?

En la arquitectura Hack, la entrada/salida mapeada a memoria se implementa mediante dos áreas especiales de la RAM:

- `SCREEN` (desde la dirección `16384` hasta `24575`): está conectada a la pantalla. Cada celda representa 16 píxeles horizontales. Al escribir valores binarios en esta área, se encienden o apagan píxeles en la pantalla.
- `KBD` (en la dirección `24576`): está conectada al teclado. Esta celda contiene el código ASCII de la tecla actualmente presionada. Si no hay ninguna tecla presionada, contiene el valor `0`.

Gracias a esta implementación, un programa puede dibujar en pantalla o responder a teclas leyendo y escribiendo en esas posiciones de memoria.


#### Programa que usa entrada-salida mapeada a memoria

```asm
// Si se presiona la tecla 'd', encender la esquina superior izquierda de la pantalla
@KBD
D=M
@100
D=D-A     // D = KBD - 100
@DRAW
D;JEQ     // Si es igual a 'd' (ASCII 100), salta a DRAW
@END
0;JMP

(DRAW)
@16384    // Dirección base de SCREEN
M=-1      // Enciende los primeros 16 píxeles (todos en 1)
(END)
@END
0;JMP     // Bucle infinito para terminar
```

### Funcionamiento del programa en el simulador

	1.	El programa lee el valor del teclado (KBD).
	2.	Si se presiona la tecla 'd', su código ASCII es 100, por lo que la condición D;JEQ se cumple.
	3.	Se salta a la etiqueta (DRAW) donde se escribe -1 en la dirección 16384 de la RAM, lo que enciende los primeros 16 píxeles de la pantalla.
	4.	Si no se presiona la tecla 'd', no se ejecuta el bloque de dibujo, y el programa entra directamente en el bucle (END).