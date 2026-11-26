-- ============================================================
-- ICMB-130: DIALOGUE THEME ANALYSIS
-- Dataset: 130 Indian films (2000–2025)
-- Database: icmb130_db
-- Table: film_analytics
-- MySQL 8.0+
-- ============================================================


-- ============================================================
-- QUERY 1: OVERALL PREVALENCE OF 12 CURATED THEMES
-- ============================================================

WITH theme_data AS (

    SELECT 'Love and romantic relationships' AS theme,
           SUM(theme_chunks_love_and_romantic_relationships) AS chunks
    FROM film_analytics

    UNION ALL
    SELECT 'Marriage and weddings',
           SUM(theme_chunks_marriage_and_weddings)
    FROM film_analytics

    UNION ALL
    SELECT 'Family and parent-child relationships',
           SUM(theme_chunks_family_and_parent_child_relationships)
    FROM film_analytics

    UNION ALL
    SELECT 'Sports and competition',
           SUM(theme_chunks_sports_and_competition)
    FROM film_analytics

    UNION ALL
    SELECT 'Money, wealth and economic transactions',
           SUM(theme_chunks_money_wealth_and_economic_transactions)
    FROM film_analytics

    UNION ALL
    SELECT 'Police and law enforcement',
           SUM(theme_chunks_police_and_law_enforcement)
    FROM film_analytics

    UNION ALL
    SELECT 'Healthcare and medicine',
           SUM(theme_chunks_healthcare_and_medicine)
    FROM film_analytics

    UNION ALL
    SELECT 'Politics, governance and corruption',
           SUM(theme_chunks_politics_governance_and_corruption)
    FROM film_analytics

    UNION ALL
    SELECT 'National security and terrorism',
           SUM(theme_chunks_national_security_and_terrorism)
    FROM film_analytics

    UNION ALL
    SELECT 'Courts and legal proceedings',
           SUM(theme_chunks_courts_and_legal_proceedings)
    FROM film_analytics

    UNION ALL
    SELECT 'Education and academic institutions',
           SUM(theme_chunks_education_and_academic_institutions)
    FROM film_analytics

    UNION ALL
    SELECT 'Religion and devotional beliefs',
           SUM(theme_chunks_religion_and_devotional_beliefs)
    FROM film_analytics
)

SELECT
    theme,
    chunks AS total_theme_chunks,
    ROUND(
        chunks * 100.0 /
        (SELECT SUM(total_curated_theme_chunks)
         FROM film_analytics), 2
    ) AS overall_share_pct
FROM theme_data
ORDER BY chunks DESC;


-- ============================================================
-- QUERY 2: PERIOD-WISE AVERAGE FILM-LEVEL THEME SHARES
-- ============================================================

WITH period_data AS (
    SELECT
        CASE
            WHEN year BETWEEN 2000 AND 2008 THEN 'Early (2000-2008)'
            WHEN year BETWEEN 2009 AND 2017 THEN 'Middle (2009-2017)'
            WHEN year BETWEEN 2018 AND 2025 THEN 'Recent (2018-2025)'
        END AS period,

        theme_share_love_and_romantic_relationships AS love_share,
        theme_share_marriage_and_weddings AS marriage_share,
        theme_share_family_and_parent_child_relationships AS family_share,
        theme_share_sports_and_competition AS sports_share,
        theme_share_money_wealth_and_economic_transactions AS money_share,
        theme_share_police_and_law_enforcement AS police_share,
        theme_share_healthcare_and_medicine AS healthcare_share,
        theme_share_politics_governance_and_corruption AS politics_share,
        theme_share_national_security_and_terrorism AS security_share,
        theme_share_courts_and_legal_proceedings AS courts_share,
        theme_share_education_and_academic_institutions AS education_share,
        theme_share_religion_and_devotional_beliefs AS religion_share

    FROM film_analytics
)

