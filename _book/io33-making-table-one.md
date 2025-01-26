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
## $ case        <int> 110754, 99706, 105271, 105001, 112263,…
## $ age         <int> 67, 74, 50, 71, 69, 56, 50, 57, 51, 63…
## $ arm         <chr> "F: FOLFOX", "A: IFL", "A: IFL", "G: I…
## $ sex         <fct> Male, Female, Female, Female, Female, …
## $ race        <chr> "Caucasian", "Caucasian", "Caucasian",…
## $ fu.time     <int> 922, 270, 175, 128, 233, 120, 369, 421…
## $ fu.stat     <int> 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,…
## $ ps          <int> 0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 1,…
## $ hgb         <dbl> 11.5, 10.7, 11.1, 12.6, 13.0, 10.2, 13…
## $ bmi         <dbl> 25.09861, 19.49786, NA, 29.42922, 26.3…
## $ alk.phos    <int> 160, 290, 700, 771, 350, 569, 162, 152…
## $ ast         <int> 35, 52, 100, 68, 35, 27, 16, 12, 25, 1…
## $ mdquality.s <int> NA, 1, 1, 1, NA, 1, 1, 1, 1, 1, NA, NA…
## $ age.ord     <ord> 60-69, 70-79, 40-49, 70-79, 60-69, 50-…
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
<div id="kuodhxojog" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#kuodhxojog table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#kuodhxojog thead, #kuodhxojog tbody, #kuodhxojog tfoot, #kuodhxojog tr, #kuodhxojog td, #kuodhxojog th {
  border-style: none;
}

#kuodhxojog p {
  margin: 0;
  padding: 0;
}

#kuodhxojog .gt_table {
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

#kuodhxojog .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#kuodhxojog .gt_title {
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

#kuodhxojog .gt_subtitle {
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

#kuodhxojog .gt_heading {
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

#kuodhxojog .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#kuodhxojog .gt_col_headings {
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

#kuodhxojog .gt_col_heading {
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

#kuodhxojog .gt_column_spanner_outer {
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

#kuodhxojog .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#kuodhxojog .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#kuodhxojog .gt_column_spanner {
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

#kuodhxojog .gt_spanner_row {
  border-bottom-style: hidden;
}

#kuodhxojog .gt_group_heading {
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

#kuodhxojog .gt_empty_group_heading {
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

#kuodhxojog .gt_from_md > :first-child {
  margin-top: 0;
}

#kuodhxojog .gt_from_md > :last-child {
  margin-bottom: 0;
}

#kuodhxojog .gt_row {
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

#kuodhxojog .gt_stub {
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

#kuodhxojog .gt_stub_row_group {
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

#kuodhxojog .gt_row_group_first td {
  border-top-width: 2px;
}

#kuodhxojog .gt_row_group_first th {
  border-top-width: 2px;
}

#kuodhxojog .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#kuodhxojog .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#kuodhxojog .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#kuodhxojog .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#kuodhxojog .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#kuodhxojog .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#kuodhxojog .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#kuodhxojog .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#kuodhxojog .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#kuodhxojog .gt_footnotes {
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

#kuodhxojog .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#kuodhxojog .gt_sourcenotes {
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

#kuodhxojog .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#kuodhxojog .gt_left {
  text-align: left;
}

#kuodhxojog .gt_center {
  text-align: center;
}

#kuodhxojog .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#kuodhxojog .gt_font_normal {
  font-weight: normal;
}

#kuodhxojog .gt_font_bold {
  font-weight: bold;
}

#kuodhxojog .gt_font_italic {
  font-style: italic;
}

#kuodhxojog .gt_super {
  font-size: 65%;
}

#kuodhxojog .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#kuodhxojog .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#kuodhxojog .gt_indent_1 {
  text-indent: 5px;
}

#kuodhxojog .gt_indent_2 {
  text-indent: 10px;
}

#kuodhxojog .gt_indent_3 {
  text-indent: 15px;
}

#kuodhxojog .gt_indent_4 {
  text-indent: 20px;
}

#kuodhxojog .gt_indent_5 {
  text-indent: 25px;
}

#kuodhxojog .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#kuodhxojog div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="ndxyfivyuw" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#ndxyfivyuw table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#ndxyfivyuw thead, #ndxyfivyuw tbody, #ndxyfivyuw tfoot, #ndxyfivyuw tr, #ndxyfivyuw td, #ndxyfivyuw th {
  border-style: none;
}

#ndxyfivyuw p {
  margin: 0;
  padding: 0;
}

#ndxyfivyuw .gt_table {
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

#ndxyfivyuw .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#ndxyfivyuw .gt_title {
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

#ndxyfivyuw .gt_subtitle {
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

#ndxyfivyuw .gt_heading {
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

#ndxyfivyuw .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ndxyfivyuw .gt_col_headings {
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

#ndxyfivyuw .gt_col_heading {
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

#ndxyfivyuw .gt_column_spanner_outer {
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

#ndxyfivyuw .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#ndxyfivyuw .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#ndxyfivyuw .gt_column_spanner {
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

