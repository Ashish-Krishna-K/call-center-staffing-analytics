-- KPI: Unanswered call % by hour of day
-- Purpose: Show at which hours of the day calls are most likely to go
-- unanswered (unanswered calls / total calls arriving in that hour).
-- Source: vw_call_records_enriched (see 00_create_view.sql)
-- Scope note: the 18:00 hour is excluded. It has only 14 calls across the
-- whole dataset vs ~500-600 in every other hour, so it looks like spillover
-- after the shift, not a staffed hour (see 02_exploratory_checks.ipynb).
-- Output is ordered by hour so it can be plotted directly.
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