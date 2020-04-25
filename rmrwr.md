--- 
title: "Reproducible Medical Research with R"
author: "Peter D.R. Higgins, MD, PhD, MSc"
date: "2020-04-24"
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
R is a statistical programming language, designed for non-programmers (statisticians). It is optimized to work with data in tables. It is a very fast and powerful programming engine, but it is not terribly comfortable or convenient. R itself is not terribly user-friendly. It is a lot like a drag racing car, which is basically a person with a steering wheel strapped to an airplane engine.
![drag racer](images/drag.png)
Very aerodynamic and fast, but not comfortable for the long run (more than about 8 seconds).
You will need something more like a production car, with a nice interior and a dashboard, and comfy leather seats. 
![dashboard](images/dashboard.png)
This is provided by the RStudio IDE (Integrated Developer Environment). We want you to install both R and RStudio, in that order.    
Let's start with installing R.    
R is free and available for download on the web. Go to the [r-project website](https://r-project.org/) to get started. 

This screen will look like this
![irproject](images/r-project.png)    
You can see from the blue link (download R) that you can download R, but you will be downloading it faster if you pick a local CRAN mirror.   
You might be wondering what CRAN and CRAN Mirrors are. Nothing to do with cranberries, fortunately. CRAN is the Comprehensive R Archive Network. Each site (mirror) in the network contains an archive of all R versions and packages, and the sites are scattered over the globe. A CRAN Mirror maintains an up to date copy of all of the R versions and packages on CRAN. If you use the nearest CRAN mirror, you will generally get faster downloads.   
At this point, you might be wondering what a package is...   
A package is a set of functions and/or data that you can download to upgrade and add features to R. It is a lot like a downloadable upgrade to a Tesla that lets you play the video game _Witcher 3_ on your console, but more useful.
![tesla](images/dash-tesla.png)   

Now click on the blue link that says "download R".    
This will take you to a page to select your local CRAN Mirror , from which you will download R.
![cran](images/cran-mirror.png)
Scroll down to your country (yes, the USA is at the bottom), and a CRAN mirror near you.
This is an example from northern Michigan, USA.
![usa-mirrors](images/usa-mirrors.png)
Once you click on a CRAN Mirror site to select the location, you will be taken to the actual Download site.

![install](images/installr.png)
Select the link for the operating system you want to use. We will walk through this with Windows first, then Mac. If you are using a Mac, skip forward to the Mac install. If you are using Linux, you can clearly figure it out on your own (it will look a lot like these).  
Once you have clicked through, your next screen will look like this    
![install2](images/installr2.png)
You want to download both base and Rtools (you might need Rtools later). The base link will take you to the latest version, which will look something like this.

![install3](images/installr3windows.png)
Click on this link, and you will be able to save a file named R-N.N.N-win.exe (Ns depending on version number) to your Downloads folder. Click on the Save button to save it.
![install4](images/installrsave.png)
Now, go to your Downloads folder in Windows, and double clinic on the R installation file (R-N.N.N-win.exe). Click Yes to allow this to install.
![install5exe](images/installrexe.png)
Now select your language option
![install_language](images/installrEnglish.png)
You will be asked to accept the GNU license - do so. Click Yes to allow this to install. Then select where to install - generally use the default- a local (often C) drive - do not install on a shared network drive or in the cloud.
![install_drive](images/installrdrive.png)
Then select the Components - generally use the defaults, but newer computers can skip the 32 bit version.
![install_comp](images/installrComponents.png)
In the next dialog box, accept the default startup options.
![install_defaults](images/installrdefaults.png)
You can choose the start menu folder. The default R folder is fine.
![install_start](images/installrstartmenu.png)

You probably won't need shortcuts, so leave these unchecked in the next dialog box.
![install_addltasks](images/installraddltasks.png)

Then the Setup Wizard will appear - click Finish, and the rest of the installation will occur.

![install_wizard](images/installrwizard.png)

### Testing

Now you want to test whether your Windows installation was successful. Can you find R and make it work?
Hunt for your C folder, then for OS-APPS within that folder. Keep drilling down to the Program Files folder. Then the R folder, and the current version folder within that one (R-N.N.N). Within that folder will be the bin folder, and within that will be your R-N.N.N.exe file. Double click on this to run it. The example paths below can help guide you.

![install_path2](images/installwin-path2.png)

![install_path](images/installrpath.png)
Opening the exe file will produce a classic 2000-era terminal window, called Rterm, with 64 bit if that is what your computer uses. The version number should match what you downloaded. The messaging should end with a ">" prompt.
![install_term](images/windowsrterm.png)
At this prompt, type in:     
<br>
paste(‘Two to the seventh power is’, 2^7)
<br>
(don't leave out the comma) - then press the Enter key.

This should produce the following:    

![install_test](images/windowstest.png)
Note that you have explained what is being done and computed the result. 

### Mac Install of R
The installation for Mac is very similar, but the windows look a bit different. At the Download Version page, you click on the Mac Download.
You will then click on the link for R-N.N.N.pkg, and allow downloads from CRAN.

![install_path](images/installrpkgmac.png) 

Then go to Finder, and navigate to the Downloads folder. Click on R-N.N.N.pkg
You will then click on the link for R-N.N.N.pkg, and allow downloads from CRAN.
![install_downloadmac](images/installrdownloadsmac.png)
Click on Continue on 2 consecutive screens to download

![cont1_mac](images/installrCont1mac.png)
![cont2_mac](images/installrCont2mac.png)
Then you need to agree with the License Agreement, 
![mac_license](images/installrmacLicense.png)
then Click on Install, and provide your Mac password for permission to install.
![cont1_mac](images/installrmac-install.png)
When the installation is complete, click on the Close button. Accept the prompt to move the installer file to the trash.

### Testing R on the Mac
Go to Finder, and then your Applications folder. Scroll down to the R file. Double click on this to run it. 
![findrmac](images/findrmac.png)
You should get this 2000=era terminal window named R Console. The version number should match what you downloaded, and the messaging should end with a ">" prompt.
At this prompt, type in 
<br>
paste(‘Two to the seventh power is’, 2^7)
<br>
(DON’T leave out the comma)
![rconsolemac](images/rconsolemac.png)

This should result in

![mactestR](images/mactestR.png)

### Successful testing!

Awesome. You are now Ready to R!
![ready2R](images/ready2R.png)



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

\begin{figure}

{\centering \includegraphics[width=0.8\linewidth]{io02-getting-started_files/figure-latex/nice-fig-1} 

}

\caption{Here is a nice figure!}(\#fig:nice-fig)
\end{figure}

Reference a figure by its code chunk label with the `fig:` prefix, e.g., see Figure \@ref(fig:nice-fig). Similarly, you can reference tables generated from `knitr::kable()`, e.g., see Table \@ref(tab:nice-tab).


```r
knitr::kable(
  head(iris, 20), caption = 'Here is a nice table!',
  booktabs = TRUE
)
```

\begin{table}

\caption{(\#tab:nice-tab)Here is a nice table!}
\centering
\begin{tabular}[t]{rrrrl}
\toprule
Sepal.Length & Sepal.Width & Petal.Length & Petal.Width & Species\\
\midrule
5.1 & 3.5 & 1.4 & 0.2 & setosa\\
4.9 & 3.0 & 1.4 & 0.2 & setosa\\
4.7 & 3.2 & 1.3 & 0.2 & setosa\\
4.6 & 3.1 & 1.5 & 0.2 & setosa\\
5.0 & 3.6 & 1.4 & 0.2 & setosa\\
\addlinespace
5.4 & 3.9 & 1.7 & 0.4 & setosa\\
4.6 & 3.4 & 1.4 & 0.3 & setosa\\
5.0 & 3.4 & 1.5 & 0.2 & setosa\\
4.4 & 2.9 & 1.4 & 0.2 & setosa\\
4.9 & 3.1 & 1.5 & 0.1 & setosa\\
\addlinespace
5.4 & 3.7 & 1.5 & 0.2 & setosa\\
4.8 & 3.4 & 1.6 & 0.2 & setosa\\
4.8 & 3.0 & 1.4 & 0.1 & setosa\\
4.3 & 3.0 & 1.1 & 0.1 & setosa\\
5.8 & 4.0 & 1.2 & 0.2 & setosa\\
\addlinespace
5.7 & 4.4 & 1.5 & 0.4 & setosa\\
5.4 & 3.9 & 1.3 & 0.4 & setosa\\
5.1 & 3.5 & 1.4 & 0.3 & setosa\\
5.7 & 3.8 & 1.7 & 0.3 & setosa\\
5.1 & 3.8 & 1.5 & 0.3 & setosa\\
\bottomrule
\end{tabular}
\end{table}

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

####	Cleaning – names with janitor package to snake_case

##### A few words about tidyverse style

####	Finding Missing data – naniar and visdat packages

####	Validating data – validate package

### Asserting properties of your data with assertr

####	Evaluating – str, glimpse

####	Exploring- skimr package

####	Histograms

####	Correlations – ggally extension of ggplot2, and corrr package

<!--chapter:end:io08-data-validation.Rmd-->

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
title: "Making Table One"
author: "Peter Higgins"
output: html_document
---


# Descriptive Data Tables



## Making Table One

### Arsenal package, tableby

### gtsummary

<!--chapter:end:io10-tableOne.Rmd-->

---
title: "GGplot with single variable"
author: "Peter Higgins"
output: html_document
---


# Single variable GGplots



## Histograms

### dotplots

### other?

<!--chapter:end:io11-ggplot-single-var.Rmd-->

---
title: "GGplot with Continuous vs Categorical Vars"
author: "Peter Higgins"
output: html_document
---


# Two variable GGplots - continuous vs categorical



## Boxplot

## Violin plot

## geom point or jitter

### Overplotting - jitter and alpha

## Ridgeplots

## Challenges

<!--chapter:end:io12-ggplot-cont-vs-catvar.Rmd-->

---
title: "GGplot with Continuous vs Continuous Vars"
author: "Peter Higgins"
output: html_document
---


# Two variable GGplots - continuous vs continuous



## Scatterplot

## Mosaic plot

## corrr package

## Correlation matrix

## Challenges

<!--chapter:end:io13-ggplot-cont-vs-cont.Rmd-->

---
title: "Presenting your Results with Rmarkdown"
author: "Peter Higgins"
output: html_document
---


# Presenting your Results with Rmarkdown

The magic of the knit button

## Making word document reports

### setting up a custom template

## Rmarkdown to powerpoint

## Rmarkdown to HTML


## Challenges

<!--chapter:end:io14-presenting-Rmarkdown.Rmd-->

---
title: "Reproducible Research"
author: "Peter Higgins"
output: html_document
---


# Reproducibility in Your Research


####	Collaborating with Past You and Future You

#####	General references 

######  <https://peerj.com/preprints/3192/>

######  <https://peerj.com/preprints/3139/> 

#### DataCamp GitHub Course

####		The problem of versions and updated packages
#####		Solutions
###### Renv package
###### Rocker (docker) containers

####	R Projects
####  RStudio on Projects
#####	Multiple scripts and organization of projects
##### Version control 
###### <https://peerj.com/preprints/3159/>

####	Linear and branching projects, and use of the drake package

<!--chapter:end:io15-reproducible-research.Rmd-->

---
title: "Study Design"
author: "Peter Higgins"
output: html_document
---


# Study Design

####	Hypotheses – null and alternative

####	Specific and testable

####	Inclusion and exclusion

####	How many eligible patients – DataDirect query

####	Be conservative – most won’t enroll

## Study Designs

####	Cross sectional 

####  Cohort

####	Retrospective

####	Rarely prospective – registries, case series more likely

####	All Associations

#### Causal Inference requires randomization

<!--chapter:end:io16-study-design.Rmd-->

---
title: "Sample Size and Power"
author: "Peter Higgins"
output: html_document
---

# Sample Size and Power
Using the pwr package

####	Estimating measures in each group

####	Estimating effect size

####	Estimating range and SD

####	Power calc for continuous

####	Power calc for proportion
h <- pwr::ES.h(.14, .08) # effect size
pwr::pwr.2p.test(h=0.1934809,n=350,sig.level=0.05,alternative="two.sided")

<!--chapter:end:io17-sample-size.Rmd-->

---
title: "Sources of Bias"
author: "Peter Higgins"
output: html_document
---

# Sources of Bias

###	Generalizability of studies

###	Bias in design

###	Recall Bias

###	Immortal Time bias

###	Ascertainment bias

### Collider bias

### Assuming linearity on a scale

<!--chapter:end:io18-sources-bias.Rmd-->

---
title: "R Notebook"
output: html_notebook
---

This is an example of use of the blockrand package to create a randomization of two assignments with 5 strata in a randomized permuted block design


```r
library(blockrand)
library(knitr)
library(kableExtra)
library(tidyverse, quietly = T)
```

```
## -- Attaching packages ------------- tidyverse 1.3.0 --
```

```
## v ggplot2 3.3.0.9000      v purrr   0.3.4      
## v tibble  3.0.1           v dplyr   0.8.99.9002
## v tidyr   1.0.2           v stringr 1.4.0      
## v readr   1.3.1           v forcats 0.5.0
```

```
## -- Conflicts ---------------- tidyverse_conflicts() --
## x dplyr::filter()     masks stats::filter()
## x dplyr::group_rows() masks kableExtra::group_rows()
## x dplyr::lag()        masks stats::lag()
```

Our goal is to have 500 assignments available across 5 strata.


```r
set.seed(1234)
stratum1 <- blockrand(n = 100,
                      block.prefix = "B_",
                      stratum = "Stratum_1",
                      num.levels = 2,
                      levels = c("Patient Navigator", "Control")
                      ) %>% filter(id <101)
stratum1
```

```
##    id   stratum block.id block.size         treatment
## 1   1 Stratum_1     B_01          8           Control
## 2   2 Stratum_1     B_01          8           Control
## 3   3 Stratum_1     B_01          8           Control
## 4   4 Stratum_1     B_01          8 Patient Navigator
## 5   5 Stratum_1     B_01          8           Control
## 6   6 Stratum_1     B_01          8 Patient Navigator
## 7   7 Stratum_1     B_01          8 Patient Navigator
## 8   8 Stratum_1     B_01          8 Patient Navigator
## 9   9 Stratum_1     B_02          4           Control
## 10 10 Stratum_1     B_02          4           Control
## 11 11 Stratum_1     B_02          4 Patient Navigator
## 12 12 Stratum_1     B_02          4 Patient Navigator
## 13 13 Stratum_1     B_03          4           Control
## 14 14 Stratum_1     B_03          4 Patient Navigator
## 15 15 Stratum_1     B_03          4           Control
## 16 16 Stratum_1     B_03          4 Patient Navigator
## 17 17 Stratum_1     B_04          4           Control
## 18 18 Stratum_1     B_04          4           Control
## 19 19 Stratum_1     B_04          4 Patient Navigator
## 20 20 Stratum_1     B_04          4 Patient Navigator
## 21 21 Stratum_1     B_05          2           Control
## 22 22 Stratum_1     B_05          2 Patient Navigator
## 23 23 Stratum_1     B_06          8 Patient Navigator
## 24 24 Stratum_1     B_06          8           Control
## 25 25 Stratum_1     B_06          8 Patient Navigator
## 26 26 Stratum_1     B_06          8           Control
## 27 27 Stratum_1     B_06          8 Patient Navigator
## 28 28 Stratum_1     B_06          8           Control
## 29 29 Stratum_1     B_06          8           Control
## 30 30 Stratum_1     B_06          8 Patient Navigator
## 31 31 Stratum_1     B_07          8 Patient Navigator
## 32 32 Stratum_1     B_07          8           Control
## 33 33 Stratum_1     B_07          8 Patient Navigator
## 34 34 Stratum_1     B_07          8           Control
## 35 35 Stratum_1     B_07          8 Patient Navigator
## 36 36 Stratum_1     B_07          8 Patient Navigator
## 37 37 Stratum_1     B_07          8           Control
## 38 38 Stratum_1     B_07          8           Control
## 39 39 Stratum_1     B_08          8           Control
## 40 40 Stratum_1     B_08          8           Control
## 41 41 Stratum_1     B_08          8 Patient Navigator
## 42 42 Stratum_1     B_08          8 Patient Navigator
## 43 43 Stratum_1     B_08          8 Patient Navigator
## 44 44 Stratum_1     B_08          8           Control
## 45 45 Stratum_1     B_08          8 Patient Navigator
## 46 46 Stratum_1     B_08          8           Control
## 47 47 Stratum_1     B_09          4           Control
## 48 48 Stratum_1     B_09          4 Patient Navigator
## 49 49 Stratum_1     B_09          4           Control
## 50 50 Stratum_1     B_09          4 Patient Navigator
## 51 51 Stratum_1     B_10          2           Control
## 52 52 Stratum_1     B_10          2 Patient Navigator
## 53 53 Stratum_1     B_11          2           Control
## 54 54 Stratum_1     B_11          2 Patient Navigator
## 55 55 Stratum_1     B_12          2 Patient Navigator
## 56 56 Stratum_1     B_12          2           Control
## 57 57 Stratum_1     B_13          8           Control
## 58 58 Stratum_1     B_13          8 Patient Navigator
## 59 59 Stratum_1     B_13          8           Control
## 60 60 Stratum_1     B_13          8 Patient Navigator
## 61 61 Stratum_1     B_13          8 Patient Navigator
## 62 62 Stratum_1     B_13          8 Patient Navigator
## 63 63 Stratum_1     B_13          8           Control
## 64 64 Stratum_1     B_13          8           Control
## 65 65 Stratum_1     B_14          4 Patient Navigator
## 66 66 Stratum_1     B_14          4           Control
## 67 67 Stratum_1     B_14          4           Control
## 68 68 Stratum_1     B_14          4 Patient Navigator
## 69 69 Stratum_1     B_15          2 Patient Navigator
## 70 70 Stratum_1     B_15          2           Control
## 71 71 Stratum_1     B_16          4 Patient Navigator
## 72 72 Stratum_1     B_16          4           Control
## 73 73 Stratum_1     B_16          4           Control
## 74 74 Stratum_1     B_16          4 Patient Navigator
## 75 75 Stratum_1     B_17          8           Control
## 76 76 Stratum_1     B_17          8 Patient Navigator
## 77 77 Stratum_1     B_17          8 Patient Navigator
## 78 78 Stratum_1     B_17          8 Patient Navigator
## 79 79 Stratum_1     B_17          8           Control
## 80 80 Stratum_1     B_17          8           Control
##  [ reached 'max' / getOption("max.print") -- omitted 20 rows ]
```

Now stratum 2


```r
set.seed(0714)
stratum2 <- blockrand(n = 100,
                      block.prefix = "B_",
                      stratum = "Stratum_2",
                      num.levels = 2,
                      levels = c("Patient Navigator", "Control")
                      ) %>% filter(id <101)
stratum2
```

```
##    id   stratum block.id block.size         treatment
## 1   1 Stratum_2     B_01          6 Patient Navigator
## 2   2 Stratum_2     B_01          6 Patient Navigator
## 3   3 Stratum_2     B_01          6           Control
## 4   4 Stratum_2     B_01          6           Control
## 5   5 Stratum_2     B_01          6 Patient Navigator
## 6   6 Stratum_2     B_01          6           Control
## 7   7 Stratum_2     B_02          4           Control
## 8   8 Stratum_2     B_02          4 Patient Navigator
## 9   9 Stratum_2     B_02          4           Control
## 10 10 Stratum_2     B_02          4 Patient Navigator
## 11 11 Stratum_2     B_03          4           Control
## 12 12 Stratum_2     B_03          4 Patient Navigator
## 13 13 Stratum_2     B_03          4 Patient Navigator
## 14 14 Stratum_2     B_03          4           Control
## 15 15 Stratum_2     B_04          4           Control
## 16 16 Stratum_2     B_04          4           Control
## 17 17 Stratum_2     B_04          4 Patient Navigator
## 18 18 Stratum_2     B_04          4 Patient Navigator
## 19 19 Stratum_2     B_05          4           Control
## 20 20 Stratum_2     B_05          4           Control
## 21 21 Stratum_2     B_05          4 Patient Navigator
## 22 22 Stratum_2     B_05          4 Patient Navigator
## 23 23 Stratum_2     B_06          8 Patient Navigator
## 24 24 Stratum_2     B_06          8 Patient Navigator
## 25 25 Stratum_2     B_06          8 Patient Navigator
## 26 26 Stratum_2     B_06          8           Control
## 27 27 Stratum_2     B_06          8           Control
## 28 28 Stratum_2     B_06          8 Patient Navigator
## 29 29 Stratum_2     B_06          8           Control
## 30 30 Stratum_2     B_06          8           Control
## 31 31 Stratum_2     B_07          2 Patient Navigator
## 32 32 Stratum_2     B_07          2           Control
## 33 33 Stratum_2     B_08          2 Patient Navigator
## 34 34 Stratum_2     B_08          2           Control
## 35 35 Stratum_2     B_09          6 Patient Navigator
## 36 36 Stratum_2     B_09          6           Control
## 37 37 Stratum_2     B_09          6           Control
## 38 38 Stratum_2     B_09          6 Patient Navigator
## 39 39 Stratum_2     B_09          6 Patient Navigator
## 40 40 Stratum_2     B_09          6           Control
## 41 41 Stratum_2     B_10          4 Patient Navigator
## 42 42 Stratum_2     B_10          4           Control
## 43 43 Stratum_2     B_10          4 Patient Navigator
## 44 44 Stratum_2     B_10          4           Control
## 45 45 Stratum_2     B_11          2           Control
## 46 46 Stratum_2     B_11          2 Patient Navigator
## 47 47 Stratum_2     B_12          4 Patient Navigator
## 48 48 Stratum_2     B_12          4           Control
## 49 49 Stratum_2     B_12          4 Patient Navigator
## 50 50 Stratum_2     B_12          4           Control
## 51 51 Stratum_2     B_13          6           Control
## 52 52 Stratum_2     B_13          6           Control
## 53 53 Stratum_2     B_13          6           Control
## 54 54 Stratum_2     B_13          6 Patient Navigator
## 55 55 Stratum_2     B_13          6 Patient Navigator
## 56 56 Stratum_2     B_13          6 Patient Navigator
## 57 57 Stratum_2     B_14          8 Patient Navigator
## 58 58 Stratum_2     B_14          8           Control
## 59 59 Stratum_2     B_14          8 Patient Navigator
## 60 60 Stratum_2     B_14          8           Control
## 61 61 Stratum_2     B_14          8           Control
## 62 62 Stratum_2     B_14          8 Patient Navigator
## 63 63 Stratum_2     B_14          8           Control
## 64 64 Stratum_2     B_14          8 Patient Navigator
## 65 65 Stratum_2     B_15          2 Patient Navigator
## 66 66 Stratum_2     B_15          2           Control
## 67 67 Stratum_2     B_16          2 Patient Navigator
## 68 68 Stratum_2     B_16          2           Control
## 69 69 Stratum_2     B_17          2           Control
## 70 70 Stratum_2     B_17          2 Patient Navigator
## 71 71 Stratum_2     B_18          4 Patient Navigator
## 72 72 Stratum_2     B_18          4 Patient Navigator
## 73 73 Stratum_2     B_18          4           Control
## 74 74 Stratum_2     B_18          4           Control
## 75 75 Stratum_2     B_19          6           Control
## 76 76 Stratum_2     B_19          6 Patient Navigator
## 77 77 Stratum_2     B_19          6           Control
## 78 78 Stratum_2     B_19          6 Patient Navigator
## 79 79 Stratum_2     B_19          6 Patient Navigator
## 80 80 Stratum_2     B_19          6           Control
##  [ reached 'max' / getOption("max.print") -- omitted 20 rows ]
```


Now stratum 3


```r
set.seed(1965)
stratum3 <- blockrand(n = 100,
                      block.prefix = "B_",
                      stratum = "Stratum_3",
                      num.levels = 2,
                      levels = c("Patient Navigator", "Control")
                      ) %>% filter(id <101)
stratum3
```

```
##    id   stratum block.id block.size         treatment
## 1   1 Stratum_3     B_01          8           Control
## 2   2 Stratum_3     B_01          8 Patient Navigator
## 3   3 Stratum_3     B_01          8 Patient Navigator
## 4   4 Stratum_3     B_01          8           Control
## 5   5 Stratum_3     B_01          8           Control
## 6   6 Stratum_3     B_01          8           Control
## 7   7 Stratum_3     B_01          8 Patient Navigator
## 8   8 Stratum_3     B_01          8 Patient Navigator
## 9   9 Stratum_3     B_02          4           Control
## 10 10 Stratum_3     B_02          4 Patient Navigator
## 11 11 Stratum_3     B_02          4 Patient Navigator
## 12 12 Stratum_3     B_02          4           Control
## 13 13 Stratum_3     B_03          6 Patient Navigator
## 14 14 Stratum_3     B_03          6 Patient Navigator
## 15 15 Stratum_3     B_03          6           Control
## 16 16 Stratum_3     B_03          6 Patient Navigator
## 17 17 Stratum_3     B_03          6           Control
## 18 18 Stratum_3     B_03          6           Control
## 19 19 Stratum_3     B_04          2           Control
## 20 20 Stratum_3     B_04          2 Patient Navigator
## 21 21 Stratum_3     B_05          2           Control
## 22 22 Stratum_3     B_05          2 Patient Navigator
## 23 23 Stratum_3     B_06          6           Control
## 24 24 Stratum_3     B_06          6           Control
## 25 25 Stratum_3     B_06          6 Patient Navigator
## 26 26 Stratum_3     B_06          6           Control
## 27 27 Stratum_3     B_06          6 Patient Navigator
## 28 28 Stratum_3     B_06          6 Patient Navigator
## 29 29 Stratum_3     B_07          6 Patient Navigator
## 30 30 Stratum_3     B_07          6           Control
## 31 31 Stratum_3     B_07          6           Control
## 32 32 Stratum_3     B_07          6           Control
## 33 33 Stratum_3     B_07          6 Patient Navigator
## 34 34 Stratum_3     B_07          6 Patient Navigator
## 35 35 Stratum_3     B_08          8           Control
## 36 36 Stratum_3     B_08          8           Control
## 37 37 Stratum_3     B_08          8           Control
## 38 38 Stratum_3     B_08          8           Control
## 39 39 Stratum_3     B_08          8 Patient Navigator
## 40 40 Stratum_3     B_08          8 Patient Navigator
## 41 41 Stratum_3     B_08          8 Patient Navigator
## 42 42 Stratum_3     B_08          8 Patient Navigator
## 43 43 Stratum_3     B_09          6 Patient Navigator
## 44 44 Stratum_3     B_09          6           Control
## 45 45 Stratum_3     B_09          6           Control
## 46 46 Stratum_3     B_09          6 Patient Navigator
## 47 47 Stratum_3     B_09          6           Control
## 48 48 Stratum_3     B_09          6 Patient Navigator
## 49 49 Stratum_3     B_10          6           Control
## 50 50 Stratum_3     B_10          6 Patient Navigator
## 51 51 Stratum_3     B_10          6           Control
## 52 52 Stratum_3     B_10          6           Control
## 53 53 Stratum_3     B_10          6 Patient Navigator
## 54 54 Stratum_3     B_10          6 Patient Navigator
## 55 55 Stratum_3     B_11          8 Patient Navigator
## 56 56 Stratum_3     B_11          8 Patient Navigator
## 57 57 Stratum_3     B_11          8           Control
## 58 58 Stratum_3     B_11          8           Control
## 59 59 Stratum_3     B_11          8 Patient Navigator
## 60 60 Stratum_3     B_11          8           Control
## 61 61 Stratum_3     B_11          8 Patient Navigator
## 62 62 Stratum_3     B_11          8           Control
## 63 63 Stratum_3     B_12          6           Control
## 64 64 Stratum_3     B_12          6           Control
## 65 65 Stratum_3     B_12          6 Patient Navigator
## 66 66 Stratum_3     B_12          6 Patient Navigator
## 67 67 Stratum_3     B_12          6 Patient Navigator
## 68 68 Stratum_3     B_12          6           Control
## 69 69 Stratum_3     B_13          4 Patient Navigator
## 70 70 Stratum_3     B_13          4 Patient Navigator
## 71 71 Stratum_3     B_13          4           Control
## 72 72 Stratum_3     B_13          4           Control
## 73 73 Stratum_3     B_14          2 Patient Navigator
## 74 74 Stratum_3     B_14          2           Control
## 75 75 Stratum_3     B_15          6           Control
## 76 76 Stratum_3     B_15          6           Control
## 77 77 Stratum_3     B_15          6 Patient Navigator
## 78 78 Stratum_3     B_15          6 Patient Navigator
## 79 79 Stratum_3     B_15          6 Patient Navigator
## 80 80 Stratum_3     B_15          6           Control
##  [ reached 'max' / getOption("max.print") -- omitted 20 rows ]
```

Now stratum 4


```r
set.seed(314159)
stratum4 <- blockrand(n = 100,
                      block.prefix = "B_",
                      stratum = "Stratum_4",
                      num.levels = 2,
                      levels = c("Patient Navigator", "Control")
                      ) %>% filter(id <101)
stratum4
```

```
##    id   stratum block.id block.size         treatment
## 1   1 Stratum_4     B_01          4           Control
## 2   2 Stratum_4     B_01          4 Patient Navigator
## 3   3 Stratum_4     B_01          4 Patient Navigator
## 4   4 Stratum_4     B_01          4           Control
## 5   5 Stratum_4     B_02          2           Control
## 6   6 Stratum_4     B_02          2 Patient Navigator
## 7   7 Stratum_4     B_03          2 Patient Navigator
## 8   8 Stratum_4     B_03          2           Control
## 9   9 Stratum_4     B_04          6           Control
## 10 10 Stratum_4     B_04          6 Patient Navigator
## 11 11 Stratum_4     B_04          6 Patient Navigator
## 12 12 Stratum_4     B_04          6           Control
## 13 13 Stratum_4     B_04          6 Patient Navigator
## 14 14 Stratum_4     B_04          6           Control
## 15 15 Stratum_4     B_05          2 Patient Navigator
## 16 16 Stratum_4     B_05          2           Control
## 17 17 Stratum_4     B_06          2 Patient Navigator
## 18 18 Stratum_4     B_06          2           Control
## 19 19 Stratum_4     B_07          4 Patient Navigator
## 20 20 Stratum_4     B_07          4           Control
## 21 21 Stratum_4     B_07          4 Patient Navigator
## 22 22 Stratum_4     B_07          4           Control
## 23 23 Stratum_4     B_08          2 Patient Navigator
## 24 24 Stratum_4     B_08          2           Control
## 25 25 Stratum_4     B_09          4           Control
## 26 26 Stratum_4     B_09          4 Patient Navigator
## 27 27 Stratum_4     B_09          4           Control
## 28 28 Stratum_4     B_09          4 Patient Navigator
## 29 29 Stratum_4     B_10          2 Patient Navigator
## 30 30 Stratum_4     B_10          2           Control
## 31 31 Stratum_4     B_11          6           Control
## 32 32 Stratum_4     B_11          6 Patient Navigator
## 33 33 Stratum_4     B_11          6           Control
## 34 34 Stratum_4     B_11          6 Patient Navigator
## 35 35 Stratum_4     B_11          6           Control
## 36 36 Stratum_4     B_11          6 Patient Navigator
## 37 37 Stratum_4     B_12          8           Control
## 38 38 Stratum_4     B_12          8 Patient Navigator
## 39 39 Stratum_4     B_12          8           Control
## 40 40 Stratum_4     B_12          8           Control
## 41 41 Stratum_4     B_12          8 Patient Navigator
## 42 42 Stratum_4     B_12          8           Control
## 43 43 Stratum_4     B_12          8 Patient Navigator
## 44 44 Stratum_4     B_12          8 Patient Navigator
## 45 45 Stratum_4     B_13          4 Patient Navigator
## 46 46 Stratum_4     B_13          4 Patient Navigator
## 47 47 Stratum_4     B_13          4           Control
## 48 48 Stratum_4     B_13          4           Control
## 49 49 Stratum_4     B_14          4 Patient Navigator
## 50 50 Stratum_4     B_14          4 Patient Navigator
## 51 51 Stratum_4     B_14          4           Control
## 52 52 Stratum_4     B_14          4           Control
## 53 53 Stratum_4     B_15          4 Patient Navigator
## 54 54 Stratum_4     B_15          4 Patient Navigator
## 55 55 Stratum_4     B_15          4           Control
## 56 56 Stratum_4     B_15          4           Control
## 57 57 Stratum_4     B_16          4 Patient Navigator
## 58 58 Stratum_4     B_16          4           Control
## 59 59 Stratum_4     B_16          4 Patient Navigator
## 60 60 Stratum_4     B_16          4           Control
## 61 61 Stratum_4     B_17          4           Control
## 62 62 Stratum_4     B_17          4 Patient Navigator
## 63 63 Stratum_4     B_17          4           Control
## 64 64 Stratum_4     B_17          4 Patient Navigator
## 65 65 Stratum_4     B_18          6           Control
## 66 66 Stratum_4     B_18          6           Control
## 67 67 Stratum_4     B_18          6 Patient Navigator
## 68 68 Stratum_4     B_18          6 Patient Navigator
## 69 69 Stratum_4     B_18          6           Control
## 70 70 Stratum_4     B_18          6 Patient Navigator
## 71 71 Stratum_4     B_19          6 Patient Navigator
## 72 72 Stratum_4     B_19          6           Control
## 73 73 Stratum_4     B_19          6           Control
## 74 74 Stratum_4     B_19          6 Patient Navigator
## 75 75 Stratum_4     B_19          6 Patient Navigator
## 76 76 Stratum_4     B_19          6           Control
## 77 77 Stratum_4     B_20          6           Control
## 78 78 Stratum_4     B_20          6 Patient Navigator
## 79 79 Stratum_4     B_20          6 Patient Navigator
## 80 80 Stratum_4     B_20          6           Control
##  [ reached 'max' / getOption("max.print") -- omitted 20 rows ]
```

Now Stratum 5


```r
set.seed(2718)
stratum5 <- blockrand(n = 100,
                      block.prefix = "B_",
                      stratum = "Stratum_5",
                      num.levels = 2,
                      levels = c("Patient Navigator", "Control")
                      ) %>% filter(id <101)
stratum5
```

```
##    id   stratum block.id block.size         treatment
## 1   1 Stratum_5     B_01          2 Patient Navigator
## 2   2 Stratum_5     B_01          2           Control
## 3   3 Stratum_5     B_02          8           Control
## 4   4 Stratum_5     B_02          8           Control
## 5   5 Stratum_5     B_02          8           Control
## 6   6 Stratum_5     B_02          8           Control
## 7   7 Stratum_5     B_02          8 Patient Navigator
## 8   8 Stratum_5     B_02          8 Patient Navigator
## 9   9 Stratum_5     B_02          8 Patient Navigator
## 10 10 Stratum_5     B_02          8 Patient Navigator
## 11 11 Stratum_5     B_03          4 Patient Navigator
## 12 12 Stratum_5     B_03          4 Patient Navigator
## 13 13 Stratum_5     B_03          4           Control
## 14 14 Stratum_5     B_03          4           Control
## 15 15 Stratum_5     B_04          8 Patient Navigator
## 16 16 Stratum_5     B_04          8           Control
## 17 17 Stratum_5     B_04          8 Patient Navigator
## 18 18 Stratum_5     B_04          8           Control
## 19 19 Stratum_5     B_04          8 Patient Navigator
## 20 20 Stratum_5     B_04          8           Control
## 21 21 Stratum_5     B_04          8 Patient Navigator
## 22 22 Stratum_5     B_04          8           Control
## 23 23 Stratum_5     B_05          6           Control
## 24 24 Stratum_5     B_05          6 Patient Navigator
## 25 25 Stratum_5     B_05          6 Patient Navigator
## 26 26 Stratum_5     B_05          6 Patient Navigator
## 27 27 Stratum_5     B_05          6           Control
## 28 28 Stratum_5     B_05          6           Control
## 29 29 Stratum_5     B_06          6           Control
## 30 30 Stratum_5     B_06          6 Patient Navigator
## 31 31 Stratum_5     B_06          6           Control
## 32 32 Stratum_5     B_06          6 Patient Navigator
## 33 33 Stratum_5     B_06          6           Control
## 34 34 Stratum_5     B_06          6 Patient Navigator
## 35 35 Stratum_5     B_07          2           Control
## 36 36 Stratum_5     B_07          2 Patient Navigator
## 37 37 Stratum_5     B_08          4           Control
## 38 38 Stratum_5     B_08          4 Patient Navigator
## 39 39 Stratum_5     B_08          4           Control
## 40 40 Stratum_5     B_08          4 Patient Navigator
## 41 41 Stratum_5     B_09          6 Patient Navigator
## 42 42 Stratum_5     B_09          6 Patient Navigator
## 43 43 Stratum_5     B_09          6 Patient Navigator
## 44 44 Stratum_5     B_09          6           Control
## 45 45 Stratum_5     B_09          6           Control
## 46 46 Stratum_5     B_09          6           Control
## 47 47 Stratum_5     B_10          6 Patient Navigator
## 48 48 Stratum_5     B_10          6           Control
## 49 49 Stratum_5     B_10          6           Control
## 50 50 Stratum_5     B_10          6           Control
## 51 51 Stratum_5     B_10          6 Patient Navigator
## 52 52 Stratum_5     B_10          6 Patient Navigator
## 53 53 Stratum_5     B_11          2 Patient Navigator
## 54 54 Stratum_5     B_11          2           Control
## 55 55 Stratum_5     B_12          6           Control
## 56 56 Stratum_5     B_12          6           Control
## 57 57 Stratum_5     B_12          6 Patient Navigator
## 58 58 Stratum_5     B_12          6 Patient Navigator
## 59 59 Stratum_5     B_12          6 Patient Navigator
## 60 60 Stratum_5     B_12          6           Control
## 61 61 Stratum_5     B_13          2           Control
## 62 62 Stratum_5     B_13          2 Patient Navigator
## 63 63 Stratum_5     B_14          2 Patient Navigator
## 64 64 Stratum_5     B_14          2           Control
## 65 65 Stratum_5     B_15          6 Patient Navigator
## 66 66 Stratum_5     B_15          6 Patient Navigator
## 67 67 Stratum_5     B_15          6 Patient Navigator
## 68 68 Stratum_5     B_15          6           Control
## 69 69 Stratum_5     B_15          6           Control
## 70 70 Stratum_5     B_15          6           Control
## 71 71 Stratum_5     B_16          4 Patient Navigator
## 72 72 Stratum_5     B_16          4 Patient Navigator
## 73 73 Stratum_5     B_16          4           Control
## 74 74 Stratum_5     B_16          4           Control
## 75 75 Stratum_5     B_17          6 Patient Navigator
## 76 76 Stratum_5     B_17          6           Control
## 77 77 Stratum_5     B_17          6 Patient Navigator
## 78 78 Stratum_5     B_17          6           Control
## 79 79 Stratum_5     B_17          6 Patient Navigator
## 80 80 Stratum_5     B_17          6           Control
##  [ reached 'max' / getOption("max.print") -- omitted 20 rows ]
```

now bind these together in one assignment sheet


```r
assign500 <- rbind(stratum1, stratum2, stratum3, stratum4, stratum5)
assign500 %>% 
  rename(num = id) %>% 
  select(stratum, num, treatment, block.id, block.size) %>% 
  knitr::kable() %>% 
  kable_styling()
```

\begin{table}[H]
\centering
\begin{tabular}{l|r|l|l|r}
\hline
stratum & num & treatment & block.id & block.size\\
\hline
Stratum\_1 & 1 & Control & B\_01 & 8\\
\hline
Stratum\_1 & 2 & Control & B\_01 & 8\\
\hline
Stratum\_1 & 3 & Control & B\_01 & 8\\
\hline
Stratum\_1 & 4 & Patient Navigator & B\_01 & 8\\
\hline
Stratum\_1 & 5 & Control & B\_01 & 8\\
\hline
Stratum\_1 & 6 & Patient Navigator & B\_01 & 8\\
\hline
Stratum\_1 & 7 & Patient Navigator & B\_01 & 8\\
\hline
Stratum\_1 & 8 & Patient Navigator & B\_01 & 8\\
\hline
Stratum\_1 & 9 & Control & B\_02 & 4\\
\hline
Stratum\_1 & 10 & Control & B\_02 & 4\\
\hline
Stratum\_1 & 11 & Patient Navigator & B\_02 & 4\\
\hline
Stratum\_1 & 12 & Patient Navigator & B\_02 & 4\\
\hline
Stratum\_1 & 13 & Control & B\_03 & 4\\
\hline
Stratum\_1 & 14 & Patient Navigator & B\_03 & 4\\
\hline
Stratum\_1 & 15 & Control & B\_03 & 4\\
\hline
Stratum\_1 & 16 & Patient Navigator & B\_03 & 4\\
\hline
Stratum\_1 & 17 & Control & B\_04 & 4\\
\hline
Stratum\_1 & 18 & Control & B\_04 & 4\\
\hline
Stratum\_1 & 19 & Patient Navigator & B\_04 & 4\\
\hline
Stratum\_1 & 20 & Patient Navigator & B\_04 & 4\\
\hline
Stratum\_1 & 21 & Control & B\_05 & 2\\
\hline
Stratum\_1 & 22 & Patient Navigator & B\_05 & 2\\
\hline
Stratum\_1 & 23 & Patient Navigator & B\_06 & 8\\
\hline
Stratum\_1 & 24 & Control & B\_06 & 8\\
\hline
Stratum\_1 & 25 & Patient Navigator & B\_06 & 8\\
\hline
Stratum\_1 & 26 & Control & B\_06 & 8\\
\hline
Stratum\_1 & 27 & Patient Navigator & B\_06 & 8\\
\hline
Stratum\_1 & 28 & Control & B\_06 & 8\\
\hline
Stratum\_1 & 29 & Control & B\_06 & 8\\
\hline
Stratum\_1 & 30 & Patient Navigator & B\_06 & 8\\
\hline
Stratum\_1 & 31 & Patient Navigator & B\_07 & 8\\
\hline
Stratum\_1 & 32 & Control & B\_07 & 8\\
\hline
Stratum\_1 & 33 & Patient Navigator & B\_07 & 8\\
\hline
Stratum\_1 & 34 & Control & B\_07 & 8\\
\hline
Stratum\_1 & 35 & Patient Navigator & B\_07 & 8\\
\hline
Stratum\_1 & 36 & Patient Navigator & B\_07 & 8\\
\hline
Stratum\_1 & 37 & Control & B\_07 & 8\\
\hline
Stratum\_1 & 38 & Control & B\_07 & 8\\
\hline
Stratum\_1 & 39 & Control & B\_08 & 8\\
\hline
Stratum\_1 & 40 & Control & B\_08 & 8\\
\hline
Stratum\_1 & 41 & Patient Navigator & B\_08 & 8\\
\hline
Stratum\_1 & 42 & Patient Navigator & B\_08 & 8\\
\hline
Stratum\_1 & 43 & Patient Navigator & B\_08 & 8\\
\hline
Stratum\_1 & 44 & Control & B\_08 & 8\\
\hline
Stratum\_1 & 45 & Patient Navigator & B\_08 & 8\\
\hline
Stratum\_1 & 46 & Control & B\_08 & 8\\
\hline
Stratum\_1 & 47 & Control & B\_09 & 4\\
\hline
Stratum\_1 & 48 & Patient Navigator & B\_09 & 4\\
\hline
Stratum\_1 & 49 & Control & B\_09 & 4\\
\hline
Stratum\_1 & 50 & Patient Navigator & B\_09 & 4\\
\hline
Stratum\_1 & 51 & Control & B\_10 & 2\\
\hline
Stratum\_1 & 52 & Patient Navigator & B\_10 & 2\\
\hline
Stratum\_1 & 53 & Control & B\_11 & 2\\
\hline
Stratum\_1 & 54 & Patient Navigator & B\_11 & 2\\
\hline
Stratum\_1 & 55 & Patient Navigator & B\_12 & 2\\
\hline
Stratum\_1 & 56 & Control & B\_12 & 2\\
\hline
Stratum\_1 & 57 & Control & B\_13 & 8\\
\hline
Stratum\_1 & 58 & Patient Navigator & B\_13 & 8\\
\hline
Stratum\_1 & 59 & Control & B\_13 & 8\\
\hline
Stratum\_1 & 60 & Patient Navigator & B\_13 & 8\\
\hline
Stratum\_1 & 61 & Patient Navigator & B\_13 & 8\\
\hline
Stratum\_1 & 62 & Patient Navigator & B\_13 & 8\\
\hline
Stratum\_1 & 63 & Control & B\_13 & 8\\
\hline
Stratum\_1 & 64 & Control & B\_13 & 8\\
\hline
Stratum\_1 & 65 & Patient Navigator & B\_14 & 4\\
\hline
Stratum\_1 & 66 & Control & B\_14 & 4\\
\hline
Stratum\_1 & 67 & Control & B\_14 & 4\\
\hline
Stratum\_1 & 68 & Patient Navigator & B\_14 & 4\\
\hline
Stratum\_1 & 69 & Patient Navigator & B\_15 & 2\\
\hline
Stratum\_1 & 70 & Control & B\_15 & 2\\
\hline
Stratum\_1 & 71 & Patient Navigator & B\_16 & 4\\
\hline
Stratum\_1 & 72 & Control & B\_16 & 4\\
\hline
Stratum\_1 & 73 & Control & B\_16 & 4\\
\hline
Stratum\_1 & 74 & Patient Navigator & B\_16 & 4\\
\hline
Stratum\_1 & 75 & Control & B\_17 & 8\\
\hline
Stratum\_1 & 76 & Patient Navigator & B\_17 & 8\\
\hline
Stratum\_1 & 77 & Patient Navigator & B\_17 & 8\\
\hline
Stratum\_1 & 78 & Patient Navigator & B\_17 & 8\\
\hline
Stratum\_1 & 79 & Control & B\_17 & 8\\
\hline
Stratum\_1 & 80 & Control & B\_17 & 8\\
\hline
Stratum\_1 & 81 & Patient Navigator & B\_17 & 8\\
\hline
Stratum\_1 & 82 & Control & B\_17 & 8\\
\hline
Stratum\_1 & 83 & Control & B\_18 & 8\\
\hline
Stratum\_1 & 84 & Control & B\_18 & 8\\
\hline
Stratum\_1 & 85 & Patient Navigator & B\_18 & 8\\
\hline
Stratum\_1 & 86 & Patient Navigator & B\_18 & 8\\
\hline
Stratum\_1 & 87 & Patient Navigator & B\_18 & 8\\
\hline
Stratum\_1 & 88 & Patient Navigator & B\_18 & 8\\
\hline
Stratum\_1 & 89 & Control & B\_18 & 8\\
\hline
Stratum\_1 & 90 & Control & B\_18 & 8\\
\hline
Stratum\_1 & 91 & Patient Navigator & B\_19 & 4\\
\hline
Stratum\_1 & 92 & Patient Navigator & B\_19 & 4\\
\hline
Stratum\_1 & 93 & Control & B\_19 & 4\\
\hline
Stratum\_1 & 94 & Control & B\_19 & 4\\
\hline
Stratum\_1 & 95 & Control & B\_20 & 4\\
\hline
Stratum\_1 & 96 & Patient Navigator & B\_20 & 4\\
\hline
Stratum\_1 & 97 & Patient Navigator & B\_20 & 4\\
\hline
Stratum\_1 & 98 & Control & B\_20 & 4\\
\hline
Stratum\_1 & 99 & Patient Navigator & B\_21 & 2\\
\hline
Stratum\_1 & 100 & Control & B\_21 & 2\\
\hline
Stratum\_2 & 1 & Patient Navigator & B\_01 & 6\\
\hline
Stratum\_2 & 2 & Patient Navigator & B\_01 & 6\\
\hline
Stratum\_2 & 3 & Control & B\_01 & 6\\
\hline
Stratum\_2 & 4 & Control & B\_01 & 6\\
\hline
Stratum\_2 & 5 & Patient Navigator & B\_01 & 6\\
\hline
Stratum\_2 & 6 & Control & B\_01 & 6\\
\hline
Stratum\_2 & 7 & Control & B\_02 & 4\\
\hline
Stratum\_2 & 8 & Patient Navigator & B\_02 & 4\\
\hline
Stratum\_2 & 9 & Control & B\_02 & 4\\
\hline
Stratum\_2 & 10 & Patient Navigator & B\_02 & 4\\
\hline
Stratum\_2 & 11 & Control & B\_03 & 4\\
\hline
Stratum\_2 & 12 & Patient Navigator & B\_03 & 4\\
\hline
Stratum\_2 & 13 & Patient Navigator & B\_03 & 4\\
\hline
Stratum\_2 & 14 & Control & B\_03 & 4\\
\hline
Stratum\_2 & 15 & Control & B\_04 & 4\\
\hline
Stratum\_2 & 16 & Control & B\_04 & 4\\
\hline
Stratum\_2 & 17 & Patient Navigator & B\_04 & 4\\
\hline
Stratum\_2 & 18 & Patient Navigator & B\_04 & 4\\
\hline
Stratum\_2 & 19 & Control & B\_05 & 4\\
\hline
Stratum\_2 & 20 & Control & B\_05 & 4\\
\hline
Stratum\_2 & 21 & Patient Navigator & B\_05 & 4\\
\hline
Stratum\_2 & 22 & Patient Navigator & B\_05 & 4\\
\hline
Stratum\_2 & 23 & Patient Navigator & B\_06 & 8\\
\hline
Stratum\_2 & 24 & Patient Navigator & B\_06 & 8\\
\hline
Stratum\_2 & 25 & Patient Navigator & B\_06 & 8\\
\hline
Stratum\_2 & 26 & Control & B\_06 & 8\\
\hline
Stratum\_2 & 27 & Control & B\_06 & 8\\
\hline
Stratum\_2 & 28 & Patient Navigator & B\_06 & 8\\
\hline
Stratum\_2 & 29 & Control & B\_06 & 8\\
\hline
Stratum\_2 & 30 & Control & B\_06 & 8\\
\hline
Stratum\_2 & 31 & Patient Navigator & B\_07 & 2\\
\hline
Stratum\_2 & 32 & Control & B\_07 & 2\\
\hline
Stratum\_2 & 33 & Patient Navigator & B\_08 & 2\\
\hline
Stratum\_2 & 34 & Control & B\_08 & 2\\
\hline
Stratum\_2 & 35 & Patient Navigator & B\_09 & 6\\
\hline
Stratum\_2 & 36 & Control & B\_09 & 6\\
\hline
Stratum\_2 & 37 & Control & B\_09 & 6\\
\hline
Stratum\_2 & 38 & Patient Navigator & B\_09 & 6\\
\hline
Stratum\_2 & 39 & Patient Navigator & B\_09 & 6\\
\hline
Stratum\_2 & 40 & Control & B\_09 & 6\\
\hline
Stratum\_2 & 41 & Patient Navigator & B\_10 & 4\\
\hline
Stratum\_2 & 42 & Control & B\_10 & 4\\
\hline
Stratum\_2 & 43 & Patient Navigator & B\_10 & 4\\
\hline
Stratum\_2 & 44 & Control & B\_10 & 4\\
\hline
Stratum\_2 & 45 & Control & B\_11 & 2\\
\hline
Stratum\_2 & 46 & Patient Navigator & B\_11 & 2\\
\hline
Stratum\_2 & 47 & Patient Navigator & B\_12 & 4\\
\hline
Stratum\_2 & 48 & Control & B\_12 & 4\\
\hline
Stratum\_2 & 49 & Patient Navigator & B\_12 & 4\\
\hline
Stratum\_2 & 50 & Control & B\_12 & 4\\
\hline
Stratum\_2 & 51 & Control & B\_13 & 6\\
\hline
Stratum\_2 & 52 & Control & B\_13 & 6\\
\hline
Stratum\_2 & 53 & Control & B\_13 & 6\\
\hline
Stratum\_2 & 54 & Patient Navigator & B\_13 & 6\\
\hline
Stratum\_2 & 55 & Patient Navigator & B\_13 & 6\\
\hline
Stratum\_2 & 56 & Patient Navigator & B\_13 & 6\\
\hline
Stratum\_2 & 57 & Patient Navigator & B\_14 & 8\\
\hline
Stratum\_2 & 58 & Control & B\_14 & 8\\
\hline
Stratum\_2 & 59 & Patient Navigator & B\_14 & 8\\
\hline
Stratum\_2 & 60 & Control & B\_14 & 8\\
\hline
Stratum\_2 & 61 & Control & B\_14 & 8\\
\hline
Stratum\_2 & 62 & Patient Navigator & B\_14 & 8\\
\hline
Stratum\_2 & 63 & Control & B\_14 & 8\\
\hline
Stratum\_2 & 64 & Patient Navigator & B\_14 & 8\\
\hline
Stratum\_2 & 65 & Patient Navigator & B\_15 & 2\\
\hline
Stratum\_2 & 66 & Control & B\_15 & 2\\
\hline
Stratum\_2 & 67 & Patient Navigator & B\_16 & 2\\
\hline
Stratum\_2 & 68 & Control & B\_16 & 2\\
\hline
Stratum\_2 & 69 & Control & B\_17 & 2\\
\hline
Stratum\_2 & 70 & Patient Navigator & B\_17 & 2\\
\hline
Stratum\_2 & 71 & Patient Navigator & B\_18 & 4\\
\hline
Stratum\_2 & 72 & Patient Navigator & B\_18 & 4\\
\hline
Stratum\_2 & 73 & Control & B\_18 & 4\\
\hline
Stratum\_2 & 74 & Control & B\_18 & 4\\
\hline
Stratum\_2 & 75 & Control & B\_19 & 6\\
\hline
Stratum\_2 & 76 & Patient Navigator & B\_19 & 6\\
\hline
Stratum\_2 & 77 & Control & B\_19 & 6\\
\hline
Stratum\_2 & 78 & Patient Navigator & B\_19 & 6\\
\hline
Stratum\_2 & 79 & Patient Navigator & B\_19 & 6\\
\hline
Stratum\_2 & 80 & Control & B\_19 & 6\\
\hline
Stratum\_2 & 81 & Patient Navigator & B\_20 & 6\\
\hline
Stratum\_2 & 82 & Control & B\_20 & 6\\
\hline
Stratum\_2 & 83 & Patient Navigator & B\_20 & 6\\
\hline
Stratum\_2 & 84 & Control & B\_20 & 6\\
\hline
Stratum\_2 & 85 & Patient Navigator & B\_20 & 6\\
\hline
Stratum\_2 & 86 & Control & B\_20 & 6\\
\hline
Stratum\_2 & 87 & Control & B\_21 & 4\\
\hline
Stratum\_2 & 88 & Control & B\_21 & 4\\
\hline
Stratum\_2 & 89 & Patient Navigator & B\_21 & 4\\
\hline
Stratum\_2 & 90 & Patient Navigator & B\_21 & 4\\
\hline
Stratum\_2 & 91 & Patient Navigator & B\_22 & 8\\
\hline
Stratum\_2 & 92 & Control & B\_22 & 8\\
\hline
Stratum\_2 & 93 & Patient Navigator & B\_22 & 8\\
\hline
Stratum\_2 & 94 & Control & B\_22 & 8\\
\hline
Stratum\_2 & 95 & Control & B\_22 & 8\\
\hline
Stratum\_2 & 96 & Patient Navigator & B\_22 & 8\\
\hline
Stratum\_2 & 97 & Control & B\_22 & 8\\
\hline
Stratum\_2 & 98 & Patient Navigator & B\_22 & 8\\
\hline
Stratum\_2 & 99 & Control & B\_23 & 4\\
\hline
Stratum\_2 & 100 & Patient Navigator & B\_23 & 4\\
\hline
Stratum\_3 & 1 & Control & B\_01 & 8\\
\hline
Stratum\_3 & 2 & Patient Navigator & B\_01 & 8\\
\hline
Stratum\_3 & 3 & Patient Navigator & B\_01 & 8\\
\hline
Stratum\_3 & 4 & Control & B\_01 & 8\\
\hline
Stratum\_3 & 5 & Control & B\_01 & 8\\
\hline
Stratum\_3 & 6 & Control & B\_01 & 8\\
\hline
Stratum\_3 & 7 & Patient Navigator & B\_01 & 8\\
\hline
Stratum\_3 & 8 & Patient Navigator & B\_01 & 8\\
\hline
Stratum\_3 & 9 & Control & B\_02 & 4\\
\hline
Stratum\_3 & 10 & Patient Navigator & B\_02 & 4\\
\hline
Stratum\_3 & 11 & Patient Navigator & B\_02 & 4\\
\hline
Stratum\_3 & 12 & Control & B\_02 & 4\\
\hline
Stratum\_3 & 13 & Patient Navigator & B\_03 & 6\\
\hline
Stratum\_3 & 14 & Patient Navigator & B\_03 & 6\\
\hline
Stratum\_3 & 15 & Control & B\_03 & 6\\
\hline
Stratum\_3 & 16 & Patient Navigator & B\_03 & 6\\
\hline
Stratum\_3 & 17 & Control & B\_03 & 6\\
\hline
Stratum\_3 & 18 & Control & B\_03 & 6\\
\hline
Stratum\_3 & 19 & Control & B\_04 & 2\\
\hline
Stratum\_3 & 20 & Patient Navigator & B\_04 & 2\\
\hline
Stratum\_3 & 21 & Control & B\_05 & 2\\
\hline
Stratum\_3 & 22 & Patient Navigator & B\_05 & 2\\
\hline
Stratum\_3 & 23 & Control & B\_06 & 6\\
\hline
Stratum\_3 & 24 & Control & B\_06 & 6\\
\hline
Stratum\_3 & 25 & Patient Navigator & B\_06 & 6\\
\hline
Stratum\_3 & 26 & Control & B\_06 & 6\\
\hline
Stratum\_3 & 27 & Patient Navigator & B\_06 & 6\\
\hline
Stratum\_3 & 28 & Patient Navigator & B\_06 & 6\\
\hline
Stratum\_3 & 29 & Patient Navigator & B\_07 & 6\\
\hline
Stratum\_3 & 30 & Control & B\_07 & 6\\
\hline
Stratum\_3 & 31 & Control & B\_07 & 6\\
\hline
Stratum\_3 & 32 & Control & B\_07 & 6\\
\hline
Stratum\_3 & 33 & Patient Navigator & B\_07 & 6\\
\hline
Stratum\_3 & 34 & Patient Navigator & B\_07 & 6\\
\hline
Stratum\_3 & 35 & Control & B\_08 & 8\\
\hline
Stratum\_3 & 36 & Control & B\_08 & 8\\
\hline
Stratum\_3 & 37 & Control & B\_08 & 8\\
\hline
Stratum\_3 & 38 & Control & B\_08 & 8\\
\hline
Stratum\_3 & 39 & Patient Navigator & B\_08 & 8\\
\hline
Stratum\_3 & 40 & Patient Navigator & B\_08 & 8\\
\hline
Stratum\_3 & 41 & Patient Navigator & B\_08 & 8\\
\hline
Stratum\_3 & 42 & Patient Navigator & B\_08 & 8\\
\hline
Stratum\_3 & 43 & Patient Navigator & B\_09 & 6\\
\hline
Stratum\_3 & 44 & Control & B\_09 & 6\\
\hline
Stratum\_3 & 45 & Control & B\_09 & 6\\
\hline
Stratum\_3 & 46 & Patient Navigator & B\_09 & 6\\
\hline
Stratum\_3 & 47 & Control & B\_09 & 6\\
\hline
Stratum\_3 & 48 & Patient Navigator & B\_09 & 6\\
\hline
Stratum\_3 & 49 & Control & B\_10 & 6\\
\hline
Stratum\_3 & 50 & Patient Navigator & B\_10 & 6\\
\hline
Stratum\_3 & 51 & Control & B\_10 & 6\\
\hline
Stratum\_3 & 52 & Control & B\_10 & 6\\
\hline
Stratum\_3 & 53 & Patient Navigator & B\_10 & 6\\
\hline
Stratum\_3 & 54 & Patient Navigator & B\_10 & 6\\
\hline
Stratum\_3 & 55 & Patient Navigator & B\_11 & 8\\
\hline
Stratum\_3 & 56 & Patient Navigator & B\_11 & 8\\
\hline
Stratum\_3 & 57 & Control & B\_11 & 8\\
\hline
Stratum\_3 & 58 & Control & B\_11 & 8\\
\hline
Stratum\_3 & 59 & Patient Navigator & B\_11 & 8\\
\hline
Stratum\_3 & 60 & Control & B\_11 & 8\\
\hline
Stratum\_3 & 61 & Patient Navigator & B\_11 & 8\\
\hline
Stratum\_3 & 62 & Control & B\_11 & 8\\
\hline
Stratum\_3 & 63 & Control & B\_12 & 6\\
\hline
Stratum\_3 & 64 & Control & B\_12 & 6\\
\hline
Stratum\_3 & 65 & Patient Navigator & B\_12 & 6\\
\hline
Stratum\_3 & 66 & Patient Navigator & B\_12 & 6\\
\hline
Stratum\_3 & 67 & Patient Navigator & B\_12 & 6\\
\hline
Stratum\_3 & 68 & Control & B\_12 & 6\\
\hline
Stratum\_3 & 69 & Patient Navigator & B\_13 & 4\\
\hline
Stratum\_3 & 70 & Patient Navigator & B\_13 & 4\\
\hline
Stratum\_3 & 71 & Control & B\_13 & 4\\
\hline
Stratum\_3 & 72 & Control & B\_13 & 4\\
\hline
Stratum\_3 & 73 & Patient Navigator & B\_14 & 2\\
\hline
Stratum\_3 & 74 & Control & B\_14 & 2\\
\hline
Stratum\_3 & 75 & Control & B\_15 & 6\\
\hline
Stratum\_3 & 76 & Control & B\_15 & 6\\
\hline
Stratum\_3 & 77 & Patient Navigator & B\_15 & 6\\
\hline
Stratum\_3 & 78 & Patient Navigator & B\_15 & 6\\
\hline
Stratum\_3 & 79 & Patient Navigator & B\_15 & 6\\
\hline
Stratum\_3 & 80 & Control & B\_15 & 6\\
\hline
Stratum\_3 & 81 & Control & B\_16 & 4\\
\hline
Stratum\_3 & 82 & Control & B\_16 & 4\\
\hline
Stratum\_3 & 83 & Patient Navigator & B\_16 & 4\\
\hline
Stratum\_3 & 84 & Patient Navigator & B\_16 & 4\\
\hline
Stratum\_3 & 85 & Control & B\_17 & 2\\
\hline
Stratum\_3 & 86 & Patient Navigator & B\_17 & 2\\
\hline
Stratum\_3 & 87 & Patient Navigator & B\_18 & 4\\
\hline
Stratum\_3 & 88 & Control & B\_18 & 4\\
\hline
Stratum\_3 & 89 & Patient Navigator & B\_18 & 4\\
\hline
Stratum\_3 & 90 & Control & B\_18 & 4\\
\hline
Stratum\_3 & 91 & Control & B\_19 & 8\\
\hline
Stratum\_3 & 92 & Control & B\_19 & 8\\
\hline
Stratum\_3 & 93 & Control & B\_19 & 8\\
\hline
Stratum\_3 & 94 & Patient Navigator & B\_19 & 8\\
\hline
Stratum\_3 & 95 & Patient Navigator & B\_19 & 8\\
\hline
Stratum\_3 & 96 & Patient Navigator & B\_19 & 8\\
\hline
Stratum\_3 & 97 & Control & B\_19 & 8\\
\hline
Stratum\_3 & 98 & Patient Navigator & B\_19 & 8\\
\hline
Stratum\_3 & 99 & Control & B\_20 & 4\\
\hline
Stratum\_3 & 100 & Patient Navigator & B\_20 & 4\\
\hline
Stratum\_4 & 1 & Control & B\_01 & 4\\
\hline
Stratum\_4 & 2 & Patient Navigator & B\_01 & 4\\
\hline
Stratum\_4 & 3 & Patient Navigator & B\_01 & 4\\
\hline
Stratum\_4 & 4 & Control & B\_01 & 4\\
\hline
Stratum\_4 & 5 & Control & B\_02 & 2\\
\hline
Stratum\_4 & 6 & Patient Navigator & B\_02 & 2\\
\hline
Stratum\_4 & 7 & Patient Navigator & B\_03 & 2\\
\hline
Stratum\_4 & 8 & Control & B\_03 & 2\\
\hline
Stratum\_4 & 9 & Control & B\_04 & 6\\
\hline
Stratum\_4 & 10 & Patient Navigator & B\_04 & 6\\
\hline
Stratum\_4 & 11 & Patient Navigator & B\_04 & 6\\
\hline
Stratum\_4 & 12 & Control & B\_04 & 6\\
\hline
Stratum\_4 & 13 & Patient Navigator & B\_04 & 6\\
\hline
Stratum\_4 & 14 & Control & B\_04 & 6\\
\hline
Stratum\_4 & 15 & Patient Navigator & B\_05 & 2\\
\hline
Stratum\_4 & 16 & Control & B\_05 & 2\\
\hline
Stratum\_4 & 17 & Patient Navigator & B\_06 & 2\\
\hline
Stratum\_4 & 18 & Control & B\_06 & 2\\
\hline
Stratum\_4 & 19 & Patient Navigator & B\_07 & 4\\
\hline
Stratum\_4 & 20 & Control & B\_07 & 4\\
\hline
Stratum\_4 & 21 & Patient Navigator & B\_07 & 4\\
\hline
Stratum\_4 & 22 & Control & B\_07 & 4\\
\hline
Stratum\_4 & 23 & Patient Navigator & B\_08 & 2\\
\hline
Stratum\_4 & 24 & Control & B\_08 & 2\\
\hline
Stratum\_4 & 25 & Control & B\_09 & 4\\
\hline
Stratum\_4 & 26 & Patient Navigator & B\_09 & 4\\
\hline
Stratum\_4 & 27 & Control & B\_09 & 4\\
\hline
Stratum\_4 & 28 & Patient Navigator & B\_09 & 4\\
\hline
Stratum\_4 & 29 & Patient Navigator & B\_10 & 2\\
\hline
Stratum\_4 & 30 & Control & B\_10 & 2\\
\hline
Stratum\_4 & 31 & Control & B\_11 & 6\\
\hline
Stratum\_4 & 32 & Patient Navigator & B\_11 & 6\\
\hline
Stratum\_4 & 33 & Control & B\_11 & 6\\
\hline
Stratum\_4 & 34 & Patient Navigator & B\_11 & 6\\
\hline
Stratum\_4 & 35 & Control & B\_11 & 6\\
\hline
Stratum\_4 & 36 & Patient Navigator & B\_11 & 6\\
\hline
Stratum\_4 & 37 & Control & B\_12 & 8\\
\hline
Stratum\_4 & 38 & Patient Navigator & B\_12 & 8\\
\hline
Stratum\_4 & 39 & Control & B\_12 & 8\\
\hline
Stratum\_4 & 40 & Control & B\_12 & 8\\
\hline
Stratum\_4 & 41 & Patient Navigator & B\_12 & 8\\
\hline
Stratum\_4 & 42 & Control & B\_12 & 8\\
\hline
Stratum\_4 & 43 & Patient Navigator & B\_12 & 8\\
\hline
Stratum\_4 & 44 & Patient Navigator & B\_12 & 8\\
\hline
Stratum\_4 & 45 & Patient Navigator & B\_13 & 4\\
\hline
Stratum\_4 & 46 & Patient Navigator & B\_13 & 4\\
\hline
Stratum\_4 & 47 & Control & B\_13 & 4\\
\hline
Stratum\_4 & 48 & Control & B\_13 & 4\\
\hline
Stratum\_4 & 49 & Patient Navigator & B\_14 & 4\\
\hline
Stratum\_4 & 50 & Patient Navigator & B\_14 & 4\\
\hline
Stratum\_4 & 51 & Control & B\_14 & 4\\
\hline
Stratum\_4 & 52 & Control & B\_14 & 4\\
\hline
Stratum\_4 & 53 & Patient Navigator & B\_15 & 4\\
\hline
Stratum\_4 & 54 & Patient Navigator & B\_15 & 4\\
\hline
Stratum\_4 & 55 & Control & B\_15 & 4\\
\hline
Stratum\_4 & 56 & Control & B\_15 & 4\\
\hline
Stratum\_4 & 57 & Patient Navigator & B\_16 & 4\\
\hline
Stratum\_4 & 58 & Control & B\_16 & 4\\
\hline
Stratum\_4 & 59 & Patient Navigator & B\_16 & 4\\
\hline
Stratum\_4 & 60 & Control & B\_16 & 4\\
\hline
Stratum\_4 & 61 & Control & B\_17 & 4\\
\hline
Stratum\_4 & 62 & Patient Navigator & B\_17 & 4\\
\hline
Stratum\_4 & 63 & Control & B\_17 & 4\\
\hline
Stratum\_4 & 64 & Patient Navigator & B\_17 & 4\\
\hline
Stratum\_4 & 65 & Control & B\_18 & 6\\
\hline
Stratum\_4 & 66 & Control & B\_18 & 6\\
\hline
Stratum\_4 & 67 & Patient Navigator & B\_18 & 6\\
\hline
Stratum\_4 & 68 & Patient Navigator & B\_18 & 6\\
\hline
Stratum\_4 & 69 & Control & B\_18 & 6\\
\hline
Stratum\_4 & 70 & Patient Navigator & B\_18 & 6\\
\hline
Stratum\_4 & 71 & Patient Navigator & B\_19 & 6\\
\hline
Stratum\_4 & 72 & Control & B\_19 & 6\\
\hline
Stratum\_4 & 73 & Control & B\_19 & 6\\
\hline
Stratum\_4 & 74 & Patient Navigator & B\_19 & 6\\
\hline
Stratum\_4 & 75 & Patient Navigator & B\_19 & 6\\
\hline
Stratum\_4 & 76 & Control & B\_19 & 6\\
\hline
Stratum\_4 & 77 & Control & B\_20 & 6\\
\hline
Stratum\_4 & 78 & Patient Navigator & B\_20 & 6\\
\hline
Stratum\_4 & 79 & Patient Navigator & B\_20 & 6\\
\hline
Stratum\_4 & 80 & Control & B\_20 & 6\\
\hline
Stratum\_4 & 81 & Patient Navigator & B\_20 & 6\\
\hline
Stratum\_4 & 82 & Control & B\_20 & 6\\
\hline
Stratum\_4 & 83 & Patient Navigator & B\_21 & 2\\
\hline
Stratum\_4 & 84 & Control & B\_21 & 2\\
\hline
Stratum\_4 & 85 & Patient Navigator & B\_22 & 6\\
\hline
Stratum\_4 & 86 & Control & B\_22 & 6\\
\hline
Stratum\_4 & 87 & Control & B\_22 & 6\\
\hline
Stratum\_4 & 88 & Control & B\_22 & 6\\
\hline
Stratum\_4 & 89 & Patient Navigator & B\_22 & 6\\
\hline
Stratum\_4 & 90 & Patient Navigator & B\_22 & 6\\
\hline
Stratum\_4 & 91 & Patient Navigator & B\_23 & 6\\
\hline
Stratum\_4 & 92 & Patient Navigator & B\_23 & 6\\
\hline
Stratum\_4 & 93 & Control & B\_23 & 6\\
\hline
Stratum\_4 & 94 & Control & B\_23 & 6\\
\hline
Stratum\_4 & 95 & Control & B\_23 & 6\\
\hline
Stratum\_4 & 96 & Patient Navigator & B\_23 & 6\\
\hline
Stratum\_4 & 97 & Control & B\_24 & 8\\
\hline
Stratum\_4 & 98 & Control & B\_24 & 8\\
\hline
Stratum\_4 & 99 & Patient Navigator & B\_24 & 8\\
\hline
Stratum\_4 & 100 & Control & B\_24 & 8\\
\hline
Stratum\_5 & 1 & Patient Navigator & B\_01 & 2\\
\hline
Stratum\_5 & 2 & Control & B\_01 & 2\\
\hline
Stratum\_5 & 3 & Control & B\_02 & 8\\
\hline
Stratum\_5 & 4 & Control & B\_02 & 8\\
\hline
Stratum\_5 & 5 & Control & B\_02 & 8\\
\hline
Stratum\_5 & 6 & Control & B\_02 & 8\\
\hline
Stratum\_5 & 7 & Patient Navigator & B\_02 & 8\\
\hline
Stratum\_5 & 8 & Patient Navigator & B\_02 & 8\\
\hline
Stratum\_5 & 9 & Patient Navigator & B\_02 & 8\\
\hline
Stratum\_5 & 10 & Patient Navigator & B\_02 & 8\\
\hline
Stratum\_5 & 11 & Patient Navigator & B\_03 & 4\\
\hline
Stratum\_5 & 12 & Patient Navigator & B\_03 & 4\\
\hline
Stratum\_5 & 13 & Control & B\_03 & 4\\
\hline
Stratum\_5 & 14 & Control & B\_03 & 4\\
\hline
Stratum\_5 & 15 & Patient Navigator & B\_04 & 8\\
\hline
Stratum\_5 & 16 & Control & B\_04 & 8\\
\hline
Stratum\_5 & 17 & Patient Navigator & B\_04 & 8\\
\hline
Stratum\_5 & 18 & Control & B\_04 & 8\\
\hline
Stratum\_5 & 19 & Patient Navigator & B\_04 & 8\\
\hline
Stratum\_5 & 20 & Control & B\_04 & 8\\
\hline
Stratum\_5 & 21 & Patient Navigator & B\_04 & 8\\
\hline
Stratum\_5 & 22 & Control & B\_04 & 8\\
\hline
Stratum\_5 & 23 & Control & B\_05 & 6\\
\hline
Stratum\_5 & 24 & Patient Navigator & B\_05 & 6\\
\hline
Stratum\_5 & 25 & Patient Navigator & B\_05 & 6\\
\hline
Stratum\_5 & 26 & Patient Navigator & B\_05 & 6\\
\hline
Stratum\_5 & 27 & Control & B\_05 & 6\\
\hline
Stratum\_5 & 28 & Control & B\_05 & 6\\
\hline
Stratum\_5 & 29 & Control & B\_06 & 6\\
\hline
Stratum\_5 & 30 & Patient Navigator & B\_06 & 6\\
\hline
Stratum\_5 & 31 & Control & B\_06 & 6\\
\hline
Stratum\_5 & 32 & Patient Navigator & B\_06 & 6\\
\hline
Stratum\_5 & 33 & Control & B\_06 & 6\\
\hline
Stratum\_5 & 34 & Patient Navigator & B\_06 & 6\\
\hline
Stratum\_5 & 35 & Control & B\_07 & 2\\
\hline
Stratum\_5 & 36 & Patient Navigator & B\_07 & 2\\
\hline
Stratum\_5 & 37 & Control & B\_08 & 4\\
\hline
Stratum\_5 & 38 & Patient Navigator & B\_08 & 4\\
\hline
Stratum\_5 & 39 & Control & B\_08 & 4\\
\hline
Stratum\_5 & 40 & Patient Navigator & B\_08 & 4\\
\hline
Stratum\_5 & 41 & Patient Navigator & B\_09 & 6\\
\hline
Stratum\_5 & 42 & Patient Navigator & B\_09 & 6\\
\hline
Stratum\_5 & 43 & Patient Navigator & B\_09 & 6\\
\hline
Stratum\_5 & 44 & Control & B\_09 & 6\\
\hline
Stratum\_5 & 45 & Control & B\_09 & 6\\
\hline
Stratum\_5 & 46 & Control & B\_09 & 6\\
\hline
Stratum\_5 & 47 & Patient Navigator & B\_10 & 6\\
\hline
Stratum\_5 & 48 & Control & B\_10 & 6\\
\hline
Stratum\_5 & 49 & Control & B\_10 & 6\\
\hline
Stratum\_5 & 50 & Control & B\_10 & 6\\
\hline
Stratum\_5 & 51 & Patient Navigator & B\_10 & 6\\
\hline
Stratum\_5 & 52 & Patient Navigator & B\_10 & 6\\
\hline
Stratum\_5 & 53 & Patient Navigator & B\_11 & 2\\
\hline
Stratum\_5 & 54 & Control & B\_11 & 2\\
\hline
Stratum\_5 & 55 & Control & B\_12 & 6\\
\hline
Stratum\_5 & 56 & Control & B\_12 & 6\\
\hline
Stratum\_5 & 57 & Patient Navigator & B\_12 & 6\\
\hline
Stratum\_5 & 58 & Patient Navigator & B\_12 & 6\\
\hline
Stratum\_5 & 59 & Patient Navigator & B\_12 & 6\\
\hline
Stratum\_5 & 60 & Control & B\_12 & 6\\
\hline
Stratum\_5 & 61 & Control & B\_13 & 2\\
\hline
Stratum\_5 & 62 & Patient Navigator & B\_13 & 2\\
\hline
Stratum\_5 & 63 & Patient Navigator & B\_14 & 2\\
\hline
Stratum\_5 & 64 & Control & B\_14 & 2\\
\hline
Stratum\_5 & 65 & Patient Navigator & B\_15 & 6\\
\hline
Stratum\_5 & 66 & Patient Navigator & B\_15 & 6\\
\hline
Stratum\_5 & 67 & Patient Navigator & B\_15 & 6\\
\hline
Stratum\_5 & 68 & Control & B\_15 & 6\\
\hline
Stratum\_5 & 69 & Control & B\_15 & 6\\
\hline
Stratum\_5 & 70 & Control & B\_15 & 6\\
\hline
Stratum\_5 & 71 & Patient Navigator & B\_16 & 4\\
\hline
Stratum\_5 & 72 & Patient Navigator & B\_16 & 4\\
\hline
Stratum\_5 & 73 & Control & B\_16 & 4\\
\hline
Stratum\_5 & 74 & Control & B\_16 & 4\\
\hline
Stratum\_5 & 75 & Patient Navigator & B\_17 & 6\\
\hline
Stratum\_5 & 76 & Control & B\_17 & 6\\
\hline
Stratum\_5 & 77 & Patient Navigator & B\_17 & 6\\
\hline
Stratum\_5 & 78 & Control & B\_17 & 6\\
\hline
Stratum\_5 & 79 & Patient Navigator & B\_17 & 6\\
\hline
Stratum\_5 & 80 & Control & B\_17 & 6\\
\hline
Stratum\_5 & 81 & Control & B\_18 & 8\\
\hline
Stratum\_5 & 82 & Patient Navigator & B\_18 & 8\\
\hline
Stratum\_5 & 83 & Control & B\_18 & 8\\
\hline
Stratum\_5 & 84 & Patient Navigator & B\_18 & 8\\
\hline
Stratum\_5 & 85 & Patient Navigator & B\_18 & 8\\
\hline
Stratum\_5 & 86 & Control & B\_18 & 8\\
\hline
Stratum\_5 & 87 & Patient Navigator & B\_18 & 8\\
\hline
Stratum\_5 & 88 & Control & B\_18 & 8\\
\hline
Stratum\_5 & 89 & Patient Navigator & B\_19 & 8\\
\hline
Stratum\_5 & 90 & Control & B\_19 & 8\\
\hline
Stratum\_5 & 91 & Patient Navigator & B\_19 & 8\\
\hline
Stratum\_5 & 92 & Patient Navigator & B\_19 & 8\\
\hline
Stratum\_5 & 93 & Control & B\_19 & 8\\
\hline
Stratum\_5 & 94 & Patient Navigator & B\_19 & 8\\
\hline
Stratum\_5 & 95 & Control & B\_19 & 8\\
\hline
Stratum\_5 & 96 & Control & B\_19 & 8\\
\hline
Stratum\_5 & 97 & Control & B\_20 & 2\\
\hline
Stratum\_5 & 98 & Patient Navigator & B\_20 & 2\\
\hline
Stratum\_5 & 99 & Patient Navigator & B\_21 & 8\\
\hline
Stratum\_5 & 100 & Patient Navigator & B\_21 & 8\\
\hline
\end{tabular}
\end{table}



Add a new chunk by clicking the *Insert Chunk* button on the toolbar or by pressing *Cmd+Option+I*.

When you save the notebook, an HTML file containing the code and output will be saved alongside it (click the *Preview* button or press *Cmd+Shift+K* to preview the HTML file). 

The preview shows you a rendered HTML copy of the contents of the editor. Consequently, unlike *Knit*, *Preview* does not run any R code chunks. Instead, the output of the chunk when it was last run in the editor is displayed.


<!--chapter:end:io19_randomization_blockrand_CAPTURE.Rmd-->

---
title: "Tests with one var, one group"
author: "Peter Higgins"
output: html_document
---

# One variable, single group


#### Continuous value – t test 

#### Challenges for single continuous outcome

#### Estimate single Proportion

#### Challenges for single proportion

<!--chapter:end:io20-one-var-1group-tests.Rmd-->

---
title: "Tests with one var, 2 group"
author: "Peter Higgins"
output: html_document
---

# One variable, two groups


####	Variable 1 is greater in group A vs group B

#####	Test for skew – if not, T test

###### Challenges

#####	If yes, Wilcoxon, non parametric

###### Challenges

####	Variable 2 proportion is greater in group A vs group B

#####	If no rare cells, chi square

###### Challenges

#####	If rare cells, Fischer exact test

###### Challenges

<!--chapter:end:io21-one-var-2group-tests.Rmd-->

---
title: "Tests with one var, multiple group"
author: "Peter Higgins"
output: html_document
---

# One variable, Multiple groups


####	Fun with ANOVA - kind of a waste of time

##### Use regression instead

<!--chapter:end:io22-one-var-Multgroup-tests.Rmd-->

---
title: "Linear Regression and Broom"
author: "Peter Higgins"
output: html_document
---

# Linear Regression


#### Single outcome, multiple possible predictors

##### Challenges

#### One predictor at a time – multiple univariate models – modelr and broom packages

##### Challenges

#### Choosing predictors for multivariate modeling – testing, dealing with collinearity

##### Challenges

#### Multivariate modeling

##### Challenges

#### Model fit checking

##### Challenges

#### presenting model results with RMarkdown

##### Challenges





<!--chapter:end:io23-linear-regression.Rmd-->

---
title: "Sharing your models with Shiny"
author: "Peter Higgins"
output: html_document
---

# Sharing Models with Shiny

#### Basics of Shiny

#### Practice with model from linear regression chapter

<!--chapter:end:io24-sharing-shiny.Rmd-->

---
title: "Logistic Regression"
author: "Peter Higgins"
output: html_document
---

# Logistic Regression


#### Concepts and OR

#### Modeling

#### Estimating GOF

#### AuROC

#### Sens Spec PPV NPV

#### Confusion Matrix

#### Present results with broom, RMarkdown

#### Make user-friendly model predictions with Shiny



<!--chapter:end:io25-logistic-regression.Rmd-->

---
title: "Meta-Analysis"
author: "Peter Higgins"
output: html_document
---

# Meta-Analysis

#### Data search

####	Data collection

####	Data Exclusion

####	Data extraction and checking

####	Using Metafor package

#### Making Figures

####	Writing up results in RMarkdown




<!--chapter:end:io26-meta-analysis.Rmd-->

---
title: "Chisq and basic graphs from mockstudy"
author: "Peter Higgins"
date: "4/25/2019"
output: html_document
---



### Take a look at the data




```r
glimpse(mockstudy)
```

```
## Rows: 1,499
## Columns: 14
## $ case        <int> 110754, 99706, 105271, 105001, 1122...
## $ age         <int> 67, 74, 50, 71, 69, 56, 50, 57, 51,...
## $ arm         <chr> "F: FOLFOX", "A: IFL", "A: IFL", "G...
## $ sex         <fct> Male, Female, Female, Female, Femal...
## $ race        <chr> "Caucasian", "Caucasian", "Caucasia...
## $ fu.time     <int> 922, 270, 175, 128, 233, 120, 369, ...
## $ fu.stat     <int> 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,...
## $ ps          <int> 0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0,...
## $ hgb         <dbl> 11.5, 10.7, 11.1, 12.6, 13.0, 10.2,...
## $ bmi         <dbl> 25.09861, 19.49786, NA, 29.42922, 2...
## $ alk.phos    <int> 160, 290, 700, 771, 350, 569, 162, ...
## $ ast         <int> 35, 52, 100, 68, 35, 27, 16, 12, 25...
## $ mdquality.s <int> NA, 1, 1, 1, NA, 1, 1, 1, 1, 1, NA,...
## $ age.ord     <ord> 60-69, 70-79, 40-49, 70-79, 60-69, ...
```
### Set up a chisquared table
with text interpretation with inline r code.


```r
mockstudy %>% 
  tabyl(arm, fu.stat) ->
outcome_table
names(outcome_table) <- c("Study Arm", "Lived", "Died")
outcome_table %>% 
  gt()
```

\captionsetup[table]{labelformat=empty,skip=1pt}
\begin{longtable}{lrr}
\toprule
Study Arm & Lived & Died \\ 
\midrule
A: IFL & 18 & 410 \\ 
F: FOLFOX & 99 & 592 \\ 
G: IROX & 26 & 354 \\ 
\bottomrule
\end{longtable}



```r
mockstudy %>% 
  tabyl(arm, fu.stat) %>% 
  column_to_rownames('arm') %>% 
  chisq.test() ->
results

results$statistic
```

```
## X-squared 
##  35.66764
```

```r
results$parameter
```

```
## df 
##  2
```

### Study Results

This is a statement of study results. <br>

In the evaluation of followup status by study arm, the null hypothesis of independence was rejected, with a chi-squared statistic of 35.67, with 2 degrees of freedom, and a p value of 0, using the Pearson's Chi-squared test method.



### Start with a barplot
for percent survival
tag it as panel A for a multipanel plot


```r
mockstudy %>% 
  group_by(arm) %>% 
  summarize(surv = length(which(fu.stat==1)),
         died = length(which(fu.stat==2)),
         pct_surv = surv*100/(died+surv)) %>% 
  select(arm, surv, died, pct_surv) %>% 
  ggplot() +
  aes(x=arm, y = pct_surv, fill=arm,
      label= round(pct_surv,1)) +
  geom_bar(stat= 'identity') +
  labs(y= "Percent Survived \n To End of Followup", x= "Study Arm", tag ="A") +
  theme_classic2(base_size = 15) +
  theme(legend.position = 'none') +
  geom_text(size=5, vjust=-0.3) +
  scale_fill_manual(values = c("black", "green", "blue")) +
  ylim(0,18) ->
p1
```

### Now add a boxplot, make it multipanel
tagged as panel B


```r
mockstudy %>% 
  group_by(arm) %>% 
ggplot() +
  aes(x=arm, y = fu.time, fill=arm) +
  geom_violin(alpha =0.3) +
  geom_jitter(width =0.25, alpha=0.15) +
  labs(y= "Survival Time in \nDays (Censored)", x= "Study Arm", tag = "B") +
  theme_classic2(base_size = 15) +
  theme(legend.position = 'none') +
  scale_fill_manual(values = c("black", "green", "blue")) ->
p2

p1 + p2   + plot_layout(ncol=2, heights = c(4,4))
```

![](io28-mockstudy_analysis_chisq_files/figure-latex/survivaltime_boxplot-1.pdf)<!-- --> 



### Now add a survival curve
For some reason, patchwork does not work with this survival curve


```r
survfit(formula = Surv(fu.time, fu.stat) ~ arm, data= mockstudy) ->
fit

ggsurvplot(fit,
           pval = TRUE, conf.int = TRUE,
           risk.table = TRUE,
           risk.table.col = "strata",
           linetype = "strata",
           surv.median.line = "hv",
           ggtheme = theme_bw(),
           palette = c("black", "blue", "gray80")) 
```

```
## Warning: Vectorized input to `element_text()` is not officially supported.
## Results may be unexpected or may change in future versions of ggplot2.
```

![](io28-mockstudy_analysis_chisq_files/figure-latex/survival_curves-1.pdf)<!-- --> 




<!--chapter:end:io28-mockstudy_analysis_chisq.Rmd-->

---
title: "Untitled"
author: "Peter Higgins"
date: "3/21/2019"
output:
  word_document: default
  html_document: default
---







```r
mockstudy %>% 
  tabyl(arm, fu.stat) %>% 
  column_to_rownames('arm') %>% 
  chisq.test() ->
results

results$statistic
```

```
## X-squared 
##  35.66764
```

```r
results$parameter
```

```
## df 
##  2
```

## Study Results

This is an R Markdown document. <br>

In the evaluation of followup status by study arm, the null hypothesis of independence was rejected, with a chi-squared statistic of 35.67, with 2 degrees of freedom, and a p value of 0, using the Pearson's Chi-squared test method.


```
## 
## 	Pearson's Chi-squared test
## 
## data:  .
## X-squared = 1944.5, df = 36, p-value <
## 0.00000000000000022
```

![](io29a-chisq_example_files/figure-latex/corr-1.pdf)<!-- --> 

In the evaluation of household tasks by person responsible, the null hypothesis of independence was rejected, with a chi-squared statistic of 1944.46, with 36 degrees of freedom, and a p value of 0, using the Pearson's Chi-squared test method.


```r
housetasks %>% 
  as.data.frame() %>% 
  rownames_to_column("Task") %>% 
  filter(Task=="Finances" | Task=="Official") %>% 
  select(Task, Wife, Husband) %>% 
  column_to_rownames("Task") %>% 
  chisq.test()
```

```
## 
## 	Pearson's Chi-squared test with Yates' continuity
## 	correction
## 
## data:  .
## X-squared = 0.0082362, df = 1, p-value = 0.9277
```



```
##             Wife Alternating Husband Jointly
## Laundry    7.738       0.272   1.777   2.246
## Main_meal  4.976       0.012   1.243   1.903
## Dinner     2.197       0.073   0.600   0.560
## Breakfeast 1.222       0.615   0.408   1.443
## Tidying    0.149       0.133   1.270   0.661
## Dishes     0.063       0.178   0.891   0.625
## Shopping   0.085       0.090   0.581   0.586
## Official   0.688       3.771   0.010   0.311
## Driving    1.538       2.403   3.374   1.789
## Finances   0.886       0.037   0.028   1.700
## Insurance  1.705       0.941   0.868   1.683
## Repairs    2.919       0.947  21.921   2.275
## Holidays   2.831       1.098   1.233  12.445
```

![](io29a-chisq_example_files/figure-latex/percent-1.pdf)<!-- --> 





<!--chapter:end:io29a-chisq_example.Rmd-->

---
title: "Comparing 2 groups"
author: "Peter Higgins"
date: "1/2/2019"
output: powerpoint_presentation
---



## Comparing Two Measures of Centrality
- Means and Medians
- t tests and wilcoxon
- for numerical continuous data


## Common Problem
- Comparing two groups
  - Mean or median vs. expected
  - Two arms of study - independent
  - Pre and post / spouse and partner / left vs right arm – paired groups
- Are the means significantly different?
- Or the medians (if not normally distributed)?


## How Skewed is Too Skewed?
- Formal test of normality = Shapiro-Wilk test
- Use base data set called ToothGrowth



```r
library(tidyverse)
data <- ToothGrowth
head(data)
```

```
##    len supp dose
## 1  4.2   VC  0.5
## 2 11.5   VC  0.5
## 3  7.3   VC  0.5
## 4  5.8   VC  0.5
## 5  6.4   VC  0.5
## 6 10.0   VC  0.5
```

## Visualize the Distribution of data$len in ggplot
- Use geom_histogram or geom_density
- Bonus points: facet by supplement treatment
- Your turn to try it



![](io30-ttest_files/figure-latex/density-1.pdf)<!-- --> 


```r
data %>% 
ggplot(mapping = aes(len)) +
  geom_histogram() +
  #geom_density() + 
  facet_wrap(~supp)
```

![](io30-ttest_files/figure-latex/histogram-1.pdf)<!-- --> 

## Visualize the Distribution of data$len in ggplot
- The OJ group is left skewed
- May be problematic for using means
- formally test with Shapiro-Wilk

```r
data$len %>% 
shapiro.test()
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  .
## W = 0.96743, p-value = 0.1091
```

## Results of Shapiro-Wilk
- p-value = 0.1091
- p not < 0.05
- Acceptably close to normal
- OK to compare means rather than medians
- can use t test rather than wilcoxon test
  - if p is < 0.05, use wilcoxon test
  - also known as Mann-Whitney test
  - a rank-based (non-parametric) test
  
## Try it yourself
- use df <- msleep

```r
df <- msleep 
head(df$sleep_total)
```

```
## [1] 12.1 17.0 14.4 14.9  4.0 14.4
```
- test the normality of total sleep hours in mammals

## Mammal sleep hours

```r
shapiro.test(df$sleep_total)
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  df$sleep_total
## W = 0.97973, p-value = 0.2143
```
- meets criteria - acceptable to consider normally distributed
- now consider - is the mean roughly 8 hours of sleep per day?

## One Sample T test
- univariate test
  - Ho: mean is 8 hours
  - Ha: mean is not 8 hours
- can use t test because shapiro.test is NS

## How to do One Sample T test

```r
t.test(df$sleep_total, alternative = "two.sided",
       mu = 8)
```
- Try it out, see if you can interpret results

## Interpreting the One Sample T test

```
## 
## 	One Sample t-test
## 
## data:  df$sleep_total
## t = 4.9822, df = 82, p-value = 0.000003437
## alternative hypothesis: true mean is not equal to 8
## 95 percent confidence interval:
##   9.461972 11.405497
## sample estimates:
## mean of x 
##  10.43373
```
- p is highly significant
  - can reject the null, accept alternative
  - sample mean 10.43, CI 9.46-11.41

## What are the arguments of the t.test function?
- x = vector of continuous numerical data
- y= NULL - optional 2nd vector of continuous numerical data
- alternative = c("two.sided", "less", "greater"),
- mu = 0
- paired = FALSE
- var.equal = FALSE
- conf.level = 0.95
- [documentation](https://www.rdocumentation.org/packages/stats/versions/3.5.1/topics/t.test)



## Fine, but what about 2 groups?
- consider df$vore

```r
table(df$vore)
```

```
## 
##   carni   herbi insecti    omni 
##      19      32       5      20
```
- hypothesis - herbivores need more time to get food, sleep less than carnivores
- how to test this?
  - normal, so can use t test for 2 groups
  
## Setting up 2 group t test
- formula interface: outcome ~ groupvar 

```r
df %>% 
  filter(vore %in% c("herbi", "carni")) %>% 
  t.test(formula = sleep_total ~ vore, data = .)
```
- Try it yourself
- What do the results mean?

## Results of the 2 group t test

```
## 
## 	Welch Two Sample t-test
## 
## data:  sleep_total by vore
## t = 0.63232, df = 39.31, p-value = 0.5308
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -1.911365  3.650509
## sample estimates:
## mean in group carni mean in group herbi 
##           10.378947            9.509375
```
## Interpreting the 2 group t test
- Welch t-test (not Student)
  - Welch does NOT assume equal variances in each group
- p value NS
- accept null hypothesis
  - Ho: means of groups roughly equal
  - Ha: means are different
  - 95% CI crosses 0
- Carnivores sleep a little more, but not a lot

## 2 group t test with wide data
- You want to compare column A with column B (data are not tidy)
- Do mammals spend more time awake than asleep?

```r
t.test(x = df$sleep_total, y = df$awake, data = msleep)
```

## Results of 2 group t test with wide data


```r
t.test(x = df$sleep_total, y = df$awake, data = msleep)
```

```
## 
## 	Welch Two Sample t-test
## 
## data:  df$sleep_total and df$awake
## t = -4.5353, df = 164, p-value = 0.00001106
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -4.498066 -1.769404
## sample estimates:
## mean of x mean of y 
##  10.43373  13.56747
```

## 3 Assumptions of Student's t test  
1. Sample is normally distributed (test with Shapiro)
2. Variances are homogeneous (homoskedasticity) (test with Levene)
3. Observations are independent
  + not paired like left vs. right colon
  + not paired like spouse and partner
  + not paired like measurements pre and post Rx
  
## Testing Assumptions of Student's t test  
- Normality - test with Shapiro
  - If not normal, Wilcoxon >  t test
- Equal Variances - test with Levene
  - If not equal, Welch t > Student's t
- Observations are independent
  - Think about data collection
  - are some observations correlated with some others?
  - If correlated, use paired t test
  
## Getting results out of t.test
- Use the tidy function from the broom package
- Do carnivores have bigger brains than insectivores?

```r
df %>% 
  filter(vore %in% c("carni", "insecti")) %>% 
t.test(formula = brainwt ~ vore, data = .) %>% 
  tidy() ->
result
result
```

## Getting results out of t.test


```
## # A tibble: 1 x 9
##   estimate1 estimate2 statistic p.value parameter conf.low
##       <dbl>     <dbl>     <dbl>   <dbl>     <dbl>    <dbl>
## 1    0.0793    0.0216      1.20   0.253        12  -0.0471
## # ... with 3 more variables: conf.high <dbl>, method <chr>,
## #   alternative <chr>
```
## Reporting the results from t.test using inline code
- use backticks before and after, start with r
  - i.e. My result is [backtick]r code here[backtick].
- The mean brain weight for carnivores was 0.0792556
- The mean brain weight for herbivores was 0.02155
  - The difference was 
- The t statistic for this  Two Sample t-test was 1.1995501
- The p value was 0.2534631
  - The confidence interval was from -0.05 to 0.16


## For Next Time  
- Skewness and Kurtosis
- Review Normality
  - When to use Wilcoxon
- Levene test for equal variances
  - When to use Welch t vs. Student's t
- Paired t and Wilcoxon tests

<!--chapter:end:io30-ttest.Rmd-->

---
title: "Comparing 2 groups"
author: "Peter Higgins"
date: "1/2/2019"
output: powerpoint_presentation
---



## Comparing Two Measures of Centrality
- Means and Medians
- t tests and wilcoxon
- for numerical continuous data


## Common Problem
- Comparing two groups
  - Mean or median vs. expected
  - Two arms of study - independent
  - Pre and post / spouse and partner / left vs right arm – paired groups
- Are the means significantly different?
- Or the medians (if not normally distributed)?


## How Skewed is Too Skewed?
- Formal test of normality = Shapiro-Wilk test
- Use base data set called ToothGrowth



```r
library(tidyverse)
data <- ToothGrowth
head(data)
```

```
##    len supp dose
## 1  4.2   VC  0.5
## 2 11.5   VC  0.5
## 3  7.3   VC  0.5
## 4  5.8   VC  0.5
## 5  6.4   VC  0.5
## 6 10.0   VC  0.5
```

## Visualize the Distribution of data$len in ggplot
- Use geom_histogram or geom_density
- Bonus points: facet by supplement treatment
- Your turn to try it



![](io30a-ttest_files/figure-latex/density-1.pdf)<!-- --> 


```r
data %>% 
ggplot(mapping = aes(len)) +
  geom_histogram() +
  #geom_density() + 
  facet_wrap(~supp)
```

![](io30a-ttest_files/figure-latex/histogram-1.pdf)<!-- --> 

## Visualize the Distribution of data$len in ggplot
- The OJ group is left skewed
- May be problematic for using means
- formally test with Shapiro-Wilk

```r
data$len %>% 
shapiro.test()
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  .
## W = 0.96743, p-value = 0.1091
```

## Results of Shapiro-Wilk
- p-value = 0.1091
- p not < 0.05
- Acceptably close to normal
- OK to compare means rather than medians
- can use t test rather than wilcoxon test
  - if p is < 0.05, use wilcoxon test
  - also known as Mann-Whitney test
  - a rank-based (non-parametric) test
  
## Try it yourself
- use df <- msleep

```r
df <- msleep 
head(df$sleep_total)
```

```
## [1] 12.1 17.0 14.4 14.9  4.0 14.4
```
- test the normality of total sleep hours in mammals

## Mammal sleep hours

```r
shapiro.test(df$sleep_total)
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  df$sleep_total
## W = 0.97973, p-value = 0.2143
```
- meets criteria - acceptable to consider normally distributed
- now consider - is the mean roughly 8 hours of sleep per day?

## One Sample T test
- univariate test
  - Ho: mean is 8 hours
  - Ha: mean is not 8 hours
- can use t test because shapiro.test is NS

## How to do One Sample T test

```r
t.test(df$sleep_total, alternative = "two.sided",
       mu = 8)
```
- Try it out, see if you can interpret results

## Interpreting the One Sample T test

```
## 
## 	One Sample t-test
## 
## data:  df$sleep_total
## t = 4.9822, df = 82, p-value = 0.000003437
## alternative hypothesis: true mean is not equal to 8
## 95 percent confidence interval:
##   9.461972 11.405497
## sample estimates:
## mean of x 
##  10.43373
```
- p is highly significant
  - can reject the null, accept alternative
  - sample mean 10.43, CI 9.46-11.41

## What are the arguments of the t.test function?
- x = vector of continuous numerical data
- y= NULL - optional 2nd vector of continuous numerical data
- alternative = c("two.sided", "less", "greater"),
- mu = 0
- paired = FALSE
- var.equal = FALSE
- conf.level = 0.95
- [documentation](https://www.rdocumentation.org/packages/stats/versions/3.5.1/topics/t.test)



## Fine, but what about 2 groups?
- consider df$vore

```r
table(df$vore)
```

```
## 
##   carni   herbi insecti    omni 
##      19      32       5      20
```
- hypothesis - herbivores need more time to get food, sleep less than carnivores
- how to test this?
  - normal, so can use t test for 2 groups
  
## Setting up 2 group t test
- formula interface: outcome ~ groupvar 

```r
df %>% 
  filter(vore %in% c("herbi", "carni")) %>% 
  t.test(formula = sleep_total ~ vore, data = .)
```
- Try it yourself
- What do the results mean?

## Results of the 2 group t test

```
## 
## 	Welch Two Sample t-test
## 
## data:  sleep_total by vore
## t = 0.63232, df = 39.31, p-value = 0.5308
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -1.911365  3.650509
## sample estimates:
## mean in group carni mean in group herbi 
##           10.378947            9.509375
```
## Interpreting the 2 group t test
- Welch t-test (not Student)
  - Welch does NOT assume equal variances in each group
- p value NS
- accept null hypothesis
  - Ho: means of groups roughly equal
  - Ha: means are different
  - 95% CI crosses 0
- Carnivores sleep a little more, but not a lot

## 2 group t test with wide data
- You want to compare column A with column B (data are not tidy)
- Do mammals spend more time awake than asleep?

```r
t.test(x = df$sleep_total, y = df$awake, data = msleep)
```

## Results of 2 group t test with wide data


```r
t.test(x = df$sleep_total, y = df$awake, data = msleep)
```

```
## 
## 	Welch Two Sample t-test
## 
## data:  df$sleep_total and df$awake
## t = -4.5353, df = 164, p-value = 0.00001106
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -4.498066 -1.769404
## sample estimates:
## mean of x mean of y 
##  10.43373  13.56747
```

## 3 Assumptions of Student's t test  
1. Sample is normally distributed (test with Shapiro)
2. Variances are homogeneous (homoskedasticity) (test with Levene)
3. Observations are independent
  + not paired like left vs. right colon
  + not paired like spouse and partner
  + not paired like measurements pre and post Rx
  
## Testing Assumptions of Student's t test  
- Normality - test with Shapiro
  - If not normal, Wilcoxon >  t test
- Equal Variances - test with Levene
  - If not equal, Welch t > Student's t
- Observations are independent
  - Think about data collection
  - are some observations correlated with some others?
  - If correlated, use paired t test
  
## Getting results out of t.test
- Use the tidy function from the broom package
- Do carnivores have bigger brains than insectivores?

```r
df %>% 
  filter(vore %in% c("carni", "insecti")) %>% 
t.test(formula = brainwt ~ vore, data = .) %>% 
  tidy() ->
result
result
```

## Getting results out of t.test


```
## # A tibble: 1 x 9
##   estimate1 estimate2 statistic p.value parameter conf.low
##       <dbl>     <dbl>     <dbl>   <dbl>     <dbl>    <dbl>
## 1    0.0793    0.0216      1.20   0.253        12  -0.0471
## # ... with 3 more variables: conf.high <dbl>, method <chr>,
## #   alternative <chr>
```
## Reporting the results from t.test using inline code
- use backticks before and after, start with r
  - i.e. My result is [backtick]r code here[backtick].
- The mean brain weight for carnivores was 0.0792556
- The mean brain weight for herbivores was 0.02155
  - The difference was 
- The t statistic for this  Two Sample t-test was 1.1995501
- The p value was 0.2534631
  - The confidence interval was from -0.05 to 0.16


## For Next Time  
- Skewness and Kurtosis
- Review Normality
  - When to use Wilcoxon
- Levene test for equal variances
  - When to use Welch t vs. Student's t
- Paired t and Wilcoxon tests

<!--chapter:end:io30a-ttest.Rmd-->

---
title: "Comparing 2 groups"
author: "Peter Higgins"
date: "1/2/2019"
output: powerpoint_presentation
---



## Review from t test part 1
- Comparing Two Measures of Centrality
  - is it normal (Shapiro test)?
    - if yes, use t test
    - if no, use Wilcoxon rank test (nonparametric)
  - are the observations paired?
    - if yes, use paired Wilcoxon or paired t test
    - if no, can use usual versions
  - are the variances equal in 2 groups (Levene test)?
    - if yes, OK to use Student's t test
    - if no, must use Welch t test (unequal var)

## Review how to do t test part 1  
  - one sample
    - t.test(df$sleep_total, alternative = "two.sided",        mu = 8)
  - formula interface: outcome ~ groupvar
df %>%    filter(vore %in% c("herbi", "carni")) %>%    t.test(formula = sleep_total ~ vore, data = .)
  - use broom::tidy() to get results into a dataframe
  - can use results in text with inline code
  - use backticks before and after, start with r
i.e. My result is [backtick]r code here[backtick].


## What We have Left to Cover
- General info on Skewness and Kurtosis
- When to use t tests vs. rank (wilcoxon)
- Levene test for equal variances
  - When to use Welch t vs. Student’s t
- Paired t and Wilcoxon tests


## Skewness
-  A term for asymmetric data - obviously not normal
  - Left-skewed - long leftward tail
  -   aka negatively skewed
    - mean less than the median
    - typical of age at death in US, number of questions answered on a survey, sq_ft/$ in Ann Arbor housing
    - often has a natural upper bound
  - Right-skewed - long rightward tail
    - aka positively skewed
    - mean greater than the median
    - typical of length of stay, medical costs, children per family
    - mostly low, but some huge outliers
    - often has a natural lower bound
    
## Skewness example: Old Faithful geyser eruption duration
- Duration of eruptions in minutes is negatively skewed

```
## 
## Attaching package: 'MASS'
```

```
## The following object is masked from 'package:dplyr':
## 
##     select
```

![](io31-ttest_part2_files/figure-latex/geys-1.pdf)<!-- --> 

## Skewness example: Old Faithful eruption wait times
- Wait time for eruptions in minutes is negatively skewed
![](io31-ttest_part2_files/figure-latex/geyser2-1.pdf)<!-- --> 
## How Skewed is Too Skewed?
- Formal test of normality = Shapiro-Wilk test
- Use base data set called ToothGrowth
- test the len variable


```r
library(tidyverse)
library(MASS)
shapiro.test(geyser$waiting)
```

```
## 
## 	Shapiro-Wilk normality test
## 
## data:  geyser$waiting
## W = 0.93871, p-value = 0.0000000008541
```

## Kurtosis
- Descriptive of how tightly bunched data are
  - leptokurtotic - histogram has tall peak, little spread 
    - think leaping high = lepto
    - values <3 are platykurtotic
  - platykurtotic - histogram is mostly flat, wide spread
    - think flat, like a platypus beak
    - values <3 are platykurtotic
  - kurtosis values ~ 3 are mesokurtotic


```r
library(tidyverse)
library(MASS)
#kurtosis(geyser$waiting)
```
## Decision tree for Comparing 2 group data

1. Is it normal (Shapiro test)?
  - yes - t.test
  - no - wilcoxon
2. Is it paired data?
  - use paired variants of either t.test or wilcoxon
3. If normal, are the variances of the two groups equal (Levene test)?
  - if yes, use Student t test (var.equal=TRUE)
  - if no, use Welch t test (var.equal = FALSE)

## Tooth length data
- We know it is reasonably normal from Shapiro test
  - Ok to use t test
- Should we use the Student version (var.equal) or the Welch version?
  - Welch (var.equal = FALSE) is the default
- Determine this with Levene test for 2 groups (in car package)
  - use Bartlett test if >2 groups and normally distributed


```r
library(tidyverse)
library(car)
data <- ToothGrowth
data %>% 
  filter(dose > 0.9) %>% 
  leveneTest(len ~ as.factor(dose), data = .)
```

```
## Levene's Test for Homogeneity of Variance (center = median)
##       Df F value Pr(>F)
## group  1  1.6144 0.2116
##       38
```

```r
# note has to be as.factor - will not evaluate if groupvar is numeric
```

## Interpretation of Levene's test

- the null hypothesis is that all populations variances are equal;
- the alternative hypothesis is that at least two of them differ.

```
## Levene's Test for Homogeneity of Variance (center = median)
##       Df F value Pr(>F)
## group  1  1.6144 0.2116
##       38
```

- will not reject null, OK to use Student t test

## Arguments for t.test
x = vector of continuous numerical data
alternative = c(“two.sided”, “less”, “greater”),
mu = 0
paired = FALSE
var.equal = FALSE
conf.level = 0.95
Open the t.test help - type in console "?t.test"


## Mammal sleep hours for t test

First with Student t test, compare herbivores to omnivores by sleep_rem

```r
df <- msleep
df %>% 
  filter(vore != 'carni') %>% 
  filter(vore != 'insecti') %>% 
  t.test(sleep_rem ~ vore, data=., var.equal=TRUE)
```

```
## 
## 	Two Sample t-test
## 
## data:  sleep_rem by vore
## t = -1.9638, df = 40, p-value = 0.05653
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -1.19495934  0.01718156
## sample estimates:
## mean in group herbi  mean in group omni 
##            1.366667            1.955556
```

Now with Welch's t test, do the same thing
compare herbivores to omnivores by sleep_rem

```r
df <- msleep
df %>% 
  filter(vore %in% c('omni','herbi')) %>% 
  t.test(sleep_rem ~ vore, data=., var.equal=FALSE)
```

```
## 
## 	Welch Two Sample t-test
## 
## data:  sleep_rem by vore
## t = -1.937, df = 34.768, p-value = 0.06091
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -1.20623797  0.02846019
## sample estimates:
## mean in group herbi  mean in group omni 
##            1.366667            1.955556
```
## Paired T test

```r
library(PairedData)
# matched exposed and control children
# exposed have parents who worked in factory with lead
head(BloodLead)

t.test(x=BloodLead$Exposed, y= BloodLead$Control, paired=TRUE,
       alternative = "two.sided")
```

## Paired Wilcoxon test

```r
library(PairedData)
# matched exposed and control children
# exposed have parents who worked in factory with lead
head(BloodLead)

wilcox.test(x=BloodLead$Exposed, y= BloodLead$Control,
              paired=TRUE,alternative = "two.sided")
```
```
- Try it out, see if you can interpret results


- p is highly significant
  - can reject the null, accept alternative
  - sample mean 10.43, CI 9.46-11.41






<!--chapter:end:io31-ttest_part2.Rmd-->

---
title: "Building Table One for a Clinical Study"
output: html_notebook
author: Peter D.R. Higgins
---

We will start by loading libraries and data.


```r
library(arsenal)
library(knitr)
library(survival)
library(tidyverse)
```

```
## -- Attaching packages ------------- tidyverse 1.3.0 --
```

```
## v ggplot2 3.3.0.9000      v purrr   0.3.4      
## v tibble  3.0.1           v dplyr   0.8.99.9002
## v tidyr   1.0.2           v stringr 1.4.0      
## v readr   1.3.1           v forcats 0.5.0
```

```
## -- Conflicts ---------------- tidyverse_conflicts() --
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
data(mockstudy)
library(magrittr)
```

```
## 
## Attaching package: 'magrittr'
```

```
## The following object is masked from 'package:purrr':
## 
##     set_names
```

```
## The following object is masked from 'package:tidyr':
## 
##     extract
```

```r
library(keyring)
library(REDCapR)
```


```r
dim(mockstudy)
```

```
## [1] 1499   14
```

```r
glimpse(mockstudy)
```

```
## Rows: 1,499
## Columns: 14
## $ case        <int> 110754, 99706, 105271, 105001, 1122...
## $ age         <int> 67, 74, 50, 71, 69, 56, 50, 57, 51,...
## $ arm         <chr> "F: FOLFOX", "A: IFL", "A: IFL", "G...
## $ sex         <fct> Male, Female, Female, Female, Femal...
## $ race        <chr> "Caucasian", "Caucasian", "Caucasia...
## $ fu.time     <int> 922, 270, 175, 128, 233, 120, 369, ...
## $ fu.stat     <int> 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,...
## $ ps          <int> 0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0,...
## $ hgb         <dbl> 11.5, 10.7, 11.1, 12.6, 13.0, 10.2,...
## $ bmi         <dbl> 25.09861, 19.49786, NA, 29.42922, 2...
## $ alk.phos    <int> 160, 290, 700, 771, 350, 569, 162, ...
## $ ast         <int> 35, 52, 100, 68, 35, 27, 16, 12, 25...
## $ mdquality.s <int> NA, 1, 1, 1, NA, 1, 1, 1, 1, 1, NA,...
## $ age.ord     <ord> 60-69, 70-79, 40-49, 70-79, 60-69, ...
```

### Basic Table 1
Let's make a basic Table 1 grouped by arm
with details on sex and age in each group.


```r
#summary by groups
tab1 <- tableby(arm ~ sex + age, data = mockstudy)
summary(tab1, text=TRUE)
```

```
## 
## 
## |             | A: IFL (N=428)  | F: FOLFOX (N=691) | G: IROX (N=380) | Total (N=1499)  | p value|
## |:------------|:---------------:|:-----------------:|:---------------:|:---------------:|-------:|
## |sex          |                 |                   |                 |                 |   0.190|
## |-  Male      |   277 (64.7%)   |    411 (59.5%)    |   228 (60.0%)   |   916 (61.1%)   |        |
## |-  Female    |   151 (35.3%)   |    280 (40.5%)    |   152 (40.0%)   |   583 (38.9%)   |        |
## |Age in Years |                 |                   |                 |                 |   0.614|
## |-  Mean (SD) | 59.673 (11.365) |  60.301 (11.632)  | 59.763 (11.499) | 59.985 (11.519) |        |
## |-  Range     | 27.000 - 88.000 |  19.000 - 88.000  | 26.000 - 85.000 | 19.000 - 88.000 |        |
```
###  Table 1 without groups
Let's make a Table 1 - but ungrouped, with stats on BMI, sex, Age
in each group.


```r
#summary without groups
tab.noby <- tableby(~ bmi + sex +age, data = mockstudy)
summary(tab.noby)
```

```
## 
## 
## |                             | Overall (N=1499) |
## |:----------------------------|:----------------:|
## |**Body Mass Index (kg/m^2)** |                  |
## |&nbsp;&nbsp;&nbsp;N-Miss     |        33        |
## |&nbsp;&nbsp;&nbsp;Mean (SD)  |  27.206 (5.432)  |
## |&nbsp;&nbsp;&nbsp;Range      | 14.053 - 60.243  |
## |**sex**                      |                  |
## |&nbsp;&nbsp;&nbsp;Male       |   916 (61.1%)    |
## |&nbsp;&nbsp;&nbsp;Female     |   583 (38.9%)    |
## |**Age in Years**             |                  |
## |&nbsp;&nbsp;&nbsp;Mean (SD)  | 59.985 (11.519)  |
## |&nbsp;&nbsp;&nbsp;Range      | 19.000 - 88.000  |
```
###  Table 1 grouped, build right hand side
Let's make a Table 1 by arm, with stats on ps, sex, Age
in each group.


```r
myvars <- names(mockstudy)
rhs <- paste(myvars[8:10], collapse = '+')
rhs 
```

```
## [1] "ps+hgb+bmi"
```

```r
as.formula(paste('arm ~', rhs))
```

```
## arm ~ ps + hgb + bmi
```

```r
summary(tableby(as.formula(paste('arm ~', rhs)), data=mockstudy))
```

```
## 
## 
## |                             | A: IFL (N=428)  | F: FOLFOX (N=691) | G: IROX (N=380) | Total (N=1499)  | p value|
## |:----------------------------|:---------------:|:-----------------:|:---------------:|:---------------:|-------:|
## |**ps**                       |                 |                   |                 |                 |   0.903|
## |&nbsp;&nbsp;&nbsp;N-Miss     |       69        |        141        |       56        |       266       |        |
## |&nbsp;&nbsp;&nbsp;Mean (SD)  |  0.529 (0.597)  |   0.547 (0.595)   |  0.537 (0.606)  |  0.539 (0.598)  |        |
## |&nbsp;&nbsp;&nbsp;Range      |  0.000 - 2.000  |   0.000 - 2.000   |  0.000 - 2.000  |  0.000 - 2.000  |        |
## |**hgb**                      |                 |                   |                 |                 |   0.639|
## |&nbsp;&nbsp;&nbsp;N-Miss     |       69        |        141        |       56        |       266       |        |
## |&nbsp;&nbsp;&nbsp;Mean (SD)  | 12.276 (1.686)  |  12.381 (1.763)   | 12.373 (1.680)  | 12.348 (1.719)  |        |
## |&nbsp;&nbsp;&nbsp;Range      | 9.060 - 17.300  |  9.000 - 18.200   | 9.000 - 17.000  | 9.000 - 18.200  |        |
## |**Body Mass Index (kg/m^2)** |                 |                   |                 |                 |   0.892|
## |&nbsp;&nbsp;&nbsp;N-Miss     |        9        |        20         |        4        |       33        |        |
## |&nbsp;&nbsp;&nbsp;Mean (SD)  | 27.290 (5.552)  |  27.210 (5.173)   | 27.106 (5.751)  | 27.206 (5.432)  |        |
## |&nbsp;&nbsp;&nbsp;Range      | 14.053 - 53.008 |  16.649 - 49.130  | 15.430 - 60.243 | 14.053 - 60.243 |        |
```

###  Table 1 digit control
Let's make a Table 1 but now control # of digits


```r
summary(tableby(arm ~ sex + fu.time, data=mockstudy), digits=4, digits.p =2, digits.pct =1)
```

```
## 
## 
## |                            |   A: IFL (N=428)    |  F: FOLFOX (N=691)  |   G: IROX (N=380)   |   Total (N=1499)    | p value|
## |:---------------------------|:-------------------:|:-------------------:|:-------------------:|:-------------------:|-------:|
## |**sex**                     |                     |                     |                     |                     |    0.19|
## |&nbsp;&nbsp;&nbsp;Male      |     277 (64.7%)     |     411 (59.5%)     |     228 (60.0%)     |     916 (61.1%)     |        |
## |&nbsp;&nbsp;&nbsp;Female    |     151 (35.3%)     |     280 (40.5%)     |     152 (40.0%)     |     583 (38.9%)     |        |
## |**fu.time**                 |                     |                     |                     |                     |  < 0.01|
## |&nbsp;&nbsp;&nbsp;Mean (SD) | 553.5841 (419.6065) | 731.2460 (487.7443) | 607.2421 (435.5092) | 649.0841 (462.5109) |        |
## |&nbsp;&nbsp;&nbsp;Range     | 9.0000 - 2170.0000  | 0.0000 - 2472.0000  | 17.0000 - 2118.0000 | 0.0000 - 2472.0000  |        |
```


###  Table 1 out to word document
Let's make a Table 1 and write to MS Word


```r
tab1 <- tableby(arm ~ sex + age, data = mockstudy)
write2word(tab1, file = 'table1.docx')
```

```
## 
## 
## processing file: table1.docx.Rmd
```

```
## 
  |                                                        
  |                                                  |   0%
  |                                                        
  |..................................................| 100%
##   ordinary text without R code
```

```
## output file: table1.docx.knit.md
```

```
## /Applications/RStudio.app/Contents/MacOS/pandoc/pandoc +RTS -K512m -RTS table1.docx.utf8.md --to docx --from markdown+autolink_bare_uris+tex_math_single_backslash+smart --output table1.docx --highlight-style tango --lua-filter /Library/Frameworks/R.framework/Versions/3.6/Resources/library/rmarkdown/rmd/lua/pagebreak.lua
```

```
## 
## Output created: table1.docx
```

###  Table 1 with new data
Let's make a Table 1 with a new dataset from REDCap
We will assign arms 1 and 2, then make a table one


```r
fake_df <- REDCapR::redcap_read_oneshot(
  redcap_uri = "https://bbmc.ouhsc.edu/redcap/api/",  
  token      = "F304DEC3793FECC3B6DEEFF66302CAD3"
)$data
```

```
## 500 records and 13 columns were read from REDCap in 0.5 seconds.  The http status code was 200.
```


```r
#assign arms
fake_df$arm <- c(rep(1,250), rep(2, 250))
fake_df$race<- as.factor(fake_df$race)
```



```r
rhs <- paste(names(fake_df[c(8:11)]), collapse = '+')
tab2 <- summary(tableby(as.formula(paste('arm ~', rhs)), data=fake_df), pfootnote=TRUE)
tab2
```

```
## 
## 
## |                            |     1 (N=250)     |     2 (N=250)     |   Total (N=500)   |  p value|
## |:---------------------------|:-----------------:|:-----------------:|:-----------------:|--------:|
## |**race**                    |                   |                   |                   | 0.625^1^|
## |&nbsp;&nbsp;&nbsp;1         |     12 (4.8%)     |     7 (2.8%)      |     19 (3.8%)     |         |
## |&nbsp;&nbsp;&nbsp;3         |     24 (9.6%)     |    32 (12.8%)     |    56 (11.2%)     |         |
## |&nbsp;&nbsp;&nbsp;4         |    176 (70.4%)    |    176 (70.4%)    |    352 (70.4%)    |         |
## |&nbsp;&nbsp;&nbsp;5         |    31 (12.4%)     |    28 (11.2%)     |    59 (11.8%)     |         |
## |&nbsp;&nbsp;&nbsp;6         |     7 (2.8%)      |     7 (2.8%)      |     14 (2.8%)     |         |
## |**gender**                  |                   |                   |                   | 0.372^2^|
## |&nbsp;&nbsp;&nbsp;Mean (SD) |   0.460 (0.499)   |   0.500 (0.501)   |   0.480 (0.500)   |         |
## |&nbsp;&nbsp;&nbsp;Range     |   0.000 - 1.000   |   0.000 - 1.000   |   0.000 - 1.000   |         |
## |**height**                  |                   |                   |                   | 0.498^2^|
## |&nbsp;&nbsp;&nbsp;Mean (SD) | 173.092 (10.610)  |  172.476 (9.725)  | 172.784 (10.171)  |         |
## |&nbsp;&nbsp;&nbsp;Range     | 142.500 - 204.300 | 142.900 - 205.300 | 142.500 - 205.300 |         |
## |**weight**                  |                   |                   |                   | 0.850^2^|
## |&nbsp;&nbsp;&nbsp;Mean (SD) | 110.356 (22.806)  | 109.940 (26.311)  | 110.148 (24.597)  |         |
## |&nbsp;&nbsp;&nbsp;Range     | 48.000 - 171.000  | 36.000 - 189.000  | 36.000 - 189.000  |         |
## 1. Pearson's Chi-squared test
## 2. Linear Model ANOVA
```

```r
# write2word(tab2, file = 'table3.docx')
# write2html(tab2, "~/table3.html")
```




<!--chapter:end:io33-tableone_arsenal.Rmd-->

---
title: "Chisq and basic graphs from mockstudy"
author: "Peter Higgins"
date: "4/25/2019"
output: html_document
---



### Take a look at the data




```r
glimpse(mockstudy)
```

```
## Rows: 1,499
## Columns: 14
## $ case        <int> 110754, 99706, 105271, 105001, 1122...
## $ age         <int> 67, 74, 50, 71, 69, 56, 50, 57, 51,...
## $ arm         <chr> "F: FOLFOX", "A: IFL", "A: IFL", "G...
## $ sex         <fct> Male, Female, Female, Female, Femal...
## $ race        <chr> "Caucasian", "Caucasian", "Caucasia...
## $ fu.time     <int> 922, 270, 175, 128, 233, 120, 369, ...
## $ fu.stat     <int> 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,...
## $ ps          <int> 0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0,...
## $ hgb         <dbl> 11.5, 10.7, 11.1, 12.6, 13.0, 10.2,...
## $ bmi         <dbl> 25.09861, 19.49786, NA, 29.42922, 2...
## $ alk.phos    <int> 160, 290, 700, 771, 350, 569, 162, ...
## $ ast         <int> 35, 52, 100, 68, 35, 27, 16, 12, 25...
## $ mdquality.s <int> NA, 1, 1, 1, NA, 1, 1, 1, 1, 1, NA,...
## $ age.ord     <ord> 60-69, 70-79, 40-49, 70-79, 60-69, ...
```
### Set up a chisquared table
with text interpretation with inline r code.


```r
mockstudy %>% 
  tabyl(arm, fu.stat) ->
outcome_table
names(outcome_table) <- c("Study Arm", "Lived", "Died")
outcome_table %>% 
  gt()
```

\captionsetup[table]{labelformat=empty,skip=1pt}
\begin{longtable}{lrr}
\toprule
Study Arm & Lived & Died \\ 
\midrule
A: IFL & 18 & 410 \\ 
F: FOLFOX & 99 & 592 \\ 
G: IROX & 26 & 354 \\ 
\bottomrule
\end{longtable}



```r
mockstudy %>% 
  tabyl(arm, fu.stat) %>% 
  column_to_rownames('arm') %>% 
  chisq.test() ->
results

results$statistic
```

```
## X-squared 
##  35.66764
```

```r
results$parameter
```

```
## df 
##  2
```

### Study Results

This is a statement of study results. <br>

In the evaluation of followup status by study arm, the null hypothesis of independence was rejected, with a chi-squared statistic of 35.67, with 2 degrees of freedom, and a p value of 0, using the Pearson's Chi-squared test method.



### Start with a barplot
for percent survival
tag it as panel A for a multipanel plot


```r
mockstudy %>% 
  group_by(arm) %>% 
  summarize(surv = length(which(fu.stat==1)),
         died = length(which(fu.stat==2)),
         pct_surv = surv*100/(died+surv)) %>% 
  select(arm, surv, died, pct_surv) %>% 
  ggplot() +
  aes(x=arm, y = pct_surv, fill=arm) +
  geom_bar(stat= 'identity') +
  labs(y= "Percent Survived", x= "Study Arm", tag ="A") +
  theme_minimal() +
  scale_fill_manual(values = c("black", "blue", "grey80")) ->
p1
```

### Now add a boxplot, make it multipanel
tagged as panel B


```r
mockstudy %>% 
  group_by(arm) %>% 
ggplot() +
  aes(x=arm, y = fu.time, fill=arm) +
  geom_jitter(width =0.25, alpha=0.5) +
  geom_violin(alpha =0.3) +
  labs(y= "Survival Time in \nDays (Censored)", x= "Study Arm", tag = "B") +
  theme_minimal() +
  scale_fill_manual(values = c("black", "blue", "grey80")) ->
p2

p1 + p2   + plot_layout(ncol=1, heights = c(4,4))
```

![](io34-mockstudy_analysis_files/figure-latex/survivaltime_boxplot-1.pdf)<!-- --> 



### Now add a survival curve
For some reason, patchwork does not work with this survival curve


```r
survfit(formula = Surv(fu.time, fu.stat) ~ arm, data= mockstudy) ->
fit

ggsurvplot(fit,
           pval = TRUE, conf.int = TRUE,
           risk.table = TRUE,
           risk.table.col = "strata",
           linetype = "strata",
           surv.median.line = "hv",
           ggtheme = theme_bw(),
           palette = c("red", "blue", "green")) 
```

```
## Warning: Vectorized input to `element_text()` is not officially supported.
## Results may be unexpected or may change in future versions of ggplot2.
```

![](io34-mockstudy_analysis_files/figure-latex/survival_curves-1.pdf)<!-- --> 




<!--chapter:end:io34-mockstudy_analysis.Rmd-->

---
title: "Univariate Predictor Modeling with Purrr"
author: "Peter D.R. Higgins"
output:
  html_document:
    df_print: paged
  html_notebook: default
  pdf_document: default
  word_document: default
---

Let's start by loading libraries.


```r
library(tidyverse)
library(broom)
library(purrr)  
library(knitr)
library(kableExtra)
library(magrittr)
```

We will start with the mtcars dataset, with its many numeric variables.

__Note__ that mtcars is a particularly convenient dataset for modeling. There are no character variables, and no extra (non-predictor) variables to remove. If there are predictors in your dataset that are of type(character), you probably want to convert them to factors, and order them into levels (if they are ordinal, rather than categorical) before modeling. The *forcats* package can be very helpful for this. 

We will plan for modeling to predict the outcome variable, mpg, or miles per gallon. 
Check out all the available predictors below. 

How well will they predict mpg? 
Should you put some of them, or all of them, into a multivariate model?

Usually we look at how well single predictors predict the outcome variable in univariate models, then select the promising ones (p < 0.20, or p < 0.10, depending on how stringent you want to be) to put into a multivariate model.



```r
head(mtcars)
```

```
##                    mpg cyl disp  hp drat    wt  qsec vs am
## Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1
## Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1
## Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1
## Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0
## Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0
## Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0
##                   gear carb
## Mazda RX4            4    4
## Mazda RX4 Wag        4    4
## Datsun 710           4    1
## Hornet 4 Drive       3    1
## Hornet Sportabout    3    2
## Valiant              3    1
```

In an R notebook, you can add a new chunk by clicking the *Insert Chunk* button on the toolbar or by pressing *Cmd+Option+I*.

Now let's look at an example of a single univariate predictor model, using cylinders as the predictor of mpg, using the *lm* function.

With the broom package, we can *tidy* the model to get a dataframe as our output.


```r
model <- mtcars %>% 
  lm(mpg ~ cyl, data = .)
model %>% 
  tidy()
```

```
## # A tibble: 2 x 5
##   term        estimate std.error statistic  p.value
##   <chr>          <dbl>     <dbl>     <dbl>    <dbl>
## 1 (Intercept)    37.9      2.07      18.3  8.37e-18
## 2 cyl            -2.88     0.322     -8.92 6.11e-10
```

We can also use the broom function *glance* to get statistics for the whole model.

```r
model %>% 
  glance()
```

```
## # A tibble: 1 x 11
##   r.squared adj.r.squared sigma statistic  p.value    df
##       <dbl>         <dbl> <dbl>     <dbl>    <dbl> <int>
## 1     0.726         0.717  3.21      79.6 6.11e-10     2
## # ... with 5 more variables: logLik <dbl>, AIC <dbl>,
## #   BIC <dbl>, deviance <dbl>, df.residual <int>
```

Now let's look at testing multiple univariate predictors for mpg - by constructing and summarizing multiple univariate models from one chain of tidy code using the _map_ function from the **purrr** package.

This is a bit complicated.

1. First we define full_df as mtcars, with both predictor variables and the outcome variable, mpg

2. Then we use *select* to remove mpg (our outcome variable), to get a new dataframe of only predictor variables. We will pipe this predictors dataframe (predictors_df) into subsequent functions, but will also retain the ability to call the entire mtcars dataframe (which still includes the outcome variable mpg).

3. Then we *map* the *lm* function over all the predictor variables (.x), using the full data from mtcars, which includes our outcome variable, mpg.

4. We then *tidy* the resulting 10 models and save this as a list of 10 dataframes, each named for their predictor variable.

5. Then we save the predictor variable names from this list to a vector called pred, which we will use later to label the predictors.

6. Then we *bind_rows* (stack the rows) of the tidy dataframes from the 10 models in the list together into a single dataframe, and *filter* out the intercept rows.

7. Then we add a column variable called predictor, and *select* the 3 variables we want, in the proper order.

8. We *arrange* the rows by p value, then save this dataframe as an object called bivariate_table, and display it nicely in HTML with the *kable* function from knitr.


```r
full_df <- mtcars   #1
predictors_df <- mtcars %>%  #2
  dplyr::select(-mpg)

predictors_df %>% 
  map(~lm(full_df$mpg ~ .x, data = full_df)) %>% #3
  map(tidy) -> #4
list

pred <- names(list) #5

list %>% 
  bind_rows() %>% #6
  filter(term != "(Intercept)") %>% 
  mutate(predictor = pred) %>% #7
  select(predictor, estimate, p.value) %>% 
  rename(Predictor = predictor, Estimate = estimate, `P value` = p.value) %>% 
  arrange(`P value`) -> #8
bivariate_table

kable(bivariate_table, digits = 3) %>%
  kable_styling(bootstrap_options = "responsive", full_width = FALSE) %>%
  column_spec(2:3, width = "2.3cm")
```

\begin{table}[H]
\centering
\begin{tabular}{l|>{\raggedleft\arraybackslash}p{2.3cm}|>{\raggedleft\arraybackslash}p{2.3cm}}
\hline
Predictor & Estimate & P value\\
\hline
wt & -5.344 & 0.000\\
\hline
cyl & -2.876 & 0.000\\
\hline
disp & -0.041 & 0.000\\
\hline
hp & -0.068 & 0.000\\
\hline
drat & 7.678 & 0.000\\
\hline
vs & 7.940 & 0.000\\
\hline
am & 7.245 & 0.000\\
\hline
carb & -2.056 & 0.001\\
\hline
gear & 3.923 & 0.005\\
\hline
qsec & 1.412 & 0.017\\
\hline
\end{tabular}
\end{table}



<!--chapter:end:io35-making-univariate-model-tables.Rmd-->

---
title: "Tidying Your Data with Tidyr: Part 1"
author: "Peter Higgins"
date: "7/24/2019"
output: html_document
---



## What is Tidy Data?
 Tidy data is rectangular (rows by columns) data formatted to fit 3 main rules:
 
 1. Each row is a unique observation.
 2. Each column contains a single variable.
 3. Each cell contains only one piece of data - a value or count.
 
![Tidy Data Characteristics](/Users/peterhiggins/Documents/Rcode/teach_rmrwr/tidy-1.png) 
 
<br>and different kinds of observations (usually recorded on distinct clinical report forms, or CRFs) are usually stored in distinct tables.
 
### Tidy data is helpful because: 
 
 1. Most tidyverse and tidyverse-adjacent packages are designed to work on data in tidy data format, and output results in tidy data format.
 2. This standardized format allows packages and functions to work together, taking output from one function as input to another function.
 3. This allows "chaining" or piping (%>%) of functions together to allow you to do more powerful, more complex things with your data quickly and easily, with no friction between functions and data-processing steps.
 4. This allows you to focus on the analysis you want to do, rather than the mechanics of the functions and the data formats.

Tidy data is particularly helpful for R, which treats each column as a vector, because a tidy layout ensures that values of variables (vectors) from the same observation are always matched.

## Standardization and the Tidy Data Manifesto
The original tidy data manifesto, by Hadley Wickham, can be found at (https://vita.had.co.nz/papers/tidy-data.pdf). This was written in part because R, as an open source language, had become a Wild West of data formats, with each package having its own particular data format, so that most functions were unable to work well together without a lot of data fiddling between each pair of functions.

Even with this standardization, lots of clinical data are entered into spreadsheets, because they are ubiquitous and the startup costs are minimal. But spreadsheets also have few to no particular rules - just a wide open blank grid for entering data. 

## The Dangers of Data Freedom

This leads most folks to: 

1. Label and comment on their data, with a lot of text near the top of a spreadsheet (need to skip rows when importing to get to the data)
2. Consider their unit of observation as one patient, and enter longitudinal data with repeated measures in an ever-widening spreadsheet, with sequential observations from left to right, as in the data set below.

![MessyData](/Users/peterhiggins/Documents/Rcode/teach_rmrwr/messydata.png)

<br>
This dataset has some annotation junk in the first 2 rows,
data on the visit number in the 3rd row in merged cells that is hard to access/to assign to observations, and then wide data with repeated measures (which fortunately incorporate the visit number in their names). There is also messiness in the blood pressure values, which actually have two values (systolic and diastolic) in each cell.

## The Many Ways of Messiness
The most common ways that clinical data can be messy include:

1. Column headers are values or categories, not variable names.
2. Multiple variables are stored in one column.
3. Variables are stored in both rows and columns.
4. Multiple types of observational units are stored in the same table.
5. A single observational unit is stored in multiple tables.

Data tidying is the process of taking messy data and converting it to tidy format. As every messy dataset is messy in its own way, this can usually not be automated, but functions in the *tidyr* package make it much easier.

Tidying is one of the key preparation steps in a Data Science workflow, after Importing and before Transforming.

![DataScienceWorkflow](/Users/peterhiggins/Documents/Rcode/teach_rmrwr/data-science-workflow.png)


## Tidying Data
Today we will learn about two *tidyr* functions, 
*pivot_longer*, which addresses multiple repeated longitudinal measures stored in wide format, and
*separate*, which helps you separate multiple values stored in one column into their own distinct variables/columns.

Let's start with *pivot_longer*. Take a look at the included data on 6 patients over 3 visits by running the code chunk below


```r
data
```

```
##   studyid MCS1 MCS2 MCS3     bp1     bp2     bp3
## 1       1   35   37   41  124/83  134/88  122/78
## 2       2   42   44   48  145/96 157/104  127/74
## 3       3   51   54   57  112/62  118/69  103/59
## 4       4   63   67   69  108/48  114/61  102/51
## 5       5   72   76   79 172/117 189/122 159/102
## 6       6   49   53   57  133/77  139/84  129/76
```

In this simple dataset, our intrepid investigator has entered one row per study subject, and 3 measures of the Mental Component Score of the SF-36 on 3 different days, and 3 measures of blood pressure at these visits, numbered 1 through 3.

Ideally, we would have a tidy dataset, in which each row is a distinct observation, with a distinct combination of studyid and visit number, and values for MCS and bp for each unique observation. To truly make this tidy, you would separate bp into two distinct measures - a column for sbp and a column for dbp, as we want one value per data cell.

This would look like the data2 object.
Run the code chunk below to see what this data will look like after Tidying.

```r
data2
```

```
## # A tibble: 18 x 5
##    studyid visit_num   MCS sbp   dbp  
##  *   <dbl> <chr>     <dbl> <chr> <chr>
##  1       1 1            35 124   83   
##  2       1 2            37 134   88   
##  3       1 3            41 122   78   
##  4       2 1            42 145   96   
##  5       2 2            44 157   104  
##  6       2 3            48 127   74   
##  7       3 1            51 112   62   
##  8       3 2            54 118   69   
##  9       3 3            57 103   59   
## 10       4 1            63 108   48   
## 11       4 2            67 114   61   
## 12       4 3            69 102   51   
## 13       5 1            72 172   117  
## 14       5 2            76 189   122  
## 15       5 3            79 159   102  
## 16       6 1            49 133   77   
## 17       6 2            53 139   84   
## 18       6 3            57 129   76
```

## Tidying Like a Real Data Scientist
Let's see how you can do this tidying.
We will use four steps:

1. pivot_longer() for MCS scores
2. pivot_longer() for bp measurements
3. separate()  bp into systolic (sbp) and diastolic (dbp)
4. merge MCS and bp data with dplyr::left_join() into one tidy dataset of 5 columns

### 1. Tidy MCS 
First, we will tidy the MCS scores. <br> 

The *pivot_longer()* function uses four main arguments

1. cols =  sets which columns you want to group together for pivoting to longer format
2. names_to = what the new column name will be in which to collect and keep the information from the old pivoted column names (often a visit number, week, or other time point)
3. names_prefix = what part of the old, pivoted column names is repeated and should be removed
4. values_to = the name of the column in which to keep the values from the cells of the pivoted columns

<br>
1. Run the code below and see what it does. <br> 
Why is this more tidy? <br> 
What do the four arguments mean (google "pivot_longer tidyverse")? <br> 
What other arguments are available? <br> 
2. Run the code up to the select statement, to see what the data look like before selecting.<br> 
2. Experiment with commenting out the names_prefix = 
argument to see what it adds <br> 
3. experiment with using cols = MCS1:MCS3 instead of starts_with <br> 
4. change the names_to to something else <br> 

```r
data %>% 
  pivot_longer(cols = starts_with("MCS"),
               names_to = "visit_num",
               names_prefix = "MCS",
               values_to = "MCS")  %>% 
  select(studyid, visit_num, MCS) ->
mcsdata

mcsdata
```

```
## # A tibble: 18 x 3
##    studyid visit_num   MCS
##      <dbl> <chr>     <dbl>
##  1       1 1            35
##  2       1 2            37
##  3       1 3            41
##  4       2 1            42
##  5       2 2            44
##  6       2 3            48
##  7       3 1            51
##  8       3 2            54
##  9       3 3            57
## 10       4 1            63
## 11       4 2            67
## 12       4 3            69
## 13       5 1            72
## 14       5 2            76
## 15       5 3            79
## 16       6 1            49
## 17       6 2            53
## 18       6 3            57
```

### 2. Tidy bp

Take a look at the BP data above, and use the code chunk below as a template. Edit this code to tidy the bp data. <br> 
Then assign the resulting dataset to bpdata.


```r
data %>% 
  pivot_longer(cols = starts_with("bp"),
               names_to = "visit_num",
               names_prefix = "bp",
               values_to = "bp") %>% 
  select(studyid, visit_num, bp) ->
bpdata

bpdata
```

```
## # A tibble: 18 x 3
##    studyid visit_num bp     
##      <dbl> <chr>     <fct>  
##  1       1 1         124/83 
##  2       1 2         134/88 
##  3       1 3         122/78 
##  4       2 1         145/96 
##  5       2 2         157/104
##  6       2 3         127/74 
##  7       3 1         112/62 
##  8       3 2         118/69 
##  9       3 3         103/59 
## 10       4 1         108/48 
## 11       4 2         114/61 
## 12       4 3         102/51 
## 13       5 1         172/117
## 14       5 2         189/122
## 15       5 3         159/102
## 16       6 1         133/77 
## 17       6 2         139/84 
## 18       6 3         129/76
```

### 3. Separate bp
A problem with the bp data column is that it is messy, storing two values in a common format of SBP/DBP. The forward slash is the separator between the two values. <br> 

Fortunately, tidyr has a function to deal with this sort of problem, called *separate()* <br> 

You just pipe your dataframe into the separate function, which has 3 arguments: <br> 

1. the column that needs to be separated, col = "column2separate"
2. the columns that the new data will go into, into = c("newcol1", "newcol2")
3. The separator, sep = "-" (whatever the separator text is, in quotes) <br> 

Use your bpdata object (edit the code below) and the separate function below to split the BP values. Note - there are arguments that need fixing! <br> 


```r
bpdata %>% 
  separate(col = "bp", into = c("sbp", "dbp"), sep = "/")
```

```
## # A tibble: 18 x 4
##    studyid visit_num sbp   dbp  
##      <dbl> <chr>     <chr> <chr>
##  1       1 1         124   83   
##  2       1 2         134   88   
##  3       1 3         122   78   
##  4       2 1         145   96   
##  5       2 2         157   104  
##  6       2 3         127   74   
##  7       3 1         112   62   
##  8       3 2         118   69   
##  9       3 3         103   59   
## 10       4 1         108   48   
## 11       4 2         114   61   
## 12       4 3         102   51   
## 13       5 1         172   117  
## 14       5 2         189   122  
## 15       5 3         159   102  
## 16       6 1         133   77   
## 17       6 2         139   84   
## 18       6 3         129   76
```

### 4. Merge MCS and bp to make a tidy dataset
 We will use the *left_join()* function from the dplyr package to merget these two subsets together. Each observation is uniquely identifiable by the combination of studyid and visit_num. The combination (in database parlance) is called a *unique key*. This will help you do the merge between mcsdata and bpdata. <br>
 
 We will use the left_join function to merge two datasets. You don't actually need _dplyr::_ here, as we did library(dplyr) in the setup chunk, but I am putting it in to make it clear where the left_join function comes from. As arguments, you just list your two datasets. and left_join figures out the unique key and joins them. The console output tells you what it is using to join them.
 
You can also formally state the unique key that you want with the by argument (see  this illustrated in the second chunk of code below).

The first dataset is used as the starting point, and new columns from the 2nd dataset are added to the right. <br>

See what happens when you change the order of the datasets.
 
 

```r
dplyr::left_join(mcsdata, bpdata2) ->
  data2
```

```
## Joining, by = c("studyid", "visit_num")
```

```r
left_join(bpdata2, mcsdata, by = c("studyid", "visit_num"))
```

```
## # A tibble: 18 x 5
##    studyid visit_num sbp   dbp     MCS
##  *   <dbl> <chr>     <chr> <chr> <dbl>
##  1       1 1         124   83       35
##  2       1 2         134   88       37
##  3       1 3         122   78       41
##  4       2 1         145   96       42
##  5       2 2         157   104      44
##  6       2 3         127   74       48
##  7       3 1         112   62       51
##  8       3 2         118   69       54
##  9       3 3         103   59       57
## 10       4 1         108   48       63
## 11       4 2         114   61       67
## 12       4 3         102   51       69
## 13       5 1         172   117      72
## 14       5 2         189   122      76
## 15       5 3         159   102      79
## 16       6 1         133   77       49
## 17       6 2         139   84       53
## 18       6 3         129   76       57
```
## Challenge round!
you have been provided (below) with a messy clinical dataset with longitudinal repeated data. Your job is to use your new tidying skills to tidy this dataset. This data is from a hypothetical 8 week study of 6 patients with Crohn's disease treated with Amazingmab who get a survey (CDAI - Crohn's Disease Activity Index) score at 0 and 8 weeks, and and endoscopic score (SES-CD - Simple Endoscopic Score for Crohn's Disease) at 0 and 8 weeks. They also vary in whether or not they have ileal or colonic (or both) involvement of active Crohn's disease at baseline.

You should end up with 9 columns for:

1. studyid
2. name
3. enrollment month
4. enrollment year
5. ileal involvement
6. colonic involvement
7. week
8. CDAI
9. SES_CD <br>
<br>
Run the code chunk below to take a look at the data, then get started on _*tidying your data!*_



```r
name <- c("Alice", "Bob", "Cassie", "Doug", "Ellen", "Frank")
studyid <- 1:6
CDAIwk0 <- c(255, 310, 388, 274, 410, 375)
CDAIwk8 <- c(110, 140, 175, 122, 180, 90)
SES_CDwk0 <- c(25, 14, 19, 21, 22, 17)
SES_CDwk8 <- c(7, 4, 6, 8, 7, 5)
ileocolonic <- c('0_1', '1_1', '1_0', '1_1', '1_0', '1_1')
enroll_month <- c("May-18", "Jun-18", 'Sep-18', 'Jan-19', 'Feb-19', 'Apr-19')

challenge <- data.frame(studyid, name, enroll_month, ileocolonic, CDAIwk0, SES_CDwk0, CDAIwk8, SES_CDwk8)

challenge
```

```
##   studyid   name enroll_month ileocolonic CDAIwk0 SES_CDwk0
## 1       1  Alice       May-18         0_1     255        25
## 2       2    Bob       Jun-18         1_1     310        14
## 3       3 Cassie       Sep-18         1_0     388        19
## 4       4   Doug       Jan-19         1_1     274        21
## 5       5  Ellen       Feb-19         1_0     410        22
## 6       6  Frank       Apr-19         1_1     375        17
##   CDAIwk8 SES_CDwk8
## 1     110         7
## 2     140         4
## 3     175         6
## 4     122         8
## 5     180         7
## 6      90         5
```


```r
challenge %>% 
  pivot_longer(cols = starts_with("CDAI"),
               names_to = "Week",
               values_to = "CDAI",
               names_prefix = "CDAIwk") %>% 
  select(studyid, Week, CDAI) ->
cdai_data

challenge %>% 
  pivot_longer(cols = starts_with("SES"),
               names_to = "Week",
               values_to = "SES_CD",
               names_prefix = "SES_CDwk") %>% 
  select(studyid, Week, SES_CD) ->
ses_data

challenge %>% 
  select(studyid:ileocolonic) %>% 
  left_join(cdai_data) %>% 
  left_join(ses_data) %>% 
  separate(col = "enroll_month", into = c("month", "year"), sep = "-") %>% 
  separate(col = "ileocolonic", into = c("ileal", "colonic"), sep = "_") 
```

```
## Joining, by = "studyid"
```

```
## Joining, by = c("studyid", "Week")
```

```
##    studyid   name month year ileal colonic Week CDAI SES_CD
## 1        1  Alice   May   18     0       1    0  255     25
## 2        1  Alice   May   18     0       1    8  110      7
## 3        2    Bob   Jun   18     1       1    0  310     14
## 4        2    Bob   Jun   18     1       1    8  140      4
## 5        3 Cassie   Sep   18     1       0    0  388     19
## 6        3 Cassie   Sep   18     1       0    8  175      6
## 7        4   Doug   Jan   19     1       1    0  274     21
## 8        4   Doug   Jan   19     1       1    8  122      8
## 9        5  Ellen   Feb   19     1       0    0  410     22
## 10       5  Ellen   Feb   19     1       0    8  180      7
## 11       6  Frank   Apr   19     1       1    0  375     17
## 12       6  Frank   Apr   19     1       1    8   90      5
```


<!--chapter:end:io36-tidyr1.Rmd-->

---
title: "Tidying Your Data with Tidyr: Part 2"
author: "Peter Higgins"
date: "8/1/2019"
output: html_document
---



## Review: What is Tidy Data?
 Tidy data is rectangular (rows by columns) data formatted to fit 3 main rules:
 
 1. Each row is a unique observation.
 2. Each column contains a single variable.
 3. Each cell contains only one piece of data - a value or count.
 
![Tidy Data Characteristics](tidy-1.png) 
 
<br>and different kinds of observations (usually recorded on distinct clinical report forms, or CRFs) are usually stored in distinct tables.
 
### Tidy data is helpful because: 
 
 1. Most tidyverse and tidyverse-adjacent packages are designed to work on data in tidy data format, and output results in tidy data format.
 2. This standardized format allows packages and functions to work together, taking output from one function as input to another function.
 3. This allows "chaining" or piping (%>%) of functions together to allow you to do more powerful, more complex things with your data quickly and easily, with no friction between functions and data-processing steps.
 4. This allows you to focus on the analysis you want to do, rather than the mechanics of the functions and the data formats.

Tidy data is particularly helpful for R, which treats each column as a vector, because a tidy layout ensures that values of variables (vectors) from the same observation are always matched.

Tidying is one of the key preparation steps in a Data Science workflow, after Importing and before Transforming.

![DataScienceWorkflow](/Users/peterhiggins/Documents/Rcode/teach_rmrwr/data-science-workflow.png)


## Tidying Data
Today we will review *pivot_longer* and *separate()*, and
learn about new *tidyr* functions, 

1. *pivot_wider()*, which does the reverse of *pivot_longer()*
2. *unite()*, which does the opposite of *separate()*
3. *separate_rows*, which addresses when you have a variable number of multiple values of the same type in one cell. One common examples is a list of medications (i.e. HCTZ, claritin, propanolol, enalapril) in a single cell.
4. *uncount*, which takes a summary of counts, and returns these to individual rows of observations (the reverse of *count*)
5. *nest()*, which allows you to group data by categorical factor variables and collect the remaining variables into a dataframe (in a list column!) for each row. This allows you to do complex operations (i.e. linear regressions) on each dataframe.
6. *unnest()* which restores your nested data to individual observations.

### 1. Review of pivot_longer
Let's start with a review of *pivot_longer*. Take a look at the included pivotdx data on 6 recently hospitalized patients with multiple diagnoses by running the code chunk below.


```r
name <- c("Alice", "Bob", "Cassie", "Doug", "Ellen", "Frank")
studyid <- 1:6
dx1 <- c("J15.0", "J13", "J15.7", "J18.9", "J13", "J18.9")
dx2 <- c("K51.8", "K51.50", "K51.911", "K50.80", "K50.0", "K50.90")
dx3 <- c("Z92.25", "Z92.25", "Z92.25", "Z92.25", "Z92.25", "Z92.25")
dx4 <- c("D68.69", "D68.69", NA, "D68.69", "D68.69", "D68.69")
dx5 <- c(NA, "N17.0", NA, "N17.0", "N17.0", "N17.0")
dx6 <- c(NA, "I82.409", NA, "I82.409", "I82.409", NA)
dx7 <- c(NA, "F33.0", NA, "N39.0", NA, NA)
pivotdx <- data.frame(studyid, name, dx1, dx2, dx3, dx4, dx5, dx6, dx7)

pivotdx
```

```
##   studyid   name   dx1     dx2    dx3    dx4   dx5     dx6
## 1       1  Alice J15.0   K51.8 Z92.25 D68.69  <NA>    <NA>
## 2       2    Bob   J13  K51.50 Z92.25 D68.69 N17.0 I82.409
## 3       3 Cassie J15.7 K51.911 Z92.25   <NA>  <NA>    <NA>
## 4       4   Doug J18.9  K50.80 Z92.25 D68.69 N17.0 I82.409
## 5       5  Ellen   J13   K50.0 Z92.25 D68.69 N17.0 I82.409
## 6       6  Frank J18.9  K50.90 Z92.25 D68.69 N17.0    <NA>
##     dx7
## 1  <NA>
## 2 F33.0
## 3  <NA>
## 4 N39.0
## 5  <NA>
## 6  <NA>
```
This is a common data format for hospitalizations and patient encounters.
Everyone has at least one ICD-10 diagnosis, but some have as many as 15, while others may only have 3.
This is untidy because the diagnoses should be in a single column, dx.

Your challenge is to use *pivot_longer* to tidy this dataset.

Remember that the *pivot_longer()* function uses four main arguments

1. cols =  sets which columns you want to group together for pivoting to longer format
2. names_to = what the new column name will be in which to collect and keep the information from the old pivoted column names (often a visit number, week, or other time point)
3. names_prefix = what part of the old, pivoted column names is repeated and should be removed
4. values_to = the name of the column in which to keep the values from the cells of the pivoted columns

and when you have NAs, you want to add the argument <br>
values_drop_na = TRUE <br>
to the pivot_longer() function.

Edit the code block below to tidy the pivotdx data and assign the result to tidydx.
Assign the diagnosis number to dx_num.


```r
pivotdx %>% 
  pivot_longer(cols = starts_with("dx"),
               names_to = "dx_num",
               names_prefix = "dx",
               values_to = "diagnosis",
               values_drop_na = TRUE)  ->
tidydx

tidydx
```

```
## # A tibble: 32 x 4
##    studyid name  dx_num diagnosis
##      <int> <fct> <chr>  <fct>    
##  1       1 Alice 1      J15.0    
##  2       1 Alice 2      K51.8    
##  3       1 Alice 3      Z92.25   
##  4       1 Alice 4      D68.69   
##  5       2 Bob   1      J13      
##  6       2 Bob   2      K51.50   
##  7       2 Bob   3      Z92.25   
##  8       2 Bob   4      D68.69   
##  9       2 Bob   5      N17.0    
## 10       2 Bob   6      I82.409  
## # ... with 22 more rows
```

### 2. Review of separate()

Take a look at the blood pressure data by running to code chunk below. Edit this code to separate the bp data into sbp and dbp variables.

Remember that the *separate()* function has 3 arguments: <br> 

1. the column that needs to be separated, col = "column2separate"
2. the columns that the new data will go into, into = c("newcol1", "newcol2")
3. The separator, sep = "-" (whatever the separator text is, in quotes) <br> 

Edit the code chunk below, replacing the *head()* function and using the *separate()* function to replace the bp column with sbp and dbp.


```r
data %>% 
  pivot_longer(cols = starts_with("bp"),
               names_to = "visit_num",
               names_prefix = "bp",
               values_to = "bp") %>% 
  select(studyid, visit_num, bp) ->
bpdata

bpdata %>% 
  separate(col = "bp",
           into = c("sbp", "dbp"),
           sep = "/")
```

```
## # A tibble: 18 x 4
##    studyid visit_num sbp   dbp  
##      <dbl> <chr>     <chr> <chr>
##  1       1 1         124   83   
##  2       1 2         134   88   
##  3       1 3         122   78   
##  4       2 1         145   96   
##  5       2 2         157   104  
##  6       2 3         127   74   
##  7       3 1         112   62   
##  8       3 2         118   69   
##  9       3 3         103   59   
## 10       4 1         108   48   
## 11       4 2         114   61   
## 12       4 3         102   51   
## 13       5 1         172   117  
## 14       5 2         189   122  
## 15       5 3         159   102  
## 16       6 1         133   77   
## 17       6 2         139   84   
## 18       6 3         129   76
```


### 3. Use separate_rows to tidy a medications column.

It is common to have a data query that results in a list of medications in a single common, often separated by commas.
Each patient will have a variable number of medications, and you want a tidy single column of medications, which requires the *separate_rows()* function.
 
The *separate_rows()* function has 3 arguments: <br> 

1. the dataframe (if not piped in already)
2. the name of the column or columns that need to be separated, using the syntax from dplyr::select() - i.e. unquoted list with commas, column1:column4, starts_with(med), etc.
3. The separator, sep = "-" (whatever the separator text is, in quotes, default is comma) 
4. convert =TRUE  will convert data types if needed <br> 

Edit the code chunk below to make the medications column tidy.
 
 

```r
name <- c("Alice", "Bob", "Cassie", "Doug", "Ellen", "Frank")
studyid <- 1:6
medications <- c("propanolol, HCTZ, aspirin", 
                 "enalapril, aspirin, clonidine, sumatriptan", 
                 "aspirin, ramipril, HCTZ, hydrocortisone", 
                 "atorvastatin, aspirin, synthroid", 
                 "albuterol, oxycodone, pravastatin, synthroid, omeprazole",                   "crestor, lantus, HCTZ, lyrica, januvia")

meds <- data.frame(studyid, name, medications)

meds %>% 
  separate_rows("medications",
                sep = ",")
```

```
##    studyid   name     medications
## 1        1  Alice      propanolol
## 2        1  Alice            HCTZ
## 3        1  Alice         aspirin
## 4        2    Bob       enalapril
## 5        2    Bob         aspirin
## 6        2    Bob       clonidine
## 7        2    Bob     sumatriptan
## 8        3 Cassie         aspirin
## 9        3 Cassie        ramipril
## 10       3 Cassie            HCTZ
## 11       3 Cassie  hydrocortisone
## 12       4   Doug    atorvastatin
## 13       4   Doug         aspirin
## 14       4   Doug       synthroid
## 15       5  Ellen       albuterol
## 16       5  Ellen       oxycodone
## 17       5  Ellen     pravastatin
## 18       5  Ellen       synthroid
## 19       5  Ellen      omeprazole
## 20       6  Frank         crestor
## 21       6  Frank          lantus
## 22       6  Frank            HCTZ
## 23       6  Frank          lyrica
## 24       6  Frank         januvia
```

### 4. Using *uncount()*
Uncount takes a dataframe that is a summary of counts, and returns these to individual rows of observations (the reverse of *count*).

Run the code chunk below to review the sex and primary diagnoses of patients in two weeks of a busy IBD clinic.

To return this summary table (made with group_by and count) to individual tidy observations, use the *uncount()* function.

The three arguments for uncount are

1. the data frame (unless piped in)
2. the weights for each group (often a variable named count or n)
3. .id = A string if you want to generate a unique id for each observation. The string will be the name of the new column, i.e.   .id ="studyid"

Note that *uncount()* will automatically generate rownames consisting of category # and the number in that group (i.e. 3.46). These can be moved to a useful column by piping the result of uncount() to the function <br>
*rownames_to_column(var = "rowname")* from the *tibble* package
<br>
Try adding this line to your code

Alternatively, you can pipe your result into <br>
remove_rownames()


```r
library(tibble)
sex <- c("Male", "Female", "Male", "Female", "Male", "Female")
primarydx <- c("Crohn's disease", "Ulcerative colitis", "Microscopic Colitis")
count <- c(58, 61, 71, 59, 19, 84)

counts <- data.frame(sex, primarydx, count)

counts %>% 
  uncount(count, .id ="studyid") %>% 
  rownames_to_column(var = "number")
```

```
##     number    sex          primarydx studyid
## 1        1   Male    Crohn's disease       1
## 2      1.1   Male    Crohn's disease       2
## 3      1.2   Male    Crohn's disease       3
## 4      1.3   Male    Crohn's disease       4
## 5      1.4   Male    Crohn's disease       5
## 6      1.5   Male    Crohn's disease       6
## 7      1.6   Male    Crohn's disease       7
## 8      1.7   Male    Crohn's disease       8
## 9      1.8   Male    Crohn's disease       9
## 10     1.9   Male    Crohn's disease      10
## 11    1.10   Male    Crohn's disease      11
## 12    1.11   Male    Crohn's disease      12
## 13    1.12   Male    Crohn's disease      13
## 14    1.13   Male    Crohn's disease      14
## 15    1.14   Male    Crohn's disease      15
## 16    1.15   Male    Crohn's disease      16
## 17    1.16   Male    Crohn's disease      17
## 18    1.17   Male    Crohn's disease      18
## 19    1.18   Male    Crohn's disease      19
## 20    1.19   Male    Crohn's disease      20
## 21    1.20   Male    Crohn's disease      21
## 22    1.21   Male    Crohn's disease      22
## 23    1.22   Male    Crohn's disease      23
## 24    1.23   Male    Crohn's disease      24
## 25    1.24   Male    Crohn's disease      25
## 26    1.25   Male    Crohn's disease      26
## 27    1.26   Male    Crohn's disease      27
## 28    1.27   Male    Crohn's disease      28
## 29    1.28   Male    Crohn's disease      29
## 30    1.29   Male    Crohn's disease      30
## 31    1.30   Male    Crohn's disease      31
## 32    1.31   Male    Crohn's disease      32
## 33    1.32   Male    Crohn's disease      33
## 34    1.33   Male    Crohn's disease      34
## 35    1.34   Male    Crohn's disease      35
## 36    1.35   Male    Crohn's disease      36
## 37    1.36   Male    Crohn's disease      37
## 38    1.37   Male    Crohn's disease      38
## 39    1.38   Male    Crohn's disease      39
## 40    1.39   Male    Crohn's disease      40
## 41    1.40   Male    Crohn's disease      41
## 42    1.41   Male    Crohn's disease      42
## 43    1.42   Male    Crohn's disease      43
## 44    1.43   Male    Crohn's disease      44
## 45    1.44   Male    Crohn's disease      45
## 46    1.45   Male    Crohn's disease      46
## 47    1.46   Male    Crohn's disease      47
## 48    1.47   Male    Crohn's disease      48
## 49    1.48   Male    Crohn's disease      49
## 50    1.49   Male    Crohn's disease      50
## 51    1.50   Male    Crohn's disease      51
## 52    1.51   Male    Crohn's disease      52
## 53    1.52   Male    Crohn's disease      53
## 54    1.53   Male    Crohn's disease      54
## 55    1.54   Male    Crohn's disease      55
## 56    1.55   Male    Crohn's disease      56
## 57    1.56   Male    Crohn's disease      57
## 58    1.57   Male    Crohn's disease      58
## 59       2 Female Ulcerative colitis       1
## 60     2.1 Female Ulcerative colitis       2
## 61     2.2 Female Ulcerative colitis       3
## 62     2.3 Female Ulcerative colitis       4
## 63     2.4 Female Ulcerative colitis       5
## 64     2.5 Female Ulcerative colitis       6
## 65     2.6 Female Ulcerative colitis       7
## 66     2.7 Female Ulcerative colitis       8
## 67     2.8 Female Ulcerative colitis       9
## 68     2.9 Female Ulcerative colitis      10
## 69    2.10 Female Ulcerative colitis      11
## 70    2.11 Female Ulcerative colitis      12
## 71    2.12 Female Ulcerative colitis      13
## 72    2.13 Female Ulcerative colitis      14
## 73    2.14 Female Ulcerative colitis      15
## 74    2.15 Female Ulcerative colitis      16
## 75    2.16 Female Ulcerative colitis      17
## 76    2.17 Female Ulcerative colitis      18
## 77    2.18 Female Ulcerative colitis      19
## 78    2.19 Female Ulcerative colitis      20
## 79    2.20 Female Ulcerative colitis      21
## 80    2.21 Female Ulcerative colitis      22
## 81    2.22 Female Ulcerative colitis      23
## 82    2.23 Female Ulcerative colitis      24
## 83    2.24 Female Ulcerative colitis      25
## 84    2.25 Female Ulcerative colitis      26
## 85    2.26 Female Ulcerative colitis      27
## 86    2.27 Female Ulcerative colitis      28
## 87    2.28 Female Ulcerative colitis      29
## 88    2.29 Female Ulcerative colitis      30
## 89    2.30 Female Ulcerative colitis      31
## 90    2.31 Female Ulcerative colitis      32
## 91    2.32 Female Ulcerative colitis      33
## 92    2.33 Female Ulcerative colitis      34
## 93    2.34 Female Ulcerative colitis      35
## 94    2.35 Female Ulcerative colitis      36
## 95    2.36 Female Ulcerative colitis      37
## 96    2.37 Female Ulcerative colitis      38
## 97    2.38 Female Ulcerative colitis      39
## 98    2.39 Female Ulcerative colitis      40
## 99    2.40 Female Ulcerative colitis      41
## 100   2.41 Female Ulcerative colitis      42
##  [ reached 'max' / getOption("max.print") -- omitted 252 rows ]
```

### 5. Nesting some of your data

The *nest()* function allows you to group data by categorical factor variables and collect the remaining variables into a dataframe (in a list column!) for each row. This allows you to do complex operations (i.e. linear regressions) on each dataframe.

As our first example, let's see how this works with the gapminder dataset.
Run the code below, then view (in the Environment tab, by clicking on the dataset names) both the original gapminder dataset, and gap_nested to see the difference from nesting. 
<br>
Click on the dataframes in the individual cells of the gap_nested dataframe to see how they actually contain their own dataframes (inside a column) for that particular country.
<br>
The dataframes are nested inside a special kind of column, called a list-column, within the gap_nested dataframe.
<br>
This is a bit like Russian nesting dolls. If you glimpse(gap_nested), you will see that this column has the type *list<df[,4]>* meaning that it contains dataframes with varying numbers of rows and 4 columns.
<br>
This nested data format allows you to do complex things, like generate linear models for all 142 countries in gap_nested to show the relationship between gdpPercap and lifeExp (life expectancy) in each country, and store the slopes and intercepts as variables in the gap_nested dataframe.


```r
library(gapminder)
gapminder <- gapminder::gapminder
gapminder
```

```
## # A tibble: 1,704 x 6
##    country     continent  year lifeExp      pop gdpPercap
##    <fct>       <fct>     <int>   <dbl>    <int>     <dbl>
##  1 Afghanistan Asia       1952    28.8  8425333      779.
##  2 Afghanistan Asia       1957    30.3  9240934      821.
##  3 Afghanistan Asia       1962    32.0 10267083      853.
##  4 Afghanistan Asia       1967    34.0 11537966      836.
##  5 Afghanistan Asia       1972    36.1 13079460      740.
##  6 Afghanistan Asia       1977    38.4 14880372      786.
##  7 Afghanistan Asia       1982    39.9 12881816      978.
##  8 Afghanistan Asia       1987    40.8 13867957      852.
##  9 Afghanistan Asia       1992    41.7 16317921      649.
## 10 Afghanistan Asia       1997    41.8 22227415      635.
## # ... with 1,694 more rows
```

```r
gapminder %>% 
  group_by(country, continent) %>% 
  nest() ->
gap_nested

gap_nested
```

```
## # A tibble: 142 x 3
## # Groups:   country, continent [142]
##    country     continent data             
##    <fct>       <fct>     <list>           
##  1 Afghanistan Asia      <tibble [12 x 4]>
##  2 Albania     Europe    <tibble [12 x 4]>
##  3 Algeria     Africa    <tibble [12 x 4]>
##  4 Angola      Africa    <tibble [12 x 4]>
##  5 Argentina   Americas  <tibble [12 x 4]>
##  6 Australia   Oceania   <tibble [12 x 4]>
##  7 Austria     Europe    <tibble [12 x 4]>
##  8 Bahrain     Asia      <tibble [12 x 4]>
##  9 Bangladesh  Asia      <tibble [12 x 4]>
## 10 Belgium     Europe    <tibble [12 x 4]>
## # ... with 132 more rows
```

In the chunk below, we will illustrate how to use the nested dataframes to make 142 linear models.
Run it to see the result.


```r
library(purrr)
```

```
## 
## Attaching package: 'purrr'
```

```
## The following object is masked from 'package:magrittr':
## 
##     set_names
```

```r
library(broom)
library(ggplot2)
library(forcats)
gap_nested  %>% 
  mutate(model = map(data, ~lm(lifeExp ~ gdpPercap, data = .x))) ->
models

models %>% mutate(glance  = map(model, glance),
         tidy    = map(model, tidy),
         augment = map(model, augment),
         rsq     = map_dbl(glance, "r.squared")) ->
models2

models2 %>% 
  arrange(desc(rsq)) %>% 
  ggplot(aes(x= fct_reorder(country, rsq), y = rsq, color= continent)) +
  geom_point() +
  coord_flip()
```

![](io37-tidyr2_files/figure-latex/unnamed-chunk-2-1.pdf)<!-- --> 


### 6. Unnest simply reverses the nesting step
This restores your dataframe to a tidy state, with one observation per row. 
Try this out with gap_nested below.

The arguments for unnest have good defaults, so you can often run *unnest(dataframe)* without any other arguments.

But it is possible to use 
.preserve = list-column_name (usually data) to keep particular list columns while unnesting the rest of them (if you have more than one list column)
.drop = TRUE is the default, to drop all list columns after they are unnested.

Edit the code below to unnest gap_nested. <br>
You should get the original gapminder dataset back.


```r
gap_nested %>% 
  unnest()
```

```
## Warning: `cols` is now required.
## Please use `cols = c(data)`
```

```
## # A tibble: 1,704 x 6
## # Groups:   country, continent [142]
##    country     continent  year lifeExp      pop gdpPercap
##    <fct>       <fct>     <int>   <dbl>    <int>     <dbl>
##  1 Afghanistan Asia       1952    28.8  8425333      779.
##  2 Afghanistan Asia       1957    30.3  9240934      821.
##  3 Afghanistan Asia       1962    32.0 10267083      853.
##  4 Afghanistan Asia       1967    34.0 11537966      836.
##  5 Afghanistan Asia       1972    36.1 13079460      740.
##  6 Afghanistan Asia       1977    38.4 14880372      786.
##  7 Afghanistan Asia       1982    39.9 12881816      978.
##  8 Afghanistan Asia       1987    40.8 13867957      852.
##  9 Afghanistan Asia       1992    41.7 16317921      649.
## 10 Afghanistan Asia       1997    41.8 22227415      635.
## # ... with 1,694 more rows
```

## Challenge round!
you have been provided (below) with a messy clinical dataset with longitudinal repeated data. Your job is to use your new tidying skills to tidy this dataset. This data is from a hypothetical 8 week study of 6 patients with Crohn's disease treated with Amazingmab who get a survey (CDAI - Crohn's Disease Activity Index) score at 0 and 8 weeks, and and endoscopic score (SES-CD - Simple Endoscopic Score for Crohn's Disease) at 0 and 8 weeks. They also vary in whether or not they have ileal or colonic (or both) involvement of active Crohn's disease at baseline.

You should end up with 9 columns for:

1. studyid
2. name
3. enrollment month
4. enrollment year
5. ileal involvement
6. colonic involvement
7. week
8. CDAI
9. SES_CD <br>
<br>
Run the code chunk below to take a look at the data, then get started on _*tidying your data!*_



```r
name <- c("Alice", "Bob", "Cassie", "Doug", "Ellen", "Frank")
studyid <- 1:6
CDAIwk0 <- c(255, 310, 388, 274, 410, 375)
CDAIwk8 <- c(110, 140, 175, 122, 180, 90)
SES_CDwk0 <- c(25, 14, 19, 21, 22, 17)
SES_CDwk8 <- c(7, 4, 6, 8, 7, 5)
ileocolonic <- c('0_1', '1_1', '1_0', '1_1', '1_0', '1_1')
enroll_month <- c("May-18", "Jun-18", 'Sep-18', 'Jan-19', 'Feb-19', 'Apr-19')

challenge <- data.frame(studyid, name, enroll_month, ileocolonic, CDAIwk0, SES_CDwk0, CDAIwk8, SES_CDwk8)

challenge
```

```
##   studyid   name enroll_month ileocolonic CDAIwk0 SES_CDwk0
## 1       1  Alice       May-18         0_1     255        25
## 2       2    Bob       Jun-18         1_1     310        14
## 3       3 Cassie       Sep-18         1_0     388        19
## 4       4   Doug       Jan-19         1_1     274        21
## 5       5  Ellen       Feb-19         1_0     410        22
## 6       6  Frank       Apr-19         1_1     375        17
##   CDAIwk8 SES_CDwk8
## 1     110         7
## 2     140         4
## 3     175         6
## 4     122         8
## 5     180         7
## 6      90         5
```


```r
challenge %>% 
  pivot_longer(cols = starts_with("CDAI"),
               names_to = "Week",
               values_to = "CDAI",
               names_prefix = "CDAIwk") %>% 
  select(studyid, Week, CDAI) ->
cdai_data

challenge %>% 
  pivot_longer(cols = starts_with("SES"),
               names_to = "Week",
               values_to = "SES_CD",
               names_prefix = "SES_CDwk") %>% 
  select(studyid, Week, SES_CD) ->
ses_data

challenge %>% 
  select(studyid:ileocolonic) %>% 
  left_join(cdai_data) %>% 
  left_join(ses_data) %>% 
  separate(col = "enroll_month", into = c("month", "year"), sep = "-") %>% 
  separate(col = "ileocolonic", into = c("ileal", "colonic"), sep = "_") 
```

```
## Joining, by = "studyid"
```

```
## Joining, by = c("studyid", "Week")
```

```
##    studyid   name month year ileal colonic Week CDAI SES_CD
## 1        1  Alice   May   18     0       1    0  255     25
## 2        1  Alice   May   18     0       1    8  110      7
## 3        2    Bob   Jun   18     1       1    0  310     14
## 4        2    Bob   Jun   18     1       1    8  140      4
## 5        3 Cassie   Sep   18     1       0    0  388     19
## 6        3 Cassie   Sep   18     1       0    8  175      6
## 7        4   Doug   Jan   19     1       1    0  274     21
## 8        4   Doug   Jan   19     1       1    8  122      8
## 9        5  Ellen   Feb   19     1       0    0  410     22
## 10       5  Ellen   Feb   19     1       0    8  180      7
## 11       6  Frank   Apr   19     1       1    0  375     17
## 12       6  Frank   Apr   19     1       1    8   90      5
```


<!--chapter:end:io37-tidyr2.Rmd-->

---
title: "R Notebook"
output:
  html_document:
    df_print: paged
---

## Examples with tidylog

Install the package if not already installed,
then load libraries


```r
### devtools::install_github("elbersb/tidylog")
library("dplyr")
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
library("tidylog", warn.conflicts = FALSE)
library(tidyverse)
```

```
## -- Attaching packages ------------- tidyverse 1.3.0 --
```

```
## v ggplot2 3.3.0.9000     v purrr   0.3.4     
## v tibble  3.0.1          v stringr 1.4.0     
## v tidyr   1.0.2          v forcats 0.5.0     
## v readr   1.3.1
```

```
## -- Conflicts ---------------- tidyverse_conflicts() --
## x tidylog::add_count()     masks dplyr::add_count()
## x tidylog::add_tally()     masks dplyr::add_tally()
## x tidylog::anti_join()     masks dplyr::anti_join()
## x tidylog::count()         masks dplyr::count()
## x tidylog::distinct()      masks dplyr::distinct()
## x tidylog::distinct_all()  masks dplyr::distinct_all()
## x tidylog::distinct_at()   masks dplyr::distinct_at()
## x tidylog::distinct_if()   masks dplyr::distinct_if()
## x tidyr::drop_na()         masks tidylog::drop_na()
## x tidyr::fill()            masks tidylog::fill()
## x tidylog::filter()        masks dplyr::filter(), stats::filter()
## x tidylog::filter_all()    masks dplyr::filter_all()
## x tidylog::filter_at()     masks dplyr::filter_at()
## x tidylog::filter_if()     masks dplyr::filter_if()
## x tidylog::full_join()     masks dplyr::full_join()
## x tidyr::gather()          masks tidylog::gather()
## x tidylog::group_by()      masks dplyr::group_by()
## x tidylog::group_by_all()  masks dplyr::group_by_all()
## x tidylog::group_by_at()   masks dplyr::group_by_at()
## x tidylog::group_by_if()   masks dplyr::group_by_if()
## x tidylog::inner_join()    masks dplyr::inner_join()
## x dplyr::lag()             masks stats::lag()
## x tidylog::left_join()     masks dplyr::left_join()
## x tidylog::mutate()        masks dplyr::mutate()
## x tidylog::mutate_all()    masks dplyr::mutate_all()
## x tidylog::mutate_at()     masks dplyr::mutate_at()
## x tidylog::mutate_if()     masks dplyr::mutate_if()
## x tidyr::pivot_longer()    masks tidylog::pivot_longer()
## x tidyr::pivot_wider()     masks tidylog::pivot_wider()
## x tidylog::rename()        masks dplyr::rename()
## x tidylog::rename_all()    masks dplyr::rename_all()
## x tidylog::rename_at()     masks dplyr::rename_at()
## x tidylog::rename_if()     masks dplyr::rename_if()
## x tidyr::replace_na()      masks tidylog::replace_na()
## x tidylog::right_join()    masks dplyr::right_join()
## x tidylog::sample_frac()   masks dplyr::sample_frac()
## x tidylog::sample_n()      masks dplyr::sample_n()
## x tidylog::select()        masks dplyr::select()
## x tidylog::select_all()    masks dplyr::select_all()
## x tidylog::select_at()     masks dplyr::select_at()
## x tidylog::select_if()     masks dplyr::select_if()
## x tidylog::semi_join()     masks dplyr::semi_join()
## x tidylog::slice()         masks dplyr::slice()
## x tidyr::spread()          masks tidylog::spread()
## x tidylog::summarise()     masks dplyr::summarise()
## x tidylog::summarise_all() masks dplyr::summarise_all()
## x tidylog::summarise_at()  masks dplyr::summarise_at()
## x tidylog::summarise_if()  masks dplyr::summarise_if()
## x tidylog::summarize()     masks dplyr::summarize()
## x tidylog::summarize_all() masks dplyr::summarize_all()
## x tidylog::summarize_at()  masks dplyr::summarize_at()
## x tidylog::summarize_if()  masks dplyr::summarize_if()
## x tidylog::tally()         masks dplyr::tally()
## x tidylog::top_frac()      masks dplyr::top_frac()
## x tidylog::top_n()         masks dplyr::top_n()
## x tidylog::transmute()     masks dplyr::transmute()
## x tidylog::transmute_all() masks dplyr::transmute_all()
## x tidylog::transmute_at()  masks dplyr::transmute_at()
## x tidylog::transmute_if()  masks dplyr::transmute_if()
## x tidyr::uncount()         masks tidylog::uncount()
## x tidylog::ungroup()       masks dplyr::ungroup()
```

```r
library(broom)
library(scales)
```

```
## 
## Attaching package: 'scales'
```

```
## The following object is masked from 'package:purrr':
## 
##     discard
```

```
## The following object is masked from 'package:readr':
## 
##     col_factor
```

The tidylog package will give you feedback about basic dplyr operations.
It provides simple feedback for the most common functions, such as filter, mutate, select, full_join, and group_by.

Let's see an example with a pipe.


```r
summary <- mtcars %>%
    select(mpg, cyl, hp, am) %>%
    filter(mpg > 15) %>%
    mutate(mpg_round = round(mpg)) %>%
    group_by(cyl, mpg_round, am) %>%
    tally() %>%
    filter(n >= 1)
## select: dropped 7 variables (disp, drat, wt, qsec, vs, …)
## filter: removed 6 rows (19%), 26 rows remaining
## mutate: new variable 'mpg_round' with 15 unique values and 0% NA
## group_by: 3 grouping variables (cyl, mpg_round, am)
## tally: now 20 rows and 4 columns, 2 group variables remaining (cyl, mpg_round)
## filter (grouped): no rows removed
summary
## # A tibble: 20 x 4
## # Groups:   cyl, mpg_round [17]
##      cyl mpg_round    am     n
##    <dbl>     <dbl> <dbl> <int>
##  1     4        21     1     1
##  2     4        22     0     1
##  3     4        23     0     1
##  4     4        23     1     1
##  5     4        24     0     1
##  6     4        26     1     1
##  7     4        27     1     1
##  8     4        30     1     2
##  9     4        32     1     1
## 10     4        34     1     1
## 11     6        18     0     2
## 12     6        19     0     1
## 13     6        20     1     1
## 14     6        21     0     1
## 15     6        21     1     2
## 16     8        15     0     2
## 17     8        16     0     2
## 18     8        16     1     1
## 19     8        17     0     1
## 20     8        19     0     2
```

Examples with filter and distinct


```r
a <- filter(mtcars, mpg > 20)
```

```
## filter: removed 18 rows (56%), 14 rows remaining
```

```r
b <- filter(mtcars, mpg > 100)
```

```
## filter: removed all rows (100%)
```

```r
c <- filter(mtcars, mpg > 0)
```

```
## filter: no rows removed
```

```r
d <- filter_at(mtcars, vars(starts_with("d")), any_vars((. %% 2) == 0))
```

```
## filter_at: removed 19 rows (59%), 13 rows remaining
```

```r
e <- distinct(mtcars)
```

```
## distinct: no rows removed
```

Examples with mutate and transmute


```r
a <- mutate(mtcars, new_var = 1)
```

```
## mutate: new variable 'new_var' with one unique value and 0% NA
```

```r
b <- mutate(mtcars, new_var = runif(n()))
```

```
## mutate: new variable 'new_var' with 32 unique values and 0% NA
```

```r
c <- mutate(mtcars, new_var = NA)
```

```
## mutate: new variable 'new_var' with one unique value and 100% NA
```

```r
d <- mutate_at(mtcars, vars(mpg, gear, drat), round)
```

```
## mutate_at: changed 28 values (88%) of 'mpg' (0 new NA)
```

```
##            changed 31 values (97%) of 'drat' (0 new NA)
```

```r
e <- mutate(mtcars, am_factor = as.factor(am))
```

```
## mutate: new variable 'am_factor' with 2 unique values and 0% NA
```

```r
f <- mutate(mtcars, am = as.factor(am))
```

```
## mutate: converted 'am' from double to factor (0 new NA)
```

```r
g <- mutate(mtcars, am = ifelse(am == 1, NA, am))
```

```
## mutate: changed 13 values (41%) of 'am' (13 new NA)
```

```r
h <- mutate(mtcars, am = recode(am, `0` = "zero", `1` = NA_character_))
```

```
## mutate: converted 'am' from double to character (13 new NA)
```

```r
i <- transmute(mtcars, mpg = mpg * 2, gear = gear + 1, new_var = vs + am)
```

```
## transmute: dropped 9 variables (cyl, disp, hp, drat, wt, …)
```

```
##            changed 32 values (100%) of 'mpg' (0 new NA)
```

```
##            changed 32 values (100%) of 'gear' (0 new NA)
```

```
##            new variable 'new_var' with 3 unique values and 0% NA
```

Examples with select


```r
a <- select(mtcars, mpg, wt)
```

```
## select: dropped 9 variables (cyl, disp, hp, drat, qsec, …)
```

```r
b <- select(mtcars, matches("a"))
```

```
## select: dropped 7 variables (mpg, cyl, disp, hp, wt, …)
```

```r
c <- select_if(mtcars, is.character)
```

```
## select_if: dropped all variables
```

Examples with joins


```r
a <- left_join(band_members, band_instruments, by = "name")
```

```
## left_join: added one column (plays)
```

```
##            > rows only in x   1
```

```
##            > rows only in y  (1)
```

```
##            > matched rows     2
```

```
##            >                 ===
```

```
##            > rows total       3
```

```r
b <- full_join(band_members, band_instruments, by = "name")
```

```
## full_join: added one column (plays)
```

```
##            > rows only in x   1
```

```
##            > rows only in y   1
```

```
##            > matched rows     2
```

```
##            >                 ===
```

```
##            > rows total       4
```

```r
c <- anti_join(band_members, band_instruments, by = "name")
```

```
## anti_join: added no columns
```

```
##            > rows only in x   1
```

```
##            > rows only in y  (1)
```

```
##            > matched rows    (2)
```

```
##            >                 ===
```

```
##            > rows total       1
```

```r
a
```

```
## # A tibble: 3 x 3
##   name  band    plays 
## * <chr> <chr>   <chr> 
## 1 Mick  Stones  <NA>  
## 2 John  Beatles guitar
## 3 Paul  Beatles bass
```

```r
b
```

```
## # A tibble: 4 x 3
##   name  band    plays 
## * <chr> <chr>   <chr> 
## 1 Mick  Stones  <NA>  
## 2 John  Beatles guitar
## 3 Paul  Beatles bass  
## 4 Keith <NA>    guitar
```

```r
c
```

```
## # A tibble: 1 x 2
##   name  band  
##   <chr> <chr> 
## 1 Mick  Stones
```

Examples with summarize


```r
a <- mtcars %>%
    group_by(cyl, carb) %>%
    summarize(total_weight = sum(wt))
```

```
## group_by: 2 grouping variables (cyl, carb)
```

```
## summarize: now 9 rows and 3 columns, one group variable remaining (cyl)
```

```r
a
```

```
## # A tibble: 9 x 3
## # Groups:   cyl [3]
##     cyl  carb total_weight
##   <dbl> <dbl>        <dbl>
## 1     4     1        10.8 
## 2     4     2        14.4 
## 3     6     1         6.68
## 4     6     4        12.4 
## 5     6     6         2.77
## 6     8     2        14.2 
## 7     8     3        11.6 
## 8     8     4        26.6 
## 9     8     8         3.57
```

```r
b <- iris %>%
    group_by(Species) %>%
    summarize_if(is.numeric, list(min = min, max =max))
```

```
## group_by: one grouping variable (Species)
```

```
## summarize_if: now 3 rows and 9 columns, ungrouped
```

```r
b
```

```
## # A tibble: 3 x 9
##   Species Sepal.Length_min Sepal.Width_min Petal.Length_min
## * <fct>              <dbl>           <dbl>            <dbl>
## 1 setosa               4.3             2.3              1  
## 2 versic~              4.9             2                3  
## 3 virgin~              4.9             2.2              4.5
## # ... with 5 more variables: Petal.Width_min <dbl>,
## #   Sepal.Length_max <dbl>, Sepal.Width_max <dbl>,
## #   Petal.Length_max <dbl>, Petal.Width_max <dbl>
```

How to turn tidylogging off and back on when needed


```r
options("tidylog.display" = list())  # turn off
a <- filter(mtcars, mpg > 20)
a
```

```
##                 mpg cyl  disp  hp drat    wt  qsec vs am
## Mazda RX4      21.0   6 160.0 110 3.90 2.620 16.46  0  1
## Mazda RX4 Wag  21.0   6 160.0 110 3.90 2.875 17.02  0  1
## Datsun 710     22.8   4 108.0  93 3.85 2.320 18.61  1  1
## Hornet 4 Drive 21.4   6 258.0 110 3.08 3.215 19.44  1  0
## Merc 240D      24.4   4 146.7  62 3.69 3.190 20.00  1  0
## Merc 230       22.8   4 140.8  95 3.92 3.150 22.90  1  0
## Fiat 128       32.4   4  78.7  66 4.08 2.200 19.47  1  1
## Honda Civic    30.4   4  75.7  52 4.93 1.615 18.52  1  1
## Toyota Corolla 33.9   4  71.1  65 4.22 1.835 19.90  1  1
## Toyota Corona  21.5   4 120.1  97 3.70 2.465 20.01  1  0
## Fiat X1-9      27.3   4  79.0  66 4.08 1.935 18.90  1  1
## Porsche 914-2  26.0   4 120.3  91 4.43 2.140 16.70  0  1
## Lotus Europa   30.4   4  95.1 113 3.77 1.513 16.90  1  1
## Volvo 142E     21.4   4 121.0 109 4.11 2.780 18.60  1  1
##                gear carb
## Mazda RX4         4    4
## Mazda RX4 Wag     4    4
## Datsun 710        4    1
## Hornet 4 Drive    3    1
## Merc 240D         4    2
## Merc 230          4    2
## Fiat 128          4    1
## Honda Civic       4    2
## Toyota Corolla    4    1
## Toyota Corona     3    1
## Fiat X1-9         4    1
## Porsche 914-2     5    2
## Lotus Europa      5    2
## Volvo 142E        4    2
```

Now back on


```r
options("tidylog.display" = NULL)    # turn on
a <- filter(mtcars, mpg > 20)
```

```
## filter: removed 18 rows (56%), 14 rows remaining
```

Add a new chunk by clicking the *Insert Chunk* button on the toolbar or by pressing *Cmd+Option+I*.

When you save the notebook, an HTML file containing the code and output will be saved alongside it (click the *Preview* button or press *Cmd+Shift+K* to preview the HTML file). 

The preview shows you a rendered HTML copy of the contents of the editor. Consequently, unlike *Knit*, *Preview* does not run any R code chunks. Instead, the output of the chunk when it was last run in the editor is displayed.


```r
mtcars %>% 
  group_by(cyl) %>% 
  count(am) %>% 
  spread(am, n) %>% 
  column_to_rownames('cyl') %>% 
  chisq.test() %>% 
  tidy() 
```

```
## group_by: one grouping variable (cyl)
```

```
## count: now 6 rows and 3 columns, one group variable remaining (cyl)
```

```
## Warning in chisq.test(.): Chi-squared approximation may be
## incorrect
```

```
## # A tibble: 1 x 4
##   statistic p.value parameter method                    
##       <dbl>   <dbl>     <int> <chr>                     
## 1      8.74  0.0126         2 Pearson's Chi-squared test
```


```r
mt <- mtcars %>% 
  group_by(cyl) %>% 
  filter(cyl <7) %>% 
  t.test(mpg ~ cyl, data = .) %>% 
  tidy() 
```

```
## group_by: one grouping variable (cyl)
```

```
## filter (grouped): removed 14 rows (44%), 18 rows remaining
```

The p value for this t test is 0.0004



```r
mtcars %>% 
  aov(mpg ~ cyl, data = .) %>% 
  tidy() ->
result
```


The result of the ANOVA test is F(1, 30) = 79.56, with p <0.0001 

<!--chapter:end:io38-tidylog.Rmd-->

---
title: "more_dplyr"
author: "Peter Higgins"
date: "8/15/2019"
output: html_document
---



## More dplyr

You have learned the big 7 verbs in dplyr, including
<br>
1. filteR
2. seleCt
3. mutate
4. group_by
5. summarize
6. arrange
7. count
<br>
But there is more!!

### rename

when you don't need a full mutate, just better names.
This often comes up after you have used clean_names to improve the formatting of variable names, but you end up with long, long names.
<br>
First run the code chunk below to see what you have in the data frame

Then pipe tbl into a rename function, which has the format<br>
rename(new_name = old_name)
and rename the sbp as sbp_basel

```r
name <- c("Bob", "Carla", "Dave")
the_value_of_sbp_at_baseline <- c(120, 134, 96)
tbl <- data.frame(name, the_value_of_sbp_at_baseline)
tbl %>% 
  rename(sbp_base = the_value_of_sbp_at_baseline)
```

```
##    name sbp_base
## 1   Bob      120
## 2 Carla      134
## 3  Dave       96
```

### Re-arrange your variables/columns

If you don't like the order of your variables, you can use *select* to reorder them.
use the format:
select(var1, var2, var3:var4, everything())

note that everything() puts all the other variables in at the end, in their previous order.
This is helpful for pulling interesting variables to the front of the line.

Run the chunk below,
then pipe the tbl into 
 select(pt_id, everything())


```r
firstname <- c("Bob", "Carla", "Dave", "Elena")
pt_id <- c(001, 002, 003, 004)
lastname <- c("Edwards", "Frankel", "Genghis", "Harrison")
tbl <- data.frame(firstname, pt_id, lastname)
tbl %>% 
  select(pt_id, everything())
```

```
##   pt_id firstname lastname
## 1     1       Bob  Edwards
## 2     2     Carla  Frankel
## 3     3      Dave  Genghis
## 4     4     Elena Harrison
```

### Find distinct rows

If you want to list only the distinct, unique observations, you can use the distinct function.

Run the code chunk below to see the replicates by visit_num

Then pipe tbl into 
  distinct(var1, var2) - the variables you care about
  
  In this case, use firstname, lastname to find the distinct patients


```r
firstname <- rep(c("Bob", "Carla", "Dave", "Elena"),3)
pt_id <- rep(c(001, 002, 003, 004),3)
lastname <- rep(c("Edwards", "Frankel", "Genghis", "Harrison"),3)
visit_num <- c(rep(1,4), rep(2, 4), rep(3,4))
tbl <- data.frame(pt_id, firstname, lastname, visit_num)
tbl %>% 
  distinct(firstname, lastname) ->
unique_pts
```

### Select a group of rows with slice()
Sometimes you just want a few contiguous rows, like with head(), or tail().
but you can also pick which rows with slice()

This is a simple command with 

slice(start_row:end_row) to select the rows you want

Run the chunk below to find out how many rows are in the starwars dataset.

Then look at head and tail functions

Then pipe starwars into a slice function.

Slice out rows 15:25
or
46:60


```r
dim(starwars)
```

```
## [1] 87 14
```

```r
starwars %>% 
  head(7)
```

```
## # A tibble: 7 x 14
##   name  height  mass hair_color skin_color eye_color
##   <chr>  <int> <dbl> <chr>      <chr>      <chr>    
## 1 Luke~    172    77 blond      fair       blue     
## 2 C-3PO    167    75 <NA>       gold       yellow   
## 3 R2-D2     96    32 <NA>       white, bl~ red      
## 4 Dart~    202   136 none       white      yellow   
## 5 Leia~    150    49 brown      light      brown    
## 6 Owen~    178   120 brown, gr~ light      blue     
## 7 Beru~    165    75 brown      light      blue     
## # ... with 8 more variables: birth_year <dbl>, sex <chr>,
## #   gender <chr>, homeworld <chr>, species <chr>,
## #   films <list>, vehicles <list>, starships <list>
```

```r
starwars %>% 
  tail(10)
```

```
## # A tibble: 10 x 14
##    name  height  mass hair_color skin_color eye_color
##    <chr>  <int> <dbl> <chr>      <chr>      <chr>    
##  1 Tarf~    234   136 brown      brown      blue     
##  2 Raym~    188    79 brown      light      brown    
##  3 Sly ~    178    48 none       pale       white    
##  4 Tion~    206    80 none       grey       black    
##  5 Finn      NA    NA black      dark       dark     
##  6 Rey       NA    NA brown      light      hazel    
##  7 Poe ~     NA    NA brown      light      brown    
##  8 BB8       NA    NA none       none       black    
##  9 Capt~     NA    NA unknown    unknown    unknown  
## 10 Padm~    165    45 brown      light      brown    
## # ... with 8 more variables: birth_year <dbl>, sex <chr>,
## #   gender <chr>, homeworld <chr>, species <chr>,
## #   films <list>, vehicles <list>, starships <list>
```

```r
starwars %>% 
  slice(15:35)
```

```
## # A tibble: 21 x 14
##    name  height   mass hair_color skin_color eye_color
##    <chr>  <int>  <dbl> <chr>      <chr>      <chr>    
##  1 Gree~    173   74   <NA>       green      black    
##  2 Jabb~    175 1358   <NA>       green-tan~ orange   
##  3 Wedg~    170   77   brown      fair       hazel    
##  4 Jek ~    180  110   brown      fair       blue     
##  5 Yoda      66   17   white      green      brown    
##  6 Palp~    170   75   grey       pale       yellow   
##  7 Boba~    183   78.2 black      fair       brown    
##  8 IG-88    200  140   none       metal      red      
##  9 Bossk    190  113   none       green      red      
## 10 Land~    177   79   black      dark       brown    
## # ... with 11 more rows, and 8 more variables:
## #   birth_year <dbl>, sex <chr>, gender <chr>,
## #   homeworld <chr>, species <chr>, films <list>,
## #   vehicles <list>, starships <list>
```

### Randomly sample some rows with sample_n() or sample_frac()
Sometimes you want a smaller but representative sample of rows, 
which you can get with sample_n() or sample_frac()

sample_n needs a size (number of rows)

while sample_frac needs a size between 0 and 1.

You can also choose to sample with replacement (replace = TRUE)

Using the chunk below,
try to 

1. sample 30 records from starwars (without replacement)
2. take a 20% random sample (with replacement)


```r
starwars %>% 
  sample_n(size =30, replace =TRUE)
```

```
## # A tibble: 30 x 14
##    name  height  mass hair_color skin_color eye_color
##    <chr>  <int> <dbl> <chr>      <chr>      <chr>    
##  1 Bigg~    183    84 black      light      brown    
##  2 Plo ~    188    80 none       orange     black    
##  3 Jar ~    196    66 none       orange     orange   
##  4 Sebu~    112    40 none       grey, red  orange   
##  5 Anak~    188    84 blond      fair       blue     
##  6 Lobot    175    79 none       light      blue     
##  7 Lama~    229    88 none       grey       black    
##  8 Joca~    167    NA white      fair       blue     
##  9 Han ~    180    80 brown      fair       brown    
## 10 R5-D4     97    32 <NA>       white, red red      
## # ... with 20 more rows, and 8 more variables:
## #   birth_year <dbl>, sex <chr>, gender <chr>,
## #   homeworld <chr>, species <chr>, films <list>,
## #   vehicles <list>, starships <list>
```

```r
starwars %>% 
  sample_frac(size = 0.2, replace = TRUE)
```

```
## # A tibble: 17 x 14
##    name  height  mass hair_color skin_color eye_color
##    <chr>  <int> <dbl> <chr>      <chr>      <chr>    
##  1 Greg~    185    85 black      dark       brown    
##  2 Plo ~    188    80 none       orange     black    
##  3 Dooku    193    80 white      fair       brown    
##  4 Bossk    190   113 none       green      red      
##  5 Lama~    229    88 none       grey       black    
##  6 Ackb~    180    83 none       brown mot~ orange   
##  7 Bib ~    180    NA none       pale       pink     
##  8 San ~    191    NA none       grey       gold     
##  9 San ~    191    NA none       grey       gold     
## 10 Wedg~    170    77 brown      fair       hazel    
## 11 Bossk    190   113 none       green      red      
## 12 Dext~    198   102 none       brown      yellow   
## 13 Han ~    180    80 brown      fair       brown    
## 14 Qui-~    193    89 brown      fair       blue     
## 15 Fini~    170    NA blond      fair       blue     
## 16 Plo ~    188    80 none       orange     black    
## 17 Eeth~    171    NA black      brown      brown    
## # ... with 8 more variables: birth_year <dbl>, sex <chr>,
## #   gender <chr>, homeworld <chr>, species <chr>,
## #   films <list>, vehicles <list>, starships <list>
```

but you can also pick which rows with slice()

<!--chapter:end:io40-more_dplyr.Rmd-->

---
title: "Drawing a Consort Diagram in ggplot2"
author: "Peter Higgins"
date: "1/26/2019"
output:  html_document
---



## Why bother?
 To begin, CONSORT diagrams are a common figure in the reporting of clinical trials. They are frequently used, but often require resorting to drawing flow diagrams in PowerPoint or Adobe Illustrator, removing the user from the R universe.
 
 <br>
  There are a few solutions available on the web, but they either use diagrammeR, which is an elegant package designed to be adaptable to networks and it reformats the diagram with each addition or removal of a node or edge. This makes it less useful for a static flow diagram. Also, honestly, diagrammeR code is not very literate programming. It is quite difficult to interpret what is going on in the code for complex flowcharts with multiple nodes and edges.
  
<br>
   A second possibility is using the grid package, opening viewports, and essentially hacking a flowchart by hand. This provides a lot of options and customizability, and there are a few examples that are quite effective, but hacky-looking and far from elegant.

<br>
    One of the great appeals of ggplot2 is that it is literate programming, which is concise, elegant, and consistent. In this document, I will try to reproduce a CONSORT diagram from a recent study on which I was a senior author using ggplot2.

<br>

## Our goal
Out end goal is to reproduce this diagram from the phase 2 study of Upadacitinib in ulcerative colitis. It is a reasonably complex 5 arm dose-ranging study that should illustrate what we can do with ggplot2.
     

```r
#! [Alt text] (/path/to/image.jpg)
```

<br>
## Getting started
Let's first draw a 100 x 100 grid that will be our working space.
The grid lines will help us align and place boxes exactly where we want them. Later on we will change the graph theme to theme_void() to remove the background when we don't need it anymore.

<br>


```r
data <- tibble(x= 1:100, y= 1:100)
head(data)
```

```
## # A tibble: 6 x 2
##       x     y
##   <int> <int>
## 1     1     1
## 2     2     2
## 3     3     3
## 4     4     4
## 5     5     5
## 6     6     6
```

```r
data %>% 
  ggplot(aes(x, y)) +
  scale_x_continuous(minor_breaks = seq(10, 100, 10)) +
  scale_y_continuous(minor_breaks = seq(10, 100, 10)) +
  theme_linedraw() ->
  p
p
```

![](io41-draw_consort_files/figure-latex/draw-grid-1.pdf)<!-- --> 

## Adding our first box and text
Now let's add the top box with geom_rect, and the text with annotate.
Feel free to fiddle with xmin, text location, until you have it right
<br>


```r
p +
  geom_rect(xmin = 36, xmax=64, ymin=94, ymax=100, color='black',
            fill='white', size=0.25, size=0.25) +
  annotate('text', x= 50, y=97,label= '446 Patients assessed for eligibility', size=2.5) ->
  p
```

```
## Warning: Duplicated aesthetics after name standardisation:
## size
```

```r
p
```

![](io41-draw_consort_files/figure-latex/draw-box-1.pdf)<!-- --> 

## Adding our 2 more boxes
Now let's add the top box with geom_rect, and the text with annotate.
Feel free to fiddle with xmin, text location, until you have it right.
Added 18 spaces after 196 patients excluded, to make it look sort of left-justified
<br>


```r
p +
  geom_rect(xmin = 32, xmax=68, ymin=73, ymax=83, color='black',
            fill='white', size=0.25) +
  annotate('text', x= 50, y=78,label= '250 Patients randomly assigned\n and included in the intention-to-treat analysis', size=2.5) +
  geom_rect(xmin = 70, xmax=97, ymin=80, ymax=98, color='black',
            fill='white', size=0.25) +
  annotate('text', x= 83.5, y=89,label= '196 Patients excluded                 \n 172 Did not meet inclusion criteria\n 17 Withdrew consent\n 2 Lost to follow up\n 5 Other reasons', size=2.5) ->
  p
p
```

![](io41-draw_consort_files/figure-latex/draw-2more-boxes-1.pdf)<!-- --> 

## Adding Arrows
Now let's add the arrows between the top box and the bottom box, as well as the downward line and the exclusions box on the right.
We will use geom_segment, which takes arguments x, xend, y, and yend to place the line segment, and we will add the size and arrow arguments to draw an arrow.
Feel free to fiddle with xmin, text location, until you have it right
<br>


```r
p +
  geom_segment(
    x=50, xend=50, y=94, yend=83.3, 
    size=0.15, linejoin = "mitre", lineend = "butt",
    arrow = arrow(length = unit(1, "mm"), type= "closed")) +
    geom_segment(
    x=50, xend=69.7, y=89, yend=89, 
    size=0.15, linejoin = "mitre", lineend = "butt",
    arrow = arrow(length = unit(1, "mm"), type= "closed")) ->
  p
p
```

![](io41-draw_consort_files/figure-latex/draw-arrows-1.pdf)<!-- --> 

<br>

## Now let's add 5 arrows (and a horizontal line)!
Now let's add the 5 arrows between the assignment box and randomization groups. The arrow in the middle will be longer than the others, as it goes all the way from the randomization box to the 3rd group assignment box. The other 4 arrows only go from a horizontal line to their assignment boxes.

<br>
We will start from the bottom of the randomization box (y=**73**),
and the top of the assignment boxes at y=**58.3**.

Then we will add the horizontal line at y=**65**.


```r
p +
  geom_segment(
  #middle arrow first
    x=50, xend=50, y=73, yend=58.3, 
    size=0.15, linejoin = "mitre", lineend = "butt",
    arrow = arrow(length = unit(1, "mm"), type= "closed")) +
  # then leftmost arrow, x and xend=10
  geom_segment(
    x=10, xend=10, y=65, yend=58.3, 
    size=0.15, linejoin = "mitre", lineend = "butt",
    arrow = arrow(length = unit(1, "mm"), type= "closed")) +
  # then 2nd arrow from the left, x and xend=30
  geom_segment(
    x=30, xend=30, y=65, yend=58.3, 
    size=0.15, linejoin = "mitre", lineend = "butt",
    arrow = arrow(length = unit(1, "mm"), type= "closed")) +
  # then 4th arrow from the left, x and xend=70
  geom_segment(
    x=70, xend=70, y=65, yend=58.3, 
    size=0.15, linejoin = "mitre", lineend = "butt",
    arrow = arrow(length = unit(1, "mm"), type= "closed")) +
# then rightmost arrow, x and xend=90
  geom_segment(
    x=90, xend=90, y=65, yend=58.3, 
    size=0.15, linejoin = "mitre", lineend = "butt",
    arrow = arrow(length = unit(1, "mm"), type= "closed")) +
  # then horizontal line, but remove the arrow
  geom_segment(
    x=10, xend=90, y=65, yend=65, 
    size=0.15, linejoin = "mitre", lineend = "butt")->
  p
p
```

![](io41-draw_consort_files/figure-latex/5-arrows-1.pdf)<!-- --> 

<br>

## Now let's add the assignment boxes!
Now let's add the 5 assignment boxes below these 5 arrows. These will have y values from 49 to 58, and x values from 1-19, 21-39, 41-59, 61-79, and 81-99. Add the text as indicated in the figure



```r
p +
  #first box on left
  geom_rect(xmin = 1, xmax=19, ymin=49, ymax=58, 
              color='black', fill='white', size=0.25) +
  annotate('text', x= 10, y=54, size=2.5,
             label= '46 Patients assigned\nto placebo') +
  #2nd box on left
  geom_rect(xmin = 21, xmax=39, ymin=49, ymax=58, 
              color='black', fill='white', size=0.25) +
  annotate('text', x= 30, y=54, size=2.5,
             label= '47 Patients assigned\nto UPA 7.5 mg QD') +
#3rd box on left
  geom_rect(xmin = 41, xmax=59, ymin=49, ymax=58, 
              color='black', fill='white', size=0.25) +
  annotate('text', x= 50, y=54, size=2.5,
             label= '49 Patients assigned\nto UPA 15 mg QD') +
#4th box on left
  geom_rect(xmin = 61, xmax=79, ymin=49, ymax=58, 
              color='black', fill='white', size=0.25) +
  annotate('text', x= 70, y=54, size=2.5,
             label= '52 Patients assigned\nto UPA 30 mg QD') +
#5th box on left
  geom_rect(xmin = 81, xmax=99, ymin=49, ymax=58, 
              color='black', fill='white', size=0.25) +
  annotate('text', x= 90, y=54, size=2.5,
             label= '56 Patients assigned\nto UPA 45 mg QD')->
  p
p
```

![](io41-draw_consort_files/figure-latex/5-boxes-1.pdf)<!-- --> 

<br>

## Now let's add the 5 long arrows!
Now let's add the 5 long arrows below these 5 boxes These are off center, so they will have y values from 49 to 15.3, and x values of 2, 22, 42, 62, and 82. Add the text as indicated in the figure.



```r
p +
  #first arrow on left
  geom_segment(
    x=2, xend=2, y=49, yend=15.3, 
    size=0.15, linejoin = "mitre", lineend = "butt",
    arrow = arrow(length = unit(1, "mm"), type= "closed")) +
  #2nd arrow on left
  geom_segment(
    x=22, xend=22, y=49, yend=15.3, 
    size=0.15, linejoin = "mitre", lineend = "butt",
    arrow = arrow(length = unit(1, "mm"), type= "closed")) +
#3rd arrow on left
  geom_segment(
    x=42, xend=42, y=49, yend=15.3, 
    size=0.15, linejoin = "mitre", lineend = "butt",
    arrow = arrow(length = unit(1, "mm"), type= "closed")) +
#4th arrow on left
  geom_segment(
    x=62, xend=62, y=49, yend=15.3, 
    size=0.15, linejoin = "mitre", lineend = "butt",
    arrow = arrow(length = unit(1, "mm"), type= "closed")) +
#5th arrow on left
  geom_segment(
    x=82, xend=82, y=49, yend=15.3, 
    size=0.15, linejoin = "mitre", lineend = "butt",
    arrow = arrow(length = unit(1, "mm"), type= "closed")) ->
  p
p
```

![](io41-draw_consort_files/figure-latex/5-long-arrows-1.pdf)<!-- --> 

<br>

## Now let's add the discontinuation boxes!
Now let's add the 5 discontinuation boxes below these 5 boxes These are off center, so they will have y values from 40 to 25, and x values of 5-19, 25-39, 44-59, 65-79, and 85-99. Add the text as indicated in the figure. To make discontinued (sort of) left justified, add four spaces after each occurrence of discontinued.


```r
p +
  #first box on left
  geom_rect(xmin = 5, xmax=19, ymin=25, ymax=40, 
              color='black', fill='white', size=0.25) +
  annotate('text', x= 12, y=33, size=2.5,
      label= '5 Discontinued    \n3 Adverse event\n2 Lack of efficacy') +
  #2nd box from left
  geom_rect(xmin = 25, xmax=39, ymin=25, ymax=40, 
              color='black', fill='white', size=0.25) +
  annotate('text', x= 32, y=33, size=2.5,
      label= '1 Discontinued    \n1 Adverse event\n1 Lack of efficacy') +
  #3rd box from left
  geom_rect(xmin = 45, xmax=59, ymin=25, ymax=40, 
              color='black', fill='white', size=0.25) +
  annotate('text', x= 52, y=33, size=2.5,
      label= '4 Discontinued    \n2 Adverse event\n1 Lack of efficacy\n1 Other') +
  #4th box from left
  geom_rect(xmin = 65, xmax=79, ymin=25, ymax=40, 
              color='black', fill='white', size=0.25) +
  annotate('text', x= 72, y=33, size=2.5,
      label= '6 Discontinued    \n4 Adverse event\n1 Lack of efficacy\n1 Other') +
#4th box from left
  geom_rect(xmin = 85, xmax=99, ymin=25, ymax=40, 
              color='black', fill='white', size=0.25) +
  annotate('text', x= 92, y=33, size=2.5,
      label= '6 Discontinued    \n4 Adverse event\n2 Lack of efficacy') ->p
p
```

![](io41-draw_consort_files/figure-latex/5-discontinuation-boxes-1.pdf)<!-- --> 


<br>

## Now let's add the short arrows!
Now let's add the 5 short arrows to the discontinuation boxes. These will go from x=2 to x=4.7 (plus 20*N), at a y value of 32.5. 


```r
p +
#first arrow on left
  geom_segment(
    x=2, xend=4.7, y=32.5, yend=32.5, 
    size=0.15, linejoin = "mitre", lineend = "butt",
    arrow = arrow(length = unit(1, "mm"), type= "closed")) +
  #2nd arrow on left
  geom_segment(
    x=22, xend=24.7, y=32.5, yend=32.5, 
    size=0.15, linejoin = "mitre", lineend = "butt",
    arrow = arrow(length = unit(1, "mm"), type= "closed")) +
#3rd arrow on left
  geom_segment(
    x=42, xend=44.7, y=32.5, yend=32.5,  
    size=0.15, linejoin = "mitre", lineend = "butt",
    arrow = arrow(length = unit(1, "mm"), type= "closed")) +
#4th arrow on left
  geom_segment(
    x=62, xend=64.7, y=32.5, yend=32.5,  
    size=0.15, linejoin = "mitre", lineend = "butt",
    arrow = arrow(length = unit(1, "mm"), type= "closed")) +
#5th arrow on left
  geom_segment(
    x=82, xend=84.7, y=32.5, yend=32.5, 
    size=0.15, linejoin = "mitre", lineend = "butt",
    arrow = arrow(length = unit(1, "mm"), type= "closed")) ->
  p
p
```

![](io41-draw_consort_files/figure-latex/short-arrows-1.pdf)<!-- --> 

<br>

## Now for the completion boxes!
Now let's add the 5 completion boxes at the bottom. These will be aligned with the assignment boxes, so they will have y values from 15 to 7, and x values of 1-19, 21-39, 41-59, 61-79, and 81-99. Add the text as indicated in the figure. 


```r
p +
  #first box on left
  geom_rect(xmin = 1, xmax=19, ymin=7, ymax=15, 
              color='black', fill='white', size=0.25) +
  annotate('text', x= 10, y=11, size=2.5,
             label= '41 Patients completed\nthe study') +
  #2nd box on left
  geom_rect(xmin = 21, xmax=39, ymin=7, ymax=15, 
              color='black', fill='white', size=0.25) +
  annotate('text', x= 30, y=11, size=2.5,
             label= '45 Patients completed\nthe study') +
#3rd box on left
  geom_rect(xmin = 41, xmax=59, ymin=7, ymax=15, 
              color='black', fill='white', size=0.25) +
  annotate('text', x= 50, y=11, size=2.5,
             label= '45 Patients completed\nthe study') +
#4th box on left
  geom_rect(xmin = 61, xmax=79, ymin=7, ymax=15,  
              color='black', fill='white', size=0.25) +
  annotate('text', x= 70, y=11, size=2.5,
             label= '46 Patients completed\nthe study') +
#5th box on left
  geom_rect(xmin = 81, xmax=99, ymin=7, ymax=15,  
              color='black', fill='white', size=0.25) +
  annotate('text', x= 90, y=11, size=2.5,
             label= '50 Patients completed\nthe study')->
  p
p
```

![](io41-draw_consort_files/figure-latex/completion-boxes-1.pdf)<!-- --> 

<br>

## Now for the big reveal!
Let's take away the axes and gridlines to reveal our creation!


```r
p + theme_void()
```

![](io41-draw_consort_files/figure-latex/reveal-1.pdf)<!-- --> 

<!--chapter:end:io41-draw_consort.Rmd-->

---
title: "blockrand_demo"
author: "Peter Higgins"
date: "2/21/2019"
output: html_document
---



The blockrand package is a user-friendly way to generate randomization for permuted blocks.

### Block Randomization
Block randomization is a commonly used technique in clinical trial design to reduce bias and achieve balance in the allocation of participants to treatment arms, especially when the sample size is small.

### Permuted Block Randomization
The permuted block technique randomizes patients between groups within a set of study participants, called a block. Treatment assignments within blocks are determined so that they are random in order but that the desired allocation proportions are achieved exactly within each block. In a 2-group trial with equal allocation and a block size of 6, 3 patients in each block would be assigned to the control and 3 to the treatment and the ordering of those 6 assignments would be random. For example, with treatment labels A and B, possible blocks might be: ABBABA, BABBAA, and AABABB (different permutations). As each block is filled, the trial is guaranteed to have the desired allocation to each group.
The standard error of the treatment effect or the difference between the groups is therefore minimized with equal allocation. Permuted block randomization avoids significant imbalances, which can occur with simple randomization.

### Random Size Permuted Blocks
The main limitation of permuted block randomization is the potential for bias if treatment assignments become known or predictable. For example, with a block size of 4, if an investigator knew the first 3 assignments in the block, the investigator also would know with certainty the assignment for the next patient enrolled. The use of reasonably large block sizes, random block sizes, and strong blinding procedures such as double-blind treatment assignments and identical-appearing placebos are strategies used to prevent this.

You can set up a random block size. For example, each block can be randomly selected with a size of 2, 4, or 6. This makes it very difficult to guess the next assignment.

### Stratification
You may have a baseline variable that is predictive of outcomes, or predictive of response to the treatment. For example, if you have a well-validated risk score that predicts the outcome, you want to make sure that the treatment groups have a similar distribution of risk levels. Otherwise, your study might be biased if a lot of the high risk patients ended up in one arm, and not the other.

When this is the case, you can divide your population into different levels (or strata) of risk. Then do a separate randomization for each stratum.


## Our Randomization
Our goal is to have 500 assignments available across 5 strata of risk.
To make this reproducible, I will set a distinct seed for each stratum.

### Stratum 1 


```r
set.seed(1234)
stratum1 <- blockrand(n = 100,
                      block.prefix = "B_", # this is for block.id
                      stratum = "Stratum_1",
                      num.levels = 2, # 2 distinct treatments
                      levels = c("Patient Navigator", "Control")
                      ) %>% filter(id <101) # often will come out uneven
                          # based on block size, so will trim to 100
stratum1
```

```
##    id   stratum block.id block.size         treatment
## 1   1 Stratum_1     B_01          8           Control
## 2   2 Stratum_1     B_01          8           Control
## 3   3 Stratum_1     B_01          8           Control
## 4   4 Stratum_1     B_01          8 Patient Navigator
## 5   5 Stratum_1     B_01          8           Control
## 6   6 Stratum_1     B_01          8 Patient Navigator
## 7   7 Stratum_1     B_01          8 Patient Navigator
## 8   8 Stratum_1     B_01          8 Patient Navigator
## 9   9 Stratum_1     B_02          4           Control
## 10 10 Stratum_1     B_02          4           Control
## 11 11 Stratum_1     B_02          4 Patient Navigator
## 12 12 Stratum_1     B_02          4 Patient Navigator
## 13 13 Stratum_1     B_03          4           Control
## 14 14 Stratum_1     B_03          4 Patient Navigator
## 15 15 Stratum_1     B_03          4           Control
## 16 16 Stratum_1     B_03          4 Patient Navigator
## 17 17 Stratum_1     B_04          4           Control
## 18 18 Stratum_1     B_04          4           Control
## 19 19 Stratum_1     B_04          4 Patient Navigator
## 20 20 Stratum_1     B_04          4 Patient Navigator
## 21 21 Stratum_1     B_05          2           Control
## 22 22 Stratum_1     B_05          2 Patient Navigator
## 23 23 Stratum_1     B_06          8 Patient Navigator
## 24 24 Stratum_1     B_06          8           Control
## 25 25 Stratum_1     B_06          8 Patient Navigator
## 26 26 Stratum_1     B_06          8           Control
## 27 27 Stratum_1     B_06          8 Patient Navigator
## 28 28 Stratum_1     B_06          8           Control
## 29 29 Stratum_1     B_06          8           Control
## 30 30 Stratum_1     B_06          8 Patient Navigator
## 31 31 Stratum_1     B_07          8 Patient Navigator
## 32 32 Stratum_1     B_07          8           Control
## 33 33 Stratum_1     B_07          8 Patient Navigator
## 34 34 Stratum_1     B_07          8           Control
## 35 35 Stratum_1     B_07          8 Patient Navigator
## 36 36 Stratum_1     B_07          8 Patient Navigator
## 37 37 Stratum_1     B_07          8           Control
## 38 38 Stratum_1     B_07          8           Control
## 39 39 Stratum_1     B_08          8           Control
## 40 40 Stratum_1     B_08          8           Control
## 41 41 Stratum_1     B_08          8 Patient Navigator
## 42 42 Stratum_1     B_08          8 Patient Navigator
## 43 43 Stratum_1     B_08          8 Patient Navigator
## 44 44 Stratum_1     B_08          8           Control
## 45 45 Stratum_1     B_08          8 Patient Navigator
## 46 46 Stratum_1     B_08          8           Control
## 47 47 Stratum_1     B_09          4           Control
## 48 48 Stratum_1     B_09          4 Patient Navigator
## 49 49 Stratum_1     B_09          4           Control
## 50 50 Stratum_1     B_09          4 Patient Navigator
## 51 51 Stratum_1     B_10          2           Control
## 52 52 Stratum_1     B_10          2 Patient Navigator
## 53 53 Stratum_1     B_11          2           Control
## 54 54 Stratum_1     B_11          2 Patient Navigator
## 55 55 Stratum_1     B_12          2 Patient Navigator
## 56 56 Stratum_1     B_12          2           Control
## 57 57 Stratum_1     B_13          8           Control
## 58 58 Stratum_1     B_13          8 Patient Navigator
## 59 59 Stratum_1     B_13          8           Control
## 60 60 Stratum_1     B_13          8 Patient Navigator
## 61 61 Stratum_1     B_13          8 Patient Navigator
## 62 62 Stratum_1     B_13          8 Patient Navigator
## 63 63 Stratum_1     B_13          8           Control
## 64 64 Stratum_1     B_13          8           Control
## 65 65 Stratum_1     B_14          4 Patient Navigator
## 66 66 Stratum_1     B_14          4           Control
## 67 67 Stratum_1     B_14          4           Control
## 68 68 Stratum_1     B_14          4 Patient Navigator
## 69 69 Stratum_1     B_15          2 Patient Navigator
## 70 70 Stratum_1     B_15          2           Control
## 71 71 Stratum_1     B_16          4 Patient Navigator
## 72 72 Stratum_1     B_16          4           Control
## 73 73 Stratum_1     B_16          4           Control
## 74 74 Stratum_1     B_16          4 Patient Navigator
## 75 75 Stratum_1     B_17          8           Control
## 76 76 Stratum_1     B_17          8 Patient Navigator
## 77 77 Stratum_1     B_17          8 Patient Navigator
## 78 78 Stratum_1     B_17          8 Patient Navigator
## 79 79 Stratum_1     B_17          8           Control
## 80 80 Stratum_1     B_17          8           Control
##  [ reached 'max' / getOption("max.print") -- omitted 20 rows ]
```
 
### Now stratum 2
 

```r
set.seed(0714)
stratum2 <- blockrand(n = 100,
                      block.prefix = "B_",
                      stratum = "Stratum_2",
                      num.levels = 2,
                      levels = c("Patient Navigator", "Control")
                      ) %>% filter(id <101)
stratum2
```

```
##    id   stratum block.id block.size         treatment
## 1   1 Stratum_2     B_01          6 Patient Navigator
## 2   2 Stratum_2     B_01          6 Patient Navigator
## 3   3 Stratum_2     B_01          6           Control
## 4   4 Stratum_2     B_01          6           Control
## 5   5 Stratum_2     B_01          6 Patient Navigator
## 6   6 Stratum_2     B_01          6           Control
## 7   7 Stratum_2     B_02          4           Control
## 8   8 Stratum_2     B_02          4 Patient Navigator
## 9   9 Stratum_2     B_02          4           Control
## 10 10 Stratum_2     B_02          4 Patient Navigator
## 11 11 Stratum_2     B_03          4           Control
## 12 12 Stratum_2     B_03          4 Patient Navigator
## 13 13 Stratum_2     B_03          4 Patient Navigator
## 14 14 Stratum_2     B_03          4           Control
## 15 15 Stratum_2     B_04          4           Control
## 16 16 Stratum_2     B_04          4           Control
## 17 17 Stratum_2     B_04          4 Patient Navigator
## 18 18 Stratum_2     B_04          4 Patient Navigator
## 19 19 Stratum_2     B_05          4           Control
## 20 20 Stratum_2     B_05          4           Control
## 21 21 Stratum_2     B_05          4 Patient Navigator
## 22 22 Stratum_2     B_05          4 Patient Navigator
## 23 23 Stratum_2     B_06          8 Patient Navigator
## 24 24 Stratum_2     B_06          8 Patient Navigator
## 25 25 Stratum_2     B_06          8 Patient Navigator
## 26 26 Stratum_2     B_06          8           Control
## 27 27 Stratum_2     B_06          8           Control
## 28 28 Stratum_2     B_06          8 Patient Navigator
## 29 29 Stratum_2     B_06          8           Control
## 30 30 Stratum_2     B_06          8           Control
## 31 31 Stratum_2     B_07          2 Patient Navigator
## 32 32 Stratum_2     B_07          2           Control
## 33 33 Stratum_2     B_08          2 Patient Navigator
## 34 34 Stratum_2     B_08          2           Control
## 35 35 Stratum_2     B_09          6 Patient Navigator
## 36 36 Stratum_2     B_09          6           Control
## 37 37 Stratum_2     B_09          6           Control
## 38 38 Stratum_2     B_09          6 Patient Navigator
## 39 39 Stratum_2     B_09          6 Patient Navigator
## 40 40 Stratum_2     B_09          6           Control
## 41 41 Stratum_2     B_10          4 Patient Navigator
## 42 42 Stratum_2     B_10          4           Control
## 43 43 Stratum_2     B_10          4 Patient Navigator
## 44 44 Stratum_2     B_10          4           Control
## 45 45 Stratum_2     B_11          2           Control
## 46 46 Stratum_2     B_11          2 Patient Navigator
## 47 47 Stratum_2     B_12          4 Patient Navigator
## 48 48 Stratum_2     B_12          4           Control
## 49 49 Stratum_2     B_12          4 Patient Navigator
## 50 50 Stratum_2     B_12          4           Control
## 51 51 Stratum_2     B_13          6           Control
## 52 52 Stratum_2     B_13          6           Control
## 53 53 Stratum_2     B_13          6           Control
## 54 54 Stratum_2     B_13          6 Patient Navigator
## 55 55 Stratum_2     B_13          6 Patient Navigator
## 56 56 Stratum_2     B_13          6 Patient Navigator
## 57 57 Stratum_2     B_14          8 Patient Navigator
## 58 58 Stratum_2     B_14          8           Control
## 59 59 Stratum_2     B_14          8 Patient Navigator
## 60 60 Stratum_2     B_14          8           Control
## 61 61 Stratum_2     B_14          8           Control
## 62 62 Stratum_2     B_14          8 Patient Navigator
## 63 63 Stratum_2     B_14          8           Control
## 64 64 Stratum_2     B_14          8 Patient Navigator
## 65 65 Stratum_2     B_15          2 Patient Navigator
## 66 66 Stratum_2     B_15          2           Control
## 67 67 Stratum_2     B_16          2 Patient Navigator
## 68 68 Stratum_2     B_16          2           Control
## 69 69 Stratum_2     B_17          2           Control
## 70 70 Stratum_2     B_17          2 Patient Navigator
## 71 71 Stratum_2     B_18          4 Patient Navigator
## 72 72 Stratum_2     B_18          4 Patient Navigator
## 73 73 Stratum_2     B_18          4           Control
## 74 74 Stratum_2     B_18          4           Control
## 75 75 Stratum_2     B_19          6           Control
## 76 76 Stratum_2     B_19          6 Patient Navigator
## 77 77 Stratum_2     B_19          6           Control
## 78 78 Stratum_2     B_19          6 Patient Navigator
## 79 79 Stratum_2     B_19          6 Patient Navigator
## 80 80 Stratum_2     B_19          6           Control
##  [ reached 'max' / getOption("max.print") -- omitted 20 rows ]
```
 
 
### Now stratum 3
 

```r
set.seed(1965)
stratum3 <- blockrand(n = 100,
                      block.prefix = "B_",
                      stratum = "Stratum_3",
                      num.levels = 2,
                      levels = c("Patient Navigator", "Control")
                      ) %>% filter(id <101)
stratum3
```

```
##    id   stratum block.id block.size         treatment
## 1   1 Stratum_3     B_01          8           Control
## 2   2 Stratum_3     B_01          8 Patient Navigator
## 3   3 Stratum_3     B_01          8 Patient Navigator
## 4   4 Stratum_3     B_01          8           Control
## 5   5 Stratum_3     B_01          8           Control
## 6   6 Stratum_3     B_01          8           Control
## 7   7 Stratum_3     B_01          8 Patient Navigator
## 8   8 Stratum_3     B_01          8 Patient Navigator
## 9   9 Stratum_3     B_02          4           Control
## 10 10 Stratum_3     B_02          4 Patient Navigator
## 11 11 Stratum_3     B_02          4 Patient Navigator
## 12 12 Stratum_3     B_02          4           Control
## 13 13 Stratum_3     B_03          6 Patient Navigator
## 14 14 Stratum_3     B_03          6 Patient Navigator
## 15 15 Stratum_3     B_03          6           Control
## 16 16 Stratum_3     B_03          6 Patient Navigator
## 17 17 Stratum_3     B_03          6           Control
## 18 18 Stratum_3     B_03          6           Control
## 19 19 Stratum_3     B_04          2           Control
## 20 20 Stratum_3     B_04          2 Patient Navigator
## 21 21 Stratum_3     B_05          2           Control
## 22 22 Stratum_3     B_05          2 Patient Navigator
## 23 23 Stratum_3     B_06          6           Control
## 24 24 Stratum_3     B_06          6           Control
## 25 25 Stratum_3     B_06          6 Patient Navigator
## 26 26 Stratum_3     B_06          6           Control
## 27 27 Stratum_3     B_06          6 Patient Navigator
## 28 28 Stratum_3     B_06          6 Patient Navigator
## 29 29 Stratum_3     B_07          6 Patient Navigator
## 30 30 Stratum_3     B_07          6           Control
## 31 31 Stratum_3     B_07          6           Control
## 32 32 Stratum_3     B_07          6           Control
## 33 33 Stratum_3     B_07          6 Patient Navigator
## 34 34 Stratum_3     B_07          6 Patient Navigator
## 35 35 Stratum_3     B_08          8           Control
## 36 36 Stratum_3     B_08          8           Control
## 37 37 Stratum_3     B_08          8           Control
## 38 38 Stratum_3     B_08          8           Control
## 39 39 Stratum_3     B_08          8 Patient Navigator
## 40 40 Stratum_3     B_08          8 Patient Navigator
## 41 41 Stratum_3     B_08          8 Patient Navigator
## 42 42 Stratum_3     B_08          8 Patient Navigator
## 43 43 Stratum_3     B_09          6 Patient Navigator
## 44 44 Stratum_3     B_09          6           Control
## 45 45 Stratum_3     B_09          6           Control
## 46 46 Stratum_3     B_09          6 Patient Navigator
## 47 47 Stratum_3     B_09          6           Control
## 48 48 Stratum_3     B_09          6 Patient Navigator
## 49 49 Stratum_3     B_10          6           Control
## 50 50 Stratum_3     B_10          6 Patient Navigator
## 51 51 Stratum_3     B_10          6           Control
## 52 52 Stratum_3     B_10          6           Control
## 53 53 Stratum_3     B_10          6 Patient Navigator
## 54 54 Stratum_3     B_10          6 Patient Navigator
## 55 55 Stratum_3     B_11          8 Patient Navigator
## 56 56 Stratum_3     B_11          8 Patient Navigator
## 57 57 Stratum_3     B_11          8           Control
## 58 58 Stratum_3     B_11          8           Control
## 59 59 Stratum_3     B_11          8 Patient Navigator
## 60 60 Stratum_3     B_11          8           Control
## 61 61 Stratum_3     B_11          8 Patient Navigator
## 62 62 Stratum_3     B_11          8           Control
## 63 63 Stratum_3     B_12          6           Control
## 64 64 Stratum_3     B_12          6           Control
## 65 65 Stratum_3     B_12          6 Patient Navigator
## 66 66 Stratum_3     B_12          6 Patient Navigator
## 67 67 Stratum_3     B_12          6 Patient Navigator
## 68 68 Stratum_3     B_12          6           Control
## 69 69 Stratum_3     B_13          4 Patient Navigator
## 70 70 Stratum_3     B_13          4 Patient Navigator
## 71 71 Stratum_3     B_13          4           Control
## 72 72 Stratum_3     B_13          4           Control
## 73 73 Stratum_3     B_14          2 Patient Navigator
## 74 74 Stratum_3     B_14          2           Control
## 75 75 Stratum_3     B_15          6           Control
## 76 76 Stratum_3     B_15          6           Control
## 77 77 Stratum_3     B_15          6 Patient Navigator
## 78 78 Stratum_3     B_15          6 Patient Navigator
## 79 79 Stratum_3     B_15          6 Patient Navigator
## 80 80 Stratum_3     B_15          6           Control
##  [ reached 'max' / getOption("max.print") -- omitted 20 rows ]
```
 
### Now stratum 4
 

```r
set.seed(314159)
stratum4 <- blockrand(n = 100,
                      block.prefix = "B_",
                      stratum = "Stratum_4",
                      num.levels = 2,
                      levels = c("Patient Navigator", "Control")
                      ) %>% filter(id <101)
stratum4
```

```
##    id   stratum block.id block.size         treatment
## 1   1 Stratum_4     B_01          4           Control
## 2   2 Stratum_4     B_01          4 Patient Navigator
## 3   3 Stratum_4     B_01          4 Patient Navigator
## 4   4 Stratum_4     B_01          4           Control
## 5   5 Stratum_4     B_02          2           Control
## 6   6 Stratum_4     B_02          2 Patient Navigator
## 7   7 Stratum_4     B_03          2 Patient Navigator
## 8   8 Stratum_4     B_03          2           Control
## 9   9 Stratum_4     B_04          6           Control
## 10 10 Stratum_4     B_04          6 Patient Navigator
## 11 11 Stratum_4     B_04          6 Patient Navigator
## 12 12 Stratum_4     B_04          6           Control
## 13 13 Stratum_4     B_04          6 Patient Navigator
## 14 14 Stratum_4     B_04          6           Control
## 15 15 Stratum_4     B_05          2 Patient Navigator
## 16 16 Stratum_4     B_05          2           Control
## 17 17 Stratum_4     B_06          2 Patient Navigator
## 18 18 Stratum_4     B_06          2           Control
## 19 19 Stratum_4     B_07          4 Patient Navigator
## 20 20 Stratum_4     B_07          4           Control
## 21 21 Stratum_4     B_07          4 Patient Navigator
## 22 22 Stratum_4     B_07          4           Control
## 23 23 Stratum_4     B_08          2 Patient Navigator
## 24 24 Stratum_4     B_08          2           Control
## 25 25 Stratum_4     B_09          4           Control
## 26 26 Stratum_4     B_09          4 Patient Navigator
## 27 27 Stratum_4     B_09          4           Control
## 28 28 Stratum_4     B_09          4 Patient Navigator
## 29 29 Stratum_4     B_10          2 Patient Navigator
## 30 30 Stratum_4     B_10          2           Control
## 31 31 Stratum_4     B_11          6           Control
## 32 32 Stratum_4     B_11          6 Patient Navigator
## 33 33 Stratum_4     B_11          6           Control
## 34 34 Stratum_4     B_11          6 Patient Navigator
## 35 35 Stratum_4     B_11          6           Control
## 36 36 Stratum_4     B_11          6 Patient Navigator
## 37 37 Stratum_4     B_12          8           Control
## 38 38 Stratum_4     B_12          8 Patient Navigator
## 39 39 Stratum_4     B_12          8           Control
## 40 40 Stratum_4     B_12          8           Control
## 41 41 Stratum_4     B_12          8 Patient Navigator
## 42 42 Stratum_4     B_12          8           Control
## 43 43 Stratum_4     B_12          8 Patient Navigator
## 44 44 Stratum_4     B_12          8 Patient Navigator
## 45 45 Stratum_4     B_13          4 Patient Navigator
## 46 46 Stratum_4     B_13          4 Patient Navigator
## 47 47 Stratum_4     B_13          4           Control
## 48 48 Stratum_4     B_13          4           Control
## 49 49 Stratum_4     B_14          4 Patient Navigator
## 50 50 Stratum_4     B_14          4 Patient Navigator
## 51 51 Stratum_4     B_14          4           Control
## 52 52 Stratum_4     B_14          4           Control
## 53 53 Stratum_4     B_15          4 Patient Navigator
## 54 54 Stratum_4     B_15          4 Patient Navigator
## 55 55 Stratum_4     B_15          4           Control
## 56 56 Stratum_4     B_15          4           Control
## 57 57 Stratum_4     B_16          4 Patient Navigator
## 58 58 Stratum_4     B_16          4           Control
## 59 59 Stratum_4     B_16          4 Patient Navigator
## 60 60 Stratum_4     B_16          4           Control
## 61 61 Stratum_4     B_17          4           Control
## 62 62 Stratum_4     B_17          4 Patient Navigator
## 63 63 Stratum_4     B_17          4           Control
## 64 64 Stratum_4     B_17          4 Patient Navigator
## 65 65 Stratum_4     B_18          6           Control
## 66 66 Stratum_4     B_18          6           Control
## 67 67 Stratum_4     B_18          6 Patient Navigator
## 68 68 Stratum_4     B_18          6 Patient Navigator
## 69 69 Stratum_4     B_18          6           Control
## 70 70 Stratum_4     B_18          6 Patient Navigator
## 71 71 Stratum_4     B_19          6 Patient Navigator
## 72 72 Stratum_4     B_19          6           Control
## 73 73 Stratum_4     B_19          6           Control
## 74 74 Stratum_4     B_19          6 Patient Navigator
## 75 75 Stratum_4     B_19          6 Patient Navigator
## 76 76 Stratum_4     B_19          6           Control
## 77 77 Stratum_4     B_20          6           Control
## 78 78 Stratum_4     B_20          6 Patient Navigator
## 79 79 Stratum_4     B_20          6 Patient Navigator
## 80 80 Stratum_4     B_20          6           Control
##  [ reached 'max' / getOption("max.print") -- omitted 20 rows ]
```
 
### Now Stratum 5
 

```r
set.seed(2718)
stratum5 <- blockrand(n = 100,
                      block.prefix = "B_",
                      stratum = "Stratum_5",
                      num.levels = 2,
                      levels = c("Patient Navigator", "Control")
                      ) %>% filter(id <101)
stratum5
```

```
##    id   stratum block.id block.size         treatment
## 1   1 Stratum_5     B_01          2 Patient Navigator
## 2   2 Stratum_5     B_01          2           Control
## 3   3 Stratum_5     B_02          8           Control
## 4   4 Stratum_5     B_02          8           Control
## 5   5 Stratum_5     B_02          8           Control
## 6   6 Stratum_5     B_02          8           Control
## 7   7 Stratum_5     B_02          8 Patient Navigator
## 8   8 Stratum_5     B_02          8 Patient Navigator
## 9   9 Stratum_5     B_02          8 Patient Navigator
## 10 10 Stratum_5     B_02          8 Patient Navigator
## 11 11 Stratum_5     B_03          4 Patient Navigator
## 12 12 Stratum_5     B_03          4 Patient Navigator
## 13 13 Stratum_5     B_03          4           Control
## 14 14 Stratum_5     B_03          4           Control
## 15 15 Stratum_5     B_04          8 Patient Navigator
## 16 16 Stratum_5     B_04          8           Control
## 17 17 Stratum_5     B_04          8 Patient Navigator
## 18 18 Stratum_5     B_04          8           Control
## 19 19 Stratum_5     B_04          8 Patient Navigator
## 20 20 Stratum_5     B_04          8           Control
## 21 21 Stratum_5     B_04          8 Patient Navigator
## 22 22 Stratum_5     B_04          8           Control
## 23 23 Stratum_5     B_05          6           Control
## 24 24 Stratum_5     B_05          6 Patient Navigator
## 25 25 Stratum_5     B_05          6 Patient Navigator
## 26 26 Stratum_5     B_05          6 Patient Navigator
## 27 27 Stratum_5     B_05          6           Control
## 28 28 Stratum_5     B_05          6           Control
## 29 29 Stratum_5     B_06          6           Control
## 30 30 Stratum_5     B_06          6 Patient Navigator
## 31 31 Stratum_5     B_06          6           Control
## 32 32 Stratum_5     B_06          6 Patient Navigator
## 33 33 Stratum_5     B_06          6           Control
## 34 34 Stratum_5     B_06          6 Patient Navigator
## 35 35 Stratum_5     B_07          2           Control
## 36 36 Stratum_5     B_07          2 Patient Navigator
## 37 37 Stratum_5     B_08          4           Control
## 38 38 Stratum_5     B_08          4 Patient Navigator
## 39 39 Stratum_5     B_08          4           Control
## 40 40 Stratum_5     B_08          4 Patient Navigator
## 41 41 Stratum_5     B_09          6 Patient Navigator
## 42 42 Stratum_5     B_09          6 Patient Navigator
## 43 43 Stratum_5     B_09          6 Patient Navigator
## 44 44 Stratum_5     B_09          6           Control
## 45 45 Stratum_5     B_09          6           Control
## 46 46 Stratum_5     B_09          6           Control
## 47 47 Stratum_5     B_10          6 Patient Navigator
## 48 48 Stratum_5     B_10          6           Control
## 49 49 Stratum_5     B_10          6           Control
## 50 50 Stratum_5     B_10          6           Control
## 51 51 Stratum_5     B_10          6 Patient Navigator
## 52 52 Stratum_5     B_10          6 Patient Navigator
## 53 53 Stratum_5     B_11          2 Patient Navigator
## 54 54 Stratum_5     B_11          2           Control
## 55 55 Stratum_5     B_12          6           Control
## 56 56 Stratum_5     B_12          6           Control
## 57 57 Stratum_5     B_12          6 Patient Navigator
## 58 58 Stratum_5     B_12          6 Patient Navigator
## 59 59 Stratum_5     B_12          6 Patient Navigator
## 60 60 Stratum_5     B_12          6           Control
## 61 61 Stratum_5     B_13          2           Control
## 62 62 Stratum_5     B_13          2 Patient Navigator
## 63 63 Stratum_5     B_14          2 Patient Navigator
## 64 64 Stratum_5     B_14          2           Control
## 65 65 Stratum_5     B_15          6 Patient Navigator
## 66 66 Stratum_5     B_15          6 Patient Navigator
## 67 67 Stratum_5     B_15          6 Patient Navigator
## 68 68 Stratum_5     B_15          6           Control
## 69 69 Stratum_5     B_15          6           Control
## 70 70 Stratum_5     B_15          6           Control
## 71 71 Stratum_5     B_16          4 Patient Navigator
## 72 72 Stratum_5     B_16          4 Patient Navigator
## 73 73 Stratum_5     B_16          4           Control
## 74 74 Stratum_5     B_16          4           Control
## 75 75 Stratum_5     B_17          6 Patient Navigator
## 76 76 Stratum_5     B_17          6           Control
## 77 77 Stratum_5     B_17          6 Patient Navigator
## 78 78 Stratum_5     B_17          6           Control
## 79 79 Stratum_5     B_17          6 Patient Navigator
## 80 80 Stratum_5     B_17          6           Control
##  [ reached 'max' / getOption("max.print") -- omitted 20 rows ]
```
 
## Randomization Schedule
now bind these together in one assignment sheet,
so that we have one randomization schedule for all 5 strata.
 

```r
assign500 <- rbind(stratum1, stratum2, stratum3, stratum4, stratum5)
assign500 %>%
  rename(num = id) %>%
  select(stratum, num, treatment, block.id, block.size) %>%
  knitr::kable() %>%
  kable_styling()
```

\begin{table}[H]
\centering
\begin{tabular}{l|r|l|l|r}
\hline
stratum & num & treatment & block.id & block.size\\
\hline
Stratum\_1 & 1 & Control & B\_01 & 8\\
\hline
Stratum\_1 & 2 & Control & B\_01 & 8\\
\hline
Stratum\_1 & 3 & Control & B\_01 & 8\\
\hline
Stratum\_1 & 4 & Patient Navigator & B\_01 & 8\\
\hline
Stratum\_1 & 5 & Control & B\_01 & 8\\
\hline
Stratum\_1 & 6 & Patient Navigator & B\_01 & 8\\
\hline
Stratum\_1 & 7 & Patient Navigator & B\_01 & 8\\
\hline
Stratum\_1 & 8 & Patient Navigator & B\_01 & 8\\
\hline
Stratum\_1 & 9 & Control & B\_02 & 4\\
\hline
Stratum\_1 & 10 & Control & B\_02 & 4\\
\hline
Stratum\_1 & 11 & Patient Navigator & B\_02 & 4\\
\hline
Stratum\_1 & 12 & Patient Navigator & B\_02 & 4\\
\hline
Stratum\_1 & 13 & Control & B\_03 & 4\\
\hline
Stratum\_1 & 14 & Patient Navigator & B\_03 & 4\\
\hline
Stratum\_1 & 15 & Control & B\_03 & 4\\
\hline
Stratum\_1 & 16 & Patient Navigator & B\_03 & 4\\
\hline
Stratum\_1 & 17 & Control & B\_04 & 4\\
\hline
Stratum\_1 & 18 & Control & B\_04 & 4\\
\hline
Stratum\_1 & 19 & Patient Navigator & B\_04 & 4\\
\hline
Stratum\_1 & 20 & Patient Navigator & B\_04 & 4\\
\hline
Stratum\_1 & 21 & Control & B\_05 & 2\\
\hline
Stratum\_1 & 22 & Patient Navigator & B\_05 & 2\\
\hline
Stratum\_1 & 23 & Patient Navigator & B\_06 & 8\\
\hline
Stratum\_1 & 24 & Control & B\_06 & 8\\
\hline
Stratum\_1 & 25 & Patient Navigator & B\_06 & 8\\
\hline
Stratum\_1 & 26 & Control & B\_06 & 8\\
\hline
Stratum\_1 & 27 & Patient Navigator & B\_06 & 8\\
\hline
Stratum\_1 & 28 & Control & B\_06 & 8\\
\hline
Stratum\_1 & 29 & Control & B\_06 & 8\\
\hline
Stratum\_1 & 30 & Patient Navigator & B\_06 & 8\\
\hline
Stratum\_1 & 31 & Patient Navigator & B\_07 & 8\\
\hline
Stratum\_1 & 32 & Control & B\_07 & 8\\
\hline
Stratum\_1 & 33 & Patient Navigator & B\_07 & 8\\
\hline
Stratum\_1 & 34 & Control & B\_07 & 8\\
\hline
Stratum\_1 & 35 & Patient Navigator & B\_07 & 8\\
\hline
Stratum\_1 & 36 & Patient Navigator & B\_07 & 8\\
\hline
Stratum\_1 & 37 & Control & B\_07 & 8\\
\hline
Stratum\_1 & 38 & Control & B\_07 & 8\\
\hline
Stratum\_1 & 39 & Control & B\_08 & 8\\
\hline
Stratum\_1 & 40 & Control & B\_08 & 8\\
\hline
Stratum\_1 & 41 & Patient Navigator & B\_08 & 8\\
\hline
Stratum\_1 & 42 & Patient Navigator & B\_08 & 8\\
\hline
Stratum\_1 & 43 & Patient Navigator & B\_08 & 8\\
\hline
Stratum\_1 & 44 & Control & B\_08 & 8\\
\hline
Stratum\_1 & 45 & Patient Navigator & B\_08 & 8\\
\hline
Stratum\_1 & 46 & Control & B\_08 & 8\\
\hline
Stratum\_1 & 47 & Control & B\_09 & 4\\
\hline
Stratum\_1 & 48 & Patient Navigator & B\_09 & 4\\
\hline
Stratum\_1 & 49 & Control & B\_09 & 4\\
\hline
Stratum\_1 & 50 & Patient Navigator & B\_09 & 4\\
\hline
Stratum\_1 & 51 & Control & B\_10 & 2\\
\hline
Stratum\_1 & 52 & Patient Navigator & B\_10 & 2\\
\hline
Stratum\_1 & 53 & Control & B\_11 & 2\\
\hline
Stratum\_1 & 54 & Patient Navigator & B\_11 & 2\\
\hline
Stratum\_1 & 55 & Patient Navigator & B\_12 & 2\\
\hline
Stratum\_1 & 56 & Control & B\_12 & 2\\
\hline
Stratum\_1 & 57 & Control & B\_13 & 8\\
\hline
Stratum\_1 & 58 & Patient Navigator & B\_13 & 8\\
\hline
Stratum\_1 & 59 & Control & B\_13 & 8\\
\hline
Stratum\_1 & 60 & Patient Navigator & B\_13 & 8\\
\hline
Stratum\_1 & 61 & Patient Navigator & B\_13 & 8\\
\hline
Stratum\_1 & 62 & Patient Navigator & B\_13 & 8\\
\hline
Stratum\_1 & 63 & Control & B\_13 & 8\\
\hline
Stratum\_1 & 64 & Control & B\_13 & 8\\
\hline
Stratum\_1 & 65 & Patient Navigator & B\_14 & 4\\
\hline
Stratum\_1 & 66 & Control & B\_14 & 4\\
\hline
Stratum\_1 & 67 & Control & B\_14 & 4\\
\hline
Stratum\_1 & 68 & Patient Navigator & B\_14 & 4\\
\hline
Stratum\_1 & 69 & Patient Navigator & B\_15 & 2\\
\hline
Stratum\_1 & 70 & Control & B\_15 & 2\\
\hline
Stratum\_1 & 71 & Patient Navigator & B\_16 & 4\\
\hline
Stratum\_1 & 72 & Control & B\_16 & 4\\
\hline
Stratum\_1 & 73 & Control & B\_16 & 4\\
\hline
Stratum\_1 & 74 & Patient Navigator & B\_16 & 4\\
\hline
Stratum\_1 & 75 & Control & B\_17 & 8\\
\hline
Stratum\_1 & 76 & Patient Navigator & B\_17 & 8\\
\hline
Stratum\_1 & 77 & Patient Navigator & B\_17 & 8\\
\hline
Stratum\_1 & 78 & Patient Navigator & B\_17 & 8\\
\hline
Stratum\_1 & 79 & Control & B\_17 & 8\\
\hline
Stratum\_1 & 80 & Control & B\_17 & 8\\
\hline
Stratum\_1 & 81 & Patient Navigator & B\_17 & 8\\
\hline
Stratum\_1 & 82 & Control & B\_17 & 8\\
\hline
Stratum\_1 & 83 & Control & B\_18 & 8\\
\hline
Stratum\_1 & 84 & Control & B\_18 & 8\\
\hline
Stratum\_1 & 85 & Patient Navigator & B\_18 & 8\\
\hline
Stratum\_1 & 86 & Patient Navigator & B\_18 & 8\\
\hline
Stratum\_1 & 87 & Patient Navigator & B\_18 & 8\\
\hline
Stratum\_1 & 88 & Patient Navigator & B\_18 & 8\\
\hline
Stratum\_1 & 89 & Control & B\_18 & 8\\
\hline
Stratum\_1 & 90 & Control & B\_18 & 8\\
\hline
Stratum\_1 & 91 & Patient Navigator & B\_19 & 4\\
\hline
Stratum\_1 & 92 & Patient Navigator & B\_19 & 4\\
\hline
Stratum\_1 & 93 & Control & B\_19 & 4\\
\hline
Stratum\_1 & 94 & Control & B\_19 & 4\\
\hline
Stratum\_1 & 95 & Control & B\_20 & 4\\
\hline
Stratum\_1 & 96 & Patient Navigator & B\_20 & 4\\
\hline
Stratum\_1 & 97 & Patient Navigator & B\_20 & 4\\
\hline
Stratum\_1 & 98 & Control & B\_20 & 4\\
\hline
Stratum\_1 & 99 & Patient Navigator & B\_21 & 2\\
\hline
Stratum\_1 & 100 & Control & B\_21 & 2\\
\hline
Stratum\_2 & 1 & Patient Navigator & B\_01 & 6\\
\hline
Stratum\_2 & 2 & Patient Navigator & B\_01 & 6\\
\hline
Stratum\_2 & 3 & Control & B\_01 & 6\\
\hline
Stratum\_2 & 4 & Control & B\_01 & 6\\
\hline
Stratum\_2 & 5 & Patient Navigator & B\_01 & 6\\
\hline
Stratum\_2 & 6 & Control & B\_01 & 6\\
\hline
Stratum\_2 & 7 & Control & B\_02 & 4\\
\hline
Stratum\_2 & 8 & Patient Navigator & B\_02 & 4\\
\hline
Stratum\_2 & 9 & Control & B\_02 & 4\\
\hline
Stratum\_2 & 10 & Patient Navigator & B\_02 & 4\\
\hline
Stratum\_2 & 11 & Control & B\_03 & 4\\
\hline
Stratum\_2 & 12 & Patient Navigator & B\_03 & 4\\
\hline
Stratum\_2 & 13 & Patient Navigator & B\_03 & 4\\
\hline
Stratum\_2 & 14 & Control & B\_03 & 4\\
\hline
Stratum\_2 & 15 & Control & B\_04 & 4\\
\hline
Stratum\_2 & 16 & Control & B\_04 & 4\\
\hline
Stratum\_2 & 17 & Patient Navigator & B\_04 & 4\\
\hline
Stratum\_2 & 18 & Patient Navigator & B\_04 & 4\\
\hline
Stratum\_2 & 19 & Control & B\_05 & 4\\
\hline
Stratum\_2 & 20 & Control & B\_05 & 4\\
\hline
Stratum\_2 & 21 & Patient Navigator & B\_05 & 4\\
\hline
Stratum\_2 & 22 & Patient Navigator & B\_05 & 4\\
\hline
Stratum\_2 & 23 & Patient Navigator & B\_06 & 8\\
\hline
Stratum\_2 & 24 & Patient Navigator & B\_06 & 8\\
\hline
Stratum\_2 & 25 & Patient Navigator & B\_06 & 8\\
\hline
Stratum\_2 & 26 & Control & B\_06 & 8\\
\hline
Stratum\_2 & 27 & Control & B\_06 & 8\\
\hline
Stratum\_2 & 28 & Patient Navigator & B\_06 & 8\\
\hline
Stratum\_2 & 29 & Control & B\_06 & 8\\
\hline
Stratum\_2 & 30 & Control & B\_06 & 8\\
\hline
Stratum\_2 & 31 & Patient Navigator & B\_07 & 2\\
\hline
Stratum\_2 & 32 & Control & B\_07 & 2\\
\hline
Stratum\_2 & 33 & Patient Navigator & B\_08 & 2\\
\hline
Stratum\_2 & 34 & Control & B\_08 & 2\\
\hline
Stratum\_2 & 35 & Patient Navigator & B\_09 & 6\\
\hline
Stratum\_2 & 36 & Control & B\_09 & 6\\
\hline
Stratum\_2 & 37 & Control & B\_09 & 6\\
\hline
Stratum\_2 & 38 & Patient Navigator & B\_09 & 6\\
\hline
Stratum\_2 & 39 & Patient Navigator & B\_09 & 6\\
\hline
Stratum\_2 & 40 & Control & B\_09 & 6\\
\hline
Stratum\_2 & 41 & Patient Navigator & B\_10 & 4\\
\hline
Stratum\_2 & 42 & Control & B\_10 & 4\\
\hline
Stratum\_2 & 43 & Patient Navigator & B\_10 & 4\\
\hline
Stratum\_2 & 44 & Control & B\_10 & 4\\
\hline
Stratum\_2 & 45 & Control & B\_11 & 2\\
\hline
Stratum\_2 & 46 & Patient Navigator & B\_11 & 2\\
\hline
Stratum\_2 & 47 & Patient Navigator & B\_12 & 4\\
\hline
Stratum\_2 & 48 & Control & B\_12 & 4\\
\hline
Stratum\_2 & 49 & Patient Navigator & B\_12 & 4\\
\hline
Stratum\_2 & 50 & Control & B\_12 & 4\\
\hline
Stratum\_2 & 51 & Control & B\_13 & 6\\
\hline
Stratum\_2 & 52 & Control & B\_13 & 6\\
\hline
Stratum\_2 & 53 & Control & B\_13 & 6\\
\hline
Stratum\_2 & 54 & Patient Navigator & B\_13 & 6\\
\hline
Stratum\_2 & 55 & Patient Navigator & B\_13 & 6\\
\hline
Stratum\_2 & 56 & Patient Navigator & B\_13 & 6\\
\hline
Stratum\_2 & 57 & Patient Navigator & B\_14 & 8\\
\hline
Stratum\_2 & 58 & Control & B\_14 & 8\\
\hline
Stratum\_2 & 59 & Patient Navigator & B\_14 & 8\\
\hline
Stratum\_2 & 60 & Control & B\_14 & 8\\
\hline
Stratum\_2 & 61 & Control & B\_14 & 8\\
\hline
Stratum\_2 & 62 & Patient Navigator & B\_14 & 8\\
\hline
Stratum\_2 & 63 & Control & B\_14 & 8\\
\hline
Stratum\_2 & 64 & Patient Navigator & B\_14 & 8\\
\hline
Stratum\_2 & 65 & Patient Navigator & B\_15 & 2\\
\hline
Stratum\_2 & 66 & Control & B\_15 & 2\\
\hline
Stratum\_2 & 67 & Patient Navigator & B\_16 & 2\\
\hline
Stratum\_2 & 68 & Control & B\_16 & 2\\
\hline
Stratum\_2 & 69 & Control & B\_17 & 2\\
\hline
Stratum\_2 & 70 & Patient Navigator & B\_17 & 2\\
\hline
Stratum\_2 & 71 & Patient Navigator & B\_18 & 4\\
\hline
Stratum\_2 & 72 & Patient Navigator & B\_18 & 4\\
\hline
Stratum\_2 & 73 & Control & B\_18 & 4\\
\hline
Stratum\_2 & 74 & Control & B\_18 & 4\\
\hline
Stratum\_2 & 75 & Control & B\_19 & 6\\
\hline
Stratum\_2 & 76 & Patient Navigator & B\_19 & 6\\
\hline
Stratum\_2 & 77 & Control & B\_19 & 6\\
\hline
Stratum\_2 & 78 & Patient Navigator & B\_19 & 6\\
\hline
Stratum\_2 & 79 & Patient Navigator & B\_19 & 6\\
\hline
Stratum\_2 & 80 & Control & B\_19 & 6\\
\hline
Stratum\_2 & 81 & Patient Navigator & B\_20 & 6\\
\hline
Stratum\_2 & 82 & Control & B\_20 & 6\\
\hline
Stratum\_2 & 83 & Patient Navigator & B\_20 & 6\\
\hline
Stratum\_2 & 84 & Control & B\_20 & 6\\
\hline
Stratum\_2 & 85 & Patient Navigator & B\_20 & 6\\
\hline
Stratum\_2 & 86 & Control & B\_20 & 6\\
\hline
Stratum\_2 & 87 & Control & B\_21 & 4\\
\hline
Stratum\_2 & 88 & Control & B\_21 & 4\\
\hline
Stratum\_2 & 89 & Patient Navigator & B\_21 & 4\\
\hline
Stratum\_2 & 90 & Patient Navigator & B\_21 & 4\\
\hline
Stratum\_2 & 91 & Patient Navigator & B\_22 & 8\\
\hline
Stratum\_2 & 92 & Control & B\_22 & 8\\
\hline
Stratum\_2 & 93 & Patient Navigator & B\_22 & 8\\
\hline
Stratum\_2 & 94 & Control & B\_22 & 8\\
\hline
Stratum\_2 & 95 & Control & B\_22 & 8\\
\hline
Stratum\_2 & 96 & Patient Navigator & B\_22 & 8\\
\hline
Stratum\_2 & 97 & Control & B\_22 & 8\\
\hline
Stratum\_2 & 98 & Patient Navigator & B\_22 & 8\\
\hline
Stratum\_2 & 99 & Control & B\_23 & 4\\
\hline
Stratum\_2 & 100 & Patient Navigator & B\_23 & 4\\
\hline
Stratum\_3 & 1 & Control & B\_01 & 8\\
\hline
Stratum\_3 & 2 & Patient Navigator & B\_01 & 8\\
\hline
Stratum\_3 & 3 & Patient Navigator & B\_01 & 8\\
\hline
Stratum\_3 & 4 & Control & B\_01 & 8\\
\hline
Stratum\_3 & 5 & Control & B\_01 & 8\\
\hline
Stratum\_3 & 6 & Control & B\_01 & 8\\
\hline
Stratum\_3 & 7 & Patient Navigator & B\_01 & 8\\
\hline
Stratum\_3 & 8 & Patient Navigator & B\_01 & 8\\
\hline
Stratum\_3 & 9 & Control & B\_02 & 4\\
\hline
Stratum\_3 & 10 & Patient Navigator & B\_02 & 4\\
\hline
Stratum\_3 & 11 & Patient Navigator & B\_02 & 4\\
\hline
Stratum\_3 & 12 & Control & B\_02 & 4\\
\hline
Stratum\_3 & 13 & Patient Navigator & B\_03 & 6\\
\hline
Stratum\_3 & 14 & Patient Navigator & B\_03 & 6\\
\hline
Stratum\_3 & 15 & Control & B\_03 & 6\\
\hline
Stratum\_3 & 16 & Patient Navigator & B\_03 & 6\\
\hline
Stratum\_3 & 17 & Control & B\_03 & 6\\
\hline
Stratum\_3 & 18 & Control & B\_03 & 6\\
\hline
Stratum\_3 & 19 & Control & B\_04 & 2\\
\hline
Stratum\_3 & 20 & Patient Navigator & B\_04 & 2\\
\hline
Stratum\_3 & 21 & Control & B\_05 & 2\\
\hline
Stratum\_3 & 22 & Patient Navigator & B\_05 & 2\\
\hline
Stratum\_3 & 23 & Control & B\_06 & 6\\
\hline
Stratum\_3 & 24 & Control & B\_06 & 6\\
\hline
Stratum\_3 & 25 & Patient Navigator & B\_06 & 6\\
\hline
Stratum\_3 & 26 & Control & B\_06 & 6\\
\hline
Stratum\_3 & 27 & Patient Navigator & B\_06 & 6\\
\hline
Stratum\_3 & 28 & Patient Navigator & B\_06 & 6\\
\hline
Stratum\_3 & 29 & Patient Navigator & B\_07 & 6\\
\hline
Stratum\_3 & 30 & Control & B\_07 & 6\\
\hline
Stratum\_3 & 31 & Control & B\_07 & 6\\
\hline
Stratum\_3 & 32 & Control & B\_07 & 6\\
\hline
Stratum\_3 & 33 & Patient Navigator & B\_07 & 6\\
\hline
Stratum\_3 & 34 & Patient Navigator & B\_07 & 6\\
\hline
Stratum\_3 & 35 & Control & B\_08 & 8\\
\hline
Stratum\_3 & 36 & Control & B\_08 & 8\\
\hline
Stratum\_3 & 37 & Control & B\_08 & 8\\
\hline
Stratum\_3 & 38 & Control & B\_08 & 8\\
\hline
Stratum\_3 & 39 & Patient Navigator & B\_08 & 8\\
\hline
Stratum\_3 & 40 & Patient Navigator & B\_08 & 8\\
\hline
Stratum\_3 & 41 & Patient Navigator & B\_08 & 8\\
\hline
Stratum\_3 & 42 & Patient Navigator & B\_08 & 8\\
\hline
Stratum\_3 & 43 & Patient Navigator & B\_09 & 6\\
\hline
Stratum\_3 & 44 & Control & B\_09 & 6\\
\hline
Stratum\_3 & 45 & Control & B\_09 & 6\\
\hline
Stratum\_3 & 46 & Patient Navigator & B\_09 & 6\\
\hline
Stratum\_3 & 47 & Control & B\_09 & 6\\
\hline
Stratum\_3 & 48 & Patient Navigator & B\_09 & 6\\
\hline
Stratum\_3 & 49 & Control & B\_10 & 6\\
\hline
Stratum\_3 & 50 & Patient Navigator & B\_10 & 6\\
\hline
Stratum\_3 & 51 & Control & B\_10 & 6\\
\hline
Stratum\_3 & 52 & Control & B\_10 & 6\\
\hline
Stratum\_3 & 53 & Patient Navigator & B\_10 & 6\\
\hline
Stratum\_3 & 54 & Patient Navigator & B\_10 & 6\\
\hline
Stratum\_3 & 55 & Patient Navigator & B\_11 & 8\\
\hline
Stratum\_3 & 56 & Patient Navigator & B\_11 & 8\\
\hline
Stratum\_3 & 57 & Control & B\_11 & 8\\
\hline
Stratum\_3 & 58 & Control & B\_11 & 8\\
\hline
Stratum\_3 & 59 & Patient Navigator & B\_11 & 8\\
\hline
Stratum\_3 & 60 & Control & B\_11 & 8\\
\hline
Stratum\_3 & 61 & Patient Navigator & B\_11 & 8\\
\hline
Stratum\_3 & 62 & Control & B\_11 & 8\\
\hline
Stratum\_3 & 63 & Control & B\_12 & 6\\
\hline
Stratum\_3 & 64 & Control & B\_12 & 6\\
\hline
Stratum\_3 & 65 & Patient Navigator & B\_12 & 6\\
\hline
Stratum\_3 & 66 & Patient Navigator & B\_12 & 6\\
\hline
Stratum\_3 & 67 & Patient Navigator & B\_12 & 6\\
\hline
Stratum\_3 & 68 & Control & B\_12 & 6\\
\hline
Stratum\_3 & 69 & Patient Navigator & B\_13 & 4\\
\hline
Stratum\_3 & 70 & Patient Navigator & B\_13 & 4\\
\hline
Stratum\_3 & 71 & Control & B\_13 & 4\\
\hline
Stratum\_3 & 72 & Control & B\_13 & 4\\
\hline
Stratum\_3 & 73 & Patient Navigator & B\_14 & 2\\
\hline
Stratum\_3 & 74 & Control & B\_14 & 2\\
\hline
Stratum\_3 & 75 & Control & B\_15 & 6\\
\hline
Stratum\_3 & 76 & Control & B\_15 & 6\\
\hline
Stratum\_3 & 77 & Patient Navigator & B\_15 & 6\\
\hline
Stratum\_3 & 78 & Patient Navigator & B\_15 & 6\\
\hline
Stratum\_3 & 79 & Patient Navigator & B\_15 & 6\\
\hline
Stratum\_3 & 80 & Control & B\_15 & 6\\
\hline
Stratum\_3 & 81 & Control & B\_16 & 4\\
\hline
Stratum\_3 & 82 & Control & B\_16 & 4\\
\hline
Stratum\_3 & 83 & Patient Navigator & B\_16 & 4\\
\hline
Stratum\_3 & 84 & Patient Navigator & B\_16 & 4\\
\hline
Stratum\_3 & 85 & Control & B\_17 & 2\\
\hline
Stratum\_3 & 86 & Patient Navigator & B\_17 & 2\\
\hline
Stratum\_3 & 87 & Patient Navigator & B\_18 & 4\\
\hline
Stratum\_3 & 88 & Control & B\_18 & 4\\
\hline
Stratum\_3 & 89 & Patient Navigator & B\_18 & 4\\
\hline
Stratum\_3 & 90 & Control & B\_18 & 4\\
\hline
Stratum\_3 & 91 & Control & B\_19 & 8\\
\hline
Stratum\_3 & 92 & Control & B\_19 & 8\\
\hline
Stratum\_3 & 93 & Control & B\_19 & 8\\
\hline
Stratum\_3 & 94 & Patient Navigator & B\_19 & 8\\
\hline
Stratum\_3 & 95 & Patient Navigator & B\_19 & 8\\
\hline
Stratum\_3 & 96 & Patient Navigator & B\_19 & 8\\
\hline
Stratum\_3 & 97 & Control & B\_19 & 8\\
\hline
Stratum\_3 & 98 & Patient Navigator & B\_19 & 8\\
\hline
Stratum\_3 & 99 & Control & B\_20 & 4\\
\hline
Stratum\_3 & 100 & Patient Navigator & B\_20 & 4\\
\hline
Stratum\_4 & 1 & Control & B\_01 & 4\\
\hline
Stratum\_4 & 2 & Patient Navigator & B\_01 & 4\\
\hline
Stratum\_4 & 3 & Patient Navigator & B\_01 & 4\\
\hline
Stratum\_4 & 4 & Control & B\_01 & 4\\
\hline
Stratum\_4 & 5 & Control & B\_02 & 2\\
\hline
Stratum\_4 & 6 & Patient Navigator & B\_02 & 2\\
\hline
Stratum\_4 & 7 & Patient Navigator & B\_03 & 2\\
\hline
Stratum\_4 & 8 & Control & B\_03 & 2\\
\hline
Stratum\_4 & 9 & Control & B\_04 & 6\\
\hline
Stratum\_4 & 10 & Patient Navigator & B\_04 & 6\\
\hline
Stratum\_4 & 11 & Patient Navigator & B\_04 & 6\\
\hline
Stratum\_4 & 12 & Control & B\_04 & 6\\
\hline
Stratum\_4 & 13 & Patient Navigator & B\_04 & 6\\
\hline
Stratum\_4 & 14 & Control & B\_04 & 6\\
\hline
Stratum\_4 & 15 & Patient Navigator & B\_05 & 2\\
\hline
Stratum\_4 & 16 & Control & B\_05 & 2\\
\hline
Stratum\_4 & 17 & Patient Navigator & B\_06 & 2\\
\hline
Stratum\_4 & 18 & Control & B\_06 & 2\\
\hline
Stratum\_4 & 19 & Patient Navigator & B\_07 & 4\\
\hline
Stratum\_4 & 20 & Control & B\_07 & 4\\
\hline
Stratum\_4 & 21 & Patient Navigator & B\_07 & 4\\
\hline
Stratum\_4 & 22 & Control & B\_07 & 4\\
\hline
Stratum\_4 & 23 & Patient Navigator & B\_08 & 2\\
\hline
Stratum\_4 & 24 & Control & B\_08 & 2\\
\hline
Stratum\_4 & 25 & Control & B\_09 & 4\\
\hline
Stratum\_4 & 26 & Patient Navigator & B\_09 & 4\\
\hline
Stratum\_4 & 27 & Control & B\_09 & 4\\
\hline
Stratum\_4 & 28 & Patient Navigator & B\_09 & 4\\
\hline
Stratum\_4 & 29 & Patient Navigator & B\_10 & 2\\
\hline
Stratum\_4 & 30 & Control & B\_10 & 2\\
\hline
Stratum\_4 & 31 & Control & B\_11 & 6\\
\hline
Stratum\_4 & 32 & Patient Navigator & B\_11 & 6\\
\hline
Stratum\_4 & 33 & Control & B\_11 & 6\\
\hline
Stratum\_4 & 34 & Patient Navigator & B\_11 & 6\\
\hline
Stratum\_4 & 35 & Control & B\_11 & 6\\
\hline
Stratum\_4 & 36 & Patient Navigator & B\_11 & 6\\
\hline
Stratum\_4 & 37 & Control & B\_12 & 8\\
\hline
Stratum\_4 & 38 & Patient Navigator & B\_12 & 8\\
\hline
Stratum\_4 & 39 & Control & B\_12 & 8\\
\hline
Stratum\_4 & 40 & Control & B\_12 & 8\\
\hline
Stratum\_4 & 41 & Patient Navigator & B\_12 & 8\\
\hline
Stratum\_4 & 42 & Control & B\_12 & 8\\
\hline
Stratum\_4 & 43 & Patient Navigator & B\_12 & 8\\
\hline
Stratum\_4 & 44 & Patient Navigator & B\_12 & 8\\
\hline
Stratum\_4 & 45 & Patient Navigator & B\_13 & 4\\
\hline
Stratum\_4 & 46 & Patient Navigator & B\_13 & 4\\
\hline
Stratum\_4 & 47 & Control & B\_13 & 4\\
\hline
Stratum\_4 & 48 & Control & B\_13 & 4\\
\hline
Stratum\_4 & 49 & Patient Navigator & B\_14 & 4\\
\hline
Stratum\_4 & 50 & Patient Navigator & B\_14 & 4\\
\hline
Stratum\_4 & 51 & Control & B\_14 & 4\\
\hline
Stratum\_4 & 52 & Control & B\_14 & 4\\
\hline
Stratum\_4 & 53 & Patient Navigator & B\_15 & 4\\
\hline
Stratum\_4 & 54 & Patient Navigator & B\_15 & 4\\
\hline
Stratum\_4 & 55 & Control & B\_15 & 4\\
\hline
Stratum\_4 & 56 & Control & B\_15 & 4\\
\hline
Stratum\_4 & 57 & Patient Navigator & B\_16 & 4\\
\hline
Stratum\_4 & 58 & Control & B\_16 & 4\\
\hline
Stratum\_4 & 59 & Patient Navigator & B\_16 & 4\\
\hline
Stratum\_4 & 60 & Control & B\_16 & 4\\
\hline
Stratum\_4 & 61 & Control & B\_17 & 4\\
\hline
Stratum\_4 & 62 & Patient Navigator & B\_17 & 4\\
\hline
Stratum\_4 & 63 & Control & B\_17 & 4\\
\hline
Stratum\_4 & 64 & Patient Navigator & B\_17 & 4\\
\hline
Stratum\_4 & 65 & Control & B\_18 & 6\\
\hline
Stratum\_4 & 66 & Control & B\_18 & 6\\
\hline
Stratum\_4 & 67 & Patient Navigator & B\_18 & 6\\
\hline
Stratum\_4 & 68 & Patient Navigator & B\_18 & 6\\
\hline
Stratum\_4 & 69 & Control & B\_18 & 6\\
\hline
Stratum\_4 & 70 & Patient Navigator & B\_18 & 6\\
\hline
Stratum\_4 & 71 & Patient Navigator & B\_19 & 6\\
\hline
Stratum\_4 & 72 & Control & B\_19 & 6\\
\hline
Stratum\_4 & 73 & Control & B\_19 & 6\\
\hline
Stratum\_4 & 74 & Patient Navigator & B\_19 & 6\\
\hline
Stratum\_4 & 75 & Patient Navigator & B\_19 & 6\\
\hline
Stratum\_4 & 76 & Control & B\_19 & 6\\
\hline
Stratum\_4 & 77 & Control & B\_20 & 6\\
\hline
Stratum\_4 & 78 & Patient Navigator & B\_20 & 6\\
\hline
Stratum\_4 & 79 & Patient Navigator & B\_20 & 6\\
\hline
Stratum\_4 & 80 & Control & B\_20 & 6\\
\hline
Stratum\_4 & 81 & Patient Navigator & B\_20 & 6\\
\hline
Stratum\_4 & 82 & Control & B\_20 & 6\\
\hline
Stratum\_4 & 83 & Patient Navigator & B\_21 & 2\\
\hline
Stratum\_4 & 84 & Control & B\_21 & 2\\
\hline
Stratum\_4 & 85 & Patient Navigator & B\_22 & 6\\
\hline
Stratum\_4 & 86 & Control & B\_22 & 6\\
\hline
Stratum\_4 & 87 & Control & B\_22 & 6\\
\hline
Stratum\_4 & 88 & Control & B\_22 & 6\\
\hline
Stratum\_4 & 89 & Patient Navigator & B\_22 & 6\\
\hline
Stratum\_4 & 90 & Patient Navigator & B\_22 & 6\\
\hline
Stratum\_4 & 91 & Patient Navigator & B\_23 & 6\\
\hline
Stratum\_4 & 92 & Patient Navigator & B\_23 & 6\\
\hline
Stratum\_4 & 93 & Control & B\_23 & 6\\
\hline
Stratum\_4 & 94 & Control & B\_23 & 6\\
\hline
Stratum\_4 & 95 & Control & B\_23 & 6\\
\hline
Stratum\_4 & 96 & Patient Navigator & B\_23 & 6\\
\hline
Stratum\_4 & 97 & Control & B\_24 & 8\\
\hline
Stratum\_4 & 98 & Control & B\_24 & 8\\
\hline
Stratum\_4 & 99 & Patient Navigator & B\_24 & 8\\
\hline
Stratum\_4 & 100 & Control & B\_24 & 8\\
\hline
Stratum\_5 & 1 & Patient Navigator & B\_01 & 2\\
\hline
Stratum\_5 & 2 & Control & B\_01 & 2\\
\hline
Stratum\_5 & 3 & Control & B\_02 & 8\\
\hline
Stratum\_5 & 4 & Control & B\_02 & 8\\
\hline
Stratum\_5 & 5 & Control & B\_02 & 8\\
\hline
Stratum\_5 & 6 & Control & B\_02 & 8\\
\hline
Stratum\_5 & 7 & Patient Navigator & B\_02 & 8\\
\hline
Stratum\_5 & 8 & Patient Navigator & B\_02 & 8\\
\hline
Stratum\_5 & 9 & Patient Navigator & B\_02 & 8\\
\hline
Stratum\_5 & 10 & Patient Navigator & B\_02 & 8\\
\hline
Stratum\_5 & 11 & Patient Navigator & B\_03 & 4\\
\hline
Stratum\_5 & 12 & Patient Navigator & B\_03 & 4\\
\hline
Stratum\_5 & 13 & Control & B\_03 & 4\\
\hline
Stratum\_5 & 14 & Control & B\_03 & 4\\
\hline
Stratum\_5 & 15 & Patient Navigator & B\_04 & 8\\
\hline
Stratum\_5 & 16 & Control & B\_04 & 8\\
\hline
Stratum\_5 & 17 & Patient Navigator & B\_04 & 8\\
\hline
Stratum\_5 & 18 & Control & B\_04 & 8\\
\hline
Stratum\_5 & 19 & Patient Navigator & B\_04 & 8\\
\hline
Stratum\_5 & 20 & Control & B\_04 & 8\\
\hline
Stratum\_5 & 21 & Patient Navigator & B\_04 & 8\\
\hline
Stratum\_5 & 22 & Control & B\_04 & 8\\
\hline
Stratum\_5 & 23 & Control & B\_05 & 6\\
\hline
Stratum\_5 & 24 & Patient Navigator & B\_05 & 6\\
\hline
Stratum\_5 & 25 & Patient Navigator & B\_05 & 6\\
\hline
Stratum\_5 & 26 & Patient Navigator & B\_05 & 6\\
\hline
Stratum\_5 & 27 & Control & B\_05 & 6\\
\hline
Stratum\_5 & 28 & Control & B\_05 & 6\\
\hline
Stratum\_5 & 29 & Control & B\_06 & 6\\
\hline
Stratum\_5 & 30 & Patient Navigator & B\_06 & 6\\
\hline
Stratum\_5 & 31 & Control & B\_06 & 6\\
\hline
Stratum\_5 & 32 & Patient Navigator & B\_06 & 6\\
\hline
Stratum\_5 & 33 & Control & B\_06 & 6\\
\hline
Stratum\_5 & 34 & Patient Navigator & B\_06 & 6\\
\hline
Stratum\_5 & 35 & Control & B\_07 & 2\\
\hline
Stratum\_5 & 36 & Patient Navigator & B\_07 & 2\\
\hline
Stratum\_5 & 37 & Control & B\_08 & 4\\
\hline
Stratum\_5 & 38 & Patient Navigator & B\_08 & 4\\
\hline
Stratum\_5 & 39 & Control & B\_08 & 4\\
\hline
Stratum\_5 & 40 & Patient Navigator & B\_08 & 4\\
\hline
Stratum\_5 & 41 & Patient Navigator & B\_09 & 6\\
\hline
Stratum\_5 & 42 & Patient Navigator & B\_09 & 6\\
\hline
Stratum\_5 & 43 & Patient Navigator & B\_09 & 6\\
\hline
Stratum\_5 & 44 & Control & B\_09 & 6\\
\hline
Stratum\_5 & 45 & Control & B\_09 & 6\\
\hline
Stratum\_5 & 46 & Control & B\_09 & 6\\
\hline
Stratum\_5 & 47 & Patient Navigator & B\_10 & 6\\
\hline
Stratum\_5 & 48 & Control & B\_10 & 6\\
\hline
Stratum\_5 & 49 & Control & B\_10 & 6\\
\hline
Stratum\_5 & 50 & Control & B\_10 & 6\\
\hline
Stratum\_5 & 51 & Patient Navigator & B\_10 & 6\\
\hline
Stratum\_5 & 52 & Patient Navigator & B\_10 & 6\\
\hline
Stratum\_5 & 53 & Patient Navigator & B\_11 & 2\\
\hline
Stratum\_5 & 54 & Control & B\_11 & 2\\
\hline
Stratum\_5 & 55 & Control & B\_12 & 6\\
\hline
Stratum\_5 & 56 & Control & B\_12 & 6\\
\hline
Stratum\_5 & 57 & Patient Navigator & B\_12 & 6\\
\hline
Stratum\_5 & 58 & Patient Navigator & B\_12 & 6\\
\hline
Stratum\_5 & 59 & Patient Navigator & B\_12 & 6\\
\hline
Stratum\_5 & 60 & Control & B\_12 & 6\\
\hline
Stratum\_5 & 61 & Control & B\_13 & 2\\
\hline
Stratum\_5 & 62 & Patient Navigator & B\_13 & 2\\
\hline
Stratum\_5 & 63 & Patient Navigator & B\_14 & 2\\
\hline
Stratum\_5 & 64 & Control & B\_14 & 2\\
\hline
Stratum\_5 & 65 & Patient Navigator & B\_15 & 6\\
\hline
Stratum\_5 & 66 & Patient Navigator & B\_15 & 6\\
\hline
Stratum\_5 & 67 & Patient Navigator & B\_15 & 6\\
\hline
Stratum\_5 & 68 & Control & B\_15 & 6\\
\hline
Stratum\_5 & 69 & Control & B\_15 & 6\\
\hline
Stratum\_5 & 70 & Control & B\_15 & 6\\
\hline
Stratum\_5 & 71 & Patient Navigator & B\_16 & 4\\
\hline
Stratum\_5 & 72 & Patient Navigator & B\_16 & 4\\
\hline
Stratum\_5 & 73 & Control & B\_16 & 4\\
\hline
Stratum\_5 & 74 & Control & B\_16 & 4\\
\hline
Stratum\_5 & 75 & Patient Navigator & B\_17 & 6\\
\hline
Stratum\_5 & 76 & Control & B\_17 & 6\\
\hline
Stratum\_5 & 77 & Patient Navigator & B\_17 & 6\\
\hline
Stratum\_5 & 78 & Control & B\_17 & 6\\
\hline
Stratum\_5 & 79 & Patient Navigator & B\_17 & 6\\
\hline
Stratum\_5 & 80 & Control & B\_17 & 6\\
\hline
Stratum\_5 & 81 & Control & B\_18 & 8\\
\hline
Stratum\_5 & 82 & Patient Navigator & B\_18 & 8\\
\hline
Stratum\_5 & 83 & Control & B\_18 & 8\\
\hline
Stratum\_5 & 84 & Patient Navigator & B\_18 & 8\\
\hline
Stratum\_5 & 85 & Patient Navigator & B\_18 & 8\\
\hline
Stratum\_5 & 86 & Control & B\_18 & 8\\
\hline
Stratum\_5 & 87 & Patient Navigator & B\_18 & 8\\
\hline
Stratum\_5 & 88 & Control & B\_18 & 8\\
\hline
Stratum\_5 & 89 & Patient Navigator & B\_19 & 8\\
\hline
Stratum\_5 & 90 & Control & B\_19 & 8\\
\hline
Stratum\_5 & 91 & Patient Navigator & B\_19 & 8\\
\hline
Stratum\_5 & 92 & Patient Navigator & B\_19 & 8\\
\hline
Stratum\_5 & 93 & Control & B\_19 & 8\\
\hline
Stratum\_5 & 94 & Patient Navigator & B\_19 & 8\\
\hline
Stratum\_5 & 95 & Control & B\_19 & 8\\
\hline
Stratum\_5 & 96 & Control & B\_19 & 8\\
\hline
Stratum\_5 & 97 & Control & B\_20 & 2\\
\hline
Stratum\_5 & 98 & Patient Navigator & B\_20 & 2\\
\hline
Stratum\_5 & 99 & Patient Navigator & B\_21 & 8\\
\hline
Stratum\_5 & 100 & Patient Navigator & B\_21 & 8\\
\hline
\end{tabular}
\end{table}

<!--chapter:end:io42-randomization_demo_CAPTURE.Rmd-->

---
title: "Building Plots in ggplot2"
author: "Peter Higgins"
date: "5/27/2019"
output: html_document
---



# Building Plots
 Building plots in **ggplot2** is based on  a conceptual model called the grammar of graphics. Each plot is built up as layers, and it's easy to build complex plots one layer at a time. it is often helpful to prepare the data in a tidy structure, which is usually a very tall data frame.

---

# Getting Started
   Let's start with the simple example that illustrates the concept. You can add layers with the plus sign at the end of each line of code.
    Start with your data frame, and type it into the ggplot command.
    

```r
mtcars %>% 
  ggplot() 
```

![](io45-begin_scatterplots_files/figure-latex/mtcars-1.pdf)<!-- --> 

# Layer One - the plot window
    All you get is a empty rectangle of gray.  this is the default. The ggplot function does not know what data variables you want to map to objects in the plot. Let's give it some more information.  Add a new layer beginning with a plus sign at the end of the previous line of code, and then on the line below, add a new line of code.


```r
mtcars %>% 
  ggplot() +
  aes(x=wt)
```

![](io45-begin_scatterplots_files/figure-latex/x axis-1.pdf)<!-- --> 

# X Axis
This line adds an aesthetic mapping, of the weight variable to the x axis.  Ggplot labels the X axis, and scales this axis appropriately for the range of the weight variable, which is the weight in pounds divided by 1000. But no y axis yet.

```r
mtcars %>% 
  ggplot() +
  aes(x=wt) +
  aes(y=mpg)
```

![](io45-begin_scatterplots_files/figure-latex/y axis-1.pdf)<!-- --> 

---

# Y Axis
Now we have two axes, each labeled and scaled to the appropriate range of the X and Y variables.  But we have no data displayed yet. We have not yet told ggplot how we want these data to be displayed with a particular geometry (aka geom).


```r
mtcars %>% 
  ggplot() +
  aes(x=wt) +
  aes(y=mpg) +
  geom_point()
```

![](io45-begin_scatterplots_files/figure-latex/scatter-1.pdf)<!-- --> 

# Data
   Now we have some data plotted, with a simple scatterplot.  It does give you some idea of the  inverse relationship between weight and miles per gallon.  We can add another geom layer to see this relationship.
   

```r
mtcars %>% 
  ggplot() +
  aes(x=wt) +
  aes(y=mpg) +
  geom_point() +
  geom_smooth(method = "lm")
```

```
## `geom_smooth()` using formula 'y ~ x'
```

![](io45-begin_scatterplots_files/figure-latex/linear-1.pdf)<!-- --> 

# Linear
The geom smooth with a linear regression model method gives us the best fit least squares line.  This is placed on top of previous scatter plot, as an additional layer.  scatter plot points that fall on this line are partially obscured by the line, because this linear regression layer is listed last and it is on top.

---

# Points on Top?
   Let's flip this around with the geom point last.  I will also add a new argument to geom_smooth, standard error equals FALSE
   

```r
mtcars %>% 
  ggplot() +
  aes(x=wt) +
  aes(y=mpg) +
  geom_smooth(method = "lm", se=FALSE) +
  geom_point() 
```

```
## `geom_smooth()` using formula 'y ~ x'
```

![](io45-begin_scatterplots_files/figure-latex/points on top-1.pdf)<!-- --> 

# Points on Top
It's a bit subtle, but the points are now on top of the linear regression line, because they are the last layer.  We have also removed the standard error interval around the smoothing line.

---

# More Geoms
   We can add as many geoms as we want, to build up more complex plots. For now, let's focus on the elements of the scatter plot. What else can we do with these data points?

---

# More Options
   We can control their color, shape, and size, their intensity of color(alpha), their fill (for hollow shapes), the stroke, and group. All of these can be mapped to other variables in your dataset, to provide more information to the viewer of your plot.


```r
mtcars %>% 
  ggplot() +
  aes(x=wt) +
  aes(y=mpg) +
  geom_point(color="forestgreen", shape = 4, size=3) 
```

![](io45-begin_scatterplots_files/figure-latex/set color-1.pdf)<!-- --> 

# Color, size, and shape
  We can set the color, size, and shape manually, which can make the plot look nice, but does not convey any new information. To convey more information, we need to map data to these aesthetic parameter with aes.
  
---

# Numeric vs. Text
   Note that numeric values can be set simply with equals, while text values like the color need to be set within quotes.
   Sizes are easy, and you can experiment to find the size you want. How do you know what colors and shapes are available?
  
---

# Colors
    There are a number of cheat sheets for our colors available on the web.  All of these colors have names which are lowercase with no spaces or underscores. You can see a list of names by entering the function 'colors()' in the console
     Examples of color  cheat sheets can be found at 

http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf 

and at 

https://www.nceas.ucsb.edu/~frazier/RSpatialGuides

---

# Shapes

      A diagram of the 25 available shapes for scatterplots can be found at:


http://www.sthda.com/english/wiki/r-plot-pch-symbols-the-different-point-shapes-available-in-r 


Note that most of these can only have a color attribute, with no fill. Shapes 21-25 can specify a distinct color (outline) and fill (inner color).

  
---

# Mapping

By mapping the colors, shapes, or size to a variable and your data set, you can communicate more information.  See the example below.


```r
mtcars %>% 
  ggplot() +
  aes(x=wt) +
  aes(y=mpg) +
  geom_point(aes(color=factor(cyl), shape = factor(am), size=disp)) 
```

![](io45-begin_scatterplots_files/figure-latex/map color, shape, size-1.pdf)<!-- --> 

# More Information
You can see that we are now recording more information in the scatter plot.  This requires more explanatory legends, shown by default on the right

---

# Mapping Variables
   Note that in order to map variables to data aesthetics,  these have to be placed within an aes function.  For continuous aesthetics like size, you can use a continuous variable.  For discrete aesthetics like color or shape, these need to be factors with clear levels.
   
---

# More Control of Color
   You may not be a fan of the default colors in ggplot2. You may want to use specific colors to convey meaning (red= warning, green=healthy). There are a lot of ways to convey meaning with color. Color can have a single shade with levels of intensity to reflect dose or amount. You can use built in scales like viridis_d (for discrete levels).

---
   

```r
mtcars %>% 
  ggplot() +
  aes(x=wt) +
  aes(y=mpg) +
  geom_point(aes(color=factor(cyl), 
            shape = factor(am), size=disp)) +
  scale_colour_viridis_d()
```

![](io45-begin_scatterplots_files/figure-latex/viridis color-1.pdf)<!-- --> 

---

# Viridis 
   The viridis colors are designed to have easily distinguished levels, print well in color or black and white, and be perceived as different by people who are color blind. This is the default palette. Thre are also magma, plasa, inferno, and cividis versions, i.e.  (scale_colour_viridis(option="magma", discrete=TRUE)). Edit the code above to try a few of these out.
   
---

# Color Brewer / Color Distiller 
   You can make custom color palettes automatically with color brewer (for discrete scales) and color distiller (continuous). Details at https://ggplot2.tidyverse.org/reference/scale_brewer.html 
Just add scale_colour_brewer(palette="Blues").

---
# Color Brewer
There are lots of standard palettes to choose from, seen here https://www.r-graph-gallery.com/38-rcolorbrewers-palettes/ 
  Some guidance on how to use these can be found here https://www.datanovia.com/en/blog/the-a-z-of-rcolorbrewer-palette/ 
  

```r
mtcars %>% 
  ggplot() +
  aes(x=wt) +
  aes(y=mpg) +
  geom_point(aes(color=factor(cyl), 
            shape = factor(am), size=disp)) +
  scale_colour_brewer(palette="Blues")
```

![](io45-begin_scatterplots_files/figure-latex/blue color-1.pdf)<!-- --> 

---

# Manual Colors
What if you want to control each color? Then you can use scale_color_manual and set the values. Note that you can list more colors than the plot will use (that is fine), but if the plot needs 3 colors and you only list 2, it will throw an error.


```r
mtcars %>% 
  ggplot() +
  aes(x=wt) +
  aes(y=mpg) +
  geom_point(aes(color=factor(cyl), 
            shape = factor(am), size=disp)) +
  scale_colour_manual(values = c("darkorchid", "chartreuse", "skyblue", "goldenrod"))
```

![](io45-begin_scatterplots_files/figure-latex/manual color-1.pdf)<!-- --> 

---

# More Manual Colors
You can even store your favorite color palette as an object, and use it throughout your graphs or in a custom ggplot theme. 


```r
my_palette <- c( "royalblue2", "salmon", "springgreen2", "darkorchid", "chartreuse", "skyblue", "goldenrod", "darkslateblue", "deeppink", "lawngreen", "sienna3")
mtcars %>% 
  ggplot() +
  aes(x=wt) +
  aes(y=mpg) +
  geom_point(aes(color=factor(cyl), 
            shape = factor(am), size=disp)) +
  scale_colour_manual(values = my_palette)
```

![](io45-begin_scatterplots_files/figure-latex/palette color-1.pdf)<!-- --> 


# Manual Control of Shapes
You can control your shapes with the same approach, using scale_shape_manual, and a vector of values. 
The full list of shapes can be found at http://www.sthda.com/english/wiki/ggplot2-point-shapes 
Experiment with a few different shapes. See how some shapes (filled squares) capture the eye, and others (empty circle) fade into the background. You can use this effect to draw the viewer's eye to the information that you want to emphasize.


```r
mtcars %>% 
  ggplot() +
  aes(x=wt) +
  aes(y=mpg) +
  geom_point(aes(color=factor(cyl), 
            shape = factor(am), size=disp)) +
  scale_shape_manual(values = c(1, 15))
```

![](io45-begin_scatterplots_files/figure-latex/shape control-1.pdf)<!-- --> 

# Manual Control of Size
Sometimes the default range of sizes is too small or too big. You can take control with scale_size for continuous variables (scale_size(range = c(3,6)), or scale_size_manual(values= c(3,4,5,6)) for factor variables. Some details here https://ggplot2.tidyverse.org/reference/scale_size.html and at
https://ggplot2.tidyverse.org/reference/scale_manual.html 

---


```r
mtcars %>% 
  ggplot() +
  aes(x=wt) +
  aes(y=mpg) +
  geom_point(aes(color=factor(cyl), 
            shape = factor(am), size=disp)) +
  scale_size(range = c(3,6))
```

![](io45-begin_scatterplots_files/figure-latex/size control-1.pdf)<!-- --> 

# Controlling alpha when you have many points
Sometimes you have lots of data (in the diamonds dataset), and points are on top of each other. It is helpful to be able to discern when you have one point at a particular x,y location vs. 20 data points. This is where alpha (control of transparency) is a helpful aesthetic.



```r
diamonds %>% 
  ggplot() +
  aes(x=carat) +
  aes(y=price) +
  geom_point(aes(fill=clarity), shape = 21,
             alpha = 1) 
```

![](io45-begin_scatterplots_files/figure-latex/alpha control-1.pdf)<!-- --> 


# Adjusting Alpha
You can see that better clarity (IF) is more valued than low clarity (I1), but it is hard to see what is going on as there are 53,940 diamonds in this dataset. Experiment with alpha =0.1 and 0.01, 0.005 to see more patterns in the data. You can also replace clarity with color as the fill to get another look at what is valued in diamonds. 

---
# Adjusting Alpha
Notice that the fill is an argument of the aes() function, but that alpha and shape are not. This is because they are called as arguments to geom_point(), but are constants, and are not mapped to data. To map to data, you need aes().


# Inheritance in ggplot
Components of the ggplot call are inherited from ggplot() to the geoms. Inherited means that you can set an aesthetic in the ggplot() function, and it will be used downstream in each geom. You can override the inherited arguments by setting a different argument in the geom. See below.


```r
diamonds %>% 
  ggplot(aes(x=carat, y = price, fill=clarity),
         shape = 21) +
  geom_point(alpha = 0.2) +
  geom_smooth(se=TRUE) 
```

```
## `geom_smooth()` using method = 'gam' and formula 'y ~ s(x, bs = "cs")'
```

![](io45-begin_scatterplots_files/figure-latex/alpha inheritance-1.pdf)<!-- --> 


# Many Smoother Lines
The code above gives us a distinct smoother line for each level of clarity, because geom_smooth inherits the fill grouping from ggplot. What if we want an overall smoothed line for all levels of clarity? We have to remove fill from ggplot, and move it to aes(fill=clarity) within the geom_point. While you are at it, make se=FALSE in geom_smooth.
You could also turn off the inheritance from ggplot by inserting aes(fill = NA) into geom_smooth.

---

# Improving this plot
We can control the color of the smoother line, by adding color = "magenta" to geom_smooth without an aes() call. Note the quotes around the color name, as it is text, not an object. We can also hide the now not very useful legend by adding *theme(legend.position = "none")*. Again, quotes because we want the text "none", rather than having R search for an object named none in our environment pane.

---

# A common color mistake
Evaluate the code below.
Why did this not work as expected?


```r
ggplot(data = diamonds) +
  geom_point(aes(x=carat, y=price, color ="blue")) +
  labs(title = "diamonds_red")
```

![](io45-begin_scatterplots_files/figure-latex/diamonds_red-1.pdf)<!-- --> 
# Colors Gone Wrong
This went wrong because you should map data variables to aesthetics within the aes() function, and constants like color = "blue" should be in ggplot() or a geom() but outside of aes().
By putting values in the aes() you are generating a new factor variable and a legend.
Consider this example:



```r
ggplot(data = mtcars) +
  geom_point(aes(x=mpg, y=wt, color ="blah")) +
  geom_point(aes(x=mpg, y=drat, color ="asdfasdf")) +
  scale_color_manual(values = c("blah"= "blue", "asdfasdf" = "red"))
```

![](io45-begin_scatterplots_files/figure-latex/unnamed-chunk-1-1.pdf)<!-- --> 
Based on this information, go back and fix the diamonds_red plot above, so that the points are truly blue.

---

# Labeling Data Points
One additional aes you can add is labeling your graphics with actual data values.
This is done with geom_text(aes(label = variable, vjust = -0.5)).
You will often want to add a vjust or hjust to have the label offset from the actual point.


```r
mtcars2 <- mtcars %>% rownames_to_column("car")
ggplot(data = mtcars2) +
  geom_point(aes(x=mpg, y=wt)) +
  geom_text(aes(x=mpg, y=wt,
                label = car, vjust = -0.5))
```

![](io45-begin_scatterplots_files/figure-latex/data labels-1.pdf)<!-- --> 




# Labels for Your Plot

Now let's turn to labeling your plot. There are 7+ key labels that we can access with the labs() function. These include the title, subtitle, x, y, caption, tag, and legend titles. These can all be added with *labs(label = "new label")*. You can remove a label by setting it to NULL, i.e. 'labs(title = NULL)'. Change the tag below to "A", and add better x, y, and color labels.


```r
mtcars %>% 
  ggplot(aes(x=wt, y = mpg, color=factor(cyl), 
             size=disp, shape = factor(am))) +
  geom_point() + 
  labs(tag = "Figure 1A") +
  theme(legend.position = "bottom")
```

![](io45-begin_scatterplots_files/figure-latex/labeling-1.pdf)<!-- --> 

Note that a lot of the text labels overlap. This is a good use case for the ggrepel package, with its functions geom_text_repel() and geom_label_repel(), which will automatically move these around to avoid overlaps. Details here https://cran.r-project.org/web/packages/ggrepel/vignettes/ggrepel.html 

# More Labels

You have shortened the tag, and improved your x and y axis labels. Now add a title, subtitle, caption, and improve the shape and size legend titles.


```r
mtcars %>% 
  ggplot(aes(x=wt, y = mpg, color=factor(cyl), 
             size=disp, shape = factor(am))) +
  geom_point() + 
  labs(tag = "A", x = "Car Weight", y = "Miles Per Gallon", color = "Cylinders") +
  theme(legend.position = "bottom")
```

![](io45-begin_scatterplots_files/figure-latex/labeling2-1.pdf)<!-- --> 


# Long Labels

Sometimes you have labels that are a bit too long for their space, and they need a line break. Just insert "\n" for a new line inside the quotes. For example, "This is a Long Title \n It is Really too Long". Put a line break in the title and y axis title below. Note that you only want a space on **one** side of the "\n".


```r
mtcars %>% 
  ggplot(aes(x=wt, y = mpg, color=factor(cyl), 
             size=disp, shape = factor(am))) +
  geom_point() + 
  labs(tag = "A", x = "Car Weight", 
       y = "Miles Per Gallon for the car we are talking about here", color = "Cylinders",
       title = "A Really Long Title that Should Have Been Shortened a Few Versions Ago",
       size = "Displacement",
       shape = "Automatic Transmission") 
```

![](io45-begin_scatterplots_files/figure-latex/labeling3-1.pdf)<!-- --> 

# Labels Other Ways
labs() is the most convenient way to label your plot and keep all of your labels organized. There are some older ways to do this as well. You may see these in other people's code. ggtitle("My title") also works for titles. xlab("xaxis") and ylab("my_y_axis") also work for specific axis labels.

<!--chapter:end:io45-begin_scatterplots.Rmd-->

---
title: "Categorical vs Continuous Boxplots and More"
author: "Peter Higgins"
date: "6/14/2019"
output: html_document
---



## Boxplots
Boxplots are common ways to compare a continous variable across several categories, and are often used to illustrate the continous outcome of an experiment across several groups.
<br>
The basic geom is geom_boxplot, with the aes containing a categorical variable (usually x),
and a continuous variable, usually y. As usual, geom_boxplot inherits aes from the ggplot function.
<br>
Arguments to geom_boxplot include
- outlier.color, outlier.fill
- outlier.shape, outlier.stroke, outlier.alpha
- outlier.size
- color
- fill
- position = 'dodge2'

<br>
We will use the data from 4 clinical trials published from 1987-1989 by Lanza on the use of misoprostol to reduce the severity of NSAID-induced gastric ulcers on a 1-5 scale.
Start by taking a look at the data.
<br>
Details are here: https://vincentarelbundock.github.io/Rdatasets/doc/HSAUR/Lanza.html 


```r
data(Lanza)
glimpse(Lanza)
```

```
## Rows: 198
## Columns: 3
## $ study          <fct> I, I, I, I, I, I, I, I, I, I, I,...
## $ treatment      <fct> Misoprostol, Misoprostol, Misopr...
## $ classification <ord> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,...
```

## First Boxplot
 Your basic boxplot aes needs a categorical x variable, and a continuous y variable. 
  Add a geom_boxplot() to the code below to get the basic boxplot by treatment group.
  Then use the color and fill arguments to map treatment to these graphic aesthetics. Use the show.legend=FALSE argument to geom_boxplot to control the legend. 

![](io46-begin_boxplots_files/figure-latex/boxplot1-1.pdf)<!-- --> 

## Second Boxplot, with grouping by trial
You can map another variable to your aesthetic statement with the fill aes. In this case, we will use x= study and fill= treatment, to separate the treatments the data in each study. Edit the code below to add the aes(fill=) mapping to produce comparisons for all 4 studies by treatment group. 

![](io46-begin_boxplots_files/figure-latex/boxplot2-1.pdf)<!-- --> 

## Third Boxplot, with grouping by trial using facets
Another way to do subgrouping of your data is to facet it into small multiples. This produces multiple small graphs. You can facet by a single variable with facet_wrap(~newvar) In this case, we will use x = treatment, y = ulcers, and add facet_wrap(~ study), to separate the data in each study. Edit the code below to produce comparisons for all 4 studies by treatment group.  Experiment with which variable is x and which is the variable used for faceting.

![](io46-begin_boxplots_files/figure-latex/boxplot3-1.pdf)<!-- --> 

<br>
<br>
<br>
<br>
## CHALLENGE 1: make your own boxplot with a new dataset
Without looking at or copy/pasting from the previous code,
use the data from the polyps dataset to make a boxplot comparing the number of polyps in FAP patients taking placebo vs. taking NSAIDs.
<br>
Run the code below, then edit it to produce the desired boxplot.
Remember to:

1. map the aesthetics to both a categorical (treat) and a continuous (number of polyps) variable
2. add the right geom
3. Add title, labels with labs()
4. use constant color and fill, or map these to variables also.
5. Style the theme, colors, base_size as desired.



```r
data("polyps", package = "HSAUR")
glimpse(polyps)
```

```
## Rows: 20
## Columns: 3
## $ number <dbl> 63, 2, 28, 17, 61, 1, 7, 15, 44, 25, 3, ...
## $ treat  <fct> placebo, drug, placebo, drug, placebo, d...
## $ age    <dbl> 20, 16, 18, 22, 13, 23, 34, 50, 19, 17, ...
```

```r
ggplot(data=polyps)
```

![](io46-begin_boxplots_files/figure-latex/unnamed-chunk-1-1.pdf)<!-- --> 




<br>
<br>
<br>
<br>

## Fourth Boxplot, with grouping by trial and treatment using facets
You can facet by two variables by adding facet_grid(catvar1 ~ catvar2). Try faceting by categorical variables treatment and study. Try again in reverse order. 

![](io46-begin_boxplots_files/figure-latex/boxplot4-1.pdf)<!-- --> 

## Fifth Boxplot, using arguments for varwidth, color, fill, and notch



```
## notch went outside hinges. Try setting notch=FALSE.
```

![](io46-begin_boxplots_files/figure-latex/boxplot5-1.pdf)<!-- --> 

## Sixth Boxplot, with overlay of datapoints with geom_jitter and remove outliers (no need to repeat these). This provides a clearer view of the data.
What would happen if you put geom_boxplot last?
What would happen if outlier.shape = NA was removed?

![](io46-begin_boxplots_files/figure-latex/boxplot6-1.pdf)<!-- --> 

## Seventh plot, with violin
You can see how a boxplot obscures the distribution. Try this again with a violinplot. change the boxplot geom to violin in the code below.

![](io46-begin_boxplots_files/figure-latex/boxplot7-1.pdf)<!-- --> 

<br>
<br>
<br>
<br>
## CHALLENGE 2: make your own violinplot overlaid with jittered datapoints with a new dataset
Without looking at or copy/pasting from the previous code,
use the data from the polyps dataset to make a violin plot comparing the number of polyps in FAP patients taking placebo vs. taking NSAIDs.
<br>
Run the code below, then edit it to produce the desired boxplot.
Remember to:

1. map the aesthetics to both a categorical (treat) and a continuous (number of polyps) variable
2. add the violin geom
3. Overlay with the jitter geom, control the width
4. Add title, labels with labs()
5. use constant color and fill, or map these to variables also.
6. Use alpha to adjust the intensity of the violin fill and of the jittered points.
7. Style the theme, colors, base_size as desired.


```r
data("polyps", package = "HSAUR")
glimpse(polyps)
```

```
## Rows: 20
## Columns: 3
## $ number <dbl> 63, 2, 28, 17, 61, 1, 7, 15, 44, 25, 3, ...
## $ treat  <fct> placebo, drug, placebo, drug, placebo, d...
## $ age    <dbl> 20, 16, 18, 22, 13, 23, 34, 50, 19, 17, ...
```

```r
ggplot(data=polyps)
```

![](io46-begin_boxplots_files/figure-latex/unnamed-chunk-2-1.pdf)<!-- --> 

<br>
<br>
<br>
<br>
## Eighth Plot, with ridgeplots
 Ridgeplots are a variant of violin plots that look like ridges, or mountain ranges. These are nice for comparing distribution densities.
 You need to map your continuous variable in the x aesthetic, then pick categorical variables for your y and /or your fill aesthetics.
 Map ulcers to x, study to y, and treatment to fill.  Experiment with swapping y and fill mappings.
 


```
## Picking joint bandwidth of 0.407
```

![](io46-begin_boxplots_files/figure-latex/plot8-1.pdf)<!-- --> 

## Ninth plot, with ridges in series
Ridgeplots are often use to illustrate changes in distributions over time (consecutive months, or years).
Add facet_wrap(~treatment) and see the distribution change by treatment from study to study.
Add ncol=1 to the facet_wrap for a different view


```
## Picking joint bandwidth of 0.621
```

![](io46-begin_boxplots_files/figure-latex/plot9-1.pdf)<!-- --> 

## Tenth plot, with raincloud plots
You can add the points (the 'rain') to the clouds by adding the argument jittered_points = TRUE to geom_density_ridges.
You can also have the rain 'fall' by adding the arguments jittered_points = TRUE, position='raincloud', alpha =0.5, scale =0.9 <br>
to geom_density_ridges.


```
## Picking joint bandwidth of 0.407
```

![](io46-begin_boxplots_files/figure-latex/plot10-1.pdf)<!-- --> 
<br>
<br>
<br>
<br>
## CHALLENGE 3: make your own raincloud plot with a new dataset
Without looking at or copy/pasting from the previous code,
use the data from the polyps dataset to make a raincloud plot comparing the age in FAP patients taking placebo vs. taking NSAIDs.
<br>
Run the code below, then edit it to produce the desired boxplot.
Remember to:

1. map the aesthetics to both a categorical (treat) and a continuous (age) variable
2. add the raincloud geom
3. Use jittered_points = TRUE, position='raincloud'
4. adjust the alpha and scale options
5. use constant color and fill, or map these to variables also.
6. Use alpha to adjust the intensity of the jittered points.
7. Style the theme, colors, base_size as desired.
8. add appropriate labels


```r
data("polyps", package = "HSAUR")
glimpse(polyps)
```

```
## Rows: 20
## Columns: 3
## $ number <dbl> 63, 2, 28, 17, 61, 1, 7, 15, 44, 25, 3, ...
## $ treat  <fct> placebo, drug, placebo, drug, placebo, d...
## $ age    <dbl> 20, 16, 18, 22, 13, 23, 34, 50, 19, 17, ...
```

```r
ggplot(data=polyps)
```

![](io46-begin_boxplots_files/figure-latex/unnamed-chunk-3-1.pdf)<!-- --> 

<br>
<br>
<br>
<br>

## Eleventh plot, with mean labels
You can label the mean in a boxplot with a stat_summary, using function fun.y = mean, and specifying the geom as text. It helps to round the y to 1 decimal place.
<br>
more details here https://stackoverflow.com/questions/19876505/boxplot-show-the-value-of-mean 


```
## Warning: `fun.y` is deprecated. Use `fun` instead.
```

![](io46-begin_boxplots_files/figure-latex/plot11-1.pdf)<!-- --> 

## Twelfth plot, with ggsignif
You can make comparisons and list p values between groups with the ggsignif package/
<br>
more details here: 
https://cran.r-project.org/web/packages/ggsignif/vignettes/intro.html


![](io46-begin_boxplots_files/figure-latex/plot12-1.pdf)<!-- --> 

<br>
<br>
<br>
<br>
## CHALLENGE 4: make your own boxplot with significance comparison and p value for a new dataset
Without looking at or copy/pasting from the previous code,
use the data from the polyps dataset to make a boxplot/violinplot comparing the number of polyps in FAP patients taking placebo vs. taking NSAIDs.
<br>
Run the code below, then edit it to produce the desired plot.
Remember to:

1. map the aesthetics to both a categorical (treat) and a continuous (polyps) variable
2. add the violin geom first, then boxplot
3. adjust the alpha and width options for violin
4. add ggsignif, list the correct groups for comparison, set the y position correctly 
5. use constant color and fill, or map these to variables also.
6. Style the theme, colors, base_size as desired.
7. adjust ylim if needed
8. add appropriate labels


```r
data("polyps", package = "HSAUR")
glimpse(polyps)
```

```
## Rows: 20
## Columns: 3
## $ number <dbl> 63, 2, 28, 17, 61, 1, 7, 15, 44, 25, 3, ...
## $ treat  <fct> placebo, drug, placebo, drug, placebo, d...
## $ age    <dbl> 20, 16, 18, 22, 13, 23, 34, 50, 19, 17, ...
```

```r
ggplot(data=polyps)
```

![](io46-begin_boxplots_files/figure-latex/unnamed-chunk-4-1.pdf)<!-- --> 

<!--chapter:end:io46-begin_boxplots.Rmd-->

---
title: "Basics of Barplots"
author: "Peter Higgins"
date: "6/14/2019"
output: html_document
---



## Barplots

The basic geom is geom_bar, but you can change what it does pretty dramatically by changing its stat and position arguments. The default stat is stat='count', and the default position = 'stack'.
Let's start with the basic defaults with the mpg dataset.



```r
glimpse(mpg)
```

```
## Rows: 234
## Columns: 11
## $ manufacturer <chr> "audi", "audi", "audi", "audi", "a...
## $ model        <chr> "a4", "a4", "a4", "a4", "a4", "a4"...
## $ displ        <dbl> 1.8, 1.8, 2.0, 2.0, 2.8, 2.8, 3.1,...
## $ year         <int> 1999, 1999, 2008, 2008, 1999, 1999...
## $ cyl          <int> 4, 4, 4, 4, 6, 6, 6, 4, 4, 4, 4, 6...
## $ trans        <chr> "auto(l5)", "manual(m5)", "manual(...
## $ drv          <chr> "f", "f", "f", "f", "f", "f", "f",...
## $ cty          <int> 18, 21, 20, 21, 16, 18, 18, 18, 16...
## $ hwy          <int> 29, 29, 31, 30, 26, 26, 27, 26, 25...
## $ fl           <chr> "p", "p", "p", "p", "p", "p", "p",...
## $ class        <chr> "compact", "compact", "compact", "...
```

## First Barplot
 Your basic barplot aes only needs an x variable, to divide by a categorical variable. The implied y variable is the count of cases in each category. This is because the default stat for geom_bar is stat='count').
 Now run the code below to get the basic barplot by class of vehicle.
 Delete the stat argument to make sure you get the same graph, proving that stat='count' is the default stat argument.

![](io47-begin_bars_files/figure-latex/barplot1-1.pdf)<!-- --> 

## Second Barplot, with stat = 'count' and position = 'stack'
You can add a 2nd variable to your aes statement with fill. In this case, we will use fill= factor(cyl), to separate the cases by categories of cylinders in each car's engine. This will work because the default position for geom_bar is position = 'stack').
This version gives you the counts by class and cylinder.

![](io47-begin_bars_files/figure-latex/barplot2-1.pdf)<!-- --> 

## Third Barplot, with stat = 'count' and position = 'fill'
You can view this same plot by proportions instead of counts, if you change the position to 'fill'. Change the position argument below from 'stack' to 'fill'. The y axis will now be a proportion scale, rather than count.

![](io47-begin_bars_files/figure-latex/barplot3-1.pdf)<!-- --> 

## Fourth Barplot, with stat = 'count' and position = 'dodge'
The versions above are great for counts and proportions, but are a little hard to compare between cylinder groups. To line these up side by side, use position = 'dodge'. Edit the code below to dodge your geom_bar cylinders.

![](io47-begin_bars_files/figure-latex/barplot4-1.pdf)<!-- --> 

## Fifth Barplot, with a y variable and stat = 'identity'
Sometimes you don't want to plot counts or proportions, but a different variable in your dataset. Maybe the average hwy mpg by class. In this case, you need to supply a y variable in the aes, and to change the stat to stat='identity'

![](io47-begin_bars_files/figure-latex/barplot5-1.pdf)<!-- --> 

## Sixth Barplot, with a y variable and stat = 'identity' and reordering by the y variable values
It is helpful for comparisons to have your categorical variable sorted by the value of your y variable. This can be done manually by setting factor levels before you ggplot, or you can do it on the fly within the aes by using fct_reorder from the forcats package.

![](io47-begin_bars_files/figure-latex/barplot6-1.pdf)<!-- --> 
## The problem with barplots and y variables
Barplots are intended for use with counts, but can be used with distinct y variables. Unfortunately, they are not the best visual representation of comparable quantities. Rectangular areas are problematic for visual interpretation. Viewers are more accurate with a linear distance that is not confounded by area. 
<br>
For this reason, Cleveland dot plots and lollipop plots were developed.

## Cleveland dot plot
This is named after Cleveland, a researcher on visual perception of graphs and data.
This clearly represents the point estimates of the average highway mpg. It does avoid the problem with rectangular areas. However, it is somwhat hard to connect to the labels on the x axis (which lollipop plots try to address), and does not show the confidence in this estimate.

![](io47-begin_bars_files/figure-latex/cleveplot-1.pdf)<!-- --> 
## Lollipop plot
This is named after the shape, like a lollipop.
This clearly represents the point estimates of the average highway mpg, and makes it easier to connect the estimates to the labels on the x axis, but does not show the confidence in this estimate.


```
## Warning: Ignoring unknown parameters: stem.colour
```

![](io47-begin_bars_files/figure-latex/lolliplot-1.pdf)<!-- --> 

## Pointrange plot
This geom has a point estimate and a confidence interval
This clearly represents the point estimates of the average highway mpg, and the confidence in this estimate.


```
## Warning: Ignoring unknown aesthetics: nudge_x
```

![](io47-begin_bars_files/figure-latex/pointrange-1.pdf)<!-- --> 


## Seventh Barplot, with counts and reordering by the count values
That reordering is nice. Can you do it with the original counts barplots? Yes you can, but you have to use fct_infreq to wrap the x variable, class.  Run the code below, then change it to make x = fct_infreq(class).

![](io47-begin_bars_files/figure-latex/barplot7-1.pdf)<!-- --> 

## Eighth Barplot, with geom_col vs. geom_bar(stat='identity')
You may see code in which geom_col() is used instead of geom_bar. They are essentially the same geom, except for one very important default. The default for geom_col() is stat='identity', so that it works well with a y axis that is not counts. But you get the same graph by using geom_bar with stat='identity'
<br>
Test it for yourself.
Change the geom_col() code below to geom_bar with stat='identity'

![](io47-begin_bars_files/figure-latex/barplot8-1.pdf)<!-- --> 

## Ninth Barplot, with geom_bar(stat='identity') and coord_flip()
It can be easier to compare the length of bars when they are horizontal. This is easily done by adding coord_flip to the end of your code. Be sure to do it at the end. If not, it can get confusing which axis is x and which is y.
<br>
Test it for yourself.
Flip the plot below with coord_flip()

![](io47-begin_bars_files/figure-latex/barplot9-1.pdf)<!-- --> 

## Tenth Barplot, with value labels
You can add value labels by adding geom_text(label=var)
<br>
Test it for yourself.
add geom_text(label = mean_hwy, vjust=1.3) to the plot below.
You can improve the labels by wrapping mean_hwy in a round function, like round(mean_hwy,1)

![](io47-begin_bars_files/figure-latex/barplot10-1.pdf)<!-- --> 

## Eleventh Barplot, with value labels that are dodges
Adding value labels gets more complicated with position= 'dodge'.
<br>
add geom_text, but with
geom_text(aes(label=round(mean_hwy)), position=position_dodge(width=0.9), vjust=-0.2)

![](io47-begin_bars_files/figure-latex/barplot11-1.pdf)<!-- --> 



## Twelfth Barplot, with labels on the bars instead of the axis
You can label your groups with names directly on the bars.
<br>
first remove the x axis labels and x axis ticks,
using 
<br>
theme(axis.text.y = element_blank()) +
theme(axis.ticks.y = element_blank())
**before** the coord_flip()

Then add  geom_text(aes(x = class, y = 1, label = class), hjust=0)
  again, **before** the coord_flip() 
  <br>
  Note that hjust =0 is left-aligned, hjust =0.5 is centered, and hjust = 1.0 is right-aligned.

![](io47-begin_bars_files/figure-latex/barplot12-1.pdf)<!-- --> 


## Fourteenth Barplot, moving and removing the legend
You can move the legend to top, bottom, left or right with theme(legend.position = "top"), or the equivalent
<br>
You can remove the legend with theme(legend.position = "none")

![](io47-begin_bars_files/figure-latex/barplot14-1.pdf)<!-- --> 

<!--chapter:end:io47-begin_bars.Rmd-->

---
title: "fork_branch"
author: "Peter Higgins"
date: "1/12/2019"
output:
  html_document:
    df_print: paged
---



## Creating a fork/branch/pull-request workflow

There are several steps to collaborating on someone else's github project in R.
Note that a lot of this is adapted from excellent (but not Rstudio specific) instructions at 
https://blog.scottlowe.org/2015/01/27/using-fork-branch-git-workflow/ 

### Forking
The first step is to fork - or create a copy in a new location (your github account). Do this by:  

1. log into your github account
2. go to the github repo of the project you want to fork
  i) for example, "https://github.com/brentthorne/posterdown"
3. at the top right, click on the "Fork" button
4. This will create a copy of the repo, with the same name, in your github account.
  i) this will be named something like "https://github.com/higgi13425/posterdown" 

### Cloning
The second step is to clone, or copy, this repo to your local computer as a project. Do this by:  

1. Opening RStudio
2. Select New Project/Version Control/Git
3. Go back to your newly forked github repo, "https://github.com/higgi13425/posterdown"
4. Click on the Clone or download button on the right
5. click on the clipboard to copy the link
6. Go back to Rstudio
7. Paste the link into the Repository URL box
8. give the project folder a reasonable name, like posterdown
9. Confirm that you this will be in a reasonable directory, like "~/Documents/Rcode"
10. Click the "New Session" box at lower left
11. Click on Create Project  

Now you have a Forked Github repo, and you have cloned this to a linked Rstudio Project on your local computer. Great!

This will allow you to work on the project locally, and push updates/changes to your Github repo. But the project is not linked back to the original repo. If you want to contribute to the original project, through pull requests, you need to link this as an upstream repo.

## Linking to the upstream repo
Now you will create this link:  

1. Open the Terminal in Rstudio
  i) View/Move Focus to Terminal
2. at the cursor prompt ($), type **git remote add upstream** (but don't hit return yet)
3. This prepares to add a remote upstream link to your project, but now you need the link - to the original github repo.
4. Go back to your browser, and go back to the original github repo
  i) for example, "https://github.com/brentthorne/posterdown"
5. use the Clone or download button to copy the link
6. Go back to Rstudio, to the Terminal window
7. after **git remote add upstream**, leave one space, then paste in the link to the original repo
8. this wil now look like **git remote add upstream https://github.com/brentthorne/posterdown** (now press return)
9. Now your local project on your computer is linked to your github repo (https://github.com/higgi13425/posterdown), and also linked upstream to the original github repo (https://github.com/brentthorne/posterdown)
10. This will allow you to push changes to your repo, and also to suggest changes to the original project repo (a pull request)
11. The original project/repo owner can review your pull request, and decide which changes to incorporate into their repo.  

## Creating a branch

So far, you’ve forked a project repository, cloned it down to your local system, and added a Git remote to your clone that points to the original project repository on GitHub. Now you’re ready to start making changes to your local Git repository. You can’t just start making changes willy nilly, though; to effectively collaborate with others on the same repo, you should use a branch.
A branch is a distinct version that takes a different direction from the master (production) version. The branch allows you to experiment, and try out different ideas or pathways, without damaging the production version (master branch). Any coding errors you make in your branch will not harm users of the master branch. Once you are happy with the changes in your branch, you can send a pull request to the keeper of the original repo, and they can decide which changes to merge into the master branch.

When using the “fork and branch” workflow to collaborate with others, the purpose of a branch is to help facilitate multiple users making changes to a repository at the same time.

So, assuming that your eventual goal is to issue a pull request to have your changes merged back into the original project, you’ll need to use a branch. Often you’ll see this referred to as a feature branch, because you’ll typically be implementing a new feature in the project.

As a general rule of thumb, you should limit a branch to one logical change. The basic idea is that you should only make the necessary changes to implement one specific feature or enhancement.

To create a new branch and check it out (meaning tell Git you will be making changes to the branch)

1. Go to the Rstudio Terminal window
2. At the $ prompt, type in **git checkout -b <new branch name>**
  i) for example git checkout - b fix_typos_in_README
  
Now a new feature branch has been created.

## Working on your branch

You can do your usual local R coding, editing, etc.
Then 

1. stage your changes in the Git tab
2. commit these changes
3. push these changes to your Github remote repo in the Git tab.
  i) _Note that you can also push changes in the Terminal window with the command **git push origin new-feature**_
4. Keep doing this iteratively, until you are happy with your one logical unit feature change.


## Suggesting this feature change to the keeper of the original repo (aka Opening a Pull Request)

Once you push a new branch up to your repository, GitHub will prompt you to create a pull request.

The maintainers of the original project can use this pull request to pull your changes across to their repository and, if they approve of the changes, merge them into the main repository.

Be aware that, to help keep things manageable, some open source projects may have guidelines around how pull requests are submitted. You might need to use a certain name for your feature branch, or perhaps the project requests that you create an issue (another GitHub feature) before submitting the pull request (and then including the issue number in the pull request). Just check with the maintainers of the particular project(s) to which you’d like to contribute to see if any such details exist.


## Cleaning up After a Merged Pull Request

If the maintainers accept your changes and merge them into the main repository, then there is a little bit of post-merge clean-up for you to do. 
First, you should update your local clone 

1. Go to the RStudio Terminal, and at the $ prompt, type
**git pull upstream master**.
This pulls the changes from the original repository’s (indicated by upstream) master branch (indicated by master in that command) to your local cloned repository. One of the commits in the commit history will be the commit that merged your feature branch, so after you git pull your local repository’s master branch will have your feature branch’s changes committed. This means you can delete the feature branch (because the changes are already in the master branch):

2. Delete the feature branch by going to the RStudio Terminal, and at the $ prompt, type
**git branch -d <branch name> **

3. Then you can update the master branch in your forked repository:
Go to the RStudio Terminal, and at the $ prompt, type
**git push origin master**

4. Then push the deletion of the feature branch to your GitHub repository 
Go to the RStudio Terminal, and at the $ prompt, type 
**git push --delete origin <branch name>**

And that’s it! You’ve just successfully created a feature branch, made some changes, committed those changes to your repository, pushed them to GitHub, opened a pull request, had your changes merged by the maintainers, and then cleaned up. Pretty neat, eh?

## Keeping Your Fork in Sync
By the way, your forked repository doesn’t automatically stay in sync with the original repository; you need to take care of this yourself. After all, in a healthy open source project, multiple contributors are forking the repository, cloning it, creating feature branches, committing changes, and submitting pull requests.

To keep your fork in sync with the original repository, 
Go to the RStudio Terminal, and at the $ prompt, type
**git pull upstream master**

then
**git push origin master**

This pulls the changes from the original repository (the one pointed to by the upstream Git remote) and pushes them to your forked repository (the one pointed to by the origin remote). (Hopefully that makes a little bit of sense to you by now.)

<!--chapter:end:io55-ForkBranchCollaboration.Rmd-->

---
title: "Tips for Hashtag Debugging your Pipes and GGPlots"
author: "Peter Higgins"
date: "1/30/2020"
output: html_document
---



## Debugging
While layering functions with piping in the tidyverse
and the plus sign in `ggplots` is a great way to keep your code clear,
there will still be bugs in your code.
<br>
This can be pretty frustrating, especially when you spend a lot of time staring at the code and it finally turns out to be something trivial, like a missing parenthesis, a pipe in place of a + (or the reverse), a missing aes statement, or a mistyped function (fitler instead of filter).
<br>
So how can you systematically approach debugging a pipe or plot, and find and fix your problem efficiently without spending tons of time?

### The Quick Screen
Start by checking for common errors - check for **The Big 5**.
<br>

1. Click just to the right of each final parenthesis on each line. Does this result in highlighting the first parenthesis on that line of code? If not, you are probably missing a closing parenthesis.
2. When piping, check that you have a proper pipe `%>%` at the end of each line, except for the last line. 
3. When plotting, check that you have a plus sign `+` at the end of each line, except for the last line.
4. Error message about a missing function - ` Error in function(arguments) : could not find function "func"`. Either you are calling a function from a library you have not loaded, or you mis-typed the function. If the library was not loaded, go back to the top and load the library that this function comes from. If you mis-typed the function (for example, `/selcet`), fix the typographical error. The error message will tell you which function seems to be missing.
5. Error message about a missing object - `Error: object 'xxxobj' not found`. Make sure that you have typed the names of the dataframe and the variables correctly. Each of these is a data object. The error message will tell you which object seems to be missing.

Your Turn:
Search for The Big 5 in the pipe below
(Hint - there are 5 Bugs to Be Found)    
You should end up with 4 columns of 10 rows, sorted by efficiency, when all of the bugs have been fixed.


```r
mtcars %>% 
  filter(cyl >4) %>% 
  select(mpg, hp, displ) %>% 
  mutate(efficiency = hp/disp ) +  
  filtre(efficiency > 0.5) %>% 
  arrange(desc(efficiency) %<% 
  slice(1:10)
```

```
## Error: <text>:8:0: unexpected end of input
## 6:   arrange(desc(efficiency) %<% 
## 7:   slice(1:10)
##   ^
```


### Systematic Hunting For Bugs in Pipes

What if it is not one of the Big 5 Pipe Bugs, and you need to hunt systematically?

Let's start by adding a pipe to the last line (`slice(1:10)`),    
and then a `return()` as a new line following `slice(1:10)`,    
so that you now have an 8 line pipe.     
**Note** it will be blue - this is OK. 
It just shows that this is an important function.
<br>
Adding `return()` just returns the result of the previous 7 lines,    
which does not seem like much,    
but it makes it a lot easier to use our debugging MVP, the hashtag.
<br>
<br>
First, in debugging a pipe, you want to be able to quickly select and run lines repeatedly. You can do this with your mouse, but it is slow and sometimes inaccurate.
You can do this faster with the keyboard.
To run a whole pipe, just click anywhere in the pipe and press the key combination: <br>
Cmd-Shift-Return on the Mac <br>
Ctrl-Shift-Return on PC <br>
<br>
With this key combination, you don't have to use your mouse to select lines to run.    
This will run the whole pipe or plot.
<br>
Now you have to take control of exactly which lines of the pipe will run.<br>
You want to run a series of experiments to isolate the bug. <br>
Start by running the pipe from the top.<br>
Run just your first line (data) by putting a hashtag just before the first pipe `%>%` and pressing Cmd-Shift-Return while still on that line. If that works, delete the hashtag and repeat the process on the 2nd line.  <br>      
You can stop running the pipe after only 2 lines by placing a hashtag just before the 2nd pipe. Then press your Cmd-Shift-Return key combo to run just the first 2 lines.      <br>
If that works, try running the first 3 lines, by deleting the hashtag on line 2, and putting it just before the pipe on line 3 (Copy-Paste can help). <br>
Use this approach to run successively more lines of the pipe in the code chunk below.    
<br>
In which line of the pipe below do you hit the first error (bug)?


```r
iris %>% 
  filter(Sepal.Length <5) %>% 
  select(Sepal.Length, Sepal.Width, Species) %>% 
  mutate(Sepal.Area = Sepal.Lngth * Sepal.Width) %>% 
  filter(Sepal.Area >10) %>% 
  arrange(desc(Sepal.Area) %>% 
  slice(1:10) %>% 
  return()
  
```

```
## Error: <text>:10:0: unexpected end of input
## 8:   return()
## 9:   
##   ^
```

Great. Now you know the bug is somewhere in lines 4-7. <br>
You can selectively turn off one line at a time by putting a hashtag at the beginning of the line.
Use this approach to turn off line 5 (filter). <br>
Does this fix the pipe?<br>
 If not, try lines 4,6,7 individually. Turning off which one gets rid of the error/changes the error? <br>
 Changing the error means that you made it at least a little bit farther before a new error occurred. <br>
 Now hunt in the 'commented out/hashtagged' line for an error you can fix. Once you think you have fixed it, try running the pipe up to and including that line (hashtag just before pipe in that line). Does that work?<br>
If yes, you have made progress. <br>
Keep going line by line until you find and fix the next bug, until you can get the whole pipe to run.

### Systematic Hunting For Bugs in Plots

The Big 5 Common Errors in Plots are slightly different.
<br>

1. Click just to the right of each final parenthesis on each line. Does this result in highlighting the first parenthesis on that line of code? If not, you are probably missing a closing parenthesis.
2. When plotting, check that you have a plus sign `+` at the end of each line, except for the last line.
3. Missing aes() mapping. <br> 
It is easy to get excited about your ggplot and declare variables in the ggplot statement, and forget about wrapping the mapping of x and y in an aesthetic function. Check to make sure that every time you map variables in your data to a plot component (x,y, color, shape, size, etc.) that this occurs **inside** an aes() call.
4. Error message about a missing function - ` Error in function(arguments) : could not find function "func"`. Either you are calling a function from a library you have not loaded, or you mis-typed the function. If the library was not loaded, go back to the top and load the library that this function comes from. If you mis-typed the function (for example, `/selcet`), fix the typographical error. The error message will tell you which function seems to be missing.
5. Error message about a missing object - `Error: object 'xxxobj' not found`. Make sure that you have typed the names of the dataframe and the variables correctly. Each of these is a data object. The error message will tell you which object seems to be missing.
<br>
### Your Turn to Debug a Plot
<br>
Before hashtag-debugging the plot below, we will cap the plot code with an additional final line, by adding a `+` to the final line `theme_minimal()` and a new following line: `NULL`. This functions like `return` does for pipes - we can now use hashtags to turn off lines without causing errors because of missing pipes.<br>
Go ahead and add the `+` and `NULL` to the plot in the code chunk below.


```
## Error in theme_mnimal(): could not find function "theme_mnimal"
```

Now use the same hashtag approach to run the lines of the plot code sequentially, adding one line at a time, with a hashtag placed just before the pipe, and using the Cmd-Shift-Return key combination. When you hit an error, use the hashtag at the beginning of each line that is a suspect in this Bug Hunt, and turn off one line at a time until you isolate the Bug.
Then try to fix it, and run the whole plot chunk one line at a time.

### Hashtag Debugging

The elements of **Hashtag Debugging** of a code chunk are simply stated in 7 steps:

1. Add a placeholder line to the end of the code chunk
  a. `%>% return()` for data pipes
  b. `+ NULL` for plots
2. Insert a hashtag just before the line extender (`%>%` for datapipes, `+` for plots) near the top of the code chunk
3. Use Cmd-Shift-Return or Ctrl-Shift-Enter to run the code up to the hashtag.
4. Keep running more lines by moving the hashtag down one line until you hit an error.
5. Try to find and fix the error in that line.
6. If needed, put a hashtag at the beginning of a line to turn off that line and run the rest of the pipe.
7. If the error IS resolved (or changes), you have fixed the first error. Now run incrementally more lines (steps 2-4) until you have found a new error or completely fixed the pipe.

Use your new skills.    
Figure out which Star Wars characters are overweight (by human standards)
<br>
Try debugging the data pipe below.
Work through each step in the process.


```r
starwars %>% 
  filter(height <180) %>% 
  select(name, height, mass, gender homeworld, species) %>% 
  mtate(bmi = mass^2/height) %>% 
  filter(bmi>=25) %<% 
  select(name, height, mass, bmi) %>% 
  arrange(dsc(bmi)) %>% 
  slice(1:15) 
  
```

```
## Error: <text>:3:37: unexpected symbol
## 2:   filter(height <180) %>% 
## 3:   select(name, height, mass, gender homeworld
##                                        ^
```

Good work!

Now try debugging the problematic plotting code chunk below. 
There are multiple errors.
Work through each step in the process.


```r
murders %>% 
  ggplot(x = population/10^6, y = total, label = abb) +
  geom_abline(intercept = log10(r), lty=2, col=darkgrey) +
  geom_point(aes(color==region), size = 3) +
  geom_text_repel() +
  scale_x_log10() +
  scale_y_log10() +
  xlab("Populations in millions (log scale)") +
  ylab("Total number of murders (log scale)") 
```

```
## Error in layer(data = data, mapping = mapping, stat = StatIdentity, geom = GeomAbline, : object 'darkgrey' not found
```

```r
  ggtitle("US Gun Murders in 2010") +
  scale_color_discrete(name="Region")
```

```
## NULL
```


Here is another complex plot.
Work through each step to completely debug this one.
When it works, it will make a heatmap of measles cases in the US
by month and year, with the introduction of the measles vaccine 
marked as an important event.


```r
us_contagious_diseases %>%
  filter(!state%in%c("Hawaii","Alaska") & disease ==  the_disease) %>%
  mutate(rate = count / population * 10000 * 52 / weeks_reporting) %>%
  mutate(state = reorder(state, rate) %>%
  ggplot(aes(year state,  fill = rate)) %>%
  geom_tile(color = "grey50") +
  scale_x_cntinuous(expand=c(0,0)) +
  scale_fill_gradientn(colors = brewer.pal(9, "Reds"), trans = "sqrt") +
  geom_vline(xintercept=1963, col = "blue") +
  theme_minimal() +  
  theme(panel.grid = element_blank()) +
  ggttle(the_disease) +
  ylab("") +
  xlab("")
```

```
## Error: <text>:5:19: unexpected symbol
## 4:   mutate(state = reorder(state, rate) %>%
## 5:   ggplot(aes(year state
##                      ^
```

Now let's try a final data pipe debugging.

Use your skills to make this one work.


```r
gapminder %>% 
  filter(year == 1965) %>% 
  filter(!is.na(infant_mortality) %>% 
  mutate(adult_survival = life_expectancy/infant_mortality) %>% 
  select(country, adultsurvival, continent) %>% 
  group_by(continent) %>% 
  summarize(mean_adult_surv = mean(adult_survival),
            sd_adult_surv = stdev(adult_survival)) %>% 
  arrange(mean_adult_surv)
  
```

```
## Error: <text>:11:0: unexpected end of input
## 9:   arrange(mean_adult_surv)
## 10:   
##    ^
```



<!--chapter:end:io58-debug_pipes_plots.Rmd-->

---
title: "Finding Help in R"
author: "Peter Higgins"
date: "11/3/2019"
output: html_document
---



## Programming in R

Saving programs and data in R is critical to producing reproducible medical research. But for most people, coding is not easy, comes with lots of syntax errors and cryptic error messages, and can be frustrating. One of the key skills in programming in R is finding help when you are stuck. <br>
<br>
In this chapter, we will explain several ways to find help in R, moving from the simple to the more complex.

## Starting with Help!

The simplest approach to getting help in R is to use the _help()_ function. In the console, you can type _help("lm")_ or _help("geom\_boxplot")_ or  _help("filter")_ to make the reference materials appear in the Help tab in the lower right quadrant of RStudio. Note that there may be more than one match - in which case it will show you a list. The search for _help("filter")_ is a good example, as many packages have function that includes _'filter'_ in the name. 
In the code block below, use _help('filter')_ to find the details on the _filter_ function from the _dplyr_ package.


```r
help()
```
<br>
You can also get help by going directly to the Help tab, and entering a term in the search box (top right of the Help window, with a magnifying glass icon), and pressing return. <br>
<br>
Help will take you directly to the documentation of a package or a function, which includes 

- Description
- Usage (generic function with argument defaults)
- Arguments - explanation of each argument
- Details provided by the package author
- Examples (which can sometimes be cryptic)

This is useful if you are just trying to remember the arguments to a function and/or their defaults, but is often not terribly helpful for beginners trying to understand how to use a package or a particular function. <br>
Let's explore the dplyr::filter documentation a bit. There are 3 arguments listed, though **...** is a bit cryptic. The first argument is the **.data**, which is often piped in. The
**...** argument lets you insert a variety of logical statements to filter by, and the **.preserve** argument defaults to recalculating grouping structure after filtering (default value is FALSE). <br> 
<br>
The Details section recommends filtering **before** grouping for better speed (because of that recalculation of grouping structure). <br> 
<br>
There are details on how grouping and rownames are affected by filter, followed by a mention of 3 variants of filter, filter_all, filter_if, and filter_at, which allow you to work on selections of variables. <br> 
<br>
This is followed by some examples of the use of _filter_. <br>

## The Magic of Vignettes
While the function documentation that you can find with _help()_ explains the nuts and bolts (and arguments) for a function, it does not tell you much about the intended use, or the structure of the data that you should use this function on. Wrangling data into the right structure is often critical to successfully using a function. <br>
<br>
This makes package vignettes very helpful.
The _browseVignettes('package\_name')_ function can help you find the available vignettes for a given package. 
Edit the code block below to browse vignettes for the _tidyr_ package. Remember to use quotes. this will open a webpage list to read the vignette and see examples of the use of _tidyr_.


```r
browseVignettes()
```

```
## starting httpd help server ... done
```

Another useful approach is to search on the web for vignettes. You can Google "flextable vignettes" fo find examples of how to use the _flextable_ package. Jump to a web browser and try it out. You will see nice explanations, and examples of code that you can copy and paste back into RStudio and run - either in the Console (interactively), or in a script. Try out a few of the layout and formatting examples with _flextable_. <br>
<br>
Often when you are first using a package, the vignette is the best place to start to get oriented to the intended use of the package and its functions. <br>
<br>
Several newer packages have dedicated documentation websites make with the _pkgdown_ package. You can search for these by Googling _packagename_ and "tidyverse"" for packages in the tidyverse. Google the package website for the _forcats_ package. Read the Home text, then check out the Reference page (tab) for each function. The Articles or "Get Started" tab often contains examples. <br>
<br> 
A general strategy is to Google "<name> package in R".
Try googling a few others, like 

- ggpubr
- RVerbalExpressions
- sf
- quanteda

## Googling the Error Message

It is very common to get an obscure error message. These are intended to be helpful, but often are not. A few common error messages and their usual causes are:

| Error Message        | Common Causes    | 
| ------------- |-------------:| 
| "could not find function x"    | package not installed, or function misspelled | 
| "subscript out of bounds"      | trying to find the 15th item in a vector when there are only 12      | 
| "error in if" | an if statement trying to deal with non-logical data or NAs.      |   
| "cannot open" | trying to read a file that can't be found   |  
| "object x not found" | using an argument that needs quotes without the quotes. If there are no quotes, R assumes that you are looking for an object already defined in the Environment tab.|  

An R error message cheat sheet can be found [here] (http://varianceexplained.org/courses/errors/)

Over time, you will learn to recognize common errors. But until you do (and even **after** you do), a helpful way out of a frustrating error message is to copy the error message, and paste it into a Google search. Some one has had that error before and asked for help on the internet. You can learn from their experience, and see what solutions other folks have come up with. 

Run the code block below to generate an error, then google the error message and see if you can figure out how to fix it.



```
## Error: stat_smooth requires the following missing aesthetics: x and y
```

![](io60-help_in_R_files/figure-latex/ggplot-1.pdf)<!-- --> 

The problem is that the ggplot function does not include the aesthetics layer around x and y - 
aes(x, y) is required inside the _ggplot()_ function to tell ggplot that the variables time and conc should be mapped to x and y. 

## You Know What You Want to Do, but Don't Know What Package or Function to Use

### CRAN Task Views
There are two general approaches to this problem. If you know a general topic area, and are looking for packages, the CRAN Task Views can be really helpful in finding a package that does what you need. CRAN Task Views are lists of packages that do useful things in a certain topic area. Pick your task, and it will supply a useful list of likely packages, with a description of what the package does and a link to the documentation. <br>
<br>
Look for packages to help you block randomize patients into clinical trials on CRAN [here] (https://cran.r-project.org/web/views/). The ClinicalTrials link will take you to an extensive list of packages that help with a variety of needs for clinical trials. 
You will fairly quickly find the _blockrand_ package is one that suits your needs, though there are a few other options available. 

### Google is Your Friend
Try googling "How to do" __task__ "in R".
Try "How do do block randomization in R".
Several options come up, including the blockrand package.<br>
<br>
Try another one - google "how to put significance bars in a ggplot in R".
Several options come up, including ggsignif and ggpubr.

## Seeking Advanced Help with a Minimal REPREX
 There is a large R community, and many experienced people are willing to help you when you are stuck. However, it can be very difficult to accurately explain your problem to someone who is not at your computer. <br>
<br>
 This problem has led to the concept of the minimal REProducible EXample (minimal REPREX), and the _reprex_ package. The reprex package helps you post a useful example on websites like the [RStudio Community](https://community.rstudio.com) or [Stack Overflow](https://stackoverflow.com) to ask for help.<br>
<br>
A minimal reproducible example includes:
1. All of the libraries needed
2. a small ('toy') dataset, with no extra columns (just the ones needed), and a limited number of rows (often 5-6).
3. Your code, which is not quite working, or producing a surprising result
4. A clear explanation of the result you are trying to get with your code (sometimes this is a jpeg of a graph, or a table of what you want the data to look like after processing).

There is a nice explanation of how to reprex for beginners [here](https://www.jessemaegan.com/post/so-you-ve-been-asked-to-make-a-reprex/).

More resources and details can be found [in the RStudio Community FAQ here](https://community.rstudio.com/t/faq-whats-a-reproducible-example-reprex-and-how-do-i-do-one/5219)

Before we start making a reprex of our own, let's look at a few examples on RStudio Community.

1. https://community.rstudio.com/t/could-not-plot-geometric-point/42558
2. https://community.rstudio.com/t/how-to-subset-a-data-frame-by-a-rowvalue/43514/8
3. https://community.rstudio.com/t/pivot-wider-tidyselect-and-col-how-to-exclude-variables/41191
4. https://community.rstudio.com/t/new-to-r-would-like-to-find-a-way-to-find-the-mean-of-each-states/39161

Now you have a feel for what a reprex looks like, and how folks ask and answer questions on RStudio Community. 
<br>
<br>
So let's imagine that you are trying to plot data on blood pressure for men and women, and you want to color the points differently for men and women. But you don't know how. 
Let's start with the 4 steps to a reprex.
In a new script you need to:

1. include all libraries needed.<br>
  In this case, <br>
  library(tidyverse) <br>
  covers any data wrangling and ggplot2
  <br>
2. Include your data. This should be a minimal or 'toy' dataset. Be **SURE** you are not including any fields that are Protected Health Information (PHI) or identifiers. You can 
  a. use a built-in dataset (https://www.rdocumentation.org/packages/datasets/versions/3.6.1)  and _select()_ a few key variables and _filter()_ down to a reasonable number of rows (or use _head()_ to get 6 rows), or 
  b. take your own data and select only the columns needed and use filter() or head() for a minimal number of rows. **Make sure** not to use any Protected Health Information (PHI).Then use _dput()_ to add the data to the reprex and assign it to an object
  c. build a toy dataset from scratch with data.frame
  d. Use the _datapasta_ package to copy in some data from a website or spreadsheet

#### Built in datasets
In the code chunk below, examine the built-in dataset, infert.
Then select only education, age, and parity.
Then use head() to get only 6 rows.
Assign this to `data` and print it out

```r
glimpse(datasets::infert)
```

```
## Rows: 248
## Columns: 8
## $ education      <fct> 0-5yrs, 0-5yrs, 0-5yrs, 0-5yrs, ...
## $ age            <dbl> 26, 42, 39, 34, 35, 36, 23, 32, ...
## $ parity         <dbl> 6, 1, 6, 4, 3, 4, 1, 2, 1, 2, 2,...
## $ induced        <dbl> 1, 1, 2, 2, 1, 2, 0, 0, 0, 0, 1,...
## $ case           <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,...
## $ spontaneous    <dbl> 2, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0,...
## $ stratum        <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 1...
## $ pooled.stratum <dbl> 3, 1, 4, 2, 32, 36, 6, 22, 5, 19...
```


```r
glimpse(datasets::infert)
```

```
## Rows: 248
## Columns: 8
## $ education      <fct> 0-5yrs, 0-5yrs, 0-5yrs, 0-5yrs, ...
## $ age            <dbl> 26, 42, 39, 34, 35, 36, 23, 32, ...
## $ parity         <dbl> 6, 1, 6, 4, 3, 4, 1, 2, 1, 2, 2,...
## $ induced        <dbl> 1, 1, 2, 2, 1, 2, 0, 0, 0, 0, 1,...
## $ case           <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,...
## $ spontaneous    <dbl> 2, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0,...
## $ stratum        <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 1...
## $ pooled.stratum <dbl> 3, 1, 4, 2, 32, 36, 6, 22, 5, 19...
```

```r
data <- infert %>% 
  select(education, age, parity) %>% 
  head()
data
```

```
##   education age parity
## 1    0-5yrs  26      6
## 2    0-5yrs  42      1
## 3    0-5yrs  39      6
## 4    0-5yrs  34      4
## 5   6-11yrs  35      3
## 6   6-11yrs  36      4
```

#### Filtering your dataframe object
In the code chunk below, examine the local dataset, emerg_dept,
which has counts of ED arrivals, how many breached the UK 4 hour guarantee, and how many got admitted.
Then _select()_ only org_code, attendances, breaches, and admissions.
Then _arrange()_ to have the top attendances at the top,
use _top_n(10)_ to get only the top 10 rows.
Assign this to `data` and print it out

```r
emerg_dept
```

```
## # A tibble: 50 x 6
##    period     org_code type  attendances breaches admissions
##    <date>     <fct>    <fct>       <dbl>    <dbl>      <dbl>
##  1 2018-07-01 RRK      1           32209     6499      11332
##  2 2018-07-01 R1H      1           28357     6294       7986
##  3 2018-07-01 RW6      1           23887     4641       6282
##  4 2018-07-01 R0A      1           22012     4669       6818
##  5 2018-07-01 RDU      1           21043     1941       6519
##  6 2018-07-01 RAL      1           20481     2529       4530
##  7 2018-07-01 RF4      1           19303     4606       5004
##  8 2018-07-01 RWE      1           18890     4861       4522
##  9 2018-07-01 RXF      1           18828     2731       3981
## 10 2018-07-01 RQM      1           18560     1064       4130
## # ... with 40 more rows
```


```r
emerg_dept %>% 
  select(org_code, attendances:admissions) %>% 
  arrange(desc(attendances)) %>% 
  top_n(10) ->
data
```

```
## Selecting by admissions
```

```r
data
```

```
## # A tibble: 10 x 4
##    org_code attendances breaches admissions
##    <fct>          <dbl>    <dbl>      <dbl>
##  1 RRK            32209     6499      11332
##  2 R1H            28357     6294       7986
##  3 RW6            23887     4641       6282
##  4 R0A            22012     4669       6818
##  5 RDU            21043     1941       6519
##  6 RF4            19303     4606       5004
##  7 RR8            17889     3507       5345
##  8 RTG            17591     2757       5302
##  9 RJE            16622     3758       5855
## 10 R1K            11922     3038       6098
```

#### Toy datasets
Run the code below to build a toy dataset with patient_id, sbp, dbp.
Then edit the code to add 4 values for heart rate and
4 values for respiratory rate

```r
df <- data.frame(
  patient_id = 1:4,
  sbp = c(151, 137, 129, 144),
  dbp = c(92, 85, 79, 66)
)
df
```

```
##   patient_id sbp dbp
## 1          1 151  92
## 2          2 137  85
## 3          3 129  79
## 4          4 144  66
```


#### Fun with Datapasta Example
_datapasta_ is a package for pasting data. It is super-helpful when you just want to quickly get a bit of data from a website or a spreadsheet. <br>
Go to the website, https://en.wikipedia.org/wiki/Health_insurance_coverage_in_the_United_States, and find the large table named, "Percent uninsured (all persons) by state, 1999–2014". Carefully copy the table without the title line.
Then use the Addins dropdown to "Paste as Tribble" into your code file. Assign the resulting tibble to an object named ins_data.  You will get funny names for the columns. Change these with names(ins_data), and assign state and 1999:2014 to the names.
Filter to get rid of DC and United states. You should end up with 50 rows.


```r
ins_data <- tibble::tribble(
                     ~V1,  ~V2,  ~V3,  ~V4,  ~V5,  ~V6,  ~V7,  ~V8,  ~V9, ~V10, ~V11, ~V12, ~V13, ~V14, ~V15, ~V16, ~V17,
              "Division", 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014,
               "Alabama",   12, 12.5, 12.4, 12.2, 12.5,   12,   14, 15.1, 11.7, 11.5, 16.4, 15.5,   13, 14.8, 13.6, 12.1,
                "Alaska", 18.3, 17.4, 14.8,   18, 17.5, 15.3, 16.9, 16.4, 17.6, 19.6, 17.2, 18.1, 18.2,   19, 18.5, 17.2,
               "Arizona", 19.4, 16.4, 16.7, 16.4, 16.4, 16.2, 19.1, 20.8, 17.8, 19.1, 18.9, 19.1, 17.3,   18, 17.1, 13.6,
              "Arkansas", 13.9, 14.1, 16.4, 16.5, 17.2, 15.9, 17.2, 18.6, 15.7, 17.6,   19, 18.5, 17.5, 18.4,   16, 11.8,
            "California",   19, 17.5,   18, 16.5, 17.3, 17.5,   18, 17.8, 17.5, 18.1, 19.3, 19.4, 19.7, 17.9, 17.2, 12.4,
              "Colorado", 14.1, 12.9, 14.6, 14.5, 15.3, 15.2, 16.2, 16.5,   16, 15.4, 14.5, 12.9, 15.7, 13.7, 14.1, 10.3,
           "Connecticut",  7.3,  8.9,  8.2,  8.6,  9.4, 10.3, 10.1,  8.7,  8.6,  9.4, 11.1, 11.2,  8.6,  8.1,  9.4,  6.9,
              "Delaware",  9.7,  8.5,  8.5,  9.2,  9.6, 13.1, 11.6, 11.9, 10.6, 10.7,   13, 11.3,   10, 10.8,  9.1,  7.8,
  "District of Columbia",   14, 12.8, 12.3,   13, 12.7,   12, 12.4, 10.9,  9.3,  9.4, 12.4, 12.8,  8.4,  7.9,  6.7,  5.3,
               "Florida", 17.4, 16.2, 16.9, 15.6,   17, 18.3, 19.5, 20.3, 19.8, 19.4, 21.7, 20.7, 19.8, 21.5,   20, 16.6,
               "Georgia", 14.2, 13.9, 14.7, 14.6, 15.2, 15.7, 17.9, 17.3, 17.2, 17.1, 20.5, 19.5, 19.2, 19.2, 18.8, 15.8,
                "Hawaii",  9.2,  7.9,  8.2,  8.8,  8.6,  8.5,  8.1,  7.9,  6.9,  7.3,  7.4,  7.7,  7.8,  7.7,  6.7,  5.3,
                 "Idaho", 18.2, 15.4, 15.7, 16.9, 17.7, 14.5, 14.4, 15.1, 13.6, 15.4, 15.1, 19.1, 16.9, 15.9, 16.2, 13.6,
              "Illinois", 11.9,   12, 11.8, 12.4, 13.8, 12.5, 13.2, 13.5,   13, 12.2, 14.2, 14.8, 14.7, 13.6, 12.7,  9.7,
               "Indiana",  8.9, 10.1, 10.1, 11.5, 12.2, 12.4, 13.1, 11.3,   11, 11.3, 13.7, 13.4,   12, 13.4,   14, 11.9,
                  "Iowa",  7.8,  8.1,  6.8,    9, 10.4,  8.8,  8.1,  9.9,  8.8,    9, 10.8, 12.2,   10, 10.1,  8.1,  6.2,
                "Kansas", 11.2,  9.6,  9.8,  9.4, 10.1, 10.6,   10, 12.1, 12.4, 11.8, 12.8, 12.6, 13.5, 12.6, 12.3, 10.2,
              "Kentucky", 12.9, 12.7, 11.6, 12.7, 13.7, 13.9, 11.7, 15.2, 13.4, 15.7, 15.9, 14.8, 14.4, 15.7, 14.3,  8.5,
             "Louisiana", 20.9, 16.8, 17.8, 17.2,   19,   17, 16.9, 21.1,   18, 19.5, 14.5, 19.8, 20.8, 18.3, 16.6,  8.5,
                 "Maine",  9.2, 10.4, 10.2, 10.4,  9.6,  9.3,  9.8,  8.9,  8.5, 10.2,   10,  9.3,   10,  9.5, 11.2, 10.1,
              "Maryland",   10,    9,   11, 11.7, 12.2, 11.9, 13.1, 13.2, 12.7, 11.4, 13.3, 12.8, 13.8, 12.4, 10.2,  7.9,
         "Massachusetts",  7.8,  7.1,  6.9,  9.5, 10.1,  9.8,  8.6,  9.6,  4.9,    5,  4.3,  5.5,  3.4,  4.1,  3.7,  3.3,
              "Michigan",    9,  7.8,    9,  9.8,  9.3, 10.2,  9.5, 10.1, 10.8, 11.5,   13,   13, 12.5, 10.9,   11,  8.5,
             "Minnesota",  6.6,    8,  6.9,  7.9,  8.7,  8.3,  7.6,  8.9,    8,  8.2,    8,  9.7,  9.2,  8.3,  8.2,  5.9,
           "Mississippi", 15.7, 13.2,   17, 16.2, 17.5, 16.9, 16.5, 20.3, 18.4, 17.7, 17.3,   21, 16.2, 15.3, 17.1, 14.5,
              "Missouri",  6.6,  8.6,  9.7, 10.8,  9.9,   11, 11.4, 13.1, 12.2, 12.4, 14.6, 13.9, 14.9, 13.3,   13, 11.7,
               "Montana", 17.3, 16.1, 13.8, 14.3, 18.9, 17.5, 15.5, 16.9,   15, 15.7, 15.1, 18.2, 18.3, 18.1, 16.5, 14.2,
              "Nebraska",    9,  7.9,  7.9,  9.3, 10.1, 10.3,  9.8,   12,   13, 11.1, 11.1, 13.2, 12.3, 13.3, 11.3,  9.7,
                "Nevada", 18.3, 15.7, 14.5, 18.4, 17.6, 18.2, 16.5, 18.6, 16.9, 18.1, 20.6, 21.4, 22.6, 23.5, 20.7, 15.2,
         "New Hampshire",  7.7,  7.9,  9.7,  8.8,  9.3,  8.7,  9.1, 10.8,  9.9, 10.1,  9.8, 10.1, 12.5,   12, 10.7,  9.2,
            "New Jersey", 11.1, 10.2, 11.6,   12, 12.8, 12.6, 13.7, 14.8, 14.6, 13.2, 14.5, 15.6, 15.4,   14, 13.2, 10.9,
            "New Mexico",   24,   23, 19.6,   20, 21.3, 19.3, 20.2, 22.7, 21.8, 22.8, 20.9, 21.4, 19.6, 21.9, 18.6, 14.5,
              "New York", 14.4, 14.5, 13.9,   14, 14.3, 11.8, 12.1, 13.4, 12.3, 13.4, 14.1, 15.1, 12.2, 11.3, 10.7,  8.7,
        "North Carolina", 12.5, 12.1, 13.3, 15.9, 16.7, 14.2, 14.5, 17.4, 16.2, 15.1, 17.8, 17.1, 16.3, 17.2, 15.6, 13.1,
          "North Dakota", 10.2,  9.8,    8,  9.7, 10.3,   10, 10.8, 11.8,  9.5, 11.6, 10.3, 13.4,  9.1, 11.5, 10.4,  7.9,
                  "Ohio",  9.9,  9.8,  9.9, 10.4, 11.1, 10.3,   11,  9.6, 11.1, 11.2, 13.8, 13.6, 13.7, 12.3,   11,  8.4,
              "Oklahoma", 15.4, 17.4, 17.2, 16.7, 19.1, 18.7, 17.7, 18.8, 17.6, 13.8, 17.9, 17.3, 16.9, 17.2, 17.7, 15.4,
                "Oregon", 14.2, 11.6, 12.7, 14.3,   16, 15.4, 15.3, 17.5, 16.2, 15.9, 17.3,   16, 13.8, 15.4, 14.7,  9.7,
          "Pennsylvania",  7.8,  7.6,  8.4, 10.2,   10, 10.1,  9.3,  9.4,  9.1,  9.6, 10.9, 10.9, 10.8,   12,  9.7,  8.5,
          "Rhode Island",  5.9,  6.9,  7.7,  8.1, 10.4,   10, 10.7,  8.1, 10.5,   11,   12, 11.5,   12, 12.3, 11.6,  7.4,
        "South Carolina", 14.8, 10.7, 11.1, 11.1, 13.1, 14.9, 16.3, 15.3, 15.9, 15.5, 16.8, 20.5,   19, 14.3, 15.8, 13.6,
          "South Dakota", 10.1, 10.8,  8.3, 10.8, 10.6,   11, 11.5, 11.5,  9.9, 12.2, 13.1, 13.1,   13, 14.4, 11.3,  9.8,
             "Tennessee",  9.3, 10.7, 10.1,  9.8, 12.2, 12.4, 13.4, 13.2,   14, 14.5,   15, 14.6, 13.3, 13.9, 13.9,   12,
                 "Texas", 21.1,   22, 22.4, 24.5, 23.6, 23.6, 22.9, 23.9, 24.7, 24.5, 25.5, 24.6, 23.8, 24.6, 22.1, 19.1,
         "United States", 13.6, 13.1, 13.5, 13.9, 14.6, 14.3, 14.6, 15.2, 14.7, 14.9, 16.1, 16.3, 15.7, 15.4, 14.5, 11.7,
                  "Utah", 11.9, 10.8, 13.8, 12.1, 11.5, 12.8, 15.5, 16.7, 12.2,   12, 14.1, 13.8, 14.6, 14.4,   14, 12.5,
               "Vermont", 10.1,  7.4,  8.8,  8.9,  8.4,  9.8, 11.2,  9.8, 10.1,  9.3,  9.4,  9.3,  8.6,    7,  7.2,    5,
              "Virginia", 11.3,  9.6,  9.8, 11.8, 11.5,   13, 12.3, 12.5, 14.2, 11.8, 12.6,   14, 13.4, 12.5, 12.3, 10.9,
            "Washington", 12.2, 13.1, 13.3, 12.3, 14.8, 12.5, 12.5, 11.5,   11,   12, 12.6, 13.9, 14.5, 13.6,   14,  9.2,
         "West Virginia", 14.9, 13.4, 12.9, 13.8, 16.8, 15.7, 16.5, 13.3, 13.7, 14.5, 13.7, 13.4, 14.9, 14.6,   14,  8.6,
             "Wisconsin",  9.7,  7.1,  7.3,  8.6,  9.8, 10.3,  8.8,    8,    8,  9.2,  8.9,  9.4, 10.4,  9.7,  9.1,  7.3,
               "Wyoming", 14.5, 14.7, 14.1, 14.8, 14.8, 12.3, 14.4, 14.2, 13.2, 13.3, 15.4, 17.2, 17.8, 15.4, 13.4,   12
  )
names(ins_data) <- c("state", c(1999:2014))

ins_data %>% slice(2:45) %>% bind_rows(slice(ins_data, 47:53)) %>%
  filter(state != "District of Columbia") ->
  ins_data
```


3. include your minimal code - just enough to reproduce the problem, and no more.

Now you need to
- run this minimal code in a new script window to make sure it reproduces the problem and gets the same error.
- Install the reprex package

```r
#install.packages('reprex')
```
- Select all of the code in your new script window, including libraries, data, and code
- copy this with Ctrl-C (Windows) or Cmd-C (Mac)
- go to the Console, type in "reprex()" and enter
- your REPREX will be generated and will show up in your Viewer tab. This is now on your Clipboard.
- Go to [RStudio Community](https://community.rstudio.com) and start a new topic.
- Type in an introduction to your problem, state clearly what you are trying to do, and where you are stuck.
- Paste in the reprex.
- Thank people in advance for their help.
- Post this topic.
- Wait for helpful answers.





<!--chapter:end:io60-help_in_R.Rmd-->

---
title: "Advanced Modeling"
author: "Peter Higgins"
date: "4/21/2019"
output: html_document
---



## R Markdown

Linear and Logistic models do not work in all cases.
Consider the example of some pK data from oral dosing of Theophylline.


```r
data("Theoph")
glimpse(Theoph)
```

```
## Rows: 132
## Columns: 5
## $ Subject <ord> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, ...
## $ Wt      <dbl> 79.6, 79.6, 79.6, 79.6, 79.6, 79.6, 79....
## $ Dose    <dbl> 4.02, 4.02, 4.02, 4.02, 4.02, 4.02, 4.0...
## $ Time    <dbl> 0.00, 0.25, 0.57, 1.12, 2.02, 3.82, 5.1...
## $ conc    <dbl> 0.74, 2.84, 6.57, 10.50, 9.66, 8.58, 8....
```
12 Subjects were given varying oral doses, with 132 serum levels taken at 11 time points. These roughly include 0, 0.25, 0.5, 1, 2, 4, 5, 7, 9, 12, and 24 h. Exact times are recorded as numeric variables, so that these Times are not groupable like a factor variable.

So why is this hard to model?
Let's take a look

## Including Plots

You can also embed plots, for example:

![](io64-GAM_files/figure-latex/plot-1.pdf)<!-- --> 

http://www.sthda.com/english/articles/40-regression-analysis/162-nonlinear-regression-essentials-in-r-polynomial-and-spline-regression-models/#spline-regression

No surprise here, but this rises quickly after oral dosing, then slowly drifts down over 24 h. Not a good linear model or a logistic model. <br>
You could imagine fitting two linear models in piecewise fashion - one up to 1 hour, and one after one hour.
But how to interpret/explain that?
And is the cutoff closer to 2 hours?
And how to incorporate dose and Wt?

This is where GAMs (General Additive Models) shine.
It can automatically pick out where to best break the data into distinct models, and place 'knots' in the splines at these points, then piecewise model the data between these knots. 

Let's set up a GAM


```r
model <- gam(conc ~ s(Wt) + s(Dose) + s(Time), data=Theoph)
summary(model)
```

```
## 
## Family: gaussian 
## Link function: identity 
## 
## Formula:
## conc ~ s(Wt) + s(Dose) + s(Time)
## 
## Parametric coefficients:
##             Estimate Std. Error t value            Pr(>|t|)
## (Intercept)   4.9605     0.1046   47.44 <0.0000000000000002
##                
## (Intercept) ***
## ---
## Signif. codes:  
## 0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Approximate significance of smooth terms:
##           edf Ref.df      F              p-value    
## s(Wt)   8.528  8.914  5.005           0.00000657 ***
## s(Dose) 1.000  1.000  1.448                0.231    
## s(Time) 8.872  8.995 64.022 < 0.0000000000000002 ***
## ---
## Signif. codes:  
## 0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## R-sq.(adj) =  0.824   Deviance explained = 84.9%
## GCV = 1.6918  Scale est. = 1.4431    n = 132
```
That adjusted R2 looks good, and the deviance explained seems high.
But it is a black box.
Lets make predictions and take a look.


```r
model <- gam(conc ~ s(Wt) + s(Dose) + s(Time), data=Theoph)
predictions <- model %>% predict(Theoph)
predictions <- as.data.frame(predictions)
Theoph <- cbind(Theoph, predictions$predictions)
names(Theoph)[6] <- "predicted"
Theoph <- Theoph[,1:6]
ggplot(aes(x=Time, y=predicted, color=Subject), data=Theoph) + 
  geom_line() +
  geom_point(aes(x=Time, y=conc))
```

![](io64-GAM_files/figure-latex/predictions-1.pdf)<!-- --> 

that looks promising.
How well do actual conc and predicted conc correlate?


```r
ggplot(aes(x=conc, y=predicted), data = Theoph) + 
  geom_point()
```

![](io64-GAM_files/figure-latex/cor-1.pdf)<!-- --> 

```r
cor(Theoph$conc, Theoph$predicted)
```

```
## [1] 0.9215227
```


<!--chapter:end:io64-GAM.Rmd-->

---
title: "Reproducible Medical Research with R"
author: "Peter D.R. Higgins, MD, PhD, MSc"
date: "2020-04-24"
output: html_document
---

<!--chapter:end:io98-title-holder.Rmd-->



<!--chapter:end:io99-references.Rmd-->

