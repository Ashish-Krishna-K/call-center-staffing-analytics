-- KPI: Average satisfaction rating by department
-- Purpose: Compare the average satisfaction rating for each department. Satisfaction rating
--          ranges from 1 (low) to 5 (high).
-- Source: vw_call_records_enriched (see 00_create_view.sql)
-- Scope Note: Includes all hours (including the 18:00 hour as the exclusion only 
--             applies to hourly KPIs).
-- Output: Ordered alphabetically by department so tables and charts can line up across
--         metrics.

SELECT
    department,
    COUNT(*) AS answered_call_cnt,
    ROUND(AVG(satisfaction_rating), 2) AS avg_satisfaction_rating
FROM
    vw_call_records_enriched
WHERE
    answered = 'yes'
GROUP BY
    department
ORDER BY
    department;