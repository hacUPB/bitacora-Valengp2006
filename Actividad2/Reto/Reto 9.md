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
