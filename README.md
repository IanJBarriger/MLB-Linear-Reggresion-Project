# MLB Win Percentage Prediction Using Linear Regression

This project uses team-level Major League Baseball (MLB) statistics (2000–2015) to build a predictive model for team win percentage. The project involved data collection, exploratory data analysis (EDA), multicollinearity diagnostics, and linear regression modeling, culminating in a refined model that identifies key performance indicators contributing to team success.

## What This Project Covers:
* Data Collection & Cleaning: Official MLB team statistics from 2000–2015, sourced via Baseball Reference.
* Exploratory Data Analysis: Visualized trends, checked for linearity, and explored variable relationships.
* Modeling: Created a full linear regression model, addressed multicollinearity, and selected variables using backward selection.
* Model Diagnostics: Evaluated assumptions of linear regression and confirmed model reliability using R², BIC, and Mallow’s Cp.
* Final Output: A reliable regression model that predicts win percentage using key metrics like Runs (R), ERA, Errors (E), and Run Differential (RUNDIFF).

**Tech used:** 
* R Studio
  * R Packages: car, MASS, olsrr, Metrics

## Dataset:
* Source: Baseball Reference
* Years Covered: 2000–2015
* Variables: 18 features, including offensive, defensive, and fielding stats.

The dataset includes information about MLB team metrics, including:
* yearID
* leagueID
* Wins
* Runs
* atBats
* Hits
* homeRuns
* Walks
* strikeOuts
* stolenBases
* runsAllowed
* ERA
* hitsAllowed
* Errors
* fieldingPercentage
* runDifferential (1:Positive, 0:Negative)

## Summary of Results:

The final model revealed the following:
* Positive contributors: Runs, Hits, Home Runs
* Negative contributors: ERA, Errors
* Run Differential played a key role and its interactions improved model precision
* Adjusted R² and BIC showed the final model was more efficient than the full model
    - Example insight: A 1-unit increase in Runs (R) increases expected win percentage by ~0.05%
    - Conversely, a 1-unit increase in ERA decreases win percentage by ~0.1%

## Lessons Learned:
* Developed practical skills in building regression models with real-world data.
* Improved understanding of multicollinearity and interaction effects.
* Gained hands-on experience with model diagnostics and refinement.
* Learned how to translate statistical findings into actionable insights for domain experts.

## Future Improvements:
* Incorporate more recent seasons (post 2015)
* Test non-linear models or tree-based regressors (Random Forest)
* Explore advanced baseball metrics (e.g., WAR, OBP, SLG)
* Visualize results with an interactive dashboard

## Citation
Data Provided by [Baseball Reference](https://www.baseball-reference.com/)

