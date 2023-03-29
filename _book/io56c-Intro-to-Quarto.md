---
title: "Introduction to Quarto"
author: "Peter Higgins"
date: "10/21/2021"
output: html_document
---



# Quarto is a Next-Generation RMarkdown

## Goals for this Chapter

-   introduce Quarto
-   Install Quarto CLI
-   Explore Quarto Features

## Packages Needed for this chapter

You will need {tidyverse}, {medicaldata}, {rmarkdown}, {flextable), {gt}, and updated versions of R and RStudio. If needed, copy the block of code below into your RStudio and run the code to load these packages. You can remove the hashtags from the `install.packages` functions to install these packages if needed.


```r
# install.packages('tidyverse')
# install.packages('medicaldata')
# install.packages('rmarkdown')
# install.packages('flextable')
# install.packages('gt')
library(tidyverse)
library(medicaldata)
library(rmarkdown)
library(flextable)
library(gt)
```

## Introducing Quarto

Quarto is the next-generation version of RMarkdown. RMarkdown grew organically, with many spinoffs (blogdown, bookdown, posterdown), with great creativity. But there was not master plan in mind, and a fair number of hacky workarounds became standard. There was some inconsistency between implementations, there was no command-line interface, the approach was specific to R, and past decisions made some new features impossible to implement.

So the folks at Posit (formerly RStudio) decided to rebuild RMarkdown from scratch with a coherent master plan, a command line interface, the ability to use many languages (including Python, bash, Julia, etc.), and pathways to more features that were not possible in RMarkdown. In many ways, Quarto documents (\*.qmd) look a lot like rmd documents. There is a familiar YAML header, text and code chunks, formatting with markdown tags, and the ability to use Pandoc to render (instead of knit) documents to a variety of output formats.

Let's take a moment to go to the [quarto page](https://quarto.org). Click on the **Get Started** button to go to the installation page.

Now click on the *Download Quarto CLI* button to download the right version of quarto for your computer. Note that installing a current version of RStudio will also install the Quarto CLI, but it is not an R package.

Installation is straightforward - go to your downloads folder, and click on the downloaded file to start the installation process. Once this is complete, and the original package moved to the trash, you are ready to open RStudio and work with Quarto documents and presentations.

## A Tour of Quarto

Quarto is an authoring framework that lets you create a variety of output documents, including HTML, MS Word, MS Powerpoint, and others, from a mix of text and code chunks. You can show (during analysis) or hide (for manuscript) code chunks, and show or hide the output. Quarto is a great way to document your background, analysis, and conclusions. It is also a useful format for collaborating and for code review. Think of it as an analytic notebook that can fold up your code and present results when needed.

You can open a New File/Quarto Document, or a New File/Quarto Presentation. Your Document format options are HTML, PDF, or MS Word. The visual editor is on by default, which gives you and WYSIWYG (What You See Is What You Get) environment, like MS Word or Google Docs. You can also switch to the source editor for more control of formatting.

## Opening a New Quarto Document

Try this yourself - in RStudio, open New File/Quarto Document, and select HTML as the format. Give it a title and author, then click the `Create` button.

The default document starts with a YAML chunk, which controls the document output and global options, which looks something like this:


```r
---
title: "Prostate data"
date: 2022-09-12
format: html
---
```

The rest of the document consists of explanatory text and code chunks. The explanatory text can be formatted in the Visual Editor (as in MS Word) or in the source editor with markdown tags for bold, italic, etc.

## Annotating code in Quarto

There are many times that you want to annotate code for collaborators or for your future self. This can be a bit clunky if mixed in with the code. Annotation of code can be done more neatly with Quarto.

You first add the code-annotations style to the YAML header as shown below (options - below, hover, or select), <br>
then add comments as numbers between angle brackets (you can apply the same number to more than one line),
then detail the numbers with full comments below the code chunk, as shown below


```r
---
# Add to YAML header
code-annotations: hover
---
library(tidyverse)
library(medicaldata)
medicaldata::abm |>                         #<1>
  mutate(gluc_ratio = csf_gluc/blood_gluc,  #<2>
         wbc_ratio = csf_wbc/blood_wbc)     #<2>
```
1. Take the abm dataset, and then
2. add new columns for glucose and wbc ratio

Then, when you hover over the comment number, the text comment is shown.
The select option requires clicking the number.

This requires at least Quarto version >= 1.3, and when rendered, looks like this (with the annotation markers that you can hover over circled in red in this case):

