# Sesión 1: profundización teórica de patrones de diseño - 29/09/2025

## Factory Method

- **Idea:** encapsular la creación de objetos concre­tos para que el cliente dependa sólo de una interfaz/abstracción.
- **Cuándo usar:** cuando tienes familias de objetos o varias implementaciones intercambiables y quieres centralizar la creación.

**Ejemplo genérico (C++):**
```cpp
#include <iostream>
#include <memory>
#include <string>

// Producto base
struct Transporte {
    virtual void entregar() = 0;
    virtual ~Transporte() = default;
};

// Productos concretos
struct Camion : Transporte {
    void entregar() override { std::cout << "Entrega por carretera\n"; }
};
struct Barco : Transporte {
    void entregar() override { std::cout << "Entrega por mar\n"; }
};

// Fábrica
struct TransporteFactory {
    static std::unique_ptr<Transporte> crear(const std::string& tipo) {
        if (tipo == "camion") return std::make_unique<Camion>();
        if (tipo == "barco")  return std::make_unique<Barco>();
        return nullptr;
    }
};

int main() {
    auto t1 = TransporteFactory::crear("camion");
    auto t2 = TransporteFactory::crear("barco");
    if (t1) t1->entregar();
    if (t2) t2->entregar();
}
```

**Ejercicio práctico:**

- Implementar Tren como nuevo tipo sin cambiar el cliente.
- Prueba: crear 5 objetos de cada tipo y ejecutar entregar().

**Preguntas para ChatGPT**

- ¿Cómo cambio la fábrica para leer el tipo desde un archivo de configuración?
- ¿Qué diferencias hay entre Factory Method y Abstract Factory?

**1. ¿Cómo cambiar la fábrica para leer el tipo desde un archivo de configuración?**

La idea es que en lugar de escribir en el código "camion" o "barco", el programa lea ese dato de un archivo (ej: config.txt).

Ejemplo sencillo en C++

config.txt
`camion`

**Código**
```cpp
#include <iostream>
#include <fstream>
#include <memory>
#include <string>

// Producto base
struct Transporte {
    virtual void entregar() = 0;
    virtual ~Transporte() = default;
};

struct Camion : Transporte {
    void entregar() override { std::cout << "Entrega por carretera\n"; }
};
struct Barco : Transporte {
    void entregar() override { std::cout << "Entrega por mar\n"; }
};

// Fábrica
struct TransporteFactory {
    static std::unique_ptr<Transporte> crear(const std::string& tipo) {
        if (tipo == "camion") return std::make_unique<Camion>();
        if (tipo == "barco")  return std::make_unique<Barco>();
        return nullptr;
    }
};

int main() {
    std::ifstream file("config.txt");
    std::string tipo;
    if (file >> tipo) {
        auto transporte = TransporteFactory::crear(tipo);
        if (transporte) transporte->entregar();
        else std::cout << "Tipo desconocido en config\n";
    }
}
```

**Qué se logra con esto:**

El cliente no cambia aunque varíe el tipo de transporte; basta con editar el archivo de configuración. Esto aumenta la flexibilidad.

**2. Diferencias entre Factory Method y Abstract Factory**

| Aspecto              | Factory Method                                                                 | Abstract Factory                                                                 |
|-----------------------|--------------------------------------------------------------------------------|---------------------------------------------------------------------------------|
| **Propósito**         | Define un método para crear un objeto, dejando que las subclases decidan qué clase concreta instanciar. | Provee una interfaz para crear **familias de objetos relacionados** sin especificar sus clases concretas. |
| **Nivel de abstracción** | Crea un único tipo de objeto.                                                  | Crea múltiples tipos de objetos que deben usarse juntos (compatibles entre sí). |
| **Estructura típica** | Una jerarquía donde cada subclase implementa su propio método de creación.      | Una interfaz con varios métodos de creación (p. ej., `crearBotón()`, `crearVentana()`), y cada fábrica concreta implementa todos ellos. |
| **Ejemplo genérico**  | `TransporteFactory` que decide si devuelve un `Camion` o un `Barco`.            | `GUIFactory` que puede crear **conjunto** de elementos: `Botón` + `Ventana` para Windows o para macOS. |
| **Flexibilidad**      | Buen equilibrio cuando solo cambias un producto a la vez.                       | Útil cuando necesitas garantizar que varios productos se creen en conjunto de forma coherente. |

