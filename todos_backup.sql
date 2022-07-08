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
-- Name: todos; Type: TABLE; Schema: public; Owner: joelbarton
--

CREATE TABLE public.todos (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    completed boolean DEFAULT false NOT NULL,
    list_id integer NOT NULL
);


ALTER TABLE public.todos OWNER TO joelbarton;

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

ALTER SEQUENCE public.todo_id_seq OWNED BY public.todos.id;


--
-- Name: lists id; Type: DEFAULT; Schema: public; Owner: joelbarton
--

ALTER TABLE ONLY public.lists ALTER COLUMN id SET DEFAULT nextval('public.lists_id_seq'::regclass);


--
-- Name: todos id; Type: DEFAULT; Schema: public; Owner: joelbarton
--

ALTER TABLE ONLY public.todos ALTER COLUMN id SET DEFAULT nextval('public.todo_id_seq'::regclass);


--
-- Data for Name: lists; Type: TABLE DATA; Schema: public; Owner: joelbarton
--

COPY public.lists (id, name) FROM stdin;
1	Homework
2	Groceries
3	TEST TEST
\.


--
-- Data for Name: todos; Type: TABLE DATA; Schema: public; Owner: joelbarton
--

COPY public.todos (id, name, completed, list_id) FROM stdin;
2	carrots	f	2
6	Fear of being loved	f	3
7	Allegiance to the pain	f	3
8	Give anything to change	f	3
9	I fucked up; I'm missing you	f	3
1	Science	f	1
5	cs	f	1
3	spinach	t	2
4	cheese	t	2
\.


--
-- Name: lists_id_seq; Type: SEQUENCE SET; Schema: public; Owner: joelbarton
--

SELECT pg_catalog.setval('public.lists_id_seq', 4, true);


--
-- Name: todo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: joelbarton
--

SELECT pg_catalog.setval('public.todo_id_seq', 10, true);


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
-- Name: todos todo_pkey; Type: CONSTRAINT; Schema: public; Owner: joelbarton
--

ALTER TABLE ONLY public.todos
    ADD CONSTRAINT todo_pkey PRIMARY KEY (id);


--
-- Name: todos todos_list_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: joelbarton
--

ALTER TABLE ONLY public.todos
    ADD CONSTRAINT todos_list_id_fkey FOREIGN KEY (list_id) REFERENCES public.lists(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

