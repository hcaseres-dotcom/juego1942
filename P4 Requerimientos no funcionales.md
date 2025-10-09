## ⚙️ Requerimientos No Funcionales

Clasificación: **O** (Obligatorio) / **R** (Recomendado)

### 🟩 O - Obligatorios

- **NF-01 Extensibilidad (O)**  
  Diseño modular que permita agregar enemigos, niveles y métricas sin romper interfaces (`Enemigo`, `Strategy` de dificultad).

- **NF-02 Mantenibilidad (O)**  
  Separación clara entre renderizado, lógica y datos. Nombres descriptivos, sin duplicación, con comentarios/Javadoc básicos.

- **NF-03 Gestión de errores (O)**  
  Manejo robusto de archivos: si no existen o están corruptos, se recrea una estructura mínima. El juego nunca debe fallar. Se recomienda jerarquía simple de excepciones en Java puro.

- **NF-05 Portabilidad (O)**  
  El juego debe compilar y ejecutarse en **Processing 4.x** sin dependencias externas.

### 🟨 R - Recomendados

- **NF-04 Rendimiento (R)**  
  Meta de ≥ **50 FPS** con cantidad razonable de sprites (elementos visuales del juego). Reciclado de listas/objetos para munición. Colisiones con AABB.
> Esta meta busca asegurar una experiencia de juego fluida y estable. Para lograr = **50 FPS**, se recomienda limitar la cantidad de sprites activos simultáneamente y optimizar el uso de memoria.  
> El **reciclado de listas y objetos** (por ejemplo, reutilizar instancias de munición en lugar de crear nuevas constantemente) reduce la carga del recolector de basura y mejora el rendimiento.  
> Las **colisiones AABB** (Axis-Aligned Bounding Box) permiten detectar intersecciones de forma eficiente, ya que comparan rectángulos alineados con los ejes, evitando cálculos costosos como los de colisión circular o pixel-perfect.

- **NF-06 Presentación y organización (R)**  
  Incluir README de ejecución, diagrama de clases y guía breve de análisis para la defensa. Alineado con la rúbrica de presentación.
