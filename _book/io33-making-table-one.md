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
<div id="tzpgzdmbns" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#tzpgzdmbns table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#tzpgzdmbns thead, #tzpgzdmbns tbody, #tzpgzdmbns tfoot, #tzpgzdmbns tr, #tzpgzdmbns td, #tzpgzdmbns th {
  border-style: none;
}

#tzpgzdmbns p {
  margin: 0;
  padding: 0;
}

#tzpgzdmbns .gt_table {
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

#tzpgzdmbns .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#tzpgzdmbns .gt_title {
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

#tzpgzdmbns .gt_subtitle {
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

#tzpgzdmbns .gt_heading {
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

#tzpgzdmbns .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#tzpgzdmbns .gt_col_headings {
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

#tzpgzdmbns .gt_col_heading {
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

#tzpgzdmbns .gt_column_spanner_outer {
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

#tzpgzdmbns .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#tzpgzdmbns .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#tzpgzdmbns .gt_column_spanner {
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

#tzpgzdmbns .gt_spanner_row {
  border-bottom-style: hidden;
}

#tzpgzdmbns .gt_group_heading {
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

#tzpgzdmbns .gt_empty_group_heading {
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

#tzpgzdmbns .gt_from_md > :first-child {
  margin-top: 0;
}

#tzpgzdmbns .gt_from_md > :last-child {
  margin-bottom: 0;
}

#tzpgzdmbns .gt_row {
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

#tzpgzdmbns .gt_stub {
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

#tzpgzdmbns .gt_stub_row_group {
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

#tzpgzdmbns .gt_row_group_first td {
  border-top-width: 2px;
}

#tzpgzdmbns .gt_row_group_first th {
  border-top-width: 2px;
}

#tzpgzdmbns .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#tzpgzdmbns .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#tzpgzdmbns .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#tzpgzdmbns .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#tzpgzdmbns .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#tzpgzdmbns .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#tzpgzdmbns .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#tzpgzdmbns .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#tzpgzdmbns .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#tzpgzdmbns .gt_footnotes {
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

#tzpgzdmbns .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#tzpgzdmbns .gt_sourcenotes {
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

#tzpgzdmbns .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#tzpgzdmbns .gt_left {
  text-align: left;
}

#tzpgzdmbns .gt_center {
  text-align: center;
}

#tzpgzdmbns .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#tzpgzdmbns .gt_font_normal {
  font-weight: normal;
}

#tzpgzdmbns .gt_font_bold {
  font-weight: bold;
}

#tzpgzdmbns .gt_font_italic {
  font-style: italic;
}

#tzpgzdmbns .gt_super {
  font-size: 65%;
}

#tzpgzdmbns .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#tzpgzdmbns .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#tzpgzdmbns .gt_indent_1 {
  text-indent: 5px;
}

#tzpgzdmbns .gt_indent_2 {
  text-indent: 10px;
}

#tzpgzdmbns .gt_indent_3 {
  text-indent: 15px;
}

#tzpgzdmbns .gt_indent_4 {
  text-indent: 20px;
}

#tzpgzdmbns .gt_indent_5 {
  text-indent: 25px;
}

#tzpgzdmbns .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#tzpgzdmbns div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="ulytspcdhd" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#ulytspcdhd table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#ulytspcdhd thead, #ulytspcdhd tbody, #ulytspcdhd tfoot, #ulytspcdhd tr, #ulytspcdhd td, #ulytspcdhd th {
  border-style: none;
}

#ulytspcdhd p {
  margin: 0;
  padding: 0;
}

#ulytspcdhd .gt_table {
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

#ulytspcdhd .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#ulytspcdhd .gt_title {
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

#ulytspcdhd .gt_subtitle {
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

#ulytspcdhd .gt_heading {
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

#ulytspcdhd .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ulytspcdhd .gt_col_headings {
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

#ulytspcdhd .gt_col_heading {
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

#ulytspcdhd .gt_column_spanner_outer {
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

#ulytspcdhd .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#ulytspcdhd .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#ulytspcdhd .gt_column_spanner {
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

#ulytspcdhd .gt_spanner_row {
  border-bottom-style: hidden;
}

#ulytspcdhd .gt_group_heading {
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

#ulytspcdhd .gt_empty_group_heading {
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

#ulytspcdhd .gt_from_md > :first-child {
  margin-top: 0;
}

#ulytspcdhd .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ulytspcdhd .gt_row {
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

#ulytspcdhd .gt_stub {
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

#ulytspcdhd .gt_stub_row_group {
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

#ulytspcdhd .gt_row_group_first td {
  border-top-width: 2px;
}

#ulytspcdhd .gt_row_group_first th {
  border-top-width: 2px;
}

