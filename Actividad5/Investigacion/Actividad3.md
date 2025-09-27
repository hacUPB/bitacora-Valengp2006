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

**Herencia**

#### Evidencia 2:

<img width="285" height="73" alt="Captura de pantalla 2025-09-23 a la(s) 3 24 15 p m" src="https://github.com/user-attachments/assets/ad5af89c-ad39-436b-b669-171a87d160a1" />

- La clase derivada puede acceder al miembro **`protected`** de la clase base (`baseVar`), confirmando que la protección se extiende a las clases hijas.  
- Se ejecutó el método de la clase base (`Base method`) y el método redefinido en la clase derivada (`Derived method`).  
- La herencia permite **reutilizar atributos y comportamientos**, pero con la posibilidad de **extender o redefinir** en la clase hija.  

**Conclusión:**  

La herencia en C++ se implementa copiando la estructura de la clase base dentro de la clase derivada. Los miembros `protected` son accesibles desde la clase derivada, mientras que los `private` permanecen inaccesibles. Los métodos pueden ser redefinidos, lo que prepara el camino para el polimorfismo.

**Polimorfismo**

#### Evidencia 3:

<img width="302" height="53" alt="Captura de pantalla 2025-09-23 a la(s) 3 28 54 p m" src="https://github.com/user-attachments/assets/73ba6ef5-dde3-449b-9d2b-a9ce401343d6" />

- Se definió una clase base `Animal` con un método **virtual** `makeSound()`.  
- Al crear punteros de tipo `Animal*` que apuntan a instancias de `Dog` y `Cat`, las llamadas se resolvieron en **tiempo de ejecución** gracias a la **vtable**.  
- El **vptr** de cada objeto apunta a la tabla de métodos virtuales (vtable) correspondiente, que contiene las direcciones de las implementaciones correctas (`Dog::makeSound` o `Cat::makeSound`).  

**Conclusión:**  

El polimorfismo en C++ se implementa mediante el uso de **punteros a vtables**. Cada objeto con métodos virtuales almacena internamente un puntero oculto (`vptr`) que en tiempo de ejecución se usa para invocar el método adecuado. Esto permite que diferentes clases respondan de manera distinta a la misma interfaz.

#### Código usado:

`ofApp.cpp`
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
    
    std::cout << "\n===== Experimento 2: Herencia =====\n";

    Derived d;
    std::cout << "Base var desde Derived: " << d.baseVar << std::endl;
    d.baseMethod();  // método heredado
    d.derivedMethod();  // método propio
    
    std::cout << "\n===== Experimento 3: Polimorfismo =====\n";

    Animal* a1 = new Dog();
    Animal* a2 = new Cat();

    a1->speak();  // llama Dog::speak
    a2->speak();  // llama Cat::speak

    delete a1;
    delete a2;
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

`ofApp.h`
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

class Base {
public:
    int baseVar;
    Base() : baseVar(100) {}
    void baseMethod() { std::cout << "Base method\n"; }
};

class Derived : public Base {
public:
    int derivedVar;
    Derived() : derivedVar(200) {}
    void derivedMethod() { std::cout << "Derived method\n"; }
};

class Animal {
public:
    virtual void speak() { std::cout << "Animal speak\n"; }
};

class Dog : public Animal {
public:
    void speak() override { std::cout << "Dog barks\n"; }
};

