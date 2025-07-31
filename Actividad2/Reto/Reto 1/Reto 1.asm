@i
M=1         // i = 1

@sum
M=0         // sum = 0

(LOOP)
@i
D=M
@101
D=D-A
@END
D;JGE       // Si i >= 101, salir del ciclo

@i
D=M
@sum
M=M+D       // sum += i

@i
M=M+1       // i++

@LOOP
0;JMP       // Repetir el ciclo

(END)
@END
0;JMP       // Fin del programa