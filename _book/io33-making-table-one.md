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
<div id="xkmepwliul" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#xkmepwliul table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#xkmepwliul thead, #xkmepwliul tbody, #xkmepwliul tfoot, #xkmepwliul tr, #xkmepwliul td, #xkmepwliul th {
  border-style: none;
}

#xkmepwliul p {
  margin: 0;
  padding: 0;
}

#xkmepwliul .gt_table {
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

#xkmepwliul .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#xkmepwliul .gt_title {
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

#xkmepwliul .gt_subtitle {
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

#xkmepwliul .gt_heading {
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

#xkmepwliul .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#xkmepwliul .gt_col_headings {
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

#xkmepwliul .gt_col_heading {
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

#xkmepwliul .gt_column_spanner_outer {
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

#xkmepwliul .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#xkmepwliul .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#xkmepwliul .gt_column_spanner {
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

#xkmepwliul .gt_spanner_row {
  border-bottom-style: hidden;
}

#xkmepwliul .gt_group_heading {
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

#xkmepwliul .gt_empty_group_heading {
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

#xkmepwliul .gt_from_md > :first-child {
  margin-top: 0;
}

#xkmepwliul .gt_from_md > :last-child {
  margin-bottom: 0;
}

#xkmepwliul .gt_row {
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

#xkmepwliul .gt_stub {
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

#xkmepwliul .gt_stub_row_group {
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

#xkmepwliul .gt_row_group_first td {
  border-top-width: 2px;
}

#xkmepwliul .gt_row_group_first th {
  border-top-width: 2px;
}

#xkmepwliul .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#xkmepwliul .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#xkmepwliul .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#xkmepwliul .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#xkmepwliul .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#xkmepwliul .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#xkmepwliul .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#xkmepwliul .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#xkmepwliul .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#xkmepwliul .gt_footnotes {
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

#xkmepwliul .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#xkmepwliul .gt_sourcenotes {
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

#xkmepwliul .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#xkmepwliul .gt_left {
  text-align: left;
}

#xkmepwliul .gt_center {
  text-align: center;
}

#xkmepwliul .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#xkmepwliul .gt_font_normal {
  font-weight: normal;
}

#xkmepwliul .gt_font_bold {
  font-weight: bold;
}

#xkmepwliul .gt_font_italic {
  font-style: italic;
}

#xkmepwliul .gt_super {
  font-size: 65%;
}

#xkmepwliul .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#xkmepwliul .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#xkmepwliul .gt_indent_1 {
  text-indent: 5px;
}

#xkmepwliul .gt_indent_2 {
  text-indent: 10px;
}

#xkmepwliul .gt_indent_3 {
  text-indent: 15px;
}

#xkmepwliul .gt_indent_4 {
  text-indent: 20px;
}

#xkmepwliul .gt_indent_5 {
  text-indent: 25px;
}

#xkmepwliul .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#xkmepwliul div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="qdpjaaxwip" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#qdpjaaxwip table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#qdpjaaxwip thead, #qdpjaaxwip tbody, #qdpjaaxwip tfoot, #qdpjaaxwip tr, #qdpjaaxwip td, #qdpjaaxwip th {
  border-style: none;
}

#qdpjaaxwip p {
  margin: 0;
  padding: 0;
}

#qdpjaaxwip .gt_table {
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

#qdpjaaxwip .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#qdpjaaxwip .gt_title {
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

#qdpjaaxwip .gt_subtitle {
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

#qdpjaaxwip .gt_heading {
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

#qdpjaaxwip .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#qdpjaaxwip .gt_col_headings {
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

#qdpjaaxwip .gt_col_heading {
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

#qdpjaaxwip .gt_column_spanner_outer {
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

#qdpjaaxwip .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#qdpjaaxwip .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#qdpjaaxwip .gt_column_spanner {
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

#qdpjaaxwip .gt_spanner_row {
  border-bottom-style: hidden;
}

#qdpjaaxwip .gt_group_heading {
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

#qdpjaaxwip .gt_empty_group_heading {
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

#qdpjaaxwip .gt_from_md > :first-child {
  margin-top: 0;
}

#qdpjaaxwip .gt_from_md > :last-child {
  margin-bottom: 0;
}

#qdpjaaxwip .gt_row {
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

#qdpjaaxwip .gt_stub {
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

#qdpjaaxwip .gt_stub_row_group {
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

#qdpjaaxwip .gt_row_group_first td {
  border-top-width: 2px;
}

#qdpjaaxwip .gt_row_group_first th {
  border-top-width: 2px;
}

#qdpjaaxwip .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#qdpjaaxwip .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#qdpjaaxwip .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#qdpjaaxwip .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#qdpjaaxwip .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#qdpjaaxwip .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#qdpjaaxwip .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#qdpjaaxwip .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#qdpjaaxwip .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#qdpjaaxwip .gt_footnotes {
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

