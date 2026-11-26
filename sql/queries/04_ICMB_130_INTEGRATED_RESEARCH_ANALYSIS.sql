-- ================================================================
-- ICMB-130: INTEGRATED RESEARCH ANALYSIS
-- Project: Indian Cinema Multimodal Benchmark Dataset (2000-2025)
-- Database: icmb130_db
-- Table: film_analytics
-- Module: 04
--
-- This module integrates:
-- 1. Commercial performance and dominant dialogue themes
-- 2. Commercial performance and audience sentiment
-- 3. Period-wise integrated trends
-- 4. Annual integrated trends
-- 5. Film-level integrated research dataset
--
-- Important:
-- - India Gross values are nominal, not inflation-adjusted.
-- - Theme percentages are based on curated theme chunks.
-- - Positive/negative/neutral percentages use classifiable comments.
-- - Sentiment analysis is exploratory and not representative of
--   the entire audience.
-- - Vikram (2022) has one unresolved sentiment-count discrepancy.
-- ================================================================


-- ================================================================
-- QUERY 1: BOX OFFICE VS DOMINANT DIALOGUE THEMES
-- ================================================================

WITH theme_data AS (
    SELECT
        movie_record_id,
        year,
        `rank`,
        movie_title,
        language,
        india_gross_cr,
        total_curated_theme_chunks,

        GREATEST(
            theme_chunks_love_and_romantic_relationships,
            theme_chunks_marriage_and_weddings,
            theme_chunks_family_and_parent_child_relationships,
            theme_chunks_sports_and_competition,
            theme_chunks_money_wealth_and_economic_transactions,
            theme_chunks_police_and_law_enforcement,
            theme_chunks_healthcare_and_medicine,
            theme_chunks_politics_governance_and_corruption,
            theme_chunks_national_security_and_terrorism,
            theme_chunks_courts_and_legal_proceedings,
            theme_chunks_education_and_academic_institutions,
            theme_chunks_religion_and_devotional_beliefs
        ) AS dominant_theme_chunks,

        CASE
            WHEN theme_chunks_love_and_romantic_relationships =
                GREATEST(
                    theme_chunks_love_and_romantic_relationships,
                    theme_chunks_marriage_and_weddings,
                    theme_chunks_family_and_parent_child_relationships,
                    theme_chunks_sports_and_competition,
                    theme_chunks_money_wealth_and_economic_transactions,
                    theme_chunks_police_and_law_enforcement,
                    theme_chunks_healthcare_and_medicine,
                    theme_chunks_politics_governance_and_corruption,
                    theme_chunks_national_security_and_terrorism,
                    theme_chunks_courts_and_legal_proceedings,
                    theme_chunks_education_and_academic_institutions,
                    theme_chunks_religion_and_devotional_beliefs
                ) THEN 'Love and romantic relationships'

            WHEN theme_chunks_marriage_and_weddings =
                GREATEST(
                    theme_chunks_love_and_romantic_relationships,
                    theme_chunks_marriage_and_weddings,
                    theme_chunks_family_and_parent_child_relationships,
                    theme_chunks_sports_and_competition,
                    theme_chunks_money_wealth_and_economic_transactions,
                    theme_chunks_police_and_law_enforcement,
                    theme_chunks_healthcare_and_medicine,
                    theme_chunks_politics_governance_and_corruption,
                    theme_chunks_national_security_and_terrorism,
                    theme_chunks_courts_and_legal_proceedings,
                    theme_chunks_education_and_academic_institutions,
                    theme_chunks_religion_and_devotional_beliefs
                ) THEN 'Marriage and weddings'

            WHEN theme_chunks_family_and_parent_child_relationships =
                GREATEST(
                    theme_chunks_love_and_romantic_relationships,
                    theme_chunks_marriage_and_weddings,
                    theme_chunks_family_and_parent_child_relationships,
                    theme_chunks_sports_and_competition,
                    theme_chunks_money_wealth_and_economic_transactions,
                    theme_chunks_police_and_law_enforcement,
                    theme_chunks_healthcare_and_medicine,
                    theme_chunks_politics_governance_and_corruption,
                    theme_chunks_national_security_and_terrorism,
                    theme_chunks_courts_and_legal_proceedings,
                    theme_chunks_education_and_academic_institutions,
                    theme_chunks_religion_and_devotional_beliefs
                ) THEN 'Family and parent-child relationships'

            WHEN theme_chunks_sports_and_competition =
                GREATEST(
                    theme_chunks_love_and_romantic_relationships,
                    theme_chunks_marriage_and_weddings,
                    theme_chunks_family_and_parent_child_relationships,
                    theme_chunks_sports_and_competition,
                    theme_chunks_money_wealth_and_economic_transactions,
                    theme_chunks_police_and_law_enforcement,
                    theme_chunks_healthcare_and_medicine,
                    theme_chunks_politics_governance_and_corruption,
                    theme_chunks_national_security_and_terrorism,
                    theme_chunks_courts_and_legal_proceedings,
                    theme_chunks_education_and_academic_institutions,
                    theme_chunks_religion_and_devotional_beliefs
                ) THEN 'Sports and competition'

            WHEN theme_chunks_money_wealth_and_economic_transactions =
                GREATEST(
                    theme_chunks_love_and_romantic_relationships,
                    theme_chunks_marriage_and_weddings,
                    theme_chunks_family_and_parent_child_relationships,
                    theme_chunks_sports_and_competition,
                    theme_chunks_money_wealth_and_economic_transactions,
                    theme_chunks_police_and_law_enforcement,
                    theme_chunks_healthcare_and_medicine,
                    theme_chunks_politics_governance_and_corruption,
                    theme_chunks_national_security_and_terrorism,
                    theme_chunks_courts_and_legal_proceedings,
                    theme_chunks_education_and_academic_institutions,
                    theme_chunks_religion_and_devotional_beliefs
                ) THEN 'Money, wealth and economic transactions'

            WHEN theme_chunks_police_and_law_enforcement =
                GREATEST(
                    theme_chunks_love_and_romantic_relationships,
                    theme_chunks_marriage_and_weddings,
                    theme_chunks_family_and_parent_child_relationships,
                    theme_chunks_sports_and_competition,
                    theme_chunks_money_wealth_and_economic_transactions,
                    theme_chunks_police_and_law_enforcement,
                    theme_chunks_healthcare_and_medicine,
                    theme_chunks_politics_governance_and_corruption,
                    theme_chunks_national_security_and_terrorism,
                    theme_chunks_courts_and_legal_proceedings,
                    theme_chunks_education_and_academic_institutions,
                    theme_chunks_religion_and_devotional_beliefs
                ) THEN 'Police and law enforcement'

            WHEN theme_chunks_healthcare_and_medicine =
                GREATEST(
                    theme_chunks_love_and_romantic_relationships,
                    theme_chunks_marriage_and_weddings,
                    theme_chunks_family_and_parent_child_relationships,
                    theme_chunks_sports_and_competition,
                    theme_chunks_money_wealth_and_economic_transactions,
                    theme_chunks_police_and_law_enforcement,
                    theme_chunks_healthcare_and_medicine,
                    theme_chunks_politics_governance_and_corruption,
                    theme_chunks_national_security_and_terrorism,
                    theme_chunks_courts_and_legal_proceedings,
                    theme_chunks_education_and_academic_institutions,
                    theme_chunks_religion_and_devotional_beliefs
                ) THEN 'Healthcare and medicine'

            WHEN theme_chunks_politics_governance_and_corruption =
                GREATEST(
                    theme_chunks_love_and_romantic_relationships,
                    theme_chunks_marriage_and_weddings,
                    theme_chunks_family_and_parent_child_relationships,
                    theme_chunks_sports_and_competition,
                    theme_chunks_money_wealth_and_economic_transactions,
                    theme_chunks_police_and_law_enforcement,
                    theme_chunks_healthcare_and_medicine,
                    theme_chunks_politics_governance_and_corruption,
                    theme_chunks_national_security_and_terrorism,
                    theme_chunks_courts_and_legal_proceedings,
                    theme_chunks_education_and_academic_institutions,
                    theme_chunks_religion_and_devotional_beliefs
                ) THEN 'Politics, governance and corruption'

            WHEN theme_chunks_national_security_and_terrorism =
                GREATEST(
                    theme_chunks_love_and_romantic_relationships,
                    theme_chunks_marriage_and_weddings,
                    theme_chunks_family_and_parent_child_relationships,
                    theme_chunks_sports_and_competition,
                    theme_chunks_money_wealth_and_economic_transactions,
                    theme_chunks_police_and_law_enforcement,
                    theme_chunks_healthcare_and_medicine,
                    theme_chunks_politics_governance_and_corruption,
                    theme_chunks_national_security_and_terrorism,
                    theme_chunks_courts_and_legal_proceedings,
                    theme_chunks_education_and_academic_institutions,
                    theme_chunks_religion_and_devotional_beliefs
                ) THEN 'National security and terrorism'

            WHEN theme_chunks_courts_and_legal_proceedings =
                GREATEST(
                    theme_chunks_love_and_romantic_relationships,
                    theme_chunks_marriage_and_weddings,
                    theme_chunks_family_and_parent_child_relationships,
                    theme_chunks_sports_and_competition,
                    theme_chunks_money_wealth_and_economic_transactions,
                    theme_chunks_police_and_law_enforcement,
                    theme_chunks_healthcare_and_medicine,
                    theme_chunks_politics_governance_and_corruption,
                    theme_chunks_national_security_and_terrorism,
                    theme_chunks_courts_and_legal_proceedings,
                    theme_chunks_education_and_academic_institutions,
                    theme_chunks_religion_and_devotional_beliefs
                ) THEN 'Courts and legal proceedings'

            WHEN theme_chunks_education_and_academic_institutions =
                GREATEST(
                    theme_chunks_love_and_romantic_relationships,
                    theme_chunks_marriage_and_weddings,
                    theme_chunks_family_and_parent_child_relationships,
                    theme_chunks_sports_and_competition,
                    theme_chunks_money_wealth_and_economic_transactions,
                    theme_chunks_police_and_law_enforcement,
                    theme_chunks_healthcare_and_medicine,
                    theme_chunks_politics_governance_and_corruption,
                    theme_chunks_national_security_and_terrorism,
                    theme_chunks_courts_and_legal_proceedings,
                    theme_chunks_education_and_academic_institutions,
                    theme_chunks_religion_and_devotional_beliefs
                ) THEN 'Education and academic institutions'

            WHEN theme_chunks_religion_and_devotional_beliefs =
                GREATEST(
                    theme_chunks_love_and_romantic_relationships,
                    theme_chunks_marriage_and_weddings,
                    theme_chunks_family_and_parent_child_relationships,
                    theme_chunks_sports_and_competition,
                    theme_chunks_money_wealth_and_economic_transactions,
                    theme_chunks_police_and_law_enforcement,
                    theme_chunks_healthcare_and_medicine,
                    theme_chunks_politics_governance_and_corruption,
                    theme_chunks_national_security_and_terrorism,
                    theme_chunks_courts_and_legal_proceedings,
                    theme_chunks_education_and_academic_institutions,
                    theme_chunks_religion_and_devotional_beliefs
                ) THEN 'Religion and devotional beliefs'
        END AS dominant_theme

    FROM film_analytics
)

