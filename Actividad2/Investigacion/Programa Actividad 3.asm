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