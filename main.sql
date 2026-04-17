-- 1-mashq
WITH ranked AS (
    SELECT 
        name,
        continent,
        ROW_NUMBER() OVER (PARTITION BY continent ORDER BY name) AS rn
    FROM student
)
SELECT 
    MAX(CASE WHEN continent = 'America' THEN name END) AS America,
    MAX(CASE WHEN continent = 'Asia' THEN name END) AS Asia,
    MAX(CASE WHEN continent = 'Europe' THEN name END) AS Europe
FROM ranked
GROUP BY rn
ORDER BY rn;
-- 2-mashq
WITH active AS (
    SELECT 
        user_id,
        login_date,
        login_date - INTERVAL (ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY login_date) - 1) DAY AS grp
    FROM logins
)
SELECT DISTINCT user_id
FROM active
GROUP BY user_id, grp
HAVING COUNT(*) >= 5
ORDER BY user_id;
