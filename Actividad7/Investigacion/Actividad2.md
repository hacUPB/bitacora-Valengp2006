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

### Ejemplo 1 — Simple Color Quad  

- **Ruta:** `01_simpleColorQuadExample`
- **Parte del tutorial:** *“Your First Shader”*
- **Concepto:** Muestra cómo un *fragment shader* puede pintar colores en pantalla sin necesidad de una textura.
- **Explicación:**
	- El **vertex shader** envía las coordenadas de cada vértice a la GPU.  
	- El **fragment shader** usa `gl_FragCoord` (posición del píxel) para determinar el color.  
	- El color se genera según la posición en pantalla → produce un **degradado**.
- **Código clave:**
```glsl
void ofApp::draw(){
    ofSetColor(255);

    //shader.begin();

    ofDrawRectangle(0, 0, ofGetWidth(), ofGetHeight());

    //shader.end();
}
````

### Ejemplo 2 — Simple Vertex Displacement

- **Ruta:** `02_simpleVertexDisplacementExample`
- **Parte del tutorial:** *“Adding Movement”*
- **Concepto:** El **vertex shader** altera la posición de los vértices usando una función seno, creando una deformación ondulada.
- **Explicación:**
   - Cada vértice cambia de posición en el eje Y según el tiempo.
   - El resultado es un plano que parece moverse como una ola.
   - Mover el mouse cambia el color o la rotación del plano.
- **Código clave:**

```glsl
vec4 newPosition = position + normal * sin(time + position.x * 0.05) * 20.0;
gl_Position = modelViewProjectionMatrix * newPosition;
```

### Ejemplo 3 — Simple Shader Interaction

- **Ruta:** `03_simpleShaderInteractionExample`
- **Parte del tutorial:** *“Passing Variables from CPU to GPU”*
- **Concepto:** Introduce el paso de valores desde la CPU hacia el shader mediante *uniforms* (como el mouse o el tiempo).
- **Explicación:**
 - La CPU envía `time` y `mouse` al shader.
 - El shader usa estos valores para modificar color o posición.
 - Se demuestra cómo la GPU responde a la interacción del usuario.
- **Código clave:**

```cpp
shader.setUniform1f("time", ofGetElapsedTimef());
shader.setUniform2f("mouse", mouseX, mouseY);
```

### Ejemplo 4 — Simple Texturing

- **Ruta:** 04_simpleTexturingExample
- **Parte del tutorial:** “Working with Textures in Shaders”
- **Concepto:** Introduce cómo aplicar una textura a una superficie usando un sampler2DRect.
- **Explicación:**
	- Se carga una imagen como textura (ofImage).
 - El shader lee el color de la textura mediante coordenadas UV.
 - Puede alterarse el color multiplicándolo o mezclándolo con otros valores.
- **Código clave:**

outputColor = texture(tex0, texCoordVarying) * vec4(1.0, 0.5, 0.5, 1.0);

### Ejemplo 5 — Alpha Masking

- **Ruta:** 05_alphaMaskingExample
- **Parte del tutorial:** “Alpha and Transparency in Shaders”
- **Concepto:** Combina una imagen base con una máscara que define la transparencia.
- **Explicación:**
	- Se utilizan dos texturas: una imagen (tex0) y una máscara (maskTex).
 - El fragment shader compara el valor de la máscara para definir qué partes se ven.
- **Código clave:**

vec4 color = texture(tex0, texCoordVarying);
float maskValue = texture(maskTex, texCoordVarying).r;
outputColor = vec4(color.rgb, maskValue);

### Ejemplo 6 — Multi Texture

- Ruta: 06_multiTextureExample
- Parte del tutorial: “Using Multiple Textures and Samplers”
- Concepto: Mezcla varias texturas dentro de un mismo shader.
- Explicación:
	- Se usan dos texturas (tex0 y tex1) para crear un efecto combinado.
 - La mezcla depende del valor de un uniform o de la posición del mouse.

- Código clave:

vec4 texA = texture(tex0, texCoordVarying);
vec4 texB = texture(tex1, texCoordVarying);
outputColor = mix(texA, texB, 0.5);