SELECT
    period,
    COUNT(*) AS total_films,

    ROUND(AVG(love_share), 2) AS love_avg_share_pct,
    ROUND(AVG(marriage_share), 2) AS marriage_avg_share_pct,
    ROUND(AVG(family_share), 2) AS family_avg_share_pct,
    ROUND(AVG(sports_share), 2) AS sports_avg_share_pct,
    ROUND(AVG(money_share), 2) AS money_avg_share_pct,
    ROUND(AVG(police_share), 2) AS police_avg_share_pct,
    ROUND(AVG(healthcare_share), 2) AS healthcare_avg_share_pct,
    ROUND(AVG(politics_share), 2) AS politics_avg_share_pct,
    ROUND(AVG(security_share), 2) AS security_avg_share_pct,
    ROUND(AVG(courts_share), 2) AS courts_avg_share_pct,
    ROUND(AVG(education_share), 2) AS education_avg_share_pct,
    ROUND(AVG(religion_share), 2) AS religion_avg_share_pct

FROM period_data
GROUP BY period
ORDER BY
    CASE period
        WHEN 'Early (2000-2008)' THEN 1
        WHEN 'Middle (2009-2017)' THEN 2
        WHEN 'Recent (2018-2025)' THEN 3
    END;


-- ============================================================
-- QUERY 3: PERIOD-WISE POOLED THEME PREVALENCE
-- ============================================================

WITH theme_data AS (

    SELECT
        CASE
            WHEN year BETWEEN 2000 AND 2008 THEN 'Early (2000-2008)'
            WHEN year BETWEEN 2009 AND 2017 THEN 'Middle (2009-2017)'
            WHEN year BETWEEN 2018 AND 2025 THEN 'Recent (2018-2025)'
        END AS period,
        'Love and romantic relationships' AS theme,
        theme_chunks_love_and_romantic_relationships AS chunks
    FROM film_analytics

    UNION ALL
    SELECT
        CASE
            WHEN year BETWEEN 2000 AND 2008 THEN 'Early (2000-2008)'
            WHEN year BETWEEN 2009 AND 2017 THEN 'Middle (2009-2017)'
            WHEN year BETWEEN 2018 AND 2025 THEN 'Recent (2018-2025)'
        END,
        'Marriage and weddings',
        theme_chunks_marriage_and_weddings
    FROM film_analytics

    UNION ALL
    SELECT
        CASE
            WHEN year BETWEEN 2000 AND 2008 THEN 'Early (2000-2008)'
            WHEN year BETWEEN 2009 AND 2017 THEN 'Middle (2009-2017)'
            WHEN year BETWEEN 2018 AND 2025 THEN 'Recent (2018-2025)'
        END,
        'Family and parent-child relationships',
        theme_chunks_family_and_parent_child_relationships
    FROM film_analytics

    UNION ALL
    SELECT
        CASE
            WHEN year BETWEEN 2000 AND 2008 THEN 'Early (2000-2008)'
            WHEN year BETWEEN 2009 AND 2017 THEN 'Middle (2009-2017)'
            WHEN year BETWEEN 2018 AND 2025 THEN 'Recent (2018-2025)'
        END,
        'Sports and competition',
        theme_chunks_sports_and_competition
    FROM film_analytics

    UNION ALL
    SELECT
        CASE
            WHEN year BETWEEN 2000 AND 2008 THEN 'Early (2000-2008)'
            WHEN year BETWEEN 2009 AND 2017 THEN 'Middle (2009-2017)'
            WHEN year BETWEEN 2018 AND 2025 THEN 'Recent (2018-2025)'
        END,
        'Money, wealth and economic transactions',
        theme_chunks_money_wealth_and_economic_transactions
    FROM film_analytics

    UNION ALL
    SELECT
        CASE
            WHEN year BETWEEN 2000 AND 2008 THEN 'Early (2000-2008)'
            WHEN year BETWEEN 2009 AND 2017 THEN 'Middle (2009-2017)'
            WHEN year BETWEEN 2018 AND 2025 THEN 'Recent (2018-2025)'
        END,
        'Police and law enforcement',
        theme_chunks_police_and_law_enforcement
    FROM film_analytics

    UNION ALL
    SELECT
        CASE
            WHEN year BETWEEN 2000 AND 2008 THEN 'Early (2000-2008)'
            WHEN year BETWEEN 2009 AND 2017 THEN 'Middle (2009-2017)'
            WHEN year BETWEEN 2018 AND 2025 THEN 'Recent (2018-2025)'
        END,
        'Healthcare and medicine',
        theme_chunks_healthcare_and_medicine
    FROM film_analytics

    UNION ALL
    SELECT
        CASE
            WHEN year BETWEEN 2000 AND 2008 THEN 'Early (2000-2008)'
            WHEN year BETWEEN 2009 AND 2017 THEN 'Middle (2009-2017)'
            WHEN year BETWEEN 2018 AND 2025 THEN 'Recent (2018-2025)'
        END,
        'Politics, governance and corruption',
        theme_chunks_politics_governance_and_corruption
    FROM film_analytics

    UNION ALL
    SELECT
        CASE
            WHEN year BETWEEN 2000 AND 2008 THEN 'Early (2000-2008)'
            WHEN year BETWEEN 2009 AND 2017 THEN 'Middle (2009-2017)'
            WHEN year BETWEEN 2018 AND 2025 THEN 'Recent (2018-2025)'
        END,
        'National security and terrorism',
        theme_chunks_national_security_and_terrorism
    FROM film_analytics

    UNION ALL
    SELECT
        CASE
            WHEN year BETWEEN 2000 AND 2008 THEN 'Early (2000-2008)'
            WHEN year BETWEEN 2009 AND 2017 THEN 'Middle (2009-2017)'
            WHEN year BETWEEN 2018 AND 2025 THEN 'Recent (2018-2025)'
        END,
        'Courts and legal proceedings',
        theme_chunks_courts_and_legal_proceedings
    FROM film_analytics

    UNION ALL
    SELECT
        CASE
            WHEN year BETWEEN 2000 AND 2008 THEN 'Early (2000-2008)'
            WHEN year BETWEEN 2009 AND 2017 THEN 'Middle (2009-2017)'
            WHEN year BETWEEN 2018 AND 2025 THEN 'Recent (2018-2025)'
        END,
        'Education and academic institutions',
        theme_chunks_education_and_academic_institutions
    FROM film_analytics

    UNION ALL
    SELECT
        CASE
            WHEN year BETWEEN 2000 AND 2008 THEN 'Early (2000-2008)'
            WHEN year BETWEEN 2009 AND 2017 THEN 'Middle (2009-2017)'
            WHEN year BETWEEN 2018 AND 2025 THEN 'Recent (2018-2025)'
        END,
        'Religion and devotional beliefs',
        theme_chunks_religion_and_devotional_beliefs
    FROM film_analytics
),

