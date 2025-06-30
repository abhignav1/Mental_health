# 🧠 Burnout Risk Prediction Using Lifestyle & Digital Behavior Data

## 📌 Overview
In today's world of non-stop screen usage and digital overload, it's becoming increasingly important to understand how our habits impact our mental health. This project predicts an individual's **mental health score** using screen time, sleep, stress, and lifestyle patterns — and determines if they may be at **risk of burnout**.

Rather than simply classifying users as "at-risk" or "not-at-risk," this model predicts a **continuous mental health score** and classifies risk after prediction, allowing for more **nuanced, accurate modeling**.

## 🎯 Project Objectives
- Predict mental health deterioration using digital behavior data
- Use regression to improve interpretability and prediction quality
- Classify users into “at risk” vs “not at risk” categories based on predicted scores
- Explore real-world applications for wellness platforms, HR tools, and digital self-care

## 📚 Dataset Details
- **Title:** Impact of Screen Time on Mental Health  
- **Source:** Kaggle  
- **Size:** ~2,000 observations  
- **Features:**
  - `daily_screen_time_hours`, `phone_usage_hours`, `tv_usage_hours`
  - `sleep_duration_hours`, `sleep_quality`, `stress_level`
  - `mood_rating`, `caffeine_intake_mg_per_day`, `physical_activity_hours_per_week`
  - `mental_health_score` (target for regression)

## 🛠️ Techniques Used
- **Data Cleaning & Preparation**
  - Removal of non-informative fields (`user_id`)
  - Handling of missing/invalid values

- **Feature Engineering**
  - `screen_per_hour_awake`
  - `stress_to_sleep_ratio`
  - `caffeine_sleep_ratio`
  - `digital_exhaustion = (screen time + phone use) * stress / sleep`
  - `wellbeing_score = mindfulness + activity - caffeine`

- **Modeling Approach**
  - Regression model using **XGBoost**
  - One-hot encoding for categorical variables
  - Removal of high-correlation and near-zero variance features
  - Threshold-based post-classification (`< 50` mental health score = "at risk")

- **Evaluation Metrics**
  - **RMSE** (Root Mean Square Error) for regression accuracy
  - **Confusion Matrix** and **Balanced Accuracy** for classification
  - **Kappa** for agreement between predicted and actual classes

## 🚀 Results
- **Regression RMSE:** Low, suggesting good fit to mental health score
- **Classification Accuracy:** **99.5%**
- **Sensitivity:** **98.9%**
- **Specificity:** **100%**
- **Kappa:** **0.99** (very strong agreement)

This model significantly outperforms basic classifiers like logistic regression and random forest used earlier in the project.

## 🧩 Key Learnings
- Predicting **continuous scores** gives better model accuracy than directly classifying risk
- Custom engineered features added major value — especially `digital_exhaustion` and `wellbeing_score`
- Simple behavioral data can offer predictive insights into **mental wellness**
- Class imbalance and labeling noise can be bypassed using smart modeling structure (regression + thresholding)

## 💡 Applications
- 📱 **Wellness Apps:** Automated check-ins based on screen/caffeine/sleep patterns
- 🧘 **Mental Health Coaches:** Early warning system for clients
- 🏢 **HR Teams:** Burnout tracking for remote employees
- 🧑‍💻 **Digital Detox Tools:** Trigger alerts or recommend breaks

## 🗂️ Repository Structure

| File | Description |
|------|-------------|
| `final_burnout_predictor.R` | R script with model training and evaluation |
| `digital_diet_mental_health.csv` | Cleaned dataset from Kaggle |
| `README.md` | This file |
| (Optional) `predictor.Rmd` | Notebook-style documentation (if rendered)

## 📦 How to Run

```r
# Install required packages (if not already installed)
install.packages(c("xgboost", "caret", "tidyverse", "Matrix"))

# Open and run final_burnout_predictor.R in RStudio
# Review printed confusion matrix and RMSE
```

## 📈 Next Steps
- Visualize top contributing features using `xgb.importance()`
- Deploy as a REST API or Shiny app
- Translate to Python + Streamlit version for interactive demo
- Use SHAP values to explain model predictions per user

## 👤 Author
**Abhigna Valambatla**  
M.S. in Business Analytics  
University of New Hampshire  
📍 Durham, NH  
📫 [LinkedIn] https://www.linkedin.com/in/abhigna-valambatla-0a216a149/ ) | [GitHub](https://github.com/abhignav1/Mental_health)
