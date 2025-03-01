---
title: "Linear Regression and Broom for Tidying"
author: "Peter Higgins"
output: html_document
editor_options: 
  markdown: 
    wrap: sentence
---



# Linear Regression and Broom for Tidying Models

Linear regression allows you to:

1.  estimate the effects of predictors (independent variables) on an outcome (dependent variable), assuming that there is a linear relationship

2.  Make predictions about future cases (patients) with their measured predictors on this continuous outcome.

Let's look at a simple linear model to predict annual health care expenses.
![shinyapp linear regression](images/shinyapp_hc_expenses.png)


``` r
library(tidyverse)
library(mlbench)
library(broom)
library(cutpointr)
```

```
## 
## Attaching package: 'cutpointr'
```

```
## The following object is masked from 'package:bayestestR':
## 
##     auc
```

``` r
library(janitor)
library(easystats)
library(medicaldata)

dm_data <- data("PimaIndiansDiabetes2", package = "mlbench")

# build model, all variables
dm_mod <- glm(diabetes ~ ., 
              data = PimaIndiansDiabetes2, 
              family = "binomial")
# output
summary(dm_mod)
```

```
## 
## Call:
## glm(formula = diabetes ~ ., family = "binomial", data = PimaIndiansDiabetes2)
## 
## Coefficients:
##                Estimate  Std. Error z value
## (Intercept) -10.0407392   1.2176743  -8.246
## pregnant      0.0821594   0.0554255   1.482
## glucose       0.0382695   0.0057677   6.635
## pressure     -0.0014203   0.0118334  -0.120
## triceps       0.0112214   0.0170837   0.657
## insulin      -0.0008253   0.0013064  -0.632
## mass          0.0705376   0.0273421   2.580
## pedigree      1.1409086   0.4274337   2.669
## age           0.0339516   0.0183817   1.847
##                         Pr(>|z|)    
## (Intercept) < 0.0000000000000002 ***
## pregnant                 0.13825    
## glucose          0.0000000000324 ***
## pressure                 0.90446    
## triceps                  0.51128    
## insulin                  0.52757    
## mass                     0.00989 ** 
## pedigree                 0.00760 ** 
## age                      0.06474 .  
## ---
## Signif. codes:  
## 0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 498.10  on 391  degrees of freedom
## Residual deviance: 344.02  on 383  degrees of freedom
##   (376 observations deleted due to missingness)
## AIC: 362.02
## 
## Number of Fisher Scoring iterations: 5
```

``` r
#tidy version
tidy(dm_mod)
```

```
## # A tibble: 9 × 5
##   term          estimate std.error statistic  p.value
##   <chr>            <dbl>     <dbl>     <dbl>    <dbl>
## 1 (Intercept) -10.0        1.22       -8.25  1.64e-16
## 2 pregnant      0.0822     0.0554      1.48  1.38e- 1
## 3 glucose       0.0383     0.00577     6.64  3.24e-11
## 4 pressure     -0.00142    0.0118     -0.120 9.04e- 1
## 5 triceps       0.0112     0.0171      0.657 5.11e- 1
## 6 insulin      -0.000825   0.00131    -0.632 5.28e- 1
## 7 mass          0.0705     0.0273      2.58  9.89e- 3
## 8 pedigree      1.14       0.427       2.67  7.60e- 3
## 9 age           0.0340     0.0184      1.85  6.47e- 2
```

``` r
# model performance
glance(dm_mod)
```

```
## # A tibble: 1 × 8
##   null.deviance df.null logLik   AIC   BIC deviance
##           <dbl>   <int>  <dbl> <dbl> <dbl>    <dbl>
## 1          498.     391  -172.  362.  398.     344.
## # ℹ 2 more variables: df.residual <int>, nobs <int>
```

``` r
# augment data with fitted predictions and residuals
dm_data_plus <- augment(dm_mod) %>% 
  mutate(pct_prob = 100 * plogis(.fitted)) %>% 
  relocate(diabetes, .fitted, pct_prob) %>% 
  arrange(-.fitted)

# select a cut point for classification
cp <- dm_data_plus %>% 
  cutpointr(pct_prob, diabetes,
            pos_class = "pos",
            method= maximize_metric,
            metric = sum_sens_spec)
```

```
## Assuming the positive class has higher x values
```

``` r
cp
```

