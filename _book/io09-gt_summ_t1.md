---
title: "Building Your Table One with the {gtsummary} Package"
author: "Peter Higgins"
output: html_document
editor_options: 
  markdown: 
    wrap: 72
---



# Building Your Table One with the {gtsummary} Package

  Table One is a standard table in most clinical studies, where the sample of the
participants studied is described. This table is often used to provide the 
demographics and distributions of patient characteristics, to enable reviewers and
readers to determine whether the study sample is representative of the population
that they see in their clinical practice, and whether the results are generalizable
to their patients. <br>
<br>
  This is important because the vast majority of clinical trials are extreme 
examples of a convenience sample, as many potential participants will not meet
the inclusion and exclusion criteria, and far fewer of the eligible people will
be willing to consent and enroll. This means that the study sample is often not
representative of the population of people with the particular disease state 
under study. <br>
<br>
  In order to help the reader, we generally provide the mean and standard deviation
of numeric variables like age and weight/BMI, and the counts and percentages of categorical
variables like sex and disease location. If particular numeric variables are 
quite skewed, like hospital length of stay or medical costs, we will often use
the median and interquartile range instead of the mean and standard deviation.<br>
<br>
  In this chapter, we will use the {gtsummary} package to build a Table One. 
This package is a powerful tool for making tables in R, and is especially useful 
for clinical research, which it was designed for. It is built on top of the {gt}
package, which is a modern and flexible package for building
and formatting tables in R. 

The {gtsummary} package is designed to make it easy to make a Table One, and to 
customize it to your needs.
You can use the tools from {gt} to format the table, or convert the table to 
another format like {flextable}, and use the formatting tools from that package 
if you prefer to format your table.


## Using tbl_summary() from the gtsummary package

The {gtsummary} package uses the `tbl_summary()` function to make a Table One. 
But you can do a lot with the options to customize this basic table. 
Let's start with a clinical trial dataset, and use it to make a basic demographics 
table. Run the code below to see the data in two different ways. 
These data are from a simple hypothetical chemotherapy trial built into {gtsummary}.


``` r
head(trial)
```

```
# A tibble: 6 × 8
  trt      age marker stage grade response death ttdeath
  <chr>  <dbl>  <dbl> <fct> <fct>    <int> <int>   <dbl>
1 Drug A    23  0.16  T1    II           0     0    24  
2 Drug B     9  1.11  T2    I            1     0    24  
3 Drug A    31  0.277 T1    II           0     0    24  
4 Drug A    NA  2.07  T3    III          1     1    17.6
5 Drug A    51  2.77  T4    III          1     1    16.4
6 Drug B    39  0.613 T4    I            0     1    15.6
```

``` r
glimpse(trial)
```

```
Rows: 200
Columns: 8
$ trt      <chr> "Drug A", "Drug B", "Drug A", "Drug A", "Drug A", "Drug B", "…
$ age      <dbl> 23, 9, 31, NA, 51, 39, 37, 32, 31, 34, 42, 63, 54, 21, 48, 71…
$ marker   <dbl> 0.160, 1.107, 0.277, 2.067, 2.767, 0.613, 0.354, 1.739, 0.144…
$ stage    <fct> T1, T2, T1, T3, T4, T4, T1, T1, T1, T3, T1, T3, T4, T4, T1, T…
$ grade    <fct> II, I, II, III, III, I, II, I, II, I, III, I, III, I, I, III,…
$ response <int> 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0…
$ death    <int> 0, 0, 0, 1, 1, 1, 0, 1, 0, 1, 0, 0, 1, 1, 1, 1, 0, 1, 0, 0, 0…
$ ttdeath  <dbl> 24.00, 24.00, 24.00, 17.64, 16.43, 15.64, 24.00, 18.43, 24.00…
```

We can see from this output that patients at different cancer stages and grades 
are included in the trial, and that the treatment is either Drug A
or Drug B. There are dichotomous variables for response and death and a continuous
variable for time to death in months.

You can load the {tidyverse}, {gt}, and {gtsummary} packages in your local 
RStudio session to get started.

Run `View(trial)` to see the raw trial data in a spreadsheet-like format. Note 
the variable labels.

## Making a Basic table

You can use the `tbl_summary` function to get started with your first Table One. 
Copy and run the code below in your local RStudio session as a  first step. 
Take a look at the HTML 
output in the Viewer tab on the lower right. 
Then add more variables to the `include` statement to get a more complete 
demographics table. Try adding cancer stage (stage) and grade. See 
how the function (automatically) handles categorical vs. continuous variables.
Note that there are 11 missing age values. The function will by default 
include missing values in the table.



``` r
library(gt)
library(gtsummary)
library(tidyverse, quietly = TRUE)
trial %>% 
  tbl_summary(include = c(age, trt),
              statistic = list(all_categorical() ~ "n = {n}"),
              digits = all_continuous() ~ 0)
```

```{=html}
<div id="ywbokqvohu" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#ywbokqvohu table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#ywbokqvohu thead, #ywbokqvohu tbody, #ywbokqvohu tfoot, #ywbokqvohu tr, #ywbokqvohu td, #ywbokqvohu th {
  border-style: none;
}

#ywbokqvohu p {
  margin: 0;
  padding: 0;
}

#ywbokqvohu .gt_table {
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

#ywbokqvohu .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#ywbokqvohu .gt_title {
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

#ywbokqvohu .gt_subtitle {
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

#ywbokqvohu .gt_heading {
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

#ywbokqvohu .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ywbokqvohu .gt_col_headings {
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

#ywbokqvohu .gt_col_heading {
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

#ywbokqvohu .gt_column_spanner_outer {
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

#ywbokqvohu .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#ywbokqvohu .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#ywbokqvohu .gt_column_spanner {
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

#ywbokqvohu .gt_spanner_row {
  border-bottom-style: hidden;
}

#ywbokqvohu .gt_group_heading {
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

#ywbokqvohu .gt_empty_group_heading {
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

#ywbokqvohu .gt_from_md > :first-child {
  margin-top: 0;
}

#ywbokqvohu .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ywbokqvohu .gt_row {
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

#ywbokqvohu .gt_stub {
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

#ywbokqvohu .gt_stub_row_group {
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

#ywbokqvohu .gt_row_group_first td {
  border-top-width: 2px;
}

#ywbokqvohu .gt_row_group_first th {
  border-top-width: 2px;
}

#ywbokqvohu .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ywbokqvohu .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#ywbokqvohu .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#ywbokqvohu .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ywbokqvohu .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ywbokqvohu .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#ywbokqvohu .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#ywbokqvohu .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#ywbokqvohu .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ywbokqvohu .gt_footnotes {
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

#ywbokqvohu .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ywbokqvohu .gt_sourcenotes {
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

#ywbokqvohu .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ywbokqvohu .gt_left {
  text-align: left;
}

#ywbokqvohu .gt_center {
  text-align: center;
}

#ywbokqvohu .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ywbokqvohu .gt_font_normal {
  font-weight: normal;
}

#ywbokqvohu .gt_font_bold {
  font-weight: bold;
}

#ywbokqvohu .gt_font_italic {
  font-style: italic;
}

#ywbokqvohu .gt_super {
  font-size: 65%;
}

#ywbokqvohu .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#ywbokqvohu .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#ywbokqvohu .gt_indent_1 {
  text-indent: 5px;
}

#ywbokqvohu .gt_indent_2 {
  text-indent: 10px;
}

#ywbokqvohu .gt_indent_3 {
  text-indent: 15px;
}

#ywbokqvohu .gt_indent_4 {
  text-indent: 20px;
}

#ywbokqvohu .gt_indent_5 {
  text-indent: 25px;
}

#ywbokqvohu .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#ywbokqvohu div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Characteristic</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_0"><span class='gt_from_md'><strong>N = 200</strong></span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left">Age</td>
<td headers="stat_0" class="gt_row gt_center">47 (38, 57)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Unknown</td>
<td headers="stat_0" class="gt_row gt_center">11</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Chemotherapy Treatment</td>
<td headers="stat_0" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Drug A</td>
<td headers="stat_0" class="gt_row gt_center">n = 98</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Drug B</td>
<td headers="stat_0" class="gt_row gt_center">n = 102</td></tr>
  </tbody>
  
  <tfoot class="gt_footnotes">
    <tr>
      <td class="gt_footnote" colspan="2"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span> <span class='gt_from_md'>Median (Q1, Q3); n = n</span></td>
    </tr>
  </tfoot>
</table>
</div>
```

Note that we formatted the categorical variables to show the count of each level,
with `n = {n}`, and we set the number of digits for continuous variables to 0.
This is a good starting point for a Table One, but we can do much more with
the `tbl_summary` function.

:::tryit

### Challenges:

1.  Run `help("tbl_summary")` in your local RStudio console. Read the help file, and figure out what each argument does in the function. 
2. Also take a look at the [tutorial online](https://www.danieldsjoberg.com/gtsummary/articles/tbl_summary.html). Click
through this link to see the tutorial on the `{gtsummary} package`tbl_summary()` 
function.
3.  How can you tell the function when a variable should be continuous vs 
categorical vs dichotomous? Set age to continuous.
4.  How do you control the number of digits in a mean or sd? Try setting age
(or all_continous) to 2 digits.
5.  How do you set mean/sd vs median/IQR for a particular variable? (make age 
a mean/SD)
6.  Why does the treatment (when you add this variable) print out as 
Chemotherapy Treatment instead of `trt`? (check the `View` function)
7.  How can you change the label for a given variable? Try changing the T 
stage to `Tumor Stage`. 
8. How can you change the label for a given value (of a categorical variable)? Try changing the drug 
names to Axitinib (A) and Bleomycin (B). NOTE: this requires a `mutate/case_when` 
in the data pipeline BEFORE you call the tbl_summary function.
9. Remove the `n=` from the categorical variables.
10. Change the missing_text `Unknown` to "Missing" for the missing values in age.

Take a few minutes to do these challenges (lean on the tutorial for help), then 
peek at the solution below.

:::


<div class='webex-solution'><button>Solution</button>



``` r
trial %>% 
  mutate(trt = case_when(trt == "Drug A" ~ "Axitinib",
                          trt == "Drug B" ~ "Bleomycin")) %>%
  tbl_summary(include = c(age, trt, stage, grade),
              statistic = list(all_categorical() ~ "{n}",
                               all_continuous() ~ "{mean} ({sd})"),
              digits = all_continuous() ~ 2,
              label = list(trt ~ "Chemotherapy Treatment",
                           stage ~ "Tumor Stage",
                           grade ~ "Tumor Grade"),
              missing_text = "Missing")
```

```{=html}
<div id="gikrqshbxh" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#gikrqshbxh table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#gikrqshbxh thead, #gikrqshbxh tbody, #gikrqshbxh tfoot, #gikrqshbxh tr, #gikrqshbxh td, #gikrqshbxh th {
  border-style: none;
}

