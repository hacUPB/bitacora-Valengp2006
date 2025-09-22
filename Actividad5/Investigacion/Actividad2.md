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

#### Evidencia 1:

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

#### Evidencia 2:

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

#### Evidencia 3: 

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

#### Código usado para las pruebas:

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
  	  
#### Evidencia 1:

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

#### Evidencia 2:

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

#### Evidencia 3:

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

#### Código usado para las pruebas:

`ofApp.h`
```cpp
#pragma once

#include "ofMain.h"

class Base {
public:
	virtual void display() {
		std::cout << "Base display\n";
	}
};

class Derived : public Base {
public:
	void display() override {
		std::cout << "Derived display\n";
	}
};

class Plain {
	int x, y;
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

void ofApp::setup() {
	Plain p;
	Base b;
	Derived d;

	std::cout << "sizeof(Plain):   " << sizeof(Plain) << std::endl;
	std::cout << "sizeof(Base):    " << sizeof(Base) << std::endl;
	std::cout << "sizeof(Derived): " << sizeof(Derived) << std::endl;

	Base* ptr = new Derived();
	ptr->display();  // Llama Derived::display, no Base::display
	delete ptr;
}
```
## Uso de punteros y referencias

**¿Cuál es la relación entre los punteros a métodos y la vtable?**

- Un puntero a método miembro en C++ puede apuntar a una función no virtual o a una virtual.
- Cuando el método no es virtual, el puntero guarda directamente la dirección de la función en la sección de código del programa.
- Cuando el método es virtual, el puntero no se resuelve directamente:
	- El compilador usa el vptr del objeto para consultar la vtable.
	- Desde la vtable obtiene la dirección real de la función en tiempo de ejecución.
- Esto significa que los punteros a métodos están estrechamente ligados al mecanismo de la vtable, ya que permiten que la llamada a la función se decida dinámicamente según el tipo real del objeto.

#### Evidencia 1:

<img width="284" height="43" alt="Captura de pantalla 2025-09-22 a la(s) 3 40 25 p m" src="https://github.com/user-attachments/assets/d36fd4bb-8329-4d85-b5ea-523629eeebae" />

- `sizeof(FunctionPointerExample)`: 8 bytes → el objeto ocupa 8 bytes, correspondientes al puntero a función.
- La ejecución de `funcPtr` imprime “Static function called” → prueba que el puntero a función fue asignado y llamado exitosamente.

Esto demuestra que el tamaño del objeto aumenta por el puntero, y que la invocación funciona sin necesidad de instanciar un objeto para la función estática.

**¿Cómo afectan estos mecanismos al rendimiento del programa?**

- **Punteros a funciones**

	- La llamada es indirecta: en lugar de saltar directo a la dirección de la función (como en una llamada normal), el programa primero debe leer la dirección almacenada en el puntero y luego saltar allí.
	- Esta indirection agrega un pequeño costo extra en comparación con una llamada directa.
	- Sin embargo, es más ligero que usar métodos virtuales, porque no requiere buscar en la vtable, solo seguir un puntero.

- **Métodos virtuales (con vtable)**

	- Cada llamada requiere:
		- Leer el vptr almacenado en el objeto.
		- Buscar en la vtable la función correspondiente.
		- Saltar a esa dirección.
	- Este proceso implica dos accesos a memoria antes de ejecutar la función, lo que es un poco más costoso que un puntero a función normal.
	- En la práctica, la diferencia es mínima, pero en contextos de millones de llamadas en bucles críticos puede impactar el rendimiento.

- **Impacto general**

	- Llamadas directas (funciones normales) → más rápidas.
	- Punteros a funciones → un poco más lentas (una indirección extra).
	- Métodos virtuales → las más lentas de las tres (porque dependen de la vtable).

**Conclusión:**

El impacto en rendimiento existe, pero suele ser despreciable en la mayoría de aplicaciones. El costo extra vale la pena porque los punteros y las vtables permiten flexibilidad, polimorfismo y diseño modular.

#### Evidencia 2:

<img width="251" height="59" alt="Captura de pantalla 2025-09-22 a la(s) 4 29 37 p m" src="https://github.com/user-attachments/assets/0ac17919-a74a-49f2-85d3-3295dc464feb" />

**Llamada directa a función estática**

- La dirección de la función se conoce en tiempo de compilación, por lo que no requiere punteros ni búsquedas adicionales.
- Este mecanismo resulta rápido y eficiente, siendo adecuado cuando no se necesita flexibilidad ni polimorfismo.

**Llamada por puntero a función**

- La llamada a través de un puntero introduce una ligera indirección.
- En la prueba realizada, resultó incluso más rápida que la llamada directa, lo cual puede explicarse por optimizaciones aplicadas por el compilador o por el procesador.
- Este enfoque permite seleccionar la función a ejecutar de manera dinámica, sin modificar la clase que contiene el puntero.

**Método virtual**

- Cada llamada a un método virtual requiere acceder al puntero oculto vptr del objeto y consultar la vtable para determinar la dirección de la función correcta.
- Esta operación añade un pequeño overhead, convirtiendo al método virtual en la opción más lenta de las tres, aunque la diferencia es mínima.
- Este mecanismo permite implementar polimorfismo dinámico, es decir, que la función que se ejecute dependa del tipo real del objeto en tiempo de ejecución.

**Conclusión**

- La diferencia de rendimiento entre llamadas directas, punteros a función y métodos virtuales existe, pero resulta despreciable en la mayoría de aplicaciones prácticas.
- Los punteros a funciones y las vtables aportan flexibilidad y polimorfismo, justificando el pequeño costo adicional en tiempo de ejecución.
- La prueba evidencia cómo C++ implementa cada mecanismo de llamada y cómo cada uno impacta el rendimiento cuando se ejecutan bucles de alta intensidad.

**¿Qué diferencia hay entre punteros a funciones y punteros a métodos miembro en C++? ¿Cómo afectan al tamaño de los objetos y al rendimiento?**

- **Diferencias conceptuales:**

| Concepto                     | Puntero a función                            | Puntero a método miembro                             |
|-------------------------------|---------------------------------------------|-----------------------------------------------------|
| Qué apunta                   | Función **libre** o estática               | Método de una clase (no estático o virtual)       |
| Necesita objeto para llamar  | No                                           | Sí, necesita un objeto o puntero a objeto         |
| Sintaxis de llamada          | `funcPtr()`                                 | `(obj->*methodPtr)()` o `(obj.*methodPtr)()`      |
| Contexto `this`              | No disponible                                | El puntero implica el objeto (`this`) al llamar   |
| Resolución de dirección      | Directa (tiempo de compilación)             | Puede implicar vtable si el método es virtual     |

- Los **punteros a funciones** se usan para funciones globales o estáticas, no necesitan un objeto.  
- Los **punteros a métodos miembro** se usan para llamar métodos de objetos, y si el método es virtual, el puntero usa la **vtable** para resolver la llamada en tiempo de ejecución.

- **Impacto en el tamaño de los objetos**

- Un **puntero a función** dentro de un objeto ocupa **el tamaño de un puntero** (normalmente 8 bytes en sistemas de 64 bits).  
- Un **puntero a método miembro** **no se almacena automáticamente** en cada objeto; normalmente se declara como variable separada.  
	- Si el método es virtual, cada objeto ya tiene un **vptr**, que apunta a la vtable, lo que añade 8 bytes al objeto.  
	- Si solo se usa un puntero a método miembro para llamar una función, no necesariamente aumenta el tamaño del objeto, porque el puntero puede existir como variable independiente fuera del objeto.

**Impacto en el rendimiento:**

| Tipo de puntero                  | Coste de llamada                                   |
|---------------------------------|--------------------------------------------------|
| Puntero a función                | Una indirección extra: leer la dirección y saltar |
| Puntero a método miembro no virtual | Una indirección y paso implícito del `this`      |
| Puntero a método miembro virtual | Acceso al `vptr` + consulta en la vtable + salto  |

