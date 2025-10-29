## Actividad 3 — Adding Uniforms

En esta actividad se explora cómo enviar información personalizada desde la aplicación en CPU hacia los *shaders* que corren en la GPU.  
El tutorial base es **"Adding Uniforms"**, parte de la introducción a shaders de *openFrameworks*.

###  Conceptos clave:

- **¿Qué es un uniform?**  
  Un *uniform* es una variable global dentro del shader cuyo valor proviene directamente de la aplicación en CPU.  
  A diferencia de las variables locales, su valor es el mismo para todos los fragmentos o vértices durante un mismo *draw call*.

- **¿Cómo funciona la comunicación entre la aplicación y los shaders?**  
  1. En la aplicación (`ofApp.cpp`), se declara y envía el valor:  
     ```cpp
     shader.setUniform1f("time", ofGetElapsedTimef());
     shader.setUniform3f("mouse", mouseX, mouseY, 0.0);
     ```
  2. En el shader (GLSL), se recibe el valor:  
     ```glsl
     uniform float time;
     uniform vec3 mouse;
     ```
  3. Estos valores pueden usarse para modificar color, posición o cualquier otra propiedad visual.

### Ejercicio:

Modifica el `fragment shader` para alterar el color de cada píxel usando variables *uniform*.  
Por ejemplo, hacer que el color cambie en función del tiempo o de la posición del mouse.

```glsl
// fragment shader personalizado
#version 150

out vec4 outputColor;
uniform float time;
uniform vec2 resolution;

void main() {
    vec2 st = gl_FragCoord.xy / resolution;
    float r = abs(sin(time + st.x * 3.14));
    float g = abs(cos(time + st.y * 3.14));
    float b = 0.8;
    outputColor = vec4(r, g, b, 1.0);
}
```

```cpp
// En ofApp::draw()
shader.begin();
shader.setUniform1f("time", ofGetElapsedTimef());
shader.setUniform2f("resolution", ofGetWidth(), ofGetHeight());
ofDrawRectangle(0, 0, ofGetWidth(), ofGetHeight());
shader.end();
```


