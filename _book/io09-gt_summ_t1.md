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
<div id="jfjznzfugf" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#jfjznzfugf table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#jfjznzfugf thead, #jfjznzfugf tbody, #jfjznzfugf tfoot, #jfjznzfugf tr, #jfjznzfugf td, #jfjznzfugf th {
  border-style: none;
}

#jfjznzfugf p {
  margin: 0;
  padding: 0;
}

#jfjznzfugf .gt_table {
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

#jfjznzfugf .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#jfjznzfugf .gt_title {
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

#jfjznzfugf .gt_subtitle {
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

#jfjznzfugf .gt_heading {
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

#jfjznzfugf .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#jfjznzfugf .gt_col_headings {
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

#jfjznzfugf .gt_col_heading {
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

#jfjznzfugf .gt_column_spanner_outer {
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

#jfjznzfugf .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#jfjznzfugf .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#jfjznzfugf .gt_column_spanner {
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

#jfjznzfugf .gt_spanner_row {
  border-bottom-style: hidden;
}

#jfjznzfugf .gt_group_heading {
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

#jfjznzfugf .gt_empty_group_heading {
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

#jfjznzfugf .gt_from_md > :first-child {
  margin-top: 0;
}

#jfjznzfugf .gt_from_md > :last-child {
  margin-bottom: 0;
}

#jfjznzfugf .gt_row {
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

#jfjznzfugf .gt_stub {
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

#jfjznzfugf .gt_stub_row_group {
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

#jfjznzfugf .gt_row_group_first td {
  border-top-width: 2px;
}

#jfjznzfugf .gt_row_group_first th {
  border-top-width: 2px;
}

#jfjznzfugf .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#jfjznzfugf .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#jfjznzfugf .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#jfjznzfugf .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#jfjznzfugf .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#jfjznzfugf .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#jfjznzfugf .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#jfjznzfugf .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#jfjznzfugf .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#jfjznzfugf .gt_footnotes {
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

#jfjznzfugf .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#jfjznzfugf .gt_sourcenotes {
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

#jfjznzfugf .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#jfjznzfugf .gt_left {
  text-align: left;
}

#jfjznzfugf .gt_center {
  text-align: center;
}

#jfjznzfugf .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#jfjznzfugf .gt_font_normal {
  font-weight: normal;
}

#jfjznzfugf .gt_font_bold {
  font-weight: bold;
}

#jfjznzfugf .gt_font_italic {
  font-style: italic;
}

#jfjznzfugf .gt_super {
  font-size: 65%;
}

#jfjznzfugf .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#jfjznzfugf .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#jfjznzfugf .gt_indent_1 {
  text-indent: 5px;
}

#jfjznzfugf .gt_indent_2 {
  text-indent: 10px;
}

#jfjznzfugf .gt_indent_3 {
  text-indent: 15px;
}

#jfjznzfugf .gt_indent_4 {
  text-indent: 20px;
}

#jfjznzfugf .gt_indent_5 {
  text-indent: 25px;
}

#jfjznzfugf .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#jfjznzfugf div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="ovvcnnrlnc" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#ovvcnnrlnc table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#ovvcnnrlnc thead, #ovvcnnrlnc tbody, #ovvcnnrlnc tfoot, #ovvcnnrlnc tr, #ovvcnnrlnc td, #ovvcnnrlnc th {
  border-style: none;
}

#ovvcnnrlnc p {
  margin: 0;
  padding: 0;
}

#ovvcnnrlnc .gt_table {
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

#ovvcnnrlnc .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#ovvcnnrlnc .gt_title {
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

#ovvcnnrlnc .gt_subtitle {
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

#ovvcnnrlnc .gt_heading {
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

#ovvcnnrlnc .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ovvcnnrlnc .gt_col_headings {
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

#ovvcnnrlnc .gt_col_heading {
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

#ovvcnnrlnc .gt_column_spanner_outer {
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

#ovvcnnrlnc .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#ovvcnnrlnc .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#ovvcnnrlnc .gt_column_spanner {
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

#ovvcnnrlnc .gt_spanner_row {
  border-bottom-style: hidden;
}

#ovvcnnrlnc .gt_group_heading {
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

#ovvcnnrlnc .gt_empty_group_heading {
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

#ovvcnnrlnc .gt_from_md > :first-child {
  margin-top: 0;
}

#ovvcnnrlnc .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ovvcnnrlnc .gt_row {
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

#ovvcnnrlnc .gt_stub {
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

#ovvcnnrlnc .gt_stub_row_group {
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

#ovvcnnrlnc .gt_row_group_first td {
  border-top-width: 2px;
}

#ovvcnnrlnc .gt_row_group_first th {
  border-top-width: 2px;
}

#ovvcnnrlnc .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ovvcnnrlnc .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#ovvcnnrlnc .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#ovvcnnrlnc .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ovvcnnrlnc .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ovvcnnrlnc .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#ovvcnnrlnc .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#ovvcnnrlnc .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#ovvcnnrlnc .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ovvcnnrlnc .gt_footnotes {
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

