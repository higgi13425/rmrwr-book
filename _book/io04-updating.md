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

You will find that you only have 9 packages available, including base, utils, methods, stats, graphics, grDevices, datasets, devtools, and usethis. This is what is called "base R" and is essentially the bare minimum needed to use R.

In order to use more of the power of R and RStudio, you will need to install packages (a one-time task), and load them (in each session) before use with a _library(package_name)_ function.

If you Google a bit for ways to do things in R, you will find many packages that can be helpful. The most strictly validated packages are hosted on CRAN - a mirrored server. There are now over 20,000 packages on CRAN to do various specialized things in R. These were all useful for someone, so they have shared them on CRAN. To install packages from CRAN, you use the function:

`install.packages("package_name")`

Notice that the package_name has to be in quotes. These can be single or double quotes. The package_name and install.packages() are _case_sensitive_ like all objects and functions in R, so that something like `Install.Packages` will not work.

Once the package is installed, you keep that in your R library associated with your current major version of R. You will need to update & reinstall packages each time you update a major version of R. R versions are designated with R version #.#.#  A change in the third number indicates a minor version change. A change in the first or 2nd number (from R 3.6.2 to 4.0.0, or 4.0.2 to 4.1.0) is a major version upgrade which will require re-installation of packages.

Let's practice installing a package. Run the code below to install the _tidyverse_ package.


```r
install.packages("tidyverse")
```

### Installing Packages from Github
Some packages are still in development. These are often in repositories on github, rather than on the CRAN servers. To install these packages, you need to know path to the repository. You can install the _medicaldata_ package from Github. Run the code below to install this package.


```r
devtools::install_github("higgi13425/medicaldata")
```

In contrast to install.packages, the _library()_ function can work with quotes around the package_name, but they are not required. This is because these packages are already installed in your R library, and are known quantities. In general, known objects in your R environment do not require quotes, and novel things like packages do require quotes.

If you re-run `print(.packages)` at this point, you will not have any more packages. This is because you have installed new packages, but not loaded them.

### Problems with Installing Packages

#### R Version Issues
Sometimes you may run into a problem installing a package which was developed for a previous version of R. Especially if you have recently upgraded your R version recently, the CRAN version of a package may be a bit behind. This can often be fixed by googling for "github" and "package_name". This will usually lead you to the github repository for that package, which will have a pathname of "github_username/package_name". Once you know this, you can use

`devtools::install_github('github_username/package_name')` to install the newest version of the package, which will usually be compatible with the latest version of R.

#### Installing from Source vs Binaries

#### Dependencies
Some packages are dependent on *specific* versions of other packages, and will ask you to update the other packages during installation. As a general rule, you should say 'yes' to all packages. If you are worried about over-writing an existing package in a way that would break your code in a different project, then that project needs its own project-specific library, which you can create with the {renv} package.

#### Extra-R Dependencies
Sometimes packages require (depend upon) software that is not part of the R ecosystem. These will generally give you messages during the install process asking you to install this helper software. Common helper software includes things like Fortran and RJava. Sometimes you will need to go to websites, or use software like Homebrew (on the Mac) to install these extra helper pieces of software. A bit of googling will usually help with the specific package requirements.

## Loading Packages with Library

Run the code chunk below to load both {tidyverse} and {medicaldata}. Note that the {tidyverse} package is actually a meta-package that contains 8 packages, and each one has its own version number.


```r
library(tidyverse)
library(medicaldata)
```
Notice that loading tidyverse led to some **conflict** messages. The dplyr::filter function masks the stats::filter() function. These two packages, {dplyr} and {stats}, both have a function named filter(). The more recently loaded package is assumed to be the default, so if you call a filter() command, R will use dplyr::filter(). If you want to call the stats::filter() command, you have to explicitly use the package::function() format. If you are not sure which package you loaded last, it can be wise to use the explicit format when calling functions in R.

The other masked function is _lag()_. The function dplyr::lag() is masking stats::lag(), as {dplyr} was loaded after {stats}. Most of the time this is not a big difference, but every once in a while a conflict between package functions can get very confusing. When in doubt, use the explicit format, in which you call package::function() to make clear what you mean, as in dplyr::lag() vs. stats::lag().

Note that it is *good practice* to load all of your packages needed for an R script or an Rmarkdown (.Rmd) document at the **beginning** of the script or .Rmd. This allows someone else using your script or Rmd to check whether they have the needed packages installed, and install them if needed. In an Rmarkdown document, this is done in a special _setup_ code chunk near the top of the document. If some of these packages are not on CRAN, it is good practice to add a comment (a statement after a hashtag) on how to install this package. For example, in a setup chunk that loads {tidyverse} and {medicaldata}, it is a good idea to add a comment on how to install {medicaldata}, which is not yet on CRAN. See the example below


```r
library(tidyverse)
library(medicaldata)
# the {medicaldata} package can be installed with remotes::install_github('higgi13425/medicaldata')
```

## Updating R
Every once in a while, you will want to update your version of R. Usually this occurs with a major version upgrade, when something important changes. You may not rush into this, as it means re-installing all of your packages, but eventually it is worth it to be up to date. 

In order to update R, you have to find your installed version of R and run it on its own, outside of RStudio. This is easy if you have an R desktop shortcut, but not too hard if you hunt around a bit in your Applications folder. 

Double click the R icon to start up R. It will open the R Console and a menu. Click on the R menu at top left, and select Check for R Updates. If you are up to date, the R Console will report "Your version of R is up to date".
If not, this process will provide windows and buttons to click to upgrade to the latest version of R. When done, quit R and start RStudio to make sure the update has carried over. You should see the new version number when RStudio starts.

## Updating RStudio
To update RStudio, just run RStudio, and go to the Help menu in the top menu bar (not the Help tab in the lower right quadrant). In the Help menu, select Check for Updates. It will tell you if you are using the latest version of RStudio, or will direct you to the website to download the latest version.

## Updating Your Packages
To update your packages, you go to the Tools menu in RStudio, and select Check for package updates. You will usually get a list of the packages that have been updated since you installed them. Generally, select Update All, and allow one restart of your R session. RStudio may ask you if you want to restart more than once, but always say no after the first session restart. 
You may be asked about installing some packages from source, and you should generally select Yes. In general, your Console pane will be a bit chatty as it documents all the steps in package installation, but should generally end with something like:

"The downloaded source packages are in
	'/private/var/folders/93/s18zkv2d4f556fxbjvb8yglc0000gp/T/RtmpHnsvlh/downloaded_packages'"

and return to your > 
prompt.

If you then re-check for Package Updates, you will get the message that all of your packages are up to date.

This process is a bit different after a major version upgrade of R, which we will cover in a later chapter. You have to retreive a list of all your packages, decide which to keep, and then install these fresh in the new version of R (and its new, major-version-specific package library).
