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

:::warning
**Be Mindful** <br>
Do not just upgrade R to a new minor (or major) version in the middle of a project.
This will take a bit of work and time, maybe an hour if you have a lot of packages installed, as this will require re-installing packages to a new library folder.
:::

## Preparing for a Minor or Major R Upgrade

You want to check the current R version at [r-project.org](https://www.r-project.org). It may have been a while since you upgraded.

Let's check your current R version, with
`R.Version()`. If you are not in the middle of a major project, it may be a good time to upgrade. There are several new features (like the native pipe) being added to base R that are worth checking out.

:::warning
Before you jump into upgrading R versions and packages, make sure that any important projects are protected. Make sure that your important ongoing projects use the {renv} package to preserve their Environment, and that you have taken a recent snapshot with `renv::snapshot()`
:::


Also, check out your current package library, with
`.libPaths()`. This should look something like:
`[1] "/Library/Frameworks/R.framework/Versions/4.1/Resources/library"`

Note that this package library is specific to the most recent major and minor version of R. If you upgrade from 4.0.x to 4.1.x, you will have a new library path to a new 4.1 folder, and will need to re-install packages in this folder.

You can do this from scratch, and just install packages as you need them (which is not a bad way to clean out packages you are not using), but a lot of people prefer to re-install all of their packages in an organized way, rather than just-in-time when they want to use them.

You can see a dataframe of all your currently installed packages with the base R function `installed.packages()`. This will help us make a list of your packages for updating.

There is also a package for Windows, {installr}, which will pull the list of your current packages and install these in the correct folder for the new version of R. If you are on a Windows OS, and have installed the {installr} package, the `installr::updateR()` command performs the following:

- finding the latest R version
- downloading it
- running the installer
- deleting the installation file
- copy old packages to the new R installation
- updating old packages as needed for the new R installation

But for MacOS and UnixOS folks, this must be done manually.

Let's do this step by step for the Mac and Linux folks.

## Saving a List of Your Packages

The short script below will save a vector of your current packages to a file in your root (home) directory, named `installed.packages.rda`.
Copy this code chunk below into your Console pane in RStudio and run it.
Then reopen RStudio, go to the Files tab, click on Home , and check your root (home) directory for the `installed.packages.rda` file.
You can click on this file to load it into your Environment tab (answer yes to load). In your Environment tab, it should look like a character vector with the names of all of your packages in quotes.


```r
tmp = installed.packages() 
# save list to tmp as a matrix object
installedpackages = as.vector(tmp[is.na(tmp[,"Priority"]), 1]) 
# filter for all rows where the "Priority" column is NA, and select just (column 1) the package names in quotes, and then assign this vector to the installedpackages object
save(installedpackages, file="~/installed_packages.rda") # save this vector as an *.rda file in your root (home) directory
rm(tmp)
rm(installedpackages)
# remove the tmp matrix and the installedpackages vector from your Environment
```

## Upgrading R (and RStudio)

Now that you have your saved list of packages stored in a file, you are ready to upgrade R. Quit RStudio, and go to [r-project.org](https://www.r-project.org). The first paragraph of text under the heading **Getting Started** will have a link to **download R**. Click on this link, and select a nearby CRAN mirror to download from. If you are in the United States, you will have to scroll down a long way (alphabetical by country) to USA. Pick one that is reasonably close, click through, and Download and install a new version of R for your operating system.

If you are not sure of the steps, refer to Chapter 2, Getting Started and Installing Your Tools.

Once this is set, you are ready to re-open RStudio. If you haven't updated RStudio in a while, it might be a good time to update RStudio as well (and get *rainbow parentheses*!) - once RStudio is open, go to **Help/Check for Updates**. If you are not using the latest version of RStudio, you will be directed to update and restart RStudio.

### Reinstalling your list of Packages

First, let's chack your new R version with
`R.Version()` - run this in the Console pane. This should be the new version.

Now let's check your library path with `.libPaths()` - run this in the Console Pane - this should match your R version.

Now run `installed.packages()`. This should show that your new library is mostly empty, except for the base R packages. We will now fix that.

Now you need to take advantage of your nicely-stored list of packages to reinstall all of your packages in your new (mostly empty) library.

We will use the short script below to load the file `installed.packages.rda` to open a vector of your previous packages in your Environment pane, and then re-install all of these packages.
Copy this code chunk below into your Console pane in RStudio and run it.
This will take a while, especially if you have a lot of packages installed.

While you are waiting, check out the code chunk below. The first step is to load the `installedpackages.rda` file from your root (home) directory into your Environment pane. Then it starts taking action on this vector of package names. See what it does in the next step, the `for loop`, and think about how it works. 
- It measures the length of the vector, `installedpackages`. 
- Then it counts from 1 to the length of `installedpackages`. 
- For each count, it installs the package at position [count] in the vector
  - Then it goes to the next [count] value, and installs the next package in the vector
  - Until it reaches the full length of the vector (installs the last package), and then stops.


```r
load("~/installed_packages.rda")
# loads vector into your Environment pane

for (count in 1:length(installedpackages)) {
    install.packages(installedpackages[count])
}
# For each package in this vector of length [count], install them one by one until the last one is installed.
```

## Now Check your list of Packages
When all of the installation is complete, you can check your work.

Review the Console text for errors or problems. You may find you need software packages external to R, or that you have tried to install some packages that are not on CRAN. Many packages that are not on CRAN are ones that you may have previously installed from Github or BioConductor. 

Note these by making a list, and install those from GitHub with `remotes::install_github("username/packagename)`. As one example, you can install the development version of the {medicaldata} package from github with `remotes::install_github("higgi13425/medicaldata)`. Note that the stable version is available on the CRAN repository. 

You may have similar issues with packages installed from BioConductor, which requires you to use `BiocManager::install("packagename")`.

Once you have completely installed your packages, check your work by running `installed.packages()` again. You should see a full list of your packages, and you are updated and ready to go!


## Updating Packages

If all of your current important projects are protected with an {renv} snapshot, this is probably a good time to update your tools (packages). 

You can do this easily within RStudio with **Tools/Check for Package Updates**. Select All, and let the updates begin. You will usually want to compile the newest version from source code, rather than a recent version from binaries. 

If you have problems with updating packages, check the troubleshooting guide at Chapter 12.1.2, Problems with Installing Packages.
