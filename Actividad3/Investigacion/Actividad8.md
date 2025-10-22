### Actividad 8

Construye un experimento (un programa) en el que puedas crear y dibujar objetos que se almacenan:

- En el `heap`.
- En el `stack`.
- En memoria global.

**Nota**
sí puedes usar el `stack,`pero recuerda que los objetos solo dudarán en el `stack` el tiempo que dure la función que los creó. ¿Hay alguna función en el programa que dure durante toda la ejecución del programa?

- ¿Cuándo debo crear objetos en el `heap` y cuándo en memoria global?

#### Respuestas:

**Código `ofApp.h`:**
```cpp
#pragma once
#include "ofMain.h"

class Sphere {
public:
    Sphere(float x, float y, float r);
    void draw() const;

    float x, y, r;
    ofColor color;
};

// Objeto en memoria global
extern Sphere esferaGlobal;

class ofApp : public ofBaseApp {
public:
    void setup();
    void update();
    void draw();
    void keyPressed(int key);

private:
    Sphere* heapSphere = nullptr;  // objeto en heap
    void createStackSphere();      // objeto en stack
};
```

**Código `ofApp.cpp`:**

```cpp
#include "ofApp.h"

// Definición del objeto global
Sphere esferaGlobal(100, 100, 40);

Sphere::Sphere(float x, float y, float r) : x(x), y(y), r(r) {
    color = ofColor(ofRandom(255), ofRandom(255), ofRandom(255));
}

void Sphere::draw() const {
    ofSetColor(color);
    ofDrawCircle(x, y, r);
}

void ofApp::setup() {
    ofBackground(0);
}

void ofApp::update() {}

void ofApp::draw() {
    // Dibuja el global
    esferaGlobal.draw();

    // Dibuja el del heap si existe
    if (heapSphere != nullptr) {
        heapSphere->draw();
    }

    // El del stack solo dura mientras la función lo crea
    // Aquí no hay nada que dibujar porque ya expiró
}

void ofApp::keyPressed(int key) {
    if (key == 'h') { // crear en heap
        heapSphere = new Sphere(ofRandomWidth(), ofRandomHeight(), 30);
        ofLog() << "Objeto creado en heap.";
    }
    if (key == 's') { // crear en stack
        createStackSphere();
    }
}

void ofApp::createStackSphere() {
    Sphere stackSphere(ofRandomWidth(), ofRandomHeight(), 20);
    ofLog() << "Objeto creado en stack en (" << stackSphere.x << "," << stackSphere.y << ")";
    stackSphere.draw(); // se dibuja aquí, pero desaparece al salir de la función
}
```

**¿Cuándo debo crear objetos en el heap y cuándo en memoria global?**

- En el **heap** cuando necesito objetos dinámicos que deben persistir durante la ejecución y no conozco cuántos crearé.
- En **memoria global** cuando necesito objetos únicos y accesibles en todo el programa, desde inicio hasta fin.

**¿Hay alguna función en el programa que dure durante toda la ejecución del programa?**

Sí. El ciclo principal de **openFrameworks** (`setup()`, `update()`, `draw()` y eventos como `keyPressed()`) dura toda la ejecución. Sin embargo, los objetos en el stack solo existen dentro de la función que los crea.

**Conclusiones:**

- El `stack `sirve para objetos temporales.
- El `heap` me permite crear objetos persistentes y dinámicos.
- La `memoria global` mantiene objetos siempre disponibles en todo el programa.