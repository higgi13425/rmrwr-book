--- 
title: "Reproducible Medical Research with R"
author: "Peter D.R. Higgins, MD, PhD, MSc"
date: "2020-04-18"
site: bookdown::bookdown_site
output: bookdown::gitbook
documentclass: book
bibliography: [book.bib, packages.bib]
biblio-style: apalike
link-citations: yes
github-repo: higgi13425/rmrwr-book
description: "This book is for anyone in the medical field interested in learning R to analyze available health data."
url: 'https\://rmrwr-book.netlify.com'
cover-image: images/data.jpg
---

# Preface
Welcome to Reproducible Medical Research with R (RMWR). I hope that this book meets your needs.     

## Who This Book is For
This is a book for anyone in the medical field interested in analyzing the data available to them to better understand health, disease, or delivery of care. This could include nurses, dieticians, psychologists, and PhDs in related fields, as well as medical students, residents, fellows, or doctors in practice.     
I expect that most learners will be using this book in their spare time at night and on weekends, as the medical school curriculum is already packed full, and there is no room to add skills in reproducible research to the standard curriculum. This book is designed for self-teaching, and many hints and solutions will be provided to avoid roadblocks and frustration. 
Many learners find themselves wanting to develop reproducible research skills after they have finished their training, and after they have become comfortable with their clinical role. This is the time when they identify and want to address problems in their practice with the data they have before them. This book is for you.

## Prerequisites

Thank you for giving this e-book a try. This is designed for physicians or others analyzing health data who are interested in pursuing this field using the R language.
<br>
We will assume that:

- you have access to a computer
- that you have access to the internet
- that you can download the current version of R, and 
- that you have downloaded a current version of Rstudio.
<br>

## The Spiral of Success Structure
This book is structured on the concept of a "spiral of success", with readers learning about topics like data visualization, data wrangling, data modeling, reproducible research, and communication of results in repeated passes. These will initially be at a superficial level, and at each pass of the spiral, will provide increasing depth and complexity. This means that the chapters on data wrangling will not all be together, nor the chapters on data visualization. Our goal is to build skills gradually, and return to (and remind students of) their previously built skills in one area and to add to them. The eventual goal is for learners to be able to produce, document, and communicate reproducible research to their community.

## Motivation for this Book
Most medical people who learn R to do their own data analysis do it on their own time. They rarely have time for a semester-long course, and their clinical schedules usually will not allow it. Fortunately, a lot of people learn R on their own, and there is a strong and supportive R Community to help new learners. A 2019 Twitter survey conducted by `@RLadies` found that more than half of respondents were largely self-taught, from books and online resources.     

There are a lot of good resources for learning R, so why one more? In part, because the needs of a medical audience are often different. There are distinct needs for protecting health information, generating a descriptive Table One, using secure data tools like REDCap, and creating standard medical journal and meeting output in Word, Powerpoint, and poster formats.     

More and more, all science is becoming data science. We are able to track patients, their test results, and even the individual pixels (voxels) of their CT scans electronically, and use those data points to develop new knowledge. While one could argue that health care workers should collect data and bring it to trained statisticians, this does not work nearly as well as you might expect. Most academic statisticians are incentivized to develop new statistical methods, and are not very interested (or incentivized) to do the hand-holding required to wrangle messy clinical data into a manuscript.      

There also are simply not enough statisticians to meet the needs of medical science. Having clinicians on the front lines with some data science training makes a big difference, whether in 1854 in London (John Snow) or in 2014 in Flint, Michigan (Mona Hanna-Atisha). Having more clinicians with some training will impact medical care, as they will identify local problems that would have otherwise never reached a statistician, and probably never been addressed with data otherwise. 

## The Scientific Reproducibility Crisis
Beginning as far back as 1989, with the David Baltimore case, and increasingly publicly through the 2010s, there has been a rising tide of realization that a lot of taxpayer-funded science is done sloppily, and that our standards as scientists need to be higher. The line between carelessly-done science and outright fraud is a thin one, and the case can be made that doing science in a sloppy fashion defrauds the funders, as it leads to results that can not be reproduced nor replicated. Particularly in medicine, where incorrect findings can cause great harm, we should take special care to do scientific research which is well-documented, reproducible, and replicable. This topic as a motivating force for doing careful medical research will be expanded upon in Chapter 1.

