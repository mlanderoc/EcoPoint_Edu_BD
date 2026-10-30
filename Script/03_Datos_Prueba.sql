--SCRIP DE DATOS DE PRUEBA
--CASO 1: Se relaciona con varias 
--CASO 2: NO se relaciona con ninguna

--  TABLA INSTITUCION    
   -- 1: Institución 1 tendrá varias zonas y varias jornadas.
   -- 2: Institución 5 no tiene zonas ni jornadas asociadas.
   
INSERT INTO INSTITUCION (id_institucion, nombre, direccion, ruta_plano) VALUES
   (1, 'Universidad Popular del Cesar - Sede Sabanas', 'Diagonal 21 No. 29-56, Valledupar', 'planos/upc_sabanas.png'),
   (2, 'Universidad Popular del Cesar - Sede Hurtado', 'Via a Patillal Km 1, Valledupar', 'planos/upc_hurtado.png'),
   (3, 'Colegio Nacional Loperena', 'Calle 16 No. 11-25, Valledupar', 'planos/loperena_central.png'),
   (4, 'Institucion Educativa Prudencia Daza', 'Calle 19B No. 12-40, Valledupar', 'planos/prudencia_daza.png'),
   (5, 'Universidad Popular del Cesar - Sede Bellas Artes', 'Carrera 9 No. 15-10, Valledupar', 'planos/upc_bellas_artes.png');


--  TABLA USUARIO 
   -- 1: Usuario 1 y 2 capturan múltiples detalles de jornada.
   -- 2: Usuario 5 está registrado pero aún no ha capturado ninguna jornada.
   
INSERT INTO USUARIO (id_usuario, nombre, apellido, password_hash, correo, rol, activo) VALUES
   (1, 'Merlin ', 'Calderon', '$2a$10$hashMerlin987654321', 'mcalde@ecopoint.co', 'DOCENTE_SUPERVISOR', true),
   (2, 'Jimin', 'Park', '$2a$10$hashEstefania123456', 'jiminshi@ecopoint.co', 'ESTUDIANTE_BRIGADISTA', true),
   (3, 'Ho-seok', 'Jung', '$2a$10$hashCarlos654321987', 'j_hope@ecopoint.co', 'ESTUDIANTE_BRIGADISTA', true),
   (4, 'Nam-joon', 'Kim', '$2a$10$hashLaura1122334455', 'papiNam@ecopoint.co', 'DOCENTE_SUPERVISOR', true),
   (5, 'Taehyung', 'Kim', '$2a$10$hashAndres998877665', 'tae@ecopoint.co', 'ESTUDIANTE_BRIGADISTA', true);


--  TABLA RESIDUO
   -- 1: Residuos 1, 2 y 3 aparecen en varios resultados de cuarteo.
   -- 2: Residuo 6 (Vidrio Transparente) no aparece en ningún cuarteo aún.
   
INSERT INTO RESIDUO (id_residuo, nombre, color_asociado, descripcion) VALUES
   (1, 'Plastico y Envases', 'BLANCO', 'Botellas plasticas limpias y envases aprovechables'),
   (2, 'Papel y Carton Limpio', 'BLANCO', 'Hojas de cuaderno, carpetas y cajas sin grasa'),
   (3, 'Restos de Alimentos y Jardineria', 'VERDE', 'Residuos organicos biodegradables de cafeteria y poda'),
   (4, 'Servilletas y Papel Engrasado', 'NEGRO', 'Papeles sucios o contaminados con comida no reciclables'),
   (5, 'Empaques Metalizados y Mecatos', 'NEGRO', 'Envolturas de paquetes no aprovechables'),
   (6, 'Vidrio Transparente', 'BLANCO', 'Envases de vidrio retornables o reciclables');


--  TABLA ZONA 
   -- 1: Institución 1 tiene las zonas 1, 2 y 3; la Zona 1 tiene varios puntos.
   -- 2: Zona 6 no tiene puntos ecológicos instalados aún.
   
INSERT INTO ZONA (id_zona, id_institucion, nombre, descripcion) VALUES
   (1, 1, 'Cafeteria Central', 'Zona de alimentacion estudiantil de alta generacion organica'),
   (2, 1, 'Bloque A de Ingenierias', 'Pasillos del primer y segundo piso de aulas de sistemas'),
   (3, 1, 'Biblioteca Institucional', 'Area de estudio y consulta bibliografica'),
   (4, 2, 'Plazoleta Deportiva', 'Canchas multiples de la sede Hurtado'),
   (5, 3, 'Patio Principal Loperena', 'Patio central de recreo estudiantil'),
   (6, 4, 'Auditorio Central', 'Zona de eventos aun sin puntos ecologicos asignados');


