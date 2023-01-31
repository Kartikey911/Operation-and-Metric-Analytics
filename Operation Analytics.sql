# User Engagement: To measure the activeness of a user. Measuring if the user finds quality in a product/service.
## Your task: Calculate the weekly user engagement?
SELECT 
    user_id, 
    DATE(occurred_at) AS week, 
    COUNT(DISTINCT event_name) AS unique_events, 
    SUM(CASE WHEN event_type = 'engagement' THEN 1 ELSE 0 END) AS engagement_count 
FROM 
    events_data 
GROUP BY 
    user_id, 
    WEEK(occurred_at) 
HAVING 
    unique_events > 0 
ORDER BY 
    week DESC;

# User Growth: Amount of users growing over time for a product.
## Your task: Calculate the user growth for product?
SELECT 
    DATE(created_at) AS week, 
    COUNT(DISTINCT user_id) AS new_users 
FROM 
    users 
GROUP BY 
    WEEK(created_at) 
ORDER BY 
    week DESC;
    
# Weekly Retention: Users getting retained weekly after signing-up for a product.
## Your task: Calculate the weekly retention of users-sign up cohort?
SELECT 
    cohort, 
    WEEK(activated_at) AS week, 
    COUNT(DISTINCT user_id) / total_users AS retention_rate 
FROM 
    (
        SELECT 
            user_id, 
            DATE(created_at) AS cohort, 
            activated_at, 
            (
                SELECT 
                    COUNT(DISTINCT user_id) 
                FROM 
                    users 
                WHERE 
                    DATE(created_at) = cohort
            ) AS total_users 
        FROM 
            users 
        WHERE 
            state = 'activated'
    ) AS subquery 
GROUP BY 
    cohort, 
    week 
ORDER BY 
    cohort, 
    week;

# Weekly Engagement: To measure the activeness of a user. Measuring if the user finds quality in a product/service weekly.
## Your task: Calculate the weekly engagement per device?
SELECT 
    device, 
    WEEK(occurred_at) AS week, 
    COUNT(DISTINCT user_id) AS engagement_count 
FROM 
    events_data 
WHERE 
    event_type = 'engagement' 
GROUP BY 
    device, 
    week 
ORDER BY 
    device, 
    week;
    
# Email Engagement: Users engaging with the email service.
## Your task: Calculate the email engagement metrics?
SELECT 
    action, 
    WEEK(occurred_at) AS week, 
    COUNT(DISTINCT user_id) AS engagement_count 
FROM 
    email_events 
GROUP BY 
    action, 
    week 
ORDER BY 
    action, 
    week;