#ulytspcdhd .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ulytspcdhd .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#ulytspcdhd .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#ulytspcdhd .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ulytspcdhd .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ulytspcdhd .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#ulytspcdhd .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#ulytspcdhd .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#ulytspcdhd .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ulytspcdhd .gt_footnotes {
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

#ulytspcdhd .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ulytspcdhd .gt_sourcenotes {
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

#ulytspcdhd .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ulytspcdhd .gt_left {
  text-align: left;
}

#ulytspcdhd .gt_center {
  text-align: center;
}

#ulytspcdhd .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ulytspcdhd .gt_font_normal {
  font-weight: normal;
}

#ulytspcdhd .gt_font_bold {
  font-weight: bold;
}

#ulytspcdhd .gt_font_italic {
  font-style: italic;
}

#ulytspcdhd .gt_super {
  font-size: 65%;
}

#ulytspcdhd .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#ulytspcdhd .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#ulytspcdhd .gt_indent_1 {
  text-indent: 5px;
}

#ulytspcdhd .gt_indent_2 {
  text-indent: 10px;
}

#ulytspcdhd .gt_indent_3 {
  text-indent: 15px;
}

#ulytspcdhd .gt_indent_4 {
  text-indent: 20px;
}

#ulytspcdhd .gt_indent_5 {
  text-indent: 25px;
}

#ulytspcdhd .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#ulytspcdhd div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="cbypcsttjt" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#cbypcsttjt table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#cbypcsttjt thead, #cbypcsttjt tbody, #cbypcsttjt tfoot, #cbypcsttjt tr, #cbypcsttjt td, #cbypcsttjt th {
  border-style: none;
}

#cbypcsttjt p {
  margin: 0;
  padding: 0;
}

#cbypcsttjt .gt_table {
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

#cbypcsttjt .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#cbypcsttjt .gt_title {
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

#cbypcsttjt .gt_subtitle {
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

#cbypcsttjt .gt_heading {
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

#cbypcsttjt .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#cbypcsttjt .gt_col_headings {
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

#cbypcsttjt .gt_col_heading {
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

#cbypcsttjt .gt_column_spanner_outer {
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

#cbypcsttjt .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#cbypcsttjt .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#cbypcsttjt .gt_column_spanner {
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

#cbypcsttjt .gt_spanner_row {
  border-bottom-style: hidden;
}

#cbypcsttjt .gt_group_heading {
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

#cbypcsttjt .gt_empty_group_heading {
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

#cbypcsttjt .gt_from_md > :first-child {
  margin-top: 0;
}

#cbypcsttjt .gt_from_md > :last-child {
  margin-bottom: 0;
}

#cbypcsttjt .gt_row {
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

#cbypcsttjt .gt_stub {
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

#cbypcsttjt .gt_stub_row_group {
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

#cbypcsttjt .gt_row_group_first td {
  border-top-width: 2px;
}

#cbypcsttjt .gt_row_group_first th {
  border-top-width: 2px;
}

#cbypcsttjt .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#cbypcsttjt .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#cbypcsttjt .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#cbypcsttjt .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#cbypcsttjt .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#cbypcsttjt .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#cbypcsttjt .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#cbypcsttjt .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#cbypcsttjt .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#cbypcsttjt .gt_footnotes {
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

#cbypcsttjt .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#cbypcsttjt .gt_sourcenotes {
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

#cbypcsttjt .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#cbypcsttjt .gt_left {
  text-align: left;
}

#cbypcsttjt .gt_center {
  text-align: center;
}

#cbypcsttjt .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#cbypcsttjt .gt_font_normal {
  font-weight: normal;
}

#cbypcsttjt .gt_font_bold {
  font-weight: bold;
}

#cbypcsttjt .gt_font_italic {
  font-style: italic;
}

#cbypcsttjt .gt_super {
  font-size: 65%;
}

#cbypcsttjt .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#cbypcsttjt .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#cbypcsttjt .gt_indent_1 {
  text-indent: 5px;
}

#cbypcsttjt .gt_indent_2 {
  text-indent: 10px;
}

#cbypcsttjt .gt_indent_3 {
  text-indent: 15px;
}

#cbypcsttjt .gt_indent_4 {
  text-indent: 20px;
}

#cbypcsttjt .gt_indent_5 {
  text-indent: 25px;
}

#cbypcsttjt .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#cbypcsttjt div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="gwxksztiew" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#gwxksztiew table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#gwxksztiew thead, #gwxksztiew tbody, #gwxksztiew tfoot, #gwxksztiew tr, #gwxksztiew td, #gwxksztiew th {
  border-style: none;
}

#gwxksztiew p {
  margin: 0;
  padding: 0;
}

#gwxksztiew .gt_table {
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

#gwxksztiew .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#gwxksztiew .gt_title {
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

