---
title: "Sharing your models with Shiny"
author: "Peter Higgins"
output: html_document
editor_options: 
  markdown: 
    wrap: sentence
---



# Sharing Models with Shiny

In this chapter we will practice Sharing your predictive models with Shiny Apps for research or clinical use.

### Packages Needed for this Chapter

This chapter will require {tidyverse}. {medicaldata}, {shiny}, and {mlbench} packages. You may already have these packages installed. If not, these can be installed with the code below if you copy the code chunk to your RStudio Console pane and run these installation functions.


``` r
# Install the packages below if you do not have these already installed.
install.packages('tidyverse')
install.packages('medicaldata')
install.packages('shiny')
install.packages('mlbench')
```

We will walk through how to do this for a few example models.

## Setting up and Saving Models

We will start by building and saving several models.
When needed, we can move these model objects (model.RDS) to the folder where the Shiny app will be located. For now, open an RStudio session in a directory where you can find the saved models, then copy and run the code chunks below to save the 3 models as `*.RDS` files.

### Linear Model

We will use one of the {medicaldata} datasets to build a linear model.
We will use the `supraclavicular` dataset to model the onset of sensory function after anesthesia in minutes, using treatment group as the main predictor, adjusted for age, bmi, and gender.

We will then save this linear model to an RDS file, using the `saveRDS()` function.


``` r
library(tidyverse)
library(medicaldata)
library(shiny)
supra_linear_model <- medicaldata::supraclavicular %>%
  lm(formula = onset_sensory ~ age + bmi + gender + group,
 data = .) 

saveRDS(supra_linear_model, "linear_model.RDS")
```

### Logistic Model

We will use the Pima Indian dataset from {mlbench} to build a logistic model.
We will classify individuals for the outcome of type 2 diabetes with 4 predictor variables.

We will then save this logistic model to an RDS file, using the `saveRDS()` function.


``` r
library(mlbench)
library(shiny)
data("PimaIndiansDiabetes2")
dm_logit_mod <- glm(diabetes ~ glucose + mass + pedigree + age, 
              data = PimaIndiansDiabetes2, 
              family = "binomial")

saveRDS(dm_logit_mod, "logit_model.RDS")
```

### Random Forest Model

We will also use the Pima Indian dataset from {mlbench} to build a random forest model with the {tidymodels} package.

This approach requires more steps, but is more flexible, as you can swap out the engine and its parameters, the pre-processing recipe, and (if needed) tune hyperparameters in the pipeline, allowing you to easily create and compare several versions of models.

We will again predict the outcome of diabetes with all of the predictor variables available.

We will then save this random forest model to an RDS file, using the `saveRDS()` function.


``` r
library(tidymodels)
library(mlbench)
data("PimaIndiansDiabetes2")
set.seed(123)
splits <- initial_split(PimaIndiansDiabetes2 %>% na.omit(), strata = diabetes)

dm_training <- training(splits)
dm_testing <- testing(splits)


dm_rf_mod <- rand_forest(mtry = 4, min_n = 2, trees = 500) %>% 
  set_engine("ranger", num.threads = 8) %>%
  set_mode("classification")

rf_recipe <- recipe(diabetes ~ ., data = dm_training) %>% 
  step_zv(all_predictors()) %>% 
  step_normalize(all_predictors())
  
rf_workflow <- workflow() %>% 
  add_model(dm_rf_mod) %>% 
  add_recipe(rf_recipe)

rf_fit <- rf_workflow %>% 
  fit(data = dm_training)

# predict(rf_fit, dm_testing, type = "prob")

# augment(rf_fit, dm_testing)

saveRDS(rf_fit, "rf_model.RDS")
```

## Building a Shiny App for the Linear Model

### The Default Shiny App
Let's start by opening a default Shiny app using the 'Old Faithful' template.
This will build an app.R web app in a folder.
We will need to move the file `linear.RDS` to this folder to have access to the model.

To set up the default Shiny App, open a new RStudio session.

Then

-   Select: File/New File/Shiny Web App.

-   Give the Application a name, like `linear-model`, leave the default structure (Single File app.R), and

-   Select the directory to save it in (I put it into my `experiments` directory), then

-   Click on the `Create` button.

