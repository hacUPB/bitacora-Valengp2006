## Actividad 2:

En esta actividad vas a experimentar con pilas y colas en un contexto de arte generativo. El código incluye la gestión de memoria.

Gestión de memoria: se maneja explícitamente la liberación de memoria mediante las funciones clear(). Nota que también se llama a clear() en el destructor de las clases Stack y Queue para asegurar que la memoria se libere cuando los objetos se destruyen.

Vas a reportar en tu bitácora de aprendizaje:

1. **Entendiendo la aplicación**: comienza explorando detenidamente cómo funciona el programa. Usa un un modelo del lenguaje como ChatGPT y el depurador para que verifiques las explicaciones que te propone ChatGPT. Puedes escribir el prompt: quiere entender de manera muy detallada el siguiente programa escrito en C++ y el openframeworks. Luego le das el código. Ve preguntando lo que no entiendas. recuerda ir usando al mismo tiempo el depurador de visual studio.
2. **Realiza evaluaciones formativas**. Dile a ChatGPT que te genere preguntas para verificar si entiendes cómo funciona el programa. Trata de verificar tus hipótesis usando el depurador y luego con las conclusiones del experimento responde la pregunta de ChatGPT. Continúa con este proceso hasta que estés seguro de que entiendes cómo funciona el programa.
3. **Pruebas:** pregunta a ChatGPT cómo podrías probar las partes del programa y el programa completo. Luego realiza las pruebas y verifica si los resultados coinciden con tus expectativas.

**Preguntas de reflexión para el stack:**

1. ¿Cómo se gestiona la memoria en una implementación manual de un stack en C++? Reflexiona sobre cómo el uso de new y delete en la creación y destrucción de nodos afecta el rendimiento y la seguridad de tu programa.
2. ¿Por qué es importante liberar la memoria cuando se desapila un nodo en un stack? Considera las consecuencias de no liberar memoria en términos de fugas de memoria y cómo esto puede impactar aplicaciones de largo tiempo de ejecución.
3. ¿Qué diferencias existen entre usar un stack de la STL (std::stack) y crear un stack manualmente? Explora cómo la abstracción que proporciona la STL puede simplificar la implementación, pero también cómo una implementación manual ofrece mayor control sobre la gestión de recursos.
4. ¿Cómo afecta la estructura de un stack al orden de acceso y eliminación de elementos? Analiza cómo la naturaleza LIFO (Last In, First Out) del stack influye en los tipos de problemas que esta estructura de datos puede resolver eficientemente.
5. ¿Cómo podrías modificar el stack para almacenar tipos de datos más complejos (e.g., objetos con múltiples atributos) sin causar problemas de memoria? Reflexiona sobre cómo gestionar adecuadamente la memoria para objetos más complejos y cómo esto afectaría tu implementación actual.

**Preguntas de autoevaluación:**

1. ¿Puedo explicar detalladamente cómo funciona el proceso de apilar y desapilar nodos en un stack, incluyendo la gestión de memoria?
2. ¿Soy capaz de identificar y corregir una fuga de memoria en una implementación de stack manual?
3. ¿Puedo modificar el stack para que incluya una función que busque un elemento específico, sin alterar el orden de los elementos apilados?
4. ¿Entiendo cómo la estructura LIFO del stack afecta el flujo de datos y puedo dar ejemplos de problemas que se resuelvan mejor con un stack?
5. ¿Puedo implementar y depurar un stack para tipos de datos más complejos, asegurándome de que no haya fugas de memoria ni errores de puntero?

**Preguntas de reflexión para la queue:**

