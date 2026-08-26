-- ==========================================
-- ESTRUCTURA (CREATE)
-- ==========================================

CREATE SCHEMA IF NOT EXISTS public AUTHORIZATION pg_database_owner;

CREATE SEQUENCE IF NOT EXISTS carreras_id_carrera_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

CREATE SEQUENCE IF NOT EXISTS estudiantes_id_estudiante_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

CREATE SEQUENCE IF NOT EXISTS facultades_id_facultad_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

CREATE TABLE facultades (
	id_facultad serial4 NOT NULL,
	nombre varchar(150) NOT NULL,
	codigo varchar(10) NOT NULL,
	decano varchar(100) NULL,
	telefono varchar(20) NULL,
	CONSTRAINT facultades_codigo_key UNIQUE (codigo),
	CONSTRAINT facultades_codigo_not_null NOT NULL codigo,
	CONSTRAINT facultades_id_facultad_not_null NOT NULL id_facultad,
	CONSTRAINT facultades_nombre_not_null NOT NULL nombre,
	CONSTRAINT facultades_pkey PRIMARY KEY (id_facultad)
);

CREATE TABLE carreras (
	id_carrera serial4 NOT NULL,
	id_facultad int4 NOT NULL,
	nombre varchar(150) NOT NULL,
	codigo varchar(10) NOT NULL,
	duracion_semestres int4 NOT NULL,
	estado varchar(20) DEFAULT 'ACTIVA'::character varying NULL,
	CONSTRAINT carreras_codigo_key UNIQUE (codigo),
	CONSTRAINT carreras_codigo_not_null NOT NULL codigo,
	CONSTRAINT carreras_duracion_semestres_not_null NOT NULL duracion_semestres,
	CONSTRAINT carreras_id_carrera_not_null NOT NULL id_carrera,
	CONSTRAINT carreras_id_facultad_not_null NOT NULL id_facultad,
	CONSTRAINT carreras_nombre_not_null NOT NULL nombre,
	CONSTRAINT carreras_pkey PRIMARY KEY (id_carrera),
	CONSTRAINT fk_carrera_facultad FOREIGN KEY (id_facultad) REFERENCES facultades(id_facultad)
);

CREATE TABLE estudiantes (
	id_estudiante serial4 NOT NULL,
	matricula varchar(20) NOT NULL,
	nombre varchar(100) NOT NULL,
	apellido varchar(100) NOT NULL,
	email varchar(100) NULL,
	telefono varchar(20) NULL,
	fecha_nacimiento date NULL,
	id_carrera int4 NOT NULL,
	fecha_ingreso date DEFAULT CURRENT_DATE NULL,
	estado varchar(20) DEFAULT 'ACTIVO'::character varying NULL,
	CONSTRAINT estudiantes_apellido_not_null NOT NULL apellido,
	CONSTRAINT estudiantes_email_key UNIQUE (email),
	CONSTRAINT estudiantes_id_carrera_not_null NOT NULL id_carrera,
	CONSTRAINT estudiantes_id_estudiante_not_null NOT NULL id_estudiante,
	CONSTRAINT estudiantes_matricula_key UNIQUE (matricula),
	CONSTRAINT estudiantes_matricula_not_null NOT NULL matricula,
	CONSTRAINT estudiantes_nombre_not_null NOT NULL nombre,
	CONSTRAINT estudiantes_pkey PRIMARY KEY (id_estudiante),
	CONSTRAINT fk_estudiantes_carrera FOREIGN KEY (id_carrera) REFERENCES carreras(id_carrera)
);

-- ==========================================
-- DATOS (INSERT)
-- ==========================================

INSERT INTO public.facultades (nombre,codigo,decano,telefono) VALUES
	 ('Facultad de Ingenieria','ING','Carlos Mendoza','6123456789'),
	 ('Facultad de Ciencias','CIE','Laura Ramirez','6122345678'),
	 ('Facultad de Administración','ADM','Roberto López','6123456789');

INSERT INTO public.carreras (id_facultad,nombre,codigo,duracion_semestres,estado) VALUES
	 (1,'Ingenieria en Desarrollo de Software','IDS',8,'ACTIVA'),
	 (1,'Ingenieria en Tecnologías Computacionales','ITC',8,'ACTIVA'),
	 (2,'Licenciatura en Biologia','BIO',8,'ACTIVA');

INSERT INTO public.estudiantes (matricula,nombre,apellido,email,telefono,fecha_nacimiento,id_carrera,fecha_ingreso,estado) VALUES
	 ('20260002','Maria','Lopez','maria@universidad.mx','6122222222','2004-08-15',7,'2026-08-20','ACTIVO'),
	 ('20260003','Carlos','Ramírez','carlos@universidad.mx','6123333333','2005-01-20',8,'2026-08-20','ACTIVO'),
	 ('20260004','Ana','Torres','ana@universidad.mx','6124444444','2004-11-03',9,'2026-08-20','ACTIVO'),
	 ('20260001','Juan','Peréz','Juan@universidad.mx','6121111111','2005-06-10',7,'2026-08-20','ACTIVO');
