# Reto
### Idea base: Cielo estrellado dinámico

**¿Qué hace el programa?**

- En el fondo se dibujan cientos de partículas (estrellas).
- Cada estrella tiene posición, tamaño, brillo e intensidad de parpadeo.
- Algunas estrellas pueden “morir” y reaparecer en otra parte del cielo (simulando que titilan o se ocultan).
- Con el tiempo, el fondo cambia de densidad y color (simulando movimiento galáctico).

**Controles**

- `mouse drag`: atrae estrellas hacia el cursor como si fuera un agujero negro.
- `tecla 1`: cambia a modo “titileo lento”.
- `tecla 2`: modo “supernova”: algunas estrellas explotan y generan chispas.
- `tecla 3`: modo “cometas” (estrellas con cola que cruzan la pantalla).
- `tecla c`: limpiar y regenerar estrellas.

**POO aplicada**

- `class Star`: atributos pos, size, brightness, twinkleSpeed. Métodos update(), draw().
- `class StarSystem`: gestiona todas las estrellas (vector).

**Herencia:**

- `class TwinklingStar : public Star` (titila de forma sinusoidal).
- `class ShootingStar : public Star` (se mueve rápido con cola).
- `class SupernovaStar : public Star` (al morir genera chispas).

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

