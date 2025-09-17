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

## Exploración de métodos virtuales

**¿En qué parte de la memoria se encuentran las vtable de cada objeto?**

- Cada objeto con métodos virtuales contiene un puntero oculto llamado `vptr`.
- Este puntero se almacena dentro del bloque de memoria de la instancia, justo al inicio.
- El `vptr` apunta a una `vtable` que está en la sección de código (text) o de datos de solo lectura (rodata) del ejecutable.
- Esto significa que todas las instancias comparten la misma vtable de su clase.
- **Entonces:**
  	- `b` tiene un `vptr` que apunta a `vtable_Base`.
  	- `d` tiene un `vptr` que apunta a `vtable_Derived`.
  	  
### Evidencia 1:

<img width="324" height="50" alt="Captura de pantalla 2025-09-17 171356" src="https://github.com/user-attachments/assets/f859036a-e1dc-4297-b887-07d3b1845a2d" />

Confirma lo siguiente:

- Cada clase con métodos virtuales tiene una vtable propia.
- Las direcciones son distintas porque:
  	- `Base` apunta a la `vtable` que contiene el puntero a `Base::display`.
  	- `Derived` apunta a la `vtable` que contiene el puntero a `Derived::display`.

Esto demuestra que:

- La vtable está en una zona global de memoria (no dentro del objeto en sí).
- Cada instancia de `Base` compartirá la misma dirección de `vtable` entre sí, y cada instancia de `Derived` también compartirá su propia `vtable`.
- En cada objeto con métodos virtuales, el compilador agrega un puntero oculto a su `vtable` (`vptr`), que apunta a esas direcciones globales.

**¿Cómo afecta la presencia de métodos virtuales al tamaño del objeto?**

- `sizeof(Base)` y `sizeof(Derived)` serán al menos 8 bytes más que una clase sin métodos virtuales (el tamaño de un puntero, el `vptr`).
- El `cout` de `*(void**)&obj` imprime la dirección de la vtable a la que apunta el `vptr`.

### Evidencia 2:

<img width="174" height="63" alt="Captura de pantalla 2025-09-17 172223" src="https://github.com/user-attachments/assets/4c6c6513-e54c-42bf-861e-f68166ba4c5a" />

Esto indica:

- Plain es una clase sin métodos virtuales → ocupa solo el espacio de sus atributos (probablemente 2 int → 8 bytes en total).
- Base y Derived tienen métodos virtuales → el compilador agrega un puntero oculto a la vtable (vptr) dentro de cada objeto.
- El puntero (vptr) ocupa 8 bytes y se superpone al espacio ya existente de los atributos, de modo que el tamaño total sigue siendo 8 bytes porque probablemente cada clase solo tiene 2 int (8 bytes) y el compilador no necesita agregar padding extra.

Conclusión:

- La presencia de métodos virtuales añade un puntero oculto (vptr) en cada objeto, lo que puede aumentar su tamaño. En este caso no aumentó porque el tamaño ya era múltiplo de 8, pero el puntero está ahí.

**¿Qué papel juegan las vtables en el polimorfismo?**

Cuando llamas a `obj.display()` y `display` es **virtual**, el compilador:
- Obtiene la dirección del `vptr` (almacenado en el objeto).
- Sigue el puntero a la `vtable`.
- Busca en la tabla la dirección de la función display.
- Llama a esa función a través de la dirección obtenida.

Esto permite que el método llamado dependa del tipo real del objeto en tiempo de ejecución (polimorfismo dinámico).

Sin virtuales, las llamadas se resuelven en tiempo de compilación.

### Evidencia 3:

<img width="186" height="85" alt="Captura de pantalla 2025-09-17 172516" src="https://github.com/user-attachments/assets/15d82116-e7ac-446f-aedd-7d43940001c9" />

Esto indica:

- Aunque ptr es un puntero a Base, se ejecutó `Derived::display()`.
- Esto ocurre porque la llamada al método se resuelve en tiempo de ejecución usando la vtable:
  	- Cada objeto con métodos virtuales tiene un puntero oculto vptr.
  	- Este vptr apunta a la vtable correspondiente a la clase real del objeto (Derived en este caso).
  	- Al llamar ptr->display(), el programa busca la dirección de display() en la vtable de Derived y la ejecuta.

Conclusión:

- La vtable permite el polimorfismo dinámico en C++. Sin ella, el compilador siempre llamaría a Base::display(), pero gracias a la vtable el programa puede decidir en tiempo de ejecución qué versión llamar.

**¿Cómo se implementan los métodos virtuales en C++?**

Cada objeto guarda un `vptr` el cual apunta a la `vtable`, la cual contiene punteros a las funciones virtuales correctas.

#### Evidencia 4:

<img width="1886" height="892" alt="Captura de pantalla 2025-09-17 173052" src="https://github.com/user-attachments/assets/21c15f3c-cd82-48a9-b18a-315e8382c2e7" />

En C++, los métodos virtuales se implementan mediante una estructura especial llamada vtable (tabla virtual).

Cuando una clase tiene métodos virtuales, el compilador añade a cada objeto de esa clase un puntero oculto llamado vptr, que apunta a la vtable correspondiente a su tipo dinámico.

La vtable contiene las direcciones de memoria de las funciones virtuales de la clase. Cuando se invoca un método virtual, el programa no llama directamente a la función, sino que:
- Obtiene el vptr del objeto.
- Accede a la vtable a la que apunta ese vptr.
- Busca en la tabla la dirección del método correspondiente.
- Llama a esa dirección, ejecutando la versión correcta según el tipo real del objeto.

Este mecanismo permite el despacho dinámico, es decir, que se llame a la versión correcta del método incluso si se accede al objeto a través de un puntero o referencia de la clase base.

En el _Disassembly_ se pudo observar este proceso: primero se carga la dirección del objeto, luego la dirección de su vtable, y finalmente se llama a la función ubicada en esa tabla, confirmando cómo el compilador implementa el polimorfismo.
