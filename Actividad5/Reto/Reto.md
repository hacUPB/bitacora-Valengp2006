# Reto - 24/09/2025
### Idea base: Cielo estrellado dinámico

**¿Qué hace el programa?**

- En el fondo se dibujan cientos de partículas (estrellas).
- Cada estrella tiene posición, tamaño, brillo e intensidad de parpadeo.
- Algunas estrellas pueden “morir” y reaparecer en otra parte del cielo (simulando que titilan o se ocultan).
- Con el tiempo, el fondo cambia de densidad y color (simulando movimiento galáctico).
- Supernova: cuando se activa, ciertas estrellas pasan por un ciclo:
    - Incremento progresivo de tamaño y brillo.
    - Explosión → flash que llena la pantalla.
    - Remanente → halo expansivo que se desvanece.
    - Regeneración → la estrella “renace” en otra posición como una normal.

**Controles**

- `mouse drag`: atrae estrellas hacia el cursor como si fuera un agujero negro.
- `tecla 1`: cambia a modo “titileo lento”.
- `tecla 2`: modo “supernova”: algunas estrellas explotan y generan chispas.
- `tecla 3`: modo “cometas” (estrellas con cola que cruzan la pantalla).
- `tecla c`: limpiar y regenerar estrellas.

**POO aplicada**

- `class Star`:
  - **Atributos:** pos, size, brightness, twinkleSpeed.
  - **Métodos** update(), draw().
- `class StarSystem`: gestiona todas las estrellas (vector).

**Herencia:**

- `class TwinklingStar : public Star`: titila de forma sinusoidal (su brillo o intensidad no es constante, sino que sube y baja suavemente siguiendo una onda seno)
- `class ShootingStar : public Star`: se mueve rápido con cola.
- `class SupernovaStar : public Star`: la estrella aumenta de tamaño y brillo; genera un flash que ocupa toda la pantalla; dibuja un halo de colores que se expande y desaparece; la estrella se considera muerta y reaparece en otra parte como una nueva estrella.

**Polimorfismo:**

- `vector<unique_ptr<Star>> stars;` en donde:
    - `vector` es un arreglo dinámico de C++ que puede crecer o reducirse según la cantidad de elementos.
    - `unique_ptr<Star>` es un puntero inteligente que se asegura de que cada objeto que creemos en memoria se destruya automáticamente cuando ya no se use.
    - En lugar de crear un Star* y preocuparnos por delete, usamos unique_ptr y C++ lo limpia solo.
    - En conjunto, significa: "Tengo un vector que guarda un montón de estrellas, pero cada estrella puede ser de un tipo distinto (normal, fugaz, supernova), siempre tratadas como si fueran Star."
- `for(auto& s : stars) { s->update(); s->draw(); }`:
    - Este bucle recorre todas las estrellas del vector.
    - Como cada estrella es un unique_ptr<Star>, usamos s-> para acceder al objeto apuntado.
    - Llamamos a dos métodos:
        - update() → actualiza la posición, brillo, movimiento o estado de la estrella.
        - draw() → la dibuja en pantalla.
    - Así, como usamos OOP ocurre lo siguiente:
        - Si s es una TwinklingStar, su update() hará que titile.
        - Si s es una ShootingStar, su update() hará que se mueva con cola.
        - Si s es una SupernovaStar, su update() manejará la explosión.
    - Gracias al polimorfismo, no importa qué tipo real de estrella haya dentro del vector: el bucle las trata a todas como Star, pero en tiempo de ejecución se ejecuta el comportamiento correcto.

### Experimentación:

**Procedimiento:**

- Implementé dos versiones del proyecto:
	- Con polimorfismo: clases base y derivadas con métodos virtuales.
	- Sin polimorfismo: clases concretas sin herencia ni virtual.
- Incorporé código para registrar en consola:
    - FPS promedio.
	- Tiempo promedio por frame.
	- Memoria utilizada.
	- Número de partículas en escena.
- Ejecuté varias pruebas en ambas versiones para obtener datos comparativos.

**Resultados**

| Versión              | FPS promedio      | Tiempo/frame (ms) | Memoria usada | Num. partículas |
|-----------------------|------------------:|------------------:|--------------:|----------------:|
| Con polimorfismo      | 58,000 – 107,000 | 0.015 – 0.017     | ~107 MB       | 200 – 209       |
| Sin polimorfismo      | 70,000 – 105,000 | 0.012 – 0.014     | ~109 MB       | 200 – 203       |

