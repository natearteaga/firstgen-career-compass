-- Software and technology examples by target role.
-- Assumes processed O*NET software skills data has been loaded into role_software_skills_raw.

SELECT
    title AS role_title,
    workplace_example AS software_or_tool,
    element_name AS software_category,
    hot_technology,
    in_demand
FROM role_software_skills_raw
ORDER BY
    role_title,
    in_demand DESC,
    hot_technology DESC,
    software_or_tool;