#ndxyfivyuw .gt_spanner_row {
  border-bottom-style: hidden;
}

#ndxyfivyuw .gt_group_heading {
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

#ndxyfivyuw .gt_empty_group_heading {
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

#ndxyfivyuw .gt_from_md > :first-child {
  margin-top: 0;
}

#ndxyfivyuw .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ndxyfivyuw .gt_row {
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

#ndxyfivyuw .gt_stub {
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

#ndxyfivyuw .gt_stub_row_group {
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

#ndxyfivyuw .gt_row_group_first td {
  border-top-width: 2px;
}

#ndxyfivyuw .gt_row_group_first th {
  border-top-width: 2px;
}

#ndxyfivyuw .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ndxyfivyuw .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#ndxyfivyuw .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#ndxyfivyuw .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ndxyfivyuw .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ndxyfivyuw .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#ndxyfivyuw .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#ndxyfivyuw .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#ndxyfivyuw .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ndxyfivyuw .gt_footnotes {
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

#ndxyfivyuw .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ndxyfivyuw .gt_sourcenotes {
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

#ndxyfivyuw .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ndxyfivyuw .gt_left {
  text-align: left;
}

#ndxyfivyuw .gt_center {
  text-align: center;
}

#ndxyfivyuw .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ndxyfivyuw .gt_font_normal {
  font-weight: normal;
}

#ndxyfivyuw .gt_font_bold {
  font-weight: bold;
}

#ndxyfivyuw .gt_font_italic {
  font-style: italic;
}

#ndxyfivyuw .gt_super {
  font-size: 65%;
}

#ndxyfivyuw .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#ndxyfivyuw .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#ndxyfivyuw .gt_indent_1 {
  text-indent: 5px;
}

#ndxyfivyuw .gt_indent_2 {
  text-indent: 10px;
}

#ndxyfivyuw .gt_indent_3 {
  text-indent: 15px;
}

#ndxyfivyuw .gt_indent_4 {
  text-indent: 20px;
}

#ndxyfivyuw .gt_indent_5 {
  text-indent: 25px;
}

#ndxyfivyuw .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#ndxyfivyuw div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="yiosqsqhhl" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#yiosqsqhhl table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#yiosqsqhhl thead, #yiosqsqhhl tbody, #yiosqsqhhl tfoot, #yiosqsqhhl tr, #yiosqsqhhl td, #yiosqsqhhl th {
  border-style: none;
}

#yiosqsqhhl p {
  margin: 0;
  padding: 0;
}

#yiosqsqhhl .gt_table {
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

#yiosqsqhhl .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#yiosqsqhhl .gt_title {
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

#yiosqsqhhl .gt_subtitle {
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

#yiosqsqhhl .gt_heading {
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

#yiosqsqhhl .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#yiosqsqhhl .gt_col_headings {
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

#yiosqsqhhl .gt_col_heading {
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

#yiosqsqhhl .gt_column_spanner_outer {
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

#yiosqsqhhl .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#yiosqsqhhl .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#yiosqsqhhl .gt_column_spanner {
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

#yiosqsqhhl .gt_spanner_row {
  border-bottom-style: hidden;
}

#yiosqsqhhl .gt_group_heading {
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

#yiosqsqhhl .gt_empty_group_heading {
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

#yiosqsqhhl .gt_from_md > :first-child {
  margin-top: 0;
}

#yiosqsqhhl .gt_from_md > :last-child {
  margin-bottom: 0;
}

#yiosqsqhhl .gt_row {
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

#yiosqsqhhl .gt_stub {
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

#yiosqsqhhl .gt_stub_row_group {
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

#yiosqsqhhl .gt_row_group_first td {
  border-top-width: 2px;
}

#yiosqsqhhl .gt_row_group_first th {
  border-top-width: 2px;
}

#yiosqsqhhl .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#yiosqsqhhl .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#yiosqsqhhl .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#yiosqsqhhl .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#yiosqsqhhl .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#yiosqsqhhl .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#yiosqsqhhl .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#yiosqsqhhl .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#yiosqsqhhl .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#yiosqsqhhl .gt_footnotes {
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

#yiosqsqhhl .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#yiosqsqhhl .gt_sourcenotes {
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

#yiosqsqhhl .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#yiosqsqhhl .gt_left {
  text-align: left;
}

#yiosqsqhhl .gt_center {
  text-align: center;
}

#yiosqsqhhl .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#yiosqsqhhl .gt_font_normal {
  font-weight: normal;
}

#yiosqsqhhl .gt_font_bold {
  font-weight: bold;
}

#yiosqsqhhl .gt_font_italic {
  font-style: italic;
}

#yiosqsqhhl .gt_super {
  font-size: 65%;
}

#yiosqsqhhl .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#yiosqsqhhl .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#yiosqsqhhl .gt_indent_1 {
  text-indent: 5px;
}

#yiosqsqhhl .gt_indent_2 {
  text-indent: 10px;
}

#yiosqsqhhl .gt_indent_3 {
  text-indent: 15px;
}

#yiosqsqhhl .gt_indent_4 {
  text-indent: 20px;
}

