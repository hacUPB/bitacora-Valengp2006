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
