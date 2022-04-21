---
title: "Reproducible Medical Research with R"
author: "Peter D.R. Higgins, MD, PhD, MSc"
date: "2022-04-15"
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

# Preface

Welcome to Reproducible Medical Research with R (RMRWR).
I hope that this book is helpful to you.

## Who This Book is For

This is a book for anyone in the medical field interested in analyzing the data available to them to better understand health, disease, or the delivery of care.
This could include nurses, dieticians, psychologists, and PhDs in related fields, as well as medical students, residents, fellows, or doctors in practice.\
I expect that most learners will be using this book in their spare time at night and on weekends, as the health training curricula are already packed full of information, and there is no room to add skills in reproducible research to the standard curriculum.
This book is designed for self-teaching, and many hints and solutions will be provided to avoid roadblocks and frustration.
Many learners find themselves wanting to develop reproducible research skills after they have finished their training, and after they have become comfortable with their clinical role.
This is the time when they identify and want to address problems faced by patients in their practice with the data they have before them.
This book is for you.

## Prerequisites

Thank you for giving this e-book a try.
This is designed for physicians and others analyzing health data who are interested in pursuing this field using the R computer language.
<br> We will assume that:

-   You have access to a computer
-   You have access to the internet
-   You can download and install software from the internet to your computer

How to download and install R and RStudio will be addressed, step by step, in Chapter 2.
<br>

## The Spiral of Success Structure

This book is structured on the concept of a "spiral of success", with readers learning about topics like data visualization, data wrangling, data modeling, reproducible research, and communication of results in repeated passes.
These will initially be at a superficial level, and at each pass of the spiral, will provide increasing depth and complexity.
This means that the chapters on data wrangling will not all be together, nor the chapters on data visualization.
Our goal is to build skills gradually, and return to (and remind students of) their previously built skills in one area and to add to them.
The eventual goal is for learners to be able to produce, document, and communicate reproducible research to their community.

## Motivation for this Book

Most medical providers who learn R to do their own data analysis do it on their own time.
They rarely have time for a semester-long course, as their clinical schedules usually will not allow it.
Fortunately, a lot of people learn R on their own, and there is a strong and supportive R community to help new learners.
A 2019 Twitter survey conducted by @RLadies found that more than half of respondents were largely self-taught, from books and online resources.

There are a lot of good resources for learning R, so why one more?
In part, because the needs of a medical audience are often different.
There are distinct needs for protecting health information, generating a descriptive Table One, using secure data tools like REDCap, and creating standard medical journal and meeting output in Word, Powerpoint, and poster formats.

Further, while learning from a textbook can be helpful, this e-book has the ability to include interactive features that are important for learning to write your own analysis code.
Informative **flipbook** demonstrations will show you what steps in R code do, and **learnr** exercises will give you a chance to do your own coding to solve problems, right within this e-book.

More and more, all science is becoming data science.
We are able to track patients, their test results, and even the individual pixels (voxels) of their CT scans electronically, and use those data points to develop new knowledge.
While one could argue that health care workers should collect data and bring it to trained statisticians, this does not work nearly as well as you might expect.
Most academic statisticians are incentivized to develop new statistical methods, and are not very interested (nor incentivized) to do the hand-holding required to wrangle messy clinical data into a manuscript.

There also are simply not enough statisticians to meet the needs of medical science.
Having clinicians on the front lines with some data science training makes a big difference, whether in 1854 in London (John Snow) or in 2014 in Flint, Michigan (Mona Hanna-Atisha).
Having more clinicians with some data science training will impact medical care, as they will identify local problems that would have otherwise never reached a statistician, and probably never been addressed with data otherwise.

## The Scientific Reproducibility Crisis

Beginning as far back as 1989, with the David Baltimore case, and increasingly and publicly through the 2010s, there has been a rising tide of realization that a lot of taxpayer-funded science is done sloppily, and that our standards as scientists need to be higher.
The line between carelessly-done science and outright fraud is a thin one, and the case can be made that doing science in a sloppy fashion defrauds the funders, as it leads to results that can not be reproduced by the authors nor replicated by others.
Particularly in medicine, where incorrect findings can cause great harm, we should take special care to do scientific research which is well-documented, reproducible, and replicable.
This topic as a motivating force for doing careful medical research will be expanded upon in Chapter 1.

## Features of a Bookdown electronic book

### Icons

There are several icons at the top left, to the right of the clickable RMWR link, that can be helpful:

1\.
The Table of Contents Sidebar - Click on the **'hamburger' menu icon** (three horizontal lines) or the `s` key to toggle the sidebar (table of contents) on and off.
Within the sidebar, you can click on whichever chapter or subsection you want.

2\.
This book is Searchable - Click on the **magnifying glass** or use the `f` key to toggle the `Find` box and search for whatever you need to find.

3\.
You can change the font size, font, and background by clicking on the **A** icon.

4\.
You can download the chapter with the download icon (downward arrow into a file tray) in PDF or EPUB formats.

### Sharing

At the top right, there are several icons for sharing links to the current chapter through social media.

### Scrolling/Paging

1.  You can scroll up and down within a chapter with your mouse, or use the up and down arrow keys.
2.  You can page through chapters with the left and right arrow keys.

## What this Book is Not

### This Book is Not A Statistics Text

This is not an introduction to statistics.
I am assuming that you have learned some statistics somewhere in secondary school, undergraduate studies, graduate school, or even medical school.
There are lots of statisticians with Ph.D.s who can certainly teach statistics much more effectively than I can.
While I have a master's degree in Clinical Research Design and Statistical Analysis (isn't that a mouthful!) from the University of Michigan, I will leave formal teaching of statistics to the pros.\
If you need to brush up on your statistics, no worries.
There are several excellent (and free!) e-books on that very topic, using R.
Some good examples include (go ahead and click through the blue links to explore):

