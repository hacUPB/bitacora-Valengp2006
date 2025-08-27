## Reto - 25/08/2025

Vas a desarrollar una aplicación que genere una cuadrícula de esferas en un espacio tridimensional y que permita interactuar con ellas a través de la cámara y el ratón. Deberás implementar la lógica para seleccionar una esfera con el ratón y mostrar la información de la esfera seleccionada en la pantalla.

Por ejemplo, la aplicación podría verse así:

![](https://sistemascomputacionales.readthedocs.io/es/latest/_images/3d-spheres.png)

Para calcular el valor en `z` de cada esfera usa esta función:

```cpp
float z = cos(ofDist(x, y, 0, 0) / distDiv) * amplitud;
```

Donde `distDiv` y `amplitud` son variables que puedes modificar con el teclado.

Al generar la cuadrícula de esferas puedes usar bucles anidados para recorrer las posiciones:

```cpp
for (int x = -ofGetWidth() / 2; x < ofGetWidth() / 2; x += xStep) {
    for (int y = -ofGetHeight() / 2; y < ofGetHeight() / 2; y += yStep) {
```

Nota que `xStep` y `yStep` son variables que puedes modificar con el teclado. En la imagen que te mostré anteriormente `xStep` y `yStep` tienen el mismo valor.

Para seleccionar una esfera con el mouse:

Puedes usar los siguientes métodos:

```cpp
void ofApp::mousePressed(int x, int y, int button) {
    // Convertir las coordenadas del mouse en un rayo 3D
    glm::vec3 rayStart, rayEnd;
    convertMouseToRay(x, y, rayStart, rayEnd);

    // Comprobar si el rayo intersecta alguna esfera
    sphereSelected = false;
    for (auto& pos : spherePositions) {
        glm::vec3 intersectionPoint;
        if (rayIntersectsSphere(rayStart, rayEnd - rayStart, pos, 5.0, intersectionPoint)) {
            // EN ESTA PARTE Debes adicionar la lógica para indicarle
            // a la aplicación la esfera seleccionada.
        }
    }
}
```

```cpp
void ofApp::convertMouseToRay(int mouseX, int mouseY, glm::vec3& rayStart, glm::vec3& rayEnd) {
    // Obtener matrices de proyección y modelo/vista de la cámara
    glm::mat4 modelview = cam.getModelViewMatrix();
    glm::mat4 projection = cam.getProjectionMatrix();
    ofRectangle viewport = ofGetCurrentViewport();

    // Convertir coordenadas del mouse a Normalized Device Coordinates (NDC)
    float x = 2.0f * (mouseX - viewport.x) / viewport.width - 1.0f;
    float y = 1.0f - 2.0f * (mouseY - viewport.y) / viewport.height;

    // Crear el rayo en NDC
    glm::vec4 rayStartNDC(x, y, -1.0f, 1.0f); // Near plane
    glm::vec4 rayEndNDC(x, y, 1.0f, 1.0f);   // Far plane

    // Convertir a coordenadas mundiales
    glm::vec4 rayStartWorld = glm::inverse(projection * modelview) * rayStartNDC;
    glm::vec4 rayEndWorld = glm::inverse(projection * modelview) * rayEndNDC;

    rayStartWorld /= rayStartWorld.w;
    rayEndWorld /= rayEndWorld.w;

    rayStart = glm::vec3(rayStartWorld);
    rayEnd = glm::vec3(rayEndWorld);
}

// Detectar si el rayo intersecta una esfera
bool ofApp::rayIntersectsSphere(const glm::vec3& rayStart, const glm::vec3& rayDir, const glm::vec3& sphereCenter, float sphereRadius, glm::vec3& intersectionPoint) {
    glm::vec3 oc = rayStart - sphereCenter;

    float a = glm::dot(rayDir, rayDir);
    float b = 2.0f * glm::dot(oc, rayDir);
    float c = glm::dot(oc, oc) - sphereRadius * sphereRadius;

    float discriminant = b * b - 4 * a * c;

    if (discriminant < 0) {
        return false;
    }
    else {
        float t = (-b - sqrt(discriminant)) / (2.0f * a);
        intersectionPoint = rayStart + t * rayDir;
        return true;
    }
}
```

### **Requisitos de la aplicación**

1. **Generación de esferas:** utiliza bucles anidados para generar posiciones de esferas en una cuadrícula tridimensional. Las posiciones deben almacenarse en un vector de `ofVec3f`.
2. **Interacción con el ratón:** implementa la funcionalidad para seleccionar una esfera con el ratón. Al seleccionar una esfera, debes mostrar sus coordenadas en pantalla.
3. **Interacción con el teclado:** implementa controles básicos para modificar la separación entre esferas, la amplitud de sus posiciones en el eje Z, y otros parámetros visuales.
4. **Visualización:** utiliza una cámara 3D (`ofEasyCam`) para permitir la exploración de la escena desde diferentes ángulos.

1. **Generación de esferas:** utiliza bucles anidados para generar posiciones de esferas en una cuadrícula tridimensional. Las posiciones deben almacenarse en un vector de `ofVec3f`.
2. **Interacción con el ratón:** implementa la funcionalidad para seleccionar una esfera con el ratón. Al seleccionar una esfera, debes mostrar sus coordenadas en pantalla.
3. **Interacción con el teclado:** implementa controles básicos para modificar la separación entre esferas, la amplitud de sus posiciones en el eje Z, y otros parámetros visuales.
4. **Visualización:** utiliza una cámara 3D (`ofEasyCam`) para permitir la exploración de la escena desde diferentes ángulos.

### Análisis de Memoria

Además de implementar la aplicación, debes analizar cómo y dónde se almacenan los datos en la memoria. Para ello:

1. **Investiga:** investiga cómo se gestionan los vectores de `ofVec3f` en C++. ¿Dónde se almacenan? ¿En qué parte de la memoria se guardan los objetos y cómo se gestionan?
2. **Experimenta:** utiliza el depurador de Visual Studio para examinar la memoria de la aplicación en tiempo de ejecución. Observa en qué parte de la memoria se encuentran los objetos (`stack`, `heap`, memoria global).
3. **Documenta:** documenta tus hallazgos en un informe breve, explicando qué descubriste sobre la gestión de la memoria en tu aplicación.

### 📤 **Bitácora**

1. El código fuente de la aplicación.
2. Un breve informe donde expliques el manejo de memoria en tu aplicación, identificando en qué parte de la memoria se encuentran los datos clave.
3. Un enlace a un video corto que muestre funcionando la aplicación.

### Respuestas:

**Código fuente de la aplicación:**

`ofApp.h`
```cpp
#pragma once
#include "ofMain.h"

class ofApp : public ofBaseApp {
public:
    void setup();
    void update();
    void draw();

    void keyPressed(int key);
    void mousePressed(int x, int y, int button);

    vector<ofVec3f> posiciones;  // posiciones de esferas
    int gridSize;                // tamaño de la cuadrícula
    float spacing;               // separación entre esferas
    float amplitude;             // altura máxima en Z
    float sigma;                 // control de "montaña"

    ofEasyCam cam;               // cámara 3D
    int esferaSeleccionada;      // índice de esfera seleccionada
};
```

`ofApp.cpp`
```cpp
#include "ofApp.h"

void ofApp::setup() {
    ofBackground(0);
    ofEnableDepthTest();
    ofSetFrameRate(60);

    gridSize = 50;     // más denso
    spacing = 15;      // separación pequeña
    amplitude = 80;    // altura máxima
    esferaSeleccionada = -1;

    // posiciones iniciales (superficie 3D tipo onda)
    posiciones.clear();
    for (int x = 0; x < gridSize; x++) {
        for (int y = 0; y < gridSize; y++) {
            float xpos = (x - gridSize / 2) * spacing;
            float ypos = (y - gridSize / 2) * spacing;

            // Fórmula para superficie ondulada en Z
            float z = amplitude * sin(x * 0.3) * cos(y * 0.3);

            posiciones.push_back(ofVec3f(xpos, ypos, z));
        }
    }
}

void ofApp::update() {}

void ofApp::draw() {
    cam.begin();

    for (int i = 0; i < posiciones.size(); i++) {
        float hue = ofMap(posiciones[i].z, -amplitude, amplitude, 0, 255);
        ofColor c = ofColor::fromHsb(hue, 255, 255);

        if (i == esferaSeleccionada) {
            ofSetColor(255); // resaltada en blanco
        }
        else {
            ofSetColor(c);
        }

        ofDrawSphere(posiciones[i], 5);
    }

    cam.end();

    if (esferaSeleccionada != -1) {
        ofSetColor(255);
        ofDrawBitmapStringHighlight("Seleccionada: " +
            ofToString(posiciones[esferaSeleccionada]), 20, 20);
    }
}

// --- Teclado ---
void ofApp::keyPressed(int key) {
    if (key == OF_KEY_UP) spacing += 2;
    if (key == OF_KEY_DOWN) spacing = max(2.0f, spacing - 2);
    if (key == 'w') amplitude += 5;
    if (key == 's') amplitude = max(5.0f, amplitude - 5);

    // regenerar posiciones con nueva superficie
    posiciones.clear();
    for (int x = 0; x < gridSize; x++) {
        for (int y = 0; y < gridSize; y++) {
            float xpos = (x - gridSize / 2) * spacing;
            float ypos = (y - gridSize / 2) * spacing;

            float z = amplitude * sin(x * 0.3) * cos(y * 0.3);

            posiciones.push_back(ofVec3f(xpos, ypos, z));
        }
    }
}

// --- Ratón ---
void ofApp::mousePressed(int x, int y, int button) {
    ofVec3f mouseWorld = cam.screenToWorld(ofVec3f(x, y, 0));

    float minDist = 99999;
    int seleccionado = -1;

    for (int i = 0; i < posiciones.size(); i++) {
        float d = posiciones[i].distance(mouseWorld);
        if (d < minDist && d < 15) { // tolerancia
            minDist = d;
            seleccionado = i;
        }
    }

    esferaSeleccionada = seleccionado;
}
```

#### Manejo de memoria:

La aplicación genera una figura tridimensional compuesta por una cuadrícula de esferas distribuidas en un espacio 3D.

- La posición de cada esfera se calcula con funciones trigonométricas (sin y cos), lo que da como resultado una superficie ondulada que varía en el eje Z.
- Cada esfera recibe un color en función de su altura (z), lo que permite visualizar el relieve de manera llamativa.
- Se utiliza la cámara ofEasyCam para explorar la figura desde diferentes ángulos.
- El usuario puede interactuar seleccionando esferas con el ratón y modificando parámetros como la amplitud de la onda y la separación entre esferas mediante el teclado.

**1. Generación y almacenamiento de datos:**

- Las posiciones de las esferas se almacenan en un vector dinámico de tipo `std::vector<ofVec3f>`.
- Cada `ofVec3f` contiene las coordenadas (x, y, z) de una esfera en la cuadrícula tridimensional.
- Al usar `std::vector`, la memoria para estas posiciones se gestiona en el *heap*, lo que permite almacenar un número variable de elementos y redimensionar el contenedor en tiempo de ejecución.

**2. Interacción y variables temporales:**

- Variables como `gridSize`, `spacing`, `amplitude` y `esferaSeleccionada` son de tipo primitivo (int, float) y se almacenan en la pila (stack) de memoria.
- Durante la ejecución de bucles (en setup o cuando se actualizan posiciones con el teclado), se crean variables locales como xpos, ypos y z, que también residen temporalmente en la pila y se liberan al finalizar cada iteración.

**3. Objetos gráficos y cámara:**

La cámara `ofEasyCam` y las funciones de dibujo (`ofDrawSphere`) utilizan internamente objetos que manejan buffers en GPU para renderizar la escena. Estos no se almacenan en el stack ni en el heap del programa directamente, sino en la memoria de la tarjeta gráfica, pero se controlan desde objetos en memoria dinámica de la aplicación.

**4. Visualización y selección con el ratón:**

- La función `screenToWorld` transforma coordenadas de pantalla en coordenadas del mundo 3D. El resultado se almacena en un `ofVec3f` temporal, ubicado en el stack.
- Para la selección de una esfera, se recorren todos los elementos del vector posiciones en el heap y se calcula la distancia con el punto del ratón en el mundo 3D.

La aplicación muestra cómo los datos se distribuyen entre la pila (variables temporales), el heap (estructura principal de esferas) y la GPU (visualización gráfica), logrando una gestión de memoria eficiente para la interacción en tiempo real.
