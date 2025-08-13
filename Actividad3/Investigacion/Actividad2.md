### Actividad 2

De nuevo una actividad grupal en la cual escribiremos juntos nuestra primera aplicación y analizaremos las diferentes partes que la componen.

- Genera un proyecto con el generador de proyectos de **`openframeworks`**.
- Abre el proyecto en Visual Studio.
- Modifica el archivo `ofApp.h` así:

```cpp
#pragma once

#include "ofMain.h"

class ofApp : public ofBaseApp{

    public:
        void setup();
        void update();
        void draw();

        void mouseMoved(int x, int y );
        void mousePressed(int x, int y, int button);

    private:

        vector<ofVec2f> particles;
        ofColor particleColor;

};
```

- Ahora modifica el archivo `ofApp.cpp` así:

```cpp
#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    ofBackground(0);
    particleColor = ofColor::white;
}

//--------------------------------------------------------------
void ofApp::update(){

}

//--------------------------------------------------------------
void ofApp::draw(){
    for(auto &pos: particles){
        ofSetColor(particleColor);
        ofDrawCircle(pos.x, pos.y, 50);
    }
}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y ){
    particles.push_back(ofVec2f(x, y));
    if (particles.size() > 100) {
        particles.erase(particles.begin());
    }
}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button){
    particleColor = ofColor(ofRandom(255), ofRandom(255), ofRandom(255));
}
```

Analicemos juntos este código:

- ¿Qué fue lo que incluimos en el archivo .h?
- ¿Cómo funciona la aplicación?
- ¿Qué hace la función mouseMoved?
- ¿Qué hace la función mousePressed?
- ¿Qué hace la función setup?
- ¿Qué hace la función update?
- ¿Qué hace la función draw?

**Respuestas:**

- **¿Qué fue lo que incluimos en el archivo ´.h´?**

Se crea la clase ´ofApp´, que toma como base otra clase llamada ´ofBaseApp´. Dentro de ella están las funciones que controlan lo que hace el programa (como setup, update, draw, mouseMoved y mousePressed), y también dos elementos internos para guardar información: una lista de posiciones llamada ´particles´ y un color llamado ´particleColor´.

- **¿Cómo funciona la aplicación?**

Al mover el mouse, se dibujan círculos en las posiciones recorridas, y al hacer clic se cambia aleatoriamente el color de todos los círculos. Solo se guardan las últimas 100 posiciones para evitar sobrecargar la memoria.

- **¿Qué hace la función ´mouseMoved´?**

Guarda la posición actual del mouse en el vector particles y, si hay más de 100 elementos, elimina el más antiguo.

- **¿Qué hace la función ´mousePressed´?**

Cambia particleColor a un color aleatorio usando valores entre 0 y 255 para rojo, verde y azul.

- **¿Qué hace la función ´setup´?**

Establece el fondo en negro y el color inicial de las partículas en blanco.

- **¿Qué hace la función update?**

En este caso, no realiza ninguna acción, pero se usa normalmente para actualizar variables y lógica antes de dibujar.

- **¿Qué hace la función ´draw?´**

Recorre todas las posiciones guardadas en ´particles´ y dibuja un círculo con un radio de 50 píxeles usando el color actual.