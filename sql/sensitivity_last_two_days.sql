-- Purpose: To test the effect of excluding March 30 and March 31 on the final KPI
--          values in order to make a decision on whether to keep the two outliers
--          or exclude them from analysis
-- Source: vw_call_records_enriched (see 00_create_view.sql)
-- Scope: Two KPIs are tested against two sets of data, one for all the dates and
--        another by excluding the two outlier dates of March 30 and 31 where the 
--        volume of calls is lower than the typical daily volume.

-- Unanswered call % by month without excluding the outlier dates
SELECT
    month_num,
    month_name,
    COUNT(*) FILTER(WHERE answered = 'no') AS unanswered_call_cnt,
    COUNT(*) AS total_call_cnt,
    ROUND(
        (CAST(COUNT(*) FILTER(WHERE answered = 'no') AS REAL) / COUNT(*))
        * 100
    , 2) AS unanswered_call_pct
FROM
    vw_call_records_enriched
GROUP BY
    month_num,
    month_name
ORDER BY
    month_num;

-- Unanswered call % by month excluding the outlier dates
SELECT
    month_num,
    month_name,
    COUNT(*) FILTER(WHERE answered = 'no') AS unanswered_call_cnt,
    COUNT(*) AS total_call_cnt,
    ROUND(
        (CAST(COUNT(*) FILTER(WHERE answered = 'no') AS REAL) / COUNT(*))
        * 100
    , 2) AS unanswered_call_pct
FROM
    vw_call_records_enriched
WHERE
    date NOT IN ('2015-03-30', '2015-03-31')
GROUP BY
    month_num,
    month_name
ORDER BY
    month_num;

-- Average speed of answer by month without excluding the outlier dates
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

-- Average speed of answer by month excluding the outlier dates
SELECT
    month_num,
    month_name,
    COUNT(*) AS answered_call_cnt,
    SUM(speed_of_answer) AS total_speed_of_answer_sec,
    ROUND(AVG(speed_of_answer), 2) AS avg_speed_of_answer_sec
FROM
    vw_call_records_enriched
WHERE
    date NOT IN ('2015-03-30', '2015-03-31')
    AND
    answered = 'yes'
GROUP BY
    month_num,
    month_name
ORDER BY
    month_num;