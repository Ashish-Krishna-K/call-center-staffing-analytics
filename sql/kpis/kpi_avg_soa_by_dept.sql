-- KPI: Average speed of answer by department
-- Purpose: Compare the average speed of answer (seconds) for each department.
--          Calculated as the mean of speed_of_answer over answered calls.
-- Source: vw_call_records_enriched (see 00_create_view.sql)
-- Scope Note: Answered calls only (unanswered calls have no speed of answer).
--             All dates included. Includes all hours, including the 18:00 hour,
--             as the exclusion only applies to hourly KPIs.
-- Output: Ordered alphabetically by department so tables and charts can line up 
--         across metrics.

SELECT
    department,
    COUNT(*) AS answered_call_cnt,
    SUM(speed_of_answer) AS total_speed_of_answer_sec,
    ROUND(AVG(speed_of_answer), 2) AS avg_speed_of_answer_sec,
    ROUND(
        SQRT(
            (SUM(speed_of_answer * speed_of_answer)
             - SUM(speed_of_answer) * SUM(speed_of_answer) / COUNT(*))
            / (COUNT(*) - 1)
        )
    , 2) AS sd_avg_speed_of_answer_sec
FROM
    vw_call_records_enriched
WHERE
    answered = 'yes'
GROUP BY
    department
ORDER BY
    department;