**Análisis:**

- El polimorfismo introduce una pequeña sobrecarga debido al uso de la vtable en llamadas a métodos virtuales.
- En escenas con pocas partículas, la diferencia es casi imperceptible.
- En escenas con muchas partículas, la versión sin polimorfismo logró un incremento del 10–15% en FPS promedio.
- El consumo de memoria fue prácticamente idéntico en ambas versiones.
- Decisión de diseño:
    - Extensibilidad y claridad → mantener polimorfismo.
	- Máxima eficiencia → eliminar polimorfismo.

**Conclusión:**

Las pruebas confirman que las decisiones de diseño OOP afectan el rendimiento en aplicaciones de arte generativo. Aunque el impacto en memoria es despreciable, el uso de métodos virtuales puede ralentizar el tiempo de ejecución cuando se escala el número de partículas.

#### Evidencias:



- El uso de **polimorfismo** facilita la extensibilidad y el orden en el diseño OOP, pero introduce una ligera sobrecarga en el rendimiento debido a las llamadas virtuales dinámicas.  
- En la prueba, la versión **sin polimorfismo** mostró un incremento en los FPS promedio (mayor fluidez) y una reducción en el tiempo por frame, aunque con un uso de memoria apenas superior.  
- La diferencia de rendimiento, aunque medible, no es significativa en el contexto del proyecto de arte generativo, por lo que el **beneficio de claridad y escalabilidad del polimorfismo** puede justificar su uso.  
- La elección final depende del objetivo:  
  - **Optimización máxima:** reducir o eliminar el polimorfismo.  
  - **Mantenibilidad y facilidad para expandir el sistema:** mantener polimorfismo y jerarquía de clases.  


**Ayúdame a revisar mi proyecto para asegurarme de que sigo las mejores prácticas de programación orientada a objetos en C++. ¿Qué aspectos debo considerar en términos de encapsulamiento, herencia y polimorfismo?**

**Encapsulamiento:**

- Visibilidad adecuada:
	- Asegúrarse de que los atributos (pos, size, brightness, etc.) sean privados o protegidos (private/protected) y que solo se accedan mediante métodos públicos si es necesario.
	- Ejemplo: en lugar de exponer directamente pos, puedes usar getPos() o setPos().
- Evitar datos públicos innecesarios:
	- En el código, varias variables están como public por simplicidad. Esto puede estar bien para un prototipo, pero para un proyecto más formal deberías restringir accesos para mantener la integridad del objeto.
- Responsabilidad clara de cada clase:
	- Star debería encargarse únicamente de representar una estrella base.
	- El control del ciclo de vida y la colección de objetos (agregar, eliminar, regenerar) corresponde a StarSystem. Esto está bien en tu diseño actual.

**Herencia:**

- Jerarquía lógica y coherente:
	- Star como clase base y TwinklingStar, ShootingStar, SupernovaStar como derivadas es una jerarquía correcta y fácil de extender.
	- Evita “herencia por herencia” (no tiene sentido crear subclases si no van a modificar comportamiento).
- Uso de override:
	- Ya es aplicado correctamente (void update() override, void draw() override). Esto mejora legibilidad y evita errores si la firma cambia.
- Destructor virtual:
	- Muy bien que se haga uso de `virtual ~Star() {}` en la clase base para evitar fugas de memoria.

**Polimorfismo:**

- Aplicación adecuada:
	- Uso de polimorfismo para que el StarSystem maneje de forma genérica objetos diferentes (TwinklingStar, ShootingStar, SupernovaStar) sin tener que distinguirlos manualmente. Esto es la esencia de OOP bien aplicada.
- Costo de rendimiento:
	- Evaluación del impacto con la versión sin polimorfismo. El resultado mostró que la diferencia existe, pero que para tu escala de proyecto es aceptable.
	- Esto demuestra que entendiste el equilibrio entre diseño y eficiencia, uno de los aprendizajes clave de OOP.

**Aspectos a mejorar:**

