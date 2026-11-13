-- KPI: Unanswered call % by hour of day
-- Purpose: Identify peak hours for unanswered calls
--          (unanswered calls / total calls arriving in that hour).
-- Source: vw_call_records_enriched (see 00_create_view.sql)
-- Scope Note: The 18:00 hour is excluded. It contains only 14 calls across the
--             entire dataset (vs. ~500–600 calls/hour during standard operational hours),
--             indicating post-shift spillover rather than a fully staffed hour
--             (see 02_exploratory_checks.ipynb).
-- Output: Ordered chronologically by hour for direct plotting.

SELECT
    hour_of_day,
    COUNT(*) FILTER(WHERE answered = 'no') AS unanswered_call_cnt,
    COUNT(*) AS total_call_cnt,
    ROUND(
        (CAST(COUNT(*) FILTER(WHERE answered = 'no') AS REAL) / COUNT(*))
        * 100
    , 2) AS unanswered_call_pct
FROM
    vw_call_records_enriched
WHERE
    hour_of_day <> '18'
GROUP BY
    hour_of_day
ORDER BY
    hour_of_day;