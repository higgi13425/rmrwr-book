---
title: "A Tasting Menu"
author: "Peter Higgins"
date: "4/14/2020"
output: html_document
editor_options: 
  markdown: 
    wrap: sentence
---



# A Tasting Menu of R

In this chapter, we will introduce you to a lot of neat things that you can do with R and RStudio, and you will publish a simple data analysis on the Internet that you can share with friends and family.
![tasting](images/tasting.png)

## Setting the Table

At the end of this chapter, you will publish a data analysis to *RPubs*, a free website site where you can share your data analyses and visualizations.
First you will need to set up an account on RPubs.
Start by opening a new tab in your browser, and navigating to this [RPubs link](https://rpubs.com/users/new).
It should look like the image below.
![rpubs1](images/rpubs1.png)\
<br> Enter your name, email, username and password, and click on the *Register Now* button, and you will be set up to use RPubs.\
This will bring you to this pag
e. In the image below, we have set up an account for pd
r.\
![rpubs2](images/rpubs2.png) Click on the *Here's How You Get Started* l
ink. ![rpubs3](images/rpubs3.png)\
You are now all set up and ready
to go. Now you have a place on the internet to share your R crea
tions. On to the creation
part!

## Goals for this Chapter

-   Open a New Rmarkdown document
-   Read in Data from a file
-   Wrangle Your Data
-   Visualize Your Data
-   Publish your work to RPubs
-   Check out Interactive Plots
-   Check out Animated Graphics
-   Check out a Clinical Trial Dashboard
-   Check out a Shiny App

## Packages needed for this Chapter

You will need to enter this line of code into your console, to make sure that the tidyverse package is installed on your computer.
`install.packages("tidyverse")`

In the setup chunk of your Rmarkdown document, you will need to access the tidyverse package with one line of code: `library(tidyverse)`

## Website links needed for this Chapter

In this chapter, you will need to access the RPubs website.\
- <https://rpubs.com/>

## Pathway for this Chapter

This Chapter is part of the **XXX** pathway.
Chapters in this pathway include

## Open a New Rmarkdown document

Let's get started in R.
Turn on your computer, and open the RStudio application.
You should see the familiar panes for the Console, Environment, and Files.\
You need to open up a new document to activate the Source pane.
While in RStudio, click on File/New File/RMarkdown.
It should look like this.
\
![newrmd](images/rmd1.png) Now you will see the window belo
w. Rename the document from "Untitled" to "Tasting", Enter your own name as the Author, and click the OK butto
n. ![newrmd2](images/rmd2.png)

Now the file is open, and looks like the window below.
Click on the save icon (like a floppy disk in the top left), and save this document as tasting.Rmd.
![newrmd3](images/rmd3.png)

You have created a new Rmarkdown document.
An Rmarkdown document lets you mix data, code, and descriptive text.
It is very helpful for presenting and explaining data and visualizations.
An Rmarkdown document can be converted (Knit) to HTML for a web page, Microsoft Word, Powerpoint, PDF, and several other formats.

**Code chunks** are in a gray color, and both start and end with 3 backticks (\`\`\`).


```r
code goes here
```

**Text** can be body text, or can be headers and titles.
The number of hashtags before some header text defines what level the header is.\
You can insert **links**, **images**, and even YouTube **videos** into Rmarkdown documents if it is helpful to explain your point.

The first code chunk in each Rmarkdown document is named `setup`.
The name comes after the left curly brace and the r (`{r`) at the beginning of the setup chunk.
The letter `r` tells RStudio that what is coming on the next line is R code (RStudio can also use SQL, C++, python, and several other languages).
After the comma, you can define options for this code chunk.
In this case, the option `include` is set to FALSE, so that when this Rmarkdown document is knitted, this code chunk will not appear.

## Read in Data from a file

We will start by reading in some data from the {medicaldata} package.

### Installing Packages

Before we begin, you have to have a few R packages installed on your computer.

Go to your Console tab, and type in (or copy and paste in) the following 3 lines (below the {r} ):


```r
install.packages('tidyverse')
install.packages('janitor')
install.packages('medicaldata')
```

Press Enter to run these functions.
These will install the 3 packages, {tidyverse}, {janitor}, and {medicaldata}.
Installing packages is like buying apps for your phone.
But these apps are not loaded unless you tell R and RStudio that you want them loaded in the current session.
You do this with the *library()* function.

### Loading Packages with library()

Copy and paste to add the following 4 lines (below the {r} line) to your `setup` chunk in your "Tasting.Rmd" Rmarkdown document:


```r
library(tidyverse)
library(janitor)
library(medicaldata)
prostate <- medicaldata::blood_storage %>% clean_names()
```

These functions will load 3 packages and reads in data from a study of prostate cancer and blood storage into the `prostate` object.

To run these functions, click on the green rightward arrow at the top right of the `setup` code chunk.

The {tidyverse} package (it is actually a meta-package that contains multiple packages) will be quite chatty, telling you which packages are being attached, and when conflicts with identically-named functions in the {stat} package have occurred.
When you call these functions, *filter()* and *lag()*, the versions from the {tidyverse} package will be used by default, and the versions from the {stats} package will be masked.

The {janitor} package will tell you that it has 2 conflicts with the {stats} package, and will supercede (mask) the {stats} functions for *chisq.test()* and *fisher.test().*

If you really want to access the versions from the {stats} package, you can do so by using the **package::function** construction, e.g. `stats::chisq.test().`

If you check the Environment tab in the top right pane of RStudio, you will find that you now have a **prostate** object under the Data header.
You can click on the white-on-blue arrow to the left of the word prostate to get an overview of each variable, the variable type (numeric, string, etc.), and the first few values of each variable.

You can also click on the word prostate in the Environment window to open up a View of the whole dataset in the Source pane (top left).
You can scroll up and down the rows, or right and left in the columns to inspect the data.

If you check the Console tab (lower left), you will see that when you clicked on prostate, this sent a function to the console to **View(prostate)**.
You can view any dataset in the Environment tab with this function.

You can also look at your data in the Console, with

`summary(prostate) or`

`glimpse(prostate)`

Underneath the setup chunk, write something about the prostate dataset.
You can write in Normal text, and add headers by starting a line with 2 hashtags, a space, and text like this

\#\# Headline about Prostate data

Write a few sentences after your headline.
You can add *italics* or **bold** text by wrapping the text to be highlighted in underscores or 2 asterisks, respectively.

## Wrangle Your Data

Add a new code chunk

name it

wrangle it - select, filter

## Visualize Your Data



first ggplot

## Publish your work to RPubs

push to RPubs

You did it.

Share website with others

## The Dessert Cart

Below are some examples of neat things you can do with medical data in R.
These are more advanced approaches, but completely doable when you have more experience with R.

### Interactive Plots

Below is an interactive plot.
Click on the plot to activate it.
Then you can hover your mouse over each point to get more details about the data.
You can also use the crosshairs to draw a zoom rectangle, or use the plotly menu bar at top right to zoom in or out of a region of the data.


```{=html}
<div id="htmlwidget-149385b7c14b5b91cb55" style="width:672px;height:480px;" class="plotly html-widget"></div>
<script type="application/json" data-for="htmlwidget-149385b7c14b5b91cb55">{"x":{"data":[{"x":[5.16,79.05,33.02,92.71,8.71,30.98,14.23,4.53,9.66,18.79,27.76,5.19,19.42,99.42,88.57,14,14.62,18.33,13.7,30.39,10.97,4.5,5.68,70.74,151.59,173.83],"y":[3.55,65.12,28.55,22.05,23.95,85.19,17.71,3.25,6.8,0.66,0.76,1.35,2.73,1.15,1.15,3.22,29.31,23.66,34,3.61,20.34,8.9,3.06,0.99,21.68,3.32],"text":["time.to.transplant:   5.16<br />time.to.agvhd:  3.55<br />factor(donor.cmv): 0","time.to.transplant:  79.05<br />time.to.agvhd: 65.12<br />factor(donor.cmv): 0","time.to.transplant:  33.02<br />time.to.agvhd: 28.55<br />factor(donor.cmv): 0","time.to.transplant:  92.71<br />time.to.agvhd: 22.05<br />factor(donor.cmv): 0","time.to.transplant:   8.71<br />time.to.agvhd: 23.95<br />factor(donor.cmv): 0","time.to.transplant:  30.98<br />time.to.agvhd: 85.19<br />factor(donor.cmv): 0","time.to.transplant:  14.23<br />time.to.agvhd: 17.71<br />factor(donor.cmv): 0","time.to.transplant:   4.53<br />time.to.agvhd:  3.25<br />factor(donor.cmv): 0","time.to.transplant:   9.66<br />time.to.agvhd:  6.80<br />factor(donor.cmv): 0","time.to.transplant:  18.79<br />time.to.agvhd:  0.66<br />factor(donor.cmv): 0","time.to.transplant:  27.76<br />time.to.agvhd:  0.76<br />factor(donor.cmv): 0","time.to.transplant:   5.19<br />time.to.agvhd:  1.35<br />factor(donor.cmv): 0","time.to.transplant:  19.42<br />time.to.agvhd:  2.73<br />factor(donor.cmv): 0","time.to.transplant:  99.42<br />time.to.agvhd:  1.15<br />factor(donor.cmv): 0","time.to.transplant:  88.57<br />time.to.agvhd:  1.15<br />factor(donor.cmv): 0","time.to.transplant:  14.00<br />time.to.agvhd:  3.22<br />factor(donor.cmv): 0","time.to.transplant:  14.62<br />time.to.agvhd: 29.31<br />factor(donor.cmv): 0","time.to.transplant:  18.33<br />time.to.agvhd: 23.66<br />factor(donor.cmv): 0","time.to.transplant:  13.70<br />time.to.agvhd: 34.00<br />factor(donor.cmv): 0","time.to.transplant:  30.39<br />time.to.agvhd:  3.61<br />factor(donor.cmv): 0","time.to.transplant:  10.97<br />time.to.agvhd: 20.34<br />factor(donor.cmv): 0","time.to.transplant:   4.50<br />time.to.agvhd:  8.90<br />factor(donor.cmv): 0","time.to.transplant:   5.68<br />time.to.agvhd:  3.06<br />factor(donor.cmv): 0","time.to.transplant:  70.74<br />time.to.agvhd:  0.99<br />factor(donor.cmv): 0","time.to.transplant: 151.59<br />time.to.agvhd: 21.68<br />factor(donor.cmv): 0","time.to.transplant: 173.83<br />time.to.agvhd:  3.32<br />factor(donor.cmv): 0"],"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgba(248,118,109,1)","opacity":1,"size":5.66929133858268,"symbol":"circle","line":{"width":1.88976377952756,"color":"rgba(248,118,109,1)"}},"hoveron":"points","name":"0","legendgroup":"0","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[35.58,11.4,2.43,9.59,null,43.43,39,17.84,4.53,21.32,16.33,162.4,13.7,76.09,10.35,5.45,3.65,6.9,3.19,8.67,136.87,4.07,9.92,12.88,8.48,11.7,13.04,1.84,43.89,7.82,46.82,24.34,10.74,2.53,4.01,33.54,8.94,24.44],"y":[3.75,2.79,3.88,2.99,4.8,0.69,2.14,1.41,10.58,12.48,9.59,77.54,21.32,0.72,84.47,78.29,0.82,2.63,44.71,16.26,18.53,2.04,21.68,53.78,3.65,2.99,3.29,2.6,9.66,0.95,2.2,11.1,31.54,7.92,2.07,11.3,7.43,8.05],"text":["time.to.transplant:  35.58<br />time.to.agvhd:  3.75<br />factor(donor.cmv): 1","time.to.transplant:  11.40<br />time.to.agvhd:  2.79<br />factor(donor.cmv): 1","time.to.transplant:   2.43<br />time.to.agvhd:  3.88<br />factor(donor.cmv): 1","time.to.transplant:   9.59<br />time.to.agvhd:  2.99<br />factor(donor.cmv): 1","time.to.transplant:     NA<br />time.to.agvhd:  4.80<br />factor(donor.cmv): 1","time.to.transplant:  43.43<br />time.to.agvhd:  0.69<br />factor(donor.cmv): 1","time.to.transplant:  39.00<br />time.to.agvhd:  2.14<br />factor(donor.cmv): 1","time.to.transplant:  17.84<br />time.to.agvhd:  1.41<br />factor(donor.cmv): 1","time.to.transplant:   4.53<br />time.to.agvhd: 10.58<br />factor(donor.cmv): 1","time.to.transplant:  21.32<br />time.to.agvhd: 12.48<br />factor(donor.cmv): 1","time.to.transplant:  16.33<br />time.to.agvhd:  9.59<br />factor(donor.cmv): 1","time.to.transplant: 162.40<br />time.to.agvhd: 77.54<br />factor(donor.cmv): 1","time.to.transplant:  13.70<br />time.to.agvhd: 21.32<br />factor(donor.cmv): 1","time.to.transplant:  76.09<br />time.to.agvhd:  0.72<br />factor(donor.cmv): 1","time.to.transplant:  10.35<br />time.to.agvhd: 84.47<br />factor(donor.cmv): 1","time.to.transplant:   5.45<br />time.to.agvhd: 78.29<br />factor(donor.cmv): 1","time.to.transplant:   3.65<br />time.to.agvhd:  0.82<br />factor(donor.cmv): 1","time.to.transplant:   6.90<br />time.to.agvhd:  2.63<br />factor(donor.cmv): 1","time.to.transplant:   3.19<br />time.to.agvhd: 44.71<br />factor(donor.cmv): 1","time.to.transplant:   8.67<br />time.to.agvhd: 16.26<br />factor(donor.cmv): 1","time.to.transplant: 136.87<br />time.to.agvhd: 18.53<br />factor(donor.cmv): 1","time.to.transplant:   4.07<br />time.to.agvhd:  2.04<br />factor(donor.cmv): 1","time.to.transplant:   9.92<br />time.to.agvhd: 21.68<br />factor(donor.cmv): 1","time.to.transplant:  12.88<br />time.to.agvhd: 53.78<br />factor(donor.cmv): 1","time.to.transplant:   8.48<br />time.to.agvhd:  3.65<br />factor(donor.cmv): 1","time.to.transplant:  11.70<br />time.to.agvhd:  2.99<br />factor(donor.cmv): 1","time.to.transplant:  13.04<br />time.to.agvhd:  3.29<br />factor(donor.cmv): 1","time.to.transplant:   1.84<br />time.to.agvhd:  2.60<br />factor(donor.cmv): 1","time.to.transplant:  43.89<br />time.to.agvhd:  9.66<br />factor(donor.cmv): 1","time.to.transplant:   7.82<br />time.to.agvhd:  0.95<br />factor(donor.cmv): 1","time.to.transplant:  46.82<br />time.to.agvhd:  2.20<br />factor(donor.cmv): 1","time.to.transplant:  24.34<br />time.to.agvhd: 11.10<br />factor(donor.cmv): 1","time.to.transplant:  10.74<br />time.to.agvhd: 31.54<br />factor(donor.cmv): 1","time.to.transplant:   2.53<br />time.to.agvhd:  7.92<br />factor(donor.cmv): 1","time.to.transplant:   4.01<br />time.to.agvhd:  2.07<br />factor(donor.cmv): 1","time.to.transplant:  33.54<br />time.to.agvhd: 11.30<br />factor(donor.cmv): 1","time.to.transplant:   8.94<br />time.to.agvhd:  7.43<br />factor(donor.cmv): 1","time.to.transplant:  24.44<br />time.to.agvhd:  8.05<br />factor(donor.cmv): 1"],"type":"scatter","mode":"markers","marker":{"autocolorscale":false,"color":"rgba(0,191,196,1)","opacity":1,"size":5.66929133858268,"symbol":"circle","line":{"width":1.88976377952756,"color":"rgba(0,191,196,1)"}},"hoveron":"points","name":"1","legendgroup":"1","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null}],"layout":{"margin":{"t":43.7625570776256,"r":7.30593607305936,"b":40.1826484018265,"l":37.2602739726027},"plot_bgcolor":"rgba(255,255,255,1)","paper_bgcolor":"rgba(255,255,255,1)","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187},"title":{"text":"Time to Transplant vs Time to Acute GVHD by Donor CMV Status","font":{"color":"rgba(0,0,0,1)","family":"","size":17.5342465753425},"x":0,"xref":"paper"},"xaxis":{"domain":[0,1],"automargin":true,"type":"linear","autorange":false,"range":[-6.7595,182.4295],"tickmode":"array","ticktext":["0","50","100","150"],"tickvals":[-8.88178419700125e-16,50,100,150],"categoryorder":"array","categoryarray":["0","50","100","150"],"nticks":null,"ticks":"outside","tickcolor":"rgba(51,51,51,1)","ticklen":3.65296803652968,"tickwidth":0.66417600664176,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":11.689497716895},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"gridcolor":"rgba(235,235,235,1)","gridwidth":0.66417600664176,"zeroline":false,"anchor":"y","title":{"text":"Time to Transplant","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187}},"hoverformat":".2f"},"yaxis":{"domain":[0,1],"automargin":true,"type":"linear","autorange":false,"range":[-3.5665,89.4165],"tickmode":"array","ticktext":["0","20","40","60","80"],"tickvals":[0,20,40,60,80],"categoryorder":"array","categoryarray":["0","20","40","60","80"],"nticks":null,"ticks":"outside","tickcolor":"rgba(51,51,51,1)","ticklen":3.65296803652968,"tickwidth":0.66417600664176,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":11.689497716895},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"gridcolor":"rgba(235,235,235,1)","gridwidth":0.66417600664176,"zeroline":false,"anchor":"x","title":{"text":"Time to Acute GVHD","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187}},"hoverformat":".2f"},"shapes":[{"type":"rect","fillcolor":"transparent","line":{"color":"rgba(51,51,51,1)","width":0.66417600664176,"linetype":"solid"},"yref":"paper","xref":"paper","x0":0,"x1":1,"y0":0,"y1":1}],"showlegend":true,"legend":{"bgcolor":"rgba(255,255,255,1)","bordercolor":"transparent","borderwidth":1.88976377952756,"font":{"color":"rgba(0,0,0,1)","family":"","size":11.689497716895},"y":0.913385826771654},"annotations":[{"text":"Donor<br />CMV<br />Status","x":1.02,"y":1,"showarrow":false,"ax":0,"ay":0,"font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187},"xref":"paper","yref":"paper","textangle":-0,"xanchor":"left","yanchor":"bottom","legendTitle":true}],"hovermode":"closest","barmode":"relative"},"config":{"doubleClick":"reset","showSendToCloud":false},"source":"A","attrs":{"179d32c8ab542":{"x":{},"y":{},"colour":{},"type":"scatter"}},"cur_data":"179d32c8ab542","visdat":{"179d32c8ab542":["function (y) ","x"]},"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.2,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script>
```

### Animated Graphics

Here is an example of animated graphics that you can create in R to illustrate changes in data over time.

![](images/vaccination-animation.gif)<!-- -->

### A Clinical Trial Dashboard

Below is an screen capture picture of a web flexdashboard to track the data in an ongoing clinical trial (which is now completed and published).
You can see the actual web dashboard [here](https://jenthompson.me/examples/progressdash.html).

Check out the various tabs.
Imagine how useful it would be to track enrollment, exclusions, missing data, and outcomes in real time.

Details on how this is done can be found [here](https://jenthompson.me/2018/02/09/flexdashboards-monitoring/), and the underlying code [here](https://github.com/jenniferthompson/MOSAICProgress).

All of this work was done in R by [Jenn Thompson](https://jenthompson.me/about/).

<img src="images/clin_trial_dashboard.png" width="638" />

### A Shiny App

The frame below shows a publicly available Shiny web application, built with R, which can help clinicians calculate the probablity of intestinal TB vs. Crohn's disease with available clinical data.
And to determine how new test results would change this estimate.

The web app can be accessed [here](https://www.pathology.med.umich.edu/shiny/tbcrohns/).

<img src="images/tb_shiny_app.png" width="634" />

### An Example of Synergy in the R Community

One of the remarkable things about the open source R community is that people build all kinds of new R functions and packages that are useful to them, and then share them publicly with tools like *Github* so that they can be useful to others.
Often combining bits of several packages leads to **emergent properties** - completely new creations that can only occur because all of the parts (packages) are present.
The collaborative nature of the R community, in this case on Twitter (follow the \#rstats hashtag), can lead to surprising collaborations and outcomes.\
Go ahead and play the example below, which uses rayrendering (all coded entirely in R) to show a 3D map of John Snow's cholera case data in 1854, which led him to identify the Broad Street water pump as the source of the cholera outbreak, and led to the removal of the pump handle and the end of outbreak.
\

<iframe width="560" height="315" src="https://www.youtube.com/embed/B_UsX5vfPJU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen>

</iframe>



If you are not familiar with John Snow and the Broad Street pump, there is a fun series of YouTube animations (parts 1-3 and an epilogue) to explain the history.
Start by clicking [here](https://www.youtube.com/watch?v=TLpzHHbFrHY&feature=emb_rel_end).
