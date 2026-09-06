-- Top O*NET essential skills by target role.
-- Assumes processed O*NET skills data has been loaded into role_skills_raw.
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
