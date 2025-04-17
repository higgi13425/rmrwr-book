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
<div id="hswawgwosc" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#hswawgwosc table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#hswawgwosc thead, #hswawgwosc tbody, #hswawgwosc tfoot, #hswawgwosc tr, #hswawgwosc td, #hswawgwosc th {
  border-style: none;
}

#hswawgwosc p {
  margin: 0;
  padding: 0;
}

#hswawgwosc .gt_table {
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

#hswawgwosc .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#hswawgwosc .gt_title {
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

#hswawgwosc .gt_subtitle {
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

#hswawgwosc .gt_heading {
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

#hswawgwosc .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#hswawgwosc .gt_col_headings {
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

#hswawgwosc .gt_col_heading {
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

#hswawgwosc .gt_column_spanner_outer {
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

#hswawgwosc .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#hswawgwosc .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#hswawgwosc .gt_column_spanner {
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

#hswawgwosc .gt_spanner_row {
  border-bottom-style: hidden;
}

#hswawgwosc .gt_group_heading {
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

#hswawgwosc .gt_empty_group_heading {
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

#hswawgwosc .gt_from_md > :first-child {
  margin-top: 0;
}

#hswawgwosc .gt_from_md > :last-child {
  margin-bottom: 0;
}

#hswawgwosc .gt_row {
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

#hswawgwosc .gt_stub {
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

#hswawgwosc .gt_stub_row_group {
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

#hswawgwosc .gt_row_group_first td {
  border-top-width: 2px;
}

#hswawgwosc .gt_row_group_first th {
  border-top-width: 2px;
}

#hswawgwosc .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#hswawgwosc .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#hswawgwosc .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#hswawgwosc .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#hswawgwosc .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#hswawgwosc .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#hswawgwosc .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#hswawgwosc .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#hswawgwosc .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#hswawgwosc .gt_footnotes {
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

#hswawgwosc .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#hswawgwosc .gt_sourcenotes {
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

#hswawgwosc .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#hswawgwosc .gt_left {
  text-align: left;
}

#hswawgwosc .gt_center {
  text-align: center;
}

#hswawgwosc .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#hswawgwosc .gt_font_normal {
  font-weight: normal;
}

#hswawgwosc .gt_font_bold {
  font-weight: bold;
}

#hswawgwosc .gt_font_italic {
  font-style: italic;
}

#hswawgwosc .gt_super {
  font-size: 65%;
}

#hswawgwosc .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#hswawgwosc .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#hswawgwosc .gt_indent_1 {
  text-indent: 5px;
}

#hswawgwosc .gt_indent_2 {
  text-indent: 10px;
}

#hswawgwosc .gt_indent_3 {
  text-indent: 15px;
}

#hswawgwosc .gt_indent_4 {
  text-indent: 20px;
}

#hswawgwosc .gt_indent_5 {
  text-indent: 25px;
}

#hswawgwosc .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#hswawgwosc div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="yexvowkpiu" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#yexvowkpiu table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#yexvowkpiu thead, #yexvowkpiu tbody, #yexvowkpiu tfoot, #yexvowkpiu tr, #yexvowkpiu td, #yexvowkpiu th {
  border-style: none;
}

#yexvowkpiu p {
  margin: 0;
  padding: 0;
}

#yexvowkpiu .gt_table {
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

#yexvowkpiu .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#yexvowkpiu .gt_title {
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

#yexvowkpiu .gt_subtitle {
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

#yexvowkpiu .gt_heading {
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

#yexvowkpiu .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#yexvowkpiu .gt_col_headings {
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

#yexvowkpiu .gt_col_heading {
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

#yexvowkpiu .gt_column_spanner_outer {
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

#yexvowkpiu .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#yexvowkpiu .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#yexvowkpiu .gt_column_spanner {
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

#yexvowkpiu .gt_spanner_row {
  border-bottom-style: hidden;
}

#yexvowkpiu .gt_group_heading {
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

#yexvowkpiu .gt_empty_group_heading {
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

#yexvowkpiu .gt_from_md > :first-child {
  margin-top: 0;
}

#yexvowkpiu .gt_from_md > :last-child {
  margin-bottom: 0;
}

#yexvowkpiu .gt_row {
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

#yexvowkpiu .gt_stub {
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

#yexvowkpiu .gt_stub_row_group {
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

#yexvowkpiu .gt_row_group_first td {
  border-top-width: 2px;
}

#yexvowkpiu .gt_row_group_first th {
  border-top-width: 2px;
}

#yexvowkpiu .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#yexvowkpiu .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#yexvowkpiu .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#yexvowkpiu .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#yexvowkpiu .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#yexvowkpiu .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#yexvowkpiu .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#yexvowkpiu .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#yexvowkpiu .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#yexvowkpiu .gt_footnotes {
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

#yexvowkpiu .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#yexvowkpiu .gt_sourcenotes {
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

#yexvowkpiu .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#yexvowkpiu .gt_left {
  text-align: left;
}

#yexvowkpiu .gt_center {
  text-align: center;
}

#yexvowkpiu .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#yexvowkpiu .gt_font_normal {
  font-weight: normal;
}

