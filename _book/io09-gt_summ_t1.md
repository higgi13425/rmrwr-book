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
<div id="uioftdvque" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#uioftdvque table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#uioftdvque thead, #uioftdvque tbody, #uioftdvque tfoot, #uioftdvque tr, #uioftdvque td, #uioftdvque th {
  border-style: none;
}

#uioftdvque p {
  margin: 0;
  padding: 0;
}

#uioftdvque .gt_table {
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

#uioftdvque .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#uioftdvque .gt_title {
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

#uioftdvque .gt_subtitle {
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

#uioftdvque .gt_heading {
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

#uioftdvque .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#uioftdvque .gt_col_headings {
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

#uioftdvque .gt_col_heading {
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

#uioftdvque .gt_column_spanner_outer {
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

#uioftdvque .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#uioftdvque .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#uioftdvque .gt_column_spanner {
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

#uioftdvque .gt_spanner_row {
  border-bottom-style: hidden;
}

#uioftdvque .gt_group_heading {
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

#uioftdvque .gt_empty_group_heading {
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

#uioftdvque .gt_from_md > :first-child {
  margin-top: 0;
}

#uioftdvque .gt_from_md > :last-child {
  margin-bottom: 0;
}

#uioftdvque .gt_row {
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

#uioftdvque .gt_stub {
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

#uioftdvque .gt_stub_row_group {
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

#uioftdvque .gt_row_group_first td {
  border-top-width: 2px;
}

#uioftdvque .gt_row_group_first th {
  border-top-width: 2px;
}

#uioftdvque .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#uioftdvque .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#uioftdvque .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#uioftdvque .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#uioftdvque .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#uioftdvque .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#uioftdvque .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#uioftdvque .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#uioftdvque .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#uioftdvque .gt_footnotes {
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

#uioftdvque .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#uioftdvque .gt_sourcenotes {
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

#uioftdvque .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#uioftdvque .gt_left {
  text-align: left;
}

#uioftdvque .gt_center {
  text-align: center;
}

#uioftdvque .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#uioftdvque .gt_font_normal {
  font-weight: normal;
}

#uioftdvque .gt_font_bold {
  font-weight: bold;
}

#uioftdvque .gt_font_italic {
  font-style: italic;
}

#uioftdvque .gt_super {
  font-size: 65%;
}

#uioftdvque .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#uioftdvque .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#uioftdvque .gt_indent_1 {
  text-indent: 5px;
}

#uioftdvque .gt_indent_2 {
  text-indent: 10px;
}

#uioftdvque .gt_indent_3 {
  text-indent: 15px;
}

#uioftdvque .gt_indent_4 {
  text-indent: 20px;
}

#uioftdvque .gt_indent_5 {
  text-indent: 25px;
}

#uioftdvque .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#uioftdvque div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
  <tfoot>
    <tr class="gt_footnotes">
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
<div id="npepwxhlwr" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#npepwxhlwr table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#npepwxhlwr thead, #npepwxhlwr tbody, #npepwxhlwr tfoot, #npepwxhlwr tr, #npepwxhlwr td, #npepwxhlwr th {
  border-style: none;
}

#npepwxhlwr p {
  margin: 0;
  padding: 0;
}

#npepwxhlwr .gt_table {
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

#npepwxhlwr .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#npepwxhlwr .gt_title {
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

#npepwxhlwr .gt_subtitle {
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

#npepwxhlwr .gt_heading {
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

#npepwxhlwr .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#npepwxhlwr .gt_col_headings {
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

#npepwxhlwr .gt_col_heading {
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

#npepwxhlwr .gt_column_spanner_outer {
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

#npepwxhlwr .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#npepwxhlwr .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#npepwxhlwr .gt_column_spanner {
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

#npepwxhlwr .gt_spanner_row {
  border-bottom-style: hidden;
}

#npepwxhlwr .gt_group_heading {
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

#npepwxhlwr .gt_empty_group_heading {
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

#npepwxhlwr .gt_from_md > :first-child {
  margin-top: 0;
}

#npepwxhlwr .gt_from_md > :last-child {
  margin-bottom: 0;
}

#npepwxhlwr .gt_row {
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

#npepwxhlwr .gt_stub {
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

#npepwxhlwr .gt_stub_row_group {
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

#npepwxhlwr .gt_row_group_first td {
  border-top-width: 2px;
}

#npepwxhlwr .gt_row_group_first th {
  border-top-width: 2px;
}

#npepwxhlwr .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#npepwxhlwr .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#npepwxhlwr .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#npepwxhlwr .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#npepwxhlwr .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#npepwxhlwr .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#npepwxhlwr .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#npepwxhlwr .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#npepwxhlwr .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#npepwxhlwr .gt_footnotes {
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

#npepwxhlwr .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#npepwxhlwr .gt_sourcenotes {
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

#npepwxhlwr .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#npepwxhlwr .gt_left {
  text-align: left;
}

#npepwxhlwr .gt_center {
  text-align: center;
}

#npepwxhlwr .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#npepwxhlwr .gt_font_normal {
  font-weight: normal;
}

#npepwxhlwr .gt_font_bold {
  font-weight: bold;
}

#npepwxhlwr .gt_font_italic {
  font-style: italic;
}

