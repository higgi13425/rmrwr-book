---
title: "Getting Started and Installing Your Tools.Rmd"
author: "Peter Higgins"
output: html_document
---



# Getting Started and Installing Your Tools

One of the most intimidating parts of getting started with something new is the actual getting started part. Don't worry, we will walk you through this step-by step. 

## Goals for this Chapter
- Install R on your Computer
- Install RStudio on your Computer
- Install Git on your Computer
- Get Acquainted with the RStudio IDE

## Website links needed for this Chapter
While in many chapters, we will list the R packages you need, in this chapter, you will be downloading and installing new software, so we will list the links here for your reference    

- https://www.r-project.org
- https://rstudio.com/products/rstudio/download/
- https://git-scm.com/downloads 

## Pathway for this Chapter
This Chapter is part of the **TOOLS** pathway.
Chapters in this pathway include

- Getting Started and Installing Your Tools
- Updating R, RStudio, and Your Packages
- Advanced Use of the RStudio IDE
- When You Don't Want to Update Packages (Using _renv_)
- Major R Updates (Where Are My Packages?)

## Installing R on your Computer
R is a statistical programming language, designed for non-programmers (statisticians). It is optimized to work with data in tables. It is a very fast and powerful programming engine, but it is not terribly comfortable or convenient. R itself is not terribly user-friendly. It is a lot like a drag racing car, which is basically a person with a steering wheel strapped to an airplane engine.
<br>
<br>
![drag racer](images/drag.png)
<br>
<br>
<br>
Very aerodynamic and fast, but not comfortable for the long run (more than about 8 seconds).
You will need something more like a production car, with a nice interior and a dashboard, and comfy leather seats. 
<br>
<br>
![dashboard](images/dashboard.png)
<br>
<br>
<br>
This equivalent of a comfy coding environment is provided by the RStudio IDE (Integrated Developer Environment). We want you to install both R and RStudio, in that order.    
<br>
Let's start with installing R.    
R is free and available for download on the web. Go to the [r-project website](https://r-project.org/) to get started. 

This screen will look like this
![irproject](images/r-project.png)    
<br>
<br>
You can see from the blue link (download R) that you can download R, but you will be downloading it faster if you pick a local CRAN mirror.   
You might be wondering what CRAN and CRAN Mirrors are. Nothing to do with cranberries, fortunately. CRAN is the Comprehensive R Archive Network. Each site (mirror) in the network contains an archive of all R versions and packages, and the sites are scattered over the globe. A CRAN Mirror maintains an up to date copy of all of the R versions and packages on CRAN. If you use the nearest CRAN mirror, you will generally get faster downloads.   
At this point, you might be wondering what a package is...   
A package is a set of functions and/or data that you can download to upgrade and add features to R. It is a lot like a downloadable upgrade to a Tesla that lets you play the video game _Witcher 3_ on your console, but more useful.
<br>
<br>
![tesla](images/dash-tesla.png)   

<br>
<br>
Another useful analogy for packages is that they are like apps for a smartphone. When you buy your first smartphone, it only comes with the basic apps that allow it to work as a phone, but a notepad and a calculator. <br>
If you want to do cool things with your smartphone, you download apps that allow your smartphone to have new capabilities. That is what packages do for your installation of R. 
<br>
<br>
<br>
![tesla](images/smartphone.jpg)   
<br>
<br>
Now let's get started. Click on the blue link that says "download R".    
This will take you to a page to select your local CRAN Mirror , from which you will download R.
<br>
<br>
![cran](images/cran-mirror.png)
<br>
<br>
Scroll down to your local country (yes, the USA is at the bottom), and a CRAN mirror near you.
This is an example from the state of Michigan, in the USA.
<br>
<br>
![usa-mirrors](images/usa-mirrors.png)
<br>
<br>
<br>
Once you click on a CRAN Mirror site to select the location, you will be taken to the actual Download site.
<br>
<br>
![install](images/installr.png)
<br>
<br>
<br>
Select the link for the operating system you want to use. We will walk through this with Windows first, then Mac. If you are using a Mac, skip forward to the Mac install directions. If you are computer-savvy enough to be using Linux, you can clearly figure it out on your own (it will look a lot like these).  
Once you have clicked through, your next screen will look like this:    
<br>
<br>
![install2](images/installr2.png)
<br>
<br>
<br>
You want to download both base and Rtools (you might need Rtools later). The base link will take you to the latest version, which will look something like this.
<br>
<br>
![install3](images/installr3windows.png)
<br>
<br>
<br>
Click on this link, and you will be able to save a file named R-N.N.N-win.exe (Ns depending on version number) to your Downloads folder. Click on the Save button to save it.
<br>
<br>
![install4](images/installrsave.png)
<br>
<br>
<br>
Now, go to your Downloads folder in Windows, and double click on the R installation file (R-N.N.N-win.exe). Click Yes to allow this to install.
<br>
<br>
![install5exe](images/installrexe.png)
<br>
<br>
<br>
Now select your language option.
<br>
<br>
![install_language](images/installrEnglish.png)
<br>
<br>
<br>
You will be asked to accept the GNU license - do so. Click Yes to allow this to install. Then select where to install - generally use the default- a local (often C) drive - do not install on a shared network drive or in the cloud.
<br>
<br>
![install_drive](images/installrdrive.png)
<br>
<br>
<br>
Then select the Components - generally use the defaults, but newer computers can skip the 32 bit version.
<br>
<br>
![install_comp](images/installrComponents.png)
<br>
<br>
<br>
In the next dialog box, accept the default startup options.
<br>
<br>
![install_defaults](images/installrdefaults.png)
<br>
<br>
<br>
You can choose the start menu folder. The default R folder is fine.
<br>
<br>
![install_start](images/installrstartmenu.png)
<br>
<br>
<br>
You probably won't need shortcuts, so leave these unchecked in the next dialog box.
<br>
<br>
![install_addltasks](images/installraddltasks.png)
<br>
<br>
<br>
Then the Setup Wizard will appear - click Finish, and the rest of the installation will occur.
<br>
<br>

![install_wizard](images/installrwizard.png)

### Testing

Now you want to test whether your Windows installation was successful. Can you find R and make it work?
Hunt for your C folder, then for OS-APPS within that folder. Keep drilling down to the Program Files folder. Then the R folder, and the current version folder within that one (R-N.N.N). Within that folder will be the bin folder, and within that will be your R-N.N.N.exe file. Double click on this to run it. The example paths below can help guide you.
<br>
<br>
![install_path2](images/installwin-path2.png)
<br>
<br>
![install_path](images/installrpath.png)
<br>
<br>
<br>
Opening the exe file will produce a classic 2000-era terminal window, called Rterm, with 64 bit if that is what your computer uses. The version number should match what you downloaded. The messaging should end with a ">" prompt.
<br>
<br>
![install_term](images/windowsrterm.png)
<br>
<br>
At this prompt, type in:     
<br>
paste(‘Two to the seventh power is’, 2^7)
<br>
(don't leave out the comma) - then press the Enter key.

This should produce the following:    

![install_test](images/windowstest.png)
<br>
<br>
<br>
Note that you have explained what is being done and computed the result. 
<br>

### Mac Install of R
The installation for Mac is very similar, but the windows look a bit different. At the Download Version page, you click on the Mac Download.
You will then click on the link for R-N.N.N.pkg, and allow downloads from CRAN.

![install_path](images/installrpkgmac.png) 
<br>
<br>
<br>
Then go to Finder, and navigate to the Downloads folder. Click on R-N.N.N.pkg
You will then click on the link for R-N.N.N.pkg, and allow downloads from CRAN.
<br>
<br>
![install_downloadmac](images/installrdownloadsmac.png)

<br>
<br>
<br>
Click on Continue on 2 consecutive screens to download
<br>
<br>

![cont1_mac](images/installrCont1mac.png)
<br>

![cont2_mac](images/installrCont2mac.png)

<br>
<br>
<br>
Then you need to agree with the License Agreement, 
<br>
<br>
![mac_license](images/installrmacLicense.png)
<br>
<br>
<br>
then Click on Install, and provide your Mac password for permission to install.
<br>
<br>
![cont1_mac](images/installrmac-install.png)
<br>
<br>
<br>
When the installation is complete, click on the Close button. Accept the prompt to move the installer file to the trash.

### Testing R on the Mac
Go to Finder, and then your Applications folder. Scroll down to the R file. Double click on this to run it. 
<br>
<br>
![findrmac](images/findrmac.png)
<br>
<br>
<br>
You should get this 2000-era terminal window named R Console. The version number should match what you downloaded, and the messaging should end with a ">" prompt.
At this prompt, type in 
<br>
paste("Two to the seventh power is", 2^7)
<br>
(DON’T leave out the comma or the quotes)
<br>
<br>
![rconsolemac](images/rconsolemac.png)
<br>
<br>
<br>
This should result in
<br>
<br>
![mactestR](images/mactestR.png)

### Successful testing!

Awesome. You are now Ready to R!<br>
<br>
![ready2R](images/ready2R.png)



## Installing RStudio on your Computer

Now that R is working, we will install RStudio. This is an IDE (Integrated Development Environment), with lots of bells and whistles to help you do reproducible medical research.
<br>
<br>
![teslax_dash](images/teslax_dash.png)
<br>
<br>
<br>
This is a lot like adding a dashboard with polished walnut panels, a large video screen map, and heated car seats with Corinthian Leather. Not absolutely necessary, but nice to have.<br>
The RStudio IDE wraps around the R engine to make your experience more comfortable and efficient.
<br>
<br>
![camry_dash](images/camry_dash.png)
<br>
<br>
<br>
Fortunately, RStudio is a lot cheaper than any of these cars. In fact, it is free and open source. You can download it from the web at: <br>
[rstudio](https://rstudio.com/products/rstudio/) <br>
Click on the RStudio Desktop icon to begin. 
<br>
<br>

![download](images/rstudio_download.png)
<br>
<br>
<br>
This will take you to a new site, where you will select the Open Source Edition of RStudio Desktop 
<br>
<br>

![open_source](images/rstudio_opensource.png)
<br>
<br>
<br>
This will take you to a new site, where you will select the Free Version of RStudio Desktop 
<br>
<br>
![free](images/rstudio_free.png)
<br>
<br>
<br>
Now select the right version for your Operating syxtem - Windows or Mac.
<br>
<br>
![mac_win](images/rstudio_mac_win.png)

### Windows Install
Now save the Rstudio.N.N.N.exe file (Ns will be digits representing the version number) to your downloads folder.
<br>
<br>
![winsave](images/rstudio_winsave.png)
<br>
<br>
<br>
Now go to your downloads folder, and double click on the Rstudio.N.N.N.exe file.
<br>
<br>
![winlaunch](images/rstudio_winlaunch.png)
<br>
<br>
<br>
Allow this app to make changes. Click Next to Continue, and Agree to the Install Location.
<br>
<br>
![wininstall](images/rstudio_wininstall.png)
<br>
<br>
<br>
Click Install to put Rstudio in the default Start Menu Folder, and when done, click the Finish button.
<br>
<br>
![winsave](images/rstudio_winstall_start.png)
<br>
<br>
<br>
![winfinish](images/winstall_finish.png)
<br>
<br>
Now select your preferred language option, accept the GNU license, Click Yes to allow this to install. Select where to install. This is generally on a local (often C:) drive, and usually **not** a shared network drive or in the cloud.
<br>
<br>

### Testing Windows RStudio
Now you should be ready to test your Windows installation of Rstudio.<br>
Open your Start menu Program list, and find Rstudio.<br>
Pin it as a favorite now. <br>
Click to Open Rstudio. <br>
Within the Console window of Rstudio, an instance of R is started up. Check that the version number matches the version of R that you downloaded.<br>
<br>
Now run a test at the prompt (">") in the Console window. Type in 
<br>
`paste("Three to the 5th power is", 3^5)`<br>

**do not leave out the quotes or the comma** <br>

Then press the enter key<br>
and this should be your result:<br>
<br>
![test_result35](images/test_result35.png)
<br>
A successful result means that you are ready to roll in Rstudio and R!
<br>
<br>
![ready](images/ready_to_R.png)
<br>

### Installing RStudio on the Mac
Start at this link: [Rstudio Download](https://rstudio.com/products/rstudio/download/
)<br>
<br>
Select the Free RStudio Desktop Version
<br>
<br>
![mac_download](images/rstudio_mac_download.png)
<br>
<br>
<br>
Then click on the big button to Download RStudio for Mac.
<br>
<br>
![mac_download2](images/rstudio_mac_download2.png)
<br>
<br>
<br>
After the Download is complete, go to Finder and the Downloads Folder. Double click on the Rstudio.N.N.N.dmg file in your Downloads folder. <br>
<br>
<br>
![mac_dmg](images/rstudio_mac_dmg.png)
<br>
<br>
<br>
This will open a window that looks like this
<br>
<br>
![mac_apps](images/rstudio_mac_apps.png)
<br>
<br>
<br>
Use your mouse to drag the RStudio icon into the Applications folder.
<br>
Now go back to Finder, then into the Applications folder.
Double click on the RStudio icon, and click OK to Open. <br>
Pin your RStudio to the Dock. <br>
Double Click to run RStudio.<br>
RStudio will open an instance of R inside the Console pane of RStudio with the version number of R that you installed, and a ">" prompt. 
<br>
<br>

### Testing the Mac Installation of RStudio
Type in <br>
`paste("Three to the 5th power is", 3^5)`<br>
**do not leave out the quotes or the comma** <br>
Then press the enter key<br>
and this should be your result.<br>
<br>
![test_result35](images/test_result35.png)
<br>
A successful result means that you are ready to roll in Rstudio and R!
<br>
<br>
![ready](images/ready_to_R.png)

## Installing Git on your Computer


## Getting Acquainted with the RStudio IDE

