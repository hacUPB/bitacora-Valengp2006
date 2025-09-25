## Actividad 1 - 01/09/2025

1. **Entiende la aplicación:** comienza explorando detenidamente cómo funciona el programa. Usa un un modelo del lenguaje como ChatGPT y el depurador para que verifiques las explicaciones que te propone ChatGPT. Puedes escribir el prompt: quiere entender de manera muy detallada el siguiente programa escrito en C++ y el openframeworks. Luego le das el código. Ve preguntando lo que no entiendas. recuerda ir usando al mismo tiempo el depurador de visual studio.
2. **Realiza evaluaciones formativas.** Dile a ChatGPT que te genere preguntas para verificar si entiendes cómo funciona el programa. Trata de verificar tus hipótesis usando el depurador y luego con las conclusiones del experimento responde la pregunta de ChatGPT. Continúa con este proceso hasta que estés seguro de que entiendes cómo funciona el programa.
3.¿Qué es una lista enlazada y en qué se diferencia de un arreglo en cuanto a la forma en que los elementos están almacenados en la memoria?
4. Al observar el código de una lista enlazada en C++, ¿Cómo crees que se vinculan los nodos entre sí? ¿Qué estructura se utiliza para lograr esta conexión?
5. ¿Cómo se gestiona la memoria en una lista enlazada? Investiga cómo se crea y se destruye un nodo en memoria utilizando el operador new y delete en C++.
6. Considerando la estructura de una lista enlazada, ¿qué ventajas ofrece en comparación con un arreglo cuando se trata de insertar o eliminar elementos en posiciones intermedias?
7. En el código presentado, ¿Cómo se asegura que no haya fugas de memoria? ¿Qué papel juega el destructor en la clase LinkedList?
8. ¿Qué sucede en la memoria cuando se invoca el método clear() en una lista enlazada? Explica paso a paso cómo se liberan los recursos.
9. Explica cómo cambia la estructura en memoria de una lista enlazada al agregar un nuevo nodo al final de la lista. ¿Cómo afecta esto al rendimiento de la lista enlazada?
10. Analiza una situación en la que utilizar una lista enlazada sería más ventajoso que utilizar un arreglo. Justifica tu respuesta considerando la gestión de memoria y las operaciones de inserción y eliminación.
11. Después de estudiar el manejo de memoria en listas enlazadas, ¿Cómo aplicarías este conocimiento para diseñar una estructura de datos personalizada para una aplicación creativa? ¿Qué aspectos considerarías para asegurar la eficiencia y evitar fugas de memoria?
12. Reflexiona sobre las diferencias en la gestión de memoria entre C++ y un lenguaje con recolección de basura automática como C#. ¿Qué ventajas y desafíos encuentras en la gestión explícita de memoria en C++ al trabajar con estructuras de datos?
13. Imagina que estás optimizando una pieza de arte generativo que usa listas enlazadas para representar elementos en movimiento. ¿Qué consideraciones tomarías en cuenta para garantizar que la gestión de la memoria sea eficiente y que no ocurran fugas de memoria?
14. **Pruebas:** pregunta a ChatGPT cómo podrías probar las partes del programa y el programa completo. Luego realiza las pruebas y verifica si los resultados coinciden con tus expectativas.

### Respuestas:

**3. ¿Qué es una lista enlazada y en qué se diferencia de un arreglo en cuanto a la forma en que los elementos están almacenados en la memoria?**

- **Lista enlazada:** es una colección de **nodos dinámicos**, donde cada nodo contiene datos y un puntero al siguiente nodo.
- **Arreglo:** los elementos están almacenados de forma **contigua** en memoria.
- **Diferencias clave:**
  - **Listas enlazadas:** memoria distribuida, no contigua; flexible para agregar o eliminar elementos.
  - **Arreglos:** memoria contigua; acceso rápido por índice, pero insertar o eliminar elementos intermedios es costoso porque se deben mover otros elementos.

**4. Al observar el código de una lista enlazada en C++, ¿cómo se vinculan los nodos entre sí? ¿Qué estructura se utiliza para lograr esta conexión?**

- Cada nodo tiene un **puntero `next`** que apunta al siguiente nodo.
- La estructura que permite la conexión es **el puntero dentro del nodo**.
- Así, aunque la memoria no sea contigua, los nodos pueden recorrerse secuencialmente usando `next`.

