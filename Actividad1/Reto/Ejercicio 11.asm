//11. Considera el siguiente programa:
    
    i=1000
    LOOP:
    if(i==0) goto CONT
    i=i-1
    goto LOOP
    CONT:
    
    //La traducción a lenguaje ensamblador del programa anterior es:
    
    // i = 1000
    @1000
    D=A
    @i
    M=D
    (LOOP)
    // if (i == 0) goto CONT
    @i
    D=M
    @CONT
    D;JEQ
    // i = i - 1
    @i
    M=M-1
    // goto LOOP
    @LOOP
    0;JMP
    (CONT)
    
    //a) ¿Qué hace este programa?
    //b) ¿En qué memoria está almacenada la variable i? ¿En qué dirección de esa memoria?
    //c) ¿En qué memoria y en qué dirección de memoria está almacenado el comentario //`i = 1000?`
    //d) ¿Cuál es la primera instrucción del programa anterior? ¿En qué memoria y en qué dirección de memoria está almacenada esa instrucción?
    //e) ¿Qué son CONT y LOOP?
    //f) ¿Cuál es la diferencia entre los símbolos `i` y `CONT`?