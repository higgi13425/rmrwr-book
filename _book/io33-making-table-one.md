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
<div id="hgyptnywxj" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#hgyptnywxj table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#hgyptnywxj thead, #hgyptnywxj tbody, #hgyptnywxj tfoot, #hgyptnywxj tr, #hgyptnywxj td, #hgyptnywxj th {
  border-style: none;
}

#hgyptnywxj p {
  margin: 0;
  padding: 0;
}

#hgyptnywxj .gt_table {
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

#hgyptnywxj .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#hgyptnywxj .gt_title {
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

#hgyptnywxj .gt_subtitle {
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

#hgyptnywxj .gt_heading {
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

#hgyptnywxj .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#hgyptnywxj .gt_col_headings {
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

#hgyptnywxj .gt_col_heading {
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

#hgyptnywxj .gt_column_spanner_outer {
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

#hgyptnywxj .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#hgyptnywxj .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#hgyptnywxj .gt_column_spanner {
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

#hgyptnywxj .gt_spanner_row {
  border-bottom-style: hidden;
}

#hgyptnywxj .gt_group_heading {
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

#hgyptnywxj .gt_empty_group_heading {
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

#hgyptnywxj .gt_from_md > :first-child {
  margin-top: 0;
}

#hgyptnywxj .gt_from_md > :last-child {
  margin-bottom: 0;
}

#hgyptnywxj .gt_row {
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

#hgyptnywxj .gt_stub {
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

#hgyptnywxj .gt_stub_row_group {
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

#hgyptnywxj .gt_row_group_first td {
  border-top-width: 2px;
}

#hgyptnywxj .gt_row_group_first th {
  border-top-width: 2px;
}

#hgyptnywxj .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#hgyptnywxj .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#hgyptnywxj .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#hgyptnywxj .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#hgyptnywxj .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#hgyptnywxj .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#hgyptnywxj .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#hgyptnywxj .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#hgyptnywxj .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#hgyptnywxj .gt_footnotes {
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

#hgyptnywxj .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#hgyptnywxj .gt_sourcenotes {
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

#hgyptnywxj .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#hgyptnywxj .gt_left {
  text-align: left;
}

#hgyptnywxj .gt_center {
  text-align: center;
}

#hgyptnywxj .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#hgyptnywxj .gt_font_normal {
  font-weight: normal;
}

#hgyptnywxj .gt_font_bold {
  font-weight: bold;
}

#hgyptnywxj .gt_font_italic {
  font-style: italic;
}

#hgyptnywxj .gt_super {
  font-size: 65%;
}

#hgyptnywxj .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#hgyptnywxj .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#hgyptnywxj .gt_indent_1 {
  text-indent: 5px;
}

#hgyptnywxj .gt_indent_2 {
  text-indent: 10px;
}

#hgyptnywxj .gt_indent_3 {
  text-indent: 15px;
}

#hgyptnywxj .gt_indent_4 {
  text-indent: 20px;
}

#hgyptnywxj .gt_indent_5 {
  text-indent: 25px;
}

#hgyptnywxj .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#hgyptnywxj div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;Characteristic&lt;/strong&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>Characteristic</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;N = 1,499&lt;/strong&gt;&lt;/span&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>N = 1,499</strong></span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span></th>
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
<td headers="stat_0" class="gt_row gt_center">26.3 (23.5, 30.1)</td></tr>
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
      <td class="gt_footnote" colspan="2"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span> <span class='gt_from_md'>Median (IQR); n (%)</span></td>
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
<div id="dgsmsqfeel" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#dgsmsqfeel table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#dgsmsqfeel thead, #dgsmsqfeel tbody, #dgsmsqfeel tfoot, #dgsmsqfeel tr, #dgsmsqfeel td, #dgsmsqfeel th {
  border-style: none;
}

#dgsmsqfeel p {
  margin: 0;
  padding: 0;
}

#dgsmsqfeel .gt_table {
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

#dgsmsqfeel .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#dgsmsqfeel .gt_title {
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

#dgsmsqfeel .gt_subtitle {
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

#dgsmsqfeel .gt_heading {
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

#dgsmsqfeel .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#dgsmsqfeel .gt_col_headings {
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

#dgsmsqfeel .gt_col_heading {
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

#dgsmsqfeel .gt_column_spanner_outer {
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

#dgsmsqfeel .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#dgsmsqfeel .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#dgsmsqfeel .gt_column_spanner {
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

#dgsmsqfeel .gt_spanner_row {
  border-bottom-style: hidden;
}

#dgsmsqfeel .gt_group_heading {
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

#dgsmsqfeel .gt_empty_group_heading {
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

#dgsmsqfeel .gt_from_md > :first-child {
  margin-top: 0;
}

#dgsmsqfeel .gt_from_md > :last-child {
  margin-bottom: 0;
}

#dgsmsqfeel .gt_row {
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

#dgsmsqfeel .gt_stub {
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

#dgsmsqfeel .gt_stub_row_group {
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

#dgsmsqfeel .gt_row_group_first td {
  border-top-width: 2px;
}

#dgsmsqfeel .gt_row_group_first th {
  border-top-width: 2px;
}

#dgsmsqfeel .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#dgsmsqfeel .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#dgsmsqfeel .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#dgsmsqfeel .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#dgsmsqfeel .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#dgsmsqfeel .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#dgsmsqfeel .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#dgsmsqfeel .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#dgsmsqfeel .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#dgsmsqfeel .gt_footnotes {
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

#dgsmsqfeel .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#dgsmsqfeel .gt_sourcenotes {
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

#dgsmsqfeel .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#dgsmsqfeel .gt_left {
  text-align: left;
}

#dgsmsqfeel .gt_center {
  text-align: center;
}

#dgsmsqfeel .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#dgsmsqfeel .gt_font_normal {
  font-weight: normal;
}

#dgsmsqfeel .gt_font_bold {
  font-weight: bold;
}

#dgsmsqfeel .gt_font_italic {
  font-style: italic;
}

#dgsmsqfeel .gt_super {
  font-size: 65%;
}

#dgsmsqfeel .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#dgsmsqfeel .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#dgsmsqfeel .gt_indent_1 {
  text-indent: 5px;
}

#dgsmsqfeel .gt_indent_2 {
  text-indent: 10px;
}

#dgsmsqfeel .gt_indent_3 {
  text-indent: 15px;
}

#dgsmsqfeel .gt_indent_4 {
  text-indent: 20px;
}

#dgsmsqfeel .gt_indent_5 {
  text-indent: 25px;
}

#dgsmsqfeel .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#dgsmsqfeel div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;Characteristic&lt;/strong&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>Characteristic</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;N = 1,499&lt;/strong&gt;&lt;/span&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>N = 1,499</strong></span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span></th>
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
<td headers="stat_0" class="gt_row gt_center">26.3 (23.5, 30.1)</td></tr>
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
      <td class="gt_footnote" colspan="2"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span> <span class='gt_from_md'>Median (IQR); n (%)</span></td>
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
<div id="yytvqofkgi" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#yytvqofkgi table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#yytvqofkgi thead, #yytvqofkgi tbody, #yytvqofkgi tfoot, #yytvqofkgi tr, #yytvqofkgi td, #yytvqofkgi th {
  border-style: none;
}