#gikrqshbxh p {
  margin: 0;
  padding: 0;
}

#gikrqshbxh .gt_table {
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

#gikrqshbxh .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#gikrqshbxh .gt_title {
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

#gikrqshbxh .gt_subtitle {
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

#gikrqshbxh .gt_heading {
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

#gikrqshbxh .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#gikrqshbxh .gt_col_headings {
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

#gikrqshbxh .gt_col_heading {
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

#gikrqshbxh .gt_column_spanner_outer {
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

#gikrqshbxh .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#gikrqshbxh .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#gikrqshbxh .gt_column_spanner {
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

#gikrqshbxh .gt_spanner_row {
  border-bottom-style: hidden;
}

#gikrqshbxh .gt_group_heading {
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

#gikrqshbxh .gt_empty_group_heading {
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

#gikrqshbxh .gt_from_md > :first-child {
  margin-top: 0;
}

#gikrqshbxh .gt_from_md > :last-child {
  margin-bottom: 0;
}

#gikrqshbxh .gt_row {
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

#gikrqshbxh .gt_stub {
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

#gikrqshbxh .gt_stub_row_group {
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

#gikrqshbxh .gt_row_group_first td {
  border-top-width: 2px;
}

#gikrqshbxh .gt_row_group_first th {
  border-top-width: 2px;
}

#gikrqshbxh .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#gikrqshbxh .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#gikrqshbxh .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#gikrqshbxh .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#gikrqshbxh .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#gikrqshbxh .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#gikrqshbxh .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#gikrqshbxh .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#gikrqshbxh .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#gikrqshbxh .gt_footnotes {
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

#gikrqshbxh .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#gikrqshbxh .gt_sourcenotes {
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

#gikrqshbxh .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#gikrqshbxh .gt_left {
  text-align: left;
}

#gikrqshbxh .gt_center {
  text-align: center;
}

#gikrqshbxh .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#gikrqshbxh .gt_font_normal {
  font-weight: normal;
}

#gikrqshbxh .gt_font_bold {
  font-weight: bold;
}

#gikrqshbxh .gt_font_italic {
  font-style: italic;
}

#gikrqshbxh .gt_super {
  font-size: 65%;
}

#gikrqshbxh .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#gikrqshbxh .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#gikrqshbxh .gt_indent_1 {
  text-indent: 5px;
}

#gikrqshbxh .gt_indent_2 {
  text-indent: 10px;
}

#gikrqshbxh .gt_indent_3 {
  text-indent: 15px;
}

#gikrqshbxh .gt_indent_4 {
  text-indent: 20px;
}

#gikrqshbxh .gt_indent_5 {
  text-indent: 25px;
}

#gikrqshbxh .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#gikrqshbxh div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Characteristic</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_0"><span class='gt_from_md'><strong>N = 200</strong></span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left">Age</td>
<td headers="stat_0" class="gt_row gt_center">47.24 (14.31)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Missing</td>
<td headers="stat_0" class="gt_row gt_center">11</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Chemotherapy Treatment</td>
<td headers="stat_0" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Axitinib</td>
<td headers="stat_0" class="gt_row gt_center">98</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Bleomycin</td>
<td headers="stat_0" class="gt_row gt_center">102</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Tumor Stage</td>
<td headers="stat_0" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    T1</td>
<td headers="stat_0" class="gt_row gt_center">53</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    T2</td>
<td headers="stat_0" class="gt_row gt_center">54</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    T3</td>
<td headers="stat_0" class="gt_row gt_center">43</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    T4</td>
<td headers="stat_0" class="gt_row gt_center">50</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Tumor Grade</td>
<td headers="stat_0" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    I</td>
<td headers="stat_0" class="gt_row gt_center">68</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    II</td>
<td headers="stat_0" class="gt_row gt_center">68</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    III</td>
<td headers="stat_0" class="gt_row gt_center">64</td></tr>
  </tbody>
  
  <tfoot class="gt_footnotes">
    <tr>
      <td class="gt_footnote" colspan="2"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span> <span class='gt_from_md'>Mean (SD); n</span></td>
    </tr>
  </tfoot>
</table>
</div>
```



</div>



## Multiple Dimensions

Now for your next challenge - rather than just having one column, let's help the reader compare the demographics of the two treatment arms with a `by` argument within `tbl_summary()`. Copy and edit the code below to produce separate columns for each treatment arm. 
Note that when you are using `trt` as the `by` variable for columns, it can not 
be included in the `include`argument to make the rows,
and it can not be in the list of labels to be modified.
Note also that we added percentages (in parentheses) to the categorical levels.
(how would you remove the parentheses and use a forward slash to separate the N 
from the percentage?)
Copy and run the code below to see the result.


``` r
trial %>% 
  mutate(trt = case_when(trt == "Drug A" ~ "Axitinib",
                          trt == "Drug B" ~ "Bleomycin")) %>%
  tbl_summary(by = trt,
              include = c(age, stage, grade),
                        statistic = list(all_categorical() ~ "{n} ({p}%)",
                               all_continuous() ~ "{mean} ({sd})"),
                        digits = all_continuous() ~ 2,
                        label = list(stage ~ "Tumor Stage",
                           grade ~ "Tumor Grade"),
                        missing_text = "Missing") 
```

```{=html}
<div id="nguoafdwgf" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#nguoafdwgf table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#nguoafdwgf thead, #nguoafdwgf tbody, #nguoafdwgf tfoot, #nguoafdwgf tr, #nguoafdwgf td, #nguoafdwgf th {
  border-style: none;
}

#nguoafdwgf p {
  margin: 0;
  padding: 0;
}

#nguoafdwgf .gt_table {
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

#nguoafdwgf .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#nguoafdwgf .gt_title {
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

#nguoafdwgf .gt_subtitle {
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

#nguoafdwgf .gt_heading {
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

#nguoafdwgf .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#nguoafdwgf .gt_col_headings {
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

#nguoafdwgf .gt_col_heading {
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

#nguoafdwgf .gt_column_spanner_outer {
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

#nguoafdwgf .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#nguoafdwgf .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#nguoafdwgf .gt_column_spanner {
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

#nguoafdwgf .gt_spanner_row {
  border-bottom-style: hidden;
}

#nguoafdwgf .gt_group_heading {
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

#nguoafdwgf .gt_empty_group_heading {
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

#nguoafdwgf .gt_from_md > :first-child {
  margin-top: 0;
}

#nguoafdwgf .gt_from_md > :last-child {
  margin-bottom: 0;
}

#nguoafdwgf .gt_row {
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

#nguoafdwgf .gt_stub {
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

#nguoafdwgf .gt_stub_row_group {
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

#nguoafdwgf .gt_row_group_first td {
  border-top-width: 2px;
}

#nguoafdwgf .gt_row_group_first th {
  border-top-width: 2px;
}

#nguoafdwgf .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#nguoafdwgf .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#nguoafdwgf .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#nguoafdwgf .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#nguoafdwgf .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#nguoafdwgf .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#nguoafdwgf .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#nguoafdwgf .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#nguoafdwgf .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#nguoafdwgf .gt_footnotes {
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

#nguoafdwgf .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#nguoafdwgf .gt_sourcenotes {
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

#nguoafdwgf .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#nguoafdwgf .gt_left {
  text-align: left;
}

#nguoafdwgf .gt_center {
  text-align: center;
}

#nguoafdwgf .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#nguoafdwgf .gt_font_normal {
  font-weight: normal;
}

#nguoafdwgf .gt_font_bold {
  font-weight: bold;
}

#nguoafdwgf .gt_font_italic {
  font-style: italic;
}

#nguoafdwgf .gt_super {
  font-size: 65%;
}

#nguoafdwgf .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#nguoafdwgf .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#nguoafdwgf .gt_indent_1 {
  text-indent: 5px;
}

#nguoafdwgf .gt_indent_2 {
  text-indent: 10px;
}

#nguoafdwgf .gt_indent_3 {
  text-indent: 15px;
}

#nguoafdwgf .gt_indent_4 {
  text-indent: 20px;
}

#nguoafdwgf .gt_indent_5 {
  text-indent: 25px;
}

