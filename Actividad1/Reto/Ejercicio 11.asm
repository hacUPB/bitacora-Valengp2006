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

    // Respuestas:

    //a) Este programa inicializa la variable `i` en 1000, luego entra en un bucle que decrementa `i` hasta que llega a 0, momento en el cual salta a la etiqueta `CONT`.
    //b) La variable `i` está almacenada en la RAM, específicamente en la dirección 16,
    //c) El comentario `// i = 1000` no se almacena en la memoria, ya que es un comentario y no una instrucción ejecutable. 
    //d) La primera instrucción del programa es `@1000`, que está almacenada en la ROM en la dirección 0.
    //e) `CONT` y `LOOP` son etiquetas que se utilizan para marcar posiciones en el código. `CONT` es el punto al que se salta cuando `i` llega a 0, y `LOOP` es el inicio del bucle.
    //f) `i` es una variable que almacena un valor, mientras que `CONT` es una etiqueta que indica un punto en el código al que se puede saltar. Las etiquetas no almacenan valores, sino que sirven como referencias para el flujo del programa.