#yiosqsqhhl .gt_indent_5 {
  text-indent: 25px;
}

#yiosqsqhhl .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#yiosqsqhhl div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="labhdjkepc" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#labhdjkepc table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#labhdjkepc thead, #labhdjkepc tbody, #labhdjkepc tfoot, #labhdjkepc tr, #labhdjkepc td, #labhdjkepc th {
  border-style: none;
}

#labhdjkepc p {
  margin: 0;
  padding: 0;
}

#labhdjkepc .gt_table {
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

#labhdjkepc .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#labhdjkepc .gt_title {
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

#labhdjkepc .gt_subtitle {
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

#labhdjkepc .gt_heading {
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

#labhdjkepc .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#labhdjkepc .gt_col_headings {
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

#labhdjkepc .gt_col_heading {
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

#labhdjkepc .gt_column_spanner_outer {
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

#labhdjkepc .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#labhdjkepc .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#labhdjkepc .gt_column_spanner {
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

#labhdjkepc .gt_spanner_row {
  border-bottom-style: hidden;
}

#labhdjkepc .gt_group_heading {
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

#labhdjkepc .gt_empty_group_heading {
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

#labhdjkepc .gt_from_md > :first-child {
  margin-top: 0;
}

#labhdjkepc .gt_from_md > :last-child {
  margin-bottom: 0;
}

#labhdjkepc .gt_row {
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

#labhdjkepc .gt_stub {
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

#labhdjkepc .gt_stub_row_group {
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

#labhdjkepc .gt_row_group_first td {
  border-top-width: 2px;
}

#labhdjkepc .gt_row_group_first th {
  border-top-width: 2px;
}

#labhdjkepc .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#labhdjkepc .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#labhdjkepc .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#labhdjkepc .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#labhdjkepc .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#labhdjkepc .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#labhdjkepc .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#labhdjkepc .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#labhdjkepc .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#labhdjkepc .gt_footnotes {
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

#labhdjkepc .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#labhdjkepc .gt_sourcenotes {
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

#labhdjkepc .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#labhdjkepc .gt_left {
  text-align: left;
}

#labhdjkepc .gt_center {
  text-align: center;
}

#labhdjkepc .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#labhdjkepc .gt_font_normal {
  font-weight: normal;
}

#labhdjkepc .gt_font_bold {
  font-weight: bold;
}

#labhdjkepc .gt_font_italic {
  font-style: italic;
}

#labhdjkepc .gt_super {
  font-size: 65%;
}

#labhdjkepc .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#labhdjkepc .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#labhdjkepc .gt_indent_1 {
  text-indent: 5px;
}

#labhdjkepc .gt_indent_2 {
  text-indent: 10px;
}

#labhdjkepc .gt_indent_3 {
  text-indent: 15px;
}

#labhdjkepc .gt_indent_4 {
  text-indent: 20px;
}

#labhdjkepc .gt_indent_5 {
  text-indent: 25px;
}

#labhdjkepc .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#labhdjkepc div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="uioxqwiexq" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#uioxqwiexq table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#uioxqwiexq thead, #uioxqwiexq tbody, #uioxqwiexq tfoot, #uioxqwiexq tr, #uioxqwiexq td, #uioxqwiexq th {
  border-style: none;
}

#uioxqwiexq p {
  margin: 0;
  padding: 0;
}

#uioxqwiexq .gt_table {
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

#uioxqwiexq .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#uioxqwiexq .gt_title {
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

#uioxqwiexq .gt_subtitle {
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

#uioxqwiexq .gt_heading {
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

#uioxqwiexq .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#uioxqwiexq .gt_col_headings {
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

#uioxqwiexq .gt_col_heading {
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

#uioxqwiexq .gt_column_spanner_outer {
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

#uioxqwiexq .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#uioxqwiexq .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#uioxqwiexq .gt_column_spanner {
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

#uioxqwiexq .gt_spanner_row {
  border-bottom-style: hidden;
}

#uioxqwiexq .gt_group_heading {
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

#uioxqwiexq .gt_empty_group_heading {
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

#uioxqwiexq .gt_from_md > :first-child {
  margin-top: 0;
}

#uioxqwiexq .gt_from_md > :last-child {
  margin-bottom: 0;
}

#uioxqwiexq .gt_row {
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

#uioxqwiexq .gt_stub {
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

#uioxqwiexq .gt_stub_row_group {
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

#uioxqwiexq .gt_row_group_first td {
  border-top-width: 2px;
}

#uioxqwiexq .gt_row_group_first th {
  border-top-width: 2px;
}

#uioxqwiexq .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#uioxqwiexq .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#uioxqwiexq .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#uioxqwiexq .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#uioxqwiexq .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#uioxqwiexq .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#uioxqwiexq .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#uioxqwiexq .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#uioxqwiexq .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#uioxqwiexq .gt_footnotes {
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

#uioxqwiexq .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#uioxqwiexq .gt_sourcenotes {
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

#uioxqwiexq .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#uioxqwiexq .gt_left {
  text-align: left;
}

#uioxqwiexq .gt_center {
  text-align: center;
}

