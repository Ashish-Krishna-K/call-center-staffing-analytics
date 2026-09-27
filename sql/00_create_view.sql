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

BEGIN TRANSACTION;

DROP VIEW IF EXISTS vw_call_records_enriched;

CREATE VIEW vw_call_records_enriched AS
SELECT
    *,
    strftime('%m', date) AS month_num,
    CASE
        WHEN strftime('%m', date) = '01' THEN 'January'
        WHEN strftime('%m', date) = '02' THEN 'February'
        WHEN strftime('%m', date) = '03' THEN 'March'
        WHEN strftime('%m', date) = '04' THEN 'April'
        WHEN strftime('%m', date) = '05' THEN 'May'
        WHEN strftime('%m', date) = '06' THEN 'June'
        WHEN strftime('%m', date) = '07' THEN 'July'
        WHEN strftime('%m', date) = '08' THEN 'August'
        WHEN strftime('%m', date) = '09' THEN 'September'
        WHEN strftime('%m', date) = '10' THEN 'October'
        WHEN strftime('%m', date) = '11' THEN 'November'
        ELSE 'December'
    END AS month_name,
    strftime('%w', date) AS day_of_week_num,
    CASE 
        WHEN strftime('%w', date) = '0' THEN 'Sunday'
        WHEN strftime('%w', date) = '1' THEN 'Monday'  
        WHEN strftime('%w', date) = '2' THEN 'Tuesday'  
        WHEN strftime('%w', date) = '3' THEN 'Wednesday'  
        WHEN strftime('%w', date) = '4' THEN 'Thursday'
        WHEN strftime('%w', date) = '5' THEN 'Friday'  
        ELSE 'Saturday'
    END AS day_of_week,
    strftime('%H', time) AS hour_of_day
FROM
    call_records;

COMMIT;