class Cat : public Animal {
public:
    void speak() override { std::cout << "Cat meows\n"; }
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

## Hagamos un poco de hackers y rompamos el encapsulamiento

**Etapa 1: Acceso legal con printMembers()**

<img width="328" height="75" alt="Captura de pantalla 2025-09-23 a la(s) 7 23 36 p m" src="https://github.com/user-attachments/assets/3f78351a-2fcb-4feb-92b1-242a2707c5fc" />

**¿Cómo se accede a los miembros privados respetando el encapsulamiento?**

- Los miembros privados (`secret1`, `secret2`, `secret3`) no pueden ser accedidos directamente.
- Para exponer su valor se define un método público (`printMembers`) que imprime su contenido.
- Esto respeta el principio de **encapsulamiento**, ya que los datos siguen protegidos de accesos externos no autorizados.

**Etapa 2: Intento de acceso directo**

<img width="400" height="39" alt="Captura de pantalla 2025-09-23 a la(s) 7 24 41 p m" src="https://github.com/user-attachments/assets/f5304f86-3da0-4844-acd9-7db2cc4b4f03" />

**¿Qué ocurre si intento acceder directamente a los miembros privados de la clase?**

- El compilador impide el acceso a los miembros privados (`secret1`, `secret2`, `secret3`).
- Al intentar compilar con `std::cout << obj.secret1;` aparece un **error de compilación** porque `secret1` es inaccesible fuera de la clase.


**Etapa 3: Acceso ilegal con reinterpret_cast**

<img width="337" height="70" alt="Captura de pantalla 2025-09-23 a la(s) 7 25 26 p m" src="https://github.com/user-attachments/assets/9a288b9a-55de-4eea-856b-95325282c20b" />

**¿Qué pasa si leo los miembros privados directamente desde la memoria del objeto usando `reinterpret_cast` y aritmética de punteros?**

- Se pueden leer los valores privados siempre que conozcas (o asumas) el layout en memoria del objeto. 
- Al reinterpretar &obj como un bloque de bytes y convertir offsets a punteros del tipo adecuado, el programa puede acceder y mostrar los valores privados.

#### Código usado:

`ofApp.cpp`
```javascript
#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup() {
    // ===== Etapa 1 =====
    std::cout << "Etapa 1: Acceso legal a miembros privados usando printMembers()" << std::endl;
    obj.printMembers();

    // ===== Etapa 2 =====
    std::cout << "\nEtapa 2: Intento de acceso directo (fallará si lo descomentas)" << std::endl;
    std::cout << "// std::cout << obj.secret1 << std::endl;  <-- No compila porque es privado" << std::endl;

    // ===== Etapa 3 =====
    std::cout << "\nEtapa 3: Acceso ilegal a miembros privados con reinterpret_cast" << std::endl;
    int* ptrInt = reinterpret_cast<int*>(&obj);
    float* ptrFloat = reinterpret_cast<float*>(ptrInt + 1);
    char* ptrChar = reinterpret_cast<char*>(ptrFloat + 1);

    std::cout << "secret1 (hackeado): " << *ptrInt << std::endl;
    std::cout << "secret2 (hackeado): " << *ptrFloat << std::endl;
    std::cout << "secret3 (hackeado): " << *ptrChar << std::endl;
}

//--------------------------------------------------------------
void ofApp::update() {}

//--------------------------------------------------------------
void ofApp::draw() {
    ofBackground(0);
    ofSetColor(255);
    ofDrawBitmapString("Revisa la consola para ver las 3 etapas", 20, 20);
}
```

`ofApp.h`
```javascript
#pragma once
#include "ofMain.h"
#include <iostream>

class MyClass {
private:
    int secret1;
    float secret2;
    char secret3;

public:
    MyClass(int s1, float s2, char s3) : secret1(s1), secret2(s2), secret3(s3) {}

    void printMembers() const {
        std::cout << "secret1: " << secret1 << std::endl;
        std::cout << "secret2: " << secret2 << std::endl;
        std::cout << "secret3: " << secret3 << std::endl;
    }
};

class ofApp : public ofBaseApp {
public:
    void setup();
    void update();
    void draw();

    MyClass obj {42, 3.14f, 'A'};
};
```
**Reflexión Guiada**

- **¿Qué es el encapsulamiento y cuál es su propósito?**

El encapsulamiento protege los datos internos de una clase, limitando su acceso y evitando modificaciones indebidas. Garantiza modularidad, seguridad y control sobre cómo se usan los atributos.

- **¿Por qué es importante proteger los datos?**

Para prevenir corrupción de estado, mantener invariantes y asegurar que las clases se utilicen de forma consistente.

- **¿Qué significa `reinterpret_cast` y cómo afecta la seguridad?**

`reinterpret_cast` permite tratar un bloque de memoria como si fuera de otro tipo. Esto ignora las restricciones del compilador, comprometiendo la seguridad y pudiendo causar errores en tiempo de ejecución.

- **¿Por qué se pudo acceder a los miembros privados?**

Porque los modificadores de acceso (`private`/`protected`/`public`) son una barrera lógica en el compilador, no física en memoria. En tiempo de ejecución, los datos están linealmente dispuestos en memoria y se pueden manipular con punteros.

- **Consecuencias en un programa real:**