**En pocas palabras:**

- Factory Method → un solo producto, pero flexible en la subclase.
- Abstract Factory → varias fábricas concretas, cada una genera una familia completa de productos relacionados.

## Observer

- Idea: permitir que un sujeto notifique a múltiples observadores sin acoplarlos.
- Cuándo usar: UI que debe actualizarse cuando cambia un modelo, eventos del sistema, etc.

**Ejemplo genérico (C++)**

```cpp
#include <iostream>
#include <vector>
#include <functional>

struct Sujeto {
    using Observador = std::function<void(int)>;
    std::vector<Observador> listeners;
    void subscribe(Observador o){ listeners.push_back(o); }
    void setValor(int v){
        for(auto &l: listeners) l(v);
    }
};

int main(){
    Sujeto s;
    s.subscribe([](int v){ std::cout << "Observador 1: " << v << "\n"; });
    s.subscribe([](int v){ std::cout << "Observador 2: " << v << "\n"; });
    s.setValor(42);
}
```

**Ejercicio práctico**

- Añade la capacidad de darse de baja (unsubscribe).
- Implementa un observador que registre en un vector los valores recibidos (para aserciones en pruebas).

**Preguntas para ChatGPT**

- ¿Cómo evitar fugas si un observador se destruye sin desuscribirse?
- ¿Cuál es la diferencia entre Observer y Pub/Sub?

**1. ¿Cómo evitar fugas si un observador se destruye sin desuscribirse?**

En el patrón Observer, el sujeto mantiene una lista de observadores registrados. El problema aparece si un observador se destruye pero nunca se dio de baja: el sujeto podría intentar notificarlo y acceder a memoria inválida → fugas o crash.

**Estrategias para evitarlo:**

- Uso de punteros débiles (weak references):
	- En lenguajes con smart pointers (como C++ con std::weak_ptr o en Java con WeakReference), el sujeto guarda referencias débiles.
	- Así, si el observador muere, la referencia se invalida sola y no provoca acceso indebido.
    - `std::vector<std::weak_ptr<Observer>> observers;`

- Patrón RAII / Destructor que se auto-desuscribe:
	- Hacer que el destructor del observador se encargue de llamar a unsubscribe() automáticamente.
	- Esto asegura que nunca quede en la lista del sujeto.
    ```cpp
    Observer::~Observer() {
    sujeto.unsubscribe(this);
    }
    ```

- Chequeos de validez antes de notificar:
	- Antes de enviar un evento, verificar si el puntero sigue siendo válido.
	- Esto es menos elegante, pero agrega seguridad extra.

**2. ¿Cuál es la diferencia entre Observer y Pub/Sub?**

Aunque parecen lo mismo, hay diferencias clave:

## Estrategias para evitar fugas en Observer

| Estrategia | Descripción | Ejemplo |
|------------|-------------|---------|
| **Punteros débiles (`weak_ptr`)** | El sujeto guarda referencias débiles en lugar de fuertes, de modo que si el observador muere la referencia se invalida sola. | `std::vector<std::weak_ptr<Observer>> observers;` |
| **Auto-desuscripción en destructor** | El observador se elimina de la lista del sujeto cuando se destruye, evitando quedar "colgado". | ```cpp<br>Observer::~Observer() { sujeto.unsubscribe(this); }<br>``` |
| **Chequeo de validez antes de notificar** | El sujeto valida que la referencia al observador siga siendo válida antes de enviar el evento. | `if (observer) observer->update();` |

Con estas técnicas se garantiza que el patrón `Observer` no cause accesos inválidos ni fugas de memoria.