#yexvowkpiu .gt_font_bold {
  font-weight: bold;
}

#yexvowkpiu .gt_font_italic {
  font-style: italic;
}

#yexvowkpiu .gt_super {
  font-size: 65%;
}

#yexvowkpiu .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#yexvowkpiu .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#yexvowkpiu .gt_indent_1 {
  text-indent: 5px;
}

#yexvowkpiu .gt_indent_2 {
  text-indent: 10px;
}

#yexvowkpiu .gt_indent_3 {
  text-indent: 15px;
}

#yexvowkpiu .gt_indent_4 {
  text-indent: 20px;
}

#yexvowkpiu .gt_indent_5 {
  text-indent: 25px;
}

#yexvowkpiu .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#yexvowkpiu div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="bkxbcxetmf" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#bkxbcxetmf table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#bkxbcxetmf thead, #bkxbcxetmf tbody, #bkxbcxetmf tfoot, #bkxbcxetmf tr, #bkxbcxetmf td, #bkxbcxetmf th {
  border-style: none;
}

#bkxbcxetmf p {
  margin: 0;
  padding: 0;
}

#bkxbcxetmf .gt_table {
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

#bkxbcxetmf .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#bkxbcxetmf .gt_title {
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

#bkxbcxetmf .gt_subtitle {
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

#bkxbcxetmf .gt_heading {
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

#bkxbcxetmf .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#bkxbcxetmf .gt_col_headings {
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

#bkxbcxetmf .gt_col_heading {
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

#bkxbcxetmf .gt_column_spanner_outer {
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

#bkxbcxetmf .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#bkxbcxetmf .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#bkxbcxetmf .gt_column_spanner {
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

#bkxbcxetmf .gt_spanner_row {
  border-bottom-style: hidden;
}

#bkxbcxetmf .gt_group_heading {
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

#bkxbcxetmf .gt_empty_group_heading {
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

#bkxbcxetmf .gt_from_md > :first-child {
  margin-top: 0;
}

#bkxbcxetmf .gt_from_md > :last-child {
  margin-bottom: 0;
}

#bkxbcxetmf .gt_row {
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

#bkxbcxetmf .gt_stub {
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

#bkxbcxetmf .gt_stub_row_group {
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

#bkxbcxetmf .gt_row_group_first td {
  border-top-width: 2px;
}

#bkxbcxetmf .gt_row_group_first th {
  border-top-width: 2px;
}

#bkxbcxetmf .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#bkxbcxetmf .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#bkxbcxetmf .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#bkxbcxetmf .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#bkxbcxetmf .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#bkxbcxetmf .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#bkxbcxetmf .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#bkxbcxetmf .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#bkxbcxetmf .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#bkxbcxetmf .gt_footnotes {
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

#bkxbcxetmf .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#bkxbcxetmf .gt_sourcenotes {
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

#bkxbcxetmf .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#bkxbcxetmf .gt_left {
  text-align: left;
}

#bkxbcxetmf .gt_center {
  text-align: center;
}

#bkxbcxetmf .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#bkxbcxetmf .gt_font_normal {
  font-weight: normal;
}

#bkxbcxetmf .gt_font_bold {
  font-weight: bold;
}

#bkxbcxetmf .gt_font_italic {
  font-style: italic;
}

#bkxbcxetmf .gt_super {
  font-size: 65%;
}

#bkxbcxetmf .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#bkxbcxetmf .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#bkxbcxetmf .gt_indent_1 {
  text-indent: 5px;
}

#bkxbcxetmf .gt_indent_2 {
  text-indent: 10px;
}

#bkxbcxetmf .gt_indent_3 {
  text-indent: 15px;
}

#bkxbcxetmf .gt_indent_4 {
  text-indent: 20px;
}

#bkxbcxetmf .gt_indent_5 {
  text-indent: 25px;
}

#bkxbcxetmf .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#bkxbcxetmf div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="ykvbxfofkg" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#ykvbxfofkg table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#ykvbxfofkg thead, #ykvbxfofkg tbody, #ykvbxfofkg tfoot, #ykvbxfofkg tr, #ykvbxfofkg td, #ykvbxfofkg th {
  border-style: none;
}

#ykvbxfofkg p {
  margin: 0;
  padding: 0;
}

#ykvbxfofkg .gt_table {
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

#ykvbxfofkg .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#ykvbxfofkg .gt_title {
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

#ykvbxfofkg .gt_subtitle {
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

#ykvbxfofkg .gt_heading {
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

#ykvbxfofkg .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ykvbxfofkg .gt_col_headings {
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

#ykvbxfofkg .gt_col_heading {
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

#ykvbxfofkg .gt_column_spanner_outer {
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

#ykvbxfofkg .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#ykvbxfofkg .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#ykvbxfofkg .gt_column_spanner {
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

#ykvbxfofkg .gt_spanner_row {
  border-bottom-style: hidden;
}

#ykvbxfofkg .gt_group_heading {
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

#ykvbxfofkg .gt_empty_group_heading {
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

#ykvbxfofkg .gt_from_md > :first-child {
  margin-top: 0;
}

