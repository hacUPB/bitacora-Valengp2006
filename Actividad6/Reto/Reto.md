# Proyecto: Cielo Generativo Interactivo - 06/10/2025

### Descripción del Proyecto

Este proyecto consiste en un sistema de arte generativo en tiempo real desarrollado en C++ con openFrameworks. El sistema simula un cielo dinámico que cambia entre diferentes estados atmosféricos de forma artística y abstracta.

Los estados disponibles son:

1. Cielo calmado → Estrellas y partículas suaves.
2.	Tormenta → Lluvia intensa, relámpagos y movimiento brusco.
3.	Nublado → Formación de nubes densas y cambiantes.

Cada estado presenta una composición visual diferente, evocando un fenómeno natural a través de patrones visuales generativos.

### Interacciones del Usuario

El usuario puede cambiar de estado con las teclas:

-	1 → Cielo calmado
-	2 → Tormenta
-	3 → Nublado

Además, cada estado posee interacciones específicas:

- **Estado Calmado**
	- Mouse clic: genera destellos brillantes.
	- Tecla +: agrega estrellas al cielo.
	- Tecla -: elimina estrellas.

- **Estado Tormenta**
	- Mouse clic: lanza un rayo en la posición del cursor.
	- Tecla ↑: aumenta la intensidad de la lluvia.
	- Tecla ↓: disminuye la intensidad de la lluvia.
	- Tecla r: genera un rayo en el centro de la pantalla.

- **Estado Nublado**
	- Mouse clic: abre un “hueco” en las nubes, como un rayo de sol.
	- Tecla ↑: incrementa la densidad general de nubes.
	- Tecla ↓: reduce la densidad de nubes.
	- Tecla c: limpia los huecos y regenera las nubes.

## Patrones de Diseño Implementados:

- **State**
	- Define el comportamiento del sistema según el estado actual del cielo.
	- Cada estado (CalmState, StormState, CloudyState) contiene su propia lógica de update, draw e interacciones.
	- Permite transiciones fluidas sin alterar la estructura del programa.

- **Factory**
	- Encargado de crear los estados cuando el usuario cambia con las teclas (1, 2, 3).
	- Centraliza la lógica de instanciación y facilita extender el sistema (por ejemplo, agregar un estado de “Aurora”).
	- Aporta escalabilidad y reduce acoplamiento en el código.

- **Observer**
	- Implementa un sistema de notificación automática: cuando el estado cambia, los observadores (HUD, interfaz, subsistemas gráficos) reciben la actualización.
	- Garantiza que siempre se muestre el estado actual y sus interacciones sin necesidad de modificar múltiples módulos.

### Conclusión

El proyecto combina arte generativo con patrones de diseño de software, logrando una experiencia interactiva donde el usuario no solo observa un paisaje visual, sino que lo transforma en tiempo real.

Gracias a la arquitectura basada en State, Factory y Observer, el sistema resulta flexible, organizado y preparado para escalar con nuevos estados e interacciones.

## Evidencias de los resultados de aprendizaje

### RAE1 — Construcción e implementación

Para evidenciar el **RAE1**, desarrollé una aplicación interactiva basada en el **Patrón State** y el **Patrón Observer**, donde cada estado (Calmado, Tormenta y Nublado) define su propio comportamiento frente a eventos de teclado y mouse.

El código fuente demuestra la aplicación de los principios de encapsulamiento y comunicación desacoplada entre estados, cumpliendo los requisitos funcionales del reto.
Además, se adjunta un video mostrando la ejecución y transición entre los estados.

### RAE2 — Pruebas de las partes y del todo

Para evidenciar el **RAE2**, realicé pruebas individuales y globales del software.

**Pruebas por patrón:**

- **Patrón State:** se verificó que cada estado responde correctamente a los eventos asignados:

	-*Calmado*: clic → destellos, “+” y “–” → manejo de estrellas.
	- *Tormenta*: clic → rayo, “↑” y “↓” → intensidad de lluvia, “r” → rayo central.
	- *Nublado*: clic → hueco solar, “↑” y “↓” → densidad de nubes, “c” → regenerar.
- **Patrón Observer:** se comprobó que al cambiar de estado, los observadores actualizan correctamente la visualización sin conflictos entre comportamientos anteriores.

**Prueba de integración:**

Se realizaron ciclos completos de ejecución pasando por todos los estados, comprobando que las transiciones son fluidas, los efectos visuales permanecen coherentes y no se generan errores en consola ni bloqueos durante la ejecución.

### Evidencias adjuntas:

#### Código:
`ofApp.h:`
```cpp
#pragma once
#include "ofMain.h"
#include <memory>
#include <vector>
#include <string>
#include <algorithm>

// =======================================================
// Patrón OBSERVER
// =======================================================
class IObserver {
public:
    virtual void onStateChange(const std::string& newState) = 0;
    virtual ~IObserver() = default;
};

class Subject {
    std::vector<IObserver*> observers;
public:
    void addObserver(IObserver* obs) { observers.push_back(obs); }
    void removeObserver(IObserver* obs) {
        observers.erase(std::remove(observers.begin(), observers.end(), obs), observers.end());
    }
    void notify(const std::string& newState) {
        for (auto* obs : observers) obs->onStateChange(newState);
    }
};

// =======================================================
// Patrón STATE
// =======================================================
class State {
protected:
    Subject* subject = nullptr;
public:
    explicit State(Subject* s);
    virtual ~State() = default;
    virtual void enter() = 0;
    virtual void update() = 0;
    virtual void draw() = 0;
    virtual void exit() = 0;

    // NUEVO → eventos de entrada
    virtual void keyPressed(int key) {}
    virtual void mousePressed(int x, int y, int button) {}
};

// Calmado
class CalmState : public State {
    ofVec2f screen;
    std::vector<ofVec2f> stars;
    std::vector<ofVec2f> flashes;
    int targetStars = 80;
    void spawnStar();
public:
    CalmState(Subject* s, ofVec2f screenSize);
    void enter() override;
    void update() override;
    void draw() override;
    void exit() override;
    void keyPressed(int key) override;       // +
    void mousePressed(int x, int y, int b) override; // clic
};

// Tormenta
class StormState : public State {
    std::vector<ofVec2f> raindrops;
    std::vector<ofVec2f> lightning;
    int rainIntensity = 300;
    int timer = 0;
    ofVec2f screen;
public:
    StormState(Subject* s, ofVec2f screenSize);
    void enter() override;
    void update() override;
    void draw() override;
    void exit() override;
    void keyPressed(int key) override;
    void mousePressed(int x, int y, int b) override;
};

// Nublado
class CloudyState : public State {
    std::vector<ofVec2f> clouds;
    std::vector<ofVec2f> holes;
    ofVec2f screen;
    int density = 5;
public:
    CloudyState(Subject* s, ofVec2f screenSize);
    void enter() override;
    void update() override;
    void draw() override;
    void exit() override;
    void keyPressed(int key) override;
    void mousePressed(int x, int y, int b) override;
};

// =======================================================
// Patrón FACTORY
// =======================================================
class StateFactory {
public:
    static std::unique_ptr<State> createState(int key, Subject* s, ofVec2f screenSize);
};

// =======================================================
// OBSERVER visual
// =======================================================
class SkyObserver : public IObserver {
    std::string current;
public:
    void onStateChange(const std::string& newState) override {
        current = newState;
        ofLogNotice("Estado") << "Cambio de estado a: " << newState;
    }
    std::string getCurrentState() const { return current; }
};

// =======================================================
// ofApp principal
// =======================================================
class ofApp : public ofBaseApp, public Subject {
    std::unique_ptr<State> currentState;
    SkyObserver observer;
    ofVec2f screenSize;
public:
    void setup() override;
    void update() override;
    void draw() override;
    void keyPressed(int key) override;
    void mousePressed(int x, int y, int button) override;
};
```