#qdpjaaxwip .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#qdpjaaxwip .gt_sourcenotes {
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

#qdpjaaxwip .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#qdpjaaxwip .gt_left {
  text-align: left;
}

#qdpjaaxwip .gt_center {
  text-align: center;
}

#qdpjaaxwip .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#qdpjaaxwip .gt_font_normal {
  font-weight: normal;
}

#qdpjaaxwip .gt_font_bold {
  font-weight: bold;
}

#qdpjaaxwip .gt_font_italic {
  font-style: italic;
}

#qdpjaaxwip .gt_super {
  font-size: 65%;
}

#qdpjaaxwip .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#qdpjaaxwip .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#qdpjaaxwip .gt_indent_1 {
  text-indent: 5px;
}

#qdpjaaxwip .gt_indent_2 {
  text-indent: 10px;
}

#qdpjaaxwip .gt_indent_3 {
  text-indent: 15px;
}

#qdpjaaxwip .gt_indent_4 {
  text-indent: 20px;
}

#qdpjaaxwip .gt_indent_5 {
  text-indent: 25px;
}

#qdpjaaxwip .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#qdpjaaxwip div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="olaezasgyj" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#olaezasgyj table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#olaezasgyj thead, #olaezasgyj tbody, #olaezasgyj tfoot, #olaezasgyj tr, #olaezasgyj td, #olaezasgyj th {
  border-style: none;
}

#olaezasgyj p {
  margin: 0;
  padding: 0;
}

#olaezasgyj .gt_table {
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

#olaezasgyj .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#olaezasgyj .gt_title {
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

#olaezasgyj .gt_subtitle {
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

#olaezasgyj .gt_heading {
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

#olaezasgyj .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#olaezasgyj .gt_col_headings {
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

#olaezasgyj .gt_col_heading {
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

#olaezasgyj .gt_column_spanner_outer {
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

#olaezasgyj .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#olaezasgyj .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#olaezasgyj .gt_column_spanner {
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

#olaezasgyj .gt_spanner_row {
  border-bottom-style: hidden;
}

#olaezasgyj .gt_group_heading {
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

#olaezasgyj .gt_empty_group_heading {
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

#olaezasgyj .gt_from_md > :first-child {
  margin-top: 0;
}

#olaezasgyj .gt_from_md > :last-child {
  margin-bottom: 0;
}

#olaezasgyj .gt_row {
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

#olaezasgyj .gt_stub {
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

#olaezasgyj .gt_stub_row_group {
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

#olaezasgyj .gt_row_group_first td {
  border-top-width: 2px;
}

#olaezasgyj .gt_row_group_first th {
  border-top-width: 2px;
}

#olaezasgyj .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#olaezasgyj .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#olaezasgyj .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#olaezasgyj .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#olaezasgyj .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#olaezasgyj .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#olaezasgyj .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#olaezasgyj .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#olaezasgyj .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#olaezasgyj .gt_footnotes {
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

#olaezasgyj .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#olaezasgyj .gt_sourcenotes {
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

#olaezasgyj .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#olaezasgyj .gt_left {
  text-align: left;
}

#olaezasgyj .gt_center {
  text-align: center;
}

#olaezasgyj .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#olaezasgyj .gt_font_normal {
  font-weight: normal;
}

#olaezasgyj .gt_font_bold {
  font-weight: bold;
}

#olaezasgyj .gt_font_italic {
  font-style: italic;
}

#olaezasgyj .gt_super {
  font-size: 65%;
}

#olaezasgyj .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#olaezasgyj .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#olaezasgyj .gt_indent_1 {
  text-indent: 5px;
}

#olaezasgyj .gt_indent_2 {
  text-indent: 10px;
}

#olaezasgyj .gt_indent_3 {
  text-indent: 15px;
}

#olaezasgyj .gt_indent_4 {
  text-indent: 20px;
}

#olaezasgyj .gt_indent_5 {
  text-indent: 25px;
}

#olaezasgyj .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#olaezasgyj div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="kjyhsmuzpi" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#kjyhsmuzpi table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#kjyhsmuzpi thead, #kjyhsmuzpi tbody, #kjyhsmuzpi tfoot, #kjyhsmuzpi tr, #kjyhsmuzpi td, #kjyhsmuzpi th {
  border-style: none;
}

#kjyhsmuzpi p {
  margin: 0;
  padding: 0;
}

#kjyhsmuzpi .gt_table {
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

#kjyhsmuzpi .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#kjyhsmuzpi .gt_title {
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

#kjyhsmuzpi .gt_subtitle {
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

#kjyhsmuzpi .gt_heading {
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

#kjyhsmuzpi .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#kjyhsmuzpi .gt_col_headings {
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

#kjyhsmuzpi .gt_col_heading {
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

#kjyhsmuzpi .gt_column_spanner_outer {
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

#kjyhsmuzpi .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#kjyhsmuzpi .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#kjyhsmuzpi .gt_column_spanner {
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

