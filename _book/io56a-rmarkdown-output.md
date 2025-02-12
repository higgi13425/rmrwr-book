---
title: "Rmarkdown Output - Word, PDF, and Powerpoint"
author: "Peter Higgins"
date: "12/9/2019"
output:
  pdf_document: default
  html_document: default
editor_options:
  markdown:
    wrap: 72
---



# Rmarkdown Output Options

While HTML is convenient for rapid output and iteration, most end-products for medical research are either Word documents, PDFs, or PowerPoint slides.

There are many options for Rmarkdown output, including the _markdown(`*.md`)_ document that results from Knitting. The `*.md` document is then translated by pandoc into options including:

- MS Word `word_document`
- PDF `pdf_document`
- PowerPoint `powerpoint_presentation`
- Rich Text Format document - `rtf_document`
- OpenDocument file `odt_document`
- LaTeX typesetting document `latex_document`
- ConTeXt typesetting document `context_document`
- HTML `html_document`
- Github-formatted markdown `github_document`
- And some other presentation formats
  + `xaringan::moon_reader`
  + `slidy_presentation`
  + `beamer_presentation`
  + `ioslides_presentation`

## Microsoft Word Output from Rmarkdown

Changing the output of a Rmarkdown document to Microsoft Word is easy - you can either:

- click on the dropdown arrow next to the **Knit** button, and select, Knit to Word, or
- change the `output:` option in the YAML header to `word_document`

These will use the default formatting for Microsoft Word, which is OK, but may not produce the font, text color (too much blue!), or the heading sizes that you want.

This is fixable, by using your own MS Word template document (aka style reference document). If you have a Word document named "my-styles.docx", this can serve as your styles template. You just have to :

1. Have the file in the same folder as the *.Rmd document, or in a nearby folder, preferably in the same project.
2. Change the `output:` field of your YAML header to look like this:


``` r
---
title: "My Title"
author: Me
date: January 7, 2027
output: 
  word_document:
    reference_docx: my-styles.docx
---
```

Note that the placement of the new-lines (returns), colons, and indents are critical to make this output format work. And if your `reference.docx` template is in a folder within your project, you need to put the path - i.e. `styles-template/reference.docx` if it is in the `styles-template` folder.

### Making a Styles Reference File for Microsoft Word

The easiest way to make a `reference_docx` file is to knit a new rmarkdown file to Microsoft Word, then reformat the resulting Word document to the format that you want. Then save the resulting word document as `my-styles.docx` in your project folder, usually near your Rmarkdown file.

It is often helpful to have each level of heading (1-5) present in your template `*.docx` file, so that you can make sure that all of the header levels and the body text are formatted the way that you want them.

### Let's Practice This.

Open RStudio.

Open the rmd4medicine project that you created in the previous chapter (if you did not, go back and do this, then return here). 

Click on the Git tab in the top right in RStudio. 

Click on the downward green arrow icon to pull down the latest files in this project from GitHub.

Open the `prep` folder, then open the `style-rmd.Rmd` file.

Knit this document to Microsoft Word.

Save the resulting document as `word-styles.docx`
in the same directory as your Rmd file
We will use this docx document as a template (after we reformat)

### Re-formatting Your Template

Open the word document, Select the Home ribbon, then the Styles window launcher (Styles Pane) in the Styles group.  
  
Select the Title.
It has the Title style. Scroll down to Title style in the Styles Window.
  
Change the font, the color, the size, etc. until you like the look.

Then click on the dropdown arrow to the right of the Title style, and select 'Update Title to Match Selection'.

