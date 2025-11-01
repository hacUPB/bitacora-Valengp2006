# Reto - 29/10/2025

## Concepto visual y funcional

La aplicación representará una **superficie ondulante**, simulando un “mar digital” o “energía lumínica”.

**Vertex Shader:**

- Deforma los vértices de la malla con una función de onda (`sin` o `cos`) en base al tiempo.
- Eso cumple el requisito de *modificar los vértices.*

**Fragment Shader:**

- Cambia el color de cada fragmento según su altura o posición.
- Usa un gradiente dinámico que se mueve con el tiempo o reacciona al mouse.
- Eso cumple el requisito de *modificar los colores de los fragmentos.*

### Funcionalidades interactivas

Para cumplir con el “interactivo” del reto, puedes incluir una o varias de estas:

1. **Interacción con el mouse:**

   - Mueve el mouse en X/Y → cambia gradualmente el color de la malla con colores que van del azul al morado.
 
2. **Teclado:**

   - Tecla ↑/↓ → aumenta o disminuye amplitud.
   - Tecla “C” → cambia la frecuencia de la onda.
     
3. **Animación automática:**

   - La malla se mueve sola con `ofGetElapsedTimef()`.

### Estructura de la malla

En `ofApp.cpp` se creará una **malla de puntos** (de aproximadamente, 100x100 vértices) con `ofMesh`.

Cada cuadro (`update`) enviará uniformes al shader:

- Tiempo (`time`)
- Posición del mouse (`mouse`)
- Amplitud y frecuencia de onda

### Resultado visual esperado

Visualmente se parecerá a esto:

- Ondas suaves que se desplazan horizontalmente.
- Colores que van del **azul al púrpura** según altura.
- Interacción que cambia la frecuencia.
- Interacción que cambia color con el mouse.

<img width="766" height="425" alt="Captura de pantalla 2025-10-29 164205" src="https://github.com/user-attachments/assets/3610c0d8-4ec2-4edd-b930-ff7491eea9b4" />

### Para los RAEs

**RAE1 (Construcción y explicación):**

- Explicar cómo se deforma la malla en el vertex shader.
- Explicar cómo se calculan los colores en el fragment shader.
- Mostrar el código y un video de la app corriendo.

**RAE2 (Pruebas):**

- Mostrar cómo se probó:

  - La malla base (sin shaders).
  - El vertex shader (probando distintas deformaciones).
  - El fragment shader (probando gradientes y animación).
  - Todo junto (la app final con interacción).

## Evidencias de los resultados de aprendizaje:

### RAE1 – Construcción y explicación de la aplicación

La aplicación desarrollada consiste en una superficie ondulante interactiva, que simula un mar digital o una energía lumínica. Utiliza `vertex` y `fragment shaders` para modificar los vértices y los colores de una malla en tiempo real.

- **Funcionamiento general:**

	- En `ofApp.cpp` se genera una malla (`ofPlanePrimitive`) que actúa como superficie base.
   El vertex shader aplica una deformación sinusoidal sobre los vértices en el eje Y, variando su altura según el tiempo, la amplitud y la frecuencia.
	- El fragment shader modifica el color de cada píxel con un gradiente dinámico entre tonos azules y púrpuras, que reacciona al movimiento del mouse.
	- El teclado permite:
	   - ↑ / ↓: ajustar la amplitud de la onda.
	   - C: cambiar la frecuencia.
	   - El movimiento es automático, pero el usuario puede alterar la visualización en tiempo real.

- **Código fuente principal:**

	- `ofApp.cpp:` creación de la malla, envío de uniformes (tiempo, mouse, amplitud, frecuencia).

