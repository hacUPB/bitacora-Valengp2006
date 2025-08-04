## Reto 6 - 04/08/2025

Ahora vas a usar un puntero para leer la posición de memoria a la que este apunta, es decir, vas a leer por medio del puntero la variable cuya dirección está almacenada en él.
    
```cpp
    int a = 10;
    int b = 5;
    int *p;
    p = &a;
    b = *p;
```
En este caso `b = *p;` hace que el valor de `b` cambie de 5 a 10 porque `p` apunta a la la variable `a` y con `*p` a la derecha del igual estás leyendo el contenido de la variable apuntada.

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