![Quarto code annotation](images/Quarto_code_annotation.png)

## The Visual Editor vs. Source Editor in Quarto

When the Visual Editor is activated by its toggle button, you will see a toolbar at the top of your source pane that looks like this:

![The Quarto Visual Editor](images/Visual%20Editor%20Quarto.png){fig-alt="Quarto Visual Editor"} This allows you to easily apply bold, italic, or code formatting, insert headers of several levels, bulleted or numbered lists, links, images, or tables. <br> The Source Editor toggle button gives you a display that is not as pretty, but it shows all the markdown tags, and gives you finer control of formatting, and looks more like this:


```r
## Text formatting

*italic* **bold** ~~strikeout~~ `code`

superscript^2^ subscript~2~

[underline]{.underline} [small caps]{.smallcaps}

## Headings

# 1st Level Header

## 2nd Level Header

### 3rd Level Header

## Lists

-   Bulleted list item 1

-   Item 2

    -   Item 2a

    -   Item 2b

1.  Numbered list item 1

2.  Item 2.
    The numbers are incremented automatically in the output.

## Links and images

<http://example.com>

[linked phrase](http://example.com)

![optional caption text](path/quarto.png){fig-alt="Quarto logo"}

## Tables

| First Header | Second Header |
|--------------|---------------|
| Content Cell | Content Cell  |
| Content Cell | Content Cell  |
```

## Adding Code Chunks

To add a new code chunk,

