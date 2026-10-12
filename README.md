# 🌿 EcoPoint Edu — Sistema Web de Gestión y Caracterización de Residuos Sólidos

> Plataforma interdisciplinaria desarrollada en conjunto entre **Ingeniería de Sistemas** e **Ingeniería Ambiental** para el diagnóstico, registro, georreferenciación y análisis técnico de puntos ecológicos en instituciones educativas.

---

## 📌 Tabla de Contenidos
1. [Descripción General](#-descripción-general)
2. [Marco Normativo y Metodológico](#-marco-normativo-y-metodológico)
3. [Arquitectura del Sistema](#-arquitectura-del-sistema)
4. [Módulos y Requerimientos](#-módulos-y-requerimientos)
5. [Modelo de Base de Datos](#-modelo-de-base-de-datos)
6. [Políticas de Borrado (Integridad Referencial)](#-políticas-de-borrado-integridad-referencial)
7. [Tecnologías Utilizadas](#-tecnologías-utilizadas)
8. [Equipo de Desarrollo](#-equipo-de-desarrollo)

---

## 📖 Descripción General
En las instituciones educativas, las decisiones sobre infraestructura ambiental suelen tomarse de forma intuitiva ante la falta de registros históricos centralizados. **EcoPoint Edu** resuelve esta problemática sistematizando las jornadas de campo de caracterización (7 días consecutivos), permitiendo:

- Reemplazar planillas físicas por captura ágil y adaptativa en dispositivos móviles.
- Trazabilidad total de qué inspector registró la visita y qué áreas presentan sobrellenado recurrente.
- Automatización del cálculo de composición física y porcentajes del **método del cuarteo**.
- Emisión inmediata de alertas operativas por desbordamiento y mala separación en la fuente.

---

## ⚖️ Marco Normativo y Metodológico
- **Resolución 2184 de 2019 (MinAmbiente Colombia):** Código unificado de colores para separación en la fuente:
  - ⚪ **Blanco:** Residuos aprovechables (plástico, vidrio, metal, papel, cartón).
  - 🟢 **Verde:** Residuos orgánicos aprovechables (restos de comida, desechos agrícolas).
  - ⚫ **Negro:** Residuos no aprovechables (papel higiénico, servilletas, papeles contaminados).
- **ISO 9000:2015:** Gestión de calidad basada en procesos, trazabilidad y toma de decisiones basada en evidencia.
- **ISO 14001 (Ciclo PHVA):** Planear, Hacer, Verificar y Actuar para la mejora continua del entorno institucional.

---

## 🏛️ Arquitectura del Sistema
El sistema implementa una arquitectura desacoplada en **3 capas**:

1. **Capa de Presentación (Frontend):** Interfaz web adaptable (*responsive*), diseñada con HTML5 semántico, CSS3 y JavaScript moderno interactuando mediante Fetch API.
2. **Capa de Lógica de Negocio (Backend):** Desarrollada en Java bajo principios de Programación Orientada a Objetos, patrones de diseño **GRASP** (Information Expert, Creator, Low Coupling) y principios **SOLID**.
3. **Capa de Persistencia y Acceso a Datos (DAO):** Implementada mediante el patrón **DAO (Data Access Object)** con transacciones JDBC conectadas a **PostgreSQL 16+**.

---

## ⚙️ Módulos y Requerimientos

### Funcionales (RF)
- **RF1 - Instituciones y Zonas:** Administración de sedes educativas y delimitación de sectores (patios, cafeterías, aulas).
- **RF2 - Puntos Ecológicos y Recipientes:** Registro con georreferenciación (coordenadas X, Y), estado inicial y canecas asociadas por color.
- **RF3 - Jornadas de Caracterización:** Control de sesiones de campo, fecha, hora, observaciones y auditor responsable.
- **RF4 - Llenado y Residuos:** Registro de niveles de llenado (Bajo, Medio, Alto, Crítico) y peso acumulado por recipiente.
- **RF5 - Método del Cuarteo:** Procesamiento algorítmico del peso de la muestra, pesaje por residuo y cálculo automático de porcentajes.
- **RF6 - Evidencias Fotográficas:** Almacenamiento y vinculación de archivos multimedia a cada inspección técnica.
- **RF7 - Mapa Interactivo:** Visualización gráfica de puntos ecológicos con indicadores semafóricos de estado.
- **RF8 - Alertas y Reportes:** Notificación automática de desbordamientos y generación de informes históricos comparativos.

### No Funcionales (RNF)
- **RNF1 - Usabilidad Responsive:** Optimizado para smartphones durante el trabajo de campo.
- **RNF2 - Rendimiento:** Consultas de consolidación y reportes procesadas en menos de 3 segundos.
- **RNF3 - Seguridad y Control de Acceso:** Roles diferenciados (Inspector de Campo vs. Administrador/Analista).
- **RNF4 - Integridad Declarativa:** Validaciones a nivel de base de datos (`NOT NULL`, `CHECK`, `FK`).

---

## 🗄️ Modelo de Base de Datos

### Diagrama Estructural Relacional
---

## 🛡️ Políticas de Borrado (Integridad Referencial)

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

---

## 💻 Tecnologías Utilizadas
- **Lenguaje Principal:** Java (JDK 17+)
- **Base de Datos:** PostgreSQL 16+
- **Frontend:** HTML5, CSS3, JavaScript (Fetch API)
- **Persistencia:** JDBC, Data Access Object (DAO) Pattern
- **Control de Versiones y Modelado:** Git, GitHub, Mermaid.js

---

## 👥 Equipo de Desarrollo
**Universidad Popular del Cesar**  
*Facultad de Ingenierías y Tecnologías — Programa de Ingeniería de Sistemas*  
*Asignatura: Programación III*

- **Carlos Gómez Galvis**
- **Estefania Marquez**
- **Merlín Landero Cuello**

**Docente orientador:** Alfredo Bautista  
*Valledupar, Cesar, Colombia*
