-- FirstGen Career Compass
-- Initial relational schema draft
--
-- Target database: PostgreSQL
-- Note: Some syntax may be adapted later for SQLite or DuckDB during local development.

CREATE TABLE sources (
    source_id SERIAL PRIMARY KEY,
    source_name VARCHAR(100) NOT NULL,
    source_url TEXT,
    source_type VARCHAR(50),
    license_or_terms_note TEXT,
    retrieved_at DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE roles (
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR(150) NOT NULL,
    normalized_role_name VARCHAR(150) NOT NULL,
    role_family VARCHAR(100),
    onet_soc_code VARCHAR(20),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE skills (
    skill_id SERIAL PRIMARY KEY,
    skill_name VARCHAR(150) NOT NULL UNIQUE,
    skill_category VARCHAR(100),
    skill_type VARCHAR(100),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE skill_aliases (
    alias_id SERIAL PRIMARY KEY,
    skill_id INTEGER NOT NULL REFERENCES skills(skill_id),
    alias_name VARCHAR(150) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (skill_id, alias_name)
);

CREATE TABLE role_skills (
    role_skill_id SERIAL PRIMARY KEY,
    role_id INTEGER NOT NULL REFERENCES roles(role_id),
    skill_id INTEGER NOT NULL REFERENCES skills(skill_id),
    source_id INTEGER REFERENCES sources(source_id),
    importance_score NUMERIC(6, 2),
    level_score NUMERIC(6, 2),
    frequency_score NUMERIC(6, 2),
    evidence_label VARCHAR(150),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (role_id, skill_id, source_id)
);

CREATE TABLE student_profiles (
    profile_id SERIAL PRIMARY KEY,
    profile_label VARCHAR(100) NOT NULL,
    target_role_id INTEGER REFERENCES roles(role_id),
    profile_note TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE student_skills (
    student_skill_id SERIAL PRIMARY KEY,
    profile_id INTEGER NOT NULL REFERENCES student_profiles(profile_id),
    skill_id INTEGER NOT NULL REFERENCES skills(skill_id),
    self_rating NUMERIC(4, 2) NOT NULL,
    evidence_note TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (profile_id, skill_id),
    CHECK (self_rating >= 0 AND self_rating <= 5)
);

CREATE TABLE skill_gaps (
    gap_id SERIAL PRIMARY KEY,
    profile_id INTEGER NOT NULL REFERENCES student_profiles(profile_id),
    role_id INTEGER NOT NULL REFERENCES roles(role_id),
    skill_id INTEGER NOT NULL REFERENCES skills(skill_id),
    required_score NUMERIC(6, 2),
    student_score NUMERIC(6, 2),
    gap_score NUMERIC(6, 2),
    priority_level VARCHAR(50),
    recommendation_note TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (profile_id, role_id, skill_id)
);

CREATE TABLE resources (
    resource_id SERIAL PRIMARY KEY,
    resource_name VARCHAR(200) NOT NULL,
    provider VARCHAR(150),
    resource_url TEXT,
    resource_type VARCHAR(100),
    cost_note VARCHAR(100),
    access_note TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE skill_resources (
    skill_resource_id SERIAL PRIMARY KEY,
    skill_id INTEGER NOT NULL REFERENCES skills(skill_id),
    resource_id INTEGER NOT NULL REFERENCES resources(resource_id),
    relevance_level VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (skill_id, resource_id)
);