#npepwxhlwr .gt_super {
  font-size: 65%;
}

#npepwxhlwr .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#npepwxhlwr .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#npepwxhlwr .gt_indent_1 {
  text-indent: 5px;
}

#npepwxhlwr .gt_indent_2 {
  text-indent: 10px;
}

#npepwxhlwr .gt_indent_3 {
  text-indent: 15px;
}

#npepwxhlwr .gt_indent_4 {
  text-indent: 20px;
}

#npepwxhlwr .gt_indent_5 {
  text-indent: 25px;
}

#npepwxhlwr .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#npepwxhlwr div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
  <tfoot>
    <tr class="gt_footnotes">
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
<div id="ipjzvvroym" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#ipjzvvroym table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#ipjzvvroym thead, #ipjzvvroym tbody, #ipjzvvroym tfoot, #ipjzvvroym tr, #ipjzvvroym td, #ipjzvvroym th {
  border-style: none;
}

#ipjzvvroym p {
  margin: 0;
  padding: 0;
}

#ipjzvvroym .gt_table {
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

#ipjzvvroym .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#ipjzvvroym .gt_title {
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

#ipjzvvroym .gt_subtitle {
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

#ipjzvvroym .gt_heading {
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

#ipjzvvroym .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ipjzvvroym .gt_col_headings {
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

#ipjzvvroym .gt_col_heading {
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

#ipjzvvroym .gt_column_spanner_outer {
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

#ipjzvvroym .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#ipjzvvroym .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#ipjzvvroym .gt_column_spanner {
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

#ipjzvvroym .gt_spanner_row {
  border-bottom-style: hidden;
}

#ipjzvvroym .gt_group_heading {
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

#ipjzvvroym .gt_empty_group_heading {
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

#ipjzvvroym .gt_from_md > :first-child {
  margin-top: 0;
}

#ipjzvvroym .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ipjzvvroym .gt_row {
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

#ipjzvvroym .gt_stub {
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

#ipjzvvroym .gt_stub_row_group {
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

#ipjzvvroym .gt_row_group_first td {
  border-top-width: 2px;
}

#ipjzvvroym .gt_row_group_first th {
  border-top-width: 2px;
}

#ipjzvvroym .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ipjzvvroym .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#ipjzvvroym .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#ipjzvvroym .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ipjzvvroym .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ipjzvvroym .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#ipjzvvroym .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#ipjzvvroym .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#ipjzvvroym .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ipjzvvroym .gt_footnotes {
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

#ipjzvvroym .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ipjzvvroym .gt_sourcenotes {
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

#ipjzvvroym .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ipjzvvroym .gt_left {
  text-align: left;
}

#ipjzvvroym .gt_center {
  text-align: center;
}

#ipjzvvroym .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ipjzvvroym .gt_font_normal {
  font-weight: normal;
}

#ipjzvvroym .gt_font_bold {
  font-weight: bold;
}

#ipjzvvroym .gt_font_italic {
  font-style: italic;
}

#ipjzvvroym .gt_super {
  font-size: 65%;
}

#ipjzvvroym .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#ipjzvvroym .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#ipjzvvroym .gt_indent_1 {
  text-indent: 5px;
}

#ipjzvvroym .gt_indent_2 {
  text-indent: 10px;
}

#ipjzvvroym .gt_indent_3 {
  text-indent: 15px;
}

#ipjzvvroym .gt_indent_4 {
  text-indent: 20px;
}

#ipjzvvroym .gt_indent_5 {
  text-indent: 25px;
}

#ipjzvvroym .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#ipjzvvroym div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
  <tfoot>
    <tr class="gt_footnotes">
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
<div id="wywmvfkwwr" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#wywmvfkwwr table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#wywmvfkwwr thead, #wywmvfkwwr tbody, #wywmvfkwwr tfoot, #wywmvfkwwr tr, #wywmvfkwwr td, #wywmvfkwwr th {
  border-style: none;
}

#wywmvfkwwr p {
  margin: 0;
  padding: 0;
}

#wywmvfkwwr .gt_table {
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

#wywmvfkwwr .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#wywmvfkwwr .gt_title {
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

#wywmvfkwwr .gt_subtitle {
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

#wywmvfkwwr .gt_heading {
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

#wywmvfkwwr .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#wywmvfkwwr .gt_col_headings {
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

#wywmvfkwwr .gt_col_heading {
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

#wywmvfkwwr .gt_column_spanner_outer {
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

#wywmvfkwwr .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#wywmvfkwwr .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#wywmvfkwwr .gt_column_spanner {
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

#wywmvfkwwr .gt_spanner_row {
  border-bottom-style: hidden;
}

#wywmvfkwwr .gt_group_heading {
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

#wywmvfkwwr .gt_empty_group_heading {
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

#wywmvfkwwr .gt_from_md > :first-child {
  margin-top: 0;
}

#wywmvfkwwr .gt_from_md > :last-child {
  margin-bottom: 0;
}

#wywmvfkwwr .gt_row {
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

#wywmvfkwwr .gt_stub {
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

#wywmvfkwwr .gt_stub_row_group {
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

#wywmvfkwwr .gt_row_group_first td {
  border-top-width: 2px;
}

