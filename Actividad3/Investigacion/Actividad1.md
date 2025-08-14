### Actividad 1 - 11/08/025

Esta actividad será grupal y demostrativa. Te mostraré los pasos a seguir para instalar y probar la herramienta que usarás desde ahora en el curso. Se trata de [openframeworks](https://openframeworks.cc/). El objetivo en este curso no es que aprendas a programar en **openframeworks**, sino que entiendas cómo se implementan algunos conceptos de programación en alto nivel, pero usando un **framework** de programación creativa en C++ que te permitan explorar y experimentar de manera más visual y creativa.

## Pasos para configurar el ambiente de trabajo

1. Descarga Openframeworks en su última versión de la página web **openframeworks** recuerda tener en cuenta las recomendaciones para tu sistema operativo.  
2. Descomprime la carpeta en el directorio raíz de tu sistema. Por ejemplo `C:\` 
3. Ejecuta la aplicación `projectGenerator.exe`, deberías ver algo similar a la siguiente imagen:

Figura 1. projectGenerator

1. Configura tu proyecto y genera los archivos con la ayuda de la aplicación.

Para verificar que todo quedó correctamente instalado, vamos a realizar un pequeño ejercicio modificando ligeramente el archivo `ofApp.cpp` que se genera por defecto:

```cpp
#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    ofBackground(0);
}

//--------------------------------------------------------------
void ofApp::update(){

}

//--------------------------------------------------------------
void ofApp::draw(){
    ofSetColor(255);
    ofDrawCircle(ofGetMouseX(), ofGetMouseY(), 20);
}
```

- ¿Cuál es el resultado que se obtiene al ejecutar este programa?

El resultado que se obtiene al ejecutar este programa es una ventana en el que se dibuja un círculo blanco de 20 píxeles de radio, el cual sigue la posición del mouse en tiempo real.