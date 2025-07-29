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

	1.	El programa lee el valor del teclado (KBD).
	2.	Si se presiona la tecla 'a', su código ASCII es 97, por lo que la condición D;JEQ se cumple.
	3.	Se salta a la etiqueta (DRAW) donde se escribe -1 en la dirección 16384 de la RAM, lo que enciende los primeros 16 píxeles de la pantalla.
	4.	Si no se presiona la tecla 'a', no se ejecuta el bloque de dibujo, y el programa entra directamente en el bucle (END).

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

// BUCLE PRINCIPAL
(LOOP)
    @KBD
    D=M        // Leer tecla presionada
    @NO_KEY
    D;JEQ      // Si no hay tecla presionada, ir a NO_KEY

    @100
    D=D-A      // Comparar tecla con ASCII 100 ('d')
    @DRAW
    D;JEQ      // Si es igual, ir a rutina de dibujo

    @CLEAR
    0;JMP      // Si no es 'd', ir a limpiar pantalla

(NO_KEY)
    @LOOP
    0;JMP      // Volver al inicio


// SUBRUTINA PARA BORRAR PANTALLA (LIMPIAR SCREEN)
(CLEAR)
    @R0
    M=0           // Contador en R0
(CLEAR_LOOP)
    @R0
    D=M
    @8192         // SCREEN tiene 8192 palabras (32*256 bits)
    D=D-A
    @AFTER_CLEAR
    D;JGE

    @SCREEN
    A=A+R0        // Dirección actual en SCREEN
    M=0           // Limpiar pixel

    @R0
    M=M+1         // Incrementar contador
    @CLEAR_LOOP
    0;JMP

(AFTER_CLEAR)
    @LOOP
    0;JMP         // Volver al inicio


// SUBRUTINA PARA MOSTRAR EL DIBUJO DEL GATO
(DRAW)

   @SCREEN
	D=A
	@R12
	AD=D+M
	// row 5
	@260 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 6
	D=A // D holds previous addr
	@32
	AD=D+A
	@396 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 7
	D=A // D holds previous addr
	@32
	AD=D+A
	@508 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 8
	D=A // D holds previous addr
	@32
	AD=D+A
	@1022 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 9
	D=A // D holds previous addr
	@32
	AD=D+A
	@1022 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 10
	D=A // D holds previous addr
	@32
	AD=D+A
	@508 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 11
	D=A // D holds previous addr
	@32
	AD=D+A
	@248 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 12
	D=A // D holds previous addr
	@32
	AD=D+A
	@508 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 13
	D=A // D holds previous addr
	@32
	AD=D+A
	@1022 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 14
	D=A // D holds previous addr
	@32
	AD=D+A
	@1022 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 15
	D=A // D holds previous addr
	@32
	AD=D+A
	@2047 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 16
	D=A // D holds previous addr
	@32
	AD=D+A
	@2047 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 17
	D=A // D holds previous addr
	@32
	AD=D+A
	@1022 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 18
	D=A // D holds previous addr
	@32
	AD=D+A
	@508 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 19
	D=A // D holds previous addr
	@32
	AD=D+A
	@248 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 20
	D=A // D holds previous addr
	@32
	AD=D+A
	@96 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 21
	D=A // D holds previous addr
	@32
	AD=D+A
	@96 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 22
	D=A // D holds previous addr
	@32
	AD=D+A
	@96 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 23
	D=A // D holds previous addr
	@32
	AD=D+A
	@32 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 24
	D=A // D holds previous addr
	@32
	AD=D+A
	@48 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 25
	D=A // D holds previous addr
	@32
	AD=D+A
	@48 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 26
	D=A // D holds previous addr
	@32
	AD=D+A
	@16 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 27
	D=A // D holds previous addr
	@32
	AD=D+A
	@48 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 28
	D=A // D holds previous addr
	@32
	AD=D+A
	@96 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// return
	@R13
	A=M
	D;JMP

    @LOOP  //sale del loop
    0;JMP
```