#gwxksztiew .gt_subtitle {
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

#gwxksztiew .gt_heading {
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

#gwxksztiew .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#gwxksztiew .gt_col_headings {
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

#gwxksztiew .gt_col_heading {
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

#gwxksztiew .gt_column_spanner_outer {
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

#gwxksztiew .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#gwxksztiew .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#gwxksztiew .gt_column_spanner {
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

#gwxksztiew .gt_spanner_row {
  border-bottom-style: hidden;
}

#gwxksztiew .gt_group_heading {
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

#gwxksztiew .gt_empty_group_heading {
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

#gwxksztiew .gt_from_md > :first-child {
  margin-top: 0;
}

#gwxksztiew .gt_from_md > :last-child {
  margin-bottom: 0;
}

#gwxksztiew .gt_row {
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

#gwxksztiew .gt_stub {
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

#gwxksztiew .gt_stub_row_group {
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

#gwxksztiew .gt_row_group_first td {
  border-top-width: 2px;
}

#gwxksztiew .gt_row_group_first th {
  border-top-width: 2px;
}

#gwxksztiew .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#gwxksztiew .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#gwxksztiew .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#gwxksztiew .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#gwxksztiew .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#gwxksztiew .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#gwxksztiew .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#gwxksztiew .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#gwxksztiew .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#gwxksztiew .gt_footnotes {
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

#gwxksztiew .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#gwxksztiew .gt_sourcenotes {
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

#gwxksztiew .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#gwxksztiew .gt_left {
  text-align: left;
}

#gwxksztiew .gt_center {
  text-align: center;
}

#gwxksztiew .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#gwxksztiew .gt_font_normal {
  font-weight: normal;
}

#gwxksztiew .gt_font_bold {
  font-weight: bold;
}

#gwxksztiew .gt_font_italic {
  font-style: italic;
}

#gwxksztiew .gt_super {
  font-size: 65%;
}

#gwxksztiew .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#gwxksztiew .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#gwxksztiew .gt_indent_1 {
  text-indent: 5px;
}

#gwxksztiew .gt_indent_2 {
  text-indent: 10px;
}

#gwxksztiew .gt_indent_3 {
  text-indent: 15px;
}

#gwxksztiew .gt_indent_4 {
  text-indent: 20px;
}

#gwxksztiew .gt_indent_5 {
  text-indent: 25px;
}

#gwxksztiew .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#gwxksztiew div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="pnsgpmstqb" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#pnsgpmstqb table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#pnsgpmstqb thead, #pnsgpmstqb tbody, #pnsgpmstqb tfoot, #pnsgpmstqb tr, #pnsgpmstqb td, #pnsgpmstqb th {
  border-style: none;
}

#pnsgpmstqb p {
  margin: 0;
  padding: 0;
}

#pnsgpmstqb .gt_table {
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

#pnsgpmstqb .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#pnsgpmstqb .gt_title {
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

#pnsgpmstqb .gt_subtitle {
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

#pnsgpmstqb .gt_heading {
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

#pnsgpmstqb .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#pnsgpmstqb .gt_col_headings {
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

#pnsgpmstqb .gt_col_heading {
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

#pnsgpmstqb .gt_column_spanner_outer {
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

#pnsgpmstqb .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#pnsgpmstqb .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#pnsgpmstqb .gt_column_spanner {
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

#pnsgpmstqb .gt_spanner_row {
  border-bottom-style: hidden;
}

#pnsgpmstqb .gt_group_heading {
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

#pnsgpmstqb .gt_empty_group_heading {
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

#pnsgpmstqb .gt_from_md > :first-child {
  margin-top: 0;
}

#pnsgpmstqb .gt_from_md > :last-child {
  margin-bottom: 0;
}

#pnsgpmstqb .gt_row {
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

#pnsgpmstqb .gt_stub {
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

#pnsgpmstqb .gt_stub_row_group {
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

#pnsgpmstqb .gt_row_group_first td {
  border-top-width: 2px;
}

#pnsgpmstqb .gt_row_group_first th {
  border-top-width: 2px;
}

#pnsgpmstqb .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#pnsgpmstqb .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#pnsgpmstqb .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#pnsgpmstqb .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#pnsgpmstqb .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#pnsgpmstqb .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#pnsgpmstqb .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#pnsgpmstqb .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#pnsgpmstqb .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#pnsgpmstqb .gt_footnotes {
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

#pnsgpmstqb .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#pnsgpmstqb .gt_sourcenotes {
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

#pnsgpmstqb .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#pnsgpmstqb .gt_left {
  text-align: left;
}

#pnsgpmstqb .gt_center {
  text-align: center;
}

#pnsgpmstqb .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#pnsgpmstqb .gt_font_normal {
  font-weight: normal;
}