- Las llamadas **directas** siguen siendo las más rápidas.  
- Las llamadas a **punteros a métodos miembro** pueden ser más lentas si son virtuales, porque involucran consulta en la vtable.  
- En bucles muy grandes, esto puede notarse; en aplicaciones normales, el coste es despreciable.

**Resumen general:**

- **Punteros a funciones** → simples, ligeros, ocupan espacio y añaden mínima sobrecarga.  
- **Punteros a métodos miembro** → necesitan objeto (`this`) y pueden involucrar vtable si son virtuales.  
- **Tamaño del objeto** → solo aumenta si el objeto contiene un vptr o un puntero a función como miembro.  
- **Rendimiento** → llamada directa > puntero a función > método virtual (generalmente).

#### Evidencia 3:

<img width="451" height="257" alt="Captura de pantalla 2025-09-22 a la(s) 4 41 31 p m" src="https://github.com/user-attachments/assets/dfa6125f-8de1-429b-994f-6a4f92471c90" />

**Tamaños de objetos**

- El puntero a función ocupa 8 bytes, como se esperaba en un sistema de 64 bits.  
- El objeto `MyClass` ocupa 8 bytes, que corresponden al puntero oculto `vptr` que el compilador agrega debido al método virtual.

**Llamada directa a función estática**

- Es la más rápida, ya que el compilador conoce la dirección de la función en tiempo de compilación y no requiere ninguna indirección.

**Llamada por puntero a función**

- Requiere un paso adicional para leer la dirección almacenada en el puntero.  
- En esta prueba, la llamada fue incluso ligeramente más rápida que la directa, lo que puede explicarse por optimizaciones del compilador o del procesador.

**Llamada a método virtual**

- Implica leer el `vptr` del objeto, acceder a la vtable y luego saltar a la función correspondiente.  
- Esto genera un overhead adicional, lo que la convierte en la llamada más lenta de las tres.

**Conclusión:**

- **Llamada directa:** más rápida y eficiente.  
- **Puntero a función:** ligera sobrecarga por indirección, pero útil para flexibilidad.  
- **Método virtual:** mayor sobrecarga debido a la vtable, permite polimorfismo dinámico.  
- En aplicaciones normales, el impacto en rendimiento es despreciable, pero en bucles muy grandes puede notarse.  
- La prueba evidencia cómo C++ implementa cada mecanismo y cómo afectan al tamaño del objeto y al rendimiento.

#### Código usado:

