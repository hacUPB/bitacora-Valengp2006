# Sesión 2: ubicación en memoria de datos y métodos
## Análisis de la estructura de una clase - 17/09/2025

En C++, una clase está compuesta por atributos (datos) y métodos (funciones miembro). Cada uno se almacena en diferentes regiones de memoria, y su ubicación depende del tipo y del modo en que se usan:

**Atributos (datos miembro):**

- **Atributos no estáticos:**
  - **Forman parte de cada instancia de la clase. Cuando creas un objeto:**
    - Si lo creas como variable local → su memoria se reserva en el stack.
    - Si lo creas con new o make_unique → su memoria se reserva en el heap.
    - Estos atributos quedan dentro del bloque de memoria del objeto, y su tamaño define el tamaño total de la instancia.

- **Atributos estáticos:**
  - No pertenecen a ninguna instancia concreta.
  - Se almacenan en una sola copia común para toda la clase, ubicada en la sección de datos estáticos del programa.
  - No incrementan el tamaño de los objetos.

### Evidencia 1:

<img width="457" height="116" alt="Captura de pantalla 2025-09-17 164126" src="https://github.com/user-attachments/assets/5b426478-55f7-4190-a4dc-9daade192086" />

La salida confirma justo lo que queríamos comprobar sobre los datos (atributos) de la clase:

- p1 empieza en ...4B80
- p2 empieza en ...4B88

Están separados 8 bytes, lo cual coincide con sizeof(Particle) = 8.
Eso significa que cada instancia tiene su propio bloque de memoria de 8 bytes.

- p1.x está en ...4B80
- p1.y en ...4B84

Están justo uno después del otro (contiguos), separados por 4 bytes cada uno.

**Conclusión de este paso:**

- Los atributos se almacenan contiguos en memoria dentro de cada objeto.
- Cada objeto reserva su propio bloque en el stack (o heap, si usas new).
- El tamaño del objeto (sizeof) depende solo de los atributos de instancia, no de los métodos.

**Métodos (funciones miembro):**

- El código de los métodos está compilado y almacenado en la sección de código (o sección de texto) del ejecutable.
- No se copian dentro de cada objeto.
- Todas las instancias llaman al mismo bloque de código de un método, pasando un puntero oculto (this) para acceder a sus propios datos.

### Evidencia 2:

<img width="459" height="154" alt="Captura de pantalla 2025-09-17 164512" src="https://github.com/user-attachments/assets/754cb567-0337-4dd2-8b6c-b646e32fc315" />

Este segundo resultado confirma lo que esperábamos sobre los métodos no virtuales:

- sizeof(Particle) = 8
- sizeof(ParticleWithMethod) = 8

El tamaño no cambió, a pesar de que `ParticleWithMethod` tiene un método adicional.

**Conclusión de este paso**

- Los métodos no forman parte de la instancia del objeto.
- Su código se almacena en la sección de código (text segment) del programa, compartido por todas las instancias.
- Solo los atributos (datos miembros no estáticos) ocupan espacio en cada objeto.

**Vtable (tabla virtual):**

- Cuando una clase declara métodos virtuales, el compilador crea una estructura oculta llamada vtable (virtual table).
- La vtable es una tabla de punteros a funciones que apunta a las implementaciones correctas de los métodos virtuales.
- Cada instancia de una clase con métodos virtuales contiene un puntero oculto a su vtable, llamado vptr.
- Esto permite que, al llamar un método virtual, el programa resuelva dinámicamente en tiempo de ejecución cuál versión del método invocar (polimorfismo dinámico).
- La vtable está en la sección de datos estáticos (una por clase con métodos virtuales).
- El vptr sí ocupa espacio dentro de cada objeto (generalmente del tamaño de un puntero).

### Evidencia 3: 

<img width="449" height="194" alt="Captura de pantalla 2025-09-17 165017" src="https://github.com/user-attachments/assets/4f7842ed-2510-4784-8b1e-3c4c48a898d0" />

Este resultado completa el experimento y confirma la teoría sobre la vtable:

- sizeof(Particle) → 8 bytes
- sizeof(ParticleWithMethod) → 8 bytes
- sizeof(ParticleVirtual) → 16 bytes

La única diferencia es que `ParticleVirtual` tiene al menos un método virtual, lo que hace que:

- Se añada un puntero oculto llamado vptr (virtual table pointer) dentro de cada instancia.
- Este puntero apunta a una vtable (tabla de funciones virtuales) que está en la sección de código y es compartida por todas las instancias de esa clase.

**Conclusión:**

- Los atributos viven en cada instancia.
- Los métodos no virtuales viven en la sección de código y no ocupan espacio en el objeto.
- Los métodos virtuales agregan un puntero vptr por instancia, lo que aumenta el tamaño de cada objeto.

### Código usado para las pruebas:

`ofApp.h`:

```cpp
#pragma once

#include "ofMain.h"

class Particle {
public:
	int x;
	int y;
};

Particle p1;
Particle p2;


class ParticleWithMethod {
public:
	int x;
	int y;
	void move(int dx, int dy) {
		x += dx;
		y += dy;
	}
};

class ParticleVirtual {
public:
	int x;
	int y;
	virtual void move(int dx, int dy) {
		x += dx;
		y += dy;
	}
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

`ofApp.cpp`
```cpp
#include "ofApp.h"

void ofApp::setup(){

    ParticleVirtual p;

    ofLog() << "--- Direcciones de objetos ---";
    ofLog() << "p1: " << &p1 << "   p2: " << &p2;

    ofLog() << "--- Direcciones de atributos ---";
    ofLog() << "&p1.x: " << &p1.x << "   &p1.y: " << &p1.y;

    ofLog() << "--- Tamaño de la clase ---";
    ofLog() << "sizeof(Particle): " << sizeof(Particle);

    ofLog() << "--- Tamaño de la clase ---";
    ofLog() << "sizeof(ParticleWithMethod): " << sizeof(ParticleWithMethod);

    ofLog() << "--- Tamaño de la clase ---";
    ofLog() << "sizeof(ParticleVirtual): " << sizeof(ParticleVirtual);
}
```