#pnsgpmstqb .gt_font_bold {
  font-weight: bold;
}

#pnsgpmstqb .gt_font_italic {
  font-style: italic;
}

#pnsgpmstqb .gt_super {
  font-size: 65%;
}

#pnsgpmstqb .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#pnsgpmstqb .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#pnsgpmstqb .gt_indent_1 {
  text-indent: 5px;
}

#pnsgpmstqb .gt_indent_2 {
  text-indent: 10px;
}

#pnsgpmstqb .gt_indent_3 {
  text-indent: 15px;
}

#pnsgpmstqb .gt_indent_4 {
  text-indent: 20px;
}

#pnsgpmstqb .gt_indent_5 {
  text-indent: 25px;
}

#pnsgpmstqb .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#pnsgpmstqb div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="izqmxtodet" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#izqmxtodet table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#izqmxtodet thead, #izqmxtodet tbody, #izqmxtodet tfoot, #izqmxtodet tr, #izqmxtodet td, #izqmxtodet th {
  border-style: none;
}

#izqmxtodet p {
  margin: 0;
  padding: 0;
}

#izqmxtodet .gt_table {
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

#izqmxtodet .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#izqmxtodet .gt_title {
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

#izqmxtodet .gt_subtitle {
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

#izqmxtodet .gt_heading {
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

#izqmxtodet .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#izqmxtodet .gt_col_headings {
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

#izqmxtodet .gt_col_heading {
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

#izqmxtodet .gt_column_spanner_outer {
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

#izqmxtodet .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#izqmxtodet .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#izqmxtodet .gt_column_spanner {
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

#izqmxtodet .gt_spanner_row {
  border-bottom-style: hidden;
}

#izqmxtodet .gt_group_heading {
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

#izqmxtodet .gt_empty_group_heading {
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

#izqmxtodet .gt_from_md > :first-child {
  margin-top: 0;
}

#izqmxtodet .gt_from_md > :last-child {
  margin-bottom: 0;
}

#izqmxtodet .gt_row {
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

#izqmxtodet .gt_stub {
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

#izqmxtodet .gt_stub_row_group {
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

#izqmxtodet .gt_row_group_first td {
  border-top-width: 2px;
}

#izqmxtodet .gt_row_group_first th {
  border-top-width: 2px;
}

#izqmxtodet .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#izqmxtodet .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#izqmxtodet .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#izqmxtodet .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#izqmxtodet .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#izqmxtodet .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#izqmxtodet .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#izqmxtodet .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#izqmxtodet .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#izqmxtodet .gt_footnotes {
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

#izqmxtodet .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#izqmxtodet .gt_sourcenotes {
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

#izqmxtodet .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#izqmxtodet .gt_left {
  text-align: left;
}

#izqmxtodet .gt_center {
  text-align: center;
}

#izqmxtodet .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#izqmxtodet .gt_font_normal {
  font-weight: normal;
}

#izqmxtodet .gt_font_bold {
  font-weight: bold;
}

#izqmxtodet .gt_font_italic {
  font-style: italic;
}

#izqmxtodet .gt_super {
  font-size: 65%;
}

#izqmxtodet .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#izqmxtodet .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#izqmxtodet .gt_indent_1 {
  text-indent: 5px;
}

#izqmxtodet .gt_indent_2 {
  text-indent: 10px;
}

#izqmxtodet .gt_indent_3 {
  text-indent: 15px;
}

#izqmxtodet .gt_indent_4 {
  text-indent: 20px;
}

#izqmxtodet .gt_indent_5 {
  text-indent: 25px;
}

#izqmxtodet .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#izqmxtodet div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="admqtjglui" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#admqtjglui table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#admqtjglui thead, #admqtjglui tbody, #admqtjglui tfoot, #admqtjglui tr, #admqtjglui td, #admqtjglui th {
  border-style: none;
}

#admqtjglui p {
  margin: 0;
  padding: 0;
}

#admqtjglui .gt_table {
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

#admqtjglui .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#admqtjglui .gt_title {
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

#admqtjglui .gt_subtitle {
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

#admqtjglui .gt_heading {
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

#admqtjglui .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#admqtjglui .gt_col_headings {
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

#admqtjglui .gt_col_heading {
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

#admqtjglui .gt_column_spanner_outer {
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

#admqtjglui .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#admqtjglui .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#admqtjglui .gt_column_spanner {
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

#admqtjglui .gt_spanner_row {
  border-bottom-style: hidden;
}

#admqtjglui .gt_group_heading {
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

#admqtjglui .gt_empty_group_heading {
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

#admqtjglui .gt_from_md > :first-child {
  margin-top: 0;
}

#admqtjglui .gt_from_md > :last-child {
  margin-bottom: 0;
}

