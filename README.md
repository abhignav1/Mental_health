# Burnout Risk Predictor

A machine learning model to detect early signs of digital fatigue and burnout using screen time, stress, sleep, and lifestyle habits. Designed for everyday use — by individuals, mental health professionals, or developers building wellness tools.

## Dataset Source

- Kaggle Dataset: Impact of Screen Time on Mental Health  
- Entries: 2,000 individuals  
- Features: Digital behavior, sleep quality, physical activity, mental health score, and more

## Problem Statement

Objective: Predict whether someone is at risk of mental burnout based on their daily habits.

```r
burnout_risk = ifelse(mental_health_score < 50, 1, 0)
```

This turns the problem into a binary classification task:  
1 = At risk, 0 = Not at risk

## Model Workflow

1. Feature Engineering:
   - Screen time per hour awake
   - Stress-to-sleep ratio
   - Screen-to-stress ratio

2. Model Selection:
   - Tested: Logistic Regression, Random Forest, XGBoost
   - XGBoost performed best in accuracy and interpretability

3. Inputs Used:
   - Screen time (hours/day)
   - Sleep duration and quality
   - Mood and stress levels
   - Exercise and mindfulness
   - Caffeine consumption

4. Output:
   - Simple prediction: "Yes" or "No" to burnout risk

## Model Performance

- Final model: XGBoost
- Accuracy on test set: ~51%
- Highlights:
  - Shows the complexity of mental health prediction
  - Performance can improve with deeper features or more nuanced scoring

## Who Can Use This?

- Individuals tracking mental wellness
- HR teams focused on employee wellbeing
- Therapists and coaches supporting clients
- Developers building wellness apps or self-care tools

## Why This Matters

"Screen time apps show numbers — this model interprets what those numbers mean for your mental health."

Burnout is real, and this project takes a step toward helping people understand their risk early. It bridges digital behavior with well-being in a meaningful way.

## Future Plans

- Add more behavioral data (like app categories, social media time)
- Deploy as a web-based wellness check-in tool
- Wrap the model into a REST API or mobile app feature