    - Corrupción de memoria
    - Fallos de seguridad
    - Datos inconsistentes
    - Vulnerabilidades explotables.

- **Implicaciones sobre C++ y encapsulamiento:**

    - El encapsulamiento en C++ depende de la disciplina del programador. 
    - Este experimento muestra que, aunque el compilador impide accesos indebidos, la memoria sigue siendo accesible con técnicas de bajo nivel.
 
  ## Herencia y la Relación en Memoria

 **¿Cómo los objetos derivados contienen los datos de las clases base?**

Cuando creamos un objeto de una clase derivada, primero se reservan los atributos de la clase base, y luego se colocan los atributos de la derivada en orden.

- `obj` y `obj.baseVar` comparten la misma dirección → significa que el objeto comienza con el bloque de memoria de Base.
- `obj.derivedVar` se almacena inmediatamente después de baseVar.
- `obj.moreDerivedVar` se coloca después de derivedVar.

Esto demuestra que la herencia en C++ se refleja linealmente en memoria: primero la base, luego la derivada, y así sucesivamente.

#### Evidencia 1:

<img width="294" height="56" alt="Captura de pantalla 2025-09-25 a la(s) 5 00 53 p m" src="https://github.com/user-attachments/assets/0ef16698-b4c7-477f-9171-700119ea4f00" />

- `&d` y `&d.baseVar` son iguales → el objeto comienza con los atributos de la clase base.
- `&d.derivedVar` aparece desplazado +4 bytes → porque baseVar ocupa 4 bytes (int).

**¿Qué sucede si agregamos más niveles de herencia?**

Cada nuevo nivel de herencia simplemente añade sus atributos después de los anteriores en memoria. Así, la memoria de `MoreDerived` comienza con `baseVar`, sigue con `derivedVar`, y finaliza con `moreDerivedVar`. Si añadiéramos otra clase derivada, sus atributos también se sumarían al final.

#### Evidencia 2:

<img width="358" height="69" alt="Captura de pantalla 2025-09-25 a la(s) 5 06 43 p m" src="https://github.com/user-attachments/assets/a136566e-40ff-4d8a-af59-4f0d26c53049" />

#### Código usados:

`ofApp.cpp:`
```javascript
#include "ofApp.h"

void ofApp::setup(){
    MoreDerived obj;
    obj.baseVar = 1;
    obj.derivedVar = 2;
    obj.moreDerivedVar = 3;
    
    std::cout << "Dirección de obj:                  " << &obj << std::endl;
    std::cout << "Dirección de obj.baseVar:          " << &(obj.baseVar) << std::endl;
    std::cout << "Dirección de obj.derivedVar:       " << &(obj.derivedVar) << std::endl;
    std::cout << "Dirección de obj.moreDerivedVar:   " << &(obj.moreDerivedVar) << std::endl;
}
void ofApp::draw(){
}

```

`ofApp.h:`
```javascript
#pragma once
#include "ofMain.h"

class Base {
public:
    int baseVar;
};

class Derived : public Base {
public:
    int derivedVar;
};

class MoreDerived : public Derived {
public:
    int moreDerivedVar;
};

class ofApp : public ofBaseApp{
public:
    void setup();
    void draw();
};
```

## Polimorfismo y Vtables en detalle

**¿Cómo funciona el polimorfismo en C++ a nivel interno?**

El polimorfismo en C++ permite que un puntero o referencia de la clase base invoque métodos definidos en clases derivadas. Esto se logra gracias a un mecanismo interno llamado vtable (virtual table)

- Cada clase con métodos virtuales tiene asociada una tabla de punteros a funciones virtuales.
- Cada objeto de esa clase contiene un puntero oculto llamado vptr que apunta a la vtable correspondiente.
- Cuando llamas a un método virtual (ej. animal->makeSound()), el compilador genera código que consulta el vptr, busca la función en la vtable, y ejecuta la versión correcta según el tipo real del objeto.

**¿Cómo utiliza el programa las vtables para el polimorfismo?**

El programa usa tablas virtuales (`vtables`) para despachar dinámicamente los métodos virtuales.

- Cada objeto polimórfico (como `Dog` o `Cat`) tiene internamente un puntero oculto llamado `vptr` que apunta a la `vtable` de su clase.
- La vtable es una tabla en memoria que guarda direcciones de funciones virtuales (por ejemplo, la dirección de `Dog::makeSound` o `Cat::makeSound`).
- Cuando escribimos `animal->makeSound()`, el compilador genera código que:
	1.	Lee el vptr desde el objeto.
	2.	Busca en la vtable la dirección del método en la posición correspondiente.
	3.	Llama a la función obtenida.
De esta manera, aunque la variable sea de tipo `Animal*`, la llamada termina ejecutando la versión correcta (`Dog::makeSound` o `Cat::makeSound`) según el tipo dinámico del objeto.

**¿Cuál es el impacto en el rendimiento?**

El polimorfismo dinámico introduce una sobrecarga ligera porque cada llamada virtual requiere:

1.	Acceder al `vptr` del objeto.
2.	Acceder a la `vtable` para obtener la dirección del método.
3.	Hacer una llamada indirecta a esa función.

Esto añade unas pocas instrucciones adicionales frente a una llamada normal, y además impide que el compilador haga optimizaciones como *inlining*.

En la práctica:

- El costo por llamada es muy bajo (nanosegundos), casi irrelevante en la mayoría de programas.
- Puede ser significativo si la llamada virtual se ejecuta en un hot-path crítico (por ejemplo, millones de veces en un bucle de renderizado o física).

**Reflexión individual**

- **Encapsulamiento:**