--  TABLA PUNTO_ECOLOGICO
   -- 1: Zona 1 contiene los Puntos 1 y 2.
   -- 2: Punto 6 está registrado pero aún no tiene inspecciones en DETALLE_JORNADA.
   
INSERT INTO PUNTO_ECOLOGICO (id_punto, id_zona, codigo, ubicacion, estado, coord_x, coord_y, observaciones) VALUES
   (1, 1, 'PE-SAB-CAF-01', 'Entrada principal de Cafeteria Central', 'CRITICO', 65.50, 25.00, 'Punto de mayor trafico en hora de almuerzo'),
   (2, 1, 'PE-SAB-CAF-02', 'Salida lateral de Cafeteria hacia jardines', 'ACTIVO', 72.00, 30.50, 'Punto de apoyo junto a mesas exteriores'),
   (3, 2, 'PE-SAB-ING-01', 'Pasillo primer piso frente a escaleras Bloque A', 'ACTIVO', 24.00, 22.50, 'Punto bajo techo en buen estado'),
   (4, 3, 'PE-SAB-BIB-01', 'Recepcion de Biblioteca primer nivel', 'ACTIVO', 40.00, 80.00, 'Alta generacion de papel limpio'),
   (5, 4, 'PE-HUR-DEP-01', 'Graderia norte de canchas multiples', 'MANTENIMIENTO', 55.00, 50.00, 'Estructura metalica en revision'),
   (6, 5, 'PE-LOP-PAT-01', 'Esquina norte del patio de banderas', 'ACTIVO', 15.00, 75.00, 'Punto recien instalado sin inspecciones previas');


--  TABLA RECIPIENTE   
INSERT INTO RECIPIENTE (id_punto, id_recipiente, color, capacidad) VALUES
   (1, 1, 'BLANCO', 55.00), (1, 2, 'VERDE', 55.00), (1, 3, 'NEGRO', 55.00),
   (2, 1, 'BLANCO', 55.00), (2, 2, 'VERDE', 55.00), (2, 3, 'NEGRO', 55.00),
   (3, 1, 'BLANCO', 45.00), (3, 2, 'VERDE', 45.00), (3, 3, 'NEGRO', 45.00),
   (4, 1, 'BLANCO', 45.00), (4, 2, 'VERDE', 45.00), (4, 3, 'NEGRO', 45.00),
   (5, 1, 'BLANCO', 60.00), (5, 2, 'VERDE', 60.00), (5, 3, 'NEGRO', 60.00);


--  TABLA JORNADA 
   -- 1: Jornada 1 incluye múltiples registros en DETALLE_JORNADA.
   -- 2: Jornada 5 está programada a futuro y aún no tiene registros en DETALLE_JORNADA.
   
INSERT INTO JORNADA (id_jornada, id_institucion, fecha, observaciones) VALUES
   (1, 1, '2026-10-05', 'Primera jornada de diagnostico ambiental en Sede Sabanas'),
   (2, 1, '2026-10-12', 'Segunda jornada de seguimiento en Sede Sabanas'),
   (3, 2, '2026-10-15', 'Jornada de auditoria en Sede Hurtado'),
   (4, 1, '2026-10-20', 'Tercera jornada de control posterior a campana educativa'),
   (5, 3, '2026-11-02', 'Jornada programada pendiente de ejecucion en Colegio Loperena');



--  TABLA DETALLE_JORNADA
INSERT INTO DETALLE_JORNADA (id_registro_jornada, id_jornada, id_punto, id_usuario, fecha_captura, estado_punto, observaciones) VALUES
   (1, 1, 1, 1, '2026-10-05 12:30:00', 'CRITICO', 'Punto saturado despues del turno de almuerzo'),
   (2, 1, 2, 2, '2026-10-05 13:10:00', 'BUENO', 'Separacion adecuada en zona exterior'),
   (3, 1, 3, 1, '2026-10-05 14:00:00', 'BUENO', 'Predominio de papel y botellas PET limpias'),
   (4, 2, 1, 3, '2026-10-12 12:45:00', 'REGULAR', 'Persiste mezcla de servilletas en caneca blanca'),
   (5, 3, 5, 4, '2026-10-15 10:15:00', 'CRITICO', 'Recipiente negro presenta fisura lateral');

