
SELECT COUNT(DISTINCT utm_source) AS 'Count of distinct campaigns' 
FROM page_visits;

SELECT COUNT(DISTINCT utm_campaign) AS 'Count of distinct sources' 
FROM page_visits;

SELECT DISTINCT utm_campaign AS 'Campaign', 
    utm_source AS 'Source' 
FROM page_visits;

SELECT page_name AS 'Web Page Name' 
FROM page_visits 
GROUP BY 1 ORDER BY 1;

WITH first_touch AS (
    SELECT user_id,
       MIN(timestamp) AS 'first_touch_at'
    FROM page_visits
    GROUP BY user_id)
SELECT pv.utm_campaign AS 'Campaign', pv.utm_source AS 'Source',
   COUNT(*) AS 'Count of First Touches'
FROM first_touch AS 'ft'
JOIN page_visits AS 'pv'
   ON ft.user_id = pv.user_id
   AND ft.first_touch_at = pv.timestamp
GROUP BY 1, 2 ORDER BY 3 DESC;

WITH last_touch AS (
    SELECT user_id,
       MAX(timestamp) AS 'last_touch_at'
    FROM page_visits
    GROUP BY user_id)
SELECT pv.utm_campaign AS 'Campaign', 
   pv.utm_source AS 'Source',
   COUNT(*) AS 'Count of Last Touches'
FROM last_touch AS 'lt'
JOIN page_visits AS 'pv'
   ON lt.user_id = pv.user_id
   AND lt.last_touch_at = pv.timestamp
GROUP BY 1, 2 ORDER BY 3 DESC;

SELECT COUNT(DISTINCT user_id) AS 'Number of Visitors Making a Purchase' 
FROM page_visits 
WHERE page_name = '4 - purchase';

WITH last_touch AS (
    SELECT user_id,
       MAX(timestamp) AS 'last_touch_at'
    FROM page_visits WHERE page_name = '4 - purchase'
    GROUP BY user_id)
SELECT pv.utm_campaign AS 'Campaign', 
   pv.utm_source AS 'Source',
   COUNT(*) AS 'Purchases'
FROM last_touch AS 'lt'
JOIN page_visits AS 'pv'
   ON lt.user_id = pv.user_id
   AND lt.last_touch_at = pv.timestamp
GROUP BY 1, 2 ORDER BY 3 DESC;
