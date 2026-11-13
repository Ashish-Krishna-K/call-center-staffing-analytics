-- KPI: average handling time (AHT) by department
-- Purpose: Compare the average time spent on each call for each department
--          (total talk time / answered calls)
--          AHT here is average talk duration only, as the dataset does not contain
--          hold or after-call work.
-- Source: vw_call_records_enriched (see 00_create_view.sql)
-- Scope Note: Includes all hours (including the 18:00 hour as the exclusion only
--             applies to hourly KPIs).
-- Output: Ordered alphabetically by department so tables and charts can line up across
--         metrics.

SELECT
    department,
    COUNT(*) AS answered_call_cnt,
    ROUND(AVG(avg_talk_duration), 2) AS aht_sec
FROM
    vw_call_records_enriched
WHERE
    answered = 'yes'
GROUP BY
    department
ORDER BY
    department;