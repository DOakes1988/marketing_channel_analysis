\# Marketing Channel Performance Analysis



\## Overview



This project analyzes Google Analytics sample session data from August 2016 to evaluate

channel performance. The analysis looks at how different channels contributed traffic and

converted sessions, whether those patterns held steady across the month, and whether device

mix helps explain differences in performance.



\## Goals



\- Identify which channels performed strongest

\- Compare traffic share against converted-session share

\- Test whether monthly patterns were stable over time

\- Explore whether device mix helped explain performance differences



\## Dataset



\- \*\*Source\*\*: Google Analytics sample dataset (BigQuery public data)

\- \*\*Time window\*\*: August 2016

\- \*\*Grain\*\*: Session-level

\- \*\*Fields used\*\*: `channelGrouping`, `totals.transactions`, `date`, `device.deviceCategory`



\## Tools used



\- BigQuery

\- SQL



\## Methodology



August 2016 was used as the analysis window, with `channelGrouping` as the primary channel

dimension. A converted session was defined as a session where `totals.transactions` was not

null. Channel performance was evaluated using sessions, converted sessions, and conversion

rate. Share analysis compared traffic contribution against converted-session contribution.

Daily trend analysis tested whether monthly performance patterns were stable over time, and

device segmentation explored whether device mix helped explain channel-level differences.



\## Analysis performed



\- Monthly channel performance summary

\- Channel share analysis

\- Daily channel trend analysis

\- Channel-by-device segmentation



\## Key findings



Referral contributes a much larger share of converted sessions than its share of traffic,

while Social brings in a large share of traffic but contributes very little to converted

sessions.



Referral's strong converted-session performance appears consistent across the month rather

than being driven by a few high-performing days. Social's weak performance is similarly

consistent, with very few converted sessions on most days.



Desktop produced the vast majority of converted sessions, and Referral's heavy desktop

concentration may partially explain its strong performance. However, Social was also heavily

desktop-driven and still converted poorly, suggesting device mix alone does not explain the

difference in channel performance.



\## Limitations



\- Public sample datasets may not reflect complete business context

\- A one-month time window may exaggerate over- or under-performance

\- This analysis is descriptive and does not support causal claims

\- Smaller-volume channels should be interpreted cautiously



\## Files



\- `sql/`: SQL queries used for channel performance, share analysis, daily trends, and device

&#x20; segmentation



\## Next steps



\- Expand the time window beyond August 2016

\- Investigate source, medium, or landing-page-level analysis

\- Build a Power BI dashboard on top of these queries to visualize channel performance