    - Implementación interna:
	    - Los modificadores de acceso (private, protected, public) no cambian la representación del objeto en memoria.
	    - El compilador implementa encapsulamiento solo a nivel de compilación, verificando si un miembro puede ser accedido desde cierto punto del código.
	    - En memoria, todos los atributos están ahí, uno tras otro, sin distinción de acceso.
    - Ejemplo conceptual en memoria:

```cpp
class A {
private:
    int x;   // accesible solo dentro de A
public:
    int y;   // accesible desde fuera
};
```

    En memoria: [ x ][ y ] → no hay “barrera física” que impida leer x. El control es solo semántico y de compilador.


- **Herencia**:

    - Implementación interna:
	    - La clase hija incluye los miembros de la clase base como si fueran los primeros campos de su propio objeto.
	    - **Si hay herencia simple:** la disposición en memoria es lineal.
	    - **En herencia múltiple:** el compilador guarda varias subestructuras (una por cada base) y gestiona punteros internos para resolver ambigüedades.
    - Ejemplo simplificado:
```cpp
class A { int x; };
class B : public A { int y; };
```

- En memoria, un objeto de B: [ x ][ y ].

    - Con herencia múltiple:
```cpp
class C { int z; };
class D : public A, public C { int w; };
```

- En memoria, un D: [ x ][ z ][ w ].

Si alguna base tiene funciones virtuales, se añade su propio puntero a `vtable` (`vptr`).

- **Polimorfismo**

