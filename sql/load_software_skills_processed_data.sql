-- FirstGen Career Compass
-- Load processed O*NET data into PostgreSQL tables.
--O*NET-SOC Code,Title,Workplace Example,Element ID,Element Name,Hot Technology,In Demand
DROP TABLE IF EXISTS staging_onet_software_skill_data;

CREATE TABLE staging_onet_software_skill_data(
    onet_soc_code TEXT,
    title TEXT,
    workplace_example TEXT,
    element_id TEXT,
    element_name TEXT,
    hot_technology TEXT,
    in_demand TEXT
);

--Copying processed O*NET skill data from CSV file into staging table using PostgreSQL

\copy staging_onet_software_skill_data FROM 'data/processed/onet_role_software_skills.csv' WITH (FORMAT csv, HEADER true);

-- Insert unique skill names into the final skills table.
INSERT INTO skills (
    skill_name,
    skill_category,
    skill_type
)
SELECT DISTINCT
    workplace_example,
    'software_tool',
    'onet_software'
FROM staging_onet_software_skill_data
ON CONFLICT (skill_name) DO NOTHING;

-- Clear old O*NET software-tool relationships before reloading.
DELETE FROM role_skills
WHERE evidence_label LIKE 'O*NET software skills%';

-- Insert role-software relationships.
INSERT INTO role_skills (
    role_id,
    skill_id,
    evidence_label
)
SELECT DISTINCT
    r.role_id,
    s.skill_id,
    'O*NET software skills | Category: ' || st.element_name ||
        ' | Hot: ' || st.hot_technology ||
        ' | In Demand: ' || st.in_demand AS evidence_label
FROM staging_onet_software_skill_data st
INNER JOIN roles r
    ON st.onet_soc_code = r.onet_soc_code
INNER JOIN skills s
    ON st.workplace_example = s.skill_name;

-- Check loaded software-tool relationships.
SELECT
    r.role_name,
    s.skill_name AS software_tool,
    rs.evidence_label
FROM role_skills rs
INNER JOIN roles r
    ON rs.role_id = r.role_id
INNER JOIN skills s
    ON rs.skill_id = s.skill_id
WHERE rs.evidence_label LIKE 'O*NET software skills%'
ORDER BY
    r.role_name,
    s.skill_name;
