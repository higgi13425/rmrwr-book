---
title: "Using the {heemod} package For Health Economic Evaluation Modeling"
author: "Peter Higgins"
date: "4/29/2025"
output: html_document
---



# Using the {tabulapdf} package tp extract tables from PDFs


This chapter is part of the **Data Import** pathway. <br> Packages needed for this chapter include {tabulapdf}, {tidyverse}, and a working version of rJava. If you don't have these packages installed, you can install them by copying the code chunk below and running it in your local RStudio session. You will also likely need the {rJavaEnv} package, 
which will help you install rJava and connect it to your R environment. 


``` r
install.packages("tabulapdf")
install.packages("tidyverse")
install.packages("rJavaEnv")
```

::: tip
This chapter takes a bit of setup to get rJava working,
which is needed for the {tabulapdf} package to work and to interactively 
extract tables from PDFs.

To get rJava working on your computer can sometimes be a bear. The {rJavaEnv} 
package has made this a lot more manageable.
Let's walk through the steps to get rJava set up.
start by loading {rJavaEnv} with a library command. 
Then run the `java_check_version_cmd()` function in your local RStudio session 
to see if you already have a working version of Java on your computer.


``` r
library(rJavaEnv)
java_check_version_cmd()
```

```
## JAVA_HOME:
## '/Users/peterhiggins/Library/Caches/org.R-project.R/R/rJavaEnv/installed/macos/aarch64/21'
## Java path:
## '/Users/peterhiggins/Library/Caches/org.R-project.R/R/rJavaEnv/installed/macos/aarch64/21/bin/java'
## Java version: "openjdk version \"21.0.6\" 2025-01-21 LTS OpenJDK Runtime
## Environment Corretto-21.0.6.7.1 (build 21.0.6+7-LTS) OpenJDK 64-Bit Server VM
## Corretto-21.0.6.7.1 (build 21.0.6+7-LTS, mixed mode, sharing)"
```

```
## [1] "21"
```
If your Java version is confirmed with a path to JAVA HOME and a version number (as it does on my home computer as seen here), 
you can skip the next step.

If not, you will probably get a message like <br>
`! JAVA_HOME is not set.
[1] FALSE`

If this is the case, copy and run the `java_quick_install()` function from 
the chunk below in your local RStudio session to install the 
latest version of Java. 

``` r
java_quick_install()
```

Now check that this worked by running the `java_check_version_cmd()` 
function in your local RStudio session again.


``` r
java_check_version_cmd()
```
This should now tell you the path to JAVA HOME, the Java path, and the Java version.
Once this is set, you are ready to get started.
:::

## Why Tables from PDFs?

Many organizations publish reports as PDFs, with tables of data in them.
It would be much more valuable for data anlysis
to have these data publicly available in a format that can be used for analysis (like downloadable csv files). This chapter will show you how to do extract these tables from PDFs.

## Extracting Tables from PDFs
The {tabulapdf} package is a great tool for extracting tables from PDFs. It uses the Java library Tabula (the equivalent of R packages in the Java computer language are called `libraries`)  to do this, and it works well with many different types of tables.

To use the {tabulapdf} package, you need to have Java installed on your computer. If you don't have Java installed, you can follow the instructions in the previous section to install it.

Run the code chunk below to load the {tabulapdf} package into your R session, along with {tidyverse} to clean up the data tables we will extract (there will be lots of cleaning up).


``` r
library(tabulapdf)
library(tidyverse)
```

Now let's start with a PDF filled with health-related data tables.
This is a nice example from KFF, the Kaiser Family Foundation, which is a non-profit organization that provides information on health issues at www.kff.org.

Unfortunately, they publish a lot of interesting health and health insurance data
in tables in PDFs.

Let's link this pdf to an object in R, by running the code chunk below. Copy and run this code chunk in your local RStudio session.


``` r
kff_pdf <- "https://files.kff.org/attachment/Topline-Survey-of-Consumer-Experiences-with-Health-Insurance.pdf"
```

