---
title: "Running R from the UNIX Command Line"
author: "Peter Higgins"
date: "9/6/2020"
output: html_document
---



# Running R from the UNIX Command Line

## What is the UNIX Command line?
The command line is a simple Terminal window with a prompt at which you can type commands, And do primitive but powerful things to your files. The UNIX computing environment was developed in the 1960s, and is still beloved and fetishized by brogrammers, who believe you are not truly a programmmer if you can't code from the command line. This is silly.
<br><br>
The major attraction to UNIX in the 1960s is that it was much better than punch cards.  Which isn't saying much. We have had 60 years of software advancement and user interface improvements, so we really should not have to put up with the inherent user hostility of UNIX environment.
<br><br>
UNIX is an early operating system, which is built around a 'kernel' which executes operating system commands, and a 'shell' which interprets your commands and sends them to the kernel for execution. The most common shell these days is named 'bash', which is a silly recursive brogrammer joke. You will sometimes see references to shell scripts or shell programming. These are the same thing as command line programming.
<br><br>
UNIX is a common under-the-hood language across many computers today, as the Apple iOS is built on top of UNIX, and the various versions of the LinuxOS are built on a UNIX-like kernel, with a similar command shell. 
<br><br>
Running R from the command line is a bit like spending a day tuning your car's engine by yourself. There is a case to be made that this will improve the efficiency and performance of your car, but it is also usually more efficient to pay someone else to do it, unless you are a car expert with a lot of free time.

## Why run R from the command line?

You can run R from the command line. It has none of the bells and whistles, nor any of the user conveniences of the RStudio Interactive Developer Environment (IDE). But it is how R was originally expected to be used when it was developed back in 2000 in New Zealand.
<br><br>
Running R from the command line allows you to do powerful things, like process multiple files at once, which can be handy when you have multiple files of sequencing data from distinct observations, or you have a multistep data wrangling pipeline with several slow steps. For many years, this was the only way to easily apply code across multiple files.
<br><br>
This is much less true today, with tools to handle file paths like the {here} and {fs} packages, and the {drake} package to manage multistep data pipelines (similar to _make_). But some labs have been doing things at the command line for years, and find it hard to change.

## How do you get started?
First, you need to open a terminal window.
And to do that, you need to find it. This is akin to getting under the hood of a car, and computer makers don't exactly encourage it.

### On a Mac

- Go to Finder/Applications/Utilities/Terminal

### On a Windows PC

- Go to Applications/Terminal


## The Yawning Blackness of the Terminal Window
So, you have managed to open a terminal window, which has a standard UNIX prompt, ending in `%`. Not terribly helpful, is it? The bash shell is waiting for you to enter a command. No user interface for you!
<br><br>
Let's start with a simple one, which can't do any harm. Run the command below:<br>
`whoami`


```bash
whoami
```

Remember that UNIX started out as an operating system for terminals, and knowing who was logged in was a helpful thing.
<br><br>
You can string together two commands with a semicolon between them. <br>
Try the following:

```bash
whoami;date
```
OK, fine. This is sort of helpful. It was really important when you were on a terminal and paying by the minute for time on a mainframe back in 1969. And, on occasion, if you will need to use a cluster to run a script on a lot of data, you will likely have to use some of this command line knowledge. 
<br><br>
At this point, it would be helpful to open a window with your Documents folder, and keep it side by side with the window in which you are reading this e-book. We will start working with files and directories, and it is helpful to see changes in your file/folder structure in real time. As we run commands in the bash shell, check them against what you see in the folder window. You may find that some files (dotfiles, starting with a period) are hidden from the user to prevent problems that occur when these are deleted. 
<br><br>

## Where Are We?

OK, let's start looking at files and directories. Start with the `pwd` command, which does **not** stand for password, but for `print working directory`.<br>
Run the code below in your Terminal window.


