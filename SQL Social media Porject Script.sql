CREATE DATABASE social_media_analysis;
USE social_media_analysis;
CREATE TABLE social_media_posts (
    post_id VARCHAR(20) PRIMARY KEY,
    platform VARCHAR(50),
    content_type VARCHAR(50),
    topic VARCHAR(50),
    language VARCHAR(20),
    region VARCHAR(50),
    post_datetime DATETIME,
    hashtags TEXT,
    views INT,
    likes INT,
    comments INT,
    shares INT,
    engagement_rate DECIMAL(5,4),
    sentiment_score DECIMAL(5,3),
    is_viral TINYINT
);

##Verify Data
SELECT * FROM social_media_posts
LIMIT 10;

##Basic Data Understanding
SELECT COUNT(*) AS total_posts
FROM social_media_posts;

## Platforms Available
SELECT DISTINCT platform
FROM social_media_posts;

## Viral vs Non-Viral Analysis
SELECT is_viral,
       COUNT(*) AS post_count
FROM social_media_posts
GROUP BY is_viral;

##Platform Performance
SELECT platform,
       AVG(views) AS avg_views,
       AVG(likes) AS avg_likes,
       AVG(engagement_rate) AS avg_engagement
FROM social_media_posts
GROUP BY platform
ORDER BY avg_engagement DESC;

##Content Type Analysis
SELECT content_type,
       COUNT(*) AS total_posts,
       AVG(engagement_rate) AS avg_engagement
FROM social_media_posts
GROUP BY content_type
ORDER BY avg_engagement DESC;

##Topic-wise Viral Content
SELECT topic,
       COUNT(*) AS viral_posts
FROM social_media_posts
WHERE is_viral = 1
GROUP BY topic
ORDER BY viral_posts DESC;

##Region Performance
SELECT region,
       AVG(views) AS avg_views,
       AVG(shares) AS avg_shares
FROM social_media_posts
GROUP BY region
ORDER BY avg_views DESC;

##Sentiment vs Virality
SELECT is_viral,
       AVG(sentiment_score) AS avg_sentiment
FROM social_media_posts
GROUP BY is_viral;

##Time-Based Analysis
SELECT MONTH(post_datetime) AS month,
       COUNT(*) AS total_posts
FROM social_media_posts
GROUP BY MONTH(post_datetime)
ORDER BY month;

##Top 10 Most Engaging Posts
SELECT post_id, platform, views, likes, shares, engagement_rate
FROM social_media_posts
ORDER BY engagement_rate DESC
LIMIT 10;

##Business Insights 
SELECT 
    'Platform Wise Viral Posts' AS report_type,
    platform AS category,
    COUNT(*) AS viral_posts,
    ROUND(AVG(engagement_rate),4) AS avg_engagement
FROM social_media_posts
WHERE is_viral = 1
GROUP BY platform

UNION ALL

SELECT 
    'Topic Wise Viral Posts' AS report_type,
    topic AS category,
    COUNT(*) AS viral_posts,
    NULL AS avg_engagement
FROM social_media_posts
WHERE is_viral = 1
GROUP BY topic
ORDER BY viral_posts DESC;

##Create a View (For Dashboard)
CREATE VIEW viral_dashboard AS
SELECT platform, topic, region,
       views, likes, shares, engagement_rate
FROM social_media_posts
WHERE is_viral = 1;

SELECT * FROM viral_dashboard;
