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
  - **Relación:**
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

### Explorando la memoria

- **¿Los atributos están almacenados de forma contigua?**

Sí, normalmente los atributos de un objeto se almacenan de manera contigua en memoria, uno tras otro, para facilitar el acceso rápido y eficiente. Esto se llama layout en memoria del objeto.

<img width="308" height="45" alt="Captura de pantalla 2025-09-15 171902" src="https://github.com/user-attachments/assets/48202087-1e12-4db2-877e-1e57a94b9869" />

- **¿Qué indica el tamaño del objeto sobre su estructura interna?**
  
  - El tamaño (sizeof(Particle)) indica cuánto espacio ocupa en memoria una instancia de esa clase.
  - Si solo tiene dos float, deberías esperar unos 8 bytes (2 × 4), pero si ves un tamaño mayor, puede deberse a padding de alineación que el compilador agrega para que los datos estén alineados en direcciones de memoria específicas, mejorando el rendimiento del procesador.

 <img width="373" height="66" alt="Captura de pantalla 2025-09-15 171647" src="https://github.com/user-attachments/assets/79513aad-1a4c-4e1c-a56e-c711bab44dc3" />

- **¿Cómo se almacenan los objetos en memoria en C++? Si tengo dos instancias de Particle, ¿Cómo se relacionan sus direcciones de memoria? ¿Los atributos están contiguos?**

    - En C++, cuando creas objetos de una clase, el compilador **reserva un bloque de memoria para cada instancia**. Cada bloque contiene el espacio necesario para **todos los atributos no estáticos** de esa clase.
    - Cada **objeto ocupa un bloque contiguo de memoria**.
    - Dentro de ese bloque, sus **atributos (variables miembro) también se almacenan de forma contigua**, en el mismo orden en que fueron declarados en la clase.
    - Puede haber pequeños **espacios vacíos (padding)** entre atributos para que estén alineados en direcciones de memoria que el procesador maneje más eficientemente.

<img width="328" height="102" alt="Captura de pantalla 2025-09-15 172012" src="https://github.com/user-attachments/assets/d735de79-7f90-405c-a916-3729d47e88f6" />

  - **Relación entre las direcciones de `p1` y `p2`:**
      - `&p1` y `&p2` devolverán las **direcciones base** de cada objeto.
      - Son **direcciones completamente independientes**, porque el compilador reserva espacio separado para cada uno.
      - No están necesariamente una al lado de la otra: su posición depende de cómo el compilador organice la memoria en ese momento.

  - **Direcciones internas (atributos):**
      - `&(p1.x)` y `&(p1.y)` normalmente estarán **una inmediatamente después de la otra** (por ejemplo: `0x1000` y `0x1004` si cada `float` ocupa 4 bytes).
      - Esto muestra que los **atributos dentro de un objeto están almacenados de forma contigua**.

- **Resumen corto**

  - Cada objeto ocupa un bloque de memoria propio.
  - Los atributos dentro de ese bloque están contiguos.
  - Dos objetos distintos (`p1` y `p2`) están en direcciones distintas e independientes entre sí.