-   type Cmd/Ctrl + Option + I or
-   choose the green C (chunk) icon at the top right of the source pane (left of the Run button), and select R from the dropdown menu, or
-   you could manually type 3 backticks (\`\`\`) then `{r}` alone on a line at the top and then 3 backticks (\`\`\`) alone on a line at the bottom of the code chunk.

Note that you can insert code chunks from a variety of languages.

To insert new text, just type plain text, and format as desired with markdown tags or the Visual Editor buttons. You can use the Outline toggle button to turn on or off the outline in the right sidebar of the Source pane. It uses your headings to create a nested outline.

## Organized Options in Code Chunks with the Hash-Pipe #\|

Previously in Rmarkdown, you could state options for your code chunk after the {r} header, inside of the curly braces. This could get a bit messy and sometimes hard to read. You can now add options to each code chunk with the hash-pipe operator (#\|) right after the {r} header, starting on the next line, with one option on each line. This looks something like:



Some of the popular options are

| Option                | What it Does                                                                                                              |
|------------------------|-----------------------------------------------|
| echo                  | Shows (true) or hides (false) code                                                                                        |
| eval                  | whether or not to evaluate the code and show results                                                                      |
| label                 | name of the chunk (must be unique in your qmd document)                                                                   |
| include               | show chunk and output (true), or just run without any output (often used for the `setup` chunk to load libraries quietly) |
| fig.width, fig.height | sets these, default unit is inches                                                                                        |
| warning               | whether to show text warnings                                                                                             |
| message               | whether to show text messages                                                                                             |
| cache                 | Cache and use previous result (true) - helpful if long calculation you don't want to repeat                               |
| fig.cap               | set the figure caption                                                                                                    |
| results: hide         | hides printed output                                                                                                      |
| fig-show: hide        | hides plots                                                                                                               |

: Options for Code Chunks

All of the possible options for a code chunk can be found [here](https://yihui.org/knitr/options/).

Code chunks and their outcomes:

| Option           | Run code | Show Code | Output | Plots | Messages | Warnings |
|------------------|----------|-----------|--------|-------|----------|----------|
| `eval: false`    | N        | **Y**     | N      | N     | N        | N        |
| `include: false` | **Y**    | N         | N      | N     | N        | N        |
| `echo: false`    | Y        | **N**     | Y      | Y     | Y        | Y        |
| `results: hide`  | Y        | Y         | **N**  | Y     | Y        | Y        |
| `fig-show: hide` | Y        | Y         | Y      | **N** | Y        | Y        |
| `message: false` | Y        | Y         | Y      | Y     | **N**    | Y        |
| `warning: false` | Y        | Y         | Y      | Y     | Y        | **N**    |

## Stating Global Options in Your YAML Header

### Code Options and Code Folding

To add global code options for all code chunks, you can set the `execute` options in your YAML section to things like `echo: false`. Note that you need to add a return after `execute:` to make a new line, then keep the default indent when you add options like `eval: false` or `fig-show: hide`.

<br>

To fold (hide) your code with an option for the user to click on a `Code button` to see it, set up your YAML chunk at the top of the qmd document with the `format:` `html:` option of `code-fold: true`. Note that this requires the correct line breaks and indents to work.


```r
---
title: "Quarto Document"
execute: 
  echo: false
format:
  html:
    code-fold: true
---
```

### Parameters

You can also render a quarto document to prepare a report for one subset of your data, and set the key parameter in the YAML chunk. For example, you can run an fuel economy report with a plot only for SUVs, as seen below.


```r
---
title: "Report by Vehicle Class"
output: html_document
params:
  my_class: "suv"
---

#| label: setup
#| include: false
library(tidyverse)
class <- mpg |> filter(class == params$my_class)

# Fuel economy plot for `r params$my_class`
ggplot(class, aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth(se = FALSE)
```

## Figures

There are a number of options for controlling figure output. Figure sizing is controlled with:

-   fig-width (width of figure created by R, in inches)

-   fig-height (height of figure created by R, in inches)

-   fig-asp (for aspect ratio - can only specify 2 of width, height, and aspect ratio), the ratio of height to width

-   out-width - often set to 70% of the width of the page and centered with `fig.align`, out.width = "70%"

-   out-height

Other options:

-   fig-cap: "Caption Goes Here"

-   fig-alt: "Alternative text if the image is not shown"

-   fig-align: "center", or "default", "left", "right"

    -   layout-ncol: 2 - this creates 2 columns

## Tables

Markdown tables can be inserted in the Visual Editor with `Insert>Table`.

You can also generate tables from your data with a code chunk. The default display is what you would normally see in the Console, with minimal formatting. You can pipe any table generated with a code chunk into a package for formatting tables and get much nicer HTML, Word, or PDF tables. The {`flextable`} package will work for any format, while the {`gt`} package is excellent for HTML and PDF. The knitr::kable() function will work for converting console output to HTML, and the {`kableExtra`} package will add nicer formatting. Other packages that can work well with tables include `reactable, stargazer, huxtable, tables,` and `ascii`.

Here are two examples from the abm (bacterial menintgitis) dataset with flextable and gt, using conditional formatting to highlight high blood band count and low csf glucose.


```r
# Flextable
medicaldata::abm |> 
  select(csf_wbc, csf_gluc, blood_band_pct, gram) |> 
  arrange(-csf_wbc) |> 
  head(7) |> 
  as_flextable() |> # i is row, j is column
  bold(i = ~ csf_gluc < 25, j = ~ csf_gluc) |> 
  color(color = "red",
  i = ~ blood_band_pct > 5, j = ~ blood_band_pct)
```

```{=html}
<div class="tabwid"><style>.cl-626c4df0{}.cl-6268f5c4{font-family:'Helvetica';font-size:11pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-6268f5d8{font-family:'Helvetica';font-size:11pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(153, 153, 153, 1.00);background-color:transparent;}.cl-6268f5d9{font-family:'Helvetica';font-size:11pt;font-weight:bold;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-6268f5e2{font-family:'Helvetica';font-size:11pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(255, 0, 0, 1.00);background-color:transparent;}.cl-626a50b8{margin:0;text-align:right;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-626a5a86{width:0.837in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(102, 102, 102, 1.00);border-top: 1.5pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-626a5a87{width:0.846in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(102, 102, 102, 1.00);border-top: 1.5pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-626a5a90{width:1.373in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(102, 102, 102, 1.00);border-top: 1.5pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-626a5a91{width:0.829in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(102, 102, 102, 1.00);border-top: 1.5pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-626a5a92{width:0.837in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-626a5a9a{width:0.846in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-626a5a9b{width:1.373in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-626a5a9c{width:0.829in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-626a5a9d{width:0.837in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-626a5aa4{width:0.846in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-626a5aa5{width:1.373in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-626a5aa6{width:0.829in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-626a5aa7{width:0.837in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-626a5aa8{width:0.846in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-626a5aae{width:1.373in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-626a5aaf{width:0.829in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-626a5ab0{width:0.837in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-626a5ab1{width:0.846in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-626a5ab2{width:1.373in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-626a5ab3{width:0.829in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-626a5ab8{width:0.837in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-626a5ab9{width:0.846in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-626a5aba{width:1.373in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-626a5ac2{width:0.829in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-626a5ac3{width:0.837in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-626a5ac4{width:0.846in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-626a5ac5{width:1.373in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-626a5ac6{width:0.829in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}</style><table data-quarto-disable-processing='true' class='cl-626c4df0'><thead><tr style="overflow-wrap:break-word;"><th class="cl-626a5a86"><p class="cl-626a50b8"><span class="cl-6268f5c4">csf_wbc</span></p></th><th class="cl-626a5a87"><p class="cl-626a50b8"><span class="cl-6268f5c4">csf_gluc</span></p></th><th class="cl-626a5a90"><p class="cl-626a50b8"><span class="cl-6268f5c4">blood_band_pct</span></p></th><th class="cl-626a5a91"><p class="cl-626a50b8"><span class="cl-6268f5c4">gram</span></p></th></tr><tr style="overflow-wrap:break-word;"><th class="cl-626a5a92"><p class="cl-626a50b8"><span class="cl-6268f5d8">numeric</span></p></th><th class="cl-626a5a9a"><p class="cl-626a50b8"><span class="cl-6268f5d8">numeric</span></p></th><th class="cl-626a5a9b"><p class="cl-626a50b8"><span class="cl-6268f5d8">numeric</span></p></th><th class="cl-626a5a9c"><p class="cl-626a50b8"><span class="cl-6268f5d8">numeric</span></p></th></tr></thead><tbody><tr style="overflow-wrap:break-word;"><td class="cl-626a5a9d"><p class="cl-626a50b8"><span class="cl-6268f5c4">100,000</span></p></td><td class="cl-626a5aa4"><p class="cl-626a50b8"><span class="cl-6268f5d9">24</span></p></td><td class="cl-626a5aa5"><p class="cl-626a50b8"><span class="cl-6268f5e2">8</span></p></td><td class="cl-626a5aa6"><p class="cl-626a50b8"><span class="cl-6268f5c4">4</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-626a5aa7"><p class="cl-626a50b8"><span class="cl-6268f5c4">78,900</span></p></td><td class="cl-626a5aa8"><p class="cl-626a50b8"><span class="cl-6268f5d9">14</span></p></td><td class="cl-626a5aae"><p class="cl-626a50b8"><span class="cl-6268f5c4">1</span></p></td><td class="cl-626a5aaf"><p class="cl-626a50b8"><span class="cl-6268f5c4">1</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-626a5a9d"><p class="cl-626a50b8"><span class="cl-6268f5c4">50,000</span></p></td><td class="cl-626a5aa4"><p class="cl-626a50b8"><span class="cl-6268f5c4"></span></p></td><td class="cl-626a5aa5"><p class="cl-626a50b8"><span class="cl-6268f5c4">4</span></p></td><td class="cl-626a5aa6"><p class="cl-626a50b8"><span class="cl-6268f5c4">4</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-626a5ab0"><p class="cl-626a50b8"><span class="cl-6268f5c4">36,000</span></p></td><td class="cl-626a5ab1"><p class="cl-626a50b8"><span class="cl-6268f5c4">75</span></p></td><td class="cl-626a5ab2"><p class="cl-626a50b8"><span class="cl-6268f5e2">38</span></p></td><td class="cl-626a5ab3"><p class="cl-626a50b8"><span class="cl-6268f5c4">4</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-626a5ab8"><p class="cl-626a50b8"><span class="cl-6268f5c4">32,200</span></p></td><td class="cl-626a5ab9"><p class="cl-626a50b8"><span class="cl-6268f5c4"></span></p></td><td class="cl-626a5aba"><p class="cl-626a50b8"><span class="cl-6268f5c4">2</span></p></td><td class="cl-626a5ac2"><p class="cl-626a50b8"><span class="cl-6268f5c4">4</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-626a5ab8"><p class="cl-626a50b8"><span class="cl-6268f5c4">28,000</span></p></td><td class="cl-626a5ab9"><p class="cl-626a50b8"><span class="cl-6268f5d9">15</span></p></td><td class="cl-626a5aba"><p class="cl-626a50b8"><span class="cl-6268f5c4">2</span></p></td><td class="cl-626a5ac2"><p class="cl-626a50b8"><span class="cl-6268f5c4">1</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-626a5ac3"><p class="cl-626a50b8"><span class="cl-6268f5c4">21,600</span></p></td><td class="cl-626a5ac4"><p class="cl-626a50b8"><span class="cl-6268f5d9">20</span></p></td><td class="cl-626a5ac5"><p class="cl-626a50b8"><span class="cl-6268f5c4">0</span></p></td><td class="cl-626a5ac6"><p class="cl-626a50b8"><span class="cl-6268f5c4">1</span></p></td></tr></tbody></table></div>
```

You can learn more about the many formatting options in {flextable} [here](https://davidgohel.github.io/flextable/index.html).


```r
# gt package
medicaldata::abm |> 
  select(csf_wbc, csf_gluc, blood_band_pct, gram) |> 
  arrange(-csf_wbc) |> 
  head(7) |> 
  gt() |> 
  tab_style(style = cell_text(weight = "bold"),
    locations = cells_body(
      columns = csf_gluc,
      rows = csf_gluc < 25)) |> 
  tab_style(style = cell_text(color = "red"),
    locations = cells_body(
      columns = blood_band_pct,
      rows = blood_band_pct > 5)) 
```

```{=html}
<div id="nkmaboimel" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#nkmaboimel .gt_table {
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

#nkmaboimel .gt_heading {
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

#nkmaboimel .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#nkmaboimel .gt_title {
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

#nkmaboimel .gt_subtitle {
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

#nkmaboimel .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#nkmaboimel .gt_col_headings {
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

#nkmaboimel .gt_col_heading {
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

#nkmaboimel .gt_column_spanner_outer {
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

#nkmaboimel .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#nkmaboimel .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#nkmaboimel .gt_column_spanner {
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

#nkmaboimel .gt_group_heading {
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

#nkmaboimel .gt_empty_group_heading {
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

#nkmaboimel .gt_from_md > :first-child {
  margin-top: 0;
}

#nkmaboimel .gt_from_md > :last-child {
  margin-bottom: 0;
}

#nkmaboimel .gt_row {
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

#nkmaboimel .gt_stub {
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

#nkmaboimel .gt_stub_row_group {
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

#nkmaboimel .gt_row_group_first td {
  border-top-width: 2px;
}

#nkmaboimel .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#nkmaboimel .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#nkmaboimel .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#nkmaboimel .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#nkmaboimel .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#nkmaboimel .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#nkmaboimel .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#nkmaboimel .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#nkmaboimel .gt_footnotes {
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

#nkmaboimel .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-left: 4px;
  padding-right: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#nkmaboimel .gt_sourcenotes {
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

#nkmaboimel .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#nkmaboimel .gt_left {
  text-align: left;
}

#nkmaboimel .gt_center {
  text-align: center;
}

#nkmaboimel .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#nkmaboimel .gt_font_normal {
  font-weight: normal;
}

#nkmaboimel .gt_font_bold {
  font-weight: bold;
}

#nkmaboimel .gt_font_italic {
  font-style: italic;
}

#nkmaboimel .gt_super {
  font-size: 65%;
}

#nkmaboimel .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 75%;
  vertical-align: 0.4em;
}

#nkmaboimel .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#nkmaboimel .gt_indent_1 {
  text-indent: 5px;
}

#nkmaboimel .gt_indent_2 {
  text-indent: 10px;
}

#nkmaboimel .gt_indent_3 {
  text-indent: 15px;
}

#nkmaboimel .gt_indent_4 {
  text-indent: 20px;
}

#nkmaboimel .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table">
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="csf_wbc">csf_wbc</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="csf_gluc">csf_gluc</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="blood_band_pct">blood_band_pct</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="gram">gram</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="csf_wbc" class="gt_row gt_right">100000</td>
<td headers="csf_gluc" class="gt_row gt_right" style="font-weight: bold;">24</td>
<td headers="blood_band_pct" class="gt_row gt_right" style="color: #FF0000;">8</td>
<td headers="gram" class="gt_row gt_right">4</td></tr>
    <tr><td headers="csf_wbc" class="gt_row gt_right">78900</td>
<td headers="csf_gluc" class="gt_row gt_right" style="font-weight: bold;">14</td>
<td headers="blood_band_pct" class="gt_row gt_right">1</td>
<td headers="gram" class="gt_row gt_right">1</td></tr>
    <tr><td headers="csf_wbc" class="gt_row gt_right">50000</td>
<td headers="csf_gluc" class="gt_row gt_right">NA</td>
<td headers="blood_band_pct" class="gt_row gt_right">4</td>
<td headers="gram" class="gt_row gt_right">4</td></tr>
    <tr><td headers="csf_wbc" class="gt_row gt_right">36000</td>
<td headers="csf_gluc" class="gt_row gt_right">75</td>
<td headers="blood_band_pct" class="gt_row gt_right" style="color: #FF0000;">38</td>
<td headers="gram" class="gt_row gt_right">4</td></tr>
    <tr><td headers="csf_wbc" class="gt_row gt_right">32200</td>
<td headers="csf_gluc" class="gt_row gt_right">NA</td>
<td headers="blood_band_pct" class="gt_row gt_right">2</td>
<td headers="gram" class="gt_row gt_right">4</td></tr>
    <tr><td headers="csf_wbc" class="gt_row gt_right">28000</td>
<td headers="csf_gluc" class="gt_row gt_right" style="font-weight: bold;">15</td>
<td headers="blood_band_pct" class="gt_row gt_right">2</td>
<td headers="gram" class="gt_row gt_right">1</td></tr>
    <tr><td headers="csf_wbc" class="gt_row gt_right">21600</td>
<td headers="csf_gluc" class="gt_row gt_right" style="font-weight: bold;">20</td>
<td headers="blood_band_pct" class="gt_row gt_right">0</td>
<td headers="gram" class="gt_row gt_right">1</td></tr>
  </tbody>
  
  
</table>
</div>
```

You can learn more about the many formatting options in {gt} [here](https://gt.rstudio.com).

## Inline Code and Caching

You can run R code and place the output into your text. much like Rmarkdown, by placing a single backtick before **r** and another single backtick after the code needed.

For example, you can write out "my two-sided p value is `` `r
2*(1-pnorm(7, mean = 5, sd = 1.1))` ``," which shows the code as written. When this R code between the backticks is evaluated (when you render the document), the resulting p value is shown. This will read: <br> My two-sided p value is 0.0690363.

## Quarto at the Command Line

As you work on a \*.qmd document (in this case, named `document.qmd`), you will want to preview it in an adjacent browser window. You can do this at the command line (Terminal in Mac, Run cmd in Windows) with

`quarto preview document.qmd --to html` for the html version, or

`quarto preview document.qmd --to docx` for the Microsoft Word version.

To render your saved qmd document from the command line, you can use with

`quarto render document.qmd --to html` for the html version, or

`quarto render document.qmd --to docx` for the Microsoft Word version. The render commands will produce a final document.

## Citations in Quarto

Citations in Quarto work much like they do in Rmarkdown. In the Visual Editor, you can use Insert\>Citation. You can enter a DOI (Digital Object Identifier), pull a reference from a Zotero library, pull references with PubMed IDs, or get references from a bibliography file (a `*.bib` file in the same directory as your document). If you add a citation using one of the first three methods, the visual editor will automatically create a bibliography `*.bib` file for you and add the reference to it. It will also add a bibliography field (required to identify the file) to the document YAML. As you add more references, this file will get populated with their citations.

When Quarto renders your file, it will build and append a bibliography to the end of your document. The bibliography will contain each of the cited references from your bibliography file, but it will not contain a section heading. As a result it is common practice to end your file with a section header for the bibliography, such as # References.

You can change the style of your citations and bibliography by referencing a CSL (citation style language) file (with the full path to the file) in the csl field in the YAML header.


```r
bibliography: my_bibliography.bib
csl: R/csl_files/gastroenterology.csl
```

You can find many journal bibliography styles (and download them) at https://www.zotero.org/styles or  https://github.com/citation-style-language/styles.


:::challenge
## Challenge Yourself
1. Create a new Quarto Document, and do a simple analysis of one of the {medicaldata} datasets with code chunks that generate a table and a figure, and add some text about your conclusions. Add some header text for the different sections. Try rendering this document (separately) to both HTML and MS Word.
2. Experiment with the visual editor and the source editor. Insert a code chunk, a citation (try this DOI - 10.1016/j.cgh.2021.05.038), a table, and a horizontal line. Toggle back and forth to compare WYSIYG to markdown tags. Render the document and peek at the YAML and the end of the document to see how it handles the citation.
3. With a quarto document open, toggle the Outline button at the top right of the Source pane, and see how your heading text becomes a nested outline.
4. Experiment with the code chunk options in section 34.9, and render the chunks to see what the different options do.
5. Take a code chunk that generates a plot, and experiment with the figure options in chapter sections 9 and 11. Render the document, and see if you get the output you expected.
:::

:::explore
## Exploring further

1.  The Quarto Getting Started Tutorials found (in left sidebar) [here](https://quarto.org/docs/get-started/)

2.  The [Quarto Chapter](https://r4ds.hadley.nz/quarto.html) in R for Data Science.

3. The Quarto website is the definitive reference [here](https://quarto.org/)
:::
