-- FirstGen Career Compass
-- Load processed O*NET data into PostgreSQL tables.

DROP TABLE IF EXISTS staging_onet_skill_data;

CREATE TABLE staging_onet_skill_data(
    onet_soc_code TEXT,
    title TEXT,
    element_id TEXT,
    element_name TEXT,
    scale_id TEXT,
    scale_name TEXT,
    data_value NUMERIC,
    n TEXT,
    standard_error TEXT,
    lower_ci_bound TEXT,
    upper_ci_bound TEXT,
    recommend_suppress TEXT,
    not_relevant TEXT,
    date TEXT,
    domain_source TEXT
);

--Copying processed O*NET skill data from CSV file into staging table using PostgreSQL

\copy staging_onet_skill_data FROM 'data/processed/onet_role_skills.csv' WITH (FORMAT csv, HEADER true);

-- Insert unique skill names into the final skills table.
INSERT INTO skills (
    skill_name,
    skill_category,
    skill_type
)
SELECT DISTINCT
    element_name AS skill_name,
    'essential_skill' AS skill_category,
    'onet' AS skill_type
FROM staging_onet_skill_data
ON CONFLICT (skill_name) DO NOTHING;


--Insert role-skill relationships into the final role_skills table.

-- Clear existing role-skill records before reloading.
TRUNCATE TABLE role_skills RESTART IDENTITY;

-- Insert role-skill relationships with O*NET importance and level scores.
INSERT INTO role_skills (
    role_id,
    skill_id,
    importance_score,
    level_score,
    evidence_label
)
SELECT
    r.role_id,
    s.skill_id,
    MAX(CASE WHEN st.scale_name = 'Importance' THEN st.data_value END) AS importance_score,
    MAX(CASE WHEN st.scale_name = 'Level' THEN st.data_value END) AS level_score,
    'O*NET essential skills' AS evidence_label
FROM staging_onet_skill_data st
INNER JOIN roles r
    ON st.onet_soc_code = r.onet_soc_code
INNER JOIN skills s
    ON st.element_name = s.skill_name
GROUP BY
    r.role_id,
    s.skill_id;

-- Check loaded role-skill relationships.
SELECT
    r.role_name,
    s.skill_name,
    rs.importance_score,
    rs.level_score,
    rs.evidence_label
FROM role_skills rs
INNER JOIN roles r
    ON rs.role_id = r.role_id
INNER JOIN skills s
    ON rs.skill_id = s.skill_id
ORDER BY
    r.role_name,
    rs.importance_score DESC,
    s.skill_name;

--checking loaded skills
SELECT
    skill_name,
    skill_category,
    skill_type
FROM skills
ORDER BY skill_name;