period_totals AS (
    SELECT
        CASE
            WHEN year BETWEEN 2000 AND 2008 THEN 'Early (2000-2008)'
            WHEN year BETWEEN 2009 AND 2017 THEN 'Middle (2009-2017)'
            WHEN year BETWEEN 2018 AND 2025 THEN 'Recent (2018-2025)'
        END AS period,
        SUM(total_curated_theme_chunks) AS total_chunks
    FROM film_analytics
    GROUP BY period
),

theme_totals AS (
    SELECT
        period,
        theme,
        SUM(chunks) AS theme_chunks
    FROM theme_data
    GROUP BY period, theme
)

SELECT
    t.period,
    t.theme,
    t.theme_chunks,
    p.total_chunks,
    ROUND(t.theme_chunks * 100.0 / NULLIF(p.total_chunks, 0), 2)
        AS pooled_theme_share_pct
FROM theme_totals t
JOIN period_totals p
    ON t.period = p.period
ORDER BY
    CASE t.period
        WHEN 'Early (2000-2008)' THEN 1
        WHEN 'Middle (2009-2017)' THEN 2
        WHEN 'Recent (2018-2025)' THEN 3
    END,
    pooled_theme_share_pct DESC;


-- ============================================================
-- QUERY 4: ANNUAL DIALOGUE THEME TRENDS (2000-2025)
-- ============================================================

