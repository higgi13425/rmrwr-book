---
title: "Finding Help in R"
author: "Peter Higgins"
date: "11/3/2019"
output: html_document
---



# Finding Help in R

Because the path to something valuable is never easy.  Learning R programming is hard, and at times will be frustrating. You will need help frequently. But the journey is a lot easier if you learn how to ask the R community for help when you are stuck. There is a very good chance that someone else has been stuck in the same place, and that there is good advice available.

## Programming in R

Saving programs and data in R is critical to producing reproducible medical research. But for most people, coding is not easy, comes with lots of syntax errors and cryptic error messages, and can be frustrating. One of the key skills in programming in R is finding help when you are stuck. <br>
<br>
In this chapter, we will explain several ways to find help in R, moving from the simple to the more complex.

## Starting with Help!

The simplest approach to getting help in R is to use the _help()_ function. In the console, you can type _help("lm")_ or _help("geom\_boxplot")_ or  _help("filter")_ to make the reference materials appear in the Help tab in the lower right quadrant of RStudio. Note that there may be more than one match - in which case it will show you a list. The search for _help("filter")_ is a good example, as many packages have function that includes _'filter'_ in the name. 
In the code block below, use _help('filter')_ to find the details on the _filter()_ function from the {dplyr} package.


``` r
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


``` r
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
- gtsummary
- arsenal

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
## Error in `geom_smooth()`:
## ! Problem while computing stat.
## ℹ Error occurred in the 1st layer.
## Caused by error in `compute_layer()`:
## ! `stat_smooth()` requires the following missing aesthetics: x and y.
```

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
2. Include your data. This should be a minimal or 'toy' dataset. Be **SURE** you are not including any fields that are Protected Health Information (PHI) or identifiers. You can do this one of several ways:
  a. use a built-in dataset (https://www.rdocumentation.org/packages/datasets/versions/3.6.1)  and _select()_ a few key variables and _filter()_ down to a reasonable number of rows (or use _head()_ to get 6 rows), or 
  b. take your own data and select only the columns needed and use filter() or head() for a minimal number of rows. **Make sure** not to use any Protected Health Information (PHI).Then use _dput()_ to add the data to the reprex and assign it to an object
  

``` r
medicaldata::blood_storage %>% 
  select(Recurrence, PVol, TVol, AA, FamHx) %>% 
  head() ->
small_blood

dput(small_blood)
```

```
## structure(list(Recurrence = c(1, 1, 0, 0, 0, 0), PVol = c(54, 
## 43.2, 102.7, 46, 60, 45.9), TVol = c(3, 3, 1, 1, 2, 2), AA = c(0, 
## 0, 0, 0, 0, 0), FamHx = c(0, 0, 0, 0, 0, 0)), row.names = c(NA, 
## 6L), class = "data.frame")
```

``` r
# output of data will show up in the console
# copy this and assign it to an object to start your reprex.
# as below