#wywmvfkwwr .gt_row_group_first th {
  border-top-width: 2px;
}

#wywmvfkwwr .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#wywmvfkwwr .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#wywmvfkwwr .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#wywmvfkwwr .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#wywmvfkwwr .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#wywmvfkwwr .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#wywmvfkwwr .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#wywmvfkwwr .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#wywmvfkwwr .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#wywmvfkwwr .gt_footnotes {
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

#wywmvfkwwr .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#wywmvfkwwr .gt_sourcenotes {
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

#wywmvfkwwr .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#wywmvfkwwr .gt_left {
  text-align: left;
}

#wywmvfkwwr .gt_center {
  text-align: center;
}

#wywmvfkwwr .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#wywmvfkwwr .gt_font_normal {
  font-weight: normal;
}

#wywmvfkwwr .gt_font_bold {
  font-weight: bold;
}

#wywmvfkwwr .gt_font_italic {
  font-style: italic;
}

#wywmvfkwwr .gt_super {
  font-size: 65%;
}

#wywmvfkwwr .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#wywmvfkwwr .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#wywmvfkwwr .gt_indent_1 {
  text-indent: 5px;
}

#wywmvfkwwr .gt_indent_2 {
  text-indent: 10px;
}

#wywmvfkwwr .gt_indent_3 {
  text-indent: 15px;
}

#wywmvfkwwr .gt_indent_4 {
  text-indent: 20px;
}

#wywmvfkwwr .gt_indent_5 {
  text-indent: 25px;
}

#wywmvfkwwr .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#wywmvfkwwr div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
  <tfoot>
    <tr class="gt_footnotes">
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
<div id="ocivztcsfr" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#ocivztcsfr table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#ocivztcsfr thead, #ocivztcsfr tbody, #ocivztcsfr tfoot, #ocivztcsfr tr, #ocivztcsfr td, #ocivztcsfr th {
  border-style: none;
}

#ocivztcsfr p {
  margin: 0;
  padding: 0;
}

#ocivztcsfr .gt_table {
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

#ocivztcsfr .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#ocivztcsfr .gt_title {
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

#ocivztcsfr .gt_subtitle {
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

#ocivztcsfr .gt_heading {
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

#ocivztcsfr .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ocivztcsfr .gt_col_headings {
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

#ocivztcsfr .gt_col_heading {
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

#ocivztcsfr .gt_column_spanner_outer {
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

#ocivztcsfr .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#ocivztcsfr .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#ocivztcsfr .gt_column_spanner {
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

#ocivztcsfr .gt_spanner_row {
  border-bottom-style: hidden;
}

#ocivztcsfr .gt_group_heading {
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

#ocivztcsfr .gt_empty_group_heading {
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

#ocivztcsfr .gt_from_md > :first-child {
  margin-top: 0;
}

#ocivztcsfr .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ocivztcsfr .gt_row {
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

#ocivztcsfr .gt_stub {
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

#ocivztcsfr .gt_stub_row_group {
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

#ocivztcsfr .gt_row_group_first td {
  border-top-width: 2px;
}

#ocivztcsfr .gt_row_group_first th {
  border-top-width: 2px;
}

#ocivztcsfr .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ocivztcsfr .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#ocivztcsfr .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#ocivztcsfr .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ocivztcsfr .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ocivztcsfr .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#ocivztcsfr .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#ocivztcsfr .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#ocivztcsfr .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ocivztcsfr .gt_footnotes {
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

#ocivztcsfr .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ocivztcsfr .gt_sourcenotes {
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

#ocivztcsfr .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ocivztcsfr .gt_left {
  text-align: left;
}

#ocivztcsfr .gt_center {
  text-align: center;
}

#ocivztcsfr .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ocivztcsfr .gt_font_normal {
  font-weight: normal;
}

#ocivztcsfr .gt_font_bold {
  font-weight: bold;
}

#ocivztcsfr .gt_font_italic {
  font-style: italic;
}

#ocivztcsfr .gt_super {
  font-size: 65%;
}

#ocivztcsfr .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#ocivztcsfr .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#ocivztcsfr .gt_indent_1 {
  text-indent: 5px;
}

#ocivztcsfr .gt_indent_2 {
  text-indent: 10px;
}

#ocivztcsfr .gt_indent_3 {
  text-indent: 15px;
}

#ocivztcsfr .gt_indent_4 {
  text-indent: 20px;
}

#ocivztcsfr .gt_indent_5 {
  text-indent: 25px;
}

#ocivztcsfr .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#ocivztcsfr div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
  <tfoot>
    <tr class="gt_footnotes">
      <td class="gt_footnote" colspan="5"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span> <span class='gt_from_md'>Median (Q1, Q3); n (%)</span></td>
    </tr>
    <tr class="gt_footnotes">
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
<div id="ufpaoajunk" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#ufpaoajunk table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#ufpaoajunk thead, #ufpaoajunk tbody, #ufpaoajunk tfoot, #ufpaoajunk tr, #ufpaoajunk td, #ufpaoajunk th {
  border-style: none;
}

#ufpaoajunk p {
  margin: 0;
  padding: 0;
}

#ufpaoajunk .gt_table {
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