WITH theme_data AS (

    SELECT year, 'Love and romantic relationships' AS theme,
           theme_chunks_love_and_romantic_relationships AS chunks
    FROM film_analytics

    UNION ALL
    SELECT year, 'Marriage and weddings',
           theme_chunks_marriage_and_weddings
    FROM film_analytics

    UNION ALL
    SELECT year, 'Family and parent-child relationships',
           theme_chunks_family_and_parent_child_relationships
    FROM film_analytics

    UNION ALL
    SELECT year, 'Sports and competition',
           theme_chunks_sports_and_competition
    FROM film_analytics

    UNION ALL
    SELECT year, 'Money, wealth and economic transactions',
           theme_chunks_money_wealth_and_economic_transactions
    FROM film_analytics

    UNION ALL
    SELECT year, 'Police and law enforcement',
           theme_chunks_police_and_law_enforcement
    FROM film_analytics

    UNION ALL
    SELECT year, 'Healthcare and medicine',
           theme_chunks_healthcare_and_medicine
    FROM film_analytics

    UNION ALL
    SELECT year, 'Politics, governance and corruption',
           theme_chunks_politics_governance_and_corruption
    FROM film_analytics

    UNION ALL
    SELECT year, 'National security and terrorism',
           theme_chunks_national_security_and_terrorism
    FROM film_analytics

    UNION ALL
    SELECT year, 'Courts and legal proceedings',
           theme_chunks_courts_and_legal_proceedings
    FROM film_analytics

    UNION ALL
    SELECT year, 'Education and academic institutions',
           theme_chunks_education_and_academic_institutions
    FROM film_analytics

    UNION ALL
    SELECT year, 'Religion and devotional beliefs',
           theme_chunks_religion_and_devotional_beliefs
    FROM film_analytics
),

annual_totals AS (
    SELECT
        year,
        SUM(total_curated_theme_chunks) AS total_chunks
    FROM film_analytics
    GROUP BY year
),

annual_theme_totals AS (
    SELECT
        year,
        theme,
        SUM(chunks) AS theme_chunks
    FROM theme_data
    GROUP BY year, theme
)

SELECT
    a.year,
    a.theme,
    a.theme_chunks,
    t.total_chunks,
    ROUND(a.theme_chunks * 100.0 / NULLIF(t.total_chunks, 0), 2)
        AS annual_theme_share_pct
FROM annual_theme_totals a
JOIN annual_totals t
    ON a.year = t.year
ORDER BY a.year, annual_theme_share_pct DESC;


-- ============================================================
-- QUERY 5: DOMINANT DIALOGUE THEME PER FILM
-- ============================================================

WITH theme_data AS (

    SELECT movie_record_id, year, movie_title,
           'Love and romantic relationships' AS theme,
           theme_chunks_love_and_romantic_relationships AS theme_chunks
    FROM film_analytics

    UNION ALL
    SELECT movie_record_id, year, movie_title,
           'Marriage and weddings',
           theme_chunks_marriage_and_weddings
    FROM film_analytics

    UNION ALL
    SELECT movie_record_id, year, movie_title,
           'Family and parent-child relationships',
           theme_chunks_family_and_parent_child_relationships
    FROM film_analytics

    UNION ALL
    SELECT movie_record_id, year, movie_title,
           'Sports and competition',
           theme_chunks_sports_and_competition
    FROM film_analytics

    UNION ALL
    SELECT movie_record_id, year, movie_title,
           'Money, wealth and economic transactions',
           theme_chunks_money_wealth_and_economic_transactions
    FROM film_analytics

    UNION ALL
    SELECT movie_record_id, year, movie_title,
           'Police and law enforcement',
           theme_chunks_police_and_law_enforcement
    FROM film_analytics

    UNION ALL
    SELECT movie_record_id, year, movie_title,
           'Healthcare and medicine',
           theme_chunks_healthcare_and_medicine
    FROM film_analytics

    UNION ALL
    SELECT movie_record_id, year, movie_title,
           'Politics, governance and corruption',
           theme_chunks_politics_governance_and_corruption
    FROM film_analytics

    UNION ALL
    SELECT movie_record_id, year, movie_title,
           'National security and terrorism',
           theme_chunks_national_security_and_terrorism
    FROM film_analytics

    UNION ALL
    SELECT movie_record_id, year, movie_title,
           'Courts and legal proceedings',
           theme_chunks_courts_and_legal_proceedings
    FROM film_analytics

    UNION ALL
    SELECT movie_record_id, year, movie_title,
           'Education and academic institutions',
           theme_chunks_education_and_academic_institutions
    FROM film_analytics

    UNION ALL
    SELECT movie_record_id, year, movie_title,
           'Religion and devotional beliefs',
           theme_chunks_religion_and_devotional_beliefs
    FROM film_analytics
),