```
## # A tibble: 1 × 16
##   direction optimal_cutpoint method          sum_sens_spec
##   <chr>                <dbl> <chr>                   <dbl>
## 1 >=                 28.5839 maximize_metric       1.57504
##        acc sensitivity specificity      AUC pos_class
##      <dbl>       <dbl>       <dbl>    <dbl> <chr>    
## 1 0.772959    0.830769    0.744275 0.862361 pos      
##   neg_class prevalence outcome  predictor data              
##   <fct>          <dbl> <chr>    <chr>     <list>            
## 1 neg         0.331633 diabetes pct_prob  <tibble [392 × 2]>
##   roc_curve             boot 
##   <list>                <lgl>
## 1 <rc_ctpnt [393 × 10]> NA
```

``` r
summary(cp)
```

```
## Method: maximize_metric 
## Predictor: pct_prob 
## Outcome: diabetes 
## Direction: >= 
## 
##     AUC   n n_pos n_neg
##  0.8624 392   130   262
## 
##  optimal_cutpoint sum_sens_spec   acc sensitivity
##           28.5839         1.575 0.773      0.8308
##  specificity  tp fn fp  tn
##       0.7443 108 22 67 195
## 
## Predictor summary: 
##     Data      Min.        5%   1st Qu.   Median     Mean
##  Overall 0.8690932  3.071251  8.953085 22.94296 33.16327
##      neg 0.8690932  2.674187  6.392249 13.48437 21.10577
##      pos 3.7635587 14.863216 34.854283 62.18036 57.46376
##   3rd Qu.      95%     Max.       SD NAs
##  53.11714 88.92870 99.46861 28.45645   0
##  28.96611 69.31582 97.91551 20.49784   0
##  80.93884 92.17256 99.46861 26.71998   0
```

``` r
plot(cp)
```

<img src="io23-linear-regression_files/figure-html/unnamed-chunk-1-1.png" width="672" />

``` r
plot_metric(cp)
```

<img src="io23-linear-regression_files/figure-html/unnamed-chunk-1-2.png" width="672" />

``` r
# classify based on cut point
dm_data_plus <- dm_data_plus %>% 
  mutate(pred_yes_dm = 
  case_when(pct_prob > cp$optimal_cutpoint ~ "pred_yes_dm", 
            TRUE ~ "pred_no")) %>% 
  relocate(pred_yes_dm, .after =pct_prob)

# check confusion matrix
dm_data_plus %>% 
  tabyl(diabetes, pred_yes_dm) %>% 
  adorn_totals("both") %>% 
  adorn_percentages() %>% 
  adorn_pct_formatting()
```

```
##  diabetes pred_no pred_yes_dm  Total
##       neg   74.4%       25.6% 100.0%
##       pos   17.7%       82.3% 100.0%
##     Total   55.6%       44.4% 100.0%
```

``` r
#check model performance
performance::check_model(dm_mod, panel = FALSE)
# use panel = TRUE in Rmarkdown to get 2x3 panels for 6 plots
# 
performance::model_performance(dm_mod)
```

```
## # Indices of model performance
## 
## AIC     |    AICc |     BIC | Tjur's R2 |  RMSE | Sigma
## -------------------------------------------------------
## 362.021 | 362.492 | 397.763 |     0.364 | 0.376 | 1.000
## 
## AIC     | Log_loss | Score_log | Score_spherical |   PCP
## --------------------------------------------------------
## 362.021 |    0.439 |   -74.015 |           0.009 | 0.718
```

``` r
#try a different model
dm_mod2 <- glm(diabetes ~ glucose + mass + pedigree + age, 
              data = PimaIndiansDiabetes2, 
              family = "binomial")

# build a really simple (NULL) model as a baseline

dm_mod3 <- glm(diabetes ~ 1,
                 data = PimaIndiansDiabetes2, 
              family = "binomial")

summary(dm_mod3)
```

```
## 
## Call:
## glm(formula = diabetes ~ 1, family = "binomial", data = PimaIndiansDiabetes2)
## 
## Coefficients:
##             Estimate Std. Error z value            Pr(>|z|)
## (Intercept) -0.62362    0.07571  -8.237 <0.0000000000000002
##                
## (Intercept) ***
## ---
## Signif. codes:  
## 0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 993.48  on 767  degrees of freedom
## Residual deviance: 993.48  on 767  degrees of freedom
## AIC: 995.48
## 
## Number of Fisher Scoring iterations: 4
```

