-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler version: 1.0.4
-- PostgreSQL version: 15.0
-- Project Site: pgmodeler.io
-- Model Author: ---
-- -- object: pg_database_owner | type: ROLE --
-- -- DROP ROLE IF EXISTS pg_database_owner;
-- CREATE ROLE pg_database_owner WITH 
-- 	INHERIT
-- 	 PASSWORD '********';
-- -- ddl-end --
-- 
-- object: pgexercises | type: ROLE --
-- DROP ROLE IF EXISTS pgexercises;
CREATE ROLE pgexercises WITH 
	SUPERUSER
	CREATEDB
	CREATEROLE
	INHERIT
	LOGIN
	 PASSWORD '********';
-- ddl-end --


-- Database creation must be performed outside a multi lined SQL file. 
-- These commands were put in this file only as a convenience.
-- 
-- object: medicamentos | type: DATABASE --
-- DROP DATABASE IF EXISTS medicamentos;
CREATE DATABASE medicamentos
	ENCODING = 'UTF8'
	LC_COLLATE = 'Spanish_United States.1252'
	LC_CTYPE = 'Spanish_United States.1252'
	TABLESPACE = pg_default
	OWNER = postgres;
-- ddl-end --


-- object: public.paciente | type: TABLE --
-- DROP TABLE IF EXISTS public.paciente CASCADE;
CREATE TABLE public.paciente (
	numero_historia_clinica integer NOT NULL,
	nombre character varying(50),
	numero_seguridad_social character varying(20),
	direccion character varying(100),
	telefono character varying(15),
	fecha_nacimiento date,
	CONSTRAINT paciente_pkey PRIMARY KEY (numero_historia_clinica)
);
-- ddl-end --
ALTER TABLE public.paciente OWNER TO postgres;
-- ddl-end --

-- object: public.ingreso_id_ingreso_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.ingreso_id_ingreso_seq CASCADE;
CREATE SEQUENCE public.ingreso_id_ingreso_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.ingreso_id_ingreso_seq OWNER TO postgres;
-- ddl-end --

-- object: public.ingreso | type: TABLE --
-- DROP TABLE IF EXISTS public.ingreso CASCADE;
CREATE TABLE public.ingreso (
	id_ingreso integer NOT NULL DEFAULT nextval('public.ingreso_id_ingreso_seq'::regclass),
	numero_historia_clinica integer,
	servicio character varying(50),
	diagnostico character varying(100),
	fecha_ingreso date,
	fecha_alta date,
	CONSTRAINT ingreso_pkey PRIMARY KEY (id_ingreso)
);
-- ddl-end --
ALTER TABLE public.ingreso OWNER TO postgres;
-- ddl-end --

-- object: public.consumopaciente_id_consumo_paciente_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.consumopaciente_id_consumo_paciente_seq CASCADE;
CREATE SEQUENCE public.consumopaciente_id_consumo_paciente_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.consumopaciente_id_consumo_paciente_seq OWNER TO postgres;
-- ddl-end --

-- object: public.consumopaciente | type: TABLE --
-- DROP TABLE IF EXISTS public.consumopaciente CASCADE;
CREATE TABLE public.consumopaciente (
	id_consumo_paciente integer NOT NULL DEFAULT nextval('public.consumopaciente_id_consumo_paciente_seq'::regclass),
	id_ingreso integer,
	numero_registro integer,
	cantidad integer,
	CONSTRAINT consumopaciente_pkey PRIMARY KEY (id_consumo_paciente)
);
-- ddl-end --
ALTER TABLE public.consumopaciente OWNER TO postgres;
-- ddl-end --

-- object: public.consumogeneral_id_consumo_general_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.consumogeneral_id_consumo_general_seq CASCADE;
CREATE SEQUENCE public.consumogeneral_id_consumo_general_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.consumogeneral_id_consumo_general_seq OWNER TO postgres;
-- ddl-end --

-- object: public.consumogeneral | type: TABLE --
-- DROP TABLE IF EXISTS public.consumogeneral CASCADE;
CREATE TABLE public.consumogeneral (
	id_consumo_general integer NOT NULL DEFAULT nextval('public.consumogeneral_id_consumo_general_seq'::regclass),
	servicio character varying(50),
	numero_registro integer,
	cantidad integer,
	fecha_consumo date,
	CONSTRAINT consumogeneral_pkey PRIMARY KEY (id_consumo_general)
);
-- ddl-end --
ALTER TABLE public.consumogeneral OWNER TO postgres;
-- ddl-end --

