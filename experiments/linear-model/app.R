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
    titlePanel("Linear Model Predictions for Supraclavicular Anesthesia"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
          h3("Input Values"),
            sliderInput("bmi",
                        "Select the BMI:",
                        min = 19,
                        max = 44,
                        value = 32),
            sliderInput("age",
                        "Select the Age:",
                        min = 18,
                        max = 74,
                        value = 40),
            selectInput("group",
                        "Select the Group:",
                        choices = list(1,2)),
            selectInput("gender",
                        "Select the Gender:",
                        choices = list(0,1))
        ),

        # Show a plot of the generated distribution
        mainPanel(
          h3("The predicted onset of sensory perception in minutes is:"),
          br(),
          textOutput("pred")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    model <- readRDS("linear_model.RDS")

    input_df <- reactive({
      data.frame(bmi = input$bmi,
               age = input$age,
               group = as.double(input$group),
               gender = as.double(input$gender))
      })

    pred <- reactive({
      predict(model, input_df())
      })

    output$pred <- renderText({pred()})

}

# Run the application
shinyApp(ui = ui, server = server)
