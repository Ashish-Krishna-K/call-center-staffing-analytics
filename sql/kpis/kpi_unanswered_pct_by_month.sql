-- KPI: Unanswered call % by month
-- Purpose: Compare the unanswered call % across months
--          (unanswered calls / total calls for the month).
-- Source: vw_call_records_enriched (see 00_create_view.sql)
-- Scope Note: Includes all hours (including the 18:00 hour as the exclusion only
--             applies to hourly KPIs).
-- Outlier Note: The last two days of March (March 30 and 31) show an unusually low
--               number of calls. Impact analysis showed 19.29% unanswered calls with
--               these days included vs. 18.91% with them removed in March. Because the
--               net difference is minor (0.38 percentage points), these dates were
--               retained in the dataset.
-- Output: Ordered chronologically by month for direct plotting.

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