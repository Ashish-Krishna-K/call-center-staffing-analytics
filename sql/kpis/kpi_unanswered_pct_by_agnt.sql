-- KPI: Unanswered call % by agent
-- Purpose: Compare the unanswered call % by each agent
--          (unanswered calls / calls assigned to that agent)
-- Source: vw_call_records_enriched (see 00_create_view.sql)
-- Scope Note: Includes all hours (including the 18:00 hour as the exclusion only
--             applies to hourly KPIs).
-- Output: Ordered alphabetically by agent so tables and charts can line up across
--         metrics.

SELECT
    agent,
    COUNT(*) FILTER(WHERE answered = 'no') AS unanswered_call_cnt,
    COUNT(*) AS assigned_call_cnt,
    ROUND(
        (CAST(COUNT(*) FILTER(WHERE answered = 'no') AS REAL) / COUNT(*))
        * 100
    , 2) AS unanswered_call_pct
FROM
    vw_call_records_enriched
GROUP BY
    agent
ORDER BY
    agent;