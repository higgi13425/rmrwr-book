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

However, when you upgrade from one minor version (the middle number) to the next, from 4.0.2 to 4.1.0, you will find that most of your carefully installed and much-beloved packages are **gone**. All of the add-on packages you know and love, from {tidyverse} to {rstatix}, did not come along for the upgrade.
Note that these are not actually **gone**, but in a library specific to the previous minor version (4.1), and that you are expected to have a new library for 4.2.
The reason for this is that packages are built/updated for minor versions, and if you just tried to use the 4.1 version with R 4.2, you could have some mysterious errors. This likely only applies to 1-3% of packages with each minor update, but it is super-annoying to try to track down which package is misbehaving and needs to be rebuilt for the new version.
So it is generally not recommended to just copy your packages from the old library (4.1) to the new (4.2) library, but to rebuild them.

:::warning
**Be Mindful** <br>
Do not just upgrade R to a new minor (or major) version in the middle of a project.
This will take a bit of work and time, maybe 10 minutes if you have a lot of packages installed, as this will require re-installing packages to a new library folder. It is possible, though unlikely, that parts of your project may break with a new version of R. The R Consortium tries to avoid breaking changes, especially for recent majpr versions of R.
:::

## When to Upgrade R
As a general rule, patch upgrades are very minor, but fix problems that have been found with the previous version. You can upgrade to a new patch version at any time, and it is recommended to do so.

Upgrading to a new minor or major version is a bit more involved. You usually want to wait a week or two after an upgrede for all of the assorted package binaries to catch up and be customized for the new version. You may also want to wait for the first patched version (e.g., 4.5.1, rather than 4.5.0) to come out, to make sure your work is not exposed to the initial bugs of a new version. There usually aren't many, and they usually aren't major, but it is a conservative approach to wait for the `*.*.1` version. On the other hand, sometimes the new features of the new version are so compelling that you don't want to wait.

## Preparing for a Minor or Major R Upgrade