1. ¿Cómo se maneja la memoria en una implementación manual de una queue en C++? Reflexiona sobre cómo se gestionan los nodos al encolar y desencolar elementos y las implicaciones en términos de eficiencia y seguridad.
2. ¿Qué desafíos específicos presenta la implementación de una queue en comparación con un stack en términos de gestión de memoria? Considera las diferencias en el manejo de punteros front y rear, y cómo estos afectan el proceso de encolado y desencolado.
3. ¿Cómo afecta la estructura FIFO (First In, First Out) de una queue a su uso en diferentes tipos de problemas? Analiza cómo la estructura FIFO influye en la resolución de problemas donde el orden de procesamiento es crucial, como en sistemas de colas de espera.
4. ¿Cómo podrías implementar una queue circular y cuál sería su ventaja respecto a una queue lineal en términos de uso de memoria? Reflexiona sobre cómo una queue circular puede mejorar la eficiencia en ciertos contextos y qué cambios serían necesarios en la implementación.
5. ¿Qué problemas podrían surgir si no se gestionan correctamente los punteros front y rear en una queue, y cómo podrías evitarlos? Considera posibles errores como la pérdida de referencias a nodos y cómo una gestión cuidadosa de los punteros puede prevenir estos problemas.

**Preguntas de autoevaluación:**

1. ¿Puedo explicar claramente el proceso de encolar y desencolar nodos en una queue, incluyendo la gestión de memoria?
2. ¿Soy capaz de identificar y corregir problemas relacionados con la gestión de los punteros front y rear en una queue?
3. ¿Puedo modificar la queue para implementar una queue circular, entendiendo cómo esto afectaría la gestión de memoria?
4. ¿Entiendo cómo la estructura FIFO de una queue afecta el flujo de datos y puedo dar ejemplos de problemas que se resuelvan mejor con una queue?
5. ¿Puedo implementar y depurar una queue para tipos de datos más complejos, asegurándome de que no haya fugas de memoria ni errores de puntero?

### Respuestas:

#### Stack:

**Preguntas de reflexión**

**1. ¿Cómo se gestiona la memoria en una implementación manual de un stack en C++? Reflexiona sobre cómo el uso de new y delete en la creación y destrucción de nodos afecta el rendimiento y la seguridad de tu programa.**

- En una implementación manual de un stack en C++, la memoria se gestiona de manera explícita mediante el uso de los operadores `new` y `delete`.
- Cada vez que se invoca el método `push`, se crea dinámicamente un nuevo nodo en memoria con `new`. Este nodo se enlaza a la estructura existente y pasa a formar parte de la pila. Por otro lado, cuando se ejecuta `pop` o `clear`, se libera la memoria asignada con `delete`, eliminando de forma segura el nodo correspondiente.
- Este manejo manual implica un mayor control sobre los recursos, pero también conlleva riesgos: si se omite liberar memoria, se generan **fugas de memoria** que pueden afectar negativamente el rendimiento del programa, especialmente en aplicaciones interactivas o de ejecución prolongada, como proyectos de arte generativo en tiempo real.

**2. ¿Por qué es importante liberar la memoria cuando se desapila un nodo en un stack? Considera las consecuencias de no liberar memoria en términos de fugas de memoria y cómo esto puede impactar aplicaciones de largo tiempo de ejecución.**

- Liberar memoria al desapilar un nodo es fundamental para evitar **fugas de memoria**.
- Si un nodo es eliminado de la estructura lógica (ya no es accesible desde el stack), pero su espacio en memoria no es liberado, esa porción de RAM queda ocupada de forma permanente durante la ejecución del programa.
- En programas de corta duración, el impacto puede ser poco visible. Sin embargo, en aplicaciones que permanecen activas durante horas, como simulaciones visuales o instalaciones interactivas, la acumulación de memoria no liberada puede ocasionar **lentitud, consumo excesivo de recursos e incluso fallos del sistema**. Por esta razón, el uso adecuado de `delete` en cada `pop` garantiza estabilidad y eficiencia en la aplicación.

**3. ¿Qué diferencias existen entre usar un stack de la STL (std::stack) y crear un stack manualmente? Explora cómo la abstracción que proporciona la STL puede simplificar la implementación, pero también cómo una implementación manual ofrece mayor control sobre la gestión de recursos.**

La principal diferencia entre un stack de la STL y una implementación manual radica en el nivel de control y responsabilidad sobre la memoria:

