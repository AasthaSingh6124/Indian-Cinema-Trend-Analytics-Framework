# Indian Cinema Trend Analytics Framework (2000–2025)

A multimodal analytics framework for discovering long-term entertainment trends in Indian cinema through box-office performance, dialogue-derived themes, and YouTube audience sentiment.

## Project Overview

This research project explores how commercial performance, cinematic dialogue themes, and audience sentiment evolve across selected Indian films released between 2000 and 2025. It combines structured film metadata and India Gross data with subtitle-derived dialogue analysis and YouTube comments to study multiple dimensions of cinema trends.

The benchmark, **ICMB-130**, contains 130 selected films—five films for each year from 2000 through 2025. Film selection and ranking are based on India Gross. The benchmark is a curated selection of high-grossing films and is not intended to represent the entire Indian film industry.

## Research Objectives

- Examine long-term box-office performance using nominal and CPI-adjusted India Gross.
- Explore dialogue-derived themes and their evolution across time periods.
- Analyze sentiment patterns in collected YouTube comments.
- Explore statistical associations between commercial performance, dialogue themes, and audience sentiment.
- Present findings through reproducible notebooks, analytical tables, visualizations, and a Power BI dashboard.

## Dataset: ICMB-130

- **Coverage:** 2000–2025
- **Films:** 130 selected films (five per year)
- **Commercial measure:** India Gross
- **Inflation reference:** India CPI, adjusted to 2025 prices
- **Integrated analytical dataset:** Film-level multimodal features

The project includes a master film dataset, integrated analytical data, and a CPI-adjusted dataset. CPI-adjusted gross is an inflation-adjusted monetary comparison; it is not an estimate of ticket prices, admissions, audience size, or real attendance.

## Methodology and Workflow

1. **Film identification and metadata collection** — identify the benchmark films and collect movie metadata.
2. **Commercial data collection and preparation** — compile and validate India Gross values and prepare analytical features.
3. **Exploratory data analysis** — examine distributions, trends, ranks, and period comparisons.
4. **Dialogue/subtitle processing** — acquire and process subtitle dialogue for thematic analysis; original-language subtitles were prioritized where suitable, with English fallback where required.
5. **Topic modelling and theme analysis** — explore topics using BERTopic and NMF-based approaches, review representative dialogue, and curate a final 12-theme taxonomy.
6. **YouTube sentiment analysis** — analyze collected comments with the CardiffNLP `twitter-xlm-roberta-base-sentiment` model and a confidence threshold of 0.60.
7. **Statistical association analysis** — explore relationships between film-level features and gross, including year-adjusted analyses and multiple-testing correction.
8. **Research reporting and visualization** — summarize findings in final tables, figures, notebooks, and Power BI.

## Curated Dialogue Theme Taxonomy

The final theme analysis uses these 12 themes:


1. Love and romantic relationships
2. Marriage and weddings
3. Family and parent–child relationships
4. Sports and competition
5. Money, wealth, and economic transactions
6. Police and law enforcement
7. Healthcare and medicine
8. Politics, governance, and corruption
9. National security and terrorism
10. Courts and legal proceedings
11. Education and academic institutions
12. Religion and devotional beliefs

## Key Findings

### Commercial performance

- The 130-film benchmark has a total nominal India Gross of approximately **₹32,881.19 crore**.
- Mean nominal India Gross is approximately **₹252.93 crore per film**.
- Period-level mean gross increases from the early period (2000–2008) to the recent period (2018–2025), in both nominal and CPI-adjusted comparisons.
- CPI adjustment moderates the size of the long-term increase: the early-to-recent mean ratio is approximately **6.70× nominal** and **2.16× CPI-adjusted**.

### Dialogue themes

- Love/romantic relationships is the most prominent theme in the film-level theme-share analysis.
- Love is the dominant theme in 69 films (53.08%) in the curated analysis.
- Theme shares vary across the early (2000–2008), middle (2009–2017), and recent (2018–2025) periods.

### YouTube sentiment

- The collected comment inventory contains **15,960 comments**.
- A substantial portion of comments were classified as uncertain or were not modelled, so sentiment interpretation focuses on the classifiable subset and reports its denominator explicitly.
- Within classifiable comments, positive sentiment is more common than negative sentiment overall; the period-wise distribution also changes over time.

### Association analysis

- The analyses are exploratory and examine correlations rather than causal effects.
- In the year-adjusted CPI-gross sentiment analysis, positive sentiment share, negative sentiment share, and classifiable-comment share showed statistically significant associations after the reported false-discovery-rate correction.
- No dialogue theme was statistically significant after FDR correction in the year-adjusted CPI-gross theme analysis.

See `outputs/results/` for the final findings and tables. These summaries should be interpreted in the context of the project's sampling, data-quality, and modelling limitations.

## Visual Results

Final figures are available in [`outputs/figures/`](outputs/figures/). They include:

- Nominal vs. CPI-adjusted performance by period, rank, and year
- Overall theme distribution, period evolution, theme heatmap, and dominant film-level themes
- YouTube sentiment distributions and period-wise sentiment
- Year-adjusted theme–gross and sentiment–gross association results

## Repository Structure

```text
.
├── notebooks/                 # 11 notebooks covering the research workflow
├── data/
│   └── processed/             # Final benchmark and analytical datasets
├── outputs/
│   ├── figures/               # Final research figures
│   └── results/                # Findings, tables, and result files
├── sql/
│   └── queries/                # SQL analytical queries
└── powerbi/                   # Power BI dashboard
```

## Tools and Technologies

- Python, Pandas, NumPy
- Jupyter Notebook / Google Colab
- TMDB metadata and film information
- Topic modelling: BERTopic and NMF
- NLP and sentiment analysis: CardiffNLP XLM-RoBERTa sentiment model
- Statistical analysis: Spearman correlation, year-adjusted analysis, FDR correction
- Visualization: Matplotlib and related Python visualization tools
- SQL
- Power BI

## Reproducing the Analysis

1. Clone or download this repository.
2. Review the dataset and notebook descriptions.
3. Install the required Python packages in your environment as needed by each notebook.
4. Run the notebooks in numerical order. Some collection notebooks may require API credentials and/or external data access; do not commit credentials to the repository.
5. Notebooks that rely on subtitle or comment source data may not run end-to-end from the public repository because restricted or raw source files are not included.

Package versions and requirements may vary across notebooks; see the notebook setup cells for environment-specific dependencies.


## Limitations

- ICMB-130 is a curated high-grossing film benchmark, not a representative sample of all Indian films.
- India Gross source coverage and historical reporting may vary; the repository does not provide complete record-level provenance for every gross value.
- CPI adjustment uses annual India CPI and does not estimate admissions or audience volume.
- Subtitle coverage, language availability, identity verification, and quality vary; not every subtitle record has complete verification.
- YouTube comments are a platform-specific, non-representative audience sample. Comment-to-film mapping and sentiment classification have limitations, and language-specific validation is incomplete.
- Topic and theme assignments involve modelling and human-curation decisions.
- Statistical associations are exploratory and do not establish causation.

## Research Disclaimer

This project is an academic exploratory analysis. Results should be interpreted with the dataset scope, source coverage, validation status, and modelling limitations in mind. The project does not claim to measure the preferences or behaviour of all Indian cinema audiences.


## Author

**Aastha Singh**  
Executive M.Tech. — Data Engineering, IIT Jodhpur  
Project: Indian Cinema Trend Analytics Framework (ICMB-130)