#admqtjglui .gt_row {
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

#admqtjglui .gt_stub {
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

#admqtjglui .gt_stub_row_group {
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

#admqtjglui .gt_row_group_first td {
  border-top-width: 2px;
}

#admqtjglui .gt_row_group_first th {
  border-top-width: 2px;
}

#admqtjglui .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#admqtjglui .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#admqtjglui .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#admqtjglui .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#admqtjglui .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#admqtjglui .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#admqtjglui .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#admqtjglui .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#admqtjglui .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#admqtjglui .gt_footnotes {
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

#admqtjglui .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#admqtjglui .gt_sourcenotes {
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

#admqtjglui .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#admqtjglui .gt_left {
  text-align: left;
}

#admqtjglui .gt_center {
  text-align: center;
}

#admqtjglui .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#admqtjglui .gt_font_normal {
  font-weight: normal;
}

#admqtjglui .gt_font_bold {
  font-weight: bold;
}

#admqtjglui .gt_font_italic {
  font-style: italic;
}

#admqtjglui .gt_super {
  font-size: 65%;
}

#admqtjglui .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#admqtjglui .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#admqtjglui .gt_indent_1 {
  text-indent: 5px;
}

#admqtjglui .gt_indent_2 {
  text-indent: 10px;
}

#admqtjglui .gt_indent_3 {
  text-indent: 15px;
}

#admqtjglui .gt_indent_4 {
  text-indent: 20px;
}

#admqtjglui .gt_indent_5 {
  text-indent: 25px;
}

#admqtjglui .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#admqtjglui div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="dflevuatve" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#dflevuatve table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#dflevuatve thead, #dflevuatve tbody, #dflevuatve tfoot, #dflevuatve tr, #dflevuatve td, #dflevuatve th {
  border-style: none;
}

#dflevuatve p {
  margin: 0;
  padding: 0;
}

#dflevuatve .gt_table {
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

#dflevuatve .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#dflevuatve .gt_title {
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

#dflevuatve .gt_subtitle {
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

#dflevuatve .gt_heading {
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

#dflevuatve .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#dflevuatve .gt_col_headings {
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

#dflevuatve .gt_col_heading {
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

#dflevuatve .gt_column_spanner_outer {
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

#dflevuatve .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#dflevuatve .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#dflevuatve .gt_column_spanner {
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

#dflevuatve .gt_spanner_row {
  border-bottom-style: hidden;
}

#dflevuatve .gt_group_heading {
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

#dflevuatve .gt_empty_group_heading {
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

#dflevuatve .gt_from_md > :first-child {
  margin-top: 0;
}

#dflevuatve .gt_from_md > :last-child {
  margin-bottom: 0;
}

#dflevuatve .gt_row {
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

#dflevuatve .gt_stub {
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

#dflevuatve .gt_stub_row_group {
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

#dflevuatve .gt_row_group_first td {
  border-top-width: 2px;
}

#dflevuatve .gt_row_group_first th {
  border-top-width: 2px;
}

#dflevuatve .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#dflevuatve .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#dflevuatve .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#dflevuatve .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#dflevuatve .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#dflevuatve .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#dflevuatve .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#dflevuatve .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#dflevuatve .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#dflevuatve .gt_footnotes {
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

#dflevuatve .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#dflevuatve .gt_sourcenotes {
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

#dflevuatve .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#dflevuatve .gt_left {
  text-align: left;
}

#dflevuatve .gt_center {
  text-align: center;
}

#dflevuatve .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#dflevuatve .gt_font_normal {
  font-weight: normal;
}

#dflevuatve .gt_font_bold {
  font-weight: bold;
}

#dflevuatve .gt_font_italic {
  font-style: italic;
}

#dflevuatve .gt_super {
  font-size: 65%;
}

#dflevuatve .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#dflevuatve .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#dflevuatve .gt_indent_1 {
  text-indent: 5px;
}

#dflevuatve .gt_indent_2 {
  text-indent: 10px;
}

#dflevuatve .gt_indent_3 {
  text-indent: 15px;
}

#dflevuatve .gt_indent_4 {
  text-indent: 20px;
}

#dflevuatve .gt_indent_5 {
  text-indent: 25px;
}

#dflevuatve .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#dflevuatve div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="tddxphdssb" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#tddxphdssb table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#tddxphdssb thead, #tddxphdssb tbody, #tddxphdssb tfoot, #tddxphdssb tr, #tddxphdssb td, #tddxphdssb th {
  border-style: none;
}

#tddxphdssb p {
  margin: 0;
  padding: 0;
}

#tddxphdssb .gt_table {
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

#tddxphdssb .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#tddxphdssb .gt_title {
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

#tddxphdssb .gt_subtitle {
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

