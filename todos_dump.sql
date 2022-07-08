--
-- PostgreSQL database dump
--

-- Dumped from database version 14.3
-- Dumped by pg_dump version 14.3

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
-- Name: lists; Type: TABLE; Schema: public; Owner: joelbarton
--

CREATE TABLE public.lists (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.lists OWNER TO joelbarton;

--
-- Name: lists_id_seq; Type: SEQUENCE; Schema: public; Owner: joelbarton
--

CREATE SEQUENCE public.lists_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lists_id_seq OWNER TO joelbarton;

--
-- Name: lists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: joelbarton
--

ALTER SEQUENCE public.lists_id_seq OWNED BY public.lists.id;


--
-- Name: todo; Type: TABLE; Schema: public; Owner: joelbarton
--

CREATE TABLE public.todo (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    completed boolean DEFAULT false NOT NULL,
    list_id integer NOT NULL
);


ALTER TABLE public.todo OWNER TO joelbarton;

--
-- Name: todo_id_seq; Type: SEQUENCE; Schema: public; Owner: joelbarton
--

CREATE SEQUENCE public.todo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.todo_id_seq OWNER TO joelbarton;

--
-- Name: todo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: joelbarton
--

ALTER SEQUENCE public.todo_id_seq OWNED BY public.todo.id;


--
-- Name: lists id; Type: DEFAULT; Schema: public; Owner: joelbarton
--

ALTER TABLE ONLY public.lists ALTER COLUMN id SET DEFAULT nextval('public.lists_id_seq'::regclass);


--
-- Name: todo id; Type: DEFAULT; Schema: public; Owner: joelbarton
--

ALTER TABLE ONLY public.todo ALTER COLUMN id SET DEFAULT nextval('public.todo_id_seq'::regclass);


--
-- Data for Name: lists; Type: TABLE DATA; Schema: public; Owner: joelbarton
--

COPY public.lists (id, name) FROM stdin;
\.


--
-- Data for Name: todo; Type: TABLE DATA; Schema: public; Owner: joelbarton
--

COPY public.todo (id, name, completed, list_id) FROM stdin;
\.


--
-- Name: lists_id_seq; Type: SEQUENCE SET; Schema: public; Owner: joelbarton
--

SELECT pg_catalog.setval('public.lists_id_seq', 1, false);


--
-- Name: todo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: joelbarton
--

SELECT pg_catalog.setval('public.todo_id_seq', 1, false);


--
-- Name: lists lists_name_key; Type: CONSTRAINT; Schema: public; Owner: joelbarton
--

ALTER TABLE ONLY public.lists
    ADD CONSTRAINT lists_name_key UNIQUE (name);


--
-- Name: lists lists_pkey; Type: CONSTRAINT; Schema: public; Owner: joelbarton
--

ALTER TABLE ONLY public.lists
    ADD CONSTRAINT lists_pkey PRIMARY KEY (id);


--
-- Name: todo todo_pkey; Type: CONSTRAINT; Schema: public; Owner: joelbarton
--

ALTER TABLE ONLY public.todo
    ADD CONSTRAINT todo_pkey PRIMARY KEY (id);


--
-- Name: todo todo_list_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: joelbarton
--

ALTER TABLE ONLY public.todo
    ADD CONSTRAINT todo_list_id_fkey FOREIGN KEY (list_id) REFERENCES public.lists(id);


--
-- PostgreSQL database dump complete
--