#ykvbxfofkg .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ykvbxfofkg .gt_row {
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

#ykvbxfofkg .gt_stub {
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

#ykvbxfofkg .gt_stub_row_group {
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

#ykvbxfofkg .gt_row_group_first td {
  border-top-width: 2px;
}

#ykvbxfofkg .gt_row_group_first th {
  border-top-width: 2px;
}

#ykvbxfofkg .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ykvbxfofkg .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#ykvbxfofkg .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#ykvbxfofkg .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ykvbxfofkg .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ykvbxfofkg .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#ykvbxfofkg .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#ykvbxfofkg .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#ykvbxfofkg .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ykvbxfofkg .gt_footnotes {
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

#ykvbxfofkg .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ykvbxfofkg .gt_sourcenotes {
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

#ykvbxfofkg .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ykvbxfofkg .gt_left {
  text-align: left;
}

#ykvbxfofkg .gt_center {
  text-align: center;
}

#ykvbxfofkg .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ykvbxfofkg .gt_font_normal {
  font-weight: normal;
}

#ykvbxfofkg .gt_font_bold {
  font-weight: bold;
}

#ykvbxfofkg .gt_font_italic {
  font-style: italic;
}

#ykvbxfofkg .gt_super {
  font-size: 65%;
}

#ykvbxfofkg .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#ykvbxfofkg .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#ykvbxfofkg .gt_indent_1 {
  text-indent: 5px;
}

#ykvbxfofkg .gt_indent_2 {
  text-indent: 10px;
}

#ykvbxfofkg .gt_indent_3 {
  text-indent: 15px;
}

#ykvbxfofkg .gt_indent_4 {
  text-indent: 20px;
}

#ykvbxfofkg .gt_indent_5 {
  text-indent: 25px;
}

#ykvbxfofkg .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#ykvbxfofkg div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="cabxuycwib" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#cabxuycwib table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#cabxuycwib thead, #cabxuycwib tbody, #cabxuycwib tfoot, #cabxuycwib tr, #cabxuycwib td, #cabxuycwib th {
  border-style: none;
}

#cabxuycwib p {
  margin: 0;
  padding: 0;
}

#cabxuycwib .gt_table {
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

#cabxuycwib .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#cabxuycwib .gt_title {
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

#cabxuycwib .gt_subtitle {
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

#cabxuycwib .gt_heading {
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

#cabxuycwib .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#cabxuycwib .gt_col_headings {
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

#cabxuycwib .gt_col_heading {
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

#cabxuycwib .gt_column_spanner_outer {
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

#cabxuycwib .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#cabxuycwib .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#cabxuycwib .gt_column_spanner {
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

#cabxuycwib .gt_spanner_row {
  border-bottom-style: hidden;
}

#cabxuycwib .gt_group_heading {
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

#cabxuycwib .gt_empty_group_heading {
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

#cabxuycwib .gt_from_md > :first-child {
  margin-top: 0;
}

#cabxuycwib .gt_from_md > :last-child {
  margin-bottom: 0;
}

#cabxuycwib .gt_row {
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

#cabxuycwib .gt_stub {
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

#cabxuycwib .gt_stub_row_group {
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

#cabxuycwib .gt_row_group_first td {
  border-top-width: 2px;
}

#cabxuycwib .gt_row_group_first th {
  border-top-width: 2px;
}

#cabxuycwib .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#cabxuycwib .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#cabxuycwib .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#cabxuycwib .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#cabxuycwib .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#cabxuycwib .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#cabxuycwib .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#cabxuycwib .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#cabxuycwib .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#cabxuycwib .gt_footnotes {
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

#cabxuycwib .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#cabxuycwib .gt_sourcenotes {
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

#cabxuycwib .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#cabxuycwib .gt_left {
  text-align: left;
}

#cabxuycwib .gt_center {
  text-align: center;
}

#cabxuycwib .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#cabxuycwib .gt_font_normal {
  font-weight: normal;
}

#cabxuycwib .gt_font_bold {
  font-weight: bold;
}

#cabxuycwib .gt_font_italic {
  font-style: italic;
}

#cabxuycwib .gt_super {
  font-size: 65%;
}

#cabxuycwib .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#cabxuycwib .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#cabxuycwib .gt_indent_1 {
  text-indent: 5px;
}

#cabxuycwib .gt_indent_2 {
  text-indent: 10px;
}

#cabxuycwib .gt_indent_3 {
  text-indent: 15px;
}

#cabxuycwib .gt_indent_4 {
  text-indent: 20px;
}

#cabxuycwib .gt_indent_5 {
  text-indent: 25px;
}

#cabxuycwib .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#cabxuycwib div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="kfadisudrw" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#kfadisudrw table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#kfadisudrw thead, #kfadisudrw tbody, #kfadisudrw tfoot, #kfadisudrw tr, #kfadisudrw td, #kfadisudrw th {
  border-style: none;
}

#kfadisudrw p {
  margin: 0;
  padding: 0;
}

#kfadisudrw .gt_table {
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

#kfadisudrw .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#kfadisudrw .gt_title {
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

