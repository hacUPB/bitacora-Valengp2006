## Reto 4

Ahora vamos a acercarnos al concepto de puntero. Un puntero es una variable que almacena la dirección de memoria de otra variable. Observa el siguiente programa escrito en C++:
    
```cpp
    int a = 10;
    int *p;
    p = &a;
    *p = 20;
```

El programa anterior modifica el contenido de la variable `a` por medio de la variable `p`. `p` es un puntero porque almacena la dirección de memoria de la variable `a`. En este caso el valor de la variable `a` será 20 luego de ejecutar `*p = 20;`. Ahora analiza:
    
- ¿Cómo se declara un puntero en C++? `int *p;`. `p` es una variable que almacenará la dirección de un variable que almacena enteros.
- ¿Cómo se define un puntero en C++? `p = &a;`. Definir el puntero es inicializar el valor del puntero, es decir, guardar la dirección de una variable. En este caso `p` contendrá la dirección de `a`.
- ¿Cómo se almacena en C++ la dirección de memoria de una variable? Con el operador `&`. `p = &a;`
- ¿Cómo se escribe el contenido de la variable a la que apunta un puntero? Con el operador . `p = 20;`. En este caso como `p` contiene la dirección de `a` entonces `p` a la izquierda del igual indica que quieres actualizar el valor de la variable `a`.

**Respuestas:**

**¿Cómo se declara un puntero en C++?**

Un puntero se declara con el asterisco * antes del nombre de la variable: int *p;. Esto indica que p es una variable que almacenará la dirección de memoria de un entero (int).

**¿Cómo se define un puntero en C++?**

Un puntero se define (inicializa) asignándole la dirección de otra variable, usando el operador &: p = &a;. En este caso, p guarda la dirección en memoria de la variable a.

**¿Cómo se almacena en C++ la dirección de memoria de una variable?**

Utilizando el operador &. Por ejemplo: p = &a; significa que p ahora apunta a la dirección de la variable a.

**¿Cómo se accede al contenido de la variable apuntada por un puntero?**

Usando el operador * antes del puntero: *p = 20;. Esto indica que se quiere acceder y modificar el valor que se encuentra en la dirección a la que apunta p, es decir, modificar el valor de a.