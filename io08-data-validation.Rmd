---
title: "Data Validation in R"
author: "Peter Higgins"
output: html_document
---


# Checking, Validating, And Asserting things about your Data


So you have imported your data!
Great!
Now to start the analysis!    

Not so fast, cowboy!    
First you need to validate your data.

## Why Spend Time Validating Your Data?
It is much more exciting to make plots, to make interactive Shiny apps of your models to share on the web, and to knit your Markdown documents to Word or PDF. <br>
<br>
But it turns out that most of the truly heinous, embarrassing errors in medical data analysis occur during the process of **data wrangling**. <br>
<br>
Imagine being the star of some of these sordid tales. <br>
<br>
After publishing a paper in JAMA in 2019, the authors share their SAS code on Github, and an interested critic noticed that they listed data for 73,000 kidney transplants in the US in one year. But someone familiar with the UNOS data knew that there are about 280,000 kidney transplants per year. During a merge step between two databases, SAS silently over-wrote much of the original data. This discovery led to a retraction of the paper and re-analysis, demonstraing a much smaller effect size. (Gander  JC, Zhang  X, Ross  K,  et al.  _Association between dialysis facility ownership and access to kidney transplantation_.  Retracted and replaced April 21, 2020. JAMA. 2019;322(10):957-973.) Twitter thread link here https://twitter.com/eric_weinhandl/status/1253127109830156289?s=20 <br>
<br>
After publishing a report of a randomized controlled trial in COPD in JAMA in 2018 (Aboumatar H, Naquibiddin M, Chung S,  et al.  _Effect of a Program Combining Transitional Care and Long-term Self-management Support on Outcomes of Hospitalized Patients With Chronic Obstructive Pulmonary Disease. A Randomized Clinical Trial_.  Retracted and replaced Nov 12, 2018. JAMA. 2018;320(22):2335-2343.), the authors realized that they had miscoded the treatment arms. For their logistic regression analysis, they had to recode the treatment arms from 1 and 2 to 0 and 1. Unfortunately, they flipped the values, and interpreted their results as beneficial. When they realized that the mis-coding changed the result from beneficial to harmful, they reported it to the journal and retracted the paper. <br>
<br>
After publishing a report on Best Practices for In-Hospital Cardiac Arrest in JAMA Cardiology, the authors found coding errors in their data. 9 hospitals of 130 had been misclassified, changing some of their associations. (https://jamanetwork.com/journals/jama/article-abstract/2764714) <br>
<br>
A med student analyzing a dataset for the first time uses boolean statements to categorize values. But she does not realize that this Stata dataset used "99" for missing values.

####	Cleaning – names with janitor package to snake_case

##### A few words about tidyverse style

####	Finding Missing data – naniar and visdat packages

####	Validating data – validate package

### Asserting properties of your data with assertr

####	Evaluating – str, glimpse

####	Exploring- skimr package

####	Histograms

####	Correlations – ggally extension of ggplot2, and corrr package
