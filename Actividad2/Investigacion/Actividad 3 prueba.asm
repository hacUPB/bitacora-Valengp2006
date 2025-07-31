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