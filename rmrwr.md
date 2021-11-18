---
title: "Reproducible Medical Research with R"
author: "Peter D.R. Higgins, MD, PhD, MSc"
date: "2021-11-11"
site: bookdown::bookdown_site
output: bookdown::gitbook
documentclass: book
# bibliography: [book.bib, packages.bib]
# biblio-style: apalike
# link-citations: yes
github-repo: higgi13425/rmrwr-book
description: "This book is for anyone in the medical field interested in learning R to analyze available health data."
url: 'https\://rmrwr.netlify.com'
editor_options: 
  markdown: 
    wrap: sentence
---

# bibliography: [book.bib, packages.bib]

Placeholder


## Who This Book is For
## Prerequisites
## The Spiral of Success Structure
## Motivation for this Book
## The Scientific Reproducibility Crisis
## Features of a Bookdown electronic book
### Icons
### Sharing
### Scrolling/Paging
## What this Book is Not
### This Book is Not A Statistics Text
### This Book Does Not Provide Comprehensive Coverage of the R Universe
## Some Guideposts
## Helpful Tools
### Demonstrations in Flipbooks
### Learnr Coding Exercises
### Coding

<!--chapter:end:index.Rmd-->


# Getting Started and Installing Your Tools

Placeholder


## Goals for this Chapter
## Website links needed for this Chapter
## Pathway for this Chapter
## Installing R on your Computer
## Windows-Specific Steps for Installing R
### Testing R on Windows
## Mac-specific Installation of R
### Testing R on the Mac
### Successful testing!
## Installing RStudio on your Computer
### Windows Install of RStudio
### Testing Windows RStudio
### Installing RStudio on the Mac
### Testing the Mac Installation of RStudio
### Critical Setup - Tuning Your RStudio Installation
## Installing Git on your Computer
### Installing Git on macOS
### Installing Git on Windows
### Installing Git on Linux
## Getting Acquainted with the RStudio IDE

<!--chapter:end:io02-getting-started.Rmd-->


# A Tasting Menu of R

Placeholder


## Setting the Table
## Goals for this Chapter
## Packages needed for this Chapter
## Website links needed for this Chapter
## Setting up RPubs
## Open a New Rmarkdown document
## Knitting your Rmarkdown document
### Installing Packages
### Loading Packages with library()
## Your Turn to Write Text
## Wrangle Your Data
## Summarize Your Data
## Visualize Your Data
## Statistical Testing of Differences
## Publish your work to RPubs
## The Dessert Cart
### Interactive Plots
### Animated Graphics
### A Clinical Trial Dashboard
### A Shiny App
### An Example of Synergy in the R Community

<!--chapter:end:io03-tasting.Rmd-->


# Importing Your Data into R

Placeholder


## Reading data with the {readr} package
### Test yourself on scurvy
### What is a path?<br>
### Try it Yourself
## Reading Excel Files with readxl
### Test yourself on strep_tb
## Bringing in data from other Statistical Programs (SAS, Stata, SPSS) with the {haven} package
## Other strange file types with rio
## Data exploration with glimpse, str, and head/tail
### Taking a glimpse with *glimpse()*
### Try this out yourself.
### Test yourself on strep_tb
### Examining Structure with *str()*
### Test yourself on the scurvy dataset
### Examining a bit of data with *head()* and *tail()*
### Test yourself on the printing tibbles
## More exploration with skimr and DataExplorer
### Test yourself on the `skim()` results
### Test yourself on the `create_report()` results
## Practice loading data from multiple file types
## Practice saving (writing to disk) data objects in formats including csv, rds, xls, xlsx and statistical program formats
## How do readr and readxl parse columns?
## What are the variable types?
## Controlling Parsing
## Chapter Challenges
## Future forms of data ingestion

<!--chapter:end:io05-importing.Rmd-->


# Wrangling Rows in R with Filter

Placeholder


## Goals for this Chapter
## Packages needed for this Chapter
## Pathway for this Chapter
## Logical Statements in R
## Filtering on Numbers - Starting with A Flipbook
### Your Turn - learnr exercises
## Filtering on Multiple Criteria with Boolean Logic
### Your Turn - learnr exercises
## Filtering Strings
### Your Turn - learnr exercises
## Filtering Dates
### Your Turn - learnr exercises
## Filtering Out or Identifying Missing Data
### Working with Missing data
### Your Turn - learnr exercises
## Filtering Out Duplicate observations
## Slicing Data by Row
## Randomly Sampling Your Rows
### Your Turn - learnr exercises
## Further Challenges
## Explore More about Filtering

