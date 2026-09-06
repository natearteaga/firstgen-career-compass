# Data Dictionary

This documents defines the key datasets used in FirstGen Career Compass.

## `data/reference/target_roles.csv`

This file defines the MVP roles and maps each project role to a O*NET Occupation

| Column | Description |
| -- | -- |
| `project_role` | The role name used throughout this project. |
| `onet_occupation` | The official O*NET occupation name used as the data source match. |
| `onet_code` | The O*NET-SOC code for the matched occupation. |
| `notes` | Explanation of the quality or limitation of the role mapping. |

## Raw O*NET Files

Raw files are stored in `data/raw/onet/` and are kept unchanged from the O*NET download.

| File | Description |
|---|---|
| `occupation_data.csv` | O*NET occupation titles and descriptions for all occupations. |
| `essential_skills.csv` | O*NET skill ratings for all occupations. |
| `knowledge.csv` | O*NET knowledge area ratings for all occupations. |
| `task_statements.csv` | O*NET task statements for all occupations. |
| `software_skills.csv` | O*NET software and technology examples for all occupations. |

## Processed O*NET Files

Processed files are stored in `data/processed/` and contain only the three MVP target roles.

| File | Description |
|---|---|
| `onet_role_occupation_data.csv` | Filtered occupation titles and descriptions for the target roles. |
| `onet_role_skills.csv` | Filtered essential skills data for the target roles. |
| `onet_role_knowledge.csv` | Filtered knowledge ratings for the target roles. |
| `onet_role_tasks.csv` | Filtered task statements for the target roles. |
| `onet_role_software_skills.csv` | Filtered software and technology examples for the target roles. |

## Dashboard Export Files

Dashboard exports are stored in `dashboard/exports/` and are designed for visualization.

| File | Description |
|---|---|
| `top_skills_by_role.csv` | Skill importance rows prepared for role-level comparison visuals. |
| `shared_skills_across_roles.csv` | Skills that appear across all three target roles with average importance scores. |
| `software_tools_by_role.csv` | Software and technology examples prepared for dashboard use. |
