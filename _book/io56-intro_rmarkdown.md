---
title: "Introduction to Rmarkdown"
author: "Peter Higgins"
date: "11/18/2021"
output: html_document
editor_options: 
  markdown: 
    wrap: 72
---



# Introduction to R Markdown

![Rmarkdown Wizards, courtesy of Alison
Horst](images/rmarkdown_wizards-2.png)

Rmarkdown is an authoring framework for creating a variety of
data-driven documents reproducibly with R. This e-book is itself a set
of RMarkdown documents, assembled with the {bookdown} package. In many
ways, Rmarkdown is a critical package for the R ecosystem, as it is a
key enabler of reproducible reports in many formats. RMarkdown is a
simple formatting syntax that allows you to mix text and code to
document data analysis, and author MS Word, MS Powerpoint, HTML, PDF,
web dashboards, web apps, and poster documents. Rmarkdown documents are
fully reproducible and support more than a dozen output formats. If your
data changes, or you decide to change a part of your analysis, you can
reproduce the entire (new version) of the document with a single click
of the **Knit** button (You can also use Cmd/Ctrl+Shift+K). This button
is found at the top of the top left pane in RStudio.

![Knit button](images/knit_button.png)

When you click the **Knit** button a document will be generated that
includes both text content as well as the output of any embedded R code
chunks within the document. You can embed an R code chunk like this
(which will run and produce output below. In this case, showing the
contents of the covid_testing dataset.):


```r
covid <- medicaldata::covid_testing
glimpse(covid)
```

```
## Rows: 15,524
## Columns: 17
## $ subject_id      <dbl> 1412, 533, 9134, 8518, 8967, 11048…
## $ fake_first_name <chr> "jhezane", "penny", "grunt", "meli…
## $ fake_last_name  <chr> "westerling", "targaryen", "rivers…
## $ gender          <chr> "female", "female", "male", "femal…
## $ pan_day         <dbl> 4, 7, 7, 8, 8, 8, 9, 9, 9, 9, 9, 9…
## $ test_id         <chr> "covid", "covid", "covid", "covid"…
## $ clinic_name     <chr> "inpatient ward a", "clinical lab"…
## $ result          <chr> "negative", "negative", "negative"…
## $ demo_group      <chr> "patient", "patient", "patient", "…
## $ age             <dbl> 0.0, 0.0, 0.8, 0.8, 0.8, 0.8, 0.8,…
## $ drive_thru_ind  <dbl> 0, 1, 1, 1, 0, 0, 1, 0, 1, 1, 1, 0…
## $ ct_result       <dbl> 45, 45, 45, 45, 45, 45, 45, 45, 45…
## $ orderset        <dbl> 0, 0, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1…
## $ payor_group     <chr> "government", "commercial", NA, NA…
## $ patient_class   <chr> "inpatient", "not applicable", NA,…
## $ col_rec_tat     <dbl> 1.4, 2.3, 7.3, 5.8, 1.2, 1.4, 2.6,…
## $ rec_ver_tat     <dbl> 5.2, 5.8, 4.7, 5.0, 6.4, 7.0, 4.2,…
```

The **Knit** button (at the top of the top left pane of RStudio) runs
<br> `render("file.Rmd", output = document-type)` <br> for you in a
background (clean) session of R.

## What Makes an Rmarkdown document?

An Rmarkdown document is a plain-text file with the \*.Rmd file
extension. It is composed of four types of content:

-   The YAML header (at the top), surrounded at top and bottom by 3
    dashes (---)

-   Text narrative - the meat of your manuscript