#ovvcnnrlnc .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ovvcnnrlnc .gt_sourcenotes {
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

#ovvcnnrlnc .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ovvcnnrlnc .gt_left {
  text-align: left;
}

#ovvcnnrlnc .gt_center {
  text-align: center;
}

#ovvcnnrlnc .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ovvcnnrlnc .gt_font_normal {
  font-weight: normal;
}

#ovvcnnrlnc .gt_font_bold {
  font-weight: bold;
}

#ovvcnnrlnc .gt_font_italic {
  font-style: italic;
}

#ovvcnnrlnc .gt_super {
  font-size: 65%;
}

#ovvcnnrlnc .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#ovvcnnrlnc .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#ovvcnnrlnc .gt_indent_1 {
  text-indent: 5px;
}

#ovvcnnrlnc .gt_indent_2 {
  text-indent: 10px;
}

#ovvcnnrlnc .gt_indent_3 {
  text-indent: 15px;
}

#ovvcnnrlnc .gt_indent_4 {
  text-indent: 20px;
}

#ovvcnnrlnc .gt_indent_5 {
  text-indent: 25px;
}

#ovvcnnrlnc .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#ovvcnnrlnc div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="njhllfpivx" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#njhllfpivx table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#njhllfpivx thead, #njhllfpivx tbody, #njhllfpivx tfoot, #njhllfpivx tr, #njhllfpivx td, #njhllfpivx th {
  border-style: none;
}

#njhllfpivx p {
  margin: 0;
  padding: 0;
}

#njhllfpivx .gt_table {
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

#njhllfpivx .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#njhllfpivx .gt_title {
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

#njhllfpivx .gt_subtitle {
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

#njhllfpivx .gt_heading {
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

#njhllfpivx .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#njhllfpivx .gt_col_headings {
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

#njhllfpivx .gt_col_heading {
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

#njhllfpivx .gt_column_spanner_outer {
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

#njhllfpivx .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#njhllfpivx .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#njhllfpivx .gt_column_spanner {
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

#njhllfpivx .gt_spanner_row {
  border-bottom-style: hidden;
}

#njhllfpivx .gt_group_heading {
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

#njhllfpivx .gt_empty_group_heading {
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

#njhllfpivx .gt_from_md > :first-child {
  margin-top: 0;
}

#njhllfpivx .gt_from_md > :last-child {
  margin-bottom: 0;
}

#njhllfpivx .gt_row {
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

#njhllfpivx .gt_stub {
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

#njhllfpivx .gt_stub_row_group {
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

#njhllfpivx .gt_row_group_first td {
  border-top-width: 2px;
}

#njhllfpivx .gt_row_group_first th {
  border-top-width: 2px;
}

#njhllfpivx .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#njhllfpivx .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#njhllfpivx .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#njhllfpivx .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#njhllfpivx .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#njhllfpivx .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#njhllfpivx .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#njhllfpivx .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#njhllfpivx .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#njhllfpivx .gt_footnotes {
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

#njhllfpivx .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#njhllfpivx .gt_sourcenotes {
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

#njhllfpivx .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#njhllfpivx .gt_left {
  text-align: left;
}

#njhllfpivx .gt_center {
  text-align: center;
}

#njhllfpivx .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#njhllfpivx .gt_font_normal {
  font-weight: normal;
}

#njhllfpivx .gt_font_bold {
  font-weight: bold;
}

#njhllfpivx .gt_font_italic {
  font-style: italic;
}

#njhllfpivx .gt_super {
  font-size: 65%;
}

#njhllfpivx .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#njhllfpivx .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#njhllfpivx .gt_indent_1 {
  text-indent: 5px;
}

#njhllfpivx .gt_indent_2 {
  text-indent: 10px;
}

#njhllfpivx .gt_indent_3 {
  text-indent: 15px;
}

#njhllfpivx .gt_indent_4 {
  text-indent: 20px;
}

#njhllfpivx .gt_indent_5 {
  text-indent: 25px;
}

#njhllfpivx .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#njhllfpivx div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="cqqgbqxccl" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#cqqgbqxccl table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#cqqgbqxccl thead, #cqqgbqxccl tbody, #cqqgbqxccl tfoot, #cqqgbqxccl tr, #cqqgbqxccl td, #cqqgbqxccl th {
  border-style: none;
}

#cqqgbqxccl p {
  margin: 0;
  padding: 0;
}

#cqqgbqxccl .gt_table {
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

#cqqgbqxccl .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#cqqgbqxccl .gt_title {
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

#cqqgbqxccl .gt_subtitle {
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

#cqqgbqxccl .gt_heading {
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

#cqqgbqxccl .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#cqqgbqxccl .gt_col_headings {
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

#cqqgbqxccl .gt_col_heading {
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

#cqqgbqxccl .gt_column_spanner_outer {
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

#cqqgbqxccl .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#cqqgbqxccl .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#cqqgbqxccl .gt_column_spanner {
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

