---
title: "Building Table One for a Clinical Study"
author: "Peter D.R. Higgins"
output:
  html_document:
    df_print: paged
editor_options:
  markdown:
    wrap: sentence
---

# Building Table One for a Clinical Study

In most clinical research, whether in an epidemiologic study or in a clinical trial, 
it is important to present a summary of the baseline characteristics of the 
study sample. This is often referred to as a "Table 1" or "Table One". You 
generally want to provide enough information about your study sample so that a reader
can determine whether your study sample is similar to the population or the
specific patient they are interested in. The reader should be able to determine if the
study is generalizable to their popuation or their patient of interest.

There are a number of R packates that can help you build a Table 1. These include 
the appropriately named `{tableone}` package, the `{arsenal}` package, and the `{compareGroups}` package. But since 2020, the `{gtsummary}` package has become the most popular package for this purpose. This is in part because it is focused on clinical applications, and because it builds on the robust table infrastructure provided by 
the `{gt}` package, which is a modern approach to building tables in R.

In this chapter, we will focus on building a Table 1 using data from the `{medicaldata}` package, the `{gtsummary}` package, and the `{arsenal}` package. 
The `{gtsummary}` package is also generally useful for producing other tables and 
tables of regression results. 

## Packages Needed for this Chapter:
- `{gt}`
- `{gtsummary}`
- `{arsenal}`
- `{medicaldata}`
- `{tidyverse}`

## Pathway for this Chapter


Let's start by looking at the mockstudy data from the `{arsenal}` package.
This is a mock study of treatment of cholangiocarcinoma with 3 different
chemotherapy regimens.
We will generate the dimensions, then `glimpse` the data.


``` r
dim(mockstudy)
```

```
## [1] 1499   14
```

``` r
glimpse(mockstudy)
```

```
## Rows: 1,499
## Columns: 14
## $ case        <int> 110754, 99706, 105271, 105001, 112263, 86205, 99508, 90158…
## $ age         <int> 67, 74, 50, 71, 69, 56, 50, 57, 51, 63, 61, 59, 61, 59, 60…
## $ arm         <chr> "F: FOLFOX", "A: IFL", "A: IFL", "G: IROX", "F: FOLFOX", "…
## $ sex         <fct> Male, Female, Female, Female, Female, Male, Male, Male, Fe…
## $ race        <chr> "Caucasian", "Caucasian", "Caucasian", "Caucasian", NA, "C…
## $ fu.time     <int> 922, 270, 175, 128, 233, 120, 369, 421, 387, 363, 168, 106…
## $ fu.stat     <int> 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2…
## $ ps          <int> 0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0, 0…
## $ hgb         <dbl> 11.5, 10.7, 11.1, 12.6, 13.0, 10.2, 13.3, 12.1, 13.8, 12.1…
## $ bmi         <dbl> 25.09861, 19.49786, NA, 29.42922, 26.35352, 19.03673, 24.5…
## $ alk.phos    <int> 160, 290, 700, 771, 350, 569, 162, 152, 231, 492, 740, 239…
## $ ast         <int> 35, 52, 100, 68, 35, 27, 16, 12, 25, 18, 45, 16, 50, 80, 1…
## $ mdquality.s <int> NA, 1, 1, 1, NA, 1, 1, 1, 1, 1, NA, NA, 1, 0, 1, 1, 0, NA,…
## $ age.ord     <ord> 60-69, 70-79, 40-49, 70-79, 60-69, 50-59, 40-49, 50-59, 50…
```

## Baseline Characteristics
For a Table One, you do not want outcomes like fu.time (followup time), but you do want particpant characteristics that were present at the start of the study. We also don't
need trivial information like case numbers or patient IDs. Let's select
for these with dplyr::select.


``` r
mockstudy_baseline <- mockstudy %>% 
  select(-fu.time, -fu.stat, -ps, -case, -mdquality.s, -age.ord)
```

## Building Your Table 1
The main function for building a Table 1 with gtsummary is `tbl_summary()`.
We can pipe the selected data into this function to get a first (ungrouped) version of the 
table.

``` r
mockstudy_baseline |> 
  tbl_summary()
```

```{=html}
<div id="dtqjxiyjcw" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#dtqjxiyjcw table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#dtqjxiyjcw thead, #dtqjxiyjcw tbody, #dtqjxiyjcw tfoot, #dtqjxiyjcw tr, #dtqjxiyjcw td, #dtqjxiyjcw th {
  border-style: none;
}

#dtqjxiyjcw p {
  margin: 0;
  padding: 0;
}

#dtqjxiyjcw .gt_table {
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

#dtqjxiyjcw .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#dtqjxiyjcw .gt_title {
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

#dtqjxiyjcw .gt_subtitle {
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

#dtqjxiyjcw .gt_heading {
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

#dtqjxiyjcw .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#dtqjxiyjcw .gt_col_headings {
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

#dtqjxiyjcw .gt_col_heading {
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

#dtqjxiyjcw .gt_column_spanner_outer {
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

#dtqjxiyjcw .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#dtqjxiyjcw .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#dtqjxiyjcw .gt_column_spanner {
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

#dtqjxiyjcw .gt_spanner_row {
  border-bottom-style: hidden;
}

#dtqjxiyjcw .gt_group_heading {
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

#dtqjxiyjcw .gt_empty_group_heading {
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

#dtqjxiyjcw .gt_from_md > :first-child {
  margin-top: 0;
}

#dtqjxiyjcw .gt_from_md > :last-child {
  margin-bottom: 0;
}

#dtqjxiyjcw .gt_row {
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

#dtqjxiyjcw .gt_stub {
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

#dtqjxiyjcw .gt_stub_row_group {
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

#dtqjxiyjcw .gt_row_group_first td {
  border-top-width: 2px;
}

#dtqjxiyjcw .gt_row_group_first th {
  border-top-width: 2px;
}

#dtqjxiyjcw .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#dtqjxiyjcw .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#dtqjxiyjcw .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#dtqjxiyjcw .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#dtqjxiyjcw .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#dtqjxiyjcw .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#dtqjxiyjcw .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#dtqjxiyjcw .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#dtqjxiyjcw .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#dtqjxiyjcw .gt_footnotes {
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

#dtqjxiyjcw .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#dtqjxiyjcw .gt_sourcenotes {
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

#dtqjxiyjcw .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#dtqjxiyjcw .gt_left {
  text-align: left;
}

#dtqjxiyjcw .gt_center {
  text-align: center;
}

#dtqjxiyjcw .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#dtqjxiyjcw .gt_font_normal {
  font-weight: normal;
}

#dtqjxiyjcw .gt_font_bold {
  font-weight: bold;
}

#dtqjxiyjcw .gt_font_italic {
  font-style: italic;
}

#dtqjxiyjcw .gt_super {
  font-size: 65%;
}

#dtqjxiyjcw .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#dtqjxiyjcw .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#dtqjxiyjcw .gt_indent_1 {
  text-indent: 5px;
}

#dtqjxiyjcw .gt_indent_2 {
  text-indent: 10px;
}

#dtqjxiyjcw .gt_indent_3 {
  text-indent: 15px;
}

#dtqjxiyjcw .gt_indent_4 {
  text-indent: 20px;
}

#dtqjxiyjcw .gt_indent_5 {
  text-indent: 25px;
}

#dtqjxiyjcw .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#dtqjxiyjcw div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Characteristic</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_0"><span class='gt_from_md'><strong>N = 1,499</strong></span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left">Age in Years</td>
<td headers="stat_0" class="gt_row gt_center">61 (52, 68)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Treatment Arm</td>
<td headers="stat_0" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    A: IFL</td>
<td headers="stat_0" class="gt_row gt_center">428 (29%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    F: FOLFOX</td>
<td headers="stat_0" class="gt_row gt_center">691 (46%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    G: IROX</td>
<td headers="stat_0" class="gt_row gt_center">380 (25%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">sex</td>
<td headers="stat_0" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Male</td>
<td headers="stat_0" class="gt_row gt_center">916 (61%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Female</td>
<td headers="stat_0" class="gt_row gt_center">583 (39%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Race</td>
<td headers="stat_0" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    African-Am</td>
<td headers="stat_0" class="gt_row gt_center">115 (7.7%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Asian</td>
<td headers="stat_0" class="gt_row gt_center">18 (1.2%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Caucasian</td>
<td headers="stat_0" class="gt_row gt_center">1,288 (86%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Hawaii/Pacific</td>
<td headers="stat_0" class="gt_row gt_center">5 (0.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Hispanic</td>
<td headers="stat_0" class="gt_row gt_center">54 (3.6%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Native-Am/Alaska</td>
<td headers="stat_0" class="gt_row gt_center">5 (0.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Other</td>
<td headers="stat_0" class="gt_row gt_center">7 (0.5%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Unknown</td>
<td headers="stat_0" class="gt_row gt_center">7</td></tr>
    <tr><td headers="label" class="gt_row gt_left">hgb</td>
<td headers="stat_0" class="gt_row gt_center">12.30 (11.10, 13.50)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Unknown</td>
<td headers="stat_0" class="gt_row gt_center">266</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Body Mass Index (kg/m^2)</td>
<td headers="stat_0" class="gt_row gt_center">26.3 (23.5, 30.2)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Unknown</td>
<td headers="stat_0" class="gt_row gt_center">33</td></tr>
    <tr><td headers="label" class="gt_row gt_left">alk.phos</td>
<td headers="stat_0" class="gt_row gt_center">123 (86, 207)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Unknown</td>
<td headers="stat_0" class="gt_row gt_center">266</td></tr>
    <tr><td headers="label" class="gt_row gt_left">ast</td>
<td headers="stat_0" class="gt_row gt_center">27 (20, 41)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Unknown</td>
<td headers="stat_0" class="gt_row gt_center">266</td></tr>
  </tbody>
  
  <tfoot class="gt_footnotes">
    <tr>
      <td class="gt_footnote" colspan="2"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span> <span class='gt_from_md'>Median (Q1, Q3); n (%)</span></td>
    </tr>
  </tfoot>
</table>
</div>
```

### Updating Variable Labels
This very quickly gives you a pretty version of a Table 1 that is publication-ready. However, you might not like the variable names that were easy to use in analysis.
You might want longer or clearer versions for the table for publication. You can use the `tbl_summary()` function to rename variables. You can use the `label` argument to rename variables. Let's rename the variables Sex and Race in the table to make them more publication-ready.


``` r
mockstudy_baseline |> 
  tbl_summary(label = list( sex ~ "Sex at Birth",
                            race ~ "Race Identified by Participant"))
```

```{=html}
<div id="ugsasibwwf" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#ugsasibwwf table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#ugsasibwwf thead, #ugsasibwwf tbody, #ugsasibwwf tfoot, #ugsasibwwf tr, #ugsasibwwf td, #ugsasibwwf th {
  border-style: none;
}

#ugsasibwwf p {
  margin: 0;
  padding: 0;
}

#ugsasibwwf .gt_table {
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

#ugsasibwwf .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#ugsasibwwf .gt_title {
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

#ugsasibwwf .gt_subtitle {
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

#ugsasibwwf .gt_heading {
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

#ugsasibwwf .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ugsasibwwf .gt_col_headings {
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

#ugsasibwwf .gt_col_heading {
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

#ugsasibwwf .gt_column_spanner_outer {
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

#ugsasibwwf .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#ugsasibwwf .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#ugsasibwwf .gt_column_spanner {
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

#ugsasibwwf .gt_spanner_row {
  border-bottom-style: hidden;
}

#ugsasibwwf .gt_group_heading {
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

#ugsasibwwf .gt_empty_group_heading {
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

#ugsasibwwf .gt_from_md > :first-child {
  margin-top: 0;
}

#ugsasibwwf .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ugsasibwwf .gt_row {
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

#ugsasibwwf .gt_stub {
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

#ugsasibwwf .gt_stub_row_group {
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

#ugsasibwwf .gt_row_group_first td {
  border-top-width: 2px;
}

#ugsasibwwf .gt_row_group_first th {
  border-top-width: 2px;
}

#ugsasibwwf .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ugsasibwwf .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#ugsasibwwf .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#ugsasibwwf .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ugsasibwwf .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ugsasibwwf .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#ugsasibwwf .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#ugsasibwwf .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#ugsasibwwf .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ugsasibwwf .gt_footnotes {
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

#ugsasibwwf .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ugsasibwwf .gt_sourcenotes {
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

#ugsasibwwf .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ugsasibwwf .gt_left {
  text-align: left;
}

#ugsasibwwf .gt_center {
  text-align: center;
}

#ugsasibwwf .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ugsasibwwf .gt_font_normal {
  font-weight: normal;
}

#ugsasibwwf .gt_font_bold {
  font-weight: bold;
}

#ugsasibwwf .gt_font_italic {
  font-style: italic;
}

#ugsasibwwf .gt_super {
  font-size: 65%;
}

#ugsasibwwf .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#ugsasibwwf .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#ugsasibwwf .gt_indent_1 {
  text-indent: 5px;
}

#ugsasibwwf .gt_indent_2 {
  text-indent: 10px;
}

#ugsasibwwf .gt_indent_3 {
  text-indent: 15px;
}

#ugsasibwwf .gt_indent_4 {
  text-indent: 20px;
}

#ugsasibwwf .gt_indent_5 {
  text-indent: 25px;
}

#ugsasibwwf .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#ugsasibwwf div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Characteristic</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_0"><span class='gt_from_md'><strong>N = 1,499</strong></span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left">Age in Years</td>
<td headers="stat_0" class="gt_row gt_center">61 (52, 68)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Treatment Arm</td>
<td headers="stat_0" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    A: IFL</td>
<td headers="stat_0" class="gt_row gt_center">428 (29%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    F: FOLFOX</td>
<td headers="stat_0" class="gt_row gt_center">691 (46%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    G: IROX</td>
<td headers="stat_0" class="gt_row gt_center">380 (25%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Sex at Birth</td>
<td headers="stat_0" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Male</td>
<td headers="stat_0" class="gt_row gt_center">916 (61%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Female</td>
<td headers="stat_0" class="gt_row gt_center">583 (39%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Race Identified by Participant</td>
<td headers="stat_0" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    African-Am</td>
<td headers="stat_0" class="gt_row gt_center">115 (7.7%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Asian</td>
<td headers="stat_0" class="gt_row gt_center">18 (1.2%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Caucasian</td>
<td headers="stat_0" class="gt_row gt_center">1,288 (86%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Hawaii/Pacific</td>
<td headers="stat_0" class="gt_row gt_center">5 (0.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Hispanic</td>
<td headers="stat_0" class="gt_row gt_center">54 (3.6%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Native-Am/Alaska</td>
<td headers="stat_0" class="gt_row gt_center">5 (0.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Other</td>
<td headers="stat_0" class="gt_row gt_center">7 (0.5%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Unknown</td>
<td headers="stat_0" class="gt_row gt_center">7</td></tr>
    <tr><td headers="label" class="gt_row gt_left">hgb</td>
<td headers="stat_0" class="gt_row gt_center">12.30 (11.10, 13.50)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Unknown</td>
<td headers="stat_0" class="gt_row gt_center">266</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Body Mass Index (kg/m^2)</td>
<td headers="stat_0" class="gt_row gt_center">26.3 (23.5, 30.2)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Unknown</td>
<td headers="stat_0" class="gt_row gt_center">33</td></tr>
    <tr><td headers="label" class="gt_row gt_left">alk.phos</td>
<td headers="stat_0" class="gt_row gt_center">123 (86, 207)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Unknown</td>
<td headers="stat_0" class="gt_row gt_center">266</td></tr>
    <tr><td headers="label" class="gt_row gt_left">ast</td>
<td headers="stat_0" class="gt_row gt_center">27 (20, 41)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Unknown</td>
<td headers="stat_0" class="gt_row gt_center">266</td></tr>
  </tbody>
  
  <tfoot class="gt_footnotes">
    <tr>
      <td class="gt_footnote" colspan="2"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span> <span class='gt_from_md'>Median (Q1, Q3); n (%)</span></td>
    </tr>
  </tfoot>
</table>
</div>
```