#kjyhsmuzpi .gt_spanner_row {
  border-bottom-style: hidden;
}

#kjyhsmuzpi .gt_group_heading {
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

#kjyhsmuzpi .gt_empty_group_heading {
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

#kjyhsmuzpi .gt_from_md > :first-child {
  margin-top: 0;
}

#kjyhsmuzpi .gt_from_md > :last-child {
  margin-bottom: 0;
}

#kjyhsmuzpi .gt_row {
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

#kjyhsmuzpi .gt_stub {
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

#kjyhsmuzpi .gt_stub_row_group {
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

#kjyhsmuzpi .gt_row_group_first td {
  border-top-width: 2px;
}

#kjyhsmuzpi .gt_row_group_first th {
  border-top-width: 2px;
}

#kjyhsmuzpi .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#kjyhsmuzpi .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#kjyhsmuzpi .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#kjyhsmuzpi .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#kjyhsmuzpi .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#kjyhsmuzpi .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#kjyhsmuzpi .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#kjyhsmuzpi .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#kjyhsmuzpi .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#kjyhsmuzpi .gt_footnotes {
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

#kjyhsmuzpi .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#kjyhsmuzpi .gt_sourcenotes {
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

#kjyhsmuzpi .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#kjyhsmuzpi .gt_left {
  text-align: left;
}

#kjyhsmuzpi .gt_center {
  text-align: center;
}

#kjyhsmuzpi .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#kjyhsmuzpi .gt_font_normal {
  font-weight: normal;
}

#kjyhsmuzpi .gt_font_bold {
  font-weight: bold;
}

#kjyhsmuzpi .gt_font_italic {
  font-style: italic;
}

#kjyhsmuzpi .gt_super {
  font-size: 65%;
}

#kjyhsmuzpi .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#kjyhsmuzpi .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#kjyhsmuzpi .gt_indent_1 {
  text-indent: 5px;
}

#kjyhsmuzpi .gt_indent_2 {
  text-indent: 10px;
}

#kjyhsmuzpi .gt_indent_3 {
  text-indent: 15px;
}

#kjyhsmuzpi .gt_indent_4 {
  text-indent: 20px;
}

#kjyhsmuzpi .gt_indent_5 {
  text-indent: 25px;
}

#kjyhsmuzpi .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#kjyhsmuzpi div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="fotueasdzl" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#fotueasdzl table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#fotueasdzl thead, #fotueasdzl tbody, #fotueasdzl tfoot, #fotueasdzl tr, #fotueasdzl td, #fotueasdzl th {
  border-style: none;
}

#fotueasdzl p {
  margin: 0;
  padding: 0;
}

#fotueasdzl .gt_table {
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

#fotueasdzl .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#fotueasdzl .gt_title {
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

#fotueasdzl .gt_subtitle {
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

#fotueasdzl .gt_heading {
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

#fotueasdzl .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#fotueasdzl .gt_col_headings {
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

#fotueasdzl .gt_col_heading {
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

#fotueasdzl .gt_column_spanner_outer {
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

#fotueasdzl .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#fotueasdzl .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#fotueasdzl .gt_column_spanner {
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

#fotueasdzl .gt_spanner_row {
  border-bottom-style: hidden;
}

#fotueasdzl .gt_group_heading {
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

#fotueasdzl .gt_empty_group_heading {
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

#fotueasdzl .gt_from_md > :first-child {
  margin-top: 0;
}

#fotueasdzl .gt_from_md > :last-child {
  margin-bottom: 0;
}

#fotueasdzl .gt_row {
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

#fotueasdzl .gt_stub {
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

#fotueasdzl .gt_stub_row_group {
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

#fotueasdzl .gt_row_group_first td {
  border-top-width: 2px;
}

#fotueasdzl .gt_row_group_first th {
  border-top-width: 2px;
}

#fotueasdzl .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#fotueasdzl .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#fotueasdzl .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#fotueasdzl .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#fotueasdzl .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#fotueasdzl .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#fotueasdzl .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#fotueasdzl .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#fotueasdzl .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#fotueasdzl .gt_footnotes {
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

#fotueasdzl .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#fotueasdzl .gt_sourcenotes {
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

#fotueasdzl .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#fotueasdzl .gt_left {
  text-align: left;
}

#fotueasdzl .gt_center {
  text-align: center;
}

#fotueasdzl .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#fotueasdzl .gt_font_normal {
  font-weight: normal;
}

#fotueasdzl .gt_font_bold {
  font-weight: bold;
}

#fotueasdzl .gt_font_italic {
  font-style: italic;
}

#fotueasdzl .gt_super {
  font-size: 65%;
}

#fotueasdzl .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#fotueasdzl .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#fotueasdzl .gt_indent_1 {
  text-indent: 5px;
}

#fotueasdzl .gt_indent_2 {
  text-indent: 10px;
}

