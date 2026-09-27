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

SELECT
    COUNT(*) AS call_volume
FROM
    call_records;

SELECT  
    strftime('%m', date) AS month,
    COUNT(*) AS call_volume
FROM
    call_records
GROUP BY
    strftime('%m', date);

SELECT
    date,
    COUNT(*) AS call_volume
FROM
    call_records
GROUP BY
    date;

SELECT
    strftime('%w', date) AS day_of_week,
    COUNT(*) AS call_volume
FROM
    call_records
GROUP BY
    strftime('%w', date);

WITH hours_added AS (
    SELECT
        *,
        strftime('%H', time) AS hour_of_day
    FROM
        call_records
)
SELECT
    MIN(hour_of_day) AS start_hour,
    MAX(hour_of_day) AS end_hour,
    COUNT(DISTINCT hour_of_day) AS n_hours
FROM
    hours_added;

WITH hours_added AS (
    SELECT
        *,
        strftime('%H', time) AS hour_of_day
    FROM
        call_records
)
SELECT
    hour_of_day,
    COUNT(*) AS call_volume
FROM
    hours_added
GROUP BY
    hour_of_day;

SELECT
    strftime('%w', date) AS day_of_week,
    strftime('%H', time) AS hour_of_day,
    COUNT(*) AS call_volume
FROM
    call_records
GROUP BY
    strftime('%w', date),
    strftime('%H', time);

SELECT
    agent,
    COUNT(*) FILTER(WHERE answered = 'no') AS unanswered_calls,
    COUNT(*) FILTER(WHERE answered = 'yes') AS answered_calls,
    COUNT(*) AS assigned_calls
FROM
    call_records
GROUP BY
    agent;

SELECT
    department,
    COUNT(*) FILTER(WHERE answered = 'no') AS unanswered_calls,
    COUNT(*) FILTER(WHERE answered = 'yes') AS answered_calls,
    COUNT(*) AS assigned_calls
FROM
    call_records
GROUP BY
    department;

SELECT
    agent,
    COUNT(DISTINCT department) AS unique_dept_cnt
FROM
    call_records
GROUP BY
    agent;

SELECT
    department,
    COUNT(DISTINCT agent) AS unique_agent_cnt
FROM
    call_records
GROUP BY
    department;