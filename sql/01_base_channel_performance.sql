WITH raw_data AS (
  SELECT
    channelGrouping AS channel_group,
    totals.transactions AS num_transactions
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`
  WHERE _TABLE_SUFFIX BETWEEN '20160801' AND '20160831'
),

session_data AS (
  SELECT
    channel_group,
    COUNT(*) AS sessions,
    SUM(CASE WHEN num_transactions IS NOT NULL THEN 1 ELSE 0 END) AS converted_sessions
  FROM raw_data
  GROUP BY channel_group
)

SELECT 
  channel_group,
  sessions,
  converted_sessions,
  ROUND(SAFE_DIVIDE(converted_sessions, sessions) * 100, 2) AS conversion_rate_pct
FROM session_data
ORDER BY converted_sessions DESC