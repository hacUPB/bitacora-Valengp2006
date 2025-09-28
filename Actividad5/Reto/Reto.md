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

