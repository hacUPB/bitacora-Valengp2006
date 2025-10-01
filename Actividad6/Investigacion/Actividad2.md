# Sesión 2: análisis de un caso de estudio - 01/10/2025

**¿Qué hace el patrón Observer en este caso?**

Está representado en las clases `Observer` y `Subject`.

- La clase `Observer` define el método `onNotify`, que permite que cualquier clase que lo implemente pueda “escuchar” eventos.
- La clase `Subject` mantiene una lista de observadores suscritos y los notifica con el método `notify`.
- En el `setup` de `ofApp`, las partículas se registran como observadores. Así, cuando el usuario presiona una tecla, `ofApp` envía un evento (ejemplo: `"stop"`, `"attract"`, `"repel"`, `"normal"`).
- Luego, cada partícula recibe ese evento en `Particle::onNotify` y cambia su comportamiento dependiendo de lo que se haya notificado.
- En resumen: permite que **todas las partículas reaccionen automáticamente a las teclas**, sin que `ofApp` tenga que controlarlas una por una.

**¿Qué hace el patrón Factory en este caso?**

Está representado en la clase `ParticleFactory`.

- Este patrón se encarga de **crear diferentes tipos de partículas** (`star`, `shooting_star`, `planet`) con distintos atributos como tamaño, color y velocidad.
- Así se evita tener que crear clases separadas para cada tipo de partícula. En lugar de eso, la lógica de inicialización está centralizada en un solo lugar.
- En resumen: facilita **crear partículas con diferentes características** sin duplicar código.

**¿Qué hace el patrón State en este caso?**

Está representado en las clases `State` y sus derivados (`NormalState`, `AttractState`, `RepelState`, `StopState`).

- Cada partícula tiene un puntero a un `State`, que define cómo se va a actualizar en cada frame.
- Cuando se cambia de estado con `setState`, el estado anterior se elimina y se asigna el nuevo.
- Luego, en el método `update`, la partícula ejecuta el comportamiento correspondiente a su estado actual (moverse normalmente, acercarse al mouse, alejarse del mouse o detenerse).
- En resumen: permite que **una misma partícula cambie de comportamiento dinámicamente**, dependiendo del estado en el que esté.

**Diagrama de relaciones**

```
               +-----------------+
               |     ofApp       |
               |   (Subject)     |
               +-----------------+
                   |   notify()
                   v
         -------------------------------
         |   Particles (Observers)     |
         |   implement onNotify()      |
         -------------------------------
                   |
                   | setState()
                   v
        +-------------------+
        |   State (base)    |
        |-------------------|
        | + update()        |
        | + onEnter()       |
        | + onExit()        |
        +---------+---------+
                  |
   --------------------------------------------
   |                |               |          |
+----------+   +------------+   +---------+  +---------+
| Normal   |   | Attract    |   | Repel   |  | Stop    |
| State    |   | State      |   | State   |  | State   |
+----------+   +------------+   +---------+  +---------+


            +-------------------------+
            |   ParticleFactory       |
            +-------------------------+
            | createParticle(type)    |
            +-------------------------+
                   |
                   v
         --------------------------------
         |   Creates different types     |
         |   of Particles:               |
         |   - "star"                    |
         |   - "shooting_star"           |
         |   - "planet"                  |
         --------------------------------
```

- **Observer:**

  - `ofApp` (Subject) → manda notificaciones (`notify()`) cuando presionas una tecla.
  - Todas las `Particle` (Observers) → escuchan el evento en `onNotify()` y cambian de estado.

- **State:**

  - Cada `Particle` tiene un puntero `state`.
  - Según el estado actual (`NormalState`, `AttractState`, `RepelState`, `StopState`), la partícula se comporta diferente en `update()`.

- **Factory:**

  - `ParticleFactory` → se encarga de crear partículas con distintas características (`star`, `shooting_star`, `planet`).
  - Así `ofApp` puede pedir partículas ya configuradas sin preocuparse por sus detalles.
  - 
### Código modificado

