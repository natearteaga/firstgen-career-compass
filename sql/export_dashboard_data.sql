-- Export dashboard-ready SQL analysis outputs.

-- 1. Export top essential skills by role.
CREATE OR REPLACE VIEW dashboard_top_skills_by_role AS
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
WHERE rs.evidence_label = 'O*NET essential skills'
ORDER BY
    r.role_name,
    rs.importance_score DESC,
    s.skill_name;

\copy (SELECT * FROM dashboard_top_skills_by_role) TO 'dashboard/exports/top_skills_by_role.csv' WITH (FORMAT csv, HEADER true);

-- 2. Export shared skills across all three target roles.
CREATE OR REPLACE VIEW dashboard_shared_skills AS
SELECT
    s.skill_name,
    COUNT(DISTINCT r.role_id) AS role_count,
    ROUND(AVG(rs.importance_score), 2) AS avg_importance_score
FROM role_skills rs
INNER JOIN roles r
    ON rs.role_id = r.role_id
INNER JOIN skills s
    ON rs.skill_id = s.skill_id
WHERE rs.evidence_label = 'O*NET essential skills'
GROUP BY
    s.skill_name
HAVING
    COUNT(DISTINCT r.role_id) = 3
ORDER BY
    avg_importance_score DESC,
    s.skill_name;

\copy (SELECT * FROM dashboard_shared_skills) TO 'dashboard/exports/shared_skills_across_roles.csv' WITH (FORMAT csv, HEADER true);

-- 3. Role-skill comparison for the three target roles.
CREATE OR REPLACE VIEW dashboard_role_skill_comparison AS
SELECT
    s.skill_name,
    MAX(CASE WHEN r.role_name = 'Business Intelligence Analysts' THEN rs.importance_score END) AS bi_analyst_importance,
    MAX(CASE WHEN r.role_name = 'Data Scientists' THEN rs.importance_score END) AS data_analyst_proxy_importance,
    MAX(CASE WHEN r.role_name = 'Software Developers' THEN rs.importance_score END) AS software_developer_importance
FROM role_skills rs
INNER JOIN roles r
    on rs.role_id = r.role_id
INNER JOIN skills s
    on rs.skill_id = s.skill_id
WHERE rs.evidence_label = 'O*NET essential skills'
GROUP BY
    s.skill_name
ORDER BY
    skill_name;

\copy (SELECT * FROM dashboard_role_skill_comparison) TO 'dashboard/exports/role_skill_comparison.csv' WITH (FORMAT csv, HEADER true);

-- 4. Export software tools by role.
CREATE OR REPLACE VIEW dashboard_software_tool_summary AS
SELECT
    r.role_name,
    COUNT(*) AS total_tools,
    SUM(CASE WHEN rs.evidence_label LIKE '%Hot: Y%' THEN 1 ELSE 0 END) AS hot_technology_count,
    SUM(CASE WHEN rs.evidence_label LIKE '%In Demand: Y%' THEN 1 ELSE 0 END) AS in_demand_count
FROM role_skills rs
INNER JOIN roles r
    ON rs.role_id = r.role_id
WHERE rs.evidence_label LIKE 'O*NET software skills%'
GROUP BY
    r.role_name
ORDER BY
    r.role_name;

\copy (SELECT * FROM dashboard_software_tool_summary) TO 'dashboard/exports/software_tool_summary.csv' WITH (FORMAT csv, HEADER true);

-- 5. Software categories by role.
CREATE OR REPLACE VIEW dashboard_software_categories_by_role AS
SELECT
    r.role_name,
    split_part(split_part(rs.evidence_label, 'Category: ', 2), ' | Hot:', 1) AS software_category,
    COUNT(*) AS tool_count
FROM role_skills rs
INNER JOIN roles r
    ON rs.role_id = r.role_id
WHERE rs.evidence_label LIKE 'O*NET software skills%'
GROUP BY
    r.role_name,
    software_category
HAVING
    COUNT(*) >= 5
ORDER BY
    r.role_name,
    tool_count DESC,
    software_category;

\copy (SELECT * FROM dashboard_software_categories_by_role) TO 'dashboard/exports/software_categories_by_role.csv' WITH (FORMAT csv, HEADER true);