-- ==========================================
-- ESTRUCTURA Y DATOS DE LA BASE DE DATOS
-- ==========================================

-- Consulta de verificación para estudiantes
SELECT * FROM estudiantes;

-- ------------------------------------------
-- Tabla: docentes
-- ------------------------------------------
CREATE TABLE docentes ( 
	id_docente SERIAL PRIMARY KEY, 
	numero_empleado VARCHAR(20) UNIQUE NOT NULL, 
	nombre VARCHAR(100) NOT NULL, 
	apellido VARCHAR(100) NOT NULL, 
	email VARCHAR(100) UNIQUE, 
	telefono VARCHAR(20), 
	id_facultad INT NOT NULL, 
	es_tiempo_completo BOOLEAN DEFAULT FALSE,
	
	CONSTRAINT fk_docente_facultad
	    FOREIGN KEY (id_facultad)
	    REFERENCES facultades(id_facultad)
);

-- ------------------------------------------
-- Tabla: materias
-- ------------------------------------------
CREATE TABLE materias ( 
	id_materia SERIAL PRIMARY KEY, 
	id_carrera INT NOT NULL, 
	clave VARCHAR(20) UNIQUE NOT NULL, 
	nombre VARCHAR(150) NOT NULL, 
	creditos INT NOT NULL, 
	tipo VARCHAR(50), 
	descripcion TEXT,
	
	CONSTRAINT fk_materia_carrera
	    FOREIGN KEY (id_carrera)
	    REFERENCES carreras(id_carrera)
);

-- Consulta de verificación para carreras
SELECT * FROM carreras;

-- Poblado de datos iniciales en la tabla materias
INSERT INTO materias (id_carrera, clave, nombre, creditos, tipo, descripcion) 
VALUES 
(7, 'IDS101', 'Metodología de la Programación', 8, 'Obligatoria', 'Fundamentos de programación'), 
(7, 'IDS201', 'Programación Web', 8, 'Obligatoria', 'Desarrollo de aplicaciones web'), 
(7, 'IDS301', 'Base de Datos II', 8, 'Obligatoria', 'Bases de datos avanzadas'), 
(8, 'ITC101', 'Redes de Computadoras', 7, 'Obligatoria', 'Fundamentos de redes');

-- ------------------------------------------
-- Tabla: aulas
-- ------------------------------------------
CREATE TABLE aulas ( 
	id_aula SERIAL PRIMARY KEY, 
	codigo VARCHAR(20) UNIQUE NOT NULL, 
	edificio VARCHAR(100), 
	capacidad INT NOT NULL, 
	tipo VARCHAR(50) 
);

-- Poblado de datos iniciales en la tabla aulas
INSERT INTO aulas (codigo, edificio, capacidad, tipo) 
VALUES 
	('A-101', 'Edificio A', 30, 'Laboratorio'), 
	('A-102', 'Edificio A', 40, 'Aula'), 
	('B-201', 'Edificio B', 25, 'Laboratorio'), 
	('B-202', 'Edificio B', 35, 'Aula');

-- ------------------------------------------
-- Tabla: periodos_academicos
-- ------------------------------------------
CREATE TABLE periodos_academicos ( 
	id_periodo SERIAL PRIMARY KEY, 
	nombre VARCHAR(50) NOT NULL, 
	fecha_inicio DATE NOT NULL, 
	fecha_fin DATE NOT NULL, 
	estado VARCHAR(20) DEFAULT 'ACTIVO' 
);

-- Poblado de datos iniciales en la tabla periodos_academicos
INSERT INTO periodos_academicos (nombre, fecha_inicio, fecha_fin, estado) 
VALUES 
('2026-1', '2026-01-20', '2026-06-15', 'FINALIZADO'), 
('2026-2', '2026-08-10', '2026-12-15', 'ACTIVO');
