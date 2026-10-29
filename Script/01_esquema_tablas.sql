--TABLAS DEL PROYECTO ECOPOINT

CREATE TABLE INSTITUCION (

	id_institucion integer,
	nombre varchar(150) NOT NULL, 
	direccion  varchar(200) NOT NULL, 
	ruta_plano varchar(250) NOT NULL,

	CONSTRAINT pk_id_institucion PRIMARY KEY (id_institucion),

	CONSTRAINT uk_nombre_institucion UNIQUE(nombre)
); 



CREATE TABLE USUARIO (

	id_usuario integer, 
	nombre varchar(80) NOT NULL, 
	apellido varchar(80) NOT NULL, 
	password_hash varchar(200) NOT NULL,
	correo varchar(120) NOT NULL,
	rol varchar(80) NOT NULL,
	activo boolean NOT NULL DEFAULT true,

	CONSTRAINT pk_id_usuario PRIMARY KEY (id_usuario),

	CONSTRAINT uk_correo_usuario UNIQUE (correo)

); 


CREATE TABLE JORNADA (

	id_jornada integer,
	id_institucion integer NOT NULL, 
	fecha date NOT NULL, 
	observaciones varchar(500),  

	CONSTRAINT pk_id_jornada PRIMARY KEY (id_jornada),

	CONSTRAINT uk_jornada UNIQUE (id_institucion, fecha),

	CONSTRAINT fk_id_institucion
	FOREIGN KEY(id_institucion) REFERENCES INSTITUCION(id_institucion) ON DELETE RESTRICT
	
); 


CREATE TABLE RESIDUO (

	id_residuo integer, 
	nombre varchar(80) NOT NULL, 
	color_asociado varchar(60) NOT NULL, 
	descripcion varchar(500),

	CONSTRAINT pk_id_residuo PRIMARY KEY (id_residuo),

	CONSTRAINT uk_nombre_residuo UNIQUE (nombre)
); 

CREATE TABLE ZONA (

	id_zona integer,
	id_institucion integer NOT NULL,
	nombre varchar(80) NOT NULL, 
	descripcion varchar(500),

	CONSTRAINT pk_id_zona PRIMARY KEY (id_zona),

	CONSTRAINT uq_zona UNIQUE(id_institucion, nombre),
	
	CONSTRAINT fk_id_instuticion 
	FOREIGN KEY(id_institucion) REFERENCES INSTITUCION(id_institucion) ON DELETE RESTRICT
	
	
); 

CREATE TABLE PUNTO_ECOLOGICO (

	id_punto integer, 
	id_zona integer NOT NULL,
	codigo varchar(120) NOT NULL,
	ubicacion varchar(100) NOT NULL, 
	estado varchar(30) NOT NULL DEFAULT 'ACTIVO',  
	coord_x numeric(5,2) NOT NULL, 
	coord_y numeric(5,2) NOT NULL, 
	observaciones varchar(500),

	CONSTRAINT pk_id_punto PRIMARY KEY (id_punto), 

	CONSTRAINT uk_codigo_punto UNIQUE (codigo),

	CONSTRAINT fk_id_zona
	FOREIGN KEY(id_zona) REFERENCES ZONA(id_zona) ON DELETE RESTRICT
); 


CREATE TABLE DETALLE_JORNADA (

	id_registro_jornada integer, 
	id_jornada integer NOT NULL, 
	id_punto integer NOT NULL, 
	id_usuario integer NOT NULL,
	fecha_captura timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, 
	estado_punto varchar(80) NOT NULL, 
	observaciones varchar(500), 

	CONSTRAINT pk_id_registro_jornada PRIMARY KEY (id_registro_jornada),

	CONSTRAINT uq_jornada_punto_unico UNIQUE(id_jornada, id_punto),

	CONSTRAINT uq_registro_punto UNIQUE(id_registro_jornada, id_punto),

	CONSTRAINT fk_id_jornada
	FOREIGN KEY(id_jornada) REFERENCES JORNADA(id_jornada) ON DELETE RESTRICT,

	CONSTRAINT fk_id_punto 
	FOREIGN KEY(id_punto) REFERENCES PUNTO_ECOLOGICO(id_punto) ON DELETE RESTRICT,

	CONSTRAINT fk_id_usuario
	FOREIGN KEY(id_usuario) REFERENCES USUARIO(id_usuario) ON DELETE RESTRICT
);


