-- Compare O*NET essential skill importance across the three target roles.
-- Assumes processed O*NET skills data has been loaded into role_skills_raw.

SELECT
    element_name AS skill_name,
    MAX(CASE WHEN title = 'Business Intelligence Analysts' THEN data_value END) AS bi_analyst_importance,
    MAX(CASE WHEN title = 'Data Scientists' THEN data_value END) AS data_analyst_proxy_importance,
    MAX(CASE WHEN title = 'Software Developers' THEN data_value END) AS software_developer_importance
FROM role_skills_raw
WHERE scale_name = 'Importance'
GROUP BY element_name
ORDER BY skill_name;
