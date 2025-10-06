## Proyecto: Constelaciones Vivas - 06/10/2025

### Concepto

El usuario crea estrellas con clics o teclas, y estas se conectan dinámicamente formando constelaciones animadas.

El sistema cambia el estilo visual y el comportamiento según el estado cósmico actual (ejemplo: calma, tormenta solar, explosivo).

### Aplicación de Patrones

**Observer:**

- Los eventos de entrada (clics del mouse, teclas, micrófono, incluso movimiento del mouse) son observados por el sistema.
- Cuando ocurre un evento → notifica a los observadores, que pueden ser:
- Sistema de generación de estrellas.
- Sistema de animación de conexiones.
- Sistema de efectos visuales (colores, partículas, explosiones).

**Factory:**

- Una fábrica de cuerpos celestes crea distintos elementos:
- Estrella básica.
- Estrella variable (cambia de tamaño/luminosidad).
- Cometa (estrella con cola animada).
- Planeta.
- Cada tipo se instancia dinámicamente dependiendo del estado cósmico y de la interacción.

**State:**

- El cielo tiene estados cósmicos que afectan cómo se comportan las estrellas y conexiones:
	1.	**Tranquilo:** pocas conexiones, colores suaves (azules, violetas).
	2.	**Tormentoso:** muchas conexiones, estrellas parpadeantes, rayos simulados.
	3.	**Explosivo:** estrellas que se expanden, conexiones caóticas, colores cálidos intensos.
- El motor del cielo cambia de estado según las interacciones del usuario o el paso del tiempo.