En resumen:
- Observer = comunicación directa, más simple, dentro del mismo contexto.
- Pub/Sub = comunicación desacoplada y distribuida, ideal para sistemas grandes.

## State

- Idea: encapsular comportamientos dependientes del estado en objetos de estado, y cambiar el estado del contexto en tiempo de ejecución.
- Cuándo usar: cuando un objeto tiene muchos comportamientos disjuntos según su estado (evita switch enormes).

**Ejemplo genérico (C++):**
```cpp
#include <iostream>
#include <memory>

struct Contexto;
struct Estado {
    virtual ~Estado() = default;
    virtual void handle(Contexto& c) = 0;
};

struct Contexto {
    std::unique_ptr<Estado> state;
    Contexto(std::unique_ptr<Estado> s) : state(std::move(s)) {}
    void request() { state->handle(*this); }
    void setState(std::unique_ptr<Estado> s){ state = std::move(s); }
};

struct Encendido : Estado {
    void handle(Contexto& c) override;
};
struct Apagado : Estado {
    void handle(Contexto& c) override;
};

void Encendido::handle(Contexto& c){
    std::cout << "De ENCENDIDO a APAGADO\n";
    c.setState(std::make_unique<Apagado>());
}
void Apagado::handle(Contexto& c){
    std::cout << "De APAGADO a ENCENDIDO\n";
    c.setState(std::make_unique<Encendido>());
}

int main(){
    Contexto ctx(std::make_unique<Apagado>());
    ctx.request();
    ctx.request();
}
```

**Ejercicio práctico**

- Implementa un estado adicional Mantenimiento que solo permite pasar a Apagado.
- Añade métodos enter() y exit() a la interfaz Estado para acciones al entrar/salir del estado.

**Preguntas para ChatGPT:**

- ¿Cuándo usar State frente a Strategy?
- ¿Puedo combinar State con Observer para notificar cambios de estado?

**1. ¿Cuándo usar State frente a Strategy?**

| Aspecto            | **State**                                                                 | **Strategy**                                                                 |
|---------------------|---------------------------------------------------------------------------|------------------------------------------------------------------------------|
| **Propósito**       | Permitir que un objeto cambie su comportamiento según su estado interno. | Permitir cambiar el algoritmo usado de forma intercambiable.                 |
| **Cambio dinámico** | El propio objeto decide cuándo cambiar de estado.                        | El cliente o contexto decide qué estrategia aplicar.                         |
| **Ejemplo típico**  | Una máquina expendedora que pasa de `SinMoneda → ConMoneda → ProductoEntregado`. | Un sistema de ordenamiento que puede usar `QuickSort`, `MergeSort`, `BubbleSort`. |
| **Metáfora**        | "El objeto **es** su estado actual."                                     | "El objeto **usa** una estrategia."                                          |

- Usa `State `cuando tu clase tenga múltiples comportamientos dependientes de su estado interno.
- Usa `Strategy` cuando quieras elegir entre varios algoritmos o políticas de manera intercambiable.


**2. ¿Se puede combinar State con Observer?**

- Sí, de hecho es una práctica muy útil:
	- El patrón State controla cómo se comporta un objeto en función de su estado interno.
	- El patrón Observer notifica a otros objetos cuando ocurre un cambio.

- Juntos funcionan así:
	- El objeto con estados (Contexto) cambia de estado.
	- Cuando el estado cambia, se notifica a los observadores.
	- Esto permite que otros componentes reaccionen al cambio, sin acoplarse directamente a la lógica interna.

**Ejemplo conceptual:**
```cpp
class State {
public:
    virtual void handle() = 0;
    virtual std::string getName() = 0;
    virtual ~State() = default;
};

class Context : public Subject { // Subject del Observer
    State* current;
public:
    void setState(State* s) {
        current = s;
        notify(); // <- aquí se notifica a los observadores
    }
    void request() { current->handle(); }
    std::string getStateName() { return current->getName(); }
};
```

Así, cuando el estado interno cambia, los observadores (interfaz gráfica, logger, etc.) reciben un aviso y pueden actualizarse en tiempo real.