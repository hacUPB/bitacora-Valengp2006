//19. Analiza el siguiente programa en lenguaje de máquina:
    
    0100000000000000
    1110110000010000
    0000000000010000
    1110001100001000
    0110000000000000
    1111110000010000
    0000000000010011
    1110001100000101
    0000000000010000
    1111110000010000
    0100000000000000
    1110010011010000
    0000000000000100
    1110001100000110
    0000000000010000
    1111110010101000
    1110101010001000
    0000000000000100
    1110101010000111
    0000000000010000
    1111110000010000
    0110000000000000
    1110010011010000
    0000000000000100
    1110001100000011
    0000000000010000
    1111110000100000
    1110111010001000
    0000000000010000
    1111110111001000
    0000000000000100
    1110101010000111
    
    //- ¿Qué hace este programa?
    //Este programa pinta en pantalla (a partir de la dirección 16384) mientras no se presione ninguna tecla. Cuando se presiona una tecla, salta a una rutina alterna que intenta modificar datos, pero no realiza un borrado efectivo. El programa sigue ejecutándose en bucle.

    //20. Implementa un programa en lenguaje ensamblador que dibuje el bitmap que diseñaste en la pantalla solo si se presiona la tecla “d”.

    // Espera la tecla 'd' (ASCII 100)
    (ESPERAR)
    @KBD
    D=M
    @100        // ASCII de 'd'
    D=D-A
    @DIBUJAR
    D;JEQ
    @ESPERAR
    0;JMP

// Dibuja el gato en pantalla (pantalla inicia en RAM[16384])
    (DIBUJAR)
    @16384      // Dirección inicial de la pantalla
    D=A
    @R0
    M=D         // R0 = dirección actual en pantalla

// Línea 0: M=7182
    @R0
    A=M
    M=7182

// Línea 1
    @R0
    D=M
    @32
    D=D+A
    @R0
    M=D
    A=D
    M=15903

// Línea 2
    @R0
    D=M
    @32
    D=D+A
    @R0
    M=D
    A=D
    M=15903

// Línea 3
    @R0
    D=M
    @32
    D=D+A
    @R0
    M=D
    A=D
    M=7182

// Línea 4
    @R0
    D=M
    @32
    D=D+A
    @R0
    M=D
    A=D
    M=7182

// Línea 5
    @R0
    D=M
    @32
    D=D+A
    @R0
    M=D
    A=D
    M=15903

// Línea 6
    @R0
    D=M
    @32
    D=D+A
    @R0
    M=D
    A=D
    M=32575

// Línea 7
    @R0
    D=M
    @32
    D=D+A
    @R0
    M=D
    A=D
    M=15903

// Línea 8
    @R0
    D=M
    @32
    D=D+A
    @R0
    M=D
    A=D
    M=7182

// Línea 9
    @R0
    D=M
    @32
    D=D+A
    @R0
    M=D
    A=D
    M=7182

// Línea 10
    @R0
    D=M
    @32
    D=D+A
    @R0
    M=D
    A=D
    M=3078

// Línea 11
    @R0
    D=M
    @32
    D=D+A
    @R0
    M=D
    A=D
    M=3078

// Línea 12
    @R0
    D=M
    @32
    D=D+A
    @R0
    M=D
    A=D
    M=1539

// Línea 13
    @R0
    D=M
    @32
    D=D+A
    @R0
    M=D
    A=D
    M=769

// Línea 14
    @R0
    D=M
    @32
    D=D+A
    @R0
    M=D
    A=D
    M=256

// Bucle infinito para mantener pantalla
(LOOP)
    @LOOP
    0;JMP