- **Uso de `std::stack`:**

  - Simplifica la programación, ya que no requiere gestionar manualmente la memoria.
  - Minimiza el riesgo de fugas y errores con punteros.
  - Está optimizado y probado, lo que lo hace confiable para la mayoría de los proyectos.

- **Uso de un stack manual:**

  - Ofrece control total sobre la estructura interna y el comportamiento de los nodos.
  - Permite personalizar la gestión de memoria y la integración con otras lógicas, como el dibujo de elementos gráficos en openFrameworks.
  - Requiere mayor responsabilidad del programador, ya que un error en la liberación de memoria puede generar inestabilidad.

En conclusión, **`std::stack` es recomendable cuando se busca robustez y rapidez en el desarrollo**, mientras que un **stack manual resulta más apropiado en contextos creativos o de aprendizaje**, donde la exploración del manejo de memoria y punteros forma parte del objetivo.


**4. ¿Cómo afecta la estructura de un stack al orden de acceso y eliminación de elementos? Analiza cómo la naturaleza LIFO (Last In, First Out) del stack influye en los tipos de problemas que esta estructura de datos puede resolver eficientemente.**

La estructura de un stack sigue el principio **LIFO (Last In, First Out)**, lo que significa que el último elemento que se inserta es siempre el primero en ser eliminado, lo que influye directamente en el **orden de acceso**: no es posible acceder directamente a elementos intermedios o al fondo del stack sin desapilar los elementos superiores primero.

Este comportamiento lo hace particularmente eficiente para problemas donde se requiere un control estricto del orden de ejecución, como:

- **Reversión de operaciones** (ejemplo: “deshacer” en un editor de texto).
- **Evaluación de expresiones matemáticas** (por ejemplo, con notación postfija).
- **Recorrido de estructuras recursivas** (como árboles o grafos).

En contextos de arte generativo, la naturaleza LIFO permite controlar la creación y eliminación de elementos visuales en el orden inverso al que fueron añadidos, lo que puede generar dinámicas interesantes en animaciones o composiciones visuales.

**5. ¿Cómo podrías modificar el stack para almacenar tipos de datos más complejos (e.g., objetos con múltiples atributos) sin causar problemas de memoria? Reflexiona sobre cómo gestionar adecuadamente la memoria para objetos más complejos y cómo esto afectaría tu implementación actual.**

Para almacenar objetos con múltiples atributos en el stack (por ejemplo, círculos con posición, color, velocidad y dirección), se deben considerar varios aspectos de gestión de memoria:

- **Definir una clase o estructura para los elementos:**
   En lugar de solo guardar un `ofVec2f`, se podría crear una clase `Circle` con atributos adicionales (posición, color, tamaño, etc.). Cada nodo del stack contendría un objeto `Circle` en lugar de un valor simple
- **Gestión adecuada de memoria dinámica:**
   Si estos objetos incluyen punteros a recursos (como texturas o buffers), es crucial liberar esos recursos en el destructor del objeto. De lo contrario, se producirían fugas de memoria.
- **Uso de RAII y smart pointers:**
   Para mayor seguridad, se pueden emplear **punteros inteligentes** (`std::unique_ptr` o `std::shared_ptr`), que gestionan automáticamente la liberación de memoria. Esto reduciría los riesgos de errores humanos asociados al uso de `new` y `delete`.

En conclusión, al ampliar el stack para manejar objetos más complejos, la implementación actual debería adaptarse para:

- Incluir destructores adecuados en las nuevas clases.
- Usar punteros inteligentes siempre que sea posible.
- Mantener el control del ciclo de vida de los objetos, garantizando que no queden recursos sin liberar.

**Preguntas de autoevaluación:**

**1. ¿Puedo explicar detalladamente cómo funciona el proceso de apilar y desapilar nodos en un stack, incluyendo la gestión de memoria?**

Sí. Cuando hago un push, se crea un nuevo nodo en memoria dinámica con new, y este pasa a ser el nuevo tope de la pila, apuntando al nodo que antes estaba arriba. Cuando hago un pop, el nodo en el tope se guarda en un puntero temporal, top se actualiza al siguiente nodo y el nodo desapilado se elimina con delete, liberando la memoria ocupada. De esta forma, cada operación de apilar y desapilar implica reservar o liberar memoria de manera explícita.

