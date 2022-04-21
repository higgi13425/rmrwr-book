#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Logistic Model Predictions for Diabetes"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("glucose",
                        "Enter the glucose value:",
                        min = 44,
                        max = 199,
                        value = 125),
            sliderInput("mass",
                        "Enter the BMI:",
                        min = 18,
                        max = 67,
                        value = 42),
            sliderInput("age",
                        "Enter the age in years:",
                        min = 21,
                        max = 81,
                        value = 51),
            sliderInput("pedigree",
                        "Enter the pedigree score:",
                        min = 0.8,
                        max = 2.4,
                        value = 1.6)
        ),

        # Show a plot of the generated distribution
        mainPanel(
          h3("The predicted probability of type 2 diabetes is:"),
          br(),
          textOutput("pred")
    )
))

# Define server logic required to draw a histogram
server <- function(input, output) {

  model <- readRDS("logit_model.RDS")

  input_df <- reactive({
    data.frame(glucose = input$glucose,
               mass = input$mass,
               age = input$age,
               pedigree = input$pedigree)
  })

  pred <- reactive({
    predict(model, input_df(), type = "response")
  })

  output$pred <- renderText({pred()})

}

# Run the application
shinyApp(ui = ui, server = server)
