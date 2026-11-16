# Marketing Campaign A/B Test Analysis

End-to-end A/B test of **588,101 users** comparing commercial ads against Public Service Announcements (PSAs). SQL was used for aggregations, Python for statistical testing and modelling, and Power BI for the dashboard.

> **Result:** Ads lifted conversion from **1.79% to 2.55%** (+0.77 pp, **+43.09%** relative), z = 7.37, p < 0.001, odds ratio 1.44.

---

## Dashboard

<img width="404" height="225" alt="Screenshot 2026-11-16 183817" src="https://github.com/user-attachments/assets/4139aed8-5cba-4cbb-baf1-d6a8dcec726d" />


---

## Business Problem

A digital marketing company invests in commercial ads to acquire customers, but it is unclear whether ads actually drive **incremental** conversions compared with showing neutral PSAs. This project uses A/B testing and statistical inference to answer whether continued ad investment is justified.

## Dataset

- **Source:** [Marketing A/B Testing (Kaggle)](https://www.kaggle.com/datasets/faviovaz/marketing-ab-testing)
- **Size:** 588,101 users, one row per user

| Column | Description |
|---|---|
| `user id` | Unique user identifier |
| `test group` | `ad` (treatment) or `psa` (control) |
| `converted` | Whether the user converted (True/False) |
| `total ads` | Total ads the user saw |
| `most ads day` | Day of the week the user saw the most ads |
| `most ads hour` | Hour of the day (0 to 23) the user saw the most ads |

## Experiment Design

- **Control (A):** users shown PSAs
- **Treatment (B):** users shown commercial ads
- **Primary KPI:** conversion rate
- **H0:** ads have the same or a lower conversion rate than PSAs
- **H1:** ads have a higher conversion rate than PSAs
- **Significance level:** 5% (one-sided)

## Approach

1. **SQL:** basic aggregations such as users per group, conversions and conversion rate by group.
2. **Data cleaning (Python):** checked missing values and duplicates, confirmed each user appears once, standardised column names, converted the conversion flag to 0/1.
3. **Feature engineering:** grouped the 24 hours into four time-of-day buckets.
4. **Hypothesis test:** two-proportion z-test, chosen because the outcome is binary and the groups are independent and large.
5. **Effect size:** absolute lift, relative lift and 95% confidence interval for the difference in proportions.
6. **Power analysis:** statistical power and Minimum Detectable Effect (MDE).
7. **Logistic regression:** checked that the ad effect holds after controlling for day of week and time of day (with a sensitivity check that adds total ads seen).
8. **Dashboard (Power BI):** KPIs, group split, conversion by day and hour, and a statistics summary.

## Key Results

| Metric | Result |
|---|---|
| Total users | 588,101 |
| Overall conversion rate | 2.524% |
| Ad conversion rate | 2.5547% (564,577 users, 14,423 conversions) |
| PSA conversion rate | 1.7854% (23,524 users, 420 conversions) |
| Absolute lift | 0.77 pp |
| Relative lift | 43.09% |
| Z-test | z = 7.37, p < 0.001 |
| 95% CI for lift | 0.59 to 0.94 pp |
| Power / MDE | Power > 99.9%, MDE 0.23 pp (12.64% relative) |
| Logistic regression odds ratio | 1.44 (95% CI 1.31 to 1.59); 1.47 (95% CI 1.33 to 1.63) with total ads added |

## Business Recommendations

- **Continue investing in commercial ads.** The lift is statistically significant, practically meaningful and robust to adjustment. Roughly 30% of ad-group conversions (about 4,300) were incremental.
- **Measure profitability next** by combining the lift with real campaign cost and customer value data.
- **Prioritise higher-converting windows:** early-week days (Monday and Tuesday) and afternoon, evening and night hours; reduce spend in the 0 to 5 hour window.
- **Test ad frequency** with a randomised experiment, since more exposure is associated with higher conversion but likely has diminishing returns.
- **Validate timing patterns** with follow-up experiments, as they are observational.

## Limitations

- Randomisation is assumed, not documented in the data.
- Conversion definition and observation window are unknown.
- No cost or revenue data, so the results show effectiveness, not financial return.
- Timing and exposure effects are associations, not proven causes.

## Tools

`SQL Server` · `Python` · `pandas` · `NumPy` · `statsmodels` · `matplotlib` · `seaborn` · `Power BI`

## Repository Structure

```
marketing-ab-test-analysis/
├── data/
│   ├── marketing_AB.csv        # raw data (download from Kaggle)
│   ├── refined_data.csv        # cleaned data
│   └── summary.csv             # group summary table
├── sql/
│   └── aggregations.sql        # SQL aggregation queries
├── notebook/
│   └── marketing_AB.ipynb      # Python analysis
├── dashboard/
│   └── marketing_ab.pbix       # Power BI file
├── images/
│   └── dashboard.png           # dashboard screenshot
└── README.md
```

## How to Run

1. Download the dataset from [Kaggle](https://www.kaggle.com/datasets/faviovaz/marketing-ab-testing) and place `marketing_AB.csv` in the `data/` folder.
2. Install the requirements: `pip install pandas numpy statsmodels matplotlib seaborn jupyter`
3. Open `notebook/marketing_AB.ipynb` and run all cells.
4. Run the queries in `sql/` against your database, and open the dashboard in Power BI Desktop.

## Author

**Apoorva Maheshwari** · [LinkedIn](https://www.linkedin.com/in/m-apoorva-05b1b2b8/) · [GitHub]((https://github.com/ApooorvaM))
