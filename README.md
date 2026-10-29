#  EcoPoint Edu — Sistema Web de Gestión y Caracterización de Residuos Sólidos
 
##  Modelo de Base de Datos
 
### Diagrama Estructural Relacional
 

<img src="Esquema Relacional/ER EcoPoint.png" alt="Diagrama relacional de EcoPoint Edu" width="700">

 
##  Políticas de Borrado (Integridad Referencial)
 
| Relación | Política de borrado | Descripción |
| :--- | :--- | :--- |
| **Institucion → Zona** | `RESTRICT` | No se puede eliminar una institución si aún tiene zonas asociadas, evitando que las dependencias y ubicaciones queden huérfanas en el sistema. |
| **Zona → Punto_ecologico** | `RESTRICT` | Se impide eliminar una zona si todavía tiene puntos ecológicos físicos registrados en ella, para preservar el mapa de infraestructura. |
| **Punto_ecologico → Recipiente** | `CASCADE` | Al ser una entidad débil, si se retira o elimina un punto ecológico, sus canecas/recipientes asociados desaparecen automáticamente con él. |
| **Punto_ecologico → Detalle_jornada** | `RESTRICT` | Se prohíbe eliminar un punto ecológico si ya existen inspecciones históricas registradas en él, para no alterar las métricas pasadas. |
| **Jornada → Detalle_jornada** | `RESTRICT` | Una jornada con visitas registradas es información de campo recolectada en terreno; no se pierde por accidente al intentar borrar la jornada. Para eliminarla hay que borrar explícitamente sus visitas primero, igual que con un punto ecológico o un usuario con historial. |
| **Usuario → Detalle_jornada** | `RESTRICT` | Un auditor o usuario no puede eliminarse si figura como responsable de visitas técnicas; esto garantiza la trazabilidad y autoría de los datos. En su lugar, se desactiva (`activo = false`). |
| **Detalle_jornada → Detalle_recipiente** | `CASCADE` | Si se suprime la visita técnica a un punto ecológico, la evaluación individual de llenado y estado de cada una de sus canecas se elimina en cascada. |
| **Recipiente → Detalle_recipiente** | `RESTRICT` | No se puede borrar la ficha de un recipiente si ya tiene mediciones de llenado o estados de separación registrados en auditorías pasadas. |
| **Detalle_recipiente → Alerta** | `CASCADE` | Las alertas generadas por desbordamiento o mala separación se eliminan automáticamente si el reporte de inspección puntual que las originó es borrado. |
| **Detalle_jornada → Evidencia** | `CASCADE` | Si se borra la visita técnica, todas las fotografías y archivos adjuntos vinculados a esa inspección pierden validez y deben eliminarse. |
| **Detalle_jornada → Cuarteo** | `RESTRICT` | El muestreo de cuarteo es el dato más valioso del diagnóstico ambiental; no se pierde por un borrado accidental de la visita que lo originó. Debe eliminarse explícitamente antes de poder borrar la visita. |
| **Cuarteo → Resultado_cuarteo** | `CASCADE` | Al ser una entidad débil, el desglose de resultados por pesaje y porcentajes depende totalmente de la prueba principal y se destruye junto con ella. |
| **Residuo → Resultado_cuarteo** | `RESTRICT` | Se prohíbe eliminar un residuo del catálogo maestro (ej. orgánico, plástico) si ya fue clasificado y cuantificado en algún estudio previo. |
 
**Criterio general:** `RESTRICT` protege todo dato recolectado en campo o con valor histórico/de auditoría (jornadas, visitas, cuarteos, usuarios, puntos, residuos del catálogo); `CASCADE` se reserva para entidades débiles o datos que solo tienen sentido como parte de su padre directo (recipientes de un punto, detalle de una visita, resultados de un cuarteo, evidencias y alertas de una inspección puntual).
 
##  Equipo de Desarrollo
**Universidad Popular del Cesar**  
*Facultad de Ingenierías y Tecnologías — Programa de Ingeniería de Sistemas*  
*Asignatura: Base de Datos I*

- **Carlos Gómez Galvis**
- **Estefania Marquez**
- **Merlín Landero Cuello**

**Docente orientador:** Yair Vargas  
*Valledupar, Cesar, Colombia*
 
