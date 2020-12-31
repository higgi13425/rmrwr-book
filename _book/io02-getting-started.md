---
title: "Getting Started and Installing Your Tools.Rmd"
author: "Peter Higgins"
output: html_document
editor_options: 
  markdown: 
    wrap: 72
---

# Getting Started and Installing Your Tools

One of the most intimidating parts of getting started with something new
is the actual getting started part. Don't worry, I will walk you through
this step-by step.

## Goals for this Chapter

-   Install R on your Computer
-   Install RStudio on your Computer
-   Install Git on your Computer
-   Get Acquainted with the RStudio IDE

## Website links needed for this Chapter

While in many chapters, I will list the R packages you need, in this
chapter, you will be downloading and installing new software, so I will
list the links here for your reference.

-   <https://www.r-project.org>
-   <https://rstudio.com/products/rstudio/download/>
-   <https://git-scm.com/downloads>

## Pathway for this Chapter

This Chapter is part of the **TOOLS** pathway. Chapters in this pathway
include

-   Getting Started and Installing Your Tools
-   Using the RStudio IDE
-   Updating R, RStudio, and Your Packages
-   Advanced Use of the RStudio IDE
-   When You Don't Want to Update Packages (Using *renv*)
-   Major R Updates (Where Are My Packages?)

## Installing R on your Computer

R is a statistical programming language, designed for non-programmers
(statisticians). It is optimized to work with data in rectangular tables
of rows (observations) and columns (variables). It is a very fast and
powerful programming engine, but it is not terribly comfortable or
convenient. R itself is not terribly user-friendly. It is a lot like a
drag racing car, which is basically a person with a steering wheel
strapped to an airplane engine.

![drag racer](images/drag.png)

Very aerodynamic and fast, but not comfortable for the long run (more
than about 8 seconds). You will need something more like a production
car, with a nice interior and a dashboard, and comfy leather seats.

![dashboard](images/dashboard.png){width="600"}

This equivalent of a comfy coding environment is provided by the RStudio
IDE (Integrated Developer Environment). I want you to install both R and
RStudio, in that order.\