CREATE TABLE RECIPIENTE(

	id_punto integer,
	id_recipiente integer,
	color varchar(80) NOT NULL,
	capacidad numeric(5,2) NOT NULL,

	CONSTRAINT pk_id_recipiente PRIMARY KEY(id_punto,id_recipiente),

	CONSTRAINT uq_recipiente_color UNIQUE(id_punto, color),
	
	CONSTRAINT fk_punto_ecologico
	FOREIGN KEY (id_punto) REFERENCES PUNTO_ECOLOGICO(id_punto) ON DELETE CASCADE
);

CREATE TABLE DETALLE_RECIPIENTE (

	id_detalle_recipiente integer,
	id_registro_jornada integer NOT NULL, 
	id_punto integer NOT NULL, 
	id_recipiente integer NOT NULL, 
	nivel_llenado varchar(80) NOT NULL,
	estado_recipiente varchar(80) NOT NULL,
	estado_senalizacion varchar(80) NOT NULL, 
	mala_separacion boolean NOT NULL DEFAULT false,
	observaciones varchar(500),

	CONSTRAINT pk_id_detalle_recipiente PRIMARY KEY (id_detalle_recipiente),

	CONSTRAINT uq_jornada_recipiente_unico UNIQUE (id_registro_jornada, id_recipiente),
	
	CONSTRAINT fk_recipiente_det_jornada 
	FOREIGN KEY(id_registro_jornada, id_punto) REFERENCES DETALLE_JORNADA (id_registro_jornada, id_punto)ON DELETE CASCADE,

	CONSTRAINT fk_det_recipiente_recipiente
	FOREIGN KEY(id_punto, id_recipiente) REFERENCES RECIPIENTE (id_punto, id_recipiente)ON DELETE RESTRICT
);


CREATE TABLE ALERTA (

	id_alerta integer, 
	id_detalle_recipiente integer NOT NULL, 
	tipo varchar(40) NOT NULL, 
	nivel_criticidad varchar(40) NOT NULL, 
	atendida boolean NOT NULL DEFAULT false,
	descripcion varchar(500) NOT NULL,
	fecha_generada timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,

	CONSTRAINT pk_alerta PRIMARY KEY (id_alerta),

	CONSTRAINT uq_alerta_detalle_tipo UNIQUE(id_detalle_recipiente, tipo),

	CONSTRAINT fk_alerta_detalle_recipiente
	FOREIGN KEY (id_detalle_recipiente) REFERENCES DETALLE_RECIPIENTE(id_detalle_recipiente) ON DELETE CASCADE

);


CREATE TABLE EVIDENCIA (

	id_evidencia integer, 
	id_registro_jornada integer NOT NULL, 
	ruta_archivo varchar(250) NOT NULL, 
	descripcion varchar(500),
	fecha_carga timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,

	CONSTRAINT pk_id_evidencia PRIMARY KEY (id_evidencia),

	CONSTRAINT uq_evicencia_registro UNIQUE (id_registro_jornada, ruta_archivo),

	CONSTRAINT fk_evidencia_detalle_jornada 
	FOREIGN KEY (id_registro_jornada) REFERENCES DETALLE_JORNADA (id_registro_jornada) ON DELETE CASCADE
);


CREATE TABLE CUARTEO(

	id_cuarteo integer,
	id_registro_jornada integer NOT NULL, 
	peso_inicial numeric(5,2) NOT NULL, 
	peso_muestra numeric(5,2) NOT NULL, 
	observaciones varchar(500),

	 CONSTRAINT pk_cuarteo PRIMARY KEY (id_cuarteo),

	CONSTRAINT uk_cuarteo_registro_jornada UNIQUE (id_registro_jornada),

	CONSTRAINT fk_cuarteo_detalle
	FOREIGN KEY (id_registro_jornada) REFERENCES DETALLE_JORNADA(id_registro_jornada) ON DELETE RESTRICT
);


CREATE TABLE RESULTADO_CUARTEO(

	id_cuarteo integer,
	id_residuo integer, 
	peso numeric(5,2) NOT NULL, 
	cantidad integer NOT NULL,

	CONSTRAINT pk_resultado_cuarteo PRIMARY KEY (id_cuarteo, id_residuo),

	CONSTRAINT fk_resultado_cuarteo 
	FOREIGN KEY (id_cuarteo) REFERENCES CUARTEO(id_cuarteo) ON DELETE CASCADE,

	CONSTRAINT fk_resultado_cuarteo_residuo 
	FOREIGN KEY (id_residuo) REFERENCES RESIDUO(id_residuo) ON DELETE RESTRICT
);