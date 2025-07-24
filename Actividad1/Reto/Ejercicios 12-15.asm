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
    @ELSE
    D;JLT     // Si D < 0, ir a ELSE

    // THEN: R0 >= 0
    @1
    D=A
    @R1
    M=D
    @END
    0;JMP

    (ELSE)
    @-1
    D=A
    @R1
    M=D

    (END)
    (LOOP)
    @LOOP
    0;JMP
    
//14. Implementa en ensamblador:
    
    //R4 = RAM[R1]

    @R1
    A=M   
    D=M   
    @R4
    M=D
    
//15. Implementa en ensamblador el siguiente problema. 
//En la posición R0 está almacenada la dirección inicial de una región de memoria. En la posición R1 está almacenado el tamaño de la región de memoria. Almacena un -1 en esa región de memoria.

    (LOOP)
    @R1
    D=M
    @END
    D;JEQ      

    @R0
    A=M
    M=-1      

    @R0
    D=M
    @1
    D=D+A
    @R0
    M=D     

    @R1
    M=M-1        

    @LOOP
    0;JMP

    (END)