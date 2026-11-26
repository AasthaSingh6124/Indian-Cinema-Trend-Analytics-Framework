-- ============================================================
-- PROJECT:
-- ICMB-130 Indian Cinema Multimodal Benchmark Dataset
--
-- MODULE:
-- Audience Sentiment Analysis
--
-- DATABASE:
-- icmb130_db
--
-- TABLE:
-- film_analytics
--
-- SAMPLE:
-- 130 films (2000-2025)
--
-- PURPOSE:
-- Analyse YouTube audience-comment sentiment at overall,
-- temporal and film levels, and perform data-quality checks.
--
-- IMPORTANT:
-- Positive, negative and neutral percentages use
-- classifiable_comments as their denominator.
--
-- Uncertain and emoji-only percentages use
-- sentiment_comment_count as their denominator.
-- ============================================================


USE icmb130_db;


-- ============================================================
-- QUERY 1: OVERALL AUDIENCE SENTIMENT DISTRIBUTION
-- ============================================================

SELECT
    'Uncertain' AS sentiment_category,
    SUM(uncertain_comments) AS comment_count,
    ROUND(
        SUM(uncertain_comments) * 100.0 /
        NULLIF(SUM(sentiment_comment_count), 0), 2
    ) AS percentage
FROM film_analytics

UNION ALL

SELECT
    'Positive',
    SUM(positive_comments),
    ROUND(
        SUM(positive_comments) * 100.0 /
        NULLIF(SUM(sentiment_comment_count), 0), 2
    )
FROM film_analytics

UNION ALL

SELECT
    'Negative',
    SUM(negative_comments),
    ROUND(
        SUM(negative_comments) * 100.0 /
        NULLIF(SUM(sentiment_comment_count), 0), 2
    )
FROM film_analytics

UNION ALL

SELECT
    'Neutral',
    SUM(neutral_comments),
    ROUND(
        SUM(neutral_comments) * 100.0 /
        NULLIF(SUM(sentiment_comment_count), 0), 2
    )
FROM film_analytics

UNION ALL

SELECT
    'Emoji Only',
    SUM(emoji_only_comments),
    ROUND(
        SUM(emoji_only_comments) * 100.0 /
        NULLIF(SUM(sentiment_comment_count), 0), 2
    )
FROM film_analytics;


-- ============================================================
-- QUERY 2: CLASSIFIABLE SENTIMENT DISTRIBUTION
-- ============================================================

SELECT
    'Positive' AS sentiment_category,
    SUM(positive_comments) AS comment_count,
    ROUND(
        SUM(positive_comments) * 100.0 /
        NULLIF(SUM(classifiable_comments), 0), 2
    ) AS percentage
FROM film_analytics

UNION ALL

SELECT
    'Negative',
    SUM(negative_comments),
    ROUND(
        SUM(negative_comments) * 100.0 /
        NULLIF(SUM(classifiable_comments), 0), 2
    )
FROM film_analytics

UNION ALL

SELECT
    'Neutral',
    SUM(neutral_comments),
    ROUND(
        SUM(neutral_comments) * 100.0 /
        NULLIF(SUM(classifiable_comments), 0), 2
    )
FROM film_analytics;


-- ============================================================
-- QUERY 3: PERIOD-WISE AUDIENCE SENTIMENT ANALYSIS
--
-- Early:  2000-2008
-- Middle: 2009-2017
-- Recent: 2018-2025
-- ============================================================

WITH period_data AS (
    SELECT
        CASE
            WHEN year BETWEEN 2000 AND 2008
                THEN 'Early (2000-2008)'
            WHEN year BETWEEN 2009 AND 2017
                THEN 'Middle (2009-2017)'
            WHEN year BETWEEN 2018 AND 2025
                THEN 'Recent (2018-2025)'
        END AS period,

        CASE
            WHEN year BETWEEN 2000 AND 2008 THEN 1
            WHEN year BETWEEN 2009 AND 2017 THEN 2
            WHEN year BETWEEN 2018 AND 2025 THEN 3
        END AS period_order,

        sentiment_comment_count,
        classifiable_comments,
        positive_comments,
        negative_comments,
        neutral_comments,
        uncertain_comments,
        emoji_only_comments

    FROM film_analytics
),

period_summary AS (
    SELECT
        period,
        period_order,
        COUNT(*) AS total_films,

        SUM(sentiment_comment_count) AS total_comments,
        SUM(classifiable_comments) AS classifiable_comments,

        SUM(positive_comments) AS positive_comments,
        SUM(negative_comments) AS negative_comments,
        SUM(neutral_comments) AS neutral_comments,

        SUM(uncertain_comments) AS uncertain_comments,
        SUM(emoji_only_comments) AS emoji_only_comments

    FROM period_data
    GROUP BY period, period_order
)

SELECT
    period,
    total_films,
    total_comments,
    classifiable_comments,

    positive_comments,
    ROUND(
        positive_comments * 100.0 /
        NULLIF(classifiable_comments, 0), 2
    ) AS positive_pct,

    negative_comments,
    ROUND(
        negative_comments * 100.0 /
        NULLIF(classifiable_comments, 0), 2
    ) AS negative_pct,

    neutral_comments,
    ROUND(
        neutral_comments * 100.0 /
        NULLIF(classifiable_comments, 0), 2
    ) AS neutral_pct,

    uncertain_comments,
    ROUND(
        uncertain_comments * 100.0 /
        NULLIF(total_comments, 0), 2
    ) AS uncertain_pct,

    emoji_only_comments,
    ROUND(
        emoji_only_comments * 100.0 /
        NULLIF(total_comments, 0), 2
    ) AS emoji_only_pct

