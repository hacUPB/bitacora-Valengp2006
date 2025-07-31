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