<!--chapter:end:io06a-filter.Rmd-->


# Interpreting Error Messages

Placeholder


## The Common Errors Table
## Examples of Common Errors and How to fix them
### Missing Parenthesis
### An Extra Parenthesis
### Missing pipe `%>%` in a data wrangling pipeline
### Missing + in a ggplot pipeline
### Pipe `%>%` in Place of a `+`
### Missing Comma Within a Function()
### A Missing Object
### One Equals Sign When you Need Two
### Non-numeric argument to a binary operator
## Errors Beyond This List
## When Things Get Weird
### Restart your R Session (Shift-Cmd-F10)
## References:

<!--chapter:end:io65-error_messages.Rmd-->


# The Building Blocks of R: data types, data structures, functions, and packages.

Placeholder


## Data Types
## Data Structures
## Examining Data Types and Data Structures
## Functions
## Packages
## The Building Blocks of R

<!--chapter:end:io09-building-blocks.Rmd-->


# Tips for Hashtag Debugging your Pipes and GGPlots

Placeholder


## Debugging
## The Quick Screen
## Systematic Hunting For Bugs in Plots
## Your Turn to Debug a Plot
## Hashtag Debugging
## Pipe 2
## Plot 2
## Plot3
## Pipe 3

<!--chapter:end:io59-hashtag_debugging.Rmd-->


# Finding Help in R

Placeholder


## Programming in R
## Starting with Help!
## The Magic of Vignettes
## Googling the Error Message
## You Know What You Want to Do, but Don't Know What Package or Function to Use
### CRAN Task Views
### Google is Your Friend
## Seeking Advanced Help with a Minimal REPREX
#### Built in datasets
#### Filtering your dataframe object
#### Toy datasets
#### Fun with Datapasta Example

<!--chapter:end:io60-help_in_R.Rmd-->


# The Basics of Base R

Placeholder


## Dimensions of Data Rectangles
## Naming columns
## Concatenation
## Sequences
## Constants
## Fancier Sequences
## Mathematical functions
## Handling missing data (NAs)
## Cutting Continuous data into Levels

<!--chapter:end:io66-base_r.Rmd-->


# Updating R, RStudio, and Your Packages

Placeholder


## Installing Packages
### Installing Packages from Github
### Problems with Installing Packages
#### R Version Issues
#### Installing from Source vs Binaries
#### Dependencies
#### Extra-R Dependencies
## Loading Packages with Library
## Updating R
## Updating RStudio
## Updating Your Packages

<!--chapter:end:io04-updating.Rmd-->

---
title: "Major R Updates (Where Did My Packages Go?)"
author: "Peter Higgins"
output: html_document
---



# Major R Updates (Where Are My Packages?)

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.


<!--chapter:end:io07-major-updates.Rmd-->


# Comparing Two Measures of Centrality

Placeholder


## Common Problem
### How Skewed is Too Skewed?
### Visualize the Distribution of data variables in ggplot
### Visualize the Distribution of data$len in ggplot
### Results of Shapiro-Wilk
### Try it yourself
### Mammal sleep hours
## One Sample T test
### How to do One Sample T test
### Interpreting the One Sample T test
### What are the arguments of the t.test function?
## Insert flipbook for ttest here
### Flipbook Time!
## Fine, but what about 2 groups?
### Setting up 2 group t test
### Results of the 2 group t test
### Interpreting the 2 group t test
### 2 group t test with wide data
### Results of 2 group t test with wide data
## 3 Assumptions of Student's t test  
### Testing Assumptions of Student's t test  
## Getting results out of t.test
### Getting results out of t.test
## Reporting the results from t.test using inline code
### For Next Time  

<!--chapter:end:io30-ttest.Rmd-->


# Sample Size Calculations with `{pwr}`

Placeholder


