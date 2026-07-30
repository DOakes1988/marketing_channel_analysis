WITH raw_data AS (
  SELECT
    COALESCE(channelGrouping, 'Unknown') AS channel_group,
    device.deviceCategory AS device,
    totals.transactions AS num_transactions
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`
  WHERE _TABLE_SUFFIX BETWEEN '20160801' AND '20160831'
),

session_data AS (
  SELECT
    channel_group,
    COUNT(*) AS total_sessions,
    SUM(CASE WHEN num_transactions IS NOT NULL THEN 1 ELSE 0 END) AS total_converted_sessions
  FROM raw_data
  GROUP BY channel_group
),

channel_device_summary AS (
  SELECT
    channel_group,
    device,
    COUNT(*) AS sessions,
    SUM(CASE WHEN num_transactions IS NOT NULL THEN 1 ELSE 0 END) AS converted_sessions
  FROM raw_data
  GROUP BY channel_group, device
)

SELECT
  cds.channel_group,
  cds.device,
  cds.sessions,
  cds.converted_sessions,
  ROUND(COALESCE(SAFE_DIVIDE(cds.converted_sessions, cds.sessions), 0) * 100, 2) AS conversion_rate_pct,
  ROUND(COALESCE(SAFE_DIVIDE(cds.sessions, sd.total_sessions), 0) * 100, 2) AS percent_channel_sessions,
  ROUND(COALESCE(SAFE_DIVIDE(cds.converted_sessions, sd.total_converted_sessions), 0) * 100, 2) AS percent_channel_converted_sessions
FROM session_data AS sd
JOIN channel_device_summary AS cds
  ON sd.channel_group = cds.channel_group
ORDER BY sd.channel_group, percent_channel_converted_sessions DESC