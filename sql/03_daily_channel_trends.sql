WITH raw_data AS (
  SELECT
    PARSE_DATE('%Y%m%d', date) AS date_,
    COALESCE(channelGrouping, 'Unknown') AS channel_group,
    totals.transactions AS num_transactions
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`
  WHERE _TABLE_SUFFIX BETWEEN '20160801' AND '20160831'
),

daily_channel_summary AS (
  SELECT
    date_,
    channel_group,
    COUNT(*) AS sessions,
    SUM(CASE WHEN num_transactions IS NOT NULL THEN 1 ELSE 0 END) AS converted_sessions
  FROM raw_data
  GROUP BY date_, channel_group
)

SELECT 
  date_,
  channel_group,
  sessions,
  converted_sessions,
  SAFE_DIVIDE(converted_sessions, sessions) AS conversion_rate
FROM daily_channel_summary
ORDER BY channel_group, date_