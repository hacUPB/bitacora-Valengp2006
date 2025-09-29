# Sesión 1: profundización teórica de patrones de diseño - 29/09/2025

### Factory Method

**¿Qué hace?**

- Encapsula la creación de objetos para no depender directamente de clases concretas.
- Se usa cuando tienes varios tipos de objetos relacionados y quieres que el código cliente no sepa qué clase exacta está creando.

**Ejemplo en C++:**

```cpp
// Producto base
class Transporte {
public:
    virtual void entregar() = 0;
    virtual ~Transporte() {}
};

// Productos concretos
class Camion : public Transporte {
public:
    void entregar() override { std::cout << "Entrega por carretera\n"; }
};

class Barco : public Transporte {
public:
    void entregar() override { std::cout << "Entrega por mar\n"; }
};

// Fábrica
class TransporteFactory {
public:
    static std::unique_ptr<Transporte> crearTransporte(const std::string& tipo) {
        if (tipo == "camion") return std::make_unique<Camion>();
        if (tipo == "barco") return std::make_unique<Barco>();
        return nullptr;
    }
};
```
