WITH raw_data AS (
  SELECT
    COALESCE(channelGrouping, 'Unknown') AS channel_group,
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
  ROUND(SAFE_DIVIDE(converted_sessions, sessions) * 100, 2) AS conversion_rate_pct,
  ROUND(SAFE_DIVIDE(sessions, (SELECT SUM(sessions) FROM session_data)) * 100, 2) AS percent_total_sessions,
  ROUND(SAFE_DIVIDE(converted_sessions, (SELECT SUM(converted_sessions) FROM session_data)) * 100, 2) AS percent_converted_sessions
FROM session_data
ORDER BY percent_converted_sessions DESC