#yytvqofkgi p {
  margin: 0;
  padding: 0;
}

#yytvqofkgi .gt_table {
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

#yytvqofkgi .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#yytvqofkgi .gt_title {
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

#yytvqofkgi .gt_subtitle {
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

#yytvqofkgi .gt_heading {
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

#yytvqofkgi .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#yytvqofkgi .gt_col_headings {
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

#yytvqofkgi .gt_col_heading {
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

#yytvqofkgi .gt_column_spanner_outer {
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

#yytvqofkgi .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#yytvqofkgi .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#yytvqofkgi .gt_column_spanner {
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

#yytvqofkgi .gt_spanner_row {
  border-bottom-style: hidden;
}

#yytvqofkgi .gt_group_heading {
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

#yytvqofkgi .gt_empty_group_heading {
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

#yytvqofkgi .gt_from_md > :first-child {
  margin-top: 0;
}

#yytvqofkgi .gt_from_md > :last-child {
  margin-bottom: 0;
}

#yytvqofkgi .gt_row {
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

#yytvqofkgi .gt_stub {
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

#yytvqofkgi .gt_stub_row_group {
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

#yytvqofkgi .gt_row_group_first td {
  border-top-width: 2px;
}

#yytvqofkgi .gt_row_group_first th {
  border-top-width: 2px;
}

#yytvqofkgi .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#yytvqofkgi .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#yytvqofkgi .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#yytvqofkgi .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#yytvqofkgi .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#yytvqofkgi .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#yytvqofkgi .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#yytvqofkgi .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#yytvqofkgi .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#yytvqofkgi .gt_footnotes {
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

#yytvqofkgi .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#yytvqofkgi .gt_sourcenotes {
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

#yytvqofkgi .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#yytvqofkgi .gt_left {
  text-align: left;
}

#yytvqofkgi .gt_center {
  text-align: center;
}

#yytvqofkgi .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#yytvqofkgi .gt_font_normal {
  font-weight: normal;
}

#yytvqofkgi .gt_font_bold {
  font-weight: bold;
}

#yytvqofkgi .gt_font_italic {
  font-style: italic;
}

#yytvqofkgi .gt_super {
  font-size: 65%;
}

#yytvqofkgi .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#yytvqofkgi .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#yytvqofkgi .gt_indent_1 {
  text-indent: 5px;
}

#yytvqofkgi .gt_indent_2 {
  text-indent: 10px;
}

#yytvqofkgi .gt_indent_3 {
  text-indent: 15px;
}

#yytvqofkgi .gt_indent_4 {
  text-indent: 20px;
}

#yytvqofkgi .gt_indent_5 {
  text-indent: 25px;
}

#yytvqofkgi .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#yytvqofkgi div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;Characteristic&lt;/strong&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>Characteristic</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;N = 1,499&lt;/strong&gt;&lt;/span&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>N = 1,499</strong></span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span></th>
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
<td headers="stat_0" class="gt_row gt_center">26.3 (23.5, 30.1)</td></tr>
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
      <td class="gt_footnote" colspan="2"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span> <span class='gt_from_md'>Median (IQR); n (%)</span></td>
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
<div id="mcxurploah" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#mcxurploah table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#mcxurploah thead, #mcxurploah tbody, #mcxurploah tfoot, #mcxurploah tr, #mcxurploah td, #mcxurploah th {
  border-style: none;
}

#mcxurploah p {
  margin: 0;
  padding: 0;
}

#mcxurploah .gt_table {
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

#mcxurploah .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#mcxurploah .gt_title {
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

#mcxurploah .gt_subtitle {
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

#mcxurploah .gt_heading {
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

#mcxurploah .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#mcxurploah .gt_col_headings {
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

#mcxurploah .gt_col_heading {
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

#mcxurploah .gt_column_spanner_outer {
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

#mcxurploah .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#mcxurploah .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#mcxurploah .gt_column_spanner {
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

#mcxurploah .gt_spanner_row {
  border-bottom-style: hidden;
}

#mcxurploah .gt_group_heading {
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

#mcxurploah .gt_empty_group_heading {
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

#mcxurploah .gt_from_md > :first-child {
  margin-top: 0;
}

#mcxurploah .gt_from_md > :last-child {
  margin-bottom: 0;
}

#mcxurploah .gt_row {
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

#mcxurploah .gt_stub {
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

#mcxurploah .gt_stub_row_group {
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

#mcxurploah .gt_row_group_first td {
  border-top-width: 2px;
}

#mcxurploah .gt_row_group_first th {
  border-top-width: 2px;
}

#mcxurploah .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#mcxurploah .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#mcxurploah .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#mcxurploah .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#mcxurploah .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#mcxurploah .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#mcxurploah .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#mcxurploah .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#mcxurploah .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#mcxurploah .gt_footnotes {
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

#mcxurploah .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#mcxurploah .gt_sourcenotes {
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

#mcxurploah .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#mcxurploah .gt_left {
  text-align: left;
}

#mcxurploah .gt_center {
  text-align: center;
}

#mcxurploah .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#mcxurploah .gt_font_normal {
  font-weight: normal;
}

#mcxurploah .gt_font_bold {
  font-weight: bold;
}

#mcxurploah .gt_font_italic {
  font-style: italic;
}

#mcxurploah .gt_super {
  font-size: 65%;
}

#mcxurploah .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#mcxurploah .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#mcxurploah .gt_indent_1 {
  text-indent: 5px;
}

#mcxurploah .gt_indent_2 {
  text-indent: 10px;
}

#mcxurploah .gt_indent_3 {
  text-indent: 15px;
}

#mcxurploah .gt_indent_4 {
  text-indent: 20px;
}

#mcxurploah .gt_indent_5 {
  text-indent: 25px;
}

#mcxurploah .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#mcxurploah div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;Characteristic&lt;/strong&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>Characteristic</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;N&lt;/strong&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;Overall&lt;/strong&gt;, N = 1,499&lt;/span&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>Overall</strong>, N = 1,499</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;A: IFL&lt;/strong&gt;, N = 428&lt;/span&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>A: IFL</strong>, N = 428</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;F: FOLFOX&lt;/strong&gt;, N = 691&lt;/span&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>F: FOLFOX</strong>, N = 691</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;G: IROX&lt;/strong&gt;, N = 380&lt;/span&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>G: IROX</strong>, N = 380</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span></th>
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
<td headers="stat_1" class="gt_row gt_center">12.10 (11.00, 13.45)</td>
<td headers="stat_2" class="gt_row gt_center">12.20 (11.10, 13.60)</td>
<td headers="stat_3" class="gt_row gt_center">12.40 (11.18, 13.63)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Unknown</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">266</td>
<td headers="stat_1" class="gt_row gt_center">69</td>
<td headers="stat_2" class="gt_row gt_center">141</td>
<td headers="stat_3" class="gt_row gt_center">56</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Body Mass Index (kg/m^2)</td>
<td headers="n" class="gt_row gt_center">1,466</td>
<td headers="stat_0" class="gt_row gt_center">26.3 (23.5, 30.1)</td>
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
<td headers="stat_1" class="gt_row gt_center">133 (89, 217)</td>
<td headers="stat_2" class="gt_row gt_center">116 (85, 195)</td>
<td headers="stat_3" class="gt_row gt_center">122 (88, 210)</td></tr>
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
      <td class="gt_footnote" colspan="6"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span> <span class='gt_from_md'>Median (IQR); n (%)</span></td>
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
<div id="ljtxgoedtx" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#ljtxgoedtx table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#ljtxgoedtx thead, #ljtxgoedtx tbody, #ljtxgoedtx tfoot, #ljtxgoedtx tr, #ljtxgoedtx td, #ljtxgoedtx th {
  border-style: none;
}

