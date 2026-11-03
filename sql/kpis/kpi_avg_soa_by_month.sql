-- KPI: Average speed of answer by month
-- Purpose: Compare the average speed of answer (seconds) across months.
--          Calculated as the mean of speed_of_answer over answered calls.
-- Source: vw_call_records_enriched (see 00_create_view.sql)
-- Scope Note: Answered calls only (unanswered calls have no speed of answer).
--             All dates included. Includes all hours, including the 18:00 hour,
--             as the exclusion only applies to hourly KPIs.
-- Output: Ordered chronologically by month for direct plotting.

SELECT
    month_num,
    month_name,
    COUNT(*) AS answered_call_cnt,
    SUM(speed_of_answer) AS total_speed_of_answer_sec,
    ROUND(AVG(speed_of_answer), 2) AS avg_speed_of_answer_sec
FROM
    vw_call_records_enriched
WHERE
    answered = 'yes'
GROUP BY
    month_num,
    month_name
ORDER BY
    month_num;