```bash
pwd
```
You can see the full path to your current directory. This can be a bit obscure if you are just looking at your folder structure, particularly at the beginning of the path. Fortunately, the {here} package handles a lot of this for you when you are working in Rstudio projects. <br>
We think of the directory as a tree, with a root - in this case, `Users`, and various branches as you build out folders and subfolders.<br>
We can move up and down the folders of the directory paths with the `cd` command, for `change directory`.
<br><br>
Try this command in your Terminal Window, and see if you can figure out what it does.


```bash
cd ..
```
It changes the directory `up` one level closer to the root directory. It is straightforward to go up the directory tree, as each folder only has one `parent`. But it is tricky to go down the directory tree, as there are many possible branches, and you do not inherently know the names of these branches. We need to list the contents of your current directory with `ls` to know what is there. Try the `ls` command in your Terminal window


```bash
cd /Users/peterhiggins/Documents/;
ls
```

You will see a listing of all files and folders in the current directory. You can get more details by adding the option (sometimes called a `flag`) `-l`


```bash
cd /Users/peterhiggins/Documents/;
ls -l
```

The full listing will give you more details, including read & write permissions, file size, date last saved, etc. <br>
Many commands have options, or flags, that modify what they do.
<br><br>
Find a folder inside of your Documents folder. We will now go `down` a level in the directory tree. In my case, I will use the `Powerpoint` folder. <br>
In your Terminal window:

- change the directory to the Powerpoint directory
- list the contents of this folder

```bash
cd /Users/peterhiggins/Documents/Powerpoint;
ls
```
Great!<br>
You moved to a new directory and listed it.<br>
Now we will get fancy, and make a new directory within this directory with the `mkdir` command.<br>
Try this in your Terminal window:


```bash
pwd;
mkdir new_files;
ls
```
You have now made a new directory (folder) within the previous directory, named `new_files`. Verify this in your Documents folder.<br> 
You can now change to this directory <br>
and list the contents (it should be empty).<br>
Try this out in your Terminal Window (**note** edit the `cd` command to your own directory path).


```bash
cd /Users/peterhiggins/Documents/Powerpoint/new_files;
ls
```
Note that you can abbreviate the current directory with `.`, so that you could have also used `cd ./new_files`
<br><br>
You can create a new (empty) file in this directory with the `touch` command.
Sometimes you need to create a new file, then write data to it.


```bash
touch file_name;
ls
```

You can also create a file with data inside it with the `cat >` command.
Type in the following lines into your Terminal window. When complete, type control-D to be done.
`cat` stands for concatenate.


```bash
cat > file2.txt
cat1
cat2
cat3
```

Now you can list the contents of this file with the `cat` command below.
I have to change the directory to get to the right place first. Check your directory with `pwd` - you may not need to do `cd`.

```bash
cd /Users/peterhiggins/Documents/Powerpoint/new_files;
cat file2.txt
```
You can also list the directory of your `new_files` folder with ls to see the new folder contents.


```bash
cd /Users/peterhiggins/Documents/Powerpoint/new_files;
ls
```


OK, now we are done with the file `file2.txt` and the directory `new_files`.
Let's get rid of them with `rm` (for removing files) and `rmdir` for removing directories. <br>
In order, we will 
- Make sure we are in the right directory
- remove the file with `rm file2.txt`
- go up one level of the directory with `cd ..`
- remove the directory with `rmdir new_files`

```bash
cd /Users/peterhiggins/Documents/Powerpoint/new_files;
rm file2.txt;
cd ..;
rmdir new_files
```
Verify all of this in your Documents window.<br>
This is great. But you can imagine a situation in which you mistakenly `rm` a file that you actually needed. Unlike your usual user interface, when a file is removed at the command line, it is gone. It is not in the trash folder. It is gone. There is something to be said for modern user interfaces, which are built for humans, who occasionally make mistakes. Sometimes we do want files or folders back.

## Other helpful file commands
Here are some file commands worth knowing

- `cat filename` - to print out whole file to your monitor
- `less filename` - to print out the first page, and you can tab through each page one at a time
- `head filename` - print first 10 lines of a file
- `tail filename` - print last 10 lines of a file
- `cp file1 file2` - copy file1 to file2
- `mv file1.txt file.2.txt file3.txt folder` - move files to a new folder

