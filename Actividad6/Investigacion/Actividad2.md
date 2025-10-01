# Sesión 2: análisis de un caso de estudio - 01/10/2025

**¿Qué hace el patrón Observer en este caso?**

Está representado en las clases `Observer` y `Subject`.

- La clase `Observer` define el método `onNotify`, que permite que cualquier clase que lo implemente pueda “escuchar” eventos.
- La clase `Subject` mantiene una lista de observadores suscritos y los notifica con el método `notify`.
- En el `setup` de `ofApp`, las partículas se registran como observadores. Así, cuando el usuario presiona una tecla, `ofApp` envía un evento (ejemplo: `"stop"`, `"attract"`, `"repel"`, `"normal"`).
- Luego, cada partícula recibe ese evento en `Particle::onNotify` y cambia su comportamiento dependiendo de lo que se haya notificado.
- En resumen: permite que **todas las partículas reaccionen automáticamente a las teclas**, sin que `ofApp` tenga que controlarlas una por una.

**¿Qué hace el patrón Factory en este caso?**

Está representado en la clase `ParticleFactory`.

- Este patrón se encarga de **crear diferentes tipos de partículas** (`star`, `shooting_star`, `planet`) con distintos atributos como tamaño, color y velocidad.
- Así se evita tener que crear clases separadas para cada tipo de partícula. En lugar de eso, la lógica de inicialización está centralizada en un solo lugar.
- En resumen: facilita **crear partículas con diferentes características** sin duplicar código.

**¿Qué hace el patrón State en este caso?**

Está representado en las clases `State` y sus derivados (`NormalState`, `AttractState`, `RepelState`, `StopState`).

- Cada partícula tiene un puntero a un `State`, que define cómo se va a actualizar en cada frame.
- Cuando se cambia de estado con `setState`, el estado anterior se elimina y se asigna el nuevo.
- Luego, en el método `update`, la partícula ejecuta el comportamiento correspondiente a su estado actual (moverse normalmente, acercarse al mouse, alejarse del mouse o detenerse).
- En resumen: permite que **una misma partícula cambie de comportamiento dinámicamente**, dependiendo del estado en el que esté.

**Diagrama de relaciones**

```
               +-----------------+
               |     ofApp       |
               |   (Subject)     |
               +-----------------+
                   |   notify()
                   v
         -------------------------------
         |   Particles (Observers)     |
         |   implement onNotify()      |
         -------------------------------
                   |
                   | setState()
                   v
        +-------------------+
        |   State (base)    |
        |-------------------|
        | + update()        |
        | + onEnter()       |
        | + onExit()        |
        +---------+---------+
                  |
   --------------------------------------------
   |                |               |          |
+----------+   +------------+   +---------+  +---------+
| Normal   |   | Attract    |   | Repel   |  | Stop    |
| State    |   | State      |   | State   |  | State   |
+----------+   +------------+   +---------+  +---------+


            +-------------------------+
            |   ParticleFactory       |
            +-------------------------+
            | createParticle(type)    |
            +-------------------------+
                   |
                   v
         --------------------------------
         |   Creates different types     |
         |   of Particles:               |
         |   - "star"                    |
         |   - "shooting_star"           |
         |   - "planet"                  |
         --------------------------------
```

- **Observer:**

  - `ofApp` (Subject) → manda notificaciones (`notify()`) cuando presionas una tecla.
  -Todas las `Particle` (Observers) → escuchan el evento en `onNotify()` y cambian de estado.

- **State:**

  - Cada `Particle` tiene un puntero `state`.
  - Según el estado actual (`NormalState`, `AttractState`, `RepelState`, `StopState`), la partícula se comporta diferente en `update()`.

- **Factory:**

  - `ParticleFactory` → se encarga de crear partículas con distintas características (`star`, `shooting_star`, `planet`).
  - Así `ofApp` puede pedir partículas ya configuradas sin preocuparse por sus detalles.