#fotueasdzl .gt_indent_3 {
  text-indent: 15px;
}

#fotueasdzl .gt_indent_4 {
  text-indent: 20px;
}

#fotueasdzl .gt_indent_5 {
  text-indent: 25px;
}

#fotueasdzl .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#fotueasdzl div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="gxzzjnxmya" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#gxzzjnxmya table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#gxzzjnxmya thead, #gxzzjnxmya tbody, #gxzzjnxmya tfoot, #gxzzjnxmya tr, #gxzzjnxmya td, #gxzzjnxmya th {
  border-style: none;
}

#gxzzjnxmya p {
  margin: 0;
  padding: 0;
}

#gxzzjnxmya .gt_table {
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

#gxzzjnxmya .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#gxzzjnxmya .gt_title {
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

#gxzzjnxmya .gt_subtitle {
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

#gxzzjnxmya .gt_heading {
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

#gxzzjnxmya .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#gxzzjnxmya .gt_col_headings {
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

#gxzzjnxmya .gt_col_heading {
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

#gxzzjnxmya .gt_column_spanner_outer {
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

#gxzzjnxmya .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#gxzzjnxmya .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#gxzzjnxmya .gt_column_spanner {
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

#gxzzjnxmya .gt_spanner_row {
  border-bottom-style: hidden;
}

#gxzzjnxmya .gt_group_heading {
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

#gxzzjnxmya .gt_empty_group_heading {
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

#gxzzjnxmya .gt_from_md > :first-child {
  margin-top: 0;
}

#gxzzjnxmya .gt_from_md > :last-child {
  margin-bottom: 0;
}

#gxzzjnxmya .gt_row {
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

#gxzzjnxmya .gt_stub {
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

#gxzzjnxmya .gt_stub_row_group {
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

#gxzzjnxmya .gt_row_group_first td {
  border-top-width: 2px;
}

#gxzzjnxmya .gt_row_group_first th {
  border-top-width: 2px;
}

#gxzzjnxmya .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#gxzzjnxmya .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#gxzzjnxmya .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#gxzzjnxmya .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#gxzzjnxmya .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#gxzzjnxmya .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#gxzzjnxmya .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#gxzzjnxmya .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#gxzzjnxmya .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#gxzzjnxmya .gt_footnotes {
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

#gxzzjnxmya .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#gxzzjnxmya .gt_sourcenotes {
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

#gxzzjnxmya .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#gxzzjnxmya .gt_left {
  text-align: left;
}

#gxzzjnxmya .gt_center {
  text-align: center;
}

#gxzzjnxmya .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#gxzzjnxmya .gt_font_normal {
  font-weight: normal;
}

#gxzzjnxmya .gt_font_bold {
  font-weight: bold;
}

#gxzzjnxmya .gt_font_italic {
  font-style: italic;
}

#gxzzjnxmya .gt_super {
  font-size: 65%;
}

#gxzzjnxmya .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#gxzzjnxmya .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#gxzzjnxmya .gt_indent_1 {
  text-indent: 5px;
}

#gxzzjnxmya .gt_indent_2 {
  text-indent: 10px;
}

#gxzzjnxmya .gt_indent_3 {
  text-indent: 15px;
}

#gxzzjnxmya .gt_indent_4 {
  text-indent: 20px;
}

#gxzzjnxmya .gt_indent_5 {
  text-indent: 25px;
}

#gxzzjnxmya .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#gxzzjnxmya div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="nlbtrtazkv" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#nlbtrtazkv table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#nlbtrtazkv thead, #nlbtrtazkv tbody, #nlbtrtazkv tfoot, #nlbtrtazkv tr, #nlbtrtazkv td, #nlbtrtazkv th {
  border-style: none;
}

#nlbtrtazkv p {
  margin: 0;
  padding: 0;
}

#nlbtrtazkv .gt_table {
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

#nlbtrtazkv .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#nlbtrtazkv .gt_title {
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

#nlbtrtazkv .gt_subtitle {
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

#nlbtrtazkv .gt_heading {
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

#nlbtrtazkv .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#nlbtrtazkv .gt_col_headings {
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

#nlbtrtazkv .gt_col_heading {
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

#nlbtrtazkv .gt_column_spanner_outer {
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

#nlbtrtazkv .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#nlbtrtazkv .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#nlbtrtazkv .gt_column_spanner {
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

#nlbtrtazkv .gt_spanner_row {
  border-bottom-style: hidden;
}

#nlbtrtazkv .gt_group_heading {
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

#nlbtrtazkv .gt_empty_group_heading {
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

#nlbtrtazkv .gt_from_md > :first-child {
  margin-top: 0;
}

#nlbtrtazkv .gt_from_md > :last-child {
  margin-bottom: 0;
}

#nlbtrtazkv .gt_row {
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

#nlbtrtazkv .gt_stub {
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

#nlbtrtazkv .gt_stub_row_group {
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

