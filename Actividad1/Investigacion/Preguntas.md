### Actividad 1:

**¿Qué es un computador digital moderno? ¿Cuáles son sus partes?**

Un computador digital moderno es una máquina capaz de ejecutar múltiples programas sobre un mismo hardware, gracias a su arquitectura general y versátil. 
Su diseño se basa en el modelo de Von Neumann, que permite que tanto los datos como las instrucciones se almacenen en la misma memoria.

Las partes fundamentales de un computador son:

- CPU (Unidad Central de Procesamiento): Procesa datos e instrucciones. Contiene registros y la ALU.
- ALU (Unidad Aritmético-Lógica): Ejecuta operaciones matemáticas y lógicas.
- Registros (como A y D): Almacenan temporalmente datos y direcciones.
- Memoria RAM: Guarda información y variables durante la ejecución del programa.
- Memoria ROM: Contiene el programa que va a ser ejecutado.
- Bus de datos y control: Permiten la comunicación entre componentes.

En el computador, se puede observar cómo interactúan estos elementos gracias al emulador de CPU, lo cual facilita entender el ciclo de ejecución de instrucciones.


### Actividad 2  

**¿Qué es un programa?**

Un **programa** es un conjunto ordenado de instrucciones que un computador ejecuta para realizar tareas específicas. 
Estas instrucciones pueden escribirse en distintos niveles de abstracción.

**¿Qué es lenguaje de máquina?**

El **lenguaje de máquina** es el nivel más bajo: son instrucciones en código binario que la CPU interpreta directamente. Son precisas pero difíciles de leer.

**¿Qué es un lenguaje ensamblador?**

El **lenguaje ensamblador** es una versión simbólica del lenguaje de máquina. 
Usa mnemónicos como @10, D=M o D;JGT, que luego son traducidos a binario mediante un ensamblador. 
En el computador Hack, se utilizan dos tipos principales de instrucciones:
- A-instructions: Para cargar valores o direcciones en el registro A (@valor).
- C-instructions: Para realizar operaciones (D=D+M, M=D, etc.) y controlar el flujo del programa.

Este modelo permite comprender cómo se traduce un programa simbólico en instrucciones que el hardware puede ejecutar.

### Actividad 3 

**¿Qué son PC, D y A? ¿Para qué los usa la CPU?**

En el computador, la CPU trabaja con tres registros esenciales:

- PC (Program Counter): Lleva el seguimiento de la dirección de la próxima instrucción en la memoria ROM. Controla la secuencia de ejecución.
- D (Data Register): Almacena datos temporales que se usan en operaciones lógicas o aritméticas.
- A (Address Register): Sirve para dos propósitos: como valor numérico (por ejemplo, para sumar D=A+1) o como dirección de memoria (M accede a RAM[A]).

La CPU utiliza estos registros para procesar datos, acceder a memoria, y tomar decisiones de control mediante instrucciones de salto condicional o incondicional.
Esta arquitectura facilita tanto la manipulación de datos como el control del flujo del programa.

