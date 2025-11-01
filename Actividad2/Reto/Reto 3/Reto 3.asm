// i = 1
@1
D=A
@20     // i en RAM[20]
M=D

// sum = 0
@0
D=A
@22     // sum en RAM[22]
M=D

(LOOP)
@20
D=M
@101
D=D-A
@END
D;JGE   // Si i > 100, salir del bucle

// sum = sum + i
@22
D=M
@20
D=D+M
@22
M=D

// i++
@20
M=M+1

@LOOP
0;JMP

(END)
@END
0;JMP