-   Code chunks, surrounded at top and bottom by 3 back-ticks (\`\`\`),
    and the `chunk header` in braces, like {r plot-figure}

    -   Note that the first code chunk is always named `setup` and is
        often used to load libraries and set up document options.

-   Inline code, which does calculations in your text to provide
    calculated values like means, medians, and p values.

This essentially provides an interface like a 'lab notebook' for data
analysis. You can use code chunks to run the analysis, and text to
document what you are doing in the analysis, how it worked, and
interpret the results. When the analysis is ready, you can polish up
your document to produce a final manuscript.

Code outputs, including tables and plots, are incorporated into the
document.

You can choose to show or hide the code chunks in the final document
with options in the chunk header, like:

`{r, echo = FALSE}` - runs code, but does not show it.<br> or <br>
`{r, echo = TRUE}` - runs code and shows the code.

## Trying out RMarkdown with a Mock Manuscript

Open up RStudio.

Start a new Project. Click - File - New Project... - Version Control \>
- Git \>

Now paste the following into the `Repository URL:` box <br>

`https://github.com/higgi13425/rmd4medicine.git`

-   add a directory name, like `rmd4medicine`

-   click on `Create Project`

-   Find the Files tab in the lower right quadrant.

-   Click to open the `prep` folder

-   Click to open the `mockstudy_analysis.Rmd` file.

This file should open in the top left quadrant of RStudio. If there are
warnings at the top of the file that you need to install packages, click
on the Install button.

## Inserting Code Chunks

You can add code to your document to process your data and display
results.

To insert a code chunk into your Rmarkdown document, click on the green
`+c` button at the top center of the top left pane in RStudio.

The dropdown menu will allow you to choose R code or several other
computer languages, For now, click on R.

This inserts a gray code chunk, which starts and stops with 3
back-ticks. The starting back-ticks are followed by braces containing a
lower-case r, designating what follows as R code.

You can name your individual code chunks with specific names, based on
what they do. You can click to the right of the lower-case r, before the
closing brace, and add a space, then a name for the code chunk. If the
chunk name contains multiple words, connect these with hyphens, as in
the code chunk below. Avoid spaces, periods, and underscores in chunk
names.


```r
head(covid)
```

```
## # A tibble: 6 × 17
##   subject_id fake_f…¹ fake_…² gender pan_day test_id clini…³
##        <dbl> <chr>    <chr>   <chr>    <dbl> <chr>   <chr>  
## 1       1412 jhezane  wester… female       4 covid   inpati…
## 2        533 penny    targar… female       7 covid   clinic…
## 3       9134 grunt    rivers  male         7 covid   clinic…
## 4       8518 melisan… swyft   female       8 covid   clinic…
## 5       8967 rolley   karsta… male         8 covid   emerge…
## 6      11048 megga    karsta… female       8 covid   oncolo…
## # … with 10 more variables: result <chr>, demo_group <chr>,
## #   age <dbl>, drive_thru_ind <dbl>, ct_result <dbl>,
## #   orderset <dbl>, payor_group <chr>, patient_class <chr>,
## #   col_rec_tat <dbl>, rec_ver_tat <dbl>, and abbreviated
## #   variable names ¹​fake_first_name, ²​fake_last_name,
## #   ³​clinic_name
```

### Code Chunk Icons

You may have noticed 3 small icons at the top right of each code chunk.
From left to right, these are a (settings) gear, a downward arrowhead
with a green baseline (run all of the preceding chunks), and a rightward
(run) arrow. Check these out and experiment with them.

+------------------------------+------------------------------------+
| Icon                         | Uses                               |
+==============================+====================================+
| Settings Gear                | Allows you to                      |
|                              |                                    |
|                              | -   Name the code chunk            |
|                              |                                    |
|                              | -   Set options for this chunk     |
+------------------------------+------------------------------------+
| Run Chunks Above (down       | Runs all of the preceding code     |
| arrow)                       | chunks, including the setup chunk  |
+------------------------------+------------------------------------+
| Run Chunk (rightward arrow)  | Runs the entire current chunk      |
+------------------------------+------------------------------------+

: Code Chunk Icons

## Including Plots

You can also embed plots using code chunks, for example:


```r
covid %>% 
  ggplot() +
  aes(x = pan_day, y = ct_result) +
  geom_point() +
  labs(title = "COVID Testing in First 100 Days of Pandemic",
       x = "Pandemic Day, 2020",
       y = "Cycle Threshold \n45 is a Negative Test")
```

<img src="io56-intro_rmarkdown_files/figure-html/plot-1.png" width="672" />

Note that the `echo = FALSE` parameter was added to the top of the
`plot` code chunk to prevent printing of the R code that generated the
plot. This is an example of a chunk option.

## Including Tables

You can also use code chunks to include tables in your document.


```r
covid %>% 
  count(demo_group, gender) %>% 
  gt() %>% 
  tab_header(title = "Demographics of COVID Testing",
             subtitle = "By Group and Gender") %>% 
  tab_source_note(source_note = "From CHOP, 2020") %>% 
  cols_label(demo_group = "Group",
             gender = "Gender",
             n = "Count")
```

```{=html}
<div id="ztehnvpryv" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#ztehnvpryv .gt_table {
  display: table;
  border-collapse: collapse;
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

#ztehnvpryv .gt_heading {
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

#ztehnvpryv .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#ztehnvpryv .gt_title {
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

#ztehnvpryv .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#ztehnvpryv .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ztehnvpryv .gt_col_headings {
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

#ztehnvpryv .gt_col_heading {
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

#ztehnvpryv .gt_column_spanner_outer {
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

#ztehnvpryv .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#ztehnvpryv .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#ztehnvpryv .gt_column_spanner {
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

#ztehnvpryv .gt_group_heading {
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

#ztehnvpryv .gt_empty_group_heading {
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

#ztehnvpryv .gt_from_md > :first-child {
  margin-top: 0;
}

#ztehnvpryv .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ztehnvpryv .gt_row {
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

#ztehnvpryv .gt_stub {
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

#ztehnvpryv .gt_stub_row_group {
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

#ztehnvpryv .gt_row_group_first td {
  border-top-width: 2px;
}

#ztehnvpryv .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ztehnvpryv .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#ztehnvpryv .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#ztehnvpryv .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ztehnvpryv .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ztehnvpryv .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#ztehnvpryv .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#ztehnvpryv .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ztehnvpryv .gt_footnotes {
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

#ztehnvpryv .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-left: 4px;
  padding-right: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ztehnvpryv .gt_sourcenotes {
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

#ztehnvpryv .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ztehnvpryv .gt_left {
  text-align: left;
}

#ztehnvpryv .gt_center {
  text-align: center;
}

#ztehnvpryv .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ztehnvpryv .gt_font_normal {
  font-weight: normal;
}

#ztehnvpryv .gt_font_bold {
  font-weight: bold;
}

#ztehnvpryv .gt_font_italic {
  font-style: italic;
}

#ztehnvpryv .gt_super {
  font-size: 65%;
}

#ztehnvpryv .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 75%;
  vertical-align: 0.4em;
}

#ztehnvpryv .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#ztehnvpryv .gt_indent_1 {
  text-indent: 5px;
}

#ztehnvpryv .gt_indent_2 {
  text-indent: 10px;
}

#ztehnvpryv .gt_indent_3 {
  text-indent: 15px;
}

#ztehnvpryv .gt_indent_4 {
  text-indent: 20px;
}

#ztehnvpryv .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table">
  <thead class="gt_header">
    <tr>
      <td colspan="3" class="gt_heading gt_title gt_font_normal" style>Demographics of COVID Testing</td>
    </tr>
    <tr>
      <td colspan="3" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style>By Group and Gender</td>
    </tr>
  </thead>
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="Group">Group</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="Gender">Gender</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="Count">Count</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="demo_group" class="gt_row gt_left">client</td>
<td headers="gender" class="gt_row gt_left">female</td>
<td headers="n" class="gt_row gt_right">314</td></tr>
    <tr><td headers="demo_group" class="gt_row gt_left">client</td>
<td headers="gender" class="gt_row gt_left">male</td>
<td headers="n" class="gt_row gt_right">290</td></tr>
    <tr><td headers="demo_group" class="gt_row gt_left">misc adult</td>
<td headers="gender" class="gt_row gt_left">female</td>
<td headers="n" class="gt_row gt_right">1214</td></tr>
    <tr><td headers="demo_group" class="gt_row gt_left">misc adult</td>
<td headers="gender" class="gt_row gt_left">male</td>
<td headers="n" class="gt_row gt_right">1227</td></tr>
    <tr><td headers="demo_group" class="gt_row gt_left">other adult</td>
<td headers="gender" class="gt_row gt_left">female</td>
<td headers="n" class="gt_row gt_right">126</td></tr>
    <tr><td headers="demo_group" class="gt_row gt_left">other adult</td>
<td headers="gender" class="gt_row gt_left">male</td>
<td headers="n" class="gt_row gt_right">97</td></tr>
    <tr><td headers="demo_group" class="gt_row gt_left">patient</td>
<td headers="gender" class="gt_row gt_left">female</td>
<td headers="n" class="gt_row gt_right">6178</td></tr>
    <tr><td headers="demo_group" class="gt_row gt_left">patient</td>
<td headers="gender" class="gt_row gt_left">male</td>
<td headers="n" class="gt_row gt_right">6077</td></tr>
    <tr><td headers="demo_group" class="gt_row gt_left">unidentified</td>
<td headers="gender" class="gt_row gt_left">male</td>
<td headers="n" class="gt_row gt_right">1</td></tr>
  </tbody>
  <tfoot class="gt_sourcenotes">
    <tr>
      <td class="gt_sourcenote" colspan="3">From CHOP, 2020</td>
    </tr>
  </tfoot>
  
</table>
</div>
```

Note that this code chunk is using the {gt} package to format the table.
Other popular approaches to table formatting include the {flextable}
package and the `knitr::kable()` function.

## Including Links and Images

### Links

You can add hypertext links to your text (without a code chunk) with a
description in square brackets followed immediately by the URL in
(parentheses), like this:

`[text description here](http://www.link.com)`

As an example, the link to the Rmarkdown cheatsheet can be found at this
[link](https://www.rstudio.com/wp-content/uploads/2015/02/rmarkdown-cheatsheet.pdf).

### Images

You can add images to your text if they are in the same project as your
Rmarkdown document. You have to specify the path to the image file
correctly. It is often helpful to collect your images in an `images`
folder or a `figures` folder. If you have already generated your figures
with other R scripts, they can be placed into your manuscript document
from a `figures` folder.

You can add images to your text with an exclamation point, followed by a
caption in square brackets followed immediately by the path to the image
file in (parentheses), on a line of its own, separated from the text,
like this:

`![Caption for this Figure 1](images/figure_1.png)`

You can also insert an image using a code chunk and the knitr function
`include_image()`, like this, which gives you more options to control
figure size, alignment, height, and width with code chunk options:


```r
knitr::include_graphics('images/datasaurus-dozen.png')
```

(note that echo = TRUE and eval=FALSE as code chunk options means that
this code is shown, but not run)

An example shown below is an image of the "datasaurus dozen" used to
illustrate what summary measures can hide in data distributions, as seen
below in 12 data distributions with the same mean and standard
deviation, one of which happens to look like a T. Rex. You should always
visualize your data. There *might* be a dinosaur in there. <br>

<img src="images/datasaurus-dozen.png" width="746" />

(note that echo = FALSE and eval=TRUE as code chunk options means that
the code chunk used to include this image code is run, but not shown)

Source for Image: <https://juliasilge.com/blog/datasaurus-multiclass/>

## Other languages in code chunks

You can use a number of different open-source languages in addition to R
if needed to do your data analysis, including SQL, shell code with Unix
Bash, C, C++ via Rcpp, Stan, and D3. Any of these options can be chosen
from the Insert Code button dropdown (green +c button).

## Code Chunk Options

When you are working through a data analysis, you usually want to
display the code that led to a result. For the final manuscript, you may
want to hide the code and just display the results. You can accomplish
this with `echo=TRUE` to display code, and `echo=FALSE` to hide the
code.

Code chunk options should be added to the top of each code chunk, in the
`chunk header` after the name of the code chunk, and separated from the
chunk name (and from each other) by commas.

The chunk header (material between the braces) must be written on one
line. You must not break the line with a return, or it will not work.

+--------------+--------------+--------------------------+
| Option       | Values       | Output                   |
+==============+==============+==========================+
| eval         | TRUE/FALSE   | Whether or not the code  |
|              |              | is run.                  |
+--------------+--------------+--------------------------+
| echo         | TRUE/FALSE   | Show or hide the code    |
+--------------+--------------+--------------------------+
| include      | TRUE/FALSE   | Whether or not the       |
|              |              | resulting output of a    |
|              |              | code chunk is displayed  |
|              |              | in the document. `FALSE` |
|              |              | means that the code      |
|              |              | *will* run, but will not |
|              |              | display results.         |
|              |              | `include = FALSE` is     |
|              |              | often used for the setup |
|              |              | chunk.                   |
+--------------+--------------+--------------------------+
| warning      | TRUE/FALSE   | Whether warnings         |
|              |              | generated from your code |
|              |              | will be displayed in the |
|              |              | document.                |
+--------------+--------------+--------------------------+
| message      | TRUE/FALSE   | Whether messages         |
|              |              | generated from your code |
|              |              | will be displayed in the |
|              |              | document.                |
+--------------+--------------+--------------------------+
| fig.align    | default,     | Where on the page the    |
|              | left, right, | output figure should     |
|              | center       | align. Text options      |
|              |              | should be in quotes,     |
|              |              | like\                    |
|              |              | `fig.align = "right"`    |
+--------------+--------------+--------------------------+
| fig.width    | default = 7  | figure width in inches   |
+--------------+--------------+--------------------------+
| fig .height  | default = 7  | figure height in inches  |
+--------------+--------------+--------------------------+
| error        | TRUE/FALSE   | If `TRUE`, will not stop |
|              |              | building the document if |
|              |              | there is an error in a   |
|              |              | code chunk.              |
+--------------+--------------+--------------------------+
| cache        | TRUE/FALSE   | If `TRUE`, will store    |
|              |              | the results and not      |
|              |              | re-run the chunk.        |
|              |              | Helpful for long, slow   |
|              |              | calculations. But watch  |
|              |              | out for this if your     |
|              |              | data change and your     |
|              |              | results do not(!!).      |
+--------------+--------------+--------------------------+

: Code Chunk Options

Note that there are many more chunk options which you can use if needed,
and these can be found [here](https://yihui.org/knitr/options/).

## How It All (Rmarkdown + {knitr} + Pandoc) Works

![rmarkdown processing from rstudio.com](images/rmarkdownflow.png)

Rmarkdown is an R-flavored version of the `markdown` language. This is a
universal, open-source markup language for creating formatted documents
from plain text. Markdown documents end with the file extension `*.md.`
An open-source program named `pandoc` converts \*.md documents to output
documents like MS Word, PDF, HTML, MS Powerpoint, etc.

When you click the **Knit** button or run the *render()* function, R
Markdown feeds the .Rmd file to knitr, which executes all of the code
chunks and creates a new markdown (.md) document which includes the code
and its output.

The markdown file generated by {knitr} is then processed by `pandoc`
which is responsible for creating the finished format.

This may sound complicated, but R Markdown makes it extremely simple by
encapsulating all of the above processing into a single *render()*
function (or the **Knit** button).

## Knitting and Editing (and re-Knitting() Your Rmd document

Find the Knit button at the top of the file, and click it to convert
this `*.Rmd` . It will automagically knit the document first to markdown
(to `*.md` and then from `*.md` to `*.HTML`.

Scroll through the document to see what has been created.

Go back to the Rmd document.<br>

Now try the following:

-   in the YAML header, edit the author to your name

-   edit the date to the current (or a different) date

-   edit the output from `html_document` to `word_document`

-   find the `glimpse` code chunk. After the chunk name `glimpse`, add a
    comma, then the option `echo=FALSE`

-   Add this same option to a few of of the other code chunks (feel free
    to use copy-paste, but make sure you don't end up with duplicate
    commas, as this will cause errors)

-   Now click on the **Knit** button again.

You should get a new version of the document, now in MS Word format,
with the code chunks hidden, and a new author and date. The Word
document is in a particular default format, but you can change this by
specifying a template word file in the YAML header.

::: tryit
## Try Out Other Chunk Options

Try adding different chunk options, including

-   `include = FALSE`

-   `eval = FALSE, echo = TRUE`

-   `eval=TRUE, echo = FALSE`
:::

## The `setup` chunk

The `setup` chunk is a special code chunk, which is usually the first
code chunk at the top of your RMarkdown document. Typically it includes
two types of code:

-   libraries to be loaded
-   data to be loaded in the background

and often looks something like this:


```r
library(tidyverse)
library(here)
data <- read_csv(here("data/my_data_file.csv"))
```

(note that for display purposes, I am using the chunk options
`eval = FALSE, echo = TRUE`, while in a real setup chunk, I would use
`include = FALSE`, which runs the code but does not display the code nor
the output. I also had to change the chunk name to `setup2` because only
unique chunk names are allowed).

Scroll to the `setup` chunk at the top of your Rmd document to see what
a working setup chunk looks like.

## Markdown syntax

Markdown is a popular markup language that allows you to add formatting
elements to text, including **bold**, *italics*, and `code` formatting.

We make text **Bold** by surrounding the words with double asterisks. We
make text *Italic* by surrounding the words with single underscores or
single asterisks. We make text ***Bold and Italic*** by surrounding the
words with triple underscores or triple asterisks. We can make text in
`code-font` by surrounding it with single back-ticks.

You can also format level 1 to level 5 headings. These are done by
preceding the heading (on its own line) with 1-5 hashtags.

## 2nd Header

### 3rd Header

#### 4th level Header

##### 5th level header

(note that I did not use a level 1 header, which would have forced a new
chapter in bookdown). There is only one level 1 header in this chapter -
the chapter title.

## Line Breaks and Page Breaks

If you simply hit return in your \*.Rmd document, you will see a line
break in your text. But this is only a `semantic` line break, as the
knitted document will smush these lines together.

You can create a deliberate line break by adding `2 or more spaces` to
the end of a line of text. This will work in any output format.

The downside of this is that these line breaks are not visible, until
you Knit the document.

Line breaks can be inserted (for HTML output) by<br> using <br> html
tags <br> The HTML tag for line breaks is `<br>`. But these are kind of
annoying to type, <br> and 2 spaces at the end of each line is pretty
easy, but less visible when you are looking at the text in the Rmd.

Note that you need a **blank line** before headers for them to be recognized as headers and formatted properly

## Making Lists

### Ordered Lists

You can create an ordered list by preceding items with numbers and
period:

1.  First
2.  Second
3.  Third

### Un-ordered lists

You can create an un--ordered list with the `-` `+` or `*` keys as your
leading bullets.

-   chickadee

-   carrot

-   quartz

### Nested Lists

You can create nested lists by tab-indenting with a new symbol, using
`-` for level 1, `+` for level 2, etc.

-   Birds

    -   Hawk

-   Vegetables

    -   Carrot

        -   Baby
        -   Ball
        -   Nantes

-   Minerals

    -   Gneiss

## The Easy Button - Visual Markdown Editing

While it is helpful to know all of the formatting options for headers,
italics, bold, etc. for troubleshooting, it is not as simple as a modern
word processor with menu buttons. So RStudio came up with the Visual
Markdown Editor.

This can be activated for your RMarkdown document by clicking on a
button in the top right of your Rmd document pane. It looks a bit like a
compass, or possibly an Angstrom symbol (if you were a chemistry major).

If you toggle this button to on, your Rmarkdown document now has basic
word processor functions, including live formatting - What You See Is
What You Get (WYSIWIG). A new submenu appears at the top of the
document, with buttons to select the heading level (or normal text, or
code block), as well as bold, italic, and underline. You can insert
lists, tables, block-quotes, links, citations, cross-references within a
document, images, horizontal lines, special characters, and math
equations. There is a drop-down menu to help you format tables. You can
even insert comments into a shared manuscript.

::: tryit
### Try inserting a list, a table and a block-quote

In your practice RMarkdown document, from the Rmarkdown Visual Editor
View,

-   Insert a short list of endoscopic procedures, types of dialysis, or
    interventions done through a catheter

-   Insert a small 3 column table with columns for ethnicity
    (Hispanic/Non-Hispanic), retirement status (Retired/Not Retired),
    and Count

-   Insert the following as a block quote: "Don't judge each day by the
    harvest you reap but by the seeds that you plant." *-Robert Louis
    Stevenson*
:::

## Inline Code

You will often want to insert a result into your text, like a percent
reduction in an endpoint, or a p value. Rather than copying and pasting
from somewhere else (which are prone to error, or forgetting to update),
you can do these calculations right in your text, using inline R code.
For example, if you want to say that we evaluated NN COVID PCR tests for
this study, you can calculate how many rows in your dataset with R,
right in the text.

To do this, you bracket the code with single back-ticks, and start with
the letter r immediately after the first back-tick, so that Rmarkdown
knows that R code is coming. After the lower-case `r`, you can insert
your code expression, like `nrow(covid)` to give you the number of rows
(observations). Putting this together, this looks like
`` `r nrow(covid)` ``. When you insert this in the
middle of a sentence in your text (inline code), this lets you write
sentences in your manuscript like the following, which calculate the
actual number in the text (and automatically update when your data
changes): <br> We evaluated 15524 COVID PCR tests in this
study.

::: tryit
### Try inserting some in-line R code

Try this yourself. Select the correct code to insert the proper results,
as illustrated below (note that these would be surrounded by single
back-ticks)

The mean cycle threshold in this study was
<div class='webex-radiogroup' id='radio_XDWKUENSCR'><label><input type="radio" autocomplete="off" name="radio_XDWKUENSCR" value="answer"></input> <span>r covid %>%  mean(ct_result, na.rm = TRUE) %>% format(digits = 5)</span></label><label><input type="radio" autocomplete="off" name="radio_XDWKUENSCR" value=""></input> <span>r covid %>% median(ct_result, na.rm = TRUE) %>% format(digits = 7)</span></label><label><input type="radio" autocomplete="off" name="radio_XDWKUENSCR" value=""></input> <span>r covid %>%  sd(ct_result, na.rm=TRUE) %>% format(digits =3)</span></label></div>

<br>

The standard deviation of the cycle threshold in this study was
<div class='webex-radiogroup' id='radio_TMSXKHANHZ'><label><input type="radio" autocomplete="off" name="radio_TMSXKHANHZ" value=""></input> <span>r covid %>%  mean(ct_result, na.rm = TRUE) %>% format(digits = 5)</span></label><label><input type="radio" autocomplete="off" name="radio_TMSXKHANHZ" value=""></input> <span>r covid %>% median(ct_result, na.rm = TRUE) %>% format(digits = 7)</span></label><label><input type="radio" autocomplete="off" name="radio_TMSXKHANHZ" value="answer"></input> <span>r covid %>%  sd(ct_result, na.rm=TRUE) %>% format(digits =3)</span></label></div>


<br>

Correct answers should produce this output when knit:

The mean cycle threshold in this study was
44.122 and the
standard deviation was
3.98.
:::

## A Quick Quiz

1.  Which code chunk option hides the code?
    <select class='webex-select'><option value='blank'></option><option value=''>eval = TRUE</option><option value=''>warning = FALSE</option><option value='answer'>echo = FALSE</option></select>
2.  Which code chunk always comes first, and includes libraries and data
    import steps? <select class='webex-select'><option value='blank'></option><option value=''>plot</option><option value='answer'>setup</option><option value=''>top_chunk</option></select>
3.  What is the name of the code block (and the markup language it is
    written in), set off with 3 hyphens(---) at the very top of your
    Rmarkdown document, that tells `pandoc` how to format the final
    document? <select class='webex-select'><option value='blank'></option><option value=''>HTML</option><option value='answer'>YAML</option><option value=''>SPAM</option><option value=''>formatter</option></select>
4.  What symbols do you use to make text bold in Rmarkdown?
    <select class='webex-select'><option value='blank'></option><option value=''>one asterisk</option><option value='answer'>two asterisks</option><option value=''>underscores</option><option value=''>Exclamation points</option></select>
5.  Which {knitr} function do you use to add images to your document
    with a code chunk?
    <select class='webex-select'><option value='blank'></option><option value=''>paste()</option><option value='answer'>include_image()</option><option value=''>insert()</option><option value=''>insert_pic()</option></select>
