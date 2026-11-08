-- KPI: Average satisfaction rating by agent
-- Purpose: Compare the average satisfaction rating of each agent. Satisfaction rating
--          ranges from 1 (low) to 5 (high).
-- Source: vw_call_records_enriched (see 00_create_view.sql)
-- Scope Note: Includes all hours (including the 18:00 hour as the exclusion only 
--             applies to hourly KPIs).
-- Output: Ordered alphabetically by agent so tables and charts can line up across
--         metrics.

SELECT
    agent,
    COUNT(*) AS answered_call_cnt,
    ROUND(AVG(satisfaction_rating), 2) AS avg_satisfaction_rating,
    ROUND(
        SQRT(
            (SUM(satisfaction_rating * satisfaction_rating)
             - SUM(satisfaction_rating) * SUM(satisfaction_rating) / COUNT(*))
            / (COUNT(*) - 1)
        )
    , 2) AS sd_avg_satisfaction_rating
FROM
    vw_call_records_enriched
WHERE
    answered = 'yes'
GROUP BY
    agent
ORDER BY
    agent;