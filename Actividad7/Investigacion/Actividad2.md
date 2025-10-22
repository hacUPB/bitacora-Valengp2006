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

**Descripción:**

Este ejemplo genera un degradado de color que depende de la posición de cada píxel (`gl_FragCoord`).
El `vertex shader` solo pasa las coordenadas al `fragment shader`, donde se calcula el color final.

**Pasos:**

1. Abrir el proyecto en el *Project Generator* de openFrameworks.
2. Ejecutar el programa.
3. En pantalla se observa una transición de colores que cambia según las coordenadas en X y Y.

**Código de prueba (en `ofApp::draw()`):**

```cpp
// Prueba sin shader
//shader.begin();
ofDrawRectangle(0, 0, ofGetWidth(), ofGetHeight());
//shader.end();
```

Esto permite comparar la salida con y sin el uso del shader.


### Ejemplo 2 — Texture Shader

**Descripción:**

En este caso, el shader aplica una **textura (imagen)** a un plano.
Se utiliza la variable `sampler2DRect tex0` para acceder a los píxeles de la textura y combinar sus colores mediante código GLSL.

**Pasos:**

1. Verificar que en la carpeta `/bin/data/` exista la imagen `tex0.jpg`.
2. Ejecutar el proyecto.
3. Se visualizará la imagen renderizada como textura sobre una figura, pudiendo modificar su color o efecto desde el shader.

**Fragment Shader base:**

```glsl
outputColor = texture(tex0, texCoordVarying) * vec4(1.0, 0.5, 0.5, 1.0);
```

*Nota:* Si el color no parece modificarse, puede deberse a que la textura ya domina la salida de color. Cambiar los valores o multiplicar solo algunos canales (por ejemplo, `vec4(1.0, 0.2, 0.2, 1.0)`) puede evidenciar mejor el efecto.

**Explicación técnica:**

- `texture(tex0, texCoordVarying)` obtiene el color original del píxel de la textura.
- Multiplicarlo por un `vec4` cambia la intensidad de cada canal RGB antes de dibujarlo.
- Este ejemplo introduce la manipulación directa de texturas en la GPU.

### **Ejemplo 3 — Texture Displacement**

**Descripción:**

Este ejemplo desplaza los vértices de una malla usando una textura como mapa de desplazamiento.
El brillo de cada píxel en la textura afecta la posición Y de cada vértice, generando una apariencia de relieve o movimiento.

**Pasos:**

1. Abrir y ejecutar el proyecto.
2. Mover el mouse para observar cómo la superficie se deforma.
3. Analizar el `vertex shader`: allí se usa el valor del canal rojo de la textura para modificar la geometría.

**Explicación técnica:**

```glsl
float displacement = texture(tex0, texcoord).r;
vec4 newPosition = vec4(position.x, position.y + displacement * 100.0, position.z, 1.0);
```

- `texture(tex0, texcoord).r` obtiene la intensidad (0–1) del canal rojo del píxel.
- Esa intensidad se multiplica por un factor (`100.0`) para desplazar la coordenada Y.

Esto demuestra cómo los shaders pueden usar texturas como **datos**, no solo como imágenes.

### Ejemplo 4 — Multiple Shaders

**Descripción:**

Se utilizan **dos shaders distintos** en una misma escena.
Cada uno se aplica a diferentes objetos o secciones de la pantalla, introduciendo el concepto de *multi-pass shading*.

**Pasos:**

1. Abrir el proyecto.
2. Ejecutar el programa.
3. Observar cómo cada región o figura tiene un efecto diferente (por ejemplo, un desplazamiento y una variación de color).

**Explicación técnica:**

- Se crean dos objetos `ofShader`.
- Cada uno se activa y desactiva para aplicarse de forma independiente.
- Este enfoque es común en pipelines avanzados de renderizado (por ejemplo, iluminación, postprocesado o efectos combinados).

