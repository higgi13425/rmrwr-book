---
title: "Wrangling Columns in R with Select, Rename, and Relocate"
author: "Peter Higgins"
date: "12/15/2020"
output: html_document
editor_options: 
  markdown: 
    wrap: 72
---



# Wrangling Columns in R with Select, Rename, and Relocate

In this chapter, we will introduce you ways to **wrangle** columns in R. Data **wrangling** refers broadly to the many things you might do to make disorderly data more organized and tidy. You
will often want to focus your analysis on particular **variables**,
or columns, in your dataset. This chapter will show you how to include the
columns you want, and exclude the columns you don't want. You will also learn how to rename and relocate your columns in your dataset. We will also learn some good general practices for column naming, which is often more important than people realize. The main functions in the tidyverse for doing column functions are *select(), rename(), rename_with(), and relocate()*. The *select()* function can use a number of 
logical statements, and functional helpers, to decide whether to keep or exclude rows in your dataset.

<div class="figure">
<img src="images/allison_horst_dplyr_relocate.png" alt="Artwork by Allison Horst, https://www.allisonhorst.com" width="2376" />
<p class="caption">(\#fig:unnamed-chunk-1)Artwork by Allison Horst, https://www.allisonhorst.com</p>
</div>

## Goals for this Chapter

-   Understand select statements
-   Select rows based on name and number
-   Select rows with helpers including `starts_with()`, `ends_with()`
-   Select rows with helpers including `contains()`, `matches()`
-   Relocate column variables within your dataset with `relocate`
-   Rename column variables within your dataset with `rename()` and `rename_with()`

## Packages needed for this Chapter

{tidyverse}

{janitor}

{medicaldata}

## Pathway for this Chapter

This Chapter is part of the **DATA WRANGLING** pathway. Chapters in this
pathway include

-   What is Tidy Data?
-   Selecting, Renaming, and Relocating Columns
-   Filtering Rows
-   Counting, Grouping, and Summarizing Rows
-   Arranging and Ranking Rows
-   Mutating to Make New Variables
-   Rearranging Untidy data with {tidyr} and {pivotr}

## Tidyselect Helpers in R

Tidyselect helpers in R are functions that help you select a specfic group of columns. A typical tidyselect helper function defines which variables match your criteria. <br>
Typical examples of tidyselect helper functions include:

-   **starts_with**("preop") - matches preop_bp, preop_hr, preop_psa

-   **ends_with**("pain") - matches abd_pain, extremity_pain, wound_pain

-   **contains**("bp") - matches bp_screening, end_bp, first_bp_am

-   **matches**("week[0-9]") - matches week4, week8, week0

-   **everything**() - all columns

-   **last_col**() - the last column

-   **num_range**("wk", 1:6) - matches wk1, wk3, wk6, but not wk7

-   **where**(is.numeric) - selects variables of numeric type

    Each of these examples of logical tests will each column in your dataframe with the
    included argument - the criteria within the parentheses, and results in a vector of TRUE or FALSE values for each column (variable) of the dataframe. The *select()* function will act on these TRUE and FALSE values to *include* (TRUE) or *exclude* (FALSE) the column variables from the resulting dataframe.

## Selecting a Column Variables 

The general format for *select* statements is:

`select(variable1, variable_name3:variable_name17, variable55)`, <br>which selects by name the first variable, the 3rd through the 17th, and the 55th variable (you use just the variable names, the numbers are just to illustrate how to use the colon operator), and drops the rest.

You can also **negatively** select against variables, with the negative sign, as in

`select(-sbp, -hr)`

These logical statements can even be sequential within a select() function, to help clarify selections, as in when you want "age" but not "stage".

`select(contains("age"), -stage)`

You can also select variables by their column number, (though this can get ugly if column numbers change), as in

`select(1:5, 17:22)`

### Try this out
:::tryit
Copy the code block below to your RStudio Console, and run it to get started.

``` r
library(tidyverse)
library(medicaldata) 
medicaldata::blood_storage %>% 
  select(everything()) %>% 
  head()
```

Now replace the argument to the select statement (`everything()`) with `1:5`.

Run this - you should get **only** the first 5 columns, instead of all the columns.

Now try this with `AnyAdjTherapy:TimeToRecurrence` as the argument to get the last 5 columns.

You can use the colon operator to get any continguous group of columns between the `start:end` columns (inclusive of the start and end columns).

Experiment for yourself to get specific groups of contiguous columns.
:::

## Selecting Columns that are Not Contiguous

You can select any non-contiguous columns by inserting a comma between the columns selected. You can even select one column at a time. For example


``` r
medicaldata::blood_storage %>% 
  select(1, bGS:sGS, 3, AA) %>% 
  head()
```

```
  RBC.Age.Group bGS BN+ OrganConfined PreopPSA PreopTherapy
1             3   3   0             0    14.08            1
2             3   2   0             1    10.50            0
3             3   3   0             1     6.98            1
4             2   1   0             1     4.40            0
5             2   2   0             1    21.40            0
6             3   1   0             0     5.10            0
  Units sGS  Age AA
1     6   1 72.1  0
2     2   3 73.6  0
3     1   1 67.5  0
4     2   3 65.8  0
5     3   3 63.2  0
6     1   3 65.4  0
```

You can mix single columns, ranges of columns, column names vs. numbers, and even change the order in which the columns are listed.


:::tryit
Try this yourself, with the *cytomegalovirus* dataset. Copy the code chunk below and run it in your RStudio Console pane. Then edit it to select the ID, patient demographics, the prior treatment variables, and the dose variables.


``` r
medicaldata::cytomegalovirus %>% 
  select(everything()) %>% 
  head()
```


<div class='webex-solution'><button>Show/Hide Solution</button>


``` r
medicaldata::cytomegalovirus %>% 
  select(ID, age:race, prior.radiation:prior.transplant,
         TNC.dose:TBI.dose) %>% 
  head()
```

</div>

:::


## Selecting Columns With Logical Operators

You can select groups of columns with logical operators to combine selections. You can use

- `c()` to combine selections. An example: `select(c(age:race, prior.radiation:prior.chemo))`.
- the symbols `&` and `|` to select the intersection or the union, respectively, of two sets of variables. An example: `select(age:race & prior.radiation:prior.chemo)`.
- the `!` symbol to select the complement of a set of variables. An example: `select(!c(age:race, prior.radiation:prior.chemo))`.

:::tryit

Try this yourself, with the *esoph_ca* dataset. Copy the code chunk below and run it in your RStudio Console pane. Then edit it to select all variables **except** the ncases and ncontrols, using the `!` symbol.


``` r
  medicaldata::esoph_ca %>% 
  select(everything()) %>% 
  head()
```


<div class='webex-solution'><button>Show/Hide Solution</button>


``` r
  medicaldata::esoph_ca %>% 
  select(!ncases:ncontrols) %>% 
  head()
```

</div>


Now try editing the code chunk below to select all of the variables that are not related to dose or any kind of graft versus host disease (end in `gvhd`) in the *cytomegalovirus* dataset. Use the `!` and the `|` symbols.


``` r
medicaldata::cytomegalovirus %>% 
  select(everything()) %>% 
  head()
```


<div class='webex-solution'><button>Show/Hide Solution</button>


``` r
medicaldata::cytomegalovirus %>% 
  select(!c(TNC.dose:TBI.dose | agvhd:time.to.cgvhd)) %>% 
  head()
```

</div>

:::






::: {.challenge}
## Further Challenges

Try selecting variables on your own computer.

Install R and Rstudio, as in Chapter
\@ref(getting-started-and-installing-your-tools).

Then make sure you have the following packages installed, as in the Installing Packages chapter:

-   tidyverse

-   medicaldata

Read in data from the medicaldata datasets with data(name)

Then try some of the following challenges

-   select in the **cytomegalovirus** dataset for 

-   select in the **opt** dataset for 

-   select in the **covid_testing** dataset for 


:::

::: {.explore}
## Explore More about Filtering

Some helpful resources include:

The RYouWithMe series from RLadiesSyndey post on selecting
[here](https://rladiessydney.org/courses/ryouwithme/02-cleanitup-1/).

The tidyverse guide to selecting variables, found
[here](https://dplyr.tidyverse.org/reference/select.html).

Suzan Baert's blog series on dplyr, part 2 about wrangling columns is found
[here](https://suzan.rbind.io/2018/02/dplyr-tutorial-2/).
:::