--  TABLA DETALLE_RECIPIENTE
INSERT INTO DETALLE_RECIPIENTE (id_detalle_recipiente, id_registro_jornada, id_punto, id_recipiente, nivel_llenado, estado_recipiente, estado_senalizacion,
   mala_separacion, observaciones) VALUES
   (1, 1, 1, 1, 'ALTO', 'BUENO', 'BUENO', true, 'Botellas mezcladas con servilletas engrasadas'),
   (2, 1, 1, 2, 'DESBORDADO', 'BUENO', 'REGULAR', false, 'Rebosamiento de restos de almuerzo'),
   (3, 1, 1, 3, 'MEDIO', 'BUENO', 'BUENO', false, 'Uso normal del recipiente negro'),
   (4, 2, 2, 1, 'MEDIO', 'BUENO', 'BUENO', false, 'Correcta disposicion de envases'),
   (5, 3, 3, 1, 'BAJO', 'BUENO', 'BUENO', false, 'Hojas de papel limpias sin contaminacion'),
   (6, 4, 1, 1, 'ALTO', 'REGULAR', 'MALO', true, 'Etiqueta blanca despegada y mala clasificacion'),
   (7, 5, 5, 3, 'ALTO', 'DANADO', 'AUSENTE', true, 'Caneca negra rota en el borde superior');



-- TABLA ALERTA  
INSERT INTO ALERTA (id_alerta, id_detalle_recipiente, tipo, nivel_criticidad, atendida, descripcion, fecha_generada) VALUES
   (1, 1, 'MALA_SEPARACION', 'ALTA', false, 'Contaminacion cruzada en caneca blanca de Cafeteria Central', '2026-10-05 12:35:00'),
   (2, 2, 'DESBORDAMIENTO', 'CRITICA', false, 'Recipiente verde desbordado requiere recoleccion inmediata', '2026-10-05 12:36:00'),
   (3, 6, 'PROBLEMA_SENALIZACION', 'MEDIA', true, 'Reposicion de rotulo normativo en caneca blanca', '2026-10-12 12:50:00'),
   (4, 7, 'DANO_FISICO', 'CRITICA', false, 'Reemplazo urgente de recipiente negro fracturado', '2026-10-15 10:20:00'),
   (5, 7, 'MALA_SEPARACION', 'ALTA', false, 'Mezcla de botellas reciclables en caneca negra danada', '2026-10-15 10:21:00');



-- TABLA EVIDENCIA  
INSERT INTO EVIDENCIA (id_evidencia, id_registro_jornada, ruta_archivo, descripcion, fecha_carga) VALUES
   (1, 1, 'evidencias/jornada1_punto1_blanco.jpg', 'Foto de servilletas dentro del contenedor blanco', '2026-10-05 12:40:00'),
   (2, 1, 'evidencias/jornada1_punto1_verde.jpg', 'Foto del desbordamiento de residuos organicos', '2026-10-05 12:41:00'),
   (3, 2, 'evidencias/jornada1_punto2_general.jpg', 'Vista panoramica del punto ecologico 2', '2026-10-05 13:15:00'),
   (4, 4, 'evidencias/jornada2_punto1_rotulo.jpg', 'Detalle del rotulo deteriorado', '2026-10-12 12:55:00'),
   (5, 5, 'evidencias/jornada3_punto5_dano.jpg', 'Evidencia de fisura en el contenedor negro', '2026-10-15 10:25:00');


-- TABLA CUARTEO 
INSERT INTO CUARTEO (id_cuarteo, id_registro_jornada, peso_inicial, peso_muestra, observaciones) VALUES
   (1, 1, 24.00, 12.00, 'Cuarteo completo de residuos recolectados en Cafeteria Central'),
   (2, 2, 14.50, 8.00, 'Muestra homogeneizada de punto exterior de cafeteria'),
   (3, 3, 10.00, 5.50, 'Caracterizacion de residuos de pasillo de ingenieria'),
   (4, 4, 21.00, 10.50, 'Segundo estudio gravimetrico en Cafeteria Central'),
   (5, 5, 18.00, 9.00, 'Cuarteo realizado en plazoleta deportiva Hurtado');


-- TABLA RESULTADO_CUARTEO
INSERT INTO RESULTADO_CUARTEO (id_cuarteo, id_residuo, peso, cantidad) VALUES
   (1, 1, 4.20, 35),
   (1, 3, 5.40, 28),
   (1, 4, 2.10, 19),
   (2, 1, 3.10, 24),
   (3, 2, 3.80, 42),
   (4, 3, 6.00, 31),
   (5, 5, 4.50, 50);