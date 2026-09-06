-- Software and technology summary by target role.
-- Uses the cleaned PostgreSQL tables: roles, skills, and role_skills.

-- 1. Count software tools by role.
SELECT
    r.role_name,
    COUNT(*) AS software_tool_count
FROM role_skills rs
INNER JOIN roles r
    ON rs.role_id = r.role_id
WHERE rs.evidence_label LIKE 'O*NET software skills%'
GROUP BY
    r.role_name
ORDER BY
    software_tool_count DESC;

-- 2. Count hot and in-demand software tools by role.
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

-- 3. Count software categories by role.
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
