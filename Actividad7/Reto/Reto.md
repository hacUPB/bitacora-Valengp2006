# Reto - 29/10/2025

### Concepto visual y funcional

La aplicación representará una **superficie ondulante**, simulando un “mar digital” o “energía lumínica”.

**Vertex Shader:**

- Deforma los vértices de la malla con una función de onda (`sin` o `cos`) en base al tiempo.
- Eso cumple el requisito de *modificar los vértices.*

**Fragment Shader:**

- Cambia el color de cada fragmento según su altura o posición.
- Usa un gradiente dinámico que se mueve con el tiempo o reacciona al mouse.
- Eso cumple el requisito de *modificar los colores de los fragmentos.*

### Funcionalidades interactivas

Para cumplir con el “interactivo” del reto, puedes incluir una o varias de estas:

1. **Interacción con el mouse:**

   - Mueve el mouse en X/Y → cambia gradualmente el color de la malla con colores que van del azul al morado.
 
2. **Teclado:**

   - Tecla ↑/↓ → aumenta o disminuye amplitud.
   - Tecla “C” → cambia la frecuencia de la onda.
     
3. **Animación automática:**

   - La malla se mueve sola con `ofGetElapsedTimef()`.

### Estructura de la malla

En `ofApp.cpp` se creará una **malla de puntos** (de aproximadamente, 100x100 vértices) con `ofMesh`.

Cada cuadro (`update`) enviará uniformes al shader:

- Tiempo (`time`)
- Posición del mouse (`mouse`)
- Amplitud y frecuencia de onda

### Resultado visual esperado

Visualmente se parecerá a esto:

- Ondas suaves que se desplazan horizontalmente.
- Colores que van del **azul al púrpura** según altura.
- Interacción que cambia la frecuencia.
- Interacción que cambia color con el mouse.

<img width="766" height="425" alt="Captura de pantalla 2025-10-29 164205" src="https://github.com/user-attachments/assets/3610c0d8-4ec2-4edd-b930-ff7491eea9b4" />

### Para los RAEs

**RAE1 (Construcción y explicación):**

- Explicar cómo se deforma la malla en el vertex shader.
- Explicar cómo se calculan los colores en el fragment shader.
- Mostrar el código y un video de la app corriendo.

**RAE2 (Pruebas):**

- Mostrar cómo se probó:

  - La malla base (sin shaders).
  - El vertex shader (probando distintas deformaciones).
  - El fragment shader (probando gradientes y animación).
  - Todo junto (la app final con interacción).


