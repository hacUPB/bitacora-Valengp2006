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

### Evidencia de los resultados de aprendizaje:

**RAE1: Construcción de aplicaciones interactivas**

Construí la aplicación Nebulosas Vivas, aplicando estructuras de datos y estrategias de programación para cumplir con los requisitos funcionales y no funcionales:

- **Lista enlazada (list):** gestión de partículas de nebulosa que nacen, crecen, se expanden y se eliminan automáticamente cuando mueren.
- **Cola (queue):** rotación de colores que define la energía cromática de las nebulosas al hacer clic derecho.
- **Vector:** conjunto de estrellas de fondo con parpadeo dinámico que aportan al realismo visual.
- **Interactividad:**
    - Clic izquierdo → genera partículas o filamentos gaseosos.
	- Arrastre de mouse → dibuja nebulosas continuas.
	- Clic derecho → rota los colores activos.

**Evidencia:**

- Captura 1: Nebulosa formada con partículas en expansión.
	<img width="2272" height="1804" alt="Captura de pantalla 2025-09-09 a la(s) 4 30 01 p m" src="https://github.com/user-attachments/assets/56735393-0118-4345-8356-806bf0301c80" />
- Captura 2: Filamentos gaseosos al arrastrar el mouse.
  <img width="2272" height="1804" alt="Captura de pantalla 2025-09-09 a la(s) 4 30 10 p m" src="https://github.com/user-attachments/assets/d38c7fd8-5ca8-4324-af7c-2307db30b487" />
- Captura 3: Rotación de colores tras clic derecho.
  <img width="2272" height="1804" alt="Captura de pantalla 2025-09-09 a la(s) 4 30 18 p m" src="https://github.com/user-attachments/assets/c1d097c8-0b39-4197-a393-df130e0fb59b" />
- Captura 4: Fondo estelar con parpadeo activo.
	<img width="2272" height="1804" alt="Captura de pantalla 2025-09-09 a la(s) 4 29 42 p m" src="https://github.com/user-attachments/assets/d0d54cf5-5ab0-41f6-8bc3-8101ee8a6e87" />

### RAE2: Pruebas de software

Realicé pruebas tanto de las partes como del programa completo para garantizar el correcto funcionamiento:

- **Prueba de partículas (unidad):** verifiqué que cada partícula se expanda, se desplace con ruido y desaparezca al llegar a opacidad cero.
- **Prueba de la cola de colores:** confirmé que al presionar clic derecho los colores se roten correctamente y el nuevo color se aplique a las partículas siguientes.
- **Prueba de estrellas:** comprobé que todas aparecen con posiciones aleatorias y que su parpadeo se mantenga activo durante la ejecución.
- **Prueba de interacción con mouse:** validé que cada evento (mousePressed, mouseDragged, mouseReleased) afecte a las estructuras de datos correctas.
- **Prueba de integración:** ejecuté el programa completo, interactuando con todos los elementos simultáneamente (dibujar nebulosas mientras cambian los colores y el fondo parpadea).

**Evidencia:**

- Captura 5: Prueba de partículas desapareciendo tras cierto tiempo.
  <img width="2272" height="1804" alt="Captura de pantalla 2025-09-09 a la(s) 4 30 34 p m" src="https://github.com/user-attachments/assets/89c53bb9-bc89-4e7e-9d28-91e605f6ca97" />

### Vídeo de evidencia

[Enlace al video de evidencia](https://youtu.be/vxvf1Pi-2pY?si=nv3TlxdSPbTIpFNN)
