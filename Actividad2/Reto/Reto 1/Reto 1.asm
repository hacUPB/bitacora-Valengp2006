// Inicializar i = 1
@1
D=A
@20     // i en RAM[20]
M=D

// Inicializar sum = 0
@0
D=A
@22     // sum en RAM[22]
M=D

(LOOP)
@20     // i
D=M
@101
D=D-A
@END
D;JGE   // Si i > 100, terminar

// sum = sum + i
@22
D=M     // D = sum
@20
D=D+M   // D = sum + i
@22
M=D     // guardar en sum

// i++
@20
M=M+1

@LOOP
0;JMP

(END)
@END
0;JMP