### Updating Variable Values
The value for Race of "African-Am" is shorthand, but not great for publication.
Let's fix this to "African-American" by using a `mutate()` function to change the value of`race` to "African-American" when it is "African-Am". We will do this **before** we pipe the data into `tbl_summary()`.


``` r
mockstudy_baseline |> 
  mutate(race = case_when(race == "African-Am" ~ "African-American",
                          .default = race)) |>
  tbl_summary(label = list( sex ~ "Sex at Birth",
                            race ~ "Race Identified by Participant"))
```

```{=html}
<div id="hpsszrkock" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#hpsszrkock table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#hpsszrkock thead, #hpsszrkock tbody, #hpsszrkock tfoot, #hpsszrkock tr, #hpsszrkock td, #hpsszrkock th {
  border-style: none;
}

#hpsszrkock p {
  margin: 0;
  padding: 0;
}

#hpsszrkock .gt_table {
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

#hpsszrkock .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#hpsszrkock .gt_title {
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

#hpsszrkock .gt_subtitle {
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

#hpsszrkock .gt_heading {
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

#hpsszrkock .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#hpsszrkock .gt_col_headings {
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

#hpsszrkock .gt_col_heading {
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

#hpsszrkock .gt_column_spanner_outer {
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

#hpsszrkock .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#hpsszrkock .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#hpsszrkock .gt_column_spanner {
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

#hpsszrkock .gt_spanner_row {
  border-bottom-style: hidden;
}

#hpsszrkock .gt_group_heading {
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

#hpsszrkock .gt_empty_group_heading {
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

#hpsszrkock .gt_from_md > :first-child {
  margin-top: 0;
}

#hpsszrkock .gt_from_md > :last-child {
  margin-bottom: 0;
}

#hpsszrkock .gt_row {
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

#hpsszrkock .gt_stub {
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

#hpsszrkock .gt_stub_row_group {
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

#hpsszrkock .gt_row_group_first td {
  border-top-width: 2px;
}

#hpsszrkock .gt_row_group_first th {
  border-top-width: 2px;
}

#hpsszrkock .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#hpsszrkock .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#hpsszrkock .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#hpsszrkock .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#hpsszrkock .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#hpsszrkock .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#hpsszrkock .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#hpsszrkock .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#hpsszrkock .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#hpsszrkock .gt_footnotes {
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

#hpsszrkock .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#hpsszrkock .gt_sourcenotes {
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

#hpsszrkock .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#hpsszrkock .gt_left {
  text-align: left;
}

#hpsszrkock .gt_center {
  text-align: center;
}

#hpsszrkock .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#hpsszrkock .gt_font_normal {
  font-weight: normal;
}

#hpsszrkock .gt_font_bold {
  font-weight: bold;
}

#hpsszrkock .gt_font_italic {
  font-style: italic;
}

#hpsszrkock .gt_super {
  font-size: 65%;
}

#hpsszrkock .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#hpsszrkock .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#hpsszrkock .gt_indent_1 {
  text-indent: 5px;
}

#hpsszrkock .gt_indent_2 {
  text-indent: 10px;
}

#hpsszrkock .gt_indent_3 {
  text-indent: 15px;
}

#hpsszrkock .gt_indent_4 {
  text-indent: 20px;
}

#hpsszrkock .gt_indent_5 {
  text-indent: 25px;
}

#hpsszrkock .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#hpsszrkock div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Characteristic</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_0"><span class='gt_from_md'><strong>N = 1,499</strong></span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left">Age in Years</td>
<td headers="stat_0" class="gt_row gt_center">61 (52, 68)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Treatment Arm</td>
<td headers="stat_0" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    A: IFL</td>
<td headers="stat_0" class="gt_row gt_center">428 (29%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    F: FOLFOX</td>
<td headers="stat_0" class="gt_row gt_center">691 (46%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    G: IROX</td>
<td headers="stat_0" class="gt_row gt_center">380 (25%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Sex at Birth</td>
<td headers="stat_0" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Male</td>
<td headers="stat_0" class="gt_row gt_center">916 (61%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Female</td>
<td headers="stat_0" class="gt_row gt_center">583 (39%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Race Identified by Participant</td>
<td headers="stat_0" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    African-American</td>
<td headers="stat_0" class="gt_row gt_center">115 (7.7%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Asian</td>
<td headers="stat_0" class="gt_row gt_center">18 (1.2%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Caucasian</td>
<td headers="stat_0" class="gt_row gt_center">1,288 (86%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Hawaii/Pacific</td>
<td headers="stat_0" class="gt_row gt_center">5 (0.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Hispanic</td>
<td headers="stat_0" class="gt_row gt_center">54 (3.6%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Native-Am/Alaska</td>
<td headers="stat_0" class="gt_row gt_center">5 (0.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Other</td>
<td headers="stat_0" class="gt_row gt_center">7 (0.5%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Unknown</td>
<td headers="stat_0" class="gt_row gt_center">7</td></tr>
    <tr><td headers="label" class="gt_row gt_left">hgb</td>
<td headers="stat_0" class="gt_row gt_center">12.30 (11.10, 13.50)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Unknown</td>
<td headers="stat_0" class="gt_row gt_center">266</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Body Mass Index (kg/m^2)</td>
<td headers="stat_0" class="gt_row gt_center">26.3 (23.5, 30.2)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Unknown</td>
<td headers="stat_0" class="gt_row gt_center">33</td></tr>
    <tr><td headers="label" class="gt_row gt_left">alk.phos</td>
<td headers="stat_0" class="gt_row gt_center">123 (86, 207)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Unknown</td>
<td headers="stat_0" class="gt_row gt_center">266</td></tr>
    <tr><td headers="label" class="gt_row gt_left">ast</td>
<td headers="stat_0" class="gt_row gt_center">27 (20, 41)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Unknown</td>
<td headers="stat_0" class="gt_row gt_center">266</td></tr>
  </tbody>
  
  <tfoot class="gt_footnotes">
    <tr>
      <td class="gt_footnote" colspan="2"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span> <span class='gt_from_md'>Median (Q1, Q3); n (%)</span></td>
    </tr>
  </tfoot>
</table>
</div>
```
###  Table 1 separated by Treatment Arm
Let's make a Table 1 that is now separated into distinct columns by Treatment Arm,
allowing readers to compare the two groups and get a sense of whether the randomization
was balanced. As we are making many comparisons on each characteristic of the participants,
it is NOT appropriate to list p values for each comparison. We will use the    `tbl_summary(by = arm)` argument to separate the table by treatment arm.
We will also `add_overall()` and `add_n()` as these are commonly used.


``` r
mockstudy_baseline |> 
  mutate(race = case_when(race == "African-Am" ~ "African-American",
                          .default = race)) |>
  tbl_summary(label = list( sex ~ "Sex at Birth",
                            race ~ "Race Identified by Participant"),
              by = arm) |> 
  add_overall() |> 
  add_n()
```

```{=html}
<div id="cmonyosouz" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#cmonyosouz table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#cmonyosouz thead, #cmonyosouz tbody, #cmonyosouz tfoot, #cmonyosouz tr, #cmonyosouz td, #cmonyosouz th {
  border-style: none;
}

#cmonyosouz p {
  margin: 0;
  padding: 0;
}

#cmonyosouz .gt_table {
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

#cmonyosouz .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#cmonyosouz .gt_title {
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

#cmonyosouz .gt_subtitle {
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

#cmonyosouz .gt_heading {
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

#cmonyosouz .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#cmonyosouz .gt_col_headings {
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

#cmonyosouz .gt_col_heading {
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

#cmonyosouz .gt_column_spanner_outer {
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

#cmonyosouz .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#cmonyosouz .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#cmonyosouz .gt_column_spanner {
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

#cmonyosouz .gt_spanner_row {
  border-bottom-style: hidden;
}

#cmonyosouz .gt_group_heading {
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

#cmonyosouz .gt_empty_group_heading {
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

#cmonyosouz .gt_from_md > :first-child {
  margin-top: 0;
}

#cmonyosouz .gt_from_md > :last-child {
  margin-bottom: 0;
}

#cmonyosouz .gt_row {
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

#cmonyosouz .gt_stub {
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

#cmonyosouz .gt_stub_row_group {
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

#cmonyosouz .gt_row_group_first td {
  border-top-width: 2px;
}

#cmonyosouz .gt_row_group_first th {
  border-top-width: 2px;
}

#cmonyosouz .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#cmonyosouz .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#cmonyosouz .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#cmonyosouz .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#cmonyosouz .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#cmonyosouz .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#cmonyosouz .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#cmonyosouz .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#cmonyosouz .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#cmonyosouz .gt_footnotes {
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

#cmonyosouz .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#cmonyosouz .gt_sourcenotes {
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

#cmonyosouz .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#cmonyosouz .gt_left {
  text-align: left;
}

#cmonyosouz .gt_center {
  text-align: center;
}

#cmonyosouz .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#cmonyosouz .gt_font_normal {
  font-weight: normal;
}

#cmonyosouz .gt_font_bold {
  font-weight: bold;
}

#cmonyosouz .gt_font_italic {
  font-style: italic;
}

#cmonyosouz .gt_super {
  font-size: 65%;
}

#cmonyosouz .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#cmonyosouz .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#cmonyosouz .gt_indent_1 {
  text-indent: 5px;
}

#cmonyosouz .gt_indent_2 {
  text-indent: 10px;
}

#cmonyosouz .gt_indent_3 {
  text-indent: 15px;
}

#cmonyosouz .gt_indent_4 {
  text-indent: 20px;
}

#cmonyosouz .gt_indent_5 {
  text-indent: 25px;
}

#cmonyosouz .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#cmonyosouz div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Characteristic</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="n"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_0"><span class='gt_from_md'><strong>Overall</strong><br />
N = 1,499</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_1"><span class='gt_from_md'><strong>A: IFL</strong><br />
N = 428</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_2"><span class='gt_from_md'><strong>F: FOLFOX</strong><br />
N = 691</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_3"><span class='gt_from_md'><strong>G: IROX</strong><br />
N = 380</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left">Age in Years</td>
<td headers="n" class="gt_row gt_center">1,499</td>
<td headers="stat_0" class="gt_row gt_center">61 (52, 68)</td>
<td headers="stat_1" class="gt_row gt_center">61 (53, 68)</td>
<td headers="stat_2" class="gt_row gt_center">61 (52, 69)</td>
<td headers="stat_3" class="gt_row gt_center">61 (52, 68)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Sex at Birth</td>
<td headers="n" class="gt_row gt_center">1,499</td>
<td headers="stat_0" class="gt_row gt_center"><br /></td>
<td headers="stat_1" class="gt_row gt_center"><br /></td>
<td headers="stat_2" class="gt_row gt_center"><br /></td>
<td headers="stat_3" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Male</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">916 (61%)</td>
<td headers="stat_1" class="gt_row gt_center">277 (65%)</td>
<td headers="stat_2" class="gt_row gt_center">411 (59%)</td>
<td headers="stat_3" class="gt_row gt_center">228 (60%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Female</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">583 (39%)</td>
<td headers="stat_1" class="gt_row gt_center">151 (35%)</td>
<td headers="stat_2" class="gt_row gt_center">280 (41%)</td>
<td headers="stat_3" class="gt_row gt_center">152 (40%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Race Identified by Participant</td>
<td headers="n" class="gt_row gt_center">1,492</td>
<td headers="stat_0" class="gt_row gt_center"><br /></td>
<td headers="stat_1" class="gt_row gt_center"><br /></td>
<td headers="stat_2" class="gt_row gt_center"><br /></td>
<td headers="stat_3" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    African-American</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">115 (7.7%)</td>
<td headers="stat_1" class="gt_row gt_center">39 (9.1%)</td>
<td headers="stat_2" class="gt_row gt_center">49 (7.2%)</td>
<td headers="stat_3" class="gt_row gt_center">27 (7.1%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Asian</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">18 (1.2%)</td>
<td headers="stat_1" class="gt_row gt_center">1 (0.2%)</td>
<td headers="stat_2" class="gt_row gt_center">14 (2.0%)</td>
<td headers="stat_3" class="gt_row gt_center">3 (0.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Caucasian</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">1,288 (86%)</td>
<td headers="stat_1" class="gt_row gt_center">371 (87%)</td>
<td headers="stat_2" class="gt_row gt_center">586 (86%)</td>
<td headers="stat_3" class="gt_row gt_center">331 (87%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Hawaii/Pacific</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">5 (0.3%)</td>
<td headers="stat_1" class="gt_row gt_center">1 (0.2%)</td>
<td headers="stat_2" class="gt_row gt_center">3 (0.4%)</td>
<td headers="stat_3" class="gt_row gt_center">1 (0.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Hispanic</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">54 (3.6%)</td>
<td headers="stat_1" class="gt_row gt_center">12 (2.8%)</td>
<td headers="stat_2" class="gt_row gt_center">28 (4.1%)</td>
<td headers="stat_3" class="gt_row gt_center">14 (3.7%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Native-Am/Alaska</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">5 (0.3%)</td>
<td headers="stat_1" class="gt_row gt_center">2 (0.5%)</td>
<td headers="stat_2" class="gt_row gt_center">1 (0.1%)</td>
<td headers="stat_3" class="gt_row gt_center">2 (0.5%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Other</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">7 (0.5%)</td>
<td headers="stat_1" class="gt_row gt_center">2 (0.5%)</td>
<td headers="stat_2" class="gt_row gt_center">4 (0.6%)</td>
<td headers="stat_3" class="gt_row gt_center">1 (0.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Unknown</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">7</td>
<td headers="stat_1" class="gt_row gt_center">0</td>
<td headers="stat_2" class="gt_row gt_center">6</td>
<td headers="stat_3" class="gt_row gt_center">1</td></tr>
    <tr><td headers="label" class="gt_row gt_left">hgb</td>
<td headers="n" class="gt_row gt_center">1,233</td>
<td headers="stat_0" class="gt_row gt_center">12.30 (11.10, 13.50)</td>
<td headers="stat_1" class="gt_row gt_center">12.10 (11.00, 13.50)</td>
<td headers="stat_2" class="gt_row gt_center">12.20 (11.10, 13.60)</td>
<td headers="stat_3" class="gt_row gt_center">12.40 (11.15, 13.65)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Unknown</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">266</td>
<td headers="stat_1" class="gt_row gt_center">69</td>
<td headers="stat_2" class="gt_row gt_center">141</td>
<td headers="stat_3" class="gt_row gt_center">56</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Body Mass Index (kg/m^2)</td>
<td headers="n" class="gt_row gt_center">1,466</td>
<td headers="stat_0" class="gt_row gt_center">26.3 (23.5, 30.2)</td>
<td headers="stat_1" class="gt_row gt_center">26.2 (23.6, 30.6)</td>
<td headers="stat_2" class="gt_row gt_center">26.5 (23.7, 30.1)</td>
<td headers="stat_3" class="gt_row gt_center">26.0 (23.2, 29.6)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Unknown</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">33</td>
<td headers="stat_1" class="gt_row gt_center">9</td>
<td headers="stat_2" class="gt_row gt_center">20</td>
<td headers="stat_3" class="gt_row gt_center">4</td></tr>
    <tr><td headers="label" class="gt_row gt_left">alk.phos</td>
<td headers="n" class="gt_row gt_center">1,233</td>
<td headers="stat_0" class="gt_row gt_center">123 (86, 207)</td>
<td headers="stat_1" class="gt_row gt_center">133 (89, 219)</td>
<td headers="stat_2" class="gt_row gt_center">116 (85, 195)</td>
<td headers="stat_3" class="gt_row gt_center">122 (88, 212)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Unknown</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">266</td>
<td headers="stat_1" class="gt_row gt_center">69</td>
<td headers="stat_2" class="gt_row gt_center">141</td>
<td headers="stat_3" class="gt_row gt_center">56</td></tr>
    <tr><td headers="label" class="gt_row gt_left">ast</td>
<td headers="n" class="gt_row gt_center">1,233</td>
<td headers="stat_0" class="gt_row gt_center">27 (20, 41)</td>
<td headers="stat_1" class="gt_row gt_center">29 (21, 42)</td>
<td headers="stat_2" class="gt_row gt_center">26 (19, 40)</td>
<td headers="stat_3" class="gt_row gt_center">27 (20, 41)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Unknown</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">266</td>
<td headers="stat_1" class="gt_row gt_center">69</td>
<td headers="stat_2" class="gt_row gt_center">141</td>
<td headers="stat_3" class="gt_row gt_center">56</td></tr>
  </tbody>
  
  <tfoot class="gt_footnotes">
    <tr>
      <td class="gt_footnote" colspan="6"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span> <span class='gt_from_md'>Median (Q1, Q3); n (%)</span></td>
    </tr>
  </tfoot>
</table>
</div>
```


