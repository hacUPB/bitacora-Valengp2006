### Actividad 5

En la unidad anterior introdujimos el concepto de puntero. Ahora vamos a profundizar en este concepto de manera práctica.

El siguiente ejemplo se supone (en la actividad que sigue vas a corregir un error) que te permite seleccionar una espera y moverla con el mouse.

Modifica el archivo `ofApp.h` de la siguiente manera:

```cpp
#pragma once

#include "ofMain.h"

class Sphere {
public:
    Sphere(float x, float y, float radius);
    void draw();
    void update(float x, float y);
    float getX();
    float getY();
    float getRadius();

private:
    float x, y;
    float radius;
    ofColor color;
};

class ofApp : public ofBaseApp{

    public:
        void setup();
        void update();
        void draw();

        void mouseMoved(int x, int y );
        void mousePressed(int x, int y, int button);

    private:

        vector<Sphere*> spheres;
        Sphere* selectedSphere;
};
```

Y el archivo `ofApp.cpp` así:

```cpp
#include "ofApp.h"

Sphere::Sphere(float x, float y, float radius) : x(x), y(y), radius(radius) {
    color = ofColor(ofRandom(255), ofRandom(255), ofRandom(255));
}

void Sphere::draw() {
    ofSetColor(color);
    ofDrawCircle(x, y, radius);
}

void Sphere::update(float x, float y) {
    this->x = x;
    this->y = y;
}

float Sphere::getRadius() {
    return radius;
}

float Sphere::getX() {
    return x;
}

float Sphere::getY() {
    return y;
}

//--------------------------------------------------------------
void ofApp::setup(){
    ofBackground(0);

    for (int i = 0; i < 5; i++) {
        float x = ofRandomWidth();
        float y = ofRandomHeight();
        float radius = ofRandom(20, 50);
        spheres.push_back(new Sphere(x, y, radius));
    }
    selectedSphere = nullptr;

}

//--------------------------------------------------------------
void ofApp::update(){
    if (selectedSphere != nullptr) {
        selectedSphere->update(ofGetMouseX(), ofGetMouseY());
    }
}

//--------------------------------------------------------------
void ofApp::draw(){
    for (auto sphere : spheres) {
        sphere->draw();
    }
}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y ){

}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button){

    if(button == OF_MOUSE_BUTTON_LEFT){
        for (auto sphere : spheres) {
            float distance = ofDist(x, y, sphere->getX(), sphere->getY());
            if (distance < sphere->getRadius()) {

                selectedSphere = sphere;
                break;
            }
        }
    }
}
```

- ¿Cuál es la definición de un puntero?
- ¿Dónde está el puntero?
- ¿Cómo se inicializa el puntero?
- ¿Para qué se está usando el puntero?
- ¿Qué es exactamente lo que está almacenado en el puntero?

**Respuestas:**

- **¿Cuál es la definición de un puntero?:**
   
Un puntero es una variable especial que no guarda directamente un valor como un número o un texto, sino que guarda la dirección en memoria de otro dato u objeto. Es como una etiqueta que apunta a dónde está guardada la información.

- **¿Dónde está el puntero?:**
  
En el código hay punteros en:

- `selectedSphere` se inicializa en setup() así:
	- `vector<Sphere*> spheres;` → un vector que guarda punteros a objetos Sphere.
	- `Sphere* selectedSphere;` → un puntero que guarda la dirección de la esfera seleccionada.

- **¿Cómo se inicializa el puntero?:**

    - `selectedSphere` se inicializa en setup() así:
```cpp
selectedSphere = nullptr;
```
Esto significa que al inicio no está apuntando a ningún objeto.

	- Los punteros dentro del vector `spheres` se crean con new al agregar cada esfera:
```cpp
spheres.push_back(new Sphere(x, y, radius));
```
Aquí `new Sphere(...)` crea una esfera en memoria y devuelve un puntero a ella.

- **¿Para qué se está usando el puntero?:**
  
Se usa para identificar y manipular una esfera específica mientras el usuario la mueve con el mouse. Además, cuando haces clic sobre una esfera, `selectedSphere` apunta a ella y en `update()` se mueve su posición al seguir el cursor.

- **¿Qué es exactamente lo que está almacenado en el puntero?**
  
No guarda directamente el objeto `Sphere`, sino la dirección en memoria donde está ese objeto, lo que permite acceder y modificar esa esfera sin tener que copiarla.
