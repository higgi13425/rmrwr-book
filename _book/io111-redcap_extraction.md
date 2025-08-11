---
title: "Using your .Rprofile file and RStudio Code Snippets"
author: "Peter Higgins"
date: "5/28/2025"
output: html_document
---



# Using your .Rprofile and .Renviron file and RStudio Code Snippets

This chapter is part of the **Coding** pathway. <br> Packages needed for this chapter include {usethis} and {tidyverse}. 

These are two tools that will help you extend what you can do with R and RStudio. The .Rprofile file is a file that is run every time you start R, and it can be used to set options, load packages, and define functions that you want to use in every R session. RStudio Code Snippets are a way to save and reuse code snippets in RStudio, which can help you work more efficiently. Let's start with the .Rprofile file.

## Setting up your .Rprofile file
You can create a .Rprofile file in your home directory or in any project directory. This file is run every time you start R, and it can be used to set options that you want to use in every R session.

The upside to this is that your workspace is set up consistently the same way every time you start R, and you don't have to remember to load packages or set options every time. The downside is when you share your code with collaborators, it may not run, as they do not have the same .Rprofile file.
In general, you should use the .Rprofile file for things that you want to set up every time you start R, and that are not specific to a project. For example, you might want to set options for how R displays output.

However, you should avoid loading packages or functions in your `.Rprofile` file, as this can cause issues when you share your code with collaborators. Instead, you should load packages in your R scripts or RMarkdown files, or use the {renv} package to manage your project-specific library paths and package versions.

The .Rprofile file is a user-controllable file that can be located in your home directory (`~/.Rprofile`) or in a project-specific directory (e.g., `my_project/.Rprofile`). When you start R, it will look for a .Rprofile file in your home directory and in the current working directory, and it will run the code in that file. This allows you to set options that you want to use in every R session. This is a 'secret' file that is not visible in the RStudio Files pane, but you can see it in the RStudio source pane if you open it with `usethis::edit_r_profile()`. It will not be shared on Github when you push your code to a repository, as it is a hidden file (the dot at the beginning of the filename makes it hidden in Unix-like operating systems).

To set up your .Rprofile file, you can use the {usethis} package. The following code will create a .Rprofile file in your home directory if it does not already exist, and then open it in RStudio for editing:


``` r
usethis::edit_r_profile()
```

```
## ☐ Edit '/Users/peterhiggins/.Rprofile'.
```

```
## ☐ Restart R for changes to take effect.
```

This will open the .Rprofile file in the source pane of RStudio, and you can add any code that you want to run every time you start R. 

You can edit your `.Rprofile` file to set some options.
Here are a few common examples of what people often do wtith their `.Rprofile` file:


``` r
options(stringsAsFactors = FALSE) # Set strings to not be factors by default
options(digits = 3) # Set the number of digits to display in output
options(scipen = 999) # Set scientific notation to not be used with a high penalty
options(tab.width = 2)
options(width = 60)
options(editor = "TextEdit")
options(usethis.full_name = "Your Name Here") # Set your name for use in package development
options(usethis.protocol = "https")
# fancy quotes are annoying and lead to
# 'copy + paste' bugs / frustrations
options(useFancyQuotes = FALSE)
options(prompt = "R> ") # CUSTOM prompt
options(max.print = 400)
options(repos = c(CRAN = "https://repo.miserver.it.umich.edu/cran/"))
```

It is generally a bad idea to set the default library path in your .Rprofile file, as this can cause issues when you share your code with collaborators.
Similarly, it is generally a bad idea to load packages in your .Rprofile file, as this can cause issues when you share your code with collaborators. 
Instead, you should load packages in your R scripts or RMarkdown files, or use the {renv} package to manage your project-specific library paths and package versions.

Note that to apply changes to your R session, you need to save the `.Rprofile` file and then restart R. You can do this by clicking on Session/Restart R in RStudio, or by pressing Shift-Cmd-O.

## Setting up your .Renviron file
You can use the .Renviron file to store secrets that you need to use to access data through APIs (Application Programming Interfaces). APIs are a common way to make data public, but require users to present a password or key to gain access to the data. API keys are commonly used for REDCap databases, US Census data,  Instead, you should use the .Renviron file to set environment variables that are specific to your project or your computer.


::: explore
### Explore REDCapTidieR and Quarto Dashboards

You can find out a lot more about REDCapTidieR [here](https://chop-cgtinformatics.github.io/REDCapTidieR/).

There is great documentation on Quarto Dashboards [here](https://quarto.org/docs/dashboards/).

You can also find a lot of great examples of Quarto dashboards in the [gallery](https://quarto.org/docs/gallery/).

Some good examples of clinical study monitoring with dashboards can be found [here](https://jenthompson.me/examples/progressdash) and [here](https://www.insight-icu.org/). These are both examples of clinical trials that are being monitored with dashboards, and they provide a good overview of the study progress and data collection. The links to the source code for these dashboards are available [here](https://jenthompson.me/2018/02/09/flexdashboards-monitoring/).

Details on publishing webpages with Quarto Pub (and how to get authorization tokens) can be found [here](https://quarto.org/docs/publishing/quarto-pub.html).

You can find out more about crontab [here](https://crontab.guru/), and more generally about scheduling cron jobs [here](https://www.tecmint.com/schedule-cron-jobs-in-linux/).


:::