###  Styling our Table 1
Let's redefine the Unknown values as Missing (within the tbl_summary function), 
and bold the labels.


``` r
mockstudy_baseline |> 
  mutate(race = case_when(race == "African-Am" ~ "African-American",
                          .default = race)) |>
  tbl_summary(label = list( sex ~ "Sex at Birth",
                            race ~ "Race Identified by Participant"),
              by = arm,
              missing_text = "Missing") |> 
  add_overall() |> 
  add_n() |> 
  bold_labels() 
```

```{=html}
<div id="uzdizpuovm" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#uzdizpuovm table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#uzdizpuovm thead, #uzdizpuovm tbody, #uzdizpuovm tfoot, #uzdizpuovm tr, #uzdizpuovm td, #uzdizpuovm th {
  border-style: none;
}

#uzdizpuovm p {
  margin: 0;
  padding: 0;
}

#uzdizpuovm .gt_table {
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

#uzdizpuovm .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#uzdizpuovm .gt_title {
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

#uzdizpuovm .gt_subtitle {
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

#uzdizpuovm .gt_heading {
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

#uzdizpuovm .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#uzdizpuovm .gt_col_headings {
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

#uzdizpuovm .gt_col_heading {
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

#uzdizpuovm .gt_column_spanner_outer {
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

#uzdizpuovm .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#uzdizpuovm .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#uzdizpuovm .gt_column_spanner {
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

#uzdizpuovm .gt_spanner_row {
  border-bottom-style: hidden;
}

#uzdizpuovm .gt_group_heading {
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

#uzdizpuovm .gt_empty_group_heading {
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

#uzdizpuovm .gt_from_md > :first-child {
  margin-top: 0;
}

#uzdizpuovm .gt_from_md > :last-child {
  margin-bottom: 0;
}

#uzdizpuovm .gt_row {
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

#uzdizpuovm .gt_stub {
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

#uzdizpuovm .gt_stub_row_group {
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

#uzdizpuovm .gt_row_group_first td {
  border-top-width: 2px;
}

#uzdizpuovm .gt_row_group_first th {
  border-top-width: 2px;
}

#uzdizpuovm .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#uzdizpuovm .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#uzdizpuovm .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#uzdizpuovm .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#uzdizpuovm .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#uzdizpuovm .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#uzdizpuovm .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#uzdizpuovm .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#uzdizpuovm .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#uzdizpuovm .gt_footnotes {
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

#uzdizpuovm .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#uzdizpuovm .gt_sourcenotes {
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

#uzdizpuovm .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#uzdizpuovm .gt_left {
  text-align: left;
}

#uzdizpuovm .gt_center {
  text-align: center;
}

#uzdizpuovm .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#uzdizpuovm .gt_font_normal {
  font-weight: normal;
}

#uzdizpuovm .gt_font_bold {
  font-weight: bold;
}

#uzdizpuovm .gt_font_italic {
  font-style: italic;
}

#uzdizpuovm .gt_super {
  font-size: 65%;
}

#uzdizpuovm .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#uzdizpuovm .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#uzdizpuovm .gt_indent_1 {
  text-indent: 5px;
}

#uzdizpuovm .gt_indent_2 {
  text-indent: 10px;
}

#uzdizpuovm .gt_indent_3 {
  text-indent: 15px;
}

#uzdizpuovm .gt_indent_4 {
  text-indent: 20px;
}

#uzdizpuovm .gt_indent_5 {
  text-indent: 25px;
}

#uzdizpuovm .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#uzdizpuovm div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Characteristic</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="n"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_0"><span class='gt_from_md'><strong>Overall</strong><br />
N = 1,499</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_1"><span class='gt_from_md'><strong>A: IFL</strong><br />
N = 428</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_2"><span class='gt_from_md'><strong>F: FOLFOX</strong><br />
N = 691</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_3"><span class='gt_from_md'><strong>G: IROX</strong><br />
N = 380</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Age in Years</td>
<td headers="n" class="gt_row gt_center">1,499</td>
<td headers="stat_0" class="gt_row gt_center">61 (52, 68)</td>
<td headers="stat_1" class="gt_row gt_center">61 (53, 68)</td>
<td headers="stat_2" class="gt_row gt_center">61 (52, 69)</td>
<td headers="stat_3" class="gt_row gt_center">61 (52, 68)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Sex at Birth</td>
<td headers="n" class="gt_row gt_center">1,499</td>
<td headers="stat_0" class="gt_row gt_center"><br /></td>
<td headers="stat_1" class="gt_row gt_center"><br /></td>
<td headers="stat_2" class="gt_row gt_center"><br /></td>
<td headers="stat_3" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Male</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">916 (61%)</td>
<td headers="stat_1" class="gt_row gt_center">277 (65%)</td>
<td headers="stat_2" class="gt_row gt_center">411 (59%)</td>
<td headers="stat_3" class="gt_row gt_center">228 (60%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Female</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">583 (39%)</td>
<td headers="stat_1" class="gt_row gt_center">151 (35%)</td>
<td headers="stat_2" class="gt_row gt_center">280 (41%)</td>
<td headers="stat_3" class="gt_row gt_center">152 (40%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Race Identified by Participant</td>
<td headers="n" class="gt_row gt_center">1,492</td>
<td headers="stat_0" class="gt_row gt_center"><br /></td>
<td headers="stat_1" class="gt_row gt_center"><br /></td>
<td headers="stat_2" class="gt_row gt_center"><br /></td>
<td headers="stat_3" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    African-American</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">115 (7.7%)</td>
<td headers="stat_1" class="gt_row gt_center">39 (9.1%)</td>
<td headers="stat_2" class="gt_row gt_center">49 (7.2%)</td>
<td headers="stat_3" class="gt_row gt_center">27 (7.1%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Asian</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">18 (1.2%)</td>
<td headers="stat_1" class="gt_row gt_center">1 (0.2%)</td>
<td headers="stat_2" class="gt_row gt_center">14 (2.0%)</td>
<td headers="stat_3" class="gt_row gt_center">3 (0.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Caucasian</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">1,288 (86%)</td>
<td headers="stat_1" class="gt_row gt_center">371 (87%)</td>
<td headers="stat_2" class="gt_row gt_center">586 (86%)</td>
<td headers="stat_3" class="gt_row gt_center">331 (87%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Hawaii/Pacific</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">5 (0.3%)</td>
<td headers="stat_1" class="gt_row gt_center">1 (0.2%)</td>
<td headers="stat_2" class="gt_row gt_center">3 (0.4%)</td>
<td headers="stat_3" class="gt_row gt_center">1 (0.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Hispanic</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">54 (3.6%)</td>
<td headers="stat_1" class="gt_row gt_center">12 (2.8%)</td>
<td headers="stat_2" class="gt_row gt_center">28 (4.1%)</td>
<td headers="stat_3" class="gt_row gt_center">14 (3.7%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Native-Am/Alaska</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">5 (0.3%)</td>
<td headers="stat_1" class="gt_row gt_center">2 (0.5%)</td>
<td headers="stat_2" class="gt_row gt_center">1 (0.1%)</td>
<td headers="stat_3" class="gt_row gt_center">2 (0.5%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Other</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">7 (0.5%)</td>
<td headers="stat_1" class="gt_row gt_center">2 (0.5%)</td>
<td headers="stat_2" class="gt_row gt_center">4 (0.6%)</td>
<td headers="stat_3" class="gt_row gt_center">1 (0.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Missing</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">7</td>
<td headers="stat_1" class="gt_row gt_center">0</td>
<td headers="stat_2" class="gt_row gt_center">6</td>
<td headers="stat_3" class="gt_row gt_center">1</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">hgb</td>
<td headers="n" class="gt_row gt_center">1,233</td>
<td headers="stat_0" class="gt_row gt_center">12.30 (11.10, 13.50)</td>
<td headers="stat_1" class="gt_row gt_center">12.10 (11.00, 13.50)</td>
<td headers="stat_2" class="gt_row gt_center">12.20 (11.10, 13.60)</td>
<td headers="stat_3" class="gt_row gt_center">12.40 (11.15, 13.65)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Missing</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">266</td>
<td headers="stat_1" class="gt_row gt_center">69</td>
<td headers="stat_2" class="gt_row gt_center">141</td>
<td headers="stat_3" class="gt_row gt_center">56</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Body Mass Index (kg/m^2)</td>
<td headers="n" class="gt_row gt_center">1,466</td>
<td headers="stat_0" class="gt_row gt_center">26.3 (23.5, 30.2)</td>
<td headers="stat_1" class="gt_row gt_center">26.2 (23.6, 30.6)</td>
<td headers="stat_2" class="gt_row gt_center">26.5 (23.7, 30.1)</td>
<td headers="stat_3" class="gt_row gt_center">26.0 (23.2, 29.6)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Missing</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">33</td>
<td headers="stat_1" class="gt_row gt_center">9</td>
<td headers="stat_2" class="gt_row gt_center">20</td>
<td headers="stat_3" class="gt_row gt_center">4</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">alk.phos</td>
<td headers="n" class="gt_row gt_center">1,233</td>
<td headers="stat_0" class="gt_row gt_center">123 (86, 207)</td>
<td headers="stat_1" class="gt_row gt_center">133 (89, 219)</td>
<td headers="stat_2" class="gt_row gt_center">116 (85, 195)</td>
<td headers="stat_3" class="gt_row gt_center">122 (88, 212)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Missing</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">266</td>
<td headers="stat_1" class="gt_row gt_center">69</td>
<td headers="stat_2" class="gt_row gt_center">141</td>
<td headers="stat_3" class="gt_row gt_center">56</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">ast</td>
<td headers="n" class="gt_row gt_center">1,233</td>
<td headers="stat_0" class="gt_row gt_center">27 (20, 41)</td>
<td headers="stat_1" class="gt_row gt_center">29 (21, 42)</td>
<td headers="stat_2" class="gt_row gt_center">26 (19, 40)</td>
<td headers="stat_3" class="gt_row gt_center">27 (20, 41)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Missing</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">266</td>
<td headers="stat_1" class="gt_row gt_center">69</td>
<td headers="stat_2" class="gt_row gt_center">141</td>
<td headers="stat_3" class="gt_row gt_center">56</td></tr>
  </tbody>
  
  <tfoot class="gt_footnotes">
    <tr>
      <td class="gt_footnote" colspan="6"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span> <span class='gt_from_md'>Median (Q1, Q3); n (%)</span></td>
    </tr>
  </tfoot>
</table>
</div>
```

