-- KPI: Unanswered call % by department
-- Purpose: Compare the unanswered call % by each department
--          (unanswered calls / calls pertaining to that department)
-- Scope Note: Includes all hours (including the 18:00 hour as the exclusion only 
--             applies to hourly KPIs).
-- Source: vw_call_records_enriched (see 00_create_view.sql)
-- Output: Ordered alphabetically by department so tables and charts can line up across
--         metrics.

SELECT
    department,
    COUNT(*) FILTER(WHERE answered = 'no') AS unanswered_call_cnt,
    COUNT(*) AS total_call_cnt,
    ROUND(
        (CAST(COUNT(*) FILTER(WHERE answered = 'no') AS REAL) / COUNT(*))
        * 100
    , 2) AS unanswered_call_pct
FROM
    vw_call_records_enriched
GROUP BY
    department
ORDER BY
    department;