    - **Implementación interna:**
	    - Cuando una clase declara métodos virtuales, el compilador genera una `vtable` (tabla de punteros a funciones).
	    - Cada objeto que pertenezca a esa clase contiene un `vptr`, un puntero oculto que apunta a la `vtable` correspondiente.
	    - En tiempo de ejecución, cuando invocas un método virtual, se hace:
	        - Cargar el `vptr` del objeto.
	        - Buscar la dirección de la función en la `vtable`.
	        - Saltar a esa función.

Esto permite que la llamada dependa del tipo real del objeto (ligadura dinámica).

**Eficiencia vs Complejidad**

- **Ventajas:**
	- **Encapsulamiento:**
	    - Facilita modularidad y mantenimiento.
	    - El costo en tiempo de ejecución es nulo (solo revisiones en compilación).
	- **Herencia:**
	    - Permite reutilización de código sin duplicación.
	    - Herencia simple es muy eficiente (básicamente copiar la disposición de memoria).
	- **Polimorfismo:**
	    - Gran flexibilidad: permite diseñar sistemas extensibles sin cambiar código existente.
	    - Coste de memoria moderado (un puntero `vptr` por objeto).

- **Desventajas:**
	- **Encapsulamiento:**
	    - Puede dar falsa sensación de seguridad: internamente todo está accesible si se usa aritmética de punteros.
	    - No protege contra accesos indebidos en binarios o depuración.
	- **Herencia:**
	    - En herencia múltiple, la disposición en memoria y las conversiones de punteros son más costosas y complejas.
	    - Puede introducir problemas de ambigüedad y aumentar la fragilidad del diseño.
	- **Polimorfismo:**
	    - Llamar a un método virtual es más lento que una llamada normal (1–2 accesos indirectos extras).
	    - Las `vtables` aumentan el tamaño del binario.
	    - Dificultan ciertas optimizaciones (ej: *inlining*).

**Conclusiones:**

- El **encapsulamiento** se implementa solo con reglas de compilador → sin costo en ejecución.
- La **herencia** es básicamente composición en memoria, con punteros extras en herencia múltiple.
- El **polimorfismo** usa `vtables` y `vptrs`, lo que introduce una leve penalización en velocidad y memoria pero da gran flexibilidad.

**¿Qué es inlining?**

El inlining (o “expansión en línea”) es una optimización que hace el compilador en C++ para evitar la sobrecarga de las llamadas a funciones.

- **¿Qué pasa normalmente al llamar una función?**

	1.	Se hace un salto a la dirección de esa función.
	2.	Se guarda la dirección de retorno en la pila.
	3.	Se pasan los argumentos y se reserva espacio para variables locales.
	4.	Al terminar, se regresa al punto de la llamada.
    - Todo eso tiene un costo en tiempo.


- **¿Qué hace el inlining?**

Cuando una función es marcada como inline (o el compilador decide optimizarla), el compilador reemplaza la llamada a la función por el propio cuerpo de la función.

Ejemplo:
```cpp
inline int cuadrado(int x) {
    return x * x;
}

int main() {
    int a = cuadrado(5);
}
```
Después de inlining, el compilador genera algo parecido a:
```cpp
int main() {
    int a = 5 * 5;  // sin llamada a función
}
```

- **Ventajas:**
	- Más rápido: elimina el overhead de la llamada a función.
	- Permite más optimizaciones (ej: propagación de constantes).

- **Desventajas:**
	- El binario crece: si la función es usada muchas veces, el código se copia en cada llamada → code bloat.
	- Puede afectar la caché de instrucciones y, en algunos casos, empeorar el rendimiento.

- **¿Cómo se relaciona con el polimorfismo?**

    - Las funciones virtuales en C++ no pueden ser *inlined* de forma normal, porque su dirección real se resuelve en tiempo de ejecución usando la `vtable`.
	- Una función virtual puede ser *inlined* solo si el compilador sabe exactamente qué tipo es el objeto en tiempo de compilación (ej: si no hay polimorfismo real en ese punto).

#### Evidencia:



- La salida demuestra que el programa efectivamente llamó a las versiones correctas (`Dog::makeSound` y `Cat::makeSound`) a pesar de usar punteros `Animal*`. Eso confirma que la `vtable` se usó para resolver las llamadas dinámicamente → es la evidencia directa de polimorfismo en acción. 

- Las direcciones de memoria (`Dirección de d:`, `Dirección de c:`) no muestran la `vtable `directamente, pero sirven para documentar que cada objeto existe en memoria y tiene su propio `vptr` oculto que apunta a la `vtable` de su clase. Esto lo puedes mencionar como soporte adicional de la explicación teórica.

