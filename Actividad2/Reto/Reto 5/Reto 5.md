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

Se ejecutó el programa en el simulador de la CPU Hack y se verificaron los siguientes resultados:

- RAM[16] = 20 → el valor de la variable a fue correctamente actualizado por medio del puntero p.
- RAM[17] = 16 → el puntero p contiene correctamente la dirección de a.

Esto demuestra que el comportamiento de los punteros puede ser simulado usando direcciones explícitas de memoria, permitiendo modificar el valor de una variable desde otra variable que guarda su dirección.
