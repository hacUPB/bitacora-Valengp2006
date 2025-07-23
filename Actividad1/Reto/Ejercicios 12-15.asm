//12. Implemente en ensamblador:

    //R4 = R1 + R2 + 69

    @R1
    D=M
    @R2
    D=D+M
    @69
    D=D+A
    @R4
    M=D
    
//13. Implemente en ensamblador:
    
    //if R0 >= 0 then R1 = 1
    //else R1 = –1
    
    //(LOOP)
    //goto LOOP

    @R0
    D=M
    @0
    D=D-A
    @R1
    D;JGE
    @-1
    D=A
    @R1
    M=D
    @1
    D=A
    @R1
    M=D
    @LOOP
    0;JMP
    
//14. Implementa en ensamblador:
    
    //R4 = RAM[R1]

    @R1
    D=M
    @R4
    M=D
    
//15. Implementa en ensamblador el siguiente problema. 
//En la posición R0 está almacenada la dirección inicial de una región de memoria. En la posición R1 está almacenado el tamaño de la región de memoria. Almacena un -1 en esa región de memoria.

    @R0
    D=M
    @R1
    D=D+A
    @R2
    M=D
    (LOOP)
    @R0
    D=M
    @-1
    D=A
    @R2
    M=D
    @R0
    D=M+1
    @R0
    M=D
    @R1
    D=M-1
    @R1
    M=D
    @LOOP
    0;JMP