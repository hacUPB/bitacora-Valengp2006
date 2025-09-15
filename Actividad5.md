# Sesión 1: la naturaleza de los objetos en C++
### Introducción a los objetos - 16/09/2025

- **¿Qué representa la clase Particle?**

La clase `Particle` representa un objeto, en el cual cada instancia de esta clase tiene dos atributos (`x` y `y`) que indican su posición en dicho plano. Estos valores son de tipo `float`, lo que permite representar posiciones con decimales y mayor precisión.

- **¿Cómo interactúan sus atributos y métodos?**

  - Los atributos `x` y `y` almacenan la posición actual de la partícula.
  - El método `move(float dx, float dy)` permite modificar esa posición sumando un desplazamiento en el eje `x` (`dx`) y en el eje `y` (`dy`).
  - Cada vez que se llama al método `move`, la partícula “se mueve” a una nueva posición en el plano.
  - **Ejemplo conceptual:**
      - Si la partícula está en `(2, 3)` y llamamos a `move(1, -2)`, su nueva posición será `(3, 1)`.

- **¿Qué es un objeto en C++? ¿cómo se relaciona con una clase?**

  - Una **clase** en C++ es un **plano o plantilla** que define qué **atributos (datos)** y **métodos (comportamientos)** tendrán sus instancias.
  - Un **objeto** es una **instancia concreta creada a partir de una clase**: ocupa memoria, tiene valores propios en sus atributos y puede ejecutar los métodos definidos en su clase.
  
**Relación:**

- La clase es el **molde** y el objeto es el **producto construido con ese molde**.
- Puedes crear muchos objetos a partir de una sola clase, y cada uno mantiene su propio estado independiente.

**Ejemplo:**

```cpp
class Particle {
public:
    float x, y;
    void move(float dx, float dy) {
        x += dx;
        y += dy;
    }
};

Particle p;      // ← p es un objeto (instancia de Particle)
p.x = 1; p.y = 2;
p.move(3, -1);    // ahora p.x == 4 y p.y == 1
```

Aquí `Particle` es la **clase** y `p` es un **objeto** que existe en memoria y puede usar los atributos y métodos de su clase.
