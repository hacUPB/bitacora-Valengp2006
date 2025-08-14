### Actividad 6

El código anterior tiene un problema. ¿Puedes identificar cuál es? ¿Cómo lo solucionarías? Recuerda que deberías poder seleccionar una esfera y moverla con el mouse.

**Respuesta:**

El problema está en que el código solo permite seleccionar la esfera, pero nunca se “libera” la selección cuando sueltas el botón del mouse, lo que provoca que, una vez que `selectedSphere` apunta a una esfera, esta seguirá moviéndose con el cursor indefinidamente, aunque ya no estés presionando el mouse.

**Cómo solucionarlo:**

Para solucionar este error debemos agregar un nuevo evento en el `ofApp.cpp` que permita detectar cuando se suelta el botón del mouse (mouseReleased) y ahí poner:

```cpp
void ofApp::mouseReleased(int x, int y, int button){
    if(button == OF_MOUSE_BUTTON_LEFT){
        selectedSphere = nullptr;
    }
}
```

También hay que declarar este nuevo evento mouseReleased en el `ofApp.h`:

```cpp
void mouseReleased(int x, int y, int button);
```

Así ocurre lo siguiente:

- Cuando presionas el botón izquierdo (mousePressed), `selectedSphere` empieza a apuntar a la esfera que clicaste.
- En cada `update()`, si `selectedSphere` no es `nullptr`, la esfera sigue al mouse.
- Cuando sueltas el botón (mouseReleased), el puntero vuelve a `nullptr` y se detiene el movimiento.