#ljtxgoedtx p {
  margin: 0;
  padding: 0;
}

#ljtxgoedtx .gt_table {
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

#ljtxgoedtx .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#ljtxgoedtx .gt_title {
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

#ljtxgoedtx .gt_subtitle {
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

#ljtxgoedtx .gt_heading {
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

#ljtxgoedtx .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ljtxgoedtx .gt_col_headings {
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

#ljtxgoedtx .gt_col_heading {
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

#ljtxgoedtx .gt_column_spanner_outer {
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

#ljtxgoedtx .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#ljtxgoedtx .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#ljtxgoedtx .gt_column_spanner {
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

#ljtxgoedtx .gt_spanner_row {
  border-bottom-style: hidden;
}

#ljtxgoedtx .gt_group_heading {
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

#ljtxgoedtx .gt_empty_group_heading {
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

#ljtxgoedtx .gt_from_md > :first-child {
  margin-top: 0;
}

#ljtxgoedtx .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ljtxgoedtx .gt_row {
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

#ljtxgoedtx .gt_stub {
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

#ljtxgoedtx .gt_stub_row_group {
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

#ljtxgoedtx .gt_row_group_first td {
  border-top-width: 2px;
}

#ljtxgoedtx .gt_row_group_first th {
  border-top-width: 2px;
}

#ljtxgoedtx .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ljtxgoedtx .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#ljtxgoedtx .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#ljtxgoedtx .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ljtxgoedtx .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ljtxgoedtx .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#ljtxgoedtx .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#ljtxgoedtx .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#ljtxgoedtx .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ljtxgoedtx .gt_footnotes {
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

#ljtxgoedtx .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ljtxgoedtx .gt_sourcenotes {
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

#ljtxgoedtx .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ljtxgoedtx .gt_left {
  text-align: left;
}

#ljtxgoedtx .gt_center {
  text-align: center;
}

#ljtxgoedtx .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ljtxgoedtx .gt_font_normal {
  font-weight: normal;
}

#ljtxgoedtx .gt_font_bold {
  font-weight: bold;
}

#ljtxgoedtx .gt_font_italic {
  font-style: italic;
}

#ljtxgoedtx .gt_super {
  font-size: 65%;
}

#ljtxgoedtx .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#ljtxgoedtx .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#ljtxgoedtx .gt_indent_1 {
  text-indent: 5px;
}

#ljtxgoedtx .gt_indent_2 {
  text-indent: 10px;
}

#ljtxgoedtx .gt_indent_3 {
  text-indent: 15px;
}

#ljtxgoedtx .gt_indent_4 {
  text-indent: 20px;
}

#ljtxgoedtx .gt_indent_5 {
  text-indent: 25px;
}

#ljtxgoedtx .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#ljtxgoedtx div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;Characteristic&lt;/strong&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>Characteristic</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;N&lt;/strong&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;Overall&lt;/strong&gt;, N = 1,499&lt;/span&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>Overall</strong>, N = 1,499</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;A: IFL&lt;/strong&gt;, N = 428&lt;/span&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>A: IFL</strong>, N = 428</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;F: FOLFOX&lt;/strong&gt;, N = 691&lt;/span&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>F: FOLFOX</strong>, N = 691</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;G: IROX&lt;/strong&gt;, N = 380&lt;/span&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>G: IROX</strong>, N = 380</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span></th>
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
<td headers="stat_1" class="gt_row gt_center">12.10 (11.00, 13.45)</td>
<td headers="stat_2" class="gt_row gt_center">12.20 (11.10, 13.60)</td>
<td headers="stat_3" class="gt_row gt_center">12.40 (11.18, 13.63)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Missing</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">266</td>
<td headers="stat_1" class="gt_row gt_center">69</td>
<td headers="stat_2" class="gt_row gt_center">141</td>
<td headers="stat_3" class="gt_row gt_center">56</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Body Mass Index (kg/m^2)</td>
<td headers="n" class="gt_row gt_center">1,466</td>
<td headers="stat_0" class="gt_row gt_center">26.3 (23.5, 30.1)</td>
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
<td headers="stat_1" class="gt_row gt_center">133 (89, 217)</td>
<td headers="stat_2" class="gt_row gt_center">116 (85, 195)</td>
<td headers="stat_3" class="gt_row gt_center">122 (88, 210)</td></tr>
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
      <td class="gt_footnote" colspan="6"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span> <span class='gt_from_md'>Median (IQR); n (%)</span></td>
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
<div id="mjidewunoj" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#mjidewunoj table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#mjidewunoj thead, #mjidewunoj tbody, #mjidewunoj tfoot, #mjidewunoj tr, #mjidewunoj td, #mjidewunoj th {
  border-style: none;
}

#mjidewunoj p {
  margin: 0;
  padding: 0;
}

#mjidewunoj .gt_table {
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

#mjidewunoj .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#mjidewunoj .gt_title {
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

#mjidewunoj .gt_subtitle {
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

#mjidewunoj .gt_heading {
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

#mjidewunoj .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#mjidewunoj .gt_col_headings {
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

#mjidewunoj .gt_col_heading {
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

#mjidewunoj .gt_column_spanner_outer {
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

#mjidewunoj .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#mjidewunoj .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#mjidewunoj .gt_column_spanner {
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

#mjidewunoj .gt_spanner_row {
  border-bottom-style: hidden;
}

#mjidewunoj .gt_group_heading {
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

#mjidewunoj .gt_empty_group_heading {
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

#mjidewunoj .gt_from_md > :first-child {
  margin-top: 0;
}

#mjidewunoj .gt_from_md > :last-child {
  margin-bottom: 0;
}

#mjidewunoj .gt_row {
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

#mjidewunoj .gt_stub {
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

#mjidewunoj .gt_stub_row_group {
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

#mjidewunoj .gt_row_group_first td {
  border-top-width: 2px;
}

#mjidewunoj .gt_row_group_first th {
  border-top-width: 2px;
}

#mjidewunoj .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#mjidewunoj .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#mjidewunoj .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#mjidewunoj .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#mjidewunoj .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#mjidewunoj .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#mjidewunoj .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#mjidewunoj .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#mjidewunoj .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#mjidewunoj .gt_footnotes {
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

