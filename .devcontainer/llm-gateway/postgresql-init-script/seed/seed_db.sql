--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE langfuse;
ALTER ROLE langfuse WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE litellm;
ALTER ROLE litellm WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:vtmnCsr6OVCESWOm36Y3Ng==$77cMRpYbnvBfMdaE70imyVZDiucezv0D67fuMLFkqjE=:gRIWw0P1t06QiHCriB/OJu33384kRuo6w801bhb+jD8=';

--
-- User Configurations
--








--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3 (Ubuntu 16.3-1.pgdg22.04+1)

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
-- PostgreSQL database dump complete
--

--
-- Database "langfuse" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3 (Ubuntu 16.3-1.pgdg22.04+1)

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
-- Name: langfuse; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE langfuse WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE langfuse OWNER TO postgres;

\connect langfuse

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
-- Name: DatasetStatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."DatasetStatus" AS ENUM (
    'ACTIVE',
    'ARCHIVED'
);


ALTER TYPE public."DatasetStatus" OWNER TO postgres;

--
-- Name: JobConfigState; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."JobConfigState" AS ENUM (
    'ACTIVE',
    'INACTIVE'
);


ALTER TYPE public."JobConfigState" OWNER TO postgres;

--
-- Name: JobExecutionStatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."JobExecutionStatus" AS ENUM (
    'COMPLETED',
    'ERROR',
    'PENDING',
    'CANCELLED'
);


ALTER TYPE public."JobExecutionStatus" OWNER TO postgres;

--
-- Name: JobType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."JobType" AS ENUM (
    'EVAL'
);


ALTER TYPE public."JobType" OWNER TO postgres;

--
-- Name: ObservationLevel; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."ObservationLevel" AS ENUM (
    'DEBUG',
    'DEFAULT',
    'WARNING',
    'ERROR'
);


ALTER TYPE public."ObservationLevel" OWNER TO postgres;

--
-- Name: ObservationType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."ObservationType" AS ENUM (
    'SPAN',
    'EVENT',
    'GENERATION'
);


ALTER TYPE public."ObservationType" OWNER TO postgres;

--
-- Name: PricingUnit; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."PricingUnit" AS ENUM (
    'PER_1000_TOKENS',
    'PER_1000_CHARS'
);


ALTER TYPE public."PricingUnit" OWNER TO postgres;

--
-- Name: ProjectRole; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."ProjectRole" AS ENUM (
    'OWNER',
    'ADMIN',
    'MEMBER',
    'VIEWER'
);


ALTER TYPE public."ProjectRole" OWNER TO postgres;

--
-- Name: ScoreSource; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."ScoreSource" AS ENUM (
    'API',
    'REVIEW',
    'EVAL'
);


ALTER TYPE public."ScoreSource" OWNER TO postgres;

--
-- Name: TokenType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."TokenType" AS ENUM (
    'PROMPT',
    'COMPLETION',
    'TOTAL'
);


ALTER TYPE public."TokenType" OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Account" (
    id text NOT NULL,
    type text NOT NULL,
    provider text NOT NULL,
    "providerAccountId" text NOT NULL,
    refresh_token text,
    access_token text,
    expires_at integer,
    token_type text,
    scope text,
    id_token text,
    session_state text,
    user_id text NOT NULL,
    expires_in integer,
    ext_expires_in integer
);


ALTER TABLE public."Account" OWNER TO postgres;

--
-- Name: Session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Session" (
    id text NOT NULL,
    expires timestamp(3) without time zone NOT NULL,
    session_token text NOT NULL,
    user_id text NOT NULL
);


ALTER TABLE public."Session" OWNER TO postgres;

--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO postgres;

--
-- Name: api_keys; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.api_keys (
    id text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    note text,
    public_key text NOT NULL,
    hashed_secret_key text NOT NULL,
    display_secret_key text NOT NULL,
    last_used_at timestamp(3) without time zone,
    expires_at timestamp(3) without time zone,
    project_id text NOT NULL,
    fast_hashed_secret_key text
);


ALTER TABLE public.api_keys OWNER TO postgres;

--
-- Name: audit_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.audit_logs (
    id text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    user_id text NOT NULL,
    project_id text NOT NULL,
    resource_type text NOT NULL,
    resource_id text NOT NULL,
    action text NOT NULL,
    before text,
    after text,
    user_project_role public."ProjectRole" NOT NULL
);


ALTER TABLE public.audit_logs OWNER TO postgres;

--
-- Name: cron_jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cron_jobs (
    name text NOT NULL,
    last_run timestamp(3) without time zone,
    state text,
    job_started_at timestamp(3) without time zone
);


ALTER TABLE public.cron_jobs OWNER TO postgres;

--
-- Name: dataset_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dataset_items (
    id text NOT NULL,
    input jsonb,
    expected_output jsonb,
    source_observation_id text,
    dataset_id text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    status public."DatasetStatus" DEFAULT 'ACTIVE'::public."DatasetStatus" NOT NULL,
    source_trace_id text,
    metadata jsonb
);


ALTER TABLE public.dataset_items OWNER TO postgres;

--
-- Name: dataset_run_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dataset_run_items (
    id text NOT NULL,
    dataset_run_id text NOT NULL,
    dataset_item_id text NOT NULL,
    observation_id text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    trace_id text NOT NULL
);


ALTER TABLE public.dataset_run_items OWNER TO postgres;

--
-- Name: dataset_runs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dataset_runs (
    id text NOT NULL,
    name text NOT NULL,
    dataset_id text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    metadata jsonb,
    description text
);


ALTER TABLE public.dataset_runs OWNER TO postgres;

--
-- Name: datasets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datasets (
    id text NOT NULL,
    name text NOT NULL,
    project_id text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    description text,
    metadata jsonb
);


ALTER TABLE public.datasets OWNER TO postgres;

--
-- Name: eval_templates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eval_templates (
    id text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    project_id text NOT NULL,
    name text NOT NULL,
    version integer NOT NULL,
    prompt text NOT NULL,
    model text NOT NULL,
    model_params jsonb NOT NULL,
    vars text[] DEFAULT ARRAY[]::text[],
    output_schema jsonb NOT NULL
);


ALTER TABLE public.eval_templates OWNER TO postgres;

--
-- Name: events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.events (
    id text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    project_id text NOT NULL,
    data jsonb NOT NULL,
    url text,
    method text,
    headers jsonb DEFAULT '{}'::jsonb NOT NULL
);


ALTER TABLE public.events OWNER TO postgres;

--
-- Name: job_configurations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job_configurations (
    id text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    project_id text NOT NULL,
    job_type public."JobType" NOT NULL,
    eval_template_id text,
    score_name text NOT NULL,
    filter jsonb NOT NULL,
    target_object text NOT NULL,
    variable_mapping jsonb NOT NULL,
    sampling numeric(65,30) NOT NULL,
    delay integer NOT NULL,
    status public."JobConfigState" DEFAULT 'ACTIVE'::public."JobConfigState" NOT NULL
);


ALTER TABLE public.job_configurations OWNER TO postgres;

--
-- Name: job_executions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job_executions (
    id text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    project_id text NOT NULL,
    job_configuration_id text NOT NULL,
    status public."JobExecutionStatus" NOT NULL,
    start_time timestamp(3) without time zone,
    end_time timestamp(3) without time zone,
    error text,
    job_input_trace_id text,
    job_output_score_id text
);


ALTER TABLE public.job_executions OWNER TO postgres;

--
-- Name: llm_api_keys; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.llm_api_keys (
    id text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    provider text NOT NULL,
    display_secret_key text NOT NULL,
    secret_key text NOT NULL,
    project_id text NOT NULL
);


ALTER TABLE public.llm_api_keys OWNER TO postgres;

--
-- Name: membership_invitations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.membership_invitations (
    id text NOT NULL,
    email text NOT NULL,
    project_id text NOT NULL,
    sender_id text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    role public."ProjectRole" NOT NULL
);


ALTER TABLE public.membership_invitations OWNER TO postgres;

--
-- Name: models; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.models (
    id text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    project_id text,
    model_name text NOT NULL,
    match_pattern text NOT NULL,
    start_date timestamp(3) without time zone,
    input_price numeric(65,30),
    output_price numeric(65,30),
    total_price numeric(65,30),
    unit text NOT NULL,
    tokenizer_config jsonb,
    tokenizer_id text
);


ALTER TABLE public.models OWNER TO postgres;

--
-- Name: observations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.observations (
    id text NOT NULL,
    name text,
    start_time timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    end_time timestamp(3) without time zone,
    parent_observation_id text,
    type public."ObservationType" NOT NULL,
    trace_id text,
    metadata jsonb,
    model text,
    "modelParameters" jsonb,
    input jsonb,
    output jsonb,
    level public."ObservationLevel" DEFAULT 'DEFAULT'::public."ObservationLevel" NOT NULL,
    status_message text,
    completion_start_time timestamp(3) without time zone,
    completion_tokens integer DEFAULT 0 NOT NULL,
    prompt_tokens integer DEFAULT 0 NOT NULL,
    total_tokens integer DEFAULT 0 NOT NULL,
    version text,
    project_id text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    unit text,
    prompt_id text,
    input_cost numeric(65,30),
    output_cost numeric(65,30),
    total_cost numeric(65,30),
    internal_model text
);


ALTER TABLE public.observations OWNER TO postgres;

--
-- Name: observations_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.observations_view AS
 SELECT o.id,
    o.name,
    o.start_time,
    o.end_time,
    o.parent_observation_id,
    o.type,
    o.trace_id,
    o.metadata,
    o.model,
    o."modelParameters",
    o.input,
    o.output,
    o.level,
    o.status_message,
    o.completion_start_time,
    o.completion_tokens,
    o.prompt_tokens,
    o.total_tokens,
    o.version,
    o.project_id,
    o.created_at,
    o.unit,
    o.prompt_id,
    o.input_cost,
    o.output_cost,
    o.total_cost,
    o.internal_model,
    m.id AS model_id,
    m.start_date AS model_start_date,
    m.input_price,
    m.output_price,
    m.total_price,
    m.tokenizer_config,
        CASE
            WHEN ((o.input_cost IS NULL) AND (o.output_cost IS NULL) AND (o.total_cost IS NULL)) THEN ((o.prompt_tokens)::numeric * m.input_price)
            ELSE o.input_cost
        END AS calculated_input_cost,
        CASE
            WHEN ((o.input_cost IS NULL) AND (o.output_cost IS NULL) AND (o.total_cost IS NULL)) THEN ((o.completion_tokens)::numeric * m.output_price)
            ELSE o.output_cost
        END AS calculated_output_cost,
        CASE
            WHEN ((o.input_cost IS NULL) AND (o.output_cost IS NULL) AND (o.total_cost IS NULL)) THEN
            CASE
                WHEN ((m.total_price IS NOT NULL) AND (o.total_tokens IS NOT NULL)) THEN (m.total_price * (o.total_tokens)::numeric)
                ELSE (((o.prompt_tokens)::numeric * m.input_price) + ((o.completion_tokens)::numeric * m.output_price))
            END
            ELSE o.total_cost
        END AS calculated_total_cost,
        CASE
            WHEN (o.end_time IS NULL) THEN NULL::double precision
            ELSE ((EXTRACT(epoch FROM o.end_time) - EXTRACT(epoch FROM o.start_time)))::double precision
        END AS latency,
        CASE
            WHEN ((o.completion_start_time IS NOT NULL) AND (o.start_time IS NOT NULL)) THEN (EXTRACT(epoch FROM (o.completion_start_time - o.start_time)))::double precision
            ELSE NULL::double precision
        END AS time_to_first_token
   FROM (public.observations o
     LEFT JOIN LATERAL ( SELECT models.id,
            models.created_at,
            models.updated_at,
            models.project_id,
            models.model_name,
            models.match_pattern,
            models.start_date,
            models.input_price,
            models.output_price,
            models.total_price,
            models.unit,
            models.tokenizer_config,
            models.tokenizer_id
           FROM public.models
          WHERE (((models.project_id = o.project_id) OR (models.project_id IS NULL)) AND (models.model_name = o.internal_model) AND ((models.start_date < o.start_time) OR (models.start_date IS NULL)) AND (o.unit = models.unit))
          ORDER BY models.project_id, models.start_date DESC NULLS LAST
         LIMIT 1) m ON (true));


ALTER VIEW public.observations_view OWNER TO postgres;