dataset <- structure(list(Recurrence = c(1, 1, 0, 0, 0, 0), PVol = c(54, 
43.2, 102.7, 46, 60, 45.9), TVol = c(3, 3, 1, 1, 2, 2), AA = c(0, 
0, 0, 0, 0, 0), FamHx = c(0, 0, 0, 0, 0, 0)), row.names = c(NA, 
6L), class = "data.frame")
```
  

  c. build a toy dataset from scratch with `tibble:tribble()`.
  Each ~tilde_var gives you a variable name, each separated by commas,
  and each value is separated by a comma.
  And, remember not to put a comma after the last value (a common mistake).
  

``` r
dataset <- tibble::tribble(
  ~pat_id, ~sbp, ~dbp, ~hr,
  001, 147, 92, 84,
  002, 158, 99, 88,
  003, 137, 84, 67,
  004, 129, 92, 73
)
```

  d. Use the _datapasta_ package to copy in some data from a website or spreadsheet
  
  Install the package, copy a (small) amount of data.
  Use the add-in to paste your data, usually as a data frame or a tribble (you can choose either).
  Remember to assign it to an object like `dataset`.

#### Built in datasets
In the code chunk below, examine the built-in dataset, infert.
Then select only education, age, and parity.
Then use head() to get only 6 rows.
Assign this to `data` and print it out

``` r
glimpse(datasets::infert)
```

```
## Rows: 248
## Columns: 8
## $ education      <fct> 0-5yrs, 0-5yrs, 0-5yrs, 0-5yrs, 6-11yrs, 6-11yrs, 6-11y…
## $ age            <dbl> 26, 42, 39, 34, 35, 36, 23, 32, 21, 28, 29, 37, 31, 29,…
## $ parity         <dbl> 6, 1, 6, 4, 3, 4, 1, 2, 1, 2, 2, 4, 1, 3, 2, 2, 5, 1, 3…
## $ induced        <dbl> 1, 1, 2, 2, 1, 2, 0, 0, 0, 0, 1, 2, 1, 2, 1, 2, 2, 0, 2…
## $ case           <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1…
## $ spontaneous    <dbl> 2, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 1, 1…
## $ stratum        <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, …
## $ pooled.stratum <dbl> 3, 1, 4, 2, 32, 36, 6, 22, 5, 19, 20, 37, 9, 29, 21, 18…
```


``` r
glimpse(datasets::infert)
```

```
## Rows: 248
## Columns: 8
## $ education      <fct> 0-5yrs, 0-5yrs, 0-5yrs, 0-5yrs, 6-11yrs, 6-11yrs, 6-11y…
## $ age            <dbl> 26, 42, 39, 34, 35, 36, 23, 32, 21, 28, 29, 37, 31, 29,…
## $ parity         <dbl> 6, 1, 6, 4, 3, 4, 1, 2, 1, 2, 2, 4, 1, 3, 2, 2, 5, 1, 3…
## $ induced        <dbl> 1, 1, 2, 2, 1, 2, 0, 0, 0, 0, 1, 2, 1, 2, 1, 2, 2, 0, 2…
## $ case           <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1…
## $ spontaneous    <dbl> 2, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 1, 1…
## $ stratum        <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, …
## $ pooled.stratum <dbl> 3, 1, 4, 2, 32, 36, 6, 22, 5, 19, 20, 37, 9, 29, 21, 18…
```

``` r
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

``` r
emerg_dept
```

```
## # A tibble: 50 × 6
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
## # ℹ 40 more rows
```


``` r
emerg_dept %>% 
  select(org_code, attendances:admissions) %>% 
  arrange(desc(attendances)) %>% 
  top_n(10) ->
data
```

```
## Selecting by admissions
```

``` r
data
```

```
## # A tibble: 10 × 4
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

``` r
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

- install the package {datapasta}, if you don't have it already
- run `library(datapasta)`
- Go to the website, https://en.wikipedia.org/wiki/Health_insurance_coverage_in_the_United_States, and find the large table named, "Percent uninsured (all persons) by state, 1999–2014". Carefully copy the table without the title line.
- Then use the Addins dropdown to "Paste as Tribble" into your code file. Assign the resulting tibble to an object named ins_data.  You will get funny names for the columns. 
- Change these with names(ins_data), and assign state and 1999:2014 to the names.
`names(ins_data) <- c('state', c(1999:2014))`
- Then filter to get rid of DC and `United States`. 
You should end up with 50 rows.


<div class='webex-solution'><button>Show/Hide Solution</button>


``` r
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
  filter(state != "District of Columbia") %>% 
  filter(state != "United States") ->
  ins_data
```

</div>


3. include your minimal code - just enough to reproduce the problem, and no more.

Now you need to
- run this minimal code in a new script window to make sure it reproduces the problem and gets the same error.
- consider adding an illustration of what you **want or expect** to output to look like
- Install the reprex package

``` r
#install.packages('reprex')
```
- Select all of the code in your new script window, including libraries, data, and code
- copy this with Ctrl-C (Windows) or Cmd-C (Mac)
- go to the Console, type in "reprex()" and enter
- your REPREX will be generated and will show up in your Viewer tab. This is now **also** on your Clipboard.
- Go to [RStudio Community](https://community.rstudio.com) and start a new topic.
- Type in an introduction to your problem, state clearly what you are trying to do, and where you are stuck.
- Paste in the reprex.
- Thank people in advance for their help.
- Post this topic.
- Wait for helpful answers.


You can also email a reprex to a friend, so that they can give it a try.

:::challenge
Try making your own reprex, and emailing it to a friend.
See if they can find/solve the problem.
:::


