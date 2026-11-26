-- ============================================================
-- ICMB-130: INDIAN CINEMA MULTIMODAL BENCHMARK
-- SQL ANALYTICS: COMMERCIAL PERFORMANCE
-- Database: icmb130_db
-- Table: film_analytics
-- ============================================================

USE icmb130_db;

-- QUERY 1: Annual Box Office Performance

SELECT
    year,
    COUNT(*) AS total_films,
    ROUND(AVG(india_gross_cr), 2) AS average_india_gross_cr,
    ROUND(MIN(india_gross_cr), 2) AS minimum_india_gross_cr,
    ROUND(MAX(india_gross_cr), 2) AS maximum_india_gross_cr,
    ROUND(SUM(india_gross_cr), 2) AS total_india_gross_cr
FROM film_analytics
GROUP BY year
ORDER BY year;


-- QUERY 2: Top 10 Highest-Grossing Films

SELECT
    movie_title,
    year,
    language,
    india_gross_cr
FROM film_analytics
ORDER BY india_gross_cr DESC
LIMIT 10;


-- QUERY 3: Period-Wise Commercial Performance

WITH ranked AS (
    SELECT
        period,
        india_gross_cr,
        ROW_NUMBER() OVER (
            PARTITION BY period
            ORDER BY india_gross_cr
        ) AS rn,
        COUNT(*) OVER (
            PARTITION BY period
        ) AS n
    FROM film_analytics
)
SELECT
    period,
    COUNT(*) AS total_films,
    ROUND(AVG(ranked.india_gross_cr), 2) AS average_gross_cr,
    ROUND(AVG(
        CASE
            WHEN rn IN (
                FLOOR((n + 1) / 2),
                FLOOR((n + 2) / 2)
            )
            THEN ranked.india_gross_cr
        END
    ), 2) AS median_gross_cr,
    ROUND(SUM(ranked.india_gross_cr), 2) AS total_gross_cr
FROM ranked
GROUP BY period
ORDER BY FIELD(period, 'Early', 'Middle', 'Recent');


-- QUERY 4: Language-Wise Commercial Performance

SELECT
    language,
    COUNT(*) AS total_films,
    ROUND(AVG(india_gross_cr), 2) AS average_gross_cr,
    ROUND(MAX(india_gross_cr), 2) AS highest_gross_cr,
    ROUND(SUM(india_gross_cr), 2) AS total_gross_cr
FROM film_analytics
GROUP BY language
ORDER BY average_gross_cr DESC;


-- QUERY 5: Annual Number-One Films

SELECT
    year,
    movie_title,
    language,
    india_gross_cr
FROM film_analytics
WHERE `rank` = 1
ORDER BY year;


-- QUERY 6: Gross Distribution by Rank

SELECT
    `rank`,
    COUNT(*) AS total_films,
    ROUND(AVG(india_gross_cr), 2) AS average_gross_cr,
    ROUND(MIN(india_gross_cr), 2) AS minimum_gross_cr,
    ROUND(MAX(india_gross_cr), 2) AS maximum_gross_cr
FROM film_analytics
GROUP BY `rank`
ORDER BY `rank`;