`ofApp.cpp:`
```javascript
#include "ofApp.h"

void ofApp::setup() {
    std::cout << "----- Tamaños de objetos -----\n";

    // Tamaño de puntero a función
    std::cout << "sizeof(void(*)()): " << sizeof(&FunctionPointerExample::staticFunction) << " bytes\n";

    // Tamaño del objeto MyClass
    MyClass obj;
    std::cout << "sizeof(MyClass): " << sizeof(obj) << " bytes\n";

    std::cout << "\n----- Llamada directa a función estática -----\n";
    FunctionPointerExample::staticFunction();

    std::cout << "\n----- Llamada por puntero a función -----\n";
    FunctionPointerExample ex;
    ex.assignFunction();
    ex.funcPtr();  // llamada a través del puntero

    std::cout << "\n----- Llamada a puntero a método miembro no virtual -----\n";
    void (MyClass::*memPtr)() = &MyClass::memberFunction;
    (obj.*memPtr)();  // llamada usando el objeto

    std::cout << "\n----- Llamada a puntero a método miembro virtual -----\n";
    void (MyClass::*virtPtr)() = &MyClass::virtualFunction;
    (obj.*virtPtr)(); // llamada usando el objeto

    // ----------------------------
    // Prueba de tiempo simple
    // ----------------------------
    constexpr int iterations = 100000000; // 100 millones
    std::clock_t start, end;

    // Llamada directa
    start = std::clock();
    for(int i = 0; i < iterations; i++) {
        FunctionPointerExample::staticFunction();
    }
    end = std::clock();
    std::cout << "\nTiempo llamada directa: " << double(end - start)/CLOCKS_PER_SEC << " s\n";

    // Llamada por puntero a función
    start = std::clock();
    for(int i = 0; i < iterations; i++) {
        ex.funcPtr();
    }
    end = std::clock();
    std::cout << "Tiempo puntero a función: " << double(end - start)/CLOCKS_PER_SEC << " s\n";

    // Llamada a método virtual
    start = std::clock();
    for(int i = 0; i < iterations; i++) {
        (obj.*virtPtr)();
    }
    end = std::clock();
    std::cout << "Tiempo puntero a método virtual: " << double(end - start)/CLOCKS_PER_SEC << " s\n";
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
#include <ctime>
#include <iostream>

// Clase para puntero a función
class FunctionPointerExample {
public:
    void (*funcPtr)();  // puntero a función

    static void staticFunction() {
        // Función estática para pruebas
    }

    void assignFunction() {
        funcPtr = staticFunction;
    }
};

// Clase con métodos para puntero a método miembro
class MyClass {
public:
    void memberFunction() {
        // Método no virtual
    }

    virtual void virtualFunction() {
        // Método virtual
    }
};

class ofApp : public ofBaseApp {
public:
    void setup();
    void update();
    void draw();

    void keyPressed(int key);
    void keyReleased(int key);
    void mouseMoved(int x, int y);
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

**¿Dónde residen los datos y métodos de una clase en la memoria?**

En C++, la ubicación de los datos y métodos de una clase en memoria depende de si son atributos, métodos estáticos o métodos virtuales.

- **Atributos**

	- Cada objeto (instancia) de la clase tiene su propio bloque de memoria para almacenar los atributos no estáticos.
	- Este bloque se asigna en:
		- `Stack`: si la instancia se crea como variable local.
		- `Heap:` si se crea dinámicamente con new.
	- Los atributos se organizan según el orden de declaración, pero el compilador puede añadir padding para alineación.

- **Métodos no estáticos:**

	- Los métodos normales (no estáticos) no se almacenan dentro del objeto (es decir que no ocupan espacio).
	- Están en la sección de código (`text segment`) del ejecutable, compartidos por todas las instancias.
	- Cada objeto llama a la misma dirección de función en memoria.

- **Métodos estáticos**

	- Los métodos estáticos tampoco forman parte de los objetos.
	- Están en la sección de código, igual que las funciones globales.
	- Se llaman usando `Clase::metodo()`, no requieren objeto.

- **Métodos virtuales y vtable**

	- Cada clase con métodos virtuales tiene una tabla de punteros a funciones, llamada `vtable`, ubicada generalmente en la sección de datos de solo lectura (rodata) o en la sección de código.
	- Cada objeto de la clase incluye un puntero oculto (`vptr`), que apunta a su vtable correspondiente.
	- La llamada a un método virtual sigue este flujo:
		- Se lee el `vptr` del objeto.
		- Se accede a la vtable de la clase real del objeto.
		- Se obtiene la dirección del método y se ejecuta.

#### Evidencia 4:

<img width="356" height="400" alt="Captura de pantalla 2025-09-22 a la(s) 4 56 18 p m" src="https://github.com/user-attachments/assets/ed0271d8-a30e-45e1-836d-6418dc032bbd" />

- **Tamaños de objetos**
	- `FunctionPointerExample` ocupa 8 bytes (por el puntero a función).  
	- `MyClass` ocupa 16 bytes debido a los atributos y alineación.  
	- `Base` y `Derived` ocupan 8 bytes cada uno, que corresponde al puntero oculto `vptr`.

- **Direcciones de atributos**
	- Los atributos `x` y `y` de `MyClass` residen dentro del bloque de memoria del objeto, confirmando que los datos no estáticos se almacenan en la instancia.

- **Funciones estáticas**
	- La dirección de `staticFunction` confirma que las funciones estáticas residen en la sección de código y son compartidas entre instancias.

- **vptr y vtable**
	- Los objetos `Base` y `Derived` tienen punteros `vptr` apuntando a direcciones distintas de vtable, lo que permite polimorfismo dinámico.

- **Prueba de ejecución**
	- La llamada directa a función estática fue rápida (0.095 s).  
	- La llamada a través de puntero a función fue un poco más rápida (0.073 s), debido a optimizaciones del compilador.  
	- La llamada a método virtual fue la más lenta (0.103 s), debido a la indirección mediante vtable.

**Conclusión:**

- Las llamadas directas son las más eficientes.  
- Los punteros a función agregan mínima sobrecarga y permiten flexibilidad.  
- Los métodos virtuales permiten polimorfismo dinámico pero introducen un pequeño costo adicional en tiempo de ejecución.  
- El tamaño del objeto aumenta por el puntero oculto `vptr` en clases con métodos virtuales, mientras que los atributos se almacenan directamente en el bloque de memoria del objeto.

#### Código usado:

`ofApp.cpp`
```javascript
#include "ofApp.h"
#include <ctime>