**2. ¿Soy capaz de identificar y corregir una fuga de memoria en una implementación de stack manual?**

Sí. Si en pop se desapila un nodo pero no se usa delete, se produce una fuga de memoria, ya que el nodo deja de ser accesible, pero su espacio en RAM sigue ocupado. Esto puede pasar desapercibido en programas cortos, pero en ejecuciones largas ocasionaría un consumo innecesario de memoria y pérdida de rendimiento. La solución es liberar siempre los nodos con delete y asegurar que el destructor (~Stack) llame a clear() para vaciar completamente la pila.

**3. ¿Puedo modificar el stack para que incluya una función que busque un elemento específico, sin alterar el orden de los elementos apilados?**

Sí. Para hacerlo, basta con recorrer la pila con un puntero auxiliar desde top hasta nullptr, verificando si alguno de los nodos contiene el valor buscado. Este método permite inspeccionar todos los elementos sin necesidad de desapilarlos ni alterar el orden, ya que solo se realiza una lectura.

**4. ¿Entiendo cómo la estructura LIFO del stack afecta el flujo de datos y puedo dar ejemplos de problemas que se resuelvan mejor con un stack?**

Sí. El stack sigue la regla LIFO (Last In, First Out), lo que significa que el último elemento en entrar es siempre el primero en salir. Esto lo hace ideal para problemas como la funcionalidad de “deshacer” en editores (Ctrl+Z), ya que el último cambio realizado es el primero que se elimina. También es útil en evaluación de expresiones postfijas y en algoritmos de backtracking. En el contexto de arte generativo, esta estructura permite controlar la aparición y desaparición de elementos gráficos en un orden inverso al de su creación.

**5. ¿Puedo implementar y depurar un stack para tipos de datos más complejos, asegurándome de que no haya fugas de memoria ni errores de puntero?**

Sí. Para objetos más complejos (por ejemplo, círculos con color, tamaño y velocidad), lo más seguro es utilizar punteros inteligentes como std::unique_ptr o std::shared_ptr, ya que estos liberan automáticamente la memoria cuando los objetos dejan de usarse. Esto evita fugas de memoria y errores de puntero comunes en la gestión manual. De esta manera, puedo extender la implementación del stack manteniendo seguridad y eficiencia en la gestión de recursos.

#### Queue

**Preguntas de reflexión:**

**1. ¿Cómo se maneja la memoria en una implementación manual de una queue en C++? Reflexiona sobre cómo se gestionan los nodos al encolar y desencolar elementos y las implicaciones en términos de eficiencia y seguridad.**

En una implementación manual de una queue, cada vez que se encola un elemento se reserva memoria dinámica para un nuevo nodo con new. Al desencolar, el nodo al que apunta front se libera con delete, evitando fugas de memoria. Este proceso garantiza que la estructura solo consuma la memoria necesaria en cada momento, aunque implica una responsabilidad directa del programador para asegurar la correcta liberación de los nodos.

**2. ¿Qué desafíos específicos presenta la implementación de una queue en comparación con un stack en términos de gestión de memoria? Considera las diferencias en el manejo de punteros front y rear, y cómo estos afectan el proceso de encolado y desencolado.**

A diferencia de un stack, en una queue se deben manejar dos punteros: front y rear. Esto introduce mayor complejidad, ya que ambos deben actualizarse correctamente para reflejar el estado de la cola. Si se pierde la referencia de alguno, se corre el riesgo de perder acceso a nodos intermedios y provocar fugas de memoria. En un stack, solo se maneja un puntero (top), lo que hace más simple su gestión.

**3. ¿Cómo afecta la estructura FIFO (First In, First Out) de una queue a su uso en diferentes tipos de problemas? Analiza cómo la estructura FIFO influye en la resolución de problemas donde el orden de procesamiento es crucial, como en sistemas de colas de espera.**