#tddxphdssb .gt_heading {
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

#tddxphdssb .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#tddxphdssb .gt_col_headings {
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

#tddxphdssb .gt_col_heading {
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

#tddxphdssb .gt_column_spanner_outer {
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

#tddxphdssb .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#tddxphdssb .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#tddxphdssb .gt_column_spanner {
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

#tddxphdssb .gt_spanner_row {
  border-bottom-style: hidden;
}

#tddxphdssb .gt_group_heading {
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

#tddxphdssb .gt_empty_group_heading {
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

#tddxphdssb .gt_from_md > :first-child {
  margin-top: 0;
}

#tddxphdssb .gt_from_md > :last-child {
  margin-bottom: 0;
}

#tddxphdssb .gt_row {
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

#tddxphdssb .gt_stub {
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

#tddxphdssb .gt_stub_row_group {
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

#tddxphdssb .gt_row_group_first td {
  border-top-width: 2px;
}

#tddxphdssb .gt_row_group_first th {
  border-top-width: 2px;
}

#tddxphdssb .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#tddxphdssb .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#tddxphdssb .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#tddxphdssb .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#tddxphdssb .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#tddxphdssb .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#tddxphdssb .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#tddxphdssb .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#tddxphdssb .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#tddxphdssb .gt_footnotes {
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

#tddxphdssb .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#tddxphdssb .gt_sourcenotes {
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

#tddxphdssb .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#tddxphdssb .gt_left {
  text-align: left;
}

#tddxphdssb .gt_center {
  text-align: center;
}

#tddxphdssb .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#tddxphdssb .gt_font_normal {
  font-weight: normal;
}

#tddxphdssb .gt_font_bold {
  font-weight: bold;
}

#tddxphdssb .gt_font_italic {
  font-style: italic;
}

#tddxphdssb .gt_super {
  font-size: 65%;
}

#tddxphdssb .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#tddxphdssb .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#tddxphdssb .gt_indent_1 {
  text-indent: 5px;
}

#tddxphdssb .gt_indent_2 {
  text-indent: 10px;
}

#tddxphdssb .gt_indent_3 {
  text-indent: 15px;
}

#tddxphdssb .gt_indent_4 {
  text-indent: 20px;
}

#tddxphdssb .gt_indent_5 {
  text-indent: 25px;
}

#tddxphdssb .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#tddxphdssb div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="ozjvgquawr" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#ozjvgquawr table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#ozjvgquawr thead, #ozjvgquawr tbody, #ozjvgquawr tfoot, #ozjvgquawr tr, #ozjvgquawr td, #ozjvgquawr th {
  border-style: none;
}

#ozjvgquawr p {
  margin: 0;
  padding: 0;
}

#ozjvgquawr .gt_table {
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

#ozjvgquawr .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#ozjvgquawr .gt_title {
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

#ozjvgquawr .gt_subtitle {
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

#ozjvgquawr .gt_heading {
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

#ozjvgquawr .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ozjvgquawr .gt_col_headings {
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

#ozjvgquawr .gt_col_heading {
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

#ozjvgquawr .gt_column_spanner_outer {
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

#ozjvgquawr .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#ozjvgquawr .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#ozjvgquawr .gt_column_spanner {
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

#ozjvgquawr .gt_spanner_row {
  border-bottom-style: hidden;
}

#ozjvgquawr .gt_group_heading {
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

#ozjvgquawr .gt_empty_group_heading {
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

#ozjvgquawr .gt_from_md > :first-child {
  margin-top: 0;
}

#ozjvgquawr .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ozjvgquawr .gt_row {
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

#ozjvgquawr .gt_stub {
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

#ozjvgquawr .gt_stub_row_group {
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

#ozjvgquawr .gt_row_group_first td {
  border-top-width: 2px;
}

#ozjvgquawr .gt_row_group_first th {
  border-top-width: 2px;
}

#ozjvgquawr .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ozjvgquawr .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#ozjvgquawr .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#ozjvgquawr .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ozjvgquawr .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ozjvgquawr .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#ozjvgquawr .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#ozjvgquawr .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#ozjvgquawr .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ozjvgquawr .gt_footnotes {
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

#ozjvgquawr .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ozjvgquawr .gt_sourcenotes {
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

#ozjvgquawr .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ozjvgquawr .gt_left {
  text-align: left;
}

#ozjvgquawr .gt_center {
  text-align: center;
}

#ozjvgquawr .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ozjvgquawr .gt_font_normal {
  font-weight: normal;
}

#ozjvgquawr .gt_font_bold {
  font-weight: bold;
}

#ozjvgquawr .gt_font_italic {
  font-style: italic;
}

#ozjvgquawr .gt_super {
  font-size: 65%;
}

