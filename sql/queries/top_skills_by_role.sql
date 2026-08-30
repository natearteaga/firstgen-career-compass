-- Top O*NET essential skills by target role.
-- Assumes processed O*NET skills data has been loaded into role_skills_raw.

SELECT
    title AS role_title,
    element_name AS skill_name,
    scale_name,
    data_value
FROM role_skills_raw
WHERE scale_name = 'Importance'
ORDER BY
    role_title,
    data_value DESC,
    skill_name;
