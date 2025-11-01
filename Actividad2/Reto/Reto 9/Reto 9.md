## Reto 9

Considera que el punto de entrada del siguiente programa es la función `main`, es decir, el programa inicia llamando la función `main`. Vas a proponer una posible traducción a lenguaje ensamblador de la función `suma`, cómo llamar a suma y cómo regresar a `std::cout << "El valor de c es: " << c << std::endl;` una vez suma termine.
```cpp
#include <iostream>

int suma(int a, int b) {
   int var = a + b;
   return var;
}


int main() {
   int c = suma(6, 9);
   std::cout << "El valor de c es: " << c << std::endl;
   return 0;
}
```

**Código en lenguaje ensamblador:**
```asm
// Main
@6
D=A
@R0
M=D        // a = 6

@9
D=A
@R1
M=D        // b = 9

@SUMA
0;JMP      // saltar a la función

(RET)
@R2
D=M
@R3
M=D        // guardar resultado en c

// Suma
(SUMA)
    @R0
    D=M
    @R1
    D=D+M
    @R2
    M=D
    @RET       // SALTO FIJO
    0;JMP
```

**Implementación:**

En este reto se implementó en lenguaje ensamblador una simulación del comportamiento de una función en C++ que recibe dos parámetros (a y b), realiza una operación de suma y retorna el resultado. Para ello, se reservaron posiciones consecutivas en memoria para los parámetros, el resultado y la variable que lo almacena. Además, se replicó el llamado desde una función principal (main) y se almacenó el resultado de retorno en una nueva variable (c), imitando el flujo lógico de una función. 

**Validación:**

Luego de probar el programa en el simulador, se verificó que la suma de los valores 6 y 9 se almacenara correctamente en memoria. El resultado 15 apareció tanto en la variable local de la función (var) como en la variable c del main, lo que confirma que el retorno y la asignación se realizaron como se esperaba.

