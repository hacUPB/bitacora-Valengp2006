# Actividad 2 - 21/10/2025

## Experimento inicial

Antes de ejecutar el código original, se modificó el método draw() para desactivar temporalmente el shader:

```cpp
void ofApp::draw(){
    ofSetColor(255);

    //shader.begin();

    ofDrawRectangle(0, 0, ofGetWidth(), ofGetHeight());

    //shader.end();
}
```

**Observaciones**

- La salida muestra un rectángulo blanco que cubre toda la ventana.
- Al no activar el shader, el color se mantiene uniforme y no se aplican efectos visuales adicionales.

**Código original con shaders:**

**Vertex Shader (shader.vert):**

```cpp
OF_GLSL_SHADER_HEADER

uniform mat4 modelViewProjectionMatrix;
in vec4 position;

void main(){
	gl_Position = modelViewProjectionMatrix * position;
}
```

**Fragment Shader (shader.frag):**

```cpp
OF_GLSL_SHADER_HEADER

out vec4 outputColor;

void main()
{
    // gl_FragCoord contiene las coordenadas del fragmento en la ventana.
    // Se usan para definir un color basado en la posición del píxel.
    
    float windowWidth = 1024.0;
    float windowHeight = 768.0;
    
	float r = gl_FragCoord.x / windowWidth;
	float g = gl_FragCoord.y / windowHeight;
	float b = 1.0;
	float a = 1.0;
	outputColor = vec4(r, g, b, a);
}
```

**Análisis de resultados**

- **¿Cómo funciona?**

El `vertex shader` calcula la posición de cada vértice del rectángulo en pantalla usando la matriz de proyección, mientras que el `fragment shader` asigna un color a cada píxel dependiendo de su posición en la ventana.

- **¿Qué resultados obtuviste?**

En pantalla se muestra un degradado de color que varía según las coordenadas x e y: el rojo aumenta de izquierda a derecha y el verde de arriba hacia abajo, mientras el azul permanece constante.

- **¿Estás usando un `vertex shader?`**

Sí. El `vertex shader` transforma los vértices del rectángulo en coordenadas adecuadas para la pantalla.

- **¿Estás usando un fragment shader?**

Sí. El `fragment shader` controla el color de cada píxel según su posición.

- **Analiza el código de los shaders. ¿Qué hace cada uno?**

	- El `vertex shader` se encarga de las transformaciones geométricas de los vértices, asegurando que el rectángulo se posicione correctamente en pantalla.
	- El `fragment shader` genera el color final de cada fragmento, utilizando las coordenadas de pantalla (`gl_FragCoord`) para crear un efecto de gradiente.

## Siguiendo el tutorial:


**Concepto base:**

En openFrameworks, un shader es un pequeño programa que corre en la GPU:

- `Vertex Shader:` manipula la posición de los vértices (geometría).
- `Fragment Shader:` define el color de cada pixel.

El flujo normal es:

1.	Cargar el shader (`shader.load()`).
2.	Comenzar el shader (`shader.begin()`).
3.	Dibujar una figura.
4.	Terminar el shader (`shader.end()`).

### Ejemplo 1 — Simple Shader

- **Ruta:** `openFrameworks/examples/shader/01_simpleShader`
- **Qué hace:** Pinta un degradado de color en pantalla usando las coordenadas de cada píxel.
- **Pasos:**
	1.	Abrir el proyecto con el *Project Generator*.
	2.	Ejecutar el programa.
	3.	Se verá una pantalla que cambia de color según `gl_FragCoord.x` y `gl_FragCoord.y`.
- **Explicación:**
	- El `vertex shader` solo pasa las coordenadas.
	- El `fragment shader` usa `gl_FragCoord` (posición del pixel) para definir el color RGB.
- **Modificación en `ofApp::draw()`:**

```cpp
// Prueba sin shader
//shader.begin();
ofDrawRectangle(0, 0, ofGetWidth(), ofGetHeight());
//shader.end();
```
**Resultado de ejecutar la aplicación sin modificar el código:**



**Resultado de ejecutar la aplicación luego de modificar el código:**



### Ejemplo 2 — Texture Shader

- **Ruta:** `openFrameworks/examples/shader/02_textureShader`

- **Qué hace:** Usa una imagen como textura dentro del shader.
- **Pasos:**
	1.	Asegurarse de que en `/bin/data`/ haya una imagen (tex0.jpg).
	2.	Ejecutar el proyecto.
	3.	Se verá la imagen texturizada, posiblemente con efectos de color controlados por el shader.
- **Explicación:**
	- El shader usa `sampler2DRect tex0;` para leer los colores de la imagen.
	- Se puede modificar el `fragment shader` para cambiar cómo se combinan los colores. Por ejemplo: `outputColor = texture(tex0, texCoordVarying) * vec4(1.0, 0.5, 0.5, 1.0);`

**Resultado de ejecutar la aplicación sin modificar el código:**



**Resultado de ejecutar la aplicación luego de modificar el código:**



### Ejemplo 3 — Texture Displacement

- **Ruta:** `openFrameworks/examples/shader/03_textureDisplacement`
- **Qué hace:** Desplaza la geometría (los vértices) de un plano usando una textura como mapa de desplazamiento.
- **Pasos:**
	1.	Abrir el proyecto.
	2.	Ejecutar y mover el mouse: se verá cómo la superficie parece moverse o deformarse.
	3.	En el `vertex shader`, la posición Y de los vértices se altera usando el valor de una textura (tex0).
- **Explicación:**
	- `texture(tex0, texcoord).r` obtiene la intensidad (canal rojo) del píxel.
	- Ese valor se usa para mover el vértice en el eje Y.

Esto introduce el concepto de usar texturas como datos, no solo como imágenes.

**Resultado de ejecutar la aplicación sin modificar el código:**



**Resultado de ejecutar la aplicación luego de modificar el código:**



### Ejemplo 4 — Multiple Shaders

- **Ruta:** `openFrameworks/examples/shader/04_multipleShaders`
- **Qué hace:** Aplica dos shaders diferentes a distintas partes de la escena (`multi-pass shading`).
- **Pasos:**
	1.	Abrir el proyecto.
	2.	Ejecutarlo.
	3.	Se verán dos secciones en pantalla con efectos distintos (por ejemplo, una con desplazamiento y otra con color).
- **Explicación:**
	- Se crean dos objetos ofShader.
	- Cada uno se aplica a un conjunto diferente de objetos o texturas.
	- Se introducen conceptos de render pass (primero aplicar un shader, luego otro encima).