###  Adding A Column Spanner
You can add column spanners to your table to group variables together.
In this case, it would make sense to identify and group the three treatment arms with a 
column spanner.


``` r
tbl <- mockstudy_baseline |> 
  mutate(race = case_when(race == "African-Am" ~ "African-American",
                          .default = race)) |>
  tbl_summary(label = list( sex ~ "Sex at Birth",
                            race ~ "Race Identified by Participant"),
              by = arm,
              missing_text = "Missing") |> 
  add_overall() |> 
  add_n() |> 
  bold_labels() |>
  modify_spanning_header(c("stat_1", "stat_2", "stat_3") ~ "**Treatment Received**") 

tbl
```

```{=html}
<div id="htjufyaevd" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#htjufyaevd table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#htjufyaevd thead, #htjufyaevd tbody, #htjufyaevd tfoot, #htjufyaevd tr, #htjufyaevd td, #htjufyaevd th {
  border-style: none;
}

#htjufyaevd p {
  margin: 0;
  padding: 0;
}

#htjufyaevd .gt_table {
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

#htjufyaevd .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#htjufyaevd .gt_title {
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

#htjufyaevd .gt_subtitle {
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

#htjufyaevd .gt_heading {
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

#htjufyaevd .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#htjufyaevd .gt_col_headings {
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

#htjufyaevd .gt_col_heading {
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

#htjufyaevd .gt_column_spanner_outer {
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

#htjufyaevd .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#htjufyaevd .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#htjufyaevd .gt_column_spanner {
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

#htjufyaevd .gt_spanner_row {
  border-bottom-style: hidden;
}

#htjufyaevd .gt_group_heading {
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

#htjufyaevd .gt_empty_group_heading {
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

#htjufyaevd .gt_from_md > :first-child {
  margin-top: 0;
}

#htjufyaevd .gt_from_md > :last-child {
  margin-bottom: 0;
}

#htjufyaevd .gt_row {
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

#htjufyaevd .gt_stub {
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

#htjufyaevd .gt_stub_row_group {
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

#htjufyaevd .gt_row_group_first td {
  border-top-width: 2px;
}

#htjufyaevd .gt_row_group_first th {
  border-top-width: 2px;
}

#htjufyaevd .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#htjufyaevd .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#htjufyaevd .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#htjufyaevd .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#htjufyaevd .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#htjufyaevd .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#htjufyaevd .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#htjufyaevd .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#htjufyaevd .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#htjufyaevd .gt_footnotes {
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

#htjufyaevd .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#htjufyaevd .gt_sourcenotes {
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

#htjufyaevd .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#htjufyaevd .gt_left {
  text-align: left;
}

#htjufyaevd .gt_center {
  text-align: center;
}

#htjufyaevd .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#htjufyaevd .gt_font_normal {
  font-weight: normal;
}

#htjufyaevd .gt_font_bold {
  font-weight: bold;
}

#htjufyaevd .gt_font_italic {
  font-style: italic;
}

#htjufyaevd .gt_super {
  font-size: 65%;
}

#htjufyaevd .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#htjufyaevd .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#htjufyaevd .gt_indent_1 {
  text-indent: 5px;
}

#htjufyaevd .gt_indent_2 {
  text-indent: 10px;
}

#htjufyaevd .gt_indent_3 {
  text-indent: 15px;
}

#htjufyaevd .gt_indent_4 {
  text-indent: 20px;
}

#htjufyaevd .gt_indent_5 {
  text-indent: 25px;
}

#htjufyaevd .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#htjufyaevd div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Characteristic</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="n"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="stat_0"><span class='gt_from_md'><strong>Overall</strong><br />
N = 1,499</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="3" scope="colgroup" id="level 1; stat_1">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>Treatment Received</strong></span></div>
      </th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_1"><span class='gt_from_md'><strong>A: IFL</strong><br />
N = 428</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_2"><span class='gt_from_md'><strong>F: FOLFOX</strong><br />
N = 691</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_3"><span class='gt_from_md'><strong>G: IROX</strong><br />
N = 380</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Age in Years</td>
<td headers="n" class="gt_row gt_center">1,499</td>
<td headers="stat_0" class="gt_row gt_center">61 (52, 68)</td>
<td headers="stat_1" class="gt_row gt_center">61 (53, 68)</td>
<td headers="stat_2" class="gt_row gt_center">61 (52, 69)</td>
<td headers="stat_3" class="gt_row gt_center">61 (52, 68)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Sex at Birth</td>
<td headers="n" class="gt_row gt_center">1,499</td>
<td headers="stat_0" class="gt_row gt_center"><br /></td>
<td headers="stat_1" class="gt_row gt_center"><br /></td>
<td headers="stat_2" class="gt_row gt_center"><br /></td>
<td headers="stat_3" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Male</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">916 (61%)</td>
<td headers="stat_1" class="gt_row gt_center">277 (65%)</td>
<td headers="stat_2" class="gt_row gt_center">411 (59%)</td>
<td headers="stat_3" class="gt_row gt_center">228 (60%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Female</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">583 (39%)</td>
<td headers="stat_1" class="gt_row gt_center">151 (35%)</td>
<td headers="stat_2" class="gt_row gt_center">280 (41%)</td>
<td headers="stat_3" class="gt_row gt_center">152 (40%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Race Identified by Participant</td>
<td headers="n" class="gt_row gt_center">1,492</td>
<td headers="stat_0" class="gt_row gt_center"><br /></td>
<td headers="stat_1" class="gt_row gt_center"><br /></td>
<td headers="stat_2" class="gt_row gt_center"><br /></td>
<td headers="stat_3" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    African-American</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">115 (7.7%)</td>
<td headers="stat_1" class="gt_row gt_center">39 (9.1%)</td>
<td headers="stat_2" class="gt_row gt_center">49 (7.2%)</td>
<td headers="stat_3" class="gt_row gt_center">27 (7.1%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Asian</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">18 (1.2%)</td>
<td headers="stat_1" class="gt_row gt_center">1 (0.2%)</td>
<td headers="stat_2" class="gt_row gt_center">14 (2.0%)</td>
<td headers="stat_3" class="gt_row gt_center">3 (0.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Caucasian</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">1,288 (86%)</td>
<td headers="stat_1" class="gt_row gt_center">371 (87%)</td>
<td headers="stat_2" class="gt_row gt_center">586 (86%)</td>
<td headers="stat_3" class="gt_row gt_center">331 (87%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Hawaii/Pacific</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">5 (0.3%)</td>
<td headers="stat_1" class="gt_row gt_center">1 (0.2%)</td>
<td headers="stat_2" class="gt_row gt_center">3 (0.4%)</td>
<td headers="stat_3" class="gt_row gt_center">1 (0.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Hispanic</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">54 (3.6%)</td>
<td headers="stat_1" class="gt_row gt_center">12 (2.8%)</td>
<td headers="stat_2" class="gt_row gt_center">28 (4.1%)</td>
<td headers="stat_3" class="gt_row gt_center">14 (3.7%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Native-Am/Alaska</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">5 (0.3%)</td>
<td headers="stat_1" class="gt_row gt_center">2 (0.5%)</td>
<td headers="stat_2" class="gt_row gt_center">1 (0.1%)</td>
<td headers="stat_3" class="gt_row gt_center">2 (0.5%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Other</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">7 (0.5%)</td>
<td headers="stat_1" class="gt_row gt_center">2 (0.5%)</td>
<td headers="stat_2" class="gt_row gt_center">4 (0.6%)</td>
<td headers="stat_3" class="gt_row gt_center">1 (0.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Missing</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">7</td>
<td headers="stat_1" class="gt_row gt_center">0</td>
<td headers="stat_2" class="gt_row gt_center">6</td>
<td headers="stat_3" class="gt_row gt_center">1</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">hgb</td>
<td headers="n" class="gt_row gt_center">1,233</td>
<td headers="stat_0" class="gt_row gt_center">12.30 (11.10, 13.50)</td>
<td headers="stat_1" class="gt_row gt_center">12.10 (11.00, 13.50)</td>
<td headers="stat_2" class="gt_row gt_center">12.20 (11.10, 13.60)</td>
<td headers="stat_3" class="gt_row gt_center">12.40 (11.15, 13.65)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Missing</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">266</td>
<td headers="stat_1" class="gt_row gt_center">69</td>
<td headers="stat_2" class="gt_row gt_center">141</td>
<td headers="stat_3" class="gt_row gt_center">56</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Body Mass Index (kg/m^2)</td>
<td headers="n" class="gt_row gt_center">1,466</td>
<td headers="stat_0" class="gt_row gt_center">26.3 (23.5, 30.2)</td>
<td headers="stat_1" class="gt_row gt_center">26.2 (23.6, 30.6)</td>
<td headers="stat_2" class="gt_row gt_center">26.5 (23.7, 30.1)</td>
<td headers="stat_3" class="gt_row gt_center">26.0 (23.2, 29.6)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Missing</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">33</td>
<td headers="stat_1" class="gt_row gt_center">9</td>
<td headers="stat_2" class="gt_row gt_center">20</td>
<td headers="stat_3" class="gt_row gt_center">4</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">alk.phos</td>
<td headers="n" class="gt_row gt_center">1,233</td>
<td headers="stat_0" class="gt_row gt_center">123 (86, 207)</td>
<td headers="stat_1" class="gt_row gt_center">133 (89, 219)</td>
<td headers="stat_2" class="gt_row gt_center">116 (85, 195)</td>
<td headers="stat_3" class="gt_row gt_center">122 (88, 212)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Missing</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">266</td>
<td headers="stat_1" class="gt_row gt_center">69</td>
<td headers="stat_2" class="gt_row gt_center">141</td>
<td headers="stat_3" class="gt_row gt_center">56</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">ast</td>
<td headers="n" class="gt_row gt_center">1,233</td>
<td headers="stat_0" class="gt_row gt_center">27 (20, 41)</td>
<td headers="stat_1" class="gt_row gt_center">29 (21, 42)</td>
<td headers="stat_2" class="gt_row gt_center">26 (19, 40)</td>
<td headers="stat_3" class="gt_row gt_center">27 (20, 41)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Missing</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">266</td>
<td headers="stat_1" class="gt_row gt_center">69</td>
<td headers="stat_2" class="gt_row gt_center">141</td>
<td headers="stat_3" class="gt_row gt_center">56</td></tr>
  </tbody>
  
  <tfoot class="gt_footnotes">
    <tr>
      <td class="gt_footnote" colspan="6"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span> <span class='gt_from_md'>Median (Q1, Q3); n (%)</span></td>
    </tr>
  </tfoot>
</table>
</div>
```

Note that the standard column names for columns in `tbl_summary()`  are 

- label
- n
- stat_0
- stat_1
- stat_2
- stat_3, etc.

Note that you can **confirm** these with `show_header_names()`
and you can change these with `modify_header()` to take control of the line breaks
with <br> and bolding with **.
Let's take a look:


``` r
show_header_names(tbl)
```

```
## Column Name   Header                       level*            N*            n*            p*             
## label         "**Characteristic**"                           1,499 <int>                                
## n             "**N**"                                                                                   
## stat_0        "**Overall**  \nN = 1,499"     Overall <chr>   1,499 <int>   1,499 <int>    1.00 <dbl>    
## stat_1        "**A: IFL**  \nN = 428"         A: IFL <chr>   1,499 <int>     428 <int>   0.286 <dbl>    
## stat_2        "**F: FOLFOX**  \nN = 691"   F: FOLFOX <chr>   1,499 <int>     691 <int>   0.461 <dbl>    
## stat_3        "**G: IROX**  \nN = 380"       G: IROX <chr>   1,499 <int>     380 <int>   0.254 <dbl>
```

```
## * These values may be dynamically placed into headers (and other locations).
## ℹ Review the `modify_header()` (`?gtsummary::modify_header()`) help for
##   examples.
```

``` r
tbl |> 
  modify_header((update = list(
      stat_0 ~ "**Overall**<br>N = 1,499",
      stat_1 ~ "**A: IFL**<br>N = 428",
      stat_2 ~ "**F: FOLFOX**<br>N = 691",
      stat_3 ~ "**G: IROX**<br>N = 380")
  ))
```

```
## Warning: The `update` argument of `modify_header()` is deprecated as of gtsummary 2.0.0.
## ℹ Use `modify_header(...)` input instead. Dynamic dots allow for syntax like
##   `modify_header(!!!list(...))`.
## ℹ The deprecated feature was likely used in the gtsummary package.
##   Please report the issue at <https://github.com/ddsjoberg/gtsummary/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```{=html}
<div id="mdcwzwawsa" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#mdcwzwawsa table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#mdcwzwawsa thead, #mdcwzwawsa tbody, #mdcwzwawsa tfoot, #mdcwzwawsa tr, #mdcwzwawsa td, #mdcwzwawsa th {
  border-style: none;
}

#mdcwzwawsa p {
  margin: 0;
  padding: 0;
}

#mdcwzwawsa .gt_table {
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

#mdcwzwawsa .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#mdcwzwawsa .gt_title {
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

#mdcwzwawsa .gt_subtitle {
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

#mdcwzwawsa .gt_heading {
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

#mdcwzwawsa .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#mdcwzwawsa .gt_col_headings {
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

#mdcwzwawsa .gt_col_heading {
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

#mdcwzwawsa .gt_column_spanner_outer {
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

#mdcwzwawsa .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#mdcwzwawsa .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#mdcwzwawsa .gt_column_spanner {
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

#mdcwzwawsa .gt_spanner_row {
  border-bottom-style: hidden;
}

#mdcwzwawsa .gt_group_heading {
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

#mdcwzwawsa .gt_empty_group_heading {
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

#mdcwzwawsa .gt_from_md > :first-child {
  margin-top: 0;
}

