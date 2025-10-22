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

