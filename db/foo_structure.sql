create schema foo;
SET search_path TO foo;

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: foo; Owner: -
--

CREATE TABLE foo.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: companies; Type: TABLE; Schema: foo; Owner: -
--

CREATE TABLE foo.companies (
    id bigint NOT NULL,
    name character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: companies_id_seq; Type: SEQUENCE; Schema: foo; Owner: -
--

CREATE SEQUENCE foo.companies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: companies_id_seq; Type: SEQUENCE OWNED BY; Schema: foo; Owner: -
--

ALTER SEQUENCE foo.companies_id_seq OWNED BY foo.companies.id;


--
-- Name: products; Type: TABLE; Schema: foo; Owner: -
--

CREATE TABLE foo.products (
    id bigint NOT NULL,
    name character varying NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    invoice_price numeric NOT NULL,
    msrp_price numeric NOT NULL,
    retail_price numeric NOT NULL,
    current_stock integer DEFAULT 0 NOT NULL,
    uuid character varying NOT NULL,
    company_id integer NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: products_id_seq; Type: SEQUENCE; Schema: foo; Owner: -
--

CREATE SEQUENCE foo.products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: foo; Owner: -
--

ALTER SEQUENCE foo.products_id_seq OWNED BY foo.products.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: foo; Owner: -
--

CREATE TABLE foo.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: foo; Owner: -
--

CREATE TABLE foo.users (
    id bigint NOT NULL,
    company_id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    first_name character varying DEFAULT ''::character varying NOT NULL,
    last_name character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: foo; Owner: -
--

CREATE SEQUENCE foo.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: foo; Owner: -
--

ALTER SEQUENCE foo.users_id_seq OWNED BY foo.users.id;


--
-- Name: companies id; Type: DEFAULT; Schema: foo; Owner: -
--

ALTER TABLE ONLY foo.companies ALTER COLUMN id SET DEFAULT nextval('foo.companies_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: foo; Owner: -
--

ALTER TABLE ONLY foo.products ALTER COLUMN id SET DEFAULT nextval('foo.products_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: foo; Owner: -
--

ALTER TABLE ONLY foo.users ALTER COLUMN id SET DEFAULT nextval('foo.users_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: foo; Owner: -
--

ALTER TABLE ONLY foo.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: foo; Owner: -
--

ALTER TABLE ONLY foo.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: foo; Owner: -
--

ALTER TABLE ONLY foo.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: foo; Owner: -
--

ALTER TABLE ONLY foo.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: foo; Owner: -
--

ALTER TABLE ONLY foo.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_companies_on_name; Type: INDEX; Schema: foo; Owner: -
--

CREATE UNIQUE INDEX index_companies_on_name ON foo.companies USING btree (name);


--
-- Name: index_users_on_email; Type: INDEX; Schema: foo; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON foo.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: foo; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON foo.users USING btree (reset_password_token);


--
-- Name: users fk_rails_7682a3bdfe; Type: FK CONSTRAINT; Schema: foo; Owner: -
--

ALTER TABLE ONLY foo.users
    ADD CONSTRAINT fk_rails_7682a3bdfe FOREIGN KEY (company_id) REFERENCES foo.companies(id) ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", foo;

INSERT INTO "schema_migrations" (version) VALUES
('20210205031499'),
('20210205031500'),
('20210205055858');


