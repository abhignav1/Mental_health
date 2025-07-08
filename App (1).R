
library(shiny)
library(xgboost)
library(caret)
library(Matrix)
library(data.table)
library(dplyr)

# Load model and combined preprocessing object
model <- xgb.load("xgb_model.model")
preprocessing <- readRDS("preprocessing.rds")
dummies_model <- preprocessing$dummies_model
keep_cols <- preprocessing$keep_cols

# Feature engineering function
feature_engineering <- function(data) {
  data <- data %>%
    mutate(
      screen_per_hour_awake = daily_screen_time_hours / (24 - sleep_duration_hours),
      stress_to_sleep_ratio = stress_level / (sleep_duration_hours + 1),
      screen_stress_ratio = daily_screen_time_hours / (stress_level + 1),
      caffeine_sleep_ratio = caffeine_intake_mg_per_day / (sleep_duration_hours + 1),
      digital_exhaustion = (daily_screen_time_hours + phone_usage_hours) * stress_level / (sleep_duration_hours + 1),
      wellbeing_score = mindfulness_minutes_per_day + physical_activity_hours_per_week - caffeine_intake_mg_per_day
    )
  return(data)
}

# UI
ui <- fluidPage(
  titlePanel("Digital Diet and Mental Health Predictor"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("screen", "Daily Screen Time (hours):", 5),
      numericInput("sleep", "Sleep Duration (hours):", 7),
      numericInput("stress", "Stress Level (0-100):", 50),
      numericInput("caffeine", "Caffeine Intake (mg/day):", 200),
      numericInput("phone", "Phone Usage (hours):", 3),
      numericInput("mindfulness", "Mindfulness Minutes per Day:", 10),
      numericInput("activity", "Physical Activity (hours/week):", 3),
      actionButton("predict", "Predict")
    ),
    
    mainPanel(
      verbatimTextOutput("result")
    )
  )
)

# Server
server <- function(input, output) {
  
  prediction <- eventReactive(input$predict, {
    # User input row
    user_data <- data.frame(
      daily_screen_time_hours = input$screen,
      sleep_duration_hours = input$sleep,
      stress_level = input$stress,
      caffeine_intake_mg_per_day = input$caffeine,
      phone_usage_hours = input$phone,
      mindfulness_minutes_per_day = input$mindfulness,
      physical_activity_hours_per_week = input$activity,
      age = 30,
      gender = "Other",
      laptop_usage_hours = 2,
      tablet_usage_hours = 1,
      tv_usage_hours = 2,
      social_media_hours = 2,
      work_related_hours = 4,
      entertainment_hours = 2,
      gaming_hours = 1,
      sleep_quality = "Average",
      mood_rating = 5,
      location_type = "Urban",
      mental_health_score = 50,
      uses_wellness_apps = "No",
      eats_healthy = "Sometimes",
      weekly_anxiety_score = 10,
      weekly_depression_score = 10,
      stringsAsFactors = FALSE
    )
    
    # Add dummy row to preserve factor levels
    dummy_row <- user_data
    dummy_row$gender <- "Male"
    dummy_row$sleep_quality <- "Poor"
    dummy_row$location_type <- "Rural"
    dummy_row$uses_wellness_apps <- "Yes"
    dummy_row$eats_healthy <- "Often"
    
    # Combine and engineer features
    combined_data <- rbind(user_data, dummy_row)
    combined_data <- feature_engineering(combined_data)
    
    # One-hot encode
    encoded <- predict(dummies_model, newdata = combined_data) %>% as.data.frame()
    encoded <- encoded[1, , drop = FALSE]  # Keep only the user row
    
    # Add missing columns with 0s
    missing_cols <- setdiff(keep_cols, colnames(encoded))
    for (col in missing_cols) {
      encoded[[col]] <- 0
    }
    
    # Reorder columns to match training
    encoded <- encoded[, keep_cols, drop = FALSE]
    
    # Predict
    dnew <- xgb.DMatrix(data = as.matrix(encoded))
    pred_score <- predict(model, dnew)
    pred_class <- ifelse(pred_score < 50, "At Risk", "Not at Risk")
    
    list(score = pred_score, class = pred_class)
  })
  
  output$result <- renderPrint({
    req(prediction())
    cat("Predicted Burnout Score:", round(prediction()$score, 2), "\n")
    cat("Mental Health Risk Level:", prediction()$class)
  })
}

# Run the app
shinyApp(ui = ui, server = server)
