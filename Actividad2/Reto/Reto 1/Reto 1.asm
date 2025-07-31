// Inicializar i = 1
@1
D=A
@i
M=D

// Inicializar sum = 0
@sum
M=0

// Etiqueta del ciclo
(LOOP)
    @i
    D=M
    @101      // Si i > 100, salir del ciclo
    D=D-A
    @END
    D;JGE

    // sum = sum + i
    @i
    D=M
    @sum
    M=D+M     // ← Aquí estaba el error, corregido a D+M

    // i++
    @i
    M=M+1

    @LOOP
    0;JMP

(END)
    @END
    0;JMP

// Variables (puedes reservarlas en RAM manualmente si quieres)
(i)   // Variable i
(sum) // Variable sum