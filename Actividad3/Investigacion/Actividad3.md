## Actividad 3 - 13/08/2025

Analiza la aplicación anterior. ¿Qué hace cada función? ¿Qué hace cada línea de código?

Realiza un experimento con la aplicación anterior. Modifica alguna parte de su código.

**Código original:**

```cpp
#include "ofApp.h"                                                 

//--------------------------------------------------------------
void ofApp::setup() {                                               
    ofBackground(0);
    particleColor = ofColor::white;
}

//--------------------------------------------------------------
void ofApp::update() {

}

//--------------------------------------------------------------
void ofApp::draw() {
    for (auto& pos : particles) {
        ofSetColor(particleColor);
        ofDrawCircle(pos.x, pos.y, 50);
    }
}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y) {
    particles.push_back(ofVec2f(x, y));
    if (particles.size() > 100) {
        particles.erase(particles.begin());
    }
}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button) {
    particleColor = ofColor(ofRandom(255), ofRandom(255), ofRandom(255));
}
```

**Código modificado:**
```cpp
#include "ofApp.h"                                                 

//--------------------------------------------------------------
void ofApp::setup() {                                               
    ofBackground(0);
    particleColor = ofColor::red;
}

//--------------------------------------------------------------
void ofApp::update() {

}

//--------------------------------------------------------------
void ofApp::draw() {
    for (auto& pos : particles) {
        ofSetColor(particleColor);
        ofDrawCircle(pos.x, pos.y, 20);
    }
}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y) {
    particles.push_back(ofVec2f(x, y));
    if (particles.size() > 100) {
        particles.erase(particles.begin());
    }
}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button) {
    particleColor = ofColor(ofRandom(255), ofRandom(255), ofRandom(255));
}
```

**Explicación modificación:** A modo de experimento se hicieron las siguientes modificaciones: 

- En la línea 6 del código se modifico en la función `particleColor` el color inicial de la partícula de blanco a rojo.
- En la línea 18 del código se modificó el tamaño de la partícula de 50 pixeles a 20.

**¿Qué hace cada función?:**

- `setup():` Pone el fondo negro y define el color inicial de la partícula (en este caso rojo).
- `update():` No realiza ninguna acción.
- `draw():` Dibuja las partículas usando el color y tamaño actual.
- `mouseMoved():` Sigue el mouse y guarda la posición hasta llegar a 100.
- `mousePressed():` Si el mouse es presionado cambia el color del círculo.