#nlbtrtazkv .gt_row_group_first td {
  border-top-width: 2px;
}

#nlbtrtazkv .gt_row_group_first th {
  border-top-width: 2px;
}

#nlbtrtazkv .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#nlbtrtazkv .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#nlbtrtazkv .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#nlbtrtazkv .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#nlbtrtazkv .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#nlbtrtazkv .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#nlbtrtazkv .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#nlbtrtazkv .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#nlbtrtazkv .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#nlbtrtazkv .gt_footnotes {
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

#nlbtrtazkv .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#nlbtrtazkv .gt_sourcenotes {
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

#nlbtrtazkv .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#nlbtrtazkv .gt_left {
  text-align: left;
}

#nlbtrtazkv .gt_center {
  text-align: center;
}

#nlbtrtazkv .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#nlbtrtazkv .gt_font_normal {
  font-weight: normal;
}

#nlbtrtazkv .gt_font_bold {
  font-weight: bold;
}

#nlbtrtazkv .gt_font_italic {
  font-style: italic;
}

#nlbtrtazkv .gt_super {
  font-size: 65%;
}

#nlbtrtazkv .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#nlbtrtazkv .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#nlbtrtazkv .gt_indent_1 {
  text-indent: 5px;
}

#nlbtrtazkv .gt_indent_2 {
  text-indent: 10px;
}

#nlbtrtazkv .gt_indent_3 {
  text-indent: 15px;
}

#nlbtrtazkv .gt_indent_4 {
  text-indent: 20px;
}

#nlbtrtazkv .gt_indent_5 {
  text-indent: 25px;
}

#nlbtrtazkv .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#nlbtrtazkv div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="fxbwzzkdvp" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#fxbwzzkdvp table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#fxbwzzkdvp thead, #fxbwzzkdvp tbody, #fxbwzzkdvp tfoot, #fxbwzzkdvp tr, #fxbwzzkdvp td, #fxbwzzkdvp th {
  border-style: none;
}

#fxbwzzkdvp p {
  margin: 0;
  padding: 0;
}

#fxbwzzkdvp .gt_table {
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

#fxbwzzkdvp .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#fxbwzzkdvp .gt_title {
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

#fxbwzzkdvp .gt_subtitle {
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

#fxbwzzkdvp .gt_heading {
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

#fxbwzzkdvp .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#fxbwzzkdvp .gt_col_headings {
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

#fxbwzzkdvp .gt_col_heading {
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

#fxbwzzkdvp .gt_column_spanner_outer {
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

#fxbwzzkdvp .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#fxbwzzkdvp .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#fxbwzzkdvp .gt_column_spanner {
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

#fxbwzzkdvp .gt_spanner_row {
  border-bottom-style: hidden;
}

#fxbwzzkdvp .gt_group_heading {
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

#fxbwzzkdvp .gt_empty_group_heading {
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

#fxbwzzkdvp .gt_from_md > :first-child {
  margin-top: 0;
}

#fxbwzzkdvp .gt_from_md > :last-child {
  margin-bottom: 0;
}

#fxbwzzkdvp .gt_row {
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

#fxbwzzkdvp .gt_stub {
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

#fxbwzzkdvp .gt_stub_row_group {
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

#fxbwzzkdvp .gt_row_group_first td {
  border-top-width: 2px;
}

#fxbwzzkdvp .gt_row_group_first th {
  border-top-width: 2px;
}

#fxbwzzkdvp .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#fxbwzzkdvp .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#fxbwzzkdvp .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#fxbwzzkdvp .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#fxbwzzkdvp .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#fxbwzzkdvp .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#fxbwzzkdvp .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#fxbwzzkdvp .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#fxbwzzkdvp .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#fxbwzzkdvp .gt_footnotes {
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

#fxbwzzkdvp .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#fxbwzzkdvp .gt_sourcenotes {
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

#fxbwzzkdvp .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#fxbwzzkdvp .gt_left {
  text-align: left;
}

#fxbwzzkdvp .gt_center {
  text-align: center;
}

#fxbwzzkdvp .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#fxbwzzkdvp .gt_font_normal {
  font-weight: normal;
}

#fxbwzzkdvp .gt_font_bold {
  font-weight: bold;
}

#fxbwzzkdvp .gt_font_italic {
  font-style: italic;
}

#fxbwzzkdvp .gt_super {
  font-size: 65%;
}

#fxbwzzkdvp .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#fxbwzzkdvp .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#fxbwzzkdvp .gt_indent_1 {
  text-indent: 5px;
}

#fxbwzzkdvp .gt_indent_2 {
  text-indent: 10px;
}

#fxbwzzkdvp .gt_indent_3 {
  text-indent: 15px;
}

#fxbwzzkdvp .gt_indent_4 {
  text-indent: 20px;
}

#fxbwzzkdvp .gt_indent_5 {
  text-indent: 25px;
}

