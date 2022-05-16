--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

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

DROP DATABASE worldcup;
--
-- Name: worldcup; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE worldcup WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE worldcup OWNER TO freecodecamp;

\connect worldcup

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
-- Name: games; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.games (
    game_id integer NOT NULL,
    year integer NOT NULL,
    round character varying(25) NOT NULL,
    winner_id integer NOT NULL,
    opponent_id integer NOT NULL,
    winner_goals integer NOT NULL,
    opponent_goals integer NOT NULL
);


ALTER TABLE public.games OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.games_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_game_id_seq OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.games_game_id_seq OWNED BY public.games.game_id;


--
-- Name: teams; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.teams (
    team_id integer NOT NULL,
    name character varying(30) NOT NULL
);


ALTER TABLE public.teams OWNER TO freecodecamp;

--
-- Name: teams_team_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.teams_team_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.teams_team_id_seq OWNER TO freecodecamp;

--
-- Name: teams_team_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.teams_team_id_seq OWNED BY public.teams.team_id;


--
-- Name: games game_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games ALTER COLUMN game_id SET DEFAULT nextval('public.games_game_id_seq'::regclass);


--
-- Name: teams team_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.teams ALTER COLUMN team_id SET DEFAULT nextval('public.teams_team_id_seq'::regclass);


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.games VALUES (156, 2018, 'Final', 442, 443, 4, 2);
INSERT INTO public.games VALUES (157, 2018, 'Third Place', 444, 445, 2, 0);
INSERT INTO public.games VALUES (158, 2018, 'Semi-Final', 443, 445, 2, 1);
INSERT INTO public.games VALUES (159, 2018, 'Semi-Final', 442, 444, 1, 0);
INSERT INTO public.games VALUES (160, 2018, 'Quarter-Final', 443, 446, 3, 2);
INSERT INTO public.games VALUES (161, 2018, 'Quarter-Final', 445, 447, 2, 0);
INSERT INTO public.games VALUES (162, 2018, 'Quarter-Final', 444, 448, 2, 1);
INSERT INTO public.games VALUES (163, 2018, 'Quarter-Final', 442, 449, 2, 0);
INSERT INTO public.games VALUES (164, 2018, 'Eighth-Final', 445, 450, 2, 1);
INSERT INTO public.games VALUES (165, 2018, 'Eighth-Final', 447, 451, 1, 0);
INSERT INTO public.games VALUES (166, 2018, 'Eighth-Final', 444, 452, 3, 2);
INSERT INTO public.games VALUES (167, 2018, 'Eighth-Final', 448, 453, 2, 0);
INSERT INTO public.games VALUES (168, 2018, 'Eighth-Final', 443, 454, 2, 1);
INSERT INTO public.games VALUES (169, 2018, 'Eighth-Final', 446, 455, 2, 1);
INSERT INTO public.games VALUES (170, 2018, 'Eighth-Final', 449, 456, 2, 1);
INSERT INTO public.games VALUES (171, 2018, 'Eighth-Final', 442, 457, 4, 3);
INSERT INTO public.games VALUES (172, 2014, 'Final', 458, 457, 1, 0);
INSERT INTO public.games VALUES (173, 2014, 'Third Place', 459, 448, 3, 0);
INSERT INTO public.games VALUES (174, 2014, 'Semi-Final', 457, 459, 1, 0);
INSERT INTO public.games VALUES (175, 2014, 'Semi-Final', 458, 448, 7, 1);
INSERT INTO public.games VALUES (176, 2014, 'Quarter-Final', 459, 460, 1, 0);
INSERT INTO public.games VALUES (177, 2014, 'Quarter-Final', 457, 444, 1, 0);
INSERT INTO public.games VALUES (178, 2014, 'Quarter-Final', 448, 450, 2, 1);
INSERT INTO public.games VALUES (179, 2014, 'Quarter-Final', 458, 442, 1, 0);
INSERT INTO public.games VALUES (180, 2014, 'Eighth-Final', 448, 461, 2, 1);
INSERT INTO public.games VALUES (181, 2014, 'Eighth-Final', 450, 449, 2, 0);
INSERT INTO public.games VALUES (182, 2014, 'Eighth-Final', 442, 462, 2, 0);
INSERT INTO public.games VALUES (183, 2014, 'Eighth-Final', 458, 463, 2, 1);
INSERT INTO public.games VALUES (184, 2014, 'Eighth-Final', 459, 453, 2, 1);
INSERT INTO public.games VALUES (185, 2014, 'Eighth-Final', 460, 464, 2, 1);
INSERT INTO public.games VALUES (186, 2014, 'Eighth-Final', 457, 451, 1, 0);
INSERT INTO public.games VALUES (187, 2014, 'Eighth-Final', 444, 465, 2, 1);


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.teams VALUES (442, 'France');
INSERT INTO public.teams VALUES (443, 'Croatia');
INSERT INTO public.teams VALUES (444, 'Belgium');
INSERT INTO public.teams VALUES (445, 'England');
INSERT INTO public.teams VALUES (446, 'Russia');
INSERT INTO public.teams VALUES (447, 'Sweden');
INSERT INTO public.teams VALUES (448, 'Brazil');
INSERT INTO public.teams VALUES (449, 'Uruguay');
INSERT INTO public.teams VALUES (450, 'Colombia');
INSERT INTO public.teams VALUES (451, 'Switzerland');
INSERT INTO public.teams VALUES (452, 'Japan');
INSERT INTO public.teams VALUES (453, 'Mexico');
INSERT INTO public.teams VALUES (454, 'Denmark');
INSERT INTO public.teams VALUES (455, 'Spain');
INSERT INTO public.teams VALUES (456, 'Portugal');
INSERT INTO public.teams VALUES (457, 'Argentina');
INSERT INTO public.teams VALUES (458, 'Germany');
INSERT INTO public.teams VALUES (459, 'Netherlands');
INSERT INTO public.teams VALUES (460, 'Costa Rica');
INSERT INTO public.teams VALUES (461, 'Chile');
INSERT INTO public.teams VALUES (462, 'Nigeria');
INSERT INTO public.teams VALUES (463, 'Algeria');
INSERT INTO public.teams VALUES (464, 'Greece');
INSERT INTO public.teams VALUES (465, 'United States');


--
-- Name: games_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.games_game_id_seq', 187, true);


--
-- Name: teams_team_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.teams_team_id_seq', 465, true);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (game_id);


--
-- Name: teams teams_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_name_key UNIQUE (name);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (team_id);


--
-- Name: games games_opponent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_opponent_id_fkey FOREIGN KEY (opponent_id) REFERENCES public.teams(team_id);


--
-- Name: games games_winner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_winner_id_fkey FOREIGN KEY (winner_id) REFERENCES public.teams(team_id);


--
-- PostgreSQL database dump complete
--


