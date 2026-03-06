--
-- PostgreSQL database dump
--

\restrict H9zkZCBLHq7yo2giYYkA1FaABRWhOjZ1dGn405dJXalGvp2YztEr2RQDliWbSuf

-- Dumped from database version 15.16
-- Dumped by pg_dump version 17.8 (Debian 17.8-0+deb13u1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.expenses_userpreference DROP CONSTRAINT IF EXISTS expenses_userpreference_user_id_08efa16a_fk_accounts_user_id;
ALTER TABLE IF EXISTS ONLY public.expenses_transactionauditlog DROP CONSTRAINT IF EXISTS expenses_transaction_user_id_5f453da2_fk_accounts_;
ALTER TABLE IF EXISTS ONLY public.expenses_transactionattachment DROP CONSTRAINT IF EXISTS expenses_transaction_transaction_id_8edab4a4_fk_expenses_;
ALTER TABLE IF EXISTS ONLY public.expenses_transaction DROP CONSTRAINT IF EXISTS expenses_transaction_to_payment_method_id_a9d0afc9_fk_expenses_;
ALTER TABLE IF EXISTS ONLY public.expenses_transactiontemplate DROP CONSTRAINT IF EXISTS expenses_transaction_payment_method_id_b13cc6f4_fk_expenses_;
ALTER TABLE IF EXISTS ONLY public.expenses_transaction DROP CONSTRAINT IF EXISTS expenses_transaction_payment_method_id_5a1c5a8f_fk_expenses_;
ALTER TABLE IF EXISTS ONLY public.expenses_transaction DROP CONSTRAINT IF EXISTS expenses_transaction_paired_transaction_i_8d0be226_fk_expenses_;
ALTER TABLE IF EXISTS ONLY public.expenses_transaction DROP CONSTRAINT IF EXISTS expenses_transaction_category_id_9fc142ec_fk_expenses_;
ALTER TABLE IF EXISTS ONLY public.expenses_transactiontemplate DROP CONSTRAINT IF EXISTS expenses_transaction_category_id_7738bdf7_fk_expenses_;
ALTER TABLE IF EXISTS ONLY public.expenses_sharedexpense DROP CONSTRAINT IF EXISTS expenses_sharedexpen_transaction_id_08caa5e2_fk_expenses_;
ALTER TABLE IF EXISTS ONLY public.expenses_recurringexpense DROP CONSTRAINT IF EXISTS expenses_recurringex_to_payment_method_id_382f1e13_fk_expenses_;
ALTER TABLE IF EXISTS ONLY public.expenses_recurringexpense DROP CONSTRAINT IF EXISTS expenses_recurringex_payment_method_id_c675cb83_fk_expenses_;
ALTER TABLE IF EXISTS ONLY public.expenses_recurringexpense DROP CONSTRAINT IF EXISTS expenses_recurringex_category_id_6bdaf48b_fk_expenses_;
ALTER TABLE IF EXISTS ONLY public.expenses_budgetlimit DROP CONSTRAINT IF EXISTS expenses_budgetlimit_category_id_8702956a_fk_expenses_;
ALTER TABLE IF EXISTS ONLY public.django_admin_log DROP CONSTRAINT IF EXISTS django_admin_log_user_id_c564eba6_fk_accounts_user_id;
ALTER TABLE IF EXISTS ONLY public.django_admin_log DROP CONSTRAINT IF EXISTS django_admin_log_content_type_id_c4bce8eb_fk_django_co;
ALTER TABLE IF EXISTS ONLY public.auth_permission DROP CONSTRAINT IF EXISTS auth_permission_content_type_id_2f476e4b_fk_django_co;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissions_group_id_b120cbf9_fk_auth_group_id;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissio_permission_id_84c5c92e_fk_auth_perm;
ALTER TABLE IF EXISTS ONLY public.accounts_user_user_permissions DROP CONSTRAINT IF EXISTS accounts_user_user_p_user_id_e4f0a161_fk_accounts_;
ALTER TABLE IF EXISTS ONLY public.accounts_user_user_permissions DROP CONSTRAINT IF EXISTS accounts_user_user_p_permission_id_113bb443_fk_auth_perm;
ALTER TABLE IF EXISTS ONLY public.accounts_user_groups DROP CONSTRAINT IF EXISTS accounts_user_groups_user_id_52b62117_fk_accounts_user_id;
ALTER TABLE IF EXISTS ONLY public.accounts_user_groups DROP CONSTRAINT IF EXISTS accounts_user_groups_group_id_bd11a704_fk_auth_group_id;
ALTER TABLE IF EXISTS ONLY public.accounts_memberpermission DROP CONSTRAINT IF EXISTS accounts_memberpermission_user_id_d3018dff_fk_accounts_user_id;
ALTER TABLE IF EXISTS ONLY public.accounts_hiddenpaymentmethod DROP CONSTRAINT IF EXISTS accounts_hiddenpayme_permission_id_fc477aae_fk_accounts_;
DROP INDEX IF EXISTS public.expenses_transactiontemplate_payment_method_id_b13cc6f4;
DROP INDEX IF EXISTS public.expenses_transactiontemplate_category_id_7738bdf7;
DROP INDEX IF EXISTS public.expenses_transactionauditlog_user_id_5f453da2;
DROP INDEX IF EXISTS public.expenses_transactionattachment_transaction_id_8edab4a4;
DROP INDEX IF EXISTS public.expenses_transaction_to_payment_method_id_a9d0afc9;
DROP INDEX IF EXISTS public.expenses_transaction_payment_method_id_5a1c5a8f;
DROP INDEX IF EXISTS public.expenses_transaction_category_id_9fc142ec;
DROP INDEX IF EXISTS public.expenses_sharedexpense_transaction_id_08caa5e2;
DROP INDEX IF EXISTS public.expenses_recurringexpense_to_payment_method_id_382f1e13;
DROP INDEX IF EXISTS public.expenses_recurringexpense_payment_method_id_c675cb83;
DROP INDEX IF EXISTS public.expenses_recurringexpense_category_id_6bdaf48b;
DROP INDEX IF EXISTS public.expenses_paymentmethod_name_e09449d3_like;
DROP INDEX IF EXISTS public.expenses_category_name_319529bb_like;
DROP INDEX IF EXISTS public.expenses_budgetlimit_category_id_8702956a;
DROP INDEX IF EXISTS public.django_session_session_key_c0390e0f_like;
DROP INDEX IF EXISTS public.django_session_expire_date_a5c62663;
DROP INDEX IF EXISTS public.django_admin_log_user_id_c564eba6;
DROP INDEX IF EXISTS public.django_admin_log_content_type_id_c4bce8eb;
DROP INDEX IF EXISTS public.auth_permission_content_type_id_2f476e4b;
DROP INDEX IF EXISTS public.auth_group_permissions_permission_id_84c5c92e;
DROP INDEX IF EXISTS public.auth_group_permissions_group_id_b120cbf9;
DROP INDEX IF EXISTS public.auth_group_name_a6ea08ec_like;
DROP INDEX IF EXISTS public.accounts_user_username_6088629e_like;
DROP INDEX IF EXISTS public.accounts_user_user_permissions_user_id_e4f0a161;
DROP INDEX IF EXISTS public.accounts_user_user_permissions_permission_id_113bb443;
DROP INDEX IF EXISTS public.accounts_user_groups_user_id_52b62117;
DROP INDEX IF EXISTS public.accounts_user_groups_group_id_bd11a704;
DROP INDEX IF EXISTS public.accounts_hiddenpaymentmethod_permission_id_fc477aae;
ALTER TABLE IF EXISTS ONLY public.expenses_userpreference DROP CONSTRAINT IF EXISTS expenses_userpreference_user_id_key;
ALTER TABLE IF EXISTS ONLY public.expenses_userpreference DROP CONSTRAINT IF EXISTS expenses_userpreference_pkey;
ALTER TABLE IF EXISTS ONLY public.expenses_transactiontemplate DROP CONSTRAINT IF EXISTS expenses_transactiontemplate_pkey;
ALTER TABLE IF EXISTS ONLY public.expenses_transactionauditlog DROP CONSTRAINT IF EXISTS expenses_transactionauditlog_pkey;
ALTER TABLE IF EXISTS ONLY public.expenses_transactionattachment DROP CONSTRAINT IF EXISTS expenses_transactionattachment_pkey;
ALTER TABLE IF EXISTS ONLY public.expenses_transaction DROP CONSTRAINT IF EXISTS expenses_transaction_pkey;
ALTER TABLE IF EXISTS ONLY public.expenses_transaction DROP CONSTRAINT IF EXISTS expenses_transaction_paired_transaction_id_key;
ALTER TABLE IF EXISTS ONLY public.expenses_sharedexpense DROP CONSTRAINT IF EXISTS expenses_sharedexpense_pkey;
ALTER TABLE IF EXISTS ONLY public.expenses_recurringexpense DROP CONSTRAINT IF EXISTS expenses_recurringexpense_pkey;
ALTER TABLE IF EXISTS ONLY public.expenses_paymentmethod DROP CONSTRAINT IF EXISTS expenses_paymentmethod_pkey;
ALTER TABLE IF EXISTS ONLY public.expenses_paymentmethod DROP CONSTRAINT IF EXISTS expenses_paymentmethod_name_key;
ALTER TABLE IF EXISTS ONLY public.expenses_category DROP CONSTRAINT IF EXISTS expenses_category_pkey;
ALTER TABLE IF EXISTS ONLY public.expenses_category DROP CONSTRAINT IF EXISTS expenses_category_name_key;
ALTER TABLE IF EXISTS ONLY public.expenses_budgetlimit DROP CONSTRAINT IF EXISTS expenses_budgetlimit_pkey;
ALTER TABLE IF EXISTS ONLY public.expenses_budgetlimit DROP CONSTRAINT IF EXISTS expenses_budgetlimit_category_id_month_7cf2e20e_uniq;
ALTER TABLE IF EXISTS ONLY public.django_session DROP CONSTRAINT IF EXISTS django_session_pkey;
ALTER TABLE IF EXISTS ONLY public.django_migrations DROP CONSTRAINT IF EXISTS django_migrations_pkey;
ALTER TABLE IF EXISTS ONLY public.django_content_type DROP CONSTRAINT IF EXISTS django_content_type_pkey;
ALTER TABLE IF EXISTS ONLY public.django_content_type DROP CONSTRAINT IF EXISTS django_content_type_app_label_model_76bd3d3b_uniq;
ALTER TABLE IF EXISTS ONLY public.django_admin_log DROP CONSTRAINT IF EXISTS django_admin_log_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_permission DROP CONSTRAINT IF EXISTS auth_permission_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_permission DROP CONSTRAINT IF EXISTS auth_permission_content_type_id_codename_01ab375a_uniq;
ALTER TABLE IF EXISTS ONLY public.auth_group DROP CONSTRAINT IF EXISTS auth_group_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissions_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissions_group_id_permission_id_0cd325b0_uniq;
ALTER TABLE IF EXISTS ONLY public.auth_group DROP CONSTRAINT IF EXISTS auth_group_name_key;
ALTER TABLE IF EXISTS ONLY public.accounts_user DROP CONSTRAINT IF EXISTS accounts_user_username_key;
ALTER TABLE IF EXISTS ONLY public.accounts_user_user_permissions DROP CONSTRAINT IF EXISTS accounts_user_user_permissions_pkey;
ALTER TABLE IF EXISTS ONLY public.accounts_user_user_permissions DROP CONSTRAINT IF EXISTS accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq;
ALTER TABLE IF EXISTS ONLY public.accounts_user DROP CONSTRAINT IF EXISTS accounts_user_pkey;
ALTER TABLE IF EXISTS ONLY public.accounts_user_groups DROP CONSTRAINT IF EXISTS accounts_user_groups_user_id_group_id_59c0b32f_uniq;
ALTER TABLE IF EXISTS ONLY public.accounts_user_groups DROP CONSTRAINT IF EXISTS accounts_user_groups_pkey;
ALTER TABLE IF EXISTS ONLY public.accounts_memberpermission DROP CONSTRAINT IF EXISTS accounts_memberpermission_user_id_key;
ALTER TABLE IF EXISTS ONLY public.accounts_memberpermission DROP CONSTRAINT IF EXISTS accounts_memberpermission_pkey;
ALTER TABLE IF EXISTS ONLY public.accounts_hiddenpaymentmethod DROP CONSTRAINT IF EXISTS accounts_hiddenpaymentmethod_pkey;
ALTER TABLE IF EXISTS ONLY public.accounts_hiddenpaymentmethod DROP CONSTRAINT IF EXISTS accounts_hiddenpaymentme_permission_id_payment_me_e3b59194_uniq;
DROP TABLE IF EXISTS public.expenses_userpreference;
DROP TABLE IF EXISTS public.expenses_transactiontemplate;
DROP TABLE IF EXISTS public.expenses_transactionauditlog;
DROP TABLE IF EXISTS public.expenses_transactionattachment;
DROP TABLE IF EXISTS public.expenses_transaction;
DROP TABLE IF EXISTS public.expenses_sharedexpense;
DROP TABLE IF EXISTS public.expenses_recurringexpense;
DROP TABLE IF EXISTS public.expenses_paymentmethod;
DROP TABLE IF EXISTS public.expenses_category;
DROP TABLE IF EXISTS public.expenses_budgetlimit;
DROP TABLE IF EXISTS public.django_session;
DROP TABLE IF EXISTS public.django_migrations;
DROP TABLE IF EXISTS public.django_content_type;
DROP TABLE IF EXISTS public.django_admin_log;
DROP TABLE IF EXISTS public.auth_permission;
DROP TABLE IF EXISTS public.auth_group_permissions;
DROP TABLE IF EXISTS public.auth_group;
DROP TABLE IF EXISTS public.accounts_user_user_permissions;
DROP TABLE IF EXISTS public.accounts_user_groups;
DROP TABLE IF EXISTS public.accounts_user;
DROP TABLE IF EXISTS public.accounts_memberpermission;
DROP TABLE IF EXISTS public.accounts_hiddenpaymentmethod;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: accounts_hiddenpaymentmethod; Type: TABLE; Schema: public; Owner: expenseuser
--

CREATE TABLE public.accounts_hiddenpaymentmethod (
    id bigint NOT NULL,
    payment_method_id integer NOT NULL,
    permission_id bigint NOT NULL
);


ALTER TABLE public.accounts_hiddenpaymentmethod OWNER TO expenseuser;

--
-- Name: accounts_hiddenpaymentmethod_id_seq; Type: SEQUENCE; Schema: public; Owner: expenseuser
--

ALTER TABLE public.accounts_hiddenpaymentmethod ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.accounts_hiddenpaymentmethod_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: accounts_memberpermission; Type: TABLE; Schema: public; Owner: expenseuser
--

CREATE TABLE public.accounts_memberpermission (
    id bigint NOT NULL,
    can_view_expenses boolean NOT NULL,
    can_view_dashboard boolean NOT NULL,
    can_view_budget boolean NOT NULL,
    can_filter_search boolean NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.accounts_memberpermission OWNER TO expenseuser;

--
-- Name: accounts_memberpermission_id_seq; Type: SEQUENCE; Schema: public; Owner: expenseuser
--

ALTER TABLE public.accounts_memberpermission ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.accounts_memberpermission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: accounts_user; Type: TABLE; Schema: public; Owner: expenseuser
--

CREATE TABLE public.accounts_user (
    id bigint NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    role character varying(10) NOT NULL,
    display_name character varying(100) NOT NULL
);


ALTER TABLE public.accounts_user OWNER TO expenseuser;

--
-- Name: accounts_user_groups; Type: TABLE; Schema: public; Owner: expenseuser
--

CREATE TABLE public.accounts_user_groups (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.accounts_user_groups OWNER TO expenseuser;

--
-- Name: accounts_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: expenseuser
--

ALTER TABLE public.accounts_user_groups ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.accounts_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: accounts_user_id_seq; Type: SEQUENCE; Schema: public; Owner: expenseuser
--

ALTER TABLE public.accounts_user ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.accounts_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: accounts_user_user_permissions; Type: TABLE; Schema: public; Owner: expenseuser
--

CREATE TABLE public.accounts_user_user_permissions (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.accounts_user_user_permissions OWNER TO expenseuser;

--
-- Name: accounts_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: expenseuser
--

ALTER TABLE public.accounts_user_user_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.accounts_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: expenseuser
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO expenseuser;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: expenseuser
--

ALTER TABLE public.auth_group ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: expenseuser
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO expenseuser;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: expenseuser
--

ALTER TABLE public.auth_group_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: expenseuser
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO expenseuser;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: expenseuser
--

ALTER TABLE public.auth_permission ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: expenseuser
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id bigint NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO expenseuser;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: expenseuser
--

ALTER TABLE public.django_admin_log ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: expenseuser
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO expenseuser;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: expenseuser
--

ALTER TABLE public.django_content_type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: expenseuser
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO expenseuser;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: expenseuser
--

ALTER TABLE public.django_migrations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: expenseuser
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO expenseuser;

--
-- Name: expenses_budgetlimit; Type: TABLE; Schema: public; Owner: expenseuser
--

CREATE TABLE public.expenses_budgetlimit (
    id bigint NOT NULL,
    month date NOT NULL,
    amount numeric(12,2) NOT NULL,
    currency character varying(3) NOT NULL,
    category_id bigint NOT NULL
);


ALTER TABLE public.expenses_budgetlimit OWNER TO expenseuser;

--
-- Name: expenses_budgetlimit_id_seq; Type: SEQUENCE; Schema: public; Owner: expenseuser
--

ALTER TABLE public.expenses_budgetlimit ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.expenses_budgetlimit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: expenses_category; Type: TABLE; Schema: public; Owner: expenseuser
--

CREATE TABLE public.expenses_category (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    color character varying(7) NOT NULL,
    icon character varying(50) NOT NULL,
    is_active boolean NOT NULL,
    "order" integer NOT NULL
);


ALTER TABLE public.expenses_category OWNER TO expenseuser;

--
-- Name: expenses_category_id_seq; Type: SEQUENCE; Schema: public; Owner: expenseuser
--

ALTER TABLE public.expenses_category ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.expenses_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: expenses_paymentmethod; Type: TABLE; Schema: public; Owner: expenseuser
--

CREATE TABLE public.expenses_paymentmethod (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    color character varying(7) NOT NULL,
    is_bank_account boolean NOT NULL,
    is_active boolean NOT NULL,
    "order" integer NOT NULL,
    starting_balance numeric(12,2) NOT NULL,
    starting_balance_date date,
    currency character varying(3) NOT NULL
);


ALTER TABLE public.expenses_paymentmethod OWNER TO expenseuser;

--
-- Name: expenses_paymentmethod_id_seq; Type: SEQUENCE; Schema: public; Owner: expenseuser
--

ALTER TABLE public.expenses_paymentmethod ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.expenses_paymentmethod_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: expenses_recurringexpense; Type: TABLE; Schema: public; Owner: expenseuser
--

CREATE TABLE public.expenses_recurringexpense (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    amount numeric(12,2) NOT NULL,
    currency character varying(3) NOT NULL,
    transaction_type character varying(15) NOT NULL,
    notes text NOT NULL,
    day_of_month integer NOT NULL,
    is_active boolean NOT NULL,
    start_date date NOT NULL,
    end_date date,
    last_added date,
    payment_method_id bigint NOT NULL,
    to_payment_method_id bigint,
    category_id bigint
);


ALTER TABLE public.expenses_recurringexpense OWNER TO expenseuser;

--
-- Name: expenses_recurringexpense_id_seq; Type: SEQUENCE; Schema: public; Owner: expenseuser
--

ALTER TABLE public.expenses_recurringexpense ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.expenses_recurringexpense_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: expenses_sharedexpense; Type: TABLE; Schema: public; Owner: expenseuser
--

CREATE TABLE public.expenses_sharedexpense (
    id bigint NOT NULL,
    member_name character varying(100) NOT NULL,
    share_amount numeric(12,2) NOT NULL,
    currency character varying(3) NOT NULL,
    is_settled boolean NOT NULL,
    settled_date date,
    notes text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    transaction_id bigint NOT NULL
);


ALTER TABLE public.expenses_sharedexpense OWNER TO expenseuser;

--
-- Name: expenses_sharedexpense_id_seq; Type: SEQUENCE; Schema: public; Owner: expenseuser
--

ALTER TABLE public.expenses_sharedexpense ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.expenses_sharedexpense_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: expenses_transaction; Type: TABLE; Schema: public; Owner: expenseuser
--

CREATE TABLE public.expenses_transaction (
    id bigint NOT NULL,
    date date NOT NULL,
    name character varying(255) NOT NULL,
    amount numeric(12,2) NOT NULL,
    currency character varying(3) NOT NULL,
    transaction_type character varying(15) NOT NULL,
    notes text NOT NULL,
    is_hidden boolean NOT NULL,
    is_recurring_instance boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    payment_method_id bigint,
    to_payment_method_id bigint,
    category_id bigint,
    exchange_rate numeric(10,6),
    converted_amount numeric(12,2),
    paired_transaction_id bigint,
    discount_amount numeric(12,2)
);


ALTER TABLE public.expenses_transaction OWNER TO expenseuser;

--
-- Name: expenses_transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: expenseuser
--

ALTER TABLE public.expenses_transaction ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.expenses_transaction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: expenses_transactionattachment; Type: TABLE; Schema: public; Owner: expenseuser
--

CREATE TABLE public.expenses_transactionattachment (
    id bigint NOT NULL,
    file character varying(100) NOT NULL,
    original_name character varying(255) NOT NULL,
    uploaded_at timestamp with time zone NOT NULL,
    transaction_id bigint NOT NULL
);


ALTER TABLE public.expenses_transactionattachment OWNER TO expenseuser;

--
-- Name: expenses_transactionattachment_id_seq; Type: SEQUENCE; Schema: public; Owner: expenseuser
--

ALTER TABLE public.expenses_transactionattachment ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.expenses_transactionattachment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: expenses_transactionauditlog; Type: TABLE; Schema: public; Owner: expenseuser
--

CREATE TABLE public.expenses_transactionauditlog (
    id bigint NOT NULL,
    transaction_id integer NOT NULL,
    transaction_name character varying(255) NOT NULL,
    action character varying(10) NOT NULL,
    changes text NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    user_id bigint
);


ALTER TABLE public.expenses_transactionauditlog OWNER TO expenseuser;

--
-- Name: expenses_transactionauditlog_id_seq; Type: SEQUENCE; Schema: public; Owner: expenseuser
--

ALTER TABLE public.expenses_transactionauditlog ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.expenses_transactionauditlog_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: expenses_transactiontemplate; Type: TABLE; Schema: public; Owner: expenseuser
--

CREATE TABLE public.expenses_transactiontemplate (
    id bigint NOT NULL,
    label character varying(100) NOT NULL,
    name character varying(255) NOT NULL,
    amount numeric(12,2) NOT NULL,
    currency character varying(3) NOT NULL,
    transaction_type character varying(15) NOT NULL,
    notes text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    category_id bigint,
    payment_method_id bigint
);


ALTER TABLE public.expenses_transactiontemplate OWNER TO expenseuser;

--
-- Name: expenses_transactiontemplate_id_seq; Type: SEQUENCE; Schema: public; Owner: expenseuser
--

ALTER TABLE public.expenses_transactiontemplate ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.expenses_transactiontemplate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: expenses_userpreference; Type: TABLE; Schema: public; Owner: expenseuser
--

CREATE TABLE public.expenses_userpreference (
    id bigint NOT NULL,
    theme character varying(5) NOT NULL,
    default_currency character varying(3) NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.expenses_userpreference OWNER TO expenseuser;

--
-- Name: expenses_userpreference_id_seq; Type: SEQUENCE; Schema: public; Owner: expenseuser
--

ALTER TABLE public.expenses_userpreference ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.expenses_userpreference_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: accounts_hiddenpaymentmethod; Type: TABLE DATA; Schema: public; Owner: expenseuser
--

COPY public.accounts_hiddenpaymentmethod (id, payment_method_id, permission_id) FROM stdin;
2	2	1
3	3	1
\.


--
-- Data for Name: accounts_memberpermission; Type: TABLE DATA; Schema: public; Owner: expenseuser
--

COPY public.accounts_memberpermission (id, can_view_expenses, can_view_dashboard, can_view_budget, can_filter_search, user_id) FROM stdin;
1	t	t	t	t	2
\.


--
-- Data for Name: accounts_user; Type: TABLE DATA; Schema: public; Owner: expenseuser
--

COPY public.accounts_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, role, display_name) FROM stdin;
2	pbkdf2_sha256$600000$x6kvYILqb1mR4Y0ONeZ3Hd$xVBLK9xlvxedoYx5ne4GKAZjpFUQq6bX1GkStgHz7nk=	2026-03-05 02:04:19.308947+00	f	expensesUser				f	t	2026-02-24 14:36:35.020363+00	member	expensesUser
1	pbkdf2_sha256$600000$MSqQebUpw6x4atnHi2sQXO$uAZG4Z7Cl580lazEj8t1ZJHAPyCxvBYKMv7FUz8A2nI=	2026-03-05 02:04:43.501875+00	t	admin			admin@example.com	t	t	2026-02-23 14:16:10.512683+00	admin	Admin
\.


--
-- Data for Name: accounts_user_groups; Type: TABLE DATA; Schema: public; Owner: expenseuser
--

COPY public.accounts_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: accounts_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: expenseuser
--

COPY public.accounts_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: expenseuser
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: expenseuser
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: expenseuser
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add content type	4	add_contenttype
14	Can change content type	4	change_contenttype
15	Can delete content type	4	delete_contenttype
16	Can view content type	4	view_contenttype
17	Can add session	5	add_session
18	Can change session	5	change_session
19	Can delete session	5	delete_session
20	Can view session	5	view_session
21	Can add user	6	add_user
22	Can change user	6	change_user
23	Can delete user	6	delete_user
24	Can view user	6	view_user
25	Can add member permission	7	add_memberpermission
26	Can change member permission	7	change_memberpermission
27	Can delete member permission	7	delete_memberpermission
28	Can view member permission	7	view_memberpermission
29	Can add hidden payment method	8	add_hiddenpaymentmethod
30	Can change hidden payment method	8	change_hiddenpaymentmethod
31	Can delete hidden payment method	8	delete_hiddenpaymentmethod
32	Can view hidden payment method	8	view_hiddenpaymentmethod
33	Can add category	9	add_category
34	Can change category	9	change_category
35	Can delete category	9	delete_category
36	Can view category	9	view_category
37	Can add payment method	10	add_paymentmethod
38	Can change payment method	10	change_paymentmethod
39	Can delete payment method	10	delete_paymentmethod
40	Can view payment method	10	view_paymentmethod
41	Can add transaction	11	add_transaction
42	Can change transaction	11	change_transaction
43	Can delete transaction	11	delete_transaction
44	Can view transaction	11	view_transaction
45	Can add budget limit	12	add_budgetlimit
46	Can change budget limit	12	change_budgetlimit
47	Can delete budget limit	12	delete_budgetlimit
48	Can view budget limit	12	view_budgetlimit
49	Can add recurring expense	13	add_recurringexpense
50	Can change recurring expense	13	change_recurringexpense
51	Can delete recurring expense	13	delete_recurringexpense
52	Can view recurring expense	13	view_recurringexpense
53	Can add transaction audit log	14	add_transactionauditlog
54	Can change transaction audit log	14	change_transactionauditlog
55	Can delete transaction audit log	14	delete_transactionauditlog
56	Can view transaction audit log	14	view_transactionauditlog
57	Can add transaction template	15	add_transactiontemplate
58	Can change transaction template	15	change_transactiontemplate
59	Can delete transaction template	15	delete_transactiontemplate
60	Can view transaction template	15	view_transactiontemplate
61	Can add transaction attachment	16	add_transactionattachment
62	Can change transaction attachment	16	change_transactionattachment
63	Can delete transaction attachment	16	delete_transactionattachment
64	Can view transaction attachment	16	view_transactionattachment
65	Can add shared expense	17	add_sharedexpense
66	Can change shared expense	17	change_sharedexpense
67	Can delete shared expense	17	delete_sharedexpense
68	Can view shared expense	17	view_sharedexpense
69	Can add user preference	18	add_userpreference
70	Can change user preference	18	change_userpreference
71	Can delete user preference	18	delete_userpreference
72	Can view user preference	18	view_userpreference
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: expenseuser
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: expenseuser
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	contenttypes	contenttype
5	sessions	session
6	accounts	user
7	accounts	memberpermission
8	accounts	hiddenpaymentmethod
9	expenses	category
10	expenses	paymentmethod
11	expenses	transaction
12	expenses	budgetlimit
13	expenses	recurringexpense
14	expenses	transactionauditlog
15	expenses	transactiontemplate
16	expenses	transactionattachment
17	expenses	sharedexpense
18	expenses	userpreference
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: expenseuser
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2026-02-23 14:16:02.794596+00
2	contenttypes	0002_remove_content_type_name	2026-02-23 14:16:02.828041+00
3	auth	0001_initial	2026-02-23 14:16:03.314494+00
4	auth	0002_alter_permission_name_max_length	2026-02-23 14:16:03.32694+00
5	auth	0003_alter_user_email_max_length	2026-02-23 14:16:03.343102+00
6	auth	0004_alter_user_username_opts	2026-02-23 14:16:03.360113+00
7	auth	0005_alter_user_last_login_null	2026-02-23 14:16:03.376817+00
8	auth	0006_require_contenttypes_0002	2026-02-23 14:16:03.389454+00
9	auth	0007_alter_validators_add_error_messages	2026-02-23 14:16:03.403332+00
10	auth	0008_alter_user_username_max_length	2026-02-23 14:16:03.419912+00
11	auth	0009_alter_user_last_name_max_length	2026-02-23 14:16:03.437382+00
12	auth	0010_alter_group_name_max_length	2026-02-23 14:16:03.474426+00
13	auth	0011_update_proxy_permissions	2026-02-23 14:16:03.495027+00
14	auth	0012_alter_user_first_name_max_length	2026-02-23 14:16:03.511566+00
15	accounts	0001_initial	2026-02-23 14:16:04.250428+00
16	admin	0001_initial	2026-02-23 14:16:04.442221+00
17	admin	0002_logentry_remove_auto_add	2026-02-23 14:16:04.470246+00
18	admin	0003_logentry_add_action_flag_choices	2026-02-23 14:16:04.497125+00
19	expenses	0001_initial	2026-02-23 14:16:05.488846+00
20	sessions	0001_initial	2026-02-23 14:16:05.702391+00
21	expenses	0002_paymentmethod_currency_transaction_exchange	2026-03-02 16:00:01.306249+00
22	expenses	0003_batch2	2026-03-04 03:47:50.413788+00
23	expenses	0004_alter_budgetlimit_id_alter_category_id_and_more	2026-03-04 07:26:26.886796+00
24	expenses	0004_tw_withdrawal_type	2026-03-04 07:28:58.722443+00
25	expenses	0005_transaction_discount_amount	2026-03-04 08:31:00.037327+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: expenseuser
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
kznnugahsqhfh7e4dphs8nf5ohrsq8vr	.eJxVjMsOwiAQRf-FtSFQKA-X7v0GMjMMUjU0Ke3K-O_apAvd3nPOfYkE21rT1nlJUxZnocXpd0OgB7cd5Du02yxpbusyodwVedAur3Pm5-Vw_w4q9PqtHRftITilBmesA-uISQdjig8A4K11aAtbpZj9yHpAJI8RaTSFYgzi_QHYoTgI:1vxEu4:K52N63QIm4Exm_ECk06D2GO_GJ9lTLaijIM0gd792-8	2026-03-17 01:50:28.969108+00
xpu4td0u79r8rqn51ph9fdf1e7nsycny	.eJxVjMsOwiAQRf-FtSFQKA-X7v0GMjMMUjU0Ke3K-O_apAvd3nPOfYkE21rT1nlJUxZnocXpd0OgB7cd5Du02yxpbusyodwVedAur3Pm5-Vw_w4q9PqtHRftITilBmesA-uISQdjig8A4K11aAtbpZj9yHpAJI8RaTSFYgzi_QHYoTgI:1vxy4x:DxEuMVi7lCqdj35X68TXn4yUXgG6YGghkKiLFycl5yA	2026-03-19 02:04:43.510749+00
\.


--
-- Data for Name: expenses_budgetlimit; Type: TABLE DATA; Schema: public; Owner: expenseuser
--

COPY public.expenses_budgetlimit (id, month, amount, currency, category_id) FROM stdin;
\.


--
-- Data for Name: expenses_category; Type: TABLE DATA; Schema: public; Owner: expenseuser
--

COPY public.expenses_category (id, name, color, icon, is_active, "order") FROM stdin;
1	Food	#fd7e14	cart	t	1
2	Transportation	#0d6efd	car-front	t	2
3	General	#6c757d	bag	t	3
4	Income	#198754	cash-stack	t	4
6	Shopee	#fd810d	tag	t	0
7	Lazada	#6ba6ff	tag	t	0
8	Clothes	#fd0de9	tag	t	0
9	Laundry	#0d6efd	tag	t	0
10	Discount	#4ade80	tag	t	5
\.


--
-- Data for Name: expenses_paymentmethod; Type: TABLE DATA; Schema: public; Owner: expenseuser
--

COPY public.expenses_paymentmethod (id, name, color, is_bank_account, is_active, "order", starting_balance, starting_balance_date, currency) FROM stdin;
10	Laundry Wallet (PurpleStore)	#9429ff	f	t	0	0.00	2026-01-25	TWD
1	Cash	#198754	f	t	1	0.00	2025-12-26	TWD
2	iPass	#0dcaf0	f	t	2	0.00	2025-12-26	TWD
3	Taishin Bank	#dc3545	t	t	3	0.00	2025-12-26	TWD
4	LINE Pay	#00b900	f	t	4	0.00	2025-12-26	TWD
5	BDO	#003087	t	t	5	0.00	2026-03-04	PHP
6	Landbank	#00843D	t	t	6	0.00	2026-03-04	PHP
7	GoTyme	#FF6B35	t	t	7	0.00	2026-03-04	PHP
8	GCash	#007DFF	f	t	8	0.00	2026-03-04	PHP
\.


--
-- Data for Name: expenses_recurringexpense; Type: TABLE DATA; Schema: public; Owner: expenseuser
--

COPY public.expenses_recurringexpense (id, name, amount, currency, transaction_type, notes, day_of_month, is_active, start_date, end_date, last_added, payment_method_id, to_payment_method_id, category_id) FROM stdin;
1	Netflix	449.00	PHP	expense		24	t	2026-03-04	\N	\N	8	\N	3
\.


--
-- Data for Name: expenses_sharedexpense; Type: TABLE DATA; Schema: public; Owner: expenseuser
--

COPY public.expenses_sharedexpense (id, member_name, share_amount, currency, is_settled, settled_date, notes, created_at, transaction_id) FROM stdin;
\.


--
-- Data for Name: expenses_transaction; Type: TABLE DATA; Schema: public; Owner: expenseuser
--

COPY public.expenses_transaction (id, date, name, amount, currency, transaction_type, notes, is_hidden, is_recurring_instance, created_at, updated_at, payment_method_id, to_payment_method_id, category_id, exchange_rate, converted_amount, paired_transaction_id, discount_amount) FROM stdin;
4508	2026-02-05	February Salary	17351.00	TWD	income		f	f	2026-03-04 07:42:10.517104+00	2026-03-04 07:42:10.517119+00	3	\N	4	\N	\N	\N	\N
4510	2026-02-05	Cash (TWD) from Taishin Bank	5000.00	TWD	income		f	f	2026-03-04 07:42:27.282433+00	2026-03-04 07:42:27.28245+00	1	\N	3	\N	\N	\N	\N
4509	2026-02-05	ATM Withdrawal → TWD Cash (Taishin Bank)	5000.00	TWD	tw_withdrawal		f	f	2026-03-04 07:42:27.2647+00	2026-03-04 07:42:27.290364+00	3	\N	3	\N	\N	4510	\N
4512	2026-02-13	Cash (TWD) from Taishin Bank	2000.00	TWD	income		f	f	2026-03-04 07:42:44.889661+00	2026-03-04 07:42:44.889686+00	1	\N	3	\N	\N	\N	\N
4511	2026-02-13	ATM Withdrawal → TWD Cash (Taishin Bank)	2000.00	TWD	tw_withdrawal		f	f	2026-03-04 07:42:44.872245+00	2026-03-04 07:42:44.897434+00	3	\N	3	\N	\N	4512	\N
4514	2026-02-26	Cash (TWD) from Taishin Bank	5000.00	TWD	income		f	f	2026-03-04 07:43:02.54659+00	2026-03-04 07:43:02.546609+00	1	\N	3	\N	\N	\N	\N
4513	2026-02-26	ATM Withdrawal → TWD Cash (Taishin Bank)	5000.00	TWD	tw_withdrawal		f	f	2026-03-04 07:43:02.525504+00	2026-03-04 07:43:02.554668+00	3	\N	3	\N	\N	4514	\N
4515	2026-02-09	Herschel Bag	1968.00	TWD	expense		f	f	2026-03-04 07:43:57.901089+00	2026-03-04 07:43:57.901106+00	3	\N	8	\N	\N	\N	\N
4516	2026-02-09	Herschel Pants	1188.00	TWD	expense		f	f	2026-03-04 07:44:14.264037+00	2026-03-04 07:44:14.264055+00	3	\N	8	\N	\N	\N	\N
4517	2026-03-04	Herschel Bag	1799.00	TWD	transfer	Utang in Paul	f	f	2026-03-04 07:45:07.896085+00	2026-03-04 15:13:08.000132+00	3	1	\N	\N	\N	\N	\N
4523	2026-02-08	Top-up Bonus (Laundry Wallet (PurpleStore))	100.00	TWD	income	Auto-bonus from top-up: Purple Store	f	f	2026-03-04 15:23:16.401861+00	2026-03-04 15:23:16.40188+00	10	\N	10	\N	\N	\N	\N
4522	2026-02-08	Purple Store	1000.00	TWD	topup		f	f	2026-03-04 15:23:16.367804+00	2026-03-04 15:23:16.407345+00	1	10	\N	\N	\N	4523	\N
4524	2026-02-08	Laundry	100.00	TWD	expense		f	f	2026-03-04 15:24:03.077139+00	2026-03-04 15:24:03.077154+00	10	\N	9	\N	\N	\N	\N
4525	2026-02-08	Dryer	50.00	TWD	expense		f	f	2026-03-04 15:24:22.520374+00	2026-03-04 15:24:22.520393+00	10	\N	9	\N	\N	\N	\N
4526	2026-02-08	Adrian Laundry	60.00	TWD	transfer		f	f	2026-03-04 15:25:35.993918+00	2026-03-04 15:25:35.993934+00	10	1	\N	\N	\N	\N	\N
4527	2026-02-08	Adrian Dryer	50.00	TWD	transfer		f	f	2026-03-04 15:25:52.831525+00	2026-03-04 15:25:52.831538+00	10	1	\N	\N	\N	\N	\N
4528	2026-02-15	Laundry	60.00	TWD	expense		f	f	2026-03-04 15:26:16.25526+00	2026-03-04 15:26:16.255282+00	10	\N	9	\N	\N	\N	\N
4529	2026-02-15	Dryer	50.00	TWD	expense		f	f	2026-03-04 15:26:32.852223+00	2026-03-04 15:26:32.852242+00	10	\N	9	\N	\N	\N	\N
4530	2026-02-23	Dryer	50.00	TWD	expense		f	f	2026-03-04 15:27:40.837016+00	2026-03-04 15:27:57.514421+00	10	\N	9	\N	\N	\N	\N
4531	2026-02-23	Laundry	60.00	TWD	expense		f	f	2026-03-04 15:27:43.604412+00	2026-03-04 15:28:05.630959+00	10	\N	9	\N	\N	\N	\N
4532	2026-03-02	Laundry	50.00	TWD	expense		f	f	2026-03-04 15:29:16.98913+00	2026-03-04 15:29:16.989146+00	10	\N	9	\N	\N	\N	\N
4533	2026-03-02	Adrian Laundry	50.00	TWD	transfer		f	f	2026-03-04 15:29:33.272959+00	2026-03-04 15:29:33.272975+00	10	1	\N	\N	\N	\N	\N
4534	2026-03-02	Puff Tech	50.00	TWD	expense		f	f	2026-03-04 15:30:02.395161+00	2026-03-04 15:30:02.395211+00	10	\N	9	\N	\N	\N	\N
4535	2026-03-02	Puff Tech	50.00	TWD	expense		f	f	2026-03-04 15:30:16.391282+00	2026-03-04 15:30:16.391311+00	1	\N	9	\N	\N	\N	\N
4536	2026-03-02	Dryer	50.00	TWD	expense		f	f	2026-03-04 15:31:12.040013+00	2026-03-04 15:31:12.040027+00	10	\N	9	\N	\N	\N	\N
4537	2026-03-02	Adrian Dryer	60.00	TWD	transfer		f	f	2026-03-04 15:31:32.488046+00	2026-03-04 15:31:32.488061+00	10	1	9	\N	\N	\N	\N
4538	2026-03-02	Puff Tech	30.00	TWD	expense		f	f	2026-03-04 15:31:50.921147+00	2026-03-04 15:31:50.921169+00	1	\N	9	\N	\N	\N	\N
4540	2026-02-26	Puff Tech	90.00	TWD	expense		f	f	2026-03-04 15:34:40.825309+00	2026-03-04 15:34:40.825331+00	10	\N	9	\N	\N	\N	\N
4539	2026-02-26	Puff Tech	50.00	TWD	expense		f	f	2026-03-04 15:33:42.50869+00	2026-03-04 15:34:56.712874+00	10	\N	9	\N	\N	\N	\N
4541	2026-02-23	Hot Pot	190.00	TWD	expense		f	f	2026-03-04 15:37:47.338486+00	2026-03-04 15:37:47.338503+00	1	\N	1	\N	\N	\N	\N
4542	2026-02-27	7-UP	10.00	TWD	expense		f	f	2026-03-04 15:38:31.952551+00	2026-03-04 15:38:31.952569+00	1	\N	1	\N	\N	\N	\N
4543	2026-02-28	Strawberry Milk	45.00	TWD	expense	From Work	f	f	2026-03-04 15:39:17.324713+00	2026-03-04 15:39:17.324732+00	1	\N	1	\N	\N	\N	35.00
4545	2026-03-01	Doritos	35.00	TWD	expense		f	f	2026-03-04 15:41:23.631758+00	2026-03-04 15:41:23.631775+00	1	\N	1	\N	\N	\N	5.00
4547	2026-03-01	Oatmilk	35.00	TWD	expense		f	f	2026-03-04 15:41:55.239215+00	2026-03-04 15:41:55.23923+00	1	\N	1	\N	\N	\N	5.00
4546	2026-03-01	Blueberry Bread	35.00	TWD	expense		f	f	2026-03-04 15:41:36.382453+00	2026-03-04 15:42:06.072982+00	1	\N	1	\N	\N	\N	5.00
4548	2026-03-01	Iced Tea	15.00	TWD	expense		f	f	2026-03-04 15:42:29.585044+00	2026-03-04 15:42:40.302419+00	1	\N	1	\N	\N	\N	8.00
4549	2026-03-02	Ramen	190.00	TWD	expense		f	f	2026-03-04 15:43:07.364571+00	2026-03-04 15:43:07.36459+00	1	\N	1	\N	\N	\N	\N
4550	2026-03-02	Tissue	35.00	TWD	expense		f	f	2026-03-04 15:43:20.730731+00	2026-03-04 15:43:20.730746+00	1	\N	3	\N	\N	\N	\N
4551	2026-03-02	Garlic	14.00	TWD	expense		f	f	2026-03-04 15:43:36.931972+00	2026-03-04 15:44:18.211906+00	1	\N	1	\N	\N	\N	\N
4552	2026-02-28	Pocari	39.00	TWD	expense		f	f	2026-03-04 15:45:12.897335+00	2026-03-04 15:45:12.89735+00	1	\N	1	\N	\N	\N	16.00
4553	2026-02-28	Lipton Milk Tea	17.00	TWD	expense	I paid 17, idk the discount yet	f	f	2026-03-04 15:45:40.765632+00	2026-03-04 15:45:53.378834+00	1	\N	1	\N	\N	\N	\N
4544	2026-03-04	Korean Fried Chicken	49.00	TWD	expense		f	f	2026-03-04 15:39:55.068506+00	2026-03-05 02:05:47.062474+00	1	\N	1	\N	\N	\N	9.00
4554	2025-09-19	Bedsheet	1630.00	TWD	expense		f	f	2026-03-05 03:36:35.496404+00	2026-03-05 03:36:35.496422+00	1	\N	3	\N	\N	\N	\N
4555	2025-09-19	Sim Card	3800.00	TWD	expense		f	f	2026-03-05 03:36:35.568632+00	2026-03-05 03:36:35.568651+00	1	\N	3	\N	\N	\N	\N
4556	2025-09-20	Coco Milk Tea	50.00	TWD	expense		f	f	2026-03-05 03:36:35.620324+00	2026-03-05 03:36:35.620345+00	1	\N	1	\N	\N	\N	\N
4557	2025-09-20	Food	99.00	TWD	expense		f	f	2026-03-05 03:36:35.736908+00	2026-03-05 03:36:35.736926+00	1	\N	1	\N	\N	\N	\N
4558	2025-09-20	Bidet	65.00	TWD	expense		f	f	2026-03-05 03:36:35.797832+00	2026-03-05 03:36:35.797848+00	1	\N	3	\N	\N	\N	\N
4559	2025-09-20	General Cleaning Supplies	90.00	TWD	expense		f	f	2026-03-05 03:36:35.876985+00	2026-03-05 03:36:35.877001+00	1	\N	3	\N	\N	\N	\N
4560	2025-09-20	Personal Essentials	646.00	TWD	expense		f	f	2026-03-05 03:36:35.904087+00	2026-03-05 03:36:35.904102+00	1	\N	3	\N	\N	\N	\N
4561	2025-09-20	Screwdriver	30.00	TWD	expense		f	f	2026-03-05 03:36:35.978566+00	2026-03-05 03:36:35.978586+00	1	\N	3	\N	\N	\N	\N
4562	2025-09-21	KFC	89.00	TWD	expense		f	f	2026-03-05 03:36:36.003856+00	2026-03-05 03:36:36.003877+00	1	\N	1	\N	\N	\N	\N
4563	2025-09-21	Food	79.00	TWD	expense		f	f	2026-03-05 03:36:36.090744+00	2026-03-05 03:36:36.090762+00	1	\N	1	\N	\N	\N	\N
4564	2025-09-22	Food.	100.00	TWD	expense		f	f	2026-03-05 03:36:36.129078+00	2026-03-05 03:36:36.129096+00	1	\N	1	\N	\N	\N	\N
4565	2025-09-22	XLB	65.00	TWD	expense		f	f	2026-03-05 03:36:36.178776+00	2026-03-05 03:36:36.178795+00	1	\N	1	\N	\N	\N	\N
4566	2025-09-22	MILK	35.00	TWD	expense		f	f	2026-03-05 03:36:36.255663+00	2026-03-05 03:36:36.255678+00	1	\N	1	\N	\N	\N	\N
4567	2025-09-23	Juice	10.00	TWD	expense		f	f	2026-03-05 03:36:36.304151+00	2026-03-05 03:36:36.304167+00	1	\N	1	\N	\N	\N	\N
4568	2025-09-23	Noodles	65.00	TWD	expense		f	f	2026-03-05 03:36:36.37893+00	2026-03-05 03:36:36.378948+00	1	\N	1	\N	\N	\N	\N
4569	2025-09-23	Rice	65.00	TWD	expense		f	f	2026-03-05 03:36:36.404262+00	2026-03-05 03:36:36.404285+00	1	\N	1	\N	\N	\N	\N
4570	2025-09-23	Chicken	70.00	TWD	expense		f	f	2026-03-05 03:36:36.542202+00	2026-03-05 03:36:36.542261+00	1	\N	1	\N	\N	\N	\N
4571	2025-09-24	food	60.00	TWD	expense		f	f	2026-03-05 03:36:36.568143+00	2026-03-05 03:36:36.568164+00	1	\N	1	\N	\N	\N	\N
4572	2025-09-24	juice	10.00	TWD	expense		f	f	2026-03-05 03:36:36.604041+00	2026-03-05 03:36:36.604055+00	1	\N	1	\N	\N	\N	\N
4573	2025-09-24	mcdo	162.00	TWD	expense		f	f	2026-03-05 03:36:36.629033+00	2026-03-05 03:36:36.629059+00	1	\N	1	\N	\N	\N	\N
4574	2025-09-25	ovaltine	22.00	TWD	expense		f	f	2026-03-05 03:36:36.670735+00	2026-03-05 03:36:36.670751+00	1	\N	1	\N	\N	\N	\N
4575	2025-09-25	onigiri	55.00	TWD	expense		f	f	2026-03-05 03:36:36.698119+00	2026-03-05 03:36:36.698132+00	1	\N	1	\N	\N	\N	\N
4576	2025-09-25	food	80.00	TWD	expense		f	f	2026-03-05 03:36:36.754587+00	2026-03-05 03:36:36.75461+00	1	\N	1	\N	\N	\N	\N
4577	2025-09-26	onigiri	50.00	TWD	expense		f	f	2026-03-05 03:36:36.778017+00	2026-03-05 03:36:36.778031+00	1	\N	1	\N	\N	\N	\N
4578	2025-09-26	Food	80.00	TWD	expense		f	f	2026-03-05 03:36:36.804158+00	2026-03-05 03:36:36.804211+00	1	\N	1	\N	\N	\N	\N
4579	2025-09-27	Coco	270.00	TWD	expense		f	f	2026-03-05 03:36:36.89126+00	2026-03-05 03:36:36.891277+00	1	\N	1	\N	\N	\N	\N
4580	2025-09-27	Coco-Service Fee	29.00	TWD	expense		f	f	2026-03-05 03:36:36.920853+00	2026-03-05 03:36:36.920868+00	1	\N	1	\N	\N	\N	\N
4581	2025-09-27	Ice cream	32.00	TWD	expense		f	f	2026-03-05 03:36:36.944837+00	2026-03-05 03:36:36.944853+00	1	\N	1	\N	\N	\N	\N
4582	2025-09-27	Food	80.00	TWD	expense		f	f	2026-03-05 03:36:36.970887+00	2026-03-05 03:36:36.970901+00	1	\N	1	\N	\N	\N	\N
4583	2025-09-27	Train	23.00	TWD	expense		f	f	2026-03-05 03:36:36.996271+00	2026-03-05 03:36:36.996288+00	1	\N	3	\N	\N	\N	\N
4584	2025-09-27	Train	23.00	TWD	expense		f	f	2026-03-05 03:36:37.020955+00	2026-03-05 03:36:37.020971+00	1	\N	3	\N	\N	\N	\N
4585	2025-09-28	Noodles	65.00	TWD	expense		f	f	2026-03-05 03:36:37.047829+00	2026-03-05 03:36:37.047848+00	1	\N	1	\N	\N	\N	\N
4586	2025-09-28	XLB	65.00	TWD	expense		f	f	2026-03-05 03:36:37.070728+00	2026-03-05 03:36:37.07074+00	1	\N	1	\N	\N	\N	\N
4587	2025-09-28	Oat Milk	35.00	TWD	expense		f	f	2026-03-05 03:36:37.091257+00	2026-03-05 03:36:37.091272+00	1	\N	1	\N	\N	\N	\N
4588	2025-09-28	Milk	39.00	TWD	expense		f	f	2026-03-05 03:36:37.17596+00	2026-03-05 03:36:37.175973+00	1	\N	1	\N	\N	\N	\N
4589	2025-09-28	Discount	15.00	TWD	income		f	f	2026-03-05 03:36:37.285735+00	2026-03-05 03:36:37.285752+00	1	\N	10	\N	\N	\N	\N
4590	2025-09-29	Food	99.00	TWD	expense		f	f	2026-03-05 03:36:37.398729+00	2026-03-05 03:36:37.398755+00	1	\N	1	\N	\N	\N	\N
4591	2025-09-29	Juice	30.00	TWD	expense		f	f	2026-03-05 03:36:37.518602+00	2026-03-05 03:36:37.518631+00	1	\N	1	\N	\N	\N	\N
4592	2025-09-29	Discount	6.00	TWD	income		f	f	2026-03-05 03:36:37.644438+00	2026-03-05 03:36:37.644454+00	1	\N	10	\N	\N	\N	\N
4593	2025-09-29	XLB	65.00	TWD	expense		f	f	2026-03-05 03:36:37.786945+00	2026-03-05 03:36:37.786961+00	1	\N	1	\N	\N	\N	\N
4594	2025-09-29	Soup	60.00	TWD	expense		f	f	2026-03-05 03:36:37.92087+00	2026-03-05 03:36:37.920884+00	1	\N	1	\N	\N	\N	\N
4595	2025-09-29	Ice cream	35.00	TWD	expense		f	f	2026-03-05 03:36:38.010081+00	2026-03-05 03:36:38.010098+00	1	\N	1	\N	\N	\N	\N
4596	2025-09-29	Discount	21.00	TWD	income		f	f	2026-03-05 03:36:38.148326+00	2026-03-05 03:36:38.148364+00	1	\N	10	\N	\N	\N	\N
4597	2025-09-29	Superglue	20.00	TWD	expense		f	f	2026-03-05 03:36:38.287386+00	2026-03-05 03:36:38.287418+00	1	\N	3	\N	\N	\N	\N
4598	2025-09-30	FOOD	89.00	TWD	expense		f	f	2026-03-05 03:36:38.387823+00	2026-03-05 03:36:38.387854+00	1	\N	1	\N	\N	\N	\N
4599	2025-09-30	food	80.00	TWD	expense		f	f	2026-03-05 03:36:38.509845+00	2026-03-05 03:36:38.509868+00	1	\N	1	\N	\N	\N	\N
4600	2025-09-30	hi chew	18.00	TWD	expense		f	f	2026-03-05 03:36:38.546899+00	2026-03-05 03:36:38.546921+00	1	\N	1	\N	\N	\N	\N
4601	2025-10-01	Food	80.00	TWD	expense		f	f	2026-03-05 03:36:38.663392+00	2026-03-05 03:36:38.66342+00	1	\N	1	\N	\N	\N	\N
4602	2025-10-01	Fried Rice	80.00	TWD	expense		f	f	2026-03-05 03:36:38.695104+00	2026-03-05 03:36:38.695132+00	1	\N	1	\N	\N	\N	\N
4603	2025-10-01	Chicken	50.00	TWD	expense		f	f	2026-03-05 03:36:38.804781+00	2026-03-05 03:36:38.804798+00	1	\N	1	\N	\N	\N	\N
4604	2025-10-02	Food	95.00	TWD	expense		f	f	2026-03-05 03:36:38.839674+00	2026-03-05 03:36:38.839689+00	1	\N	1	\N	\N	\N	\N
4605	2025-10-02	Food	89.00	TWD	expense		f	f	2026-03-05 03:36:38.915474+00	2026-03-05 03:36:38.915493+00	1	\N	1	\N	\N	\N	\N
4606	2025-10-02	Juice	35.00	TWD	expense		f	f	2026-03-05 03:36:38.968559+00	2026-03-05 03:36:38.968574+00	1	\N	1	\N	\N	\N	\N
4607	2025-10-02	Discount	7.00	TWD	income		f	f	2026-03-05 03:36:39.073043+00	2026-03-05 03:36:39.073061+00	1	\N	10	\N	\N	\N	\N
4608	2025-10-02	B1T1 Protein Bar	39.00	TWD	expense		f	f	2026-03-05 03:36:39.196298+00	2026-03-05 03:36:39.196321+00	1	\N	1	\N	\N	\N	\N
4609	2025-10-03	Milk	39.00	TWD	expense		f	f	2026-03-05 03:36:39.282163+00	2026-03-05 03:36:39.282215+00	1	\N	1	\N	\N	\N	\N
4610	2025-10-03	Bread	35.00	TWD	expense		f	f	2026-03-05 03:36:39.388421+00	2026-03-05 03:36:39.388436+00	1	\N	1	\N	\N	\N	\N
4611	2025-10-03	Discount	12.00	TWD	income		f	f	2026-03-05 03:36:39.480152+00	2026-03-05 03:36:39.48022+00	1	\N	10	\N	\N	\N	\N
4612	2025-10-03	Food	80.00	TWD	expense		f	f	2026-03-05 03:36:39.503917+00	2026-03-05 03:36:39.50393+00	1	\N	1	\N	\N	\N	\N
4613	2025-10-03	Laundry	60.00	TWD	expense		f	f	2026-03-05 03:36:39.590855+00	2026-03-05 03:36:39.590875+00	1	\N	9	\N	\N	\N	\N
4614	2025-10-03	Dryer	60.00	TWD	expense		f	f	2026-03-05 03:36:39.621965+00	2026-03-05 03:36:39.621982+00	1	\N	9	\N	\N	\N	\N
4615	2025-10-03	Plastic	10.00	TWD	expense		f	f	2026-03-05 03:36:39.713578+00	2026-03-05 03:36:39.713593+00	1	\N	3	\N	\N	\N	\N
4616	2025-10-04	Bread	35.00	TWD	expense		f	f	2026-03-05 03:36:39.737487+00	2026-03-05 03:36:39.737502+00	1	\N	1	\N	\N	\N	\N
4617	2025-10-04	Coffee	45.00	TWD	expense		f	f	2026-03-05 03:36:39.815673+00	2026-03-05 03:36:39.815686+00	1	\N	1	\N	\N	\N	\N
4618	2025-10-04	Discount	18.00	TWD	income		f	f	2026-03-05 03:36:39.8554+00	2026-03-05 03:36:39.855414+00	1	\N	10	\N	\N	\N	\N
4619	2025-10-04	Food	160.00	TWD	expense		f	f	2026-03-05 03:36:39.955499+00	2026-03-05 03:36:39.955512+00	1	\N	1	\N	\N	\N	\N
4620	2025-10-04	Minute Maid	29.00	TWD	expense		f	f	2026-03-05 03:36:39.988068+00	2026-03-05 03:36:39.988085+00	1	\N	1	\N	\N	\N	\N
4621	2025-10-04	Dicount	9.00	TWD	income		f	f	2026-03-05 03:36:40.07444+00	2026-03-05 03:36:40.074457+00	1	\N	4	\N	\N	\N	\N
4622	2025-10-04	Food (Sukiyaki)	153.00	TWD	expense		f	f	2026-03-05 03:36:40.114042+00	2026-03-05 03:36:40.114064+00	1	\N	1	\N	\N	\N	\N
4623	2025-10-04	McDo	192.00	TWD	expense		f	f	2026-03-05 03:36:40.281445+00	2026-03-05 03:36:40.281458+00	1	\N	1	\N	\N	\N	\N
4624	2025-10-04	Train	143.00	TWD	expense		f	f	2026-03-05 03:36:40.313376+00	2026-03-05 03:36:40.313392+00	1	\N	3	\N	\N	\N	\N
4625	2025-10-04	Train	143.00	TWD	expense		f	f	2026-03-05 03:36:40.43603+00	2026-03-05 03:36:40.436044+00	1	\N	3	\N	\N	\N	\N
4626	2025-10-05	Chicken Burger	75.00	TWD	expense		f	f	2026-03-05 03:36:40.461969+00	2026-03-05 03:36:40.46199+00	1	\N	1	\N	\N	\N	\N
4627	2025-10-05	Chicken Food	139.00	TWD	expense		f	f	2026-03-05 03:36:40.582479+00	2026-03-05 03:36:40.5825+00	1	\N	1	\N	\N	\N	\N
4628	2025-10-06	McDo	211.00	TWD	expense		f	f	2026-03-05 03:36:40.698257+00	2026-03-05 03:36:40.698282+00	1	\N	1	\N	\N	\N	\N
4629	2025-10-06	Plastic	1.00	TWD	expense		f	f	2026-03-05 03:36:40.736114+00	2026-03-05 03:36:40.736131+00	1	\N	3	\N	\N	\N	\N
4630	2025-10-07	Food	95.00	TWD	expense		f	f	2026-03-05 03:36:40.798833+00	2026-03-05 03:36:40.79885+00	1	\N	1	\N	\N	\N	\N
4631	2025-10-07	Food	80.00	TWD	expense		f	f	2026-03-05 03:36:40.866074+00	2026-03-05 03:36:40.866092+00	1	\N	1	\N	\N	\N	\N
4632	2025-10-07	Ice Cream	49.00	TWD	expense		f	f	2026-03-05 03:36:40.956888+00	2026-03-05 03:36:40.956905+00	1	\N	1	\N	\N	\N	\N
4633	2025-10-07	Discount	11.00	TWD	income		f	f	2026-03-05 03:36:41.035698+00	2026-03-05 03:36:41.035718+00	1	\N	10	\N	\N	\N	\N
4634	2025-10-08	Food	80.00	TWD	expense		f	f	2026-03-05 03:36:41.139446+00	2026-03-05 03:36:41.139469+00	1	\N	1	\N	\N	\N	\N
4635	2025-10-08	Food	80.00	TWD	expense		f	f	2026-03-05 03:36:41.273755+00	2026-03-05 03:36:41.273774+00	1	\N	1	\N	\N	\N	\N
4636	2025-10-08	Ice Cream	40.00	TWD	expense		f	f	2026-03-05 03:36:41.33058+00	2026-03-05 03:36:41.330601+00	1	\N	1	\N	\N	\N	\N
4637	2025-10-08	Discount	8.00	TWD	income		f	f	2026-03-05 03:36:41.405458+00	2026-03-05 03:36:41.405479+00	1	\N	10	\N	\N	\N	\N
4638	2025-10-09	Food	99.00	TWD	expense		f	f	2026-03-05 03:36:41.447714+00	2026-03-05 03:36:41.447738+00	1	\N	1	\N	\N	\N	\N
4639	2025-10-09	Food	100.00	TWD	expense		f	f	2026-03-05 03:36:41.533231+00	2026-03-05 03:36:41.533252+00	1	\N	1	\N	\N	\N	\N
4640	2025-10-09	Milk	40.00	TWD	expense		f	f	2026-03-05 03:36:41.572985+00	2026-03-05 03:36:41.57301+00	1	\N	1	\N	\N	\N	\N
4641	2025-10-09	Milk	40.00	TWD	expense		f	f	2026-03-05 03:36:41.67985+00	2026-03-05 03:36:41.679869+00	1	\N	1	\N	\N	\N	\N
4642	2025-10-09	Milk	40.00	TWD	expense		f	f	2026-03-05 03:36:41.706131+00	2026-03-05 03:36:41.706168+00	1	\N	1	\N	\N	\N	\N
4643	2025-10-09	Discount	15.00	TWD	income		f	f	2026-03-05 03:36:41.781256+00	2026-03-05 03:36:41.781279+00	1	\N	10	\N	\N	\N	\N
4644	2025-10-09	Discount	7.00	TWD	income		f	f	2026-03-05 03:36:41.813077+00	2026-03-05 03:36:41.813097+00	1	\N	10	\N	\N	\N	\N
4645	2025-10-10	Ippudo Ramen	300.00	TWD	expense		f	f	2026-03-05 03:36:41.848016+00	2026-03-05 03:36:41.848036+00	1	\N	1	\N	\N	\N	\N
4646	2025-10-10	Food	99.00	TWD	expense		f	f	2026-03-05 03:36:41.891204+00	2026-03-05 03:36:41.891229+00	1	\N	1	\N	\N	\N	\N
4647	2025-10-10	Train	22.00	TWD	expense		f	f	2026-03-05 03:36:41.922998+00	2026-03-05 03:36:41.923024+00	1	\N	3	\N	\N	\N	\N
4648	2025-10-10	Bus	26.00	TWD	expense		f	f	2026-03-05 03:36:41.991549+00	2026-03-05 03:36:41.991569+00	1	\N	3	\N	\N	\N	\N
4649	2025-10-10	Bus	25.00	TWD	expense		f	f	2026-03-05 03:36:42.044274+00	2026-03-05 03:36:42.044297+00	1	\N	3	\N	\N	\N	\N
4650	2025-10-10	Train	22.00	TWD	expense		f	f	2026-03-05 03:36:42.073158+00	2026-03-05 03:36:42.07322+00	1	\N	3	\N	\N	\N	\N
4651	2025-10-10	Washing Machine	338.00	TWD	expense		f	f	2026-03-05 03:36:42.140252+00	2026-03-05 03:36:42.140269+00	1	\N	3	\N	\N	\N	\N
4652	2025-10-10	Guitar String	110.00	TWD	expense		f	f	2026-03-05 03:36:42.207983+00	2026-03-05 03:36:42.208002+00	1	\N	3	\N	\N	\N	\N
4653	2025-10-10	Guitar String	110.00	TWD	expense		f	f	2026-03-05 03:36:42.24778+00	2026-03-05 03:36:42.247796+00	1	\N	3	\N	\N	\N	\N
4654	2025-10-10	Guitar String	100.00	TWD	expense		f	f	2026-03-05 03:36:42.313403+00	2026-03-05 03:36:42.313428+00	1	\N	3	\N	\N	\N	\N
4655	2025-10-10	Discount	10.00	TWD	income		f	f	2026-03-05 03:36:42.383579+00	2026-03-05 03:36:42.383604+00	1	\N	10	\N	\N	\N	\N
4656	2025-10-11	Food	80.00	TWD	expense		f	f	2026-03-05 03:36:42.428393+00	2026-03-05 03:36:42.428418+00	1	\N	1	\N	\N	\N	\N
4657	2025-10-11	Ice Cream	25.00	TWD	expense		f	f	2026-03-05 03:36:42.508236+00	2026-03-05 03:36:42.508262+00	1	\N	1	\N	\N	\N	\N
4658	2025-10-11	Protein Bar	39.00	TWD	expense		f	f	2026-03-05 03:36:42.531535+00	2026-03-05 03:36:42.531556+00	1	\N	1	\N	\N	\N	\N
4659	2025-10-11	Laundry (colored)	40.00	TWD	expense		f	f	2026-03-05 03:36:42.639249+00	2026-03-05 03:36:42.639263+00	1	\N	9	\N	\N	\N	\N
4660	2025-10-11	Laundry (white)	40.00	TWD	expense		f	f	2026-03-05 03:36:42.664677+00	2026-03-05 03:36:42.664692+00	1	\N	9	\N	\N	\N	\N
4661	2025-10-11	Laundry (cover)	30.00	TWD	expense		f	f	2026-03-05 03:36:42.781553+00	2026-03-05 03:36:42.781567+00	1	\N	9	\N	\N	\N	\N
4662	2025-10-11	Soap	10.00	TWD	expense		f	f	2026-03-05 03:36:42.833484+00	2026-03-05 03:36:42.8335+00	1	\N	3	\N	\N	\N	\N
4663	2025-10-11	Dryer (cover)	10.00	TWD	expense		f	f	2026-03-05 03:36:42.873081+00	2026-03-05 03:36:42.873108+00	1	\N	9	\N	\N	\N	\N
4664	2025-10-11	Dryer	50.00	TWD	expense		f	f	2026-03-05 03:36:42.91978+00	2026-03-05 03:36:42.919795+00	1	\N	9	\N	\N	\N	\N
4665	2025-10-12	Food	80.00	TWD	expense		f	f	2026-03-05 03:36:42.948032+00	2026-03-05 03:36:42.948046+00	1	\N	1	\N	\N	\N	\N
4666	2025-10-12	Rebisco	48.00	TWD	expense		f	f	2026-03-05 03:36:42.975132+00	2026-03-05 03:36:42.975147+00	1	\N	1	\N	\N	\N	\N
4667	2025-10-12	Pandesal (10 pieces)	60.00	TWD	expense		f	f	2026-03-05 03:36:42.998019+00	2026-03-05 03:36:42.998032+00	1	\N	1	\N	\N	\N	\N
4668	2025-10-13	Food	80.00	TWD	expense		f	f	2026-03-05 03:36:43.006402+00	2026-03-05 03:36:43.006415+00	1	\N	1	\N	\N	\N	\N
4669	2025-10-13	Food	80.00	TWD	expense		f	f	2026-03-05 03:36:43.014808+00	2026-03-05 03:36:43.014824+00	1	\N	1	\N	\N	\N	\N
4670	2025-10-14	Sisig	55.00	TWD	expense		f	f	2026-03-05 03:36:43.023035+00	2026-03-05 03:36:43.023049+00	1	\N	1	\N	\N	\N	\N
4671	2025-10-14	Rice	10.00	TWD	expense		f	f	2026-03-05 03:36:43.031479+00	2026-03-05 03:36:43.031493+00	1	\N	1	\N	\N	\N	\N
4672	2025-10-14	Rice	10.00	TWD	expense		f	f	2026-03-05 03:36:43.03981+00	2026-03-05 03:36:43.039823+00	1	\N	1	\N	\N	\N	\N
4673	2025-10-14	Milk	39.00	TWD	expense		f	f	2026-03-05 03:36:43.04804+00	2026-03-05 03:36:43.048053+00	1	\N	1	\N	\N	\N	\N
4674	2025-10-14	Milk	39.00	TWD	expense		f	f	2026-03-05 03:36:43.056458+00	2026-03-05 03:36:43.056475+00	1	\N	1	\N	\N	\N	\N
4675	2025-10-14	Milk	32.00	TWD	expense		f	f	2026-03-05 03:36:43.064829+00	2026-03-05 03:36:43.064843+00	1	\N	1	\N	\N	\N	\N
4676	2025-10-14	Discount	8.00	TWD	income		f	f	2026-03-05 03:36:43.073069+00	2026-03-05 03:36:43.073103+00	1	\N	10	\N	\N	\N	\N
4677	2025-10-15	Food	89.00	TWD	expense		f	f	2026-03-05 03:36:43.081409+00	2026-03-05 03:36:43.081423+00	1	\N	1	\N	\N	\N	\N
4678	2025-10-15	Food	85.00	TWD	expense		f	f	2026-03-05 03:36:43.089754+00	2026-03-05 03:36:43.08977+00	1	\N	1	\N	\N	\N	\N
4679	2025-10-15	Rice	10.00	TWD	expense		f	f	2026-03-05 03:36:43.098127+00	2026-03-05 03:36:43.098142+00	1	\N	1	\N	\N	\N	\N
4680	2025-10-15	Listerine	139.00	TWD	expense		f	f	2026-03-05 03:36:43.106532+00	2026-03-05 03:36:43.106548+00	1	\N	3	\N	\N	\N	\N
4681	2025-10-15	Discount	40.00	TWD	income		f	f	2026-03-05 03:36:43.11509+00	2026-03-05 03:36:43.115107+00	1	\N	10	\N	\N	\N	\N
4682	2025-10-16	XLB	65.00	TWD	expense		f	f	2026-03-05 03:36:43.123088+00	2026-03-05 03:36:43.123103+00	1	\N	1	\N	\N	\N	\N
4683	2025-10-16	XLB	65.00	TWD	expense		f	f	2026-03-05 03:36:43.131743+00	2026-03-05 03:36:43.131761+00	1	\N	1	\N	\N	\N	\N
4684	2025-10-17	Food	80.00	TWD	expense		f	f	2026-03-05 03:36:43.175995+00	2026-03-05 03:36:43.176009+00	1	\N	1	\N	\N	\N	\N
4685	2025-10-17	Food	80.00	TWD	expense		f	f	2026-03-05 03:36:43.190029+00	2026-03-05 03:36:43.190052+00	1	\N	1	\N	\N	\N	\N
4686	2025-10-17	Rice	10.00	TWD	expense		f	f	2026-03-05 03:36:43.292244+00	2026-03-05 03:36:43.29226+00	1	\N	1	\N	\N	\N	\N
4687	2025-10-17	Ice Cream	25.00	TWD	expense		f	f	2026-03-05 03:36:43.306715+00	2026-03-05 03:36:43.306735+00	1	\N	1	\N	\N	\N	\N
4688	2025-10-18	Food	80.00	TWD	expense		f	f	2026-03-05 03:36:43.351254+00	2026-03-05 03:36:43.351272+00	1	\N	1	\N	\N	\N	\N
4689	2025-10-18	Food	80.00	TWD	expense		f	f	2026-03-05 03:36:43.365082+00	2026-03-05 03:36:43.36511+00	1	\N	1	\N	\N	\N	\N
4690	2025-10-18	Rice	10.00	TWD	expense		f	f	2026-03-05 03:36:43.436346+00	2026-03-05 03:36:43.43636+00	1	\N	1	\N	\N	\N	\N
4691	2025-10-18	Laundry	50.00	TWD	expense		f	f	2026-03-05 03:36:43.448377+00	2026-03-05 03:36:43.448395+00	1	\N	9	\N	\N	\N	\N
4692	2025-10-18	Dryer	50.00	TWD	expense		f	f	2026-03-05 03:36:43.493089+00	2026-03-05 03:36:43.493104+00	1	\N	9	\N	\N	\N	\N
4693	2025-10-19	Food	80.00	TWD	expense		f	f	2026-03-05 03:36:43.506741+00	2026-03-05 03:36:43.506757+00	1	\N	1	\N	\N	\N	\N
4694	2025-10-20	Food	100.00	TWD	expense		f	f	2026-03-05 03:36:43.515024+00	2026-03-05 03:36:43.51504+00	1	\N	1	\N	\N	\N	\N
4695	2025-10-20	Juice	10.00	TWD	expense		f	f	2026-03-05 03:36:43.523424+00	2026-03-05 03:36:43.523439+00	1	\N	1	\N	\N	\N	\N
4696	2025-10-21	Food	89.00	TWD	expense		f	f	2026-03-05 03:36:43.531748+00	2026-03-05 03:36:43.531762+00	1	\N	1	\N	\N	\N	\N
4697	2025-10-21	Food	80.00	TWD	expense		f	f	2026-03-05 03:36:43.540021+00	2026-03-05 03:36:43.540034+00	1	\N	1	\N	\N	\N	\N
4698	2025-10-21	Noodles	35.00	TWD	expense		f	f	2026-03-05 03:36:43.548485+00	2026-03-05 03:36:43.548499+00	1	\N	1	\N	\N	\N	\N
4699	2025-10-22	Biscuit	169.00	TWD	expense		f	f	2026-03-05 03:36:43.556781+00	2026-03-05 03:36:43.556795+00	1	\N	1	\N	\N	\N	\N
4700	2025-10-22	Food	99.00	TWD	expense		f	f	2026-03-05 03:36:43.564982+00	2026-03-05 03:36:43.564998+00	1	\N	1	\N	\N	\N	\N
4701	2025-10-22	Food	80.00	TWD	expense		f	f	2026-03-05 03:36:43.573446+00	2026-03-05 03:36:43.573458+00	1	\N	1	\N	\N	\N	\N
4702	2025-10-22	Bread	35.00	TWD	expense		f	f	2026-03-05 03:36:43.606977+00	2026-03-05 03:36:43.606996+00	1	\N	1	\N	\N	\N	\N
4703	2025-10-22	Milk	30.00	TWD	expense		f	f	2026-03-05 03:36:43.623712+00	2026-03-05 03:36:43.623727+00	1	\N	1	\N	\N	\N	\N
4704	2025-10-22	Discount	16.00	TWD	income		f	f	2026-03-05 03:36:43.63202+00	2026-03-05 03:36:43.632034+00	1	\N	10	\N	\N	\N	\N
4705	2025-10-23	Food	99.00	TWD	expense		f	f	2026-03-05 03:36:43.640448+00	2026-03-05 03:36:43.640466+00	1	\N	1	\N	\N	\N	\N
4706	2025-10-24	Food	85.00	TWD	expense		f	f	2026-03-05 03:36:43.648768+00	2026-03-05 03:36:43.648784+00	1	\N	1	\N	\N	\N	\N
4707	2025-10-24	Rice	10.00	TWD	expense		f	f	2026-03-05 03:36:43.657+00	2026-03-05 03:36:43.657014+00	1	\N	1	\N	\N	\N	\N
4708	2025-10-24	Banana	32.00	TWD	expense		f	f	2026-03-05 03:36:43.665426+00	2026-03-05 03:36:43.66544+00	1	\N	1	\N	\N	\N	\N
4709	2025-10-24	Iphone Charger	120.00	TWD	expense		f	f	2026-03-05 03:36:43.673718+00	2026-03-05 03:36:43.673732+00	1	\N	3	\N	\N	\N	\N
4710	2025-10-24	Iphone Charger	60.00	TWD	expense		f	f	2026-03-05 03:36:43.682057+00	2026-03-05 03:36:43.682074+00	1	\N	3	\N	\N	\N	\N
4711	2025-10-24	CAT6A	160.00	TWD	expense		f	f	2026-03-05 03:36:43.690447+00	2026-03-05 03:36:43.690461+00	1	\N	3	\N	\N	\N	\N
4712	2025-10-24	Hand Warmer	246.00	TWD	expense		f	f	2026-03-05 03:36:43.698693+00	2026-03-05 03:36:43.698706+00	1	\N	3	\N	\N	\N	\N
4713	2025-10-24	Detergent	73.00	TWD	expense		f	f	2026-03-05 03:36:43.723839+00	2026-03-05 03:36:43.723853+00	1	\N	3	\N	\N	\N	\N
4714	2025-10-24	Router	375.00	TWD	expense		f	f	2026-03-05 03:36:43.732061+00	2026-03-05 03:36:43.732076+00	1	\N	3	\N	\N	\N	\N
4715	2025-10-24	Cetaphil	669.00	TWD	expense		f	f	2026-03-05 03:36:43.740538+00	2026-03-05 03:36:43.740554+00	1	\N	3	\N	\N	\N	\N
4716	2025-10-25	Food	80.00	TWD	expense		f	f	2026-03-05 03:36:43.74889+00	2026-03-05 03:36:43.748903+00	1	\N	1	\N	\N	\N	\N
4717	2025-10-25	Food.	100.00	TWD	expense		f	f	2026-03-05 03:36:43.757145+00	2026-03-05 03:36:43.757161+00	1	\N	1	\N	\N	\N	\N
4718	2025-10-25	Laundry	50.00	TWD	expense		f	f	2026-03-05 03:36:43.765519+00	2026-03-05 03:36:43.765533+00	1	\N	9	\N	\N	\N	\N
4719	2025-10-25	Dryer	40.00	TWD	expense		f	f	2026-03-05 03:36:43.774436+00	2026-03-05 03:36:43.774462+00	1	\N	9	\N	\N	\N	\N
4720	2025-10-25	Top Up	100.00	TWD	transfer		f	f	2026-03-05 03:36:43.782094+00	2026-03-05 03:36:43.782111+00	1	\N	3	\N	\N	\N	\N
4721	2025-10-26	Food	85.00	TWD	expense		f	f	2026-03-05 03:36:43.790547+00	2026-03-05 03:36:43.790563+00	1	\N	1	\N	\N	\N	\N
4722	2025-10-26	Rice	10.00	TWD	expense		f	f	2026-03-05 03:36:43.798865+00	2026-03-05 03:36:43.798892+00	1	\N	1	\N	\N	\N	\N
4723	2025-10-27	Milk	39.00	TWD	expense		f	f	2026-03-05 03:36:43.80702+00	2026-03-05 03:36:43.807034+00	1	\N	1	\N	\N	\N	\N
4724	2025-10-27	Discount	8.00	TWD	income		f	f	2026-03-05 03:36:43.815413+00	2026-03-05 03:36:43.815429+00	1	\N	10	\N	\N	\N	\N
4725	2025-10-27	Food	80.00	TWD	expense		f	f	2026-03-05 03:36:43.873936+00	2026-03-05 03:36:43.873951+00	1	\N	1	\N	\N	\N	\N
4726	2025-10-27	Rice	10.00	TWD	expense		f	f	2026-03-05 03:36:43.882166+00	2026-03-05 03:36:43.882235+00	1	\N	1	\N	\N	\N	\N
4727	2025-10-28	Food	90.00	TWD	expense		f	f	2026-03-05 03:36:43.890568+00	2026-03-05 03:36:43.890584+00	1	\N	1	\N	\N	\N	\N
4728	2025-10-28	MIlk	39.00	TWD	expense		f	f	2026-03-05 03:36:43.898862+00	2026-03-05 03:36:43.898878+00	1	\N	1	\N	\N	\N	\N
4729	2025-10-28	Bread	39.00	TWD	expense		f	f	2026-03-05 03:36:43.907241+00	2026-03-05 03:36:43.907256+00	1	\N	1	\N	\N	\N	\N
4730	2025-10-29	Food	80.00	TWD	expense		f	f	2026-03-05 03:36:43.915594+00	2026-03-05 03:36:43.91561+00	1	\N	1	\N	\N	\N	\N
4731	2025-10-29	Food	80.00	TWD	expense		f	f	2026-03-05 03:36:43.923958+00	2026-03-05 03:36:43.92397+00	1	\N	1	\N	\N	\N	\N
4732	2025-10-29	Rice	90.00	TWD	expense		f	f	2026-03-05 03:36:43.932262+00	2026-03-05 03:36:43.932279+00	1	\N	1	\N	\N	\N	\N
4733	2025-10-29	Kwek Kwek	18.00	TWD	expense		f	f	2026-03-05 03:36:43.94059+00	2026-03-05 03:36:43.940606+00	1	\N	1	\N	\N	\N	\N
4734	2025-10-30	XLB	65.00	TWD	expense		f	f	2026-03-05 03:36:43.948891+00	2026-03-05 03:36:43.948908+00	1	\N	1	\N	\N	\N	\N
4735	2025-10-30	RICE	45.00	TWD	expense		f	f	2026-03-05 03:36:43.957237+00	2026-03-05 03:36:43.957256+00	1	\N	1	\N	\N	\N	\N
4736	2025-10-30	Certification	1600.00	TWD	expense		f	f	2026-03-05 03:36:43.966642+00	2026-03-05 03:36:43.966654+00	1	\N	3	\N	\N	\N	\N
4737	2025-10-30	Hair Dryer	400.00	TWD	expense		f	f	2026-03-05 03:36:43.973979+00	2026-03-05 03:36:43.973996+00	1	\N	3	\N	\N	\N	\N
4738	2025-10-30	PC Cord	15.00	TWD	expense		f	f	2026-03-05 03:36:43.982267+00	2026-03-05 03:36:43.982283+00	1	\N	3	\N	\N	\N	\N
4739	2025-10-31	Food	99.00	TWD	expense		f	f	2026-03-05 03:36:43.990629+00	2026-03-05 03:36:43.990645+00	1	\N	1	\N	\N	\N	\N
4740	2025-10-31	Food	80.00	TWD	expense		f	f	2026-03-05 03:36:43.998973+00	2026-03-05 03:36:43.998988+00	1	\N	1	\N	\N	\N	\N
4741	2025-10-31	Rice	10.00	TWD	expense		f	f	2026-03-05 03:36:44.007327+00	2026-03-05 03:36:44.007341+00	1	\N	1	\N	\N	\N	\N
4742	2025-11-01	Food	99.00	TWD	expense		f	f	2026-03-05 03:36:44.015747+00	2026-03-05 03:36:44.015762+00	1	\N	1	\N	\N	\N	\N
4743	2025-11-01	Food	80.00	TWD	expense		f	f	2026-03-05 03:36:44.023902+00	2026-03-05 03:36:44.023916+00	1	\N	1	\N	\N	\N	\N
4744	2025-11-01	Rice	10.00	TWD	expense		f	f	2026-03-05 03:36:44.032316+00	2026-03-05 03:36:44.03233+00	1	\N	1	\N	\N	\N	\N
4745	2025-11-01	Laundry	50.00	TWD	expense		f	f	2026-03-05 03:36:44.040681+00	2026-03-05 03:36:44.040698+00	1	\N	9	\N	\N	\N	\N
4746	2025-11-01	Dryer	50.00	TWD	expense		f	f	2026-03-05 03:36:44.049017+00	2026-03-05 03:36:44.049046+00	1	\N	9	\N	\N	\N	\N
4747	2025-11-02	Food	80.00	TWD	expense		f	f	2026-03-05 03:36:44.057337+00	2026-03-05 03:36:44.057353+00	1	\N	1	\N	\N	\N	\N
4748	2025-11-02	Food	91.00	TWD	expense		f	f	2026-03-05 03:36:44.065718+00	2026-03-05 03:36:44.065733+00	1	\N	1	\N	\N	\N	\N
4749	2025-11-02	Coffee	35.00	TWD	expense		f	f	2026-03-05 03:36:44.132371+00	2026-03-05 03:36:44.132388+00	1	\N	1	\N	\N	\N	\N
4750	2025-11-03	Pancit Canton (2Pieces)	26.00	TWD	expense		f	f	2026-03-05 03:36:44.14074+00	2026-03-05 03:36:44.140765+00	1	\N	1	\N	\N	\N	\N
4751	2025-11-03	Indo Mie	65.00	TWD	expense		f	f	2026-03-05 03:36:44.149008+00	2026-03-05 03:36:44.14904+00	1	\N	1	\N	\N	\N	\N
4752	2025-11-03	Nabati Strawberry Wafer	85.00	TWD	expense		f	f	2026-03-05 03:36:44.157443+00	2026-03-05 03:36:44.157465+00	1	\N	1	\N	\N	\N	\N
4753	2025-11-03	Boy Bawang	19.00	TWD	expense		f	f	2026-03-05 03:36:44.165707+00	2026-03-05 03:36:44.165725+00	1	\N	1	\N	\N	\N	\N
4754	2025-11-03	Sunflower Biscuit  Crackers (Mango)	169.00	TWD	expense		f	f	2026-03-05 03:36:44.174154+00	2026-03-05 03:36:44.174222+00	1	\N	1	\N	\N	\N	\N
4755	2025-11-03	Food	80.00	TWD	expense		f	f	2026-03-05 03:36:44.182494+00	2026-03-05 03:36:44.182512+00	1	\N	1	\N	\N	\N	\N
4756	2025-11-03	Rice	10.00	TWD	expense		f	f	2026-03-05 03:36:44.190842+00	2026-03-05 03:36:44.19086+00	1	\N	1	\N	\N	\N	\N
4757	2025-11-03	Food	89.00	TWD	expense		f	f	2026-03-05 03:36:44.198902+00	2026-03-05 03:36:44.198915+00	1	\N	1	\N	\N	\N	\N
4758	2025-11-03	Plate Bowl	59.00	TWD	expense		f	f	2026-03-05 03:36:44.207592+00	2026-03-05 03:36:44.207608+00	1	\N	3	\N	\N	\N	\N
4759	2025-11-04	Food	89.00	TWD	expense		f	f	2026-03-05 03:36:44.322041+00	2026-03-05 03:36:44.322058+00	1	\N	1	\N	\N	\N	\N
4760	2025-11-04	Food	80.00	TWD	expense		f	f	2026-03-05 03:36:44.33254+00	2026-03-05 03:36:44.332558+00	1	\N	1	\N	\N	\N	\N
4761	2025-11-04	Juice	10.00	TWD	expense		f	f	2026-03-05 03:36:44.382809+00	2026-03-05 03:36:44.382823+00	1	\N	1	\N	\N	\N	\N
4762	2025-11-04	Coffee	45.00	TWD	expense		f	f	2026-03-05 03:36:44.390958+00	2026-03-05 03:36:44.390984+00	1	\N	1	\N	\N	\N	\N
4763	2025-11-04	Discount	9.00	TWD	income		f	f	2026-03-05 03:36:44.435504+00	2026-03-05 03:36:44.435519+00	1	\N	10	\N	\N	\N	\N
4764	2025-11-05	Food	85.00	TWD	expense		f	f	2026-03-05 03:36:44.449268+00	2026-03-05 03:36:44.44929+00	1	\N	1	\N	\N	\N	\N
4765	2025-11-05	Rice	10.00	TWD	expense		f	f	2026-03-05 03:36:44.524226+00	2026-03-05 03:36:44.524244+00	1	\N	1	\N	\N	\N	\N
4766	2025-11-05	Juice	30.00	TWD	expense		f	f	2026-03-05 03:36:44.53269+00	2026-03-05 03:36:44.532708+00	1	\N	1	\N	\N	\N	\N
4767	2025-11-05	Ice Cream	25.00	TWD	expense		f	f	2026-03-05 03:36:44.58278+00	2026-03-05 03:36:44.582795+00	1	\N	1	\N	\N	\N	\N
4768	2025-11-06	Food	80.00	TWD	expense		f	f	2026-03-05 03:36:44.591018+00	2026-03-05 03:36:44.591038+00	1	\N	1	\N	\N	\N	\N
4769	2025-11-06	Food	80.00	TWD	expense		f	f	2026-03-05 03:36:44.599227+00	2026-03-05 03:36:44.599249+00	1	\N	1	\N	\N	\N	\N
4770	2025-11-06	Rice	10.00	TWD	expense		f	f	2026-03-05 03:36:44.607622+00	2026-03-05 03:36:44.607635+00	1	\N	1	\N	\N	\N	\N
4771	2025-11-07	Coffee	35.00	TWD	expense		f	f	2026-03-05 03:36:44.616074+00	2026-03-05 03:36:44.61609+00	1	\N	1	\N	\N	\N	\N
4772	2025-11-07	Coffee	35.00	TWD	expense		f	f	2026-03-05 03:36:44.624211+00	2026-03-05 03:36:44.624227+00	1	\N	1	\N	\N	\N	\N
4773	2025-11-07	Food	80.00	TWD	expense		f	f	2026-03-05 03:36:44.632676+00	2026-03-05 03:36:44.632691+00	1	\N	1	\N	\N	\N	\N
4774	2025-11-07	Rice	10.00	TWD	expense		f	f	2026-03-05 03:36:44.640973+00	2026-03-05 03:36:44.640988+00	1	\N	1	\N	\N	\N	\N
4775	2025-11-08	Food	80.00	TWD	expense		f	f	2026-03-05 03:36:44.64921+00	2026-03-05 03:36:44.649233+00	1	\N	1	\N	\N	\N	\N
4776	2025-11-08	Rice	10.00	TWD	expense		f	f	2026-03-05 03:36:44.657699+00	2026-03-05 03:36:44.657715+00	1	\N	1	\N	\N	\N	\N
4777	2025-11-08	Banana	28.00	TWD	expense		f	f	2026-03-05 03:36:44.707698+00	2026-03-05 03:36:44.707712+00	1	\N	1	\N	\N	\N	\N
4778	2025-11-08	Food	99.00	TWD	expense		f	f	2026-03-05 03:36:44.716042+00	2026-03-05 03:36:44.716058+00	1	\N	1	\N	\N	\N	\N
4779	2025-11-08	Milk	30.00	TWD	expense		f	f	2026-03-05 03:36:44.724445+00	2026-03-05 03:36:44.72446+00	1	\N	1	\N	\N	\N	\N
4780	2025-11-08	Laundry	50.00	TWD	expense		f	f	2026-03-05 03:36:44.732741+00	2026-03-05 03:36:44.732758+00	1	\N	9	\N	\N	\N	\N
4781	2025-11-08	Dryer	40.00	TWD	expense		f	f	2026-03-05 03:36:44.74123+00	2026-03-05 03:36:44.741247+00	1	\N	9	\N	\N	\N	\N
4782	2025-11-09	Food	80.00	TWD	expense		f	f	2026-03-05 03:36:44.74931+00	2026-03-05 03:36:44.749325+00	1	\N	1	\N	\N	\N	\N
4783	2025-11-09	Rice	10.00	TWD	expense		f	f	2026-03-05 03:36:44.757792+00	2026-03-05 03:36:44.757807+00	1	\N	1	\N	\N	\N	\N
4784	2025-11-09	Chocomucho	69.00	TWD	expense		f	f	2026-03-05 03:36:44.766032+00	2026-03-05 03:36:44.766047+00	1	\N	1	\N	\N	\N	\N
4785	2025-11-09	Nova	29.00	TWD	expense		f	f	2026-03-05 03:36:44.774441+00	2026-03-05 03:36:44.774455+00	1	\N	1	\N	\N	\N	\N
4786	2025-11-09	Plastic	1.00	TWD	expense		f	f	2026-03-05 03:36:44.782748+00	2026-03-05 03:36:44.782764+00	1	\N	3	\N	\N	\N	\N
4787	2025-11-09	Laundry (Covers)	30.00	TWD	expense		f	f	2026-03-05 03:36:44.791046+00	2026-03-05 03:36:44.791063+00	1	\N	9	\N	\N	\N	\N
4788	2025-11-09	Dryer(Covers)	20.00	TWD	expense		f	f	2026-03-05 03:36:44.799329+00	2026-03-05 03:36:44.799342+00	1	\N	9	\N	\N	\N	\N
4789	2025-11-10	Food	99.00	TWD	expense		f	f	2026-03-05 03:36:44.808878+00	2026-03-05 03:36:44.808896+00	1	\N	1	\N	\N	\N	\N
4790	2025-11-10	Food	80.00	TWD	expense		f	f	2026-03-05 03:36:44.815937+00	2026-03-05 03:36:44.815951+00	1	\N	1	\N	\N	\N	\N
4791	2025-11-10	Rice	10.00	TWD	expense		f	f	2026-03-05 03:36:44.824395+00	2026-03-05 03:36:44.824411+00	1	\N	1	\N	\N	\N	\N
4792	2025-11-10	Milk	39.00	TWD	expense		f	f	2026-03-05 03:36:44.832625+00	2026-03-05 03:36:44.832644+00	1	\N	1	\N	\N	\N	\N
4793	2025-11-10	Discount	7.00	TWD	income		f	f	2026-03-05 03:36:44.841032+00	2026-03-05 03:36:44.841051+00	1	\N	10	\N	\N	\N	\N
4794	2025-11-11	Food	99.00	TWD	expense		f	f	2026-03-05 03:36:44.849381+00	2026-03-05 03:36:44.849397+00	1	\N	1	\N	\N	\N	\N
4795	2025-11-11	Food	95.00	TWD	expense		f	f	2026-03-05 03:36:44.857672+00	2026-03-05 03:36:44.857685+00	1	\N	1	\N	\N	\N	\N
4796	2025-11-11	Headband	46.00	TWD	expense		f	f	2026-03-05 03:36:44.866028+00	2026-03-05 03:36:44.866044+00	1	\N	3	\N	\N	\N	\N
4797	2025-11-11	Headband	58.00	TWD	expense		f	f	2026-03-05 03:36:44.874391+00	2026-03-05 03:36:44.874404+00	1	\N	3	\N	\N	\N	\N
4798	2025-11-11	Hanger	29.00	TWD	expense		f	f	2026-03-05 03:36:44.882647+00	2026-03-05 03:36:44.882661+00	1	\N	3	\N	\N	\N	\N
4799	2025-11-11	Headband	19.00	TWD	expense		f	f	2026-03-05 03:36:44.891084+00	2026-03-05 03:36:44.891099+00	1	\N	3	\N	\N	\N	\N
4800	2025-11-11	Headband	9.00	TWD	expense		f	f	2026-03-05 03:36:44.89959+00	2026-03-05 03:36:44.899604+00	1	\N	3	\N	\N	\N	\N
4801	2025-11-11	Rice Cooker	245.00	TWD	expense		f	f	2026-03-05 03:36:44.907936+00	2026-03-05 03:36:44.907955+00	1	\N	3	\N	\N	\N	\N
4802	2025-11-12	Food	80.00	TWD	expense		f	f	2026-03-05 03:36:44.932749+00	2026-03-05 03:36:44.932763+00	1	\N	1	\N	\N	\N	\N
4803	2025-11-12	Rice	10.00	TWD	expense		f	f	2026-03-05 03:36:44.940945+00	2026-03-05 03:36:44.940961+00	1	\N	1	\N	\N	\N	\N
4804	2025-11-12	Food	90.00	TWD	expense		f	f	2026-03-05 03:36:44.949436+00	2026-03-05 03:36:44.949449+00	1	\N	1	\N	\N	\N	\N
4805	2025-11-13	Food	99.00	TWD	expense		f	f	2026-03-05 03:36:44.958016+00	2026-03-05 03:36:44.958032+00	1	\N	1	\N	\N	\N	\N
4806	2025-11-13	Food	80.00	TWD	expense		f	f	2026-03-05 03:36:44.966377+00	2026-03-05 03:36:44.9664+00	1	\N	1	\N	\N	\N	\N
4807	2025-11-13	Rice	10.00	TWD	expense		f	f	2026-03-05 03:36:44.974496+00	2026-03-05 03:36:44.974509+00	1	\N	1	\N	\N	\N	\N
4808	2025-11-14	Food	99.00	TWD	expense		f	f	2026-03-05 03:36:44.982826+00	2026-03-05 03:36:44.982843+00	1	\N	1	\N	\N	\N	\N
4809	2025-11-14	Food	80.00	TWD	expense		f	f	2026-03-05 03:36:44.991166+00	2026-03-05 03:36:44.991233+00	1	\N	1	\N	\N	\N	\N
4810	2025-11-14	Rice	10.00	TWD	expense		f	f	2026-03-05 03:36:44.99946+00	2026-03-05 03:36:44.999473+00	1	\N	1	\N	\N	\N	\N
4811	2025-11-15	Bigas (10kg)	85.00	TWD	expense		f	f	2026-03-05 03:36:45.007772+00	2026-03-05 03:36:45.007785+00	1	\N	1	\N	\N	\N	\N
4812	2025-11-15	Chicken Nuggets	55.00	TWD	expense		f	f	2026-03-05 03:36:45.015988+00	2026-03-05 03:36:45.016004+00	1	\N	1	\N	\N	\N	\N
4813	2025-11-15	Indo Mie	12.00	TWD	expense		f	f	2026-03-05 03:36:45.024473+00	2026-03-05 03:36:45.024487+00	1	\N	1	\N	\N	\N	\N
4814	2025-11-15	Butter Cookies	200.00	TWD	expense		f	f	2026-03-05 03:36:45.08294+00	2026-03-05 03:36:45.082962+00	1	\N	1	\N	\N	\N	\N
4815	2025-11-15	Milk	41.00	TWD	expense		f	f	2026-03-05 03:36:45.091153+00	2026-03-05 03:36:45.091165+00	1	\N	1	\N	\N	\N	\N
4816	2025-11-15	Bread	22.00	TWD	expense		f	f	2026-03-05 03:36:45.099494+00	2026-03-05 03:36:45.099509+00	1	\N	1	\N	\N	\N	\N
4817	2025-11-15	Plastic Bag	1.00	TWD	expense		f	f	2026-03-05 03:36:45.10793+00	2026-03-05 03:36:45.107943+00	1	\N	3	\N	\N	\N	\N
4818	2025-11-15	Laundry	50.00	TWD	expense		f	f	2026-03-05 03:36:45.116214+00	2026-03-05 03:36:45.11623+00	1	\N	9	\N	\N	\N	\N
4819	2025-11-15	Dryer	50.00	TWD	expense		f	f	2026-03-05 03:36:45.124545+00	2026-03-05 03:36:45.124567+00	1	\N	9	\N	\N	\N	\N
4820	2025-11-16	Chicken	105.00	TWD	expense		f	f	2026-03-05 03:36:45.132825+00	2026-03-05 03:36:45.132846+00	1	\N	1	\N	\N	\N	\N
4821	2025-11-16	Milk	39.00	TWD	expense		f	f	2026-03-05 03:36:45.141216+00	2026-03-05 03:36:45.141231+00	1	\N	1	\N	\N	\N	\N
4822	2025-11-16	Milk	39.00	TWD	expense		f	f	2026-03-05 03:36:45.149598+00	2026-03-05 03:36:45.149616+00	1	\N	1	\N	\N	\N	\N
4823	2025-11-16	VPN	7.00	TWD	expense		f	f	2026-03-05 03:36:45.157802+00	2026-03-05 03:36:45.15782+00	1	\N	3	\N	\N	\N	\N
4824	2025-11-17	Chicken	49.00	TWD	expense		f	f	2026-03-05 03:36:45.16611+00	2026-03-05 03:36:45.166128+00	1	\N	1	\N	\N	\N	\N
4825	2025-11-18	Food	99.00	TWD	expense		f	f	2026-03-05 03:36:45.174778+00	2026-03-05 03:36:45.174796+00	1	\N	1	\N	\N	\N	\N
4826	2025-11-18	BeefSteak	64.00	TWD	expense		f	f	2026-03-05 03:36:45.182853+00	2026-03-05 03:36:45.182868+00	1	\N	1	\N	\N	\N	\N
4827	2025-11-19	Chicken	49.00	TWD	expense		f	f	2026-03-05 03:36:45.191303+00	2026-03-05 03:36:45.19132+00	1	\N	1	\N	\N	\N	\N
4828	2025-11-19	BeefSteak	55.00	TWD	expense		f	f	2026-03-05 03:36:45.241304+00	2026-03-05 03:36:45.241318+00	1	\N	1	\N	\N	\N	\N
4829	2025-11-19	Banana	20.00	TWD	expense		f	f	2026-03-05 03:36:45.24956+00	2026-03-05 03:36:45.249574+00	1	\N	1	\N	\N	\N	\N
4830	2025-11-20	Potato	49.00	TWD	expense		f	f	2026-03-05 03:36:45.299541+00	2026-03-05 03:36:45.299554+00	1	\N	1	\N	\N	\N	\N
4831	2025-11-20	Chicken (Haidilao)	59.00	TWD	expense		f	f	2026-03-05 03:36:45.307943+00	2026-03-05 03:36:45.307969+00	1	\N	1	\N	\N	\N	\N
4832	2025-11-21	Food	99.00	TWD	expense		f	f	2026-03-05 03:36:45.357876+00	2026-03-05 03:36:45.35789+00	1	\N	1	\N	\N	\N	\N
4833	2025-11-21	Food	45.00	TWD	expense		f	f	2026-03-05 03:36:45.366413+00	2026-03-05 03:36:45.366435+00	1	\N	1	\N	\N	\N	\N
4834	2025-11-21	IPass	500.00	TWD	topup		f	f	2026-03-05 03:36:45.416343+00	2026-03-05 03:36:45.416356+00	1	2	3	\N	\N	\N	\N
4835	2025-11-22	Onigiri	55.00	TWD	expense		f	f	2026-03-05 03:36:45.424682+00	2026-03-05 03:36:45.424705+00	1	\N	1	\N	\N	\N	\N
4836	2025-11-22	Juice Box	35.00	TWD	expense		f	f	2026-03-05 03:36:45.474894+00	2026-03-05 03:36:45.474913+00	1	\N	1	\N	\N	\N	\N
4837	2025-11-22	Curry	270.00	TWD	expense		f	f	2026-03-05 03:36:45.508424+00	2026-03-05 03:36:45.508439+00	1	\N	1	\N	\N	\N	\N
4838	2025-11-22	Bottled Water	20.00	TWD	expense		f	f	2026-03-05 03:36:45.51641+00	2026-03-05 03:36:45.516423+00	1	\N	1	\N	\N	\N	\N
4839	2025-11-22	BigMac (meal)	230.00	TWD	expense		f	f	2026-03-05 03:36:45.524753+00	2026-03-05 03:36:45.524767+00	1	\N	1	\N	\N	\N	\N
4840	2025-11-22	Laundry	50.00	TWD	expense		f	f	2026-03-05 03:36:45.532981+00	2026-03-05 03:36:45.532996+00	1	\N	9	\N	\N	\N	\N
4841	2025-11-22	Dryer	60.00	TWD	expense		f	f	2026-03-05 03:36:45.541334+00	2026-03-05 03:36:45.541348+00	1	\N	9	\N	\N	\N	\N
4842	2025-11-22	Eco Bag	7.00	TWD	expense		f	f	2026-03-05 03:36:45.549661+00	2026-03-05 03:36:45.549674+00	1	\N	3	\N	\N	\N	\N
4843	2025-11-23	Food	99.00	TWD	expense		f	f	2026-03-05 03:36:45.558054+00	2026-03-05 03:36:45.558078+00	1	\N	1	\N	\N	\N	\N
4844	2025-11-23	Chicken	105.00	TWD	expense		f	f	2026-03-05 03:36:45.566549+00	2026-03-05 03:36:45.566566+00	1	\N	1	\N	\N	\N	\N
4845	2025-11-23	Milk	50.00	TWD	expense		f	f	2026-03-05 03:36:45.574883+00	2026-03-05 03:36:45.574898+00	1	\N	1	\N	\N	\N	\N
4846	2025-11-24	Food	99.00	TWD	expense		f	f	2026-03-05 03:36:45.583088+00	2026-03-05 03:36:45.583102+00	1	\N	1	\N	\N	\N	\N
4847	2025-11-24	Food	45.00	TWD	expense		f	f	2026-03-05 03:36:45.59153+00	2026-03-05 03:36:45.591545+00	1	\N	1	\N	\N	\N	\N
4848	2025-11-24	Juice	78.00	TWD	expense		f	f	2026-03-05 03:36:45.599754+00	2026-03-05 03:36:45.599769+00	1	\N	1	\N	\N	\N	\N
4849	2025-11-24	Scotch brite	10.00	TWD	expense		f	f	2026-03-05 03:36:45.608266+00	2026-03-05 03:36:45.608288+00	1	\N	3	\N	\N	\N	\N
4850	2025-11-25	Chicken	49.00	TWD	expense		f	f	2026-03-05 03:36:45.616591+00	2026-03-05 03:36:45.616605+00	1	\N	1	\N	\N	\N	\N
4851	2025-11-25	XLB	65.00	TWD	expense		f	f	2026-03-05 03:36:45.624968+00	2026-03-05 03:36:45.624983+00	1	\N	1	\N	\N	\N	\N
4852	2025-11-25	Big Mac (Solo)	73.00	TWD	expense		f	f	2026-03-05 03:36:45.633102+00	2026-03-05 03:36:45.633115+00	1	\N	1	\N	\N	\N	\N
4853	2025-11-25	Juice	78.00	TWD	expense		f	f	2026-03-05 03:36:45.641452+00	2026-03-05 03:36:45.641465+00	1	\N	1	\N	\N	\N	\N
4854	2025-11-26	Food	99.00	TWD	expense		f	f	2026-03-05 03:36:45.649765+00	2026-03-05 03:36:45.649778+00	1	\N	1	\N	\N	\N	\N
4855	2025-11-26	Food	55.00	TWD	expense		f	f	2026-03-05 03:36:45.658095+00	2026-03-05 03:36:45.658108+00	1	\N	1	\N	\N	\N	\N
4856	2025-11-26	Food	55.00	TWD	expense		f	f	2026-03-05 03:36:45.666447+00	2026-03-05 03:36:45.66646+00	1	\N	1	\N	\N	\N	\N
4857	2025-11-27	Food	89.00	TWD	expense		f	f	2026-03-05 03:36:45.674851+00	2026-03-05 03:36:45.674865+00	1	\N	1	\N	\N	\N	\N
4858	2025-11-27	Food	78.00	TWD	expense		f	f	2026-03-05 03:36:45.683069+00	2026-03-05 03:36:45.683084+00	1	\N	1	\N	\N	\N	\N
4859	2025-11-27	Waffle	80.00	TWD	expense		f	f	2026-03-05 03:36:45.691472+00	2026-03-05 03:36:45.691486+00	1	\N	1	\N	\N	\N	\N
4860	2025-11-28	Onigiri	55.00	TWD	expense		f	f	2026-03-05 03:36:45.699806+00	2026-03-05 03:36:45.699821+00	1	\N	1	\N	\N	\N	\N
4861	2025-11-28	Noodles	89.00	TWD	expense		f	f	2026-03-05 03:36:45.708097+00	2026-03-05 03:36:45.70811+00	1	\N	1	\N	\N	\N	\N
4862	2025-11-28	Bread	45.00	TWD	expense		f	f	2026-03-05 03:36:45.716509+00	2026-03-05 03:36:45.716526+00	1	\N	1	\N	\N	\N	\N
4863	2025-11-28	Bread	45.00	TWD	expense		f	f	2026-03-05 03:36:45.724778+00	2026-03-05 03:36:45.724796+00	1	\N	1	\N	\N	\N	\N
4864	2025-11-28	Laundry	50.00	TWD	expense		f	f	2026-03-05 03:36:45.733159+00	2026-03-05 03:36:45.733217+00	1	\N	9	\N	\N	\N	\N
4865	2025-11-28	Dryer	60.00	TWD	expense		f	f	2026-03-05 03:36:45.741551+00	2026-03-05 03:36:45.741566+00	1	\N	9	\N	\N	\N	\N
4866	2025-11-28	IPass	500.00	TWD	topup		f	f	2026-03-05 03:36:45.749894+00	2026-03-05 03:36:45.749909+00	1	2	3	\N	\N	\N	\N
4867	2025-11-29	Sandwich	35.00	TWD	expense		f	f	2026-03-05 03:36:45.758257+00	2026-03-05 03:36:45.758275+00	1	\N	1	\N	\N	\N	\N
4868	2025-11-29	Ramen	285.00	TWD	expense		f	f	2026-03-05 03:36:45.766587+00	2026-03-05 03:36:45.7666+00	1	\N	1	\N	\N	\N	\N
4869	2025-12-07	Chicken (Combo 1)	105.00	TWD	expense		f	f	2026-03-05 03:36:45.774882+00	2026-03-05 03:36:45.774896+00	1	\N	1	\N	\N	\N	\N
4870	2025-12-07	Bigas	170.00	TWD	expense		f	f	2026-03-05 03:36:45.783146+00	2026-03-05 03:36:45.78316+00	1	\N	3	\N	\N	\N	\N
4871	2025-12-07	Dishwashing	45.00	TWD	expense		f	f	2026-03-05 03:36:45.791526+00	2026-03-05 03:36:45.791539+00	1	\N	3	\N	\N	\N	\N
4872	2025-12-08	Spicy Chicken	49.00	TWD	expense		f	f	2026-03-05 03:36:45.799826+00	2026-03-05 03:36:45.799838+00	1	\N	1	\N	\N	\N	\N
4873	2025-12-08	Banana	60.00	TWD	expense		f	f	2026-03-05 03:36:45.808296+00	2026-03-05 03:36:45.808314+00	1	\N	1	\N	\N	\N	\N
4874	2025-12-08	Laundry	55.00	TWD	expense		f	f	2026-03-05 03:36:45.816609+00	2026-03-05 03:36:45.816625+00	1	\N	9	\N	\N	\N	\N
4875	2025-12-08	Medical Exam	700.00	TWD	expense		f	f	2026-03-05 03:36:45.825017+00	2026-03-05 03:36:45.825033+00	1	\N	3	\N	\N	\N	\N
4876	2025-12-08	Personal Stamp	100.00	TWD	expense		f	f	2026-03-05 03:36:45.859426+00	2026-03-05 03:36:45.85944+00	1	\N	3	\N	\N	\N	\N
4877	2025-12-09	Bread	22.00	TWD	expense		f	f	2026-03-05 03:36:45.874969+00	2026-03-05 03:36:45.874984+00	1	\N	1	\N	\N	\N	\N
4878	2025-12-09	Lunch Food	45.00	TWD	expense		f	f	2026-03-05 03:36:45.885123+00	2026-03-05 03:36:45.885137+00	1	\N	1	\N	\N	\N	\N
4879	2025-12-09	Dinner Food	55.00	TWD	expense		f	f	2026-03-05 03:36:45.891612+00	2026-03-05 03:36:45.891624+00	1	\N	1	\N	\N	\N	\N
4880	2025-12-09	Coffee	70.00	TWD	expense		f	f	2026-03-05 03:36:45.899918+00	2026-03-05 03:36:45.899944+00	1	\N	1	\N	\N	\N	\N
4881	2025-12-09	Hose	60.00	TWD	expense		f	f	2026-03-05 03:36:45.908336+00	2026-03-05 03:36:45.908351+00	1	\N	3	\N	\N	\N	\N
4882	2025-12-10	Bread (Pasalubong)	370.00	TWD	expense		f	f	2026-03-05 03:36:45.916566+00	2026-03-05 03:36:45.916582+00	1	\N	3	\N	\N	\N	\N
4883	2025-12-10	Ramen (Pasalubong)	1396.00	TWD	expense		f	f	2026-03-05 03:36:45.924963+00	2026-03-05 03:36:45.92498+00	1	\N	3	\N	\N	\N	\N
4884	2025-12-10	Ramen (Pasalubong)	199.00	TWD	expense		f	f	2026-03-05 03:36:45.933289+00	2026-03-05 03:36:45.933302+00	1	\N	3	\N	\N	\N	\N
4885	2025-12-10	Lunch Food	49.00	TWD	expense		f	f	2026-03-05 03:36:45.94162+00	2026-03-05 03:36:45.941634+00	1	\N	1	\N	\N	\N	\N
4886	2025-12-10	Lunch Food	49.00	TWD	expense		f	f	2026-03-05 03:36:45.949869+00	2026-03-05 03:36:45.949882+00	1	\N	1	\N	\N	\N	\N
4887	2025-12-10	Dinner Food	55.00	TWD	expense		f	f	2026-03-05 03:36:45.958361+00	2026-03-05 03:36:45.958376+00	1	\N	1	\N	\N	\N	\N
4888	2025-12-11	Lunch Food	99.00	TWD	expense		f	f	2026-03-05 03:36:45.966662+00	2026-03-05 03:36:45.966675+00	1	\N	1	\N	\N	\N	\N
4889	2025-12-13	Banana (9 pIeces)	77.00	TWD	expense		f	f	2026-03-05 03:36:45.974976+00	2026-03-05 03:36:45.974991+00	1	\N	1	\N	\N	\N	\N
4890	2025-12-13	Orange (7 Pieces)	136.00	TWD	expense		f	f	2026-03-05 03:36:45.983394+00	2026-03-05 03:36:45.983407+00	1	\N	1	\N	\N	\N	\N
4891	2025-12-13	Dinner Food	49.00	TWD	expense		f	f	2026-03-05 03:36:46.058406+00	2026-03-05 03:36:46.05842+00	1	\N	1	\N	\N	\N	\N
4892	2025-12-13	Dinner Food	49.00	TWD	expense		f	f	2026-03-05 03:36:46.066739+00	2026-03-05 03:36:46.066754+00	1	\N	1	\N	\N	\N	\N
4893	2025-12-13	Lunch Food	49.00	TWD	expense		f	f	2026-03-05 03:36:46.07506+00	2026-03-05 03:36:46.075075+00	1	\N	1	\N	\N	\N	\N
4894	2025-12-13	Egg (12 Pieces)	30.00	TWD	expense		f	f	2026-03-05 03:36:46.083432+00	2026-03-05 03:36:46.083445+00	1	\N	3	\N	\N	\N	\N
4895	2025-12-13	Laundry	50.00	TWD	expense		f	f	2026-03-05 03:36:46.091665+00	2026-03-05 03:36:46.091678+00	1	\N	9	\N	\N	\N	\N
4896	2025-12-13	Dryer	60.00	TWD	expense		f	f	2026-03-05 03:36:46.099881+00	2026-03-05 03:36:46.099894+00	1	\N	9	\N	\N	\N	\N
4897	2025-12-13	Screen Protector	118.00	TWD	expense		f	f	2026-03-05 03:36:46.108232+00	2026-03-05 03:36:46.108249+00	1	\N	3	\N	\N	\N	\N
4898	2025-12-13	Screen Protector	88.00	TWD	expense		f	f	2026-03-05 03:36:46.116625+00	2026-03-05 03:36:46.116638+00	1	\N	3	\N	\N	\N	\N
4899	2025-12-13	Luggage Scale	79.00	TWD	expense		f	f	2026-03-05 03:36:46.125213+00	2026-03-05 03:36:46.125228+00	1	\N	3	\N	\N	\N	\N
4900	2025-12-13	EVA (Crocs	269.00	TWD	expense		f	f	2026-03-05 03:36:46.133251+00	2026-03-05 03:36:46.133268+00	1	\N	3	\N	\N	\N	\N
4901	2025-12-13	Lint Roller	20.00	TWD	expense		f	f	2026-03-05 03:36:46.141645+00	2026-03-05 03:36:46.14166+00	1	\N	3	\N	\N	\N	\N
4902	2025-12-13	Marker	7.00	TWD	expense		f	f	2026-03-05 03:36:46.149908+00	2026-03-05 03:36:46.149935+00	1	\N	3	\N	\N	\N	\N
4903	2025-12-13	Floss	26.00	TWD	expense		f	f	2026-03-05 03:36:46.19182+00	2026-03-05 03:36:46.191836+00	1	\N	3	\N	\N	\N	\N
4904	2025-12-13	Floss Dispenser	29.00	TWD	expense		f	f	2026-03-05 03:36:46.242221+00	2026-03-05 03:36:46.242238+00	1	\N	3	\N	\N	\N	\N
4905	2025-12-13	Shower Head	20.00	TWD	expense		f	f	2026-03-05 03:36:46.2501+00	2026-03-05 03:36:46.250116+00	1	\N	3	\N	\N	\N	\N
4906	2025-12-13	Charger	100.00	TWD	expense		f	f	2026-03-05 03:36:46.382652+00	2026-03-05 03:36:46.382667+00	1	\N	3	\N	\N	\N	\N
4907	2025-12-13	Cards	25.00	TWD	expense		f	f	2026-03-05 03:36:46.391824+00	2026-03-05 03:36:46.391839+00	1	\N	3	\N	\N	\N	\N
4908	2025-12-14	Quacker Oats (1.1kg)	159.00	TWD	expense		f	f	2026-03-05 03:36:46.441827+00	2026-03-05 03:36:46.441841+00	1	\N	1	\N	\N	\N	\N
4909	2025-12-14	Bread	45.00	TWD	expense		f	f	2026-03-05 03:36:46.45024+00	2026-03-05 03:36:46.450258+00	1	\N	1	\N	\N	\N	\N
4910	2025-12-14	ChocoMucho	69.00	TWD	expense		f	f	2026-03-05 03:36:46.479206+00	2026-03-05 03:36:46.479224+00	1	\N	1	\N	\N	\N	\N
4911	2025-12-14	Boy Bawang	19.00	TWD	expense		f	f	2026-03-05 03:36:46.500259+00	2026-03-05 03:36:46.500278+00	1	\N	1	\N	\N	\N	\N
4912	2025-12-14	Sky Flakes (32pcs)	189.00	TWD	expense		f	f	2026-03-05 03:36:46.575491+00	2026-03-05 03:36:46.575504+00	1	\N	1	\N	\N	\N	\N
4913	2025-12-14	Chicken	75.00	TWD	expense		f	f	2026-03-05 03:36:46.583604+00	2026-03-05 03:36:46.583617+00	1	\N	1	\N	\N	\N	\N
4914	2025-12-14	Chicken popcorn	45.00	TWD	expense		f	f	2026-03-05 03:36:46.592047+00	2026-03-05 03:36:46.592063+00	1	\N	1	\N	\N	\N	\N
4915	2025-12-14	Plastic	3.00	TWD	expense		f	f	2026-03-05 03:36:46.600416+00	2026-03-05 03:36:46.600432+00	1	\N	3	\N	\N	\N	\N
4916	2025-12-14	Toothpaste	21.00	TWD	expense		f	f	2026-03-05 03:36:46.608676+00	2026-03-05 03:36:46.60869+00	1	\N	3	\N	\N	\N	\N
4917	2025-12-15	lunch Food	49.00	TWD	expense		f	f	2026-03-05 03:36:46.616965+00	2026-03-05 03:36:46.616979+00	1	\N	1	\N	\N	\N	\N
4918	2025-12-15	XLB	65.00	TWD	expense		f	f	2026-03-05 03:36:46.625442+00	2026-03-05 03:36:46.625456+00	1	\N	1	\N	\N	\N	\N
4919	2025-12-15	Rice	55.00	TWD	expense		f	f	2026-03-05 03:36:46.633718+00	2026-03-05 03:36:46.633731+00	1	\N	1	\N	\N	\N	\N
4920	2025-12-16	Dinner Food	49.00	TWD	expense		f	f	2026-03-05 03:36:46.642012+00	2026-03-05 03:36:46.642027+00	1	\N	1	\N	\N	\N	\N
4921	2025-12-16	Dinner Food	49.00	TWD	expense		f	f	2026-03-05 03:36:46.650334+00	2026-03-05 03:36:46.650347+00	1	\N	1	\N	\N	\N	\N
4922	2025-12-17	Lunch Food	49.00	TWD	expense		f	f	2026-03-05 03:36:46.658651+00	2026-03-05 03:36:46.658665+00	1	\N	1	\N	\N	\N	\N
4923	2025-12-17	Lunch Food	49.00	TWD	expense		f	f	2026-03-05 03:36:46.666968+00	2026-03-05 03:36:46.666981+00	1	\N	1	\N	\N	\N	\N
4924	2025-12-18	Lunch Food	49.00	TWD	expense		f	f	2026-03-05 03:36:46.675328+00	2026-03-05 03:36:46.675342+00	1	\N	1	\N	\N	\N	\N
4925	2025-12-18	Pocari	39.00	TWD	expense		f	f	2026-03-05 03:36:46.683624+00	2026-03-05 03:36:46.683637+00	1	\N	1	\N	\N	\N	\N
4926	2025-12-19	Lunch Food	49.00	TWD	expense		f	f	2026-03-05 03:36:46.691976+00	2026-03-05 03:36:46.691991+00	1	\N	1	\N	\N	\N	\N
4927	2025-12-20	Laundry	50.00	TWD	expense		f	f	2026-03-05 03:36:46.700333+00	2026-03-05 03:36:46.700348+00	1	\N	9	\N	\N	\N	\N
4928	2025-12-20	Dryer	60.00	TWD	expense		f	f	2026-03-05 03:36:46.708628+00	2026-03-05 03:36:46.708642+00	1	\N	9	\N	\N	\N	\N
4929	2025-12-21	Chicken	75.00	TWD	expense		f	f	2026-03-05 03:36:46.717047+00	2026-03-05 03:36:46.717064+00	1	\N	1	\N	\N	\N	\N
4930	2025-12-21	Chicken Popcorn	45.00	TWD	expense		f	f	2026-03-05 03:36:46.725402+00	2026-03-05 03:36:46.725418+00	1	\N	1	\N	\N	\N	\N
4931	2025-12-21	Ipass	500.00	TWD	topup		f	f	2026-03-05 03:36:46.733774+00	2026-03-05 03:36:46.733789+00	1	2	3	\N	\N	\N	\N
4932	2025-12-21	Plastic	2.00	TWD	expense		f	f	2026-03-05 03:36:46.742008+00	2026-03-05 03:36:46.742022+00	1	\N	3	\N	\N	\N	\N
4933	2025-12-24	Banana(12Pieces)	130.00	TWD	expense		f	f	2026-03-05 03:36:46.750386+00	2026-03-05 03:36:46.750399+00	1	\N	1	\N	\N	\N	\N
4934	2025-12-24	Egg(10Pieces)	45.00	TWD	expense		f	f	2026-03-05 03:36:46.758759+00	2026-03-05 03:36:46.758775+00	1	\N	1	\N	\N	\N	\N
4935	2025-12-24	Rice(5kg)	175.00	TWD	expense		f	f	2026-03-05 03:36:46.767004+00	2026-03-05 03:36:46.767019+00	1	\N	1	\N	\N	\N	\N
4936	2025-12-24	Oreo	35.00	TWD	expense		f	f	2026-03-05 03:36:46.77545+00	2026-03-05 03:36:46.775465+00	1	\N	1	\N	\N	\N	\N
4937	2025-12-24	Oreo	35.00	TWD	expense		f	f	2026-03-05 03:36:46.783783+00	2026-03-05 03:36:46.783801+00	1	\N	1	\N	\N	\N	\N
4938	2025-12-24	All Purpose Cream (APC)	69.00	TWD	expense		f	f	2026-03-05 03:36:46.792002+00	2026-03-05 03:36:46.792016+00	1	\N	1	\N	\N	\N	\N
4939	2025-12-24	All Purpose Cream (APC)	69.00	TWD	expense		f	f	2026-03-05 03:36:46.80046+00	2026-03-05 03:36:46.800473+00	1	\N	1	\N	\N	\N	\N
4940	2025-12-24	APC (Discount)	20.00	TWD	income		f	f	2026-03-05 03:36:46.8088+00	2026-03-05 03:36:46.808816+00	1	\N	10	\N	\N	\N	\N
4941	2025-12-24	Alaska Condensed	60.00	TWD	expense		f	f	2026-03-05 03:36:46.817253+00	2026-03-05 03:36:46.817268+00	1	\N	1	\N	\N	\N	\N
4942	2025-12-24	Alaska Condensed (Discount)	5.00	TWD	income		f	f	2026-03-05 03:36:46.825539+00	2026-03-05 03:36:46.825554+00	1	\N	10	\N	\N	\N	\N
4943	2025-12-24	Graham	45.00	TWD	expense		f	f	2026-03-05 03:36:46.833832+00	2026-03-05 03:36:46.833845+00	1	\N	1	\N	\N	\N	\N
4944	2025-12-24	Graham	45.00	TWD	expense		f	f	2026-03-05 03:36:46.842116+00	2026-03-05 03:36:46.842129+00	1	\N	1	\N	\N	\N	\N
4945	2025-12-24	Graham (Discount)	45.00	TWD	income		f	f	2026-03-05 03:36:46.850462+00	2026-03-05 03:36:46.850475+00	1	\N	10	\N	\N	\N	\N
4946	2025-12-24	Plastic	1.00	TWD	expense		f	f	2026-03-05 03:36:46.858783+00	2026-03-05 03:36:46.858796+00	1	\N	3	\N	\N	\N	\N
4947	2025-12-24	Tupperware	69.00	TWD	expense		f	f	2026-03-05 03:36:46.867127+00	2026-03-05 03:36:46.867141+00	1	\N	3	\N	\N	\N	\N
4948	2025-12-24	Ipass	500.00	TWD	topup		f	f	2026-03-05 03:36:46.875461+00	2026-03-05 03:36:46.875475+00	1	2	3	\N	\N	\N	\N
4949	2025-12-25	Ramen	180.00	TWD	expense		f	f	2026-03-05 03:36:46.883669+00	2026-03-05 03:36:46.883683+00	1	\N	1	\N	\N	\N	\N
4950	2025-12-25	Pork	100.00	TWD	expense		f	f	2026-03-05 03:36:46.89212+00	2026-03-05 03:36:46.892136+00	1	\N	1	\N	\N	\N	\N
4951	2025-12-25	Lunch Food	99.00	TWD	expense		f	f	2026-03-05 03:36:46.900513+00	2026-03-05 03:36:46.900527+00	1	\N	1	\N	\N	\N	\N
4952	2025-12-26	Ramen	180.00	TWD	expense		f	f	2026-03-05 03:36:46.908711+00	2026-03-05 03:36:46.908724+00	1	\N	1	\N	\N	\N	\N
4953	2025-12-26	Pork Chasu	100.00	TWD	expense		f	f	2026-03-05 03:36:46.916986+00	2026-03-05 03:36:46.916999+00	1	\N	1	\N	\N	\N	\N
4954	2025-12-26	Lunch Bento	99.00	TWD	expense		f	f	2026-03-05 03:36:46.925531+00	2026-03-05 03:36:46.925545+00	1	\N	1	\N	\N	\N	\N
4955	2025-12-27	Korean Chicken	49.00	TWD	expense		f	f	2026-03-05 03:36:46.933765+00	2026-03-05 03:36:46.933779+00	1	\N	1	\N	\N	\N	\N
4956	2025-12-27	Spicy Chicken Balls	49.00	TWD	expense		f	f	2026-03-05 03:36:46.942143+00	2026-03-05 03:36:46.942158+00	1	\N	1	\N	\N	\N	\N
4957	2025-12-27	BigMac	159.00	TWD	expense		f	f	2026-03-05 03:36:46.950572+00	2026-03-05 03:36:46.950587+00	1	\N	1	\N	\N	\N	\N
4958	2025-12-27	Angus Burger	92.00	TWD	expense		f	f	2026-03-05 03:36:46.958819+00	2026-03-05 03:36:46.958833+00	1	\N	1	\N	\N	\N	\N
4959	2025-12-27	Boy Bawang	19.00	TWD	expense		f	f	2026-03-05 03:36:46.967151+00	2026-03-05 03:36:46.967165+00	1	\N	1	\N	\N	\N	\N
4960	2025-12-27	Boy Bawang	19.00	TWD	expense		f	f	2026-03-05 03:36:46.975566+00	2026-03-05 03:36:46.97558+00	1	\N	1	\N	\N	\N	\N
4961	2025-12-27	Boy Bawang	20.00	TWD	expense		f	f	2026-03-05 03:36:46.983855+00	2026-03-05 03:36:46.98388+00	1	\N	1	\N	\N	\N	\N
4962	2025-12-27	Tattoos	10.00	TWD	expense		f	f	2026-03-05 03:36:46.992241+00	2026-03-05 03:36:46.992255+00	1	\N	1	\N	\N	\N	\N
4963	2025-12-27	Samyang Buldak	52.00	TWD	expense		f	f	2026-03-05 03:36:47.000572+00	2026-03-05 03:36:47.000585+00	1	\N	1	\N	\N	\N	\N
4964	2025-12-27	Laundry Bag	10.00	TWD	expense		f	f	2026-03-05 03:36:47.00891+00	2026-03-05 03:36:47.008924+00	1	\N	9	\N	\N	\N	\N
4965	2025-12-27	Laundry	70.00	TWD	expense		f	f	2026-03-05 03:36:47.01721+00	2026-03-05 03:36:47.017227+00	1	\N	9	\N	\N	\N	\N
4966	2025-12-27	Dryer	60.00	TWD	expense		f	f	2026-03-05 03:36:47.026477+00	2026-03-05 03:36:47.026497+00	1	\N	9	\N	\N	\N	\N
4967	2025-12-27	Keychain	43.00	TWD	expense		f	f	2026-03-05 03:36:47.033853+00	2026-03-05 03:36:47.033878+00	1	\N	3	\N	\N	\N	\N
4968	2025-12-27	Screen Protector	88.00	TWD	expense		f	f	2026-03-05 03:36:47.042163+00	2026-03-05 03:36:47.042219+00	1	\N	3	\N	\N	\N	\N
4969	2025-12-27	Lightning Adapter	66.00	TWD	expense		f	f	2026-03-05 03:36:47.050606+00	2026-03-05 03:36:47.050621+00	1	\N	3	\N	\N	\N	\N
4970	2025-12-27	Pares	50.00	TWD	expense		f	f	2026-03-05 03:36:47.058941+00	2026-03-05 03:36:47.058956+00	1	\N	1	\N	\N	\N	\N
4971	2025-12-27	Sisig	45.00	TWD	expense		f	f	2026-03-05 03:36:47.06736+00	2026-03-05 03:36:47.067374+00	1	\N	1	\N	\N	\N	\N
4972	2025-12-27	Bread	30.00	TWD	expense		f	f	2026-03-05 03:36:47.075631+00	2026-03-05 03:36:47.075647+00	1	\N	1	\N	\N	\N	\N
4973	2025-12-27	ButterCream Crackers	169.00	TWD	expense		f	f	2026-03-05 03:36:47.084081+00	2026-03-05 03:36:47.084099+00	1	\N	1	\N	\N	\N	\N
4974	2025-12-28	Chicken	80.00	TWD	expense		f	f	2026-03-05 03:36:47.092371+00	2026-03-05 03:36:47.092387+00	1	\N	1	\N	\N	\N	\N
4975	2025-12-28	Milk	39.00	TWD	expense		f	f	2026-03-05 03:36:47.100762+00	2026-03-05 03:36:47.100776+00	1	\N	1	\N	\N	\N	\N
4976	2025-12-28	Discount Milk	11.00	TWD	income		f	f	2026-03-05 03:36:47.109062+00	2026-03-05 03:36:47.109077+00	1	\N	10	\N	\N	\N	\N
4977	2025-12-28	Meiji	59.00	TWD	expense		f	f	2026-03-05 03:36:47.117313+00	2026-03-05 03:36:47.117326+00	1	\N	1	\N	\N	\N	\N
4978	2025-12-28	Meiji	59.00	TWD	expense		f	f	2026-03-05 03:36:47.125794+00	2026-03-05 03:36:47.125808+00	1	\N	1	\N	\N	\N	\N
4979	2025-12-28	Discount Meiji	28.00	TWD	income		f	f	2026-03-05 03:36:47.150759+00	2026-03-05 03:36:47.150783+00	1	\N	10	\N	\N	\N	\N
4980	2025-12-29	Food	99.00	TWD	expense		f	f	2026-03-05 03:36:47.159006+00	2026-03-05 03:36:47.159025+00	2	\N	1	\N	\N	\N	\N
4981	2025-12-29	Converted to Cash	99.00	TWD	expense		f	f	2026-03-05 03:36:47.167348+00	2026-03-05 03:36:47.167362+00	2	\N	3	\N	\N	\N	\N
4982	2025-12-29	Converted to Cash	99.00	TWD	income		f	f	2026-03-05 03:36:47.175578+00	2026-03-05 03:36:47.175593+00	1	\N	3	\N	\N	\N	\N
4983	2025-12-29	Converted to Cash	99.00	TWD	expense		f	f	2026-03-05 03:36:47.183979+00	2026-03-05 03:36:47.183997+00	2	\N	3	\N	\N	\N	\N
4984	2025-12-29	Converted to Cash	99.00	TWD	income		f	f	2026-03-05 03:36:47.19237+00	2026-03-05 03:36:47.192385+00	1	\N	3	\N	\N	\N	\N
4985	2026-01-01	McDo Chicken (12-Piece)	259.00	TWD	expense		f	f	2026-03-05 03:36:47.200714+00	2026-03-05 03:36:47.200726+00	1	\N	1	\N	\N	\N	\N
4986	2026-01-01	BigMac	159.00	TWD	expense		f	f	2026-03-05 03:36:47.250726+00	2026-03-05 03:36:47.25074+00	1	\N	1	\N	\N	\N	\N
4987	2026-01-02	Korean Fried Chicken	49.00	TWD	expense		f	f	2026-03-05 03:36:47.292479+00	2026-03-05 03:36:47.292496+00	2	\N	1	\N	\N	\N	\N
4988	2026-01-02	Pan Fried Pork Pie	49.00	TWD	expense		f	f	2026-03-05 03:36:47.34238+00	2026-03-05 03:36:47.342394+00	2	\N	1	\N	\N	\N	\N
4989	2026-01-02	Converted To Cash	49.00	TWD	expense		f	f	2026-03-05 03:36:47.350712+00	2026-03-05 03:36:47.350728+00	2	\N	3	\N	\N	\N	\N
4990	2026-01-02	Converted To Cash	49.00	TWD	income		f	f	2026-03-05 03:36:47.429489+00	2026-03-05 03:36:47.429502+00	1	\N	3	\N	\N	\N	\N
4991	2026-01-03	XLB	65.00	TWD	expense		f	f	2026-03-05 03:36:47.442508+00	2026-03-05 03:36:47.442525+00	1	\N	1	\N	\N	\N	\N
4992	2026-01-03	Laundry	60.00	TWD	expense		f	f	2026-03-05 03:36:47.492456+00	2026-03-05 03:36:47.492471+00	1	\N	9	\N	\N	\N	\N
4993	2026-01-03	Dryer	60.00	TWD	expense		f	f	2026-03-05 03:36:47.500783+00	2026-03-05 03:36:47.500798+00	1	\N	9	\N	\N	\N	\N
4994	2026-01-03	Laundry(Cover)	50.00	TWD	expense		f	f	2026-03-05 03:36:47.659091+00	2026-03-05 03:36:47.659105+00	1	\N	9	\N	\N	\N	\N
4995	2026-01-03	XLB Rice	55.00	TWD	expense		f	f	2026-03-05 03:36:47.667546+00	2026-03-05 03:36:47.667563+00	1	\N	1	\N	\N	\N	\N
4996	2026-01-04	Chicken	100.00	TWD	expense		f	f	2026-03-05 03:36:47.675877+00	2026-03-05 03:36:47.675892+00	1	\N	1	\N	\N	\N	\N
4997	2026-01-04	Withdraw 10kNTD	10000.00	TWD	transfer		f	f	2026-03-05 03:36:47.684327+00	2026-03-05 03:36:47.684341+00	5	1	3	\N	\N	\N	\N
4998	2026-01-04	Dorm	9400.00	TWD	expense		f	f	2026-03-05 03:36:47.692595+00	2026-03-05 03:36:47.692609+00	1	\N	3	\N	\N	\N	\N
4999	2026-01-06	Katsudon (Lunch)	99.00	TWD	expense		f	f	2026-03-05 03:36:47.700801+00	2026-03-05 03:36:47.700815+00	1	\N	1	\N	\N	\N	\N
5000	2026-01-06	Juice	35.00	TWD	expense		f	f	2026-03-05 03:36:47.709142+00	2026-03-05 03:36:47.709158+00	1	\N	1	\N	\N	\N	\N
5001	2026-01-07	Midnight Snack	119.00	TWD	expense		f	f	2026-03-05 03:36:47.717566+00	2026-03-05 03:36:47.717583+00	1	\N	1	\N	\N	\N	\N
5002	2026-01-07	Screen Protector	66.00	TWD	expense		f	f	2026-03-05 03:36:47.725895+00	2026-03-05 03:36:47.72591+00	1	\N	3	\N	\N	\N	\N
5003	2026-01-07	Keychain	43.00	TWD	expense		f	f	2026-03-05 03:36:47.734237+00	2026-03-05 03:36:47.734253+00	1	\N	3	\N	\N	\N	\N
5004	2026-01-07	Adapter	88.00	TWD	expense		f	f	2026-03-05 03:36:47.767687+00	2026-03-05 03:36:47.767703+00	1	\N	3	\N	\N	\N	\N
5005	2026-01-07	Coffee	20.00	TWD	expense		f	f	2026-03-05 03:36:47.776027+00	2026-03-05 03:36:47.776042+00	1	\N	1	\N	\N	\N	\N
5006	2026-01-09	Tofu	30.00	TWD	expense		f	f	2026-03-05 03:36:47.784342+00	2026-03-05 03:36:47.784356+00	1	\N	1	\N	\N	\N	\N
5007	2026-01-09	Tofu	30.00	TWD	expense		f	f	2026-03-05 03:36:47.792721+00	2026-03-05 03:36:47.792739+00	1	\N	1	\N	\N	\N	\N
5008	2026-01-09	Fries	30.00	TWD	expense		f	f	2026-03-05 03:36:47.800966+00	2026-03-05 03:36:47.800985+00	1	\N	1	\N	\N	\N	\N
5009	2026-01-09	Onion Ring	30.00	TWD	expense		f	f	2026-03-05 03:36:47.809398+00	2026-03-05 03:36:47.809414+00	1	\N	1	\N	\N	\N	\N
5010	2026-01-09	Chicken Tenders	60.00	TWD	expense		f	f	2026-03-05 03:36:47.817714+00	2026-03-05 03:36:47.817729+00	1	\N	1	\N	\N	\N	\N
5011	2026-01-10	Soy Milk	69.00	TWD	expense		f	f	2026-03-05 03:36:47.826093+00	2026-03-05 03:36:47.826106+00	1	\N	1	\N	\N	\N	\N
5012	2026-01-10	Bread	45.00	TWD	expense		f	f	2026-03-05 03:36:47.834362+00	2026-03-05 03:36:47.834379+00	1	\N	1	\N	\N	\N	\N
5013	2026-01-10	Menudo	55.00	TWD	expense		f	f	2026-03-05 03:36:47.842787+00	2026-03-05 03:36:47.842802+00	1	\N	1	\N	\N	\N	\N
5014	2026-01-10	Plastic Bag	1.00	TWD	expense		f	f	2026-03-05 03:36:47.851037+00	2026-03-05 03:36:47.85105+00	1	\N	3	\N	\N	\N	\N
5015	2026-01-10	Juice	15.00	TWD	expense		f	f	2026-03-05 03:36:47.859393+00	2026-03-05 03:36:47.859408+00	1	\N	1	\N	\N	\N	\N
5016	2026-01-10	Discount	8.00	TWD	income		f	f	2026-03-05 03:36:47.942661+00	2026-03-05 03:36:47.942676+00	1	\N	10	\N	\N	\N	\N
5017	2026-01-10	Laundry	50.00	TWD	expense		f	f	2026-03-05 03:36:47.951004+00	2026-03-05 03:36:47.951018+00	1	\N	9	\N	\N	\N	\N
5018	2026-01-10	Dryer	60.00	TWD	expense		f	f	2026-03-05 03:36:47.959461+00	2026-03-05 03:36:47.959477+00	1	\N	9	\N	\N	\N	\N
5019	2026-01-11	Chicken Popcorn	45.00	TWD	expense		f	f	2026-03-05 03:36:47.967752+00	2026-03-05 03:36:47.967768+00	1	\N	1	\N	\N	\N	\N
5020	2026-01-12	XLB (8-piece)	65.00	TWD	expense		f	f	2026-03-05 03:36:47.976027+00	2026-03-05 03:36:47.976042+00	1	\N	1	\N	\N	\N	\N
5021	2026-01-12	XLB (4-piece)	32.00	TWD	expense		f	f	2026-03-05 03:36:47.984413+00	2026-03-05 03:36:47.984426+00	1	\N	1	\N	\N	\N	\N
5022	2026-01-12	XLB (rice)	55.00	TWD	expense		f	f	2026-03-05 03:36:47.99272+00	2026-03-05 03:36:47.992734+00	1	\N	1	\N	\N	\N	\N
5023	2026-01-12	Electricity	100.00	TWD	expense		f	f	2026-03-05 03:36:48.000988+00	2026-03-05 03:36:48.001003+00	1	\N	3	\N	\N	\N	\N
5024	2026-01-14	Juice (Work)	11.00	TWD	expense		f	f	2026-03-05 03:36:48.009317+00	2026-03-05 03:36:48.009331+00	1	\N	1	\N	\N	\N	\N
5025	2026-01-15	Juice (Work)	7.00	TWD	expense		f	f	2026-03-05 03:36:48.017743+00	2026-03-05 03:36:48.017757+00	1	\N	1	\N	\N	\N	\N
5026	2026-01-16	Ice Cream (Straberry-FamilyMart)	49.00	TWD	expense		f	f	2026-03-05 03:36:48.025998+00	2026-03-05 03:36:48.026019+00	1	\N	1	\N	\N	\N	\N
5027	2026-01-16	Koren Fried Chicken	49.00	TWD	expense		f	f	2026-03-05 03:36:48.034493+00	2026-03-05 03:36:48.034513+00	1	\N	1	\N	\N	\N	\N
5028	2026-01-17	Milk (Work)	27.00	TWD	expense		f	f	2026-03-05 03:36:48.151037+00	2026-03-05 03:36:48.15105+00	1	\N	1	\N	\N	\N	\N
5029	2026-01-17	Ramen	150.00	TWD	expense		f	f	2026-03-05 03:36:48.159565+00	2026-03-05 03:36:48.159581+00	1	\N	1	\N	\N	\N	\N
5030	2026-01-17	Karaage	100.00	TWD	expense		f	f	2026-03-05 03:36:48.167678+00	2026-03-05 03:36:48.167692+00	1	\N	1	\N	\N	\N	\N
5031	2026-01-17	Noodles Refill	30.00	TWD	expense		f	f	2026-03-05 03:36:48.176044+00	2026-03-05 03:36:48.176059+00	1	\N	1	\N	\N	\N	\N
5032	2026-01-17	Milk (1Liter)	176.00	TWD	expense		f	f	2026-03-05 03:36:48.184513+00	2026-03-05 03:36:48.184527+00	1	\N	1	\N	\N	\N	\N
5033	2026-01-17	Bubble Milk Tea	55.00	TWD	expense		f	f	2026-03-05 03:36:48.192685+00	2026-03-05 03:36:48.192699+00	1	\N	1	\N	\N	\N	\N
5034	2026-01-18	Juice (Work)	15.00	TWD	expense		f	f	2026-03-05 03:36:48.201053+00	2026-03-05 03:36:48.201067+00	1	\N	1	\N	\N	\N	\N
5035	2026-01-18	Laundry	50.00	TWD	expense		f	f	2026-03-05 03:36:48.209585+00	2026-03-05 03:36:48.209602+00	1	\N	9	\N	\N	\N	\N
5036	2026-01-18	Dryer	60.00	TWD	expense		f	f	2026-03-05 03:36:48.351144+00	2026-03-05 03:36:48.35116+00	1	\N	9	\N	\N	\N	\N
5037	2026-01-18	Electricity	100.00	TWD	expense		f	f	2026-03-05 03:36:48.359602+00	2026-03-05 03:36:48.359619+00	1	\N	3	\N	\N	\N	\N
5038	2026-01-19	Curry Lunch (Family Mart)	99.00	TWD	expense		f	f	2026-03-05 03:36:48.401227+00	2026-03-05 03:36:48.401243+00	1	\N	1	\N	\N	\N	\N
5039	2026-01-19	Rose Coffee	120.00	TWD	expense		f	f	2026-03-05 03:36:48.409649+00	2026-03-05 03:36:48.409661+00	1	\N	1	\N	\N	\N	\N
5040	2026-01-19	Rose Cheesecake	80.00	TWD	expense		f	f	2026-03-05 03:36:48.517011+00	2026-03-05 03:36:48.517026+00	1	\N	1	\N	\N	\N	\N
5041	2026-01-19	Lemon Chicken (Dinner)	60.00	TWD	expense		f	f	2026-03-05 03:36:48.526471+00	2026-03-05 03:36:48.526491+00	1	\N	1	\N	\N	\N	\N
5042	2026-01-19	Tofu (Dinner)	30.00	TWD	expense		f	f	2026-03-05 03:36:48.568075+00	2026-03-05 03:36:48.568089+00	1	\N	1	\N	\N	\N	\N
5043	2026-01-19	Rice (5kg)	175.00	TWD	expense		f	f	2026-03-05 03:36:48.57641+00	2026-03-05 03:36:48.576426+00	1	\N	3	\N	\N	\N	\N
5044	2026-01-19	Egg (10 pcs)	50.00	TWD	expense		f	f	2026-03-05 03:36:48.617911+00	2026-03-05 03:36:48.617925+00	1	\N	3	\N	\N	\N	\N
5045	2026-01-19	Pizza 1Slice	30.00	TWD	expense		f	f	2026-03-05 03:36:48.676427+00	2026-03-05 03:36:48.676441+00	1	\N	3	\N	\N	\N	\N
5046	2026-01-20	Katsudon (Family Mart)	99.00	TWD	expense		f	f	2026-03-05 03:36:48.684723+00	2026-03-05 03:36:48.684745+00	1	\N	1	\N	\N	\N	\N
5047	2026-01-22	Vegetarian Chicken	42.00	TWD	expense		f	f	2026-03-05 03:36:48.693084+00	2026-03-05 03:36:48.693099+00	1	\N	1	\N	\N	\N	\N
5048	2026-01-22	Vegetarian Chicken	42.00	TWD	expense		f	f	2026-03-05 03:36:48.701433+00	2026-03-05 03:36:48.701446+00	1	\N	1	\N	\N	\N	\N
5049	2026-01-23	Electricity	50.00	TWD	expense		f	f	2026-03-05 03:36:48.709789+00	2026-03-05 03:36:48.70981+00	1	\N	3	\N	\N	\N	\N
5050	2026-01-24	Milk (Work)	7.00	TWD	expense		f	f	2026-03-05 03:36:48.718125+00	2026-03-05 03:36:48.71814+00	1	\N	1	\N	\N	\N	\N
5051	2026-01-24	Korean Fried Chicken	49.00	TWD	expense		f	f	2026-03-05 03:36:48.726546+00	2026-03-05 03:36:48.726559+00	1	\N	1	\N	\N	\N	\N
5052	2026-01-24	Tofu	30.00	TWD	expense		f	f	2026-03-05 03:36:48.73489+00	2026-03-05 03:36:48.734904+00	1	\N	1	\N	\N	\N	\N
5053	2026-01-25	Laundry	60.00	TWD	expense		f	f	2026-03-05 03:36:48.743078+00	2026-03-05 03:36:48.743091+00	1	\N	9	\N	\N	\N	\N
5054	2026-01-25	Dryer	60.00	TWD	expense		f	f	2026-03-05 03:36:48.751464+00	2026-03-05 03:36:48.751478+00	1	\N	9	\N	\N	\N	\N
5055	2026-01-25	Electricity	50.00	TWD	expense		f	f	2026-03-05 03:36:48.759758+00	2026-03-05 03:36:48.759772+00	1	\N	3	\N	\N	\N	\N
5056	2026-01-26	Korean Fried Chicken	49.00	TWD	expense		f	f	2026-03-05 03:36:48.767971+00	2026-03-05 03:36:48.767984+00	1	\N	1	\N	\N	\N	\N
5057	2026-01-26	13 Spices Chicken	49.00	TWD	expense		f	f	2026-03-05 03:36:48.776477+00	2026-03-05 03:36:48.776493+00	1	\N	1	\N	\N	\N	\N
5058	2026-01-27	Electricity	100.00	TWD	expense		f	f	2026-03-05 03:36:48.810196+00	2026-03-05 03:36:48.810242+00	1	\N	3	\N	\N	\N	\N
5059	2026-02-01	Electricity	100.00	TWD	expense		f	f	2026-03-05 03:36:48.818312+00	2026-03-05 03:36:48.818333+00	1	\N	3	\N	\N	\N	\N
5060	2026-02-01	Laundry	60.00	TWD	expense		f	f	2026-03-05 03:36:48.826561+00	2026-03-05 03:36:48.826585+00	1	\N	9	\N	\N	\N	\N
5061	2026-02-01	Dryer	60.00	TWD	expense		f	f	2026-03-05 03:36:48.835159+00	2026-03-05 03:36:48.835234+00	1	\N	9	\N	\N	\N	\N
5062	2026-02-01	Korean Fried Chicken	49.00	TWD	expense		f	f	2026-03-05 03:36:48.843473+00	2026-03-05 03:36:48.843494+00	1	\N	1	\N	\N	\N	\N
5063	2026-02-01	13 Spices Chicken Balls	49.00	TWD	expense		f	f	2026-03-05 03:36:48.851872+00	2026-03-05 03:36:48.851894+00	1	\N	1	\N	\N	\N	\N
5064	2026-02-03	Bread	30.00	TWD	expense		f	f	2026-03-05 03:36:48.859988+00	2026-03-05 03:36:48.860003+00	1	\N	1	\N	\N	\N	\N
5065	2026-02-03	Candy	12.00	TWD	expense		f	f	2026-03-05 03:36:48.868292+00	2026-03-05 03:36:48.86831+00	1	\N	1	\N	\N	\N	\N
5066	2026-02-03	Juice	7.00	TWD	expense		f	f	2026-03-05 03:36:48.876578+00	2026-03-05 03:36:48.876596+00	1	\N	1	\N	\N	\N	\N
5067	2026-02-05	Notebook 1	51.00	TWD	expense		f	f	2026-03-05 03:36:48.88488+00	2026-03-05 03:36:48.884895+00	1	\N	3	\N	\N	\N	\N
5068	2026-02-05	Notebook 2	29.00	TWD	expense		f	f	2026-03-05 03:36:48.893234+00	2026-03-05 03:36:48.893252+00	1	\N	3	\N	\N	\N	\N
5069	2026-02-05	Fruit Tea	60.00	TWD	expense		f	f	2026-03-05 03:36:48.9017+00	2026-03-05 03:36:48.901715+00	1	\N	1	\N	\N	\N	\N
5070	2026-02-05	Bubblegum	22.00	TWD	expense		f	f	2026-03-05 03:36:48.926607+00	2026-03-05 03:36:48.926621+00	1	\N	1	\N	\N	\N	\N
5071	2026-02-05	Milk	175.00	TWD	expense		f	f	2026-03-05 03:36:48.934847+00	2026-03-05 03:36:48.93486+00	1	\N	1	\N	\N	\N	\N
5072	2026-02-05	Airwaves Candy	52.00	TWD	expense		f	f	2026-03-05 03:36:48.94321+00	2026-03-05 03:36:48.943225+00	1	\N	1	\N	\N	\N	\N
5073	2026-02-05	Trash Bag	17.00	TWD	expense		f	f	2026-03-05 03:36:48.951556+00	2026-03-05 03:36:48.951571+00	1	\N	3	\N	\N	\N	\N
5074	2026-02-05	Coffee Candy	35.00	TWD	expense		f	f	2026-03-05 03:36:48.959921+00	2026-03-05 03:36:48.959934+00	1	\N	1	\N	\N	\N	\N
5075	2026-02-05	Plastic Bag	3.00	TWD	expense		f	f	2026-03-05 03:36:48.968247+00	2026-03-05 03:36:48.968262+00	1	\N	3	\N	\N	\N	\N
5076	2026-02-05	Hi Chu Candy	33.00	TWD	expense		f	f	2026-03-05 03:36:48.976514+00	2026-03-05 03:36:48.976529+00	1	\N	1	\N	\N	\N	\N
5077	2026-02-05	Electricity	100.00	TWD	expense		f	f	2026-03-05 03:36:48.98481+00	2026-03-05 03:36:48.984825+00	1	\N	3	\N	\N	\N	\N
5078	2026-02-06	Fries	30.00	TWD	expense		f	f	2026-03-05 03:36:48.993121+00	2026-03-05 03:36:48.993135+00	1	\N	1	\N	\N	\N	\N
5079	2026-02-06	Chicken Skin	30.00	TWD	expense		f	f	2026-03-05 03:36:49.001564+00	2026-03-05 03:36:49.001578+00	1	\N	1	\N	\N	\N	\N
5080	2026-02-07	Almond	45.00	TWD	expense		f	f	2026-03-05 03:36:49.009893+00	2026-03-05 03:36:49.00991+00	1	\N	1	\N	\N	\N	\N
5081	2026-02-07	Almond	45.00	TWD	expense		f	f	2026-03-05 03:36:49.018239+00	2026-03-05 03:36:49.018254+00	1	\N	1	\N	\N	\N	\N
5082	2026-02-07	Discount Almond	18.00	TWD	income		f	f	2026-03-05 03:36:49.076713+00	2026-03-05 03:36:49.076728+00	1	\N	10	\N	\N	\N	\N
5083	2026-02-07	Almond	45.00	TWD	expense		f	f	2026-03-05 03:36:49.084941+00	2026-03-05 03:36:49.084955+00	1	\N	1	\N	\N	\N	\N
5084	2026-02-07	Almond	45.00	TWD	expense		f	f	2026-03-05 03:36:49.093378+00	2026-03-05 03:36:49.093396+00	1	\N	1	\N	\N	\N	\N
5085	2026-02-07	Discount Almond	18.00	TWD	income		f	f	2026-03-05 03:36:49.101613+00	2026-03-05 03:36:49.101628+00	1	\N	10	\N	\N	\N	\N
5086	2026-02-07	Almond	45.00	TWD	expense		f	f	2026-03-05 03:36:49.10989+00	2026-03-05 03:36:49.109904+00	1	\N	1	\N	\N	\N	\N
5087	2026-02-07	Almond	45.00	TWD	expense		f	f	2026-03-05 03:36:49.118311+00	2026-03-05 03:36:49.118327+00	1	\N	1	\N	\N	\N	\N
5088	2026-02-07	Discount Almond	18.00	TWD	income		f	f	2026-03-05 03:36:49.12666+00	2026-03-05 03:36:49.126675+00	1	\N	10	\N	\N	\N	\N
5089	2026-02-07	Andrew's Chicken	250.00	TWD	expense		f	f	2026-03-05 03:36:49.134891+00	2026-03-05 03:36:49.134906+00	1	\N	1	\N	\N	\N	\N
5090	2026-02-07	Safeguard	42.00	TWD	expense		f	f	2026-03-05 03:36:49.1433+00	2026-03-05 03:36:49.143315+00	1	\N	3	\N	\N	\N	\N
5091	2026-02-07	Safeguard	42.00	TWD	expense		f	f	2026-03-05 03:36:49.15166+00	2026-03-05 03:36:49.151673+00	1	\N	3	\N	\N	\N	\N
5092	2026-02-07	Safeguard	42.00	TWD	expense		f	f	2026-03-05 03:36:49.15992+00	2026-03-05 03:36:49.159939+00	1	\N	3	\N	\N	\N	\N
5093	2026-02-08	Cup Noodles	60.00	TWD	expense		f	f	2026-03-05 03:36:49.16825+00	2026-03-05 03:36:49.168265+00	1	\N	1	\N	\N	\N	\N
5094	2026-02-08	Lays	35.00	TWD	expense		f	f	2026-03-05 03:36:49.201688+00	2026-03-05 03:36:49.201702+00	1	\N	1	\N	\N	\N	\N
5095	2026-02-08	Lays	35.00	TWD	expense		f	f	2026-03-05 03:36:49.210017+00	2026-03-05 03:36:49.210035+00	1	\N	1	\N	\N	\N	\N
5096	2026-02-08	Juice Work	7.00	TWD	expense		f	f	2026-03-05 03:36:49.218428+00	2026-03-05 03:36:49.218443+00	1	\N	1	\N	\N	\N	\N
5097	2026-02-08	Cosco Membership	350.00	TWD	expense		f	f	2026-03-05 03:36:49.226647+00	2026-03-05 03:36:49.226666+00	1	\N	3	\N	\N	\N	\N
5098	2026-02-08	Gas Money	100.00	TWD	expense		f	f	2026-03-05 03:36:49.245466+00	2026-03-05 03:36:49.245481+00	1	\N	3	\N	\N	\N	\N
5099	2026-02-09	Converted to Cash	1799.00	TWD	income		f	f	2026-03-05 03:36:49.276741+00	2026-03-05 03:36:49.276766+00	1	\N	3	\N	\N	\N	\N
5100	2026-02-09	Pepsi	10.00	TWD	expense		f	f	2026-03-05 03:36:49.285112+00	2026-03-05 03:36:49.285135+00	1	\N	1	\N	\N	\N	\N
5101	2026-02-09	Juice	7.00	TWD	expense		f	f	2026-03-05 03:36:49.363455+00	2026-03-05 03:36:49.363477+00	1	\N	1	\N	\N	\N	\N
5102	2026-02-09	Curry	259.00	TWD	expense		f	f	2026-03-05 03:36:49.401812+00	2026-03-05 03:36:49.401827+00	1	\N	1	\N	\N	\N	\N
5103	2026-02-09	Curry	259.00	TWD	expense		f	f	2026-03-05 03:36:49.410147+00	2026-03-05 03:36:49.410202+00	1	\N	1	\N	\N	\N	\N
5104	2026-02-09	Chicken Ceasar Wrap	140.00	TWD	expense		f	f	2026-03-05 03:36:49.476837+00	2026-03-05 03:36:49.476851+00	1	\N	1	\N	\N	\N	\N
5105	2026-02-09	Bulgogi Cake	99.00	TWD	expense		f	f	2026-03-05 03:36:49.485248+00	2026-03-05 03:36:49.485268+00	1	\N	1	\N	\N	\N	\N
5106	2026-02-09	Hotdog	50.00	TWD	expense		f	f	2026-03-05 03:36:49.526879+00	2026-03-05 03:36:49.526892+00	1	\N	1	\N	\N	\N	\N
5107	2026-02-09	Coco	80.00	TWD	expense		f	f	2026-03-05 03:36:49.535192+00	2026-03-05 03:36:49.53522+00	1	\N	3	\N	\N	\N	\N
5108	2026-02-10	Electricity	250.00	TWD	expense		f	f	2026-03-05 03:36:49.543535+00	2026-03-05 03:36:49.543547+00	1	\N	3	\N	\N	\N	\N
5109	2026-02-10	Juice (Work)	3.00	TWD	expense		f	f	2026-03-05 03:36:49.55182+00	2026-03-05 03:36:49.551833+00	1	\N	1	\N	\N	\N	\N
5110	2026-02-11	Milk Tea	60.00	TWD	expense		f	f	2026-03-05 03:36:49.560155+00	2026-03-05 03:36:49.560219+00	1	\N	1	\N	\N	\N	\N
5111	2026-02-12	Doritos	43.00	TWD	expense		f	f	2026-03-05 03:36:49.619664+00	2026-03-05 03:36:49.619678+00	1	\N	1	\N	\N	\N	\N
5112	2026-02-13	Egg (10 Pieces)	60.00	TWD	expense		f	f	2026-03-05 03:36:49.626875+00	2026-03-05 03:36:49.626891+00	1	\N	1	\N	\N	\N	\N
5113	2026-02-13	Milk	175.00	TWD	expense		f	f	2026-03-05 03:36:49.635356+00	2026-03-05 03:36:49.635378+00	1	\N	1	\N	\N	\N	\N
5114	2026-02-13	Food	55.00	TWD	expense		f	f	2026-03-05 03:36:49.643645+00	2026-03-05 03:36:49.643662+00	1	\N	1	\N	\N	\N	\N
5115	2026-02-13	Keys	120.00	TWD	expense		f	f	2026-03-05 03:36:49.65199+00	2026-03-05 03:36:49.652009+00	1	\N	3	\N	\N	\N	\N
5116	2026-02-14	Juice Work	7.00	TWD	expense		f	f	2026-03-05 03:36:49.660313+00	2026-03-05 03:36:49.66033+00	1	\N	1	\N	\N	\N	\N
5117	2026-02-15	Burger Work	11.00	TWD	expense		f	f	2026-03-05 03:36:49.668617+00	2026-03-05 03:36:49.668629+00	1	\N	1	\N	\N	\N	\N
5118	2026-02-15	Cup Noodles	22.00	TWD	expense		f	f	2026-03-05 03:36:49.676932+00	2026-03-05 03:36:49.676951+00	1	\N	1	\N	\N	\N	\N
5119	2026-02-15	Mcdo	100.00	TWD	expense		f	f	2026-03-05 03:36:49.685379+00	2026-03-05 03:36:49.685395+00	1	\N	1	\N	\N	\N	\N
5120	2026-02-15	Strepsils	59.00	TWD	expense		f	f	2026-03-05 03:36:49.693777+00	2026-03-05 03:36:49.693791+00	1	\N	3	\N	\N	\N	\N
5121	2026-02-16	Strepsils	59.00	TWD	expense		f	f	2026-03-05 03:36:49.701979+00	2026-03-05 03:36:49.701993+00	1	\N	3	\N	\N	\N	\N
5122	2026-02-16	Strepsils	59.00	TWD	expense		f	f	2026-03-05 03:36:49.71036+00	2026-03-05 03:36:49.710374+00	1	\N	3	\N	\N	\N	\N
5123	2026-02-16	Korean Fried Chicken	49.00	TWD	expense		f	f	2026-03-05 03:36:49.718681+00	2026-03-05 03:36:49.718694+00	2	\N	1	\N	\N	\N	\N
5124	2026-02-16	Chicken Popcorn	45.00	TWD	expense		f	f	2026-03-05 03:36:49.785272+00	2026-03-05 03:36:49.785285+00	1	\N	1	\N	\N	\N	\N
5125	2026-02-17	13 Spices Chicken	49.00	TWD	expense		f	f	2026-03-05 03:36:49.793557+00	2026-03-05 03:36:49.79357+00	1	\N	1	\N	\N	\N	\N
5126	2026-02-17	Food	49.00	TWD	expense		f	f	2026-03-05 03:36:49.801946+00	2026-03-05 03:36:49.801961+00	1	\N	1	\N	\N	\N	\N
5127	2026-02-17	13 Spices Chicken	49.00	TWD	expense		f	f	2026-03-05 03:36:49.810303+00	2026-03-05 03:36:49.810318+00	1	\N	1	\N	\N	\N	\N
5128	2026-02-17	Korean Fried Chicken	49.00	TWD	expense		f	f	2026-03-05 03:36:49.818678+00	2026-03-05 03:36:49.818694+00	1	\N	1	\N	\N	\N	\N
5129	2026-02-18	Korean Fried Chicken	49.00	TWD	expense		f	f	2026-03-05 03:36:49.827025+00	2026-03-05 03:36:49.82704+00	1	\N	1	\N	\N	\N	\N
5130	2026-02-18	TopUp	500.00	TWD	topup		f	f	2026-03-05 03:36:49.835401+00	2026-03-05 03:36:49.835415+00	1	\N	3	\N	\N	\N	\N
5131	2026-02-18	TopUp	500.00	TWD	topup		f	f	2026-03-05 03:36:49.843638+00	2026-03-05 03:36:49.843652+00	2	\N	3	\N	\N	\N	\N
5132	2026-02-18	Train	23.00	TWD	expense		f	f	2026-03-05 03:36:49.851955+00	2026-03-05 03:36:49.851972+00	2	\N	3	\N	\N	\N	\N
5133	2026-02-18	Coco (Curry)	352.00	TWD	expense		f	f	2026-03-05 03:36:49.86039+00	2026-03-05 03:36:49.860409+00	1	\N	1	\N	\N	\N	\N
5134	2026-02-18	Train	23.00	TWD	expense		f	f	2026-03-05 03:36:50.378482+00	2026-03-05 03:36:50.378498+00	2	\N	3	\N	\N	\N	\N
5135	2026-02-18	McDo	181.00	TWD	expense		f	f	2026-03-05 03:36:50.423638+00	2026-03-05 03:36:50.423653+00	1	\N	1	\N	\N	\N	\N
5136	2026-02-18	Milk	175.00	TWD	expense		f	f	2026-03-05 03:36:50.435583+00	2026-03-05 03:36:50.435603+00	1	\N	1	\N	\N	\N	\N
5137	2026-02-19	Shopee	180.00	TWD	expense		f	f	2026-03-05 03:36:50.527291+00	2026-03-05 03:36:50.527307+00	1	\N	3	\N	\N	\N	\N
5138	2026-02-19	Lays	32.00	TWD	expense		f	f	2026-03-05 03:36:50.577529+00	2026-03-05 03:36:50.577545+00	2	\N	1	\N	\N	\N	\N
5139	2026-02-19	Lays	32.00	TWD	expense		f	f	2026-03-05 03:36:50.610612+00	2026-03-05 03:36:50.610628+00	2	\N	1	\N	\N	\N	\N
5140	2026-02-19	ChocoMucho	69.00	TWD	expense		f	f	2026-03-05 03:36:50.652456+00	2026-03-05 03:36:50.652479+00	1	\N	1	\N	\N	\N	\N
5141	2026-02-19	Presto	62.00	TWD	expense		f	f	2026-03-05 03:36:50.694014+00	2026-03-05 03:36:50.694028+00	1	\N	1	\N	\N	\N	\N
5142	2026-02-19	ChocolateChip	185.00	TWD	expense		f	f	2026-03-05 03:36:50.702388+00	2026-03-05 03:36:50.702401+00	1	\N	1	\N	\N	\N	\N
5143	2026-02-19	Buldak	50.00	TWD	expense		f	f	2026-03-05 03:36:50.79845+00	2026-03-05 03:36:50.798471+00	1	\N	1	\N	\N	\N	\N
5144	2026-02-19	Rebisco	48.00	TWD	expense		f	f	2026-03-05 03:36:50.810912+00	2026-03-05 03:36:50.810933+00	1	\N	1	\N	\N	\N	\N
5145	2026-02-19	Super Delight	49.00	TWD	expense		f	f	2026-03-05 03:36:50.819288+00	2026-03-05 03:36:50.819314+00	1	\N	1	\N	\N	\N	\N
5146	2026-02-19	BoyBawang	20.00	TWD	expense		f	f	2026-03-05 03:36:50.827773+00	2026-03-05 03:36:50.827795+00	1	\N	1	\N	\N	\N	\N
5147	2026-02-20	Doritos	35.00	TWD	expense		f	f	2026-03-05 03:36:50.83608+00	2026-03-05 03:36:50.836101+00	1	\N	1	\N	\N	\N	\N
5148	2026-02-20	Discount	24.00	TWD	income		f	f	2026-03-05 03:36:50.844299+00	2026-03-05 03:36:50.844318+00	1	\N	10	\N	\N	\N	\N
5149	2026-02-20	Doritos	35.00	TWD	expense		f	f	2026-03-05 03:36:50.85273+00	2026-03-05 03:36:50.852751+00	1	\N	1	\N	\N	\N	\N
5150	2026-02-23	City Cafe	49.00	TWD	expense		f	f	2026-03-05 03:36:50.861073+00	2026-03-05 03:36:50.861095+00	2	\N	1	\N	\N	\N	\N
5151	2026-02-23	Shopee	43.00	TWD	expense		f	f	2026-03-05 03:36:50.869338+00	2026-03-05 03:36:50.86936+00	1	\N	3	\N	\N	\N	\N
5152	2026-02-23	Electricity	250.00	TWD	expense		f	f	2026-03-05 03:36:50.877764+00	2026-03-05 03:36:50.877788+00	1	\N	3	\N	\N	\N	\N
5153	2026-02-23	Converted to Cash	54.00	TWD	expense		f	f	2026-03-05 03:36:50.886076+00	2026-03-05 03:36:50.886098+00	2	\N	3	\N	\N	\N	\N
5154	2026-02-23	Converted to Cash	54.00	TWD	income		f	f	2026-03-05 03:36:50.894462+00	2026-03-05 03:36:50.894484+00	1	\N	3	\N	\N	\N	\N
5155	2026-02-23	Burrito	65.00	TWD	expense		f	f	2026-03-05 03:36:50.902795+00	2026-03-05 03:36:50.902817+00	2	\N	1	\N	\N	\N	\N
5156	2026-02-23	Oatmilk	35.00	TWD	expense		f	f	2026-03-05 03:36:50.944412+00	2026-03-05 03:36:50.944434+00	2	\N	1	\N	\N	\N	\N
5157	2026-02-23	Discount	21.00	TWD	income		f	f	2026-03-05 03:36:50.952861+00	2026-03-05 03:36:50.952881+00	2	\N	10	\N	\N	\N	\N
\.


--
-- Data for Name: expenses_transactionattachment; Type: TABLE DATA; Schema: public; Owner: expenseuser
--

COPY public.expenses_transactionattachment (id, file, original_name, uploaded_at, transaction_id) FROM stdin;
\.


--
-- Data for Name: expenses_transactionauditlog; Type: TABLE DATA; Schema: public; Owner: expenseuser
--

COPY public.expenses_transactionauditlog (id, transaction_id, transaction_name, action, changes, "timestamp", user_id) FROM stdin;
1	4278	Income February	created	{}	2026-03-04 04:13:08.528295+00	1
2	4279	Withdraw	created	{}	2026-03-04 04:13:42.9019+00	1
3	4280	Herschel Bag	created	{}	2026-03-04 04:15:29.62617+00	1
4	4281	Herschel Pants	created	{}	2026-03-04 04:16:39.461526+00	1
5	4282	Converted to Cash	created	{}	2026-03-04 04:17:36.333924+00	1
6	4280	Herschel Bag	updated	{"category": {"from": "General", "to": "Clothes"}}	2026-03-04 04:19:24.251678+00	1
7	4508	February Salary	created	{}	2026-03-04 07:42:10.542397+00	1
8	4515	Herschel Bag	created	{}	2026-03-04 07:43:57.927036+00	1
9	4516	Herschel Pants	created	{}	2026-03-04 07:44:14.285792+00	1
10	4517	Herschel Bag	created	{}	2026-03-04 07:45:07.921118+00	1
11	4518	Purple Store	created	{}	2026-03-04 15:09:31.415945+00	1
12	4519	Top-up Bonus (Cash)	created	{}	2026-03-04 15:09:31.499011+00	1
13	4517	Herschel Bagg	updated	{"name": {"from": "Herschel Bag", "to": "Herschel Bagg"}}	2026-03-04 15:13:02.140702+00	1
14	4517	Herschel Bag	updated	{"name": {"from": "Herschel Bagg", "to": "Herschel Bag"}}	2026-03-04 15:13:08.017671+00	1
15	4520	Purple Store	created	{}	2026-03-04 15:20:27.832603+00	1
16	4521	Top-up Bonus (Cash)	created	{}	2026-03-04 15:20:27.85763+00	1
17	4520	Purple Store	deleted	{}	2026-03-04 15:22:31.168594+00	1
18	4519	Top-up Bonus (Cash)	deleted	{}	2026-03-04 15:22:35.938261+00	1
19	4521	Top-up Bonus (Cash)	deleted	{}	2026-03-04 15:22:47.297289+00	1
20	4518	Purple Store	deleted	{}	2026-03-04 15:22:47.312781+00	1
21	4522	Purple Store	created	{}	2026-03-04 15:23:16.390938+00	1
22	4523	Top-up Bonus (Laundry Wallet (PurpleStore))	created	{}	2026-03-04 15:23:16.415883+00	1
23	4524	Laundry	created	{}	2026-03-04 15:24:03.092585+00	1
24	4525	Dryer	created	{}	2026-03-04 15:24:22.542013+00	1
25	4526	Adrian Laundry	created	{}	2026-03-04 15:25:36.020915+00	1
26	4527	Adrian Dryer	created	{}	2026-03-04 15:25:52.844304+00	1
27	4528	Laundry	created	{}	2026-03-04 15:26:16.269908+00	1
28	4529	Dryer	created	{}	2026-03-04 15:26:32.870081+00	1
29	4530	Dryer	created	{}	2026-03-04 15:27:40.853295+00	1
30	4531	Laundry	created	{}	2026-03-04 15:27:43.637545+00	1
31	4530	Dryer	updated	{"date": {"from": "2026-03-04", "to": "2026-02-23"}}	2026-03-04 15:27:57.534947+00	1
32	4531	Laundry	updated	{"date": {"from": "2026-03-04", "to": "2026-02-23"}}	2026-03-04 15:28:05.646593+00	1
33	4532	Laundry	created	{}	2026-03-04 15:29:17.008014+00	1
34	4533	Adrian Laundry	created	{}	2026-03-04 15:29:33.289556+00	1
35	4534	Puff Tech	created	{}	2026-03-04 15:30:02.417732+00	1
36	4535	Puff Tech	created	{}	2026-03-04 15:30:16.406575+00	1
37	4536	Dryer	created	{}	2026-03-04 15:31:12.061759+00	1
38	4537	Adrian Dryer	created	{}	2026-03-04 15:31:32.503013+00	1
39	4538	Puff Tech	created	{}	2026-03-04 15:31:50.944141+00	1
40	4539	Puff Tech	created	{}	2026-03-04 15:33:42.523903+00	1
41	4540	Puff Tech	created	{}	2026-03-04 15:34:40.844355+00	1
42	4539	Puff Tech	updated	{"date": {"from": "2026-02-27", "to": "2026-02-26"}}	2026-03-04 15:34:56.725723+00	1
43	4541	Hot Pot	created	{}	2026-03-04 15:37:47.359238+00	1
44	4542	7-UP	created	{}	2026-03-04 15:38:31.968596+00	1
45	4543	Strawberry Milk	created	{}	2026-03-04 15:39:17.34473+00	1
46	4544	Korean Fried Chicken	created	{}	2026-03-04 15:39:55.091406+00	1
47	4545	Doritos	created	{}	2026-03-04 15:41:23.652153+00	1
48	4546	Blueberry Bread	created	{}	2026-03-04 15:41:36.406343+00	1
49	4547	Oatmilk	created	{}	2026-03-04 15:41:55.253737+00	1
50	4546	Blueberry Bread	updated	{"date": {"from": "2026-03-04", "to": "2026-03-01"}}	2026-03-04 15:42:06.100033+00	1
51	4548	Iced Tea	created	{}	2026-03-04 15:42:29.606461+00	1
52	4548	Iced Tea	updated	{"date": {"from": "2026-03-04", "to": "2026-03-01"}}	2026-03-04 15:42:40.343311+00	1
53	4549	Ramen	created	{}	2026-03-04 15:43:07.385422+00	1
54	4550	Tissue	created	{}	2026-03-04 15:43:20.750114+00	1
55	4551	Garlic	created	{}	2026-03-04 15:43:36.95346+00	1
56	4551	Garlic	updated	{"amount": {"from": "40.00", "to": "14"}, "date": {"from": "2026-03-04", "to": "2026-03-02"}}	2026-03-04 15:44:18.234083+00	1
57	4552	Pocari	created	{}	2026-03-04 15:45:12.927103+00	1
58	4553	Lipton Milk Tea	created	{}	2026-03-04 15:45:40.778759+00	1
59	4553	Lipton Milk Tea	updated	{"date": {"from": "2026-03-04", "to": "2026-02-28"}}	2026-03-04 15:45:53.391025+00	1
60	4544	Korean Fried Chicken	updated	{"amount": {"from": "45.00", "to": "49.00"}}	2026-03-05 02:05:47.077321+00	1
\.


--
-- Data for Name: expenses_transactiontemplate; Type: TABLE DATA; Schema: public; Owner: expenseuser
--

COPY public.expenses_transactiontemplate (id, label, name, amount, currency, transaction_type, notes, created_at, category_id, payment_method_id) FROM stdin;
1	Laundry	Laundry	60.00	TWD	expense		2026-03-04 15:27:21.037595+00	9	10
2	Dryer	Dryer	50.00	TWD	expense		2026-03-04 15:27:36.346376+00	9	10
3	KFC	Korean Fried Chicken	49.00	TWD	expense		2026-03-05 02:03:00.389343+00	1	1
\.


--
-- Data for Name: expenses_userpreference; Type: TABLE DATA; Schema: public; Owner: expenseuser
--

COPY public.expenses_userpreference (id, theme, default_currency, user_id) FROM stdin;
1	dark	TWD	1
\.


--
-- Name: accounts_hiddenpaymentmethod_id_seq; Type: SEQUENCE SET; Schema: public; Owner: expenseuser
--

SELECT pg_catalog.setval('public.accounts_hiddenpaymentmethod_id_seq', 3, true);


--
-- Name: accounts_memberpermission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: expenseuser
--

SELECT pg_catalog.setval('public.accounts_memberpermission_id_seq', 1, true);


--
-- Name: accounts_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: expenseuser
--

SELECT pg_catalog.setval('public.accounts_user_groups_id_seq', 1, false);


--
-- Name: accounts_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: expenseuser
--

SELECT pg_catalog.setval('public.accounts_user_id_seq', 2, true);


--
-- Name: accounts_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: expenseuser
--

SELECT pg_catalog.setval('public.accounts_user_user_permissions_id_seq', 1, false);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: expenseuser
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: expenseuser
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: expenseuser
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 72, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: expenseuser
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: expenseuser
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 18, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: expenseuser
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 25, true);


--
-- Name: expenses_budgetlimit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: expenseuser
--

SELECT pg_catalog.setval('public.expenses_budgetlimit_id_seq', 1, false);


--
-- Name: expenses_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: expenseuser
--

SELECT pg_catalog.setval('public.expenses_category_id_seq', 10, true);


--
-- Name: expenses_paymentmethod_id_seq; Type: SEQUENCE SET; Schema: public; Owner: expenseuser
--

SELECT pg_catalog.setval('public.expenses_paymentmethod_id_seq', 10, true);


--
-- Name: expenses_recurringexpense_id_seq; Type: SEQUENCE SET; Schema: public; Owner: expenseuser
--

SELECT pg_catalog.setval('public.expenses_recurringexpense_id_seq', 1, true);


--
-- Name: expenses_sharedexpense_id_seq; Type: SEQUENCE SET; Schema: public; Owner: expenseuser
--

SELECT pg_catalog.setval('public.expenses_sharedexpense_id_seq', 1, false);


--
-- Name: expenses_transaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: expenseuser
--

SELECT pg_catalog.setval('public.expenses_transaction_id_seq', 4553, true);


--
-- Name: expenses_transactionattachment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: expenseuser
--

SELECT pg_catalog.setval('public.expenses_transactionattachment_id_seq', 1, false);


--
-- Name: expenses_transactionauditlog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: expenseuser
--

SELECT pg_catalog.setval('public.expenses_transactionauditlog_id_seq', 60, true);


--
-- Name: expenses_transactiontemplate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: expenseuser
--

SELECT pg_catalog.setval('public.expenses_transactiontemplate_id_seq', 3, true);


--
-- Name: expenses_userpreference_id_seq; Type: SEQUENCE SET; Schema: public; Owner: expenseuser
--

SELECT pg_catalog.setval('public.expenses_userpreference_id_seq', 1, true);


--
-- Name: accounts_hiddenpaymentmethod accounts_hiddenpaymentme_permission_id_payment_me_e3b59194_uniq; Type: CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.accounts_hiddenpaymentmethod
    ADD CONSTRAINT accounts_hiddenpaymentme_permission_id_payment_me_e3b59194_uniq UNIQUE (permission_id, payment_method_id);


--
-- Name: accounts_hiddenpaymentmethod accounts_hiddenpaymentmethod_pkey; Type: CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.accounts_hiddenpaymentmethod
    ADD CONSTRAINT accounts_hiddenpaymentmethod_pkey PRIMARY KEY (id);


--
-- Name: accounts_memberpermission accounts_memberpermission_pkey; Type: CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.accounts_memberpermission
    ADD CONSTRAINT accounts_memberpermission_pkey PRIMARY KEY (id);


--
-- Name: accounts_memberpermission accounts_memberpermission_user_id_key; Type: CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.accounts_memberpermission
    ADD CONSTRAINT accounts_memberpermission_user_id_key UNIQUE (user_id);


--
-- Name: accounts_user_groups accounts_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_groups accounts_user_groups_user_id_group_id_59c0b32f_uniq; Type: CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_user_id_group_id_59c0b32f_uniq UNIQUE (user_id, group_id);


--
-- Name: accounts_user accounts_user_pkey; Type: CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.accounts_user
    ADD CONSTRAINT accounts_user_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_user_permissions accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq; Type: CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq UNIQUE (user_id, permission_id);


--
-- Name: accounts_user_user_permissions accounts_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: accounts_user accounts_user_username_key; Type: CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.accounts_user
    ADD CONSTRAINT accounts_user_username_key UNIQUE (username);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: expenses_budgetlimit expenses_budgetlimit_category_id_month_7cf2e20e_uniq; Type: CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.expenses_budgetlimit
    ADD CONSTRAINT expenses_budgetlimit_category_id_month_7cf2e20e_uniq UNIQUE (category_id, month);


--
-- Name: expenses_budgetlimit expenses_budgetlimit_pkey; Type: CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.expenses_budgetlimit
    ADD CONSTRAINT expenses_budgetlimit_pkey PRIMARY KEY (id);


--
-- Name: expenses_category expenses_category_name_key; Type: CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.expenses_category
    ADD CONSTRAINT expenses_category_name_key UNIQUE (name);


--
-- Name: expenses_category expenses_category_pkey; Type: CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.expenses_category
    ADD CONSTRAINT expenses_category_pkey PRIMARY KEY (id);


--
-- Name: expenses_paymentmethod expenses_paymentmethod_name_key; Type: CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.expenses_paymentmethod
    ADD CONSTRAINT expenses_paymentmethod_name_key UNIQUE (name);


--
-- Name: expenses_paymentmethod expenses_paymentmethod_pkey; Type: CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.expenses_paymentmethod
    ADD CONSTRAINT expenses_paymentmethod_pkey PRIMARY KEY (id);


--
-- Name: expenses_recurringexpense expenses_recurringexpense_pkey; Type: CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.expenses_recurringexpense
    ADD CONSTRAINT expenses_recurringexpense_pkey PRIMARY KEY (id);


--
-- Name: expenses_sharedexpense expenses_sharedexpense_pkey; Type: CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.expenses_sharedexpense
    ADD CONSTRAINT expenses_sharedexpense_pkey PRIMARY KEY (id);


--
-- Name: expenses_transaction expenses_transaction_paired_transaction_id_key; Type: CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.expenses_transaction
    ADD CONSTRAINT expenses_transaction_paired_transaction_id_key UNIQUE (paired_transaction_id);


--
-- Name: expenses_transaction expenses_transaction_pkey; Type: CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.expenses_transaction
    ADD CONSTRAINT expenses_transaction_pkey PRIMARY KEY (id);


--
-- Name: expenses_transactionattachment expenses_transactionattachment_pkey; Type: CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.expenses_transactionattachment
    ADD CONSTRAINT expenses_transactionattachment_pkey PRIMARY KEY (id);


--
-- Name: expenses_transactionauditlog expenses_transactionauditlog_pkey; Type: CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.expenses_transactionauditlog
    ADD CONSTRAINT expenses_transactionauditlog_pkey PRIMARY KEY (id);


--
-- Name: expenses_transactiontemplate expenses_transactiontemplate_pkey; Type: CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.expenses_transactiontemplate
    ADD CONSTRAINT expenses_transactiontemplate_pkey PRIMARY KEY (id);


--
-- Name: expenses_userpreference expenses_userpreference_pkey; Type: CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.expenses_userpreference
    ADD CONSTRAINT expenses_userpreference_pkey PRIMARY KEY (id);


--
-- Name: expenses_userpreference expenses_userpreference_user_id_key; Type: CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.expenses_userpreference
    ADD CONSTRAINT expenses_userpreference_user_id_key UNIQUE (user_id);


--
-- Name: accounts_hiddenpaymentmethod_permission_id_fc477aae; Type: INDEX; Schema: public; Owner: expenseuser
--

CREATE INDEX accounts_hiddenpaymentmethod_permission_id_fc477aae ON public.accounts_hiddenpaymentmethod USING btree (permission_id);


--
-- Name: accounts_user_groups_group_id_bd11a704; Type: INDEX; Schema: public; Owner: expenseuser
--

CREATE INDEX accounts_user_groups_group_id_bd11a704 ON public.accounts_user_groups USING btree (group_id);


--
-- Name: accounts_user_groups_user_id_52b62117; Type: INDEX; Schema: public; Owner: expenseuser
--

CREATE INDEX accounts_user_groups_user_id_52b62117 ON public.accounts_user_groups USING btree (user_id);


--
-- Name: accounts_user_user_permissions_permission_id_113bb443; Type: INDEX; Schema: public; Owner: expenseuser
--

CREATE INDEX accounts_user_user_permissions_permission_id_113bb443 ON public.accounts_user_user_permissions USING btree (permission_id);


--
-- Name: accounts_user_user_permissions_user_id_e4f0a161; Type: INDEX; Schema: public; Owner: expenseuser
--

CREATE INDEX accounts_user_user_permissions_user_id_e4f0a161 ON public.accounts_user_user_permissions USING btree (user_id);


--
-- Name: accounts_user_username_6088629e_like; Type: INDEX; Schema: public; Owner: expenseuser
--

CREATE INDEX accounts_user_username_6088629e_like ON public.accounts_user USING btree (username varchar_pattern_ops);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: expenseuser
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: expenseuser
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: expenseuser
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: expenseuser
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: expenseuser
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: expenseuser
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: expenseuser
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: expenseuser
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: expenses_budgetlimit_category_id_8702956a; Type: INDEX; Schema: public; Owner: expenseuser
--

CREATE INDEX expenses_budgetlimit_category_id_8702956a ON public.expenses_budgetlimit USING btree (category_id);


--
-- Name: expenses_category_name_319529bb_like; Type: INDEX; Schema: public; Owner: expenseuser
--

CREATE INDEX expenses_category_name_319529bb_like ON public.expenses_category USING btree (name varchar_pattern_ops);


--
-- Name: expenses_paymentmethod_name_e09449d3_like; Type: INDEX; Schema: public; Owner: expenseuser
--

CREATE INDEX expenses_paymentmethod_name_e09449d3_like ON public.expenses_paymentmethod USING btree (name varchar_pattern_ops);


--
-- Name: expenses_recurringexpense_category_id_6bdaf48b; Type: INDEX; Schema: public; Owner: expenseuser
--

CREATE INDEX expenses_recurringexpense_category_id_6bdaf48b ON public.expenses_recurringexpense USING btree (category_id);


--
-- Name: expenses_recurringexpense_payment_method_id_c675cb83; Type: INDEX; Schema: public; Owner: expenseuser
--

CREATE INDEX expenses_recurringexpense_payment_method_id_c675cb83 ON public.expenses_recurringexpense USING btree (payment_method_id);


--
-- Name: expenses_recurringexpense_to_payment_method_id_382f1e13; Type: INDEX; Schema: public; Owner: expenseuser
--

CREATE INDEX expenses_recurringexpense_to_payment_method_id_382f1e13 ON public.expenses_recurringexpense USING btree (to_payment_method_id);


--
-- Name: expenses_sharedexpense_transaction_id_08caa5e2; Type: INDEX; Schema: public; Owner: expenseuser
--

CREATE INDEX expenses_sharedexpense_transaction_id_08caa5e2 ON public.expenses_sharedexpense USING btree (transaction_id);


--
-- Name: expenses_transaction_category_id_9fc142ec; Type: INDEX; Schema: public; Owner: expenseuser
--

CREATE INDEX expenses_transaction_category_id_9fc142ec ON public.expenses_transaction USING btree (category_id);


--
-- Name: expenses_transaction_payment_method_id_5a1c5a8f; Type: INDEX; Schema: public; Owner: expenseuser
--

CREATE INDEX expenses_transaction_payment_method_id_5a1c5a8f ON public.expenses_transaction USING btree (payment_method_id);


--
-- Name: expenses_transaction_to_payment_method_id_a9d0afc9; Type: INDEX; Schema: public; Owner: expenseuser
--

CREATE INDEX expenses_transaction_to_payment_method_id_a9d0afc9 ON public.expenses_transaction USING btree (to_payment_method_id);


--
-- Name: expenses_transactionattachment_transaction_id_8edab4a4; Type: INDEX; Schema: public; Owner: expenseuser
--

CREATE INDEX expenses_transactionattachment_transaction_id_8edab4a4 ON public.expenses_transactionattachment USING btree (transaction_id);


--
-- Name: expenses_transactionauditlog_user_id_5f453da2; Type: INDEX; Schema: public; Owner: expenseuser
--

CREATE INDEX expenses_transactionauditlog_user_id_5f453da2 ON public.expenses_transactionauditlog USING btree (user_id);


--
-- Name: expenses_transactiontemplate_category_id_7738bdf7; Type: INDEX; Schema: public; Owner: expenseuser
--

CREATE INDEX expenses_transactiontemplate_category_id_7738bdf7 ON public.expenses_transactiontemplate USING btree (category_id);


--
-- Name: expenses_transactiontemplate_payment_method_id_b13cc6f4; Type: INDEX; Schema: public; Owner: expenseuser
--

CREATE INDEX expenses_transactiontemplate_payment_method_id_b13cc6f4 ON public.expenses_transactiontemplate USING btree (payment_method_id);


--
-- Name: accounts_hiddenpaymentmethod accounts_hiddenpayme_permission_id_fc477aae_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.accounts_hiddenpaymentmethod
    ADD CONSTRAINT accounts_hiddenpayme_permission_id_fc477aae_fk_accounts_ FOREIGN KEY (permission_id) REFERENCES public.accounts_memberpermission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_memberpermission accounts_memberpermission_user_id_d3018dff_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.accounts_memberpermission
    ADD CONSTRAINT accounts_memberpermission_user_id_d3018dff_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_groups accounts_user_groups_group_id_bd11a704_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_group_id_bd11a704_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_groups accounts_user_groups_user_id_52b62117_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_user_id_52b62117_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_user_permissions accounts_user_user_p_permission_id_113bb443_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_p_permission_id_113bb443_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_user_permissions accounts_user_user_p_user_id_e4f0a161_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_p_user_id_e4f0a161_fk_accounts_ FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: expenses_budgetlimit expenses_budgetlimit_category_id_8702956a_fk_expenses_; Type: FK CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.expenses_budgetlimit
    ADD CONSTRAINT expenses_budgetlimit_category_id_8702956a_fk_expenses_ FOREIGN KEY (category_id) REFERENCES public.expenses_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: expenses_recurringexpense expenses_recurringex_category_id_6bdaf48b_fk_expenses_; Type: FK CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.expenses_recurringexpense
    ADD CONSTRAINT expenses_recurringex_category_id_6bdaf48b_fk_expenses_ FOREIGN KEY (category_id) REFERENCES public.expenses_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: expenses_recurringexpense expenses_recurringex_payment_method_id_c675cb83_fk_expenses_; Type: FK CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.expenses_recurringexpense
    ADD CONSTRAINT expenses_recurringex_payment_method_id_c675cb83_fk_expenses_ FOREIGN KEY (payment_method_id) REFERENCES public.expenses_paymentmethod(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: expenses_recurringexpense expenses_recurringex_to_payment_method_id_382f1e13_fk_expenses_; Type: FK CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.expenses_recurringexpense
    ADD CONSTRAINT expenses_recurringex_to_payment_method_id_382f1e13_fk_expenses_ FOREIGN KEY (to_payment_method_id) REFERENCES public.expenses_paymentmethod(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: expenses_sharedexpense expenses_sharedexpen_transaction_id_08caa5e2_fk_expenses_; Type: FK CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.expenses_sharedexpense
    ADD CONSTRAINT expenses_sharedexpen_transaction_id_08caa5e2_fk_expenses_ FOREIGN KEY (transaction_id) REFERENCES public.expenses_transaction(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: expenses_transactiontemplate expenses_transaction_category_id_7738bdf7_fk_expenses_; Type: FK CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.expenses_transactiontemplate
    ADD CONSTRAINT expenses_transaction_category_id_7738bdf7_fk_expenses_ FOREIGN KEY (category_id) REFERENCES public.expenses_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: expenses_transaction expenses_transaction_category_id_9fc142ec_fk_expenses_; Type: FK CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.expenses_transaction
    ADD CONSTRAINT expenses_transaction_category_id_9fc142ec_fk_expenses_ FOREIGN KEY (category_id) REFERENCES public.expenses_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: expenses_transaction expenses_transaction_paired_transaction_i_8d0be226_fk_expenses_; Type: FK CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.expenses_transaction
    ADD CONSTRAINT expenses_transaction_paired_transaction_i_8d0be226_fk_expenses_ FOREIGN KEY (paired_transaction_id) REFERENCES public.expenses_transaction(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: expenses_transaction expenses_transaction_payment_method_id_5a1c5a8f_fk_expenses_; Type: FK CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.expenses_transaction
    ADD CONSTRAINT expenses_transaction_payment_method_id_5a1c5a8f_fk_expenses_ FOREIGN KEY (payment_method_id) REFERENCES public.expenses_paymentmethod(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: expenses_transactiontemplate expenses_transaction_payment_method_id_b13cc6f4_fk_expenses_; Type: FK CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.expenses_transactiontemplate
    ADD CONSTRAINT expenses_transaction_payment_method_id_b13cc6f4_fk_expenses_ FOREIGN KEY (payment_method_id) REFERENCES public.expenses_paymentmethod(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: expenses_transaction expenses_transaction_to_payment_method_id_a9d0afc9_fk_expenses_; Type: FK CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.expenses_transaction
    ADD CONSTRAINT expenses_transaction_to_payment_method_id_a9d0afc9_fk_expenses_ FOREIGN KEY (to_payment_method_id) REFERENCES public.expenses_paymentmethod(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: expenses_transactionattachment expenses_transaction_transaction_id_8edab4a4_fk_expenses_; Type: FK CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.expenses_transactionattachment
    ADD CONSTRAINT expenses_transaction_transaction_id_8edab4a4_fk_expenses_ FOREIGN KEY (transaction_id) REFERENCES public.expenses_transaction(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: expenses_transactionauditlog expenses_transaction_user_id_5f453da2_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.expenses_transactionauditlog
    ADD CONSTRAINT expenses_transaction_user_id_5f453da2_fk_accounts_ FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: expenses_userpreference expenses_userpreference_user_id_08efa16a_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: expenseuser
--

ALTER TABLE ONLY public.expenses_userpreference
    ADD CONSTRAINT expenses_userpreference_user_id_08efa16a_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

\unrestrict H9zkZCBLHq7yo2giYYkA1FaABRWhOjZ1dGn405dJXalGvp2YztEr2RQDliWbSuf