## Sample Size for a Continuous Endpoint (t-test)
## One Sample t-test for Lowering Creatinine
## Paired t-tests (before vs after, or truly paired)
## 2 Sample t tests with Unequal Study Arm Sizes
## Testing Multiple Options and Plotting Results
## Your Turn {.tryit}
### Scenario 1: FEV1 in COPD
### Scenario 2: BNP in CHF
### Scenario 3: Barthel Index in Stroke
## Sample Sizes for Proportions
## Sample size for two proportions, equal n
## Sample size for two proportions, unequal arms
## Your Turn {.tryit}
### Scenario 1: Mortality on Renal Dialysis
### Scenario 2: Intestinal anastomosis in Crohn's disease
### Scenario 3: Metformin in Donuts
## add chi square
## add correlation test
## add anova
## add linear model
## add note on guessing effect sizes - cohen small, medium, large
## Explore More

<!--chapter:end:io69-sample_size.Rmd-->


# Randomization for Clinical Trials with R

Placeholder


## Printing these on Cards
## Now, try this yourself
## Now Freestyle

<!--chapter:end:io66-blockrand.rmd-->


# Univariate ggplots to Visualize Distributions

Placeholder


## Histograms
### Comparisons of Distributions with Histograms
### Histograms and Categories
## Density Plots
### Comparisons with Density plots
## Comparing Distributions Across Categories
## Boxplots
## Violin Plots
## Ridgeline Plots
### Including Plots
### Including Points
### Including Points
### Including Points
### Including Points

<!--chapter:end:io48-univariate_distrib_plots.Rmd-->


# Bivariate ggplot2 Scatterplots to Visualize Relationships Between Variables

Placeholder


## Packages used in this Chapter
## Data Exploration and Validation (DEV)
## Scatterplots
### Micro-quiz!
## Mapping More Variables
## Inheritance and Layering in ggplot2
## Aesthetic mapping Micro-Quiz!
## Controlling Point Shape, Size, and Color Manually
### Manual Shapes
### Manual Sizes
### Manual Color

<!--chapter:end:io48b-bivariate-scatter-plots.Rmd-->


# Customizing Plot Scales

Placeholder


## Goals for this Chapter
## Packages Needed for this chapter
## A Flipbook of Where We Are Going With Scales
## A Basic Scatterplot
## But what if you want the scale for risk to start at 0?
## But this axis does not really start at Exactly 0
## Control the Limits and the Breaks
## Test what you have learned
## Continuous vs. Discrete Plots and Scales
## Using Scales to Customize a Legend
## Test what you have learned
### More Examples with Flipbooks

<!--chapter:end:io48c-scales.Rmd-->


# Helping out with ggplot

Placeholder


## ggx::gghelp()
## Getting more help with theming with ggThemeAssist
## Website helpers for ggplot
## Getting Even more help with esquisse

<!--chapter:end:io67-ggplot_helpers.Rmd-->


# Functions

Placeholder


### Acknowledgement
## Don't repeat yourself
## Your Turn
## Freestyle
## Read More

<!--chapter:end:io71-functions_plots.Rmd-->


# Adding Citations to your RMarkdown

Placeholder


## Goals for this Chapter
## Packages Needed for this chapter
## Getting Set Up for Citations
### Installing the Zotero Connector
### Registration for Zotero
## Building your First Zotero Collection
## Adding References to Your Zotero Collection
## Inserting References into Documents (Rmarkdown)
### Formatting your Bibliography
## Inserting References into Documents (MS Word)

<!--chapter:end:io56b-Rmd-citations-Zotero.Rmd-->


# Running R from the UNIX Command Line {#cmd-line}

Placeholder


## What is the UNIX Command line?
## Why run R from the command line?
## How do you get started?
### On a Mac
### On a Windows PC
## The Yawning Blackness of the Terminal Window
## Where Are We?
## Cleaning Up
## Other helpful file commands
## What about R?
## What about just a few lines of R?
## Running an R Script from the Terminal
## Rendering an Rmarkdown file from the Terminal

<!--chapter:end:io70-r_cmd_line.Rmd-->

---
title: "Reproducible Medical Research with R"
author: "Peter D.R. Higgins, MD, PhD, MSc"
date: "2021-11-11"
output: html_document
---
# Title holder {-}

<!--chapter:end:io98-title-holder.Rmd-->


# References {-}


<!--chapter:end:io99-references.Rmd-->