`ofApp.cpp`
```cpp
#include "ofApp.h"

// =======================================================
// Base del patrón STATE
// =======================================================
State::State(Subject* s) { subject = s; }

// =======================================================
// CalmState
// =======================================================
CalmState::CalmState(Subject* s, ofVec2f screenSize)
    : State(s), screen(screenSize) {
}

void CalmState::spawnStar() {
    stars.push_back(ofVec2f(ofRandom(screen.x), ofRandom(screen.y)));
}

void CalmState::enter() {
    stars.clear();
    flashes.clear();
    for (int i = 0; i < targetStars; i++) spawnStar();
    subject->notify("Cielo Calmado");
}

void CalmState::update() {
    // Destellos se desvanecen gradualmente
    if (!flashes.empty()) {
        flashes.erase(flashes.begin());
    }
}

void CalmState::draw() {
    ofBackgroundGradient(ofColor(10, 10, 40), ofColor(0, 0, 0));
    ofSetColor(255);
    for (auto& s : stars) ofDrawCircle(s, 1.5);

    // Dibujar destellos
    ofSetColor(255, 255, 150);
    for (auto& f : flashes) ofDrawCircle(f, 6);
}

void CalmState::exit() {
    stars.clear();
    flashes.clear();
}

void CalmState::keyPressed(int key) {
    if (key == '+') {
        stars.push_back(ofVec2f(ofRandom(screen.x), ofRandom(screen.y)));
    }
    else if (key == '-') {
        if (!stars.empty()) stars.pop_back();
    }
}

void CalmState::mousePressed(int x, int y, int button) {
    flashes.push_back(ofVec2f(x, y));
}

// =======================================================
// StormState
// =======================================================
StormState::StormState(Subject* s, ofVec2f screenSize)
    : State(s), screen(screenSize) {
}

void StormState::enter() {
    raindrops.clear();
    lightning.clear();
    for (int i = 0; i < rainIntensity; i++)
        raindrops.push_back(ofVec2f(ofRandom(screen.x), ofRandom(-screen.y, screen.y)));
    subject->notify("Tormenta");
}

void StormState::update() {
    timer++;
    // Movimiento vertical de la lluvia
    for (auto& r : raindrops) {
        r.y += 8;
        if (r.y > screen.y) {
            r.x = ofRandom(screen.x);
            r.y = ofRandom(-screen.y, 0);
        }
    }
    // Desvanecer rayos con el tiempo
    if (!lightning.empty() && timer % 10 == 0)
        lightning.erase(lightning.begin());
}

void StormState::draw() {
    ofBackground(15, 15, 40);
    ofSetColor(100, 150, 255);
    for (auto& r : raindrops)
        ofDrawLine(r.x, r.y, r.x, r.y + 10);

    // Dibujar rayos
    ofSetColor(255, 255, 180);
    for (auto& l : lightning)
        ofDrawLine(l.x, 0, l.x + ofRandom(-20, 20), l.y);
}

void StormState::exit() {
    raindrops.clear();
    lightning.clear();
}

void StormState::keyPressed(int key) {
    if (key == OF_KEY_UP) {
        rainIntensity += 50;
        for (int i = 0; i < 50; i++)
            raindrops.push_back(ofVec2f(ofRandom(screen.x), ofRandom(-screen.y, 0)));
    }
    else if (key == OF_KEY_DOWN) {
        rainIntensity = std::max(50, rainIntensity - 50);
        if (raindrops.size() > rainIntensity)
            raindrops.resize(rainIntensity);
    }
    else if (key == 'r') {
        lightning.push_back(ofVec2f(screen.x / 2, screen.y / 2));
    }
}

void StormState::mousePressed(int x, int y, int button) {
    lightning.push_back(ofVec2f(x, y));
}

// =======================================================
// CloudyState
// =======================================================
CloudyState::CloudyState(Subject* s, ofVec2f screenSize)
    : State(s), screen(screenSize) {
}

void CloudyState::enter() {
    clouds.clear();
    holes.clear();
    for (int i = 0; i < density; i++)
        clouds.push_back(ofVec2f(ofRandom(screen.x), ofRandom(screen.y / 2)));
    subject->notify("Cielo Nublado");
}

void CloudyState::update() {
    for (auto& c : clouds) {
        c.x += 0.5;
        if (c.x > screen.x + 100) c.x = -100;
    }
}

void CloudyState::draw() {
    ofBackground(100, 120, 150);
    ofSetColor(255, 255, 255, 220);
    for (auto& c : clouds) {
        ofDrawCircle(c, 60);
        ofDrawCircle(c + ofVec2f(40, 10), 50);
        ofDrawCircle(c + ofVec2f(-40, 10), 50);
    }

    // Dibujar huecos (rayos de sol)
    ofSetColor(255, 230, 100, 180);
    for (auto& h : holes)
        ofDrawCircle(h, 40);
}

void CloudyState::exit() {
    clouds.clear();
    holes.clear();
}

void CloudyState::keyPressed(int key) {
    if (key == OF_KEY_UP) {
        density++;
        clouds.push_back(ofVec2f(ofRandom(screen.x), ofRandom(screen.y / 2)));
    }
    else if (key == OF_KEY_DOWN) {
        if (density > 1) density--;
        if (!clouds.empty()) clouds.pop_back();
    }
    else if (key == 'c') {
        holes.clear();
        clouds.clear();
        for (int i = 0; i < density; i++)
            clouds.push_back(ofVec2f(ofRandom(screen.x), ofRandom(screen.y / 2)));
    }
}

void CloudyState::mousePressed(int x, int y, int button) {
    holes.push_back(ofVec2f(x, y));
}

// =======================================================
// Factory
// =======================================================
std::unique_ptr<State> StateFactory::createState(int key, Subject* s, ofVec2f screenSize) {
    switch (key) {
    case '1': return std::make_unique<CalmState>(s, screenSize);
    case '2': return std::make_unique<StormState>(s, screenSize);
    case '3': return std::make_unique<CloudyState>(s, screenSize);
    default:  return std::make_unique<CalmState>(s, screenSize);
    }
}

// =======================================================
// ofApp
// =======================================================
void ofApp::setup() {
    ofSetFrameRate(60);
    screenSize = ofVec2f{ static_cast<float>(ofGetWidth()), static_cast<float>(ofGetHeight()) };
    addObserver(&observer);
    currentState = std::make_unique<CalmState>(this, screenSize);
    currentState->enter();
}

void ofApp::update() {
    if (currentState) currentState->update();
}

void ofApp::draw() {
    if (currentState) currentState->draw();

    ofSetColor(255);
    ofDrawBitmapStringHighlight("1 = Calmado | 2 = Tormenta | 3 = Nublado", 20, 20);
    ofDrawBitmapStringHighlight("Estado actual: " + observer.getCurrentState(), 20, 40);
}

void ofApp::keyPressed(int key) {
    if (key == '1' || key == '2' || key == '3') {
        currentState->exit();
        currentState = StateFactory::createState(key, this, screenSize);
        currentState->enter();
    }
    else {
        if (currentState) currentState->keyPressed(key);
    }
}

void ofApp::mousePressed(int x, int y, int button) {
    if (currentState) currentState->mousePressed(x, y, button);
}
```
**En Calmado:**

