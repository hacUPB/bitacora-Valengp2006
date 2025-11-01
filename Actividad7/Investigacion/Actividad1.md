# Actividad 1 - 20/10/2025

## Lista de conceptos fundamentales

| **Concepto** | **Definición breve** |
|---------------|----------------------|
| **GPU / GPU pipeline** | La GPU (Unidad de Procesamiento Gráfico) ejecuta tareas de renderizado mediante una cadena de etapas llamadas “pipeline”, que transforman datos 3D en píxeles visibles. |
| **Vertex shader** | Programa que procesa cada vértice del modelo, aplicando transformaciones de posición, rotación y proyección antes del renderizado. |
| **Fragment (pixel) shader** | Programa que calcula el color final de cada fragmento o píxel en pantalla, determinando iluminación, textura y efectos visuales. |
| **Uniforms y atributos** | Los *uniforms* son variables constantes durante un frame (por ejemplo, tiempo o resolución), mientras los *atributos* varían por vértice (como posición o color). |
| **Texturas y framebuffers (FBO)** | Una textura es una imagen usada en el shader; un FBO (Frame Buffer Object) permite renderizar la escena en una textura para aplicar post-procesado. |
| **Paralelismo masivo (SIMD / warps)** | La GPU ejecuta miles de hilos simultáneamente usando el modelo SIMD (Single Instruction, Multiple Data), procesando muchos fragmentos o vértices en paralelo. |
| **Varyings / interpolación** | Variables que transmiten datos del vertex shader al fragment shader; sus valores se interpolan automáticamente entre vértices. |
| **Render-to-texture** | Técnica donde el resultado del renderizado se guarda en una textura, que luego puede ser usada para efectos como desenfoque, reflejos o post-procesado. |

- **Preparación del entorno (openFrameworks)**

Se utilizaron los ejemplos de shaders incluidos en openFrameworks (carpeta examples/shaders).
Cada uno se abrió y ejecutó correctamente, verificando su compilación y comportamiento visual.

Ejemplo probados:
	- 01_simple

## Preguntas y respuestas

1. **¿Qué son los vértices?**

Los vértices son puntos en el espacio (2D o 3D) que definen la forma de los objetos gráficos. En 3D, cada vértice contiene información como su posición (x, y, z), color, coordenadas de textura y normales. Son los elementos básicos que forman las figuras geométricas en una escena.

2. **¿Con qué figura geométrica se dibuja en 3D?**

La figura base usada para representar objetos 3D es el triángulo. Toda superficie o modelo 3D se descompone en una malla de triángulos, ya que son la forma más simple y estable para representar planos en el espacio tridimensional.

3. **¿Qué es un shader?**

Un shader es un pequeño programa que se ejecuta en la GPU. Se usa para controlar cómo se dibujan los objetos en pantalla: su color, iluminación, textura y apariencia. Existen diferentes tipos de shaders (como vertex y fragment shaders), y se escriben generalmente en el lenguaje GLSL.

4. **¿Cómo se le llaman a los grupos de píxeles de un mismo triángulo?**

Se les llama fragmentos (fragments). Cada fragmento representa un posible píxel del triángulo en la pantalla, antes de decidir si realmente será visible.

5. **¿Qué es un fragment shader?**

El fragment shader es el programa que se ejecuta para cada fragmento. Determina el color final de cada píxel del objeto en pantalla, aplicando efectos como luces, sombras, transparencias o texturas.

6. **¿Qué es un vertex shader?**

El vertex shader se ejecuta para cada vértice de la malla. Su función es transformar la posición del vértice en el espacio 3D a coordenadas en la pantalla (2D). También puede modificar atributos como la iluminación o el color.

7. **¿Al proceso de determinar qué píxeles del display va a cubrir cada triángulo de una mesh se le llama?**

Ese proceso se llama rasterización. Convierte los triángulos definidos por vértices en fragmentos (píxeles) que la GPU puede procesar para mostrar en pantalla.

8. **¿Qué es el render pipeline?**

El render pipeline (tubería de renderizado) es la secuencia de etapas que sigue la GPU para transformar una escena 3D en una imagen 2D final. Incluye pasos como la transformación de vértices, rasterización, aplicación de shaders y escritura de píxeles en el framebuffer.

9. **¿Hay alguna diferencia entre aplicar un color a una superficie de una mesh o aplicar una textura?**

Sí, hay diferencias:

- Aplicar un color significa asignar un tono uniforme o calculado a toda la superficie.
- Aplicar una textura implica usar una imagen (bitmap) que se mapea sobre la superficie para darle detalles visuales como patrones, sombras o materiales.

10. **¿Cuál es la diferencia entre una textura y un material?**

- Una textura es una imagen que se aplica a una superficie.
- Un material define el comportamiento visual completo del objeto (cómo refleja la luz, si es brillante, metálico, transparente, etc.). Los materiales pueden incluir una o varias texturas y propiedades físicas.

11. **¿Qué transformaciones se requieren para mover un vértice del 3D world al View Screen?**

Se aplican tres transformaciones principales:

- Model Matrix → Mueve el objeto dentro del mundo.
- View Matrix → Posiciona la cámara.
- Projection Matrix → Convierte la escena 3D en una proyección 2D (perspectiva o ortográfica).

12. **¿Al proceso de convertir los triángulos en fragmentos se le llama?**

Ese proceso también se llama rasterización, donde se generan fragmentos (potenciales píxeles) a partir de las superficies triangulares.

13. **¿Qué es el framebuffer?**

El framebuffer es una porción de memoria en la GPU que almacena la imagen final que se va a mostrar en pantalla. Guarda información de color, profundidad y otros datos necesarios para el renderizado.

14. **¿Para qué se usa el Z-buffer o depth buffer en el render pipeline?**

El Z-buffer (o depth buffer) almacena la información de profundidad de cada píxel. Sirve para determinar qué objeto está más cerca de la cámara y evitar que se dibujen superficies que deberían quedar ocultas detrás de otras.