1.  [Learning Statistics with R (LSR)](https://learningstatisticswithr-bookdown.netlify.com)
2.  [Open Intro Statistics](https://www.openintro.org/book/os/)
3.  [Modern Dive](https://bookdown.org/fjmcgrade/ismaykim/)
4.  [Teacup Giraffes](https://tinystats.github.io/teacups-giraffes-and-statistics/index.html)

We will cover much of the same material as these books, but with a less theoretical and more applied approach.
I will focus on specific medical examples, and emphasize issues (like Protected Health Information) that are particularly important for medical data.
I am assuming that you are here because you want to analyze your own data in your (probably) very limited free time.

### This Book Does Not Provide Comprehensive Coverage of the R Universe

This book is also far from comprehensive in teaching what is available in the R ecosystem.
This book should be considered a launch pad.
Many of the later chapters will give you a taste of what is available in certain areas, and guide you to resources (and links) that you can explore to learn more and do more beyond the scope of this book.
The R computer language has expanded far beyond statistics, and allows you to do many powerful things to improve your workflow, make amazing graphics, and share results with others.

## Some Guideposts

Keep an eye out for helpful Guideposts, which look like this:

**Warnings**

::: {.warning}
This is a common syntax error, especially for beginners.
Watch out for this.
:::

**Tips**

::: {.tip}
This is a helpful tip for debugging.
:::

**Try It Out**

::: {.tryit}
Take what you have learned and try it yourself on your own computer.
:::

**Challenge** - take the next step and try a more challenging example.

::: {.challenge}
Try this more complicated example.
:::

**Explore More** - resources for learning more about a particular topic.

::: {.explore}
If you want to learn more about Shiny apps, go to <https://mastering-shiny.org> to see an entire book on the topic.
:::

## Helpful Tools

Throughout this book you will find **flipbook** code demonstrations and **learnr** code interactive exercises in which you can practice writing R code right in the book.
Let's explain how to use these demonstration flipbooks and learnr exercises.

### Demonstrations in Flipbooks

Flipbooks are windows in this book in which you can watch R code being built into pipelines, and see the results at each step.
Each flipbook demonstrates some important code concepts, and often new functions in R.
You can click on the window to activate it, and the fullscreen (4 arrows) icon to expand it to the full screen.
Then use the left and right arrow keys to go forward and back in the code, one step at a time.
You will want to go through these *slowly*, and make sure that you understand what is happening in each step.
You may even want to take notes, particularly on the function syntax, as you will likely coding exercises with these functions shortly after the flipbook demonstration.

Take a look at the example of a flipbook below.\
Activate it by clicking on it, and use the expand icon (4 arrows at the lower right) to make it full screen.
You can step forward and backward through the pipeline of code with the right and left arrow keys.
Watch the results of each step.

<!---FLIPBOOK EX 1-->

<iframe style="margin:0 auto; border: solid black;" id="myIframe8" width="763" height="432" src="https://higgi13425.github.io/mini_flipbooks/demo_microflip.html#1" scrolling="no" allowfullscreen loading="lazy">

</iframe>

<!---FLIPBOOK EX 1-->

### Learnr Coding Exercises

Learnr coding exercises are windows in this book in which you can write your own R code to solve a problem.
Each learnr exercise tests whether you have mastered important code concepts, and often new functions in R.
If needed, you can reset to a fresh code window with the `Start Over` button.
You can type lines of code into the window, then click on the `Run Code` button at the top right to run the code and get your results.
Your code may not produce the right result the first time, and you will have to interpret the error message to figure out how to fix it.
Rely on the text and your notes and the demonstrations to help you.
If you are stuck, you can click on the `Hint` button to see an example of correct code, and compare it to your own.
If you would like, you can even copy this code to the clipboard with the `Copy` button and

Take a look at the example of a learnr exercise below.\
There is a dataset piped into a series of functions ('verbs'), with a blank.
Fill in the blank with 'p_vol' (without the quotes), which stands for the variable, prostate volume.
Then run your code with the `Run Code` button to get a result.
Practice using the `Start Over` button, the `Hint` button (there may be more than one - usually the **last** one is the solution), and the `Copy To Clipboard` button.

<!---LEARNR TUTORIAL EX 1-->

<iframe style="margin:0 auto; border: solid black;" id="myIframe9" width="763" height="763" src="https://higginslab-rshiny.med.umich.edu/shiny-apps/learn_demo/" scrolling="yes">

</iframe>

<!---LEARNR TUTORIAL EX 1-->

When you get a table of data as a result from a code pipeline, it may have more columns (variables) than can be displayed easily.
When this is the case, there will be a black arrow pointing rightward at the top right of the table of results.
Click on this to scroll right and see more columns.\
A table of data as a result from a code pipeline may also have more rows (observations) than can be displayed easily.
When this is the case, the table will be paginated, with 10 rows per page.
At the bottom right of the table, there will be a clickable listing of pages, along with `Previous` and `Next` buttons.
Click on these buttons (or the page number buttons) to see more pages of data to inspect and check your results.

### Coding

An **important note** on writing your own code: you should always have an internet search window open when you are writing code.
No one can remember every function, nor the correct arguments and syntax of each function.
A critical skill in writing code is searching for how to do something correctly.
This is **not** a sign of weakness.
Professional programmers google "*how do I do x?*" many times each day.
This is **how** programming is done.
You will often search for things like "how do I do x in R?" or "how to x in tidyverse".
This is completely normal, and to be expected.
You do not have time to memorize hundreds of functions, and you may have days or even weeks between coding sessions (because of your day job), making it hard to remember all the details from your last coding session.
This is not a problem.
There are lots of websites that can help you solve specific problems, as you will find in the How to Find Help chapter.