#cqqgbqxccl .gt_spanner_row {
  border-bottom-style: hidden;
}

#cqqgbqxccl .gt_group_heading {
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

#cqqgbqxccl .gt_empty_group_heading {
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

#cqqgbqxccl .gt_from_md > :first-child {
  margin-top: 0;
}

#cqqgbqxccl .gt_from_md > :last-child {
  margin-bottom: 0;
}

#cqqgbqxccl .gt_row {
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

#cqqgbqxccl .gt_stub {
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

#cqqgbqxccl .gt_stub_row_group {
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

#cqqgbqxccl .gt_row_group_first td {
  border-top-width: 2px;
}

#cqqgbqxccl .gt_row_group_first th {
  border-top-width: 2px;
}

#cqqgbqxccl .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#cqqgbqxccl .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#cqqgbqxccl .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#cqqgbqxccl .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#cqqgbqxccl .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#cqqgbqxccl .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#cqqgbqxccl .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#cqqgbqxccl .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#cqqgbqxccl .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#cqqgbqxccl .gt_footnotes {
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

#cqqgbqxccl .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#cqqgbqxccl .gt_sourcenotes {
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

#cqqgbqxccl .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#cqqgbqxccl .gt_left {
  text-align: left;
}

#cqqgbqxccl .gt_center {
  text-align: center;
}

#cqqgbqxccl .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#cqqgbqxccl .gt_font_normal {
  font-weight: normal;
}

#cqqgbqxccl .gt_font_bold {
  font-weight: bold;
}

#cqqgbqxccl .gt_font_italic {
  font-style: italic;
}

#cqqgbqxccl .gt_super {
  font-size: 65%;
}

#cqqgbqxccl .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#cqqgbqxccl .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#cqqgbqxccl .gt_indent_1 {
  text-indent: 5px;
}

#cqqgbqxccl .gt_indent_2 {
  text-indent: 10px;
}

#cqqgbqxccl .gt_indent_3 {
  text-indent: 15px;
}

#cqqgbqxccl .gt_indent_4 {
  text-indent: 20px;
}

#cqqgbqxccl .gt_indent_5 {
  text-indent: 25px;
}

#cqqgbqxccl .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#cqqgbqxccl div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="pbifztoysc" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#pbifztoysc table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#pbifztoysc thead, #pbifztoysc tbody, #pbifztoysc tfoot, #pbifztoysc tr, #pbifztoysc td, #pbifztoysc th {
  border-style: none;
}

#pbifztoysc p {
  margin: 0;
  padding: 0;
}

#pbifztoysc .gt_table {
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

#pbifztoysc .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#pbifztoysc .gt_title {
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

#pbifztoysc .gt_subtitle {
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

#pbifztoysc .gt_heading {
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

#pbifztoysc .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#pbifztoysc .gt_col_headings {
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

#pbifztoysc .gt_col_heading {
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

#pbifztoysc .gt_column_spanner_outer {
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

#pbifztoysc .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#pbifztoysc .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#pbifztoysc .gt_column_spanner {
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

#pbifztoysc .gt_spanner_row {
  border-bottom-style: hidden;
}

#pbifztoysc .gt_group_heading {
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

#pbifztoysc .gt_empty_group_heading {
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

#pbifztoysc .gt_from_md > :first-child {
  margin-top: 0;
}

#pbifztoysc .gt_from_md > :last-child {
  margin-bottom: 0;
}

#pbifztoysc .gt_row {
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

#pbifztoysc .gt_stub {
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

#pbifztoysc .gt_stub_row_group {
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

#pbifztoysc .gt_row_group_first td {
  border-top-width: 2px;
}

#pbifztoysc .gt_row_group_first th {
  border-top-width: 2px;
}

#pbifztoysc .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#pbifztoysc .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#pbifztoysc .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#pbifztoysc .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#pbifztoysc .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#pbifztoysc .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#pbifztoysc .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#pbifztoysc .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#pbifztoysc .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#pbifztoysc .gt_footnotes {
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

#pbifztoysc .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#pbifztoysc .gt_sourcenotes {
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

#pbifztoysc .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#pbifztoysc .gt_left {
  text-align: left;
}

#pbifztoysc .gt_center {
  text-align: center;
}

#pbifztoysc .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#pbifztoysc .gt_font_normal {
  font-weight: normal;
}

#pbifztoysc .gt_font_bold {
  font-weight: bold;
}

#pbifztoysc .gt_font_italic {
  font-style: italic;
}

#pbifztoysc .gt_super {
  font-size: 65%;
}

#pbifztoysc .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#pbifztoysc .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#pbifztoysc .gt_indent_1 {
  text-indent: 5px;
}

#pbifztoysc .gt_indent_2 {
  text-indent: 10px;
}

#pbifztoysc .gt_indent_3 {
  text-indent: 15px;
}

#pbifztoysc .gt_indent_4 {
  text-indent: 20px;
}

#pbifztoysc .gt_indent_5 {
  text-indent: 25px;
}

