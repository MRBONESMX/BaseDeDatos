-- DROP SCHEMA public;

CREATE SCHEMA public AUTHORIZATION pg_database_owner;

-- DROP SEQUENCE public.carreras_id_carrera_seq;

CREATE SEQUENCE public.carreras_id_carrera_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.estudiantes_id_estudiante_seq;

CREATE SEQUENCE public.estudiantes_id_estudiante_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.facultades_id_facultad_seq;

CREATE SEQUENCE public.facultades_id_facultad_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;-- public.facultades definition

-- Drop table

-- DROP TABLE public.facultades;

CREATE TABLE public.facultades (
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


-- public.carreras definition

-- Drop table

-- DROP TABLE public.carreras;

CREATE TABLE public.carreras (
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
	CONSTRAINT fk_carrera_facultad FOREIGN KEY (id_facultad) REFERENCES public.facultades(id_facultad)
);


-- public.estudiantes definition

-- Drop table

-- DROP TABLE public.estudiantes;

CREATE TABLE public.estudiantes (
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
	CONSTRAINT fk_estudiantes_carrera FOREIGN KEY (id_carrera) REFERENCES public.carreras(id_carrera)
);