``` r
# compare models
# compare_performance(dm_mod, dm_mod2, dm_mod3, rank = TRUE)

# plot(compare_performance(dm_mod, dm_mod2, dm_mod3, rank = TRUE)) + labs(subtitle = "Larger Area is Better")

# plot(compare_performance(dm_mod, dm_mod2, rank = TRUE)) + labs(subtitle = "Larger Area is Better")

#test_performance(dm_mod, dm_mod2, dm_mod3)

# save model to RDS
saveRDS(dm_mod, "dm_mod.RDS")
```

This is a simple web application that lets users who are not familiar with R use your model.

They can enter values for the 3 predictor variables (gender, age, BMI) for a new patient, and predict their annual health insurance expenses in dollars.
This web app produces a table with the inputs, and shows the output when you click the PREDICT button.
Try it out here:

[Model Predictions Shiny Web App](https://pdrhiggins.shinyapps.io/model_predict/).

Enter different predictor data points, and recalculate the expenses.

You can click on the About tab for an explanation of the model, and even explore the publicly shared underlying code on GitHub (link in the About tab).

We will walk through how to build, test, and share your own models in this chapter.

## Packages needed

-   {tidyverse}
-   {medicaldata}
-   {broom}
-   {easystats} you can install this one (Not on CRAN) with `install.packages("easystats", repos = "https://easystats.r-universe.dev")`
-   {performance}
-   {insight}
-   {gtsummary}

Note that the base modeling function lm() comes from the {stat} package, which loads by default when you start R.

## Building a simple base model with {lm}

The simplest model is called the null model, with no predictors.
This model uses the mean value of the outcome to estimate it.

In the blood_storage (prostate cancer) dataset in {medicaldata}, the mean time to recurrence is 32.92 months.

To build a simple null model, you will need two main arguments to the lm() function:

-   the **formula**

-   the **data**

The **formula** follows the format *dependent_variable* \~ *independent_variables.*

Note that the **data** argument is not the first argument, so it does ***not*** automatically play well with pipes.\
You can pipe in data if you make the data argument explicit, and set it to `data = .`

Let's look at a simple example:

Copy the code chunk below and run it in your RStudio Console.


``` r
medicaldata::blood_storage %>% 
  lm(TimeToRecurrence ~ NULL, data = .)
```

```
## 
## Call:
## lm(formula = TimeToRecurrence ~ NULL, data = .)
## 
## Coefficients:
## (Intercept)  
##       32.92
```

The output tells you the `Call` - the model being run, and then all the coefficients.
In the case of the NULL model, the only coefficient is the intercept.
This intercept is equal to the mean value of the outcome variable, TimeToRecurrence, in months.
With no other predictor variables, this is the best estimate available for time to recurrence.

We can also output the results as a nice tibble, using the *tidy()* function from the {broom} package.


``` r
medicaldata::blood_storage  %>% 
  lm(TimeToRecurrence ~ NULL, data = .) %>% 
  broom::tidy()
```

```
## # A tibble: 1 × 5
##   term        estimate std.error statistic  p.value
##   <chr>          <dbl>     <dbl>     <dbl>    <dbl>
## 1 (Intercept)     32.9      1.61      20.5 1.04e-59
```

This model has only one term, the intercept.
It estimates every value of time to recurrence with the mean, 32.91.
This is a pretty poor model, but is a place to start.\

\
Let's look at how good this model is, using another function from the {broom} package.
We can *glance()* our model, again output into a nice tibble.


``` r
medicaldata::blood_storage  %>% 
  lm(TimeToRecurrence ~ NULL, data = .) %>% 
  broom::glance()
```

```
## # A tibble: 1 × 12
##   r.squared adj.r.squared sigma statistic p.value    df
##       <dbl>         <dbl> <dbl>     <dbl>   <dbl> <dbl>
## 1         0             0  28.6        NA      NA    NA
## # ℹ 6 more variables: logLik <dbl>, AIC <dbl>, BIC <dbl>,
## #   deviance <dbl>, df.residual <int>, nobs <int>
```

The r.squared and adj.r.squared are both 0, so we are capturing none of the variation in the data with this null model.
The log likelihood is -1502, and the AIC 3009, and BIC 3016 (these are both high because this is a crummy model).

AIC is Akaike's Information Criterion, and estimates the out-of-sample prediction error and relative quality of a statistical model.
A higher number indicates more information lost.
Lower numbers for AIC = higher quality models.

BIC is the Bayesian Information Criterion, which like AIC, penalizes models for the number of parameters to reduce overfitting.
BIC also considers the number of observations in the data, which AIC does not.
Lower values of BIC are better, and BIC is generally always higher than AIC, but absolute values do not matter, only relative values when comparing models on the same dataset for the same outcome.
If we improve the model (with useful predictor variables), the BIC should go down.

Let's add some predictors: Age, TVol (tumor volume), and sGS (surgical Gleason score), and see if we do better.


``` r
medicaldata::blood_storage  %>% 
  lm(TimeToRecurrence ~  Age + TVol + sGS, data = .) %>% 
  broom::glance()
```

```
## # A tibble: 1 × 12
##   r.squared adj.r.squared sigma statistic p.value    df
##       <dbl>         <dbl> <dbl>     <dbl>   <dbl> <dbl>
## 1    0.0130       0.00334  28.5      1.34   0.260     3
## # ℹ 6 more variables: logLik <dbl>, AIC <dbl>, BIC <dbl>,
## #   deviance <dbl>, df.residual <int>, nobs <int>
```

We are now explaining some (about 0.33% = 100\*the adjusted R-squared) of the variation with this predictor, and the log likelihood (-1472) got closer to zero, and the AIC (2954) and BIC (2972) were reduced, showing that this is a better model than the NULL model (though still not great).

#### Key Takeaways

-   use *lm()* to build the model

-   argument: formula = outcome \~ predictor1 + predictor2 + ...

-   argument: data = .
    with the pipe

-   tidy() from {broom} to see the model table of estimates

-   glance() from {broom}to see measures of model accuracy

#### Your turn with licorice!

Pipe the licorice data into an lm() function, with a formula argument and the data = .
argument.
Use the outcome of pacu30min_throatPain.
Use predictors like intraOp_surgerySize, treat, preOp_pain, preOp_gender, and preOp_smoking.

Then pipe the result into the function tidy() to see the model, and (separately) into the function glance() to evaluate the model quality.

Copy the code chunk below into RStudio as a start.
Use *tidy()* to see the model table, and *glance()* to look at the performance of the model.


``` r
medicaldata::licorice_gargle %>%
  lm(formula = pacu30min_throatPain ~ var1 + var2 + var3,
 data = .) 
```


<div class='webex-solution'><button>Show the solution</button>



``` r
medicaldata::licorice_gargle %>%
  lm(formula = pacu30min_throatPain ~ intraOp_surgerySize  +
       treat + preOp_pain + preOp_gender + 
       preOp_smoking,
       data = .) %>% 
  tidy()
```

```
## # A tibble: 6 × 5
##   term                estimate std.error statistic   p.value
##   <chr>                  <dbl>     <dbl>     <dbl>     <dbl>
## 1 (Intercept)           0.376     0.365      1.03  0.304    
## 2 intraOp_surgerySize   0.316     0.143      2.21  0.0283   
## 3 treat                -0.690     0.154     -4.48  0.0000117
## 4 preOp_pain            1.96      0.835      2.35  0.0197   
## 5 preOp_gender         -0.265     0.160     -1.65  0.100    
## 6 preOp_smoking         0.0652    0.0956     0.682 0.496
```

``` r
medicaldata::licorice_gargle %>%
  lm(formula = pacu30min_throatPain ~ intraOp_surgerySize  +
       treat + preOp_pain + preOp_gender + 
       preOp_smoking,
       data = .) %>% 
  glance()
```

```
## # A tibble: 1 × 12
##   r.squared adj.r.squared sigma statistic    p.value    df
##       <dbl>         <dbl> <dbl>     <dbl>      <dbl> <dbl>
## 1     0.143         0.124  1.17      7.59 0.00000130     5
## # ℹ 6 more variables: logLik <dbl>, AIC <dbl>, BIC <dbl>,
## #   deviance <dbl>, df.residual <int>, nobs <int>
```


</div>


#### Interpreting the Model Estimates

For the full model with 5 predictors (shown in the hidden solution above - Click the button to show it), you get a tidied tibble with 6 rows and 5 columns.
These are

-   The first column is the `term` - these include the (Intercept) and each of the predictors you called in the model.
-   the second column is the `estimate`. This is the point estimate of the effect of each predictor in the multivariable model. For the `intraOp_surgerySize` predictor, this is 0.316. This means that for each unit or level increase of `intraOp_surgerySize`, which is defined on a 1-3 scale from small to large, the `pacu_30min_throat pain` (on a 0-10 scale), increases by 0.316 points. So a large surgery (2 levels larger than small) will result in, on average, a `pacu_30min_throat pain` score 0.632 points higher than a small surgery.
-   similarly, the estimate for `preop_gender` is -0.265. This means that for each 1 point increase in the level of `preop_gender`, coded as 0=male, 1=female, the `pacu_30min_throat pain` score goes doen by -0.265 points. In this case, that means that the average `pacu_30min_throat pain` score in females was 0.265 points lower than in males.
-   the std.error column tells you about the variance of this estimate, and can help you calculate confidence intervals around the point estimated if needed.
-   the statistic is the t value for the estimate, which allows you to calculate p values with a t test. Values with a large absolute value (farther from zero) imply a stronger effect. Values of the statistic \> 1.96 (absolute value) correspond to a p value \< 0.05.
-   the p value is the significance of the estimate for that particular predictor variable. Low values (often \< 0.05) are considered significant for traditional, historical reasons (it is an arbitrary cutoff).

##### Check your work:

For the full model with 5 predictors, the which predictor variable has the largest estimated effect on `pacu30min_throatpain`?

<select class='webex-select'><option value='blank'></option><option value=''>intraOp_surgerySize</option><option value='answer'>preOp_pain</option><option value=''>genderFemale</option><option value=''>smoking</option><option value=''>treatLicorice</option></select>

For the full model with 5 predictors, what is the BIC value (using the glance function)?

<select class='webex-select'><option value='blank'></option><option value=''>-364</option><option value='answer'>765</option><option value=''>309</option><option value=''>741</option><option value=''>7</option></select>

#### Your turn with supra!

Use the **supraclavicular** dataset to build a model with the outcome `onset_sensory`, with predictors (independent variables) age, bmi, gender, and group.

Output the regression table with *tidy()* and the model measures with *glance()* 

Copy the code chunk below into RStudio as a start


``` r
medicaldata::supraclavicular %>%
  lm(formula = onset_sensory ~ var1,
 data = .) %>% 
  glance()
```


<div class='webex-solution'><button>Show Solution</button>



``` r
medicaldata::supraclavicular %>%
  lm(formula = onset_sensory ~ age + bmi + gender + group,
 data = .) %>% 
  glance()
```

```
## # A tibble: 1 × 12
##   r.squared adj.r.squared sigma statistic p.value    df
##       <dbl>         <dbl> <dbl>     <dbl>   <dbl> <dbl>
## 1    0.0356      -0.00504  11.5     0.876   0.481     4
## # ℹ 6 more variables: logLik <dbl>, AIC <dbl>, BIC <dbl>,
## #   deviance <dbl>, df.residual <int>, nobs <int>
```


</div>


##### For the full model with 4 predictors, what is the Adjusted R squared value?

<select class='webex-select'><option value='blank'></option><option value=''>0.036</option><option value=''>301.7</option><option value=''>-383.3</option><option value=''>0.48</option><option value='answer'>-0.005</option></select>

### Producing manuscript-quality tables with {gtsummary}

Let's take your model above, and rather than pipe it into tidy() or glance(), pipe it into the *tbl_regression()* function from the {gtsummary} package.


``` r
medicaldata::supraclavicular %>%
  lm(formula = onset_sensory ~ age + bmi + gender + group,
 data = .) %>% 
  tbl_regression()
```

```{=html}
<div id="pwixlvdepq" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#pwixlvdepq table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#pwixlvdepq thead, #pwixlvdepq tbody, #pwixlvdepq tfoot, #pwixlvdepq tr, #pwixlvdepq td, #pwixlvdepq th {
  border-style: none;
}

#pwixlvdepq p {
  margin: 0;
  padding: 0;
}

#pwixlvdepq .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#pwixlvdepq .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#pwixlvdepq .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#pwixlvdepq .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#pwixlvdepq .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#pwixlvdepq .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#pwixlvdepq .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#pwixlvdepq .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#pwixlvdepq .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#pwixlvdepq .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#pwixlvdepq .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#pwixlvdepq .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#pwixlvdepq .gt_spanner_row {
  border-bottom-style: hidden;
}

#pwixlvdepq .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#pwixlvdepq .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#pwixlvdepq .gt_from_md > :first-child {
  margin-top: 0;
}

#pwixlvdepq .gt_from_md > :last-child {
  margin-bottom: 0;
}

#pwixlvdepq .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#pwixlvdepq .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#pwixlvdepq .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#pwixlvdepq .gt_row_group_first td {
  border-top-width: 2px;
}

#pwixlvdepq .gt_row_group_first th {
  border-top-width: 2px;
}

#pwixlvdepq .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#pwixlvdepq .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#pwixlvdepq .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#pwixlvdepq .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#pwixlvdepq .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#pwixlvdepq .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#pwixlvdepq .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#pwixlvdepq .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#pwixlvdepq .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#pwixlvdepq .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#pwixlvdepq .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#pwixlvdepq .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#pwixlvdepq .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#pwixlvdepq .gt_left {
  text-align: left;
}

#pwixlvdepq .gt_center {
  text-align: center;
}

#pwixlvdepq .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#pwixlvdepq .gt_font_normal {
  font-weight: normal;
}

#pwixlvdepq .gt_font_bold {
  font-weight: bold;
}

#pwixlvdepq .gt_font_italic {
  font-style: italic;
}

#pwixlvdepq .gt_super {
  font-size: 65%;
}

#pwixlvdepq .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#pwixlvdepq .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#pwixlvdepq .gt_indent_1 {
  text-indent: 5px;
}

#pwixlvdepq .gt_indent_2 {
  text-indent: 10px;
}

#pwixlvdepq .gt_indent_3 {
  text-indent: 15px;
}

#pwixlvdepq .gt_indent_4 {
  text-indent: 20px;
}

#pwixlvdepq .gt_indent_5 {
  text-indent: 25px;
}

#pwixlvdepq .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#pwixlvdepq div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Characteristic</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="estimate"><span class='gt_from_md'><strong>Beta</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="conf.low"><span class='gt_from_md'><strong>95% CI</strong></span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="p.value"><span class='gt_from_md'><strong>p-value</strong></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left">age</td>
<td headers="estimate" class="gt_row gt_center">-0.02</td>
<td headers="conf.low" class="gt_row gt_center">-0.20, 0.15</td>
<td headers="p.value" class="gt_row gt_center">0.8</td></tr>
    <tr><td headers="label" class="gt_row gt_left">bmi</td>
<td headers="estimate" class="gt_row gt_center">0.00</td>
<td headers="conf.low" class="gt_row gt_center">-0.39, 0.38</td>
<td headers="p.value" class="gt_row gt_center">>0.9</td></tr>
    <tr><td headers="label" class="gt_row gt_left">gender</td>
<td headers="estimate" class="gt_row gt_center">3.0</td>
<td headers="conf.low" class="gt_row gt_center">-1.9, 7.8</td>
<td headers="p.value" class="gt_row gt_center">0.2</td></tr>
    <tr><td headers="label" class="gt_row gt_left">group</td>
<td headers="estimate" class="gt_row gt_center">2.4</td>
<td headers="conf.low" class="gt_row gt_center">-2.2, 7.1</td>
<td headers="p.value" class="gt_row gt_center">0.3</td></tr>
  </tbody>
  
  <tfoot class="gt_footnotes">
    <tr>
      <td class="gt_footnote" colspan="4"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span> <span class='gt_from_md'>CI = Confidence Interval</span></td>
    </tr>
  </tfoot>
</table>
</div>
```

This produces a nice looking table, suitable for Rmarkdown documents, with output to Word or Powerpoint.
You can even convert this to other formats:

-   to a tibble with *as_tibble()*

-   to a gt object with *as_gt()* then use gt formatting

-   to a flextable object with *as_flextable()* then add formatting with flextable

#### Takeaways for Linear Modeling

-   start with data - pipe into model lm(formula, data = .)

-   model can be piped into *tidy()* for an estimates table

-   model can be piped into *glance()* for measures of the model

-   model can be piped into *tbl_regression()* for a publication-quality table

## Is Your Model Valid?

Key assumptions of linear regression

1.  Homogeneity of variance (homoscedasticity): The error variance should be constant

2.  Linearity: the relationships between the predictors and the outcome variable should be linear

3.  Independence: The errors associated with one observation are not correlated with the errors of any other observation

4.  Normality: the errors should be normally distributed.
    Technically normality is necessary only for hypothesis tests to be valid.

These assumption can be checked easily with the {performance} package in the {easystats} meta-package ({tidyverse} is another meta-package of packages).

In the code chunk below, we assign the model to the object name `supra_model`, and then run `check_model` from the {performance} package.


``` r
supra_model <- medicaldata::supraclavicular %>%
  lm(formula = onset_sensory ~ age + bmi + gender + group,
 data = .) 

performance::check_model(supra_model, panel = FALSE)
```

This produces a nice set of six plots in the Plots tab) with some guidance in the subtitles on how to interpret the plots.