#pbifztoysc .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#pbifztoysc div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="rwhkftiisj" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#rwhkftiisj table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#rwhkftiisj thead, #rwhkftiisj tbody, #rwhkftiisj tfoot, #rwhkftiisj tr, #rwhkftiisj td, #rwhkftiisj th {
  border-style: none;
}

#rwhkftiisj p {
  margin: 0;
  padding: 0;
}

#rwhkftiisj .gt_table {
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

#rwhkftiisj .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#rwhkftiisj .gt_title {
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

#rwhkftiisj .gt_subtitle {
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

#rwhkftiisj .gt_heading {
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

#rwhkftiisj .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#rwhkftiisj .gt_col_headings {
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

#rwhkftiisj .gt_col_heading {
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

#rwhkftiisj .gt_column_spanner_outer {
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

#rwhkftiisj .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#rwhkftiisj .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#rwhkftiisj .gt_column_spanner {
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

#rwhkftiisj .gt_spanner_row {
  border-bottom-style: hidden;
}

#rwhkftiisj .gt_group_heading {
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

#rwhkftiisj .gt_empty_group_heading {
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

#rwhkftiisj .gt_from_md > :first-child {
  margin-top: 0;
}

#rwhkftiisj .gt_from_md > :last-child {
  margin-bottom: 0;
}

#rwhkftiisj .gt_row {
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

#rwhkftiisj .gt_stub {
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

#rwhkftiisj .gt_stub_row_group {
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

#rwhkftiisj .gt_row_group_first td {
  border-top-width: 2px;
}

#rwhkftiisj .gt_row_group_first th {
  border-top-width: 2px;
}

#rwhkftiisj .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#rwhkftiisj .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#rwhkftiisj .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#rwhkftiisj .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#rwhkftiisj .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#rwhkftiisj .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#rwhkftiisj .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#rwhkftiisj .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#rwhkftiisj .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#rwhkftiisj .gt_footnotes {
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

#rwhkftiisj .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#rwhkftiisj .gt_sourcenotes {
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

#rwhkftiisj .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#rwhkftiisj .gt_left {
  text-align: left;
}

#rwhkftiisj .gt_center {
  text-align: center;
}

#rwhkftiisj .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#rwhkftiisj .gt_font_normal {
  font-weight: normal;
}

#rwhkftiisj .gt_font_bold {
  font-weight: bold;
}

#rwhkftiisj .gt_font_italic {
  font-style: italic;
}

#rwhkftiisj .gt_super {
  font-size: 65%;
}

#rwhkftiisj .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#rwhkftiisj .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#rwhkftiisj .gt_indent_1 {
  text-indent: 5px;
}

#rwhkftiisj .gt_indent_2 {
  text-indent: 10px;
}

#rwhkftiisj .gt_indent_3 {
  text-indent: 15px;
}

#rwhkftiisj .gt_indent_4 {
  text-indent: 20px;
}

#rwhkftiisj .gt_indent_5 {
  text-indent: 25px;
}

#rwhkftiisj .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#rwhkftiisj div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="oqrikbenwb" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#oqrikbenwb table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#oqrikbenwb thead, #oqrikbenwb tbody, #oqrikbenwb tfoot, #oqrikbenwb tr, #oqrikbenwb td, #oqrikbenwb th {
  border-style: none;
}

#oqrikbenwb p {
  margin: 0;
  padding: 0;
}

#oqrikbenwb .gt_table {
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

#oqrikbenwb .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#oqrikbenwb .gt_title {
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

#oqrikbenwb .gt_subtitle {
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

#oqrikbenwb .gt_heading {
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

#oqrikbenwb .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#oqrikbenwb .gt_col_headings {
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

#oqrikbenwb .gt_col_heading {
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

#oqrikbenwb .gt_column_spanner_outer {
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

#oqrikbenwb .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#oqrikbenwb .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#oqrikbenwb .gt_column_spanner {
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

#oqrikbenwb .gt_spanner_row {
  border-bottom-style: hidden;
}

#oqrikbenwb .gt_group_heading {
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

#oqrikbenwb .gt_empty_group_heading {
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

#oqrikbenwb .gt_from_md > :first-child {
  margin-top: 0;
}

#oqrikbenwb .gt_from_md > :last-child {
  margin-bottom: 0;
}

#oqrikbenwb .gt_row {
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

#oqrikbenwb .gt_stub {
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

#oqrikbenwb .gt_stub_row_group {
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

#oqrikbenwb .gt_row_group_first td {
  border-top-width: 2px;
}

#oqrikbenwb .gt_row_group_first th {
  border-top-width: 2px;
}

#oqrikbenwb .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#oqrikbenwb .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#oqrikbenwb .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#oqrikbenwb .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#oqrikbenwb .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#oqrikbenwb .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#oqrikbenwb .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#oqrikbenwb .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#oqrikbenwb .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#oqrikbenwb .gt_footnotes {
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

#oqrikbenwb .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#oqrikbenwb .gt_sourcenotes {
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

#oqrikbenwb .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#oqrikbenwb .gt_left {
  text-align: left;
}