#fxbwzzkdvp .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#fxbwzzkdvp div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="kwmsvordpx" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#kwmsvordpx table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#kwmsvordpx thead, #kwmsvordpx tbody, #kwmsvordpx tfoot, #kwmsvordpx tr, #kwmsvordpx td, #kwmsvordpx th {
  border-style: none;
}

#kwmsvordpx p {
  margin: 0;
  padding: 0;
}

#kwmsvordpx .gt_table {
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

#kwmsvordpx .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#kwmsvordpx .gt_title {
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

#kwmsvordpx .gt_subtitle {
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

#kwmsvordpx .gt_heading {
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

#kwmsvordpx .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#kwmsvordpx .gt_col_headings {
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

#kwmsvordpx .gt_col_heading {
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

#kwmsvordpx .gt_column_spanner_outer {
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

#kwmsvordpx .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#kwmsvordpx .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#kwmsvordpx .gt_column_spanner {
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

#kwmsvordpx .gt_spanner_row {
  border-bottom-style: hidden;
}

#kwmsvordpx .gt_group_heading {
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

#kwmsvordpx .gt_empty_group_heading {
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

#kwmsvordpx .gt_from_md > :first-child {
  margin-top: 0;
}

#kwmsvordpx .gt_from_md > :last-child {
  margin-bottom: 0;
}

#kwmsvordpx .gt_row {
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

#kwmsvordpx .gt_stub {
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

#kwmsvordpx .gt_stub_row_group {
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

#kwmsvordpx .gt_row_group_first td {
  border-top-width: 2px;
}

#kwmsvordpx .gt_row_group_first th {
  border-top-width: 2px;
}

#kwmsvordpx .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#kwmsvordpx .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#kwmsvordpx .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#kwmsvordpx .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#kwmsvordpx .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#kwmsvordpx .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#kwmsvordpx .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#kwmsvordpx .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#kwmsvordpx .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#kwmsvordpx .gt_footnotes {
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

#kwmsvordpx .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#kwmsvordpx .gt_sourcenotes {
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

#kwmsvordpx .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#kwmsvordpx .gt_left {
  text-align: left;
}

#kwmsvordpx .gt_center {
  text-align: center;
}

#kwmsvordpx .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#kwmsvordpx .gt_font_normal {
  font-weight: normal;
}

#kwmsvordpx .gt_font_bold {
  font-weight: bold;
}

#kwmsvordpx .gt_font_italic {
  font-style: italic;
}

#kwmsvordpx .gt_super {
  font-size: 65%;
}

#kwmsvordpx .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#kwmsvordpx .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#kwmsvordpx .gt_indent_1 {
  text-indent: 5px;
}

#kwmsvordpx .gt_indent_2 {
  text-indent: 10px;
}

#kwmsvordpx .gt_indent_3 {
  text-indent: 15px;
}

#kwmsvordpx .gt_indent_4 {
  text-indent: 20px;
}

#kwmsvordpx .gt_indent_5 {
  text-indent: 25px;
}

#kwmsvordpx .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#kwmsvordpx div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="vnnebskezu" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#vnnebskezu table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#vnnebskezu thead, #vnnebskezu tbody, #vnnebskezu tfoot, #vnnebskezu tr, #vnnebskezu td, #vnnebskezu th {
  border-style: none;
}

#vnnebskezu p {
  margin: 0;
  padding: 0;
}

#vnnebskezu .gt_table {
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

#vnnebskezu .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#vnnebskezu .gt_title {
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

#vnnebskezu .gt_subtitle {
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

#vnnebskezu .gt_heading {
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

#vnnebskezu .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#vnnebskezu .gt_col_headings {
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

#vnnebskezu .gt_col_heading {
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

#vnnebskezu .gt_column_spanner_outer {
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

#vnnebskezu .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#vnnebskezu .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#vnnebskezu .gt_column_spanner {
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

#vnnebskezu .gt_spanner_row {
  border-bottom-style: hidden;
}

#vnnebskezu .gt_group_heading {
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

#vnnebskezu .gt_empty_group_heading {
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

#vnnebskezu .gt_from_md > :first-child {
  margin-top: 0;
}

#vnnebskezu .gt_from_md > :last-child {
  margin-bottom: 0;
}

#vnnebskezu .gt_row {
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

#vnnebskezu .gt_stub {
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

#vnnebskezu .gt_stub_row_group {
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

#vnnebskezu .gt_row_group_first td {
  border-top-width: 2px;
}

#vnnebskezu .gt_row_group_first th {
  border-top-width: 2px;
}

#vnnebskezu .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#vnnebskezu .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#vnnebskezu .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#vnnebskezu .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#vnnebskezu .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#vnnebskezu .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#vnnebskezu .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#vnnebskezu .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#vnnebskezu .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#vnnebskezu .gt_footnotes {
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

#vnnebskezu .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#vnnebskezu .gt_sourcenotes {
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

