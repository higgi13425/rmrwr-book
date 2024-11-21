---
title: "Major and Minor R Updates (Where Did My Packages Go?)"
author: "Peter Higgins"
output: html_document
---



# Major R Updates (Where Are My Packages?)

Versions of R have numbers attached, like R.4.1.2.

The first number is the *major* version (4).

The second number is the *minor* version (1).

The third number is the *patch level* (2).

When you upgrade R from one patch level to the next, from 4.1.1 to 4.1.2, the changes are very minor, and backward-compatible.

However, when you upgrade from one minor version (the middle number) to the next, from 4.0.2 to 4.1.0, you will find that your carefully installed and much-beloved packages are **gone**. All of the add-on packages you know and love, from {tidyverse} to {rstatix}, did not come along for the upgrade.
Note that these are not actually **gone**, but in a library specific to the previous minor version (4.1), and that you are expected to have a new library for 4.2.
The reason for this is that packages are built/updated for minor versions, and if you just tried to use the 4.1 version with R 4.2, you could have some mysterious errors. This likely only applies to 1-3% of packages with each minor update, but it is super-annoying to try to track down which package is misbehaving and needs to be rebuilt for the new version.
So it is generally not recommended to just copy your packages from the old library (4.1) to the new (4.2) library, but to rebuild them.

:::warning
**Be Mindful** <br>
Do not just upgrade R to a new minor (or major) version in the middle of a project.
This will take a bit of work and time, maybe an hour if you have a lot of packages installed, as this will require re-installing packages to a new library folder.
:::

## Preparing for a Minor or Major R Upgrade