#uioxqwiexq .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#uioxqwiexq .gt_font_normal {
  font-weight: normal;
}

#uioxqwiexq .gt_font_bold {
  font-weight: bold;
}

#uioxqwiexq .gt_font_italic {
  font-style: italic;
}

#uioxqwiexq .gt_super {
  font-size: 65%;
}

#uioxqwiexq .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#uioxqwiexq .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#uioxqwiexq .gt_indent_1 {
  text-indent: 5px;
}

#uioxqwiexq .gt_indent_2 {
  text-indent: 10px;
}

#uioxqwiexq .gt_indent_3 {
  text-indent: 15px;
}

#uioxqwiexq .gt_indent_4 {
  text-indent: 20px;
}

#uioxqwiexq .gt_indent_5 {
  text-indent: 25px;
}

#uioxqwiexq .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#uioxqwiexq div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="ainvephbsw" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#ainvephbsw table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#ainvephbsw thead, #ainvephbsw tbody, #ainvephbsw tfoot, #ainvephbsw tr, #ainvephbsw td, #ainvephbsw th {
  border-style: none;
}

#ainvephbsw p {
  margin: 0;
  padding: 0;
}

#ainvephbsw .gt_table {
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

#ainvephbsw .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#ainvephbsw .gt_title {
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

#ainvephbsw .gt_subtitle {
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

#ainvephbsw .gt_heading {
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

#ainvephbsw .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ainvephbsw .gt_col_headings {
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

#ainvephbsw .gt_col_heading {
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

#ainvephbsw .gt_column_spanner_outer {
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

#ainvephbsw .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#ainvephbsw .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#ainvephbsw .gt_column_spanner {
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

#ainvephbsw .gt_spanner_row {
  border-bottom-style: hidden;
}

#ainvephbsw .gt_group_heading {
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

#ainvephbsw .gt_empty_group_heading {
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

#ainvephbsw .gt_from_md > :first-child {
  margin-top: 0;
}

#ainvephbsw .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ainvephbsw .gt_row {
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

#ainvephbsw .gt_stub {
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

#ainvephbsw .gt_stub_row_group {
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

#ainvephbsw .gt_row_group_first td {
  border-top-width: 2px;
}

#ainvephbsw .gt_row_group_first th {
  border-top-width: 2px;
}

#ainvephbsw .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ainvephbsw .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#ainvephbsw .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#ainvephbsw .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ainvephbsw .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ainvephbsw .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#ainvephbsw .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#ainvephbsw .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#ainvephbsw .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ainvephbsw .gt_footnotes {
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

#ainvephbsw .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ainvephbsw .gt_sourcenotes {
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

#ainvephbsw .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ainvephbsw .gt_left {
  text-align: left;
}

#ainvephbsw .gt_center {
  text-align: center;
}

#ainvephbsw .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ainvephbsw .gt_font_normal {
  font-weight: normal;
}

#ainvephbsw .gt_font_bold {
  font-weight: bold;
}

#ainvephbsw .gt_font_italic {
  font-style: italic;
}

#ainvephbsw .gt_super {
  font-size: 65%;
}

#ainvephbsw .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#ainvephbsw .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#ainvephbsw .gt_indent_1 {
  text-indent: 5px;
}

#ainvephbsw .gt_indent_2 {
  text-indent: 10px;
}

#ainvephbsw .gt_indent_3 {
  text-indent: 15px;
}

#ainvephbsw .gt_indent_4 {
  text-indent: 20px;
}

#ainvephbsw .gt_indent_5 {
  text-indent: 25px;
}

#ainvephbsw .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#ainvephbsw div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="3" scope="colgroup" id="**Treatment Received**">
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
## * These values may be dynamically placed into headers (and
## other locations).
## ℹ Review the `modify_header()`
##   (`?gtsummary::modify_header()`) help for examples.
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
## Warning: The `update` argument of `modify_header()` is deprecated as
## of gtsummary 2.0.0.
## ℹ Use `modify_header(...)` input instead. Dynamic dots
##   allow for syntax like `modify_header(!!!list(...))`.
## ℹ The deprecated feature was likely used in the gtsummary
##   package.
##   Please report the issue at
##   <https://github.com/ddsjoberg/gtsummary/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where
## this warning was generated.
```

```{=html}
<div id="rmeeehkkbz" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#rmeeehkkbz table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#rmeeehkkbz thead, #rmeeehkkbz tbody, #rmeeehkkbz tfoot, #rmeeehkkbz tr, #rmeeehkkbz td, #rmeeehkkbz th {
  border-style: none;
}

#rmeeehkkbz p {
  margin: 0;
  padding: 0;
}

#rmeeehkkbz .gt_table {
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

#rmeeehkkbz .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#rmeeehkkbz .gt_title {
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

#rmeeehkkbz .gt_subtitle {
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

#rmeeehkkbz .gt_heading {
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

#rmeeehkkbz .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#rmeeehkkbz .gt_col_headings {
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

#rmeeehkkbz .gt_col_heading {
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

#rmeeehkkbz .gt_column_spanner_outer {
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