There is a less pretty version in base R, using `plot(model_name)`, which also works to produce four of these 6 plots.

You can also formally test for heteroscedasticity.

The variance of your residuals should be homogenous.


``` r
check_heteroscedasticity(supra_model)
```

```
## OK: Error variance appears to be homoscedastic (p = 0.427).
```

A green output that starts with `OK` for `check_heteroscedasticity`, indicating homoscedasticity (homgeneous residual variance), is good.

## Making Predictions with Your Model

We can use the linear model to make predictions about the individual observations in our data, or in future data.

Let's start with adding model predictions to each observation in our dataset.
This is often called the `training data` as it was the data the model was trained on.
You can add predictions (fitted results) to your dataframe with the *augment()* function from the {broom} package.
We `augment` this dataframe with the model predictions, and then `relocate` them to the beginning (leftmost columns) of the tibble.


``` r
supra_data_plus <-  augment(supra_model) %>% 
  relocate(onset_sensory, .fitted, .resid) %>% 
  arrange(-.fitted)
supra_data_plus
```

```
## # A tibble: 100 × 12
##    onset_sensory .fitted .resid .rownames   age   bmi gender
##            <dbl>   <dbl>  <dbl> <chr>     <dbl> <dbl>  <dbl>
##  1            19    16.5   2.46 52           18  22.1      1
##  2            10    16.5  -6.51 99           19  24.4      1
##  3            14    16.5  -2.50 24           19  25.1      1
##  4             4    16.5 -12.5  6            21  22.0      1
##  5             8    16.3  -8.30 87           28  30.4      1
##  6             9    16.3  -7.27 74           31  21.0      1
##  7             6    16.3 -10.3  19           28  39.8      1
##  8            39    16.2  22.8  39           31  29.6      1
##  9            38    16.2  21.8  48           32  24.4      1
## 10             3    16.2 -13.2  43           32  35.4      1
## # ℹ 90 more rows
## # ℹ 5 more variables: group <dbl>, .hat <dbl>,
## #   .sigma <dbl>, .cooksd <dbl>, .std.resid <dbl>
```

