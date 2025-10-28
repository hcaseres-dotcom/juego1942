## ⚙️ Requerimientos No Funcionales

- **NF-01 Extensibilidad (O)**  
  El juego cuenta con un diseño modular que permita agregar enemigos, niveles y métricas sin romper interfaces (`Enemigo`, `Strategy` de dificultad).

- **NF-02 Mantenibilidad (O)**  
  El juego permite una separación clara entre renderizado, lógica y datos. Nombres descriptivos, sin duplicación, con comentarios/Javadoc básicos.

- **NF-03 Gestión de errores (O)**  
 **El juego otorga un manejo robusto de archivos: si no existen o están corruptos, se recrea una estructura mínima. El juego nunca debe fallar. Se recomienda jerarquía simple de excepciones en Java puro.**

- **NF-04 Portabilidad (O)**  
  El juego debe compilar y ejecutarse en **Processing 4.x** sin dependencias externas.

- **NF-05 Rendimiento (R)**  
  El juego debe cargar en un tiempo menor a 10 segundos. El objeto nave debe responder optimamente a los controles manejados por el usuario.  

- **NF-06 Presentación y organización (R)**  
  El juego incluye un README de ejecución, diagrama de clases y guía breve de análisis para la defensa. Alineado con la rúbrica de presentación.