#kfadisudrw .gt_subtitle {
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

#kfadisudrw .gt_heading {
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

#kfadisudrw .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#kfadisudrw .gt_col_headings {
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

#kfadisudrw .gt_col_heading {
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

#kfadisudrw .gt_column_spanner_outer {
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

#kfadisudrw .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#kfadisudrw .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#kfadisudrw .gt_column_spanner {
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

#kfadisudrw .gt_spanner_row {
  border-bottom-style: hidden;
}

#kfadisudrw .gt_group_heading {
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

#kfadisudrw .gt_empty_group_heading {
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

#kfadisudrw .gt_from_md > :first-child {
  margin-top: 0;
}

#kfadisudrw .gt_from_md > :last-child {
  margin-bottom: 0;
}

#kfadisudrw .gt_row {
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

#kfadisudrw .gt_stub {
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

#kfadisudrw .gt_stub_row_group {
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

#kfadisudrw .gt_row_group_first td {
  border-top-width: 2px;
}

#kfadisudrw .gt_row_group_first th {
  border-top-width: 2px;
}

#kfadisudrw .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#kfadisudrw .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#kfadisudrw .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#kfadisudrw .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#kfadisudrw .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#kfadisudrw .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#kfadisudrw .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#kfadisudrw .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#kfadisudrw .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#kfadisudrw .gt_footnotes {
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

#kfadisudrw .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#kfadisudrw .gt_sourcenotes {
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

#kfadisudrw .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#kfadisudrw .gt_left {
  text-align: left;
}

#kfadisudrw .gt_center {
  text-align: center;
}

#kfadisudrw .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#kfadisudrw .gt_font_normal {
  font-weight: normal;
}

#kfadisudrw .gt_font_bold {
  font-weight: bold;
}

#kfadisudrw .gt_font_italic {
  font-style: italic;
}

#kfadisudrw .gt_super {
  font-size: 65%;
}

#kfadisudrw .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#kfadisudrw .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#kfadisudrw .gt_indent_1 {
  text-indent: 5px;
}

#kfadisudrw .gt_indent_2 {
  text-indent: 10px;
}

#kfadisudrw .gt_indent_3 {
  text-indent: 15px;
}

#kfadisudrw .gt_indent_4 {
  text-indent: 20px;
}

#kfadisudrw .gt_indent_5 {
  text-indent: 25px;
}

#kfadisudrw .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#kfadisudrw div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="vpezjpdxbx" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#vpezjpdxbx table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#vpezjpdxbx thead, #vpezjpdxbx tbody, #vpezjpdxbx tfoot, #vpezjpdxbx tr, #vpezjpdxbx td, #vpezjpdxbx th {
  border-style: none;
}

#vpezjpdxbx p {
  margin: 0;
  padding: 0;
}

#vpezjpdxbx .gt_table {
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

#vpezjpdxbx .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#vpezjpdxbx .gt_title {
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

#vpezjpdxbx .gt_subtitle {
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

#vpezjpdxbx .gt_heading {
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

#vpezjpdxbx .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#vpezjpdxbx .gt_col_headings {
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

#vpezjpdxbx .gt_col_heading {
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

#vpezjpdxbx .gt_column_spanner_outer {
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

#vpezjpdxbx .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#vpezjpdxbx .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#vpezjpdxbx .gt_column_spanner {
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

#vpezjpdxbx .gt_spanner_row {
  border-bottom-style: hidden;
}

#vpezjpdxbx .gt_group_heading {
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

#vpezjpdxbx .gt_empty_group_heading {
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

#vpezjpdxbx .gt_from_md > :first-child {
  margin-top: 0;
}

#vpezjpdxbx .gt_from_md > :last-child {
  margin-bottom: 0;
}

#vpezjpdxbx .gt_row {
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

#vpezjpdxbx .gt_stub {
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

#vpezjpdxbx .gt_stub_row_group {
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

#vpezjpdxbx .gt_row_group_first td {
  border-top-width: 2px;
}

#vpezjpdxbx .gt_row_group_first th {
  border-top-width: 2px;
}

#vpezjpdxbx .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#vpezjpdxbx .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#vpezjpdxbx .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#vpezjpdxbx .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#vpezjpdxbx .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#vpezjpdxbx .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#vpezjpdxbx .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#vpezjpdxbx .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#vpezjpdxbx .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#vpezjpdxbx .gt_footnotes {
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

#vpezjpdxbx .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#vpezjpdxbx .gt_sourcenotes {
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

#vpezjpdxbx .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#vpezjpdxbx .gt_left {
  text-align: left;
}

#vpezjpdxbx .gt_center {
  text-align: center;
}

#vpezjpdxbx .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#vpezjpdxbx .gt_font_normal {
  font-weight: normal;
}

#vpezjpdxbx .gt_font_bold {
  font-weight: bold;
}

#vpezjpdxbx .gt_font_italic {
  font-style: italic;
}

#vpezjpdxbx .gt_super {
  font-size: 65%;
}

#vpezjpdxbx .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#vpezjpdxbx .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#vpezjpdxbx .gt_indent_1 {
  text-indent: 5px;
}

