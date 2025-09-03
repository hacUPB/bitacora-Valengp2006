### Actividad 2:

En esta actividad vas a experimentar con pilas y colas en un contexto de arte generativo. El código incluye la gestión de memoria.

Gestión de memoria: se maneja explícitamente la liberación de memoria mediante las funciones clear(). Nota que también se llama a clear() en el destructor de las clases Stack y Queue para asegurar que la memoria se libere cuando los objetos se destruyen.

Vas a reportar en tu bitácora de aprendizaje:

1. **Entendiendo la aplicación**: comienza explorando detenidamente cómo funciona el programa. Usa un un modelo del lenguaje como ChatGPT y el depurador para que verifiques las explicaciones que te propone ChatGPT. Puedes escribir el prompt: quiere entender de manera muy detallada el siguiente programa escrito en C++ y el openframeworks. Luego le das el código. Ve preguntando lo que no entiendas. recuerda ir usando al mismo tiempo el depurador de visual studio.
2. **Realiza evaluaciones formativas**. Dile a ChatGPT que te genere preguntas para verificar si entiendes cómo funciona el programa. Trata de verificar tus hipótesis usando el depurador y luego con las conclusiones del experimento responde la pregunta de ChatGPT. Continúa con este proceso hasta que estés seguro de que entiendes cómo funciona el programa.
3. **Pruebas:** pregunta a ChatGPT cómo podrías probar las partes del programa y el programa completo. Luego realiza las pruebas y verifica si los resultados coinciden con tus expectativas.

Preguntas de reflexión para el stack:

1. ¿Cómo se gestiona la memoria en una implementación manual de un stack en C++? Reflexiona sobre cómo el uso de new y delete en la creación y destrucción de nodos afecta el rendimiento y la seguridad de tu programa.
2. ¿Por qué es importante liberar la memoria cuando se desapila un nodo en un stack? Considera las consecuencias de no liberar memoria en términos de fugas de memoria y cómo esto puede impactar aplicaciones de largo tiempo de ejecución.
3. ¿Qué diferencias existen entre usar un stack de la STL (std::stack) y crear un stack manualmente? Explora cómo la abstracción que proporciona la STL puede simplificar la implementación, pero también cómo una implementación manual ofrece mayor control sobre la gestión de recursos.
4. ¿Cómo afecta la estructura de un stack al orden de acceso y eliminación de elementos? Analiza cómo la naturaleza LIFO (Last In, First Out) del stack influye en los tipos de problemas que esta estructura de datos puede resolver eficientemente.
5. ¿Cómo podrías modificar el stack para almacenar tipos de datos más complejos (e.g., objetos con múltiples atributos) sin causar problemas de memoria? Reflexiona sobre cómo gestionar adecuadamente la memoria para objetos más complejos y cómo esto afectaría tu implementación actual.

Preguntas de autoevaluación:

1. ¿Puedo explicar detalladamente cómo funciona el proceso de apilar y desapilar nodos en un stack, incluyendo la gestión de memoria?
2. ¿Soy capaz de identificar y corregir una fuga de memoria en una implementación de stack manual?
3. ¿Puedo modificar el stack para que incluya una función que busque un elemento específico, sin alterar el orden de los elementos apilados?
4. ¿Entiendo cómo la estructura LIFO del stack afecta el flujo de datos y puedo dar ejemplos de problemas que se resuelvan mejor con un stack?
5. ¿Puedo implementar y depurar un stack para tipos de datos más complejos, asegurándome de que no haya fugas de memoria ni errores de puntero?

Preguntas de reflexión para la queue:

1. ¿Cómo se maneja la memoria en una implementación manual de una queue en C++? Reflexiona sobre cómo se gestionan los nodos al encolar y desencolar elementos y las implicaciones en términos de eficiencia y seguridad.
2. ¿Qué desafíos específicos presenta la implementación de una queue en comparación con un stack en términos de gestión de memoria? Considera las diferencias en el manejo de punteros front y rear, y cómo estos afectan el proceso de encolado y desencolado.
3. ¿Cómo afecta la estructura FIFO (First In, First Out) de una queue a su uso en diferentes tipos de problemas? Analiza cómo la estructura FIFO influye en la resolución de problemas donde el orden de procesamiento es crucial, como en sistemas de colas de espera.
4. ¿Cómo podrías implementar una queue circular y cuál sería su ventaja respecto a una queue lineal en términos de uso de memoria? Reflexiona sobre cómo una queue circular puede mejorar la eficiencia en ciertos contextos y qué cambios serían necesarios en la implementación.
5. ¿Qué problemas podrían surgir si no se gestionan correctamente los punteros front y rear en una queue, y cómo podrías evitarlos? Considera posibles errores como la pérdida de referencias a nodos y cómo una gestión cuidadosa de los punteros puede prevenir estos problemas.

Preguntas de autoevaluación:

1. ¿Puedo explicar claramente el proceso de encolar y desencolar nodos en una queue, incluyendo la gestión de memoria?
2. ¿Soy capaz de identificar y corregir problemas relacionados con la gestión de los punteros front y rear en una queue?
3. ¿Puedo modificar la queue para implementar una queue circular, entendiendo cómo esto afectaría la gestión de memoria?
4. ¿Entiendo cómo la estructura FIFO de una queue afecta el flujo de datos y puedo dar ejemplos de problemas que se resuelvan mejor con una queue?
5. ¿Puedo implementar y depurar una queue para tipos de datos más complejos, asegurándome de que no haya fugas de memoria ni errores de puntero?