Let's start with installing R.\
R is free and available for download on the web. Go to the [r-project
website](https://r-project.org/) to get started.

This screen will look like this ![irproject](images/r-project.png)\

You can see from the blue link (**download R**) that you can use this
link to download R, but you will be downloading it faster if you pick a
local CRAN mirror.\
You might be wondering what CRAN and CRAN Mirrors are. Nothing to do
with cranberries, fortunately. CRAN is the Comprehensive R Archive
Network. Each site (mirror) in the network contains an archive of all R
versions and packages, and the sites are scattered over the globe. A
CRAN Mirror maintains an up to date copy of all of the R versions and
packages on CRAN. If you use the nearest CRAN mirror, you will generally
get faster downloads.

\
At this point, you might be wondering what a package is...\
A package is a set of functions and/or data that you can download to
upgrade and add features to R. It is like a downloadable upgrade to a
Tesla vehicle that lets you play the video game *Witcher 3* on your
console, but more useful.

![](images/dash-tesla.png){width="600"}

Another useful analogy for packages is that they are like apps for a
smartphone. When you buy your first smartphone, it only comes with the
basic apps that allow it to work as a phone, but a notepad and a
calculator.

If you want to do cool things with your smartphone, you download apps
that allow your smartphone to have new capabilities. That is what
packages do for your installation of R.

![tesla](images/smartphone.jpg)\

Now let's get started. Click on the blue link that says "download R".\
This will take you to a page to select your local CRAN Mirror , from
which you will download R.

![cran](images/cran-mirror.png)

Scroll down to your local country (yes, the USA is at the bottom), and a
CRAN mirror near you. This is an example from the state of Michigan, in
the USA.

![usa-mirrors](images/usa-mirrors.png)

Once you click on a CRAN Mirror site to select the location, you will be
taken to the actual Download site.

![install](images/installr.png)

Select the link for the operating system you want to use. We will walk
through this with Windows first, then Mac. If you are using a Mac, skip
forward to the Mac install directions. If you are computer-savvy enough
to be using Linux, you can clearly figure it out on your own (it will
look a lot like these).

## Windows-Specific Steps for Installing R

If you are installing R on a Mac, jump ahead to the Mac-specific version
below.

On windows, once you have clicked through, your next screen will look
like this:\

![install2](images/installr2.png)

You want to download both base and Rtools (you might need Rtools later).
The base link will take you to the latest version, which will look
something like this.

![install3](images/installr3windows.png)

Click on this link, and you will be able to save a file named
R-N.N.N-win.exe (Ns depending on version number) to your Downloads
folder. Click on the Save button

to save it.

![install4](images/installrsave.png){width="281"}

Now, go to your Downloads folder in Windows, and double click on the R
installation file (R-N.N.N-win.exe). Click Yes to allow this to install.

![install5exe](images/installrexe.png)

Now select your language option.

![install_language](images/installrEnglish.png)

You will be asked to accept the GNU license - do so. Click Yes to allow
this to install. Then select where to install - generally use the
default- a local (often C) drive - do not install on a shared network
drive or in the cloud.

![install_drive](images/installrdrive.png)

Then select the Components - generally use the defaults, but newer
computers can skip the 32 bit version.

![install_comp](images/installrComponents.png)

In the next dialog box, accept the default startup options.

![install_defaults](images/installrdefaults.png)

You can choose the start menu folder. The default R folder is fine.

![install_start](images/installrstartmenu.png)

If you want a shortcut icon for R on your desktop, you can leave this
checked. But most people start RStudio, with R running within RStudio,
rather than directly starting R. You probably won't need an R shortcut,
so leave these unchecked in the next dialog box.

![install_addltasks](images/installraddltasks.png)

Then the Setup Wizard will appear - click Finish, and the rest of the
installation will occur.

![install_wizard](images/installrwizard.png)

### Testing R on Windows

Now you want to test whether your Windows installation was successful.
Can you find R and make it work? Hunt for your C folder, then for
OS-APPS within that folder. Keep drilling down to the Program Files
folder. Then the R folder, and the current version folder within that
one (R-N.N.N). Within that folder will be the bin folder, and within
that will be your R-N.N.N.exe file. Double click on this to run it. The
example paths below can help guide you.

![install_path2](images/installwin-path2.png)

![install_path](images/installrpath.png)

Opening the exe file will produce a classic 2000-era terminal window,
called Rterm, with 64 bit if that is what your computer uses. The
version number should match what you downloaded. The messaging should
end with a "\>" prompt.

![install_term](images/windowsrterm.png)

At this prompt, type in:\

paste('Two to the seventh power is', 2\^7)

(don't leave out the comma or the quotes) - then press the Enter key.

This should produce the following:

Two to the seventh power is 128

![install_test](images/windowstest.png)

Note that you have explained what is being done in the text, and
computed the result and displayed it.

## Mac-specific Installation of R

The installation for Mac is very similar, but the windows look a bit
different. If you are working with Windows, jump ahead at this point to
Installing RStudio. At the Download Version page, you click on the Mac
Download. You will then click on the link for R-N.N.N.pkg, and allow
downloads from CRAN.

![install_path](images/installrpkgmac.png)

Then go to Finder, and navigate to the Downloads folder. Click on
R-N.N.N.pkg You will then click on the link for R-N.N.N.pkg, and allow
downloads from CRAN.

![install_downloadmac](images/installrdownloadsmac.png)

Click on Continue on 2 consecutive screens to download

![cont1_mac](images/installrCont1mac.png)

![cont2_mac](images/installrCont2mac.png)

Then you need to agree with the License Agreement,

![mac_license](images/installrmacLicense.png)

then Click on Install, and provide your Mac password for permission to
install.

![cont1_mac](images/installrmac-install.png)

When the installation is complete, click on the Close button. Accept the
prompt to move the installer file to the trash.

### Testing R on the Mac

Go to Finder, and then your Applications folder. Scroll down to the R
file. Double click on this to run it.

![findrmac](images/findrmac.png)

You should get this 2000-era terminal window named R Console. The
version number should match what you downloaded, and the messaging
should end with a "\>" prompt. At this prompt, type in

paste("Two to the seventh power is", 2\^7)

(DON'T leave out the comma or the quotes)

![rconsolemac](images/rconsolemac.png)

This should result in

![mactestR](images/mactestR.png)

### Successful testing!

Awesome. You are now Ready to R!

![ready2R](images/ready2R.png)

## Installing RStudio on your Computer

Now that R is working, we will install RStudio. This is an IDE
(Integrated Development Environment), with lots of bells and whistles to
help you do reproducible medical research.

![teslax_dash](images/teslax_dash.png)

This is a lot like adding a dashboard with polished walnut panels, a
large video screen map, and heated car seats with Corinthian Leather.
Not absolutely necessary, but nice to have.

The RStudio IDE wraps around the R engine to make your experience more
comfortable and efficient.

![camry_dash](images/camry_dash.png)

Fortunately, RStudio is a lot cheaper than any of these cars. In fact,
it is free and open source. You can download it from the web at:

[rstudio](https://rstudio.com/products/rstudio/)

Click on the RStudio Desktop icon to begin.

![download](images/rstudio_download.png)

This will take you to a new site, where you will select the Open Source
Edition of RStudio Desktop

![open_source](images/rstudio_opensource.png)

This will take you to a new site, where you will select the Free Version
of RStudio Desktop

![free](images/rstudio_free.png)

Now select the right version for your Operating syxtem - Windows or Mac.

<br> ![mac_win](images/rstudio_mac_win.png)

### Windows Install of RStudio

If you are installing on a Mac, jump ahead now to the Mac-specfic
installation instructions.

Now save the RStudio.N.N.N.exe file (Ns will be digits representing the
version number) to your downloads folder.

![winsave](images/rstudio_winsave.png)

Now go to your downloads folder, and double click on the
RStudio.N.N.N.exe file.

![winlaunch](images/rstudio_winlaunch.png)

Allow this app to make changes. Click Next to Continue, and Agree to the
Install Location.

![wininstall](images/rstudio_wininstall.png)

Click Install to put RStudio in the default Start Menu Folder, and when
done, click the Finish button.

![winsave](images/rstudio_winstall_start.png)

![winfinish](images/winstall_finish.png)

Now select your preferred language option, accept the GNU license, Click
Yes to allow this to install. Select where to install. This is generally
on a local (often C:) drive, and usually **not** a shared network drive
or in the cloud.

### Testing Windows RStudio

Now you should be ready to test your Windows installation of RStudio.

Open your Start menu Program list, and find RStudio.

Pin it as a favorite now.

Click to Open RStudio.

Within the Console window of RStudio, an instance of R is started up.
Check that the version number matches the version of R that you
downloaded.

Now run a test at the prompt ("\>") in the Console window. Type in

`paste("Three to the 5th power is", 3^5)`

**do not leave out the quotes or the comma**

Then press the enter key

and this should be your result:

![test_result35](images/test_result35.png)

A successful result means that you are ready to roll in RStudio and R!

![ready](images/ready_to_R.png) <br>

### Installing RStudio on the Mac

Start at this link: [RStudio
Download](https://rstudio.com/products/rstudio/download/)

Select the Free RStudio Desktop Version

![mac_download](images/rstudio_mac_download.png)

Then click on the big button to Download RStudio for Mac.

![mac_download2](images/rstudio_mac_download2.png)

After the Download is complete, go to Finder and the Downloads Folder.
Double click on the RStudio.N.N.N.dmg file in your Downloads folder.

![mac_dmg](images/rstudio_mac_dmg.png)

This will open a window that looks like this

![mac_apps](images/rstudio_mac_apps.png)

Use your mouse to drag the RStudio icon into the Applications folder.

Now go back to Finder, then into the Applications folder. Double click
on the RStudio icon, and click OK to Open.

Pin your RStudio to the Dock.

Double Click to run RStudio.

RStudio will open an instance of R inside the Console pane of RStudio
with the version number of R that you installed, and a "\>" prompt.

### Testing the Mac Installation of RStudio

Type in

`paste("Three to the 5th power is", 3^5)`

**do not leave out the quotes or the comma**

Then press the enter key

and this should be your result.

![test_result35](images/test_result35.png)

A successful result means that you are ready to roll in RStudio and R!

![ready](images/ready_to_R.png)

## Critical Setup - Tuning Your RStudio Installation

You now have 6+ adjustments that you need to make in your RStudio Global
Settings for optimal R and RStudio use.

1.  At this point, it is a good idea to jump out of RStudio and create
    an "Rcode" folder on your computer, in a place that is easy to find,
    often at the top level in your Documents folder, to make all of your
    future projects easy to find.

Once this **Rcode folder** is in place, switch back to RStudio. In the
RStudio Menus, go to Tools/Global Options. A new Global Options window
will open up. Click on the General tab on the left. At the top, there is
a small window for identifying your Default working directory. Click on
the Browse button, and browse to your new "Rcode" folder and select it.
From now on, your R files and Projects will all be in one place and easy
to find.

2.  In the same General tab, de-select the first 3 options

-   turn off Restore most recently opened project at startup
-   turn off Restore previously open source documents at startup
-   turn off Restore .RData into workspace

3.  In the same General tab, find Save workspace to .RData on exit.
    Click on the dropdown menu to select "Never"

These tune-ups (\#2 and \#3) to your RStudio will mean you will always
start with a clean workspace in a new RStudio session, which will avoid
a lot of potential problems later.

4.  In the same General tab, at the top, click on the Advanced tab. Then
    select the box for

-   Show full path to project in window title This will show your
    working directory at the top of your Console Pane. This can prevent
    confusion and problems later.

5.  On the left, click on the Rmarkdown tab. Then de-select the option
    for

-   Show output inline for all Rmarkdown documents.

This will put your temporary output from Code Chunks into the larger and
nicer Viewer tab.

6.  Take a look at the Appearance tab. You can change your code font,
    the font size, and the theme. I wouldn't make any drastic changes at
    this point, but it is good to know that these options are available.
    Any changes here are entirely optional (and cosmetic) at this point.

7.  in the RStudio menus, select Code, then check/select two options to
    turn these on:

-   Soft Wrap Long Lines - so that your code does not get too wide
-   Rainbow Parentheses - color-codes parentheses so that you can keep
    track of whether you have closed all of your open parentheses (a
    common source of errors)

Now your RStudio installation is tuned and ready to go!

## Installing Git on your Computer

The software program, **git**, is a version control system. It is the
most common version control system in the world. It is free and open
source, and is the foundation of reproducible computing.

We won't be doing a lot with **git** just yet, but it is helpful to get
this installation done and out of the way. It will come up a lot when we
start to discuss reproducible research and collaboration.

### Installing Git on macOS

If you are using Windows, jump ahead to Installing Git on Windows.

1.  The easiest approach on the macOS is to go to the Terminal tab in
    the Console pane (lower left) in RStudio. A prompt will appear that
    ends in a \$.

At that prompt, type `git --version`

note that there are **2 dashes** before version.

This will tell you the current version of **git** (2.29.2 as of January
1, 2021), or prompt you to install **git**.

2.  If you want the current version of **git**, you can install this
    yourself.

a\. First, let's check if you have **homebrew** installed.\
Go to the Terminal tab in the Console pane (lower left) in RStudio. A
prompt will appear that ends in a \$.

at the prompt, type `command -v brew`

This should return "/usr/local/bin/brew" if homebrew is installed, or
will tell you "brew not found" or something similar.

b\. Installing homebrew

At the terminal prompt(\$), paste in the following:

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

Then press Enter to run it. This installs the **homebrew** program,
which allows you to install software on macOS that does *not* come from
the Apple App Store

This will take a couple of minutes.

c\. Installing **git**

Once you have **homebrew** installed, installing **git** is
straightforward.

At the Terminal prompt (\$), type

`brew install git`

and this will quickly install. You will be prompted to click
**Continue** buttons to complete the installation.

3.  Check your installation.

    At the Terminal prompt (\$), type

    `git --version`

    and this should return a result like "git version 2.29.2", depending
    on the version number.

### Installing Git on Windows

If you are using Windows, go to the website,
<https://git-scm.com/download/win>.

1.  This will start the download automatically

2.  Go to your downloads folder and install the downloaded .exe file by
    clicking on it

3.  Check your installation.

    At the Terminal prompt (\$), type

    `git --version`

    and this should return a result like "git version 2.29.2", depending
    on the version number.

### Installing Git on Linux

If you are using Fedora, or a related version of Linux like RHEL or
CentOS, use **dnf**

At the \$ prompt, type `sudo dnf install git-all`

If you are using a Debian-based version of Linux like Ubuntu, use
**apt**

At the \$ prompt, type `sudo apt install git-all`

For other distributions of Linux, follow the instructions at
<https://git-scm.com/download/linux>.

1.  Check your installation.

    At the Terminal prompt (\$), type

    `git --version`

    and this should return a result like "git version 2.29.2", depending
    on the version number.

## Getting Acquainted with the RStudio IDE

When you first open the RStudio IDE (Integrated Development
Environment), there will be a left side pane, with tabs for Console,
Terminal, Rmarkdown, and Jobs.

Just for fun, go to the RStudio menus, and choose File/New File/RScript.
This will open a new pane at the top left, which we will call Q1
(quadrant 1), or the top left pane, or the Source pane. This pane will
contain tabs for each active script or document, along with tabs for any
datasets you have opened up to have a look at.

The Quadrant 2 pane, with tabs for Console, Terminal, Rmarkdown, and
Jobs, has now been pushed to the lower left pane. You will use the
Console for interactive programming, and as a "sandbox" to test out new
code. When your code works and is good enough to save, you will move it
to the Source pane and save it to a Script or an Rmarkdown document. Any
code that is not saved to Source will be lost (actually it will be
somewhere in the History, but it can be a pain to find the version that
works later - it is best to save the good stuff to a Script or .Rmd).

The Quadrant 3, or top right pane, includes tabs for your Environment
(objects, like datasets, functions, and variables you have defined),
History (saving the past in case you forget to, but messy), and
Connections tabs for connections to databases. Later a Git tab will be
added for version control (backup) of your Source documents.

In Quadrant 4, or the bottom right pane, you will find tabs for your
Files, Plots, Packages, Help, and a Viewer for HTML output.

This is material that is also well described in the "Basic Basics 1"
section of RLadiesSydney. Check it out at
[BasicBasics1](https://rladiessydney.org/courses/ryouwithme/01-basicbasics-1/).
There is a nice \~ 15 minute video by Jen Richmond worth watching if you
are just getting started. Note that a lot of the other material on this
website ([RYouWithMe](https://bookdown.org/connect/#/apps/5384/access))
is very helpful for people new to R.
