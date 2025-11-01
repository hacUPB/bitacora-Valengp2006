### Anotaciones actividad 3:

Luego de probar el código de la actividad 3 se evidenció que la función de borrar pantalla no está funcionando según lo esperado.

Al iniciar el programa mientras no esté presionada la tecla d no comenzará a realizar el dibujo, sin embargo, luego debería desaparecer el dibujo al soltar la tecla, lo cual no ocurrió, sino que el código continuó ejecutándose entre la línea 1 y 10 sin avanzar a la función de limpiar.

Finalmente, se reorganizó la lógica del programa para evaluar primero si hay una tecla presionada y luego decidir si mostrar o borrar el dibujo según sea la tecla “d” (ASCII 100) o no. Se corrigieron saltos inalcanzables y errores de flujo que impedían ejecutar la función CLEAR. Además, se reubicaron las subrutinas DRAW y CLEAR fuera del bucle principal para un mejor control. Se ajustaron errores de sintaxis como instrucciones inválidas y se eliminaron etiquetas mal ubicadas. Con estos cambios, el programa ahora muestra el dibujo solo mientras se presiona la tecla “d” y lo borra al soltarla.

### Anotaciones actividad 4:

Para esta actividad se modificó el código original de la Actividad 3, el cual mostraba una imagen al presionar la tecla 'd' y la borraba automáticamente al soltarla. El objetivo ahora era que la imagen solo se mostrara al presionar 'd' y solo se borrara si se presionaba la tecla 'e'. Para lograrlo, se añadieron condiciones específicas que verifican si el valor de KBD es igual a 100 (ASCII de 'd') o 101 (ASCII de 'e'). Cada una de estas condiciones redirige el flujo del programa a las subrutinas DRAW o CLEAR respectivamente.

Se eliminó la lógica que comparaba con cero (que verificaba si no había tecla presionada), ya que ahora no se desea borrar automáticamente. Además, se ajustaron las condiciones del bucle principal (LOOP) para que cualquier tecla diferente de 'd' o 'e' no altere el estado actual de la pantalla. Durante las pruebas en el simulador, se verificó que al presionar 'd' el dibujo del gato se mostrara correctamente, y que al presionar 'e' se borrara completamente, dejando la pantalla en blanco. También se probó que al presionar otras teclas o no presionar ninguna, la pantalla permaneciera sin cambios. El comportamiento observado fue el esperado en todos los casos.