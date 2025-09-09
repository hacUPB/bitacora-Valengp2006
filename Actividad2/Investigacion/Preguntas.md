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
// Si se presiona la tecla 'a', encender la esquina superior izquierda de la pantalla
@KBD
D=M
@100
D=D-A     
@DRAW
D;JEQ     
@END
0;JMP

(DRAW)
@16384    
M=-1      
(END)
@END
0;JMP     
```

### Funcionamiento del programa en el simulador

1. El programa lee el valor del teclado (KBD).
2. Si se presiona la tecla 'a', su código ASCII es 97, por lo que la condición D;JEQ se cumple.
3. Se salta a la etiqueta (DRAW) donde se escribe -1 en la dirección 16384 de la RAM, lo que enciende los primeros 16 píxeles de la pantalla.
4. Si no se presiona la tecla 'a', no se ejecuta el bloque de dibujo, y el programa entra directamente en el bucle (END).

## Actividad 3:

Usar un if que detecte si se está presionando o no la tecla "d", si no esta presionada la tecla hacer que salte a una función que ponga todo en ceros (la imagen se ve en blanco);. si está presionada la tecla d, entonces muestra la pantalla con el dibujo.

#### Lógica del programa:

1. Verificar constantemente si se está presionando alguna tecla utilizando un bucle (`loop`).
2. Si no hay ninguna tecla presionada (`KBD = 0`), volver al inicio del bucle.
3. Si hay una tecla presionada, leer el valor de `KBD` y compararlo con el código ASCII de la tecla `'d'` (valor **100**).
4. Si el valor es igual a 100, saltar a la función (o subrutina) que dibuja la figura (escribiendo los valores del bitmap en la memoria de pantalla `SCREEN`, a partir de `RAM[16384]`).
5. Si el valor es distinto de 100, saltar a la subrutina que borra la pantalla (poniendo en 0 todas las líneas del dibujo).
6. Repetir el proceso en bucle para permitir que la imagen se muestre solo mientras se mantenga presionada la tecla `'d'`.

La dirección `KBD` permite detectar la tecla presionada, y `SCREEN` permite manipular directamente los píxeles visibles.

**Código**

```asm
// Programa en lenguaje ensamblador Hack
// Muestra el dibujo del gato si se presiona la tecla "d" (ASCII 100)
// De lo contrario, borra la pantalla

// Bucle principal que evalúa el teclado
(LOOP)
    @KBD
    D=M            // Leer la tecla presionada
    @CHECKD
    D;JGT          // Si alguna tecla fue presionada, ir a verificar

    @CLEAR
    0;JMP          // Si no hay tecla, limpiar pantalla

(CHECKD)
    @KBD
    D=M
    @100
    D=D-A          // Comparar con ASCII de 'd'
    @DRAW
    D;JEQ          // Si es igual, dibujar
    @CLEAR
    0;JMP          // Si no es 'd', limpiar

//Subrutina Borrar

(CLEAR)
    @R0
    M=0
(CLEAR_LOOP)
    @R0
    D=M
    @8192
    D=D-A
    @AFTER_CLEAR
    D;JGE

    @SCREEN
    D=A
    @R0
    A=D+M         // Dirección: SCREEN + i
    M=0           // Borrar pixel

    @R0
    M=M+1
    @CLEAR_LOOP
    0;JMP

(AFTER_CLEAR)
    @LOOP
    0;JMP

// SUBRUTINA PARA MOSTRAR EL DIBUJO DEL GATO
(DRAW)
    @SCREEN
    D=A
    @R12
    M=0
    AD=D+M         // Dirección inicial en SCREEN

    // Cada bloque representa una fila del dibujo (palabra de 16 bits)
    @260
    D=D+A
    A=D-A
    M=D-A

    D=A
    @32
    AD=D+A
    @396
    D=D+A
    A=D-A
    M=D-A

    D=A
    @32
    AD=D+A
    @508
    D=D+A
    A=D-A
    M=D-A

    D=A
    @32
    AD=D+A
    @1022
    D=D+A
    A=D-A
    M=D-A

    D=A
    @32
    AD=D+A
    @1022
    D=D+A
    A=D-A
    M=D-A

    D=A
    @32
    AD=D+A
    @508
    D=D+A
    A=D-A
    M=D-A

    D=A
    @32
    AD=D+A
    @248
    D=D+A
    A=D-A
    M=D-A

    D=A
    @32
    AD=D+A
    @508
    D=D+A
    A=D-A
    M=D-A

    D=A
    @32
    AD=D+A
    @1022
    D=D+A
    A=D-A
    M=D-A

    D=A
    @32
    AD=D+A
    @1022
    D=D+A
    A=D-A
    M=D-A

    D=A
    @32
    AD=D+A
    @2047
    D=D+A
    A=D-A
    M=D-A

    D=A
    @32
    AD=D+A
    @2047
    D=D+A
    A=D-A
    M=D-A

    D=A
    @32
    AD=D+A
    @1022
    D=D+A
    A=D-A
    M=D-A

    D=A
    @32
    AD=D+A
    @508
    D=D+A
    A=D-A
    M=D-A

    D=A
    @32
    AD=D+A
    @248
    D=D+A
    A=D-A
    M=D-A

    D=A
    @32
    AD=D+A
    @96
    D=D+A
    A=D-A
    M=D-A

    D=A
    @32
    AD=D+A
    @96
    D=D+A
    A=D-A
    M=D-A

    D=A
    @32
    AD=D+A
    @96
    D=D+A
    A=D-A
    M=D-A

    D=A
    @32
    AD=D+A
    @32
    D=D+A
    A=D-A
    M=D-A

    D=A
    @32
    AD=D+A
    @48
    D=D+A
    A=D-A
    M=D-A

    D=A
    @32
    AD=D+A
    @48
    D=D+A
    A=D-A
    M=D-A

    D=A
    @32
    AD=D+A
    @16
    D=D+A
    A=D-A
    M=D-A

    D=A
    @32
    AD=D+A
    @48
    D=D+A
    A=D-A
    M=D-A

    D=A
    @32
    AD=D+A
    @96
    D=D+A
    A=D-A
    M=D-A

    @R13
    A=M
    0;JMP
```
## Actividad 4:

En esta actividad se modificó el código para que ahora se ejecuten dos funciones diferentes dependiendo de la tecla presionada: si se detecta la tecla 'd', el programa llama la subrutina DRAW que pinta la imagen en pantalla. Si se detecta la tecla 'e', se llama la subrutina CLEAR que borra el contenido del SCREEN. A diferencia de la versión anterior, ya no se borra automáticamente al soltar la tecla 'd', sino que el borrado solo se ejecuta cuando el usuario presiona explícitamente la tecla 'e'.
