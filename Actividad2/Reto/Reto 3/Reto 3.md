## Reto 3

Escribe un programa en lenguaje ensamblador que implemente el programa anterior.

**Programa en lenguaje ensamblador:**

```asm
// i = 1
@1
D=A
@20     // i en RAM[20]
M=D

// sum = 0
@0
D=A
@22     // sum en RAM[22]
M=D

(LOOP)
@20
D=M
@101
D=D-A
@END
D;JGE   // Si i > 100, salir del bucle

// sum = sum + i
@22
D=M
@20
D=D+M
@22
M=D

// i++
@20
M=M+1

@LOOP
0;JMP

(END)
@END
0;JMP
```

**Implementación del programa:**

Se implementó un programa que usa un ciclo for en lenguaje ensamblador Hack para sumar los primeros 100 números naturales. Las variables i y sum fueron almacenadas en las posiciones RAM[20] y RAM[22], respectivamente.

**Pruebas realizadas:**
Se utilizó el simulador CPU Emulator para ejecutar el programa. Al finalizar la simulación, se verificó que la posición RAM[22] contiene el valor 5050, confirmando que la suma fue realizada correctamente. Además, se monitoreó el incremento de i para asegurar que el ciclo itera exactamente 100 veces.

Se evidenció que el código es prácticamente igual al realizado en el reto 2, con la diferencia que, al utilizar como referencia en el lenguaje de alto nivel el ciclo for, el bucle tiene una estructura mas ordenada, como se haria en el lenguaje de alto nivel.