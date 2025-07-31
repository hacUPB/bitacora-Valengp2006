// Programa que muestra un dibujo si se presiona la tecla 'd', y lo borra si no.

// BUCLE PRINCIPAL: Evaluar si hay una tecla presionada
(MAIN_LOOP)
    @KBD
    D=M            // Leer valor de tecla
    @CHECK_KEY
    0;JMP          // Ir a evaluar qué tecla es

// VERIFICAR TECLA
(CHECK_KEY)
    D=M
    @100
    D=D-A
    @DRAW
    D;JEQ          // Si tecla == 100 ('d'), ir a dibujar

    @KBD
    D=M
    @NO_KEY
    D;JEQ          // Si tecla == 0, ir a borrar

    @MAIN_LOOP
    0;JMP          // Si es otra tecla, seguir evaluando

// SUBRUTINA: BORRAR PANTALLA
(NO_KEY)
    @R0
    M=0            // i = 0
(CLEAR_LOOP)
    @R0
    D=M
    @8192
    D=D-A
    @END_CLEAR
    D;JGE          // Si i >= 8192, terminar borrado

    @SCREEN
    A=A+R0         // A = SCREEN + i
    M=0            // Limpiar pixel

    @R0
    M=M+1          // i++
    @CLEAR_LOOP
    0;JMP

(END_CLEAR)
    @MAIN_LOOP
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