-- FirstGen Career Compass
-- Load processed O*NET data into PostgreSQL tables.

DROP TABLE IF EXISTS staging_onet_occupation_data;

CREATE TABLE staging_onet_occupation_data(
    onet_soc_code TEXT,
    title TEXT,
    description TEXT
);

--Copying processed O*NET occupation data from CSV file into staging table using PostgreSQL

\copy staging_onet_occupation_data(onet_soc_code, title, description) FROM 'data/processed/onet_role_occupation_data.csv' WITH (FORMAT csv, HEADER true);
--Clear existing role records before reloading this small MVP dataset, had to use CASCADE to avoid foreign key constraint errors when truncating the roles table, since role_skills references roles.
TRUNCATE TABLE roles RESTART IDENTITY CASCADE;

--- Insert data from staging table into roles table, avoiding duplicates based on onet_soc_code
INSERT INTO roles (
    role_name, 
    normalized_role_name, 
    role_family,
    onet_soc_code, 
    description
)
SELECT
    title AS role_name,
    LOWER(REPLACE(title, ' ', '_')) AS normalized_role_name,
    CASE
        WHEN title in ('Business Intelligence Analysts', 'Data Scientists', 'Data Scientists ') THEN 'analytics'
        WHEN title = 'Software Developers' THEN 'software'
        ELSE 'other'
    END AS role_family,
    onet_soc_code,
    description
FROM staging_onet_occupation_data;

--checking loaded roles
SELECT
    role_name,
    normalized_role_name,
    role_family,
    onet_soc_code
FROM roles
ORDER BY role_name;