## What this Book is Not

### This Book is Not A Statistics Text
This is not an introduction to statistics. I am assuming that you have learned some statistics somewhere in secondary school, undergraduate studies, graduate school, or even medical school. There are lots of statisticians with Ph.D.s who can certainly teach statistics much more effectively than I can. While I have a master's degree in Clinical Research Design and Statistical Analysis (isn't that a mouthful!) from the University of Michigan, I will leave formal teaching of statistics to the pros.      

If you need to brush up on your statistics, no worries. There are several excellent (and free!) e-books on that very topic, using R. Some good examples include (go ahead and click through the blue links to explore):     

1. [Learning Statistics with R (LSR)](https://learningstatisticswithr-bookdown.netlify.com)
2. [Modern Dive](https://bookdown.org/fjmcgrade/ismaykim/)
3. [Teacup Giraffes](https://tinystats.github.io/teacups-giraffes-and-statistics/index.html)


We will cover a lot of the same materials as these books, but with a less theoretical and more applied approach. I will focus on specific medical examples, and emphasize issues (like Protected Health Information) that are particularly important for medical data. I am assuming that you are here because you want to analyze your own data in your probably very limited free time.

### This Book Does Not Provide Comprehensive Coverage of the R Universe
This book is also far from comprehensive in teaching what is available in the R ecosystem. This book should be considered a launch pad. Many of the later chapters will give you a taste of what is available in certain areas, and guide you to resources (and links) that you can explore to learn more and do more beyond the scope of this book.    


## Some Guideposts

Keep an eye out for Guideposts, which look like this:

**Warnings**

:::warning
This is a common gotcha. Watch out for this.
:::

**Tips**

:::tip
This is a helpful tip for debugging.
:::

**Try It Out**

:::tryit
Take what you have learned and try it yourself in the code box below.
:::

**Challenge** - take the next step and try a more challenging example.

:::challenge
Try this more complicated example.
:::

**Explore More** - resources for learning more about a particular topic.

:::explore
If you want to learn more about Shiny apps, go to https://mastering-shiny.org to see an entire book on the topic.
:::




<!--chapter:end:index.Rmd-->

---
title: "Getting Started and Installing Your Tools.Rmd"
author: "Peter Higgins"
output: html_document
---



# Getting Started and Installing Your Tools

One of the most intimidating parts of getting started with something new is the actual getting started part. Don't worry, we will walk you through this step-by step. 

## Goals for this Chapter
- Install R on your Computer
- Install RStudio on your Computer
- Install Git on your Computer
- Get Acquainted with the RStudio IDE

## Website links needed for this Chapter
While in many chapters, we will list the R packages you need, in this chapter, you will be downloading and installing new software, so we will list the links here for your reference    

- https://www.r-project.org
- https://rstudio.com/products/rstudio/download/
- https://git-scm.com/downloads 

## Pathway for this Chapter
This Chapter is part of the **TOOLS** pathway.
Chapters in this pathway include

- Getting Started and Installing Your Tools
- Updating R, RStudio, and Your Packages
- Advanced Use of the RStudio IDE
- When You Don't Want to Update Packages (Using _renv_)
- Major R Updates (Where Are My Packages?)

## Installing R on your Computer


## Installing RStudio on your Computer


## Installing Git on your Computer


## Getting Acquainted with the RStudio IDE


## Introduction {#intro}

There are many books about Data Science. 
<br>
Why does the world need another one, particularly one targeting physicians?

- There is a lot of health care data
- There are a lot of interesting questions in health care
- There are particular and challenging issues in doing data analysis with PHI (Protected Health Information)

Syllabus:  Data Science for Physicians (DS4P)<br>

- Instructor: Peter Higgins, MD, PhD, MSc (CRDSA), Professor of Internal Medicine
- Office Hours: MSRB One 6510
- In-person class time
  - MSRB One 6510, Thursday evenings 6:30-8:30 PM
<br> 

## Course Description and Objectives

### Description
A practical introduction to data collection and security, data cleaning, statistical methods and computational tools needed to make sense of data, and methods for reporting and sharing your findings. This course is not a traditional introductory statistics courses in that computing plays a more central role than mathematics and a higher emphasis is placed on “thinking with data.” Topics include 

- secure HIPPA-compliant data collection
- data cleaning and validation
- data visualization
- data wrangling
- confidence intervals
- hypothesis testing, and 
- regression 
The course has no mathematics or computer science prerequisites.
<br>

### Objectives

1.	Have students engage in the data/science research pipeline in as faithful a manner as possible while maintaining a level suitable for novices.
2.	Foster a conceptual understanding of statistical topics and methods using real clinical data whenever possible, and simulation/resampling to support teaching concepts of inference. 
3.	Use a flipped classroom model by incorporating online learning for new concepts, with limited face-to-face time for real-time problem-solving 
4.	Introduce best practices for reproducible research and collaboration.
5.	Develop statistical literacy by, among other ways, tying in the curriculum to actual clinical data, demonstrating the importance statistics and computing plays in advancing medicine
<br>

### Topics
Roughly speaking we will cover the following topics (a more detailed outline is found below:

1.	Introduction and Tools (R, RStudio, and R Markdown)
2.	Data Import, and Handling
3.	Data Collection
4.	Checking, Validating, And Exploring your Data
5.	Data Types
6.	Data Wrangling with Tidyr and Dplyr
7.	Graphic Summaries for a Single Variable – ggplot package
8.	Descriptive Data for a Single Variable
9.	Graphic Summaries for Two or More Variables – ggplot2
10.	Descriptive Data for Two or More Variables
11.	Presenting your Results in a report with RMarkdown
12.	Statistical inference
13.	Study Design
14.	Sample Size and Power
15.	Sources of Bias
16.	Study Types
17.	One variable, single group
18.	One variable, two groups
19.	Multiple groups
20.	Linear Regression
21.	Reporting results interactively with Shiny
22.	Logistic Regression
23.	Meta-Analysis
<br>

### Learning Resources

•	E-Textbooks: 
Open Intro Statistics, at www.openintro.org  

•	E-Books on R
<br>
These are at different levels:

Level:    Absolute Beginner 
Textbook: R Basics	 
Goal:     Set up R and RStudio on a laptop, introduce the concept of an IDE  
Link:

Level:    New to R & Statistics	 
Textbook: Modern Dive 
Goal:     Learn basics of Data Management and visualization, introduction to hypothesis testing and statistical modeling   
Link:
<br>

Level:    Comfortable with R	
Textbook: Hands-On R Programming  
Goal:      
Link: 
<br>

Level:    Ready to Understand More	
Textbook: R for Data Science  
Link:      
<br>

•	Software: 

- Local laptop/desktop free open-source version of R and RStudio
- Cloud-based RStudio Server, which you can access in your browser via:
<br>
 Note if you are off-campus you must first log into the UM VPN. 
 
<br>
•	Online:

- DataCamp. A brower based interactive tool for learning R through short, focused courses, each 3-4 hours long.
- RStudio. Website with many resources for learning about the RStudio IDE and the tidyverse.
- r-cookbook – an often useful website with concrete examples of how to use R packages
- Stack Overflow and Google. Remarkably helpful to search for explanations of error messages, or explanations of problems that someone else has probably also experienced. For using Google, search for any topic or your error message and add “in R”
- package vignettes – variable quality, but when well done, can be extremely helpful examples of how to use the functions in each package
- R twitter – follow Rbloggers, #rstats
<br>

### Evaluation
This course is entirely voluntary. I hope that you will learn valuable skills that will advance your research career. I would like you to progress to using these skills on your own data as quickly as possible, as this will greatly help you reinforce your new skills. There are no grades and no formal evaluations. You can, however, earn certificates on DataCamp for completing courses.
<br>

### Task Goals
1.	Learn concepts through Data Camp  
a.	Multiple short courses to correspond with each unit
2.	Test yourself with assignments in ModernDive
a.	Chapters corresponding to each unit
3.	Three Challenges
a.	Clean data and perform descriptive data analysis on the biofire dataset
b.	Clean data and model outcomes in the health satisfaction dataset, producing a final report
c.	Use logistic regression to model dichotomous outcomes and produce a Shiny app to allow users to make predictions for future patients 
4.	Final Project 
There will be a final capstone project. This is an opportunity for you to use your statistics and data science skills developed during the challenges and perform your own start-to-finish data analysis project. The project will involving you addressing a scientific question by choosing a data set (or preferably, using one of your own), performing an analysis using the concepts and tools we have covered in this course, and writing a report. This can be done solo or with a partner.
<br>

### Learning Goals
1.	Recognize the importance of data collection, identify limitations in data collection methods, and determine how they affect the generalizability of your findings
2.	Use statistical software (R) to summarize data numerically and visually, and to perform data analysis.
3.	Have a conceptual understanding of statistical inference.
4.	Apply estimation and testing methods to analyze single variables or the relationship between two variables in order to understand data relationships and make data-based conclusions.
5.	Model numerical response variables and dichotomous response variables using a single explanatory variable or multiple explanatory variables in order to investigate relationships between variables.
6.	Interpret results correctly, effectively, and in context without relying on statistical jargon.
7.	Critique data-based claims and evaluate data-based decisions.
<br>

### Tips for success
1.	Read materials for each unit
2.	Do Data Camp courses for each unit – usually around 1 chapter (1 hour) per day.
3.	Do Data Camp daily practice on any day that you don’t have time to do a full chapter
4.	At end of each course, review material, take notes, copy/reproduce/save code on your laptop
5.	Try new skills on your own data, or on one of the open data sets
6.	Use RStudio and DataCamp Cheat sheets
7.	Annotate your code to help ‘future you’ understand it.
8.	Save and reuse your code for future projects
<br>

### Expected work load  
This course is entirely voluntary. It is expected that you have lots of clinical and/or research work to keep up with, along with the occasional call or night rotation. This is an investment in future skills to help your career. I recommend that you try to do up to one hour a day on most days, and on days when that is not realistic, to just do the 10 minutes of daily practice on DataCamp to keep the information fresh in your mind.  
<br>
Other learning resources:
<br>
<br>
<br>


You can label chapter and section titles using `{#label}` after them, e.g., we can reference Chapter \@ref(intro). If you do not manually label them, there will be automatic labels anyway, e.g., Chapter \@ref(methods).

Figures and tables with captions will be placed in `figure` and `table` environments, respectively.


```r
par(mar = c(4, 4, .1, .1))
plot(pressure, type = 'b', pch = 19)
```

<div class="figure" style="text-align: center">
<img src="io02-getting-started_files/figure-epub3/nice-fig-1.png" alt="Here is a nice figure!" width="80%" />
<p class="caption">(\#fig:nice-fig)Here is a nice figure!</p>
</div>

Reference a figure by its code chunk label with the `fig:` prefix, e.g., see Figure \@ref(fig:nice-fig). Similarly, you can reference tables generated from `knitr::kable()`, e.g., see Table \@ref(tab:nice-tab).


```r
knitr::kable(
  head(iris, 20), caption = 'Here is a nice table!',
  booktabs = TRUE
)
```



Table: (\#tab:nice-tab)Here is a nice table!

 Sepal.Length   Sepal.Width   Petal.Length   Petal.Width  Species 
-------------  ------------  -------------  ------------  --------
          5.1           3.5            1.4           0.2  setosa  
          4.9           3.0            1.4           0.2  setosa  
          4.7           3.2            1.3           0.2  setosa  
          4.6           3.1            1.5           0.2  setosa  
          5.0           3.6            1.4           0.2  setosa  
          5.4           3.9            1.7           0.4  setosa  
          4.6           3.4            1.4           0.3  setosa  
          5.0           3.4            1.5           0.2  setosa  
          4.4           2.9            1.4           0.2  setosa  
          4.9           3.1            1.5           0.1  setosa  
          5.4           3.7            1.5           0.2  setosa  
          4.8           3.4            1.6           0.2  setosa  
          4.8           3.0            1.4           0.1  setosa  
          4.3           3.0            1.1           0.1  setosa  
          5.8           4.0            1.2           0.2  setosa  
          5.7           4.4            1.5           0.4  setosa  
          5.4           3.9            1.3           0.4  setosa  
          5.1           3.5            1.4           0.3  setosa  
          5.7           3.8            1.7           0.3  setosa  
          5.1           3.8            1.5           0.3  setosa  

You can write citations, too. For example, we are using the **bookdown** package [@R-bookdown] in this sample book, which was built on top of R Markdown and **knitr** [@xie2015].

## Access RStudio cloud  

<br>

## R basics E-book  

<br>
Use the e-book Rbasics by Chester Ismay 

https://ismayc.github.io/rbasics-book/

<br>

## RStudio tips document  

<br>

<!--chapter:end:io02-getting-started.Rmd-->

---
title: "A Tasting Menu"
author: "Peter Higgins"
date: "4/14/2020"
output: html_document
---



# A Tasting Menu of R
In this chapter, we will introduce you to a lot of neat things that you can do with R and RStudio, and you will publish a simple data analysis on the Internet 
that you can share with friends and family.
![tasting](images/tasting.png)    

## Setting the Table

At the end of this chapter, you will publish a data analysis to *RPubs*, a free website site where you can share your data analyses and visualizations. First you will need to set up an account on RPubs. Start by opening a new tab in your browser, and navigating to this [RPubs link](https://rpubs.com/users/new). It should look like the image below.
![rpubs1](images/rpubs1.png)    
<br>
Enter your name, email, username and password, and click on the _Register Now_ button, and you will be set up to use RPubs.    
This will bring you to this page. In the image below, we have set up an account for pdr.    
![rpubs2](images/rpubs2.png) 
Click on the _Here's How You Get Started_ link.
![rpubs3](images/rpubs3.png)    
You are now all set up and ready to go. Now you have a place on the internet to share your R creations!

## Goals for this Chapter
- Open a New Rmarkdown document
- Read in Data from a file
- Wrangle Your Data
- Visualize Your Data
- Publish your work to RPubs
- Check out Interactive Plots
- Check out Animated Graphics
- Check out a Clinical Trial Dashboard
- Check out a Shiny App

## Packages needed for this Chapter
You will need to enter this line of code into your console, to make sure that the tidyverse package is installed on your computer.
`install.packages("tidyverse")`      

In the setup chunk of your Rmarkdown document, you will need to access the tidyverse package with one line of code:
`library(tidyverse)`

## Website links needed for this Chapter
In this chapter, you will need to access the RPubs website.   
- https://rpubs.com/

## Pathway for this Chapter
This Chapter is part of the **XXX** pathway.
Chapters in this pathway include

## Open a New Rmarkdown document

Let's get started in R. Turn on your computer, and open the RStudio application. You should see the familiar panes for the Console, Environment, and Files.    
You need to open up a new document to activate the Source pane. While in RStudio, click on File/New File/R Script.
It should look like this.    
![newrmd](images/rmd1.png)
Now you will see the window below. Rename the document from "Untitled" to "Tasting", and click the OK button.
![newrmd2](images/rmd2.png)

Now the file is open, and looks like the window below. Click on the save icon (like a floppy disk in the top left), and save this document as tasting.Rmd.
![newrmd3](images/rmd3.png)
You have created a new Rmarkdown document. An Rmarkdown document lets you mix data, code, and descriptive text. It is very helpful for presenting and explaining data and visualizations. An Rmarkdown document can be converted (Knit) to HTML for a web page, Microsoft Word, Powerpoint, PDF, and several other formats.     
 
Code chunks are in a gray color, and both start and end with 3 backticks (\`\`\`).    

Text can be body text, or can be headers and titles. The number of hashtags before some header text defines what level the header is.     
You can insert links, pictures, and YouTube videos into Rmarkdown documents if it is helpful to explain your point. <br>
The first code chunk in each Rmarkdown document is named `setup`. The name comes after the left curly brace and the r (`{r`) at the beginning of the setup chunk. The letter `r` tells RStudio that what is coming on the next line is R code (RStudio can also use SQL, C++, python, and several other languages). After the comma, you can define options for this code chunk. In this case, the option `include` is set to FALSE, so that when this Rmarkdown document is knitted, this code chunk will not appear. 

## Read in Data from a file

## Wrangle Your Data

## Visualize Your Data

## Publish your work to RPubs

## The Dessert Cart

Below are some examples of neat things you can do with medical data in R. These are more advanced approaches, but completely doable when you have more experience with R.

### Interactive Plots

### Animated Graphics

### A Clinical Trial Dashboard

### A Shiny App

### An Example of Synergy in the R Community

One of the remarkable things about the open source R community is that people build all kinds of new R functions and packages that are useful to them, and then share them publicly with tools like _Github_ so that they can be useful to others. Often combining bits of several packages leads to **emergent properties**  - completely new creations that can only occur because all of the parts (packages) are present. The collaborative nature of the R community, in this case on Twitter (follow the #rstats hashtag), can lead to surprising collaborations and outcomes.     
See the example below.     
Go ahead, _click_ on the play button to run the gifs. All coded in R.    
<br>

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">I used a modified version of <a href="https://twitter.com/djnavarro?ref_src=twsrc%5Etfw">@djnavarro</a>&#39;s flametree package to produce this fractal tree in 3D, placed it in a LEGO planter for <a href="https://twitter.com/ryantimpe?ref_src=twsrc%5Etfw">@ryantimpe</a>, set down a copy of <a href="https://twitter.com/skyetetra?ref_src=twsrc%5Etfw">@skyetetra</a> and <a href="https://twitter.com/robinson_es?ref_src=twsrc%5Etfw">@robinson_es</a>&#39;s book for some light reading, and of course, used <a href="https://twitter.com/hashtag/rayrender?src=hash&amp;ref_src=twsrc%5Etfw">#rayrender</a> and <a href="https://twitter.com/hashtag/rstats?src=hash&amp;ref_src=twsrc%5Etfw">#rstats</a> to render it all :) <a href="https://t.co/qRg2omUftw">https://t.co/qRg2omUftw</a> <a href="https://t.co/Ff9VeLtX97">pic.twitter.com/Ff9VeLtX97</a></p>&mdash; Tyler Morgan-Wall (@tylermorganwall) <a href="https://twitter.com/tylermorganwall/status/1250047222936416256?ref_src=twsrc%5Etfw">April 14, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>




<!--chapter:end:io03-tasting.Rmd-->

---
title: "Updating R, RStudio, and Your Packages"
author: "Peter Higgins"
output: html_document
---


# Updating R, RStudio, and Your Packages

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.


<!--chapter:end:io04-updating.Rmd-->

---
title: "Major R Updates (Where Did My Packages Go?)"
author: "Peter Higgins"
output: html_document
---



# Major R Updates (Where Are My Packages?)

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.


<!--chapter:end:io07-major-updates.Rmd-->

---
title: "Time Series with the Tidyverts Packages"
author: "Daniel Y Chen"
output: html_document
---



# Time Series data with the Tidyverts Packages
Fun text here. 
All kinds of crazy examples.
Time series with data from influenza pandemic of 1918-19, perhaps.
This is a book for anyone in the medical field interested in analyzing the data available to them to better understand health, disease, or delivery of care. This could include nurses, dieticians, psychologists, and PhDs in related fields, as well as medical students, residents, fellows, or doctors in practice.     
I expect that most learners will be using this book in their spare time at night and on weekends, as the medical school curriculum is already packed full, and there is no room to add skills in reproducible research to the standard curriculum. This book is designed for self-teaching, and many hints and solutions will be provided to avoid roadblocks and frustration. 

## Tsibble
Time series tibble

[Tidyverts webpage](https://tidyverts.org)

## Fable
Tidy forecasting

## Feasts
Feature extraction and Statistics

## Slider
Rolling anaylsis with window functions.     
[Slider packagedown page](https://davisvaughan.github.io/slider/)    



<!--chapter:end:io09-timeseries.Rmd-->

---
title: "Reproducible Medical Research with R"
author: "Peter D.R. Higgins, MD, PhD, MSc"
date: "2020-04-18"
output: html_document
---

<!--chapter:end:io98-title-holder.Rmd-->


# References {-}


<!--chapter:end:io99-references.Rmd-->