#vnnebskezu .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#vnnebskezu .gt_left {
  text-align: left;
}

#vnnebskezu .gt_center {
  text-align: center;
}

#vnnebskezu .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#vnnebskezu .gt_font_normal {
  font-weight: normal;
}

#vnnebskezu .gt_font_bold {
  font-weight: bold;
}

#vnnebskezu .gt_font_italic {
  font-style: italic;
}

#vnnebskezu .gt_super {
  font-size: 65%;
}

#vnnebskezu .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#vnnebskezu .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#vnnebskezu .gt_indent_1 {
  text-indent: 5px;
}

#vnnebskezu .gt_indent_2 {
  text-indent: 10px;
}

#vnnebskezu .gt_indent_3 {
  text-indent: 15px;
}

#vnnebskezu .gt_indent_4 {
  text-indent: 20px;
}

#vnnebskezu .gt_indent_5 {
  text-indent: 25px;
}

#vnnebskezu .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#vnnebskezu div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="laiotgbhpg" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#laiotgbhpg table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#laiotgbhpg thead, #laiotgbhpg tbody, #laiotgbhpg tfoot, #laiotgbhpg tr, #laiotgbhpg td, #laiotgbhpg th {
  border-style: none;
}

#laiotgbhpg p {
  margin: 0;
  padding: 0;
}

#laiotgbhpg .gt_table {
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

#laiotgbhpg .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#laiotgbhpg .gt_title {
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

#laiotgbhpg .gt_subtitle {
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

#laiotgbhpg .gt_heading {
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

#laiotgbhpg .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#laiotgbhpg .gt_col_headings {
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

#laiotgbhpg .gt_col_heading {
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

#laiotgbhpg .gt_column_spanner_outer {
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

#laiotgbhpg .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#laiotgbhpg .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#laiotgbhpg .gt_column_spanner {
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

#laiotgbhpg .gt_spanner_row {
  border-bottom-style: hidden;
}

#laiotgbhpg .gt_group_heading {
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

#laiotgbhpg .gt_empty_group_heading {
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

#laiotgbhpg .gt_from_md > :first-child {
  margin-top: 0;
}

#laiotgbhpg .gt_from_md > :last-child {
  margin-bottom: 0;
}

#laiotgbhpg .gt_row {
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

#laiotgbhpg .gt_stub {
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

#laiotgbhpg .gt_stub_row_group {
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

#laiotgbhpg .gt_row_group_first td {
  border-top-width: 2px;
}

#laiotgbhpg .gt_row_group_first th {
  border-top-width: 2px;
}

#laiotgbhpg .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#laiotgbhpg .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#laiotgbhpg .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#laiotgbhpg .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#laiotgbhpg .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#laiotgbhpg .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#laiotgbhpg .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#laiotgbhpg .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#laiotgbhpg .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#laiotgbhpg .gt_footnotes {
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

#laiotgbhpg .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#laiotgbhpg .gt_sourcenotes {
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

#laiotgbhpg .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#laiotgbhpg .gt_left {
  text-align: left;
}

#laiotgbhpg .gt_center {
  text-align: center;
}

#laiotgbhpg .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#laiotgbhpg .gt_font_normal {
  font-weight: normal;
}

#laiotgbhpg .gt_font_bold {
  font-weight: bold;
}

#laiotgbhpg .gt_font_italic {
  font-style: italic;
}

#laiotgbhpg .gt_super {
  font-size: 65%;
}

#laiotgbhpg .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#laiotgbhpg .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#laiotgbhpg .gt_indent_1 {
  text-indent: 5px;
}

#laiotgbhpg .gt_indent_2 {
  text-indent: 10px;
}

#laiotgbhpg .gt_indent_3 {
  text-indent: 15px;
}

#laiotgbhpg .gt_indent_4 {
  text-indent: 20px;
}

#laiotgbhpg .gt_indent_5 {
  text-indent: 25px;
}

#laiotgbhpg .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#laiotgbhpg div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="kixiwcyycr" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#kixiwcyycr table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#kixiwcyycr thead, #kixiwcyycr tbody, #kixiwcyycr tfoot, #kixiwcyycr tr, #kixiwcyycr td, #kixiwcyycr th {
  border-style: none;
}

#kixiwcyycr p {
  margin: 0;
  padding: 0;
}

#kixiwcyycr .gt_table {
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

#kixiwcyycr .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#kixiwcyycr .gt_title {
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

#kixiwcyycr .gt_subtitle {
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

#kixiwcyycr .gt_heading {
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

#kixiwcyycr .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#kixiwcyycr .gt_col_headings {
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

#kixiwcyycr .gt_col_heading {
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

#kixiwcyycr .gt_column_spanner_outer {
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

#kixiwcyycr .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#kixiwcyycr .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#kixiwcyycr .gt_column_spanner {
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

#kixiwcyycr .gt_spanner_row {
  border-bottom-style: hidden;
}