#nguoafdwgf .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#nguoafdwgf div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Characteristic</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_1"><span class='gt_from_md'><strong>Axitinib</strong><br />
N = 98</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_2"><span class='gt_from_md'><strong>Bleomycin</strong><br />
N = 102</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left">Age</td>
<td headers="stat_1" class="gt_row gt_center">47.01 (14.71)</td>
<td headers="stat_2" class="gt_row gt_center">47.45 (14.01)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Missing</td>
<td headers="stat_1" class="gt_row gt_center">7</td>
<td headers="stat_2" class="gt_row gt_center">4</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Tumor Stage</td>
<td headers="stat_1" class="gt_row gt_center"><br /></td>
<td headers="stat_2" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    T1</td>
<td headers="stat_1" class="gt_row gt_center">28 (29%)</td>
<td headers="stat_2" class="gt_row gt_center">25 (25%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    T2</td>
<td headers="stat_1" class="gt_row gt_center">25 (26%)</td>
<td headers="stat_2" class="gt_row gt_center">29 (28%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    T3</td>
<td headers="stat_1" class="gt_row gt_center">22 (22%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (21%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    T4</td>
<td headers="stat_1" class="gt_row gt_center">23 (23%)</td>
<td headers="stat_2" class="gt_row gt_center">27 (26%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Tumor Grade</td>
<td headers="stat_1" class="gt_row gt_center"><br /></td>
<td headers="stat_2" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    I</td>
<td headers="stat_1" class="gt_row gt_center">35 (36%)</td>
<td headers="stat_2" class="gt_row gt_center">33 (32%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    II</td>
<td headers="stat_1" class="gt_row gt_center">32 (33%)</td>
<td headers="stat_2" class="gt_row gt_center">36 (35%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    III</td>
<td headers="stat_1" class="gt_row gt_center">31 (32%)</td>
<td headers="stat_2" class="gt_row gt_center">33 (32%)</td></tr>
  </tbody>
  
  <tfoot class="gt_footnotes">
    <tr>
      <td class="gt_footnote" colspan="3"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span> <span class='gt_from_md'>Mean (SD); n (%)</span></td>
    </tr>
  </tfoot>
</table>
</div>
```

:::tryit

## New Challenges

Now for your next challenges (lean on the `tbl_summary` tutorial on the website):

1.  Change the label for grade to "Tumor Badness Scale"
2.  Change the label for stage to "Tumor Extent"
3. Set all continuous variables to 3 digits
4.  Set a Spanning Header (using a modify function) over the Drug columns with the
label of "**Treatment Arm**" (note that the names of the columns are actually 
"stat1" and "stat2"). What do the asterisks do? What happens if you remove 
them?)
5.  Make the labels bold (note that this is a new function, 
not an argument for `tbl_summary()`)
6.  Make the levels italicized

Take a few minutes to do these challenges, then peek at the solution below.
:::



<div class='webex-solution'><button>Solution</button>



``` r
trial %>% 
  mutate(trt = case_when(trt == "Drug A" ~ "Axitinib",
                          trt == "Drug B" ~ "Bleomycin")) %>%
  tbl_summary(by = trt,
              include = c(age, trt, stage, grade),
              statistic = list(all_categorical() ~ "{n} ({p}%)",
                               all_continuous() ~ "{mean} ({sd})"),
              digits = all_continuous() ~ 3,
              label = list(stage ~ "Tumor Extent",
                           grade ~ "Tumor Badness Scale"),
              missing_text = "Missing") %>%
              modify_spanning_header(all_stat_cols() ~ "**Treatment Arm**") |> 
              italicize_levels() %>%
              bold_labels()
```

```{=html}
<div id="rxmpipmway" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#rxmpipmway table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#rxmpipmway thead, #rxmpipmway tbody, #rxmpipmway tfoot, #rxmpipmway tr, #rxmpipmway td, #rxmpipmway th {
  border-style: none;
}

#rxmpipmway p {
  margin: 0;
  padding: 0;
}

#rxmpipmway .gt_table {
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

#rxmpipmway .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#rxmpipmway .gt_title {
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

#rxmpipmway .gt_subtitle {
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

#rxmpipmway .gt_heading {
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

#rxmpipmway .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#rxmpipmway .gt_col_headings {
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

#rxmpipmway .gt_col_heading {
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

#rxmpipmway .gt_column_spanner_outer {
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

#rxmpipmway .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#rxmpipmway .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#rxmpipmway .gt_column_spanner {
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

#rxmpipmway .gt_spanner_row {
  border-bottom-style: hidden;
}

#rxmpipmway .gt_group_heading {
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

#rxmpipmway .gt_empty_group_heading {
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

#rxmpipmway .gt_from_md > :first-child {
  margin-top: 0;
}

#rxmpipmway .gt_from_md > :last-child {
  margin-bottom: 0;
}

#rxmpipmway .gt_row {
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

#rxmpipmway .gt_stub {
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

#rxmpipmway .gt_stub_row_group {
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

#rxmpipmway .gt_row_group_first td {
  border-top-width: 2px;
}

#rxmpipmway .gt_row_group_first th {
  border-top-width: 2px;
}

#rxmpipmway .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#rxmpipmway .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#rxmpipmway .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#rxmpipmway .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#rxmpipmway .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#rxmpipmway .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#rxmpipmway .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#rxmpipmway .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#rxmpipmway .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#rxmpipmway .gt_footnotes {
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

#rxmpipmway .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#rxmpipmway .gt_sourcenotes {
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

#rxmpipmway .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#rxmpipmway .gt_left {
  text-align: left;
}

#rxmpipmway .gt_center {
  text-align: center;
}

#rxmpipmway .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#rxmpipmway .gt_font_normal {
  font-weight: normal;
}

#rxmpipmway .gt_font_bold {
  font-weight: bold;
}

#rxmpipmway .gt_font_italic {
  font-style: italic;
}

#rxmpipmway .gt_super {
  font-size: 65%;
}

#rxmpipmway .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#rxmpipmway .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#rxmpipmway .gt_indent_1 {
  text-indent: 5px;
}

#rxmpipmway .gt_indent_2 {
  text-indent: 10px;
}

#rxmpipmway .gt_indent_3 {
  text-indent: 15px;
}

#rxmpipmway .gt_indent_4 {
  text-indent: 20px;
}

#rxmpipmway .gt_indent_5 {
  text-indent: 25px;
}

#rxmpipmway .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#rxmpipmway div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Characteristic</strong></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="level 1; stat_1">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>Treatment Arm</strong></span></div>
      </th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_1"><span class='gt_from_md'><strong>Axitinib</strong><br />
N = 98</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_2"><span class='gt_from_md'><strong>Bleomycin</strong><br />
N = 102</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Age</td>
<td headers="stat_1" class="gt_row gt_center">47.011 (14.709)</td>
<td headers="stat_2" class="gt_row gt_center">47.449 (14.005)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-style: italic;">    Missing</td>
<td headers="stat_1" class="gt_row gt_center">7</td>
<td headers="stat_2" class="gt_row gt_center">4</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Tumor Extent</td>
<td headers="stat_1" class="gt_row gt_center"><br /></td>
<td headers="stat_2" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-style: italic;">    T1</td>
<td headers="stat_1" class="gt_row gt_center">28 (29%)</td>
<td headers="stat_2" class="gt_row gt_center">25 (25%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-style: italic;">    T2</td>
<td headers="stat_1" class="gt_row gt_center">25 (26%)</td>
<td headers="stat_2" class="gt_row gt_center">29 (28%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-style: italic;">    T3</td>
<td headers="stat_1" class="gt_row gt_center">22 (22%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (21%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-style: italic;">    T4</td>
<td headers="stat_1" class="gt_row gt_center">23 (23%)</td>
<td headers="stat_2" class="gt_row gt_center">27 (26%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Tumor Badness Scale</td>
<td headers="stat_1" class="gt_row gt_center"><br /></td>
<td headers="stat_2" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-style: italic;">    I</td>
<td headers="stat_1" class="gt_row gt_center">35 (36%)</td>
<td headers="stat_2" class="gt_row gt_center">33 (32%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-style: italic;">    II</td>
<td headers="stat_1" class="gt_row gt_center">32 (33%)</td>
<td headers="stat_2" class="gt_row gt_center">36 (35%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-style: italic;">    III</td>
<td headers="stat_1" class="gt_row gt_center">31 (32%)</td>
<td headers="stat_2" class="gt_row gt_center">33 (32%)</td></tr>
  </tbody>
  
  <tfoot class="gt_footnotes">
    <tr>
      <td class="gt_footnote" colspan="3"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span> <span class='gt_from_md'>Mean (SD); n (%)</span></td>
    </tr>
  </tfoot>
</table>
</div>
```



</div>


## Even More Help

If the package author has set up vignettes, there are examples of how to use a function available as help files in R. You can run the function `vignette(function)` in the Console. Try `vignette("gtsummary_definition")`.

## Figuring out Column names
Column names are made on the fly by `tbl_summary` when you use the 
`by=` argument or `add_p()` or `add_n()` in `tbl_summary()` so you can't just refer to 
them by the name of the drug or trt variable (the displayed names are called Headers).
You can use the `show_header_names` function to see the names of the columns of
the table you just built. They are usually (from left to right) something like
`n, stat_1, stat_2, p.value, etc.` But it helps to know the names of these if you want to build a
spanning header. See the example below and its output to see how to use
`show_header_names`. The column name labels (needed to manipulate tbese)
are **not** the same as the displayed Headers.


``` r
tbl <- trial |> 
  tbl_summary(by = trt) |>
  add_n() |>
  add_p() 

tbl
```

```{=html}
<div id="fzkphgpeki" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#fzkphgpeki table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#fzkphgpeki thead, #fzkphgpeki tbody, #fzkphgpeki tfoot, #fzkphgpeki tr, #fzkphgpeki td, #fzkphgpeki th {
  border-style: none;
}

#fzkphgpeki p {
  margin: 0;
  padding: 0;
}

#fzkphgpeki .gt_table {
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

#fzkphgpeki .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#fzkphgpeki .gt_title {
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

#fzkphgpeki .gt_subtitle {
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

#fzkphgpeki .gt_heading {
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

#fzkphgpeki .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#fzkphgpeki .gt_col_headings {
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

#fzkphgpeki .gt_col_heading {
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

#fzkphgpeki .gt_column_spanner_outer {
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

#fzkphgpeki .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#fzkphgpeki .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#fzkphgpeki .gt_column_spanner {
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

#fzkphgpeki .gt_spanner_row {
  border-bottom-style: hidden;
}

#fzkphgpeki .gt_group_heading {
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

#fzkphgpeki .gt_empty_group_heading {
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

#fzkphgpeki .gt_from_md > :first-child {
  margin-top: 0;
}

#fzkphgpeki .gt_from_md > :last-child {
  margin-bottom: 0;
}

#fzkphgpeki .gt_row {
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

#fzkphgpeki .gt_stub {
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

#fzkphgpeki .gt_stub_row_group {
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

#fzkphgpeki .gt_row_group_first td {
  border-top-width: 2px;
}

#fzkphgpeki .gt_row_group_first th {
  border-top-width: 2px;
}

#fzkphgpeki .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#fzkphgpeki .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#fzkphgpeki .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#fzkphgpeki .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#fzkphgpeki .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#fzkphgpeki .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#fzkphgpeki .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#fzkphgpeki .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#fzkphgpeki .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#fzkphgpeki .gt_footnotes {
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

#fzkphgpeki .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#fzkphgpeki .gt_sourcenotes {
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

#fzkphgpeki .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#fzkphgpeki .gt_left {
  text-align: left;
}

#fzkphgpeki .gt_center {
  text-align: center;
}

#fzkphgpeki .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#fzkphgpeki .gt_font_normal {
  font-weight: normal;
}

#fzkphgpeki .gt_font_bold {
  font-weight: bold;
}

#fzkphgpeki .gt_font_italic {
  font-style: italic;
}

#fzkphgpeki .gt_super {
  font-size: 65%;
}

#fzkphgpeki .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#fzkphgpeki .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#fzkphgpeki .gt_indent_1 {
  text-indent: 5px;
}

