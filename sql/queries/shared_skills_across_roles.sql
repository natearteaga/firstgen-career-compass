-- Skills that appear across all three target roles.
-- Uses the cleaned PostgreSQL tables: roles, skills, and role_skills.

SELECT
    s.skill_name,
    COUNT(DISTINCT r.role_id) AS role_count,
    ROUND(AVG(rs.importance_score), 2) AS avg_importance_score
FROM role_skills rs
INNER JOIN roles r
    ON rs.role_id = r.role_id
INNER JOIN skills s
    ON rs.skill_id = s.skill_id
GROUP BY
    s.skill_name
HAVING
    COUNT(DISTINCT r.role_id) = 3
ORDER BY
    avg_importance_score DESC,
    s.skill_name;