#mdcwzwawsa .gt_from_md > :last-child {
  margin-bottom: 0;
}

#mdcwzwawsa .gt_row {
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

#mdcwzwawsa .gt_stub {
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

#mdcwzwawsa .gt_stub_row_group {
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

#mdcwzwawsa .gt_row_group_first td {
  border-top-width: 2px;
}

#mdcwzwawsa .gt_row_group_first th {
  border-top-width: 2px;
}

#mdcwzwawsa .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#mdcwzwawsa .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#mdcwzwawsa .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#mdcwzwawsa .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#mdcwzwawsa .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#mdcwzwawsa .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#mdcwzwawsa .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#mdcwzwawsa .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#mdcwzwawsa .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#mdcwzwawsa .gt_footnotes {
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

#mdcwzwawsa .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#mdcwzwawsa .gt_sourcenotes {
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

#mdcwzwawsa .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#mdcwzwawsa .gt_left {
  text-align: left;
}

#mdcwzwawsa .gt_center {
  text-align: center;
}

#mdcwzwawsa .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#mdcwzwawsa .gt_font_normal {
  font-weight: normal;
}

#mdcwzwawsa .gt_font_bold {
  font-weight: bold;
}

#mdcwzwawsa .gt_font_italic {
  font-style: italic;
}

#mdcwzwawsa .gt_super {
  font-size: 65%;
}

#mdcwzwawsa .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#mdcwzwawsa .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#mdcwzwawsa .gt_indent_1 {
  text-indent: 5px;
}

#mdcwzwawsa .gt_indent_2 {
  text-indent: 10px;
}

#mdcwzwawsa .gt_indent_3 {
  text-indent: 15px;
}

#mdcwzwawsa .gt_indent_4 {
  text-indent: 20px;
}

#mdcwzwawsa .gt_indent_5 {
  text-indent: 25px;
}

#mdcwzwawsa .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#mdcwzwawsa div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Characteristic</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="n"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="stat_0"><span class='gt_from_md'><strong>Overall</strong><br>N = 1,499</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="3" scope="colgroup" id="level 1; stat_1">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>Treatment Received</strong></span></div>
      </th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_1"><span class='gt_from_md'><strong>A: IFL</strong><br>N = 428</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_2"><span class='gt_from_md'><strong>F: FOLFOX</strong><br>N = 691</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_3"><span class='gt_from_md'><strong>G: IROX</strong><br>N = 380</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Age in Years</td>
<td headers="n" class="gt_row gt_center">1,499</td>
<td headers="stat_0" class="gt_row gt_center">61 (52, 68)</td>
<td headers="stat_1" class="gt_row gt_center">61 (53, 68)</td>
<td headers="stat_2" class="gt_row gt_center">61 (52, 69)</td>
<td headers="stat_3" class="gt_row gt_center">61 (52, 68)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Sex at Birth</td>
<td headers="n" class="gt_row gt_center">1,499</td>
<td headers="stat_0" class="gt_row gt_center"><br /></td>
<td headers="stat_1" class="gt_row gt_center"><br /></td>
<td headers="stat_2" class="gt_row gt_center"><br /></td>
<td headers="stat_3" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Male</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">916 (61%)</td>
<td headers="stat_1" class="gt_row gt_center">277 (65%)</td>
<td headers="stat_2" class="gt_row gt_center">411 (59%)</td>
<td headers="stat_3" class="gt_row gt_center">228 (60%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Female</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">583 (39%)</td>
<td headers="stat_1" class="gt_row gt_center">151 (35%)</td>
<td headers="stat_2" class="gt_row gt_center">280 (41%)</td>
<td headers="stat_3" class="gt_row gt_center">152 (40%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Race Identified by Participant</td>
<td headers="n" class="gt_row gt_center">1,492</td>
<td headers="stat_0" class="gt_row gt_center"><br /></td>
<td headers="stat_1" class="gt_row gt_center"><br /></td>
<td headers="stat_2" class="gt_row gt_center"><br /></td>
<td headers="stat_3" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    African-American</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">115 (7.7%)</td>
<td headers="stat_1" class="gt_row gt_center">39 (9.1%)</td>
<td headers="stat_2" class="gt_row gt_center">49 (7.2%)</td>
<td headers="stat_3" class="gt_row gt_center">27 (7.1%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Asian</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">18 (1.2%)</td>
<td headers="stat_1" class="gt_row gt_center">1 (0.2%)</td>
<td headers="stat_2" class="gt_row gt_center">14 (2.0%)</td>
<td headers="stat_3" class="gt_row gt_center">3 (0.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Caucasian</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">1,288 (86%)</td>
<td headers="stat_1" class="gt_row gt_center">371 (87%)</td>
<td headers="stat_2" class="gt_row gt_center">586 (86%)</td>
<td headers="stat_3" class="gt_row gt_center">331 (87%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Hawaii/Pacific</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">5 (0.3%)</td>
<td headers="stat_1" class="gt_row gt_center">1 (0.2%)</td>
<td headers="stat_2" class="gt_row gt_center">3 (0.4%)</td>
<td headers="stat_3" class="gt_row gt_center">1 (0.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Hispanic</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">54 (3.6%)</td>
<td headers="stat_1" class="gt_row gt_center">12 (2.8%)</td>
<td headers="stat_2" class="gt_row gt_center">28 (4.1%)</td>
<td headers="stat_3" class="gt_row gt_center">14 (3.7%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Native-Am/Alaska</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">5 (0.3%)</td>
<td headers="stat_1" class="gt_row gt_center">2 (0.5%)</td>
<td headers="stat_2" class="gt_row gt_center">1 (0.1%)</td>
<td headers="stat_3" class="gt_row gt_center">2 (0.5%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Other</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">7 (0.5%)</td>
<td headers="stat_1" class="gt_row gt_center">2 (0.5%)</td>
<td headers="stat_2" class="gt_row gt_center">4 (0.6%)</td>
<td headers="stat_3" class="gt_row gt_center">1 (0.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Missing</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">7</td>
<td headers="stat_1" class="gt_row gt_center">0</td>
<td headers="stat_2" class="gt_row gt_center">6</td>
<td headers="stat_3" class="gt_row gt_center">1</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">hgb</td>
<td headers="n" class="gt_row gt_center">1,233</td>
<td headers="stat_0" class="gt_row gt_center">12.30 (11.10, 13.50)</td>
<td headers="stat_1" class="gt_row gt_center">12.10 (11.00, 13.50)</td>
<td headers="stat_2" class="gt_row gt_center">12.20 (11.10, 13.60)</td>
<td headers="stat_3" class="gt_row gt_center">12.40 (11.15, 13.65)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Missing</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">266</td>
<td headers="stat_1" class="gt_row gt_center">69</td>
<td headers="stat_2" class="gt_row gt_center">141</td>
<td headers="stat_3" class="gt_row gt_center">56</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Body Mass Index (kg/m^2)</td>
<td headers="n" class="gt_row gt_center">1,466</td>
<td headers="stat_0" class="gt_row gt_center">26.3 (23.5, 30.2)</td>
<td headers="stat_1" class="gt_row gt_center">26.2 (23.6, 30.6)</td>
<td headers="stat_2" class="gt_row gt_center">26.5 (23.7, 30.1)</td>
<td headers="stat_3" class="gt_row gt_center">26.0 (23.2, 29.6)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Missing</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">33</td>
<td headers="stat_1" class="gt_row gt_center">9</td>
<td headers="stat_2" class="gt_row gt_center">20</td>
<td headers="stat_3" class="gt_row gt_center">4</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">alk.phos</td>
<td headers="n" class="gt_row gt_center">1,233</td>
<td headers="stat_0" class="gt_row gt_center">123 (86, 207)</td>
<td headers="stat_1" class="gt_row gt_center">133 (89, 219)</td>
<td headers="stat_2" class="gt_row gt_center">116 (85, 195)</td>
<td headers="stat_3" class="gt_row gt_center">122 (88, 212)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Missing</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">266</td>
<td headers="stat_1" class="gt_row gt_center">69</td>
<td headers="stat_2" class="gt_row gt_center">141</td>
<td headers="stat_3" class="gt_row gt_center">56</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">ast</td>
<td headers="n" class="gt_row gt_center">1,233</td>
<td headers="stat_0" class="gt_row gt_center">27 (20, 41)</td>
<td headers="stat_1" class="gt_row gt_center">29 (21, 42)</td>
<td headers="stat_2" class="gt_row gt_center">26 (19, 40)</td>
<td headers="stat_3" class="gt_row gt_center">27 (20, 41)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Missing</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">266</td>
<td headers="stat_1" class="gt_row gt_center">69</td>
<td headers="stat_2" class="gt_row gt_center">141</td>
<td headers="stat_3" class="gt_row gt_center">56</td></tr>
  </tbody>
  
  <tfoot class="gt_footnotes">
    <tr>
      <td class="gt_footnote" colspan="6"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span> <span class='gt_from_md'>Median (Q1, Q3); n (%)</span></td>
    </tr>
  </tfoot>
</table>
</div>
```

###  Further Styling our Table 1

You can use {gtsummary} functions to modify header names, footnotes, captions, the number
of digits in numbers, and the stats used.
See the tutorial article [here](https://www.danieldsjoberg.com/gtsummary/articles/tbl_summary.html) for more information. The pdf cheatsheet is also downloadable at the same website under
`Articles/cheat sheet`, and is very helpful.

You can convert this table to a gt table with `as_gt()` and further style it,
using all of the table styling functions available in the `{gt}` package. Lots of 
details on how to style `{gt}` tables can be found in the `{gt}` package 
[documentation](https://gt.rstudio.com/).

### Your Turn
In the last code block, we saved the table as the object `tbl`. Take this `tbl` 
object and 

- fix up the labels for `hgb`, `alk.phos`, and `ast` to be more publication-ready.
- add a caption to the table that says "Baseline Characteristics of Participants in the Mock Study by Treatment Arm"
- add a footnote to the table that says "Note: Missing values are indicated as 'Missing' in the table."
- improve the value labels for 'Hawaii/Pacific', and 'Native-Am/Alaska' to be "Native Hawaiian or other Pacific Islander" and "American Indian or Alaska Native" respectively.
- change the number of digits in the table to 2.
- change the stats to show the mean and standard deviation for continuous variables, and the count and percent for categorical variables.
- convert the table to a gt table and style it with the `gt` package. Add some color.

The code block below starts with tbl, unmodified.
Add a pipe and start fixing it up, with the goals above. Refer to the `{gtsummary}` and `{gt}` documentation for help. Click on the links below as needed.

- gtsummary: [tbl_summary()](https://www.danieldsjoberg.com/gtsummary/reference/tbl_summary.html)
- gt: [gt()](https://gt.rstudio.com/reference/gt.html)


``` r
tbl
```

```{=html}
<div id="ggfxjpitfn" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#ggfxjpitfn table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#ggfxjpitfn thead, #ggfxjpitfn tbody, #ggfxjpitfn tfoot, #ggfxjpitfn tr, #ggfxjpitfn td, #ggfxjpitfn th {
  border-style: none;
}

#ggfxjpitfn p {
  margin: 0;
  padding: 0;
}

#ggfxjpitfn .gt_table {
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

#ggfxjpitfn .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#ggfxjpitfn .gt_title {
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

#ggfxjpitfn .gt_subtitle {
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

#ggfxjpitfn .gt_heading {
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

#ggfxjpitfn .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ggfxjpitfn .gt_col_headings {
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

#ggfxjpitfn .gt_col_heading {
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

#ggfxjpitfn .gt_column_spanner_outer {
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

#ggfxjpitfn .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#ggfxjpitfn .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#ggfxjpitfn .gt_column_spanner {
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

#ggfxjpitfn .gt_spanner_row {
  border-bottom-style: hidden;
}

#ggfxjpitfn .gt_group_heading {
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

#ggfxjpitfn .gt_empty_group_heading {
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

#ggfxjpitfn .gt_from_md > :first-child {
  margin-top: 0;
}

#ggfxjpitfn .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ggfxjpitfn .gt_row {
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

#ggfxjpitfn .gt_stub {
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

#ggfxjpitfn .gt_stub_row_group {
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

#ggfxjpitfn .gt_row_group_first td {
  border-top-width: 2px;
}

#ggfxjpitfn .gt_row_group_first th {
  border-top-width: 2px;
}

#ggfxjpitfn .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ggfxjpitfn .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#ggfxjpitfn .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#ggfxjpitfn .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ggfxjpitfn .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ggfxjpitfn .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#ggfxjpitfn .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#ggfxjpitfn .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#ggfxjpitfn .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ggfxjpitfn .gt_footnotes {
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

#ggfxjpitfn .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ggfxjpitfn .gt_sourcenotes {
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

#ggfxjpitfn .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ggfxjpitfn .gt_left {
  text-align: left;
}

#ggfxjpitfn .gt_center {
  text-align: center;
}

#ggfxjpitfn .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ggfxjpitfn .gt_font_normal {
  font-weight: normal;
}

#ggfxjpitfn .gt_font_bold {
  font-weight: bold;
}

#ggfxjpitfn .gt_font_italic {
  font-style: italic;
}

#ggfxjpitfn .gt_super {
  font-size: 65%;
}

#ggfxjpitfn .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#ggfxjpitfn .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#ggfxjpitfn .gt_indent_1 {
  text-indent: 5px;
}

#ggfxjpitfn .gt_indent_2 {
  text-indent: 10px;
}

#ggfxjpitfn .gt_indent_3 {
  text-indent: 15px;
}

#ggfxjpitfn .gt_indent_4 {
  text-indent: 20px;
}

#ggfxjpitfn .gt_indent_5 {
  text-indent: 25px;
}

#ggfxjpitfn .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#ggfxjpitfn div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Characteristic</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="n"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="stat_0"><span class='gt_from_md'><strong>Overall</strong><br />
N = 1,499</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="3" scope="colgroup" id="level 1; stat_1">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>Treatment Received</strong></span></div>
      </th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_1"><span class='gt_from_md'><strong>A: IFL</strong><br />