#mjidewunoj .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#mjidewunoj .gt_sourcenotes {
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

#mjidewunoj .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#mjidewunoj .gt_left {
  text-align: left;
}

#mjidewunoj .gt_center {
  text-align: center;
}

#mjidewunoj .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#mjidewunoj .gt_font_normal {
  font-weight: normal;
}

#mjidewunoj .gt_font_bold {
  font-weight: bold;
}

#mjidewunoj .gt_font_italic {
  font-style: italic;
}

#mjidewunoj .gt_super {
  font-size: 65%;
}

#mjidewunoj .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#mjidewunoj .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#mjidewunoj .gt_indent_1 {
  text-indent: 5px;
}

#mjidewunoj .gt_indent_2 {
  text-indent: 10px;
}

#mjidewunoj .gt_indent_3 {
  text-indent: 15px;
}

#mjidewunoj .gt_indent_4 {
  text-indent: 20px;
}

#mjidewunoj .gt_indent_5 {
  text-indent: 25px;
}

#mjidewunoj .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#mjidewunoj div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;Characteristic&lt;/strong&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>Characteristic</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;N&lt;/strong&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;Overall&lt;/strong&gt;, N = 1,499&lt;/span&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>Overall</strong>, N = 1,499</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="3" scope="colgroup" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;Treatment Received&lt;/strong&gt;&lt;/span&gt;">
        <span class="gt_column_spanner"><span class='gt_from_md'><strong>Treatment Received</strong></span></span>
      </th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;A: IFL&lt;/strong&gt;, N = 428&lt;/span&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>A: IFL</strong>, N = 428</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;F: FOLFOX&lt;/strong&gt;, N = 691&lt;/span&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>F: FOLFOX</strong>, N = 691</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;G: IROX&lt;/strong&gt;, N = 380&lt;/span&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>G: IROX</strong>, N = 380</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span></th>
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
<td headers="stat_1" class="gt_row gt_center">12.10 (11.00, 13.45)</td>
<td headers="stat_2" class="gt_row gt_center">12.20 (11.10, 13.60)</td>
<td headers="stat_3" class="gt_row gt_center">12.40 (11.18, 13.63)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Missing</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">266</td>
<td headers="stat_1" class="gt_row gt_center">69</td>
<td headers="stat_2" class="gt_row gt_center">141</td>
<td headers="stat_3" class="gt_row gt_center">56</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Body Mass Index (kg/m^2)</td>
<td headers="n" class="gt_row gt_center">1,466</td>
<td headers="stat_0" class="gt_row gt_center">26.3 (23.5, 30.1)</td>
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
<td headers="stat_1" class="gt_row gt_center">133 (89, 217)</td>
<td headers="stat_2" class="gt_row gt_center">116 (85, 195)</td>
<td headers="stat_3" class="gt_row gt_center">122 (88, 210)</td></tr>
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
      <td class="gt_footnote" colspan="6"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span> <span class='gt_from_md'>Median (IQR); n (%)</span></td>
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
## ℹ As a usage guide, the code below re-creates the current column headers.
```

```
## modify_header(
##   label = '**Characteristic**',
##   n = '**N**',
##   stat_0 = '**Overall**, N = 1,499',
##   stat_1 = '**A: IFL**, N = 428',
##   stat_2 = '**F: FOLFOX**, N = 691',
##   stat_3 = '**G: IROX**, N = 380'
## )
```

```
## 
## 
## Column Name   Column Header          
## ------------  -----------------------
## label         **Characteristic**     
## n             **N**                  
## stat_0        **Overall**, N = 1,499 
## stat_1        **A: IFL**, N = 428    
## stat_2        **F: FOLFOX**, N = 691 
## stat_3        **G: IROX**, N = 380
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

