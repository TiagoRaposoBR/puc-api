--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2
-- Dumped by pg_dump version 13.2

-- Started on 2021-05-17 13:37:48

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
-- TOC entry 3 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 3053 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 207 (class 1259 OID 16443)
-- Name: char_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.char_group (
    id integer NOT NULL,
    nome character varying(250) NOT NULL
);


ALTER TABLE public.char_group OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 16441)
-- Name: char_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.char_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.char_group_id_seq OWNER TO postgres;

--
-- TOC entry 3054 (class 0 OID 0)
-- Dependencies: 206
-- Name: char_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.char_group_id_seq OWNED BY public.char_group.id;


--
-- TOC entry 205 (class 1259 OID 16430)
-- Name: characters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.characters (
    id integer NOT NULL,
    nome character varying(250) NOT NULL,
    race character varying(100),
    gender character varying(50),
    creation_date date,
    universe_id integer
);


ALTER TABLE public.characters OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 16449)
-- Name: characters_group_join; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.characters_group_join (
    group_id integer NOT NULL,
    character_id integer NOT NULL
);


ALTER TABLE public.characters_group_join OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 16428)
-- Name: characters_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.characters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.characters_id_seq OWNER TO postgres;

--
-- TOC entry 3055 (class 0 OID 0)
-- Dependencies: 204
-- Name: characters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.characters_id_seq OWNED BY public.characters.id;


--
-- TOC entry 210 (class 1259 OID 16464)
-- Name: comics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comics (
    id integer NOT NULL,
    title character varying(250) NOT NULL,
    issue_number character varying(20),
    release_date date,
    group_id integer,
    universe_id integer
);


ALTER TABLE public.comics OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16480)
-- Name: comics_characters_join; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comics_characters_join (
    comic_id integer NOT NULL,
    character_id integer NOT NULL
);


ALTER TABLE public.comics_characters_join OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16462)
-- Name: comics_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comics_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comics_id_seq OWNER TO postgres;

--
-- TOC entry 3056 (class 0 OID 0)
-- Dependencies: 209
-- Name: comics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comics_id_seq OWNED BY public.comics.id;


--
-- TOC entry 203 (class 1259 OID 16422)
-- Name: universe; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.universe (
    id integer NOT NULL,
    nome character varying(250) NOT NULL
);


ALTER TABLE public.universe OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 16420)
-- Name: universe_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.universe_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.universe_id_seq OWNER TO postgres;

--
-- TOC entry 3057 (class 0 OID 0)
-- Dependencies: 202
-- Name: universe_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.universe_id_seq OWNED BY public.universe.id;


--
-- TOC entry 201 (class 1259 OID 16415)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 16406)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer DEFAULT nextval('public.users_id_seq'::regclass) NOT NULL,
    nome text NOT NULL,
    data_criacao timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    access_token text,
    token_expire timestamp without time zone,
    userkey character varying(32) NOT NULL,
    userpass character varying(32) NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 2887 (class 2604 OID 16446)
-- Name: char_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.char_group ALTER COLUMN id SET DEFAULT nextval('public.char_group_id_seq'::regclass);


--
-- TOC entry 2886 (class 2604 OID 16433)
-- Name: characters id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.characters ALTER COLUMN id SET DEFAULT nextval('public.characters_id_seq'::regclass);


--
-- TOC entry 2888 (class 2604 OID 16467)
-- Name: comics id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comics ALTER COLUMN id SET DEFAULT nextval('public.comics_id_seq'::regclass);


--
-- TOC entry 2885 (class 2604 OID 16425)
-- Name: universe id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.universe ALTER COLUMN id SET DEFAULT nextval('public.universe_id_seq'::regclass);


--
-- TOC entry 3043 (class 0 OID 16443)
-- Dependencies: 207
-- Data for Name: char_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.char_group (id, nome) FROM stdin;
1	Bat-família
2	Liga da Justiça
3	Super-família
\.


--
-- TOC entry 3041 (class 0 OID 16430)
-- Dependencies: 205
-- Data for Name: characters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.characters (id, nome, race, gender, creation_date, universe_id) FROM stdin;
2	Batman	Humano	Masculino	1939-05-01	1
3	Robin	Humano	Masculino	1940-04-01	1
4	Batwoman	Humano	Feminino	1956-07-01	1
5	Coringa	Humano	Masculino	1940-04-25	1
6	Superman	Kriptoniano	Masculino	1938-04-01	1
7	Lex Luthor	Humano	Masculino	1940-04-01	1
\.


--
-- TOC entry 3044 (class 0 OID 16449)
-- Dependencies: 208
-- Data for Name: characters_group_join; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.characters_group_join (group_id, character_id) FROM stdin;
1	2
2	2
1	3
1	4
1	5
2	6
3	6
3	7
\.


