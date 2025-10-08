### Actividad 9

Considera el siguiente código. El archivo `ofApp.h` es el siguiente:

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

private:
    vector<ofVec2f*> heapObjects;
};
```
​
Y el archivo `ofApp.cpp` es el siguiente:

```cpp
#include "ofApp.h"

void ofApp::setup(){
    ofBackground(0);
}

void ofApp::update(){
}

void ofApp::draw(){
    ofSetColor(0, 0, 255); // Color azul para los objetos del heap
    for(auto& pos : heapObjects) {
        ofDrawCircle(pos->x, pos->y, 20);
        ofDrawBitmapString("Heap Memory", pos->x - 40, pos->y - 40);
    }
}

void ofApp::keyPressed(int key){
    if(key == 'f') {
        if(!heapObjects.empty()) {
            delete heapObjects.back();
            heapObjects.pop_back();
        }
    }
}

void ofApp::mousePressed(int x, int y, int button){
    heapObjects.push_back(new ofVec2f(x, y));
}
```
​
- ¿Qué sucede cuando presionas la tecla “f”?
- Analiza detalladamente esta parte del código:

```cpp
if(!heapObjects.empty()) {
    delete heapObjects.back();
    heapObjects.pop_back();
}
```

#### Respuestas:

**¿Qué sucede cuando presionas la tecla “f”?**

Cuando se presiona la tecla f, el programa elimina el último objeto creado en el heap y, como consecuencia, desaparece el último círculo azul dibujado en pantalla. Si se continúa presionando f, se irán borrando uno a uno los demás círculos. Si la lista ya está vacía, no pasa nada.

**Analiza detalladamente esta parte del código:**

- `if(!heapObjects.empty())`: evita operar cuando el vector está vacío (previene acceso inválido).
- `heapObjects.back()`: obtiene el puntero al último objeto del vector (sin quitarlo).
- `delete heapObjects.back();`: libera la memoria en el heap a la que apunta ese puntero (evita fuga de memoria).
- `heapObjects.pop_back();`: remueve el puntero del vector (ya no queda referencia al objeto eliminado).