FROM period_summary
ORDER BY period_order;


-- ============================================================
-- QUERY 4: FILM-WISE AUDIENCE SENTIMENT DISTRIBUTION
-- ============================================================

SELECT
    movie_record_id,
    year,
    movie_title,
    language,

    sentiment_comment_count AS total_comments,
    classifiable_comments,

    positive_comments,
    ROUND(
        positive_comments * 100.0 /
        NULLIF(classifiable_comments, 0), 2
    ) AS positive_pct,

    negative_comments,
    ROUND(
        negative_comments * 100.0 /
        NULLIF(classifiable_comments, 0), 2
    ) AS negative_pct,

    neutral_comments,
    ROUND(
        neutral_comments * 100.0 /
        NULLIF(classifiable_comments, 0), 2
    ) AS neutral_pct,

    uncertain_comments,
    ROUND(
        uncertain_comments * 100.0 /
        NULLIF(sentiment_comment_count, 0), 2
    ) AS uncertain_pct,

    emoji_only_comments,
    ROUND(
        emoji_only_comments * 100.0 /
        NULLIF(sentiment_comment_count, 0), 2
    ) AS emoji_only_pct

FROM film_analytics
ORDER BY year, `rank`;


-- ============================================================
-- QUERY 5: AUDIENCE COMMENT COVERAGE ANALYSIS
-- ============================================================

SELECT
    movie_record_id,
    year,
    movie_title,
    language,

    sentiment_comment_count AS total_comments,
    classifiable_comments,

    CASE
        WHEN sentiment_comment_count < 50
            THEN 'Low Coverage'
        WHEN sentiment_comment_count < 100
            THEN 'Moderate Coverage'
        ELSE 'High Coverage'
    END AS coverage_category,

    ROUND(
        classifiable_comments * 100.0 /
        NULLIF(sentiment_comment_count, 0), 2
    ) AS classifiable_coverage_pct

FROM film_analytics
ORDER BY total_comments ASC, year ASC;


-- ============================================================
-- QUERY 6: SENTIMENT DATA-QUALITY RECONCILIATION
--
-- Identify films where recorded comment totals differ
-- from the sum of the five sentiment categories.
-- ============================================================

SELECT
    movie_record_id,
    year,
    movie_title,

    sentiment_comment_count AS recorded_total,

    positive_comments,
    negative_comments,
    neutral_comments,
    uncertain_comments,
    emoji_only_comments,

    (
        positive_comments
        + negative_comments
        + neutral_comments
        + uncertain_comments
        + emoji_only_comments
    ) AS calculated_total,

    sentiment_count_difference AS stored_difference,

    (
        sentiment_comment_count
        -
        (
            positive_comments
            + negative_comments
            + neutral_comments
            + uncertain_comments
            + emoji_only_comments
        )
    ) AS calculated_difference,

    CASE
        WHEN sentiment_comment_count =
             (
                positive_comments
                + negative_comments
                + neutral_comments
                + uncertain_comments
                + emoji_only_comments
             )
        THEN 'MATCH'
        ELSE 'MISMATCH'
    END AS reconciliation_status

FROM film_analytics

WHERE sentiment_comment_count <>
      (
        positive_comments
        + negative_comments
        + neutral_comments
        + uncertain_comments
        + emoji_only_comments
      )

ORDER BY year, `rank`;


-- ============================================================
-- QUERY 7: FINAL SENTIMENT RECONCILIATION SUMMARY
-- ============================================================

SELECT
    COUNT(*) AS total_films,

    SUM(
        CASE
            WHEN sentiment_comment_count =
                 positive_comments
                 + negative_comments
                 + neutral_comments
                 + uncertain_comments
                 + emoji_only_comments
            THEN 1
            ELSE 0
        END
    ) AS matched_films,

    SUM(
        CASE
            WHEN sentiment_comment_count <>
                 positive_comments
                 + negative_comments
                 + neutral_comments
                 + uncertain_comments
                 + emoji_only_comments
            THEN 1
            ELSE 0
        END
    ) AS mismatched_films,

    ROUND(
        SUM(
            CASE
                WHEN sentiment_comment_count =
                     positive_comments
                     + negative_comments
                     + neutral_comments
                     + uncertain_comments
                     + emoji_only_comments
                THEN 1
                ELSE 0
            END
        ) * 100.0 / NULLIF(COUNT(*), 0),
        2
    ) AS reconciliation_success_pct

FROM film_analytics;


-- ============================================================
-- DATA-QUALITY NOTE
--
-- Final verified reconciliation:
-- Total films:       130
-- Matched films:     129
-- Mismatched films:  1
--
-- Vikram (2022):
-- Recorded total:    100
-- Calculated total:   99
-- Difference:          1
--
-- Original values are intentionally retained.
-- No additional comments or sentiment labels have been
-- artificially added to force reconciliation.
--
-- INTERPRETATION NOTE:
-- YouTube comment sentiment is exploratory. A large
-- proportion of comments is uncertain or language-uncertain.
-- Results should not be interpreted as representative
-- measures of all film audiences.
-- ============================================================
