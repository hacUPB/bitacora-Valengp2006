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

class ofApp : public ofBaseApp{
public:
    void setup();
    void update();
    void draw();

    void keyPressed(int key);
    void mousePressed(int x, int y, int button);

    // Datos de la malla
    vector<ofVec3f> posiciones;    // posiciones de las esferas (heap)
    vector<ofColor> colores;       // color por esfera
    vector<float> tamanos;         // tamaño (radio) por esfera

    // Parámetros
    int gridSize;
    float spacing;
    float amplitude;
    float sphereRadius; // tamaño base de cada esfera

    // Cámara e interacción
    ofEasyCam cam;
    int esferaSeleccionada; // índice seleccionado (-1 = ninguna)

    // Helpers
    void regenerateMesh();
    int nearestSphereToScreen(int x, int y);
};
```

`ofApp.cpp`
```cpp
#include "ofApp.h"
#include <limits>

//--------------------------------------------------------------
void ofApp::setup(){
    ofBackground(0);
    ofEnableDepthTest();
    ofSetFrameRate(60);

    // parámetros iniciales
    gridSize = 40;         // 40x40 = 1600 esferas
    spacing = 15.0f;
    amplitude = 60.0f;
    sphereRadius = 6.0f;
    esferaSeleccionada = -1;

    cam.setDistance(600);

    // crear malla inicial
    regenerateMesh();
}

//--------------------------------------------------------------
void ofApp::update(){
    // nada por ahora
}

//--------------------------------------------------------------
void ofApp::draw(){
    cam.begin();

    for (int i = 0; i < (int)posiciones.size(); i++) {
        // si está seleccionada, la dibujamos resaltada
        if (i == esferaSeleccionada) {
            ofPushStyle();
            ofSetColor(255, 255, 0); // amarillo brillante
            ofDrawSphere(posiciones[i], tamanos[i] * 1.5f);
            ofPopStyle();
        } else {
            ofSetColor(colores[i]);
            ofDrawSphere(posiciones[i], tamanos[i]);
        }
    }

    cam.end();

    // Información en pantalla (2D)
    ofSetColor(255);
    string info = "Global: a/z amplitude | s/x spacing  -  Click: select sphere\n";
    info += "If selected: UP/DOWN size | c random color | d deselect\n";
    ofDrawBitmapStringHighlight(info, 10, 20);

    if (esferaSeleccionada != -1) {
        string sel = "Selected idx: " + ofToString(esferaSeleccionada) +
                     "  pos: " + ofToString(posiciones[esferaSeleccionada]) +
                     "  size: " + ofToString(tamanos[esferaSeleccionada]);
        ofDrawBitmapStringHighlight(sel, 10, 60);
    }
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key){
    bool regen = false;

    // Modificaciones globales
    if (key == 'a') { amplitude += 5.0f; regen = true; }
    if (key == 'z') { amplitude = max(1.0f, amplitude - 5.0f); regen = true; }
    if (key == 's') { spacing += 1.0f; regen = true; }
    if (key == 'x') { spacing = max(1.0f, spacing - 1.0f); regen = true; }

    // Modificaciones a la esfera seleccionada (si hay)
    if (esferaSeleccionada != -1) {
        if (key == OF_KEY_UP) {
            tamanos[esferaSeleccionada] += 1.5f;
        }
        if (key == OF_KEY_DOWN) {
            tamanos[esferaSeleccionada] = max(1.0f, tamanos[esferaSeleccionada] - 1.5f);
        }
        if (key == 'c') {
            colores[esferaSeleccionada] = ofColor::fromHsb(ofRandom(0,255), 255, 255);
        }
        if (key == 'd') {
            esferaSeleccionada = -1;
        }
    }

    if (regen) {
        regenerateMesh();
    }
}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button){
    int idx = nearestSphereToScreen(x, y);
    esferaSeleccionada = idx; // (-1 si ninguna)
}

//--------------------------------------------------------------
void ofApp::regenerateMesh(){
    posiciones.clear();
    colores.clear();
    tamanos.clear();

    posiciones.reserve(gridSize * gridSize);
    colores.reserve(gridSize * gridSize);
    tamanos.reserve(gridSize * gridSize);

    const float freq = 0.25f; // controla cuántas crestas/vales
    for (int ix = 0; ix < gridSize; ix++) {
        for (int iy = 0; iy < gridSize; iy++) {
            float xpos = (ix - gridSize / 2.0f) * spacing;
            float ypos = (iy - gridSize / 2.0f) * spacing;

            // superficie ondulada (puedes cambiar por gaussiana si prefieres)
            float z = amplitude * sin(ix * freq) * cos(iy * freq);

            posiciones.push_back(ofVec3f(xpos, ypos, z));

            // color por altura z
            float hue = ofMap(z, -amplitude, amplitude, 0, 255, true);
            colores.push_back(ofColor::fromHsb(hue, 255, 255));

            // tamanos iniciales (puedes variar por z si quieres)
            tamanos.push_back(sphereRadius);
        }
    }

    // si la selección previa queda fuera (ej por cambio de grid), deselect
    if (esferaSeleccionada >= (int)posiciones.size()) esferaSeleccionada = -1;
}

//--------------------------------------------------------------
int ofApp::nearestSphereToScreen(int x, int y){
    // Ray from camera through mouse pixel
    ofVec3f rayOrigin = cam.screenToWorld(ofVec3f(x, y, 0.0f)); // near plane
    ofVec3f rayEnd    = cam.screenToWorld(ofVec3f(x, y, 1.0f)); // far plane
    ofVec3f rayDir    = (rayEnd - rayOrigin).normalized();

    float bestT = std::numeric_limits<float>::infinity();
    int bestIdx = -1;

    for (int i = 0; i < (int)posiciones.size(); i++) {
        ofVec3f center = posiciones[i];
        float r = tamanos[i]; // radio de la esfera (usa tamaño actual)

        // Solve quadratic for intersection: (o + t*d - c)^2 = r^2
        ofVec3f L = rayOrigin - center;
        float a = rayDir.dot(rayDir); // ==1 normalmente
        float b = 2.0f * rayDir.dot(L);
        float c = L.dot(L) - r * r;
        float disc = b * b - 4.0f * a * c;

        if (disc < 0.0f) continue; // no intersection

        float sqrtDisc = sqrt(disc);
        float t0 = (-b - sqrtDisc) / (2.0f * a);
        float t1 = (-b + sqrtDisc) / (2.0f * a);

        // tomar la intersección más cercana positiva
        float t = (t0 >= 0.0f) ? t0 : ((t1 >= 0.0f) ? t1 : -1.0f);
        if (t >= 0.0f && t < bestT) {
            bestT = t;
            bestIdx = i;
        }
    }

    return bestIdx; // -1 si ninguna
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


#### [Enlace video funcionamiento del programa](https://youtu.be/BZBzT2QU0p8)
#### Imagen de referencia:

<img width="759" height="726" alt="Captura de pantalla 2025-08-27 165455" src="https://github.com/user-attachments/assets/c34971e6-4c10-45f9-9221-afe2d96d05d2" />

