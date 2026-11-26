# ICMB-130: Final Research Findings

## 1. Dataset Overview

The Indian Cinema Multimodal Benchmark Dataset (ICMB-130)
contains 130 films selected from the five highest-grossing
Indian films in each year from 2000 to 2025.

India Gross was used as the commercial ranking metric.
The dataset integrates film-level metadata, box-office
information, subtitle-derived thematic features and
YouTube comment sentiment information.

The integrated inflation-adjusted dataset contains
130 observations and 65 columns.

## 2. Commercial Performance and Inflation Adjustment

The original India Gross collections were adjusted to
2025 price levels using India's annual Consumer Price
Index (CPI), obtained from the World Bank.

The adjustment formula was:

Adjusted Gross = Original Gross × (CPI in 2025 / CPI in release year)

Period-wise mean gross:

| Research Period | Nominal Mean (₹ Cr) | Adjusted Mean (₹ Cr) |
|---|---:|---:|
| Early (2000–2008) | 68.51 | 241.16 |
| Middle (2009–2017) | 254.36 | 447.29 |
| Recent (2018–2025) | 458.80 | 521.68 |

The nominal early-to-recent mean gross ratio is approximately
6.70, whereas the inflation-adjusted ratio is approximately
2.16.

This demonstrates that nominal comparisons substantially
overstate the difference between historical and recent
box-office collections.

The adjustment is CPI-based and should not be interpreted
as a ticket-price-adjusted or audience-volume measure.

## 3. Cinematic Theme Distribution

Twelve curated cinematic themes were examined using
subtitle-derived theme shares.

The highest average film-level theme shares were:

| Theme | Mean Share |
|---|---:|
| Love and Romantic Relationships | 37.37% |
| Marriage and Weddings | 12.69% |
| Family and Parent-Child Relationships | 9.55% |
| Money, Wealth and Economic Transactions | 7.48% |
| Police and Law Enforcement | 7.38% |
| Sports and Competition | 7.15% |

Love and Romantic Relationships was the most prominent
theme in the dataset.

It was the dominant theme in 69 of 130 films (53.08%).

## 4. Changes Across Research Periods

The average share of Love and Romantic Relationships
declined from 42.64% in the Early period to 28.88%
in the Recent period.

Marriage and Weddings declined from 15.82% to 9.84%.

Some themes showed higher average representation in the
Recent period:

- National Security and Terrorism: 1.85% to 6.96%.
- Politics, Governance and Corruption: 0.95% to 5.56%.
- Religion and Devotional Beliefs: 0.57% to 8.79%.
- Money, Wealth and Economic Transactions: 6.59% to 9.61%.

These are descriptive differences in subtitle-derived
theme representation, not evidence of causal changes
in audience preferences.

## 5. YouTube Comment Sentiment

The sentiment dataset contains 15,960 comments.

| Sentiment Category | Count | Share of All Comments |
|---|---:|---:|
| Positive | 2,985 | 18.70% |
| Negative | 2,168 | 13.58% |
| Neutral | 940 | 5.89% |
| Uncertain | 9,476 | 59.37% |
| Emoji-only / Not modelled | 390 | 2.44% |
| Empty | 1 | 0.01% |

There were 6,093 classifiable comments.

Within classifiable comments:

- Positive: 48.99%.
- Negative: 35.58%.
- Neutral: 15.43%.

The high uncertain-comment proportion is an important
limitation when interpreting the sentiment findings.

Period-wise positive sentiment share declined from
55.86% in the Early period to 45.50% in the Recent period.

Period-wise negative sentiment share increased from
29.50% to 41.77%.

These results describe the collected YouTube comments
and do not necessarily represent the entire movie audience.

## 6. Year-Adjusted Correlation Analysis

Partial Spearman correlations were used to examine
associations after controlling for year.

The analysis covered 17 associations:

- 12 cinematic theme measures.
- 5 sentiment measures.

None of the 12 theme measures showed a statistically
significant association with inflation-adjusted gross
after year adjustment and FDR correction.

Three sentiment-related associations remained
statistically significant:

| Measure | Partial Spearman ρ | FDR p-value |
|---|---:|---:|
| Positive sentiment share | -0.2276 | 0.0325 |
| Negative sentiment share | +0.2306 | 0.0325 |
| Classifiable comment share | +0.2345 | 0.0325 |

Neutral sentiment share and uncertain comment share
were not statistically significant after FDR correction.

These findings are exploratory associations and
must not be interpreted as causal effects.

## 7. Research Limitations

1. The dataset contains 130 selected films and should not
   be treated as a complete representation of all Indian cinema.

2. Gross collections are CPI-adjusted, not adjusted for
   ticket prices, admissions, or audience size.

3. Subtitle availability and validation quality vary.
   Not every subtitle file has fully verified film identity.

4. Language representation is unequal across the dataset.
   Language-level comparisons should therefore be interpreted
   cautiously.

5. Subtitle-derived themes represent the available dialogue
   corpus and may not capture every aspect of a film.

6. A large proportion of YouTube comments were classified
   as uncertain. Sentiment coverage is therefore limited.

7. YouTube comment samples and video-to-film source mapping
   have limitations and should not be treated as representative
   samples of all viewers.

8. The analysis is observational and does not establish
   causal relationships.

9. Year-adjusted partial Spearman p-values use a
   residual-degrees-of-freedom approximation. Results should
   be interpreted as exploratory rather than definitive.

## 8. Overall Conclusion

The ICMB-130 analysis provides an integrated view of
commercial performance, subtitle-derived cinematic themes
and YouTube comment sentiment across Indian films released
between 2000 and 2025.

The findings indicate that inflation adjustment changes
the interpretation of historical box-office comparisons.
Love and Romantic Relationships remains the most prominent
curated theme, although its average representation is lower
in the Recent period.

The year-adjusted analysis does not identify statistically
significant associations between individual cinematic
themes and inflation-adjusted gross. However, positive,
negative and classifiable YouTube comment shares show
statistically significant exploratory associations with
inflation-adjusted gross.

Overall, the project demonstrates a multimodal,
longitudinal analytical approach while highlighting the
limitations of subtitle coverage, sentiment classification
and observational data.