You want to check the version number of the current R version at [r-project.org](https://www.r-project.org). It may have been a while since you upgraded.

Let's also check your current installed R version, with
`R.Version()` in the Console. If you are not in the middle of a major project, it may be a good time to upgrade. There are several new features (like the native pipe, installing packages in parallel) being added to base R that are worth the upgrade.

:::warning
Before you jump into upgrading R versions and packages, make sure that any important projects are protected. Make sure that your important ongoing projects use the {renv} package to preserve their Environment, and that you have taken a recent snapshot with `renv::snapshot()`

You can also manage more than one R version on your local computer with the {rig} package, so that you can stick with R 4.2.3 until you finish that particular project, while working in R 4.5.1 in all of your new projects.
:::

Take a moment to identify the location of your current package library, with
`.libPaths()`. This should look something like:
`[1] "/Library/Frameworks/R.framework/Versions/4.1/Resources/library"`

Note that this package library is specific to the most recent major and minor version of R. If you upgrade from 4.0.x to 4.1.x, you will have a new library path to a new `4.1/Resources/library` folder, and will need to re-install packages in this folder.

Take a moment to explore this file path with `Finder` on the Mac or `Windows File Explorer` in Windows. Go to `/Library/Frameworks/R.framework/Versions/` to see all the past versions of R that you have installed. You will see a folder for each minor version of R you have installed, and inside each of these folders is a `Resources` folder, and inside of that is a `library` folder. This is where all of your packages are stored.

Take a moment to save this file path in a text file or a word document, as you will need to know where your most recent library is located when you upgrade R. This will be helpful if you choose to use the `updater` package to help you with the upgrade process.

### Before you upgrade R

You can copy over some packages from the previous version's library folder, but these were built under the prior version of R, and some of these won't work with the new minor version of R.
It is better (and now pretty fast) to rebuild these packages from scratch, and you can do this in one of two ways:

1. After the R upgrade, just install packages as you need them (which is not a bad way to clean out packages you are not actually using), but a lot of people prefer to re-install all of their packages in an organized way, rather than just-in-time when they want to use them. It can be a bit annoying for the first week or two after an upgrade to frequently have to stop and reinstall packages, but you get through it.

2. Re-install all of your packages in bulk right after thee R upgrade. This is a lot faster, and requires you to only stop your work once. 

### STEP 1: Clean up old, unused packages

If you are planning a bulk re-install (#2), you should first take a look at the current packages in RStudio. Click on the Help tab, then the Home icon, then under `Reference` in the Home window, select Packages. This will show you a list of your currently installed packages in your current library. Take 10 (or more,if you have many packages) minutes to inspect this list, and find packages that you used once and probably won't use again. This is a good way to do a bit of spring cleaning, and not just blindly re-install every package you tried once and never used again. You can always install more packages later as you need them.

As an example, I used the R package {blueycolors} for one specific project (it provides ggplot2 palettes for colors from the Bluey cartoon) and I don't need it anymore. I can just remove it from my library with `remove.packages("blueycolors")` and then install it again if I need it in the future. But if I find a bunch of packages like this that I want to remove, I can copy the package names from the help window and paste them into a vector in the Console to remove them all at once. I will create a starter vector named `pkg_remove_vec` with: (copy this code chunk and run it in your local RStudio session)


``` r
pkg_remove_vec <- Hmisc::Cs(c())
```

Then I can copy the package names from the Help window, and insert commas between them into the center of the parentheses, like this:


``` r
pkg_remove_vec <- c(Hmisc::Cs(billboarder, blueycolors, ggplot2movies))
```

Note that this requires that the {Hmisc} package is installed, so you may need to install {Hmisc} first. The `Cs` function from Hmisc will take comma-separated values and apply quotes around each item, turning this into a proper vector without you having to type out each quotation mark.

You now have a vector, `pkg_remove_vec` in your Environment.

### STEP 2: Build a dataframe of your currently installed packages.

You can build a dataframe of your currently installed packages with the code chunk below: (copy and run this in your local instance of RStudio)


``` r
pkg_current <- installed.packages() |>
  as.data.frame() |>
  dplyr::select(Package, Version) |>
  tibble::remove_rownames()
```

You can now see this dataframe in your Environment tab, with the number of packages (obs.) listed.  You can inspoect this dataframe by clicking on the name `pkg_current`, and then scroll through the list to see if there are any other packages you want to remove. 

### STEP 3: Removing unwanted Packages from the dataframe

You can remove unwanted packages from the dataframe with the code below. This will remove any packages in the `pkg_remove_vec` vector from the `pkg_current` dataframe.

``` r
pkg_current <- pkg_current |>
  dplyr::filter(!Package %in% pkg_remove_vec)
```

The data frame `pkg_current` now contains only the packages you want to keep. You will be able to use this dataframe to re-install all of your packages in bulk.

### STEP 4: Upgrading R to the new Version

- Go to [r-project.org](https://www.r-project.org) and download the new version of R.
- Install the new version of R.
- restart R and RStudio - confirm that the new version is running with `R.Version()`.

### STEP 5: Upgrading the RStudio Version

- While you are at it, check in the RStudio menu `Help/Check for Updates` to see if there is a new version of RStudio. Upgrade this if needed. The new version of RStudio will have updates to make it work better with the new version of R.

- Restart RStudio. You should now have the new version of R (check `R.Version()`) and the new version of RStudio (check `Help/Check for Updates` in RStudio).

Check your library path again with `.libPaths()`. You should see a new library path for the new version of R.
Explore this with Finder or Windows File Explorer. You should find a folder for your new version, with a `Resources` folder, and inside that a `library` folder. This is where a base set of packages will be installed. But you will be missing packages like `tidyverse`, `ggplot2`, and `dplyr` (and lots of others) that you had in your old version of R.

## STEP 6: Rebuilding All of your Packages in One (Automated) Step

There are two options for doing this:

1. You can use the `install.packages()` function to install all of your packages in one step with the dataframe we built earlier. You can use the `pkg_current` dataframe you created above to do this. You can run the code below to install all of your packages in one step: (copy this and run it in your local RStudio session)


``` r
install.packages(
  pkg_current$Package,
  dependencies = TRUE,
  repos = c(CRAN = "https://cran.rstudio.com/"),
  type = "source"
)
```

One of the benefits of R version 4.5.0 and higher is that it will install packages in parallel, which is **much** faster than the previous parallel approach. From ~ 40 min for 700+ packages to 1 minute.

Scroll through the output and check for any errors, or packages that did not install. Dig into the error messages (if any) one by one. If you have problems addressing the errors, check the troubleshooting guide at Chapter 12.1.2, Problems with Installing Packages.

2. There is a slick package called {updater} which can handle the grunt work for you. It can be found at https://www.danieldsjoberg.com/updater/

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
- Run `updater::install_pkgs(lib.loc = c("<location(s) saved in Step 1>"))` in the Console. Note that this is the point where you copy the saved library path from Step 1 into the parentheses (with quotes) into the Console. Note that you will want to update the version number in the path to your new version. This will end up looking something like
`updater::install_pkgs(lib.loc = c("/Library/Frameworks/R.framework/Versions/4.7/Resources/library"))`.


## Checking the new library path

When all of the installation is complete, you can check your work.

You can check the new library path with `.libPaths()`. This should now point to the new library folder for the new version of R. If you have multiple library paths, the first one is the one that will be used for installing packages.
It should look something like `/Library/Frameworks/R.framework/Versions/5.1-arm64/Resources/library"`

## Now Check your list of Packages

You should also review the Console text for errors or problems. You may find you need software packages external to R, or that you have tried to install some packages that are not on CRAN. Many packages that are not on CRAN are ones that you may have previously installed from Github or BioConductor. 

Note these by making a list of packages left to be installed, and install those from GitHub with `remotes::install_github("username/packagename)`. As one example, you can install the development version of the {medicaldata} package from github with `remotes::install_github("higgi13425/medicaldata")`. Note that the stable version is available on the CRAN repository. 

You may have similar issues with packages installed from BioConductor, which requires you to use `BiocManager::install("packagename")`.

Once you have completely installed your packages, check your work by running `installed.packages()` again. You should see a full list of your packages, and you are updated and ready to go!


## Updating Packages

If all of your current important projects are protected with an {renv} snapshot, this is probably a good time to update your tools (packages). Especially in the first month after a major R update, a lot of R packages are updated to optimize functions in the new version of R.

You can do this easily within RStudio with the menu commands **`Tools/Check for Package Updates`**. Select All, and let the updates begin. You will usually want to compile the newest version from source code, rather than a recent version from binaries. It may take 2-3 weeks after an R update to have all the packages available in binaries, so you may need to compile from source code if you upgrade R right after a new version is released.

If you have problems with updating packages, check the troubleshooting guide at Chapter 12.1.2, Problems with Installing Packages.