#ozjvgquawr .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#ozjvgquawr .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#ozjvgquawr .gt_indent_1 {
  text-indent: 5px;
}

#ozjvgquawr .gt_indent_2 {
  text-indent: 10px;
}

#ozjvgquawr .gt_indent_3 {
  text-indent: 15px;
}

#ozjvgquawr .gt_indent_4 {
  text-indent: 20px;
}

#ozjvgquawr .gt_indent_5 {
  text-indent: 25px;
}

#ozjvgquawr .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#ozjvgquawr div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="rqmhnredmm" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#rqmhnredmm table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#rqmhnredmm thead, #rqmhnredmm tbody, #rqmhnredmm tfoot, #rqmhnredmm tr, #rqmhnredmm td, #rqmhnredmm th {
  border-style: none;
}

#rqmhnredmm p {
  margin: 0;
  padding: 0;
}

#rqmhnredmm .gt_table {
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

#rqmhnredmm .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#rqmhnredmm .gt_title {
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

#rqmhnredmm .gt_subtitle {
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

#rqmhnredmm .gt_heading {
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

#rqmhnredmm .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#rqmhnredmm .gt_col_headings {
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

#rqmhnredmm .gt_col_heading {
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

#rqmhnredmm .gt_column_spanner_outer {
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

#rqmhnredmm .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#rqmhnredmm .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#rqmhnredmm .gt_column_spanner {
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

#rqmhnredmm .gt_spanner_row {
  border-bottom-style: hidden;
}

#rqmhnredmm .gt_group_heading {
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

#rqmhnredmm .gt_empty_group_heading {
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

#rqmhnredmm .gt_from_md > :first-child {
  margin-top: 0;
}

#rqmhnredmm .gt_from_md > :last-child {
  margin-bottom: 0;
}

#rqmhnredmm .gt_row {
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

#rqmhnredmm .gt_stub {
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

#rqmhnredmm .gt_stub_row_group {
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

#rqmhnredmm .gt_row_group_first td {
  border-top-width: 2px;
}

#rqmhnredmm .gt_row_group_first th {
  border-top-width: 2px;
}

#rqmhnredmm .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#rqmhnredmm .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#rqmhnredmm .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#rqmhnredmm .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#rqmhnredmm .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#rqmhnredmm .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#rqmhnredmm .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#rqmhnredmm .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#rqmhnredmm .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#rqmhnredmm .gt_footnotes {
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

#rqmhnredmm .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#rqmhnredmm .gt_sourcenotes {
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

#rqmhnredmm .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#rqmhnredmm .gt_left {
  text-align: left;
}

#rqmhnredmm .gt_center {
  text-align: center;
}

#rqmhnredmm .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#rqmhnredmm .gt_font_normal {
  font-weight: normal;
}

#rqmhnredmm .gt_font_bold {
  font-weight: bold;
}

#rqmhnredmm .gt_font_italic {
  font-style: italic;
}

#rqmhnredmm .gt_super {
  font-size: 65%;
}

#rqmhnredmm .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#rqmhnredmm .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#rqmhnredmm .gt_indent_1 {
  text-indent: 5px;
}

#rqmhnredmm .gt_indent_2 {
  text-indent: 10px;
}

#rqmhnredmm .gt_indent_3 {
  text-indent: 15px;
}

#rqmhnredmm .gt_indent_4 {
  text-indent: 20px;
}

#rqmhnredmm .gt_indent_5 {
  text-indent: 25px;
}

#rqmhnredmm .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#rqmhnredmm div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="knlirbheeg" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#knlirbheeg table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#knlirbheeg thead, #knlirbheeg tbody, #knlirbheeg tfoot, #knlirbheeg tr, #knlirbheeg td, #knlirbheeg th {
  border-style: none;
}

#knlirbheeg p {
  margin: 0;
  padding: 0;
}

#knlirbheeg .gt_table {
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

#knlirbheeg .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#knlirbheeg .gt_title {
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

#knlirbheeg .gt_subtitle {
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

#knlirbheeg .gt_heading {
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

#knlirbheeg .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#knlirbheeg .gt_col_headings {
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

#knlirbheeg .gt_col_heading {
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

#knlirbheeg .gt_column_spanner_outer {
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

#knlirbheeg .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#knlirbheeg .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#knlirbheeg .gt_column_spanner {
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

#knlirbheeg .gt_spanner_row {
  border-bottom-style: hidden;
}

#knlirbheeg .gt_group_heading {
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

#knlirbheeg .gt_empty_group_heading {
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

#knlirbheeg .gt_from_md > :first-child {
  margin-top: 0;
}

#knlirbheeg .gt_from_md > :last-child {
  margin-bottom: 0;
}

#knlirbheeg .gt_row {
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