You want to check the current R version at [r-project.org](https://www.r-project.org). It may have been a while since you upgraded.

Let's check your current R version, with
`R.Version()` in the Console. If you are not in the middle of a major project, it may be a good time to upgrade. There are several new features (like the native pipe) being added to base R that are worth checking out.

:::warning
Before you jump into upgrading R versions and packages, make sure that any important projects are protected. Make sure that your important ongoing projects use the {renv} package to preserve their Environment, and that you have taken a recent snapshot with `renv::snapshot()`
:::

Take a moment to identify the location of your current package library, with
`.libPaths()`. This should look something like:
`[1] "/Library/Frameworks/R.framework/Versions/4.1/Resources/library"`
**Copy** this current library path to something like Notes or Notepad on your computer **NOW**.

Note that this package library is specific to the most recent major and minor version of R. If you upgrade from 4.0.x to 4.1.x, you will have a new library path to a new 4.1 folder, and will need to re-install packages in this folder.

### Installing New Packages from Scratch

You can do this from scratch, and just install packages as you need them (which is not a bad way to clean out packages you are not using), but a lot of people prefer to re-install all of their packages in an organized way, rather than just-in-time when they want to use them. It can be a little annoying for the first week after an upgrade to frequently have to stop and reinstall packages, but it usually only lasts about a week.

You can see a dataframe of all your currently installed packages with the base R function `installed.packages()`. This will help us make a list of your packages for updating.
If you are doing this from scratch, you may want to copy this to a word document for your future reference, and spend 10 minutes installing your favorite 30 packages or so (and all dependencies) to get started. This is a good way to do a bit of spring cleaning, and not just blindly reinstall every package you tried once and never used again. You can always install more as you need them.

For folks who want to do some spring cleaning of their package library, here is a **starter list** of packages that are commonly used in the R community. You can copy and paste this into the Console to install them all at once. These packages (along with their dependencies, which also get installed) will cover around 85% of your everyday packages, and will get you started without having to stop frequently to install packages on day one of a new version of R.


``` r
install.packages("pak")
```

```
## 
## The downloaded binary packages are in
## 	/var/folders/93/s18zkv2d4f556fxbjvb8yglc0000gp/T//Rtmpyf9e1o/downloaded_packages
```

``` r
pak::pak(c("tidyverse", "rstatix", "tidymodels", "readxl", "writexl", "shiny", "rmarkdown", "keyring", "broom", "duckplyr", "dtplyr", "data.table", "labelled", "ggfont", "extrafont", "flexdashboard", "flextable", "gtsummary", "googlesheets4", "REDCapTidieR", "janitor", "ggraph", "gganimate", "tidygraph", "janitor", "webexercises", "synthpop", "slider", "usethis", "testthat", "remotes", "devtools", "httr2", "dataExplorer", "naniar", "visdat", "randomForest", "xgboost", "glmnet", "caret", "ranger", "rpart", "lme4", "keyring", "scholar", "medicaldata", "NHSRdatasets", "lintr", "datapasta", "magick", "magrittr", "officer", "palmerpenguins", "pkgdown", "bookdown", "plotROC", "pwr", "waffle", "ragg", "RColorBrewer", "XML", "conflicted", "corrplot", "jsonlite", "DT", "kable", "kableExtra", "quarto"))
```

```
## Error: ! error in pak subprocess
## Caused by error: 
## ! Could not solve package dependencies:
## * tidyverse: dependency conflict
## * rstatix: dependency conflict
## * tidymodels: dependency conflict
## * readxl: dependency conflict
## * writexl: dependency conflict
## * shiny: dependency conflict
## * rmarkdown: dependency conflict
## * keyring: dependency conflict
## * broom: dependency conflict
## * duckplyr: dependency conflict
## * dtplyr: dependency conflict
## * data.table: dependency conflict
## * labelled: dependency conflict
## * ggfont: Can't find package called ggfont.
## * extrafont: dependency conflict
## * flexdashboard: dependency conflict
## * flextable: dependency conflict
## * gtsummary: dependency conflict
## * googlesheets4: dependency conflict
## * REDCapTidieR: dependency conflict
## * janitor: dependency conflict
## * ggraph: dependency conflict
## * gganimate: dependency conflict
## * tidygraph: dependency conflict
## * webexercises: dependency conflict
## * synthpop: dependency conflict
## * slider: dependency conflict
## * usethis: dependency conflict
## * testthat: dependency conflict
## * remotes: dependency conflict
## * devtools: dependency conflict
## * httr2: dependency conflict
## * dataExplorer: Can't find package called dataExplorer.
## * naniar: dependency conflict
## * visdat: dependency conflict
## * randomForest: dependency conflict
## * xgboost: dependency conflict
## * glmnet: dependency conflict
## * caret: dependency conflict
## * ranger: dependency conflict
## * rpart: dependency conflict
## * lme4: dependency conflict
## * scholar: dependency conflict
## * medicaldata: dependency conflict
## * NHSRdatasets: dependency conflict
## * lintr: dependency conflict
## * datapasta: dependency conflict
## * magick: dependency conflict
## * magrittr: dependency conflict
## * officer: dependency conflict
## * palmerpenguins: dependency conflict
## * pkgdown: dependency conflict
## * bookdown: dependency conflict
## * plotROC: dependency conflict
## * pwr: dependency conflict
## * waffle: dependency conflict
## * ragg: dependency conflict
## * RColorBrewer: dependency conflict
## * XML: dependency conflict
## * conflicted: dependency conflict
## * corrplot: dependency conflict
## * jsonlite: dependency conflict
## * DT: dependency conflict
## * kable: Can't find package called kable.
## * kableExtra: dependency conflict
## * quarto: dependency conflict
```

## Rebuilding All Packages in One (Automated) Step

There is a slick package called {updater} which can handle the grunt work for you. It can be found at https://www.danieldsjoberg.com/updater/
You may want to do this at the end of the day, as it will take 30-60 minutes to reinstall all of your packages.

There are 3 steps:

1. Copy and save the path to your current R system library before you upgrade R.
- Run `.libPaths()` in the Console to get the path to your current library.
- Copy this path to a text file or Notes/Notepad on your computer.

2. Upgrade R to the new version.
- Go to [r-project.org](https://www.r-project.org) and download the new version of R.
- Install the new version of R.
- restart R and RStudio - confirm that the new version is running with `R.Version()`.
- While you are at it, check in the RStudio menu `Help/Check for Updates` to see if there is a new version of RStudio. Upgrade this if needed

3. Install your packages to the new library.
- Install the {updater} package with `install.packages("updater")`.
- Run `updater::install_pkgs(lib.loc = c("<location(s) saved in Step 1>"))` in the Console. Note that this is the point where you copy the saved library path from Step 1 into the parentheses (with quotes) into the Console. This will end up looking something like `updater::install_pkgs(lib.loc = c("/Library/Frameworks/R.framework/Versions/4.1/Resources/library"))`.

Depending on your number of packages, this might take 30-60 minutes. There is a progress bar. You can go get a coffee or do some other work while this is running, or head home.

## Checking the new library path

When all of the installation is complete, you can check your work.

You can check the new library path with `.libPaths()`. This should now point to the new library folder for the new version of R. If you have multiple library paths, the first one is the one that will be used for installing packages.
It should look something like `/Library/Frameworks/R.framework/Versions/4.4-arm64/Resources/library"`

## Now Check your list of Packages

You should also review the Console text for errors or problems. You may find you need software packages external to R, or that you have tried to install some packages that are not on CRAN. Many packages that are not on CRAN are ones that you may have previously installed from Github or BioConductor. 

Note these by making a list of packages left to be installed, and install those from GitHub with `remotes::install_github("username/packagename)`. As one example, you can install the development version of the {medicaldata} package from github with `remotes::install_github("higgi13425/medicaldata)`. Note that the stable version is available on the CRAN repository. 

You may have similar issues with packages installed from BioConductor, which requires you to use `BiocManager::install("packagename")`.

Once you have completely installed your packages, check your work by running `installed.packages()` again. You should see a full list of your packages, and you are updated and ready to go!


## Updating Packages

If all of your current important projects are protected with an {renv} snapshot, this is probably a good time to update your tools (packages). 

You can do this easily within RStudio with the menu commands **`Tools/Check for Package Updates`**. Select All, and let the updates begin. You will usually want to compile the newest version from source code, rather than a recent version from binaries. 

If you have problems with updating packages, check the troubleshooting guide at Chapter 12.1.2, Problems with Installing Packages.

