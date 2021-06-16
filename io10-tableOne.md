---
title: "Making Table One"
author: "Peter Higgins"
output: html_document
---

# Descriptive Data Tables

In this chapter, we will focus on making the descriptive table of the participants in your study, often colloquially know as "Table One", based on its usual placement in a medical manuscript.    
<br>
Before we plunge in, I would like to make one point of warning. It is quite common in a multiple-arm randomized controlled trial to compare the distribution of particular baseline characteristics of the subjects between arms with a p value, usually in a column at the far right. This is silly, as this produces a whole column of p values, corresponding to the multiple comparisons performed. With 20 comparisons, by chance, you are likely to get one or more "significant" p values. These are not helpful or meaningful, and are considered bad statistical practice.     
<br>
Let me quote the CONSORT guidelines on the publications of clinical trials. <br>
<br>
*“Unfortunately significance tests of baseline differences are still common; they were reported in half of 50 RCTs published in  leading general journals in 1997. Such significance tests assess the probability that observed baseline differences could have occurred by chance; however, we already know that any differences are caused by chance. Tests of baseline differences are not necessarily wrong, just illogical. Such hypothesis  
testing is superfluous and can mislead investigators and their readers. Rather, comparisons at baseline should be based on consideration of the prognostic strength of the variables measured and the size >of any chance imbalances that have occurred.”* [CONSORT STATEMENT](http://www.consort-statement.org/checklists/view/32-consort/510->baseline-data)

<br>
Despite this, some journals and editors still ask for these p values. Please resist, and quote the CONSORT statement. If you must do this, please do it only under duress. 


## Making Table One

### The *tableby* function in the **arsenal** package



### The gtsummary package with flextable
This is a newer approach which offers many of the same features as tableby. The gtsummary package is a companion to/built upon the gt package, ("gt" for grammar of tables), which is supported by RStudio. The gtsummary package, like gt, is designed to produce nice html output with lots of nice formatting. <br>
<br>
However, as a nice bonus, gtsummary includes a neat function *as_flextable*, which converts your resulting table into a flextable, which can be knit to a Microsoft Word Document or a Powerpoint presentation with Rmarkdown. <br>
<br>
This means that you can make a table once, and be able to produce output in HTML for webpages, Microsoft Word for manuscripts, and MS Powerpoint for presentations from the same file without any conversion issues.<br>
<br>
The only question is how and when you prefer to format your table. Both gt and flextable have great options for formatting your tables. You can do this in gt, then do *as_flextable*, or you can convert to a flextable first, then do your formatting. You can choose based on your comfort and familiarity with flextable vs. gt. Both have excellent explanatory websites, with flextable [here](https://davidgohel.github.io/flextable/index.html) and gtsummary [here](http://www.danieldsjoberg.com/gtsummary/index.html).



 
### Example of how to build a Table 1 with gtsummary
 


In the window below, you can:
 
- Expand the example below to View in full screen by clicking the four arrows icon (Esc to return to small version).
- Go to the next slide or previous slide with the left and right arrow icons/keys (or hover your mouse over the window and slowly scroll up and down.) 
- Share on the internet by clicking the Share icon (3 circles connected by 2 lines).

Give it a try.
 
<iframe src="table-one.html" width="672" height="360"></iframe>



## Making An Adverse Events Table

## Making A Results Table