#fzkphgpeki .gt_indent_2 {
  text-indent: 10px;
}

#fzkphgpeki .gt_indent_3 {
  text-indent: 15px;
}

#fzkphgpeki .gt_indent_4 {
  text-indent: 20px;
}

#fzkphgpeki .gt_indent_5 {
  text-indent: 25px;
}

#fzkphgpeki .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#fzkphgpeki div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Characteristic</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="n"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_1"><span class='gt_from_md'><strong>Drug A</strong><br />
N = 98</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_2"><span class='gt_from_md'><strong>Drug B</strong><br />
N = 102</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="p.value"><span class='gt_from_md'><strong>p-value</strong></span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>2</sup></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left">Age</td>
<td headers="n" class="gt_row gt_center">189</td>
<td headers="stat_1" class="gt_row gt_center">46 (37, 60)</td>
<td headers="stat_2" class="gt_row gt_center">48 (39, 56)</td>
<td headers="p.value" class="gt_row gt_center">0.7</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Unknown</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_1" class="gt_row gt_center">7</td>
<td headers="stat_2" class="gt_row gt_center">4</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">Marker Level (ng/mL)</td>
<td headers="n" class="gt_row gt_center">190</td>
<td headers="stat_1" class="gt_row gt_center">0.84 (0.23, 1.60)</td>
<td headers="stat_2" class="gt_row gt_center">0.52 (0.18, 1.21)</td>
<td headers="p.value" class="gt_row gt_center">0.085</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Unknown</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_1" class="gt_row gt_center">6</td>
<td headers="stat_2" class="gt_row gt_center">4</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">T Stage</td>
<td headers="n" class="gt_row gt_center">200</td>
<td headers="stat_1" class="gt_row gt_center"><br /></td>
<td headers="stat_2" class="gt_row gt_center"><br /></td>
<td headers="p.value" class="gt_row gt_center">0.9</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    T1</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_1" class="gt_row gt_center">28 (29%)</td>
<td headers="stat_2" class="gt_row gt_center">25 (25%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    T2</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_1" class="gt_row gt_center">25 (26%)</td>
<td headers="stat_2" class="gt_row gt_center">29 (28%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    T3</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_1" class="gt_row gt_center">22 (22%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (21%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    T4</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_1" class="gt_row gt_center">23 (23%)</td>
<td headers="stat_2" class="gt_row gt_center">27 (26%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">Grade</td>
<td headers="n" class="gt_row gt_center">200</td>
<td headers="stat_1" class="gt_row gt_center"><br /></td>
<td headers="stat_2" class="gt_row gt_center"><br /></td>
<td headers="p.value" class="gt_row gt_center">0.9</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    I</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_1" class="gt_row gt_center">35 (36%)</td>
<td headers="stat_2" class="gt_row gt_center">33 (32%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    II</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_1" class="gt_row gt_center">32 (33%)</td>
<td headers="stat_2" class="gt_row gt_center">36 (35%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    III</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_1" class="gt_row gt_center">31 (32%)</td>
<td headers="stat_2" class="gt_row gt_center">33 (32%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">Tumor Response</td>
<td headers="n" class="gt_row gt_center">193</td>
<td headers="stat_1" class="gt_row gt_center">28 (29%)</td>
<td headers="stat_2" class="gt_row gt_center">33 (34%)</td>
<td headers="p.value" class="gt_row gt_center">0.5</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Unknown</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_1" class="gt_row gt_center">3</td>
<td headers="stat_2" class="gt_row gt_center">4</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">Patient Died</td>
<td headers="n" class="gt_row gt_center">200</td>
<td headers="stat_1" class="gt_row gt_center">52 (53%)</td>
<td headers="stat_2" class="gt_row gt_center">60 (59%)</td>
<td headers="p.value" class="gt_row gt_center">0.4</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Months to Death/Censor</td>
<td headers="n" class="gt_row gt_center">200</td>
<td headers="stat_1" class="gt_row gt_center">23.5 (17.4, 24.0)</td>
<td headers="stat_2" class="gt_row gt_center">21.2 (14.5, 24.0)</td>
<td headers="p.value" class="gt_row gt_center">0.14</td></tr>
  </tbody>
  
  <tfoot class="gt_footnotes">
    <tr>
      <td class="gt_footnote" colspan="5"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span> <span class='gt_from_md'>Median (Q1, Q3); n (%)</span></td>
    </tr>
    <tr>
      <td class="gt_footnote" colspan="5"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>2</sup></span> <span class='gt_from_md'>Wilcoxon rank sum test; Pearson’s Chi-squared test</span></td>
    </tr>
  </tfoot>
</table>
</div>
```

``` r
tbl |> 
  show_header_names()
```

```
Column Name   Header                    level*         N*          n*          p*             
label         "**Characteristic**"                     200 <int>                              
n             "**N**"                                  200 <int>                              
stat_1        "**Drug A**  \nN = 98"    Drug A <chr>   200 <int>    98 <int>   0.490 <dbl>    
stat_2        "**Drug B**  \nN = 102"   Drug B <chr>   200 <int>   102 <int>   0.510 <dbl>    
p.value       "**p-value**"                            200 <int>                              
```

## Even More Challenges

:::tryit

Start with this chunk of code:


``` r
trial %>% 
  mutate(trt = case_when(trt == "Drug A" ~ "Axitinib",
                          trt == "Drug B" ~ "Bleomycin")) %>%
  tbl_summary(by = trt,
              include = c(age, trt, stage, grade),
              statistic = list(all_categorical() ~ "{n} ({p}%)",
                               all_continuous() ~ "{mean} ({sd})"),
              digits = all_continuous() ~ 3,
              label = list(stage ~ "Tumor Extent",
                           grade ~ "Tumor Badness Scale"),
              missing_text = "Missing") %>%
              modify_spanning_header(all_stat_cols() ~ "**Treatment Arm**") |> 
              bold_labels()
```

```{=html}
<div id="fyfuhtcpqc" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#fyfuhtcpqc table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#fyfuhtcpqc thead, #fyfuhtcpqc tbody, #fyfuhtcpqc tfoot, #fyfuhtcpqc tr, #fyfuhtcpqc td, #fyfuhtcpqc th {
  border-style: none;
}

#fyfuhtcpqc p {
  margin: 0;
  padding: 0;
}

#fyfuhtcpqc .gt_table {
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

#fyfuhtcpqc .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#fyfuhtcpqc .gt_title {
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

#fyfuhtcpqc .gt_subtitle {
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

#fyfuhtcpqc .gt_heading {
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

#fyfuhtcpqc .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#fyfuhtcpqc .gt_col_headings {
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

#fyfuhtcpqc .gt_col_heading {
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

#fyfuhtcpqc .gt_column_spanner_outer {
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

#fyfuhtcpqc .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#fyfuhtcpqc .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#fyfuhtcpqc .gt_column_spanner {
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

#fyfuhtcpqc .gt_spanner_row {
  border-bottom-style: hidden;
}

#fyfuhtcpqc .gt_group_heading {
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

#fyfuhtcpqc .gt_empty_group_heading {
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

#fyfuhtcpqc .gt_from_md > :first-child {
  margin-top: 0;
}

#fyfuhtcpqc .gt_from_md > :last-child {
  margin-bottom: 0;
}

#fyfuhtcpqc .gt_row {
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

#fyfuhtcpqc .gt_stub {
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

#fyfuhtcpqc .gt_stub_row_group {
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

#fyfuhtcpqc .gt_row_group_first td {
  border-top-width: 2px;
}

#fyfuhtcpqc .gt_row_group_first th {
  border-top-width: 2px;
}

#fyfuhtcpqc .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#fyfuhtcpqc .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#fyfuhtcpqc .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#fyfuhtcpqc .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#fyfuhtcpqc .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#fyfuhtcpqc .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#fyfuhtcpqc .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#fyfuhtcpqc .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#fyfuhtcpqc .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#fyfuhtcpqc .gt_footnotes {
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

#fyfuhtcpqc .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#fyfuhtcpqc .gt_sourcenotes {
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

#fyfuhtcpqc .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#fyfuhtcpqc .gt_left {
  text-align: left;
}

#fyfuhtcpqc .gt_center {
  text-align: center;
}

#fyfuhtcpqc .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#fyfuhtcpqc .gt_font_normal {
  font-weight: normal;
}

#fyfuhtcpqc .gt_font_bold {
  font-weight: bold;
}

#fyfuhtcpqc .gt_font_italic {
  font-style: italic;
}

#fyfuhtcpqc .gt_super {
  font-size: 65%;
}

#fyfuhtcpqc .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#fyfuhtcpqc .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#fyfuhtcpqc .gt_indent_1 {
  text-indent: 5px;
}

#fyfuhtcpqc .gt_indent_2 {
  text-indent: 10px;
}

#fyfuhtcpqc .gt_indent_3 {
  text-indent: 15px;
}

#fyfuhtcpqc .gt_indent_4 {
  text-indent: 20px;
}

#fyfuhtcpqc .gt_indent_5 {
  text-indent: 25px;
}

#fyfuhtcpqc .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#fyfuhtcpqc div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Characteristic</strong></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="level 1; stat_1">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>Treatment Arm</strong></span></div>
      </th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_1"><span class='gt_from_md'><strong>Axitinib</strong><br />