#rmeeehkkbz .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#rmeeehkkbz .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#rmeeehkkbz .gt_column_spanner {
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

#rmeeehkkbz .gt_spanner_row {
  border-bottom-style: hidden;
}

#rmeeehkkbz .gt_group_heading {
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

#rmeeehkkbz .gt_empty_group_heading {
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

#rmeeehkkbz .gt_from_md > :first-child {
  margin-top: 0;
}

#rmeeehkkbz .gt_from_md > :last-child {
  margin-bottom: 0;
}

#rmeeehkkbz .gt_row {
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

#rmeeehkkbz .gt_stub {
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

#rmeeehkkbz .gt_stub_row_group {
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

#rmeeehkkbz .gt_row_group_first td {
  border-top-width: 2px;
}

#rmeeehkkbz .gt_row_group_first th {
  border-top-width: 2px;
}

#rmeeehkkbz .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#rmeeehkkbz .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#rmeeehkkbz .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#rmeeehkkbz .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#rmeeehkkbz .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#rmeeehkkbz .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#rmeeehkkbz .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#rmeeehkkbz .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#rmeeehkkbz .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#rmeeehkkbz .gt_footnotes {
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

#rmeeehkkbz .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#rmeeehkkbz .gt_sourcenotes {
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

#rmeeehkkbz .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#rmeeehkkbz .gt_left {
  text-align: left;
}

#rmeeehkkbz .gt_center {
  text-align: center;
}

#rmeeehkkbz .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#rmeeehkkbz .gt_font_normal {
  font-weight: normal;
}

#rmeeehkkbz .gt_font_bold {
  font-weight: bold;
}

#rmeeehkkbz .gt_font_italic {
  font-style: italic;
}

#rmeeehkkbz .gt_super {
  font-size: 65%;
}

#rmeeehkkbz .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#rmeeehkkbz .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#rmeeehkkbz .gt_indent_1 {
  text-indent: 5px;
}

#rmeeehkkbz .gt_indent_2 {
  text-indent: 10px;
}

#rmeeehkkbz .gt_indent_3 {
  text-indent: 15px;
}

#rmeeehkkbz .gt_indent_4 {
  text-indent: 20px;
}

#rmeeehkkbz .gt_indent_5 {
  text-indent: 25px;
}

#rmeeehkkbz .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#rmeeehkkbz div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Characteristic</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="n"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="stat_0"><span class='gt_from_md'><strong>Overall</strong><br>N = 1,499</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="3" scope="colgroup" id="**Treatment Received**">
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
<div id="honbemtyor" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#honbemtyor table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#honbemtyor thead, #honbemtyor tbody, #honbemtyor tfoot, #honbemtyor tr, #honbemtyor td, #honbemtyor th {
  border-style: none;
}

#honbemtyor p {
  margin: 0;
  padding: 0;
}

#honbemtyor .gt_table {
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

#honbemtyor .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#honbemtyor .gt_title {
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

#honbemtyor .gt_subtitle {
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

#honbemtyor .gt_heading {
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

#honbemtyor .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#honbemtyor .gt_col_headings {
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

#honbemtyor .gt_col_heading {
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

#honbemtyor .gt_column_spanner_outer {
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

#honbemtyor .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#honbemtyor .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#honbemtyor .gt_column_spanner {
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

#honbemtyor .gt_spanner_row {
  border-bottom-style: hidden;
}

#honbemtyor .gt_group_heading {
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

#honbemtyor .gt_empty_group_heading {
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

#honbemtyor .gt_from_md > :first-child {
  margin-top: 0;
}

#honbemtyor .gt_from_md > :last-child {
  margin-bottom: 0;
}

#honbemtyor .gt_row {
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

#honbemtyor .gt_stub {
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

#honbemtyor .gt_stub_row_group {
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

#honbemtyor .gt_row_group_first td {
  border-top-width: 2px;
}

#honbemtyor .gt_row_group_first th {
  border-top-width: 2px;
}

#honbemtyor .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#honbemtyor .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#honbemtyor .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#honbemtyor .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#honbemtyor .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#honbemtyor .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#honbemtyor .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#honbemtyor .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#honbemtyor .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#honbemtyor .gt_footnotes {
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

#honbemtyor .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#honbemtyor .gt_sourcenotes {
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

#honbemtyor .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#honbemtyor .gt_left {
  text-align: left;
}

#honbemtyor .gt_center {
  text-align: center;
}

#honbemtyor .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#honbemtyor .gt_font_normal {
  font-weight: normal;
}

#honbemtyor .gt_font_bold {
  font-weight: bold;
}

#honbemtyor .gt_font_italic {
  font-style: italic;
}

#honbemtyor .gt_super {
  font-size: 65%;
}

#honbemtyor .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#honbemtyor .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#honbemtyor .gt_indent_1 {
  text-indent: 5px;
}

#honbemtyor .gt_indent_2 {
  text-indent: 10px;
}

#honbemtyor .gt_indent_3 {
  text-indent: 15px;
}

#honbemtyor .gt_indent_4 {
  text-indent: 20px;
}

