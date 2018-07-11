SELECT COUNT(DISTINCT utm_campaign)
FROM page_visits;

SELECT COUNT(DISTINCT utm_source)
FROM page_visits;

SELECT DISTINCT utm_campaign, 
    utm_source
FROM page_visits
ORDER BY 2;

SELECT DISTINCT page_name
FROM page_visits;

WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) AS first_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT pv.utm_campaign,
    COUNT(*) AS first_touch_count
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
GROUP BY pv.utm_campaign
ORDER BY 2 DESC;

WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) AS last_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT pv.utm_campaign,
    COUNT(*) AS last_touch_count
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
GROUP BY pv.utm_campaign
ORDER BY 2 DESC;

SELECT page_name, 
    COUNT(*)
FROM page_visits
GROUP BY page_name;

WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) AS last_touch_at
    FROM page_visits
    WHERE page_name = '4 - purchase'
    GROUP BY user_id)
SELECT pv.utm_campaign,
    COUNT(*) AS last_touch_count_at_purchase
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
GROUP BY pv.utm_campaign
ORDER BY 2 DESC;

WITH popular_first_touch_users AS (
    SELECT user_id
    FROM page_visits
    WHERE page_name = '1 - landing_page'
      AND utm_campaign = 'interview-with-cool-tshirts-founder'),
    popular_second_touch_users AS (
    SELECT user_id
    FROM page_visits
    WHERE page_name = '2 - shopping_cart'
      AND utm_campaign = 'interview-with-cool-tshirts-founder'),
    popular_third_touch_users AS (
    SELECT user_id
    FROM page_visits
    WHERE page_name = '3 - checkout'
      AND utm_campaign = 'retargetting-ad')
SELECT utm_campaign,
    COUNT(*) AS 'user_journey_last_touch_count'
FROM popular_first_touch_users pftu
JOIN popular_second_touch_users pstu
    ON pftu.user_id = pstu.user_id
JOIN popular_third_touch_users pttu
    ON pftu.user_id = pttu.user_id
JOIN page_visits pv
    ON pftu.user_id = pv.user_id
WHERE page_name = '4 - purchase'
GROUP BY utm_campaign
ORDER BY 2 DESC;

WITH popular_last_touch_users AS (
    SELECT user_id
    FROM page_visits
    WHERE page_name = '4 - purchase'
      AND utm_campaign = 'weekly-newsletter'),
    popular_third_touch_users AS (
    SELECT user_id
    FROM page_visits
    WHERE page_name = '3 - checkout'
      AND utm_campaign = 'weekly-newsletter'),
    popular_second_touch_users AS (
    SELECT user_id
    FROM page_visits
    WHERE page_name = '2 - shopping_cart'
      AND utm_campaign = 'ten-crazy-cool-tshirts-facts')
SELECT utm_campaign,
    COUNT(*) AS 'user_journey_purchase_first_touch_count'
FROM popular_last_touch_users pltu
JOIN popular_third_touch_users pttu
    ON pltu.user_id = pttu.user_id
JOIN popular_second_touch_users pstu
    ON pltu.user_id = pstu.user_id
JOIN page_visits pv
    ON pltu.user_id = pv.user_id
WHERE page_name = '1 - landing_page'
GROUP BY utm_campaign
ORDER BY 2 DESC;

WITH popular_first_touch_users AS (
    SELECT user_id
    FROM page_visits
    WHERE page_name = '1 - landing_page'
      AND utm_campaign = 'interview-with-cool-tshirts-founder')
SELECT COUNT(*) AS 'number_of_associated_purchases_for_interview-with-cool-tshirts-founder'
FROM popular_first_touch_users pftu
JOIN page_visits pv
    ON pftu.user_id = pv.user_id
WHERE page_name = '4 - purchase';

WITH popular_first_touch_users AS (
    SELECT user_id
    FROM page_visits
    WHERE page_name = '1 - landing_page'
      AND utm_campaign = 'getting-to-know-cool-tshirts')
SELECT COUNT(*) AS 'number_of_associated_purchases_for_getting-to-know-cool-tshirts'
FROM popular_first_touch_users pftu
JOIN page_visits pv
    ON pftu.user_id = pv.user_id
WHERE page_name = '4 - purchase';

WITH popular_first_touch_users AS (
    SELECT user_id
    FROM page_visits
    WHERE page_name = '1 - landing_page'
      AND utm_campaign = 'ten-crazy-cool-tshirts-facts')
SELECT COUNT(*) AS 'number_of_associated_purchases_for_ten-crazy-cool-tshirts-facts'
FROM popular_first_touch_users pftu
JOIN page_visits pv
    ON pftu.user_id = pv.user_id
WHERE page_name = '4 - purchase';

WITH popular_first_touch_users AS (
    SELECT user_id
    FROM page_visits
    WHERE page_name = '1 - landing_page'
      AND utm_campaign = 'cool-tshirts-search')
SELECT COUNT(*) AS 'number_of_associated_purchases_for_cool-tshirts-search'
FROM popular_first_touch_users pftu
JOIN page_visits pv
    ON pftu.user_id = pv.user_id
WHERE page_name = '4 - purchase';