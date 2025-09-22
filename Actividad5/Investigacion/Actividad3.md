# Sesión 3: implementación Interna de Encapsulamiento, Herencia y Polimorfismo
## Profundizando en el encapsulamiento

**¿Cómo implementa el compilador el encapsulamiento en C++? Si los miembros privados aún ocupan espacio en el objeto, ¿Qué impide que se acceda a ellos desde fuera de la clase?**

- Los miembros privados y protegidos siguen existiendo en la memoria del objeto.
	- Cada objeto reserva espacio para privateVar, protectedVar y publicVar.
	- Por ejemplo, sizeof(AccessControl) será igual a la suma de los tamaños de sus atributos (posiblemente con padding).

- El compilador controla el acceso durante la compilación:
	- Si un código externo intenta modificar o leer privateVar, el compilador genera un error de compilación.
	- No existe ninguna verificación en tiempo de ejecución: el objeto sigue conteniendo los datos, pero el compilador impide que se acceda a ellos de manera incorrecta.

**Encapsulamiento**

#### Evidencia 1:

<img width="347" height="73" alt="Captura de pantalla 2025-09-22 a la(s) 5 36 24 p m" src="https://github.com/user-attachments/assets/d08ff285-b463-4eb5-acad-23f4b85b4018" />

- `publicVar` se puede modificar directamente desde `main()` o `setup()` → acceso permitido.  
- `privateVar` y `protectedVar` no se pueden modificar desde fuera de la clase; el compilador bloquea el acceso.  
- Se puede acceder a los miembros privados y protegidos mediante **métodos públicos** (`getPrivate()`, `getProtected()`), confirmando que el espacio en memoria sigue reservado para ellos, pero la protección se aplica en tiempo de compilación.  

**Conclusión:**  

El compilador implementa el encapsulamiento controlando el acceso a los miembros de la clase. Los datos privados/protegidos existen en memoria, pero no se pueden manipular directamente desde fuera de la clase.

#### Código usado:

`ofApp.cpp:`
```javascript
#include "ofApp.h"

void ofApp::setup() {
    std::cout << "===== Experimento 1: Encapsulamiento =====\n";

    AccessControl ac;

    // Acceso permitido
    ac.publicVar = 10;
    std::cout << "Public var: " << ac.publicVar << std::endl;

    // Acceso prohibido (descomentar para ver errores de compilación)
    // ac.privateVar = 20;
    // ac.protectedVar = 30;

    // Acceso mediante métodos públicos
    std::cout << "Private var via getter: " << ac.getPrivate() << std::endl;
    std::cout << "Protected var via getter: " << ac.getProtected() << std::endl;
}

void ofApp::update() {}
void ofApp::draw() {}
void ofApp::keyPressed(int key) {}
void ofApp::keyReleased(int key) {}
void ofApp::mouseMoved(int x, int y) {}
void ofApp::mouseDragged(int x, int y, int button) {}
void ofApp::mousePressed(int x, int y, int button) {}
void ofApp::mouseReleased(int x, int y, int button) {}
void ofApp::mouseEntered(int x, int y) {}
void ofApp::mouseExited(int x, int y) {}
void ofApp::windowResized(int w, int h) {}
void ofApp::dragEvent(ofDragInfo dragInfo) {}
void ofApp::gotMessage(ofMessage msg) {}
```
`ofApp.h:`
```javascript
#pragma once
#include "ofMain.h"
#include <iostream>

class AccessControl {
private:
    int privateVar;
protected:
    int protectedVar;
public:
    int publicVar;

    AccessControl() : privateVar(1), protectedVar(2), publicVar(3) {}

    // Métodos públicos para acceder a los privados/protegidos
    int getPrivate() { return privateVar; }
    int getProtected() { return protectedVar; }
};
 
class ofApp : public ofBaseApp{
public:
    void setup();
    void update();
    void draw();

    void keyPressed(int key);
    void keyReleased(int key);
    void mouseMoved(int x, int y );
    void mouseDragged(int x, int y, int button);
    void mousePressed(int x, int y, int button);
    void mouseReleased(int x, int y, int button);
    void mouseEntered(int x, int y);
    void mouseExited(int x, int y);
    void windowResized(int w, int h);
    void dragEvent(ofDragInfo dragInfo);
    void gotMessage(ofMessage msg);
};
```
**Herencia**

#### Evidencia 2:

