-- Skills that appear across all three target roles.
-- Assumes processed O*NET skills data has been loaded into role_skills_raw.

SELECT
    element_name AS skill_name,
    COUNT(DISTINCT title) AS role_count,
    AVG(data_value) AS avg_importance_score
FROM role_skills_raw
WHERE scale_name = 'Importance'
GROUP BY element_name
HAVING COUNT(DISTINCT title) = 3
ORDER BY
    avg_importance_score DESC,
    skill_name;