ranked_themes AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY movie_record_id
               ORDER BY theme_chunks DESC, theme ASC
           ) AS theme_rank
    FROM theme_data
)

SELECT
    movie_record_id,
    year,
    movie_title,
    theme AS dominant_theme,
    theme_chunks
FROM ranked_themes
WHERE theme_rank = 1
ORDER BY year, movie_title;


-- ============================================================
-- QUERY 6: DISTRIBUTION OF DOMINANT THEMES ACROSS FILMS
-- ============================================================

WITH theme_data AS (

    SELECT movie_record_id,
           'Love and romantic relationships' AS theme,
           theme_chunks_love_and_romantic_relationships AS theme_chunks
    FROM film_analytics

    UNION ALL
    SELECT movie_record_id, 'Marriage and weddings',
           theme_chunks_marriage_and_weddings
    FROM film_analytics

    UNION ALL
    SELECT movie_record_id, 'Family and parent-child relationships',
           theme_chunks_family_and_parent_child_relationships
    FROM film_analytics

    UNION ALL
    SELECT movie_record_id, 'Sports and competition',
           theme_chunks_sports_and_competition
    FROM film_analytics

    UNION ALL
    SELECT movie_record_id, 'Money, wealth and economic transactions',
           theme_chunks_money_wealth_and_economic_transactions
    FROM film_analytics

    UNION ALL
    SELECT movie_record_id, 'Police and law enforcement',
           theme_chunks_police_and_law_enforcement
    FROM film_analytics

    UNION ALL
    SELECT movie_record_id, 'Healthcare and medicine',
           theme_chunks_healthcare_and_medicine
    FROM film_analytics

    UNION ALL
    SELECT movie_record_id, 'Politics, governance and corruption',
           theme_chunks_politics_governance_and_corruption
    FROM film_analytics

    UNION ALL
    SELECT movie_record_id, 'National security and terrorism',
           theme_chunks_national_security_and_terrorism
    FROM film_analytics

    UNION ALL
    SELECT movie_record_id, 'Courts and legal proceedings',
           theme_chunks_courts_and_legal_proceedings
    FROM film_analytics

    UNION ALL
    SELECT movie_record_id, 'Education and academic institutions',
           theme_chunks_education_and_academic_institutions
    FROM film_analytics

    UNION ALL
    SELECT movie_record_id, 'Religion and devotional beliefs',
           theme_chunks_religion_and_devotional_beliefs
    FROM film_analytics
),

ranked_themes AS (
    SELECT
        movie_record_id,
        theme,
        theme_chunks,
        ROW_NUMBER() OVER (
            PARTITION BY movie_record_id
            ORDER BY theme_chunks DESC, theme ASC
        ) AS theme_rank
    FROM theme_data
),

dominant_themes AS (
    SELECT movie_record_id, theme
    FROM ranked_themes
    WHERE theme_rank = 1
)

SELECT
    theme AS dominant_theme,
    COUNT(*) AS film_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM film_analytics), 2
    ) AS percentage_of_films
FROM dominant_themes
GROUP BY theme
ORDER BY film_count DESC, theme;


-- ============================================================
-- QUERY 7: LANGUAGE-WISE DIALOGUE THEME COUNTS
-- ============================================================