#ufpaoajunk .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#ufpaoajunk .gt_title {
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

#ufpaoajunk .gt_subtitle {
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

#ufpaoajunk .gt_heading {
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

#ufpaoajunk .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ufpaoajunk .gt_col_headings {
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

#ufpaoajunk .gt_col_heading {
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

#ufpaoajunk .gt_column_spanner_outer {
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

#ufpaoajunk .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#ufpaoajunk .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#ufpaoajunk .gt_column_spanner {
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

#ufpaoajunk .gt_spanner_row {
  border-bottom-style: hidden;
}

#ufpaoajunk .gt_group_heading {
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

#ufpaoajunk .gt_empty_group_heading {
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

#ufpaoajunk .gt_from_md > :first-child {
  margin-top: 0;
}

#ufpaoajunk .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ufpaoajunk .gt_row {
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

#ufpaoajunk .gt_stub {
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

#ufpaoajunk .gt_stub_row_group {
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

#ufpaoajunk .gt_row_group_first td {
  border-top-width: 2px;
}

#ufpaoajunk .gt_row_group_first th {
  border-top-width: 2px;
}

#ufpaoajunk .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ufpaoajunk .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#ufpaoajunk .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#ufpaoajunk .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ufpaoajunk .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ufpaoajunk .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#ufpaoajunk .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#ufpaoajunk .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#ufpaoajunk .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ufpaoajunk .gt_footnotes {
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

#ufpaoajunk .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ufpaoajunk .gt_sourcenotes {
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

#ufpaoajunk .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ufpaoajunk .gt_left {
  text-align: left;
}

#ufpaoajunk .gt_center {
  text-align: center;
}

#ufpaoajunk .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ufpaoajunk .gt_font_normal {
  font-weight: normal;
}

#ufpaoajunk .gt_font_bold {
  font-weight: bold;
}

#ufpaoajunk .gt_font_italic {
  font-style: italic;
}

#ufpaoajunk .gt_super {
  font-size: 65%;
}

#ufpaoajunk .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#ufpaoajunk .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#ufpaoajunk .gt_indent_1 {
  text-indent: 5px;
}

#ufpaoajunk .gt_indent_2 {
  text-indent: 10px;
}

#ufpaoajunk .gt_indent_3 {
  text-indent: 15px;
}

#ufpaoajunk .gt_indent_4 {
  text-indent: 20px;
}

#ufpaoajunk .gt_indent_5 {
  text-indent: 25px;
}

#ufpaoajunk .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#ufpaoajunk div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
  <tfoot>
    <tr class="gt_footnotes">
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
<div id="khmxplnqyg" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#khmxplnqyg table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#khmxplnqyg thead, #khmxplnqyg tbody, #khmxplnqyg tfoot, #khmxplnqyg tr, #khmxplnqyg td, #khmxplnqyg th {
  border-style: none;
}

#khmxplnqyg p {
  margin: 0;
  padding: 0;
}

#khmxplnqyg .gt_table {
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

#khmxplnqyg .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#khmxplnqyg .gt_title {
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

#khmxplnqyg .gt_subtitle {
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

#khmxplnqyg .gt_heading {
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

#khmxplnqyg .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#khmxplnqyg .gt_col_headings {
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

#khmxplnqyg .gt_col_heading {
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

#khmxplnqyg .gt_column_spanner_outer {
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

#khmxplnqyg .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#khmxplnqyg .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#khmxplnqyg .gt_column_spanner {
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

#khmxplnqyg .gt_spanner_row {
  border-bottom-style: hidden;
}

#khmxplnqyg .gt_group_heading {
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

#khmxplnqyg .gt_empty_group_heading {
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

#khmxplnqyg .gt_from_md > :first-child {
  margin-top: 0;
}

#khmxplnqyg .gt_from_md > :last-child {
  margin-bottom: 0;
}

#khmxplnqyg .gt_row {
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

#khmxplnqyg .gt_stub {
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

#khmxplnqyg .gt_stub_row_group {
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

#khmxplnqyg .gt_row_group_first td {
  border-top-width: 2px;
}

#khmxplnqyg .gt_row_group_first th {
  border-top-width: 2px;
}

#khmxplnqyg .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#khmxplnqyg .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#khmxplnqyg .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#khmxplnqyg .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#khmxplnqyg .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#khmxplnqyg .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#khmxplnqyg .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#khmxplnqyg .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#khmxplnqyg .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#khmxplnqyg .gt_footnotes {
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

#khmxplnqyg .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#khmxplnqyg .gt_sourcenotes {
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

#khmxplnqyg .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#khmxplnqyg .gt_left {
  text-align: left;
}

#khmxplnqyg .gt_center {
  text-align: center;
}

#khmxplnqyg .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#khmxplnqyg .gt_font_normal {
  font-weight: normal;
}

#khmxplnqyg .gt_font_bold {
  font-weight: bold;
}

#khmxplnqyg .gt_font_italic {
  font-style: italic;
}

#khmxplnqyg .gt_super {
  font-size: 65%;
}

#khmxplnqyg .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#khmxplnqyg .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#khmxplnqyg .gt_indent_1 {
  text-indent: 5px;
}

#khmxplnqyg .gt_indent_2 {
  text-indent: 10px;
}

