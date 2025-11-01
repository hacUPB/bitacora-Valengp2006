## Reto 2

Transforma el programa en alto nivel anterior para que utilice un ciclo for en vez de un ciclo while.

**Programa en lenguaje de alto nivel con ciclo for**

```cpp
int sum = 0;
for (int i = 1; i <= 100; i++) {
    sum += i;
}
```

**Implementación:**

Se logró transformar el ciclo while a un ciclo for en lenguaje de alto nivel. Ambos programas realizan la misma operación: sumar los primeros 100 números naturales. La diferencia está en la estructura del control de flujo: en for, la inicialización, condición y actualización están integradas en una sola línea.

**Validación:**

Para comprobar la equivalencia lógica de ambas versiones, se analizaron paso a paso las instrucciones. Se verificó que ambas versiones inicializan i en 1, suman su valor a sum mientras i <= 100 y luego incrementan i en cada iteración. Aunque aún no se ha probado en ensamblador, esta validación teórica garantiza que el comportamiento del nuevo ciclo será el mismo cuando se implemente.