The dataframe `supra_data_plus` includes a prediction of the outcome (`.fitted`) for each observation.
We can compare these predictions to the outcome (`onset_sensory`) and see how the residuals (`.resid`) are calculated (`onset_sensory minus .fitted`).
The Cook's D variable (`.cooksd`) is a measure of how large the effect on the model would be if you deleted that particular observation.
Large values for Cook's distance sugest that these observations are outliers that pull the model in one direction (have high leverage), and indicate an influential data point.
Review any observation with a `.cooksd` \> 1 carefully.

### Predictions from new data

You can also input new observations (in a data frame) to the model, and predict the outcome for these observations.
First, we need to create a dataframe that matches the predictor variables for the supra_model.
You might get a dataframe of new observations from a colleague.
It is important that this is in the same format, with *exactly* the same variable names as the original data.


``` r
new_data <- tibble(age = c(27, 38, 51),
                   bmi = c(30.4, 34.2, 41.1),
                   gender = c(2, 1, 1),
                   group = c(2, 1, 2))
new_data
```

```
## # A tibble: 3 × 4
##     age   bmi gender group
##   <dbl> <dbl>  <dbl> <dbl>
## 1    27  30.4      2     2
## 2    38  34.2      1     1
## 3    51  41.1      1     2
```

To make predictions with the new data, you use the base {stats} function predict(), with arguments for the model, and the new data.


``` r
predict(object = supra_model, 
        newdata = new_data)
```

```
##        1        2        3 
## 19.27186 13.62400 15.77457
```

This gives us predictions for each of the 3 rows of the `new_data` dataframe, of the outcome `onset_sensory`.

## Choosing predictors for multivariate modeling -- testing, dealing with collinearity

interactions

### Challenges

## presenting model results with RMarkdown

### Challenges

## presenting model results with a Shiny App

### Challenges