#vpezjpdxbx .gt_indent_2 {
  text-indent: 10px;
}

#vpezjpdxbx .gt_indent_3 {
  text-indent: 15px;
}

#vpezjpdxbx .gt_indent_4 {
  text-indent: 20px;
}

#vpezjpdxbx .gt_indent_5 {
  text-indent: 25px;
}

#vpezjpdxbx .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#vpezjpdxbx div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="ifbjrshgra" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>@import url("https://fonts.googleapis.com/css2?family=Atkinson+Hyperlegible+Next:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap");
#ifbjrshgra table {
  font-family: 'Atkinson Hyperlegible Next', system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#ifbjrshgra thead, #ifbjrshgra tbody, #ifbjrshgra tfoot, #ifbjrshgra tr, #ifbjrshgra td, #ifbjrshgra th {
  border-style: none;
}

#ifbjrshgra p {
  margin: 0;
  padding: 0;
}

#ifbjrshgra .gt_table {
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

#ifbjrshgra .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#ifbjrshgra .gt_title {
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

#ifbjrshgra .gt_subtitle {
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

#ifbjrshgra .gt_heading {
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

#ifbjrshgra .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ifbjrshgra .gt_col_headings {
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

#ifbjrshgra .gt_col_heading {
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

#ifbjrshgra .gt_column_spanner_outer {
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

#ifbjrshgra .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#ifbjrshgra .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#ifbjrshgra .gt_column_spanner {
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

#ifbjrshgra .gt_spanner_row {
  border-bottom-style: hidden;
}

#ifbjrshgra .gt_group_heading {
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

#ifbjrshgra .gt_empty_group_heading {
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

#ifbjrshgra .gt_from_md > :first-child {
  margin-top: 0;
}

#ifbjrshgra .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ifbjrshgra .gt_row {
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

#ifbjrshgra .gt_stub {
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

#ifbjrshgra .gt_stub_row_group {
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

#ifbjrshgra .gt_row_group_first td {
  border-top-width: 2px;
}

#ifbjrshgra .gt_row_group_first th {
  border-top-width: 2px;
}

#ifbjrshgra .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ifbjrshgra .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#ifbjrshgra .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#ifbjrshgra .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ifbjrshgra .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ifbjrshgra .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#ifbjrshgra .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#ifbjrshgra .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#ifbjrshgra .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ifbjrshgra .gt_footnotes {
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

#ifbjrshgra .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ifbjrshgra .gt_sourcenotes {
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

#ifbjrshgra .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ifbjrshgra .gt_left {
  text-align: left;
}

#ifbjrshgra .gt_center {
  text-align: center;
}

#ifbjrshgra .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ifbjrshgra .gt_font_normal {
  font-weight: normal;
}

#ifbjrshgra .gt_font_bold {
  font-weight: bold;
}

#ifbjrshgra .gt_font_italic {
  font-style: italic;
}

#ifbjrshgra .gt_super {
  font-size: 65%;
}

#ifbjrshgra .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#ifbjrshgra .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#ifbjrshgra .gt_indent_1 {
  text-indent: 5px;
}

#ifbjrshgra .gt_indent_2 {
  text-indent: 10px;
}

#ifbjrshgra .gt_indent_3 {
  text-indent: 15px;
}

#ifbjrshgra .gt_indent_4 {
  text-indent: 20px;
}

#ifbjrshgra .gt_indent_5 {
  text-indent: 25px;
}

#ifbjrshgra .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#ifbjrshgra div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="ieumzgreyc" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>@import url("https://fonts.googleapis.com/css2?family=Orbitron:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap");
#ieumzgreyc table {
  font-family: Orbitron, system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#ieumzgreyc thead, #ieumzgreyc tbody, #ieumzgreyc tfoot, #ieumzgreyc tr, #ieumzgreyc td, #ieumzgreyc th {
  border-style: none;
}

#ieumzgreyc p {
  margin: 0;
  padding: 0;
}

#ieumzgreyc .gt_table {
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

#ieumzgreyc .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#ieumzgreyc .gt_title {
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

#ieumzgreyc .gt_subtitle {
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

#ieumzgreyc .gt_heading {
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

#ieumzgreyc .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ieumzgreyc .gt_col_headings {
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

#ieumzgreyc .gt_col_heading {
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

#ieumzgreyc .gt_column_spanner_outer {
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

#ieumzgreyc .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#ieumzgreyc .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#ieumzgreyc .gt_column_spanner {
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

#ieumzgreyc .gt_spanner_row {
  border-bottom-style: hidden;
}

#ieumzgreyc .gt_group_heading {
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

#ieumzgreyc .gt_empty_group_heading {
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

#ieumzgreyc .gt_from_md > :first-child {
  margin-top: 0;
}

#ieumzgreyc .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ieumzgreyc .gt_row {
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

#ieumzgreyc .gt_stub {
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

#ieumzgreyc .gt_stub_row_group {
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

#ieumzgreyc .gt_row_group_first td {
  border-top-width: 2px;
}

#ieumzgreyc .gt_row_group_first th {
  border-top-width: 2px;
}