SELECT
    movie_record_id,
    year,
    `rank`,
    movie_title,
    language,
    india_gross_cr,
    dominant_theme,
    dominant_theme_chunks,
    total_curated_theme_chunks,

    ROUND(
        dominant_theme_chunks * 100.0 /
        NULLIF(total_curated_theme_chunks, 0), 2
    ) AS dominant_theme_share_pct

FROM theme_data
ORDER BY india_gross_cr DESC;


-- ================================================================
-- QUERY 2: BOX OFFICE VS AUDIENCE SENTIMENT
-- ================================================================

SELECT
    movie_record_id,
    year,
    `rank`,
    movie_title,
    language,
    india_gross_cr,

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
    ) AS uncertain_pct

FROM film_analytics
ORDER BY india_gross_cr DESC;


-- ================================================================
-- QUERY 3: PERIOD-WISE INTEGRATED TRENDS
-- ================================================================

SELECT
    CASE
        WHEN year BETWEEN 2000 AND 2008 THEN 'Early (2000-2008)'
        WHEN year BETWEEN 2009 AND 2017 THEN 'Middle (2009-2017)'
        WHEN year BETWEEN 2018 AND 2025 THEN 'Recent (2018-2025)'
    END AS period,

    COUNT(*) AS total_films,

    ROUND(AVG(india_gross_cr), 2) AS avg_india_gross_cr,

    ROUND(
        AVG(total_curated_theme_chunks), 2
    ) AS avg_theme_chunks_per_film,

    ROUND(
        AVG(theme_share_love_and_romantic_relationships), 2
    ) AS avg_love_share_pct,

    ROUND(
        AVG(theme_share_sports_and_competition), 2
    ) AS avg_sports_share_pct,

    SUM(sentiment_comment_count) AS total_comments,
    SUM(classifiable_comments) AS classifiable_comments,

    SUM(positive_comments) AS positive_comments,

    ROUND(
        SUM(positive_comments) * 100.0 /
        NULLIF(SUM(classifiable_comments), 0), 2
    ) AS positive_pct,

    SUM(negative_comments) AS negative_comments,

    ROUND(
        SUM(negative_comments) * 100.0 /
        NULLIF(SUM(classifiable_comments), 0), 2
    ) AS negative_pct,

    SUM(neutral_comments) AS neutral_comments,

    ROUND(
        SUM(neutral_comments) * 100.0 /
        NULLIF(SUM(classifiable_comments), 0), 2
    ) AS neutral_pct,

    SUM(uncertain_comments) AS uncertain_comments