-- object: public.facultativo | type: TABLE --
-- DROP TABLE IF EXISTS public.facultativo CASCADE;
CREATE TABLE public.facultativo (
	numero_colegiado integer NOT NULL,
	nombre character varying(50),
	direccion character varying(100),
	telefono character varying(15),
	servicio character varying(50),
	CONSTRAINT facultativo_pkey PRIMARY KEY (numero_colegiado)
);
-- ddl-end --
ALTER TABLE public.facultativo OWNER TO postgres;
-- ddl-end --

-- object: public.receta_id_receta_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.receta_id_receta_seq CASCADE;
CREATE SEQUENCE public.receta_id_receta_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.receta_id_receta_seq OWNER TO postgres;
-- ddl-end --

-- object: public.receta | type: TABLE --
-- DROP TABLE IF EXISTS public.receta CASCADE;
CREATE TABLE public.receta (
	id_receta integer NOT NULL DEFAULT nextval('public.receta_id_receta_seq'::regclass),
	id_ingreso integer,
	numero_registro integer,
	numero_colegiado integer,
	CONSTRAINT receta_pkey PRIMARY KEY (id_receta)
);
-- ddl-end --
ALTER TABLE public.receta OWNER TO postgres;
-- ddl-end --

-- object: public.revision_id_revision_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.revision_id_revision_seq CASCADE;
CREATE SEQUENCE public.revision_id_revision_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.revision_id_revision_seq OWNER TO postgres;
-- ddl-end --

-- object: public.revision | type: TABLE --
-- DROP TABLE IF EXISTS public.revision CASCADE;
CREATE TABLE public.revision (
	id_revision integer NOT NULL DEFAULT nextval('public.revision_id_revision_seq'::regclass),
	id_ingreso integer,
	fecha date,
	hora time,
	informe character varying(500),
	CONSTRAINT revision_pkey PRIMARY KEY (id_revision)
);
-- ddl-end --
ALTER TABLE public.revision OWNER TO postgres;
-- ddl-end --

-- object: ingreso_numero_historia_clinica_fkey | type: CONSTRAINT --
-- ALTER TABLE public.ingreso DROP CONSTRAINT IF EXISTS ingreso_numero_historia_clinica_fkey CASCADE;
ALTER TABLE public.ingreso ADD CONSTRAINT ingreso_numero_historia_clinica_fkey FOREIGN KEY (numero_historia_clinica)
REFERENCES public.paciente (numero_historia_clinica) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: consumopaciente_id_ingreso_fkey | type: CONSTRAINT --
-- ALTER TABLE public.consumopaciente DROP CONSTRAINT IF EXISTS consumopaciente_id_ingreso_fkey CASCADE;
ALTER TABLE public.consumopaciente ADD CONSTRAINT consumopaciente_id_ingreso_fkey FOREIGN KEY (id_ingreso)
REFERENCES public.ingreso (id_ingreso) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: receta_id_ingreso_fkey | type: CONSTRAINT --
-- ALTER TABLE public.receta DROP CONSTRAINT IF EXISTS receta_id_ingreso_fkey CASCADE;
ALTER TABLE public.receta ADD CONSTRAINT receta_id_ingreso_fkey FOREIGN KEY (id_ingreso)
REFERENCES public.ingreso (id_ingreso) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: receta_numero_registro_fkey | type: CONSTRAINT --
-- ALTER TABLE public.receta DROP CONSTRAINT IF EXISTS receta_numero_registro_fkey CASCADE;
ALTER TABLE public.receta ADD CONSTRAINT receta_numero_registro_fkey FOREIGN KEY (numero_registro)
REFERENCES public.consumopaciente (id_consumo_paciente) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: receta_numero_colegiado_fkey | type: CONSTRAINT --
-- ALTER TABLE public.receta DROP CONSTRAINT IF EXISTS receta_numero_colegiado_fkey CASCADE;
ALTER TABLE public.receta ADD CONSTRAINT receta_numero_colegiado_fkey FOREIGN KEY (numero_colegiado)
REFERENCES public.facultativo (numero_colegiado) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: revision_id_ingreso_fkey | type: CONSTRAINT --
-- ALTER TABLE public.revision DROP CONSTRAINT IF EXISTS revision_id_ingreso_fkey CASCADE;
ALTER TABLE public.revision ADD CONSTRAINT revision_id_ingreso_fkey FOREIGN KEY (id_ingreso)
REFERENCES public.ingreso (id_ingreso) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "grant_CU_26541e8cda" | type: PERMISSION --
GRANT CREATE,USAGE
   ON SCHEMA public
   TO pg_database_owner;
-- ddl-end --

-- object: "grant_U_cd8e46e7b6" | type: PERMISSION --
GRANT USAGE
   ON SCHEMA public
   TO PUBLIC;
-- ddl-end --