Then repeat the process for body text, Heading1, Heading2, Heading3, etc. 
There is a nice video walkthrough of where to click [here](https://vimeo.com/110804387).

When you are happy with the formatting, then save this document as `word-styles.docx`.

### Using Your New Styles Template

Use File/New File/Rmarkdown to open a new *.Rmd file.

Go to the top of your Rmarkdown document, to the YAML Header  
It should have 2 lines of 3 dashes, with a title, author, date, and   
  
`output: html_document`
  
between them
  
You need to change this to (note that these are real indent tabs)  

output:  
(indent)word_document:  
(indent)(indent)reference_docx: word-styles.docx  
    
Note the placement of the colons, what is on each line, and the number of indents are critical to making this work.

### Now you are ready!

Now save this document and knit - you will get the format that you intended. And you can use this template for any future Rmarkdown document - just be sure that you have  
`word-styles.docx`  
in the same folder where your Rmarkdown document lives.  



## PDF Output from RMarkdown

Most of the time, you will not need PDF output. Many journals prefer that you submit MS Word files in `*.docx` format and image files in `tiff`, `bmp`, or `jpeg` formats. Then their web server will generate the PDF.

But if you are determined to make your own PDFs from Rmarkdown files, you can. It just takes a bit of setup.

### LaTeX and tinytex

First, you need a translator for all of the things PDFs can do. A complete version uses TeX or LaTeX to get all kinds of typesetting functions. Most of the time, you need a much smaller subset of TeX, which is where the {[tinytex](https://yihui.org/tinytex/)} package comes in handy.

To use {tinytex}, copy the code chunk below, and run it in your local RStudio console (once only).


``` r
install.packages('tinytex')
tinytex::install_tinytex()
```

More details on how to use and maintain {tinytex} can be found [here](https://yihui.org/tinytex/).

### Knitting to PDF

Now that the installation of {tinytex} is complete, you can **Knit** to PDF. Open your favorite Rmarkdown document, and knit to PDF in one of two ways:

1. Click on the dropdown arrow next to the Knit button, and select Knit to PDF.
2. Edit the YAML `output:` key to pdf_document (with no quotes). Then click on the Knit button.

This will open up a new window with your auto-generated PDF document.




## Microsoft Powerpoint Output from Rmarkdown

To get Powerpoint output, you can simply change the `output:` key to `powerpoint_presentation`.

You can even add a formatted powerpoint template (like `my-styles.pptx`) to get the fonts and colors and headings the way you like them (remember to use the indents, like this:


``` r
---
title: "My Title"
author: Me
date: January 7, 2027
output: 
  powerpoint_presentatino:
    reference_docx: my-styles.pptx
---
```

A simple Powerpoint template can be found [here](https://github.com/mfherman/mattherman/blob/master/static/ppt/template-no-title.pptx. 

But the knitted result often won't be quite right out of the gate, as slides, unlike word documents, need explicit separators between slides. 

You will create a new slide each time you insert a Level1/2 Heading, or (more commonly) each time you have *3 or more dashes* on a single line.

Since most Word Documents don't have a lot of Level1 Headings, an Rmd document that works well for MS Word will usually have way too many words/lines per Powerpoint slide.

You will usually have to 

1. Start After the YAML with a Level 1 header
2. Divide up your slides with 3-dash breaks `---`.
3. Start Each new slide with a Level 1 or Level 2 header
4. Convert the text into pithy bullet points (usually level 3 and 4 headers and body text)
5. Insert only one image or plot per slide (you can reformat them later in PPT)
6. Set up your template pptx file - often enlarging the area for the image, and removing the separate title slide is helpful (as in the example template above).

Oftentimes, you will just be wanting to get the images and plots from your project into PPT, and add text and formatting later. This will be less than completely reproducible, but can be faster than writing a whole PowerPoint presentation in Rmd.

### Tables in Powerpoint

You can use the {flextable} package to make formatted tables for Powerpoint. This package can be found [here](https://davidgohel.github.io/flextable/).

Alternatively, many people use `knitr::kable()` to print out tables on PowerPoint slides. If you want more than basic formatting, you can use the {kableExtra} package, found [here](https://cran.r-project.org/web/packages/kableExtra/vignettes/awesome_table_in_html.html) to style your kable tables.

### Images in Powerpoint

You can add a code chunk and create a plot on a slide with code in the code chunk, using fig.width and fig.height chunk options to control the dimensions of the plot.

You can include a graphic (picture, other plot, etc.) in a code chunk with `knitr::include_graphics("path/to/filename")`, with a code chunk like this:


``` r
knitr::include_graphics(here("images/echocardiogram.jpg"))
```

This is often helpful if you have already created your images or graphics, and just need to pull them into powerpoint from a folder.

You can use chunk options like `fig.width=12` and `fig.height=7` to control the size of the image on the slide.

Note that if you are using these options frequently, it may be easier to set these globally (for the whole presentation) in the `setup` chunk, as options in `knitr:opts_chunk$set()`, rather than in each code chunk.


### Plots in Powerpoint

Note that plots come in from R to Powerpoint as included graphics. They can be re-sized, but not edited, once they are in Powerpoint. This is good for reproducibility, but if you are still fiddling with your plots, it may be best to save the conversion to Powerpoint until the final version.

You can put multiple plots on one slide if you use the {[patchwork](https://patchwork.data-imaginist.com)} package to set them up as a multipanel figure.

If you want plots in PPT that are editable (less reproducible, but sometimes handy), you will want to use the {[mschart](https://ardata-fr.github.io/mschart/)} package, which will output charts in Microsoft format that can be included in PowerPoint slides and will still be editable within PowerPoint.