#knlirbheeg .gt_stub {
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

#knlirbheeg .gt_stub_row_group {
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

#knlirbheeg .gt_row_group_first td {
  border-top-width: 2px;
}

#knlirbheeg .gt_row_group_first th {
  border-top-width: 2px;
}

#knlirbheeg .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#knlirbheeg .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#knlirbheeg .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#knlirbheeg .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#knlirbheeg .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#knlirbheeg .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#knlirbheeg .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#knlirbheeg .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#knlirbheeg .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#knlirbheeg .gt_footnotes {
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

#knlirbheeg .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#knlirbheeg .gt_sourcenotes {
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

#knlirbheeg .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#knlirbheeg .gt_left {
  text-align: left;
}

#knlirbheeg .gt_center {
  text-align: center;
}

#knlirbheeg .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#knlirbheeg .gt_font_normal {
  font-weight: normal;
}

#knlirbheeg .gt_font_bold {
  font-weight: bold;
}

#knlirbheeg .gt_font_italic {
  font-style: italic;
}

#knlirbheeg .gt_super {
  font-size: 65%;
}

#knlirbheeg .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#knlirbheeg .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#knlirbheeg .gt_indent_1 {
  text-indent: 5px;
}

#knlirbheeg .gt_indent_2 {
  text-indent: 10px;
}

#knlirbheeg .gt_indent_3 {
  text-indent: 15px;
}

#knlirbheeg .gt_indent_4 {
  text-indent: 20px;
}

#knlirbheeg .gt_indent_5 {
  text-indent: 25px;
}

#knlirbheeg .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#knlirbheeg div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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
<div id="zqfiyjrusa" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#zqfiyjrusa table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#zqfiyjrusa thead, #zqfiyjrusa tbody, #zqfiyjrusa tfoot, #zqfiyjrusa tr, #zqfiyjrusa td, #zqfiyjrusa th {
  border-style: none;
}

#zqfiyjrusa p {
  margin: 0;
  padding: 0;
}

#zqfiyjrusa .gt_table {
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

#zqfiyjrusa .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#zqfiyjrusa .gt_title {
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

#zqfiyjrusa .gt_subtitle {
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

#zqfiyjrusa .gt_heading {
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

#zqfiyjrusa .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#zqfiyjrusa .gt_col_headings {
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

#zqfiyjrusa .gt_col_heading {
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

#zqfiyjrusa .gt_column_spanner_outer {
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

#zqfiyjrusa .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#zqfiyjrusa .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#zqfiyjrusa .gt_column_spanner {
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

#zqfiyjrusa .gt_spanner_row {
  border-bottom-style: hidden;
}

#zqfiyjrusa .gt_group_heading {
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

#zqfiyjrusa .gt_empty_group_heading {
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

#zqfiyjrusa .gt_from_md > :first-child {
  margin-top: 0;
}

#zqfiyjrusa .gt_from_md > :last-child {
  margin-bottom: 0;
}

#zqfiyjrusa .gt_row {
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

#zqfiyjrusa .gt_stub {
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

#zqfiyjrusa .gt_stub_row_group {
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

#zqfiyjrusa .gt_row_group_first td {
  border-top-width: 2px;
}

#zqfiyjrusa .gt_row_group_first th {
  border-top-width: 2px;
}

#zqfiyjrusa .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#zqfiyjrusa .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#zqfiyjrusa .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#zqfiyjrusa .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#zqfiyjrusa .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#zqfiyjrusa .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#zqfiyjrusa .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#zqfiyjrusa .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#zqfiyjrusa .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#zqfiyjrusa .gt_footnotes {
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

#zqfiyjrusa .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#zqfiyjrusa .gt_sourcenotes {
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

#zqfiyjrusa .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#zqfiyjrusa .gt_left {
  text-align: left;
}

#zqfiyjrusa .gt_center {
  text-align: center;
}

#zqfiyjrusa .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#zqfiyjrusa .gt_font_normal {
  font-weight: normal;
}

#zqfiyjrusa .gt_font_bold {
  font-weight: bold;
}

#zqfiyjrusa .gt_font_italic {
  font-style: italic;
}

#zqfiyjrusa .gt_super {
  font-size: 65%;
}

#zqfiyjrusa .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#zqfiyjrusa .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#zqfiyjrusa .gt_indent_1 {
  text-indent: 5px;
}

#zqfiyjrusa .gt_indent_2 {
  text-indent: 10px;
}

#zqfiyjrusa .gt_indent_3 {
  text-indent: 15px;
}

#zqfiyjrusa .gt_indent_4 {
  text-indent: 20px;
}

#zqfiyjrusa .gt_indent_5 {
  text-indent: 25px;
}

#zqfiyjrusa .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#zqfiyjrusa div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
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

