---
title: "Updating R, RStudio, and Your Packages"
author: "Peter Higgins"
output: html_document
---



# Updating R, RStudio, and Your Packages

## Installing Packages
The most important way to update R is to add _packages_. Each package adds new functions and/or data to R, enabling you to do much more in the R and RStudio environment.

When you open R, or start a new session, you have only the base version of R available, and it is pretty spartan. You can see how many packages you have available to you by starting RStudio and going to the menu Session/New Session, or Session/Restart R. Each of these will give you a clean workspace to start in. Once you have started a new session, or restarted R, run the following code:


```r
print(.packages())
```

```
##  [1] "medicaldata" "forcats"     "stringr"     "dplyr"      
##  [5] "purrr"       "readr"       "tidyr"       "tibble"     
##  [9] "ggplot2"     "tidyverse"   "stats"       "graphics"   
## [13] "grDevices"   "utils"       "datasets"    "methods"    
## [17] "base"
```

You will find that you only have 9 packages available, including base, utils, methods, stats, graphics, grDevices, datasets, devtools, and usethis.   

In order to use more of the power of R and RStudio, you will need to install packages (a one-time task), and load them (in each session) before use with a _library(package_name)_ function.

If you Google a bit for ways to do things in R, you will find many packages that can be helpful. The most strictly validated packages are hosted on CRAN - a mirrored server. There are now over 20,000 packages on CRAN to do various specialized things in R. These were all useful for someone, so they have shared them on CRAN. To install packages from CRAN, you use the function:

`install.packages("package_name")`

Notice that the package_name has to be in quotes. These can be single or double quotes. The package_name and install.packages() are _case_sensitive_ like all objects and functions in R, so that something like `Install.Packages` will not work.

Once the package is installed, you keep that in your R library associated with your current major version of R. You will need to update & reinstall packages each time you update a major version of R. R versions are designated with R version #.#.#  A change in the third number indicates a minor version change. A change in the first or 2nd number (from R 3.6.2 to 4.0.0, or 4.0.2 to 4.1.0) is a major version upgrade which will require re-installation of packages.

Let's practice installing a package. Run the code below to install the _tidyverse_ package.


```r
install.packages("tidyverse")
```

```
## 
## The downloaded binary packages are in
## 	/var/folders/93/s18zkv2d4f556fxbjvb8yglc0000gp/T//RtmpI8vFuX/downloaded_packages
```

### Installing Packages from Github
Some packages are still in development. These are often in repositories on github, rather than on the CRAN servers. To install these packages, you need to know path to the repository. You can install the _medicaldata_ package from Github. Run the code below to install this package.


```r
devtools::install_github("higgi13425/medicaldata")
```

```
## Using github PAT from envvar GITHUB_PAT
```

```
## Skipping install of 'medicaldata' from a github remote, the SHA1 (1c039d8b) has not changed since last install.
##   Use `force = TRUE` to force installation
```

In contrast, to install.packages, the library() function can work with quotes around the package_name, but they are not required. This is because these packages are already installed in your R library, and are known quantities. In general, known objects in your R environment do not require quotes, and novel things like packages do require quotes.

If you re-run `print(.packages)` at this point, you will not have any more packages. This is because you have installed new packages, but not loaded them.

### Problems with Installing Packages

#### R Version Issues
Sometimes you may run into a problem installing a package which was developed for a previous version of R. Especially if you have recently upgraded your R version recently, the CRAN version of a package may be a bit behind. This can often be fixed by googling for "github" and "package_name". This will usually lead you to the github repository for that package, which will have a pathname of "github_username/package_name". Once you know this, you can use

`devtools::install_github('github_username/package_name') to install the newest version of the package, which will usually be compatible with the latest version of R.

#### Installing from Source vs Binaries

#### Dependencies
Some packages are dependent on *specific* versions of other packages, and will ask you to update the other packages during installation. As a general rule, you should say 'yes'. If you are worried about over-writing an existing package in a way that would break your code in a different project, then that project needs its own project-specific library, which you can create with the {renv} package.

#### Extra-R Dependencies
Sometimes packages require (depend upon) software that is not part of the R ecosystem. These will generally give you messages during the install process asking you to install this helper software. Common helper software includes things like Fortran and RJava. Sometimes you will need to go to websites, or use software like Homebrew (on the Mac) to install these extra helper pieces of software. 

## Loading Packages with Library

Run the code chunk below to load both {tidyverse} and {medicaldata}. Note that the {tidyverse} package is actually a meta-package that contains 8 packages, and each one has its own version number.


```r
library(tidyverse)
library(medicaldata)
```
Notice that loading tidyverse led to some **conflict** messages. The dplyr::filter function masks the stats::filter() function. These two packages, {dplyr} and {stats}, both have a function named filter(). The more recently loaded package is assumed to be the default, so if you call a filter() command, R will use dplyr::filter(). If you want to call the stats::filter() command, you have to explicitly use the package::function() format. If you are not sure which package you loaded last, it can be wise to use the explicit format when calling functions in R.

The other masked function is _lag()_. The function dplyr::lag() is masking stats::lag(), as {dplyr} was loaded after {stats}. Most of the time this is not a big difference, but every once in a while a conflict between package functions can get very confusing. When in doubt, use the explicit format, in which you call package::function() to make clear what you mean - dplyr::lag() vs. stats::lag().

Note that it is *good practice* to load all of your packages needed for an R script or an Rmarkdown (.Rmd) document at the **beginning** of the script or .Rmd. This allows someone else using your script or Rmd to check whether they have the needed packages installed, and install them if needed. In an Rmarkdown document, this is done in a special _setup_ code chunk near the top of the document. If some of these packages are not on CRAN, it is good practice to add a comment (a statement after a hashtag) on how to install this package. For example, in a setup chunk that loads {tidyverse} and {medicaldata}, it is a good idea to add a comment on how to install {medicaldata}, which is not yet on CRAN. See the example below


```r
library(tidyverse)
library(medicaldata)
# the {medicaldata} package can be installed with devtools::install_github('higgi13425/medicaldata')
```

## Updating R


## Updating RStudio


## Updating Your Packages