#honbemtyor .gt_indent_5 {
  text-indent: 25px;
}

#honbemtyor .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#honbemtyor div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="3" scope="colgroup" id="**Treatment Received**">
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
<div id="uontkxeowr" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#uontkxeowr table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#uontkxeowr thead, #uontkxeowr tbody, #uontkxeowr tfoot, #uontkxeowr tr, #uontkxeowr td, #uontkxeowr th {
  border-style: none;
}

#uontkxeowr p {
  margin: 0;
  padding: 0;
}

#uontkxeowr .gt_table {
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

#uontkxeowr .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#uontkxeowr .gt_title {
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

#uontkxeowr .gt_subtitle {
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

#uontkxeowr .gt_heading {
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

#uontkxeowr .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#uontkxeowr .gt_col_headings {
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

#uontkxeowr .gt_col_heading {
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

#uontkxeowr .gt_column_spanner_outer {
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

#uontkxeowr .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#uontkxeowr .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#uontkxeowr .gt_column_spanner {
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

#uontkxeowr .gt_spanner_row {
  border-bottom-style: hidden;
}

#uontkxeowr .gt_group_heading {
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

#uontkxeowr .gt_empty_group_heading {
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

#uontkxeowr .gt_from_md > :first-child {
  margin-top: 0;
}

#uontkxeowr .gt_from_md > :last-child {
  margin-bottom: 0;
}

#uontkxeowr .gt_row {
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

#uontkxeowr .gt_stub {
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

#uontkxeowr .gt_stub_row_group {
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

#uontkxeowr .gt_row_group_first td {
  border-top-width: 2px;
}

#uontkxeowr .gt_row_group_first th {
  border-top-width: 2px;
}

#uontkxeowr .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#uontkxeowr .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#uontkxeowr .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#uontkxeowr .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#uontkxeowr .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#uontkxeowr .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#uontkxeowr .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#uontkxeowr .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#uontkxeowr .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#uontkxeowr .gt_footnotes {
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

#uontkxeowr .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#uontkxeowr .gt_sourcenotes {
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

#uontkxeowr .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#uontkxeowr .gt_left {
  text-align: left;
}

#uontkxeowr .gt_center {
  text-align: center;
}

#uontkxeowr .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#uontkxeowr .gt_font_normal {
  font-weight: normal;
}

#uontkxeowr .gt_font_bold {
  font-weight: bold;
}

#uontkxeowr .gt_font_italic {
  font-style: italic;
}

#uontkxeowr .gt_super {
  font-size: 65%;
}

#uontkxeowr .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#uontkxeowr .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#uontkxeowr .gt_indent_1 {
  text-indent: 5px;
}

#uontkxeowr .gt_indent_2 {
  text-indent: 10px;
}

#uontkxeowr .gt_indent_3 {
  text-indent: 15px;
}

#uontkxeowr .gt_indent_4 {
  text-indent: 20px;
}

#uontkxeowr .gt_indent_5 {
  text-indent: 25px;
}

#uontkxeowr .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#uontkxeowr div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="itqxmzanxh" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#itqxmzanxh table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#itqxmzanxh thead, #itqxmzanxh tbody, #itqxmzanxh tfoot, #itqxmzanxh tr, #itqxmzanxh td, #itqxmzanxh th {
  border-style: none;
}

#itqxmzanxh p {
  margin: 0;
  padding: 0;
}

#itqxmzanxh .gt_table {
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

#itqxmzanxh .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#itqxmzanxh .gt_title {
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

#itqxmzanxh .gt_subtitle {
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

#itqxmzanxh .gt_heading {
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

#itqxmzanxh .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#itqxmzanxh .gt_col_headings {
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

#itqxmzanxh .gt_col_heading {
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

#itqxmzanxh .gt_column_spanner_outer {
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

#itqxmzanxh .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#itqxmzanxh .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#itqxmzanxh .gt_column_spanner {
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

#itqxmzanxh .gt_spanner_row {
  border-bottom-style: hidden;
}

#itqxmzanxh .gt_group_heading {
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

#itqxmzanxh .gt_empty_group_heading {
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

#itqxmzanxh .gt_from_md > :first-child {
  margin-top: 0;
}

#itqxmzanxh .gt_from_md > :last-child {
  margin-bottom: 0;
}

#itqxmzanxh .gt_row {
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

#itqxmzanxh .gt_stub {
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

#itqxmzanxh .gt_stub_row_group {
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

#itqxmzanxh .gt_row_group_first td {
  border-top-width: 2px;
}

#itqxmzanxh .gt_row_group_first th {
  border-top-width: 2px;
}

#itqxmzanxh .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#itqxmzanxh .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#itqxmzanxh .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#itqxmzanxh .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#itqxmzanxh .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#itqxmzanxh .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#itqxmzanxh .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#itqxmzanxh .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#itqxmzanxh .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#itqxmzanxh .gt_footnotes {
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

#itqxmzanxh .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#itqxmzanxh .gt_sourcenotes {
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

#itqxmzanxh .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#itqxmzanxh .gt_left {
  text-align: left;
}

#itqxmzanxh .gt_center {
  text-align: center;
}