void ofApp::setup() {
    std::cout << "===== Tamaños de objetos =====\n";
    MyClass obj;
    Base b;
    Derived d;
    FunctionPointerExample ex;

    std::cout << "sizeof(FunctionPointerExample): " << sizeof(ex) << " bytes\n";
    std::cout << "sizeof(MyClass): " << sizeof(obj) << " bytes\n";
    std::cout << "sizeof(Base): " << sizeof(b) << " bytes\n";
    std::cout << "sizeof(Derived): " << sizeof(d) << " bytes\n";

    std::cout << "\n===== Direcciones de atributos =====\n";
    std::cout << "&obj: " << &obj << "\n";
    std::cout << "&obj.x: " << &obj.x << "\n";
    std::cout << "&obj.y: " << &obj.y << "\n";

    std::cout << "\n===== Funciones estáticas =====\n";
    std::cout << "Función estática: " << (void*)&FunctionPointerExample::staticFunction << "\n";

    std::cout << "\n===== Direcciones de vptr (vtable) =====\n";
    std::cout << "vptr Base: " << *(void**)&b << "\n";
    std::cout << "vptr Derived: " << *(void**)&d << "\n";

    std::cout << "\n===== Prueba de punteros y ejecución =====\n";
    ex.assignFunction();
    ex.funcPtr(); // llamada a función estática

    // puntero a método miembro no virtual
    void (MyClass::*memPtr)() = &MyClass::memberFunction;
    (obj.*memPtr)();

    // puntero a método miembro virtual
    void (MyClass::*virtPtr)() = &MyClass::virtualFunction;
    (obj.*virtPtr)();

    // ----------------------------
    // Prueba de rendimiento simple
    // ----------------------------
    constexpr int iterations = 50000000; // 50 millones
    std::clock_t start, end;

    start = std::clock();
    for(int i = 0; i < iterations; i++) {
        FunctionPointerExample::staticFunction();
    }
    end = std::clock();
    std::cout << "\nTiempo llamada directa: " << double(end - start)/CLOCKS_PER_SEC << " s\n";

    start = std::clock();
    for(int i = 0; i < iterations; i++) {
        ex.funcPtr();
    }
    end = std::clock();
    std::cout << "Tiempo puntero a función: " << double(end - start)/CLOCKS_PER_SEC << " s\n";

    start = std::clock();
    for(int i = 0; i < iterations; i++) {
        (obj.*virtPtr)();
    }
    end = std::clock();
    std::cout << "Tiempo puntero a método virtual: " << double(end - start)/CLOCKS_PER_SEC << " s\n";
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

// ----------------------------
// Clases para pruebas
// ----------------------------
class FunctionPointerExample {
public:
    void (*funcPtr)();  // puntero a función

    static void staticFunction() {
        // función estática
    }

    void assignFunction() {
        funcPtr = staticFunction;
    }
};

class MyClass {
public:
    int x;
    int y;

    void memberFunction() {
        // método no virtual
    }

    virtual void virtualFunction() {
        // método virtual
    }
};

class Base {
public:
    virtual void foo() {}
};

class Derived : public Base {
public:
    void foo() override {}
};

// ----------------------------
// Clase principal OF
// ----------------------------
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