**5. ¿Cómo se gestiona la memoria en una lista enlazada? Cómo se crea y destruye un nodo en memoria usando `new` y `delete`.**

- **Creación de un nodo:**

```cpp
Node* newNode = new Node(x, y);
```
`new` reserva memoria en el **heap** y llama al constructor de `Node`.

- **Destrucción de un nodo:**

```cpp
delete node;
```
- Libera la memoria en el heap y llama al destructor del nodo.
- La gestión explícita de memoria en C++ requiere **liberar cada nodo** cuando ya no se necesita (por ejemplo en `clear()` o en el destructor de la lista).

**6. Ventajas de la lista enlazada sobre un arreglo para insertar/eliminar elementos en posiciones intermedias**

- Inserción o eliminación no requiere **mover todos los demás elementos**, solo actualizar los punteros `next`.
- En arreglos, mover elementos para mantener la continuidad consume tiempo proporcional al tamaño del arreglo.

**7. Cómo se asegura que no haya fugas de memoria en tu código y el papel del destructor en `LinkedList`**

- Se usa `delete` para **liberar todos los nodos**.
-  `clear()` recorre todos los nodos y los elimina.
-   El **destructor `~LinkedList()`** llama a `clear()`, asegurando que la memoria se libere automáticamente cuando el objeto `LinkedList` deja de existir.

**8. Qué sucede en memoria cuando se invoca `clear()`**

1. Se toma el primer nodo (`head`).
2. Se guarda temporalmente `current->next`.
3. Se hace `delete current`, liberando la memoria del nodo.
4. Se pasa al siguiente nodo y se repite.
5. Al final, `head` y `tail` se ponen en `nullptr`, `size = 0`.

Todos los nodos quedan liberados y no quedan referencias a memoria ocupada.

**9. Cómo cambia la estructura en memoria al agregar un nuevo nodo al final**

- Se crea un nuevo nodo en **memoria dinámica (heap)**.
-  `tail->next` apunta al nuevo nodo.
-   `tail` se actualiza para apuntar al nuevo nodo.
-    **Rendimiento:** añadir al final es eficiente (`O(1)`) si se mantiene `tail`, porque no hay que recorrer la lista.

**10. Situación donde usar una lista enlazada es más ventajoso que un arreglo**

- Ejemplo: un **sistema de partículas** donde se agregan y eliminan elementos continuamente.
- Razón: insertar/eliminar partículas no requiere mover todos los elementos como en un arreglo.
- Memoria flexible: cada nodo se crea dinámicamente según necesidad.

**11. Aplicación en una estructura de datos personalizada para una aplicación creativa**

- **Cantidad de elementos:** usar lista enlazada si se agregan y eliminan muchos elementos dinámicamente
- **Gestión de memoria:** asegurar delete y destructores adecuados.
- **Acceso a elementos:** si necesitas acceso rápido por índice, tal vez un arreglo sea mejor.
- **Eficiencia:** mantener punteros head y tail para operaciones rápidas al inicio/final.

**12. Diferencias de gestión de memoria C++ vs lenguajes con GC (ej. C#)**

- **C++:** gestión manual con new y delete.
	- **Ventaja:** control total sobre memoria y rendimiento.
	- **Desafío:** riesgo de fugas de memoria o dangling pointers.

- **C#:** recolección automática (GC).
	- **Ventaja:** no preocuparse por liberar memoria manualmente.
	- **Desafío:** menos control sobre cuándo se libera la memoria y posibles pausas por GC.

**13. Optimización en arte generativo con listas enlazadas**

-	Liberar nodos que ya no se usan (por ejemplo partículas fuera de la pantalla).
-	Evitar crear demasiados nodos por frame.
-	Mantener head y tail correctamente para eficiencia.
-	Revisar que cada delete se haga solo cuando el nodo deja de ser necesario.

**14. Pruebas del programa**

**Pruebas unitarias:**

- Crear lista con 0, 1, 10 nodos y verificar size.
- Llamar a addNode() y verificar que tail apunta al último nodo.
- Llamar a clear() y verificar que head y tail sean nullptr.

**Pruebas funcionales:**

- Mover el mouse y observar que la serpiente sigue correctamente.
- Presionar 'c' y verificar que desaparece y se puede reiniciar.
- Probar límites de pantalla y crecimiento excesivo de la lista.