#ieumzgreyc .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ieumzgreyc .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#ieumzgreyc .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#ieumzgreyc .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ieumzgreyc .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ieumzgreyc .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#ieumzgreyc .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#ieumzgreyc .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#ieumzgreyc .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ieumzgreyc .gt_footnotes {
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

#ieumzgreyc .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ieumzgreyc .gt_sourcenotes {
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

#ieumzgreyc .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ieumzgreyc .gt_left {
  text-align: left;
}

#ieumzgreyc .gt_center {
  text-align: center;
}

#ieumzgreyc .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ieumzgreyc .gt_font_normal {
  font-weight: normal;
}

#ieumzgreyc .gt_font_bold {
  font-weight: bold;
}

#ieumzgreyc .gt_font_italic {
  font-style: italic;
}

#ieumzgreyc .gt_super {
  font-size: 65%;
}

#ieumzgreyc .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#ieumzgreyc .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#ieumzgreyc .gt_indent_1 {
  text-indent: 5px;
}

#ieumzgreyc .gt_indent_2 {
  text-indent: 10px;
}

#ieumzgreyc .gt_indent_3 {
  text-indent: 15px;
}

#ieumzgreyc .gt_indent_4 {
  text-indent: 20px;
}

#ieumzgreyc .gt_indent_5 {
  text-indent: 25px;
}

