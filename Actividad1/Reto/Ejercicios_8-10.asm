//8. Considera el siguiente programa:

    @var1
    D=M
    @var2
    D=D+M
    @var3
    M=D

    //a) ¿Qué hace este programa?
    //b) ¿En que posición de la memoria está var1, var2 y var3?
    //¿Por qué en esas posiciones?

    //Respuestas:

    // a) Este programa suma el valor almacenado en la posición de memoria `var1` con el valor almacenado en `var2` y guarda el resultado en `var3`.
    // b) La posición de memoria de 'var1' se encuentra en la posición 16 de la RAM, ya que los primeros 15 registros estan reservados para la memoria, de igual forma 'var2' y 'var3' ocupan las posiciones 17 y 18 respectivamente.

//9. Considera el siguiente programa:
    
   i=1
   sum=0
   sum=sum+i
   i=i+1

   //La traducción al lenguaje ensamblador del programa anterior es:

   // i = 1
    @i
    M=1
    // sum = 0
    @sum
    M=0
    // sum = sum + i
    @i
    D=M
    @sum
    M=D+M
    // i = i + 1
    @i
    D=M+1
    @i
    M=D

    //a) ¿Qué hace este programa?
    //b) ¿En qué parte de la memoria RAM está la variable i y sum? ¿Por qué en esas posiciones?
    //c) Optimiza esta parte del código para que use solo dos instrucciones:
        // i = i + 1
        @i
        D=M+1
        @i
        M=D

    // Respuestas:

    // a) Este programa inicializa la variable `i` en 1 y la variable `sum` en 0, luego suma el valor de `i` a `sum`, y finalmente incrementa `i` en 1.
    // b) La variable `i` se encuentra en la posición 16 de la RAM y `sum` en la posición 17. Estas posiciones son elegidas porque las primeras 15 posiciones de la RAM están reservadas para el sistema, por lo que las variables de usuario comienzan a partir de la posición 16.
    // c) La optimización del código para que use solo dos instrucciones es la siguiente:
        @i
        M=M+1

//10. Las posiciones de memoria RAM de 0 a 15 tienen los nombres simbólico R0 a R15. Escribe un programa en lenguaje ensamblador que guarde en R1 la operación 2 * R0.

    @R0
    D=M
    @2
    D=D*A
    @R1
    M=D
    