--
-- TOC entry 3046 (class 0 OID 16464)
-- Dependencies: 210
-- Data for Name: comics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comics (id, title, issue_number, release_date, group_id, universe_id) FROM stdin;
1	Detective Comics	27	1939-05-01	1	1
2	Detective Comics	38	1940-04-01	1	1
3	Batman	1	1940-04-25	1	1
4	Action Comics	1	1938-04-01	3	1
5	Action Comics	23	1940-04-01	3	1
6	The Brave And The Bold	28	1960-03-01	2	1
7	Justice League Of America	-	1960-11-01	2	1
\.


--
-- TOC entry 3047 (class 0 OID 16480)
-- Dependencies: 211
-- Data for Name: comics_characters_join; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comics_characters_join (comic_id, character_id) FROM stdin;
1	2
2	2
2	3
3	2
3	3
3	5
4	6
5	6
5	7
6	2
6	6
7	2
7	6
\.


--
-- TOC entry 3039 (class 0 OID 16422)
-- Dependencies: 203
-- Data for Name: universe; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.universe (id, nome) FROM stdin;
1	Terra 1
2	Terra 2
3	Via Láctea
4	Kripton
\.


--
-- TOC entry 3036 (class 0 OID 16406)
-- Dependencies: 200
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, nome, data_criacao, access_token, token_expire, userkey, userpass) FROM stdin;
1	admin	2021-05-10 21:34:00.01715	48yuikjrfdov09dis8w0eu34hjkgfi98d7eyu3h42tj59-ig8fru	\N	d77301fa05c6d3275bf6800822d12e72	a569d129b400a0dfe99c416ed7489a1b
2	John Doe	2021-05-10 21:35:31.819764	sstFo01kJVYBlCV2lttQzQ==	2021-05-16 11:18:20	f87c162abb7430b535973d25d6643128	0ebea460343cf6a26b1570d0a6b8c846
\.


--
-- TOC entry 3058 (class 0 OID 0)
-- Dependencies: 206
-- Name: char_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.char_group_id_seq', 3, true);


--
-- TOC entry 3059 (class 0 OID 0)
-- Dependencies: 204
-- Name: characters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.characters_id_seq', 7, true);


--
-- TOC entry 3060 (class 0 OID 0)
-- Dependencies: 209
-- Name: comics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comics_id_seq', 7, true);


--
-- TOC entry 3061 (class 0 OID 0)
-- Dependencies: 202
-- Name: universe_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.universe_id_seq', 5, true);


--
-- TOC entry 3062 (class 0 OID 0)
-- Dependencies: 201
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- TOC entry 2896 (class 2606 OID 16448)
-- Name: char_group char_group_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.char_group
    ADD CONSTRAINT char_group_pk PRIMARY KEY (id);


--
-- TOC entry 2894 (class 2606 OID 16435)
-- Name: characters characters_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.characters
    ADD CONSTRAINT characters_pk PRIMARY KEY (id);


--
-- TOC entry 2898 (class 2606 OID 16469)
-- Name: comics comics_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comics
    ADD CONSTRAINT comics_pk PRIMARY KEY (id);


--
-- TOC entry 2892 (class 2606 OID 16427)
-- Name: universe universe_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.universe
    ADD CONSTRAINT universe_pk PRIMARY KEY (id);


--
-- TOC entry 2890 (class 2606 OID 16413)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 2900 (class 2606 OID 16452)
-- Name: characters_group_join characters_group_join_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.characters_group_join
    ADD CONSTRAINT characters_group_join_fk FOREIGN KEY (character_id) REFERENCES public.characters(id) ON DELETE CASCADE;


--
-- TOC entry 2901 (class 2606 OID 16457)
-- Name: characters_group_join characters_group_join_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.characters_group_join
    ADD CONSTRAINT characters_group_join_fk_1 FOREIGN KEY (group_id) REFERENCES public.char_group(id) ON DELETE CASCADE;


--
-- TOC entry 2899 (class 2606 OID 16436)
-- Name: characters characters_universe_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.characters
    ADD CONSTRAINT characters_universe_fk FOREIGN KEY (universe_id) REFERENCES public.universe(id);


--
-- TOC entry 2904 (class 2606 OID 16483)
-- Name: comics_characters_join comics_characters_join_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comics_characters_join
    ADD CONSTRAINT comics_characters_join_fk FOREIGN KEY (comic_id) REFERENCES public.comics(id);


--
-- TOC entry 2905 (class 2606 OID 16488)
-- Name: comics_characters_join comics_characters_join_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comics_characters_join
    ADD CONSTRAINT comics_characters_join_fk_1 FOREIGN KEY (character_id) REFERENCES public.characters(id);


--
-- TOC entry 2902 (class 2606 OID 16470)
-- Name: comics group_comics_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comics
    ADD CONSTRAINT group_comics_fk FOREIGN KEY (group_id) REFERENCES public.char_group(id);


--
-- TOC entry 2903 (class 2606 OID 16475)
-- Name: comics universe_comics_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comics
    ADD CONSTRAINT universe_comics_fk FOREIGN KEY (universe_id) REFERENCES public.universe(id);


-- Completed on 2021-05-17 13:37:48

--
-- PostgreSQL database dump complete
--

