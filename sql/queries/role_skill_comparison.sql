-- Compare O*NET essential skill importance across the three target roles.
-- Assumes processed O*NET skills data has been loaded into role_skills_raw.

SELECT
    s.skill_name,
    MAX(CASE WHEN r.role_name = 'Business Intelligence Analysts' THEN rs.importance_score END) AS bi_analyst_importance,
    MAX(CASE WHEN r.role_name = 'Data Scientists' THEN rs.importance_score END) AS data_analyst_proxy_importance,
    MAX(CASE WHEN r.role_name = 'Software Developers' THEN rs.importance_score END) AS software_developer_importance
FROM role_skills rs
INNER JOIN roles r 
    ON rs.role_id = r.role_id
INNER JOIN skills s 
    ON rs.skill_id = s.skill_id
GROUP BY
    s.skill_name
ORDER BY
    skill_name;