N = 98</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_2"><span class='gt_from_md'><strong>Bleomycin</strong><br />
N = 102</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Age</td>
<td headers="stat_1" class="gt_row gt_center">47.011 (14.709)</td>
<td headers="stat_2" class="gt_row gt_center">47.449 (14.005)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Missing</td>
<td headers="stat_1" class="gt_row gt_center">7</td>
<td headers="stat_2" class="gt_row gt_center">4</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Tumor Extent</td>
<td headers="stat_1" class="gt_row gt_center"><br /></td>
<td headers="stat_2" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    T1</td>
<td headers="stat_1" class="gt_row gt_center">28 (29%)</td>
<td headers="stat_2" class="gt_row gt_center">25 (25%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    T2</td>
<td headers="stat_1" class="gt_row gt_center">25 (26%)</td>
<td headers="stat_2" class="gt_row gt_center">29 (28%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    T3</td>
<td headers="stat_1" class="gt_row gt_center">22 (22%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (21%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    T4</td>
<td headers="stat_1" class="gt_row gt_center">23 (23%)</td>
<td headers="stat_2" class="gt_row gt_center">27 (26%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Tumor Badness Scale</td>
<td headers="stat_1" class="gt_row gt_center"><br /></td>
<td headers="stat_2" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    I</td>
<td headers="stat_1" class="gt_row gt_center">35 (36%)</td>
<td headers="stat_2" class="gt_row gt_center">33 (32%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    II</td>
<td headers="stat_1" class="gt_row gt_center">32 (33%)</td>
<td headers="stat_2" class="gt_row gt_center">36 (35%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    III</td>
<td headers="stat_1" class="gt_row gt_center">31 (32%)</td>
<td headers="stat_2" class="gt_row gt_center">33 (32%)</td></tr>
  </tbody>
  
  <tfoot class="gt_footnotes">
    <tr>
      <td class="gt_footnote" colspan="3"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span> <span class='gt_from_md'>Mean (SD); n (%)</span></td>
    </tr>
  </tfoot>
</table>
</div>
```

Now for your next challenges:

1.  Add an overall column next to Drug A and Drug B
2.  Change the Characteristic column label to "Variable" (and make it bold)
3.  Add p values (though you really should not)
4.  Style p values to 3 digits
4.  Make the variable levels _italicized_
5.  Add an N column for each variable

Take a few minutes to do these challenges, then peek at the solution below.

:::


<div class='webex-solution'><button>Solution</button>



``` r
trial %>% 
  mutate(trt = case_when(trt == "Drug A" ~ "Axitinib",
                          trt == "Drug B" ~ "Bleomycin")) %>%
  tbl_summary(by = trt,
              include = c(age, trt, stage, grade),
              statistic = list(all_categorical() ~ "{n} ({p}%)",
                               all_continuous() ~ "{mean} ({sd})"),
              digits = all_continuous() ~ 3,
              label = list(stage ~ "Tumor Extent",
                           grade ~ "Tumor Badness Scale"),
              missing_text = "Missing") %>%
      modify_header(label = "**Variable**") |> 
      add_overall() |> 
      add_n() |>
      add_p(pvalue_fun = label_style_pvalue(digits = 3)) |>
      modify_spanning_header(all_stat_cols() ~ "**Treatment Arm**") |> 
      italicize_levels() %>%
      bold_labels()
```

```{=html}
<div id="dwnftlpspi" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#dwnftlpspi table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#dwnftlpspi thead, #dwnftlpspi tbody, #dwnftlpspi tfoot, #dwnftlpspi tr, #dwnftlpspi td, #dwnftlpspi th {
  border-style: none;
}

#dwnftlpspi p {
  margin: 0;
  padding: 0;
}

#dwnftlpspi .gt_table {
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

#dwnftlpspi .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#dwnftlpspi .gt_title {
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

#dwnftlpspi .gt_subtitle {
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

#dwnftlpspi .gt_heading {
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

#dwnftlpspi .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#dwnftlpspi .gt_col_headings {
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

#dwnftlpspi .gt_col_heading {
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

#dwnftlpspi .gt_column_spanner_outer {
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

#dwnftlpspi .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#dwnftlpspi .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#dwnftlpspi .gt_column_spanner {
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

#dwnftlpspi .gt_spanner_row {
  border-bottom-style: hidden;
}

#dwnftlpspi .gt_group_heading {
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

#dwnftlpspi .gt_empty_group_heading {
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

#dwnftlpspi .gt_from_md > :first-child {
  margin-top: 0;
}

#dwnftlpspi .gt_from_md > :last-child {
  margin-bottom: 0;
}

#dwnftlpspi .gt_row {
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

#dwnftlpspi .gt_stub {
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

#dwnftlpspi .gt_stub_row_group {
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

#dwnftlpspi .gt_row_group_first td {
  border-top-width: 2px;
}

#dwnftlpspi .gt_row_group_first th {
  border-top-width: 2px;
}

#dwnftlpspi .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#dwnftlpspi .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#dwnftlpspi .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#dwnftlpspi .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#dwnftlpspi .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#dwnftlpspi .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#dwnftlpspi .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#dwnftlpspi .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#dwnftlpspi .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#dwnftlpspi .gt_footnotes {
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

#dwnftlpspi .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#dwnftlpspi .gt_sourcenotes {
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

#dwnftlpspi .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#dwnftlpspi .gt_left {
  text-align: left;
}

#dwnftlpspi .gt_center {
  text-align: center;
}

#dwnftlpspi .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#dwnftlpspi .gt_font_normal {
  font-weight: normal;
}

#dwnftlpspi .gt_font_bold {
  font-weight: bold;
}

#dwnftlpspi .gt_font_italic {
  font-style: italic;
}

#dwnftlpspi .gt_super {
  font-size: 65%;
}

#dwnftlpspi .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#dwnftlpspi .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#dwnftlpspi .gt_indent_1 {
  text-indent: 5px;
}

#dwnftlpspi .gt_indent_2 {
  text-indent: 10px;
}

#dwnftlpspi .gt_indent_3 {
  text-indent: 15px;
}

#dwnftlpspi .gt_indent_4 {
  text-indent: 20px;
}

#dwnftlpspi .gt_indent_5 {
  text-indent: 25px;
}

#dwnftlpspi .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#dwnftlpspi div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Variable</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="n"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="3" scope="colgroup" id="level 1; stat_0">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>Treatment Arm</strong></span></div>
      </th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="p.value"><span class='gt_from_md'><strong>p-value</strong></span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>2</sup></span></th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_0"><span class='gt_from_md'><strong>Overall</strong><br />
N = 200</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_1"><span class='gt_from_md'><strong>Axitinib</strong><br />
N = 98</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_2"><span class='gt_from_md'><strong>Bleomycin</strong><br />
N = 102</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Age</td>
<td headers="n" class="gt_row gt_center">189</td>
<td headers="stat_0" class="gt_row gt_center">47.238 (14.312)</td>
<td headers="stat_1" class="gt_row gt_center">47.011 (14.709)</td>
<td headers="stat_2" class="gt_row gt_center">47.449 (14.005)</td>
<td headers="p.value" class="gt_row gt_center">0.718</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-style: italic;">    Missing</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">11</td>
<td headers="stat_1" class="gt_row gt_center">7</td>
<td headers="stat_2" class="gt_row gt_center">4</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Tumor Extent</td>
<td headers="n" class="gt_row gt_center">200</td>
<td headers="stat_0" class="gt_row gt_center"><br /></td>
<td headers="stat_1" class="gt_row gt_center"><br /></td>
<td headers="stat_2" class="gt_row gt_center"><br /></td>
<td headers="p.value" class="gt_row gt_center">0.866</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-style: italic;">    T1</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">53 (27%)</td>
<td headers="stat_1" class="gt_row gt_center">28 (29%)</td>
<td headers="stat_2" class="gt_row gt_center">25 (25%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-style: italic;">    T2</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">54 (27%)</td>
<td headers="stat_1" class="gt_row gt_center">25 (26%)</td>
<td headers="stat_2" class="gt_row gt_center">29 (28%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-style: italic;">    T3</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">43 (22%)</td>
<td headers="stat_1" class="gt_row gt_center">22 (22%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (21%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-style: italic;">    T4</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">50 (25%)</td>
<td headers="stat_1" class="gt_row gt_center">23 (23%)</td>
<td headers="stat_2" class="gt_row gt_center">27 (26%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Tumor Badness Scale</td>
<td headers="n" class="gt_row gt_center">200</td>
<td headers="stat_0" class="gt_row gt_center"><br /></td>
<td headers="stat_1" class="gt_row gt_center"><br /></td>
<td headers="stat_2" class="gt_row gt_center"><br /></td>
<td headers="p.value" class="gt_row gt_center">0.871</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-style: italic;">    I</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">68 (34%)</td>
<td headers="stat_1" class="gt_row gt_center">35 (36%)</td>
<td headers="stat_2" class="gt_row gt_center">33 (32%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-style: italic;">    II</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">68 (34%)</td>
<td headers="stat_1" class="gt_row gt_center">32 (33%)</td>
<td headers="stat_2" class="gt_row gt_center">36 (35%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-style: italic;">    III</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">64 (32%)</td>
<td headers="stat_1" class="gt_row gt_center">31 (32%)</td>
<td headers="stat_2" class="gt_row gt_center">33 (32%)</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
  </tbody>
  
  <tfoot class="gt_footnotes">
    <tr>
      <td class="gt_footnote" colspan="6"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span> <span class='gt_from_md'>Mean (SD); n (%)</span></td>
    </tr>
    <tr>
      <td class="gt_footnote" colspan="6"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>2</sup></span> <span class='gt_from_md'>Wilcoxon rank sum test; Pearson’s Chi-squared test</span></td>
    </tr>
  </tfoot>
</table>
</div>
```



</div>


## Adding Some Formatting

The {gtsummary} package is designed to help you quickly make nice looking tables
suitable for publication, but if you want complete control of formatting 
(font, color, etc), you want to use a table formatting package.

The two big ones are {gt}, which is the underlying package for {gtsummary}, and 
{flextable} which can produce output for MS Word and Powerpoint as well as HTML.

Check out the websites for each by googling for:

1.  gt and pkgdown
2.  flextable and pkgdown

There are hundreds of functions in each package to help you organize and format 
tables. Often to a fairly obnoxious level.

To get your tables from {gtsummary} ready for formatting, you need a conversion function.

### Formatting with {gt}

For gt tables, this is `as_gt()`. Once this is done, you can use any {gt) 
functions to format your table. Using the gt website for guidance, add some more formatting 
below. Try bolding, text colors, and cell colors. It may be helpful to search 
(Cmd-F) for `tab_style()` on the gt website.
Take a few minutes to style your table to something elegant, or
to something that looks like peak `MySpace web page`.


``` r
trial %>% 
  select(trt, age, stage, grade) %>% 
  tbl_summary() %>% 
  as_gt() %>% 
   opt_table_font(
    font = list(
      google_font(name = "Atkinson Hyperlegible Next")
    )
  )
```

```{=html}
<div id="hbobvtpakr" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>@import url("https://fonts.googleapis.com/css2?family=Atkinson+Hyperlegible+Next:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap");
#hbobvtpakr table {
  font-family: 'Atkinson Hyperlegible Next', system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#hbobvtpakr thead, #hbobvtpakr tbody, #hbobvtpakr tfoot, #hbobvtpakr tr, #hbobvtpakr td, #hbobvtpakr th {
  border-style: none;
}

#hbobvtpakr p {
  margin: 0;
  padding: 0;
}

#hbobvtpakr .gt_table {
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

#hbobvtpakr .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#hbobvtpakr .gt_title {
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

#hbobvtpakr .gt_subtitle {
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

#hbobvtpakr .gt_heading {
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

#hbobvtpakr .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#hbobvtpakr .gt_col_headings {
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

#hbobvtpakr .gt_col_heading {
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

#hbobvtpakr .gt_column_spanner_outer {
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

#hbobvtpakr .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#hbobvtpakr .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#hbobvtpakr .gt_column_spanner {
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

#hbobvtpakr .gt_spanner_row {
  border-bottom-style: hidden;
}

#hbobvtpakr .gt_group_heading {
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

#hbobvtpakr .gt_empty_group_heading {
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

#hbobvtpakr .gt_from_md > :first-child {
  margin-top: 0;
}

#hbobvtpakr .gt_from_md > :last-child {
  margin-bottom: 0;
}

#hbobvtpakr .gt_row {
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

#hbobvtpakr .gt_stub {
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

#hbobvtpakr .gt_stub_row_group {
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

#hbobvtpakr .gt_row_group_first td {
  border-top-width: 2px;
}

#hbobvtpakr .gt_row_group_first th {
  border-top-width: 2px;
}