- Al hacer clic, se generan destellos brillantes.

<img width="1027" height="769" alt="Captura de pantalla 2025-10-08 164221" src="https://github.com/user-attachments/assets/b7b5c863-0dc1-4cc0-b419-0dfc2955ab8b" />

- Con “+” aparecen más estrellas.
  
<img width="1021" height="762" alt="Captura de pantalla 2025-10-08 164320" src="https://github.com/user-attachments/assets/3c1aefd0-e1e8-4edc-ba48-3b02a03ddaf7" />

- Con “–” desaparecen algunas estrellas.

**En Tormenta:**

<img width="1021" height="764" alt="Captura de pantalla 2025-10-08 164340" src="https://github.com/user-attachments/assets/b43622ab-ad3b-4298-973d-ba4549b8050a" />

- Con clic se lanza un rayo en la posición del cursor.

![Funcionamiento clic mouse](https://github.com/user-attachments/assets/f0527689-b521-43bc-83e9-a3a49b73b084)

- Con “↑” aumenta la intensidad de lluvia (más gotas).
  
![Grabación de pantalla 2025-10-08 165725](https://github.com/user-attachments/assets/95e66592-3181-4e4e-bcbd-753bdb35aa3e)

- Con “↓” disminuye la intensidad.

![Funcionamiento tecla abajo](https://github.com/user-attachments/assets/d7bd9002-0f04-44be-904f-8d21d184b255)

- Con “r” aparece un rayo en el centro.

![Funcionamiento tecla r](https://github.com/user-attachments/assets/1f84566f-0e4c-4491-8417-2b343cec7646)

**En Nublado, verifica que:**

- Clic abre un hueco en las nubes.
  
<img width="1022" height="764" alt="Captura de pantalla 2025-10-08 164724" src="https://github.com/user-attachments/assets/6bbf7cca-fd5f-4518-98df-459ede885894" />

- Con “↑” aumentas densidad.
  
<img width="1025" height="765" alt="Captura de pantalla 2025-10-08 164750" src="https://github.com/user-attachments/assets/bf63ca3e-8e1b-4aa8-9b2b-24d987076b49" />

- Con “↓” la reduces.
  
<img width="1022" height="768" alt="Captura de pantalla 2025-10-08 164807" src="https://github.com/user-attachments/assets/ad66ee45-4069-4860-9526-e9b389956180" />

- Con “c” regeneras las nubes.

<img width="1024" height="769" alt="Captura de pantalla 2025-10-08 164816" src="https://github.com/user-attachments/assets/a1cee621-19cb-44be-a42e-416f3ee8a558" />

**Mensaje en consola de cambio de estados:**

<img width="384" height="89" alt="Captura de pantalla 2025-10-08 164047" src="https://github.com/user-attachments/assets/5e936f95-f814-4ee4-855c-39bc6a0af10f" />

## Video de resultados

[Enlace al video](https://youtu.be/VucKwElTgk4)