## Extracting Tables from PDFs
Now we have to extract some data tables from this PDF. The nice folks at KFF have a habit of including lots of summary rows and subset totals as distinct rows in their tables, so we will have to select the columns and rows that we want, and frequently rename columns.

The {tabulapdf} package has a function called `extract_tables()` that will help you pull out the tables from a PDF.
To get started, we can simply grab ALL the tables, or do this in a targeted way.

Take a moment to go the the website for this PDF, [here](https://files.kff.org/attachment/Topline-Survey-of-Consumer-Experiences-with-Health-Insurance.pdf), and scroll through the PDF to see what tables are in it. Keep this PDF window open for future reference during this chapter.

Let's get a quick overview of this PDF by running the commands in the code chunk below.

``` r
# Get the number of pages in the PDF
get_n_pages(kff_pdf)
```

```
## [1] 40
```

``` r
# Get the metadata on the PDF
extract_metadata(kff_pdf)
```

```
## $pages
## [1] 40
## 
## $title
## [1] "KFF Survey of Consumer Experiences with Health Insurance"
## 
## $author
## NULL
## 
## $subject
## NULL
## 
## $keywords
## [1] "Topline-Survey-of-Consumer-Experiences-with-Health-Insurance"
## 
## $creator
## [1] "Microsoft® Word for Microsoft 365"
## 
## $producer
## [1] "Microsoft® Word for Microsoft 365"
## 
## $created
## [1] "Thu Jun 08 15:15:33 EDT 2023"
## 
## $modified
## [1] "Mon Jun 12 16:07:40 EDT 2023"
## 
## $trapped
## NULL
```

``` r
# figure out the pixel dimensions of the PDF pages
get_page_dims(kff_pdf, pages = 1:2)
```

```
## [[1]]
## [1] 612 792
## 
## [[2]]
## [1] 612 792
```

Now we know that there are 40 pages in this PDF, it was exported to PDF from Microsoft Word on June 8th 2023, and we have a title and some keywords.

We also learned that each page is 612 pixels wide and 792 pixels tall (the pages are
all the same size, 8.5 inches wide by 11 inches tall).

## Extracting Tables from the PDF

Let's go whole hog. Let's see how many tables there are.
This will take a minute, but run the code chunk belowin your local R session.


``` r
# Extract all tables from the PDF
kff_tables <- extract_tables(kff_pdf, pages = 1:40, output = "tibble")
```
If you take a look in your Environment tab, you will now find the kff_tables object.
It is a list of 38 tables.
Click on the object in the Environment tab, and you will see a list of 38 tables
in the Viewer tab. Each table has its own blue dot with a white triangle next
to the table number. Click on one or two of these to expand them, and compare these to the PDF. See if you can figure out which table object corresponds to which table in the PDF.

You will probably find that there are actually more than 38 tables in the PDF.
Several of these are stuck together in the table extraction process, and some of them are empty.

To take a look at one of the tables in the list, run the code chunk below,
which will pull out the 17th table in the list and show it in the Viewer tab.


``` r
# Extract the 17th table from the list of tables
kff_tables[[17]]
```

The result is a bit wonky, but recognizable as all of the tables in response to questions
17 through 19b, all bound together in a single table. Scroll through the PDF to find these.

## Extracting a Specific Table
You can use `slice()` to select specific rows to get the table that you actually want.
Let's try to get the data in response to question 19a. This was: "In the past 12 
months, did you end up paying more for treatment or services than you expected 
to pay as a direct result of the problems youhad with your current health
insurance?"

This is a yes/no question, and the table shows the percentage of people who said
yes, and the percentage of people who said no. 

To do this, we can use the `extract_tables()` function again, but this time we 
will pull this one `table` and slice out the rows that we want.
Copy and run the code below in your local R session. Review each line to make sure you know what each function is doing.


``` r
# Extract the 17th table from the list of tables
pay_more <- kff_tables[[17]] |>
  slice(20:21) |>
  rename(response = `...1`) |>
  separate(`Total sponsored`, into = c("overall", "emp_sponsored"), sep = "\\s") |>
  relocate(overall, .after = Marketplace) |>
  janitor::clean_names()

pay_more |>
  gt::gt()
```

```{=html}
<div id="fidkcxgrkw" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#fidkcxgrkw table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#fidkcxgrkw thead, #fidkcxgrkw tbody, #fidkcxgrkw tfoot, #fidkcxgrkw tr, #fidkcxgrkw td, #fidkcxgrkw th {
  border-style: none;
}

#fidkcxgrkw p {
  margin: 0;
  padding: 0;
}

#fidkcxgrkw .gt_table {
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

#fidkcxgrkw .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#fidkcxgrkw .gt_title {
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

#fidkcxgrkw .gt_subtitle {
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

#fidkcxgrkw .gt_heading {
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

#fidkcxgrkw .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#fidkcxgrkw .gt_col_headings {
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

#fidkcxgrkw .gt_col_heading {
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

#fidkcxgrkw .gt_column_spanner_outer {
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

#fidkcxgrkw .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#fidkcxgrkw .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#fidkcxgrkw .gt_column_spanner {
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

#fidkcxgrkw .gt_spanner_row {
  border-bottom-style: hidden;
}

#fidkcxgrkw .gt_group_heading {
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

#fidkcxgrkw .gt_empty_group_heading {
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

#fidkcxgrkw .gt_from_md > :first-child {
  margin-top: 0;
}

#fidkcxgrkw .gt_from_md > :last-child {
  margin-bottom: 0;
}

#fidkcxgrkw .gt_row {
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

#fidkcxgrkw .gt_stub {
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

#fidkcxgrkw .gt_stub_row_group {
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

#fidkcxgrkw .gt_row_group_first td {
  border-top-width: 2px;
}

#fidkcxgrkw .gt_row_group_first th {
  border-top-width: 2px;
}

#fidkcxgrkw .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#fidkcxgrkw .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#fidkcxgrkw .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#fidkcxgrkw .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#fidkcxgrkw .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#fidkcxgrkw .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#fidkcxgrkw .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#fidkcxgrkw .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#fidkcxgrkw .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#fidkcxgrkw .gt_footnotes {
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

#fidkcxgrkw .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#fidkcxgrkw .gt_sourcenotes {
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

#fidkcxgrkw .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#fidkcxgrkw .gt_left {
  text-align: left;
}

#fidkcxgrkw .gt_center {
  text-align: center;
}

#fidkcxgrkw .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#fidkcxgrkw .gt_font_normal {
  font-weight: normal;
}

#fidkcxgrkw .gt_font_bold {
  font-weight: bold;
}

#fidkcxgrkw .gt_font_italic {
  font-style: italic;
}

#fidkcxgrkw .gt_super {
  font-size: 65%;
}

#fidkcxgrkw .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#fidkcxgrkw .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#fidkcxgrkw .gt_indent_1 {
  text-indent: 5px;
}

#fidkcxgrkw .gt_indent_2 {
  text-indent: 10px;
}

#fidkcxgrkw .gt_indent_3 {
  text-indent: 15px;
}

#fidkcxgrkw .gt_indent_4 {
  text-indent: 20px;
}

#fidkcxgrkw .gt_indent_5 {
  text-indent: 25px;
}

#fidkcxgrkw .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#fidkcxgrkw div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="response">response</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="emp_sponsored">emp_sponsored</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="medicare">medicare</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="medicaid">medicaid</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="marketplace">marketplace</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="overall">overall</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="response" class="gt_row gt_left">Yes</td>
<td headers="emp_sponsored" class="gt_row gt_right">33</td>
<td headers="medicare" class="gt_row gt_right">19</td>
<td headers="medicaid" class="gt_row gt_right">12</td>
<td headers="marketplace" class="gt_row gt_right">35</td>
<td headers="overall" class="gt_row gt_right">28</td></tr>
    <tr><td headers="response" class="gt_row gt_left">No</td>
<td headers="emp_sponsored" class="gt_row gt_right">67</td>
<td headers="medicare" class="gt_row gt_right">80</td>
<td headers="medicaid" class="gt_row gt_right">88</td>
<td headers="marketplace" class="gt_row gt_right">65</td>
<td headers="overall" class="gt_row gt_right">72</td></tr>
  </tbody>
  
  
</table>
</div>
```

Despite the common assumption that employer sponsored health insurance in the US
is the best, satisfaction seems to be higher for medicaid and medicare.

You can even remove the response column (the chi-squared test will not work with a character column),
convert the percentages from character to numeric, and run a chi-squared test to show that the different types of insurance are significantly different from each other by this metric.


``` r
pay_more |>
  select(-response) |>
  mutate_if(is.character, as.numeric) |>
  chisq.test()
```

```
## 
## 	Pearson's Chi-squared test
## 
## data:  mutate_if(select(pay_more, -response), is.character, as.numeric)
## X-squared = 19.732, df = 4, p-value = 0.0005641
```

## Extracting a Specific Table
But this approach is a bit cumbersome, and involves a fair amount of hunting to 
find the table you want, and to clean it up.
Instead, we can use the `extract_tables()` function to extract a specific page.
This narrows it down a lot.


``` r
kff_tables <- extract_tables(kff_pdf, pages = 5, output = "tibble")
head(kff_tables)
```

```
## [[1]]
## # A tibble: 20 × 10
##    ...1                Excellent ...3  ...4  ...5  ...6  ...7  ...8  ...9  ...10
##    <chr>               <chr>     <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr>
##  1 <NA>                / Very    <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA> 
##  2 <NA>                good/     <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA> 
##  3 <NA>                Good      <NA>  Very  <NA>  Fair… <NA>  <NA>  No    <NA> 
##  4 <NA>                (NET)     Exce… good  Good  (NET) Fair  Poor  answ… <NA> 
##  5 a. physical health  <NA>      <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA> 
##  6 Total               84        12    35    38    16    14    2     *     n=3,…
##  7 Employer            89        14    37    39    11    10    1     -     n=978
##  8 sponsored           <NA>      <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA> 
##  9 Medicare            77        8     34    36    23    18    4     *     n=885
## 10 Medicaid            68        8     24    36    32    27    5     -     n=815
## 11 Marketplace         84        15    36    33    16    14    2     -     n=880
## 12 b. mental health a… <NA>      <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA> 
## 13 emotional well-     <NA>      <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA> 
## 14 being               <NA>      <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA> 
## 15 Total               82        21    31    30    18    14    3     *     n=3,…
## 16 Employer            84        19    35    30    16    13    3     -     n=978
## 17 sponsored           <NA>      <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>  <NA> 
## 18 Medicare            89        28    31    29    11    10    2     *     n=885
## 19 Medicaid            64        12    17    35    36    29    7     -     n=815
## 20 Marketplace         80        22    31    28    20    17    3     -     n=880
```
Now there is only one table to look at, and it is a bit easier to see what 
is going on. Note that kff_tables is still a list (take a look in the Viewer tab), and we still have to pluck out the tibble we want, even though there is only one. Our usual data cleaning functions from {dplyr} will work on a tibgle, but not on a list. We need to pluck out the tibble we want. There are two ways to do this:

- kff_tables[[1]], or
- kff_tables %>% pluck(1)

For our purposes, on page 5 of this PDF, we want the mental health and emotional
well-being table, so we can slice rows 15 to 20, and clean up the column names 
to get only the raw data columns.


``` r
mental_health <- kff_tables[[1]] |>
  slice(15:20) |>
  select(1, 3:5, 7:8) |>
  rename(
    insurance = `...1`,
    excellent = `...3`,
    very_good = `...4`,
    good = `...5`,
    fair = `...7`,
    poor = `...8`
  ) |>
  pivot_longer(
    cols = c(excellent, very_good, good, fair, poor),
    names_to = "rating",
    values_to = "percent"
  ) |>
  mutate(insurance = case_when(
    insurance == "Total" ~ "overall",
    TRUE ~ insurance
  )) |>
  filter(insurance != "sponsored") |>
  pivot_wider(
    names_from = insurance,
    values_from = percent
  ) |>
  janitor::clean_names() |>
  relocate(overall, .after = marketplace)

mental_health
```

```
## # A tibble: 5 × 6
##   rating    employer medicare medicaid marketplace overall
##   <chr>     <chr>    <chr>    <chr>    <chr>       <chr>  
## 1 excellent 19       28       12       22          21     
## 2 very_good 35       31       17       31          31     
## 3 good      30       29       35       28          30     
## 4 fair      13       10       29       17          14     
## 5 poor      3        2        7        3           3
```

As you can see, removing subtotals and rearranging to get clean data takes a
bit of wrangling to get it into a tidy clean format of raw data.
But now we can use this data to make plots or perform analyses.

## Viewing and Targeting the PDF
The {tabula_pdf} package can go even farther. It can let you view thumbnails of
the pages in the RStudio Viewer window, and even pick out the particular
table area that you want to extract.
This can only be done in an **interactive** R session, as it will open a shiny app in the Viewer tab and require a human to draw a rectangle around the desired section of the PDF to extract a table from.


``` r
# get some overview data on the PDF
kff_pdf |>
  get_n_pages()
```

```
## [1] 40
```

``` r
subtable <- kff_pdf |>
  locate_areas(pages = 22)
```

```
## Error in locate_areas(kff_pdf, pages = 22): locate_areas() is only available in an interactive session
```

``` r
# manually select the area of the table
# using the shiny widget in the Viewer pane
# then click the Done button at the top right

extract_tables(kff_pdf,
  pages = 22,
  guess = FALSE,
  col_names = FALSE,
  area = subtable
)
```

```
## Error: object 'subtable' not found
```

You can also combine the steps and just use the `extract_areas()` function to
pull data from a specific area of the PDF. This is useful if you know exactly 
which table you want to extract.

Let's try this for question 15h (_deny or delay drug coverage_) on page 19 of this PDF in the code chunk 
below. Copy and run this in your local RStudio session. Click Done when you have completed your rectangle.


``` r
# Extract the table from the PDF
deny <- extract_areas(kff_pdf, pages = 19, output = "tibble")
deny
```

This should produce a 5 x 6 tibble,
with some goofy column names, a total row that you probably don't want,
and some extra columns for `no answer` and N that you don't need.

If you did not draw the rectangle around the table quite right,
just run the code chunk again and adjust your area.
The `deny` object that you selected with your rectangle is still a list, 
so you need to pluck out the first table
with `deny[[1]]`, or pluck(1) to get a single tibble instead of a list.
Then use the `select()`  and `slice()` functions to get down to the raw data,
and rename the columns with the `rename()` function to fix these one at a time,
or with the `purrr:set_names()` function for renaming all the names at once.

An example of data cleaning is shown below.
I managed to cut off the `b` in `before` with my rectangle, so I had to shorten 
the insurance column name in the rename function.


``` r
# Clean up the table
deny2 <- deny |>
  pluck(1) |> # you could use deny[[1]] for the first 2 lines
  rename(
    insurance = `efore you received it`,
    yes = `...2`,
    no = `...3`,
    not_tried = `...4`
  ) |>
  slice(2:5) |>
  select(-`...5`, -`...6`)
deny2
```


:::tryit
Now try it yourself.
Try to grab an interesting section from the big table on page 22 of the PDF.
Pick a question that interests you, grab it with a rectangle,
and extract and clean the raw data into an analysis-ready tibble.
:::


The example below is one possible solution for question 20d


<div class='webex-solution'><button>Solution</button>


``` r
# note that I excluded the last 2 columns by drawing a smaller rectangle
extract_areas(kff_pdf, pages = 22, output = "tibble") |>
  pluck(1) |>
  slice(3:6) |>
  purrr::set_names(c("insurance", "yes", "no"))
```

```
## Error in locate_areas(file = file, pages = pages, copy = copy): locate_areas() is only available in an interactive session
```

</div>


Note that the interactive portion of drawing the rectangle actually makes this
process **less** reproducible, because a key piece is not hard-coded, but it is 
a pretty convenient tool for quickly getting the exact data you want, especially when it is a difficult table structure.

This sort of interactive step can not be scheduled or run automatically, as
it requires a person to draw the rectangle in real time, so it is fine for 
one-off interactive coding, but not for a reproducible workflow.


:::tryit

## Your Turn

Let's try to extract some data from a PDF from the Centers for Disease Control (CDC). Get the pdf from the code chunk below. Tables are on pages 26-51. You will want to find & inspect the PDF on the web at https://www.cdc.gov/nchs/data/hus/hus19-508.pdf to help you pick out an interesting table.
Note that the page numbers within the pdf do not correspond to the actual page numbers of the document. You may have to add ~11 to the listed page number the get the actual page/table. 

``` r
cdc_pdf <- "https://www.cdc.gov/nchs/data/hus/hus19-508.pdf"
```

Pick out a table that you find interesting, and try to extract it and clean it up to raw data. Try doing one table programmatically, and (a harder one) interactively. The side-by-side ones on pages 47-48 (which are really 58-59) may be good examples for interactive extraction. See if you can get all 50 states into one table. 

The example below is one possible table extraction for health care expenditures by an individual.


<div class='webex-solution'><button>Solution</button>


``` r
cdc_pdf |> extract_tables(pages = 60) -> health_dollars
```

```
## New names:
## • `` -> `...1`
## • `` -> `...2`
## • `` -> `...3`
## • `` -> `...4`
## • `` -> `...5`
## • `` -> `...7`
## • `` -> `...8`
```

``` r
health_dollars |>
  pluck(1) |>
  slice(5:15) |>
  separate(`Source of funds`, into = c("medicaid_f", "medicaid_s"), sep = " ", extra = "merge") |>
  purrr::set_names(c("year", "hc_spend_total", "private_ins", "medicare", "medicaid_total", "medicaid_federal", "medicaid_state", "out_of_pocket", "other")) |>
  mutate(year = parse_number(year)) |>
  mutate(across(
    .cols = where(is.character),
    parse_number
  ))
```

```
## # A tibble: 11 × 9
##     year hc_spend_total private_ins medicare medicaid_total medicaid_federal
##    <dbl>          <dbl>       <dbl>    <dbl>          <dbl>            <dbl>
##  1  2008          2009.        698.     442            318.             188.
##  2  2009          2111.        731.     470.           346.             231.
##  3  2010          2191.        751.     489.           366.             247.
##  4  2011          2267.        780      512            374.             228.
##  5  2012          2361.        810.     534.           388.             224.
##  6  2013          2431.        824.     554.           406.             234.
##  7  2014          2556         870.     580.           447.             274.
##  8  2015          2710.        936.     607.           484.             304.
##  9  2016          2838.        990.     630.           504              318.
## 10  2017          2954.       1032.     659.           520.             323.
## 11  2018          3076.       1079.     697.           533.             331.
## # ℹ 3 more variables: medicaid_state <dbl>, out_of_pocket <dbl>, other <dbl>
```

</div>


::: 


:::explore
### Explore More Features
Explore more features of {tabulapdf} at the Tabula website [here](https://tabula.technology/).
The package website can be found [here](https://docs.ropensci.org/tabulapdf/).
You can see the official documentation of this package on CRAN [here](https://cran.r-project.org/web/packages/tabulapdf/tabulapdf.pdf).
:::
