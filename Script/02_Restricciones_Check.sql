--SCRIP DE LAS RESTRICCIONES DEL PROYECTO
--restricciones para INSTITUCION
ALTER TABLE INSTITUCION
	ADD CONSTRAINT ck_institucion_id_pos CHECK (id_institucion>0),
	ADD CONSTRAINT ck_institucion_nombre_vacio CHECK(TRIM(nombre)<>''),
	ADD CONSTRAINT ck_institucion_direccion_vacia CHECK(TRIM(direccion)<>'');

--restricciones para USUARIO
ALTER TABLE USUARIO
	ADD CONSTRAINT ck_usuario_id_pos CHECK(id_usuario>0),
	ADD CONSTRAINT ck_usuario_nombre_sin_numeros CHECK (nombre!~ '[0-9]' AND TRIM(nombre)<>''),
	ADD CONSTRAINT ck_usuario_apellido_sin_numeros CHECK(apellido!~'[0-9]' AND TRIM(apellido)<>''),
	ADD CONSTRAINT ck_usuario_correo_formato CHECK (correo LIKE '%_@_%._%' AND correo NOT LIKE '% %'),
	ADD CONSTRAINT ck_usuario_rol_valido CHECK (rol IN ('DOCENTE_SUPERVISOR', 'ESTUDIANTE_BRIGADISTA'));

--restruciones para RESIDUO
ALTER TABLE RESIDUO
	ADD CONSTRAINT ck_residuo_id_pos CHECK (id_residuo > 0),
  	ADD CONSTRAINT ck_residuo_nombre_vacio CHECK (TRIM(nombre) <> ''),	
	ADD CONSTRAINT ck_residuo_color_norma CHECK (color_asociado IN('BLANCO','VERDE','NEGRO'));

--restricciones para ZONA
ALTER TABLE ZONA
	ADD CONSTRAINT ck_zona_id_pos CHECK (id_zona > 0),
	ADD CONSTRAINT ck_zona_nombre_no_vacio CHECK (TRIM(nombre) <> '');

--restricciones para PUNTO_ECOLOGICO
ALTER TABLE PUNTO_ECOLOGICO
	ADD CONSTRAINT ck_punto_id_pos CHECK (id_punto > 0),
	ADD CONSTRAINT ck_punto_codigo_vacio CHECK (TRIM(codigo) <> ''),
	ADD CONSTRAINT ck_punto_ubicacion_vacia CHECK (TRIM(ubicacion) <> ''),
	ADD CONSTRAINT ck_punto_estado_valido CHECK (estado IN ('ACTIVO', 'CRITICO', 'MANTENIMIENTO', 'INACTIVO')),
	ADD CONSTRAINT ck_punto_coord_x_rango CHECK (coord_x >= 0 AND coord_x <= 100),
	ADD CONSTRAINT ck_punto_coord_y_rango CHECK (coord_y >= 0 AND coord_y <= 100);

--restricciones para RECIPIENTE
ALTER TABLE RECIPIENTE
	ADD CONSTRAINT ck_recipiente_numero_color CHECK (
    (id_recipiente = 1 AND color = 'BLANCO') OR 
    (id_recipiente = 2 AND color = 'VERDE') OR 
    (id_recipiente = 3 AND color = 'NEGRO')),
	ADD CONSTRAINT ck_recipiente_capacidad_pos CHECK (capacidad > 0);

--restricciones para JORNADA
ALTER TABLE JORNADA
	ADD CONSTRAINT ck_jornada_id_pos CHECK (id_jornada > 0);

--restricciones para DETALLE_JORNADA
ALTER TABLE DETALLE_JORNADA
	ADD CONSTRAINT ck_detalle_jornada_id_pos CHECK (id_registro_jornada > 0),
	ADD CONSTRAINT ck_detalle_jornada_estado_punto CHECK (estado_punto IN ('BUENO', 'REGULAR', 'CRITICO'));

--restricciones para DETALLE_RECIPIENTE
ALTER TABLE DETALLE_RECIPIENTE
	ADD CONSTRAINT ck_det_recipiente_id_pos CHECK (id_detalle_recipiente > 0),
	ADD CONSTRAINT ck_det_recipiente_nivel_llenado CHECK (nivel_llenado IN ('VACIO','BAJO', 'MEDIO', 'ALTO', 'DESBORDADO')),
	ADD CONSTRAINT ck_det_recipiente_estado_fisico CHECK (estado_recipiente IN ('BUENO', 'REGULAR', 'DANADO')),
	ADD CONSTRAINT ck_det_recipiente_senalizacion CHECK (estado_senalizacion IN ('BUENO', 'REGULAR', 'MALO', 'AUSENTE'));

--restricciones para ALERTA
ALTER TABLE ALERTA
	ADD CONSTRAINT ck_alerta_id_pos CHECK (id_alerta > 0),
	ADD CONSTRAINT ck_alerta_tipo_valido CHECK (tipo IN ('DESBORDAMIENTO', 'MALA_SEPARACION', 'DANO_FISICO', 'PROBLEMA_SENALIZACION')),
	ADD CONSTRAINT ck_alerta_criticidad_valida CHECK (nivel_criticidad IN ('BAJA', 'MEDIA', 'ALTA', 'CRITICA')),
	ADD CONSTRAINT ck_alerta_descripcion_vacia CHECK (TRIM(descripcion) <> '');

--restricciones para EVIDENCIA
ALTER TABLE EVIDENCIA
	ADD CONSTRAINT ck_evidencia_id_pos CHECK (id_evidencia > 0),
	ADD CONSTRAINT ck_evidencia_ruta_vacia CHECK (TRIM(ruta_archivo) <> '');

--restricciones para CUARTEO
ALTER TABLE CUARTEO
	ADD CONSTRAINT ck_cuarteo_id_pos CHECK (id_cuarteo > 0),
	ADD CONSTRAINT ck_cuarteo_pesos_pos CHECK (peso_inicial > 0 AND peso_muestra > 0),
	ADD CONSTRAINT ck_cuarteo_muestra_menor CHECK (peso_muestra <= peso_inicial);

--restricciones para RESULTADO_CUARTEO
ALTER TABLE RESULTADO_CUARTEO
	ADD CONSTRAINT ck_resultado_peso_pos CHECK (peso >= 0),
	ADD CONSTRAINT ck_resultado_cantidad_pos CHECK (cantidad >= 0),
	ADD CONSTRAINT ck_resultado_registro_valido CHECK (peso > 0 OR cantidad > 0);