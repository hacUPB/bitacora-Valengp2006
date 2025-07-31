## Reto 5

Traduce este programa a lenguaje ensamblador:

```cpp
int a = 10;
int *p;
p = &a;
*p = 20;
```

**Programa en lenguaje ensamblador:**

```asm
// int a = 10;
@10
D=A
@16     // a en RAM[16]
M=D

// int *p;  → p en RAM[17]

// p = &a;
@16
D=A
@17     // p en RAM[17]
M=D

// *p = 20;
@20
D=A         // D = 20
@17
A=M         // A = M[17] → dirección de a
M=D         // *p = 20 (RAM[16] = 20)
```

**Implementación:** 

La variable a se almacenó en la dirección RAM[16], y el puntero p se ubicó en RAM[17], guardando allí la dirección de a. Luego se accedió indirectamente a a mediante p para asignarle el valor 20, simulando el acceso indirecto de un puntero.

**Validación:** 

Se utilizó el simulador de la plataforma nand2tetris para verificar que, al finalizar la ejecución, RAM[16] (la variable a) contiene el valor 20. Esto comprueba que el puntero almacenado en RAM[17] apuntó correctamente a a y permitió modificar su contenido.