N = 428</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_2"><span class='gt_from_md'><strong>F: FOLFOX</strong><br />
N = 691</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_3"><span class='gt_from_md'><strong>G: IROX</strong><br />
N = 380</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Age in Years</td>
<td headers="n" class="gt_row gt_center">1,499</td>
<td headers="stat_0" class="gt_row gt_center">61 (52, 68)</td>
<td headers="stat_1" class="gt_row gt_center">61 (53, 68)</td>
<td headers="stat_2" class="gt_row gt_center">61 (52, 69)</td>
<td headers="stat_3" class="gt_row gt_center">61 (52, 68)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Sex at Birth</td>
<td headers="n" class="gt_row gt_center">1,499</td>
<td headers="stat_0" class="gt_row gt_center"><br /></td>
<td headers="stat_1" class="gt_row gt_center"><br /></td>
<td headers="stat_2" class="gt_row gt_center"><br /></td>
<td headers="stat_3" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Male</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">916 (61%)</td>
<td headers="stat_1" class="gt_row gt_center">277 (65%)</td>
<td headers="stat_2" class="gt_row gt_center">411 (59%)</td>
<td headers="stat_3" class="gt_row gt_center">228 (60%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Female</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">583 (39%)</td>
<td headers="stat_1" class="gt_row gt_center">151 (35%)</td>
<td headers="stat_2" class="gt_row gt_center">280 (41%)</td>
<td headers="stat_3" class="gt_row gt_center">152 (40%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Race Identified by Participant</td>
<td headers="n" class="gt_row gt_center">1,492</td>
<td headers="stat_0" class="gt_row gt_center"><br /></td>
<td headers="stat_1" class="gt_row gt_center"><br /></td>
<td headers="stat_2" class="gt_row gt_center"><br /></td>
<td headers="stat_3" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    African-American</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">115 (7.7%)</td>
<td headers="stat_1" class="gt_row gt_center">39 (9.1%)</td>
<td headers="stat_2" class="gt_row gt_center">49 (7.2%)</td>
<td headers="stat_3" class="gt_row gt_center">27 (7.1%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Asian</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">18 (1.2%)</td>
<td headers="stat_1" class="gt_row gt_center">1 (0.2%)</td>
<td headers="stat_2" class="gt_row gt_center">14 (2.0%)</td>
<td headers="stat_3" class="gt_row gt_center">3 (0.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Caucasian</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">1,288 (86%)</td>
<td headers="stat_1" class="gt_row gt_center">371 (87%)</td>
<td headers="stat_2" class="gt_row gt_center">586 (86%)</td>
<td headers="stat_3" class="gt_row gt_center">331 (87%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Hawaii/Pacific</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">5 (0.3%)</td>
<td headers="stat_1" class="gt_row gt_center">1 (0.2%)</td>
<td headers="stat_2" class="gt_row gt_center">3 (0.4%)</td>
<td headers="stat_3" class="gt_row gt_center">1 (0.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Hispanic</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">54 (3.6%)</td>
<td headers="stat_1" class="gt_row gt_center">12 (2.8%)</td>
<td headers="stat_2" class="gt_row gt_center">28 (4.1%)</td>
<td headers="stat_3" class="gt_row gt_center">14 (3.7%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Native-Am/Alaska</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">5 (0.3%)</td>
<td headers="stat_1" class="gt_row gt_center">2 (0.5%)</td>
<td headers="stat_2" class="gt_row gt_center">1 (0.1%)</td>
<td headers="stat_3" class="gt_row gt_center">2 (0.5%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Other</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">7 (0.5%)</td>
<td headers="stat_1" class="gt_row gt_center">2 (0.5%)</td>
<td headers="stat_2" class="gt_row gt_center">4 (0.6%)</td>
<td headers="stat_3" class="gt_row gt_center">1 (0.3%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Missing</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">7</td>
<td headers="stat_1" class="gt_row gt_center">0</td>
<td headers="stat_2" class="gt_row gt_center">6</td>
<td headers="stat_3" class="gt_row gt_center">1</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">hgb</td>
<td headers="n" class="gt_row gt_center">1,233</td>
<td headers="stat_0" class="gt_row gt_center">12.30 (11.10, 13.50)</td>
<td headers="stat_1" class="gt_row gt_center">12.10 (11.00, 13.50)</td>
<td headers="stat_2" class="gt_row gt_center">12.20 (11.10, 13.60)</td>
<td headers="stat_3" class="gt_row gt_center">12.40 (11.15, 13.65)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Missing</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">266</td>
<td headers="stat_1" class="gt_row gt_center">69</td>
<td headers="stat_2" class="gt_row gt_center">141</td>
<td headers="stat_3" class="gt_row gt_center">56</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Body Mass Index (kg/m^2)</td>
<td headers="n" class="gt_row gt_center">1,466</td>
<td headers="stat_0" class="gt_row gt_center">26.3 (23.5, 30.2)</td>
<td headers="stat_1" class="gt_row gt_center">26.2 (23.6, 30.6)</td>
<td headers="stat_2" class="gt_row gt_center">26.5 (23.7, 30.1)</td>
<td headers="stat_3" class="gt_row gt_center">26.0 (23.2, 29.6)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Missing</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">33</td>
<td headers="stat_1" class="gt_row gt_center">9</td>
<td headers="stat_2" class="gt_row gt_center">20</td>
<td headers="stat_3" class="gt_row gt_center">4</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">alk.phos</td>
<td headers="n" class="gt_row gt_center">1,233</td>
<td headers="stat_0" class="gt_row gt_center">123 (86, 207)</td>
<td headers="stat_1" class="gt_row gt_center">133 (89, 219)</td>
<td headers="stat_2" class="gt_row gt_center">116 (85, 195)</td>
<td headers="stat_3" class="gt_row gt_center">122 (88, 212)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Missing</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">266</td>
<td headers="stat_1" class="gt_row gt_center">69</td>
<td headers="stat_2" class="gt_row gt_center">141</td>
<td headers="stat_3" class="gt_row gt_center">56</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">ast</td>
<td headers="n" class="gt_row gt_center">1,233</td>
<td headers="stat_0" class="gt_row gt_center">27 (20, 41)</td>
<td headers="stat_1" class="gt_row gt_center">29 (21, 42)</td>
<td headers="stat_2" class="gt_row gt_center">26 (19, 40)</td>
<td headers="stat_3" class="gt_row gt_center">27 (20, 41)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Missing</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">266</td>
<td headers="stat_1" class="gt_row gt_center">69</td>
<td headers="stat_2" class="gt_row gt_center">141</td>
<td headers="stat_3" class="gt_row gt_center">56</td></tr>
  </tbody>
  
  <tfoot class="gt_footnotes">
    <tr>
      <td class="gt_footnote" colspan="6"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span> <span class='gt_from_md'>Median (Q1, Q3); n (%)</span></td>
    </tr>
  </tfoot>
</table>
</div>
```

## Try this with a new dataset

Now we will use the `trial` dataset from the {gtsummary} package to create a Table 1.
The `trial` dataset is a simulated dataset of a clinical trial with 200 observations and 6 variables.
Run the code block below. Which are baseline variables for Table 1, and which are outcome variables?
Use your R skills to:

- select the baseline variables 
- create a Table 1, divided by treatment (`trt`), and 
- set the missing_text to "Missing".



``` r
trial
```

```
## # A tibble: 200 × 8
##    trt      age marker stage grade response death ttdeath
##    <chr>  <dbl>  <dbl> <fct> <fct>    <int> <int>   <dbl>
##  1 Drug A    23  0.16  T1    II           0     0    24  
##  2 Drug B     9  1.11  T2    I            1     0    24  
##  3 Drug A    31  0.277 T1    II           0     0    24  
##  4 Drug A    NA  2.07  T3    III          1     1    17.6
##  5 Drug A    51  2.77  T4    III          1     1    16.4
##  6 Drug B    39  0.613 T4    I            0     1    15.6
##  7 Drug A    37  0.354 T1    II           0     0    24  
##  8 Drug A    32  1.74  T1    I            0     1    18.4
##  9 Drug A    31  0.144 T1    II           0     0    24  
## 10 Drug B    34  0.205 T3    I            0     1    10.5
## # ℹ 190 more rows
```
  

<div class='webex-solution'><button>Show code Solution</button>



``` r
trial |> 
  select(age, marker, stage, grade, trt) |>
  tbl_summary(by = trt, missing_text = "Missing")
```

```{=html}
<div id="orybdztbkd" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#orybdztbkd table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#orybdztbkd thead, #orybdztbkd tbody, #orybdztbkd tfoot, #orybdztbkd tr, #orybdztbkd td, #orybdztbkd th {
  border-style: none;
}

#orybdztbkd p {
  margin: 0;
  padding: 0;
}

#orybdztbkd .gt_table {
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

#orybdztbkd .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#orybdztbkd .gt_title {
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

#orybdztbkd .gt_subtitle {
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

#orybdztbkd .gt_heading {
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

#orybdztbkd .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#orybdztbkd .gt_col_headings {
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

#orybdztbkd .gt_col_heading {
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

#orybdztbkd .gt_column_spanner_outer {
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

#orybdztbkd .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#orybdztbkd .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#orybdztbkd .gt_column_spanner {
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

#orybdztbkd .gt_spanner_row {
  border-bottom-style: hidden;
}

#orybdztbkd .gt_group_heading {
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

#orybdztbkd .gt_empty_group_heading {
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

#orybdztbkd .gt_from_md > :first-child {
  margin-top: 0;
}

#orybdztbkd .gt_from_md > :last-child {
  margin-bottom: 0;
}

#orybdztbkd .gt_row {
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

#orybdztbkd .gt_stub {
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

#orybdztbkd .gt_stub_row_group {
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

#orybdztbkd .gt_row_group_first td {
  border-top-width: 2px;
}

#orybdztbkd .gt_row_group_first th {
  border-top-width: 2px;
}

#orybdztbkd .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#orybdztbkd .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#orybdztbkd .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#orybdztbkd .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#orybdztbkd .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#orybdztbkd .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#orybdztbkd .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#orybdztbkd .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#orybdztbkd .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#orybdztbkd .gt_footnotes {
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

#orybdztbkd .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#orybdztbkd .gt_sourcenotes {
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

#orybdztbkd .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#orybdztbkd .gt_left {
  text-align: left;
}

#orybdztbkd .gt_center {
  text-align: center;
}

#orybdztbkd .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#orybdztbkd .gt_font_normal {
  font-weight: normal;
}

#orybdztbkd .gt_font_bold {
  font-weight: bold;
}

#orybdztbkd .gt_font_italic {
  font-style: italic;
}

#orybdztbkd .gt_super {
  font-size: 65%;
}

#orybdztbkd .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#orybdztbkd .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#orybdztbkd .gt_indent_1 {
  text-indent: 5px;
}

#orybdztbkd .gt_indent_2 {
  text-indent: 10px;
}

#orybdztbkd .gt_indent_3 {
  text-indent: 15px;
}

#orybdztbkd .gt_indent_4 {
  text-indent: 20px;
}

#orybdztbkd .gt_indent_5 {
  text-indent: 25px;
}

#orybdztbkd .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#orybdztbkd div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Characteristic</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_1"><span class='gt_from_md'><strong>Drug A</strong><br />
N = 98</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_2"><span class='gt_from_md'><strong>Drug B</strong><br />
N = 102</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left">Age</td>
<td headers="stat_1" class="gt_row gt_center">46 (37, 60)</td>
<td headers="stat_2" class="gt_row gt_center">48 (39, 56)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Missing</td>
<td headers="stat_1" class="gt_row gt_center">7</td>
<td headers="stat_2" class="gt_row gt_center">4</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Marker Level (ng/mL)</td>
<td headers="stat_1" class="gt_row gt_center">0.84 (0.23, 1.60)</td>
<td headers="stat_2" class="gt_row gt_center">0.52 (0.18, 1.21)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Missing</td>
<td headers="stat_1" class="gt_row gt_center">6</td>
<td headers="stat_2" class="gt_row gt_center">4</td></tr>
    <tr><td headers="label" class="gt_row gt_left">T Stage</td>
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
    <tr><td headers="label" class="gt_row gt_left">Grade</td>
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
      <td class="gt_footnote" colspan="3"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span> <span class='gt_from_md'>Median (Q1, Q3); n (%)</span></td>
    </tr>
  </tfoot>
</table>
</div>
```



</div>


## Making Modifications to the trial table

Let's do some basics, like adding a column for N, adding the overall column, and bolding the labels.


<div class='webex-solution'><button>Show code Solution</button>



``` r
trial |> 
  select(age, marker, stage, grade, trt) |>
  tbl_summary(by = trt, missing_text = "Missing") |> 
  add_n() |>
  add_overall() |>
  bold_labels()
```

```{=html}
<div id="qnyekzydnw" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#qnyekzydnw table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#qnyekzydnw thead, #qnyekzydnw tbody, #qnyekzydnw tfoot, #qnyekzydnw tr, #qnyekzydnw td, #qnyekzydnw th {
  border-style: none;
}

#qnyekzydnw p {
  margin: 0;
  padding: 0;
}

#qnyekzydnw .gt_table {
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

#qnyekzydnw .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#qnyekzydnw .gt_title {
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

#qnyekzydnw .gt_subtitle {
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

#qnyekzydnw .gt_heading {
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

#qnyekzydnw .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#qnyekzydnw .gt_col_headings {
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

#qnyekzydnw .gt_col_heading {
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

#qnyekzydnw .gt_column_spanner_outer {
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

#qnyekzydnw .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#qnyekzydnw .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#qnyekzydnw .gt_column_spanner {
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

#qnyekzydnw .gt_spanner_row {
  border-bottom-style: hidden;
}

#qnyekzydnw .gt_group_heading {
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

#qnyekzydnw .gt_empty_group_heading {
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

#qnyekzydnw .gt_from_md > :first-child {
  margin-top: 0;
}

#qnyekzydnw .gt_from_md > :last-child {
  margin-bottom: 0;
}

#qnyekzydnw .gt_row {
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

#qnyekzydnw .gt_stub {
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

#qnyekzydnw .gt_stub_row_group {
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

#qnyekzydnw .gt_row_group_first td {
  border-top-width: 2px;
}

#qnyekzydnw .gt_row_group_first th {
  border-top-width: 2px;
}

#qnyekzydnw .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#qnyekzydnw .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#qnyekzydnw .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#qnyekzydnw .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#qnyekzydnw .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#qnyekzydnw .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#qnyekzydnw .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#qnyekzydnw .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#qnyekzydnw .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#qnyekzydnw .gt_footnotes {
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