```cpp
#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup() {
    ofSetWindowTitle("Reto Shader Interactivo");
    ofBackground(0);
    ofSetFrameRate(60);

    // Cargar shader según el renderizador
    if (ofIsGLProgrammableRenderer()) {
        shader.load("shadersGL3/shader");
    } else {
        shader.load("shadersGL2/shader");
    }

    // Crear plano (malla base)
    float planeScale = 1.0;
    int planeWidth = ofGetWidth() * planeScale;
    int planeHeight = ofGetHeight() * planeScale;
    int planeGridSize = 20;
    int planeColumns = planeWidth / planeGridSize;
    int planeRows = planeHeight / planeGridSize;

    plane.set(planeWidth, planeHeight, planeColumns, planeRows, OF_PRIMITIVE_TRIANGLES);
    plane.mapTexCoordsFromTexture(ofTexture());

    amplitude = 100.0;   // altura inicial de la onda
    frequency = 0.5;     // frecuencia inicial
}

//--------------------------------------------------------------
void ofApp::update() {
    // No necesitamos lógica adicional aquí, solo actualizar el tiempo
}

//--------------------------------------------------------------
void ofApp::draw() {
    ofBackground(0);

    // Calcular el color base según la posición del mouse en X/Y
    float mixX = ofClamp(mouseX / float(ofGetWidth()), 0.0, 1.0);
    ofColor colorLeft = ofColor::blue;
    ofColor colorRight = ofColor::purple;
    ofColor mixColor = colorLeft.getLerped(colorRight, mixX);
    ofSetColor(mixColor);

    shader.begin();

    // Pasar uniformes al shader
    shader.setUniform1f("time", ofGetElapsedTimef());
    shader.setUniform1f("amplitude", amplitude);
    shader.setUniform1f("frequency", frequency);
    shader.setUniform2f("mouse", mixX, mouseY / float(ofGetHeight()));

    // Centrar y rotar la malla
    ofPushMatrix();
    ofTranslate(ofGetWidth() / 2, ofGetHeight() / 2);
    ofRotateDeg(60, 1, 0, 0);

    plane.drawWireframe();
    ofPopMatrix();

    shader.end();

    // Mostrar info en pantalla
    ofSetColor(255);
    ofDrawBitmapStringHighlight("↑/↓ : amplitud  |  C : cambiar frecuencia  |  Mouse X/Y : color", 20, 20);
    ofDrawBitmapStringHighlight("Amplitud: " + ofToString(amplitude, 2), 20, 40);
    ofDrawBitmapStringHighlight("Frecuencia: " + ofToString(frequency, 2), 20, 60);
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key) {
    if (key == OF_KEY_UP) amplitude += 10;
    if (key == OF_KEY_DOWN) amplitude = max(10.0f, amplitude - 10.0f);
    if (key == 'c' || key == 'C') frequency += 0.1;
    if (frequency > 3.0) frequency = 0.5; // reinicia si se pasa
}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y) {
    mousePos = glm::vec2(x, y);
}

//--------------------------------------------------------------
void ofApp::keyReleased(int key) {}

//--------------------------------------------------------------
void ofApp::mouseDragged(int x, int y, int button) {}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button) {}

//--------------------------------------------------------------
void ofApp::mouseReleased(int x, int y, int button) {}

//--------------------------------------------------------------
void ofApp::windowResized(int w, int h) {}

//--------------------------------------------------------------
void ofApp::gotMessage(ofMessage msg) {}

//--------------------------------------------------------------
void ofApp::dragEvent(ofDragInfo dragInfo) {}
```
   - `ofApp.h:` 
      - declaración de las variables y métodos necesarios para controlar la aplicación.
	   - Define los objetos ofEasyCam, ofMesh y ofShader.
	   - Declara variables de tipo float para controlar amplitud, frecuencia y el tiempo.
	   - Incluye las funciones principales (`setup()`, `update()`, `draw()`) y los eventos de interacción (`keyPressed()`, `mouseMoved()`).
	   - Sirve como encabezado que conecta la lógica de la aplicación con la implementación en ofApp.cpp.

```cpp
#pragma once
#include "ofMain.h"

class ofApp : public ofBaseApp {
public:
    void setup();
    void update();
    void draw();

    void keyPressed(int key);
    void keyReleased(int key);
    void mouseMoved(int x, int y);
    void mouseDragged(int x, int y, int button);
    void mousePressed(int x, int y, int button);
    void mouseReleased(int x, int y, int button);
    void windowResized(int w, int h);
    void dragEvent(ofDragInfo dragInfo);
    void gotMessage(ofMessage msg);

    ofShader shader;
    ofPlanePrimitive plane;

    float amplitude;
    float frequency;
    glm::vec2 mousePos;
};
```
   - `shader.vert:` deformación de vértices mediante sin() para crear la onda.

```cpp
#version 150

uniform mat4 modelViewProjectionMatrix;
in vec4 position;
uniform float time;
uniform float amplitude;
uniform float frequency;

void main() {
    // Desplazamiento tipo onda (suave y continuo)
    float wave = sin(position.x * frequency * 0.05 + time) * amplitude;
    vec4 newPosition = position;
    newPosition.y += wave;
    gl_Position = modelViewProjectionMatrix * newPosition;
}
```

   - `shader.frag:` gradiente de color según posición y valores dinámicos.

```cpp
#version 150

out vec4 outputColor;
uniform vec2 mouse;
uniform float time;

void main() {
    // Gradiente entre azul y morado, afectado por el mouse y el tiempo
    vec3 colorA = vec3(0.0, 0.0, 1.0); // azul
    vec3 colorB = vec3(0.6, 0.0, 1.0); // morado
    float t = abs(sin(time * 0.5)) * 0.5 + mouse.x * 0.5;
    vec3 color = mix(colorA, colorB, t);
    outputColor = vec4(color, 1.0);
}
```

- **Explicación del flujo:**

	1.	La CPU (openFrameworks) calcula el tiempo y la interacción del usuario.
	2.	Estos datos se envían como uniforms al shader.
	3.	La GPU usa esas variables para deformar y colorear la superficie.
	4.	El resultado es una animación fluida, continua e interactiva.

- **Video de demostración:** [Enlace]()

### RAE2 – Pruebas de la aplicación

- **Prueba en `ofApp.cpp`:**

	- Se verificó que las variables uniformes (time, mouse, amplitude, frequency) se actualizan correctamente.
   - Se probó que las teclas modifican las variables esperadas.
	- Se validó que el plano se dibuja centrado y a la escala correcta.

- **Prueba del `vertex shader`:**

	- Se probó la deformación inicial con una onda fija.
	- Luego se introdujeron variables de amplitud y frecuencia controladas desde teclado.
	- Se comprobó visualmente que la malla respondía de manera continua y sin artefactos.

- **Prueba del `fragment shader`:**

	- Se inició con un color plano (`globalColor`) para verificar comunicación.
	- Luego se implementó el gradiente dinámico, observando la transición fluida entre azul y púrpura.
	- Se ajustó la sensibilidad del color al movimiento del mouse.

- **Prueba del sistema completo:**

	- Se ejecutó la aplicación con todos los componentes activos.
	- Se comprobó la sincronización entre deformación (`vertex shader`) y color (`fragment shader`).
	- Se observó el comportamiento interactivo completo, verificando estabilidad y rendimiento en tiempo real.