#itqxmzanxh .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#itqxmzanxh .gt_font_normal {
  font-weight: normal;
}

#itqxmzanxh .gt_font_bold {
  font-weight: bold;
}

#itqxmzanxh .gt_font_italic {
  font-style: italic;
}

#itqxmzanxh .gt_super {
  font-size: 65%;
}

#itqxmzanxh .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#itqxmzanxh .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#itqxmzanxh .gt_indent_1 {
  text-indent: 5px;
}

#itqxmzanxh .gt_indent_2 {
  text-indent: 10px;
}

#itqxmzanxh .gt_indent_3 {
  text-indent: 15px;
}

#itqxmzanxh .gt_indent_4 {
  text-indent: 20px;
}

#itqxmzanxh .gt_indent_5 {
  text-indent: 25px;
}

#itqxmzanxh .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#itqxmzanxh div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="crxfpblodh" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#crxfpblodh table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#crxfpblodh thead, #crxfpblodh tbody, #crxfpblodh tfoot, #crxfpblodh tr, #crxfpblodh td, #crxfpblodh th {
  border-style: none;
}

#crxfpblodh p {
  margin: 0;
  padding: 0;
}

#crxfpblodh .gt_table {
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

#crxfpblodh .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#crxfpblodh .gt_title {
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

#crxfpblodh .gt_subtitle {
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

#crxfpblodh .gt_heading {
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

#crxfpblodh .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#crxfpblodh .gt_col_headings {
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

#crxfpblodh .gt_col_heading {
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

#crxfpblodh .gt_column_spanner_outer {
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

#crxfpblodh .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#crxfpblodh .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#crxfpblodh .gt_column_spanner {
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

#crxfpblodh .gt_spanner_row {
  border-bottom-style: hidden;
}

#crxfpblodh .gt_group_heading {
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

#crxfpblodh .gt_empty_group_heading {
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

#crxfpblodh .gt_from_md > :first-child {
  margin-top: 0;
}

#crxfpblodh .gt_from_md > :last-child {
  margin-bottom: 0;
}

#crxfpblodh .gt_row {
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

#crxfpblodh .gt_stub {
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

#crxfpblodh .gt_stub_row_group {
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

#crxfpblodh .gt_row_group_first td {
  border-top-width: 2px;
}

#crxfpblodh .gt_row_group_first th {
  border-top-width: 2px;
}

#crxfpblodh .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#crxfpblodh .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#crxfpblodh .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#crxfpblodh .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#crxfpblodh .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#crxfpblodh .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#crxfpblodh .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#crxfpblodh .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#crxfpblodh .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#crxfpblodh .gt_footnotes {
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

#crxfpblodh .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#crxfpblodh .gt_sourcenotes {
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

#crxfpblodh .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#crxfpblodh .gt_left {
  text-align: left;
}

#crxfpblodh .gt_center {
  text-align: center;
}

#crxfpblodh .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#crxfpblodh .gt_font_normal {
  font-weight: normal;
}

#crxfpblodh .gt_font_bold {
  font-weight: bold;
}

#crxfpblodh .gt_font_italic {
  font-style: italic;
}

#crxfpblodh .gt_super {
  font-size: 65%;
}

#crxfpblodh .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#crxfpblodh .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#crxfpblodh .gt_indent_1 {
  text-indent: 5px;
}

#crxfpblodh .gt_indent_2 {
  text-indent: 10px;
}

#crxfpblodh .gt_indent_3 {
  text-indent: 15px;
}

#crxfpblodh .gt_indent_4 {
  text-indent: 20px;
}

#crxfpblodh .gt_indent_5 {
  text-indent: 25px;
}

#crxfpblodh .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#crxfpblodh div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Participant<br>Characteristic</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="n"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="stat_0"><span class='gt_from_md'><strong>Overall</strong><br>N = 200</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="**Treatment Arm**">
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
<div id="zbsncyumew" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#zbsncyumew table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#zbsncyumew thead, #zbsncyumew tbody, #zbsncyumew tfoot, #zbsncyumew tr, #zbsncyumew td, #zbsncyumew th {
  border-style: none;
}

#zbsncyumew p {
  margin: 0;
  padding: 0;
}

#zbsncyumew .gt_table {
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

#zbsncyumew .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#zbsncyumew .gt_title {
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

#zbsncyumew .gt_subtitle {
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

#zbsncyumew .gt_heading {
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

#zbsncyumew .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#zbsncyumew .gt_col_headings {
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

#zbsncyumew .gt_col_heading {
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

#zbsncyumew .gt_column_spanner_outer {
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

#zbsncyumew .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#zbsncyumew .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#zbsncyumew .gt_column_spanner {
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

#zbsncyumew .gt_spanner_row {
  border-bottom-style: hidden;
}

#zbsncyumew .gt_group_heading {
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

#zbsncyumew .gt_empty_group_heading {
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

#zbsncyumew .gt_from_md > :first-child {
  margin-top: 0;
}

#zbsncyumew .gt_from_md > :last-child {
  margin-bottom: 0;
}

#zbsncyumew .gt_row {
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