#qnyekzydnw .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#qnyekzydnw .gt_sourcenotes {
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

#qnyekzydnw .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#qnyekzydnw .gt_left {
  text-align: left;
}

#qnyekzydnw .gt_center {
  text-align: center;
}

#qnyekzydnw .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#qnyekzydnw .gt_font_normal {
  font-weight: normal;
}

#qnyekzydnw .gt_font_bold {
  font-weight: bold;
}

#qnyekzydnw .gt_font_italic {
  font-style: italic;
}

#qnyekzydnw .gt_super {
  font-size: 65%;
}

#qnyekzydnw .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#qnyekzydnw .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#qnyekzydnw .gt_indent_1 {
  text-indent: 5px;
}

#qnyekzydnw .gt_indent_2 {
  text-indent: 10px;
}

#qnyekzydnw .gt_indent_3 {
  text-indent: 15px;
}

#qnyekzydnw .gt_indent_4 {
  text-indent: 20px;
}

#qnyekzydnw .gt_indent_5 {
  text-indent: 25px;
}

#qnyekzydnw .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#qnyekzydnw div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Characteristic</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="n"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_0"><span class='gt_from_md'><strong>Overall</strong><br />
N = 200</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_1"><span class='gt_from_md'><strong>Drug A</strong><br />
N = 98</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_2"><span class='gt_from_md'><strong>Drug B</strong><br />
N = 102</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Age</td>
<td headers="n" class="gt_row gt_center">189</td>
<td headers="stat_0" class="gt_row gt_center">47 (38, 57)</td>
<td headers="stat_1" class="gt_row gt_center">46 (37, 60)</td>
<td headers="stat_2" class="gt_row gt_center">48 (39, 56)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Missing</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">11</td>
<td headers="stat_1" class="gt_row gt_center">7</td>
<td headers="stat_2" class="gt_row gt_center">4</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Marker Level (ng/mL)</td>
<td headers="n" class="gt_row gt_center">190</td>
<td headers="stat_0" class="gt_row gt_center">0.64 (0.22, 1.41)</td>
<td headers="stat_1" class="gt_row gt_center">0.84 (0.23, 1.60)</td>
<td headers="stat_2" class="gt_row gt_center">0.52 (0.18, 1.21)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Missing</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">10</td>
<td headers="stat_1" class="gt_row gt_center">6</td>
<td headers="stat_2" class="gt_row gt_center">4</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">T Stage</td>
<td headers="n" class="gt_row gt_center">200</td>
<td headers="stat_0" class="gt_row gt_center"><br /></td>
<td headers="stat_1" class="gt_row gt_center"><br /></td>
<td headers="stat_2" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    T1</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">53 (27%)</td>
<td headers="stat_1" class="gt_row gt_center">28 (29%)</td>
<td headers="stat_2" class="gt_row gt_center">25 (25%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    T2</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">54 (27%)</td>
<td headers="stat_1" class="gt_row gt_center">25 (26%)</td>
<td headers="stat_2" class="gt_row gt_center">29 (28%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    T3</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">43 (22%)</td>
<td headers="stat_1" class="gt_row gt_center">22 (22%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (21%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    T4</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">50 (25%)</td>
<td headers="stat_1" class="gt_row gt_center">23 (23%)</td>
<td headers="stat_2" class="gt_row gt_center">27 (26%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Grade</td>
<td headers="n" class="gt_row gt_center">200</td>
<td headers="stat_0" class="gt_row gt_center"><br /></td>
<td headers="stat_1" class="gt_row gt_center"><br /></td>
<td headers="stat_2" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    I</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">68 (34%)</td>
<td headers="stat_1" class="gt_row gt_center">35 (36%)</td>
<td headers="stat_2" class="gt_row gt_center">33 (32%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    II</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">68 (34%)</td>
<td headers="stat_1" class="gt_row gt_center">32 (33%)</td>
<td headers="stat_2" class="gt_row gt_center">36 (35%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    III</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">64 (32%)</td>
<td headers="stat_1" class="gt_row gt_center">31 (32%)</td>
<td headers="stat_2" class="gt_row gt_center">33 (32%)</td></tr>
  </tbody>
  
  <tfoot class="gt_footnotes">
    <tr>
      <td class="gt_footnote" colspan="5"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span> <span class='gt_from_md'>Median (Q1, Q3); n (%)</span></td>
    </tr>
  </tfoot>
</table>
</div>
```


</div>



## More Modifications to the trial table

Let's change the Headers to make them have line breaks (and no commas), change 
the label Characteristic to 'Participant Characteristic`, and add a column spanner for 
the treatment arms. Use flanking double asterisks `**` to bold the headers as needed.


<div class='webex-solution'><button>Show code Solution</button>



``` r
trial |> 
  select(age, marker, stage, grade, trt) |>
  tbl_summary(by = trt, missing_text = "Missing") |> 
  add_n() |>
  add_overall() |>
  bold_labels() |> 
  modify_header(update = list(
    label ~ "**Participant<br>Characteristic**",
    stat_0 ~ "**Overall**<br>N = 200",
    stat_1 ~ "**Drug A**<br>N = 98",
    stat_2 ~ "**Drug B**<br>N = 102"
  )) |>
  modify_spanning_header(c("stat_1", "stat_2") ~ "**Treatment Arm**") 
```

```{=html}
<div id="ejdnqchwji" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#ejdnqchwji table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#ejdnqchwji thead, #ejdnqchwji tbody, #ejdnqchwji tfoot, #ejdnqchwji tr, #ejdnqchwji td, #ejdnqchwji th {
  border-style: none;
}

#ejdnqchwji p {
  margin: 0;
  padding: 0;
}

#ejdnqchwji .gt_table {
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

#ejdnqchwji .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#ejdnqchwji .gt_title {
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

#ejdnqchwji .gt_subtitle {
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

#ejdnqchwji .gt_heading {
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

#ejdnqchwji .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ejdnqchwji .gt_col_headings {
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

#ejdnqchwji .gt_col_heading {
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

#ejdnqchwji .gt_column_spanner_outer {
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

#ejdnqchwji .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#ejdnqchwji .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#ejdnqchwji .gt_column_spanner {
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

#ejdnqchwji .gt_spanner_row {
  border-bottom-style: hidden;
}

#ejdnqchwji .gt_group_heading {
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

#ejdnqchwji .gt_empty_group_heading {
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

#ejdnqchwji .gt_from_md > :first-child {
  margin-top: 0;
}

#ejdnqchwji .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ejdnqchwji .gt_row {
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

#ejdnqchwji .gt_stub {
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

#ejdnqchwji .gt_stub_row_group {
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

#ejdnqchwji .gt_row_group_first td {
  border-top-width: 2px;
}

#ejdnqchwji .gt_row_group_first th {
  border-top-width: 2px;
}

#ejdnqchwji .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ejdnqchwji .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#ejdnqchwji .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#ejdnqchwji .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ejdnqchwji .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ejdnqchwji .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#ejdnqchwji .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#ejdnqchwji .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#ejdnqchwji .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ejdnqchwji .gt_footnotes {
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

#ejdnqchwji .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ejdnqchwji .gt_sourcenotes {
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

#ejdnqchwji .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ejdnqchwji .gt_left {
  text-align: left;
}

#ejdnqchwji .gt_center {
  text-align: center;
}

#ejdnqchwji .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ejdnqchwji .gt_font_normal {
  font-weight: normal;
}

#ejdnqchwji .gt_font_bold {
  font-weight: bold;
}

#ejdnqchwji .gt_font_italic {
  font-style: italic;
}

#ejdnqchwji .gt_super {
  font-size: 65%;
}

#ejdnqchwji .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#ejdnqchwji .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#ejdnqchwji .gt_indent_1 {
  text-indent: 5px;
}

#ejdnqchwji .gt_indent_2 {
  text-indent: 10px;
}

#ejdnqchwji .gt_indent_3 {
  text-indent: 15px;
}

#ejdnqchwji .gt_indent_4 {
  text-indent: 20px;
}

#ejdnqchwji .gt_indent_5 {
  text-indent: 25px;
}

#ejdnqchwji .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#ejdnqchwji div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Participant<br>Characteristic</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="n"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="stat_0"><span class='gt_from_md'><strong>Overall</strong><br>N = 200</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="level 1; stat_1">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>Treatment Arm</strong></span></div>
      </th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_1"><span class='gt_from_md'><strong>Drug A</strong><br>N = 98</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_2"><span class='gt_from_md'><strong>Drug B</strong><br>N = 102</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Age</td>
<td headers="n" class="gt_row gt_center">189</td>
<td headers="stat_0" class="gt_row gt_center">47 (38, 57)</td>
<td headers="stat_1" class="gt_row gt_center">46 (37, 60)</td>
<td headers="stat_2" class="gt_row gt_center">48 (39, 56)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Missing</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">11</td>
<td headers="stat_1" class="gt_row gt_center">7</td>
<td headers="stat_2" class="gt_row gt_center">4</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Marker Level (ng/mL)</td>
<td headers="n" class="gt_row gt_center">190</td>
<td headers="stat_0" class="gt_row gt_center">0.64 (0.22, 1.41)</td>
<td headers="stat_1" class="gt_row gt_center">0.84 (0.23, 1.60)</td>
<td headers="stat_2" class="gt_row gt_center">0.52 (0.18, 1.21)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Missing</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">10</td>
<td headers="stat_1" class="gt_row gt_center">6</td>
<td headers="stat_2" class="gt_row gt_center">4</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">T Stage</td>
<td headers="n" class="gt_row gt_center">200</td>
<td headers="stat_0" class="gt_row gt_center"><br /></td>
<td headers="stat_1" class="gt_row gt_center"><br /></td>
<td headers="stat_2" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    T1</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">53 (27%)</td>
<td headers="stat_1" class="gt_row gt_center">28 (29%)</td>
<td headers="stat_2" class="gt_row gt_center">25 (25%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    T2</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">54 (27%)</td>
<td headers="stat_1" class="gt_row gt_center">25 (26%)</td>
<td headers="stat_2" class="gt_row gt_center">29 (28%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    T3</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">43 (22%)</td>
<td headers="stat_1" class="gt_row gt_center">22 (22%)</td>
<td headers="stat_2" class="gt_row gt_center">21 (21%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    T4</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">50 (25%)</td>
<td headers="stat_1" class="gt_row gt_center">23 (23%)</td>
<td headers="stat_2" class="gt_row gt_center">27 (26%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Grade</td>
<td headers="n" class="gt_row gt_center">200</td>
<td headers="stat_0" class="gt_row gt_center"><br /></td>
<td headers="stat_1" class="gt_row gt_center"><br /></td>
<td headers="stat_2" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    I</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">68 (34%)</td>
<td headers="stat_1" class="gt_row gt_center">35 (36%)</td>
<td headers="stat_2" class="gt_row gt_center">33 (32%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    II</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">68 (34%)</td>
<td headers="stat_1" class="gt_row gt_center">32 (33%)</td>
<td headers="stat_2" class="gt_row gt_center">36 (35%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    III</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">64 (32%)</td>
<td headers="stat_1" class="gt_row gt_center">31 (32%)</td>
<td headers="stat_2" class="gt_row gt_center">33 (32%)</td></tr>
  </tbody>
  
  <tfoot class="gt_footnotes">
    <tr>
      <td class="gt_footnote" colspan="5"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span> <span class='gt_from_md'>Median (Q1, Q3); n (%)</span></td>
    </tr>
  </tfoot>
</table>
</div>
```


</div>



## Taking Control of the Stats

You can take control of what statistics are shown.
Let's see an example where you require mean and SD for all continuous variables
in the table,
set digits to 2,
and show fractions and percentages for all categorical values.
These changes are made within the `tbl_summary()` function.
Note how the footnote changes to keep up.



``` r
trial |> 
  select(age, marker, stage, grade, trt) |>
  tbl_summary(by = trt, missing_text = "Missing",
               statistic = list(
      all_continuous() ~ "{mean} ({sd})",
      all_categorical() ~ "{n} / {N} ({p}%)"
    ),
    digits = all_continuous() ~ 2,
    label = grade ~ "Tumor Grade",) |> 
  add_n() |>
  add_overall() |>
  bold_labels() |> 
  modify_header(update = list(
    label ~ "**Participant<br>Characteristic**",
    stat_0 ~ "**Overall**<br>N = 200",
    stat_1 ~ "**Drug A**<br>N = 98",
    stat_2 ~ "**Drug B**<br>N = 102"
  )) |>
  modify_spanning_header(c("stat_1", "stat_2") ~ "**Treatment Arm**") 
```

```{=html}
<div id="plhwxooozm" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#plhwxooozm table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#plhwxooozm thead, #plhwxooozm tbody, #plhwxooozm tfoot, #plhwxooozm tr, #plhwxooozm td, #plhwxooozm th {
  border-style: none;
}

#plhwxooozm p {
  margin: 0;
  padding: 0;
}

#plhwxooozm .gt_table {
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

#plhwxooozm .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#plhwxooozm .gt_title {
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

#plhwxooozm .gt_subtitle {
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

#plhwxooozm .gt_heading {
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

#plhwxooozm .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#plhwxooozm .gt_col_headings {
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

#plhwxooozm .gt_col_heading {
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

#plhwxooozm .gt_column_spanner_outer {
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

#plhwxooozm .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#plhwxooozm .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#plhwxooozm .gt_column_spanner {
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

#plhwxooozm .gt_spanner_row {
  border-bottom-style: hidden;
}

#plhwxooozm .gt_group_heading {
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

#plhwxooozm .gt_empty_group_heading {
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

#plhwxooozm .gt_from_md > :first-child {
  margin-top: 0;
}

#plhwxooozm .gt_from_md > :last-child {
  margin-bottom: 0;
}

#plhwxooozm .gt_row {
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

#plhwxooozm .gt_stub {
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

#plhwxooozm .gt_stub_row_group {
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

#plhwxooozm .gt_row_group_first td {
  border-top-width: 2px;
}

#plhwxooozm .gt_row_group_first th {
  border-top-width: 2px;
}

#plhwxooozm .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#plhwxooozm .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#plhwxooozm .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#plhwxooozm .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#plhwxooozm .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#plhwxooozm .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#plhwxooozm .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#plhwxooozm .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#plhwxooozm .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#plhwxooozm .gt_footnotes {
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

#plhwxooozm .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#plhwxooozm .gt_sourcenotes {
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

#plhwxooozm .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#plhwxooozm .gt_left {
  text-align: left;
}

#plhwxooozm .gt_center {
  text-align: center;
}

#plhwxooozm .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#plhwxooozm .gt_font_normal {
  font-weight: normal;
}

#plhwxooozm .gt_font_bold {
  font-weight: bold;
}

#plhwxooozm .gt_font_italic {
  font-style: italic;
}

#plhwxooozm .gt_super {
  font-size: 65%;
}

#plhwxooozm .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#plhwxooozm .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#plhwxooozm .gt_indent_1 {
  text-indent: 5px;
}

#plhwxooozm .gt_indent_2 {
  text-indent: 10px;
}

#plhwxooozm .gt_indent_3 {
  text-indent: 15px;
}

#plhwxooozm .gt_indent_4 {
  text-indent: 20px;
}

#plhwxooozm .gt_indent_5 {
  text-indent: 25px;
}

#plhwxooozm .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#plhwxooozm div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Participant<br>Characteristic</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="n"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="stat_0"><span class='gt_from_md'><strong>Overall</strong><br>N = 200</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="level 1; stat_1">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>Treatment Arm</strong></span></div>
      </th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_1"><span class='gt_from_md'><strong>Drug A</strong><br>N = 98</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_2"><span class='gt_from_md'><strong>Drug B</strong><br>N = 102</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Age</td>
<td headers="n" class="gt_row gt_center">189</td>
<td headers="stat_0" class="gt_row gt_center">47.24 (14.31)</td>
<td headers="stat_1" class="gt_row gt_center">47.01 (14.71)</td>
<td headers="stat_2" class="gt_row gt_center">47.45 (14.01)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Missing</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">11</td>
<td headers="stat_1" class="gt_row gt_center">7</td>
<td headers="stat_2" class="gt_row gt_center">4</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Marker Level (ng/mL)</td>
<td headers="n" class="gt_row gt_center">190</td>
<td headers="stat_0" class="gt_row gt_center">0.92 (0.86)</td>
<td headers="stat_1" class="gt_row gt_center">1.02 (0.89)</td>
<td headers="stat_2" class="gt_row gt_center">0.82 (0.83)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Missing</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">10</td>
<td headers="stat_1" class="gt_row gt_center">6</td>
<td headers="stat_2" class="gt_row gt_center">4</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">T Stage</td>
<td headers="n" class="gt_row gt_center">200</td>
<td headers="stat_0" class="gt_row gt_center"><br /></td>
<td headers="stat_1" class="gt_row gt_center"><br /></td>
<td headers="stat_2" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    T1</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">53 / 200 (27%)</td>
<td headers="stat_1" class="gt_row gt_center">28 / 98 (29%)</td>
<td headers="stat_2" class="gt_row gt_center">25 / 102 (25%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    T2</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">54 / 200 (27%)</td>
<td headers="stat_1" class="gt_row gt_center">25 / 98 (26%)</td>
<td headers="stat_2" class="gt_row gt_center">29 / 102 (28%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    T3</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">43 / 200 (22%)</td>
<td headers="stat_1" class="gt_row gt_center">22 / 98 (22%)</td>
<td headers="stat_2" class="gt_row gt_center">21 / 102 (21%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    T4</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">50 / 200 (25%)</td>
<td headers="stat_1" class="gt_row gt_center">23 / 98 (23%)</td>
<td headers="stat_2" class="gt_row gt_center">27 / 102 (26%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Tumor Grade</td>
<td headers="n" class="gt_row gt_center">200</td>
<td headers="stat_0" class="gt_row gt_center"><br /></td>
<td headers="stat_1" class="gt_row gt_center"><br /></td>
<td headers="stat_2" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    I</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">68 / 200 (34%)</td>
<td headers="stat_1" class="gt_row gt_center">35 / 98 (36%)</td>
<td headers="stat_2" class="gt_row gt_center">33 / 102 (32%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    II</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">68 / 200 (34%)</td>
<td headers="stat_1" class="gt_row gt_center">32 / 98 (33%)</td>
<td headers="stat_2" class="gt_row gt_center">36 / 102 (35%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    III</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">64 / 200 (32%)</td>
<td headers="stat_1" class="gt_row gt_center">31 / 98 (32%)</td>
<td headers="stat_2" class="gt_row gt_center">33 / 102 (32%)</td></tr>
  </tbody>
  
  <tfoot class="gt_footnotes">
    <tr>
      <td class="gt_footnote" colspan="5"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span> <span class='gt_from_md'>Mean (SD); n / N (%)</span></td>
    </tr>
  </tfoot>
</table>
</div>
```

### Your Turn
The original streptomycin for tuberculosis trial never had a Table 1, because it
was published in 1955, when these did not exist. Let's make one now. 
Gender and the baseline_x variables in the strep_tb dataset will be the baseline variables.
The `arm` variable will be the treatment variable.
Use the `strep_tb` dataset from the {medicaldata} package to create a Table 1.
You will need to run `data(strep_tb`) to load the dataset.
Then pipe the `strep_tb` dataset into a select function, then into the `tbl_summary()` function.
Improve the table from the baseline generic version. Add details and styling that you 
think would be helpful to the reader, and make it publication-ready.
Consider cleaning up some of the value labels with mutate statements.



<div class='webex-solution'><button>Show code Solution</button>



``` r
strep_tb |> 
  select(gender, starts_with("baseline"), arm) |>
  tbl_summary(by = arm, missing_text = "Missing",
              label = list(
                gender ~ "Gender",
                baseline_condition ~ "Baseline Condition",
                baseline_temp ~ "Baseline Temperature",
                baseline_esr ~ "Baseline ESR",
                baseline_cavitation ~ "Baseline Cavitation"
              )) |> 
  add_n() |>
  add_overall() |>
  bold_labels() |> 
  modify_header(update = list(
    label ~ "**Participant<br>Characteristic**",
    stat_0 ~ "**Overall**<br>N = 107",
    stat_1 ~ "**Control**<br>N = 52",
    stat_2 ~ "**Streptomycin**<br>N = 55"
  )) |>
  modify_spanning_header(c("stat_1", "stat_2") ~ "**Treatment Arm**") 
```

```{=html}
<div id="ayxhhxznxa" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#ayxhhxznxa table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#ayxhhxznxa thead, #ayxhhxznxa tbody, #ayxhhxznxa tfoot, #ayxhhxznxa tr, #ayxhhxznxa td, #ayxhhxznxa th {
  border-style: none;
}

#ayxhhxznxa p {
  margin: 0;
  padding: 0;
}

#ayxhhxznxa .gt_table {
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

#ayxhhxznxa .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#ayxhhxznxa .gt_title {
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

#ayxhhxznxa .gt_subtitle {
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

#ayxhhxznxa .gt_heading {
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

#ayxhhxznxa .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ayxhhxznxa .gt_col_headings {
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

#ayxhhxznxa .gt_col_heading {
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

#ayxhhxznxa .gt_column_spanner_outer {
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

#ayxhhxznxa .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#ayxhhxznxa .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#ayxhhxznxa .gt_column_spanner {
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

#ayxhhxznxa .gt_spanner_row {
  border-bottom-style: hidden;
}

#ayxhhxznxa .gt_group_heading {
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

#ayxhhxznxa .gt_empty_group_heading {
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

#ayxhhxznxa .gt_from_md > :first-child {
  margin-top: 0;
}

#ayxhhxznxa .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ayxhhxznxa .gt_row {
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

#ayxhhxznxa .gt_stub {
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

#ayxhhxznxa .gt_stub_row_group {
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

#ayxhhxznxa .gt_row_group_first td {
  border-top-width: 2px;
}

#ayxhhxznxa .gt_row_group_first th {
  border-top-width: 2px;
}

#ayxhhxznxa .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ayxhhxznxa .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#ayxhhxznxa .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#ayxhhxznxa .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ayxhhxznxa .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ayxhhxznxa .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#ayxhhxznxa .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#ayxhhxznxa .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#ayxhhxznxa .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ayxhhxznxa .gt_footnotes {
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

#ayxhhxznxa .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ayxhhxznxa .gt_sourcenotes {
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

#ayxhhxznxa .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ayxhhxznxa .gt_left {
  text-align: left;
}

#ayxhhxznxa .gt_center {
  text-align: center;
}

#ayxhhxznxa .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ayxhhxznxa .gt_font_normal {
  font-weight: normal;
}

#ayxhhxznxa .gt_font_bold {
  font-weight: bold;
}

#ayxhhxznxa .gt_font_italic {
  font-style: italic;
}

#ayxhhxznxa .gt_super {
  font-size: 65%;
}

#ayxhhxznxa .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#ayxhhxznxa .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#ayxhhxznxa .gt_indent_1 {
  text-indent: 5px;
}

#ayxhhxznxa .gt_indent_2 {
  text-indent: 10px;
}

#ayxhhxznxa .gt_indent_3 {
  text-indent: 15px;
}

#ayxhhxznxa .gt_indent_4 {
  text-indent: 20px;
}

#ayxhhxznxa .gt_indent_5 {
  text-indent: 25px;
}

#ayxhhxznxa .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#ayxhhxznxa div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Participant<br>Characteristic</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="n"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="stat_0"><span class='gt_from_md'><strong>Overall</strong><br>N = 107</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="level 1; stat_1">
        <div class="gt_column_spanner"><span class='gt_from_md'><strong>Treatment Arm</strong></span></div>
      </th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_1"><span class='gt_from_md'><strong>Control</strong><br>N = 52</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_2"><span class='gt_from_md'><strong>Streptomycin</strong><br>N = 55</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Gender</td>
<td headers="n" class="gt_row gt_center">107</td>
<td headers="stat_0" class="gt_row gt_center"><br /></td>
<td headers="stat_1" class="gt_row gt_center"><br /></td>
<td headers="stat_2" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    F</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">59 (55%)</td>
<td headers="stat_1" class="gt_row gt_center">28 (54%)</td>
<td headers="stat_2" class="gt_row gt_center">31 (56%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    M</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">48 (45%)</td>
<td headers="stat_1" class="gt_row gt_center">24 (46%)</td>
<td headers="stat_2" class="gt_row gt_center">24 (44%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Baseline Condition</td>
<td headers="n" class="gt_row gt_center">107</td>
<td headers="stat_0" class="gt_row gt_center"><br /></td>
<td headers="stat_1" class="gt_row gt_center"><br /></td>
<td headers="stat_2" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1_Good</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">16 (15%)</td>
<td headers="stat_1" class="gt_row gt_center">8 (15%)</td>
<td headers="stat_2" class="gt_row gt_center">8 (15%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2_Fair</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">37 (35%)</td>
<td headers="stat_1" class="gt_row gt_center">20 (38%)</td>
<td headers="stat_2" class="gt_row gt_center">17 (31%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    3_Poor</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">54 (50%)</td>
<td headers="stat_1" class="gt_row gt_center">24 (46%)</td>
<td headers="stat_2" class="gt_row gt_center">30 (55%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Baseline Temperature</td>
<td headers="n" class="gt_row gt_center">107</td>
<td headers="stat_0" class="gt_row gt_center"><br /></td>
<td headers="stat_1" class="gt_row gt_center"><br /></td>
<td headers="stat_2" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1_&lt;=98.9F/37.2C</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">7 (6.5%)</td>
<td headers="stat_1" class="gt_row gt_center">4 (7.7%)</td>
<td headers="stat_2" class="gt_row gt_center">3 (5.5%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2_99-99.9F/37.3-37.7C</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">24 (22%)</td>
<td headers="stat_1" class="gt_row gt_center">12 (23%)</td>
<td headers="stat_2" class="gt_row gt_center">12 (22%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2_99-99.9F/37.3-37.7C/37.3-37.7C</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">1 (0.9%)</td>
<td headers="stat_1" class="gt_row gt_center">0 (0%)</td>
<td headers="stat_2" class="gt_row gt_center">1 (1.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    3_100-100.9F/37.8-38.2C</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">31 (29%)</td>
<td headers="stat_1" class="gt_row gt_center">17 (33%)</td>
<td headers="stat_2" class="gt_row gt_center">14 (25%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    3_100-100.9F/37.8-38.2C/37.8-38.2C</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">1 (0.9%)</td>
<td headers="stat_1" class="gt_row gt_center">0 (0%)</td>
<td headers="stat_2" class="gt_row gt_center">1 (1.8%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    4_&gt;=101F/38.3C</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">43 (40%)</td>
<td headers="stat_1" class="gt_row gt_center">19 (37%)</td>
<td headers="stat_2" class="gt_row gt_center">24 (44%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Baseline ESR</td>
<td headers="n" class="gt_row gt_center">106</td>
<td headers="stat_0" class="gt_row gt_center"><br /></td>
<td headers="stat_1" class="gt_row gt_center"><br /></td>
<td headers="stat_2" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2_11-20</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">5 (4.7%)</td>
<td headers="stat_1" class="gt_row gt_center">2 (3.9%)</td>
<td headers="stat_2" class="gt_row gt_center">3 (5.5%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    3_21-50</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">36 (34%)</td>
<td headers="stat_1" class="gt_row gt_center">20 (39%)</td>
<td headers="stat_2" class="gt_row gt_center">16 (29%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    4_51+</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">65 (61%)</td>
<td headers="stat_1" class="gt_row gt_center">29 (57%)</td>
<td headers="stat_2" class="gt_row gt_center">36 (65%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Missing</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">1</td>
<td headers="stat_1" class="gt_row gt_center">1</td>
<td headers="stat_2" class="gt_row gt_center">0</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Baseline Cavitation</td>
<td headers="n" class="gt_row gt_center">107</td>
<td headers="stat_0" class="gt_row gt_center">62 (58%)</td>
<td headers="stat_1" class="gt_row gt_center">30 (58%)</td>
<td headers="stat_2" class="gt_row gt_center">32 (58%)</td></tr>
  </tbody>
  
  <tfoot class="gt_footnotes">
    <tr>
      <td class="gt_footnote" colspan="5"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span> <span class='gt_from_md'>n (%)</span></td>
    </tr>
  </tfoot>
</table>
</div>
```


</div>