##  Declaración de Uso de Inteligencia Artificial y Proceso de Verificación
De acuerdo con los lineamientos académicos de transparencia de la asignatura, el equipo declara el uso de herramientas de Inteligencia Artificial como apoyo de consultoría durante la fase de diseño y revisión del esquema relacional de **EcoPoint Edu**, detallando a continuación qué elementos fueron asistidos y **cómo el equipo verificó manualmente cada componente**:
 
### 1. Alcance del apoyo con IA
 
- Revisión de cumplimiento de la **Tercera Forma Normal (3FN)**, identificando atributos redundantes o calculados: eliminación de `porcentaje` de la tabla física `RESULTADO_CUARTEO` (se calcula a partir de `peso` y `peso_muestra`, no se persiste) y de `tipo_residuo` en `RECIPIENTE` (ya está determinado por `color` mediante `ck_recipiente_numero_color`).
  
- Sugerencia de expresiones regulares y condiciones lógicas para las restricciones `CHECK` (`ck_usuario_nombre_sin_numeros`, `ck_recipiente_numero_color`, `ck_cuarteo_muestra_menor`), y explicación de la función `TRIM()` para rechazar textos compuestos solo por espacios en blanco en las validaciones de campos obligatorios.
  
- Consulta sobre mecanismos de PostgreSQL para centralizar restricciones repetidas entre varias tablas, equivalentes a una interfaz: se identificó `CREATE DOMAIN` como la herramienta adecuada. El equipo decidió **no implementarlo** en esta entrega porque aún no se ha cubierto en el curso, optando por practicar la sintaxis de `ALTER TABLE`/`ADD CONSTRAINT` de forma explícita en cada tabla, para poder explicar cada línea en la sustentación.
  
- Aclaración sobre buenas prácticas al insertar datos de prueba: coherencia narrativa de los registros (evitar nombres genéricos tipo "cliente1"), respeto estricto del orden de dependencias entre llaves foráneas al insertar, y cobertura explícita de los tres casos exigidos por la rúbrica (una fila que se relaciona con varias, una que no se relaciona con ninguna, y un intento de inserción rechazado por el motor).
  
- Diferencias entre los tipos `VARCHAR(n)` y `TEXT` en PostgreSQL (internamente equivalentes en almacenamiento y rendimiento; `VARCHAR(n)` impone un límite de longitud validado por el motor, usado aquí para cumplir el criterio de "textos acotados" de la rúbrica) y el propósito de `CURRENT_TIMESTAMP` como valor `DEFAULT` en columnas de fecha/hora de captura, para que el servidor registre el momento exacto sin depender del reloj del dispositivo usado en campo.
  
- Estructuración de lotes de datos semilla (`INSERT INTO`).
  
### 2. Cómo verificó el equipo cada entregable en PostgreSQL
 
Todo el código SQL fue auditado, corregido y probado manualmente por los tres integrantes del equipo en **PostgreSQL / pgAdmin 4** siguiendo este protocolo de verificación:
 
1. **Prueba de ejecución en limpio (Base Vacía):** se creó una base de datos completamente vacía (`ecopoint_db`) y se ejecutaron en orden secuencial `01_esquema_tablas.sql`, `02_restricciones_check.sql` y `03_datos_prueba.sql`, verificando en la consola de salida (*Messages*) que las tablas, sus llaves primarias, foráneas, únicas y restricciones `CHECK` se crearan con **cero errores**.

2. **Auditoría de nombres de restricciones y acciones referenciales:** se inspeccionó el catálogo del esquema en pgAdmin (`Constraints`) comprobando que ninguna restricción conservara nombres automáticos del servidor y que cada `FOREIGN KEY` tuviera su política `ON DELETE RESTRICT` o `ON DELETE CASCADE` acorde a las reglas del dominio ambiental, descritas en la tabla de políticas de borrado de este documento.

3. **Pruebas de rechazo en vivo (Casos Negativos):** el equipo ejecutó manualmente sentencias `INSERT` inválidas (nombres con dígitos numéricos, coordenadas fuera del rango `0..100`, `peso_muestra > peso_inicial` en `CUARTEO`, inconsistencia de `id_punto` en `DETALLE_RECIPIENTE`), capturando y conservando como evidencia el mensaje textual que PostgreSQL devolvió al rechazar cada operación, referenciando explícitamente la restricción invocada.