- Encapsular datos sensibles: convierte public → protected o private y expón solo lo necesario.
- Separar responsabilidades: considera mover la lógica de profiling a una clase o módulo aparte (ej. Profiler), en lugar de incluirla en ofApp.
- Documentación interna: agrega comentarios que expliquen el rol de cada clase y cada método virtual para reforzar mantenibilidad.
- Uso de unique_ptr: lo aplicas en StarSystem, excelente. Podrías añadir std::make_unique en todo el código para mayor consistencia.

**En conclusión:**

El proyecto sí sigue buenas prácticas OOP, especialmente en la separación entre Star y StarSystem, el uso de herencia lógica y el polimorfismo aplicado con unique_ptr. Lo único pendiente es reforzar encapsulamiento para que el código sea más robusto a largo plazo.

### Reflexión y ajuste Final

**Para las pruebas finales realicé diferentes escenarios de validación:**

- **Prueba de creación y comportamiento individual de objetos:** verifiqué que cada tipo de estrella (TwinklingStar, ShootingStar, SupernovaStar) cumpliera con su comportamiento específico (parpadeo, movimiento y explosión).
- **Prueba de interacción simultánea:** ejecuté la aplicación con múltiples instancias de cada clase para asegurar que no hubiera conflictos y que los métodos polimórficos funcionaran de manera independiente.
- **Prueba de rendimiento:** medí los FPS en escenas con gran número de objetos para confirmar que el sistema mantenía un desempeño fluido.

**En cuanto a las buenas prácticas de POO en C++, consideré los siguientes aspectos:**

- **Encapsulamiento:** probé que los atributos sensibles no se modificaran de forma directa desde fuera de la clase, sino que se gestionaran mediante métodos públicos controlados. Esto evita inconsistencias en el estado de los objetos.
- **Herencia**: confirmé que la jerarquía definida era coherente (una ShootingStar es una Star) y que cada clase derivada extendía o especializaba el comportamiento sin duplicar código innecesario.
- **Polimorfismo:** verifiqué que las llamadas a update() y draw() se resolvieran correctamente en tiempo de ejecución según el tipo de objeto, garantizando flexibilidad para añadir nuevas variantes de estrellas sin modificar la estructura existente.

**Reflexión personal:**

El entendimiento de los mecanismos internos de la POO influyó directamente en la claridad del diseño. Comprender cómo funciona el polimorfismo me permitió organizar el código de forma más extensible, y al mismo tiempo pude medir que su impacto en el rendimiento era mínimo en comparación con los beneficios de mantenibilidad.

Los desafíos más grandes estuvieron en equilibrar la eficiencia con un diseño limpio. En pruebas iniciales intenté simplificar quitando virtual, pero comprobé que la pérdida de extensibilidad no justificaba la ganancia en FPS. Aprendí que en proyectos de arte generativo es más importante mantener un diseño robusto y flexible que obsesionarse con micro-optimizaciones.

### Evidencias de los resultados de aprendizaje

**RAE1 – Construcción de aplicaciones interactivas**

- La aplicación cumple con los requisitos funcionales del reto: cada estrella responde a un patrón diferente (parpadeo, movimiento lineal, supernova).
- Realicé pruebas visuales y capturas de pantalla que muestran las distintas fases del sistema en funcionamiento:
	- Escena con estrellas parpadeando en diferentes posiciones.
	- Trayectorias de estrellas fugaces cruzando la pantalla.
	- Animación de supernova expandiéndose y desapareciendo.
- Estas capturas demuestran que la obra de arte generativo se comporta como fue planeado y satisface los requisitos establecidos.

**RAE2 – Pruebas de partes y del todo**

- **Pruebas unitarias (partes):** validé cada clase hija de manera aislada para comprobar que los métodos update() y draw() generaran el comportamiento esperado. Ejemplo: en ShootingStar, verifiqué que al llegar al borde de la pantalla la estrella se reposicionara correctamente.
- **Pruebas de integración (el todo):** ejecuté la aplicación con todas las clases activas simultáneamente para asegurar que no hubiera conflictos y que la interacción entre los diferentes tipos de estrellas mantuviera la coherencia visual.
- **Pruebas de robustez:** aumenté intencionalmente el número de instancias hasta el límite de rendimiento aceptable para comprobar que el sistema se mantenía estable.

Con estas pruebas, evidencio que logré un nivel resolutivo en la construcción de la aplicación (RAE1) y un nivel autónomo en la aplicación de pruebas siguiendo metodologías básicas de validación (RAE2).