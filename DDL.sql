-- Table: hack.Evaluation

-- DROP TABLE IF EXISTS hack."Evaluation";

CREATE TABLE IF NOT EXISTS hack."Evaluation"
(
    hack_id character varying COLLATE pg_catalog."default" NOT NULL,
    team_id character varying COLLATE pg_catalog."default" NOT NULL,
    judge_id character varying COLLATE pg_catalog."default" NOT NULL,
    comment character varying COLLATE pg_catalog."default",
    CONSTRAINT "Evaluation_pkey" PRIMARY KEY (hack_id, team_id, judge_id),
    CONSTRAINT fk_judge FOREIGN KEY (hack_id, judge_id)
        REFERENCES hack."Judge" (hack_id, judge_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT fk_team FOREIGN KEY (hack_id, team_id)
        REFERENCES hack."Team" (hack_id, team_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS hack."Evaluation"
    OWNER to postgres;

-- Table: hack.Hackathon

-- DROP TABLE IF EXISTS hack."Hackathon";

CREATE TABLE IF NOT EXISTS hack."Hackathon"
(
    hack_id character varying COLLATE pg_catalog."default" NOT NULL,
    date date NOT NULL,
    start_time time without time zone NOT NULL,
    end_time time without time zone NOT NULL,
    duration time without time zone NOT NULL,
    theme character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT hackathon_pkey PRIMARY KEY (hack_id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS hack."Hackathon"
    OWNER to postgres;

-- Table: hack.Judge

-- DROP TABLE IF EXISTS hack."Judge";

CREATE TABLE IF NOT EXISTS hack."Judge"
(
    judge_id character varying COLLATE pg_catalog."default" NOT NULL,
    hack_id character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Judge_pkey" PRIMARY KEY (judge_id, hack_id),
    CONSTRAINT fk_hack FOREIGN KEY (hack_id)
        REFERENCES hack."Hackathon" (hack_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_user FOREIGN KEY (judge_id)
        REFERENCES hack."User" (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS hack."Judge"
    OWNER to postgres;

-- Table: hack.Organizer

-- DROP TABLE IF EXISTS hack."Organizer";

CREATE TABLE IF NOT EXISTS hack."Organizer"
(
    user_id character varying COLLATE pg_catalog."default" NOT NULL,
    hack_id character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Organizer_pkey" PRIMARY KEY (user_id, hack_id),
    CONSTRAINT fk_hack FOREIGN KEY (hack_id)
        REFERENCES hack."Hackathon" (hack_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_user FOREIGN KEY (user_id)
        REFERENCES hack."User" (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS hack."Organizer"
    OWNER to postgres;

-- Table: hack.Participant

-- DROP TABLE IF EXISTS hack."Participant";

CREATE TABLE IF NOT EXISTS hack."Participant"
(
    user_id character varying COLLATE pg_catalog."default" NOT NULL,
    team_id character varying COLLATE pg_catalog."default" NOT NULL,
    hack_id character varying COLLATE pg_catalog."default" NOT NULL,
    domain character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Participant_pkey" PRIMARY KEY (user_id, team_id, hack_id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS hack."Participant"
    OWNER to postgres;
-- Index: fki_fk_u

-- DROP INDEX IF EXISTS hack.fki_fk_u;

CREATE INDEX IF NOT EXISTS fki_fk_u
    ON hack."Participant" USING btree
    (user_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: fki_fk_user

-- DROP INDEX IF EXISTS hack.fki_fk_user;

CREATE INDEX IF NOT EXISTS fki_fk_user
    ON hack."Participant" USING btree
    (user_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: fki_fk_user1

-- DROP INDEX IF EXISTS hack.fki_fk_user1;

CREATE INDEX IF NOT EXISTS fki_fk_user1
    ON hack."Participant" USING btree
    (user_id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: hack.Sponsor

-- DROP TABLE IF EXISTS hack."Sponsor";

CREATE TABLE IF NOT EXISTS hack."Sponsor"
(
    hack_id character varying COLLATE pg_catalog."default" NOT NULL,
    sponsor_id character varying COLLATE pg_catalog."default" NOT NULL,
    name character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Sponsor_pkey" PRIMARY KEY (hack_id, sponsor_id),
    CONSTRAINT hack_id FOREIGN KEY (hack_id)
        REFERENCES hack."Hackathon" (hack_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS hack."Sponsor"
    OWNER to postgres;

-- Table: hack.Submission

-- DROP TABLE IF EXISTS hack."Submission";

CREATE TABLE IF NOT EXISTS hack."Submission"
(
    hack_id character varying COLLATE pg_catalog."default" NOT NULL,
    team_id character varying COLLATE pg_catalog."default" NOT NULL,
    "time" time without time zone NOT NULL,
    eval_state character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Submission_pkey" PRIMARY KEY (hack_id, team_id),
    CONSTRAINT unique_sub UNIQUE (hack_id, team_id, "time"),
    CONSTRAINT fk_team FOREIGN KEY (hack_id, team_id)
        REFERENCES hack."Team" (hack_id, team_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS hack."Submission"
    OWNER to postgres;

-- Table: hack.Team

-- DROP TABLE IF EXISTS hack."Team";

CREATE TABLE IF NOT EXISTS hack."Team"
(
    hack_id character varying COLLATE pg_catalog."default" NOT NULL,
    team_id character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Team_pkey" PRIMARY KEY (hack_id, team_id),
    CONSTRAINT "Team_hack_id_team_id_key" UNIQUE (hack_id, team_id),
    CONSTRAINT fk_team FOREIGN KEY (hack_id, team_id)
        REFERENCES hack."Team" (hack_id, team_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS hack."Team"
    OWNER to postgres;

-- Table: hack.User

-- DROP TABLE IF EXISTS hack."User";

CREATE TABLE IF NOT EXISTS hack."User"
(
    user_id character varying COLLATE pg_catalog."default" NOT NULL,
    name character varying COLLATE pg_catalog."default" NOT NULL,
    email_id character varying COLLATE pg_catalog."default" NOT NULL,
    password character varying COLLATE pg_catalog."default" NOT NULL,
    dob date NOT NULL,
    age bigint NOT NULL,
    mobile character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "User_pkey" PRIMARY KEY (user_id),
    CONSTRAINT email_id UNIQUE (email_id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS hack."User"
    OWNER to postgres;