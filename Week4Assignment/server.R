#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
 mtcars$carb2 <- ifelse(mtcars$carb - 1 > 0, mtcars$carb - 1, 0)
 model1 <- lm(hp ~ mtcars$carb, data = mtcars)
 model2 <- lm(hp ~ mtcars$carb2 + mtcars$carb, data = mtcars)
 
 model1pred <- reactive({
   carbInput <- input$sliderCarburetors
   predict(model1, newdata = data.frame(carb = carbInput))
 })
 
 model2pred <- reactive({
   carbInput <- input$sliderCarburetors
   predict(model2, newdata = 
             data.frame(carb = carbInput,
                        carb2 = ifelse(carbInput - 1 > 0,
                                       carbInput - 1, 0)))
 })
 
 output$plot1 <- renderPlot({
 carbInput <- input$sliderCarburetors
   
 plot(mtcars$carb, mtcars$hp, xlab = "# Carburetors",
      ylab = "Horsepower", bty = "n", pch = 16, 
      xlim = c(10, 32), ylim = c(50, 350) )
 if(input$showModel1){
   abline(model1, col = "red", lwd = 2)
 }
 if(input$showModel2){
   model2lines <- predict(model2, newdata = data.frame(
     carburetor = 10:35, mpgsp = ifelse(10:32 - 20 > 0, 10:32 - 20, 0)
   ))
 lines(10:32, model2lines, col = "blue", lwd = 2)
 }
 legend(25, 250, c("Model 1 Prediction", "Model 2 Predition"), pch = 16,
        col = c("red", "blue"), bty = "n", cex = 1.2)
 points(mpgInput, model1pred(), col = "red", pch = 16, cex = 2)
 points(mpgInput, model2pred(), col = "blue", pch = 16, cex = 2)
 })
 output$pred1 <- renderText({
   model1pred()
 })
 
 output$pred2 <- renderText({
   model2pred()
 })
})
