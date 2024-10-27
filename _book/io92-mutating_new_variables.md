---
title: "Mutating to Make New Variables/Columns"
author: "Peter Higgins"
date: "2/8/2022"
output: html_document
editor_options: 
  markdown: 
    wrap: 72
---



# Using Mutate to Make New Variables (Columns)

Many datasets, especially if you were involved in the data collection,
will have exactly the variables you need in exactly the right format and
data type. But often we import data from the electronic medical record,
a data warehouse, or the Centers for Disease Control, and the data may
not be in quite the format we want. We also want to collect the most
*granular form* of the data available, without any calculations or
interpretations by either the participant, the study coordinator, or the
investigator. For example, collecting the date of birth is more accurate
than collecting the participant age in years (which is a rounded-off
calculation). This allows us to accurately calculate the participant's
age at any particular point in time.

The `dataset` below contains data on 4 participants, with baseline
values and the dates of 2 subsequent visits. Copy this code block (with
icon in top right of the code block) and paste it into your local
RStudio instance to run it and create this temporary demonstration
dataset on your own computer.


``` r
dataset <- tibble::tribble(
 ~studyid, ~dob, ~baseline_visit, ~visit_1, ~visit_2, ~wt_kg, ~ht_m, ~sex, ~race, ~ethnicity, ~creat,
  '001', as.Date("1971-04-13"), as.Date("2021-03-01"), as.Date("2021-09-07"), as.Date("2022-03-19"), 64.2, 1.53, 1, 1, 0, 0.63,
  '002', as.Date("1983-07-19"), as.Date("2021-04-01"), as.Date("2021-10-03"), as.Date("2022-04-13"), 56.3, 1.47, 2, 6, 1, 1.32,
  '003', as.Date("1976-09-26"), as.Date("2021-04-13"), as.Date("2021-10-18"), as.Date("2022-04-22"), 84.7, 1.78, 1, 4, 0, 1.05,
  '004', as.Date("1988-02-07"), as.Date("2021-04-19"), as.Date("2021-11-22"), as.Date("2022-05-01"), 99.2, 1.88, 2, 2, 0, 1.19)
```

Below is an example of how to calculate the age at the baseline visit
(dividing the interval days by 365.25 to get years), and then relocating
this new value after the baseline visit to make it easier to find. Copy
this code and run it yourself to see the result.


``` r
dataset %>% 
  mutate(age_base_yrs = as.numeric(
    baseline_visit - dob)/365.25) %>% 
  relocate(age_base_yrs, .after = baseline_visit)
```

Some takeaway points:

\- most mutate functions to produce new variables are fairly simple
math\
- subtraction will convert dates to an interval of days\
- you can convert this interval to numeric to do more math (the
conversion to years)\
- you have to assign a name to the new variable, and set it equal to
your calculation\
- all the other variables remain in the dataset, you are just adding new
ones - by default, these new variables (columns) are placed at the end
(the far right) of your dataset\
- you can change their location to a more sensible or convenient
location with the *relocate()* function. Arguments for this function
include the variables that you want to relocate (the default is that
they are inserted the front {or far left} of your dataset), and the
**.before=** and **.after=** arguments, to help with specific column
placement).\
- You can select the variables to relocate with the usual
[tidyselect](https://dplyr.tidyverse.org/reference/dplyr_tidy_select.html)
dplyr helpers like starts_with(), where(is.numeric()), last_col(),
matches(), etc.

::: tryit
Try this yourself. Edit the code you copied above to do these
calculations. Open the `dataset` in the Environment tab to get the
correct variable names.\
Try these challenges:\
- Calculate the age at visit 2. Which participant is 45.6 years old at
visit 2?\
<select class='webex-select'><option value='blank'></option><option value=''>Participant 001</option><option value=''>Participant 002</option><option value='answer'>Participant 003</option><option value=''>Participant 004</option></select>\
- Calculate the number of days between the baseline visit and visit 1.
This gap is supposed to be 180-200 days. Which participant had a visit
outside of the study window?
<select class='webex-select'><option value='blank'></option><option value=''>Participant 001</option><option value=''>Participant 002</option><option value=''>Participant 003</option><option value='answer'>Participant 004</option></select>
:::

## Calculating BMI

Another common calculation is the calculation of body mass index. This
requires dividing the weight in kilograms by the height in meters
squared. Fortunately, our self-explanatory variable names reassure us
that we have th right units for these. Run the code chunk below to see
the raw data in the available small dataset. Now edit the code below to
create a new variable named bmi with the *mutate()* function.


``` r
dataset 
```

```
## # A tibble: 4 × 11
##   studyid dob        baseline_visit visit_1    visit_2   
##   <chr>   <date>     <date>         <date>     <date>    
## 1 001     1971-04-13 2021-03-01     2021-09-07 2022-03-19
## 2 002     1983-07-19 2021-04-01     2021-10-03 2022-04-13
## 3 003     1976-09-26 2021-04-13     2021-10-18 2022-04-22
## 4 004     1988-02-07 2021-04-19     2021-11-22 2022-05-01
## # ℹ 6 more variables: wt_kg <dbl>, ht_m <dbl>, sex <dbl>,
## #   race <dbl>, ethnicity <dbl>, creat <dbl>
```

*****


<div class='webex-solution'><button>Show/Hide the Solution</button>
 Note that `round`ing to 2 places was
added to make `bmi` look nicer, and `knitr::kable()` was used to make a
scrollable HTML table. You can use the scroll bar to move to the right
to see all of the columns.


``` r
dataset %>% 
  mutate(bmi = round(wt_kg/ht_m^2, 2)) %>% 
  relocate(bmi, .before = wt_kg) %>% 
  knitr::kable()
```



|studyid |dob        |baseline_visit |visit_1    |visit_2    |   bmi| wt_kg| ht_m| sex| race| ethnicity| creat|
|:-------|:----------|:--------------|:----------|:----------|-----:|-----:|----:|---:|----:|---------:|-----:|
|001     |1971-04-13 |2021-03-01     |2021-09-07 |2022-03-19 | 27.43|  64.2| 1.53|   1|    1|         0|  0.63|
|002     |1983-07-19 |2021-04-01     |2021-10-03 |2022-04-13 | 26.05|  56.3| 1.47|   2|    6|         1|  1.32|
|003     |1976-09-26 |2021-04-13     |2021-10-18 |2022-04-22 | 26.73|  84.7| 1.78|   1|    4|         0|  1.05|
|004     |1988-02-07 |2021-04-19     |2021-11-22 |2022-05-01 | 28.07|  99.2| 1.88|   2|    2|         0|  1.19|


</div>
 

*****

## Recoding categorical or ordinal data

Sex data and race data are often recorded as categorical data. A variety
of surveys often have response scales that are ordinal, like a happiness
scale from `0_never` to `10_always`. The categorical data responses like
`male / female` for sex have no inherent order, while the ordinal scales
clearly do. These responses are often entered/coded as numbers, which
are can be confusing, especially if there are many variables in the
codebook. It is better to make variables and values self-explaining. For
example, if male was coded as `1` and female was coded as `2`, it would
be very easy to get these reversed, or interpreted differently in
different parts of your analysis. It is better to recode these to link
the coded value to the definition, like `1_male`, and `2_female`. Then
there is no confusion about what each value means. You can still extract
the numeric values, if needed for calculations, by using the
*parse_number()* function to retrieve only the numeric value.

This recoding can be done with the *case_when()* function. The code
below takes a numeric `sex` variable and recodes it to a new `sex_cat`
variable with 2 categories, `1_male`, and `2_female`. It identifies 2
distinct cases (sex ==1 and sex ==2), and recodes the values to the
desired ones.


``` r
dataset %>% 
  mutate(sex_cat = case_when(sex == 1 ~ "1_male",
                             sex == 2 ~ "2_female"))
```

```
## # A tibble: 4 × 12
##   studyid dob        baseline_visit visit_1    visit_2   
##   <chr>   <date>     <date>         <date>     <date>    
## 1 001     1971-04-13 2021-03-01     2021-09-07 2022-03-19
## 2 002     1983-07-19 2021-04-01     2021-10-03 2022-04-13
## 3 003     1976-09-26 2021-04-13     2021-10-18 2022-04-22
## 4 004     1988-02-07 2021-04-19     2021-11-22 2022-05-01
## # ℹ 7 more variables: wt_kg <dbl>, ht_m <dbl>, sex <dbl>,
## #   race <dbl>, ethnicity <dbl>, creat <dbl>, sex_cat <chr>
```

::: warning
Note that it is very easy to get an error with the logical tests in
*case_when()* if you forget to use TWO equals signs, which are needed to
TEST for equality. You can set a variable equal to a value with one
equals sign, but to perform a logical test you will need to use 2 equals signs.
:::

::: tryit
Try this yourself. Try this challenge:

\- Recode the NIH race category from numeric to helpful self-explanatory
values. Copy the code block above to use as a starting point. Use:\
- 1_white\
- 2_black\
- 3_asian\
- 4_pacific_islander\
- 5_native_american\
- 6_more_than_one_race\
to recode these numeric values into self-explanatory values
:::

*****


<div class='webex-solution'><button>Show/Hide the Solution</button>
 
Note that `flextable::flextable()`
was used to make a pretty HTML table. You can use the scroll bar to move
to the right to see all of the columns. Both kable (via kableExtra) and
flextable have lots of formatting options for fonts, size, colors,
alignment, etc.


``` r
dataset %>% 
  mutate(race = case_when(race == 1 ~ "1_white",
                          race == 2 ~ "2_black",
                          race == 3 ~ "3_asian",
                          race == 4 ~ "4_pacific_islander",
                          race == 5 ~ "5_native_american",
                          race == 6 ~ "6_more_than_one_race")) %>% 
  flextable::flextable()
```

```{=html}
<div class="tabwid"><style>.cl-a40dae16{}.cl-a40a5d56{font-family:'Helvetica';font-size:11pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-a40bb138{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-a40bb142{margin:0;text-align:right;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-a40bbf48{width:0.75in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 1.5pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-a40bbf52{width:0.75in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 1.5pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-a40bbf53{width:0.75in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-a40bbf54{width:0.75in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-a40bbf5c{width:0.75in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-a40bbf5d{width:0.75in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}</style><table data-quarto-disable-processing='true' class='cl-a40dae16'><thead><tr style="overflow-wrap:break-word;"><th class="cl-a40bbf48"><p class="cl-a40bb138"><span class="cl-a40a5d56">studyid</span></p></th><th class="cl-a40bbf52"><p class="cl-a40bb142"><span class="cl-a40a5d56">dob</span></p></th><th class="cl-a40bbf52"><p class="cl-a40bb142"><span class="cl-a40a5d56">baseline_visit</span></p></th><th class="cl-a40bbf52"><p class="cl-a40bb142"><span class="cl-a40a5d56">visit_1</span></p></th><th class="cl-a40bbf52"><p class="cl-a40bb142"><span class="cl-a40a5d56">visit_2</span></p></th><th class="cl-a40bbf52"><p class="cl-a40bb142"><span class="cl-a40a5d56">wt_kg</span></p></th><th class="cl-a40bbf52"><p class="cl-a40bb142"><span class="cl-a40a5d56">ht_m</span></p></th><th class="cl-a40bbf52"><p class="cl-a40bb142"><span class="cl-a40a5d56">sex</span></p></th><th class="cl-a40bbf48"><p class="cl-a40bb138"><span class="cl-a40a5d56">race</span></p></th><th class="cl-a40bbf52"><p class="cl-a40bb142"><span class="cl-a40a5d56">ethnicity</span></p></th><th class="cl-a40bbf52"><p class="cl-a40bb142"><span class="cl-a40a5d56">creat</span></p></th></tr></thead><tbody><tr style="overflow-wrap:break-word;"><td class="cl-a40bbf53"><p class="cl-a40bb138"><span class="cl-a40a5d56">001</span></p></td><td class="cl-a40bbf54"><p class="cl-a40bb142"><span class="cl-a40a5d56">1971-04-13</span></p></td><td class="cl-a40bbf54"><p class="cl-a40bb142"><span class="cl-a40a5d56">2021-03-01</span></p></td><td class="cl-a40bbf54"><p class="cl-a40bb142"><span class="cl-a40a5d56">2021-09-07</span></p></td><td class="cl-a40bbf54"><p class="cl-a40bb142"><span class="cl-a40a5d56">2022-03-19</span></p></td><td class="cl-a40bbf54"><p class="cl-a40bb142"><span class="cl-a40a5d56">64.2</span></p></td><td class="cl-a40bbf54"><p class="cl-a40bb142"><span class="cl-a40a5d56">1.53</span></p></td><td class="cl-a40bbf54"><p class="cl-a40bb142"><span class="cl-a40a5d56">1</span></p></td><td class="cl-a40bbf53"><p class="cl-a40bb138"><span class="cl-a40a5d56">1_white</span></p></td><td class="cl-a40bbf54"><p class="cl-a40bb142"><span class="cl-a40a5d56">0</span></p></td><td class="cl-a40bbf54"><p class="cl-a40bb142"><span class="cl-a40a5d56">0.63</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-a40bbf53"><p class="cl-a40bb138"><span class="cl-a40a5d56">002</span></p></td><td class="cl-a40bbf54"><p class="cl-a40bb142"><span class="cl-a40a5d56">1983-07-19</span></p></td><td class="cl-a40bbf54"><p class="cl-a40bb142"><span class="cl-a40a5d56">2021-04-01</span></p></td><td class="cl-a40bbf54"><p class="cl-a40bb142"><span class="cl-a40a5d56">2021-10-03</span></p></td><td class="cl-a40bbf54"><p class="cl-a40bb142"><span class="cl-a40a5d56">2022-04-13</span></p></td><td class="cl-a40bbf54"><p class="cl-a40bb142"><span class="cl-a40a5d56">56.3</span></p></td><td class="cl-a40bbf54"><p class="cl-a40bb142"><span class="cl-a40a5d56">1.47</span></p></td><td class="cl-a40bbf54"><p class="cl-a40bb142"><span class="cl-a40a5d56">2</span></p></td><td class="cl-a40bbf53"><p class="cl-a40bb138"><span class="cl-a40a5d56">6_more_than_one_race</span></p></td><td class="cl-a40bbf54"><p class="cl-a40bb142"><span class="cl-a40a5d56">1</span></p></td><td class="cl-a40bbf54"><p class="cl-a40bb142"><span class="cl-a40a5d56">1.32</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-a40bbf53"><p class="cl-a40bb138"><span class="cl-a40a5d56">003</span></p></td><td class="cl-a40bbf54"><p class="cl-a40bb142"><span class="cl-a40a5d56">1976-09-26</span></p></td><td class="cl-a40bbf54"><p class="cl-a40bb142"><span class="cl-a40a5d56">2021-04-13</span></p></td><td class="cl-a40bbf54"><p class="cl-a40bb142"><span class="cl-a40a5d56">2021-10-18</span></p></td><td class="cl-a40bbf54"><p class="cl-a40bb142"><span class="cl-a40a5d56">2022-04-22</span></p></td><td class="cl-a40bbf54"><p class="cl-a40bb142"><span class="cl-a40a5d56">84.7</span></p></td><td class="cl-a40bbf54"><p class="cl-a40bb142"><span class="cl-a40a5d56">1.78</span></p></td><td class="cl-a40bbf54"><p class="cl-a40bb142"><span class="cl-a40a5d56">1</span></p></td><td class="cl-a40bbf53"><p class="cl-a40bb138"><span class="cl-a40a5d56">4_pacific_islander</span></p></td><td class="cl-a40bbf54"><p class="cl-a40bb142"><span class="cl-a40a5d56">0</span></p></td><td class="cl-a40bbf54"><p class="cl-a40bb142"><span class="cl-a40a5d56">1.05</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-a40bbf5c"><p class="cl-a40bb138"><span class="cl-a40a5d56">004</span></p></td><td class="cl-a40bbf5d"><p class="cl-a40bb142"><span class="cl-a40a5d56">1988-02-07</span></p></td><td class="cl-a40bbf5d"><p class="cl-a40bb142"><span class="cl-a40a5d56">2021-04-19</span></p></td><td class="cl-a40bbf5d"><p class="cl-a40bb142"><span class="cl-a40a5d56">2021-11-22</span></p></td><td class="cl-a40bbf5d"><p class="cl-a40bb142"><span class="cl-a40a5d56">2022-05-01</span></p></td><td class="cl-a40bbf5d"><p class="cl-a40bb142"><span class="cl-a40a5d56">99.2</span></p></td><td class="cl-a40bbf5d"><p class="cl-a40bb142"><span class="cl-a40a5d56">1.88</span></p></td><td class="cl-a40bbf5d"><p class="cl-a40bb142"><span class="cl-a40a5d56">2</span></p></td><td class="cl-a40bbf5c"><p class="cl-a40bb138"><span class="cl-a40a5d56">2_black</span></p></td><td class="cl-a40bbf5d"><p class="cl-a40bb142"><span class="cl-a40a5d56">0</span></p></td><td class="cl-a40bbf5d"><p class="cl-a40bb142"><span class="cl-a40a5d56">1.19</span></p></td></tr></tbody></table></div>
```


</div>
 

*****


## Calculating Glomerular Filtration Rate

A typical, but more complicated kind of mutation calculation is the
calculation of GFR. This estimate of renal function is affected by sex,
serum creatinine (sCr) level, and age, using the 2021 CKD-EPI Creatinine
equations.

These can be summarized as 2021 CKD-EPI Creatinine = 142 x (Scr/A)\^B x
0.9938\^age x (1.012 if female), where A and B are the following:

+-----------+-----------+-----------+-----------+
| Female    |           | Male      |           |
+===========+===========+===========+===========+
| Scr \<=   | *A* = 0.7 | Scr \<=   | *A* = 0.9 |
| 0.7       |           | 0.9       |           |
|           | *B* =     |           | *B* =     |
|           | -0.241    |           | -0.302    |
+-----------+-----------+-----------+-----------+
| Scr \>    | A = 0.7   | Scr \>    | *A* = 0.9 |
| 0.7       |           | 0.9       |           |
|           | B = -1.2  |           | *B* =     |
|           |           |           | -1.2      |
+-----------+-----------+-----------+-----------+

which works out to 4 distinct equations.

The four equations are listed here in R format to help you out.

+----------------------+-----------------------------------------------+
| Case                 | Equation                                      |
+======================+===============================================+
| Female, low          | 142 \* (creat/0.7)\^-0.241 \* 0.9938\^age \*     |
| Creatinine           | 1.012                                         |
+----------------------+-----------------------------------------------+
| Female, high         | 142 \* (creat/0.7)\^-1.200 \* 0.9938\^age \*     |
| Creatinine           | 1.012                                         |
+----------------------+-----------------------------------------------+
| Male, low Creatinine | 142 \* (creat/0.7)\^-0.302 \* 0.9938\^age        |
+----------------------+-----------------------------------------------+
| Male, high           | 142 \* (creat/0.7)\^-1.200 \* 0.9938\^age        |
| Creatinine           |                                               |
+----------------------+-----------------------------------------------+

: 2021 CKD-EPI Equations for GFR

::: tryit
Try this yourself. <br>
Try this challenge in your local version of RStudio:

- Use mutate and case_when to calculate gfr for each of the four cases with each equation.
- Note that you have to calculate (baseline) age first, in order to use it as a variable in the gfr calculation.
- Relocate creat, sex, age, and gfr to a location right after the studyid.

*****

<div class='webex-solution'><button>Show/Hide the Solution</button>
 

``` r
dataset %>%
  mutate(age = as.numeric((baseline_visit - dob)/365.25)) %>% 
  mutate(gfr = case_when(
    sex == 2 & creat <= 0.7 ~ 142 * (creat/0.7)^-0.241 * 0.9938^age * 1.012,
    sex == 2 & creat > 0.7 ~ 142 * (creat/0.7)^-1.200 * 0.9938^age * 1.012,
    sex == 1 & creat <= 0.9 ~ 142 * (creat/0.7)^-0.302 * 0.9938^age,
    sex == 1 & creat > 0.9 ~ 142 * (creat/0.7)^-1.200 * 0.9938^age
  )) %>% 
  relocate(creat, sex, age, gfr, .after = studyid) 
```

```
## # A tibble: 4 × 13
##   studyid creat   sex   age   gfr dob        baseline_visit
##   <chr>   <dbl> <dbl> <dbl> <dbl> <date>     <date>        
## 1 001      0.63     1  49.9 107.  1971-04-13 2021-03-01    
## 2 002      1.32     2  37.7  53.1 1983-07-19 2021-04-01    
## 3 003      1.05     1  44.5  66.2 1976-09-26 2021-04-13    
## 4 004      1.19     2  33.2  61.8 1988-02-07 2021-04-19    
## # ℹ 6 more variables: visit_1 <date>, visit_2 <date>,
## #   wt_kg <dbl>, ht_m <dbl>, race <dbl>, ethnicity <dbl>
```


</div>
 
*****

:::