FROM film_analytics

GROUP BY
    CASE
        WHEN year BETWEEN 2000 AND 2008 THEN 'Early (2000-2008)'
        WHEN year BETWEEN 2009 AND 2017 THEN 'Middle (2009-2017)'
        WHEN year BETWEEN 2018 AND 2025 THEN 'Recent (2018-2025)'
    END

ORDER BY MIN(year);


-- ================================================================
-- QUERY 4: ANNUAL INTEGRATED TRENDS
-- ================================================================

SELECT
    year,
    COUNT(*) AS total_films,

    ROUND(AVG(india_gross_cr), 2) AS avg_india_gross_cr,
    ROUND(SUM(india_gross_cr), 2) AS total_india_gross_cr,

    ROUND(
        AVG(theme_share_love_and_romantic_relationships), 2
    ) AS avg_love_share_pct,

    ROUND(
        AVG(theme_share_sports_and_competition), 2
    ) AS avg_sports_share_pct,

    ROUND(
        AVG(theme_share_marriage_and_weddings), 2
    ) AS avg_marriage_share_pct,

    SUM(sentiment_comment_count) AS total_comments,
    SUM(classifiable_comments) AS classifiable_comments,

    ROUND(
        SUM(positive_comments) * 100.0 /
        NULLIF(SUM(classifiable_comments), 0), 2
    ) AS positive_pct,

    ROUND(
        SUM(negative_comments) * 100.0 /
        NULLIF(SUM(classifiable_comments), 0), 2
    ) AS negative_pct,

    ROUND(
        SUM(neutral_comments) * 100.0 /
        NULLIF(SUM(classifiable_comments), 0), 2
    ) AS neutral_pct,

    ROUND(
        SUM(uncertain_comments) * 100.0 /
        NULLIF(SUM(sentiment_comment_count), 0), 2
    ) AS uncertain_pct