SELECT
    language,
    COUNT(*) AS total_films,

    SUM(theme_chunks_love_and_romantic_relationships)
        AS love_chunks,

    SUM(theme_chunks_marriage_and_weddings)
        AS marriage_chunks,

    SUM(theme_chunks_family_and_parent_child_relationships)
        AS family_chunks,

    SUM(theme_chunks_sports_and_competition)
        AS sports_chunks,

    SUM(theme_chunks_money_wealth_and_economic_transactions)
        AS money_chunks,

    SUM(theme_chunks_police_and_law_enforcement)
        AS police_chunks,

    SUM(theme_chunks_healthcare_and_medicine)
        AS healthcare_chunks,

    SUM(theme_chunks_politics_governance_and_corruption)
        AS politics_chunks,

    SUM(theme_chunks_national_security_and_terrorism)
        AS national_security_chunks,

    SUM(theme_chunks_courts_and_legal_proceedings)
        AS courts_chunks,

    SUM(theme_chunks_education_and_academic_institutions)
        AS education_chunks,

    SUM(theme_chunks_religion_and_devotional_beliefs)
        AS religion_chunks,

    SUM(total_curated_theme_chunks) AS total_theme_chunks

FROM film_analytics
GROUP BY language
ORDER BY total_films DESC;


-- ============================================================
-- QUERY 8: LANGUAGE-WISE NORMALIZED THEME PERCENTAGES
-- ============================================================

SELECT
    language,
    COUNT(*) AS total_films,
    SUM(total_curated_theme_chunks) AS total_theme_chunks,

    ROUND(
        SUM(theme_chunks_love_and_romantic_relationships)
        * 100.0 / NULLIF(SUM(total_curated_theme_chunks), 0), 2
    ) AS love_pct,

    ROUND(
        SUM(theme_chunks_marriage_and_weddings)
        * 100.0 / NULLIF(SUM(total_curated_theme_chunks), 0), 2
    ) AS marriage_pct,

    ROUND(
        SUM(theme_chunks_family_and_parent_child_relationships)
        * 100.0 / NULLIF(SUM(total_curated_theme_chunks), 0), 2
    ) AS family_pct,

    ROUND(
        SUM(theme_chunks_sports_and_competition)
        * 100.0 / NULLIF(SUM(total_curated_theme_chunks), 0), 2
    ) AS sports_pct,

    ROUND(
        SUM(theme_chunks_money_wealth_and_economic_transactions)
        * 100.0 / NULLIF(SUM(total_curated_theme_chunks), 0), 2
    ) AS money_pct,

    ROUND(
        SUM(theme_chunks_police_and_law_enforcement)
        * 100.0 / NULLIF(SUM(total_curated_theme_chunks), 0), 2
    ) AS police_pct,

    ROUND(
        SUM(theme_chunks_healthcare_and_medicine)
        * 100.0 / NULLIF(SUM(total_curated_theme_chunks), 0), 2
    ) AS healthcare_pct,

    ROUND(
        SUM(theme_chunks_politics_governance_and_corruption)
        * 100.0 / NULLIF(SUM(total_curated_theme_chunks), 0), 2
    ) AS politics_pct,

    ROUND(
        SUM(theme_chunks_national_security_and_terrorism)
        * 100.0 / NULLIF(SUM(total_curated_theme_chunks), 0), 2
    ) AS national_security_pct,

    ROUND(
        SUM(theme_chunks_courts_and_legal_proceedings)
        * 100.0 / NULLIF(SUM(total_curated_theme_chunks), 0), 2
    ) AS courts_pct,

    ROUND(
        SUM(theme_chunks_education_and_academic_institutions)
        * 100.0 / NULLIF(SUM(total_curated_theme_chunks), 0), 2
    ) AS education_pct,

    ROUND(
        SUM(theme_chunks_religion_and_devotional_beliefs)
        * 100.0 / NULLIF(SUM(total_curated_theme_chunks), 0), 2
    ) AS religion_pct

FROM film_analytics
GROUP BY language
ORDER BY total_films DESC;


-- ============================================================
-- END OF ICMB-130 DIALOGUE THEME ANALYSIS
-- ============================================================
