// Main
@6
D=A
@R0
M=D        // a = 6

@9
D=A
@R1
M=D        // b = 9

@SUMA
0;JMP      // saltar a la función

(RET)
@R2
D=M
@R3
M=D        // guardar resultado en c

// Suma
(SUMA)
    @R0
    D=M
    @R1
    D=D+M
    @R2
    M=D
    @RET       // SALTO FIJO
    0;JMP
