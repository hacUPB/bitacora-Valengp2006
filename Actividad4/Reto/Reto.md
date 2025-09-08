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

Para lograr que la interacción con el usuario influya en múltiples estructuras de datos de forma simultánea para lograr el efecto visual, se hace uso de los siguientes controles:

- Con un clic izquierdo sostenido, el usuario activa la lista enlazada de partículas, generando filamentos gaseosos. Al mismo tiempo, estas partículas toman el color que se encuentra al frente de la cola, integrando así dos estructuras de datos en una sola acción.
- Con un clic izquierdo único, se añade una partícula aislada que expande su radio hasta desaparecer, reforzando la idea de nubes efímeras.
- Con un clic derecho, el usuario rota la paleta de la cola de colores, lo que modifica indirectamente cómo se perciben todas las nuevas partículas que se vayan añadiendo a la lista.

De esta manera, la interacción conecta la lista de partículas y la cola de colores, logrando un dinamismo coherente: el usuario no solo dibuja nebulosas, sino que también decide la energía cromática con la que estas se manifiestan.

**4. Optimización: ¿Qué técnicas puedes implementar para optimizar la gestión de memoria y el rendimiento de tu aplicación mientras mantienes una experiencia visual rica y fluida?Ejemplo de idea:«Lluvia de colores:» crea una simulación de gotas de lluvia de colores que caen desde la parte superior de la pantalla. Usa un arreglo para almacenar las posiciones iniciales de las gotas y una pila para apilar nuevas gotas a medida que se generan. Al liberar las gotas que han caído fuera de la pantalla, asegúrate de gestionar y liberar correctamente la memoria.**

Para mantener una experiencia visual rica y fluida, es necesario implementar técnicas de optimización que aseguren un buen rendimiento incluso con muchas partículas activas:

- **Eliminar partículas muertas:** en cada actualización se recorren las partículas y se eliminan aquellas cuya opacidad llegó a cero, liberando memoria.
- **Uso eficiente de estructuras de datos:** la lista enlazada permite insertar y borrar partículas sin problemas de índices, y la cola mantiene un tamaño fijo, evitando acumulación innecesaria.
- **Dibujado con modo aditivo:** el uso de OF_BLENDMODE_ADD permite que las partículas se acumulen visualmente sin necesidad de cálculos extra de fusión, optimizando la representación de gas luminoso.
- **Control del número de partículas:** se puede establecer un límite máximo de partículas activas, borrando las más antiguas si se supera ese umbral. Esto asegura fluidez incluso en interacciones prolongadas.
- **Reutilización de objetos:** como alternativa a borrar y crear constantemente, podrían reciclarse partículas reasignándoles nuevas posiciones y propiedades, minimizando operaciones de memoria.

Estas técnicas garantizan que el sistema pueda sostener miles de partículas en movimiento sin comprometer la experiencia interactiva, manteniendo la ilusión de una nebulosa viva que respira en el espacio profundo.