#khmxplnqyg .gt_indent_3 {
  text-indent: 15px;
}

#khmxplnqyg .gt_indent_4 {
  text-indent: 20px;
}

#khmxplnqyg .gt_indent_5 {
  text-indent: 25px;
}

#khmxplnqyg .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#khmxplnqyg div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
  <tfoot>
    <tr class="gt_footnotes">
      <td class="gt_footnote" colspan="6"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span> <span class='gt_from_md'>Mean (SD); n (%)</span></td>
    </tr>
    <tr class="gt_footnotes">
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
<div id="lfbzvwbyjn" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>@import url("https://fonts.googleapis.com/css2?family=Atkinson+Hyperlegible+Next:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap");
#lfbzvwbyjn table {
  font-family: 'Atkinson Hyperlegible Next', system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#lfbzvwbyjn thead, #lfbzvwbyjn tbody, #lfbzvwbyjn tfoot, #lfbzvwbyjn tr, #lfbzvwbyjn td, #lfbzvwbyjn th {
  border-style: none;
}

#lfbzvwbyjn p {
  margin: 0;
  padding: 0;
}

#lfbzvwbyjn .gt_table {
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

#lfbzvwbyjn .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#lfbzvwbyjn .gt_title {
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

#lfbzvwbyjn .gt_subtitle {
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

#lfbzvwbyjn .gt_heading {
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

#lfbzvwbyjn .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#lfbzvwbyjn .gt_col_headings {
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

#lfbzvwbyjn .gt_col_heading {
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

#lfbzvwbyjn .gt_column_spanner_outer {
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

#lfbzvwbyjn .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#lfbzvwbyjn .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#lfbzvwbyjn .gt_column_spanner {
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

#lfbzvwbyjn .gt_spanner_row {
  border-bottom-style: hidden;
}

#lfbzvwbyjn .gt_group_heading {
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

#lfbzvwbyjn .gt_empty_group_heading {
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

#lfbzvwbyjn .gt_from_md > :first-child {
  margin-top: 0;
}

#lfbzvwbyjn .gt_from_md > :last-child {
  margin-bottom: 0;
}

#lfbzvwbyjn .gt_row {
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

#lfbzvwbyjn .gt_stub {
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

#lfbzvwbyjn .gt_stub_row_group {
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

#lfbzvwbyjn .gt_row_group_first td {
  border-top-width: 2px;
}

#lfbzvwbyjn .gt_row_group_first th {
  border-top-width: 2px;
}

#lfbzvwbyjn .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#lfbzvwbyjn .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#lfbzvwbyjn .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#lfbzvwbyjn .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#lfbzvwbyjn .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#lfbzvwbyjn .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#lfbzvwbyjn .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#lfbzvwbyjn .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#lfbzvwbyjn .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#lfbzvwbyjn .gt_footnotes {
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

#lfbzvwbyjn .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#lfbzvwbyjn .gt_sourcenotes {
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

#lfbzvwbyjn .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#lfbzvwbyjn .gt_left {
  text-align: left;
}

#lfbzvwbyjn .gt_center {
  text-align: center;
}

#lfbzvwbyjn .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#lfbzvwbyjn .gt_font_normal {
  font-weight: normal;
}

#lfbzvwbyjn .gt_font_bold {
  font-weight: bold;
}

#lfbzvwbyjn .gt_font_italic {
  font-style: italic;
}

#lfbzvwbyjn .gt_super {
  font-size: 65%;
}

#lfbzvwbyjn .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#lfbzvwbyjn .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#lfbzvwbyjn .gt_indent_1 {
  text-indent: 5px;
}

#lfbzvwbyjn .gt_indent_2 {
  text-indent: 10px;
}

#lfbzvwbyjn .gt_indent_3 {
  text-indent: 15px;
}

#lfbzvwbyjn .gt_indent_4 {
  text-indent: 20px;
}

#lfbzvwbyjn .gt_indent_5 {
  text-indent: 25px;
}

#lfbzvwbyjn .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#lfbzvwbyjn div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
  <tfoot>
    <tr class="gt_footnotes">
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
<div id="yivfaldvrc" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>@import url("https://fonts.googleapis.com/css2?family=Orbitron:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap");
#yivfaldvrc table {
  font-family: Orbitron, system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#yivfaldvrc thead, #yivfaldvrc tbody, #yivfaldvrc tfoot, #yivfaldvrc tr, #yivfaldvrc td, #yivfaldvrc th {
  border-style: none;
}

#yivfaldvrc p {
  margin: 0;
  padding: 0;
}

#yivfaldvrc .gt_table {
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

#yivfaldvrc .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#yivfaldvrc .gt_title {
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

#yivfaldvrc .gt_subtitle {
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

#yivfaldvrc .gt_heading {
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

#yivfaldvrc .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#yivfaldvrc .gt_col_headings {
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

#yivfaldvrc .gt_col_heading {
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

#yivfaldvrc .gt_column_spanner_outer {
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

#yivfaldvrc .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#yivfaldvrc .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#yivfaldvrc .gt_column_spanner {
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

#yivfaldvrc .gt_spanner_row {
  border-bottom-style: hidden;
}

