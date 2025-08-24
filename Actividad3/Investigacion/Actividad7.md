### Actividad 7

Ahora te voy a proponer que reflexiones profundamente sobre el manejo de la memoria en un programa. Se trata de un experimento en el que tienes que analizar por qué está funcionando mal.

Modifica el archivo `ofApp.h` de la siguiente manera:

```cpp
#pragma once

#include "ofMain.h"

class Sphere {
public:
    Sphere(float x, float y, float radius);
    void draw() const;

    float x, y;
    float radius;
    ofColor color;
};

class ofApp : public ofBaseApp {
public:
    void setup();
    void update();
    void draw();

    void keyPressed(int key);

private:
    std::vector<Sphere*> globalVector;
    void createObjectInStack();
};
```

Y el archivo `ofApp.cpp` así:

```cpp
#include "ofApp.h"

Sphere::Sphere(float x, float y, float radius) : x(x), y(y), radius(radius) {
    color = ofColor(ofRandom(255), ofRandom(255), ofRandom(255));
}

void Sphere::draw() const {
    ofSetColor(color);
    ofDrawCircle(x, y, radius);
}

void ofApp::setup() {
    ofBackground(0);
}

void ofApp::update() {
}

void ofApp::draw() {
    ofSetColor(255);
    for (Sphere* sphere : globalVector) {
        if (sphere != nullptr) {
            ofDrawBitmapString("Objects pointed: " + ofToString(globalVector.size()), 20, 20);
            ofDrawBitmapString("Attempting to draw stored object...", 20, 40);
            ofDrawBitmapString("Stored Object Position: " + ofToString(sphere->x) + ", " + ofToString(sphere->y), 20, 60);
            sphere->draw();
        }
    }
}

void ofApp::keyPressed(int key) {
    if (key == 'c') {
        if (globalVector.empty()) {
            createObjectInStack();
        }
    }
    else if (key == 'd') {
        if (!globalVector.empty()) {
            ofLog() << "Accessing object in global vector: Position (" << globalVector[0]->x << ", " << globalVector[0]->y << ")";
        }
        else {
            ofLog() << "No objects in the global vector.";
        }
    }
}

void ofApp::createObjectInStack() {
    Sphere localSphere(ofRandomWidth(), ofRandomHeight(), 30);
    globalVector.push_back(&localSphere);
    ofLog() << "Object created in stack: Position (" << localSphere.x << ", " << localSphere.y << ")";
    localSphere.draw();
}
```

- ¿Qué sucede cuando presionas la tecla “c”?

Realiza esta modificación a la función `createObjectInStack` donde claramente se está creando un objeto, pero se está creando en el `heap` y no en el `stack`, así que no te dejes confundir por el nombre de la función.

```cpp
void ofApp::createObjectInStack() {
    // Sphere localSphere(ofRandomWidth(), ofRandomHeight(), 30);
    // globalVector.push_back(&localSphere);
    // ofLog() << "Object created in stack: Position (" << localSphere.x << ", " << localSphere.y << ")";
    // localSphere.draw();
    Sphere* heapSphere = new Sphere(ofRandomWidth(), ofRandomHeight(), 30);
    globalVector.push_back(heapSphere);
    ofLog() << "Object created in heap: Position (" << heapSphere->x << ", " << heapSphere->y << ")";
    heapSphere->draw();
}
```

- ¿Qué sucede cuando presionas la tecla “c”?
- ¿Por qué ocurre esto?

#### Respuestas:

**- ¿Qué sucede cuando presionas la tecla “c” en la primera versión del código?**

Cuando se presiona la tecla **“c”**, se crea un objeto `Sphere` llamado `localSphere` dentro de la función `createObjectInStack()`. Este objeto se almacena en el **stack**, pero al salir de la función la memoria se libera.  
El puntero `&localSphere` guardado en `globalVector` se convierte en un **puntero colgante (dangling pointer)**, ya que apunta a un objeto que ya no existe.  
El programa puede mostrar mensajes o incluso dibujar la esfera en algunos casos, pero el comportamiento es **indefinido**, pudiendo fallar o mostrar datos corruptos.  

**- ¿Qué sucede cuando presionas la tecla “c” en la segunda versión del código (con `new`)?**

En la segunda versión, el objeto `Sphere` se crea en el **heap** usando `new`. Como los objetos en el heap no se eliminan automáticamente al terminar la función, el puntero almacenado en `globalVector` sigue siendo válido.  

Cada vez que se presiona **“c”**, se crea un nuevo objeto en memoria dinámica, se guarda en el vector y se dibuja correctamente en pantalla. Ahora se puede acceder a sus atributos de manera consistente.  


**- ¿Por qué ocurre esto?**

La diferencia se debe al manejo de la **memoria stack vs heap**:  

- En el **stack**, las variables locales solo existen mientras la función está en ejecución. Al finalizar, esa memoria se libera automáticamente.  
- En el **heap**, los objetos creados con `new` permanecen en memoria hasta que se liberen manualmente con `delete`.  

Por eso, en la primera versión el puntero apuntaba a memoria inválida, mientras que en la segunda versión apunta a un objeto válido en el heap.  