Now go to your file manager for your computer, and find the file named "linear_model.RDS", and copy/paste/move it into your `linear-model` folder.

Now your Shiny app will have access to the model.

We will now edit the "Old Faithful" Shiny app to turn it into the Linear Model Shiny app that we want. Having the structure in place and editing piece by piece is pretty helpful. Let's go step by step.

:::warning
Editing and coding in Shiny apps can be frustrating at first, as the structure is very particular, and a bit persnickety. Every comma, parenthesis, and curly brace is there for a reason, and it is very easy to get these wrong. It is very helpful to
1. Have the rainbow parentheses option turned on in your version of RStudio. You can turn this on with Tools/Global Options/Code/Display and select the checkbox for Rainbow Parentheses. When this is on, paired parentheses are color-matched, and when you reach the red close-parenthesis, you know you have closed all of the open expressions. 
2. Watch your commas - you will need one between each input, but no comma after the last input.
3. Watch the red dot Xs at the left side of your code. Hover over these to help figure out what is wrong, and how to fix it.
4. If you are totally stuck, there are several Solution buttons to bail you out.
5. Don't get down on yourself if you are struggling with Shiny - the syntax is hard when you are getting started, and the details of parentheses, curly braces, and commas are fairly unforgiving. Keep plugging away - you will get this working!
:::


1. Find and run the app.R file in the linear-model folder. This should produce the "Old Faithful" histogram, where x is the waiting time in minutes to the next eruption.
2. Close the shiny app, and go to the app.R file. In the ui section, Change the title from "Old Faithful Geyser Data to "Linear Model Predictions for Supraclavicular Anesthesia".
3. Reload/Run the App to make sure this worked, and nothing else broke.

### Editing the **ui** *sidebarPanel* for the Input Predictor Variables

4. The linear model for predicting onset of sensory function has 4 predictors: group, gender, age, and bmi. The group value can be 1 or 2, the gender 0 or 1, the BMI ranges from 19-44, and the age ranges from 18 to 74 in the supraclavicular dataset.
5. In the ui sidebarPanel section, replace the sliderInput for bins with one for BMI, with the appropriate range, and a default value of 32. Re-run the app to make sure that worked. Note that the mainPanel will now fail, without the "bins" input. That is OK.
6. In the ui sidebarPanel section, copy/paste to add a similar sliderInput for age from 18 to 74, with a default of 40. Make sure you have a comma between each Input. Check to make sure you have parentheses and commas in all the right places. Feel free to undo (Cmd-Z or control-Z to start over).
7. In the ui sidebarPanel section, add a comma, then a new selectInput for the group variable, with choices of 1 and 2. Instead of min, max, and value, you will need `choices = list(1,2)`. Test run the App again.
8. Copy/paste to add a similar selectInput for gender, with values of 0 and 1. Don't forget the comma between Inputs. Test run the App again.
9. Now add (before the first sliderInput) a header for your sidebar, with a line for `h3("Input Values")`. Be sure to follow this with a comma before the first Input. Test run the App again.

If your version is not working, check the Solution button below and compare it to your code for the ui section. You should have 5 distinct entries in the sidebarPanel - one h3 title, and 4 Inputs.


<div class='webex-solution'><button>Solution</button>


``` r
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
           plotOutput("distPlot")
        )
    )
)
```


</div>


Now we have the inputs all set in the sidebarPanel. Let's take these 4 inputs (and the model) to the server section, and set it up to make predictions.

### Editing the *server* section to make Predictions

Scroll down to the **server** section of app.R.
Now delete everything from `output$distPlot` to the `})` at the end,
before the final curly brace `}` - leave that one in place.

Now you should have several lines of open space between the two curly braces.

The server section will generate predictions in 4 steps, two of which are reactive to inputs.

1. For step 1, we will read in the model. Copy this line of code into the server section: `model <- readRDS("linear_model.RDS")`. This just reads the model object in, and stores it in the variable `model`. No inputs yet. Run the app again to make sure it works.

2. For step 2, we will read in the input values, and store them as a dataframe. These have to be wrapped in `reactive({ })` as they are reacting to inputs. Paste this code chunk into the server section next:


``` r
input_df <- reactive({
      data.frame(bmi = input$bmi,
               age = input$age,
               group = as.double(input$group),
               gender = as.double(input$gender))
      })
```
Notice that the drop-down choice values have to be converted to doubles, which is their data type in the original dataset for modeling. This creates a function *input_df()* that we can use in the prediction step. Run the app again to make sure it works.

3. For step 3, we will make the predictions. We will use the model and *input_df*. Again, this is reactive to the input values, so we will wrap the predict() function in `reactive({ })`. We will use `input_df()` with parentheses, like a function, as it had reactive inputs. Then we will assign this result to pred. Paste the code chunk below into the server section next.


``` r
    pred <- reactive({
      predict(model, input_df())
      })
```
Run the app again to make sure it works.

4. For step 4, we will render the prediction to HTML text for display in the mainPanel of the ui, and assign it to `output$pred`. Again, because `pred` had reactive inputs, we use it as `pred()` inside the `renderText({ })` function.


``` r
    output$pred <- renderText({pred()})
```
Run the app again to make sure it works. Now you should have an output$pred to display in the ui.

If your version of the server section is not working, check the Solution button below and compare it to your code for the ui section. You should have 4 distinct entries in the server section - the model, the input_df, pred, and output$pred.


<div class='webex-solution'><button>Solution</button>


``` r
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
```


</div>


### Editing the mainPanel in the ui section to display your Prediction

Now we just have to show the text in `output$pred`. Scroll up to the ui section, and find the mainPanel. We will just put in some introductory text, followed by a blank line (line break), and then use a textOutput() function to show the prediction ("pred"). Copy and paste the code chunk below into the mainPanel.


``` r
 h3("The predicted onset of sensory perception in minutes is:"),
          br(),
          textOutput("pred")
```

Now run the app.R one more time.

If all went well, you should now have a linear model Shiny app that predicts (with default values) the return of sensory function after supraclavicular anesthesia in 10.63524 minutes. You can test different inputs to see their effects on the predicted time of onset of sensory function.

## Building a Shiny App for the Logistic Model

Now we will turn to the logistic model for predicting the diagnosis of diabetes. Not surprisingly, serum glucose (from 44-199) will be an important predictor. We will use the logistic diabetes model that we created at the beginning of this chapter. The other 3 predictors we will use are named mass (BMI, from 18-67), pedigree (a score for diabetes frequency in ancestors), and age in years (range 21-81).

### The Default Shiny App

Again, we will start by opening a default Shiny app using the 'Old Faithful' template.
This will build an app.R web app in a folder.
We will need to move the file `logit_model.RDS` to this folder to have access to the model.

To set up the default Shiny App, open a new RStudio session.

Then

-   Select: File/New File/Shiny Web App.

-   Give the Application a name, like `logistic-model`, leave the default structure (Single File app.R), and

-   Select the directory to save it in (I put it into my `experiments` directory), then

-   Click on the `Create` button.

Now go to your file manager for your computer, and find the file named "logit_model.RDS", and copy/paste/move it into your `logistic-model` folder.

Now your Shiny app will have access to the model.

We will now edit the "Old Faithful" Shiny app to turn it into the Linear Model Shiny app that we want. Having the structure in place and editing piece by piece is pretty helpful. Let's go step by step.


1. Find and run the app.R file in the logistic-model folder. This should produce the "Old Faithful" histogram, where x is the waiting time in minutes to the next eruption.
2. Close the shiny app, and go to the app.R file. In the ui section, Change the title from "Old Faithful Geyser Data to "Logistic Model Predictions for Diabetes".
3. Reload/Run the App to make sure this worked, and nothing else broke.

### Editing the **ui** *sidebarPanel* for the Input Predictor Variables

4. The logistic model for classifying individuals into type 2 diabetes vs not diabetes has 4 predictors: glucose, mass (bmi), predigree (score), and mass (actually BMI) These values all have the data type of numeric double.

5. Scroll to the ui sidebarPanel section, and replace the sliderInput for bins with one for glucose, with a helpful label to guide users to enter the glucose value, with the appropriate range of 44-199, and a default value of 125. Re-run the app to make sure that worked. Note that the mainPanel will now fail, without the "bins" input. That is OK.

