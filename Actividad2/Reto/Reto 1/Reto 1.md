## Reto 1

Escribe un programa en lenguaje ensamblador que sume los primeros 100 números naturales.
    
```cpp
    int i = 1;
    int sum = 0;
    While (i <= 100){
       sum += i;
       i++;
    }
```
    
- ¿Cómo están implementadas las variables `i` y `sum`?
- ¿En qué direcciones de memoria están estas variables?
- ¿Cómo está implementado el ciclo `while`?
- ¿Cómo se implementa la variable `i`?
- ¿En qué parte de la memoria se almacena la variable `i`?
- Después de todo lo que has hecho, ¿Qué es entonces una variable?
- ¿Qué es la dirección de una variable?
- ¿Qué es el contenido de una variable?

**Respuetas:**

- Código en Assembly:

```asm
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
```

Se implementaron dos variables, i y sum, usando etiquetas simbólicas que el ensamblador asigna desde RAM[16] (es decir, i = RAM[16], sum = RAM[17]). El ciclo while se construyó con una etiqueta (LOOP) y una condición de parada que compara i con 101. El cuerpo del ciclo realiza la suma acumulativa y luego incrementa i.

Para probar el programa se usó el simulador de Hack paso a paso. Se verificó que:

+ i se incrementa correctamente desde 1 hasta 100.
+	sum acumula correctamente la suma (debe terminar en 5050).
+	El salto condicional funciona bien y termina el ciclo en el momento correcto.
+	El valor final en RAM[17] (sum) es 5050, lo que confirma que la lógica funciona.

**¿Cómo están implementadas las variables i y sum?**

Las variables i y sum están implementadas como etiquetas simbólicas que el ensamblador traduce en direcciones de memoria RAM. Internamente, @i y @sum hacen referencia a ubicaciones específicas en la RAM donde se almacenan sus respectivos valores.

**¿En qué direcciones de memoria están estas variables?**

Por convención en Hack, las variables simbólicas empiezan a asignarse desde la RAM[16].
Entonces:
*	i → RAM[16]
*	sum → RAM[17]

**¿Cómo está implementado el ciclo while?**

El ciclo while se implementa con una etiqueta de bucle (LOOP) y un salto condicional que compara el valor de i con 101:
    
```asm
@i
D=M
@101
D=D-A
@END
D;JGE      // Si i >= 101, salir del bucle
```

Este bloque se repite con 0;JMP al final del ciclo para regresar a (LOOP) mientras la condición sea verdadera.

- **¿Cómo se implementa la variable i?**

    Se inicializa con @1 y M=D, y se incrementa dentro del ciclo con M=M+1. Todo esto ocurre en la dirección de memoria asociada a i (RAM[16]).

- **¿En qué parte de la memoria se almacena la variable i?**

    En RAM[16] (como se explicó anteriormente, las variables empiezan desde la dirección 16 en la arquitectura Hack).

- **Después de todo lo que has hecho, ¿Qué es entonces una variable?**

    Una variable en ensamblador Hack es una ubicación en memoria RAM donde se puede guardar y modificar un valor. Es un nombre simbólico que el ensamblador traduce a una dirección numérica.

- **¿Qué es la dirección de una variable?**

    Es el índice en la memoria RAM donde se almacena el contenido de la variable. Por ejemplo, si i está en RAM[16], esa es su dirección.

- **¿Qué es el contenido de una variable?**

    Es el valor almacenado en esa dirección de memoria. Si i = 5, entonces en RAM[16] hay un valor binario que representa 5.