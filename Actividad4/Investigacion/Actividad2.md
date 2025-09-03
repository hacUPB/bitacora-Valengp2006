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

#### Queue

**Preguntas de reflexión:**

**1. ¿Cómo se maneja la memoria en una implementación manual de una queue en C++? Reflexiona sobre cómo se gestionan los nodos al encolar y desencolar elementos y las implicaciones en términos de eficiencia y seguridad.**



**2. ¿Qué desafíos específicos presenta la implementación de una queue en comparación con un stack en términos de gestión de memoria? Considera las diferencias en el manejo de punteros front y rear, y cómo estos afectan el proceso de encolado y desencolado.**



**3. ¿Cómo afecta la estructura FIFO (First In, First Out) de una queue a su uso en diferentes tipos de problemas? Analiza cómo la estructura FIFO influye en la resolución de problemas donde el orden de procesamiento es crucial, como en sistemas de colas de espera.**



**4. ¿Cómo podrías implementar una queue circular y cuál sería su ventaja respecto a una queue lineal en términos de uso de memoria? Reflexiona sobre cómo una queue circular puede mejorar la eficiencia en ciertos contextos y qué cambios serían necesarios en la implementación.**



**5. ¿Qué problemas podrían surgir si no se gestionan correctamente los punteros front y rear en una queue, y cómo podrías evitarlos? Considera posibles errores como la pérdida de referencias a nodos y cómo una gestión cuidadosa de los punteros puede prevenir estos problemas.**




