-- KPI: Average speed of answer by hour of day
-- Purpose: Compare the average speed of answer (seconds) across hours of day.
--          Calculated as the mean of speed_of_answer over answered calls
-- Source: vw_call_records_enriched (see 00_create_view.sql)
-- Scope Note: Answered calls only (unanswered calls have no speed of answer).
--             All dates included. The 18:00 hour is excluded: it contains only
--             14 calls across the entire dataset (vs. ~500-600 calls/hour
--             during standard hours), which looks like post-shift spillover
--             rather than a fully staffed hour (see 02_exploratory_checks.ipynb).
-- Output: Ordered chronologically by hour for direct plotting.

SELECT
    hour_of_day,
    COUNT(*) AS answered_call_cnt,
    SUM(speed_of_answer) AS total_speed_of_answer_sec,
    ROUND(AVG(speed_of_answer), 2) AS avg_speed_of_answer_sec
FROM
    vw_call_records_enriched
WHERE
    answered = 'yes'
    AND
    hour_of_day <> '18'
GROUP BY
    hour_of_day
ORDER BY
    hour_of_day;