# ICMB-130: Final Research Findings

## Project Title

A Multimodal Analytics Framework for Long-Term Entertainment Trend
Discovery Across Indian Cinema (2000–2025)

## 1. Dataset Overview

The ICMB-130 benchmark contains 130 films selected as the top five
highest-grossing films per year from 2000 to 2025, using India Gross /
India Nett as the ranking metric.

The project integrates commercial metadata, subtitle-derived dialogue
themes and collected YouTube audience comments.

All 130 movie identifiers were matched across the master, theme and
film-level sentiment datasets. This indicates successful record-level
integration, not equal completeness or reliability across modalities.

## 2. Commercial Performance

The selected sample exhibits a strong positive temporal association
between release year and nominal India Gross (Spearman rho = 0.8700,
p = 3.90e-41).

Mean India Gross was ₹68.509 crore in the Early period (2000–2008),
₹254.359 crore in the Middle period (2009–2017), and ₹458.803 crore
in the Recent period (2018–2025).

These figures are descriptive. Gross values are nominal and have not
been adjusted for inflation. The top-five-per-year selection also
means that these findings should not be interpreted as a complete
representation of the Indian film industry.

## 3. Dialogue Theme Trends

The curated dialogue analysis identified 12 themes.

Love and romantic relationship dialogue share declined from 25.18%
in the Early period to 21.43% in the Middle period and 14.58% in
the Recent period.

Marriage and wedding dialogue share declined from 8.36% to 6.86%
and 5.16%, respectively.

Family and parent-child dialogue share was 5.85%, 4.71% and 5.07%
across the three periods.

These are descriptive patterns within the available subtitle corpus.
They do not establish industry-wide changes in narrative content.

## 4. Audience Sentiment

The collected YouTube dataset contained 15,960 comments. Of these,
6,093 (38.18%) were classified as positive, negative or neutral.

Among classifiable comments:
- Positive: 48.99%
- Negative: 35.58%
- Neutral: 15.43%

A substantial proportion of comments remained uncertain or otherwise
unclassified. Language coverage and model validation limitations mean
that these findings are exploratory and should not be interpreted as
representative audience opinion.

## 5. Integrated Statistical Analysis

Unadjusted exploratory associations were observed between some
dialogue or sentiment features and India Gross.

However, after year adjustment and multiple-testing correction,
no theme–gross, sentiment–gross or theme–sentiment association
remained statistically significant.

Therefore, the analysis does not establish robust independent
associations between dialogue themes, collected comment sentiment
and commercial performance in this benchmark sample.

The results should not be interpreted causally.

## 6. Data Quality and Limitations

1. The benchmark contains only the top five selected films per year.
2. India Gross values are nominal and not inflation-adjusted.
3. India Gross source attribution is not documented in the current
   master dataset, and no entries are marked verified.
4. Eight films do not have positive subtitle dialogue-block and
   word-count values in the manifest.
5. None of the 130 stored subtitle file paths resolved during the
   Notebook 11 path audit. Subtitle source-file revalidation remains
   unresolved.
6. YouTube sentiment classification is exploratory. A substantial
   proportion of comments are uncertain or unclassified.
7. The inspected Batch 04 video manifest had 12 records whose manual
   verification status was pending.
8. One film-level sentiment count mismatch was identified for
   Vikram (2022_3): 100 total comments versus 99 comments accounted
   for in the listed sentiment categories.
9. IMDb review analysis has not been established as a completed
   component of this analysis.

## 7. Overall Conclusion

ICMB-130 provides an integrated benchmark for exploring commercial
performance, dialogue themes and collected audience responses across
selected Indian films released between 2000 and 2025.

The analysis identifies descriptive changes in nominal box-office
values and curated dialogue-theme prevalence. Audience sentiment
coverage and language uncertainty constrain the strength of sentiment
interpretation.

After year adjustment and multiple-testing correction, no robust
independent statistical associations were established among the
analysed dialogue themes, audience sentiment features and India Gross.

The benchmark is therefore best understood as an exploratory,
multimodal research resource, with documented data-quality limitations
that should guide interpretation and future validation.