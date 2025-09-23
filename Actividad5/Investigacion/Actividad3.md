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



- La clase derivada puede acceder al miembro **`protected`** de la clase base (`baseVar`), confirmando que la protección se extiende a las clases hijas.  
- Se ejecutó el método de la clase base (`Base method`) y el método redefinido en la clase derivada (`Derived method`).  
- La herencia permite **reutilizar atributos y comportamientos**, pero con la posibilidad de **extender o redefinir** en la clase hija.  

**Conclusión:**  

La herencia en C++ se implementa copiando la estructura de la clase base dentro de la clase derivada. Los miembros `protected` son accesibles desde la clase derivada, mientras que los `private` permanecen inaccesibles. Los métodos pueden ser redefinidos, lo que prepara el camino para el polimorfismo.


**Polimorfismo**

#### Evidencia 3:



- Se definió una clase base `Animal` con un método **virtual** `makeSound()`.  
- Al crear punteros de tipo `Animal*` que apuntan a instancias de `Dog` y `Cat`, las llamadas se resolvieron en **tiempo de ejecución** gracias a la **vtable**.  
- El **vptr** de cada objeto apunta a la tabla de métodos virtuales (vtable) correspondiente, que contiene las direcciones de las implementaciones correctas (`Dog::makeSound` o `Cat::makeSound`).  

**Conclusión:**  

El polimorfismo en C++ se implementa mediante el uso de **punteros a vtables**. Cada objeto con métodos virtuales almacena internamente un puntero oculto (`vptr`) que en tiempo de ejecución se usa para invocar el método adecuado. Esto permite que diferentes clases respondan de manera distinta a la misma interfaz.