```{=html}
<div id="rmawhwpuxw" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#rmawhwpuxw table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#rmawhwpuxw thead, #rmawhwpuxw tbody, #rmawhwpuxw tfoot, #rmawhwpuxw tr, #rmawhwpuxw td, #rmawhwpuxw th {
  border-style: none;
}

#rmawhwpuxw p {
  margin: 0;
  padding: 0;
}

#rmawhwpuxw .gt_table {
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

#rmawhwpuxw .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#rmawhwpuxw .gt_title {
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

#rmawhwpuxw .gt_subtitle {
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

#rmawhwpuxw .gt_heading {
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

#rmawhwpuxw .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#rmawhwpuxw .gt_col_headings {
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

#rmawhwpuxw .gt_col_heading {
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

#rmawhwpuxw .gt_column_spanner_outer {
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

#rmawhwpuxw .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#rmawhwpuxw .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#rmawhwpuxw .gt_column_spanner {
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

#rmawhwpuxw .gt_spanner_row {
  border-bottom-style: hidden;
}

#rmawhwpuxw .gt_group_heading {
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

#rmawhwpuxw .gt_empty_group_heading {
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

#rmawhwpuxw .gt_from_md > :first-child {
  margin-top: 0;
}

#rmawhwpuxw .gt_from_md > :last-child {
  margin-bottom: 0;
}

#rmawhwpuxw .gt_row {
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

#rmawhwpuxw .gt_stub {
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

#rmawhwpuxw .gt_stub_row_group {
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

#rmawhwpuxw .gt_row_group_first td {
  border-top-width: 2px;
}

#rmawhwpuxw .gt_row_group_first th {
  border-top-width: 2px;
}

#rmawhwpuxw .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#rmawhwpuxw .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#rmawhwpuxw .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#rmawhwpuxw .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#rmawhwpuxw .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#rmawhwpuxw .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#rmawhwpuxw .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#rmawhwpuxw .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#rmawhwpuxw .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#rmawhwpuxw .gt_footnotes {
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

#rmawhwpuxw .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#rmawhwpuxw .gt_sourcenotes {
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

#rmawhwpuxw .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#rmawhwpuxw .gt_left {
  text-align: left;
}

#rmawhwpuxw .gt_center {
  text-align: center;
}

#rmawhwpuxw .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#rmawhwpuxw .gt_font_normal {
  font-weight: normal;
}

#rmawhwpuxw .gt_font_bold {
  font-weight: bold;
}

#rmawhwpuxw .gt_font_italic {
  font-style: italic;
}

#rmawhwpuxw .gt_super {
  font-size: 65%;
}

#rmawhwpuxw .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#rmawhwpuxw .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#rmawhwpuxw .gt_indent_1 {
  text-indent: 5px;
}

#rmawhwpuxw .gt_indent_2 {
  text-indent: 10px;
}

#rmawhwpuxw .gt_indent_3 {
  text-indent: 15px;
}

#rmawhwpuxw .gt_indent_4 {
  text-indent: 20px;
}

#rmawhwpuxw .gt_indent_5 {
  text-indent: 25px;
}

#rmawhwpuxw .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#rmawhwpuxw div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;Characteristic&lt;/strong&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>Characteristic</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;N&lt;/strong&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;Overall&lt;/strong&gt;&lt;br&gt;N = 1,499&lt;/span&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>Overall</strong><br>N = 1,499</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="3" scope="colgroup" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;Treatment Received&lt;/strong&gt;&lt;/span&gt;">
        <span class="gt_column_spanner"><span class='gt_from_md'><strong>Treatment Received</strong></span></span>
      </th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;A: IFL&lt;/strong&gt;&lt;br&gt;N = 428&lt;/span&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>A: IFL</strong><br>N = 428</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;F: FOLFOX&lt;/strong&gt;&lt;br&gt;N = 691&lt;/span&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>F: FOLFOX</strong><br>N = 691</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;G: IROX&lt;/strong&gt;&lt;br&gt;N = 380&lt;/span&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>G: IROX</strong><br>N = 380</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span></th>
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
<td headers="stat_1" class="gt_row gt_center">12.10 (11.00, 13.45)</td>
<td headers="stat_2" class="gt_row gt_center">12.20 (11.10, 13.60)</td>
<td headers="stat_3" class="gt_row gt_center">12.40 (11.18, 13.63)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Missing</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">266</td>
<td headers="stat_1" class="gt_row gt_center">69</td>
<td headers="stat_2" class="gt_row gt_center">141</td>
<td headers="stat_3" class="gt_row gt_center">56</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Body Mass Index (kg/m^2)</td>
<td headers="n" class="gt_row gt_center">1,466</td>
<td headers="stat_0" class="gt_row gt_center">26.3 (23.5, 30.1)</td>
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
<td headers="stat_1" class="gt_row gt_center">133 (89, 217)</td>
<td headers="stat_2" class="gt_row gt_center">116 (85, 195)</td>
<td headers="stat_3" class="gt_row gt_center">122 (88, 210)</td></tr>
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
      <td class="gt_footnote" colspan="6"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span> <span class='gt_from_md'>Median (IQR); n (%)</span></td>
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
<div id="nswbprlcbf" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#nswbprlcbf table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#nswbprlcbf thead, #nswbprlcbf tbody, #nswbprlcbf tfoot, #nswbprlcbf tr, #nswbprlcbf td, #nswbprlcbf th {
  border-style: none;
}

#nswbprlcbf p {
  margin: 0;
  padding: 0;
}

#nswbprlcbf .gt_table {
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

#nswbprlcbf .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#nswbprlcbf .gt_title {
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

#nswbprlcbf .gt_subtitle {
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

#nswbprlcbf .gt_heading {
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

#nswbprlcbf .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#nswbprlcbf .gt_col_headings {
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

#nswbprlcbf .gt_col_heading {
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

#nswbprlcbf .gt_column_spanner_outer {
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

#nswbprlcbf .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#nswbprlcbf .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#nswbprlcbf .gt_column_spanner {
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

#nswbprlcbf .gt_spanner_row {
  border-bottom-style: hidden;
}

#nswbprlcbf .gt_group_heading {
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

#nswbprlcbf .gt_empty_group_heading {
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

#nswbprlcbf .gt_from_md > :first-child {
  margin-top: 0;
}

#nswbprlcbf .gt_from_md > :last-child {
  margin-bottom: 0;
}

#nswbprlcbf .gt_row {
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

#nswbprlcbf .gt_stub {
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

#nswbprlcbf .gt_stub_row_group {
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

#nswbprlcbf .gt_row_group_first td {
  border-top-width: 2px;
}

#nswbprlcbf .gt_row_group_first th {
  border-top-width: 2px;
}

#nswbprlcbf .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#nswbprlcbf .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#nswbprlcbf .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#nswbprlcbf .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#nswbprlcbf .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#nswbprlcbf .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#nswbprlcbf .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#nswbprlcbf .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#nswbprlcbf .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#nswbprlcbf .gt_footnotes {
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

#nswbprlcbf .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#nswbprlcbf .gt_sourcenotes {
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

#nswbprlcbf .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#nswbprlcbf .gt_left {
  text-align: left;
}

#nswbprlcbf .gt_center {
  text-align: center;
}

#nswbprlcbf .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#nswbprlcbf .gt_font_normal {
  font-weight: normal;
}

#nswbprlcbf .gt_font_bold {
  font-weight: bold;
}

#nswbprlcbf .gt_font_italic {
  font-style: italic;
}

#nswbprlcbf .gt_super {
  font-size: 65%;
}

#nswbprlcbf .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#nswbprlcbf .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#nswbprlcbf .gt_indent_1 {
  text-indent: 5px;
}

#nswbprlcbf .gt_indent_2 {
  text-indent: 10px;
}

#nswbprlcbf .gt_indent_3 {
  text-indent: 15px;
}

#nswbprlcbf .gt_indent_4 {
  text-indent: 20px;
}

#nswbprlcbf .gt_indent_5 {
  text-indent: 25px;
}

#nswbprlcbf .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#nswbprlcbf div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;Characteristic&lt;/strong&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>Characteristic</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;N&lt;/strong&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;Overall&lt;/strong&gt;, N = 1,499&lt;/span&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>Overall</strong>, N = 1,499</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="3" scope="colgroup" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;Treatment Received&lt;/strong&gt;&lt;/span&gt;">
        <span class="gt_column_spanner"><span class='gt_from_md'><strong>Treatment Received</strong></span></span>
      </th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;A: IFL&lt;/strong&gt;, N = 428&lt;/span&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>A: IFL</strong>, N = 428</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;F: FOLFOX&lt;/strong&gt;, N = 691&lt;/span&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>F: FOLFOX</strong>, N = 691</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;G: IROX&lt;/strong&gt;, N = 380&lt;/span&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>G: IROX</strong>, N = 380</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span></th>
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
<td headers="stat_1" class="gt_row gt_center">12.10 (11.00, 13.45)</td>
<td headers="stat_2" class="gt_row gt_center">12.20 (11.10, 13.60)</td>
<td headers="stat_3" class="gt_row gt_center">12.40 (11.18, 13.63)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Missing</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">266</td>
<td headers="stat_1" class="gt_row gt_center">69</td>
<td headers="stat_2" class="gt_row gt_center">141</td>
<td headers="stat_3" class="gt_row gt_center">56</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Body Mass Index (kg/m^2)</td>
<td headers="n" class="gt_row gt_center">1,466</td>
<td headers="stat_0" class="gt_row gt_center">26.3 (23.5, 30.1)</td>
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
<td headers="stat_1" class="gt_row gt_center">133 (89, 217)</td>
<td headers="stat_2" class="gt_row gt_center">116 (85, 195)</td>
<td headers="stat_3" class="gt_row gt_center">122 (88, 210)</td></tr>
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
      <td class="gt_footnote" colspan="6"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span> <span class='gt_from_md'>Median (IQR); n (%)</span></td>
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
<div id="jtzjdnnfhr" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#jtzjdnnfhr table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#jtzjdnnfhr thead, #jtzjdnnfhr tbody, #jtzjdnnfhr tfoot, #jtzjdnnfhr tr, #jtzjdnnfhr td, #jtzjdnnfhr th {
  border-style: none;
}

#jtzjdnnfhr p {
  margin: 0;
  padding: 0;
}

#jtzjdnnfhr .gt_table {
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

#jtzjdnnfhr .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#jtzjdnnfhr .gt_title {
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

#jtzjdnnfhr .gt_subtitle {
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

#jtzjdnnfhr .gt_heading {
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

#jtzjdnnfhr .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#jtzjdnnfhr .gt_col_headings {
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

#jtzjdnnfhr .gt_col_heading {
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

#jtzjdnnfhr .gt_column_spanner_outer {
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

#jtzjdnnfhr .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#jtzjdnnfhr .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#jtzjdnnfhr .gt_column_spanner {
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

#jtzjdnnfhr .gt_spanner_row {
  border-bottom-style: hidden;
}

#jtzjdnnfhr .gt_group_heading {
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

#jtzjdnnfhr .gt_empty_group_heading {
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

#jtzjdnnfhr .gt_from_md > :first-child {
  margin-top: 0;
}

#jtzjdnnfhr .gt_from_md > :last-child {
  margin-bottom: 0;
}

#jtzjdnnfhr .gt_row {
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

#jtzjdnnfhr .gt_stub {
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

#jtzjdnnfhr .gt_stub_row_group {
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

#jtzjdnnfhr .gt_row_group_first td {
  border-top-width: 2px;
}

#jtzjdnnfhr .gt_row_group_first th {
  border-top-width: 2px;
}

#jtzjdnnfhr .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#jtzjdnnfhr .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#jtzjdnnfhr .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#jtzjdnnfhr .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#jtzjdnnfhr .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#jtzjdnnfhr .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#jtzjdnnfhr .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#jtzjdnnfhr .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#jtzjdnnfhr .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#jtzjdnnfhr .gt_footnotes {
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

#jtzjdnnfhr .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#jtzjdnnfhr .gt_sourcenotes {
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

#jtzjdnnfhr .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#jtzjdnnfhr .gt_left {
  text-align: left;
}

#jtzjdnnfhr .gt_center {
  text-align: center;
}

#jtzjdnnfhr .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#jtzjdnnfhr .gt_font_normal {
  font-weight: normal;
}

#jtzjdnnfhr .gt_font_bold {
  font-weight: bold;
}

#jtzjdnnfhr .gt_font_italic {
  font-style: italic;
}

#jtzjdnnfhr .gt_super {
  font-size: 65%;
}

#jtzjdnnfhr .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#jtzjdnnfhr .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#jtzjdnnfhr .gt_indent_1 {
  text-indent: 5px;
}

#jtzjdnnfhr .gt_indent_2 {
  text-indent: 10px;
}

#jtzjdnnfhr .gt_indent_3 {
  text-indent: 15px;
}

#jtzjdnnfhr .gt_indent_4 {
  text-indent: 20px;
}

#jtzjdnnfhr .gt_indent_5 {
  text-indent: 25px;
}

#jtzjdnnfhr .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#jtzjdnnfhr div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;Characteristic&lt;/strong&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>Characteristic</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;Drug A&lt;/strong&gt;, N = 98&lt;/span&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>Drug A</strong>, N = 98</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;Drug B&lt;/strong&gt;, N = 102&lt;/span&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>Drug B</strong>, N = 102</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left">Age</td>
<td headers="stat_1" class="gt_row gt_center">46 (37, 59)</td>
<td headers="stat_2" class="gt_row gt_center">48 (39, 56)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Missing</td>
<td headers="stat_1" class="gt_row gt_center">7</td>
<td headers="stat_2" class="gt_row gt_center">4</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Marker Level (ng/mL)</td>
<td headers="stat_1" class="gt_row gt_center">0.84 (0.24, 1.57)</td>
<td headers="stat_2" class="gt_row gt_center">0.52 (0.19, 1.20)</td></tr>
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
      <td class="gt_footnote" colspan="3"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span> <span class='gt_from_md'>Median (IQR); n (%)</span></td>
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
<div id="alrbldscng" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#alrbldscng table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#alrbldscng thead, #alrbldscng tbody, #alrbldscng tfoot, #alrbldscng tr, #alrbldscng td, #alrbldscng th {
  border-style: none;
}

#alrbldscng p {
  margin: 0;
  padding: 0;
}

#alrbldscng .gt_table {
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

#alrbldscng .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#alrbldscng .gt_title {
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

#alrbldscng .gt_subtitle {
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

#alrbldscng .gt_heading {
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

#alrbldscng .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#alrbldscng .gt_col_headings {
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

#alrbldscng .gt_col_heading {
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

#alrbldscng .gt_column_spanner_outer {
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

#alrbldscng .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#alrbldscng .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#alrbldscng .gt_column_spanner {
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

#alrbldscng .gt_spanner_row {
  border-bottom-style: hidden;
}

#alrbldscng .gt_group_heading {
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

#alrbldscng .gt_empty_group_heading {
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

#alrbldscng .gt_from_md > :first-child {
  margin-top: 0;
}

#alrbldscng .gt_from_md > :last-child {
  margin-bottom: 0;
}

#alrbldscng .gt_row {
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

#alrbldscng .gt_stub {
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

#alrbldscng .gt_stub_row_group {
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

#alrbldscng .gt_row_group_first td {
  border-top-width: 2px;
}

#alrbldscng .gt_row_group_first th {
  border-top-width: 2px;
}

#alrbldscng .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#alrbldscng .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#alrbldscng .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#alrbldscng .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#alrbldscng .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#alrbldscng .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#alrbldscng .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#alrbldscng .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#alrbldscng .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#alrbldscng .gt_footnotes {
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

#alrbldscng .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#alrbldscng .gt_sourcenotes {
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

#alrbldscng .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#alrbldscng .gt_left {
  text-align: left;
}

#alrbldscng .gt_center {
  text-align: center;
}

#alrbldscng .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#alrbldscng .gt_font_normal {
  font-weight: normal;
}

#alrbldscng .gt_font_bold {
  font-weight: bold;
}

#alrbldscng .gt_font_italic {
  font-style: italic;
}

#alrbldscng .gt_super {
  font-size: 65%;
}

#alrbldscng .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#alrbldscng .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#alrbldscng .gt_indent_1 {
  text-indent: 5px;
}

#alrbldscng .gt_indent_2 {
  text-indent: 10px;
}

#alrbldscng .gt_indent_3 {
  text-indent: 15px;
}

#alrbldscng .gt_indent_4 {
  text-indent: 20px;
}

#alrbldscng .gt_indent_5 {
  text-indent: 25px;
}

#alrbldscng .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#alrbldscng div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;Characteristic&lt;/strong&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>Characteristic</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;N&lt;/strong&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;Overall&lt;/strong&gt;, N = 200&lt;/span&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>Overall</strong>, N = 200</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;Drug A&lt;/strong&gt;, N = 98&lt;/span&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>Drug A</strong>, N = 98</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;Drug B&lt;/strong&gt;, N = 102&lt;/span&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>Drug B</strong>, N = 102</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Age</td>
<td headers="n" class="gt_row gt_center">189</td>
<td headers="stat_0" class="gt_row gt_center">47 (38, 57)</td>
<td headers="stat_1" class="gt_row gt_center">46 (37, 59)</td>
<td headers="stat_2" class="gt_row gt_center">48 (39, 56)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Missing</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">11</td>
<td headers="stat_1" class="gt_row gt_center">7</td>
<td headers="stat_2" class="gt_row gt_center">4</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Marker Level (ng/mL)</td>
<td headers="n" class="gt_row gt_center">190</td>
<td headers="stat_0" class="gt_row gt_center">0.64 (0.22, 1.39)</td>
<td headers="stat_1" class="gt_row gt_center">0.84 (0.24, 1.57)</td>
<td headers="stat_2" class="gt_row gt_center">0.52 (0.19, 1.20)</td></tr>
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
      <td class="gt_footnote" colspan="5"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span> <span class='gt_from_md'>Median (IQR); n (%)</span></td>
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
<div id="kkuisycqxh" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#kkuisycqxh table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#kkuisycqxh thead, #kkuisycqxh tbody, #kkuisycqxh tfoot, #kkuisycqxh tr, #kkuisycqxh td, #kkuisycqxh th {
  border-style: none;
}

#kkuisycqxh p {
  margin: 0;
  padding: 0;
}

#kkuisycqxh .gt_table {
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

#kkuisycqxh .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#kkuisycqxh .gt_title {
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

#kkuisycqxh .gt_subtitle {
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

#kkuisycqxh .gt_heading {
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

#kkuisycqxh .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#kkuisycqxh .gt_col_headings {
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

#kkuisycqxh .gt_col_heading {
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

#kkuisycqxh .gt_column_spanner_outer {
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

#kkuisycqxh .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#kkuisycqxh .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#kkuisycqxh .gt_column_spanner {
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

#kkuisycqxh .gt_spanner_row {
  border-bottom-style: hidden;
}

#kkuisycqxh .gt_group_heading {
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

#kkuisycqxh .gt_empty_group_heading {
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

#kkuisycqxh .gt_from_md > :first-child {
  margin-top: 0;
}

#kkuisycqxh .gt_from_md > :last-child {
  margin-bottom: 0;
}

#kkuisycqxh .gt_row {
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

#kkuisycqxh .gt_stub {
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

#kkuisycqxh .gt_stub_row_group {
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

#kkuisycqxh .gt_row_group_first td {
  border-top-width: 2px;
}

#kkuisycqxh .gt_row_group_first th {
  border-top-width: 2px;
}

#kkuisycqxh .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#kkuisycqxh .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#kkuisycqxh .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#kkuisycqxh .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#kkuisycqxh .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#kkuisycqxh .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#kkuisycqxh .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#kkuisycqxh .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#kkuisycqxh .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#kkuisycqxh .gt_footnotes {
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

#kkuisycqxh .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#kkuisycqxh .gt_sourcenotes {
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

#kkuisycqxh .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#kkuisycqxh .gt_left {
  text-align: left;
}

#kkuisycqxh .gt_center {
  text-align: center;
}

#kkuisycqxh .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#kkuisycqxh .gt_font_normal {
  font-weight: normal;
}

#kkuisycqxh .gt_font_bold {
  font-weight: bold;
}

#kkuisycqxh .gt_font_italic {
  font-style: italic;
}

#kkuisycqxh .gt_super {
  font-size: 65%;
}

#kkuisycqxh .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#kkuisycqxh .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#kkuisycqxh .gt_indent_1 {
  text-indent: 5px;
}

#kkuisycqxh .gt_indent_2 {
  text-indent: 10px;
}

#kkuisycqxh .gt_indent_3 {
  text-indent: 15px;
}

#kkuisycqxh .gt_indent_4 {
  text-indent: 20px;
}

#kkuisycqxh .gt_indent_5 {
  text-indent: 25px;
}

#kkuisycqxh .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#kkuisycqxh div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;Participant&lt;br&gt;Characteristic&lt;/strong&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>Participant<br>Characteristic</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;N&lt;/strong&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;Overall&lt;/strong&gt;&lt;br&gt;N = 200&lt;/span&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>Overall</strong><br>N = 200</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;Treatment Arm&lt;/strong&gt;&lt;/span&gt;">
        <span class="gt_column_spanner"><span class='gt_from_md'><strong>Treatment Arm</strong></span></span>
      </th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;Drug A&lt;/strong&gt;&lt;br&gt;N = 98&lt;/span&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>Drug A</strong><br>N = 98</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;Drug B&lt;/strong&gt;&lt;br&gt;N = 102&lt;/span&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>Drug B</strong><br>N = 102</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Age</td>
<td headers="n" class="gt_row gt_center">189</td>
<td headers="stat_0" class="gt_row gt_center">47 (38, 57)</td>
<td headers="stat_1" class="gt_row gt_center">46 (37, 59)</td>
<td headers="stat_2" class="gt_row gt_center">48 (39, 56)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Missing</td>
<td headers="n" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center">11</td>
<td headers="stat_1" class="gt_row gt_center">7</td>
<td headers="stat_2" class="gt_row gt_center">4</td></tr>
    <tr><td headers="label" class="gt_row gt_left" style="font-weight: bold;">Marker Level (ng/mL)</td>
<td headers="n" class="gt_row gt_center">190</td>
<td headers="stat_0" class="gt_row gt_center">0.64 (0.22, 1.39)</td>
<td headers="stat_1" class="gt_row gt_center">0.84 (0.24, 1.57)</td>
<td headers="stat_2" class="gt_row gt_center">0.52 (0.19, 1.20)</td></tr>
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
      <td class="gt_footnote" colspan="5"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span> <span class='gt_from_md'>Median (IQR); n (%)</span></td>
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
<div id="bsesnnjtnb" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#bsesnnjtnb table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#bsesnnjtnb thead, #bsesnnjtnb tbody, #bsesnnjtnb tfoot, #bsesnnjtnb tr, #bsesnnjtnb td, #bsesnnjtnb th {
  border-style: none;
}

#bsesnnjtnb p {
  margin: 0;
  padding: 0;
}

#bsesnnjtnb .gt_table {
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

#bsesnnjtnb .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#bsesnnjtnb .gt_title {
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

#bsesnnjtnb .gt_subtitle {
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

#bsesnnjtnb .gt_heading {
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

#bsesnnjtnb .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#bsesnnjtnb .gt_col_headings {
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

#bsesnnjtnb .gt_col_heading {
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

#bsesnnjtnb .gt_column_spanner_outer {
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

#bsesnnjtnb .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#bsesnnjtnb .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#bsesnnjtnb .gt_column_spanner {
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

#bsesnnjtnb .gt_spanner_row {
  border-bottom-style: hidden;
}

#bsesnnjtnb .gt_group_heading {
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

#bsesnnjtnb .gt_empty_group_heading {
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

#bsesnnjtnb .gt_from_md > :first-child {
  margin-top: 0;
}

#bsesnnjtnb .gt_from_md > :last-child {
  margin-bottom: 0;
}

#bsesnnjtnb .gt_row {
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

#bsesnnjtnb .gt_stub {
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

#bsesnnjtnb .gt_stub_row_group {
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

#bsesnnjtnb .gt_row_group_first td {
  border-top-width: 2px;
}

#bsesnnjtnb .gt_row_group_first th {
  border-top-width: 2px;
}

#bsesnnjtnb .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#bsesnnjtnb .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#bsesnnjtnb .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#bsesnnjtnb .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#bsesnnjtnb .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#bsesnnjtnb .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#bsesnnjtnb .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#bsesnnjtnb .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#bsesnnjtnb .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#bsesnnjtnb .gt_footnotes {
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

#bsesnnjtnb .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#bsesnnjtnb .gt_sourcenotes {
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

#bsesnnjtnb .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#bsesnnjtnb .gt_left {
  text-align: left;
}

#bsesnnjtnb .gt_center {
  text-align: center;
}

#bsesnnjtnb .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#bsesnnjtnb .gt_font_normal {
  font-weight: normal;
}

#bsesnnjtnb .gt_font_bold {
  font-weight: bold;
}

#bsesnnjtnb .gt_font_italic {
  font-style: italic;
}

#bsesnnjtnb .gt_super {
  font-size: 65%;
}

#bsesnnjtnb .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#bsesnnjtnb .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#bsesnnjtnb .gt_indent_1 {
  text-indent: 5px;
}

#bsesnnjtnb .gt_indent_2 {
  text-indent: 10px;
}

#bsesnnjtnb .gt_indent_3 {
  text-indent: 15px;
}

#bsesnnjtnb .gt_indent_4 {
  text-indent: 20px;
}

#bsesnnjtnb .gt_indent_5 {
  text-indent: 25px;
}

#bsesnnjtnb .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#bsesnnjtnb div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;Participant&lt;br&gt;Characteristic&lt;/strong&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>Participant<br>Characteristic</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;N&lt;/strong&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;Overall&lt;/strong&gt;&lt;br&gt;N = 200&lt;/span&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>Overall</strong><br>N = 200</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;Treatment Arm&lt;/strong&gt;&lt;/span&gt;">
        <span class="gt_column_spanner"><span class='gt_from_md'><strong>Treatment Arm</strong></span></span>
      </th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;Drug A&lt;/strong&gt;&lt;br&gt;N = 98&lt;/span&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>Drug A</strong><br>N = 98</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;Drug B&lt;/strong&gt;&lt;br&gt;N = 102&lt;/span&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>Drug B</strong><br>N = 102</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span></th>
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
      <td class="gt_footnote" colspan="5"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span> <span class='gt_from_md'>Mean (SD); n / N (%)</span></td>
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
<div id="fjtgzcgzpt" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#fjtgzcgzpt table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#fjtgzcgzpt thead, #fjtgzcgzpt tbody, #fjtgzcgzpt tfoot, #fjtgzcgzpt tr, #fjtgzcgzpt td, #fjtgzcgzpt th {
  border-style: none;
}

#fjtgzcgzpt p {
  margin: 0;
  padding: 0;
}

#fjtgzcgzpt .gt_table {
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

#fjtgzcgzpt .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#fjtgzcgzpt .gt_title {
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

#fjtgzcgzpt .gt_subtitle {
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

#fjtgzcgzpt .gt_heading {
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

#fjtgzcgzpt .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#fjtgzcgzpt .gt_col_headings {
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

#fjtgzcgzpt .gt_col_heading {
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

#fjtgzcgzpt .gt_column_spanner_outer {
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

#fjtgzcgzpt .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#fjtgzcgzpt .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#fjtgzcgzpt .gt_column_spanner {
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

#fjtgzcgzpt .gt_spanner_row {
  border-bottom-style: hidden;
}

#fjtgzcgzpt .gt_group_heading {
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

#fjtgzcgzpt .gt_empty_group_heading {
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

#fjtgzcgzpt .gt_from_md > :first-child {
  margin-top: 0;
}

#fjtgzcgzpt .gt_from_md > :last-child {
  margin-bottom: 0;
}

#fjtgzcgzpt .gt_row {
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

#fjtgzcgzpt .gt_stub {
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

#fjtgzcgzpt .gt_stub_row_group {
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

#fjtgzcgzpt .gt_row_group_first td {
  border-top-width: 2px;
}

#fjtgzcgzpt .gt_row_group_first th {
  border-top-width: 2px;
}

#fjtgzcgzpt .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#fjtgzcgzpt .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#fjtgzcgzpt .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#fjtgzcgzpt .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#fjtgzcgzpt .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#fjtgzcgzpt .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#fjtgzcgzpt .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#fjtgzcgzpt .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#fjtgzcgzpt .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#fjtgzcgzpt .gt_footnotes {
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

#fjtgzcgzpt .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#fjtgzcgzpt .gt_sourcenotes {
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

#fjtgzcgzpt .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#fjtgzcgzpt .gt_left {
  text-align: left;
}

#fjtgzcgzpt .gt_center {
  text-align: center;
}

#fjtgzcgzpt .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#fjtgzcgzpt .gt_font_normal {
  font-weight: normal;
}

#fjtgzcgzpt .gt_font_bold {
  font-weight: bold;
}

#fjtgzcgzpt .gt_font_italic {
  font-style: italic;
}

#fjtgzcgzpt .gt_super {
  font-size: 65%;
}

#fjtgzcgzpt .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#fjtgzcgzpt .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#fjtgzcgzpt .gt_indent_1 {
  text-indent: 5px;
}

#fjtgzcgzpt .gt_indent_2 {
  text-indent: 10px;
}

#fjtgzcgzpt .gt_indent_3 {
  text-indent: 15px;
}

#fjtgzcgzpt .gt_indent_4 {
  text-indent: 20px;
}

#fjtgzcgzpt .gt_indent_5 {
  text-indent: 25px;
}

#fjtgzcgzpt .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#fjtgzcgzpt div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;Participant&lt;br&gt;Characteristic&lt;/strong&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>Participant<br>Characteristic</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;N&lt;/strong&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>N</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="2" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;Overall&lt;/strong&gt;&lt;br&gt;N = 107&lt;/span&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>Overall</strong><br>N = 107</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;Treatment Arm&lt;/strong&gt;&lt;/span&gt;">
        <span class="gt_column_spanner"><span class='gt_from_md'><strong>Treatment Arm</strong></span></span>
      </th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;Control&lt;/strong&gt;&lt;br&gt;N = 52&lt;/span&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>Control</strong><br>N = 52</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;span class='gt_from_md'&gt;&lt;strong&gt;Streptomycin&lt;/strong&gt;&lt;br&gt;N = 55&lt;/span&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><span class='gt_from_md'><strong>Streptomycin</strong><br>N = 55</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span></th>
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
      <td class="gt_footnote" colspan="5"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height: 0;"><sup>1</sup></span> <span class='gt_from_md'>n (%)</span></td>
    </tr>
  </tfoot>
</table>
</div>
```


</div>

