## Actividad 4 — Adding Some Interactivity

Esta actividad corresponde al tutorial **"Adding Some Interactivity"**, donde se agrega interacción del usuario a través de variables *uniforms*.

### Análisis:

- **¿Qué hace el código del ejemplo?**
  
  - Controla el color y el movimiento de la animación con la posición del mouse.
  - Los valores del mouse son enviados como *uniforms* al shader, lo que permite que la GPU modifique el resultado visual en tiempo real.

- **¿Cómo funciona la comunicación entre CPU y GPU?**

  - La aplicación en C++ obtiene la posición del mouse y el tiempo.
  - Usa `setUniform` para pasar estos datos a los shaders.
  - El *vertex shader* puede usarlos para modificar la geometría.
  - El *fragment shader* puede usarlos para variar el color, brillo o textura.

### Ejercicio:

1. **Modifica `ofApp.cpp`** para pasar las coordenadas del mouse y el tiempo al shader:

```cpp
shader.begin();
shader.setUniform1f("time", ofGetElapsedTimef());
shader.setUniform2f("mouse", mouseX, mouseY);
shader.setUniform2f("resolution", ofGetWidth(), ofGetHeight());
plane.draw();
shader.end();
```

2. **En el vertex shader**, altera la posición de los vértices con base en el movimiento del mouse:

```glsl
#version 150

uniform float time;
uniform vec2 mouse;
in vec4 position;
in vec2 texcoord;
out vec2 vTexCoord;

void main() {
    vec4 pos = position;
    pos.z += sin(pos.x * 0.01 + time + mouse.x * 0.01) * 20.0;
    vTexCoord = texcoord;
    gl_Position = transform * pos;
}
```

3. **En el fragment shader**, cambia el color dependiendo del movimiento del mouse:

```glsl
#version 150

uniform vec2 mouse;
uniform float time;
in vec2 vTexCoord;
out vec4 outputColor;

void main() {
    float r = abs(sin(time + mouse.x * 0.01));
    float g = abs(cos(time + mouse.y * 0.01));
    float b = 0.8;
    outputColor = vec4(r, g, b, 1.0);
}
```
