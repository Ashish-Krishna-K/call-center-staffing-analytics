-- DATABASE SCHEMA
-- CREATE TABLE IF NOT EXISTS "call_records" (
-- "call_id" TEXT,
--   "date" DATE,
--   "time" TIME,
--   "agent" TEXT,
--   "department" TEXT,
--   "answered" TEXT,
--   "resolved" TEXT,
--   "speed_of_answer" REAL,
--   "avg_talk_duration" REAL,
--   "satisfaction_rating" REAL
-- );

-- VIEW SCHEMA
-- SELECT
--     *,
--     strftime('%m', date) AS month_num,
--     CASE
--         WHEN strftime('%m', date) = '01' THEN 'January'
--         WHEN strftime('%m', date) = '02' THEN 'February'
--         WHEN strftime('%m', date) = '03' THEN 'March'
--         WHEN strftime('%m', date) = '04' THEN 'April'
--         WHEN strftime('%m', date) = '05' THEN 'May'
--         WHEN strftime('%m', date) = '06' THEN 'June'
--         WHEN strftime('%m', date) = '07' THEN 'July'
--         WHEN strftime('%m', date) = '08' THEN 'August'
--         WHEN strftime('%m', date) = '09' THEN 'September'
--         WHEN strftime('%m', date) = '10' THEN 'October'
--         WHEN strftime('%m', date) = '11' THEN 'November'
--         ELSE 'December'
--     END AS month_name,
--     strftime('%w', date) AS day_of_week_num,
--     CASE 
--         WHEN strftime('%w', date) = '0' THEN 'Sunday'
--         WHEN strftime('%w', date) = '1' THEN 'Monday'  
--         WHEN strftime('%w', date) = '2' THEN 'Tuesday'  
--         WHEN strftime('%w', date) = '3' THEN 'Wednesday'  
--         WHEN strftime('%w', date) = '4' THEN 'Thursday'
--         WHEN strftime('%w', date) = '5' THEN 'Friday'  
--         ELSE 'Saturday'
--     END AS day_of_week,
--     strftime('%H', time) AS hour_of_day
-- FROM
--     call_records;

-- Total records in the table
SELECT
    COUNT(*) AS call_volume
FROM
    vw_call_records_enriched;

-- Call volume by month
SELECT  
    month_num,
    MIN(month_name) AS month_name,
    COUNT(*) AS call_volume
FROM
    vw_call_records_enriched
GROUP BY
    month_num;

-- Call Volume by date
SELECT
    date,
    COUNT(*) AS call_volume
FROM
    vw_call_records_enriched
GROUP BY
    date;

-- Start hour, end hour and total hours for the day
SELECT
    MIN(hour_of_day) AS start_hour,
    MAX(hour_of_day) AS end_hour,
    COUNT(DISTINCT hour_of_day) AS hours_in_a_day
FROM
    vw_call_records_enriched;

-- Call Volume by hour of the day
SELECT
    hour_of_day,
    COUNT(*) AS call_volume
FROM
    vw_call_records_enriched
GROUP BY
    hour_of_day;

-- Call volume by day of week and hour of day
SELECT
    day_of_week_num,
    MIN(day_of_week) AS day_of_week,
    hour_of_day,
    COUNT(*) AS call_volume
FROM
    vw_call_records_enriched
GROUP BY
    day_of_week_num,
    hour_of_day;

-- Call Volume by day of the week
SELECT
    day_of_week_num,
    MIN(day_of_week) AS day_of_week,
    COUNT(*) AS call_volume
FROM
    vw_call_records_enriched
GROUP BY
    day_of_week_num;

-- Average call volume by day of week
WITH daily_calls AS (
    SELECT
        date,
        day_of_week_num,
        MIN(day_of_week) AS day_of_week,
        COUNT(*) AS call_volume
    FROM
        vw_call_records_enriched
    GROUP BY
        date,
        day_of_week_num
)
SELECT
    day_of_week_num,
    MIN(day_of_week) AS day_of_week,
    ROUND(AVG(call_volume), 2) AS avg_call_volume
FROM
    daily_calls
GROUP BY
    day_of_week_num;

-- Unanswered call count, answered call count and assigned calls count by agent
SELECT
    agent,
    COUNT(*) FILTER(WHERE answered = 'no') AS unanswered_call_cnt,
    COUNT(*) FILTER(WHERE answered = 'yes') AS answered_call_cnt,
    COUNT(*) AS assigned_call_cnt
FROM
    vw_call_records_enriched
GROUP BY
    agent;

-- Unanswered call count, answered call count and assigned calls count by department
SELECT
    department,
    COUNT(*) FILTER(WHERE answered = 'no') AS unanswered_call_cnt,
    COUNT(*) FILTER(WHERE answered = 'yes') AS answered_call_cnt,
    COUNT(*) AS assigned_call_cnt
FROM
    vw_call_records_enriched
GROUP BY
    department;

-- department coverage by each agent
SELECT
    agent,
    COUNT(DISTINCT department) AS unique_dept_cnt
FROM
    vw_call_records_enriched
GROUP BY
    agent;

-- agent coverage by each department
SELECT
    department,
    COUNT(DISTINCT agent) AS unique_agent_cnt
FROM
    vw_call_records_enriched
GROUP BY
    department;