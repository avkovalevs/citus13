--
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 13.5 (Ubuntu 13.5-2.pgdg20.04+1)
-- Dumped by pg_dump version 13.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE testdbprod;
--
-- Name: testdbprod; Type: DATABASE; Schema: -; Owner: gr_prod_dba
--

CREATE DATABASE testdbprod WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.UTF-8';


ALTER DATABASE testdbprod OWNER TO gr_prod_dba;

\connect testdbprod

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: testdbprod; Type: DATABASE PROPERTIES; Schema: -; Owner: gr_prod_dba
--

ALTER DATABASE testdbprod SET "citus.shard_replication_factor" TO '2';


\connect testdbprod

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: classifier; Type: TABLE; Schema: public; Owner: gr_prod_dba
--

CREATE TABLE public.classifier (
    classifier_id integer NOT NULL,
    text_classifier_id uuid,
    classifier_type character varying,
    state character varying,
    transaction_from date,
    transaction_to date,
    name text
);


ALTER TABLE public.classifier OWNER TO gr_prod_dba;

--
-- Name: cluster; Type: TABLE; Schema: public; Owner: gr_prod_dba
--

CREATE TABLE public.cluster (
    classifier_id integer NOT NULL,
    cluster_id integer NOT NULL,
    text_cluster_id character varying,
    transaction_from date,
    transaction_to date,
    name text
);


ALTER TABLE public.cluster OWNER TO gr_prod_dba;

SET default_table_access_method = columnar;

--
-- Name: transactionsa1; Type: TABLE; Schema: public; Owner: svc_talend_proddb
--

CREATE TABLE public.transactionsa1 (
    days2100 smallint,
    period_type character(1),
    gtin_classifier_id integer,
    gtin_cluster_id integer,
    sid_classifier_id integer,
    sid_cluster_id integer,
    cnt integer,
    price double precision,
    selling_distribution numeric(7,4)
);


ALTER TABLE public.transactionsa1 OWNER TO svc_talend_proddb;

--
-- Name: classifier classifier_pkey; Type: CONSTRAINT; Schema: public; Owner: gr_prod_dba
--

ALTER TABLE ONLY public.classifier
    ADD CONSTRAINT classifier_pkey PRIMARY KEY (classifier_id);


--
-- Name: cluster pk_cluster; Type: CONSTRAINT; Schema: public; Owner: gr_prod_dba
--

ALTER TABLE ONLY public.cluster
    ADD CONSTRAINT pk_cluster PRIMARY KEY (classifier_id, cluster_id);


--
-- Name: TABLE classifier; Type: ACL; Schema: public; Owner: gr_prod_dba
--

GRANT SELECT ON TABLE public.classifier TO gr_prod_read;
GRANT SELECT,INSERT,DELETE,TRUNCATE,UPDATE ON TABLE public.classifier TO gr_prod_write;


--
-- Name: TABLE cluster; Type: ACL; Schema: public; Owner: gr_prod_dba
--

GRANT SELECT ON TABLE public.cluster TO gr_prod_read;
GRANT SELECT,INSERT,DELETE,TRUNCATE,UPDATE ON TABLE public.cluster TO gr_prod_write;


--
-- PostgreSQL database dump complete
--