#zbsncyumew .gt_stub {
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

#zbsncyumew .gt_stub_row_group {
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

#zbsncyumew .gt_row_group_first td {
  border-top-width: 2px;
}

#zbsncyumew .gt_row_group_first th {
  border-top-width: 2px;
}

#zbsncyumew .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#zbsncyumew .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#zbsncyumew .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#zbsncyumew .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#zbsncyumew .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#zbsncyumew .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#zbsncyumew .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#zbsncyumew .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#zbsncyumew .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#zbsncyumew .gt_footnotes {
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

#zbsncyumew .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#zbsncyumew .gt_sourcenotes {
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

#zbsncyumew .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#zbsncyumew .gt_left {
  text-align: left;
}

#zbsncyumew .gt_center {
  text-align: center;
}

#zbsncyumew .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#zbsncyumew .gt_font_normal {
  font-weight: normal;
}

#zbsncyumew .gt_font_bold {
  font-weight: bold;
}

#zbsncyumew .gt_font_italic {
  font-style: italic;
}

#zbsncyumew .gt_super {
  font-size: 65%;
}

#zbsncyumew .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#zbsncyumew .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#zbsncyumew .gt_indent_1 {
  text-indent: 5px;
}

#zbsncyumew .gt_indent_2 {
  text-indent: 10px;
}

#zbsncyumew .gt_indent_3 {
  text-indent: 15px;
}

#zbsncyumew .gt_indent_4 {
  text-indent: 20px;
}

#zbsncyumew .gt_indent_5 {
  text-indent: 25px;
}

#zbsncyumew .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#zbsncyumew div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Participant<br>Characteristic</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="n"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="stat_0"><span class='gt_from_md'><strong>Overall</strong><br>N = 200</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="**Treatment Arm**">
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
<div id="jzirbxaqsy" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#jzirbxaqsy table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#jzirbxaqsy thead, #jzirbxaqsy tbody, #jzirbxaqsy tfoot, #jzirbxaqsy tr, #jzirbxaqsy td, #jzirbxaqsy th {
  border-style: none;
}

#jzirbxaqsy p {
  margin: 0;
  padding: 0;
}

#jzirbxaqsy .gt_table {
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

#jzirbxaqsy .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#jzirbxaqsy .gt_title {
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

#jzirbxaqsy .gt_subtitle {
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

#jzirbxaqsy .gt_heading {
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

#jzirbxaqsy .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#jzirbxaqsy .gt_col_headings {
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

#jzirbxaqsy .gt_col_heading {
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

#jzirbxaqsy .gt_column_spanner_outer {
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

#jzirbxaqsy .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#jzirbxaqsy .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#jzirbxaqsy .gt_column_spanner {
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

#jzirbxaqsy .gt_spanner_row {
  border-bottom-style: hidden;
}

#jzirbxaqsy .gt_group_heading {
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

#jzirbxaqsy .gt_empty_group_heading {
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

#jzirbxaqsy .gt_from_md > :first-child {
  margin-top: 0;
}

#jzirbxaqsy .gt_from_md > :last-child {
  margin-bottom: 0;
}

#jzirbxaqsy .gt_row {
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

#jzirbxaqsy .gt_stub {
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

#jzirbxaqsy .gt_stub_row_group {
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

#jzirbxaqsy .gt_row_group_first td {
  border-top-width: 2px;
}

#jzirbxaqsy .gt_row_group_first th {
  border-top-width: 2px;
}

#jzirbxaqsy .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#jzirbxaqsy .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#jzirbxaqsy .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#jzirbxaqsy .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#jzirbxaqsy .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#jzirbxaqsy .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#jzirbxaqsy .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#jzirbxaqsy .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#jzirbxaqsy .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#jzirbxaqsy .gt_footnotes {
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

#jzirbxaqsy .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#jzirbxaqsy .gt_sourcenotes {
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

#jzirbxaqsy .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#jzirbxaqsy .gt_left {
  text-align: left;
}

#jzirbxaqsy .gt_center {
  text-align: center;
}

#jzirbxaqsy .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#jzirbxaqsy .gt_font_normal {
  font-weight: normal;
}

#jzirbxaqsy .gt_font_bold {
  font-weight: bold;
}

#jzirbxaqsy .gt_font_italic {
  font-style: italic;
}

#jzirbxaqsy .gt_super {
  font-size: 65%;
}

#jzirbxaqsy .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#jzirbxaqsy .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#jzirbxaqsy .gt_indent_1 {
  text-indent: 5px;
}

#jzirbxaqsy .gt_indent_2 {
  text-indent: 10px;
}

#jzirbxaqsy .gt_indent_3 {
  text-indent: 15px;
}

#jzirbxaqsy .gt_indent_4 {
  text-indent: 20px;
}

#jzirbxaqsy .gt_indent_5 {
  text-indent: 25px;
}

#jzirbxaqsy .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#jzirbxaqsy div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Participant<br>Characteristic</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="n"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="stat_0"><span class='gt_from_md'><strong>Overall</strong><br>N = 107</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="**Treatment Arm**">
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