#yivfaldvrc .gt_group_heading {
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

#yivfaldvrc .gt_empty_group_heading {
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

#yivfaldvrc .gt_from_md > :first-child {
  margin-top: 0;
}

#yivfaldvrc .gt_from_md > :last-child {
  margin-bottom: 0;
}

#yivfaldvrc .gt_row {
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

#yivfaldvrc .gt_stub {
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

#yivfaldvrc .gt_stub_row_group {
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

#yivfaldvrc .gt_row_group_first td {
  border-top-width: 2px;
}

#yivfaldvrc .gt_row_group_first th {
  border-top-width: 2px;
}

#yivfaldvrc .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#yivfaldvrc .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#yivfaldvrc .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#yivfaldvrc .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#yivfaldvrc .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#yivfaldvrc .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#yivfaldvrc .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#yivfaldvrc .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#yivfaldvrc .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#yivfaldvrc .gt_footnotes {
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

#yivfaldvrc .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#yivfaldvrc .gt_sourcenotes {
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

#yivfaldvrc .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#yivfaldvrc .gt_left {
  text-align: left;
}

#yivfaldvrc .gt_center {
  text-align: center;
}

#yivfaldvrc .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#yivfaldvrc .gt_font_normal {
  font-weight: normal;
}

#yivfaldvrc .gt_font_bold {
  font-weight: bold;
}

#yivfaldvrc .gt_font_italic {
  font-style: italic;
}

#yivfaldvrc .gt_super {
  font-size: 65%;
}

#yivfaldvrc .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#yivfaldvrc .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#yivfaldvrc .gt_indent_1 {
  text-indent: 5px;
}

#yivfaldvrc .gt_indent_2 {
  text-indent: 10px;
}

#yivfaldvrc .gt_indent_3 {
  text-indent: 15px;
}

#yivfaldvrc .gt_indent_4 {
  text-indent: 20px;
}

#yivfaldvrc .gt_indent_5 {
  text-indent: 25px;
}