FROM film_analytics
GROUP BY year
ORDER BY year;


-- ================================================================
-- QUERY 5: FILM-LEVEL INTEGRATED RESEARCH DATASET
-- ================================================================

SELECT
    movie_record_id,
    year,
    `rank`,
    movie_title,
    language,

    india_gross_cr,

    total_curated_theme_chunks,

    CASE
        WHEN total_curated_theme_chunks = 0 THEN NULL
        ELSE ROUND(
            GREATEST(
                theme_chunks_love_and_romantic_relationships,
                theme_chunks_marriage_and_weddings,
                theme_chunks_family_and_parent_child_relationships,
                theme_chunks_sports_and_competition,
                theme_chunks_money_wealth_and_economic_transactions,
                theme_chunks_police_and_law_enforcement,
                theme_chunks_healthcare_and_medicine,
                theme_chunks_politics_governance_and_corruption,
                theme_chunks_national_security_and_terrorism,
                theme_chunks_courts_and_legal_proceedings,
                theme_chunks_education_and_academic_institutions,
                theme_chunks_religion_and_devotional_beliefs
            ) * 100.0 /
            total_curated_theme_chunks, 2
        )
    END AS dominant_theme_share_pct,

    sentiment_comment_count AS total_comments,
    classifiable_comments,

    ROUND(
        classifiable_comments * 100.0 /
        NULLIF(sentiment_comment_count, 0), 2
    ) AS classifiable_coverage_pct,

    ROUND(
        positive_comments * 100.0 /
        NULLIF(classifiable_comments, 0), 2
    ) AS positive_pct,

    ROUND(
        negative_comments * 100.0 /
        NULLIF(classifiable_comments, 0), 2
    ) AS negative_pct,

    ROUND(
        neutral_comments * 100.0 /
        NULLIF(classifiable_comments, 0), 2
    ) AS neutral_pct,

    sentiment_count_difference

FROM film_analytics
ORDER BY year, `rank`;


-- ================================================================
-- END OF MODULE 04
-- ================================================================
