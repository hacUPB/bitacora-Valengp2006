## Proyecto: Cielo Generativo Interactivo - 06/10/2025

### Descripción del Proyecto

Este proyecto consiste en un sistema de arte generativo en tiempo real desarrollado en C++ con openFrameworks. El sistema simula un cielo dinámico que cambia entre diferentes estados atmosféricos de forma artística y abstracta.

Los estados disponibles son:

1. Cielo calmado → Estrellas y partículas suaves.
2.	Tormenta → Lluvia intensa, relámpagos y movimiento brusco.
3.	Nublado → Formación de nubes densas y cambiantes.

Cada estado presenta una composición visual diferente, evocando un fenómeno natural a través de patrones visuales generativos.

### Interacciones del Usuario

El usuario puede cambiar de estado con las teclas:

-	1 → Cielo calmado
-	2 → Tormenta
-	3 → Nublado

Además, cada estado posee interacciones específicas:

- **Estado Calmado**
	- Mouse clic: genera destellos brillantes.
	- Tecla +: agrega estrellas al cielo.
	- Tecla -: elimina estrellas.

- **Estado Tormenta**
	- Mouse clic: lanza un rayo en la posición del cursor.
	- Tecla ↑: aumenta la intensidad de la lluvia.
	- Tecla ↓: disminuye la intensidad de la lluvia.
	- Tecla r: genera un rayo en el centro de la pantalla.

- **Estado Nublado**
	- Mouse clic: abre un “hueco” en las nubes, como un rayo de sol.
	- Tecla ↑: incrementa la densidad general de nubes.
	- Tecla ↓: reduce la densidad de nubes.
	- Tecla c: limpia los huecos y regenera las nubes.

## Patrones de Diseño Implementados:

- **State**
	- Define el comportamiento del sistema según el estado actual del cielo.
	- Cada estado (CalmState, StormState, CloudyState) contiene su propia lógica de update, draw e interacciones.
	- Permite transiciones fluidas sin alterar la estructura del programa.

- **Factory**
	- Encargado de crear los estados cuando el usuario cambia con las teclas (1, 2, 3).
	- Centraliza la lógica de instanciación y facilita extender el sistema (por ejemplo, agregar un estado de “Aurora”).
	- Aporta escalabilidad y reduce acoplamiento en el código.

- **Observer**
	- Implementa un sistema de notificación automática: cuando el estado cambia, los observadores (HUD, interfaz, subsistemas gráficos) reciben la actualización.
	- Garantiza que siempre se muestre el estado actual y sus interacciones sin necesidad de modificar múltiples módulos.

### Conclusión

El proyecto combina arte generativo con patrones de diseño de software, logrando una experiencia interactiva donde el usuario no solo observa un paisaje visual, sino que lo transforma en tiempo real.

Gracias a la arquitectura basada en State, Factory y Observer, el sistema resulta flexible, organizado y preparado para escalar con nuevos estados e interacciones.

