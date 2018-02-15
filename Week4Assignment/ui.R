#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(caret)
data(iris)
validation_index <- createDataPartition(dataset$Species, p=0.80, list=FALSE) 

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Predict Horsepower from carburetors"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput("sliderCarburetors", "What is # Carburetors of the car?",
                  1, 8, value = 2),
      checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
      checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE),
      submitButton("Submit") # New!
    ),
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("plot1"),
      h3("Predicted Horsepower from Model 1: "),
      textOutput("pred1"),
      h3("Predicted Horsepower from Model 2: "),
      textOutput("pred2")
    )
  )
))
