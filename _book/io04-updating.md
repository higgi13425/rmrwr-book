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

Once the package is installed, you keep that in your R library associated with your current major version of R. You will need to update & reinstall packages each time you update a major version of R. R versions are designated with R version #.#.#  A change in the third number indicates a *patch level* change. A change in the first number (from R 3.6.2 to 4.0.0) is a major version change, while a change in the middle number (4.0.2 to 4.1.0) is a minor version change. Any major or minor version upgrade will require re-installation of your add-on packages into a version-specific package library.

Let's practice installing a package. Run the code below to install the _remotes()_ package.


```r
install.packages("remotes")
```

### Installing Packages from Github
Some packages are still in development. These are often in repositories on GitHub, rather than on the CRAN servers. To install these packages, you need to know path to the repository. You can install the development version of the _medicaldata_ package from Github (the stable version is on CRAN). Run the code below to install this package (this assumes that you already have the remotes package installed).


```r
remotes::install_github("higgi13425/medicaldata")
```

In contrast to install.packages, the _library()_ function can work with quotes around the package_name, but they are not required. This is because these packages are already installed in your R library, and are known quantities. In general, known objects in your R Environment pane (dataframes, vectors) do not require quotes, and novel things like new packages (or variables hidden inside of a data frame) do require quotes or a $ - though the tidyverse packages work around this quote issue for variables inside of a data frame.

If you re-run `print(.packages)` at this point, you will not have any more packages. This is because you have installed new packages, but not loaded them with `library()`.

Notice that you were able to use the {remotes} package function, _install_github()_ above, without loading the package with `library(remotes)`, because you explicitly called the function with its package name, as in `remotes::install_github()`.

:::tryit
Try installing a few more packages, like "janitor", or "gtsummary".
These should now show up with `installed.packages()`.
Then use `library()` to load these packages,
and see that the output of `print(.packages)` has changed.
:::

### Problems with Installing Packages

#### R Version Issues
Sometimes you may run into a problem installing a package which was developed for a previous version of R. Especially if you have recently upgraded your R version recently, the CRAN version of a package may be a bit behind. This can often be fixed by googling for "github" and "package_name". This will usually lead you to the github repository for that package, which will have a pathname of "github_username/package_name". Once you know this, you can use

`devtools::install_github('github_username/package_name')` to install the newest version of the package, which will usually be compatible with the latest version of R.

#### Installing from Source vs Binaries

When you install or update a package that is in rapid development, you may get this message:

`There are binary versions available but the source
  versions are later:
               binary source needs_compilation
tidyr           1.1.4  1.2.0              TRUE`

This means that the latest version (in this case, 1.2.0), is available, but it has to be compiled and built from source code, which is a bit slower. It is faster to install from binary files, which tend to be available on CRAN (built by the CRAN volunteer maintainer team) a little bit later. When the binary version of a package is not yet available, you will be asked to decide - you can install the source code version (installs slower, but you get the very latest version), or the binary version (installs fast, but a version behind). Most of the time, unless you have a very slow internet connection, you want to install from the **source** version. The compilation part is what slows the installation. Usually, you want to answer Yes to the question 
`Do you want to install from sources the packages which need compilation? (Yes/no/cancel)`

Why do some packages need to be compiled from source (~ 25%) and others (~75%) don't? 
Usually it is because the ones that need to be compiled include another language (like C or C++, rather than pure R) which needs to be compiled. These additional languages are usually used to improve processing speed of the resulting functions.


#### Dependencies
Some packages are dependent on *specific* versions of other packages, and will ask you to update the other packages during installation. As a general rule, you should say 'yes' to all packages. If you are worried about over-writing an existing package in a way that would break your code in a different project, then that project needs its own project-specific library, which you can create with the {renv} package.

#### Extra-R Dependencies
Sometimes packages require (depend upon) software that is not part of the R ecosystem. These will generally give you messages during the install process asking you to install this helper software. Common helper software packages include things like `gtk+`, `freetype`, and `proj`. Sometimes you will need to go to websites, or use software like Homebrew (on the Mac) to install these extra helper pieces of software. If you have never used Homebrew, here is a basic [guide](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-homebrew-on-macos) to get you started. The Homebrew page is [here](https://brew.sh). You can search on the Homebrew page and usually find the packages you need. They can be installed (via your Terminal Application (in Utilties) with something like `brew install packagename`. A bit of googling with the error message as the search term will usually help you find the specific package name. Once the external-to-R package is installed, you can go back and install the R package that depends on the external software package.

#### Package Installation Failed

Sometimes you will get a message like:

`Warning in install.packages : installation of package "ragg" had non-zero exit status`

  This means that the package installation failed. Sometimes it is because there is a problem with the package, but more often there is a missing dependency.  Often you can figure this out by scrolling upward. You will often find messages telling you that 
  `fatal error: 'ft2build.h' file not found`

Suggesting that you need a file named 'ft2build.h'. You will likely need to web search for this error to find out how to fix it, usually by downloading and installing a piece of software that the problematic package needs in order to run.

Another example - 
`configure: error: Install libtiff-dev or equivalent first (or set PKG_MODULE if non-standard) ERROR: configuration failed for package 'tiff'`

You are missing a piece of software external to R called *libtiff-dev*. The error message is fairly helpful.

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

#### Explicitly Managing Function Conflicts

You can also manage conflicts between identically-named functions from different packages in R with the {conflicted} package, which identifies conflicts when you have called a function without explicitly naming the package that it is from.
You load `library(conflicted)` and it will watch out for conflicts and send an error when you call a function in an ambiguous way.

If you don't want to always explicitly specify between `dplyr::filter`, `base::filter` and `rstatix::filter`, you can set your default version of a function right after you load your libraries, with `conflicted::conflict_prefer("filter", "dplyr")`, which tells R that you want to use the `dplyr` version of `filter` by default, and that you will specify if you want to use `base::filter` or `rstatix::filter`.

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