#kixiwcyycr .gt_group_heading {
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

#kixiwcyycr .gt_empty_group_heading {
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

#kixiwcyycr .gt_from_md > :first-child {
  margin-top: 0;
}

#kixiwcyycr .gt_from_md > :last-child {
  margin-bottom: 0;
}

#kixiwcyycr .gt_row {
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

#kixiwcyycr .gt_stub {
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

#kixiwcyycr .gt_stub_row_group {
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

#kixiwcyycr .gt_row_group_first td {
  border-top-width: 2px;
}

#kixiwcyycr .gt_row_group_first th {
  border-top-width: 2px;
}

#kixiwcyycr .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#kixiwcyycr .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#kixiwcyycr .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#kixiwcyycr .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#kixiwcyycr .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#kixiwcyycr .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#kixiwcyycr .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#kixiwcyycr .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#kixiwcyycr .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#kixiwcyycr .gt_footnotes {
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

#kixiwcyycr .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#kixiwcyycr .gt_sourcenotes {
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

#kixiwcyycr .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#kixiwcyycr .gt_left {
  text-align: left;
}

#kixiwcyycr .gt_center {
  text-align: center;
}

#kixiwcyycr .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#kixiwcyycr .gt_font_normal {
  font-weight: normal;
}

#kixiwcyycr .gt_font_bold {
  font-weight: bold;
}

#kixiwcyycr .gt_font_italic {
  font-style: italic;
}

#kixiwcyycr .gt_super {
  font-size: 65%;
}

#kixiwcyycr .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#kixiwcyycr .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#kixiwcyycr .gt_indent_1 {
  text-indent: 5px;
}

#kixiwcyycr .gt_indent_2 {
  text-indent: 10px;
}

#kixiwcyycr .gt_indent_3 {
  text-indent: 15px;
}

#kixiwcyycr .gt_indent_4 {
  text-indent: 20px;
}

#kixiwcyycr .gt_indent_5 {
  text-indent: 25px;
}

#kixiwcyycr .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#kixiwcyycr div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="lxbrasflla" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#lxbrasflla table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#lxbrasflla thead, #lxbrasflla tbody, #lxbrasflla tfoot, #lxbrasflla tr, #lxbrasflla td, #lxbrasflla th {
  border-style: none;
}

#lxbrasflla p {
  margin: 0;
  padding: 0;
}

#lxbrasflla .gt_table {
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

#lxbrasflla .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#lxbrasflla .gt_title {
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

#lxbrasflla .gt_subtitle {
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

#lxbrasflla .gt_heading {
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

#lxbrasflla .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#lxbrasflla .gt_col_headings {
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

#lxbrasflla .gt_col_heading {
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

#lxbrasflla .gt_column_spanner_outer {
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

#lxbrasflla .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#lxbrasflla .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#lxbrasflla .gt_column_spanner {
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

#lxbrasflla .gt_spanner_row {
  border-bottom-style: hidden;
}

#lxbrasflla .gt_group_heading {
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

#lxbrasflla .gt_empty_group_heading {
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

#lxbrasflla .gt_from_md > :first-child {
  margin-top: 0;
}

#lxbrasflla .gt_from_md > :last-child {
  margin-bottom: 0;
}

#lxbrasflla .gt_row {
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

#lxbrasflla .gt_stub {
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

#lxbrasflla .gt_stub_row_group {
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

#lxbrasflla .gt_row_group_first td {
  border-top-width: 2px;
}

#lxbrasflla .gt_row_group_first th {
  border-top-width: 2px;
}

#lxbrasflla .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#lxbrasflla .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#lxbrasflla .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#lxbrasflla .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#lxbrasflla .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#lxbrasflla .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#lxbrasflla .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#lxbrasflla .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#lxbrasflla .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#lxbrasflla .gt_footnotes {
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

#lxbrasflla .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#lxbrasflla .gt_sourcenotes {
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

#lxbrasflla .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#lxbrasflla .gt_left {
  text-align: left;
}

#lxbrasflla .gt_center {
  text-align: center;
}

#lxbrasflla .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#lxbrasflla .gt_font_normal {
  font-weight: normal;
}

#lxbrasflla .gt_font_bold {
  font-weight: bold;
}

#lxbrasflla .gt_font_italic {
  font-style: italic;
}

#lxbrasflla .gt_super {
  font-size: 65%;
}

#lxbrasflla .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#lxbrasflla .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#lxbrasflla .gt_indent_1 {
  text-indent: 5px;
}

#lxbrasflla .gt_indent_2 {
  text-indent: 10px;
}

#lxbrasflla .gt_indent_3 {
  text-indent: 15px;
}

#lxbrasflla .gt_indent_4 {
  text-indent: 20px;
}

#lxbrasflla .gt_indent_5 {
  text-indent: 25px;
}

#lxbrasflla .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#lxbrasflla div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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