#oqrikbenwb .gt_center {
  text-align: center;
}

#oqrikbenwb .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#oqrikbenwb .gt_font_normal {
  font-weight: normal;
}

#oqrikbenwb .gt_font_bold {
  font-weight: bold;
}

#oqrikbenwb .gt_font_italic {
  font-style: italic;
}

#oqrikbenwb .gt_super {
  font-size: 65%;
}

#oqrikbenwb .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#oqrikbenwb .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#oqrikbenwb .gt_indent_1 {
  text-indent: 5px;
}

#oqrikbenwb .gt_indent_2 {
  text-indent: 10px;
}

#oqrikbenwb .gt_indent_3 {
  text-indent: 15px;
}

#oqrikbenwb .gt_indent_4 {
  text-indent: 20px;
}

#oqrikbenwb .gt_indent_5 {
  text-indent: 25px;
}

#oqrikbenwb .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#oqrikbenwb div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="jpwwibrkbr" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>@import url("https://fonts.googleapis.com/css2?family=Atkinson+Hyperlegible+Next:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap");
#jpwwibrkbr table {
  font-family: 'Atkinson Hyperlegible Next', system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#jpwwibrkbr thead, #jpwwibrkbr tbody, #jpwwibrkbr tfoot, #jpwwibrkbr tr, #jpwwibrkbr td, #jpwwibrkbr th {
  border-style: none;
}

#jpwwibrkbr p {
  margin: 0;
  padding: 0;
}

#jpwwibrkbr .gt_table {
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

#jpwwibrkbr .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#jpwwibrkbr .gt_title {
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

#jpwwibrkbr .gt_subtitle {
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

#jpwwibrkbr .gt_heading {
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

#jpwwibrkbr .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#jpwwibrkbr .gt_col_headings {
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

#jpwwibrkbr .gt_col_heading {
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

#jpwwibrkbr .gt_column_spanner_outer {
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

#jpwwibrkbr .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#jpwwibrkbr .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#jpwwibrkbr .gt_column_spanner {
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

#jpwwibrkbr .gt_spanner_row {
  border-bottom-style: hidden;
}

#jpwwibrkbr .gt_group_heading {
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

#jpwwibrkbr .gt_empty_group_heading {
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

#jpwwibrkbr .gt_from_md > :first-child {
  margin-top: 0;
}

#jpwwibrkbr .gt_from_md > :last-child {
  margin-bottom: 0;
}

#jpwwibrkbr .gt_row {
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

#jpwwibrkbr .gt_stub {
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

#jpwwibrkbr .gt_stub_row_group {
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

#jpwwibrkbr .gt_row_group_first td {
  border-top-width: 2px;
}

#jpwwibrkbr .gt_row_group_first th {
  border-top-width: 2px;
}

#jpwwibrkbr .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#jpwwibrkbr .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#jpwwibrkbr .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#jpwwibrkbr .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#jpwwibrkbr .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#jpwwibrkbr .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#jpwwibrkbr .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#jpwwibrkbr .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#jpwwibrkbr .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#jpwwibrkbr .gt_footnotes {
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

#jpwwibrkbr .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#jpwwibrkbr .gt_sourcenotes {
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

#jpwwibrkbr .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#jpwwibrkbr .gt_left {
  text-align: left;
}

#jpwwibrkbr .gt_center {
  text-align: center;
}

#jpwwibrkbr .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#jpwwibrkbr .gt_font_normal {
  font-weight: normal;
}

#jpwwibrkbr .gt_font_bold {
  font-weight: bold;
}

#jpwwibrkbr .gt_font_italic {
  font-style: italic;
}

#jpwwibrkbr .gt_super {
  font-size: 65%;
}

#jpwwibrkbr .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#jpwwibrkbr .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#jpwwibrkbr .gt_indent_1 {
  text-indent: 5px;
}

#jpwwibrkbr .gt_indent_2 {
  text-indent: 10px;
}

#jpwwibrkbr .gt_indent_3 {
  text-indent: 15px;
}

#jpwwibrkbr .gt_indent_4 {
  text-indent: 20px;
}

#jpwwibrkbr .gt_indent_5 {
  text-indent: 25px;
}

#jpwwibrkbr .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#jpwwibrkbr div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="quitlqhbun" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>@import url("https://fonts.googleapis.com/css2?family=Orbitron:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap");
#quitlqhbun table {
  font-family: Orbitron, system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#quitlqhbun thead, #quitlqhbun tbody, #quitlqhbun tfoot, #quitlqhbun tr, #quitlqhbun td, #quitlqhbun th {
  border-style: none;
}

#quitlqhbun p {
  margin: 0;
  padding: 0;
}

#quitlqhbun .gt_table {
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

#quitlqhbun .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#quitlqhbun .gt_title {
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

#quitlqhbun .gt_subtitle {
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

#quitlqhbun .gt_heading {
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

#quitlqhbun .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#quitlqhbun .gt_col_headings {
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

#quitlqhbun .gt_col_heading {
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

