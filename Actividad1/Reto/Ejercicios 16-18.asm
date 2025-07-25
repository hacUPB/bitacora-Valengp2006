//16. Implementa en lenguaje ensamblador el siguiente programa:
    
    int[] arr = new int[10];
    int sum = 0;
    for (int j = 0; j < 10; j++) {
        sum = sum + arr[j];
    }
    
    //a) ¿Qué hace este programa?
    //b) ¿Cuál es la dirección base de arr en la memoria RAM?
    //c) ¿Cuál es la dirección base de sum en la memoria RAM y por qué?
    //d) ¿Cuál es la dirección base de j en la memoria RAM y por qué?

    // Respuestas:
    // a) Este programa inicializa un arreglo de 10 enteros, luego suma todos los elementos del arreglo y almacena el resultado en la variable `sum`.
    // b) La dirección base de `arr` en la memoria RAM es 16.
    // c) La dirección base de `sum` es 26, ya que es la siguiente posición disponible después de `arr` que ocupa hasta la posición 25.
    // d) La dirección base de `j` es 27, ya que es la siguiente posición disponible después de `sum`.

//17. Implementa en lenguaje ensamblador:
    
    if ( (D - 7) == 0) goto a la instrucción en ROM[69]

    @7
    D=D-A
    @69
    D;JEQ 
   
//18. Utiliza esta herramienta para dibujar un bitmap en la pantalla.