--
-- Name: posthog_integrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.posthog_integrations (
    project_id text NOT NULL,
    encrypted_posthog_api_key text NOT NULL,
    posthog_host_name text NOT NULL,
    last_sync_at timestamp(3) without time zone,
    enabled boolean NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.posthog_integrations OWNER TO postgres;

--
-- Name: pricings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pricings (
    id text NOT NULL,
    model_name text NOT NULL,
    pricing_unit public."PricingUnit" DEFAULT 'PER_1000_TOKENS'::public."PricingUnit" NOT NULL,
    price numeric(65,30) NOT NULL,
    currency text DEFAULT 'USD'::text NOT NULL,
    token_type public."TokenType" NOT NULL
);


ALTER TABLE public.pricings OWNER TO postgres;

--
-- Name: project_memberships; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.project_memberships (
    project_id text NOT NULL,
    user_id text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    role public."ProjectRole" NOT NULL
);


ALTER TABLE public.project_memberships OWNER TO postgres;

--
-- Name: projects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.projects (
    id text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    name text NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    cloud_config jsonb
);


ALTER TABLE public.projects OWNER TO postgres;

--
-- Name: prompts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prompts (
    id text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    project_id text NOT NULL,
    created_by text NOT NULL,
    name text NOT NULL,
    version integer NOT NULL,
    is_active boolean,
    config jsonb DEFAULT '{}'::jsonb NOT NULL,
    prompt jsonb NOT NULL,
    type text DEFAULT 'text'::text NOT NULL,
    tags text[] DEFAULT ARRAY[]::text[],
    labels text[] DEFAULT ARRAY[]::text[]
);


ALTER TABLE public.prompts OWNER TO postgres;

--
-- Name: scores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scores (
    id text NOT NULL,
    "timestamp" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    name text NOT NULL,
    value double precision NOT NULL,
    observation_id text,
    trace_id text NOT NULL,
    comment text,
    source public."ScoreSource" NOT NULL,
    project_id text NOT NULL
);


ALTER TABLE public.scores OWNER TO postgres;

--
-- Name: sso_configs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sso_configs (
    domain text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    auth_provider text NOT NULL,
    auth_config jsonb
);


ALTER TABLE public.sso_configs OWNER TO postgres;

--
-- Name: trace_sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trace_sessions (
    id text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    project_id text NOT NULL,
    bookmarked boolean DEFAULT false NOT NULL,
    public boolean DEFAULT false NOT NULL
);


ALTER TABLE public.trace_sessions OWNER TO postgres;

--
-- Name: traces; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.traces (
    id text NOT NULL,
    "timestamp" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    name text,
    project_id text NOT NULL,
    metadata jsonb,
    external_id text,
    user_id text,
    release text,
    version text,
    public boolean DEFAULT false NOT NULL,
    bookmarked boolean DEFAULT false NOT NULL,
    input jsonb,
    output jsonb,
    session_id text,
    tags text[] DEFAULT ARRAY[]::text[],
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.traces OWNER TO postgres;

--
-- Name: traces_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.traces_view AS
 WITH observations_metrics AS (
         SELECT o_1.trace_id,
            o_1.project_id,
            ((EXTRACT(epoch FROM COALESCE(max(o_1.end_time), max(o_1.start_time))))::double precision - (EXTRACT(epoch FROM min(o_1.start_time)))::double precision) AS duration
           FROM public.observations o_1
          GROUP BY o_1.project_id, o_1.trace_id
        )
 SELECT t.id,
    t."timestamp",
    t.name,
    t.project_id,
    t.metadata,
    t.external_id,
    t.user_id,
    t.release,
    t.version,
    t.public,
    t.bookmarked,
    t.input,
    t.output,
    t.session_id,
    t.tags,
    o.duration
   FROM (public.traces t
     LEFT JOIN observations_metrics o ON (((t.id = o.trace_id) AND (t.project_id = o.project_id))));


ALTER VIEW public.traces_view OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id text NOT NULL,
    name text,
    email text,
    email_verified timestamp(3) without time zone,
    password text,
    image text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    feature_flags text[] DEFAULT ARRAY[]::text[],
    admin boolean DEFAULT false NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: verification_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.verification_tokens (
    identifier text NOT NULL,
    token text NOT NULL,
    expires timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.verification_tokens OWNER TO postgres;

--
-- Data for Name: Account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Account" (id, type, provider, "providerAccountId", refresh_token, access_token, expires_at, token_type, scope, id_token, session_state, user_id, expires_in, ext_expires_in) FROM stdin;
\.


--
-- Data for Name: Session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Session" (id, expires, session_token, user_id) FROM stdin;
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
8b155899-7697-4f62-966b-b15c31e6e08d	c418394abc6167c883f1456639e995ab5054a8257e8dba37b7a95c76ba59af0c	2024-05-23 10:02:33.126918+00	20230710200816_scores_add_comment	\N	\N	2024-05-23 10:02:33.105208+00	1
06c4e569-c8d8-4ce8-a726-8e1c772d12ab	45fc679b7dbbe0f2954623bfe4e29932374cdc3167f8395728ef5c20115e5665	2024-05-23 10:02:31.920072+00	20230518191501_init	\N	\N	2024-05-23 10:02:31.682162+00	1
149e9b87-d37b-4493-899a-d866aa0e25bf	6462cebefe054956e2fa9948435590bd4dae0d58f75cf2ecba57059f2c0909f8	2024-05-23 10:02:32.788492+00	20230623172401_observation_add_level_and_status_message	\N	\N	2024-05-23 10:02:32.767203+00	1
c932a8a0-1ab9-4bec-93e8-8397a55a4c00	b9c79e332b90d28b1711534e53622f297a6a888aa7d6c1c1832185d1fef2c929	2024-05-23 10:02:32.011446+00	20230518193415_add_observaionts_and_traces	\N	\N	2024-05-23 10:02:31.926938+00	1
c8a2da57-53c5-41e9-91be-3a90e6e19b32	2f2fd22c3cc8bd21f6f23c88b7d5ef34674431520d0e55a37f8239e4a58afebd	2024-05-23 10:02:32.041548+00	20230518193521_changes	\N	\N	2024-05-23 10:02:32.01898+00	1
b3a564bf-3372-49f0-8905-7b1f0bceb35d	d2c9bf829418360a44d1022156aaa8e95df92c940b5dfe962f8a7f7260cb5520	2024-05-23 10:02:32.103332+00	20230522092340_add_metrics_and_observation_types	\N	\N	2024-05-23 10:02:32.048299+00	1
9db06e3b-fe9b-4804-bf59-73ec70fec40f	2480f771a6b4dea1f541c0b231784e5cebf2c443ac7636da6a411c4914f1cbd4	2024-05-23 10:02:32.83143+00	20230626095337_external_trace_id	\N	\N	2024-05-23 10:02:32.795153+00	1
d5c59046-f8ae-4708-9992-69efa53287a6	28c59a2bd9b846d914083efdc1b51eb96a1db66af370b3dddd5040a57ec9088b	2024-05-23 10:02:32.13135+00	20230522094431_endtime_optional	\N	\N	2024-05-23 10:02:32.11047+00	1
803674cf-0a71-43e8-b688-ed615cd1ff8c	755b1309b9c12e892f5a5f6db4e14f15b2d77ab61f76baab4c3621ea5e94fa6c	2024-05-23 10:02:32.160714+00	20230522131516_default_timestamp	\N	\N	2024-05-23 10:02:32.138309+00	1
1fee2ce8-b851-4576-bf4e-d51fbc36bda3	7f995c9ff2b7e3f70bb5eeebb2108552feaf5f8a51154727c36db9466f0e3ec4	2024-05-23 10:02:33.542037+00	20230731162154_score_value_float	\N	\N	2024-05-23 10:02:33.47457+00	1
228370db-fac0-435b-8376-b5fbbb6879b1	66607eae9ccdfb92f30d859bcff0838e5df64c76da43ffbb25a65845dc63234e	2024-05-23 10:02:32.221269+00	20230523082455_rename_metrics_to_gradings	\N	\N	2024-05-23 10:02:32.167527+00	1
27b3b970-7730-4e8e-a8d3-7992a482c7eb	e5b55a82f4be9d623abac6ef0d9d00da2bf437f60454ed46bb1defa30e388692	2024-05-23 10:02:32.859803+00	20230705160335_add_created_updated_timestamps	\N	\N	2024-05-23 10:02:32.83794+00	1
7ee6f549-00fe-434f-9cf8-7bc4e182a5f2	ff4107185d8f98b9d850e571a464bb806dade0f482984b3e29c019cb4d51397c	2024-05-23 10:02:32.288134+00	20230523084523_rename_to_score	\N	\N	2024-05-23 10:02:32.228435+00	1
29babec9-fa7a-465b-8dcc-74fd8049986a	ab80a534dfa4779eeae4ae5aeac192eea19b283671d6083c8f112e3c8a4229df	2024-05-23 10:02:32.31708+00	20230529140133_user_add_pw	\N	\N	2024-05-23 10:02:32.29601+00	1
c7918e2b-bf6a-4937-917d-b631cb2b42fc	f7c8e195215bf8a82ff89093a94aef748c209361aa05a48273f2084c49f05cd6	2024-05-23 10:02:33.170318+00	20230711104810_traces_add_index	\N	\N	2024-05-23 10:02:33.13402+00	1
563589c4-92a2-462e-a778-aa6cd8281900	f0ef0a5663ceecf04816edea38d3fe93cf07f4c8031d2b7e185ec2e5fe39f0fa	2024-05-23 10:02:32.624624+00	20230530204241_auth_api_ui	\N	\N	2024-05-23 10:02:32.32478+00	1
7b7e82ba-400b-4f51-9ea5-d7ae777e15e5	83f6a1d39c744faecc145e812f8ecca54267ac363f6315aa8afc3d890bf1f02d	2024-05-23 10:02:32.887582+00	20230706195819_add_completion_start_time	\N	\N	2024-05-23 10:02:32.86695+00	1
647f61f1-a628-4fb7-a422-7f4838dfc161	5e2e9d168251bab10d33e5f65a848c48d5f4ab762427ddd0f81e907c3339eb9a	2024-05-23 10:02:32.655997+00	20230618125818_remove_status_from_trace	\N	\N	2024-05-23 10:02:32.634352+00	1
ee839d41-916f-436c-9874-8fe9e483a719	a7808d643321e4bf3d0628b256abb7d088e964c48698af6fdd7f32969dfd41aa	2024-05-23 10:02:32.726683+00	20230620181114_restructure	\N	\N	2024-05-23 10:02:32.663205+00	1
ecb417fb-7143-4c08-a668-6d9246f25784	025c499c8b6f13676087e2e419671177a85a3ebad3a53cf84c7f70b0cfe01efe	2024-05-23 10:02:32.760197+00	20230622114254_new_oservations	\N	\N	2024-05-23 10:02:32.733479+00	1
0113c4c6-0cf3-4965-894f-a4cc13c95a79	ffbe75ad538d26b0864f8b8915115e0fbdd56fbc93a4d3a634d53488b741d403	2024-05-23 10:02:32.930099+00	20230707132314_traces_project_id_index	\N	\N	2024-05-23 10:02:32.89471+00	1
8ecf365c-add6-4161-a28c-3fa99b02fd67	4cd20328eb9aa4ce2f0fe7dab5e00c412215e2c4423902d79cdebd7b0e2325f0	2024-05-23 10:02:33.406657+00	20230720164603_migrate_tokens	\N	\N	2024-05-23 10:02:33.391339+00	1
6f9bd20e-14d8-4ef1-b218-a4ef36ac9035	362123c958d4fd06df3c816b74b4336ad2373f1505be12c84046e1364dd9dc10	2024-05-23 10:02:32.974213+00	20230707133415_user_add_email_index	\N	\N	2024-05-23 10:02:32.937169+00	1
80d0b804-425b-4b57-95f0-6f61dddd9d07	5755c1c8449e6a74016e9e7e42acc446746a3c41f21e07c317a66417fd399d94	2024-05-23 10:02:33.212559+00	20230711110517_memberships_add_userid_index	\N	\N	2024-05-23 10:02:33.176848+00	1
02f8c594-1401-467a-a845-5a6c32a465d5	e7de5bcadea82b38002ead42a8e99f532e5fe2c178ba53d5954ef2c60a0115b3	2024-05-23 10:02:33.051838+00	20230710105741_added_indices	\N	\N	2024-05-23 10:02:32.981344+00	1
b2a62bfb-687f-4ceb-95e0-98e79fd8ab43	18a5a7ffe2b0ec8c008a1336826e3e07525f42a27e981f0a778533947b09e92d	2024-05-23 10:02:33.098417+00	20230710114928_traces_add_user_id	\N	\N	2024-05-23 10:02:33.058954+00	1
5cd2f459-f885-4d5b-b345-4e3f82bd10ad	225ccf9170a395e34586c954db9c71b84f4300a07ef67e5ff116d2d08f80f37f	2024-05-23 10:02:33.327796+00	20230711112235_fix_indices	\N	\N	2024-05-23 10:02:33.219468+00	1
f67c8efc-b029-4333-887d-7464a5b2ad82	9994a7038fc3ba73d3b5e833ded5825ec58505918d6b4eca646dbfca60a899b8	2024-05-23 10:02:33.43726+00	20230720172051_tokens_non_null	\N	\N	2024-05-23 10:02:33.414559+00	1
70b40f14-3b4a-4548-a430-049d2bfcc634	502d73e77f606982c12150e119f9214a7d8116d3d4d947ea37130d6aaf9280cd	2024-05-23 10:02:33.355033+00	20230717190411_users_feature_flags	\N	\N	2024-05-23 10:02:33.334506+00	1
0b8d0a6b-f1c3-4a31-96b2-71b0a8241550	9d3edea83f7e43616f70059fd0dbe6236133ac5fcd9883ac59b298e97fcd2e68	2024-05-23 10:02:33.384355+00	20230720162550_tokens	\N	\N	2024-05-23 10:02:33.361911+00	1
7406b461-7bcf-4a31-a357-fa2234cac113	7c025190192fb785a7f3728ebab61bb167f3be07233341678c640bd31360fce5	2024-05-23 10:02:33.656196+00	20230810191452_traceid_nullable_on_observations	\N	\N	2024-05-23 10:02:33.634177+00	1
bf73367d-7a19-4fe3-9782-a7e6bc61b8d4	882b8cd48edf35b50633d13833aa0c8b92f70b707c3fc035fe0e59d2355a3a95	2024-05-23 10:02:33.467386+00	20230721111651_drop_usage_json	\N	\N	2024-05-23 10:02:33.445315+00	1
f9b9619d-b360-4d6b-9bbe-6295e5c50a63	056d2e25ef8ebb7b2b7eee99a708ab8feffa348896301c8a1a67524e3c2fddf8	2024-05-23 10:02:33.627215+00	20230809132331_add_project_id_to_observations	\N	\N	2024-05-23 10:02:33.605774+00	1
0ddf97f8-2271-439d-b83a-2fec2f5e8c3a	05604cd4b32a7e41e21a314c7e78fd1b5883a9582acb5f4308ee7053af9707d7	2024-05-23 10:02:33.571094+00	20230803093326_add_release_and_version	\N	\N	2024-05-23 10:02:33.549123+00	1
7d85e915-6d34-4774-a5f8-55b7f538a8e2	ef6d52cd7eae4e95cf21b942289d9efb69e7f60eb5d3ca281d252c54e2b77ede	2024-05-23 10:02:33.598816+00	20230809093636_remove_foreign_keys	\N	\N	2024-05-23 10:02:33.578009+00	1
0b21bb59-ced2-4dfa-8ac0-0a66146178c3	f409d263846f578bba696959b5ebfaa60a9534a407c6ad8c8fc32604ab7adfd1	2024-05-23 10:02:33.683242+00	20230810191453_project_id_not_null	\N	\N	2024-05-23 10:02:33.663056+00	1
ddf63cd7-42d4-47df-9db2-fe73f834f791	f998a3d872a1056949638870ce35fedb364d37297a784ecbcd1f95faf04a4c5c	2024-05-23 10:02:33.710767+00	20230814184705_add_viewer_membership_role	\N	\N	2024-05-23 10:02:33.689995+00	1
70dde09d-f977-4a04-b7ff-cb3a686d746b	51ccaa1ee0828dcb0cf731b019486c2f39c5b1bdd09046ab90f9ba6ec13be1af	2024-05-23 10:02:33.770875+00	20230901155252_add_pricings_table	\N	\N	2024-05-23 10:02:33.718013+00	1
7e0e3abd-30a5-42b7-9b6e-6d669f6c11d7	5b8a5e3d5880fa10be8005ca6e4d682104dae3f816e162c3db94c41753a8e1c5	2024-05-23 10:02:33.800179+00	20230901155336_add_pricing_data	\N	\N	2024-05-23 10:02:33.777715+00	1
c39a5c7d-af91-42f7-92b7-5a4fa0e19a5d	e31a4c1059dcbabbdc2ab6aecb50328bef42e809ed206485aba37c437c5cebc2	2024-05-23 10:02:33.857224+00	20230907204921_add_cron_jobs_table	\N	\N	2024-05-23 10:02:33.806852+00	1
6d2b0685-bdbc-4d83-8405-24bac9f850f2	800d6b5782b4564cfa092fd57f42ec2283537d439f167419211669aaa7df3ee2	2024-05-23 10:02:35.02979+00	20231119171940_bookmarked	\N	\N	2024-05-23 10:02:35.008768+00	1
1062ddd4-75e4-4e4f-a173-d21ed64b36ea	285bbb0b1c1ad7b8ee2d29ae7477b3f5b1b0e53fc58e9d75a287aaac715d498b	2024-05-23 10:02:33.88722+00	20230907225603_projects_updated_at	\N	\N	2024-05-23 10:02:33.864113+00	1
bca174aa-1fc6-4c87-a97a-d843f97e4748	578777f46933e33a0dc8e7c78f054c86dd0ed1413f67dc2d6334365cfda4c6bb	2024-05-23 10:02:34.538312+00	20231018130032_add_per_1000_chars_pricing	\N	\N	2024-05-23 10:02:34.516795+00	1
7dd4fa14-8b8f-4237-aaef-188f31533d91	d11aeff0b05af374c3306cdb12cc18afb7f73c5b8ce2c50757745ce5775340e2	2024-05-23 10:02:33.937159+00	20230907225604_api_keys_publishable_to_public	\N	\N	2024-05-23 10:02:33.894534+00	1
348ddafd-4ed2-4557-8ca8-7d4d42558901	378a5dd5ba691270826895506d53e8a6acc4ebba29f8226dfa0d78e698040c5e	2024-05-23 10:02:33.965687+00	20230910164603_cron_add_state	\N	\N	2024-05-23 10:02:33.94387+00	1
4bc01232-0997-4acb-b251-bcdf75484cac	00cea39de0d75e817cfadcd95f852d4a84e00c1f67930d518ae4d452c93ac177	2024-05-23 10:02:34.844514+00	20231110012457_observation_created_at	\N	\N	2024-05-23 10:02:34.82387+00	1
6a3435a1-2ef1-4989-90c9-523ecd33d3eb	d4af17aef307dba854b4b896df6f998cef8ac211fb792b7e90c7fe6fa4a9e4c3	2024-05-23 10:02:33.995003+00	20230912115644_add_trace_public_bool	\N	\N	2024-05-23 10:02:33.972698+00	1
ebecc8b9-1d95-49f5-ac76-362bde4d55ed	c087cf267a4c8b52ec4cebf0612b840d2136475e4776e9206778830256ce3f32	2024-05-23 10:02:34.6387+00	20231019094815_add_additional_secret_key_column	\N	\N	2024-05-23 10:02:34.545661+00	1
7d45986d-db50-4070-9430-8d695dae0f3b	2026ed8d4e73d7d09741dbedf1fe73233e624f3e7f81b2a2b9243f415168ebb2	2024-05-23 10:02:34.053623+00	20230918180320_add_indices	\N	\N	2024-05-23 10:02:34.00172+00	1
9f3e1b44-d67a-46e4-b516-e1251341b3ed	6bfdc95391ba091dc9d96899dbe7f967814cf42eb6388b664d9d76d8982add70	2024-05-23 10:02:34.096953+00	20230922030325_add_observation_index	\N	\N	2024-05-23 10:02:34.060688+00	1
660f4e0a-a2d4-4268-bf22-ee22987b0d87	ea9794f2d79f49b88ab95b90335fe97cd7ccc3d7f1dd156259a5e5aa1c107043	2024-05-23 10:02:34.253757+00	20230924232619_datasets_init	\N	\N	2024-05-23 10:02:34.103999+00	1
d56421ba-7c8e-416b-a4c8-e28346b6d85c	44810e0e19455ef071bec618d10951ba956e7a112631eb3f4c313fe903db7267	2024-05-23 10:02:34.660627+00	20231021182825_user_emails_all_lowercase	\N	\N	2024-05-23 10:02:34.6456+00	1
b7c12b4f-b788-41e0-af5b-51b8c110c9a0	6db5841932092efa895afe4c027079a9c48ae252181c8e0c3985c6d08f96ba8a	2024-05-23 10:02:34.312791+00	20230924232620_datasets_continued	\N	\N	2024-05-23 10:02:34.260738+00	1
793f6b73-7e1a-41b6-9fac-6cc7f79327e8	e8f8302423f78da25f0349a5da4083160f574c98ccc2b3e28f91d16cfa1ad499	2024-05-23 10:02:34.353936+00	20231004005909_add_parent_observation_id_index	\N	\N	2024-05-23 10:02:34.319527+00	1
f491ffbc-0352-4df2-89db-5964e2c49d0c	8f1b13112f4627c886c705d33920578b19fea917471b7367191300eebef544fc	2024-05-23 10:02:34.394871+00	20231005064433_add_release_index	\N	\N	2024-05-23 10:02:34.360723+00	1
f35052e1-9548-45df-8a22-75e0b21793d2	6456651794d1f7215c7f39238725764948ce71b7df386639d2d4f58da2e93335	2024-05-23 10:02:34.688891+00	20231025153548_add_headers_to_events	\N	\N	2024-05-23 10:02:34.6675+00	1
f13c3810-fd9b-40ec-932b-961bb1c7919b	dfeb488d9be2f37c669211d8fee91cc67d384eee1532512a00328195fd259e27	2024-05-23 10:02:34.425214+00	20231009095917_add_ondelete_cascade	\N	\N	2024-05-23 10:02:34.401382+00	1
62eae7ea-eaa8-453d-9e47-9d333830ace7	e08e3d28e1b13a6df4f7eb43bd81d427f86792a9235dfa123db11b67343c1d82	2024-05-23 10:02:34.482767+00	20231012161041_add_events_table	\N	\N	2024-05-23 10:02:34.431987+00	1
c7b18ee7-0a2d-4c10-9568-9a0a5438eb65	1074f270d9b48baa51d22c0c90218cdc47dc3338a5f0ea90bd72ef5ea5e2cf88	2024-05-23 10:02:34.890107+00	20231110012829_observation_created_at_index	\N	\N	2024-05-23 10:02:34.851565+00	1
06a1219f-925b-424f-816a-10835b56d94a	52d73a2c8f5927da07492f83ffc94ce4a3cdc93232be0291d0faf77bc5ba8eed	2024-05-23 10:02:34.509879+00	20231014131841_users_add_admin_flag	\N	\N	2024-05-23 10:02:34.489515+00	1
1d5606d5-c3e3-4310-872b-1fbdedbe1118	cc2235e89e6815af4002bd4aa6941e16dd452efe9dc5d59ac0c390589160a7ac	2024-05-23 10:02:34.731439+00	20231030184329_events_add_index_on_projectid	\N	\N	2024-05-23 10:02:34.695566+00	1
f7077264-0722-4387-8457-675c35402d28	f5ef1377c36e5301cf312bb60c6bb647bdb3de2db1d847003b4cfd3e24ca9ccc	2024-05-23 10:02:34.759739+00	20231104004529_scores_add_index	\N	\N	2024-05-23 10:02:34.738377+00	1
fdc4f60c-7049-40b6-acd8-3ed78811790f	9f5a355bf0c6c5fa36b37c898b338a234d43efa01d387eca439a95d674721ca2	2024-05-23 10:02:35.441299+00	20231230151856_add_prompt_table	\N	\N	2024-05-23 10:02:35.356784+00	1
8721b6da-8e5d-4a34-93e3-7bdcee390398	2f634dc6a7e272e3715472968da531e23c9dda562d5d137e6bfe7195d51761ab	2024-05-23 10:02:34.78938+00	20231104005403_fkey_indicies	\N	\N	2024-05-23 10:02:34.766881+00	1
00fbc0ed-5ce0-436c-9893-27abd108f735	3920714d62de04345531777f14fe9a02b8982890c93f0b57512c0ab55755ee79	2024-05-23 10:02:34.932242+00	20231112095703_observations_add_unique_constraint	\N	\N	2024-05-23 10:02:34.89713+00	1
c3d24603-1d0e-4939-97c6-1aa3c40c9a8b	85bf236e16abc39747ea773383c06cd06208e2d147237beb0b20b48318397e7e	2024-05-23 10:02:34.816849+00	20231106213824_add_openai_models	\N	\N	2024-05-23 10:02:34.796288+00	1
fa211767-4fc6-491d-8388-092f37025e09	0be96056b9709a8b7899d555e228d5c0098f1e6b358c6e016bb3843b7846b3f6	2024-05-23 10:02:35.135488+00	20231129013314_invites	\N	\N	2024-05-23 10:02:35.036449+00	1
da37e5c5-cabe-4951-b11a-251508a4df1e	5881fcf2e0d44375b52e6228413774f3154ab9fab3492f8ff24a24c2f044033b	2024-05-23 10:02:34.973883+00	20231116005353_scores_unique_id_projectid	\N	\N	2024-05-23 10:02:34.939006+00	1
a6f0de6a-290a-4639-b10b-133b6ec12e5a	8fee27ef5b07ba63a31cf88aee365f6f9c66b8cb5a08492b7f19c2a1eef249e4	2024-05-23 10:02:35.001779+00	20231119171939_cron_add_job_started_at	\N	\N	2024-05-23 10:02:34.980483+00	1
4074ad12-71a8-4d10-90bf-f96bd6771e97	1b774d2ddbe9ae0f7cf8b60beaef0d27a6f5e8b09840e342ffd85c63c5de517d	2024-05-23 10:02:35.319451+00	20231223230007_cloud_config	\N	\N	2024-05-23 10:02:35.298035+00	1
47cc9bb4-4856-46c2-b0b5-9aecd3638425	401f5230ee1dccb765509321e8075652e71ae4ec28f5648a6b2ee151fc58d90b	2024-05-23 10:02:35.254451+00	20231130003317_trace_session_input_output	\N	\N	2024-05-23 10:02:35.142417+00	1
e3080c46-f0a1-4133-a219-0251646cab9a	f73f71a1a394677fb4ddd00cfe2238c40190f875525473d9ebf80f15fc89a2e7	2024-05-23 10:02:35.29108+00	20231204223505_add_unit_to_observations	\N	\N	2024-05-23 10:02:35.270126+00	1
35f84d20-956c-4158-9d84-e81bd88f47f9	14911fffc711830a28304af98b2c9fe31f5f78fb568281090a75f4f7958ba942	2024-05-23 10:02:35.349304+00	20231223230008_accounts_add_cols_azure_ad_auth	\N	\N	2024-05-23 10:02:35.326646+00	1
ca5cff8b-be2c-4862-be93-f3299e162629	9f7ef155730980f10cf9c84fdcce91b80822a8ff1d7d35720b544f851397a0e5	2024-05-23 10:02:35.528315+00	20240104210051_add_model_indices	\N	\N	2024-05-23 10:02:35.477184+00	1
290ed240-3741-4889-a514-2a56b1401f3f	7919b5dfcacec288b646f23c83f6adbf5f69eba50d2de4a35eb2b9d3029e4729	2024-05-23 10:02:35.470334+00	20240103135918_add_pricings	\N	\N	2024-05-23 10:02:35.448223+00	1
acd19c5c-2eb2-47b5-aeeb-8a1179a58588	ed03d628f2755b0b16963a8d20b72440588a7ed57a4f1652d9b128e5dcfbf1b3	2024-05-23 10:02:35.585781+00	20240104210052_add_model_indices_pricing	\N	\N	2024-05-23 10:02:35.535402+00	1
e39d1263-4a93-4c9d-9179-d75bc4a0ef44	08918b17989f2bd0e36f80c5255042f807afe428186c68cf334fa01953153807	2024-05-23 10:02:35.614555+00	20240105010215_add_tags_in_traces	\N	\N	2024-05-23 10:02:35.592999+00	1
5d0b9e9a-13ba-489b-bc2f-6941a41c9ad3	18fba86141a537df2fdf6bc8b8d8cd1abcdef25ca0dca43d1983fb23dac4db72	2024-05-23 10:02:35.643656+00	20240105170551_index_tags_in_traces	\N	\N	2024-05-23 10:02:35.621594+00	1
96e447e9-7222-425c-b065-51faf39d6ee1	de4c1bc9e76dc2ad02e5cedc68bc20450c80307c64123469b925b1ba1787449c	2024-05-23 10:02:35.672769+00	20240106195340_drop_dataset_status	\N	\N	2024-05-23 10:02:35.650854+00	1
ddde6a2c-c2a1-46de-97cb-30db34660e8d	795187b23b16aceb796a10b5a43327cd3f767a0048f7ae8cb4d209695e49f18d	2024-05-23 10:02:36.471528+00	20240215234937_fix_observations_view	\N	\N	2024-05-23 10:02:36.446732+00	1
f05fabd6-ac80-433f-971a-79c78aa17c56	9d7148c925f6643b17c1aad933fce92bdcbc8fa2304eb97be11c0aa32747664a	2024-05-23 10:02:35.700872+00	20240111152124_add_gpt_35_pricing	\N	\N	2024-05-23 10:02:35.679674+00	1
7325f66b-e512-4346-bc9a-76c72f7493f0	fcbff614561f2c09501be18aad566624e04bf390aef8c072596ac2b793d10cb7	2024-05-23 10:02:36.149656+00	20240130100110_usage_unit_nullable	\N	\N	2024-05-23 10:02:36.128788+00	1
96b07570-d347-4c14-a845-2dc193addf3e	9496ee3af1202cb3f9d6f0d4bb88c521e0e796a04bc8e02622718a63ba79b710	2024-05-23 10:02:35.731189+00	20240117151938_traces_remove_unique_id_external	\N	\N	2024-05-23 10:02:35.708303+00	1
e42f92f6-7df8-40d5-8cf6-237e92d9119c	c5919ee7870f36a7555024eb2256b3a28c8d978032dcd943047e5cff27a86cba	2024-05-23 10:02:35.759317+00	20240117165747_add_cost_to_observations	\N	\N	2024-05-23 10:02:35.738158+00	1
a7ee9160-20bc-4b5c-ba72-b2bea9f5d65a	ad8869aea6b98159c54bd3f2fcfb4ee1114ba54a7bf5726378dc2edd6f8077eb	2024-05-23 10:02:35.81773+00	20240118204639_add_models_table	\N	\N	2024-05-23 10:02:35.766208+00	1
2490afd2-5068-4ede-93c4-82d4ac61468c	c301dfa0db4367a4691bf520cb0c0b377b10e2ef4ca66f39f818284b23d0cfa2	2024-05-23 10:02:36.177037+00	20240130160110_claude_models	\N	\N	2024-05-23 10:02:36.156643+00	1
7fdc0e3b-535f-465b-abb3-1727b997f6b1	7211b935cb3f52c11c7ebd0ac540bbbd01bb2010e51ad412d2956645c02724b7	2024-05-23 10:02:35.845587+00	20240118204936_add_internal_model	\N	\N	2024-05-23 10:02:35.824701+00	1
c6f9a836-b645-41eb-896a-3412a0f111c3	b79f2ca2011baa6604eec15e549996af3a10e396b706aff73b6ca36c08291d99	2024-05-23 10:02:35.876621+00	20240118204937_add_observations_view	\N	\N	2024-05-23 10:02:35.852388+00	1
a5fbd69a-f471-4871-b152-9c2e8b28f085	2ab605d386e52af31b6328f5542d63ec6a6b19db9bda8f2e4888a7de7154b2ae	2024-05-23 10:02:37.039125+00	20240304123642_traces_view_improvement	\N	\N	2024-05-23 10:02:37.016446+00	1
486e724c-1c6e-4d0b-a01b-e0448b941b06	2c075714bdce7df89f328062021733fd62880ff7cdb91a1d0a7aab2659a89d06	2024-05-23 10:02:35.934049+00	20240118235424_add_index_to_models	\N	\N	2024-05-23 10:02:35.883814+00	1
26804858-0b0a-4b88-939b-b137581b8b11	af31e8b4be701e97ccf87d4692055d2cc7ece9d74cc424e05dfb2775de5a7efe	2024-05-23 10:02:36.205008+00	20240131184148_add_finetuned_and_vertex_models	\N	\N	2024-05-23 10:02:36.184002+00	1
9b774f66-38c3-495b-b690-8bb781e95f45	c76d5a31377660ce77e890a918ffa07bd2db8c8c94b04753befbc27d152492ea	2024-05-23 10:02:35.962473+00	20240119140941_add_tokenizer_id	\N	\N	2024-05-23 10:02:35.9412+00	1
d6fdd23d-138d-40bf-a269-5e48db094a70	08f7d11bd5deec873669ca10101dd0a05669bb04eb300ef0ee7b6d3517ae0c24	2024-05-23 10:02:35.991906+00	20240119164147_make_model_params_nullable	\N	\N	2024-05-23 10:02:35.969694+00	1
b027bcde-712b-4cac-851a-32be0effd9d2	540712b04f0fbaf449eaf229210e04dec83280878842c7c3d9956e4ff98334ce	2024-05-23 10:02:36.499614+00	20240219162415_add_prompt_config	\N	\N	2024-05-23 10:02:36.478608+00	1
fdc5f822-7fe6-4dd1-936f-028be0d10dd1	3b0d3c46459cc2770d6e8d9db6fc139f859792da5b89937114dd09b17dac0dd4	2024-05-23 10:02:36.02132+00	20240119164148_add_models	\N	\N	2024-05-23 10:02:35.999026+00	1
5753d187-bf42-4771-8b2c-b2f04f1336c9	3bc4965e82cd4645da383ef6f6582a7efd7f5bf27e912af1efe18ff62e014db1	2024-05-23 10:02:36.233419+00	20240203184148_update_pricing	\N	\N	2024-05-23 10:02:36.211853+00	1
b2348589-8c2f-4f53-8d6c-0d795a49c989	73f7212daa54130c6fa91fc17d840262ec948b11aafce49ea3e8ce7d4f3cbef1	2024-05-23 10:02:36.066482+00	20240124140443_session_composite_key	\N	\N	2024-05-23 10:02:36.028311+00	1
a9f00b09-4171-45ad-ad1e-622b3d703aa1	4ec1ad8229c185a7afaa62357879a60d4f59b35a103975030ce43d67823096c9	2024-05-23 10:02:36.093792+00	20240124164148_correct_models	\N	\N	2024-05-23 10:02:36.073447+00	1
a7424fef-18fb-4858-9110-f1346f8ea0e6	546c704d2869f4d382fb591fd20b14c489e99fffaa5655c45a3a86e7a7d488c5	2024-05-23 10:02:36.122171+00	20240126184148_new_models copy	\N	\N	2024-05-23 10:02:36.100572+00	1
5bd55d4f-bbef-4163-8107-fa8543f8dbbb	3e0cc893b4ec41ef43740af577aef359e2c742c338c8fc5421f766d75cce1292	2024-05-23 10:02:36.322684+00	20240212175433_add_audit_log_table	\N	\N	2024-05-23 10:02:36.240391+00	1
12de11a3-e685-4ba2-97b2-d764ccd498b7	f2af6a57ddd2aab8adeaa5a3c6571cd8ab8538b071fb01e07c35d277203ae6b8	2024-05-23 10:02:36.80787+00	20240226202041_add_observations_trace_id_project_id_type_start_time_idx	\N	\N	2024-05-23 10:02:36.742767+00	1
ca46696e-0403-4641-b002-04cee983a92f	4a1b6917569327219e620f0cca78446c360958d5a91226b7f60bd4626ffb38d0	2024-05-23 10:02:36.351301+00	20240213124148_update_openai_pricing	\N	\N	2024-05-23 10:02:36.32958+00	1
1730b269-933b-476f-8fd4-fc659aaadb98	909cae9daaf399b3ab6e9c03142fa4b80d7b09f44165944b9a09007d829d6f28	2024-05-23 10:02:36.557075+00	20240226165118_add_observations_index	\N	\N	2024-05-23 10:02:36.506844+00	1
54995b8b-9a91-4cb5-b002-7bd541ee4606	a942356a983650fb3aa2974690956869324993c3a546ea83d3ae26d2a98db7c1	2024-05-23 10:02:36.410692+00	20240214232619_prompts_add_indicies	\N	\N	2024-05-23 10:02:36.358917+00	1
00332acc-58e5-4f3c-bf26-3a31a3edbf3d	00a42d4d8bd4090cf94d90eeb82fe803d23d802dcdb6c058b2371a75d951519a	2024-05-23 10:02:36.439779+00	20240215224148_update_openai_pricing	\N	\N	2024-05-23 10:02:36.418361+00	1
245c3ce3-189a-4ae5-9ec4-335f8cb51162	d498837088f8de279f4c04655af668c34f3febd961c95390a0441cb0ee0a3db6	2024-05-23 10:02:36.943006+00	20240228103642_observations_view_cte	\N	\N	2024-05-23 10:02:36.914889+00	1
fa7dc42e-cdb5-4031-88f3-b25f5e945b7f	58e1bb0a84cb20a36c750b9d13c1371e44cd1a4947d5bdb37754a23d664c5e33	2024-05-23 10:02:36.614773+00	20240226182815_add_model_index	\N	\N	2024-05-23 10:02:36.563841+00	1
93ce317c-4b91-48ff-809c-381bd7276b0d	e31ee1ec510ded08a1813273056149bfe345651ce02d9ab31883dde10e390afe	2024-05-23 10:02:36.843547+00	20240226203642_rewrite_observations_view	\N	\N	2024-05-23 10:02:36.816415+00	1
e44ee185-b4f3-4a58-857d-39566aa302df	2cb0786da90de9c0a6e2983075362c76163e0635f9d347da0686b9c0434b8f0f	2024-05-23 10:02:36.674797+00	20240226183642_add_observations_index	\N	\N	2024-05-23 10:02:36.621996+00	1
febe5943-0e64-451d-b116-3964918f2760	e733981599148cbb086a4eb4e7276fac2059ce3b60b3acf1443c3ec648f1d233	2024-05-23 10:02:36.735069+00	20240226202040_add_observations_trace_id_project_id_start_time_idx	\N	\N	2024-05-23 10:02:36.6821+00	1
c6d50c3f-1a24-459d-99dc-f9a7abc05ac6	5603e17abf74b6c9e4191ff261e56e63641a90c5e04d99c5f04be174d1a90d76	2024-05-23 10:02:36.906818+00	20240227112101_index_prompt_id_in_observations	\N	\N	2024-05-23 10:02:36.851626+00	1
ae0a5a12-7100-4549-ab29-cb33e02b21d0	83902ab9281b0b9b7257768518cbfb6895d382f30e6594b2058507d173bfa519	2024-05-23 10:02:37.009615+00	20240304123642_traces_view	\N	\N	2024-05-23 10:02:36.984711+00	1
0766f740-d07a-4110-973a-6cf547a622d8	96e0223ba9bb5ec06dc4c53988451298d6cf9df6b83da89262280ceb3c203d59	2024-05-23 10:02:36.976925+00	20240228123642_observations_view_fix	\N	\N	2024-05-23 10:02:36.950958+00	1
f8cdd45b-8935-4870-be4c-774a887786aa	b9abacb6b7858085eff8230a9950eaffe2e557c67981592097a2b93204b3c5ec	2024-05-23 10:02:37.098182+00	20240304222519_scores_add_index	\N	\N	2024-05-23 10:02:37.046752+00	1
8a54c6b1-c1e0-4d1f-9d94-486d07ff2a8a	f8e14cfb18416f04c49e67c2e9c97675b1d01a1a60a549d784cfbcd52f308771	2024-05-23 10:02:37.157504+00	20240305095119_add_observations_index	\N	\N	2024-05-23 10:02:37.10508+00	1
8154687d-b2fc-4ac5-94cb-0cc5695fd0d4	498c50087ca98fffe98b041b77c8ef195888e35e607b3c0d64643d9275e83935	2024-05-23 10:02:37.214775+00	20240305100713_traces_add_index	\N	\N	2024-05-23 10:02:37.164529+00	1
da6a13cd-29db-4d63-8772-4beb015b0098	89a9d0e9dd25662dd684333947df23ea4165a4adec9995e281b33fecdd60b775	2024-05-23 10:02:37.247313+00	20240307090110_claude_model_three	\N	\N	2024-05-23 10:02:37.222376+00	1
c7ea0130-1d3f-4430-b2cb-a56d2bd7be43	7a8d3f1cb3ce402ca6de3b8af2f9f402770d7bb1b9a0ba740dd691b5e88feb1f	2024-05-23 10:02:37.278427+00	20240307185543_score_add_source_nullable	\N	\N	2024-05-23 10:02:37.2543+00	1
e388a779-084e-4fcc-b737-6fe20b062bcb	cbf36bf3115f7c66934d46e7d8f4a21c7465f9d00569d619b7382028ee422eb3	2024-05-23 10:02:37.716843+00	20240404210315_dataset_add_descriptions	\N	\N	2024-05-23 10:02:37.694251+00	1
94573e1b-2e5a-4fdc-90c1-4881ee6093a4	b9c551f91d345926b3c740563aecff3904717185b84dcdf74c0b2521ffa2cb63	2024-05-23 10:02:37.335521+00	20240307185544_score_add_name_index	\N	\N	2024-05-23 10:02:37.285668+00	1
373e54e5-1aba-44d6-b9c0-75d2fc1310fc	0cec970448bd9ff3a78acdcce5519f9c2154378ccc3a3acbd79266478f66238e	2024-05-23 10:02:37.357728+00	20240307185725_backfill_score_source	\N	\N	2024-05-23 10:02:37.342766+00	1
b97e1aeb-dd1f-4625-8c4a-d80d9cf8c88b	c8ea9587bcf109835eb4b8cb882e121c35624d5e9f90e21886de3b7ee5793312	2024-05-23 10:02:38.692866+00	20240424150909_add_job_execution_index	\N	\N	2024-05-23 10:02:38.6556+00	1
d3050e99-7905-4165-9607-0f4a02ae83af	1a476db15f8f2a6becbde3c804623832542a9d2dc1233389e9b4d1c9047a5b43	2024-05-23 10:02:37.388003+00	20240312195727_score_source_drop_default	\N	\N	2024-05-23 10:02:37.365004+00	1
78048d24-4c26-4536-8865-6d76250ee2c0	b5d68c44ed85196b038921cde3faf6241050b76781a9d93981346165436c6ed7	2024-05-23 10:02:37.739011+00	20240404232317_dataset_items_backfill_source_trace_id	\N	\N	2024-05-23 10:02:37.724322+00	1
8a9e9816-da90-406a-816d-b3be5420eff1	137f83659a950bdc6497c2030f61bd070264ee14387f3e11143f55ae2c3d810e	2024-05-23 10:02:37.417721+00	20240314090110_claude_model	\N	\N	2024-05-23 10:02:37.394905+00	1
16eba9d1-ce70-4213-8b8d-a4ccec26d263	9e7f1d6a2d8e12037a931e8d8c86e552366e8056d2a9adb847f84da5c6972398	2024-05-23 10:02:37.447151+00	20240325211959_remove_example_table	\N	\N	2024-05-23 10:02:37.425121+00	1
a7414ea3-1345-4fa9-86c2-7a51df12d995	e0d84647251c69f99883c12c21eb9cbad9f0fc1059b58cce3296edeebdc1b8dc	2024-05-23 10:02:38.248768+00	20240414203636_ee_add_sso_configs	\N	\N	2024-05-23 10:02:38.192441+00	1
b76bd83d-529b-4975-9eb3-0585c2847179	48d049e8d66ed3f4b0336d857ae4bfeb7f39dd9ee1070fbe4bede32630478e7b	2024-05-23 10:02:37.475826+00	20240325212245_dataset_runs_add_metadata	\N	\N	2024-05-23 10:02:37.454507+00	1
9ebf65f6-547b-41c9-9ee1-fea2b86b75bc	82c21f5f2399c1173c734d8a157b4b0dac6821cbbc36dce8ba058caf40681ff7	2024-05-23 10:02:37.767402+00	20240405124810_prompt_to_json	\N	\N	2024-05-23 10:02:37.74589+00	1
b391ce7f-7ea5-44da-bdb3-79c748381977	3fa446eb946ec9e8f56c4665e02aea106727c4058acd89dd758900273a2183d8	2024-05-23 10:02:37.506871+00	20240326114211_dataset_run_item_bind_to_trace	\N	\N	2024-05-23 10:02:37.482922+00	1
55c30104-661f-44c6-8268-660ac14e0e58	f6efc777385ff3f04b4c93745d7a66fe953a4fb4544203ad22808b80468f3578	2024-05-23 10:02:37.529205+00	20240326114337_dataset_run_item_backfill_trace_id	\N	\N	2024-05-23 10:02:37.51426+00	1
70483de0-a796-4785-8de9-b928b39c835f	7c084b86913a91f9b8658084f6b8f6526bce2d0de4842c8f68e07f30f1f46fe9	2024-05-23 10:02:37.558042+00	20240326115136_dataset_run_item_traceid_non_null	\N	\N	2024-05-23 10:02:37.536118+00	1
da715d20-739a-4dff-8256-64019ab90a82	206607c9c910399b23bb8217092e4b17fd428f2890efb49f1ad65dceaa55f3d1	2024-05-23 10:02:38.003408+00	20240408133037_add_objects_for_evals	\N	\N	2024-05-23 10:02:37.774107+00	1
b29e4aa7-5967-4da8-b00e-6f1a1daf41c5	afe59690f207d0f4481d9a54af3e743622a88a68ad46d4eb2597c2b7a953fc66	2024-05-23 10:02:37.625309+00	20240326115424_dataset_run_item_index_trace	\N	\N	2024-05-23 10:02:37.574388+00	1
8933c8e9-85ef-4338-b7b3-8b16cae4aed7	10e5a3983b46239bbb0b6ad8617901df3c7eaa53df0b879577528d7e14d84d91	2024-05-23 10:02:37.65452+00	20240328065738_dataset_item_input_nullable	\N	\N	2024-05-23 10:02:37.632262+00	1
e566ad29-f345-4ac3-be9b-028633748b60	b01064942f09a3e944a7db83a680ba04e135b6aee91569445ba295a2ce443f74	2024-05-23 10:02:38.503999+00	20240420134232_posthog_integration_created_at	\N	\N	2024-05-23 10:02:38.48236+00	1
96e19392-9c93-4dec-ac01-efd6b5d4c2ad	04c22689adda42b47ce94563fc3e834507c8b214a20ae1d379b2cfa9ed4e6d73	2024-05-23 10:02:37.686397+00	20240404203640_dataset_item_source_trace_id	\N	\N	2024-05-23 10:02:37.66167+00	1
9f2d9468-a65a-4f5e-bdc3-e4b61af7bad0	dcd8dcb804ab5eeb3cc813b88ea510578a6b481e5756628b0fa7d061d9aa79a5	2024-05-23 10:02:38.30764+00	20240415235737_index_models_model_name	\N	\N	2024-05-23 10:02:38.255917+00	1
f8393476-7e18-4d48-a7c4-9ee677648342	b9711c48f8a9d20c8705c31f1a2bd4a4e1e3473e7de6f884ced0776773dea897	2024-05-23 10:02:38.033957+00	20240408134328_prompt_table_add_tags	\N	\N	2024-05-23 10:02:38.010468+00	1
3b49990a-db38-4328-a157-ad3cd4e78239	017eaef133c6ad53c86e655daf6ef310f5e8870d197b32b91b22feea8589c20d	2024-05-23 10:02:38.077469+00	20240408134330_prompt_table_add_index_to_tags	\N	\N	2024-05-23 10:02:38.041056+00	1
b31c06f4-f39b-47f1-a24d-b817ab436a5b	5b74cc3719cc73c4a9561521df9593a0b72b7f71a7edc6fc962259855d1b4597	2024-05-23 10:02:38.121908+00	20240411134330_model_updates	\N	\N	2024-05-23 10:02:38.088109+00	1
06111a38-8e80-47dc-a5bd-4aec0be9b493	20f9110c61428813f2d32bff079f64fe35ee3dbb6eb40241c24885ca87e44226	2024-05-23 10:02:38.367352+00	20240416173813_add_internal_model_index	\N	\N	2024-05-23 10:02:38.314967+00	1
444a7539-6a32-43c5-95bb-7e13ce347bd3	86412f0fd3a38ecf7aba62d2df6bc63f21d8545c6846e7ad450f1ba1054ec0ef	2024-05-23 10:02:38.155755+00	20240411194142_update_job_config_status	\N	\N	2024-05-23 10:02:38.133183+00	1
f2bc9a69-a564-4d7f-a944-58016b747346	0f44dce07307ae9364e93449837fe6fc6189780dd94b7d506f8c2f653423b42a	2024-05-23 10:02:38.184965+00	20240411224142_update_models	\N	\N	2024-05-23 10:02:38.163008+00	1
e3447207-4ba9-48ab-bdfd-a969eafdb811	e79db3e95ce362750535a772337f79cd94bc37890e58ce3c05aa0253afe1d1d6	2024-05-23 10:02:38.397565+00	20240417102742_metadata_on_dataset_and_dataset_item	\N	\N	2024-05-23 10:02:38.374951+00	1
3d355aef-0cb0-47fd-aac0-4a9a0bbfc338	b5153e69a337304509d94116fc42eac4ae838617041d473e361627e99d78eaeb	2024-05-23 10:02:38.533239+00	20240423174013_update_models	\N	\N	2024-05-23 10:02:38.511329+00	1
cacd3f52-8a93-44ca-b7c4-b9a6c94771ed	d53f2ddcfda91be76c40f87c0ebdeee510cf7316e6ce8578e16a3a068daf0bd5	2024-05-23 10:02:38.475315+00	20240419152924_posthog_integration_settings	\N	\N	2024-05-23 10:02:38.404769+00	1
40a478c7-05b4-47b6-b527-3ddd8cb44af5	a15e5ed199ff9e77ad2ab1920262094a07c63c5bf639929e7912e3ec5b6f1da0	2024-05-23 10:02:38.833804+00	20240503130335_traces_index_created_at	\N	\N	2024-05-23 10:02:38.78066+00	1
ad4de9cd-df31-4e6d-864c-6200d5ed21a0	0a6f2078af2b92a1d61d36449f3646fb8adda99acb6ee214451b8c2a7a62c36c	2024-05-23 10:02:38.647908+00	20240423192655_add_llm_api_keys	\N	\N	2024-05-23 10:02:38.541259+00	1
52cfd248-950d-44d8-bf3d-edccebd53277	6c5083ecdb222c9a4566fac6a4364a349351e868bb68eff17a7c8c48bacf39c1	2024-05-23 10:02:38.773314+00	20240503125742_traces_add_createdat_updatedat	\N	\N	2024-05-23 10:02:38.750692+00	1
62967d3f-b3d3-4c0d-863a-6e0777ef950d	a2ff78bbd0982e80edcc312bb686a9d33f4bde7e675d0915ba570aff2931307d	2024-05-23 10:02:38.721767+00	20240429124411_add_prompt_version_labels	\N	\N	2024-05-23 10:02:38.699727+00	1
9b7309ab-b0a6-4a42-a8b0-76e6b79801a3	caf1f29f946abe2c7774657473a274866a1bab1a4d4b368bac32154c263aba22	2024-05-23 10:02:38.742932+00	20240429194411_add_latest_prompt_tag	\N	\N	2024-05-23 10:02:38.728496+00	1
79656556-9c0e-4922-8223-09d7c793fd3a	6d3ba16762dc0033c95dabd79ef2ac122e8416c7ec5cd15ef761057837b19c92	2024-05-23 10:02:38.892064+00	20240503130520_traces_index_updated_at	\N	\N	2024-05-23 10:02:38.840971+00	1
04bb0ce5-8527-42df-98f6-d0e99bdd024b	86eaf205ba5fd2130957536777d0aa00c8d15cdc2af896ea5b45ed5f26d690b6	2024-05-23 10:02:38.920108+00	20240508132621_scores_add_project_id	\N	\N	2024-05-23 10:02:38.899214+00	1
47c8b4e6-39f4-419c-8bfa-220a575d4766	644c6246091a13e8e908733347ffd699789d448bb3c80207e53b32223667a292	2024-05-23 10:02:38.978474+00	20240508132735_scores_add_projectid_index	\N	\N	2024-05-23 10:02:38.926935+00	1
3a8a52b2-ddaf-4107-ad0b-77a420b189b6	c1e8301b3c0ad83f46731fa6398565faa586ee89b5dc4ff22a2289a9f7c21d8e	2024-05-23 10:02:39.000765+00	20240508132736_scores_backfill_project_id	\N	\N	2024-05-23 10:02:38.985822+00	1
db48dd3f-24e2-44aa-9587-b907a5423c00	3425cdbd747937bbb512b560a2b8132462d0412191a695e27dc9ae268f3d40f2	2024-05-23 10:02:39.030307+00	20240512151529_rename_memberships_to_project_memberships	\N	\N	2024-05-23 10:02:39.007893+00	1
c03ea5ca-d4db-4dd1-acdd-46fb23a14eeb	d010f310671b164935b005b7949c29a46a2f14117e14060702f239cf3bb081cb	2024-05-23 10:02:39.245208+00	20240512155020_rename_enum_membership_role_to_project_role	\N	\N	2024-05-23 10:02:39.037359+00	1
b2c76c41-263f-41d8-81f2-7d38532b7b58	a398b1ccdba2791a4646955f37522df929dd0e0a2d01603a068f70e096d2f53a	2024-05-23 10:02:39.272989+00	20240512155021_add_pricing_gpt4o	\N	\N	2024-05-23 10:02:39.252241+00	1
43832a98-6ee6-4648-8545-7304d53a2d1e	f9750ea80adc2a175c4455a32779c5a607d741b71ca8354a18d9e8273b70b9a0	2024-05-23 10:02:39.300995+00	20240512155021_scores_drop_fk_on_traces_and_observations	\N	\N	2024-05-23 10:02:39.279882+00	1
6f12ab48-c823-4c19-a63d-57515867b4e4	18525089d536b836d81e02dab68588e4fe2bf3d0a09e4c349d60db9bbed0cd49	2024-05-23 10:02:39.329067+00	20240512155022_scores_non_null_and_add_fk_project_id	\N	\N	2024-05-23 10:02:39.3079+00	1
734b0d2a-b933-4692-b541-646ad5cbecd4	6f038363d06b8fe9ad5e5ffdebec33d4cde3591c65fe46175a4a821736637482	2024-05-23 10:02:39.357439+00	20240513082203_scores_unique_id_and_projectid_instead_of_id_and_traceid	\N	\N	2024-05-23 10:02:39.336059+00	1
3f65b03f-e9dd-42df-afb3-4e74c45bffea	e39e28c4337fa35ab175c703d6ceda8a2d4b78d2bc616200201faff350c61455	2024-05-23 10:02:39.413385+00	20240513082204_scores_unique_id_and_projectid_instead_of_id_and_traceid_index	\N	\N	2024-05-23 10:02:39.363849+00	1
e72ba0cd-0dae-40fd-8642-2a0b0babb1ec	b8c134bdcba9a016d8ac79927a0d736c67c5bbf109ec584a15b0f6c38f50dc8d	2024-05-23 10:02:39.442529+00	20240513082205_observations_view_add_time_to_first_token	\N	\N	2024-05-23 10:02:39.4199+00	1
476a0a91-8ed8-4e30-ba66-dd7730c9cf94	c418394abc6167c883f1456639e995ab5054a8257e8dba37b7a95c76ba59af0c	2024-05-22 12:38:39.065991+00	20230710200816_scores_add_comment	\N	\N	2024-05-22 12:38:39.048624+00	1
967cb93c-4257-4925-beb0-336f825fcd7d	45fc679b7dbbe0f2954623bfe4e29932374cdc3167f8395728ef5c20115e5665	2024-05-22 12:38:38.047661+00	20230518191501_init	\N	\N	2024-05-22 12:38:37.850849+00	1
3152753e-a36e-481a-af65-ebb3c82bd8f7	6462cebefe054956e2fa9948435590bd4dae0d58f75cf2ecba57059f2c0909f8	2024-05-22 12:38:38.774513+00	20230623172401_observation_add_level_and_status_message	\N	\N	2024-05-22 12:38:38.754812+00	1
7b69d6e0-2225-488b-bcb7-40aed8771e1a	b9c79e332b90d28b1711534e53622f297a6a888aa7d6c1c1832185d1fef2c929	2024-05-22 12:38:38.121756+00	20230518193415_add_observaionts_and_traces	\N	\N	2024-05-22 12:38:38.053575+00	1
a7597070-fd5e-4292-bbbf-f12278c2878c	2f2fd22c3cc8bd21f6f23c88b7d5ef34674431520d0e55a37f8239e4a58afebd	2024-05-22 12:38:38.147434+00	20230518193521_changes	\N	\N	2024-05-22 12:38:38.12801+00	1
39a773a0-f606-4f75-a8e3-f125b04d1b70	d2c9bf829418360a44d1022156aaa8e95df92c940b5dfe962f8a7f7260cb5520	2024-05-22 12:38:38.198422+00	20230522092340_add_metrics_and_observation_types	\N	\N	2024-05-22 12:38:38.153319+00	1
bba35cba-45f5-4548-9271-89fd768fa86b	2480f771a6b4dea1f541c0b231784e5cebf2c443ac7636da6a411c4914f1cbd4	2024-05-22 12:38:38.816433+00	20230626095337_external_trace_id	\N	\N	2024-05-22 12:38:38.78083+00	1
fd219687-ca71-4d3c-b1ba-773fea8f6d19	28c59a2bd9b846d914083efdc1b51eb96a1db66af370b3dddd5040a57ec9088b	2024-05-22 12:38:38.223157+00	20230522094431_endtime_optional	\N	\N	2024-05-22 12:38:38.204659+00	1
2739438e-af7d-4fcf-af06-42b5b3ce29fa	755b1309b9c12e892f5a5f6db4e14f15b2d77ab61f76baab4c3621ea5e94fa6c	2024-05-22 12:38:38.246966+00	20230522131516_default_timestamp	\N	\N	2024-05-22 12:38:38.229318+00	1
3406731f-4b2f-47c1-8f33-29f9f6849f9c	7f995c9ff2b7e3f70bb5eeebb2108552feaf5f8a51154727c36db9466f0e3ec4	2024-05-22 12:38:39.420657+00	20230731162154_score_value_float	\N	\N	2024-05-22 12:38:39.357414+00	1
4f797446-60f6-46b6-bea8-10d8b971669f	66607eae9ccdfb92f30d859bcff0838e5df64c76da43ffbb25a65845dc63234e	2024-05-22 12:38:38.304693+00	20230523082455_rename_metrics_to_gradings	\N	\N	2024-05-22 12:38:38.256326+00	1
ab3796c1-072e-4d15-b94d-0a73843e6975	e5b55a82f4be9d623abac6ef0d9d00da2bf437f60454ed46bb1defa30e388692	2024-05-22 12:38:38.841287+00	20230705160335_add_created_updated_timestamps	\N	\N	2024-05-22 12:38:38.82223+00	1
fcae9b28-834e-47c4-bfb8-8a9f618dd14f	ff4107185d8f98b9d850e571a464bb806dade0f482984b3e29c019cb4d51397c	2024-05-22 12:38:38.360928+00	20230523084523_rename_to_score	\N	\N	2024-05-22 12:38:38.311703+00	1
0d06a2b9-f495-4557-8e67-dfdd1e962853	ab80a534dfa4779eeae4ae5aeac192eea19b283671d6083c8f112e3c8a4229df	2024-05-22 12:38:38.388589+00	20230529140133_user_add_pw	\N	\N	2024-05-22 12:38:38.37024+00	1
8637e934-70b1-43b3-9155-50563a84df60	f7c8e195215bf8a82ff89093a94aef748c209361aa05a48273f2084c49f05cd6	2024-05-22 12:38:39.103116+00	20230711104810_traces_add_index	\N	\N	2024-05-22 12:38:39.071799+00	1
a931b699-64dc-4159-9c21-1591a3e170e6	f0ef0a5663ceecf04816edea38d3fe93cf07f4c8031d2b7e185ec2e5fe39f0fa	2024-05-22 12:38:38.638135+00	20230530204241_auth_api_ui	\N	\N	2024-05-22 12:38:38.394724+00	1
0782b984-0657-4ecb-8d39-08b63d49b6ad	83f6a1d39c744faecc145e812f8ecca54267ac363f6315aa8afc3d890bf1f02d	2024-05-22 12:38:38.86559+00	20230706195819_add_completion_start_time	\N	\N	2024-05-22 12:38:38.847265+00	1
7de923d8-ee86-4717-9cb9-3d1dc1d8a2de	5e2e9d168251bab10d33e5f65a848c48d5f4ab762427ddd0f81e907c3339eb9a	2024-05-22 12:38:38.662841+00	20230618125818_remove_status_from_trace	\N	\N	2024-05-22 12:38:38.644089+00	1
d8554cd4-385e-4831-8bd7-c3db31fda26c	a7808d643321e4bf3d0628b256abb7d088e964c48698af6fdd7f32969dfd41aa	2024-05-22 12:38:38.72465+00	20230620181114_restructure	\N	\N	2024-05-22 12:38:38.669655+00	1
d7d0a270-c251-417a-b481-88df6e18328a	025c499c8b6f13676087e2e419671177a85a3ebad3a53cf84c7f70b0cfe01efe	2024-05-22 12:38:38.748914+00	20230622114254_new_oservations	\N	\N	2024-05-22 12:38:38.730319+00	1
9225fb17-06ba-40b7-a4cf-3c93abd6a661	ffbe75ad538d26b0864f8b8915115e0fbdd56fbc93a4d3a634d53488b741d403	2024-05-22 12:38:38.90239+00	20230707132314_traces_project_id_index	\N	\N	2024-05-22 12:38:38.871772+00	1
6a34e62f-5e8f-419c-a887-ff95b45f46bc	4cd20328eb9aa4ce2f0fe7dab5e00c412215e2c4423902d79cdebd7b0e2325f0	2024-05-22 12:38:39.305245+00	20230720164603_migrate_tokens	\N	\N	2024-05-22 12:38:39.292216+00	1
f2405670-3d97-4368-ab78-3bc4956d9872	362123c958d4fd06df3c816b74b4336ad2373f1505be12c84046e1364dd9dc10	2024-05-22 12:38:38.93943+00	20230707133415_user_add_email_index	\N	\N	2024-05-22 12:38:38.908301+00	1
ff7f9cbb-13cb-4341-a2c2-10d19651c53c	5755c1c8449e6a74016e9e7e42acc446746a3c41f21e07c317a66417fd399d94	2024-05-22 12:38:39.137756+00	20230711110517_memberships_add_userid_index	\N	\N	2024-05-22 12:38:39.10902+00	1
6057c5f4-3893-4dae-a39e-90265ce8e698	e7de5bcadea82b38002ead42a8e99f532e5fe2c178ba53d5954ef2c60a0115b3	2024-05-22 12:38:39.004929+00	20230710105741_added_indices	\N	\N	2024-05-22 12:38:38.945361+00	1
d15e9c3b-8c30-407e-a9f7-4d61c4bbe118	18a5a7ffe2b0ec8c008a1336826e3e07525f42a27e981f0a778533947b09e92d	2024-05-22 12:38:39.042966+00	20230710114928_traces_add_user_id	\N	\N	2024-05-22 12:38:39.010682+00	1
c49f1997-8fda-4119-93a7-075fcb5bdf59	225ccf9170a395e34586c954db9c71b84f4300a07ef67e5ff116d2d08f80f37f	2024-05-22 12:38:39.235448+00	20230711112235_fix_indices	\N	\N	2024-05-22 12:38:39.143384+00	1
e003cf45-9a1d-48a9-8f20-d10ae73e0067	9994a7038fc3ba73d3b5e833ded5825ec58505918d6b4eca646dbfca60a899b8	2024-05-22 12:38:39.328245+00	20230720172051_tokens_non_null	\N	\N	2024-05-22 12:38:39.311014+00	1
86ff58ce-ffb2-438a-b346-8c7908ace7bc	502d73e77f606982c12150e119f9214a7d8116d3d4d947ea37130d6aaf9280cd	2024-05-22 12:38:39.263576+00	20230717190411_users_feature_flags	\N	\N	2024-05-22 12:38:39.241087+00	1
d93029a7-f039-40b9-8280-8156a9e3ce7f	9d3edea83f7e43616f70059fd0dbe6236133ac5fcd9883ac59b298e97fcd2e68	2024-05-22 12:38:39.286172+00	20230720162550_tokens	\N	\N	2024-05-22 12:38:39.269356+00	1
6498f549-a135-42f5-ac79-73b62a560586	7c025190192fb785a7f3728ebab61bb167f3be07233341678c640bd31360fce5	2024-05-22 12:38:39.521825+00	20230810191452_traceid_nullable_on_observations	\N	\N	2024-05-22 12:38:39.50456+00	1
c9902405-f1a5-45b5-bcb9-99b7a82415fb	882b8cd48edf35b50633d13833aa0c8b92f70b707c3fc035fe0e59d2355a3a95	2024-05-22 12:38:39.351093+00	20230721111651_drop_usage_json	\N	\N	2024-05-22 12:38:39.333609+00	1
54784cd7-2731-4ed6-87eb-4d2a565a00f2	056d2e25ef8ebb7b2b7eee99a708ab8feffa348896301c8a1a67524e3c2fddf8	2024-05-22 12:38:39.498476+00	20230809132331_add_project_id_to_observations	\N	\N	2024-05-22 12:38:39.476631+00	1
6eb564ad-cb9c-45dd-8021-c8c973f76c25	05604cd4b32a7e41e21a314c7e78fd1b5883a9582acb5f4308ee7053af9707d7	2024-05-22 12:38:39.446257+00	20230803093326_add_release_and_version	\N	\N	2024-05-22 12:38:39.427039+00	1
f51f43d9-9805-4e1f-b48e-dfd012ad7f0c	ef6d52cd7eae4e95cf21b942289d9efb69e7f60eb5d3ca281d252c54e2b77ede	2024-05-22 12:38:39.470673+00	20230809093636_remove_foreign_keys	\N	\N	2024-05-22 12:38:39.45281+00	1
15341651-4b2d-48bd-94cc-47bb7b8b2a0b	f409d263846f578bba696959b5ebfaa60a9534a407c6ad8c8fc32604ab7adfd1	2024-05-22 12:38:39.545609+00	20230810191453_project_id_not_null	\N	\N	2024-05-22 12:38:39.527668+00	1
42184bdb-c297-441b-a72c-460bc535b1b3	f998a3d872a1056949638870ce35fedb364d37297a784ecbcd1f95faf04a4c5c	2024-05-22 12:38:39.568485+00	20230814184705_add_viewer_membership_role	\N	\N	2024-05-22 12:38:39.551241+00	1
a479c4f0-44ea-4ad4-b0e2-8b8c2a654d8b	51ccaa1ee0828dcb0cf731b019486c2f39c5b1bdd09046ab90f9ba6ec13be1af	2024-05-22 12:38:39.61785+00	20230901155252_add_pricings_table	\N	\N	2024-05-22 12:38:39.574116+00	1
3f89359c-fed2-4685-911a-2da0a95f754f	5b8a5e3d5880fa10be8005ca6e4d682104dae3f816e162c3db94c41753a8e1c5	2024-05-22 12:38:39.641778+00	20230901155336_add_pricing_data	\N	\N	2024-05-22 12:38:39.623589+00	1
877d8d8c-957d-4bdb-bdfc-42c6bfc9c2ad	e31a4c1059dcbabbdc2ab6aecb50328bef42e809ed206485aba37c437c5cebc2	2024-05-22 12:38:39.689276+00	20230907204921_add_cron_jobs_table	\N	\N	2024-05-22 12:38:39.647406+00	1
d17b0114-460d-4393-95cd-7797cff66c45	800d6b5782b4564cfa092fd57f42ec2283537d439f167419211669aaa7df3ee2	2024-05-22 12:38:40.703753+00	20231119171940_bookmarked	\N	\N	2024-05-22 12:38:40.684471+00	1
c94a8e17-f1cf-4958-8a4b-f9d737a3e1ce	285bbb0b1c1ad7b8ee2d29ae7477b3f5b1b0e53fc58e9d75a287aaac715d498b	2024-05-22 12:38:39.720133+00	20230907225603_projects_updated_at	\N	\N	2024-05-22 12:38:39.695496+00	1
44bccb9a-2020-409d-9723-6423eb3d29eb	578777f46933e33a0dc8e7c78f054c86dd0ed1413f67dc2d6334365cfda4c6bb	2024-05-22 12:38:40.289052+00	20231018130032_add_per_1000_chars_pricing	\N	\N	2024-05-22 12:38:40.270112+00	1
2caca17e-e9bf-43b5-ab88-1812a5df212b	d11aeff0b05af374c3306cdb12cc18afb7f73c5b8ce2c50757745ce5775340e2	2024-05-22 12:38:39.755585+00	20230907225604_api_keys_publishable_to_public	\N	\N	2024-05-22 12:38:39.725657+00	1
8de73e94-6f6a-4384-8a4e-f4a6691023b7	378a5dd5ba691270826895506d53e8a6acc4ebba29f8226dfa0d78e698040c5e	2024-05-22 12:38:39.778024+00	20230910164603_cron_add_state	\N	\N	2024-05-22 12:38:39.761115+00	1
247f35db-edf9-4103-871c-7ca6d0ac3a55	00cea39de0d75e817cfadcd95f852d4a84e00c1f67930d518ae4d452c93ac177	2024-05-22 12:38:40.54831+00	20231110012457_observation_created_at	\N	\N	2024-05-22 12:38:40.530549+00	1
7e72cd6e-5e42-4843-aadd-7834bdf3780f	d4af17aef307dba854b4b896df6f998cef8ac211fb792b7e90c7fe6fa4a9e4c3	2024-05-22 12:38:39.800363+00	20230912115644_add_trace_public_bool	\N	\N	2024-05-22 12:38:39.783459+00	1
93b17e70-98cc-440e-9417-f3893facdf1c	c087cf267a4c8b52ec4cebf0612b840d2136475e4776e9206778830256ce3f32	2024-05-22 12:38:40.373799+00	20231019094815_add_additional_secret_key_column	\N	\N	2024-05-22 12:38:40.294815+00	1
b913db0b-5fe4-4b69-991b-b8e2693a6b87	2026ed8d4e73d7d09741dbedf1fe73233e624f3e7f81b2a2b9243f415168ebb2	2024-05-22 12:38:39.848773+00	20230918180320_add_indices	\N	\N	2024-05-22 12:38:39.806083+00	1
15d25f16-c479-40c9-a124-343354de4edd	6bfdc95391ba091dc9d96899dbe7f967814cf42eb6388b664d9d76d8982add70	2024-05-22 12:38:39.885854+00	20230922030325_add_observation_index	\N	\N	2024-05-22 12:38:39.854619+00	1
ffc19ccc-8f5b-4bdb-a3ce-5794683454f4	ea9794f2d79f49b88ab95b90335fe97cd7ccc3d7f1dd156259a5e5aa1c107043	2024-05-22 12:38:40.014203+00	20230924232619_datasets_init	\N	\N	2024-05-22 12:38:39.891597+00	1
5b310d59-b3b9-4bd0-83c9-40cc9c91a456	44810e0e19455ef071bec618d10951ba956e7a112631eb3f4c313fe903db7267	2024-05-22 12:38:40.391942+00	20231021182825_user_emails_all_lowercase	\N	\N	2024-05-22 12:38:40.379526+00	1
3ecfc006-7f29-44c6-9fe3-24e620242a6f	6db5841932092efa895afe4c027079a9c48ae252181c8e0c3985c6d08f96ba8a	2024-05-22 12:38:40.069226+00	20230924232620_datasets_continued	\N	\N	2024-05-22 12:38:40.020248+00	1
5a768936-769c-470e-9859-984a012e2d46	e8f8302423f78da25f0349a5da4083160f574c98ccc2b3e28f91d16cfa1ad499	2024-05-22 12:38:40.105784+00	20231004005909_add_parent_observation_id_index	\N	\N	2024-05-22 12:38:40.075133+00	1
8ee7fbc2-f79c-42d5-a788-8f7eb5eca791	8f1b13112f4627c886c705d33920578b19fea917471b7367191300eebef544fc	2024-05-22 12:38:40.141805+00	20231005064433_add_release_index	\N	\N	2024-05-22 12:38:40.111483+00	1
fc32d366-4ef0-4b36-a915-9984eee75444	6456651794d1f7215c7f39238725764948ce71b7df386639d2d4f58da2e93335	2024-05-22 12:38:40.416145+00	20231025153548_add_headers_to_events	\N	\N	2024-05-22 12:38:40.397679+00	1
154d5086-10d4-496d-8bec-937f2ddaa3cb	dfeb488d9be2f37c669211d8fee91cc67d384eee1532512a00328195fd259e27	2024-05-22 12:38:40.171423+00	20231009095917_add_ondelete_cascade	\N	\N	2024-05-22 12:38:40.147818+00	1
eae76f35-5ef6-41eb-9de4-13ccb154fc7c	e08e3d28e1b13a6df4f7eb43bd81d427f86792a9235dfa123db11b67343c1d82	2024-05-22 12:38:40.23976+00	20231012161041_add_events_table	\N	\N	2024-05-22 12:38:40.177568+00	1
d097cbfb-1203-489b-95bd-54db1f80132d	1074f270d9b48baa51d22c0c90218cdc47dc3338a5f0ea90bd72ef5ea5e2cf88	2024-05-22 12:38:40.584449+00	20231110012829_observation_created_at_index	\N	\N	2024-05-22 12:38:40.554294+00	1
96e060bb-08e7-4653-bef5-34f89f2c17a9	52d73a2c8f5927da07492f83ffc94ce4a3cdc93232be0291d0faf77bc5ba8eed	2024-05-22 12:38:40.263827+00	20231014131841_users_add_admin_flag	\N	\N	2024-05-22 12:38:40.245498+00	1
8a69f9e5-e6d9-42f0-a015-b5b41454108d	cc2235e89e6815af4002bd4aa6941e16dd452efe9dc5d59ac0c390589160a7ac	2024-05-22 12:38:40.452967+00	20231030184329_events_add_index_on_projectid	\N	\N	2024-05-22 12:38:40.422176+00	1
f1b8c402-1c55-4297-97a8-ce357dcfe1b3	f5ef1377c36e5301cf312bb60c6bb647bdb3de2db1d847003b4cfd3e24ca9ccc	2024-05-22 12:38:40.477787+00	20231104004529_scores_add_index	\N	\N	2024-05-22 12:38:40.459125+00	1
9436fc65-4dbb-45d9-beda-46c140c13a72	9f5a355bf0c6c5fa36b37c898b338a234d43efa01d387eca439a95d674721ca2	2024-05-22 12:38:41.042119+00	20231230151856_add_prompt_table	\N	\N	2024-05-22 12:38:40.972686+00	1
2c96effc-7c7a-41d3-bd10-1fbe57523530	2f634dc6a7e272e3715472968da531e23c9dda562d5d137e6bfe7195d51761ab	2024-05-22 12:38:40.502945+00	20231104005403_fkey_indicies	\N	\N	2024-05-22 12:38:40.483374+00	1
9cd70c3a-e3ab-416d-beb6-65dbc861c05a	3920714d62de04345531777f14fe9a02b8982890c93f0b57512c0ab55755ee79	2024-05-22 12:38:40.620808+00	20231112095703_observations_add_unique_constraint	\N	\N	2024-05-22 12:38:40.590251+00	1
4817fa3b-b18b-4baf-8d8a-2bf6fc256793	85bf236e16abc39747ea773383c06cd06208e2d147237beb0b20b48318397e7e	2024-05-22 12:38:40.524812+00	20231106213824_add_openai_models	\N	\N	2024-05-22 12:38:40.508414+00	1
f0287b48-33c3-4534-a26e-744494a8dfd3	0be96056b9709a8b7899d555e228d5c0098f1e6b358c6e016bb3843b7846b3f6	2024-05-22 12:38:40.789091+00	20231129013314_invites	\N	\N	2024-05-22 12:38:40.709676+00	1
8b9c3edf-438f-4fdd-9f9f-648a9bc688cd	5881fcf2e0d44375b52e6228413774f3154ab9fab3492f8ff24a24c2f044033b	2024-05-22 12:38:40.655967+00	20231116005353_scores_unique_id_projectid	\N	\N	2024-05-22 12:38:40.62649+00	1
4702ff77-bdeb-4c48-806e-1e248356aa10	8fee27ef5b07ba63a31cf88aee365f6f9c66b8cb5a08492b7f19c2a1eef249e4	2024-05-22 12:38:40.678685+00	20231119171939_cron_add_job_started_at	\N	\N	2024-05-22 12:38:40.661865+00	1
9649a4f5-33c6-48f0-b446-294071c0746a	1b774d2ddbe9ae0f7cf8b60beaef0d27a6f5e8b09840e342ffd85c63c5de517d	2024-05-22 12:38:40.943856+00	20231223230007_cloud_config	\N	\N	2024-05-22 12:38:40.926539+00	1
f46c5e12-acba-408a-9a60-e42aaaf89c6a	401f5230ee1dccb765509321e8075652e71ae4ec28f5648a6b2ee151fc58d90b	2024-05-22 12:38:40.895584+00	20231130003317_trace_session_input_output	\N	\N	2024-05-22 12:38:40.796451+00	1
889aecc8-0ce5-41fe-9a6b-fbc9b4999849	f73f71a1a394677fb4ddd00cfe2238c40190f875525473d9ebf80f15fc89a2e7	2024-05-22 12:38:40.920865+00	20231204223505_add_unit_to_observations	\N	\N	2024-05-22 12:38:40.902018+00	1
0a963ebe-9d7e-462e-990d-b40339f410e5	14911fffc711830a28304af98b2c9fe31f5f78fb568281090a75f4f7958ba942	2024-05-22 12:38:40.966711+00	20231223230008_accounts_add_cols_azure_ad_auth	\N	\N	2024-05-22 12:38:40.949451+00	1
139b1052-cbff-4ea5-a09d-3604c369570d	9f7ef155730980f10cf9c84fdcce91b80822a8ff1d7d35720b544f851397a0e5	2024-05-22 12:38:41.11461+00	20240104210051_add_model_indices	\N	\N	2024-05-22 12:38:41.071847+00	1
14414a87-b268-45c4-bd39-afc9a472d2f7	7919b5dfcacec288b646f23c83f6adbf5f69eba50d2de4a35eb2b9d3029e4729	2024-05-22 12:38:41.066181+00	20240103135918_add_pricings	\N	\N	2024-05-22 12:38:41.047761+00	1
4454f535-aa6c-4c2a-9770-6d430476d8b0	ed03d628f2755b0b16963a8d20b72440588a7ed57a4f1652d9b128e5dcfbf1b3	2024-05-22 12:38:41.164008+00	20240104210052_add_model_indices_pricing	\N	\N	2024-05-22 12:38:41.120457+00	1
28c9c975-4801-4071-8c65-ba6deb115abe	08918b17989f2bd0e36f80c5255042f807afe428186c68cf334fa01953153807	2024-05-22 12:38:41.187415+00	20240105010215_add_tags_in_traces	\N	\N	2024-05-22 12:38:41.170154+00	1
3787fd25-f4c4-4e12-aa91-31d46b0f9ab4	18fba86141a537df2fdf6bc8b8d8cd1abcdef25ca0dca43d1983fb23dac4db72	2024-05-22 12:38:41.210376+00	20240105170551_index_tags_in_traces	\N	\N	2024-05-22 12:38:41.193002+00	1
0e39b1d8-97b8-41fb-9530-bb16c481eea7	de4c1bc9e76dc2ad02e5cedc68bc20450c80307c64123469b925b1ba1787449c	2024-05-22 12:38:41.233646+00	20240106195340_drop_dataset_status	\N	\N	2024-05-22 12:38:41.21608+00	1
a6b57299-a7c5-4eda-83a0-cfd57446b5f8	795187b23b16aceb796a10b5a43327cd3f767a0048f7ae8cb4d209695e49f18d	2024-05-22 12:38:41.900579+00	20240215234937_fix_observations_view	\N	\N	2024-05-22 12:38:41.881819+00	1
4aa36dcf-a97f-42d9-9692-ea9ef6cccb0d	9d7148c925f6643b17c1aad933fce92bdcbc8fa2304eb97be11c0aa32747664a	2024-05-22 12:38:41.262129+00	20240111152124_add_gpt_35_pricing	\N	\N	2024-05-22 12:38:41.239288+00	1
6b83a9f3-b9a8-48c7-99e5-7495b979bf0e	fcbff614561f2c09501be18aad566624e04bf390aef8c072596ac2b793d10cb7	2024-05-22 12:38:41.638585+00	20240130100110_usage_unit_nullable	\N	\N	2024-05-22 12:38:41.621433+00	1
c9b9f0cc-dd45-42c5-a3b5-e0452ad198a2	9496ee3af1202cb3f9d6f0d4bb88c521e0e796a04bc8e02622718a63ba79b710	2024-05-22 12:38:41.285161+00	20240117151938_traces_remove_unique_id_external	\N	\N	2024-05-22 12:38:41.267698+00	1
94c6d3ef-0fae-4499-9fb4-566d08724b47	c5919ee7870f36a7555024eb2256b3a28c8d978032dcd943047e5cff27a86cba	2024-05-22 12:38:41.308188+00	20240117165747_add_cost_to_observations	\N	\N	2024-05-22 12:38:41.290767+00	1
b65a7f1e-b9aa-4f5d-88ff-dbcf65771d70	ad8869aea6b98159c54bd3f2fcfb4ee1114ba54a7bf5726378dc2edd6f8077eb	2024-05-22 12:38:41.357774+00	20240118204639_add_models_table	\N	\N	2024-05-22 12:38:41.31428+00	1
2261bb1a-7f90-45ff-9527-93da52865d7c	c301dfa0db4367a4691bf520cb0c0b377b10e2ef4ca66f39f818284b23d0cfa2	2024-05-22 12:38:41.662362+00	20240130160110_claude_models	\N	\N	2024-05-22 12:38:41.644298+00	1
faa52129-626e-4291-a7db-9badb0cf0a32	7211b935cb3f52c11c7ebd0ac540bbbd01bb2010e51ad412d2956645c02724b7	2024-05-22 12:38:41.383185+00	20240118204936_add_internal_model	\N	\N	2024-05-22 12:38:41.365924+00	1
3b2376a4-e9fc-49b9-9fd7-f23f19d26b98	b79f2ca2011baa6604eec15e549996af3a10e396b706aff73b6ca36c08291d99	2024-05-22 12:38:41.412935+00	20240118204937_add_observations_view	\N	\N	2024-05-22 12:38:41.388799+00	1
9efde2ed-5954-4efd-920c-649cf93292f8	2ab605d386e52af31b6328f5542d63ec6a6b19db9bda8f2e4888a7de7154b2ae	2024-05-22 12:38:42.332651+00	20240304123642_traces_view_improvement	\N	\N	2024-05-22 12:38:42.313667+00	1
e898dc02-0d03-4a06-bc0f-6663524731bd	2c075714bdce7df89f328062021733fd62880ff7cdb91a1d0a7aab2659a89d06	2024-05-22 12:38:41.462246+00	20240118235424_add_index_to_models	\N	\N	2024-05-22 12:38:41.418655+00	1
98a5b32f-a281-439a-aec8-d0bd6de46e5a	af31e8b4be701e97ccf87d4692055d2cc7ece9d74cc424e05dfb2775de5a7efe	2024-05-22 12:38:41.686256+00	20240131184148_add_finetuned_and_vertex_models	\N	\N	2024-05-22 12:38:41.668089+00	1
d69e2ee3-eacd-4c3a-94aa-3f5411a7c624	c76d5a31377660ce77e890a918ffa07bd2db8c8c94b04753befbc27d152492ea	2024-05-22 12:38:41.485328+00	20240119140941_add_tokenizer_id	\N	\N	2024-05-22 12:38:41.46793+00	1
df3ebe9e-1585-4824-beec-bfa4097d793e	08f7d11bd5deec873669ca10101dd0a05669bb04eb300ef0ee7b6d3517ae0c24	2024-05-22 12:38:41.50881+00	20240119164147_make_model_params_nullable	\N	\N	2024-05-22 12:38:41.491129+00	1
f4a81bec-d038-44b1-95fb-45f92dc3bfe4	540712b04f0fbaf449eaf229210e04dec83280878842c7c3d9956e4ff98334ce	2024-05-22 12:38:41.923124+00	20240219162415_add_prompt_config	\N	\N	2024-05-22 12:38:41.90619+00	1
aec609dc-b644-4a8e-bada-1b28f1664eb1	3b0d3c46459cc2770d6e8d9db6fc139f859792da5b89937114dd09b17dac0dd4	2024-05-22 12:38:41.533396+00	20240119164148_add_models	\N	\N	2024-05-22 12:38:41.514553+00	1
5478a161-1660-423a-bf65-78d875004251	3bc4965e82cd4645da383ef6f6582a7efd7f5bf27e912af1efe18ff62e014db1	2024-05-22 12:38:41.710897+00	20240203184148_update_pricing	\N	\N	2024-05-22 12:38:41.692081+00	1
9efd1052-472f-49ae-a8c6-51be2953cc1f	73f7212daa54130c6fa91fc17d840262ec948b11aafce49ea3e8ce7d4f3cbef1	2024-05-22 12:38:41.569243+00	20240124140443_session_composite_key	\N	\N	2024-05-22 12:38:41.538894+00	1
1e984ddf-7ffd-423d-a366-b73bb51b2f89	4ec1ad8229c185a7afaa62357879a60d4f59b35a103975030ce43d67823096c9	2024-05-22 12:38:41.592774+00	20240124164148_correct_models	\N	\N	2024-05-22 12:38:41.575148+00	1
8365c9a0-494f-4735-a7cd-ed1d1bcc87f7	546c704d2869f4d382fb591fd20b14c489e99fffaa5655c45a3a86e7a7d488c5	2024-05-22 12:38:41.615748+00	20240126184148_new_models copy	\N	\N	2024-05-22 12:38:41.598523+00	1
830a0905-7ea7-47f0-9f7d-b2b369c4fae9	3e0cc893b4ec41ef43740af577aef359e2c742c338c8fc5421f766d75cce1292	2024-05-22 12:38:41.783706+00	20240212175433_add_audit_log_table	\N	\N	2024-05-22 12:38:41.716429+00	1
76b3af33-784c-4d4a-8bd9-e1f39be6aa1c	f2af6a57ddd2aab8adeaa5a3c6571cd8ab8538b071fb01e07c35d277203ae6b8	2024-05-22 12:38:42.153723+00	20240226202041_add_observations_trace_id_project_id_type_start_time_idx	\N	\N	2024-05-22 12:38:42.112934+00	1
39775811-a60a-4432-8af7-0c88ad3b67d9	4a1b6917569327219e620f0cca78446c360958d5a91226b7f60bd4626ffb38d0	2024-05-22 12:38:41.806216+00	20240213124148_update_openai_pricing	\N	\N	2024-05-22 12:38:41.789371+00	1
a6094782-f567-4d95-9263-b0caa7cd3721	909cae9daaf399b3ab6e9c03142fa4b80d7b09f44165944b9a09007d829d6f28	2024-05-22 12:38:41.968009+00	20240226165118_add_observations_index	\N	\N	2024-05-22 12:38:41.928983+00	1
20e471b2-4eb0-47cc-9ae6-1e64f4cc3fd6	a942356a983650fb3aa2974690956869324993c3a546ea83d3ae26d2a98db7c1	2024-05-22 12:38:41.853119+00	20240214232619_prompts_add_indicies	\N	\N	2024-05-22 12:38:41.81251+00	1
10244895-43ad-46fd-8656-e783b063bef8	00a42d4d8bd4090cf94d90eeb82fe803d23d802dcdb6c058b2371a75d951519a	2024-05-22 12:38:41.876119+00	20240215224148_update_openai_pricing	\N	\N	2024-05-22 12:38:41.858937+00	1
86e95dfc-86d8-4a36-83a9-ffa69fc0ea8f	d498837088f8de279f4c04655af668c34f3febd961c95390a0441cb0ee0a3db6	2024-05-22 12:38:42.256946+00	20240228103642_observations_view_cte	\N	\N	2024-05-22 12:38:42.231431+00	1
32d1eb14-cb89-4abb-a57c-41ba6321eb94	58e1bb0a84cb20a36c750b9d13c1371e44cd1a4947d5bdb37754a23d664c5e33	2024-05-22 12:38:42.01372+00	20240226182815_add_model_index	\N	\N	2024-05-22 12:38:41.973626+00	1
27b02dd5-5bdf-44e3-a62c-6dac88e8cee7	e31ee1ec510ded08a1813273056149bfe345651ce02d9ab31883dde10e390afe	2024-05-22 12:38:42.17821+00	20240226203642_rewrite_observations_view	\N	\N	2024-05-22 12:38:42.15938+00	1
ba75b970-0d74-4470-8c27-15d8cc8684ab	2cb0786da90de9c0a6e2983075362c76163e0635f9d347da0686b9c0434b8f0f	2024-05-22 12:38:42.060236+00	20240226183642_add_observations_index	\N	\N	2024-05-22 12:38:42.019219+00	1
026c39b4-325d-4e2e-8ce2-7006930a9d23	e733981599148cbb086a4eb4e7276fac2059ce3b60b3acf1443c3ec648f1d233	2024-05-22 12:38:42.107152+00	20240226202040_add_observations_trace_id_project_id_start_time_idx	\N	\N	2024-05-22 12:38:42.066017+00	1
948b1084-dbe2-4371-ac71-1dffbc3f28b1	5603e17abf74b6c9e4191ff261e56e63641a90c5e04d99c5f04be174d1a90d76	2024-05-22 12:38:42.225557+00	20240227112101_index_prompt_id_in_observations	\N	\N	2024-05-22 12:38:42.18455+00	1
f42f3207-24e5-422a-97ae-ba69b7dce1f6	83902ab9281b0b9b7257768518cbfb6895d382f30e6594b2058507d173bfa519	2024-05-22 12:38:42.307498+00	20240304123642_traces_view	\N	\N	2024-05-22 12:38:42.288957+00	1
b5e49a16-beac-4140-aa8b-122bdafc18f8	96e0223ba9bb5ec06dc4c53988451298d6cf9df6b83da89262280ceb3c203d59	2024-05-22 12:38:42.282677+00	20240228123642_observations_view_fix	\N	\N	2024-05-22 12:38:42.263096+00	1
63d839c8-69fd-4cc4-8317-a910f7fe1723	b9abacb6b7858085eff8230a9950eaffe2e557c67981592097a2b93204b3c5ec	2024-05-22 12:38:42.378642+00	20240304222519_scores_add_index	\N	\N	2024-05-22 12:38:42.338308+00	1
8012dea0-9906-4e2e-864e-62f3e87553da	f8e14cfb18416f04c49e67c2e9c97675b1d01a1a60a549d784cfbcd52f308771	2024-05-22 12:38:42.426542+00	20240305095119_add_observations_index	\N	\N	2024-05-22 12:38:42.384415+00	1
7c02270b-919f-44e8-a56c-5497536010a9	498c50087ca98fffe98b041b77c8ef195888e35e607b3c0d64643d9275e83935	2024-05-22 12:38:42.475747+00	20240305100713_traces_add_index	\N	\N	2024-05-22 12:38:42.432738+00	1
542a2632-72fa-45d0-89ea-7b3abd96f0f0	89a9d0e9dd25662dd684333947df23ea4165a4adec9995e281b33fecdd60b775	2024-05-22 12:38:42.504649+00	20240307090110_claude_model_three	\N	\N	2024-05-22 12:38:42.481798+00	1
88781ec4-1e54-415a-bf66-a5c0337f4e4f	7a8d3f1cb3ce402ca6de3b8af2f9f402770d7bb1b9a0ba740dd691b5e88feb1f	2024-05-22 12:38:42.542678+00	20240307185543_score_add_source_nullable	\N	\N	2024-05-22 12:38:42.512661+00	1
2d668c8a-c3d2-4a52-a330-fbbe41b465b0	cbf36bf3115f7c66934d46e7d8f4a21c7465f9d00569d619b7382028ee422eb3	2024-05-22 12:38:42.913058+00	20240404210315_dataset_add_descriptions	\N	\N	2024-05-22 12:38:42.894482+00	1
ff5660a5-e092-4477-b68e-a9c9c62bb0f9	b9c551f91d345926b3c740563aecff3904717185b84dcdf74c0b2521ffa2cb63	2024-05-22 12:38:42.590592+00	20240307185544_score_add_name_index	\N	\N	2024-05-22 12:38:42.548468+00	1
88befa13-6099-4cbf-887a-d8e08028bef3	0cec970448bd9ff3a78acdcce5519f9c2154378ccc3a3acbd79266478f66238e	2024-05-22 12:38:42.60975+00	20240307185725_backfill_score_source	\N	\N	2024-05-22 12:38:42.596515+00	1
22fec0f4-2372-4349-b5c4-92079ce08dab	c8ea9587bcf109835eb4b8cb882e121c35624d5e9f90e21886de3b7ee5793312	2024-05-22 12:38:43.739814+00	20240424150909_add_job_execution_index	\N	\N	2024-05-22 12:38:43.709069+00	1
1f2549fa-13ab-4960-b207-859b6c32740d	1a476db15f8f2a6becbde3c804623832542a9d2dc1233389e9b4d1c9047a5b43	2024-05-22 12:38:42.636917+00	20240312195727_score_source_drop_default	\N	\N	2024-05-22 12:38:42.616633+00	1
9ea71044-3a67-4099-847b-792505649026	b5d68c44ed85196b038921cde3faf6241050b76781a9d93981346165436c6ed7	2024-05-22 12:38:42.938867+00	20240404232317_dataset_items_backfill_source_trace_id	\N	\N	2024-05-22 12:38:42.919225+00	1
66caaf73-09aa-464f-b607-dc44e06ffc29	137f83659a950bdc6497c2030f61bd070264ee14387f3e11143f55ae2c3d810e	2024-05-22 12:38:42.664569+00	20240314090110_claude_model	\N	\N	2024-05-22 12:38:42.643026+00	1
fee7ce48-a08d-49f2-b5c5-092008453de7	9e7f1d6a2d8e12037a931e8d8c86e552366e8056d2a9adb847f84da5c6972398	2024-05-22 12:38:42.688767+00	20240325211959_remove_example_table	\N	\N	2024-05-22 12:38:42.670558+00	1
cc3967cb-6514-4419-9422-3b1547cf61a3	e0d84647251c69f99883c12c21eb9cbad9f0fc1059b58cce3296edeebdc1b8dc	2024-05-22 12:38:43.3771+00	20240414203636_ee_add_sso_configs	\N	\N	2024-05-22 12:38:43.331683+00	1
11fb4704-d71d-42f2-9f0e-6a1eac04ceb4	48d049e8d66ed3f4b0336d857ae4bfeb7f39dd9ee1070fbe4bede32630478e7b	2024-05-22 12:38:42.717341+00	20240325212245_dataset_runs_add_metadata	\N	\N	2024-05-22 12:38:42.694559+00	1
371b2feb-c87a-460e-bc67-da0ace8ad37d	82c21f5f2399c1173c734d8a157b4b0dac6821cbbc36dce8ba058caf40681ff7	2024-05-22 12:38:42.964509+00	20240405124810_prompt_to_json	\N	\N	2024-05-22 12:38:42.945536+00	1
765911b1-5008-4d75-a9f0-608fa1b3ab6d	3fa446eb946ec9e8f56c4665e02aea106727c4058acd89dd758900273a2183d8	2024-05-22 12:38:42.743821+00	20240326114211_dataset_run_item_bind_to_trace	\N	\N	2024-05-22 12:38:42.724416+00	1
d3629dcb-c7f8-4975-b5e6-18abcc823b85	f6efc777385ff3f04b4c93745d7a66fe953a4fb4544203ad22808b80468f3578	2024-05-22 12:38:42.762821+00	20240326114337_dataset_run_item_backfill_trace_id	\N	\N	2024-05-22 12:38:42.749469+00	1
065f9064-8912-45cc-9eae-36251624789b	7c084b86913a91f9b8658084f6b8f6526bce2d0de4842c8f68e07f30f1f46fe9	2024-05-22 12:38:42.785809+00	20240326115136_dataset_run_item_traceid_non_null	\N	\N	2024-05-22 12:38:42.768494+00	1
76543c3d-ecfd-409b-a0c5-e1f8680f7452	206607c9c910399b23bb8217092e4b17fd428f2890efb49f1ad65dceaa55f3d1	2024-05-22 12:38:43.185606+00	20240408133037_add_objects_for_evals	\N	\N	2024-05-22 12:38:42.970716+00	1
45774137-3ca4-4f7b-9de6-4e18de19c0ba	afe59690f207d0f4481d9a54af3e743622a88a68ad46d4eb2597c2b7a953fc66	2024-05-22 12:38:42.838259+00	20240326115424_dataset_run_item_index_trace	\N	\N	2024-05-22 12:38:42.791711+00	1
19330d48-5f05-4c73-92b3-4479bb672c27	10e5a3983b46239bbb0b6ad8617901df3c7eaa53df0b879577528d7e14d84d91	2024-05-22 12:38:42.863469+00	20240328065738_dataset_item_input_nullable	\N	\N	2024-05-22 12:38:42.844306+00	1
adcb0f55-4d66-48ba-b584-86a67e10aee9	b01064942f09a3e944a7db83a680ba04e135b6aee91569445ba295a2ce443f74	2024-05-22 12:38:43.592218+00	20240420134232_posthog_integration_created_at	\N	\N	2024-05-22 12:38:43.574978+00	1
531038f7-0cc8-49c3-b5b4-d9688ce82e39	04c22689adda42b47ce94563fc3e834507c8b214a20ae1d379b2cfa9ed4e6d73	2024-05-22 12:38:42.888491+00	20240404203640_dataset_item_source_trace_id	\N	\N	2024-05-22 12:38:42.869322+00	1
bbe58e8b-1d6e-4839-9170-8d8e84e114a3	dcd8dcb804ab5eeb3cc813b88ea510578a6b481e5756628b0fa7d061d9aa79a5	2024-05-22 12:38:43.42981+00	20240415235737_index_models_model_name	\N	\N	2024-05-22 12:38:43.385301+00	1
52c65116-ac88-4dad-9987-57a5687f2194	b9711c48f8a9d20c8705c31f1a2bd4a4e1e3473e7de6f884ced0776773dea897	2024-05-22 12:38:43.211136+00	20240408134328_prompt_table_add_tags	\N	\N	2024-05-22 12:38:43.191933+00	1
bb30328f-558e-4ad2-bb31-b18be0ac57b6	017eaef133c6ad53c86e655daf6ef310f5e8870d197b32b91b22feea8589c20d	2024-05-22 12:38:43.246173+00	20240408134330_prompt_table_add_index_to_tags	\N	\N	2024-05-22 12:38:43.216721+00	1
1482e4de-3727-41b9-80ab-dd6aaa67a2c0	5b74cc3719cc73c4a9561521df9593a0b72b7f71a7edc6fc962259855d1b4597	2024-05-22 12:38:43.277428+00	20240411134330_model_updates	\N	\N	2024-05-22 12:38:43.255716+00	1
285af2b7-a81c-48da-b9c7-841190adda55	20f9110c61428813f2d32bff079f64fe35ee3dbb6eb40241c24885ca87e44226	2024-05-22 12:38:43.47976+00	20240416173813_add_internal_model_index	\N	\N	2024-05-22 12:38:43.436433+00	1
078f9202-8fd5-432b-8d72-1bf93b8e826e	86412f0fd3a38ecf7aba62d2df6bc63f21d8545c6846e7ad450f1ba1054ec0ef	2024-05-22 12:38:43.302582+00	20240411194142_update_job_config_status	\N	\N	2024-05-22 12:38:43.283625+00	1
b97a502f-d562-400e-be7a-5381f93e0f54	0f44dce07307ae9364e93449837fe6fc6189780dd94b7d506f8c2f653423b42a	2024-05-22 12:38:43.325151+00	20240411224142_update_models	\N	\N	2024-05-22 12:38:43.3085+00	1
ea2db1a4-a89f-48f4-8ed9-b63a6b8c65cd	e79db3e95ce362750535a772337f79cd94bc37890e58ce3c05aa0253afe1d1d6	2024-05-22 12:38:43.510009+00	20240417102742_metadata_on_dataset_and_dataset_item	\N	\N	2024-05-22 12:38:43.486189+00	1
9f21ad1a-32b7-4b76-9e77-6afa2b8beced	b5153e69a337304509d94116fc42eac4ae838617041d473e361627e99d78eaeb	2024-05-22 12:38:43.617221+00	20240423174013_update_models	\N	\N	2024-05-22 12:38:43.598074+00	1
5fe31db4-f36e-45b9-a9c3-15519c709cc0	d53f2ddcfda91be76c40f87c0ebdeee510cf7316e6ce8578e16a3a068daf0bd5	2024-05-22 12:38:43.569577+00	20240419152924_posthog_integration_settings	\N	\N	2024-05-22 12:38:43.515855+00	1
a53f0082-4b50-4ace-afa8-930850ff0ca5	a15e5ed199ff9e77ad2ab1920262094a07c63c5bf639929e7912e3ec5b6f1da0	2024-05-22 12:38:43.850528+00	20240503130335_traces_index_created_at	\N	\N	2024-05-22 12:38:43.808043+00	1
e1a66315-6fdf-4207-b6ba-dd65c15f55d6	0a6f2078af2b92a1d61d36449f3646fb8adda99acb6ee214451b8c2a7a62c36c	2024-05-22 12:38:43.703289+00	20240423192655_add_llm_api_keys	\N	\N	2024-05-22 12:38:43.623324+00	1
6fcc4d56-f5e3-4fec-88ad-3c66aa891d30	6c5083ecdb222c9a4566fac6a4364a349351e868bb68eff17a7c8c48bacf39c1	2024-05-22 12:38:43.802185+00	20240503125742_traces_add_createdat_updatedat	\N	\N	2024-05-22 12:38:43.785081+00	1
91225506-e993-42c7-b94b-5654e9962af6	a2ff78bbd0982e80edcc312bb686a9d33f4bde7e675d0915ba570aff2931307d	2024-05-22 12:38:43.762436+00	20240429124411_add_prompt_version_labels	\N	\N	2024-05-22 12:38:43.745347+00	1
acbd71a3-34f5-4470-876c-eab21942be39	caf1f29f946abe2c7774657473a274866a1bab1a4d4b368bac32154c263aba22	2024-05-22 12:38:43.77942+00	20240429194411_add_latest_prompt_tag	\N	\N	2024-05-22 12:38:43.767933+00	1
294949b5-dd8e-4ab0-b055-5135dc08cbe0	6d3ba16762dc0033c95dabd79ef2ac122e8416c7ec5cd15ef761057837b19c92	2024-05-22 12:38:43.898234+00	20240503130520_traces_index_updated_at	\N	\N	2024-05-22 12:38:43.856754+00	1
b2192b13-14c7-4b48-b980-f9999dfec6d7	86eaf205ba5fd2130957536777d0aa00c8d15cdc2af896ea5b45ed5f26d690b6	2024-05-22 12:38:43.921441+00	20240508132621_scores_add_project_id	\N	\N	2024-05-22 12:38:43.903939+00	1
d5d1b11c-36a1-4571-9c34-5b6b881acc65	644c6246091a13e8e908733347ffd699789d448bb3c80207e53b32223667a292	2024-05-22 12:38:43.967555+00	20240508132735_scores_add_projectid_index	\N	\N	2024-05-22 12:38:43.927001+00	1
fca6cd4b-a13c-48bc-a4cd-93cf463b931d	c1e8301b3c0ad83f46731fa6398565faa586ee89b5dc4ff22a2289a9f7c21d8e	2024-05-22 12:38:43.985489+00	20240508132736_scores_backfill_project_id	\N	\N	2024-05-22 12:38:43.973734+00	1
f6b89f91-33ee-4269-8f55-09d75f0b1fce	3425cdbd747937bbb512b560a2b8132462d0412191a695e27dc9ae268f3d40f2	2024-05-22 12:38:44.009935+00	20240512151529_rename_memberships_to_project_memberships	\N	\N	2024-05-22 12:38:43.991039+00	1
4b347512-7848-4cc4-ab46-08b175bdbaf5	d010f310671b164935b005b7949c29a46a2f14117e14060702f239cf3bb081cb	2024-05-22 12:38:44.195631+00	20240512155020_rename_enum_membership_role_to_project_role	\N	\N	2024-05-22 12:38:44.015433+00	1
3993bb23-f089-4e2d-8d36-f2459c22c15c	a398b1ccdba2791a4646955f37522df929dd0e0a2d01603a068f70e096d2f53a	2024-05-22 12:38:44.218269+00	20240512155021_add_pricing_gpt4o	\N	\N	2024-05-22 12:38:44.201327+00	1
a20c58b0-dff4-4099-9495-f47bf145cca0	f9750ea80adc2a175c4455a32779c5a607d741b71ca8354a18d9e8273b70b9a0	2024-05-22 12:38:44.241862+00	20240512155021_scores_drop_fk_on_traces_and_observations	\N	\N	2024-05-22 12:38:44.22395+00	1
f9752de1-cbd1-4fb7-88e1-938b7e2e7cf5	18525089d536b836d81e02dab68588e4fe2bf3d0a09e4c349d60db9bbed0cd49	2024-05-22 12:38:44.265731+00	20240512155022_scores_non_null_and_add_fk_project_id	\N	\N	2024-05-22 12:38:44.247507+00	1
009aabaf-58f5-4887-ad38-df8d7b6e0019	6f038363d06b8fe9ad5e5ffdebec33d4cde3591c65fe46175a4a821736637482	2024-05-22 12:38:44.290035+00	20240513082203_scores_unique_id_and_projectid_instead_of_id_and_traceid	\N	\N	2024-05-22 12:38:44.271341+00	1
f44c8093-5550-4d5f-b810-1db8cba4442a	e39e28c4337fa35ab175c703d6ceda8a2d4b78d2bc616200201faff350c61455	2024-05-22 12:38:44.336019+00	20240513082204_scores_unique_id_and_projectid_instead_of_id_and_traceid_index	\N	\N	2024-05-22 12:38:44.295674+00	1
c8451b7b-410e-442d-9d49-45f68ada9477	b8c134bdcba9a016d8ac79927a0d736c67c5bbf109ec584a15b0f6c38f50dc8d	2024-05-22 12:38:44.360644+00	20240513082205_observations_view_add_time_to_first_token	\N	\N	2024-05-22 12:38:44.341587+00	1
\.


--
-- Data for Name: api_keys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.api_keys (id, created_at, note, public_key, hashed_secret_key, display_secret_key, last_used_at, expires_at, project_id, fast_hashed_secret_key) FROM stdin;
clwj3vxok00043hh209v6msbn	2024-05-23 10:24:26.948	\N	pk-lf-f2a3d62b-8ee4-4736-a823-5751a40f1bba	$2a$11$rOjUAU6WVf9PC6RNcqLWZebtWmNXzq9rTPL2fadWRPzqJi5mZrc3.	sk-lf-...b7ba	\N	\N	clwj3vu5000003hh22qhevccf	\N
\.


--
-- Data for Name: audit_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.audit_logs (id, created_at, updated_at, user_id, project_id, resource_type, resource_id, action, before, after, user_project_role) FROM stdin;
clwj3vu5g00023hh23p2rfsx4	2024-05-23 10:24:22.372	2024-05-23 10:24:22.372	clwiyet8c0000lh4loaeumr54	clwj3vu5000003hh22qhevccf	project	clwj3vu5000003hh22qhevccf	create	\N	{"id":"clwj3vu5000003hh22qhevccf","createdAt":"2024-05-23T10:24:22.356Z","updatedAt":"2024-05-23T10:24:22.356Z","name":"test","cloudConfig":null}	OWNER
clwj3vxot00063hh2a2b8n5we	2024-05-23 10:24:26.958	2024-05-23 10:24:26.958	clwiyet8c0000lh4loaeumr54	clwj3vu5000003hh22qhevccf	apiKey	clwj3vxok00043hh209v6msbn	create	\N	\N	OWNER
\.


--
-- Data for Name: cron_jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cron_jobs (name, last_run, state, job_started_at) FROM stdin;
\.


--
-- Data for Name: dataset_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dataset_items (id, input, expected_output, source_observation_id, dataset_id, created_at, updated_at, status, source_trace_id, metadata) FROM stdin;
\.


--
-- Data for Name: dataset_run_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dataset_run_items (id, dataset_run_id, dataset_item_id, observation_id, created_at, updated_at, trace_id) FROM stdin;
\.


--
-- Data for Name: dataset_runs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dataset_runs (id, name, dataset_id, created_at, updated_at, metadata, description) FROM stdin;
\.


--
-- Data for Name: datasets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datasets (id, name, project_id, created_at, updated_at, description, metadata) FROM stdin;
\.


--
-- Data for Name: eval_templates; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.eval_templates (id, created_at, updated_at, project_id, name, version, prompt, model, model_params, vars, output_schema) FROM stdin;
\.


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.events (id, created_at, updated_at, project_id, data, url, method, headers) FROM stdin;
\.


--
-- Data for Name: job_configurations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job_configurations (id, created_at, updated_at, project_id, job_type, eval_template_id, score_name, filter, target_object, variable_mapping, sampling, delay, status) FROM stdin;
\.


--
-- Data for Name: job_executions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job_executions (id, created_at, updated_at, project_id, job_configuration_id, status, start_time, end_time, error, job_input_trace_id, job_output_score_id) FROM stdin;
\.


--
-- Data for Name: llm_api_keys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.llm_api_keys (id, created_at, updated_at, provider, display_secret_key, secret_key, project_id) FROM stdin;
\.


--
-- Data for Name: membership_invitations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.membership_invitations (id, email, project_id, sender_id, created_at, updated_at, role) FROM stdin;
\.


--
-- Data for Name: models; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.models (id, created_at, updated_at, project_id, model_name, match_pattern, start_date, input_price, output_price, total_price, unit, tokenizer_config, tokenizer_id) FROM stdin;
clrkvx5gp000108juaogs54ea	2024-05-23 10:02:36.006	2024-05-23 10:02:36.006	\N	gpt-4-turbo-vision	(?i)^(gpt-4-vision-preview)$	\N	0.000010000000000000000000000000	0.000030000000000000000000000000	\N	TOKENS	{"tokensPerName": 1, "tokenizerModel": "gpt-4-vision-preview", "tokensPerMessage": 3}	openai
clrntkjgy000f08jx79v9g1xj	2024-05-23 10:02:36.006	2024-05-23 10:02:36.006	\N	gpt-4	(?i)^(gpt-4)$	\N	0.000030000000000000000000000000	0.000060000000000000000000000000	\N	TOKENS	{"tokensPerName": 1, "tokenizerModel": "gpt-4", "tokensPerMessage": 3}	openai
clrkwk4cc000908l537kl0rx3	2024-05-23 10:02:36.006	2024-05-23 10:02:36.006	\N	gpt-4-0613	(?i)^(gpt-4-0613)$	\N	0.000030000000000000000000000000	0.000060000000000000000000000000	\N	TOKENS	{"tokensPerName": 1, "tokenizerModel": "gpt-4-0613", "tokensPerMessage": 3}	openai
clrntkjgy000e08jx4x6uawoo	2024-05-23 10:02:36.006	2024-05-23 10:02:36.006	\N	gpt-4-0314	(?i)^(gpt-4-0314)$	\N	0.000030000000000000000000000000	0.000060000000000000000000000000	\N	TOKENS	{"tokensPerName": 1, "tokenizerModel": "gpt-4-0314", "tokensPerMessage": 3}	openai
clrkvyzgw000308jue4hse4j9	2024-05-23 10:02:36.006	2024-05-23 10:02:36.006	\N	gpt-4-32k	(?i)^(gpt-4-32k)$	\N	0.000060000000000000000000000000	0.000120000000000000000000000000	\N	TOKENS	{"tokensPerName": 1, "tokenizerModel": "gpt-4-32k", "tokensPerMessage": 3}	openai
clrkwk4cb000108l5hwwh3zdi	2024-05-23 10:02:36.006	2024-05-23 10:02:36.006	\N	gpt-4-32k-0613	(?i)^(gpt-4-32k-0613)$	\N	0.000060000000000000000000000000	0.000120000000000000000000000000	\N	TOKENS	{"tokensPerName": 1, "tokenizerModel": "gpt-4-32k-0613", "tokensPerMessage": 3}	openai
clrntkjgy000d08jx0p4y9h4l	2024-05-23 10:02:36.006	2024-05-23 10:02:36.006	\N	gpt-4-32k-0314	(?i)^(gpt-4-32k-0314)$	\N	0.000060000000000000000000000000	0.000120000000000000000000000000	\N	TOKENS	{"tokensPerName": 1, "tokenizerModel": "gpt-4-32k-0314", "tokensPerMessage": 3}	openai
clrkwk4cc000a08l562uc3s9g	2024-05-23 10:02:36.006	2024-05-23 10:02:36.006	\N	gpt-3.5-turbo-instruct	(?i)^(gpt-)(35|3.5)(-turbo-instruct)$	\N	0.000001500000000000000000000000	0.000002000000000000000000000000	\N	TOKENS	{"tokensPerName": 1, "tokenizerModel": "gpt-3.5-turbo", "tokensPerMessage": 3}	openai
clrkwk4cb000408l576jl7koo	2024-05-23 10:02:36.006	2024-05-23 10:02:36.006	\N	gpt-3.5-turbo	(?i)^(gpt-)(35|3.5)(-turbo)$	2023-11-06 00:00:00	0.000001000000000000000000000000	0.000002000000000000000000000000	\N	TOKENS	{"tokensPerName": 1, "tokenizerModel": "gpt-3.5-turbo", "tokensPerMessage": 3}	openai
clrkwk4cb000208l59yvb9yq8	2024-05-23 10:02:36.006	2024-05-23 10:02:36.006	\N	gpt-3.5-turbo-1106	(?i)^(gpt-)(35|3.5)(-turbo-1106)$	\N	0.000001000000000000000000000000	0.000002000000000000000000000000	\N	TOKENS	{"tokensPerName": 1, "tokenizerModel": "gpt-3.5-turbo-1106", "tokensPerMessage": 3}	openai
clrntkjgy000c08jxesb30p3f	2024-05-23 10:02:36.006	2024-05-23 10:02:36.006	\N	gpt-3.5-turbo	(?i)^(gpt-)(35|3.5)(-turbo)$	2023-06-27 00:00:00	0.000001500000000000000000000000	0.000002000000000000000000000000	\N	TOKENS	{"tokensPerName": 1, "tokenizerModel": "gpt-3.5-turbo", "tokensPerMessage": 3}	openai
clrkwk4cc000808l51xmk4uic	2024-05-23 10:02:36.006	2024-05-23 10:02:36.006	\N	gpt-3.5-turbo-0613	(?i)^(gpt-)(35|3.5)(-turbo-0613)$	\N	0.000001500000000000000000000000	0.000002000000000000000000000000	\N	TOKENS	{"tokensPerName": 1, "tokenizerModel": "gpt-3.5-turbo-0613", "tokensPerMessage": 3}	openai
clrntkjgy000b08jx769q1bah	2024-05-23 10:02:36.006	2024-05-23 10:02:36.006	\N	gpt-3.5-turbo	(?i)^(gpt-)(35|3.5)(-turbo)$	\N	0.000002000000000000000000000000	0.000002000000000000000000000000	\N	TOKENS	{"tokensPerName": -1, "tokenizerModel": "gpt-3.5-turbo", "tokensPerMessage": 4}	openai
clrntkjgy000a08jx4e062mr0	2024-05-23 10:02:36.006	2024-05-23 10:02:36.006	\N	gpt-3.5-turbo-0301	(?i)^(gpt-)(35|3.5)(-turbo-0301)$	\N	0.000002000000000000000000000000	0.000002000000000000000000000000	\N	TOKENS	{"tokensPerName": -1, "tokenizerModel": "gpt-3.5-turbo-0301", "tokensPerMessage": 4}	openai
clrntjt89000908jwhvkz5crm	2024-05-23 10:02:36.08	2024-05-23 10:02:36.08	\N	text-embedding-ada-002	(?i)^(text-embedding-ada-002)$	2022-12-06 00:00:00	\N	\N	0.000000100000000000000000000000	TOKENS	{"tokenizerModel": "text-embedding-ada-002"}	openai
clrntjt89000908jwhvkz5crg	2024-05-23 10:02:36.08	2024-05-23 10:02:36.08	\N	text-embedding-ada-002-v2	(?i)^(text-embedding-ada-002-v2)$	2022-12-06 00:00:00	\N	\N	0.000000100000000000000000000000	TOKENS	{"tokenizerModel": "text-embedding-ada-002"}	openai
clrntjt89000108jwcou1af71	2024-05-23 10:02:36.08	2024-05-23 10:02:36.08	\N	text-ada-001	(?i)^(text-ada-001)$	\N	\N	\N	0.000004000000000000000000000000	TOKENS	{"tokenizerModel": "text-ada-001"}	openai
clrntjt89000208jwawjr894q	2024-05-23 10:02:36.08	2024-05-23 10:02:36.08	\N	text-babbage-001	(?i)^(text-babbage-001)$	\N	\N	\N	0.000000500000000000000000000000	TOKENS	{"tokenizerModel": "text-babbage-001"}	openai
clrntjt89000308jw0jtfa4rs	2024-05-23 10:02:36.08	2024-05-23 10:02:36.08	\N	text-curie-001	(?i)^(text-curie-001)$	\N	\N	\N	0.000020000000000000000000000000	TOKENS	{"tokenizerModel": "text-curie-001"}	openai
clrntjt89000408jwc2c93h6i	2024-05-23 10:02:36.08	2024-05-23 10:02:36.08	\N	text-davinci-001	(?i)^(text-davinci-001)$	\N	\N	\N	0.000020000000000000000000000000	TOKENS	{"tokenizerModel": "text-davinci-001"}	openai
clrntjt89000508jw192m64qi	2024-05-23 10:02:36.08	2024-05-23 10:02:36.08	\N	text-davinci-002	(?i)^(text-davinci-002)$	\N	\N	\N	0.000020000000000000000000000000	TOKENS	{"tokenizerModel": "text-davinci-002"}	openai
clrntjt89000608jw4m3x5s55	2024-05-23 10:02:36.08	2024-05-23 10:02:36.08	\N	text-davinci-003	(?i)^(text-davinci-003)$	\N	\N	\N	0.000020000000000000000000000000	TOKENS	{"tokenizerModel": "text-davinci-003"}	openai
clruwn3pc00010al7bl611c8o	2024-05-23 10:02:36.108	2024-05-23 10:02:36.108	\N	text-embedding-3-small	(?i)^(text-embedding-3-small)$	\N	\N	\N	0.000000020000000000000000000000	TOKENS	{"tokenizerModel": "text-embedding-ada-002"}	openai
clruwn76700020al7gp8e4g4l	2024-05-23 10:02:36.108	2024-05-23 10:02:36.108	\N	text-embedding-ada-002-v2	(?i)^(text-embedding-3-large)$	\N	\N	\N	0.000000130000000000000000000000	TOKENS	{"tokenizerModel": "text-embedding-ada-002"}	openai
clruwnahl00030al7ab9rark7	2024-05-23 10:02:36.108	2024-05-23 10:02:36.108	\N	gpt-3.5-turbo-0125	(?i)^(gpt-)(35|3.5)(-turbo-0125)$	\N	0.000000500000000000000000000000	0.000001500000000000000000000000	\N	TOKENS	{"tokensPerName": 1, "tokenizerModel": "gpt-3.5-turbo", "tokensPerMessage": 3}	openai
clruwnahl00050al796ck3p44	2024-05-23 10:02:36.108	2024-05-23 10:02:36.108	\N	gpt-4-0125-preview	(?i)^(gpt-4-0125-preview)$	\N	0.000010000000000000000000000000	0.000030000000000000000000000000	\N	TOKENS	{"tokensPerName": 1, "tokenizerModel": "gpt-4", "tokensPerMessage": 3}	openai
clruwnahl00060al74fcfehas	2024-05-23 10:02:36.108	2024-05-23 10:02:36.108	\N	gpt-4-turbo-preview	(?i)^(gpt-4-turbo-preview)$	\N	0.000030000000000000000000000000	0.000060000000000000000000000000	\N	TOKENS	{"tokensPerName": 1, "tokenizerModel": "gpt-4", "tokensPerMessage": 3}	openai
clrs2dnql000108l46vo0gp2t	2024-05-23 10:02:36.108	2024-05-23 10:02:36.108	\N	babbage-002	(?i)^(babbage-002)$	\N	0.000000400000000000000000000000	0.000001600000000000000000000000	\N	TOKENS	{"tokenizerModel": "babbage-002"}	openai
clrs2ds35000208l4g4b0hi3u	2024-05-23 10:02:36.108	2024-05-23 10:02:36.108	\N	davinci-002	(?i)^(davinci-002)$	\N	0.000006000000000000000000000000	0.000012000000000000000000000000	\N	TOKENS	{"tokenizerModel": "davinci-002"}	openai
clrnwbota000908jsgg9mb1ml	2024-05-23 10:02:36.164	2024-05-23 10:02:36.164	\N	claude-instant-1	(?i)^(claude-instant-1)$	\N	0.000001630000000000000000000000	0.000005510000000000000000000000	\N	TOKENS	\N	claude
clrnwb41q000308jsfrac9uh6	2024-05-23 10:02:36.164	2024-05-23 10:02:36.164	\N	claude-instant-1.2	(?i)^(claude-instant-1.2)$	\N	0.000001630000000000000000000000	0.000005510000000000000000000000	\N	TOKENS	\N	claude
clrnwbd1m000508js4hxu6o7n	2024-05-23 10:02:36.164	2024-05-23 10:02:36.164	\N	claude-2.1	(?i)^(claude-2.1)$	\N	0.000008000000000000000000000000	0.000024000000000000000000000000	\N	TOKENS	\N	claude
clrnwb836000408jsallr6u11	2024-05-23 10:02:36.164	2024-05-23 10:02:36.164	\N	claude-2.0	(?i)^(claude-2.0)$	\N	0.000008000000000000000000000000	0.000024000000000000000000000000	\N	TOKENS	\N	claude
clrnwbg2b000608jse2pp4q2d	2024-05-23 10:02:36.164	2024-05-23 10:02:36.164	\N	claude-1.3	(?i)^(claude-1.3)$	\N	0.000008000000000000000000000000	0.000024000000000000000000000000	\N	TOKENS	\N	claude
clrnwbi9d000708jseiy44k26	2024-05-23 10:02:36.164	2024-05-23 10:02:36.164	\N	claude-1.2	(?i)^(claude-1.2)$	\N	0.000008000000000000000000000000	0.000024000000000000000000000000	\N	TOKENS	\N	claude
clrnwblo0000808jsc1385hdp	2024-05-23 10:02:36.164	2024-05-23 10:02:36.164	\N	claude-1.1	(?i)^(claude-1.1)$	\N	0.000008000000000000000000000000	0.000024000000000000000000000000	\N	TOKENS	\N	claude
cls08r8sq000308jq14ae96f0	2024-05-23 10:02:36.191	2024-05-23 10:02:36.191	\N	ft:gpt-3.5-turbo-1106	(?i)^(ft:)(gpt-3.5-turbo-1106:)(.+)(:)(.*)(:)(.+)$	\N	0.000003000000000000000000000000	0.000006000000000000000000000000	\N	TOKENS	{"tokensPerName": 1, "tokenizerModel": "gpt-3.5-turbo-1106", "tokensPerMessage": 3}	openai
cls08rp99000408jqepxoakjv	2024-05-23 10:02:36.191	2024-05-23 10:02:36.191	\N	ft:gpt-3.5-turbo-0613	(?i)^(ft:)(gpt-3.5-turbo-0613:)(.+)(:)(.*)(:)(.+)$	\N	0.000012000000000000000000000000	0.000016000000000000000000000000	\N	TOKENS	{"tokensPerName": 1, "tokenizerModel": "gpt-3.5-turbo-0613", "tokensPerMessage": 3}	openai
cls08rv9g000508jq5p4z4nlr	2024-05-23 10:02:36.191	2024-05-23 10:02:36.191	\N	ft:davinci-002	(?i)^(ft:)(davinci-002:)(.+)(:)(.*)(:)(.+)$$	\N	0.000012000000000000000000000000	0.000012000000000000000000000000	\N	TOKENS	{"tokenizerModel": "davinci-002"}	openai
cls08s2bw000608jq57wj4un2	2024-05-23 10:02:36.191	2024-05-23 10:02:36.191	\N	ft:babbage-002	(?i)^(ft:)(babbage-002:)(.+)(:)(.*)(:)(.+)$$	\N	0.000001600000000000000000000000	0.000001600000000000000000000000	\N	TOKENS	{"tokenizerModel": "babbage-002"}	openai
cls0k4lqt000008ky1o1s8wd5	2024-05-23 10:02:36.191	2024-05-23 10:02:36.191	\N	gemini-pro	(?i)^(gemini-pro)(@[a-zA-Z0-9]+)?$	\N	0.000000250000000000000000000000	0.000000500000000000000000000000	\N	CHARACTERS	\N	\N
cls0jni4t000008jk3kyy803r	2024-05-23 10:02:36.191	2024-05-23 10:02:36.191	\N	chat-bison-32k	(?i)^(chat-bison-32k)(@[a-zA-Z0-9]+)?$	\N	0.000000250000000000000000000000	0.000000500000000000000000000000	\N	CHARACTERS	\N	\N
cls0iv12d000108l251gf3038	2024-05-23 10:02:36.191	2024-05-23 10:02:36.191	\N	chat-bison	(?i)^(chat-bison)(@[a-zA-Z0-9]+)?$	\N	0.000000250000000000000000000000	0.000000500000000000000000000000	\N	CHARACTERS	\N	\N
cls0jmjt3000108l83ix86w0d	2024-05-23 10:02:36.191	2024-05-23 10:02:36.191	\N	text-bison-32k	(?i)^(text-bison-32k)(@[a-zA-Z0-9]+)?$	\N	0.000000250000000000000000000000	0.000000500000000000000000000000	\N	CHARACTERS	\N	\N
cls0juygp000308jk2a6x9my2	2024-05-23 10:02:36.191	2024-05-23 10:02:36.191	\N	text-bison	(?i)^(text-bison)(@[a-zA-Z0-9]+)?$	\N	0.000000250000000000000000000000	0.000000500000000000000000000000	\N	CHARACTERS	\N	\N
cls0jungb000208jk12gm4gk1	2024-05-23 10:02:36.191	2024-05-23 10:02:36.191	\N	text-unicorn	(?i)^(text-unicorn)(@[a-zA-Z0-9]+)?$	\N	0.000002500000000000000000000000	0.000007500000000000000000000000	\N	CHARACTERS	\N	\N
cls1nyj5q000208l33ne901d8	2024-05-23 10:02:36.191	2024-05-23 10:02:36.191	\N	textembedding-gecko	(?i)^(textembedding-gecko)(@[a-zA-Z0-9]+)?$	\N	\N	\N	0.000000100000000000000000000000	CHARACTERS	\N	\N
cls1nyyjp000308l31gxy1bih	2024-05-23 10:02:36.191	2024-05-23 10:02:36.191	\N	textembedding-gecko-multilingual	(?i)^(textembedding-gecko-multilingual)(@[a-zA-Z0-9]+)?$	\N	\N	\N	0.000000100000000000000000000000	CHARACTERS	\N	\N
cls1nzjt3000508l3dnwad3g0	2024-05-23 10:02:36.191	2024-05-23 10:02:36.191	\N	code-gecko	(?i)^(code-gecko)(@[a-zA-Z0-9]+)?$	\N	0.000000250000000000000000000000	0.000000500000000000000000000000	\N	CHARACTERS	\N	\N
cls1nzwx4000608l38va7e4tv	2024-05-23 10:02:36.191	2024-05-23 10:02:36.191	\N	code-bison	(?i)^(code-bison)(@[a-zA-Z0-9]+)?$	\N	0.000000250000000000000000000000	0.000000500000000000000000000000	\N	CHARACTERS	\N	\N
cls1o053j000708l39f8g4bgs	2024-05-23 10:02:36.191	2024-05-23 10:02:36.191	\N	code-bison-32k	(?i)^(code-bison-32k)(@[a-zA-Z0-9]+)?$	\N	0.000000250000000000000000000000	0.000000500000000000000000000000	\N	CHARACTERS	\N	\N
cls0j33v1000008joagkc4lql	2024-05-23 10:02:36.191	2024-05-23 10:02:36.191	\N	codechat-bison-32k	(?i)^(codechat-bison-32k)(@[a-zA-Z0-9]+)?$	\N	0.000000250000000000000000000000	0.000000500000000000000000000000	\N	CHARACTERS	\N	\N
cls0jmc9v000008l8ee6r3gsd	2024-05-23 10:02:36.191	2024-05-23 10:02:36.191	\N	codechat-bison	(?i)^(codechat-bison)(@[a-zA-Z0-9]+)?$	\N	0.000000250000000000000000000000	0.000000500000000000000000000000	\N	CHARACTERS	\N	\N
clrkwk4cb000308l5go4b6otm	2024-05-23 10:02:36.219	2024-05-23 10:02:36.219	\N	gpt-3.5-turbo-16k	(?i)^(gpt-)(35|3.5)(-turbo-16k)$	\N	0.000003000000000000000000000000	0.000004000000000000000000000000	\N	TOKENS	{"tokensPerName": 1, "tokenizerModel": "gpt-3.5-turbo-16k", "tokensPerMessage": 3}	openai
clrntjt89000a08jw0gcdbd5a	2024-05-23 10:02:36.219	2024-05-23 10:02:36.219	\N	gpt-3.5-turbo-16k-0613	(?i)^(gpt-)(35|3.5)(-turbo-16k-0613)$	\N	0.000003000000000000000000000000	0.000004000000000000000000000000	\N	TOKENS	{"tokensPerName": 1, "tokenizerModel": "gpt-3.5-turbo-16k-0613", "tokensPerMessage": 3}	openai
clruwnahl00040al78f1lb0at	2024-05-23 10:02:36.337	2024-05-23 10:02:36.337	\N	gpt-3.5-turbo	(?i)^(gpt-)(35|3.5)(-turbo)$	2024-02-16 00:00:00	0.000000500000000000000000000000	0.000001500000000000000000000000	\N	TOKENS	{"tokensPerName": 1, "tokenizerModel": "gpt-3.5-turbo", "tokensPerMessage": 3}	openai
clsk9lntu000008jwfc51bbqv	2024-05-23 10:02:36.337	2024-05-23 10:02:36.337	\N	gpt-3.5-turbo-16k	(?i)^(gpt-)(35|3.5)(-turbo-16k)$	2024-02-16 00:00:00	0.000000500000000000000000000000	0.000001500000000000000000000000	\N	TOKENS	{"tokensPerName": 1, "tokenizerModel": "gpt-3.5-turbo-16k", "tokensPerMessage": 3}	openai
clsnq07bn000008l4e46v1ll8	2024-05-23 10:02:36.427	2024-05-23 10:02:36.427	\N	gpt-4-turbo-preview	(?i)^(gpt-4-turbo-preview)$	2023-11-06 00:00:00	0.000010000000000000000000000000	0.000030000000000000000000000000	\N	TOKENS	{"tokensPerName": 1, "tokenizerModel": "gpt-4", "tokensPerMessage": 3}	openai
cltgy0iuw000008le3vod1hhy	2024-05-23 10:02:37.23	2024-05-23 10:02:37.23	\N	claude-3-opus-20240229	(?i)^(claude-3-opus-20240229)$	\N	0.000015000000000000000000000000	0.000075000000000000000000000000	\N	TOKENS	\N	claude
cltgy0pp6000108le56se7bl3	2024-05-23 10:02:37.23	2024-05-23 10:02:37.23	\N	claude-3-sonnet-20240229	(?i)^(claude-3-sonnet-20240229)$	\N	0.000003000000000000000000000000	0.000015000000000000000000000000	\N	TOKENS	\N	claude
cltr0w45b000008k1407o9qv1	2024-05-23 10:02:37.402	2024-05-23 10:02:37.402	\N	claude-3-haiku-20240307	(?i)^(claude-3-haiku-20240307)$	\N	0.000000250000000000000000000000	0.000001250000000000000000000000	\N	TOKENS	\N	claude
cluv2sjeo000008ih0fv23hi0	2024-05-23 10:02:38.107	2024-05-23 10:02:38.107	\N	gemini-1.0-pro-latest	(?i)^(gemini-1.0-pro-latest)(@[a-zA-Z0-9]+)?$	\N	0.000000250000000000000000000000	0.000000500000000000000000000000	\N	CHARACTERS	\N	\N
cluv2subq000108ih2mlrga6a	2024-05-23 10:02:38.107	2024-05-23 10:02:38.107	\N	gemini-1.0-pro	(?i)^(gemini-1.0-pro)(@[a-zA-Z0-9]+)?$	2024-02-15 00:00:00	0.000000125000000000000000000000	0.000000375000000000000000000000	\N	CHARACTERS	\N	\N
cluv2sx04000208ihbek75lsz	2024-05-23 10:02:38.107	2024-05-23 10:02:38.107	\N	gemini-1.0-pro-001	(?i)^(gemini-1.0-pro-001)(@[a-zA-Z0-9]+)?$	2024-02-15 00:00:00	0.000000125000000000000000000000	0.000000375000000000000000000000	\N	CHARACTERS	\N	\N
cluv2szw0000308ihch3n79x7	2024-05-23 10:02:38.107	2024-05-23 10:02:38.107	\N	gemini-pro	(?i)^(gemini-pro)(@[a-zA-Z0-9]+)?$	2024-02-15 00:00:00	0.000000125000000000000000000000	0.000000375000000000000000000000	\N	CHARACTERS	\N	\N
cluv2t2x0000408ihfytl45l1	2024-05-23 10:02:38.107	2024-05-23 10:02:38.107	\N	gemini-1.5-pro-latest	(?i)^(gemini-1.5-pro-latest)(@[a-zA-Z0-9]+)?$	\N	0.000002500000000000000000000000	0.000007500000000000000000000000	\N	CHARACTERS	\N	\N
cluvpl4ls000008l6h2gx3i07	2024-05-23 10:02:38.171	2024-05-23 10:02:38.171	\N	gpt-4-turbo	(?i)^(gpt-4-turbo)$	\N	0.000010000000000000000000000000	0.000030000000000000000000000000	\N	TOKENS	{"tokensPerName": 1, "tokenizerModel": "gpt-4-1106-preview", "tokensPerMessage": 3}	openai
cluv2t5k3000508ih5kve9zag	2024-05-23 10:02:38.519	2024-05-23 10:02:38.519	\N	gpt-4-turbo-2024-04-09	(?i)^(gpt-4-turbo-2024-04-09)$	\N	0.000010000000000000000000000000	0.000030000000000000000000000000	\N	TOKENS	{"tokensPerName": 1, "tokenizerModel": "gpt-4-turbo-2024-04-09", "tokensPerMessage": 3}	openai
clrkvq6iq000008ju6c16gynt	2024-05-23 10:02:38.519	2024-05-23 10:02:38.519	\N	gpt-4-1106-preview	(?i)^(gpt-4-1106-preview)$	\N	0.000010000000000000000000000000	0.000030000000000000000000000000	\N	TOKENS	{"tokensPerName": 1, "tokenizerModel": "gpt-4-1106-preview", "tokensPerMessage": 3}	openai
clv2o2x0p000008jsf9afceau	2024-05-23 10:02:38.519	2024-05-23 10:02:38.519	\N	 gpt-4-preview	(?i)^(gpt-4-preview)$	\N	0.000010000000000000000000000000	0.000030000000000000000000000000	\N	TOKENS	{"tokensPerName": 1, "tokenizerModel": "gpt-4-turbo-preview", "tokensPerMessage": 3}	openai
b9854a5c92dc496b997d99d20	2024-05-23 10:02:39.26	2024-05-23 10:02:39.26	\N	gpt-4o	(?i)^(gpt-4o)$	\N	0.000005000000000000000000000000	0.000015000000000000000000000000	\N	TOKENS	{"tokensPerName": 1, "tokenizerModel": "gpt-4o", "tokensPerMessage": 3}	openai
b9854a5c92dc496b997d99d21	2024-05-23 10:02:39.26	2024-05-23 10:02:39.26	\N	gpt-4o-2024-05-13	(?i)^(gpt-4o-2024-05-13)$	\N	0.000005000000000000000000000000	0.000015000000000000000000000000	\N	TOKENS	{"tokensPerName": 1, "tokenizerModel": "gpt-4o-2024-05-13", "tokensPerMessage": 3}	openai
\.


--
-- Data for Name: observations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.observations (id, name, start_time, end_time, parent_observation_id, type, trace_id, metadata, model, "modelParameters", input, output, level, status_message, completion_start_time, completion_tokens, prompt_tokens, total_tokens, version, project_id, created_at, unit, prompt_id, input_cost, output_cost, total_cost, internal_model) FROM stdin;
\.


--
-- Data for Name: posthog_integrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.posthog_integrations (project_id, encrypted_posthog_api_key, posthog_host_name, last_sync_at, enabled, created_at) FROM stdin;
\.


--
-- Data for Name: pricings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pricings (id, model_name, pricing_unit, price, currency, token_type) FROM stdin;
clm0obv1u00003b6lc9etkzfg	gpt-4	PER_1000_TOKENS	0.030000000000000000000000000000	USD	PROMPT
clm0obv1u00013b6l4jdl83vs	gpt-4-0314	PER_1000_TOKENS	0.030000000000000000000000000000	USD	PROMPT
clm0obv1u00023b6lsi1d24dh	gpt-4-0613	PER_1000_TOKENS	0.030000000000000000000000000000	USD	PROMPT
clm0obv1u00033b6lvv4h0iex	gpt-4-32k	PER_1000_TOKENS	0.060000000000000000000000000000	USD	PROMPT
clm0obv1u00043b6ln5pleunh	gpt-4-32k-0314	PER_1000_TOKENS	0.060000000000000000000000000000	USD	PROMPT
clm0obv1u00053b6l0g4zo5oe	gpt-4-32k-0613	PER_1000_TOKENS	0.060000000000000000000000000000	USD	PROMPT
clm0obv1u00063b6lv7y80efe	gpt-4	PER_1000_TOKENS	0.060000000000000000000000000000	USD	COMPLETION
clm0obv1u00073b6l302roky7	gpt-4-0314	PER_1000_TOKENS	0.060000000000000000000000000000	USD	COMPLETION
clm0obv1u00083b6laz822qt4	gpt-4-0613	PER_1000_TOKENS	0.060000000000000000000000000000	USD	COMPLETION
clm0obv1u00093b6l9ivm2fbs	gpt-4-32k	PER_1000_TOKENS	0.120000000000000000000000000000	USD	COMPLETION
clm0obv1u000a3b6l7ou8mq4o	gpt-4-32k-0314	PER_1000_TOKENS	0.120000000000000000000000000000	USD	COMPLETION
clm0obv1u000b3b6lym69vmpx	gpt-4-32k-0613	PER_1000_TOKENS	0.120000000000000000000000000000	USD	COMPLETION
clm0obv1u000c3b6lfeg8e6gh	gpt-3.5-turbo	PER_1000_TOKENS	0.001500000000000000000000000000	USD	PROMPT
clm0obv1u000d3b6lb8ww3uj2	gpt-3.5-turbo-0301	PER_1000_TOKENS	0.001500000000000000000000000000	USD	PROMPT
clm0obv1u000e3b6lznniclze	gpt-3.5-turbo-0613	PER_1000_TOKENS	0.001500000000000000000000000000	USD	PROMPT
clm0obv1u000f3b6lr2bxjnxr	gpt-3.5-turbo-16k	PER_1000_TOKENS	0.003000000000000000000000000000	USD	PROMPT
clm0obv1u000g3b6lo3rqrgpj	gpt-3.5-turbo-16k-0613	PER_1000_TOKENS	0.003000000000000000000000000000	USD	PROMPT
clm0obv1u000h3b6lt1l33gpm	gpt-3.5-turbo	PER_1000_TOKENS	0.002000000000000000000000000000	USD	COMPLETION
clm0obv1u000i3b6lgfs7pi5b	gpt-3.5-turbo-0301	PER_1000_TOKENS	0.002000000000000000000000000000	USD	COMPLETION
clm0obv1u000j3b6lg1jokl07	gpt-3.5-turbo-0613	PER_1000_TOKENS	0.002000000000000000000000000000	USD	COMPLETION
clm0obv1u000k3b6lgfntsm74	gpt-3.5-turbo-16k	PER_1000_TOKENS	0.004000000000000000000000000000	USD	COMPLETION
clm0obv1u000l3b6l8wjhn0ie	gpt-3.5-turbo-16k-0613	PER_1000_TOKENS	0.004000000000000000000000000000	USD	COMPLETION
clm0obv1u000m3b6lgrcel0ce	gpt-35-turbo	PER_1000_TOKENS	0.001500000000000000000000000000	USD	PROMPT
clm0obv1u000n3b6lw3bc6q70	gpt-35-turbo-0301	PER_1000_TOKENS	0.001500000000000000000000000000	USD	PROMPT
clm0obv1u000o3b6luimelud7	gpt-35-turbo-0613	PER_1000_TOKENS	0.001500000000000000000000000000	USD	PROMPT
clm0obv1u000p3b6lft9rfj1h	gpt-35-turbo-16k	PER_1000_TOKENS	0.003000000000000000000000000000	USD	PROMPT
clm0obv1u000q3b6l1zh6x8lu	gpt-35-turbo-16k-0613	PER_1000_TOKENS	0.003000000000000000000000000000	USD	PROMPT
clm0obv1v000r3b6llobngoj3	gpt-35-turbo	PER_1000_TOKENS	0.002000000000000000000000000000	USD	COMPLETION
clm0obv1v000s3b6lgcjqu15e	gpt-35-turbo-0301	PER_1000_TOKENS	0.002000000000000000000000000000	USD	COMPLETION
clm0obv1v000t3b6l6ijo29gd	gpt-35-turbo-0613	PER_1000_TOKENS	0.002000000000000000000000000000	USD	COMPLETION
clm0obv1v000u3b6lo16c29a1	gpt-35-turbo-16k	PER_1000_TOKENS	0.004000000000000000000000000000	USD	COMPLETION
clm0obv1v000v3b6leqypomnv	gpt-35-turbo-16k-0613	PER_1000_TOKENS	0.004000000000000000000000000000	USD	COMPLETION
clm0obv1v000w3b6l6y0ojr1j	text-ada-001	PER_1000_TOKENS	0.000400000000000000000000000000	USD	TOTAL
clm0obv1v000x3b6lwdjl5os6	ada	PER_1000_TOKENS	0.000400000000000000000000000000	USD	TOTAL
clm0obv1v000y3b6lsap2cbkj	text-babbage-001	PER_1000_TOKENS	0.000500000000000000000000000000	USD	TOTAL
clm0obv1v000z3b6lto21j3xd	babbage	PER_1000_TOKENS	0.000500000000000000000000000000	USD	TOTAL
clm0obv1v00103b6lges5uumn	text-curie-001	PER_1000_TOKENS	0.002000000000000000000000000000	USD	TOTAL
clm0obv1v00113b6l2vizhjhc	curie	PER_1000_TOKENS	0.002000000000000000000000000000	USD	TOTAL
clm0obv1v00123b6lqb7mfrzr	text-davinci-003	PER_1000_TOKENS	0.020000000000000000000000000000	USD	TOTAL
clm0obv1v00133b6lnqa8ecal	text-davinci-002	PER_1000_TOKENS	0.020000000000000000000000000000	USD	TOTAL
clm0obv1v00143b6l6z5s44sf	code-davinci-002	PER_1000_TOKENS	0.020000000000000000000000000000	USD	TOTAL
clm0obv1v00153b6lyntq7lx0	ada-finetuned	PER_1000_TOKENS	0.001600000000000000000000000000	USD	TOTAL
clm0obv1v00163b6l5fsheo7p	babbage-finetuned	PER_1000_TOKENS	0.002400000000000000000000000000	USD	TOTAL
clm0obv1v00173b6lly0887fz	curie-finetuned	PER_1000_TOKENS	0.012000000000000000000000000000	USD	TOTAL
clm0obv1v00183b6lg20tw4g4	davinci-finetuned	PER_1000_TOKENS	0.120000000000000000000000000000	USD	TOTAL
clm0obv1u00003b6lc2etkzfu	gpt-4-1106-preview	PER_1000_TOKENS	0.010000000000000000000000000000	USD	PROMPT
clm0obv1u00003b6lc2etkzfg	gpt-4-1106-preview	PER_1000_TOKENS	0.030000000000000000000000000000	USD	COMPLETION
clm0obv1u00013b6l4gdl83vs	gpt-4-1106-vision-preview\t	PER_1000_TOKENS	0.010000000000000000000000000000	USD	PROMPT
clm0obv1u00013b6l4gjl83vs	gpt-4-1106-vision-preview\t	PER_1000_TOKENS	0.030000000000000000000000000000	USD	COMPLETION
clqqpc2pr000008l3hvy63gxy	gpt-3.5-turbo-1106	PER_1000_TOKENS	0.001000000000000000000000000000	USD	PROMPT
clqqpcb6d000208l3atrfbmou	gpt-3.5-turbo-1106	PER_1000_TOKENS	0.002000000000000000000000000000	USD	COMPLETION
clqqpdh45000008lfgrnx76cv	gpt-3.5-turbo-instruct	PER_1000_TOKENS	0.001500000000000000000000000000	USD	PROMPT
clqqpdjya000108lf3s4b4c4m	gpt-3.5-turbo-instruct	PER_1000_TOKENS	0.002000000000000000000000000000	USD	COMPLETION
clnnuiuq6000008l4dxp43wc6	claude-instant-1.2	PER_1000_TOKENS	0.001630000000000000000000000000	USD	PROMPT
clnnujlmj000108l48wne4ii9	claude-instant-1.2	PER_1000_TOKENS	0.005510000000000000000000000000	USD	COMPLETION
clnnukutg000208l49qqt9lyr	claude-instant-1.1	PER_1000_TOKENS	0.001630000000000000000000000000	USD	PROMPT
clnnun3x3000408l490qz9uv0	claude-instant-1.1	PER_1000_TOKENS	0.005510000000000000000000000000	USD	COMPLETION
clnnuosvy000508l4gsjy2pp4	claude-2.0	PER_1000_TOKENS	0.011020000000000000000000000000	USD	PROMPT
clnnuqcns000608l40qaz8trt	claude-2.0	PER_1000_TOKENS	0.032680000000000000000000000000	USD	COMPLETION
clnnuuif8000808l4gal4fjq4	claude-1.0	PER_1000_TOKENS	0.011020000000000000000000000000	USD	PROMPT
clnnutptp000708l47r091vvd	claude-1.0	PER_1000_TOKENS	0.032680000000000000000000000000	USD	COMPLETION
clnon8riv000308mlgfr1agiv	text-embedding-ada-002	PER_1000_TOKENS	0.000100000000000000000000000000	USD	PROMPT
clnon9kfz000408ml1bg81o6z	text-embedding-ada-002	PER_1000_TOKENS	0.000100000000000000000000000000	USD	COMPLETION
clqwniv8a000d08l2frjl7mmw	codechat-bison-32k	PER_1000_CHARS	0.000500000000000000000000000000	USD	PROMPT
clqwnj044000e08l2dfjm5g90	chat-bison-32k	PER_1000_CHARS	0.000500000000000000000000000000	USD	PROMPT
clqwnj47r000f08l2a16fekls	chat-bison-32k	PER_1000_CHARS	0.000500000000000000000000000000	USD	COMPLETION
clqwnj863000g08l2bwxgdapm	codechat-bison-32k	PER_1000_CHARS	0.000500000000000000000000000000	USD	COMPLETION
clqqpc2pr000008l3hvy63gxy1	gpt-35-turbo-1106	PER_1000_TOKENS	0.001000000000000000000000000000	USD	PROMPT
clqqpcb6d000208l3atrfbmou1	gpt-35-turbo-1106	PER_1000_TOKENS	0.002000000000000000000000000000	USD	COMPLETION
clqqpdh45000008lfgrnx76cv1	gpt-35-turbo-instruct	PER_1000_TOKENS	0.001500000000000000000000000000	USD	PROMPT
clqqpdjya000108lf3s4b4c4m1	gpt-35-turbo-instruct	PER_1000_TOKENS	0.002000000000000000000000000000	USD	COMPLETION
\.


--
-- Data for Name: project_memberships; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.project_memberships (project_id, user_id, created_at, updated_at, role) FROM stdin;
clwj3vu5000003hh22qhevccf	clwiyet8c0000lh4loaeumr54	2024-05-23 10:24:22.356	2024-05-23 10:24:22.356	OWNER
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.projects (id, created_at, name, updated_at, cloud_config) FROM stdin;
clwiyf37o0001lh4la34cyw7s	2024-05-23 07:51:22.884	test	2024-05-23 07:51:22.884	\N
clwj3vu5000003hh22qhevccf	2024-05-23 10:24:22.356	test	2024-05-23 10:24:22.356	\N
\.


--
-- Data for Name: prompts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.prompts (id, created_at, updated_at, project_id, created_by, name, version, is_active, config, prompt, type, tags, labels) FROM stdin;
\.


--
-- Data for Name: scores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scores (id, "timestamp", name, value, observation_id, trace_id, comment, source, project_id) FROM stdin;
\.


--
-- Data for Name: sso_configs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sso_configs (domain, created_at, updated_at, auth_provider, auth_config) FROM stdin;
\.


--
-- Data for Name: trace_sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.trace_sessions (id, created_at, updated_at, project_id, bookmarked, public) FROM stdin;
\.


--
-- Data for Name: traces; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.traces (id, "timestamp", name, project_id, metadata, external_id, user_id, release, version, public, bookmarked, input, output, session_id, tags, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, email_verified, password, image, created_at, updated_at, feature_flags, admin) FROM stdin;
clwiyet8c0000lh4loaeumr54	admin	admin@dep.com	\N	$2a$12$lUe2nQr2JDP7U44S7YGjvuvHmqK8ETZKD/bz5Kh8kNWUaP9YINoGm	\N	2024-05-23 07:51:09.949	2024-05-23 07:51:09.949	{}	f
\.


--
-- Data for Name: verification_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.verification_tokens (identifier, token, expires) FROM stdin;
\.


--
-- Name: Account Account_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Account"
    ADD CONSTRAINT "Account_pkey" PRIMARY KEY (id);


--
-- Name: Session Session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Session"
    ADD CONSTRAINT "Session_pkey" PRIMARY KEY (id);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: api_keys api_keys_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_keys
    ADD CONSTRAINT api_keys_pkey PRIMARY KEY (id);


--
-- Name: audit_logs audit_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_pkey PRIMARY KEY (id);


--
-- Name: cron_jobs cron_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cron_jobs
    ADD CONSTRAINT cron_jobs_pkey PRIMARY KEY (name);


--
-- Name: dataset_items dataset_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dataset_items
    ADD CONSTRAINT dataset_items_pkey PRIMARY KEY (id);


--
-- Name: dataset_run_items dataset_run_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dataset_run_items
    ADD CONSTRAINT dataset_run_items_pkey PRIMARY KEY (id);


--
-- Name: dataset_runs dataset_runs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dataset_runs
    ADD CONSTRAINT dataset_runs_pkey PRIMARY KEY (id);


--
-- Name: datasets datasets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datasets
    ADD CONSTRAINT datasets_pkey PRIMARY KEY (id);


--
-- Name: eval_templates eval_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_templates
    ADD CONSTRAINT eval_templates_pkey PRIMARY KEY (id);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: job_configurations job_configurations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_configurations
    ADD CONSTRAINT job_configurations_pkey PRIMARY KEY (id);


--
-- Name: job_executions job_executions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_executions
    ADD CONSTRAINT job_executions_pkey PRIMARY KEY (id);


--
-- Name: llm_api_keys llm_api_keys_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.llm_api_keys
    ADD CONSTRAINT llm_api_keys_pkey PRIMARY KEY (id);


--
-- Name: membership_invitations membership_invitations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.membership_invitations
    ADD CONSTRAINT membership_invitations_pkey PRIMARY KEY (id);


--
-- Name: models models_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.models
    ADD CONSTRAINT models_pkey PRIMARY KEY (id);


--
-- Name: observations observations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.observations
    ADD CONSTRAINT observations_pkey PRIMARY KEY (id);


--
-- Name: posthog_integrations posthog_integrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posthog_integrations
    ADD CONSTRAINT posthog_integrations_pkey PRIMARY KEY (project_id);


--
-- Name: pricings pricings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pricings
    ADD CONSTRAINT pricings_pkey PRIMARY KEY (id);


--
-- Name: project_memberships project_memberships_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_memberships
    ADD CONSTRAINT project_memberships_pkey PRIMARY KEY (project_id, user_id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: prompts prompts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prompts
    ADD CONSTRAINT prompts_pkey PRIMARY KEY (id);


--
-- Name: scores scores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scores
    ADD CONSTRAINT scores_pkey PRIMARY KEY (id);


--
-- Name: sso_configs sso_configs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sso_configs
    ADD CONSTRAINT sso_configs_pkey PRIMARY KEY (domain);


--
-- Name: trace_sessions trace_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trace_sessions
    ADD CONSTRAINT trace_sessions_pkey PRIMARY KEY (id, project_id);


--
-- Name: traces traces_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.traces
    ADD CONSTRAINT traces_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: Account_provider_providerAccountId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Account_provider_providerAccountId_key" ON public."Account" USING btree (provider, "providerAccountId");


--
-- Name: Account_user_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Account_user_id_idx" ON public."Account" USING btree (user_id);


--
-- Name: Session_session_token_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Session_session_token_key" ON public."Session" USING btree (session_token);


--
-- Name: api_keys_fast_hashed_secret_key_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_keys_fast_hashed_secret_key_idx ON public.api_keys USING btree (fast_hashed_secret_key);


--
-- Name: api_keys_fast_hashed_secret_key_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX api_keys_fast_hashed_secret_key_key ON public.api_keys USING btree (fast_hashed_secret_key);


--
-- Name: api_keys_hashed_secret_key_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_keys_hashed_secret_key_idx ON public.api_keys USING btree (hashed_secret_key);


--
-- Name: api_keys_hashed_secret_key_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX api_keys_hashed_secret_key_key ON public.api_keys USING btree (hashed_secret_key);


--
-- Name: api_keys_id_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX api_keys_id_key ON public.api_keys USING btree (id);


--
-- Name: api_keys_project_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_keys_project_id_idx ON public.api_keys USING btree (project_id);


--
-- Name: api_keys_public_key_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_keys_public_key_idx ON public.api_keys USING btree (public_key);


--
-- Name: api_keys_public_key_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX api_keys_public_key_key ON public.api_keys USING btree (public_key);


--
-- Name: audit_logs_created_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX audit_logs_created_at_idx ON public.audit_logs USING btree (created_at);


--
-- Name: audit_logs_project_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX audit_logs_project_id_idx ON public.audit_logs USING btree (project_id);


--
-- Name: dataset_items_dataset_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dataset_items_dataset_id_idx ON public.dataset_items USING hash (dataset_id);


--
-- Name: dataset_items_source_observation_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dataset_items_source_observation_id_idx ON public.dataset_items USING hash (source_observation_id);


--
-- Name: dataset_run_items_dataset_item_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dataset_run_items_dataset_item_id_idx ON public.dataset_run_items USING hash (dataset_item_id);


--
-- Name: dataset_run_items_dataset_run_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dataset_run_items_dataset_run_id_idx ON public.dataset_run_items USING hash (dataset_run_id);


--
-- Name: dataset_run_items_observation_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dataset_run_items_observation_id_idx ON public.dataset_run_items USING hash (observation_id);


--
-- Name: dataset_run_items_trace_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dataset_run_items_trace_id_idx ON public.dataset_run_items USING btree (trace_id);


--
-- Name: dataset_runs_dataset_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dataset_runs_dataset_id_idx ON public.dataset_runs USING hash (dataset_id);


--
-- Name: dataset_runs_dataset_id_name_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX dataset_runs_dataset_id_name_key ON public.dataset_runs USING btree (dataset_id, name);


--
-- Name: datasets_project_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX datasets_project_id_idx ON public.datasets USING hash (project_id);


--
-- Name: datasets_project_id_name_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX datasets_project_id_name_key ON public.datasets USING btree (project_id, name);


--
-- Name: eval_templates_project_id_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eval_templates_project_id_id_idx ON public.eval_templates USING btree (project_id, id);


--
-- Name: eval_templates_project_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eval_templates_project_id_idx ON public.eval_templates USING btree (project_id);


--
-- Name: eval_templates_project_id_name_version_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX eval_templates_project_id_name_version_key ON public.eval_templates USING btree (project_id, name, version);


--
-- Name: events_project_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX events_project_id_idx ON public.events USING btree (project_id);


--
-- Name: job_configurations_project_id_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX job_configurations_project_id_id_idx ON public.job_configurations USING btree (project_id, id);


--
-- Name: job_configurations_project_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX job_configurations_project_id_idx ON public.job_configurations USING btree (project_id);


--
-- Name: job_executions_project_id_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX job_executions_project_id_id_idx ON public.job_executions USING btree (project_id, id);


--
-- Name: job_executions_project_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX job_executions_project_id_idx ON public.job_executions USING btree (project_id);


--
-- Name: job_executions_project_id_status_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX job_executions_project_id_status_idx ON public.job_executions USING btree (project_id, status);


--
-- Name: llm_api_keys_id_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX llm_api_keys_id_key ON public.llm_api_keys USING btree (id);


--
-- Name: llm_api_keys_project_id_provider_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX llm_api_keys_project_id_provider_idx ON public.llm_api_keys USING btree (project_id, provider);


--
-- Name: llm_api_keys_project_id_provider_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX llm_api_keys_project_id_provider_key ON public.llm_api_keys USING btree (project_id, provider);


--
-- Name: membership_invitations_email_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX membership_invitations_email_idx ON public.membership_invitations USING btree (email);


--
-- Name: membership_invitations_id_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX membership_invitations_id_key ON public.membership_invitations USING btree (id);


--
-- Name: membership_invitations_project_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX membership_invitations_project_id_idx ON public.membership_invitations USING btree (project_id);


--
-- Name: models_model_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX models_model_name_idx ON public.models USING btree (model_name);


--
-- Name: models_project_id_model_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX models_project_id_model_name_idx ON public.models USING btree (project_id, model_name);


--
-- Name: models_project_id_model_name_start_date_unit_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX models_project_id_model_name_start_date_unit_idx ON public.models USING btree (project_id, model_name, start_date, unit);


--
-- Name: models_project_id_model_name_start_date_unit_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX models_project_id_model_name_start_date_unit_key ON public.models USING btree (project_id, model_name, start_date, unit);


--
-- Name: observations_created_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX observations_created_at_idx ON public.observations USING btree (created_at);


--
-- Name: observations_id_project_id_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX observations_id_project_id_key ON public.observations USING btree (id, project_id);


--
-- Name: observations_internal_model_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX observations_internal_model_idx ON public.observations USING btree (internal_model);


--
-- Name: observations_model_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX observations_model_idx ON public.observations USING btree (model);


--
-- Name: observations_parent_observation_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX observations_parent_observation_id_idx ON public.observations USING btree (parent_observation_id);


--
-- Name: observations_project_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX observations_project_id_idx ON public.observations USING btree (project_id);


--
-- Name: observations_project_id_internal_model_start_time_unit_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX observations_project_id_internal_model_start_time_unit_idx ON public.observations USING btree (project_id, internal_model, start_time, unit);


--
-- Name: observations_project_id_start_time_type_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX observations_project_id_start_time_type_idx ON public.observations USING btree (project_id, start_time, type);


--
-- Name: observations_prompt_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX observations_prompt_id_idx ON public.observations USING btree (prompt_id);


--
-- Name: observations_start_time_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX observations_start_time_idx ON public.observations USING btree (start_time);


--
-- Name: observations_trace_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX observations_trace_id_idx ON public.observations USING btree (trace_id);


--
-- Name: observations_trace_id_project_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX observations_trace_id_project_id_idx ON public.observations USING btree (trace_id, project_id);


--
-- Name: observations_trace_id_project_id_start_time_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX observations_trace_id_project_id_start_time_idx ON public.observations USING btree (trace_id, project_id, start_time);


--
-- Name: observations_trace_id_project_id_type_start_time_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX observations_trace_id_project_id_type_start_time_idx ON public.observations USING btree (trace_id, project_id, type, start_time);


--
-- Name: observations_type_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX observations_type_idx ON public.observations USING btree (type);


--
-- Name: posthog_integrations_project_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX posthog_integrations_project_id_idx ON public.posthog_integrations USING btree (project_id);


--
-- Name: pricings_model_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX pricings_model_name_idx ON public.pricings USING btree (model_name);


--
-- Name: project_memberships_user_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX project_memberships_user_id_idx ON public.project_memberships USING btree (user_id);


--
-- Name: prompts_project_id_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX prompts_project_id_id_idx ON public.prompts USING btree (project_id, id);


--
-- Name: prompts_project_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX prompts_project_id_idx ON public.prompts USING btree (project_id);


--
-- Name: prompts_project_id_name_version_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX prompts_project_id_name_version_idx ON public.prompts USING btree (project_id, name, version);


--
-- Name: prompts_project_id_name_version_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX prompts_project_id_name_version_key ON public.prompts USING btree (project_id, name, version);


--
-- Name: prompts_tags_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX prompts_tags_idx ON public.prompts USING gin (tags);


--
-- Name: scores_id_project_id_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX scores_id_project_id_key ON public.scores USING btree (id, project_id);


--
-- Name: scores_observation_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX scores_observation_id_idx ON public.scores USING hash (observation_id);


--
-- Name: scores_project_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX scores_project_id_idx ON public.scores USING btree (project_id);


--
-- Name: scores_source_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX scores_source_idx ON public.scores USING btree (source);


--
-- Name: scores_timestamp_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX scores_timestamp_idx ON public.scores USING btree ("timestamp");


--
-- Name: scores_trace_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX scores_trace_id_idx ON public.scores USING hash (trace_id);


--
-- Name: scores_value_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX scores_value_idx ON public.scores USING btree (value);


--
-- Name: trace_sessions_created_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX trace_sessions_created_at_idx ON public.trace_sessions USING btree (created_at);


--
-- Name: trace_sessions_project_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX trace_sessions_project_id_idx ON public.trace_sessions USING btree (project_id);


--
-- Name: traces_created_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX traces_created_at_idx ON public.traces USING btree (created_at);


--
-- Name: traces_external_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX traces_external_id_idx ON public.traces USING btree (external_id);


--
-- Name: traces_id_user_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX traces_id_user_id_idx ON public.traces USING btree (id, user_id);


--
-- Name: traces_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX traces_name_idx ON public.traces USING btree (name);


--
-- Name: traces_project_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX traces_project_id_idx ON public.traces USING btree (project_id);


--
-- Name: traces_release_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX traces_release_idx ON public.traces USING btree (release);


--
-- Name: traces_session_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX traces_session_id_idx ON public.traces USING btree (session_id);


--
-- Name: traces_tags_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX traces_tags_idx ON public.traces USING gin (tags);


--
-- Name: traces_timestamp_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX traces_timestamp_idx ON public.traces USING btree ("timestamp");


--
-- Name: traces_updated_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX traces_updated_at_idx ON public.traces USING btree (updated_at);


--
-- Name: traces_user_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX traces_user_id_idx ON public.traces USING btree (user_id);


--
-- Name: users_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX users_email_key ON public.users USING btree (email);


--
-- Name: verification_tokens_identifier_token_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX verification_tokens_identifier_token_key ON public.verification_tokens USING btree (identifier, token);


--
-- Name: verification_tokens_token_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX verification_tokens_token_key ON public.verification_tokens USING btree (token);


--
-- Name: Account Account_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Account"
    ADD CONSTRAINT "Account_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Session Session_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Session"
    ADD CONSTRAINT "Session_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: api_keys api_keys_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_keys
    ADD CONSTRAINT api_keys_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: audit_logs audit_logs_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: audit_logs audit_logs_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: dataset_items dataset_items_dataset_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dataset_items
    ADD CONSTRAINT dataset_items_dataset_id_fkey FOREIGN KEY (dataset_id) REFERENCES public.datasets(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: dataset_items dataset_items_source_observation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dataset_items
    ADD CONSTRAINT dataset_items_source_observation_id_fkey FOREIGN KEY (source_observation_id) REFERENCES public.observations(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: dataset_items dataset_items_source_trace_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dataset_items
    ADD CONSTRAINT dataset_items_source_trace_id_fkey FOREIGN KEY (source_trace_id) REFERENCES public.traces(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: dataset_run_items dataset_run_items_dataset_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dataset_run_items
    ADD CONSTRAINT dataset_run_items_dataset_item_id_fkey FOREIGN KEY (dataset_item_id) REFERENCES public.dataset_items(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: dataset_run_items dataset_run_items_dataset_run_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dataset_run_items
    ADD CONSTRAINT dataset_run_items_dataset_run_id_fkey FOREIGN KEY (dataset_run_id) REFERENCES public.dataset_runs(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: dataset_run_items dataset_run_items_observation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dataset_run_items
    ADD CONSTRAINT dataset_run_items_observation_id_fkey FOREIGN KEY (observation_id) REFERENCES public.observations(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: dataset_run_items dataset_run_items_trace_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dataset_run_items
    ADD CONSTRAINT dataset_run_items_trace_id_fkey FOREIGN KEY (trace_id) REFERENCES public.traces(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: dataset_runs dataset_runs_dataset_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dataset_runs
    ADD CONSTRAINT dataset_runs_dataset_id_fkey FOREIGN KEY (dataset_id) REFERENCES public.datasets(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: datasets datasets_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datasets
    ADD CONSTRAINT datasets_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: eval_templates eval_templates_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eval_templates
    ADD CONSTRAINT eval_templates_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: events events_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: job_configurations job_configurations_eval_template_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_configurations
    ADD CONSTRAINT job_configurations_eval_template_id_fkey FOREIGN KEY (eval_template_id) REFERENCES public.eval_templates(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: job_configurations job_configurations_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_configurations
    ADD CONSTRAINT job_configurations_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: job_executions job_executions_job_configuration_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_executions
    ADD CONSTRAINT job_executions_job_configuration_id_fkey FOREIGN KEY (job_configuration_id) REFERENCES public.job_configurations(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: job_executions job_executions_job_input_trace_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_executions
    ADD CONSTRAINT job_executions_job_input_trace_id_fkey FOREIGN KEY (job_input_trace_id) REFERENCES public.traces(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: job_executions job_executions_job_output_score_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_executions
    ADD CONSTRAINT job_executions_job_output_score_id_fkey FOREIGN KEY (job_output_score_id) REFERENCES public.scores(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: job_executions job_executions_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_executions
    ADD CONSTRAINT job_executions_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: llm_api_keys llm_api_keys_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.llm_api_keys
    ADD CONSTRAINT llm_api_keys_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: membership_invitations membership_invitations_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.membership_invitations
    ADD CONSTRAINT membership_invitations_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: membership_invitations membership_invitations_sender_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.membership_invitations
    ADD CONSTRAINT membership_invitations_sender_id_fkey FOREIGN KEY (sender_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: models models_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.models
    ADD CONSTRAINT models_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: observations observations_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.observations
    ADD CONSTRAINT observations_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: observations observations_prompt_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.observations
    ADD CONSTRAINT observations_prompt_id_fkey FOREIGN KEY (prompt_id) REFERENCES public.prompts(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: posthog_integrations posthog_integrations_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posthog_integrations
    ADD CONSTRAINT posthog_integrations_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: project_memberships project_memberships_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_memberships
    ADD CONSTRAINT project_memberships_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: project_memberships project_memberships_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_memberships
    ADD CONSTRAINT project_memberships_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: prompts prompts_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prompts
    ADD CONSTRAINT prompts_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: scores scores_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scores
    ADD CONSTRAINT scores_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: trace_sessions trace_sessions_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trace_sessions
    ADD CONSTRAINT trace_sessions_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: traces traces_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.traces
    ADD CONSTRAINT traces_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: traces traces_session_id_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.traces
    ADD CONSTRAINT traces_session_id_project_id_fkey FOREIGN KEY (session_id, project_id) REFERENCES public.trace_sessions(id, project_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: DATABASE langfuse; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON DATABASE langfuse TO langfuse;


--
-- PostgreSQL database dump complete
--

--
-- Database "litellm" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3 (Ubuntu 16.3-1.pgdg22.04+1)

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
-- Name: litellm; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE litellm WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE litellm OWNER TO postgres;

\connect litellm

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
-- Name: LiteLLM_SpendLogs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."LiteLLM_SpendLogs" (
    request_id text NOT NULL,
    call_type text NOT NULL,
    api_key text DEFAULT ''::text NOT NULL,
    spend double precision DEFAULT 0.0 NOT NULL,
    total_tokens integer DEFAULT 0 NOT NULL,
    prompt_tokens integer DEFAULT 0 NOT NULL,
    completion_tokens integer DEFAULT 0 NOT NULL,
    "startTime" timestamp(3) without time zone NOT NULL,
    "endTime" timestamp(3) without time zone NOT NULL,
    model text DEFAULT ''::text NOT NULL,
    api_base text DEFAULT ''::text NOT NULL,
    "user" text DEFAULT ''::text NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    cache_hit text DEFAULT ''::text NOT NULL,
    cache_key text DEFAULT ''::text NOT NULL,
    request_tags jsonb DEFAULT '[]'::jsonb NOT NULL,
    team_id text,
    end_user text
);


ALTER TABLE public."LiteLLM_SpendLogs" OWNER TO postgres;

--
-- Name: LiteLLM_VerificationToken; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."LiteLLM_VerificationToken" (
    token text NOT NULL,
    key_name text,
    key_alias text,
    soft_budget_cooldown boolean DEFAULT false NOT NULL,
    spend double precision DEFAULT 0.0 NOT NULL,
    expires timestamp(3) without time zone,
    models text[],
    aliases jsonb DEFAULT '{}'::jsonb NOT NULL,
    config jsonb DEFAULT '{}'::jsonb NOT NULL,
    user_id text,
    team_id text,
    permissions jsonb DEFAULT '{}'::jsonb NOT NULL,
    max_parallel_requests integer,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    tpm_limit bigint,
    rpm_limit bigint,
    max_budget double precision,
    budget_duration text,
    budget_reset_at timestamp(3) without time zone,
    allowed_cache_controls text[] DEFAULT ARRAY[]::text[],
    model_spend jsonb DEFAULT '{}'::jsonb NOT NULL,
    model_max_budget jsonb DEFAULT '{}'::jsonb NOT NULL,
    budget_id text
);


ALTER TABLE public."LiteLLM_VerificationToken" OWNER TO postgres;

--
-- Name: Last30dKeysBySpend; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."Last30dKeysBySpend" AS
 SELECT l.api_key,
    v.key_alias,
    v.key_name,
    sum(l.spend) AS total_spend
   FROM (public."LiteLLM_SpendLogs" l
     LEFT JOIN public."LiteLLM_VerificationToken" v ON ((l.api_key = v.token)))
  WHERE (l."startTime" >= (CURRENT_DATE - '30 days'::interval))
  GROUP BY l.api_key, v.key_alias, v.key_name
  ORDER BY (sum(l.spend)) DESC;


ALTER VIEW public."Last30dKeysBySpend" OWNER TO postgres;

--
-- Name: Last30dModelsBySpend; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."Last30dModelsBySpend" AS
 SELECT model,
    sum(spend) AS total_spend
   FROM public."LiteLLM_SpendLogs"
  WHERE (("startTime" >= (CURRENT_DATE - '30 days'::interval)) AND (model <> ''::text))
  GROUP BY model
  ORDER BY (sum(spend)) DESC;


ALTER VIEW public."Last30dModelsBySpend" OWNER TO postgres;

--
-- Name: Last30dTopEndUsersSpend; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."Last30dTopEndUsersSpend" AS
 SELECT end_user,
    count(*) AS total_events,
    sum(spend) AS total_spend
   FROM public."LiteLLM_SpendLogs"
  WHERE ((end_user <> ''::text) AND (end_user <> USER) AND ("startTime" >= (CURRENT_DATE - '30 days'::interval)))
  GROUP BY end_user
  ORDER BY (sum(spend)) DESC
 LIMIT 100;


ALTER VIEW public."Last30dTopEndUsersSpend" OWNER TO postgres;

--
-- Name: LiteLLM_BudgetTable; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."LiteLLM_BudgetTable" (
    budget_id text NOT NULL,
    max_budget double precision,
    soft_budget double precision,
    max_parallel_requests integer,
    tpm_limit bigint,
    rpm_limit bigint,
    model_max_budget jsonb,
    budget_duration text,
    budget_reset_at timestamp(3) without time zone,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_by text NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_by text NOT NULL
);


ALTER TABLE public."LiteLLM_BudgetTable" OWNER TO postgres;

--
-- Name: LiteLLM_Config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."LiteLLM_Config" (
    param_name text NOT NULL,
    param_value jsonb
);


ALTER TABLE public."LiteLLM_Config" OWNER TO postgres;

--
-- Name: LiteLLM_EndUserTable; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."LiteLLM_EndUserTable" (
    user_id text NOT NULL,
    alias text,
    spend double precision DEFAULT 0.0 NOT NULL,
    budget_id text,
    blocked boolean DEFAULT false NOT NULL
);


ALTER TABLE public."LiteLLM_EndUserTable" OWNER TO postgres;

--
-- Name: LiteLLM_ModelTable; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."LiteLLM_ModelTable" (
    id integer NOT NULL,
    aliases jsonb,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_by text NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_by text NOT NULL
);


ALTER TABLE public."LiteLLM_ModelTable" OWNER TO postgres;

--
-- Name: LiteLLM_ModelTable_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."LiteLLM_ModelTable_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."LiteLLM_ModelTable_id_seq" OWNER TO postgres;

--
-- Name: LiteLLM_ModelTable_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."LiteLLM_ModelTable_id_seq" OWNED BY public."LiteLLM_ModelTable".id;


--
-- Name: LiteLLM_OrganizationTable; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."LiteLLM_OrganizationTable" (
    organization_id text NOT NULL,
    organization_alias text NOT NULL,
    budget_id text NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    models text[],
    spend double precision DEFAULT 0.0 NOT NULL,
    model_spend jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_by text NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_by text NOT NULL
);


ALTER TABLE public."LiteLLM_OrganizationTable" OWNER TO postgres;

--
-- Name: LiteLLM_ProxyModelTable; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."LiteLLM_ProxyModelTable" (
    model_id text NOT NULL,
    model_name text NOT NULL,
    litellm_params jsonb NOT NULL,
    model_info jsonb,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_by text NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_by text NOT NULL
);


ALTER TABLE public."LiteLLM_ProxyModelTable" OWNER TO postgres;

--
-- Name: LiteLLM_TeamTable; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."LiteLLM_TeamTable" (
    team_id text NOT NULL,
    team_alias text,
    organization_id text,
    admins text[],
    members text[],
    members_with_roles jsonb DEFAULT '{}'::jsonb NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    max_budget double precision,
    spend double precision DEFAULT 0.0 NOT NULL,
    models text[],
    max_parallel_requests integer,
    tpm_limit bigint,
    rpm_limit bigint,
    budget_duration text,
    budget_reset_at timestamp(3) without time zone,
    blocked boolean DEFAULT false NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    model_spend jsonb DEFAULT '{}'::jsonb NOT NULL,
    model_max_budget jsonb DEFAULT '{}'::jsonb NOT NULL,
    model_id integer
);


ALTER TABLE public."LiteLLM_TeamTable" OWNER TO postgres;

--
-- Name: LiteLLM_UserNotifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."LiteLLM_UserNotifications" (
    request_id text NOT NULL,
    user_id text NOT NULL,
    models text[],
    justification text NOT NULL,
    status text NOT NULL
);


ALTER TABLE public."LiteLLM_UserNotifications" OWNER TO postgres;

--
-- Name: LiteLLM_UserTable; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."LiteLLM_UserTable" (
    user_id text NOT NULL,
    user_alias text,
    team_id text,
    organization_id text,
    teams text[] DEFAULT ARRAY[]::text[],
    user_role text,
    max_budget double precision,
    spend double precision DEFAULT 0.0 NOT NULL,
    user_email text,
    models text[],
    max_parallel_requests integer,
    tpm_limit bigint,
    rpm_limit bigint,
    budget_duration text,
    budget_reset_at timestamp(3) without time zone,
    allowed_cache_controls text[] DEFAULT ARRAY[]::text[],
    model_spend jsonb DEFAULT '{}'::jsonb NOT NULL,
    model_max_budget jsonb DEFAULT '{}'::jsonb NOT NULL
);


ALTER TABLE public."LiteLLM_UserTable" OWNER TO postgres;

--
-- Name: LiteLLM_VerificationTokenView; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."LiteLLM_VerificationTokenView" AS
 SELECT v.token,
    v.key_name,
    v.key_alias,
    v.soft_budget_cooldown,
    v.spend,
    v.expires,
    v.models,
    v.aliases,
    v.config,
    v.user_id,
    v.team_id,
    v.permissions,
    v.max_parallel_requests,
    v.metadata,
    v.tpm_limit,
    v.rpm_limit,
    v.max_budget,
    v.budget_duration,
    v.budget_reset_at,
    v.allowed_cache_controls,
    v.model_spend,
    v.model_max_budget,
    v.budget_id,
    t.spend AS team_spend,
    t.max_budget AS team_max_budget,
    t.tpm_limit AS team_tpm_limit,
    t.rpm_limit AS team_rpm_limit
   FROM (public."LiteLLM_VerificationToken" v
     LEFT JOIN public."LiteLLM_TeamTable" t ON ((v.team_id = t.team_id)));


ALTER VIEW public."LiteLLM_VerificationTokenView" OWNER TO postgres;

--
-- Name: MonthlyGlobalSpend; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."MonthlyGlobalSpend" AS
 SELECT date("startTime") AS date,
    sum(spend) AS spend
   FROM public."LiteLLM_SpendLogs"
  WHERE ("startTime" >= (CURRENT_DATE - '30 days'::interval))
  GROUP BY (date("startTime"));


ALTER VIEW public."MonthlyGlobalSpend" OWNER TO postgres;

--
-- Name: MonthlyGlobalSpendPerKey; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."MonthlyGlobalSpendPerKey" AS
 SELECT date("startTime") AS date,
    sum(spend) AS spend,
    api_key
   FROM public."LiteLLM_SpendLogs"
  WHERE ("startTime" >= (CURRENT_DATE - '30 days'::interval))
  GROUP BY (date("startTime")), api_key;


ALTER VIEW public."MonthlyGlobalSpendPerKey" OWNER TO postgres;

--
-- Name: LiteLLM_ModelTable id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."LiteLLM_ModelTable" ALTER COLUMN id SET DEFAULT nextval('public."LiteLLM_ModelTable_id_seq"'::regclass);


--
-- Data for Name: LiteLLM_BudgetTable; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."LiteLLM_BudgetTable" (budget_id, max_budget, soft_budget, max_parallel_requests, tpm_limit, rpm_limit, model_max_budget, budget_duration, budget_reset_at, created_at, created_by, updated_at, updated_by) FROM stdin;
\.


--
-- Data for Name: LiteLLM_Config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."LiteLLM_Config" (param_name, param_value) FROM stdin;
\.


--
-- Data for Name: LiteLLM_EndUserTable; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."LiteLLM_EndUserTable" (user_id, alias, spend, budget_id, blocked) FROM stdin;
\.


--
-- Data for Name: LiteLLM_ModelTable; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."LiteLLM_ModelTable" (id, aliases, created_at, created_by, updated_at, updated_by) FROM stdin;
\.


--
-- Data for Name: LiteLLM_OrganizationTable; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."LiteLLM_OrganizationTable" (organization_id, organization_alias, budget_id, metadata, models, spend, model_spend, created_at, created_by, updated_at, updated_by) FROM stdin;
\.


--
-- Data for Name: LiteLLM_ProxyModelTable; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."LiteLLM_ProxyModelTable" (model_id, model_name, litellm_params, model_info, created_at, created_by, updated_at, updated_by) FROM stdin;
\.


--
-- Data for Name: LiteLLM_SpendLogs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."LiteLLM_SpendLogs" (request_id, call_type, api_key, spend, total_tokens, prompt_tokens, completion_tokens, "startTime", "endTime", model, api_base, "user", metadata, cache_hit, cache_key, request_tags, team_id, end_user) FROM stdin;
\.


--
-- Data for Name: LiteLLM_TeamTable; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."LiteLLM_TeamTable" (team_id, team_alias, organization_id, admins, members, members_with_roles, metadata, max_budget, spend, models, max_parallel_requests, tpm_limit, rpm_limit, budget_duration, budget_reset_at, blocked, created_at, updated_at, model_spend, model_max_budget, model_id) FROM stdin;
\.


--
-- Data for Name: LiteLLM_UserNotifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."LiteLLM_UserNotifications" (request_id, user_id, models, justification, status) FROM stdin;
\.


--
-- Data for Name: LiteLLM_UserTable; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."LiteLLM_UserTable" (user_id, user_alias, team_id, organization_id, teams, user_role, max_budget, spend, user_email, models, max_parallel_requests, tpm_limit, rpm_limit, budget_duration, budget_reset_at, allowed_cache_controls, model_spend, model_max_budget) FROM stdin;
default_user_id	\N	\N	\N	{}	proxy_admin	\N	0	\N	{}	\N	\N	\N	\N	\N	{}	{}	{}
\.


--
-- Data for Name: LiteLLM_VerificationToken; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."LiteLLM_VerificationToken" (token, key_name, key_alias, soft_budget_cooldown, spend, expires, models, aliases, config, user_id, team_id, permissions, max_parallel_requests, metadata, tpm_limit, rpm_limit, max_budget, budget_duration, budget_reset_at, allowed_cache_controls, model_spend, model_max_budget, budget_id) FROM stdin;
f733c66cb57971e1e9ebdd5a7a312cda1bc76b8ed6cfe6cab481f1087cf78753	sk-...word	\N	f	0	\N	{}	{}	{}	default_user_id	\N	{}	\N	{}	\N	\N	\N	\N	\N	{}	{}	{}	\N
4093e6c9825bb9e1a58a92cf361059427305247c401ac215aabda2a692bc95f7	sk-...ZRdg	\N	f	0	2024-05-30 08:10:44.998	{}	{}	{}	default_user_id	litellm-dashboard	{}	\N	{}	\N	\N	5	\N	\N	{}	{}	{}	\N
1e2a93907ba237e4a371b8824784b63f76a2b0f4b9b64b1464061942b27f1f05	sk-...5EDQ	default	f	0	\N	{all-team-models}	{}	{}	admin	\N	{}	\N	{}	\N	\N	\N	\N	\N	{}	{}	{}	\N
\.


--
-- Name: LiteLLM_ModelTable_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."LiteLLM_ModelTable_id_seq"', 1, false);


--
-- Name: LiteLLM_BudgetTable LiteLLM_BudgetTable_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."LiteLLM_BudgetTable"
    ADD CONSTRAINT "LiteLLM_BudgetTable_pkey" PRIMARY KEY (budget_id);


--
-- Name: LiteLLM_Config LiteLLM_Config_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."LiteLLM_Config"
    ADD CONSTRAINT "LiteLLM_Config_pkey" PRIMARY KEY (param_name);


--
-- Name: LiteLLM_EndUserTable LiteLLM_EndUserTable_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."LiteLLM_EndUserTable"
    ADD CONSTRAINT "LiteLLM_EndUserTable_pkey" PRIMARY KEY (user_id);


--
-- Name: LiteLLM_ModelTable LiteLLM_ModelTable_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."LiteLLM_ModelTable"
    ADD CONSTRAINT "LiteLLM_ModelTable_pkey" PRIMARY KEY (id);


--
-- Name: LiteLLM_OrganizationTable LiteLLM_OrganizationTable_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."LiteLLM_OrganizationTable"
    ADD CONSTRAINT "LiteLLM_OrganizationTable_pkey" PRIMARY KEY (organization_id);


--
-- Name: LiteLLM_ProxyModelTable LiteLLM_ProxyModelTable_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."LiteLLM_ProxyModelTable"
    ADD CONSTRAINT "LiteLLM_ProxyModelTable_pkey" PRIMARY KEY (model_id);


--
-- Name: LiteLLM_SpendLogs LiteLLM_SpendLogs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."LiteLLM_SpendLogs"
    ADD CONSTRAINT "LiteLLM_SpendLogs_pkey" PRIMARY KEY (request_id);


--
-- Name: LiteLLM_TeamTable LiteLLM_TeamTable_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."LiteLLM_TeamTable"
    ADD CONSTRAINT "LiteLLM_TeamTable_pkey" PRIMARY KEY (team_id);


--
-- Name: LiteLLM_UserNotifications LiteLLM_UserNotifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."LiteLLM_UserNotifications"
    ADD CONSTRAINT "LiteLLM_UserNotifications_pkey" PRIMARY KEY (request_id);


--
-- Name: LiteLLM_UserTable LiteLLM_UserTable_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."LiteLLM_UserTable"
    ADD CONSTRAINT "LiteLLM_UserTable_pkey" PRIMARY KEY (user_id);


--
-- Name: LiteLLM_VerificationToken LiteLLM_VerificationToken_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."LiteLLM_VerificationToken"
    ADD CONSTRAINT "LiteLLM_VerificationToken_pkey" PRIMARY KEY (token);


--
-- Name: LiteLLM_TeamTable_model_id_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "LiteLLM_TeamTable_model_id_key" ON public."LiteLLM_TeamTable" USING btree (model_id);


--
-- Name: LiteLLM_EndUserTable LiteLLM_EndUserTable_budget_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."LiteLLM_EndUserTable"
    ADD CONSTRAINT "LiteLLM_EndUserTable_budget_id_fkey" FOREIGN KEY (budget_id) REFERENCES public."LiteLLM_BudgetTable"(budget_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: LiteLLM_OrganizationTable LiteLLM_OrganizationTable_budget_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."LiteLLM_OrganizationTable"
    ADD CONSTRAINT "LiteLLM_OrganizationTable_budget_id_fkey" FOREIGN KEY (budget_id) REFERENCES public."LiteLLM_BudgetTable"(budget_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: LiteLLM_TeamTable LiteLLM_TeamTable_model_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."LiteLLM_TeamTable"
    ADD CONSTRAINT "LiteLLM_TeamTable_model_id_fkey" FOREIGN KEY (model_id) REFERENCES public."LiteLLM_ModelTable"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: LiteLLM_TeamTable LiteLLM_TeamTable_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."LiteLLM_TeamTable"
    ADD CONSTRAINT "LiteLLM_TeamTable_organization_id_fkey" FOREIGN KEY (organization_id) REFERENCES public."LiteLLM_OrganizationTable"(organization_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: LiteLLM_UserTable LiteLLM_UserTable_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."LiteLLM_UserTable"
    ADD CONSTRAINT "LiteLLM_UserTable_organization_id_fkey" FOREIGN KEY (organization_id) REFERENCES public."LiteLLM_OrganizationTable"(organization_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: LiteLLM_VerificationToken LiteLLM_VerificationToken_budget_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."LiteLLM_VerificationToken"
    ADD CONSTRAINT "LiteLLM_VerificationToken_budget_id_fkey" FOREIGN KEY (budget_id) REFERENCES public."LiteLLM_BudgetTable"(budget_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: DATABASE litellm; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON DATABASE litellm TO litellm;


--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3 (Ubuntu 16.3-1.pgdg22.04+1)

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
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