`ofApp.cpp`
```cpp
#include "ofApp.h"

void Subject::addObserver(Observer* observer) {
    observers.push_back(observer);
}

void Subject::removeObserver(Observer* observer) {
    observers.erase(std::remove(observers.begin(), observers.end(), observer), observers.end());
}

void Subject::notify(const std::string& event) {
    for (Observer* observer : observers) {
        observer->onNotify(event);
    }
}

Particle::Particle() {
    position = ofVec2f(ofRandomWidth(), ofRandomHeight());
    velocity = ofVec2f(ofRandom(-0.5f, 0.5f), ofRandom(-0.5f, 0.5f));
    size = ofRandom(2, 5);
    color = ofColor(255);
    visible = true;

    state = new NormalState();
}

Particle::~Particle() {
    delete state;
}

void Particle::setState(State* newState) {
    if (state != nullptr) {
        state->onExit(this);
        delete state;
    }
    state = newState;
    if (state != nullptr) {
        state->onEnter(this);
    }
}

void Particle::update() {
    if (state != nullptr) {
        state->update(this);
    }
    if (position.x < 0 || position.x > ofGetWidth()) velocity.x *= -1;
    if (position.y < 0 || position.y > ofGetHeight()) velocity.y *= -1;
}

void Particle::draw() {
    if (visible) { 
        ofSetColor(color);
        ofDrawCircle(position, size);
    }
}

void Particle::onNotify(const std::string& event) {
    if (event == "attract") setState(new AttractState());
    else if (event == "repel") setState(new RepelState());
    else if (event == "stop") setState(new StopState());
    else if (event == "normal") setState(new NormalState());
    else if (event == "blink") setState(new BlinkState()); 
}

void NormalState::update(Particle* particle) {
    particle->position += particle->velocity;
}

void NormalState::onEnter(Particle* particle) {
    particle->velocity = ofVec2f(ofRandom(-0.5f, 0.5f), ofRandom(-0.5f, 0.5f));
}

void AttractState::update(Particle* particle) {
    ofVec2f mousePosition(((ofApp*)ofGetAppPtr())->mouseX, ((ofApp*)ofGetAppPtr())->mouseY);
    ofVec2f direction = mousePosition - particle->position;
    direction.normalize();
    particle->velocity += direction * 0.05;
    ofClamp(particle->velocity.x, -3, 3);
    particle->position += particle->velocity * 0.2;
}

void RepelState::update(Particle* particle) {
    ofVec2f mousePosition(((ofApp*)ofGetAppPtr())->mouseX, ((ofApp*)ofGetAppPtr())->mouseY);
    ofVec2f direction = particle->position - mousePosition;
    direction.normalize();
    particle->velocity += direction * 0.05;
    ofClamp(particle->velocity.x, -3, 3);
    particle->position += particle->velocity * 0.2;
}

void StopState::update(Particle* particle) {
    particle->velocity.x = 0;
    particle->velocity.y = 0;
}

void BlinkState::update(Particle* particle) {
    particle->visible = (ofGetFrameNum() % 30 < 15); 
    particle->position += particle->velocity * 0.5;
}

Particle* ParticleFactory::createParticle(const std::string& type) {
    Particle* particle = new Particle();

    if (type == "star") {
        particle->size = ofRandom(2, 4);
        particle->color = ofColor(255, 0, 0);
    }
    else if (type == "shooting_star") {
        particle->size = ofRandom(3, 6);
        particle->color = ofColor(0, 255, 0);
        particle->velocity *= 3;
    }
    else if (type == "planet") {
        particle->size = ofRandom(5, 8);
        particle->color = ofColor(0, 0, 255);
    }
    
    else if (type == "comet") {
        particle->size = ofRandom(6, 10);
        particle->color = ofColor(200, 200, 255); 
        particle->velocity *= 4; 
    }
    return particle;
}


void ofApp::setup() {
    ofBackground(0);

    for (int i = 0; i < 100; ++i) {
        Particle* p = ParticleFactory::createParticle("star");
        particles.push_back(p);
        addObserver(p);
    }

    for (int i = 0; i < 5; ++i) {
        Particle* p = ParticleFactory::createParticle("shooting_star");
        particles.push_back(p);
        addObserver(p);
    }

    for (int i = 0; i < 10; ++i) {
        Particle* p = ParticleFactory::createParticle("planet");
        particles.push_back(p);
        addObserver(p);
    }

    for (int i = 0; i < 3; ++i) {
        Particle* p = ParticleFactory::createParticle("comet");
        particles.push_back(p);
        addObserver(p);
    }
}

void ofApp::update() {
    for (Particle* p : particles) {
        p->update();
    }
}

void ofApp::draw() {
    for (Particle* p : particles) {
        p->draw();
    }
}

void ofApp::keyPressed(int key) {
    if (key == 's') notify("stop");
    else if (key == 'a') notify("attract");
    else if (key == 'r') notify("repel");
    else if (key == 'n') notify("normal");
    else if (key == 'b') notify("blink"); 
}
```

`ofApp.h`
```cpp
#pragma once

#include "ofMain.h"
#include <vector>
#include <string>

class Observer {
public:
    virtual void onNotify(const std::string& event) = 0;
};

class Subject {
public:
    void addObserver(Observer* observer);
    void removeObserver(Observer* observer);
protected:
    void notify(const std::string& event);
private:
    std::vector<Observer*> observers;
};

class Particle;

class State {
public:
    virtual void update(Particle* particle) = 0;
    virtual void onEnter(Particle* particle) {}
    virtual void onExit(Particle* particle) {}
    virtual ~State() = default;
};

class Particle : public Observer {
public:
    Particle();
    ~Particle();

    void update();
    void draw();
    void onNotify(const std::string& event) override;
    void setState(State* newState);

    ofVec2f position;
    ofVec2f velocity;
    float size;
    ofColor color;
    bool visible;

private:
    State* state;
};


class NormalState : public State {
public:
    void update(Particle* particle) override;
    virtual void onEnter(Particle* particle) override;
};

class AttractState : public State {
public:
    void update(Particle* particle) override;
};

class RepelState : public State {
public:
    void update(Particle* particle) override;
};

class StopState : public State {
public:
    void update(Particle* particle) override;
};

class BlinkState : public State {
public:
    void update(Particle* particle) override;
};

class ParticleFactory {
public:
    static Particle* createParticle(const std::string& type);
};

class ofApp : public ofBaseApp, public Subject {
public:
    void setup();
    void update();
    void draw();
    void keyPressed(int key);
private:
    std::vector<Particle*> particles;
};
```
