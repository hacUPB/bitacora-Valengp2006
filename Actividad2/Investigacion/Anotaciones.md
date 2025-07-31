### Anotaciones actividad 3:

Luego de probar el código de la actividad 3 se evidenció que la función de borrar pantalla no está funcionando según lo esperado.

Al iniciar el programa mientras no esté presionada la tecla d no comenzará a realizar el dibujo, sin embargo, luego debería desaparecer el dibujo al soltar la tecla, lo cual no ocurrió, sino que el código continuó ejecutándose entre la línea 1 y 10 sin avanzar a la función de limpiar.

Luego de revisar nuevamente se encontró el error, el cual se debe a que la función borrar se encuentra mal ubicado, esto debido a que el código es inalcanzable en la ubicación en la que está. Para solucionarlo, se agregó un nuevo loop en el cual verifica si la tecla es igual a cero, en donde dependiendo de la respuesta salta a la función limpiar (o borrar) o a la función dibujar.