#quitlqhbun .gt_column_spanner_outer {
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

#quitlqhbun .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#quitlqhbun .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#quitlqhbun .gt_column_spanner {
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

#quitlqhbun .gt_spanner_row {
  border-bottom-style: hidden;
}

#quitlqhbun .gt_group_heading {
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

#quitlqhbun .gt_empty_group_heading {
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

#quitlqhbun .gt_from_md > :first-child {
  margin-top: 0;
}

#quitlqhbun .gt_from_md > :last-child {
  margin-bottom: 0;
}

#quitlqhbun .gt_row {
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

#quitlqhbun .gt_stub {
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

#quitlqhbun .gt_stub_row_group {
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

#quitlqhbun .gt_row_group_first td {
  border-top-width: 2px;
}

#quitlqhbun .gt_row_group_first th {
  border-top-width: 2px;
}

#quitlqhbun .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#quitlqhbun .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#quitlqhbun .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#quitlqhbun .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#quitlqhbun .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#quitlqhbun .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#quitlqhbun .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#quitlqhbun .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#quitlqhbun .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#quitlqhbun .gt_footnotes {
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

#quitlqhbun .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#quitlqhbun .gt_sourcenotes {
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

#quitlqhbun .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#quitlqhbun .gt_left {
  text-align: left;
}

#quitlqhbun .gt_center {
  text-align: center;
}

#quitlqhbun .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#quitlqhbun .gt_font_normal {
  font-weight: normal;
}

#quitlqhbun .gt_font_bold {
  font-weight: bold;
}

#quitlqhbun .gt_font_italic {
  font-style: italic;
}

#quitlqhbun .gt_super {
  font-size: 65%;
}

#quitlqhbun .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#quitlqhbun .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#quitlqhbun .gt_indent_1 {
  text-indent: 5px;
}

#quitlqhbun .gt_indent_2 {
  text-indent: 10px;
}

#quitlqhbun .gt_indent_3 {
  text-indent: 15px;
}

#quitlqhbun .gt_indent_4 {
  text-indent: 20px;
}

#quitlqhbun .gt_indent_5 {
  text-indent: 25px;
}

