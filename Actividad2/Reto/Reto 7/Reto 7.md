## Reto 7

Traduce este programa a lenguaje ensamblador:
```cpp
int a = 10;
int b = 5;
int *p;
p = &a;
b = *p;
```
**Código en lenguaje ensamblador:**

```asm
//int a = 10;
@10
D=A
@16    //a en la posición 16 en la RAM
M=D

//int b = 5;
@5
D=A
@17 //b en la posición 17 de la RAM
M=D

//int p; p = &a;
@16
D=A
@18   //p en la posición 18 de la RAM
M=D

//b =*p;
@18  //p
A=M  // A = valor de p = dirección a
D=M  // D tiene el contenido de a
@17  //b
M=D
```
**Implementación:**

Este programa traduce a lenguaje ensamblador la lógica de usar un puntero para leer el valor de una variable. La variable `a` se almacena en la dirección 16 de la RAM y se inicializa en 10. Luego, `b` se define en RAM[17] con un valor inicial de 5. El puntero `p` se almacena en la posición 18 de la RAM y apunta a `a` guardando su dirección. Finalmente se lee el valor de `a` por medio de `p` y se asigna a `b`.

**Validación:**

Luego de ejecutar el código en el emulador se verificó que;

- RAM[16] = 10 (guarda el valor de `a`)
- RAM[17] = 10 (valor de `b` actualizado a lo que apunta p)
- RAM[18] = 16 (valor de `p` que apunta a la dirección de `a`)

Esto confirma que el puntero `p` almacena la dirección de `a` y que `b = *p` funciona correctamente al copiar su valor.