La naturaleza First In, First Out (FIFO) de una queue hace que sea ideal para problemas donde el orden de llegada determina el orden de atención. Ejemplos claros son los sistemas de colas de espera (bancos, servidores de impresión, procesos en un sistema operativo). Este comportamiento asegura un procesamiento justo y ordenado, respetando la secuencia en que los elementos fueron encolados.

**4. ¿Cómo podrías implementar una queue circular y cuál sería su ventaja respecto a una queue lineal en términos de uso de memoria? Reflexiona sobre cómo una queue circular puede mejorar la eficiencia en ciertos contextos y qué cambios serían necesarios en la implementación.**

Una queue circular reutiliza el espacio de memoria ya liberado, evitando el crecimiento indefinido de la estructura y aprovechando mejor los recursos disponibles. Esto es útil en contextos donde la memoria es limitada, como en sistemas embebidos. Para implementarla, se deben ajustar las operaciones de encolado y desencolado para que los punteros front y rear vuelvan al inicio del buffer cuando llegan al final.

**5. ¿Qué problemas podrían surgir si no se gestionan correctamente los punteros front y rear en una queue, y cómo podrías evitarlos? Considera posibles errores como la pérdida de referencias a nodos y cómo una gestión cuidadosa de los punteros puede prevenir estos problemas.**

Si no se gestionan correctamente los punteros front y rear, pueden ocurrir errores como la pérdida de acceso a nodos (memory leak) o inconsistencias en la cola (por ejemplo, rear apuntando a nullptr cuando aún hay elementos). Para evitarlo, es clave actualizar cuidadosamente los punteros en cada operación y considerar casos especiales, como cuando la cola queda vacía tras un desencolado, asegurando que ambos punteros se reinicien correctamente.

**Preguntas de autoevaluación:**

**1. ¿Puedo explicar claramente el proceso de encolar y desencolar nodos en una queue, incluyendo la gestión de memoria?**

No del todo, esto debido a que  confundo el proceso de encolado con el de un stack, lo que indica que todavía no tengo clara la diferencia entre ambas estructuras. Por ahora, entiendo que encolar agrega un nodo al final (rear) y desencolar elimina el nodo al frente (front), pero necesito reforzar la práctica con ejemplos y depuración para no confundirlo con un stack.

**2. ¿Soy capaz de identificar y corregir problemas relacionados con la gestión de los punteros front y rear en una queue?**

Si, uno de los problemas más comunes es no actualizar rear cuando se elimina el último nodo. Esto provoca que rear quede apuntando a memoria liberada, lo cual genera errores. Para corregirlo, basta con establecer rear = nullptr cuando front se convierte en nullptr.

**3. ¿Puedo modificar la queue para implementar una queue circular, entendiendo cómo esto afectaría la gestión de memoria?**

Sí, una queue circular enlaza el último nodo (rear) de nuevo con el primero (front). Esto permite reutilizar el espacio y aprovechar mejor la memoria, especialmente en contextos donde el tamaño de la cola es fijo. Requiere modificar la lógica de encolado y desencolado, pero la gestión de memoria sigue dependiendo del uso correcto de new y delete.

**4. ¿Entiendo cómo la estructura FIFO de una queue afecta el flujo de datos y puedo dar ejemplos de problemas que se resuelvan mejor con una queue?**

Sí, la estructura FIFO (First In, First Out) hace que los elementos salgan en el mismo orden en que entraron. Esto es útil en sistemas de colas de espera, procesamiento de tareas en orden de llegada o la simulación de turnos. A diferencia del stack (LIFO), la queue es ideal para situaciones donde el orden justo y cronológico es importante.

**5. ¿Puedo implementar y depurar una queue para tipos de datos más complejos, asegurándome de que no haya fugas de memoria ni errores de puntero?**

Sí, para manejar datos más complejos, es necesario implementar destructores adecuados en los nodos, liberando memoria dinámica asociada a los atributos. Además, al depurar, es clave verificar con el depurador que no existan accesos a memoria inválida y que cada nodo eliminado con dequeue() haya sido correctamente liberado con delete.