#yivfaldvrc .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#yivfaldvrc div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
  <tfoot>
    <tr class="gt_footnotes">
      <td class="gt_footnote" colspan="3"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span> <span class='gt_from_md'>Median (Q1, Q3); n (%)</span></td>
    </tr>
    <tr class="gt_sourcenotes">
      <td class="gt_sourcenote" colspan="3">Source:  TRON World</td>
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
<div class="tabwid"><style>.cl-e90a3012{}.cl-e906c7c4{font-family:'Brush Script MT';font-size:18pt;font-weight:bold;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-e906c7d8{font-family:'Brush Script MT';font-size:10.8pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;position: relative;bottom:5.4pt;}.cl-e906c7d9{font-family:'Helvetica';font-size:11pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-e906c7e2{font-family:'Helvetica';font-size:6.6pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;position: relative;bottom:3.3pt;}.cl-e9082be6{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:2pt;padding-top:2pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-e9082bf0{margin:0;text-align:center;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:2pt;padding-top:2pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-e9082bf1{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-e9082bf2{margin:0;text-align:center;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-e9082bfa{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:15pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-e9082c04{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-e9083ac8{width:2.026in;background-color:transparent;vertical-align: middle;border-bottom: 1pt solid rgba(0, 0, 0, 1.00);border-top: 1pt solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e9083ad2{width:1.024in;background-color:transparent;vertical-align: middle;border-bottom: 1pt solid rgba(0, 0, 0, 1.00);border-top: 1pt solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e9083ad3{width:2.026in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e9083ad4{width:1.024in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e9083adc{width:2.026in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e9083add{width:1.024in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e9083ade{width:2.026in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e9083ae6{width:1.024in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e9083ae7{width:2.026in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e9083ae8{width:1.024in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e9083af0{width:2.026in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e9083af1{width:1.024in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e9083af2{width:2.026in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e9083afa{width:1.024in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e9083afb{width:2.026in;background-color:transparent;vertical-align: top;border-bottom: 1pt solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e9083afc{width:1.024in;background-color:transparent;vertical-align: top;border-bottom: 1pt solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e9083afd{width:2.026in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(255, 255, 255, 0.00);border-top: 0 solid rgba(255, 255, 255, 0.00);border-left: 0 solid rgba(255, 255, 255, 0.00);border-right: 0 solid rgba(255, 255, 255, 0.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e9083b04{width:1.024in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(255, 255, 255, 0.00);border-top: 0 solid rgba(255, 255, 255, 0.00);border-left: 0 solid rgba(255, 255, 255, 0.00);border-right: 0 solid rgba(255, 255, 255, 0.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}</style><table data-quarto-disable-processing='true' class='cl-e90a3012'><thead><tr style="overflow-wrap:break-word;"><th class="cl-e9083ac8"><p class="cl-e9082be6"><span class="cl-e906c7c4">Characteristic</span></p></th><th class="cl-e9083ad2"><p class="cl-e9082bf0"><span class="cl-e906c7c4">N = 200</span><span class="cl-e906c7d8">1</span></p></th></tr></thead><tbody><tr style="overflow-wrap:break-word;"><td class="cl-e9083ad3"><p class="cl-e9082bf1"><span class="cl-e906c7d9">Chemotherapy Treatment</span></p></td><td class="cl-e9083ad4"><p class="cl-e9082bf2"><span class="cl-e906c7d9"></span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-e9083adc"><p class="cl-e9082bfa"><span class="cl-e906c7d9">Drug A</span></p></td><td class="cl-e9083add"><p class="cl-e9082bf2"><span class="cl-e906c7d9">98 (49%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-e9083adc"><p class="cl-e9082bfa"><span class="cl-e906c7d9">Drug B</span></p></td><td class="cl-e9083add"><p class="cl-e9082bf2"><span class="cl-e906c7d9">102 (51%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-e9083adc"><p class="cl-e9082bf1"><span class="cl-e906c7d9">Age</span></p></td><td class="cl-e9083add"><p class="cl-e9082bf2"><span class="cl-e906c7d9">47 (38, 57)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-e9083ade"><p class="cl-e9082bfa"><span class="cl-e906c7d9">Unknown</span></p></td><td class="cl-e9083ae6"><p class="cl-e9082bf2"><span class="cl-e906c7d9">11</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-e9083ae7"><p class="cl-e9082bf1"><span class="cl-e906c7d9">T Stage</span></p></td><td class="cl-e9083ae8"><p class="cl-e9082bf2"><span class="cl-e906c7d9"></span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-e9083af0"><p class="cl-e9082bfa"><span class="cl-e906c7d9">T1</span></p></td><td class="cl-e9083af1"><p class="cl-e9082bf2"><span class="cl-e906c7d9">53 (27%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-e9083af0"><p class="cl-e9082bfa"><span class="cl-e906c7d9">T2</span></p></td><td class="cl-e9083af1"><p class="cl-e9082bf2"><span class="cl-e906c7d9">54 (27%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-e9083af0"><p class="cl-e9082bfa"><span class="cl-e906c7d9">T3</span></p></td><td class="cl-e9083af1"><p class="cl-e9082bf2"><span class="cl-e906c7d9">43 (22%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-e9083af0"><p class="cl-e9082bfa"><span class="cl-e906c7d9">T4</span></p></td><td class="cl-e9083af1"><p class="cl-e9082bf2"><span class="cl-e906c7d9">50 (25%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-e9083af2"><p class="cl-e9082bf1"><span class="cl-e906c7d9">Grade</span></p></td><td class="cl-e9083afa"><p class="cl-e9082bf2"><span class="cl-e906c7d9"></span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-e9083af0"><p class="cl-e9082bfa"><span class="cl-e906c7d9">I</span></p></td><td class="cl-e9083af1"><p class="cl-e9082bf2"><span class="cl-e906c7d9">68 (34%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-e9083af0"><p class="cl-e9082bfa"><span class="cl-e906c7d9">II</span></p></td><td class="cl-e9083af1"><p class="cl-e9082bf2"><span class="cl-e906c7d9">68 (34%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-e9083afb"><p class="cl-e9082bfa"><span class="cl-e906c7d9">III</span></p></td><td class="cl-e9083afc"><p class="cl-e9082bf2"><span class="cl-e906c7d9">64 (32%)</span></p></td></tr></tbody><tfoot><tr style="overflow-wrap:break-word;"><td  colspan="2"class="cl-e9083afd"><p class="cl-e9082c04"><span class="cl-e906c7e2">1</span><span class="cl-e906c7d9">n (%); Median (Q1, Q3)</span></p></td></tr></tfoot></table></div>
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
<div class="tabwid"><style>.cl-e95561ae{}.cl-e95172ec{font-family:'Helvetica';font-size:14pt;font-weight:bold;font-style:normal;text-decoration:none;color:rgba(255, 255, 255, 1.00);background-color:transparent;}.cl-e95172f6{font-family:'Helvetica';font-size:8.4pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(255, 255, 255, 1.00);background-color:transparent;position: relative;bottom:4.2pt;}.cl-e95172f7{font-family:'Helvetica';font-size:14pt;font-weight:bold;font-style:italic;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-e9517300{font-family:'Helvetica';font-size:14pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-e9517301{font-family:'Helvetica';font-size:14pt;font-weight:normal;font-style:italic;text-decoration:none;color:rgba(0, 0, 255, 1.00);background-color:transparent;}.cl-e9517302{font-family:'Helvetica';font-size:14pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 255, 1.00);background-color:transparent;}.cl-e9517303{font-family:'Helvetica';font-size:14pt;font-weight:normal;font-style:italic;text-decoration:none;color:rgba(176, 48, 96, 1.00);background-color:transparent;}.cl-e951730a{font-family:'Helvetica';font-size:14pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(176, 48, 96, 1.00);background-color:transparent;}.cl-e951730b{font-family:'Helvetica';font-size:14pt;font-weight:normal;font-style:italic;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-e951730c{font-family:'Helvetica';font-size:14pt;font-weight:bold;font-style:normal;text-decoration:none;color:rgba(255, 0, 0, 1.00);background-color:transparent;}.cl-e9517314{font-family:'Helvetica';font-size:8.4pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;position: relative;bottom:4.2pt;}.cl-e952c6ba{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:2pt;padding-top:2pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-e952c6c4{margin:0;text-align:center;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:2pt;padding-top:2pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-e952c6ce{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-e952c6d8{margin:0;text-align:center;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-e952c6d9{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:15pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-e952c6e2{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-e9537c5e{width:2.641in;background-color:rgba(201, 0, 0, 1.00);vertical-align: middle;border-bottom: 2pt solid rgba(0, 0, 0, 1.00);border-top: 2pt solid rgba(0, 0, 0, 1.00);border-left: 2pt solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e9537c68{width:1.226in;background-color:rgba(201, 0, 0, 1.00);vertical-align: middle;border-bottom: 2pt solid rgba(0, 0, 0, 1.00);border-top: 2pt solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 2pt solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e9537c69{width:2.641in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 2pt solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e9537c6a{width:1.226in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 2pt solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e9537c6b{width:2.641in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 2pt solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e9537c6c{width:1.226in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 2pt solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e9537c72{width:2.641in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 2pt solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e9537c73{width:1.226in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 2pt solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e9537c74{width:2.641in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 2pt solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e9537c75{width:1.226in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 2pt solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e9537c76{width:2.641in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 2pt solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e9537c7c{width:1.226in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 2pt solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e9537c7d{width:2.641in;background-color:transparent;vertical-align: top;border-bottom: 2pt solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 2pt solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e9537c7e{width:1.226in;background-color:transparent;vertical-align: top;border-bottom: 2pt solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 2pt solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e9537c7f{width:2.641in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(255, 255, 255, 0.00);border-top: 0 solid rgba(255, 255, 255, 0.00);border-left: 0 solid rgba(255, 255, 255, 0.00);border-right: 0 solid rgba(255, 255, 255, 0.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e9537c80{width:1.226in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(255, 255, 255, 0.00);border-top: 0 solid rgba(255, 255, 255, 0.00);border-left: 0 solid rgba(255, 255, 255, 0.00);border-right: 0 solid rgba(255, 255, 255, 0.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}</style><table data-quarto-disable-processing='true' class='cl-e95561ae'><thead><tr style="overflow-wrap:break-word;"><th class="cl-e9537c5e"><p class="cl-e952c6ba"><span class="cl-e95172ec">Characteristic</span></p></th><th class="cl-e9537c68"><p class="cl-e952c6c4"><span class="cl-e95172ec">N = 200</span><span class="cl-e95172f6">1</span></p></th></tr></thead><tbody><tr style="overflow-wrap:break-word;"><td class="cl-e9537c69"><p class="cl-e952c6ce"><span class="cl-e95172f7">Chemotherapy Treatment</span></p></td><td class="cl-e9537c6a"><p class="cl-e952c6d8"><span class="cl-e9517300"></span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-e9537c6b"><p class="cl-e952c6d9"><span class="cl-e9517301">Drug A</span></p></td><td class="cl-e9537c6c"><p class="cl-e952c6d8"><span class="cl-e9517302">98 (49%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-e9537c6b"><p class="cl-e952c6d9"><span class="cl-e9517303">Drug B</span></p></td><td class="cl-e9537c6c"><p class="cl-e952c6d8"><span class="cl-e951730a">102 (51%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-e9537c6b"><p class="cl-e952c6ce"><span class="cl-e951730b">Age</span></p></td><td class="cl-e9537c6c"><p class="cl-e952c6d8"><span class="cl-e9517300">47 (38, 57)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-e9537c72"><p class="cl-e952c6d9"><span class="cl-e951730b">Unknown</span></p></td><td class="cl-e9537c73"><p class="cl-e952c6d8"><span class="cl-e9517300">11</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-e9537c74"><p class="cl-e952c6ce"><span class="cl-e951730b">Grade</span></p></td><td class="cl-e9537c75"><p class="cl-e952c6d8"><span class="cl-e9517300"></span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-e9537c76"><p class="cl-e952c6d9"><span class="cl-e951730b">I</span></p></td><td class="cl-e9537c7c"><p class="cl-e952c6d8"><span class="cl-e951730c">68 (34%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-e9537c76"><p class="cl-e952c6d9"><span class="cl-e951730b">II</span></p></td><td class="cl-e9537c7c"><p class="cl-e952c6d8"><span class="cl-e951730c">68 (34%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-e9537c76"><p class="cl-e952c6d9"><span class="cl-e951730b">III</span></p></td><td class="cl-e9537c7c"><p class="cl-e952c6d8"><span class="cl-e9517300">64 (32%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-e9537c76"><p class="cl-e952c6ce"><span class="cl-e951730b">Tumor Response</span></p></td><td class="cl-e9537c7c"><p class="cl-e952c6d8"><span class="cl-e9517300">61 (32%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-e9537c7d"><p class="cl-e952c6d9"><span class="cl-e951730b">Unknown</span></p></td><td class="cl-e9537c7e"><p class="cl-e952c6d8"><span class="cl-e9517300">7</span></p></td></tr></tbody><tfoot><tr style="overflow-wrap:break-word;"><td  colspan="2"class="cl-e9537c7f"><p class="cl-e952c6e2"><span class="cl-e9517314">1</span><span class="cl-e9517300">n (%); Median (Q1, Q3)</span></p></td></tr></tfoot></table></div>
```