## What about R?
So now you can get around directories, and find your files in the Terminal window, but you really want to run R.<br>
You can launch an R session from the Terminal Window (if you have R installed on your computer) by typing the letter `R` at the Terminal prompt

```bash
R
```
You get the usual R intro, including version number, and the `R>` prompt.<br>
Now you can run R in interactive mode with available datasets, or your own datasets.<br>
Try a few simple commands with the mtcars dataset.<br>

You can use `q()` to quit back to the terminal (and reply "n" to **not** save the workplace image).

```r
head(mtcars)
```

```
##                    mpg cyl disp  hp drat    wt  qsec vs am
## Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1
## Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1
## Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1
## Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0
## Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0
## Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0
##                   gear carb
## Mazda RX4            4    4
## Mazda RX4 Wag        4    4
## Datsun 710           4    1
## Hornet 4 Drive       3    1
## Hornet Sportabout    3    2
## Valiant              3    1
```

```r
mtcars %>% 
  filter(mpg > 25) %>% 
  select(starts_with('m')|starts_with('c'))
```

```
##                 mpg cyl carb
## Fiat 128       32.4   4    1
## Honda Civic    30.4   4    2
## Toyota Corolla 33.9   4    1
## Fiat X1-9      27.3   4    1
## Porsche 914-2  26.0   4    2
## Lotus Europa   30.4   4    2
```

## What about just a few lines of R?
Sometimes you will want to call R, run some code, and be done with R.<br>
You can call R, run a few lines, and quit in one go.<br>
Just add the flag `-e` (for _evaluate_) to the call to R,<br>
and put the R commands in quotes.<br>
Try the example below
(**note** that this will not work if you are still in R - be sure you are back in the terminal with the `%` or `$` prompt)

```bash
R -e "head(mtcars)"
```
or this example - note that single or double quotes does not matter - as long as they match.


```bash
R -e 'install(palmerpenguins)'
```
You can also string together several commands with the semicolon between them. Try the example below.


```bash
R -e 'library(palmerpenguins);data(penguins);tail(penguins)'
```

## Running an R Script from the Terminal
Now we are stepping up a level - you have an R script that you have carefully created and save as the `myscript.R` file. How do you run this from the Terminal?<br>
This is easy - just call the `Rscript` command with your file name. Pick out a short R file you have written, and use it as in the example below.


```bash
Rscript myscript.R
```

This launches R, runs your script, saves resulting output (if your script includes save or ggsave commands), closes R, and sends you back to the Terminal. Very simple.

## Rendering an Rmarkdown file from the Terminal
This is a little different, as you can just run an Rmarkdown file. Normally you would use the dropdown button to knit your file from Rstudio. But you can use the `rmarkdown::render` command to render your files to HTML, PDF, Word, powerpoint, etc. Pick out a simple Rmd file, and try something like the example below. <br>
Note that this is one case where nesting different types of quotes (single vs. double) can come in handy.<br>
It helps to use single quotes around your filename and double quotes around the `rmarkown::render` command.


```bash
Rscript -e "rmarkdown::render('output_file.Rmd')"
```

So there you have it! <br>
Just enough to get you started with R from the command line.
<br>
<br>
For further reading, check out these helpful links:

1. [R in Batch mode on Linux](http://www.cureffi.org/2014/01/15/running-r-batch-mode-linux/) 
2. [R tutorial for a Unix Environment](https://uwaterloo.ca/statistics-and-actuarial-science/research/resources/r-tutorial-unix-environment)
3. [The Linux Command Line: A Complete Introduction (book)] (https://www.amazon.com/Linux-Command-Line-2nd-Introduction/dp/1593279523/ref=sr_1_12?crid=13X90SPNPT377&dchild=1&keywords=shell+scripting&qid=1599228400&s=books&sprefix=shell+scripting%2Caps%2C154&sr=1-12)
4. [Scheduling jobs with cron](https://ole.michelsen.dk/blog/schedule-jobs-with-crontab-on-mac-osx/)

