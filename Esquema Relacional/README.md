### Políticas de Borrado 

| Relaciónes | Política de borrado | Descripción |
| :--- | :--- | :--- |
| **Institucion → Zona** | `RESTRICT` | No se puede eliminar una institución si aún tiene zonas asociadas, evitando que las dependencias y ubicaciones queden huérfanas en el sistema. |
| **Zona → Punto_ecologico** | `RESTRICT` | Se impide eliminar una zona si todavía tiene puntos ecológicos físicos registrados en ella para preservar el mapa de infraestructura. |
| **Punto_ecologico → Recipiente** | `CASCADE` | Al ser una entidad débil, si se retira o elimina un punto ecológico, sus canecas/recipientes asociados desaparecen automáticamente con él. |
| **Punto_ecologico → Detalle_jornada** | `RESTRICT` | Se prohíbe eliminar un punto ecológico si ya existen inspecciones históricas registradas en él para no alterar las métricas pasadas. |
| **Jornada → Detalle_jornada** | `CASCADE` | Si se cancela y descarta una jornada completa de auditoría, todos los registros de inspección tomados en esa sesión se borran en conjunto. |
| **Usuario → Detalle_jornada** | `RESTRICT` | Un auditor o usuario no puede eliminarse si figura como responsable de visitas técnicas; esto garantiza la trazabilidad y autoría de los datos. |
| **Detalle_jornada → Detalle_recipiente** | `CASCADE` | Si se suprime la visita técnica a un punto ecológico, la evaluación individual de llenado y estado de cada una de sus canecas se elimina en cascada. |
| **Recipiente → Detalle_recipiente** | `RESTRICT` | No se puede borrar la ficha de un recipiente si ya tiene mediciones de llenado o estados de separación registrados en auditorías pasadas. |
| **Detalle_recipiente → Alerta** | `CASCADE` | Las alertas generadas por desbordamiento o mala separación se eliminan automáticamente si el reporte de inspección puntual que las originó es borrado. |
| **Detalle_jornada → Evidencia** | `CASCADE` | Si se borra la visita técnica, todas las fotografías y archivos adjuntos vinculados a esa inspección pierden validez y deben eliminarse. |
| **Detalle_jornada → Cuarteo** | `CASCADE` | Si se anula la visita técnica al punto, el muestreo de cuarteo de residuos originado a partir de esa misma visita pierde sustento y se elimina. |
| **Cuarteo → Resultado_cuarteo** | `CASCADE` | Al ser una entidad débil, el desglose de resultados por pesaje y porcentajes depende totalmente de la prueba principal y se destruye junto con ella. |
| **Residuo → Resultado_cuarteo** | `RESTRICT` | Se prohíbe eliminar un residuo del catálogo maestro (ej. orgánico, plástico) si ya fue clasificado y cuantificado en algún estudio previo. |
