# Anotaciones reto actividad 1:

- Para poder comenzar a realizar los ejercicios tuve que devolverme a revisar el material dado en clase, ya que tuve complicaciones para entender el tema desde el principio, pero luego de retroalimentar la información y resolver algunso ejemplos logré realizar el reto.

- Además, fue necesaria la elaboración de un cuadro en donde se encuentran las ramas utilizadas en el lenguaje Assembly junto con su condición de salto y significado para una mejor comprensión del tema.

### Branching instructions:

|    Ramas    |  Condición de salto  |            Significado            |
|-------------|-----------------------|-----------------------------------|
|    `JGT`    |       `comp > 0`      | Salta si el resultado es positivo |
|    `JEQ`    |      `comp == 0`      |   Salta si el resultado es cero   |
|    `JGE`    |      `comp >= 0`      |    Salta si es cero o positivo    |
|    `JLT`    |       `comp < 0`      |       Salta si es negativo        |
|    `JNE`    |       `comp ≠ 0`      |   Salta si es diferente de cero   |
|    `JLE`    |      `comp <= 0`      |    Salta si es cero o negativo    |
|    `JMP`    |    (sin condición)    |     Salta incondicionalmente      |

- Para la solución de los ejercicios relacionados con **variables** fue necesaria también la revisión de la presentación de PowerPoint en donde esta la información del curso, además de algunos tutoriales de YouTube pertenecientes al curso de Nand2Tetris.

- En cuento a los ejercicios con labels, fueron los que mas se me dificultaron, por lo que tuve que recurrir a ayuda externa para poder comprender como funcionan y como usarlos correctamente, lo cual fue mas fácil luego de pasar los ejercicios por el simulador de **Nand2Tetris**.

- Entre la información que encontré para la solución del reto encontré que en el simulador de nand2tetris la memoria RAM va desde RAM[0] hasta RAM[24575] y que la pantalla (pantalla física) está mapeada a una parte de esa memoria desde RAM[16384] hasta RAM[24575] (son 8192 direcciones en donde cada una controla 16 píxeles)

- [Enlace al bitmap de la pregunta 18](https://nand2tetris.github.io/web-ide/bitmap)

### Conclusión general

Durante el desarrollo de los 20 retos de lenguaje ensamblador Hack, comprendí cómo se comunican el software y el hardware a través de instrucciones de bajo nivel. También, aprendí a trabajar con variables, saltos condicionales, ciclos, manipulación de memoria RAM, y cómo interactuar directamente con los dispositivos del sistema como el teclado (KBD) y la pantalla (SCREEN). Traducir estructuras de alto nivel como if, for y operaciones aritméticas en instrucciones simples.

Además, este proceso no solo me permitió entender cómo funciona internamente un computador, sino que también me dio herramientas clave para implementar tareas visuales como el dibujo de un gato en pantalla al presionar una tecla, lo que me mostró el potencial de la programación de bajo nivel para controlar directamente la experiencia del usuario.