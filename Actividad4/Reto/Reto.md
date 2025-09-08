## Nebulosas vivas

**1. Exploración creativa: ¿Qué tipo de efecto visual quieres lograr? ¿Cómo pueden ayudarte las diferentes estructuras de datos a lograr ese efecto?**

En esta obra generativa quiero lograr un efecto visual que evoque la experiencia de observar el espacio profundo. El objetivo es que las nebulosas se perciban como nubes gaseosas en constante transformación, con un movimiento orgánico gracias al uso del Ruido de Perlin. Estas nubes se expanden, cambian de color y se desvanecen lentamente, transmitiendo una sensación de respiración cósmica. El fondo estrellado refuerza la escala del universo y enmarca la interacción del usuario.

Las diferentes estructuras de datos me permiten construir y organizar estos efectos visuales de forma coherente:

- **Lista enlazada (std::list<Particle>):** utilizada para gestionar las partículas de las nebulosas, que nacen y mueren dinámicamente. Esto asegura que las nebulosas sean fluidas y cambiantes, evitando la acumulación innecesaria de memoria.
- **Cola (std::queue<ofColor>):** aplicada a la rotación de la paleta de colores. Con ella, las nebulosas adquieren distintos tonos de manera cíclica y predecible, lo que aporta un ritmo visual que el usuario puede modificar con un clic.
- **Arreglo (std::vector<Star>):** empleado para el fondo de estrellas, que permanece estático y estable. Funciona como un lienzo infinito sobre el cual emergen las nebulosas vivas.

**2. Gestión de memoria: ¿Qué consideraciones debes tener en cuenta al gestionar dinámicamente la memoria de los objetos? ¿Cómo asegurar que no haya fugas de memoria?**

Al trabajar con objetos creados dinámicamente, como las partículas de la nebulosa, es necesario establecer un control riguroso sobre su ciclo de vida. Una mala gestión puede producir fugas de memoria, es decir, que los objetos ocupen espacio en memoria sin ser utilizados ni eliminados.

En esta obra, las consideraciones principales son:

- **Definir claramente el ciclo de vida de los objetos**: cada partícula nace al interactuar con el mouse, se expande y desvanece, y debe eliminarse cuando su opacidad llega a cero.
- **Liberar la memoria oportunamente:** en el `update()` se recorre la lista enlazada de partículas, y aquellas que ya no tienen visibilidad se eliminan. Esto asegura que no permanezcan ocupando memoria innecesariamente.
- **Usar estructuras adecuadas:** la lista enlazada facilita el borrado dinámico de elementos sin generar inconsistencias en índices o referencias.
- **Evitar acumulación de recursos estáticos:** la cola de colores se mantiene con un número fijo de elementos, evitando que crezca indefinidamente.
- **Mantener simples los objetos persistentes:** las estrellas de fondo se generan una vez y permanecen constantes, sin necesidad de liberación repetida.

Así, se asegura que la obra funcione de manera sostenible y eficiente, evitando saturar la memoria aunque el usuario interactúe durante largos periodos.

**3. Interacción y dinamismo: ¿Cómo puedes hacer que la interacción del usuario influya en múltiples estructuras de datos simultáneamente para crear un efecto visual coherente y dinámico?**



**4. Optimización: ¿Qué técnicas puedes implementar para optimizar la gestión de memoria y el rendimiento de tu aplicación mientras mantienes una experiencia visual rica y fluida?Ejemplo de idea:«Lluvia de colores:» crea una simulación de gotas de lluvia de colores que caen desde la parte superior de la pantalla. Usa un arreglo para almacenar las posiciones iniciales de las gotas y una pila para apilar nuevas gotas a medida que se generan. Al liberar las gotas que han caído fuera de la pantalla, asegúrate de gestionar y liberar correctamente la memoria.**