#ieumzgreyc .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#ieumzgreyc div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div class="tabwid"><style>.cl-ebd8a260{}.cl-ebd4c49c{font-family:'Brush Script MT';font-size:18pt;font-weight:bold;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-ebd4c4a6{font-family:'Brush Script MT';font-size:10.8pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;position: relative;bottom:5.4pt;}.cl-ebd4c4a7{font-family:'Helvetica';font-size:11pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-ebd4c4b0{font-family:'Helvetica';font-size:6.6pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;position: relative;bottom:3.3pt;}.cl-ebd61eaa{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:2pt;padding-top:2pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-ebd61eb4{margin:0;text-align:center;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:2pt;padding-top:2pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-ebd61eb5{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-ebd61eb6{margin:0;text-align:center;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-ebd61eb7{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:15pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-ebd61ebe{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-ebd62ce2{width:2.026in;background-color:transparent;vertical-align: middle;border-bottom: 1pt solid rgba(0, 0, 0, 1.00);border-top: 1pt solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ebd62ce3{width:1.024in;background-color:transparent;vertical-align: middle;border-bottom: 1pt solid rgba(0, 0, 0, 1.00);border-top: 1pt solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ebd62cec{width:2.026in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ebd62ced{width:1.024in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ebd62cf6{width:2.026in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ebd62cf7{width:1.024in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ebd62cf8{width:2.026in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ebd62d00{width:1.024in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ebd62d01{width:2.026in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ebd62d02{width:1.024in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ebd62d03{width:2.026in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ebd62d0a{width:1.024in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ebd62d0b{width:2.026in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ebd62d0c{width:1.024in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ebd62d0d{width:2.026in;background-color:transparent;vertical-align: top;border-bottom: 1pt solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ebd62d14{width:1.024in;background-color:transparent;vertical-align: top;border-bottom: 1pt solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ebd62d15{width:2.026in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(255, 255, 255, 0.00);border-top: 0 solid rgba(255, 255, 255, 0.00);border-left: 0 solid rgba(255, 255, 255, 0.00);border-right: 0 solid rgba(255, 255, 255, 0.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ebd62d16{width:1.024in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(255, 255, 255, 0.00);border-top: 0 solid rgba(255, 255, 255, 0.00);border-left: 0 solid rgba(255, 255, 255, 0.00);border-right: 0 solid rgba(255, 255, 255, 0.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}</style><table data-quarto-disable-processing='true' class='cl-ebd8a260'><thead><tr style="overflow-wrap:break-word;"><th class="cl-ebd62ce2"><p class="cl-ebd61eaa"><span class="cl-ebd4c49c">Characteristic</span></p></th><th class="cl-ebd62ce3"><p class="cl-ebd61eb4"><span class="cl-ebd4c49c">N = 200</span><span class="cl-ebd4c4a6">1</span></p></th></tr></thead><tbody><tr style="overflow-wrap:break-word;"><td class="cl-ebd62cec"><p class="cl-ebd61eb5"><span class="cl-ebd4c4a7">Chemotherapy Treatment</span></p></td><td class="cl-ebd62ced"><p class="cl-ebd61eb6"><span class="cl-ebd4c4a7"></span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-ebd62cf6"><p class="cl-ebd61eb7"><span class="cl-ebd4c4a7">Drug A</span></p></td><td class="cl-ebd62cf7"><p class="cl-ebd61eb6"><span class="cl-ebd4c4a7">98 (49%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-ebd62cf6"><p class="cl-ebd61eb7"><span class="cl-ebd4c4a7">Drug B</span></p></td><td class="cl-ebd62cf7"><p class="cl-ebd61eb6"><span class="cl-ebd4c4a7">102 (51%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-ebd62cf6"><p class="cl-ebd61eb5"><span class="cl-ebd4c4a7">Age</span></p></td><td class="cl-ebd62cf7"><p class="cl-ebd61eb6"><span class="cl-ebd4c4a7">47 (38, 57)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-ebd62cf8"><p class="cl-ebd61eb7"><span class="cl-ebd4c4a7">Unknown</span></p></td><td class="cl-ebd62d00"><p class="cl-ebd61eb6"><span class="cl-ebd4c4a7">11</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-ebd62d01"><p class="cl-ebd61eb5"><span class="cl-ebd4c4a7">T Stage</span></p></td><td class="cl-ebd62d02"><p class="cl-ebd61eb6"><span class="cl-ebd4c4a7"></span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-ebd62d03"><p class="cl-ebd61eb7"><span class="cl-ebd4c4a7">T1</span></p></td><td class="cl-ebd62d0a"><p class="cl-ebd61eb6"><span class="cl-ebd4c4a7">53 (27%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-ebd62d03"><p class="cl-ebd61eb7"><span class="cl-ebd4c4a7">T2</span></p></td><td class="cl-ebd62d0a"><p class="cl-ebd61eb6"><span class="cl-ebd4c4a7">54 (27%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-ebd62d03"><p class="cl-ebd61eb7"><span class="cl-ebd4c4a7">T3</span></p></td><td class="cl-ebd62d0a"><p class="cl-ebd61eb6"><span class="cl-ebd4c4a7">43 (22%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-ebd62d03"><p class="cl-ebd61eb7"><span class="cl-ebd4c4a7">T4</span></p></td><td class="cl-ebd62d0a"><p class="cl-ebd61eb6"><span class="cl-ebd4c4a7">50 (25%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-ebd62d0b"><p class="cl-ebd61eb5"><span class="cl-ebd4c4a7">Grade</span></p></td><td class="cl-ebd62d0c"><p class="cl-ebd61eb6"><span class="cl-ebd4c4a7"></span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-ebd62d03"><p class="cl-ebd61eb7"><span class="cl-ebd4c4a7">I</span></p></td><td class="cl-ebd62d0a"><p class="cl-ebd61eb6"><span class="cl-ebd4c4a7">68 (34%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-ebd62d03"><p class="cl-ebd61eb7"><span class="cl-ebd4c4a7">II</span></p></td><td class="cl-ebd62d0a"><p class="cl-ebd61eb6"><span class="cl-ebd4c4a7">68 (34%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-ebd62d0d"><p class="cl-ebd61eb7"><span class="cl-ebd4c4a7">III</span></p></td><td class="cl-ebd62d14"><p class="cl-ebd61eb6"><span class="cl-ebd4c4a7">64 (32%)</span></p></td></tr></tbody><tfoot><tr style="overflow-wrap:break-word;"><td  colspan="2"class="cl-ebd62d15"><p class="cl-ebd61ebe"><span class="cl-ebd4c4b0">1</span><span class="cl-ebd4c4a7">n (%); Median (Q1, Q3)</span></p></td></tr></tfoot></table></div>
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
<div class="tabwid"><style>.cl-ec22d79a{}.cl-ec1f10e2{font-family:'Helvetica';font-size:14pt;font-weight:bold;font-style:normal;text-decoration:none;color:rgba(255, 255, 255, 1.00);background-color:transparent;}.cl-ec1f10ec{font-family:'Helvetica';font-size:8.4pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(255, 255, 255, 1.00);background-color:transparent;position: relative;bottom:4.2pt;}.cl-ec1f10f6{font-family:'Helvetica';font-size:14pt;font-weight:bold;font-style:italic;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-ec1f10f7{font-family:'Helvetica';font-size:14pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-ec1f10f8{font-family:'Helvetica';font-size:14pt;font-weight:normal;font-style:italic;text-decoration:none;color:rgba(0, 0, 255, 1.00);background-color:transparent;}.cl-ec1f1100{font-family:'Helvetica';font-size:14pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 255, 1.00);background-color:transparent;}.cl-ec1f1101{font-family:'Helvetica';font-size:14pt;font-weight:normal;font-style:italic;text-decoration:none;color:rgba(176, 48, 96, 1.00);background-color:transparent;}.cl-ec1f1102{font-family:'Helvetica';font-size:14pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(176, 48, 96, 1.00);background-color:transparent;}.cl-ec1f110a{font-family:'Helvetica';font-size:14pt;font-weight:normal;font-style:italic;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-ec1f110b{font-family:'Helvetica';font-size:14pt;font-weight:bold;font-style:normal;text-decoration:none;color:rgba(255, 0, 0, 1.00);background-color:transparent;}.cl-ec1f110c{font-family:'Helvetica';font-size:8.4pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;position: relative;bottom:4.2pt;}.cl-ec2064e2{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:2pt;padding-top:2pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-ec2064ec{margin:0;text-align:center;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:2pt;padding-top:2pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-ec2064ed{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-ec2064ee{margin:0;text-align:center;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-ec2064f6{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:15pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-ec2064f7{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-ec2071e4{width:2.641in;background-color:rgba(201, 0, 0, 1.00);vertical-align: middle;border-bottom: 2pt solid rgba(0, 0, 0, 1.00);border-top: 2pt solid rgba(0, 0, 0, 1.00);border-left: 2pt solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec2071e5{width:1.226in;background-color:rgba(201, 0, 0, 1.00);vertical-align: middle;border-bottom: 2pt solid rgba(0, 0, 0, 1.00);border-top: 2pt solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 2pt solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec2071e6{width:2.641in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 2pt solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec2071e7{width:1.226in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 2pt solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec2071ee{width:2.641in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 2pt solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec2071ef{width:1.226in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 2pt solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec2071f8{width:2.641in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 2pt solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec2071f9{width:1.226in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 2pt solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec2071fa{width:2.641in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 2pt solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec207202{width:1.226in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 2pt solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec207203{width:2.641in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 2pt solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec207204{width:1.226in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 2pt solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec20720c{width:2.641in;background-color:transparent;vertical-align: top;border-bottom: 2pt solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 2pt solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec20720d{width:1.226in;background-color:transparent;vertical-align: top;border-bottom: 2pt solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 2pt solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec20720e{width:2.641in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(255, 255, 255, 0.00);border-top: 0 solid rgba(255, 255, 255, 0.00);border-left: 0 solid rgba(255, 255, 255, 0.00);border-right: 0 solid rgba(255, 255, 255, 0.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec207216{width:1.226in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(255, 255, 255, 0.00);border-top: 0 solid rgba(255, 255, 255, 0.00);border-left: 0 solid rgba(255, 255, 255, 0.00);border-right: 0 solid rgba(255, 255, 255, 0.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}</style><table data-quarto-disable-processing='true' class='cl-ec22d79a'><thead><tr style="overflow-wrap:break-word;"><th class="cl-ec2071e4"><p class="cl-ec2064e2"><span class="cl-ec1f10e2">Characteristic</span></p></th><th class="cl-ec2071e5"><p class="cl-ec2064ec"><span class="cl-ec1f10e2">N = 200</span><span class="cl-ec1f10ec">1</span></p></th></tr></thead><tbody><tr style="overflow-wrap:break-word;"><td class="cl-ec2071e6"><p class="cl-ec2064ed"><span class="cl-ec1f10f6">Chemotherapy Treatment</span></p></td><td class="cl-ec2071e7"><p class="cl-ec2064ee"><span class="cl-ec1f10f7"></span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-ec2071ee"><p class="cl-ec2064f6"><span class="cl-ec1f10f8">Drug A</span></p></td><td class="cl-ec2071ef"><p class="cl-ec2064ee"><span class="cl-ec1f1100">98 (49%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-ec2071ee"><p class="cl-ec2064f6"><span class="cl-ec1f1101">Drug B</span></p></td><td class="cl-ec2071ef"><p class="cl-ec2064ee"><span class="cl-ec1f1102">102 (51%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-ec2071ee"><p class="cl-ec2064ed"><span class="cl-ec1f110a">Age</span></p></td><td class="cl-ec2071ef"><p class="cl-ec2064ee"><span class="cl-ec1f10f7">47 (38, 57)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-ec2071f8"><p class="cl-ec2064f6"><span class="cl-ec1f110a">Unknown</span></p></td><td class="cl-ec2071f9"><p class="cl-ec2064ee"><span class="cl-ec1f10f7">11</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-ec2071fa"><p class="cl-ec2064ed"><span class="cl-ec1f110a">Grade</span></p></td><td class="cl-ec207202"><p class="cl-ec2064ee"><span class="cl-ec1f10f7"></span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-ec207203"><p class="cl-ec2064f6"><span class="cl-ec1f110a">I</span></p></td><td class="cl-ec207204"><p class="cl-ec2064ee"><span class="cl-ec1f110b">68 (34%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-ec207203"><p class="cl-ec2064f6"><span class="cl-ec1f110a">II</span></p></td><td class="cl-ec207204"><p class="cl-ec2064ee"><span class="cl-ec1f110b">68 (34%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-ec207203"><p class="cl-ec2064f6"><span class="cl-ec1f110a">III</span></p></td><td class="cl-ec207204"><p class="cl-ec2064ee"><span class="cl-ec1f10f7">64 (32%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-ec207203"><p class="cl-ec2064ed"><span class="cl-ec1f110a">Tumor Response</span></p></td><td class="cl-ec207204"><p class="cl-ec2064ee"><span class="cl-ec1f10f7">61 (32%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-ec20720c"><p class="cl-ec2064f6"><span class="cl-ec1f110a">Unknown</span></p></td><td class="cl-ec20720d"><p class="cl-ec2064ee"><span class="cl-ec1f10f7">7</span></p></td></tr></tbody><tfoot><tr style="overflow-wrap:break-word;"><td  colspan="2"class="cl-ec20720e"><p class="cl-ec2064f7"><span class="cl-ec1f110c">1</span><span class="cl-ec1f10f7">n (%); Median (Q1, Q3)</span></p></td></tr></tfoot></table></div>
```

