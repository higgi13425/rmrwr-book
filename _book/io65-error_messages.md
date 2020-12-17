---
title: "Errors in R"
author: "Peter Higgins"
date: "12/12/2020"
output: html_document
---



# Interpreting Error Messages

Especially when you are starting out, it can be very difficult to interpret error messages, because these can be quite jargon-y.

Let's start with a table of the most common error messages, and the likely cause in each case.

Note that when reading an error message, there are two parts - the part before the colon, which identifies in which function the error occurred, and the part after the colon, which names the error. A typical error message is something like:    
<br>

`Error in as_flextable(.) : object 'errors' not found`

On the left, you are being told that the error occurred when the `as_flextable()` function was called. This can be helpful if you have run a long pipeline of functions, as it helps you isolate the problem.

On the right, you are being told what the error was. In this case, the function looked for the object `errors` in the working environment (see your Environment tab at the top right in RStudio), and could not find it. 

Then we will walk through examples of how to create each error, and how to fix them, one by one.

## The Common Errors Table

Examine the error message from R, particularly the part that comes after the colon (:). The error messages listed in the left column will be what appears after the colon (:)


```{=html}
<div class="tabwid"><style>.cl-78eb012a{border-collapse:collapse;}.cl-78e01152{font-family:'Helvetica';font-size:11pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-78e03948{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:3pt;padding-top:3pt;padding-left:3pt;padding-right:3pt;line-height: 1;background-color:transparent;}.cl-78e097d0{width:54pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-78e097ee{width:54pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-78e097f8{width:54pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(0, 0, 0, 1.00);border-top: 2pt solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}</style><table class='cl-78eb012a'>
```

```{=html}
<thead><tr style="overflow-wrap:break-word;"><td class="cl-78e097f8"><p class="cl-78e03948"><span class="cl-78e01152">error_message</span></p></td><td class="cl-78e097f8"><p class="cl-78e03948"><span class="cl-78e01152">what_it_means</span></p></td></tr></thead><tbody><tr style="overflow-wrap:break-word;"><td class="cl-78e097d0"><p class="cl-78e03948"><span class="cl-78e01152">could not find function</span></p></td><td class="cl-78e097d0"><p class="cl-78e03948"><span class="cl-78e01152">This usually means that you made a typo in the function name (including Capitalization), or that the package you are intending to use (which contains the function) is not installed <br>(with `install.packages('package_name')`) or loaded (with `library(package)`)</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-78e097d0"><p class="cl-78e03948"><span class="cl-78e01152">object 'object-name' not found</span></p></td><td class="cl-78e097d0"><p class="cl-78e03948"><span class="cl-78e01152">This usually means that the function looked for an object (like a data frame or a vector) in your working environment (check your Environment pane) and could not find it. This commonly happens when you (1) mistype the name of the object (double-check this, easy to fix), or (2) you did not actually create or save this object to your working environment - confirm by checking your Environment tab at the top right in RStudio.</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-78e097d0"><p class="cl-78e03948"><span class="cl-78e01152">filename does not exist in current working directory ('path/to/working/directory')</span></p></td><td class="cl-78e097d0"><p class="cl-78e03948"><span class="cl-78e01152">This usually means one of three things: (1) you mistyped the name of the file, or part of the path, (2) you are not in the directory where the file is, or (3) the file you thought you had saved does not exist (check your Files tab in the lower right pane in RStudio).</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-78e097ee"><p class="cl-78e03948"><span class="cl-78e01152">error in if</span></p></td><td class="cl-78e097ee"><p class="cl-78e03948"><span class="cl-78e01152">This usually means that you have an *if* statement that is trying to make a branch-point decision, but the logical statement that you wrote is not providing either a TRUE or a FALSE value. The most common reasons are typos in the logical statement, or an NA in one of the underlying values, which yields an NA from the logical statement. You may need to use a `na.rm = TRUE` option in your logical statement.</span></p></td></tr></tbody></table></div>
```


## Examples of Common Errors and How to fix them

It turns out that I forgot to run the code chunk to generate the `errors` object. And I confirmed this, as the `errors` object was not in my Environment. So it turned out to be an easy fix


## Package (and Dependency) Problems

## Debugging Strategies


### Add-One-Line

### Tidylog

### Ask the Internet
 - see chapter on Getting Help
 
### Google strategies

tags:  
- R, or in R
- community.rstudio.com
- stackoverflow

error message in R

how to do X in R

## Restart R Session
Shift-Cmd-F10
It is possible that you have created something odd in your working Environment that is messing up your code. 
Completely restart R your R session, make sure the Environment is clean, then run your code from start to finish to give it a new try




## References:

https://bookdown.org/yih_huynh/Guide-to-R-Book/trouble.html

https://medium.com/analytics-vidhya/common-errors-in-r-and-debugging-techniques-f11af3f1c7d3

https://rpubs.com/Altruimetavasi/Troubleshooting-in-R

https://github.com/noamross/zero-dependency-problems/blob/master/misc/stack-overflow-common-r-errors.md

https://www.r-bloggers.com/2016/06/common-r-programming-errors-faced-by-beginners/

https://www.r-bloggers.com/2015/03/the-most-common-r-error-messages/

https://rpubs.com/Altruimetavasi/Troubleshooting-in-R 