#hbobvtpakr .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#hbobvtpakr .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#hbobvtpakr .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#hbobvtpakr .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#hbobvtpakr .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#hbobvtpakr .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#hbobvtpakr .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#hbobvtpakr .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#hbobvtpakr .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#hbobvtpakr .gt_footnotes {
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

#hbobvtpakr .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#hbobvtpakr .gt_sourcenotes {
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

#hbobvtpakr .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#hbobvtpakr .gt_left {
  text-align: left;
}

#hbobvtpakr .gt_center {
  text-align: center;
}

#hbobvtpakr .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#hbobvtpakr .gt_font_normal {
  font-weight: normal;
}

#hbobvtpakr .gt_font_bold {
  font-weight: bold;
}

#hbobvtpakr .gt_font_italic {
  font-style: italic;
}

#hbobvtpakr .gt_super {
  font-size: 65%;
}

#hbobvtpakr .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#hbobvtpakr .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#hbobvtpakr .gt_indent_1 {
  text-indent: 5px;
}

#hbobvtpakr .gt_indent_2 {
  text-indent: 10px;
}

#hbobvtpakr .gt_indent_3 {
  text-indent: 15px;
}

#hbobvtpakr .gt_indent_4 {
  text-indent: 20px;
}

#hbobvtpakr .gt_indent_5 {
  text-indent: 25px;
}

#hbobvtpakr .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#hbobvtpakr div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Characteristic</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_0"><span class='gt_from_md'><strong>N = 200</strong></span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left">Chemotherapy Treatment</td>
<td headers="stat_0" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Drug A</td>
<td headers="stat_0" class="gt_row gt_center">98 (49%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Drug B</td>
<td headers="stat_0" class="gt_row gt_center">102 (51%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Age</td>
<td headers="stat_0" class="gt_row gt_center">47 (38, 57)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Unknown</td>
<td headers="stat_0" class="gt_row gt_center">11</td></tr>
    <tr><td headers="label" class="gt_row gt_left">T Stage</td>
<td headers="stat_0" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    T1</td>
<td headers="stat_0" class="gt_row gt_center">53 (27%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    T2</td>
<td headers="stat_0" class="gt_row gt_center">54 (27%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    T3</td>
<td headers="stat_0" class="gt_row gt_center">43 (22%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    T4</td>
<td headers="stat_0" class="gt_row gt_center">50 (25%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Grade</td>
<td headers="stat_0" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    I</td>
<td headers="stat_0" class="gt_row gt_center">68 (34%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    II</td>
<td headers="stat_0" class="gt_row gt_center">68 (34%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    III</td>
<td headers="stat_0" class="gt_row gt_center">64 (32%)</td></tr>
  </tbody>
  
  <tfoot class="gt_footnotes">
    <tr>
      <td class="gt_footnote" colspan="2"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span> <span class='gt_from_md'>n (%); Median (Q1, Q3)</span></td>
    </tr>
  </tfoot>
</table>
</div>
```

## A Fancier Version for gt

Here is a vertigo-inducing example of what you can do with the
{gt} package. Self-control is important with table formatting.

Take some time to explore the (thousands of) options in the {gt}
package - you will likely be able to find most anything you could
want in terms of table formatting, including conditional formatting,
graphics and trendline
plots (aka 'sparklines') in table cells.
Take a look at the code below and try to decipher which functions produce which
formatting in the resulting table.


``` r
trial %>% 
  tbl_summary(by = trt,
              include =  c(age, stage, grade)) %>% 
  as_gt() %>% 
  opt_table_font(
    font = list(google_font(name = "Orbitron"))) |> 
  tab_header(title = md("**Table 1:  Tumor Characteristics by Treatment Arm**"),
                        subtitle  = "Trial was Conducted in TRON World") |> 
  tab_style(style = list(
    cell_text(weight = "bold", color = "white"),
    cell_fill(color = "blue"),
    cell_text(size = 14)),
    locations = cells_body(rows = 1:2)) |>
  tab_style(style = list(
    cell_text(weight = "bold", color = "white"),
    cell_fill(color = "red"),
    cell_text(size = 14)),
    locations = cells_body(rows = 3:7)) |> 
  tab_style(style = list(
    cell_text(weight = "bold", color = "blue"),
    cell_fill(color = "pink"),
    cell_text(size = 14)),
    locations = cells_body(rows = 8:11)) |> 
  tab_source_note(
    source_note = "Source:  TRON World") 
```

```{=html}
<div id="wfozpmewxu" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>@import url("https://fonts.googleapis.com/css2?family=Orbitron:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap");
#wfozpmewxu table {
  font-family: Orbitron, system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#wfozpmewxu thead, #wfozpmewxu tbody, #wfozpmewxu tfoot, #wfozpmewxu tr, #wfozpmewxu td, #wfozpmewxu th {
  border-style: none;
}

#wfozpmewxu p {
  margin: 0;
  padding: 0;
}

#wfozpmewxu .gt_table {
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

#wfozpmewxu .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#wfozpmewxu .gt_title {
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

#wfozpmewxu .gt_subtitle {
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

#wfozpmewxu .gt_heading {
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

#wfozpmewxu .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#wfozpmewxu .gt_col_headings {
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

#wfozpmewxu .gt_col_heading {
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

#wfozpmewxu .gt_column_spanner_outer {
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

#wfozpmewxu .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#wfozpmewxu .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#wfozpmewxu .gt_column_spanner {
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

#wfozpmewxu .gt_spanner_row {
  border-bottom-style: hidden;
}

#wfozpmewxu .gt_group_heading {
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

#wfozpmewxu .gt_empty_group_heading {
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

#wfozpmewxu .gt_from_md > :first-child {
  margin-top: 0;
}

#wfozpmewxu .gt_from_md > :last-child {
  margin-bottom: 0;
}

#wfozpmewxu .gt_row {
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

#wfozpmewxu .gt_stub {
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

#wfozpmewxu .gt_stub_row_group {
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

#wfozpmewxu .gt_row_group_first td {
  border-top-width: 2px;
}

#wfozpmewxu .gt_row_group_first th {
  border-top-width: 2px;
}

#wfozpmewxu .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#wfozpmewxu .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#wfozpmewxu .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#wfozpmewxu .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#wfozpmewxu .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#wfozpmewxu .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#wfozpmewxu .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#wfozpmewxu .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#wfozpmewxu .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#wfozpmewxu .gt_footnotes {
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

#wfozpmewxu .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#wfozpmewxu .gt_sourcenotes {
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

#wfozpmewxu .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#wfozpmewxu .gt_left {
  text-align: left;
}

#wfozpmewxu .gt_center {
  text-align: center;
}

#wfozpmewxu .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#wfozpmewxu .gt_font_normal {
  font-weight: normal;
}

#wfozpmewxu .gt_font_bold {
  font-weight: bold;
}

#wfozpmewxu .gt_font_italic {
  font-style: italic;
}

#wfozpmewxu .gt_super {
  font-size: 65%;
}

#wfozpmewxu .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#wfozpmewxu .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#wfozpmewxu .gt_indent_1 {
  text-indent: 5px;
}

#wfozpmewxu .gt_indent_2 {
  text-indent: 10px;
}

#wfozpmewxu .gt_indent_3 {
  text-indent: 15px;
}

#wfozpmewxu .gt_indent_4 {
  text-indent: 20px;
}

#wfozpmewxu .gt_indent_5 {
  text-indent: 25px;
}

#wfozpmewxu .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#wfozpmewxu div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_heading">
      <td colspan="3" class="gt_heading gt_title gt_font_normal" style><span class='gt_from_md'><strong>Table 1:  Tumor Characteristics by Treatment Arm</strong></span></td>
    </tr>
    <tr class="gt_heading">
      <td colspan="3" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style>Trial was Conducted in TRON World</td>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Characteristic</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_1"><span class='gt_from_md'><strong>Drug A</strong><br />