6. Using this example, copy/paste the sliderInput to create input widgets for mass (range 18-67), age (range 21-81), and pedigree (score range 0.8-2.4). Pick your own user-facing labels and default values. Make sure that you have a comma between each sliderInput, but not one at the end. Re-run the app after you add each sliderInput to make sure everything still works. If you have done everything right, you should have 4 usable sliderInputs.

If you are having a hard time, compare your ui section code to the code chunk Solution below.


<div class='webex-solution'><button>Solution</button>


``` r
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
           plotOutput("distPlot")
        )
    )
)
```


</div>


Now we have the inputs all set in the sidebarPanel. Let's take these 4 inputs (and the model) to the server section, and set it up to make predictions.

### Editing the *server* section to make Predictions

Scroll down to the **server** section of app.R.
Now delete everything from `output$distPlot` to the `})` at the end,
before the final curly brace `}` - leave that one in place.

Now you should have several lines of open space between the two curly braces. Add a few blank lines if you need more room.

The server section will generate predictions in 4 steps, two of which are reactive to inputs.

1. For step 1, we will read in the model. Copy this line of code into the server section: `model <- readRDS("logit_model.RDS")`. This just reads the model object in, and stores it in the variable `model`. No inputs yet. Run the app again to make sure it works.

2. For step 2, we will read in the input values, and store them as a dataframe. These have to be wrapped in `reactive({ })` as they are reacting to inputs. Paste this code chunk into the server section next:


``` r
input_df <- reactive({
      data.frame(glucose = input$glucose)
      })
```

Now add 3 more lines to the data.frame() function, for `input$mass`, `input$age`, and `input$pedigree`. Assign these to the correct variable names, and use commas in the right places to complete the input_df. This creates a function *input_df()* that we can use in the prediction step. Run the app again to make sure it works.

3. For step 3, we will make the predictions. We will use the model and *input_df*. Again, this is reactive to the input values, so we will wrap the predict() function in `reactive({ })`. We will use `input_df()` with parentheses, like a function, as it had reactive inputs. To get probabilities (rather than logit units, the default prediction), we need to add the argument `type = "response"`. Then we will assign this result to pred. Paste the code chunk below into the server section next.


``` r
    pred <- reactive({
      predict(model, input_df(), type = "response")
      })
```
Run the app again to make sure it works.

4. For step 4, we will render the prediction to HTML text for display in the mainPanel of the ui, and assign it to `output$pred`. Again, because `pred` had reactive inputs, we use it as `pred()` inside the `renderText({ })` function.


``` r
    output$pred <- renderText({pred()})
```
Run the app again to make sure it works. Now you should have an output$pred to display in the ui.

If your version of the server section is not working, check the Solution button below and compare it to your code for the ui section. You should have 4 distinct entries in the server section - the model, the input_df, pred, and output$pred.


<div class='webex-solution'><button>Solution</button>


``` r
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
```


</div>


### Editing the mainPanel in the ui section to display your Prediction

Now we just have to show the prediction text in the mainPanel. Scroll up to the ui section, and find the mainPanel. Now just put in some introductory text about the probability of type 2 diabetes formatted in the header3 level with `h3("Text"`), followed by a blank line (line break - `br()`), and then use a textOutput() function to show the prediction ("pred"). 

If you are having a hard time, you can check the Solution below


<div class='webex-solution'><button>Solution</button>



``` r
mainPanel(
          h3("The predicted probability of type 2 diabetes is:"),
          br(),
          textOutput("pred")
)
```


</div>


Now run the app.R one more time.

If all went well, you should now have a logistic model Shiny app that predicts (with default values) the probability of type 2 diabetes as 0.8304044. You can test different inputs to see their effects on the predicted probability of type 2 diabetes.


## Building a Shiny App for the Random Forest Model


:::tryit
## Challenge Yourself

1. How would you use the linear model predictions to plot these predictions compared to all of the other observations in the dataset? (Hint: augment the dataset with broom::augment predictions for each observation, then plot these with gray dots, and use the input data to make a new prediction plotted with a colored dot)

2. How would you add confidence intervals to your predictions, and how would you add these to your displayed output in the mainPanel?

:::