#quitlqhbun .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#quitlqhbun div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div class="tabwid"><style>.cl-9232aace{}.cl-922f5b62{font-family:'Brush Script MT';font-size:18pt;font-weight:bold;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-922f5b76{font-family:'Brush Script MT';font-size:10.8pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;position: relative;bottom:5.4pt;}.cl-922f5b77{font-family:'Helvetica';font-size:11pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-922f5b78{font-family:'Helvetica';font-size:6.6pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;position: relative;bottom:3.3pt;}.cl-9230b520{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:2pt;padding-top:2pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-9230b521{margin:0;text-align:center;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:2pt;padding-top:2pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-9230b522{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-9230b52a{margin:0;text-align:center;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-9230b52b{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:15pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-9230b52c{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-9230c39e{width:2.026in;background-color:transparent;vertical-align: middle;border-bottom: 1pt solid rgba(0, 0, 0, 1.00);border-top: 1pt solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-9230c3a8{width:1.024in;background-color:transparent;vertical-align: middle;border-bottom: 1pt solid rgba(0, 0, 0, 1.00);border-top: 1pt solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-9230c3a9{width:2.026in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-9230c3aa{width:1.024in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-9230c3b2{width:2.026in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-9230c3b3{width:1.024in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-9230c3b4{width:2.026in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-9230c3bc{width:1.024in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-9230c3bd{width:2.026in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-9230c3be{width:1.024in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-9230c3bf{width:2.026in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-9230c3c6{width:1.024in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-9230c3c7{width:2.026in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-9230c3c8{width:1.024in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-9230c3d0{width:2.026in;background-color:transparent;vertical-align: top;border-bottom: 1pt solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-9230c3d1{width:1.024in;background-color:transparent;vertical-align: top;border-bottom: 1pt solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-9230c3d2{width:2.026in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(255, 255, 255, 0.00);border-top: 0 solid rgba(255, 255, 255, 0.00);border-left: 0 solid rgba(255, 255, 255, 0.00);border-right: 0 solid rgba(255, 255, 255, 0.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-9230c3d3{width:1.024in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(255, 255, 255, 0.00);border-top: 0 solid rgba(255, 255, 255, 0.00);border-left: 0 solid rgba(255, 255, 255, 0.00);border-right: 0 solid rgba(255, 255, 255, 0.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}</style><table data-quarto-disable-processing='true' class='cl-9232aace'><thead><tr style="overflow-wrap:break-word;"><th class="cl-9230c39e"><p class="cl-9230b520"><span class="cl-922f5b62">Characteristic</span></p></th><th class="cl-9230c3a8"><p class="cl-9230b521"><span class="cl-922f5b62">N = 200</span><span class="cl-922f5b76">1</span></p></th></tr></thead><tbody><tr style="overflow-wrap:break-word;"><td class="cl-9230c3a9"><p class="cl-9230b522"><span class="cl-922f5b77">Chemotherapy Treatment</span></p></td><td class="cl-9230c3aa"><p class="cl-9230b52a"><span class="cl-922f5b77"></span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-9230c3b2"><p class="cl-9230b52b"><span class="cl-922f5b77">Drug A</span></p></td><td class="cl-9230c3b3"><p class="cl-9230b52a"><span class="cl-922f5b77">98 (49%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-9230c3b2"><p class="cl-9230b52b"><span class="cl-922f5b77">Drug B</span></p></td><td class="cl-9230c3b3"><p class="cl-9230b52a"><span class="cl-922f5b77">102 (51%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-9230c3b2"><p class="cl-9230b522"><span class="cl-922f5b77">Age</span></p></td><td class="cl-9230c3b3"><p class="cl-9230b52a"><span class="cl-922f5b77">47 (38, 57)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-9230c3b4"><p class="cl-9230b52b"><span class="cl-922f5b77">Unknown</span></p></td><td class="cl-9230c3bc"><p class="cl-9230b52a"><span class="cl-922f5b77">11</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-9230c3bd"><p class="cl-9230b522"><span class="cl-922f5b77">T Stage</span></p></td><td class="cl-9230c3be"><p class="cl-9230b52a"><span class="cl-922f5b77"></span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-9230c3bf"><p class="cl-9230b52b"><span class="cl-922f5b77">T1</span></p></td><td class="cl-9230c3c6"><p class="cl-9230b52a"><span class="cl-922f5b77">53 (27%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-9230c3bf"><p class="cl-9230b52b"><span class="cl-922f5b77">T2</span></p></td><td class="cl-9230c3c6"><p class="cl-9230b52a"><span class="cl-922f5b77">54 (27%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-9230c3bf"><p class="cl-9230b52b"><span class="cl-922f5b77">T3</span></p></td><td class="cl-9230c3c6"><p class="cl-9230b52a"><span class="cl-922f5b77">43 (22%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-9230c3bf"><p class="cl-9230b52b"><span class="cl-922f5b77">T4</span></p></td><td class="cl-9230c3c6"><p class="cl-9230b52a"><span class="cl-922f5b77">50 (25%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-9230c3c7"><p class="cl-9230b522"><span class="cl-922f5b77">Grade</span></p></td><td class="cl-9230c3c8"><p class="cl-9230b52a"><span class="cl-922f5b77"></span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-9230c3bf"><p class="cl-9230b52b"><span class="cl-922f5b77">I</span></p></td><td class="cl-9230c3c6"><p class="cl-9230b52a"><span class="cl-922f5b77">68 (34%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-9230c3bf"><p class="cl-9230b52b"><span class="cl-922f5b77">II</span></p></td><td class="cl-9230c3c6"><p class="cl-9230b52a"><span class="cl-922f5b77">68 (34%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-9230c3d0"><p class="cl-9230b52b"><span class="cl-922f5b77">III</span></p></td><td class="cl-9230c3d1"><p class="cl-9230b52a"><span class="cl-922f5b77">64 (32%)</span></p></td></tr></tbody><tfoot><tr style="overflow-wrap:break-word;"><td  colspan="2"class="cl-9230c3d2"><p class="cl-9230b52c"><span class="cl-922f5b78">1</span><span class="cl-922f5b77">n (%); Median (Q1, Q3)</span></p></td></tr></tfoot></table></div>
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
<div class="tabwid"><style>.cl-9279648c{}.cl-9275d042{font-family:'Helvetica';font-size:14pt;font-weight:bold;font-style:normal;text-decoration:none;color:rgba(255, 255, 255, 1.00);background-color:transparent;}.cl-9275d056{font-family:'Helvetica';font-size:8.4pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(255, 255, 255, 1.00);background-color:transparent;position: relative;bottom:4.2pt;}.cl-9275d057{font-family:'Helvetica';font-size:14pt;font-weight:bold;font-style:italic;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-9275d058{font-family:'Helvetica';font-size:14pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-9275d059{font-family:'Helvetica';font-size:14pt;font-weight:normal;font-style:italic;text-decoration:none;color:rgba(0, 0, 255, 1.00);background-color:transparent;}.cl-9275d060{font-family:'Helvetica';font-size:14pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 255, 1.00);background-color:transparent;}.cl-9275d061{font-family:'Helvetica';font-size:14pt;font-weight:normal;font-style:italic;text-decoration:none;color:rgba(176, 48, 96, 1.00);background-color:transparent;}.cl-9275d062{font-family:'Helvetica';font-size:14pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(176, 48, 96, 1.00);background-color:transparent;}.cl-9275d063{font-family:'Helvetica';font-size:14pt;font-weight:normal;font-style:italic;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-9275d064{font-family:'Helvetica';font-size:14pt;font-weight:bold;font-style:normal;text-decoration:none;color:rgba(255, 0, 0, 1.00);background-color:transparent;}.cl-9275d06a{font-family:'Helvetica';font-size:8.4pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;position: relative;bottom:4.2pt;}.cl-92771876{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:2pt;padding-top:2pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-92771877{margin:0;text-align:center;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:2pt;padding-top:2pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-92771880{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-92771881{margin:0;text-align:center;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-92771882{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:15pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-9277188a{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-92772686{width:2.641in;background-color:rgba(201, 0, 0, 1.00);vertical-align: middle;border-bottom: 2pt solid rgba(0, 0, 0, 1.00);border-top: 2pt solid rgba(0, 0, 0, 1.00);border-left: 2pt solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-92772690{width:1.226in;background-color:rgba(201, 0, 0, 1.00);vertical-align: middle;border-bottom: 2pt solid rgba(0, 0, 0, 1.00);border-top: 2pt solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 2pt solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-92772691{width:2.641in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 2pt solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-9277269a{width:1.226in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 2pt solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-9277269b{width:2.641in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 2pt solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-9277269c{width:1.226in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 2pt solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-927726a4{width:2.641in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 2pt solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-927726a5{width:1.226in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 2pt solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-927726a6{width:2.641in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 2pt solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-927726a7{width:1.226in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 2pt solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-927726ae{width:2.641in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 2pt solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-927726af{width:1.226in;background-color:transparent;vertical-align: top;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 2pt solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-927726b8{width:2.641in;background-color:transparent;vertical-align: top;border-bottom: 2pt solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 2pt solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-927726b9{width:1.226in;background-color:transparent;vertical-align: top;border-bottom: 2pt solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 2pt solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-927726ba{width:2.641in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(255, 255, 255, 0.00);border-top: 0 solid rgba(255, 255, 255, 0.00);border-left: 0 solid rgba(255, 255, 255, 0.00);border-right: 0 solid rgba(255, 255, 255, 0.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-927726bb{width:1.226in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(255, 255, 255, 0.00);border-top: 0 solid rgba(255, 255, 255, 0.00);border-left: 0 solid rgba(255, 255, 255, 0.00);border-right: 0 solid rgba(255, 255, 255, 0.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}</style><table data-quarto-disable-processing='true' class='cl-9279648c'><thead><tr style="overflow-wrap:break-word;"><th class="cl-92772686"><p class="cl-92771876"><span class="cl-9275d042">Characteristic</span></p></th><th class="cl-92772690"><p class="cl-92771877"><span class="cl-9275d042">N = 200</span><span class="cl-9275d056">1</span></p></th></tr></thead><tbody><tr style="overflow-wrap:break-word;"><td class="cl-92772691"><p class="cl-92771880"><span class="cl-9275d057">Chemotherapy Treatment</span></p></td><td class="cl-9277269a"><p class="cl-92771881"><span class="cl-9275d058"></span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-9277269b"><p class="cl-92771882"><span class="cl-9275d059">Drug A</span></p></td><td class="cl-9277269c"><p class="cl-92771881"><span class="cl-9275d060">98 (49%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-9277269b"><p class="cl-92771882"><span class="cl-9275d061">Drug B</span></p></td><td class="cl-9277269c"><p class="cl-92771881"><span class="cl-9275d062">102 (51%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-9277269b"><p class="cl-92771880"><span class="cl-9275d063">Age</span></p></td><td class="cl-9277269c"><p class="cl-92771881"><span class="cl-9275d058">47 (38, 57)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-927726a4"><p class="cl-92771882"><span class="cl-9275d063">Unknown</span></p></td><td class="cl-927726a5"><p class="cl-92771881"><span class="cl-9275d058">11</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-927726a6"><p class="cl-92771880"><span class="cl-9275d063">Grade</span></p></td><td class="cl-927726a7"><p class="cl-92771881"><span class="cl-9275d058"></span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-927726ae"><p class="cl-92771882"><span class="cl-9275d063">I</span></p></td><td class="cl-927726af"><p class="cl-92771881"><span class="cl-9275d064">68 (34%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-927726ae"><p class="cl-92771882"><span class="cl-9275d063">II</span></p></td><td class="cl-927726af"><p class="cl-92771881"><span class="cl-9275d064">68 (34%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-927726ae"><p class="cl-92771882"><span class="cl-9275d063">III</span></p></td><td class="cl-927726af"><p class="cl-92771881"><span class="cl-9275d058">64 (32%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-927726ae"><p class="cl-92771880"><span class="cl-9275d063">Tumor Response</span></p></td><td class="cl-927726af"><p class="cl-92771881"><span class="cl-9275d058">61 (32%)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-927726b8"><p class="cl-92771882"><span class="cl-9275d063">Unknown</span></p></td><td class="cl-927726b9"><p class="cl-92771881"><span class="cl-9275d058">7</span></p></td></tr></tbody><tfoot><tr style="overflow-wrap:break-word;"><td  colspan="2"class="cl-927726ba"><p class="cl-9277188a"><span class="cl-9275d06a">1</span><span class="cl-9275d058">n (%); Median (Q1, Q3)</span></p></td></tr></tfoot></table></div>
```