N = 98</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_2"><span class='gt_from_md'><strong>Drug B</strong><br />
N = 102</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left" style="color: #FFFFFF; font-weight: bold; font-size: 14; background-color: #0000FF;">Age</td>
<td headers="stat_1" class="gt_row gt_center" style="color: #FFFFFF; font-weight: bold; font-size: 14; background-color: #0000FF;">46 (37, 60)</td>
<td headers="stat_2" class="gt_row gt_center" style="color: #FFFFFF; font-weight: bold; font-size: 14; background-color: #0000FF;">48 (39, 56)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="color: #FFFFFF; font-weight: bold; font-size: 14; background-color: #0000FF;">    Unknown</td>
<td headers="stat_1" class="gt_row gt_center" style="color: #FFFFFF; font-weight: bold; font-size: 14; background-color: #0000FF;">7</td>
<td headers="stat_2" class="gt_row gt_center" style="color: #FFFFFF; font-weight: bold; font-size: 14; background-color: #0000FF;">4</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="color: #FFFFFF; font-weight: bold; font-size: 14; background-color: #FF0000;">T Stage</td>
<td headers="stat_1" class="gt_row gt_center" style="color: #FFFFFF; font-weight: bold; font-size: 14; background-color: #FF0000;"><br /></td>
<td headers="stat_2" class="gt_row gt_center" style="color: #FFFFFF; font-weight: bold; font-size: 14; background-color: #FF0000;"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="color: #FFFFFF; font-weight: bold; font-size: 14; background-color: #FF0000;">    T1</td>
<td headers="stat_1" class="gt_row gt_center" style="color: #FFFFFF; font-weight: bold; font-size: 14; background-color: #FF0000;">28 (29%)</td>
<td headers="stat_2" class="gt_row gt_center" style="color: #FFFFFF; font-weight: bold; font-size: 14; background-color: #FF0000;">25 (25%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="color: #FFFFFF; font-weight: bold; font-size: 14; background-color: #FF0000;">    T2</td>
<td headers="stat_1" class="gt_row gt_center" style="color: #FFFFFF; font-weight: bold; font-size: 14; background-color: #FF0000;">25 (26%)</td>
<td headers="stat_2" class="gt_row gt_center" style="color: #FFFFFF; font-weight: bold; font-size: 14; background-color: #FF0000;">29 (28%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="color: #FFFFFF; font-weight: bold; font-size: 14; background-color: #FF0000;">    T3</td>
<td headers="stat_1" class="gt_row gt_center" style="color: #FFFFFF; font-weight: bold; font-size: 14; background-color: #FF0000;">22 (22%)</td>
<td headers="stat_2" class="gt_row gt_center" style="color: #FFFFFF; font-weight: bold; font-size: 14; background-color: #FF0000;">21 (21%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="color: #FFFFFF; font-weight: bold; font-size: 14; background-color: #FF0000;">    T4</td>
<td headers="stat_1" class="gt_row gt_center" style="color: #FFFFFF; font-weight: bold; font-size: 14; background-color: #FF0000;">23 (23%)</td>
<td headers="stat_2" class="gt_row gt_center" style="color: #FFFFFF; font-weight: bold; font-size: 14; background-color: #FF0000;">27 (26%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="color: #0000FF; font-weight: bold; font-size: 14; background-color: #FFC0CB;">Grade</td>
<td headers="stat_1" class="gt_row gt_center" style="color: #0000FF; font-weight: bold; font-size: 14; background-color: #FFC0CB;"><br /></td>
<td headers="stat_2" class="gt_row gt_center" style="color: #0000FF; font-weight: bold; font-size: 14; background-color: #FFC0CB;"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="color: #0000FF; font-weight: bold; font-size: 14; background-color: #FFC0CB;">    I</td>
<td headers="stat_1" class="gt_row gt_center" style="color: #0000FF; font-weight: bold; font-size: 14; background-color: #FFC0CB;">35 (36%)</td>
<td headers="stat_2" class="gt_row gt_center" style="color: #0000FF; font-weight: bold; font-size: 14; background-color: #FFC0CB;">33 (32%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="color: #0000FF; font-weight: bold; font-size: 14; background-color: #FFC0CB;">    II</td>
<td headers="stat_1" class="gt_row gt_center" style="color: #0000FF; font-weight: bold; font-size: 14; background-color: #FFC0CB;">32 (33%)</td>
<td headers="stat_2" class="gt_row gt_center" style="color: #0000FF; font-weight: bold; font-size: 14; background-color: #FFC0CB;">36 (35%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="color: #0000FF; font-weight: bold; font-size: 14; background-color: #FFC0CB;">    III</td>
<td headers="stat_1" class="gt_row gt_center" style="color: #0000FF; font-weight: bold; font-size: 14; background-color: #FFC0CB;">31 (32%)</td>
<td headers="stat_2" class="gt_row gt_center" style="color: #0000FF; font-weight: bold; font-size: 14; background-color: #FFC0CB;">33 (32%)</td></tr>
  </tbody>
  <tfoot class="gt_sourcenotes">
    <tr>
      <td class="gt_sourcenote" colspan="3">Source:  TRON World</td>
    </tr>
  </tfoot>
  <tfoot class="gt_footnotes">
    <tr>
      <td class="gt_footnote" colspan="3"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span> <span class='gt_from_md'>Median (Q1, Q3); n (%)</span></td>
    </tr>
  </tfoot>
</table>
</div>
```


### The {flextable} package

For gtsummary output, the conversion function is `as_flex_table()`. Then you can use any {flextable) functions to format. Using the [flextable](https://davidgohel.github.io/flextable/reference/index.html) website, add some more formatting below. Try text and cell colors. It may be helpful to scroll down to the 'Change Visual Properties' header or to apply some of the default themes.

Take some time to explore the (hundreds of) options in the {flextable}
package - you will likely be able to find most anything you could
reasonably want in terms of table formatting for publication.


``` r
trial %>% 
  select(trt, age, stage, grade) %>% 
  tbl_summary() %>% 
  as_flex_table() %>% 
  font(fontname = "Brush Script MT",
       part = "header") %>% 
  fontsize(size = 18, part = "header")
```

```{=html}
<div class="tabwid"><style>.cl-dbb92b30{}.cl-dbb28ed8{font-family:'Brush Script MT';font-size:18pt;font-weight:bold;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-dbb28eec{font-family:'Brush Script MT';font-size:10.8pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;position: relative;bottom:5.4pt;}.cl-dbb28ef6{font-family:'Helvetica';font-size:11pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-dbb28ef7{font-family:'Helvetica';font-size:6.6pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;position: relative;bottom:3.3pt;}.cl-dbb4f1c8{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:2pt;padding-top:2pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-dbb4f1dc{margin:0;text-align:center;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:2pt;padding-top:2pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-dbb4f1e6{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-dbb4f1e7{margin:0;text-align:center;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-dbb4f1e8{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:15pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-dbb4f1f0{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-dbb50b4a{width:2.026in;background-color:transparent;vertical-align: middle;border-bottom: 1pt solid rgba(0, 0, 0, 1.00);border-top: 1pt solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-dbb50b54{width:1.024in;background-color:transparent;vertical-align: middle;border-bottom: 1pt solid rgba(0, 0, 0, 1.00);border-top: 1pt solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-dbb50b55{width:2.026in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-dbb50b5e{width:1.024in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-dbb50b5f{width:2.026in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-dbb50b68{width:1.024in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-dbb50b72{width:2.026in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-dbb50b73{width:1.024in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-dbb50b74{width:2.026in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-dbb50b7c{width:1.024in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-dbb50b7d{width:2.026in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-dbb50b86{width:1.024in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-dbb50b90{width:2.026in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-dbb50b9a{width:1.024in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-dbb50b9b{width:2.026in;background-color:transparent;vertical-align: top;border-bottom: 1pt solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-dbb50b9c{width:1.024in;background-color:transparent;vertical-align: top;border-bottom: 1pt solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-dbb50ba4{width:2.026in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(255, 255, 255, 0.00);border-top: 0 solid rgba(255, 255, 255, 0.00);border-left: 0 solid rgba(255, 255, 255, 0.00);border-right: 0 solid rgba(255, 255, 255, 0.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-dbb50ba5{width:1.024in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(255, 255, 255, 0.00);border-top: 0 solid rgba(255, 255, 255, 0.00);border-left: 0 solid rgba(255, 255, 255, 0.00);border-right: 0 solid rgba(255, 255, 255, 0.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}</style><table data-quarto-disable-processing='true' class='cl-dbb92b30'><thead><tr style="overflow-wrap:break-word;"><th class="cl-dbb50b4a"><p class="cl-dbb4f1c8"><span class="cl-dbb28ed8">Characteristic</span></p></th><th class="cl-dbb50b54"><p class="cl-dbb4f1dc"><span class="cl-dbb28ed8">N = 200</span><span class="cl-dbb28eec">1</span></p></th></tr></thead><tbody><tr style="overflow-wrap:break-word;"><td class="cl-dbb50b55"><p class="cl-dbb4f1e6"><span class="cl-dbb28ef6">Chemotherapy Treatment</span></p></td><td class="cl-dbb50b5e"><p class="cl-dbb4f1e7"><span class="cl-dbb28ef6"></span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-dbb50b5f"><p class="cl-dbb4f1e8"><span class="cl-dbb28ef6">Drug A</span></p></td><td class="cl-dbb50b68"><p class="cl-dbb4f1e7"><span class="cl-dbb28ef6">98 (49%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-dbb50b5f"><p class="cl-dbb4f1e8"><span class="cl-dbb28ef6">Drug B</span></p></td><td class="cl-dbb50b68"><p class="cl-dbb4f1e7"><span class="cl-dbb28ef6">102 (51%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-dbb50b5f"><p class="cl-dbb4f1e6"><span class="cl-dbb28ef6">Age</span></p></td><td class="cl-dbb50b68"><p class="cl-dbb4f1e7"><span class="cl-dbb28ef6">47 (38, 57)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-dbb50b72"><p class="cl-dbb4f1e8"><span class="cl-dbb28ef6">Unknown</span></p></td><td class="cl-dbb50b73"><p class="cl-dbb4f1e7"><span class="cl-dbb28ef6">11</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-dbb50b74"><p class="cl-dbb4f1e6"><span class="cl-dbb28ef6">T Stage</span></p></td><td class="cl-dbb50b7c"><p class="cl-dbb4f1e7"><span class="cl-dbb28ef6"></span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-dbb50b7d"><p class="cl-dbb4f1e8"><span class="cl-dbb28ef6">T1</span></p></td><td class="cl-dbb50b86"><p class="cl-dbb4f1e7"><span class="cl-dbb28ef6">53 (27%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-dbb50b7d"><p class="cl-dbb4f1e8"><span class="cl-dbb28ef6">T2</span></p></td><td class="cl-dbb50b86"><p class="cl-dbb4f1e7"><span class="cl-dbb28ef6">54 (27%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-dbb50b7d"><p class="cl-dbb4f1e8"><span class="cl-dbb28ef6">T3</span></p></td><td class="cl-dbb50b86"><p class="cl-dbb4f1e7"><span class="cl-dbb28ef6">43 (22%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-dbb50b7d"><p class="cl-dbb4f1e8"><span class="cl-dbb28ef6">T4</span></p></td><td class="cl-dbb50b86"><p class="cl-dbb4f1e7"><span class="cl-dbb28ef6">50 (25%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-dbb50b90"><p class="cl-dbb4f1e6"><span class="cl-dbb28ef6">Grade</span></p></td><td class="cl-dbb50b9a"><p class="cl-dbb4f1e7"><span class="cl-dbb28ef6"></span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-dbb50b7d"><p class="cl-dbb4f1e8"><span class="cl-dbb28ef6">I</span></p></td><td class="cl-dbb50b86"><p class="cl-dbb4f1e7"><span class="cl-dbb28ef6">68 (34%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-dbb50b7d"><p class="cl-dbb4f1e8"><span class="cl-dbb28ef6">II</span></p></td><td class="cl-dbb50b86"><p class="cl-dbb4f1e7"><span class="cl-dbb28ef6">68 (34%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-dbb50b9b"><p class="cl-dbb4f1e8"><span class="cl-dbb28ef6">III</span></p></td><td class="cl-dbb50b9c"><p class="cl-dbb4f1e7"><span class="cl-dbb28ef6">64 (32%)</span></p></td></tr></tbody><tfoot><tr style="overflow-wrap:break-word;"><td  colspan="2"class="cl-dbb50ba4"><p class="cl-dbb4f1f0"><span class="cl-dbb28ef7">1</span><span class="cl-dbb28ef6">n (%); Median (Q1, Q3)</span></p></td></tr></tfoot></table></div>
```

## A Fancier Version for Flextable

Flextable enables you to use a variety of formatting options and to place the 
resulting tables into microsoft office documents like Word and Powerpoint using the 
package {officer}. The several packages (officer, officedown, flextable, 
mschart, rvg) used to make MS Office tables and plots
by this group based in France is often referred to as the `Officeverse`.
There is an entire [book](https://ardata-fr.github.io/flextable-book/) on how tuo
use flextable. The Officeverse book can
be found [here](https://ardata-fr.github.io/officeverse/)

Below is an example of some more complex formatting of a basic table one from
this fake chemotherapy trial.
While flextable can be used with the pipe operator, in this example we
are adding conditional formatting and styling to the table in a more 
step-by-step manner updating the flextable (my_ft) object at each step.
Conditional formatting (also available in {gt}) is helpful for highlighting
interesting results for the reader


``` r
 myft <- trial %>% 
  select(trt,age, grade, response) %>% 
  tbl_summary() %>% 
  gtsummary::as_flex_table() # builds table, converts to flextable
big_b <- fp_border_default(color = "black", width = 2) # adds black border
myft <- italic(myft, j = 1) # makes first column italic
# row numbers are referred to by i, columns by j
myft <- bg(myft, bg = "#C90000", part = "header") # red background for header
myft <- fontsize(myft, part = "all", size = 14) #fontsize for all
myft <- color(myft, color = "white", part = "header") #white text header
myft <- border_outer(myft, big_b, part = "header") # add border for header
myft <- border_outer(myft, big_b, part = "body") # Add border for body
myft <- bold(myft, i = ~ label == "Chemotherapy Treatment", 
             j = 1, bold = TRUE) # change label for Rx
myft <- color(myft, i = ~ label == "Drug A", # color drug label text by row
              color = "blue")
myft <- color(myft, i = ~ label == "Drug B", 
              color = "maroon")
myft <- bold(myft, i = ~ label == "I"| label == "II", 
             j = ~ stat_0, bold = TRUE) # highlight interesting results
myft <- color(myft, i = ~ label == "I"| label == "II", 
             j = ~ stat_0, color = "red")
myft <- autofit(myft) #autoformat column height and width
myft  # print out the table in the viewer
```

```{=html}
<div class="tabwid"><style>.cl-dc39206a{}.cl-dc331cec{font-family:'Helvetica';font-size:14pt;font-weight:bold;font-style:normal;text-decoration:none;color:rgba(255, 255, 255, 1.00);background-color:transparent;}.cl-dc331cf6{font-family:'Helvetica';font-size:8.4pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(255, 255, 255, 1.00);background-color:transparent;position: relative;bottom:4.2pt;}.cl-dc331d00{font-family:'Helvetica';font-size:14pt;font-weight:bold;font-style:italic;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-dc331d01{font-family:'Helvetica';font-size:14pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-dc331d0a{font-family:'Helvetica';font-size:14pt;font-weight:normal;font-style:italic;text-decoration:none;color:rgba(0, 0, 255, 1.00);background-color:transparent;}.cl-dc331d0b{font-family:'Helvetica';font-size:14pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 255, 1.00);background-color:transparent;}.cl-dc331d14{font-family:'Helvetica';font-size:14pt;font-weight:normal;font-style:italic;text-decoration:none;color:rgba(176, 48, 96, 1.00);background-color:transparent;}.cl-dc331d1e{font-family:'Helvetica';font-size:14pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(176, 48, 96, 1.00);background-color:transparent;}.cl-dc331d1f{font-family:'Helvetica';font-size:14pt;font-weight:normal;font-style:italic;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-dc331d20{font-family:'Helvetica';font-size:14pt;font-weight:bold;font-style:normal;text-decoration:none;color:rgba(255, 0, 0, 1.00);background-color:transparent;}.cl-dc331d28{font-family:'Helvetica';font-size:8.4pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;position: relative;bottom:4.2pt;}.cl-dc355b88{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:2pt;padding-top:2pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-dc355b92{margin:0;text-align:center;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:2pt;padding-top:2pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-dc355b9c{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-dc355b9d{margin:0;text-align:center;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-dc355ba6{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:15pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-dc355bb0{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-dc3572a8{width:2.641in;background-color:rgba(201, 0, 0, 1.00);vertical-align: middle;border-bottom: 2pt solid rgba(0, 0, 0, 1.00);border-top: 2pt solid rgba(0, 0, 0, 1.00);border-left: 2pt solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-dc3572b2{width:1.226in;background-color:rgba(201, 0, 0, 1.00);vertical-align: middle;border-bottom: 2pt solid rgba(0, 0, 0, 1.00);border-top: 2pt solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 2pt solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-dc3572b3{width:2.641in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 2pt solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-dc3572bc{width:1.226in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 2pt solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-dc3572c6{width:2.641in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 2pt solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-dc3572c7{width:1.226in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 2pt solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-dc3572d0{width:2.641in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 2pt solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-dc3572d1{width:1.226in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 2pt solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-dc3572da{width:2.641in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 2pt solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-dc3572db{width:1.226in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 2pt solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-dc3572dc{width:2.641in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 2pt solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-dc3572e4{width:1.226in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 2pt solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-dc3572e5{width:2.641in;background-color:transparent;vertical-align: top;border-bottom: 2pt solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 2pt solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-dc3572ee{width:1.226in;background-color:transparent;vertical-align: top;border-bottom: 2pt solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 2pt solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-dc3572ef{width:2.641in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(255, 255, 255, 0.00);border-top: 0 solid rgba(255, 255, 255, 0.00);border-left: 0 solid rgba(255, 255, 255, 0.00);border-right: 0 solid rgba(255, 255, 255, 0.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-dc3572f8{width:1.226in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(255, 255, 255, 0.00);border-top: 0 solid rgba(255, 255, 255, 0.00);border-left: 0 solid rgba(255, 255, 255, 0.00);border-right: 0 solid rgba(255, 255, 255, 0.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}</style><table data-quarto-disable-processing='true' class='cl-dc39206a'><thead><tr style="overflow-wrap:break-word;"><th class="cl-dc3572a8"><p class="cl-dc355b88"><span class="cl-dc331cec">Characteristic</span></p></th><th class="cl-dc3572b2"><p class="cl-dc355b92"><span class="cl-dc331cec">N = 200</span><span class="cl-dc331cf6">1</span></p></th></tr></thead><tbody><tr style="overflow-wrap:break-word;"><td class="cl-dc3572b3"><p class="cl-dc355b9c"><span class="cl-dc331d00">Chemotherapy Treatment</span></p></td><td class="cl-dc3572bc"><p class="cl-dc355b9d"><span class="cl-dc331d01"></span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-dc3572c6"><p class="cl-dc355ba6"><span class="cl-dc331d0a">Drug A</span></p></td><td class="cl-dc3572c7"><p class="cl-dc355b9d"><span class="cl-dc331d0b">98 (49%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-dc3572c6"><p class="cl-dc355ba6"><span class="cl-dc331d14">Drug B</span></p></td><td class="cl-dc3572c7"><p class="cl-dc355b9d"><span class="cl-dc331d1e">102 (51%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-dc3572c6"><p class="cl-dc355b9c"><span class="cl-dc331d1f">Age</span></p></td><td class="cl-dc3572c7"><p class="cl-dc355b9d"><span class="cl-dc331d01">47 (38, 57)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-dc3572d0"><p class="cl-dc355ba6"><span class="cl-dc331d1f">Unknown</span></p></td><td class="cl-dc3572d1"><p class="cl-dc355b9d"><span class="cl-dc331d01">11</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-dc3572da"><p class="cl-dc355b9c"><span class="cl-dc331d1f">Grade</span></p></td><td class="cl-dc3572db"><p class="cl-dc355b9d"><span class="cl-dc331d01"></span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-dc3572dc"><p class="cl-dc355ba6"><span class="cl-dc331d1f">I</span></p></td><td class="cl-dc3572e4"><p class="cl-dc355b9d"><span class="cl-dc331d20">68 (34%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-dc3572dc"><p class="cl-dc355ba6"><span class="cl-dc331d1f">II</span></p></td><td class="cl-dc3572e4"><p class="cl-dc355b9d"><span class="cl-dc331d20">68 (34%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-dc3572dc"><p class="cl-dc355ba6"><span class="cl-dc331d1f">III</span></p></td><td class="cl-dc3572e4"><p class="cl-dc355b9d"><span class="cl-dc331d01">64 (32%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-dc3572dc"><p class="cl-dc355b9c"><span class="cl-dc331d1f">Tumor Response</span></p></td><td class="cl-dc3572e4"><p class="cl-dc355b9d"><span class="cl-dc331d01">61 (32%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-dc3572e5"><p class="cl-dc355ba6"><span class="cl-dc331d1f">Unknown</span></p></td><td class="cl-dc3572ee"><p class="cl-dc355b9d"><span class="cl-dc331d01">7</span></p></td></tr></tbody><tfoot><tr style="overflow-wrap:break-word;"><td  colspan="2"class="cl-dc3572ef"><p class="cl-dc355bb0"><span class="cl-dc331d28">1</span><span class="cl-dc331d01">n (%); Median (Q1, Q3)</span></p></td></tr></tfoot></table></div>
```

