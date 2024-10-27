---
title: "Tips for Hashtag Debugging your Pipes and GGPlots"
author: "Peter Higgins"
date: "1/30/2020"
output: html_document
---



# Tips for Hashtag Debugging your Pipes and GGPlots

## Debugging
While layering functions with piping in the tidyverse
and the plus sign in `ggplots` is a great way to keep your code clear,
your will invariably find some bugs in your code.
<br>
This can be pretty frustrating, especially when you spend a lot of time staring at the code and it finally turns out to be something trivial, like a missing parenthesis, a pipe in place of a + (or the reverse), a missing aes() statement, or a mistyped function (fitler instead of filter).
<br>
So how can you systematically approach debugging a pipe or plot, and find and fix your problem efficiently without spending tons of time?

## The Quick Screen
Start by checking for common errors - check for **The Big 5**.
<br>

1. Click just to the right of each final parenthesis on each line. Does this result in highlighting the first parenthesis on that line of code? If not, you are probably missing a closing parenthesis.
2. When piping, check that you have a proper pipe `%>%` at the end of each line, except for the last line. 
3. When plotting, check that you have a plus sign `+` at the end of each line, except for the last line.
4. Error message about a missing function - ` Error in function(arguments) : could not find function "func"`. Either you are calling a function from a library you have not loaded, or you mis-typed the function. If the library was not loaded, go back to the top and load the library that this function comes from. If you mis-typed the function (for example, `/selcet`), fix the typographical error. The error message will tell you which function seems to be missing.
5. Error message about a missing object - `Error: object 'xxxobj' not found`. Make sure that you have typed the names of the dataframe and the variables correctly. Each of these is a data object. The error message will tell you which object seems to be missing.

Your Turn:
Search for The Big 5 in the pipe below
(Hint - there are 5 Bugs to Be Found)    
You should end up with 4 columns of 10 rows, sorted by efficiency, when all of the bugs have been fixed.


``` r
mtcars %>% 
  filter(cyl >4) %>% 
  select(mpg, hp, displ) %>% 
  mutate(efficiency = hp/disp ) +  
  filtre(efficiency > 0.5) %>% 
  arrange(desc(efficiency) %<% 
  slice(1:10)
```

```
## Error in parse(text = input): <text>:8:0: unexpected end of input
## 6:   arrange(desc(efficiency) %<% 
## 7:   slice(1:10)
##   ^
```


``` r
mtcars %>% 
  filter(cyl >4) %>% 
  select(mpg, hp, displ) %>% # watch for typos in object names
  mutate(efficiency = hp/disp ) + # watch for misplaced + vs %>%  
  filter(efficiency > 0.5) %>%  # watch for typos
  arrange(desc(efficiency) %<% # watch for mistyped pipes
  slice(1:10)
```

```
## Error in parse(text = input): <text>:8:0: unexpected end of input
## 6:   arrange(desc(efficiency) %<% # watch for mistyped pipes
## 7:   slice(1:10)
##   ^
```


``` r
mtcars %>% 
  filter(cyl >4) %>% 
  select(mpg, hp, displ) %>% 
  mutate(efficiency = hp/disp ) %>%  
  filter(efficiency > 0.5) %>%  
  arrange(desc(efficiency)) %>% # watch for missing closing parentheses
  slice(1:10)
```

```
## Error in `select()`:
## ! Can't select columns that don't exist.
## ✖ Column `displ` doesn't exist.
```
## Systematic Hunting For Bugs in Pipes

What if it is not one of the Big 5 Pipe Bugs, and you need to hunt systematically?

Let's start by adding a pipe to the last line (`slice(1:10)`),    
and then a `return()` as a new line following `slice(1:10)`,    
so that you now have an 8 line pipe.     
**Note** it will be blue - this is OK. 
It just shows that this is an important function.
<br>
Adding `return()` just returns the result of the previous 7 lines,    
which does not seem like much,    
but it makes it a lot easier to use our debugging MVP, the hashtag.
<br>
<br>
First, in debugging a pipe, you want to be able to quickly select and run lines repeatedly. You can do this with your mouse, but it is slow and sometimes inaccurate.
You can do this faster with the keyboard.
To run a whole pipe, just click anywhere in the pipe and press the key combination: <br>
Cmd-Shift-Return on the Mac <br>
Ctrl-Shift-Return on PC <br>
<br>
With this key combination, you don't have to use your mouse to select lines to run.    
This will run the whole pipe or plot.
<br>
Now you have to take control of exactly which lines of the pipe will run.<br>
You want to run a series of experiments to isolate the bug. <br>
Start by running the pipe from the top.<br>
Run just your first line (data) by putting a hashtag just before the first pipe `%>%` and pressing Cmd-Shift-Return while still on that line. If that works, delete the hashtag and repeat the process on the 2nd line.  <br>      
You can stop running the pipe after only 2 lines by placing a hashtag just before the 2nd pipe. Then press your Cmd-Shift-Return key combo to run just the first 2 lines.      <br>
If that works, try running the first 3 lines, by deleting the hashtag on line 2, and putting it just before the pipe on line 3 (Copy-Paste can help). <br>
Use this approach to run successively more lines of the pipe in the code chunk below.    
<br>
In which line of the pipe below do you hit the first error (bug)?


``` r
iris %>% 
  filter(Sepal.Length <5) %>% 
  select(Sepal.Length, Sepal.Width, Species) %>% 
  mutate(Sepal.Area = Sepal.Lngth * Sepal.Width) %>% 
  filter(Sepal.Area >10) %>% 
  arrange(desc(Sepal.Area) %>% 
  slice(1:10) %>% 
  return()
```

```
## Error in parse(text = input): <text>:10:0: unexpected end of input
## 8:   return()
## 9:   
##   ^
```


``` r
iris %>% 
  filter(Sepal.Length <5) %>% 
  select(Sepal.Length, Sepal.Width, Species) %>% 
  mutate(Sepal.Area = Sepal.Lngth * Sepal.Width) %>% # watch for typos
  filter(Sepal.Area >10) %>% 
  arrange(desc(Sepal.Area) %>% # watch for missing parentheses
  slice(1:10) %>% 
  return()
```

```
## Error in parse(text = input): <text>:10:0: unexpected end of input
## 8:   return()
## 9:   
##   ^
```
Great. Now you know the bug is somewhere in lines 4-7. <br>
You can selectively turn off one line at a time by putting a hashtag at the beginning of the line.
Use this approach to turn off line 5 (filter). <br>
Does this fix the pipe?<br>
 If not, try lines 4,6,7 individually. Turning off which one gets rid of the error/changes the error? <br>
 Changing the error means that you made it at least a little bit farther before a new error occurred. <br>
 Now hunt in the 'commented out/hashtagged' line for an error you can fix. Once you think you have fixed it, try running the pipe up to and including that line (hashtag just before pipe in that line). Does that work?<br>
If yes, you have made progress. <br>
Keep going line by line until you find and fix the next bug, until you can get the whole pipe to run.

## Systematic Hunting For Bugs in Plots

The Big 5 Common Errors in Plots are slightly different.
<br>

1. Click just to the right of each final parenthesis on each line. Does this result in highlighting the first parenthesis on that line of code? If not, you are probably missing a closing parenthesis.
2. When plotting, check that you have a plus sign `+` at the end of each line, except for the last line.
3. Missing aes() mapping. <br> 
It is easy to get excited about your ggplot and declare variables in the ggplot statement, and forget about wrapping the mapping of x and y in an aesthetic function. Check to make sure that every time you map variables in your data to a plot component (x,y, color, shape, size, etc.) that this occurs **inside** an aes() call.
4. Error message about a missing function - ` Error in function(arguments) : could not find function "func"`. Either you are calling a function from a library you have not loaded, or you mis-typed the function. If the library was not loaded, go back to the top and load the library that this function comes from. If you mis-typed the function (for example, `/selcet`), fix the typographical error. The error message will tell you which function seems to be missing.
5. Error message about a missing object - `Error: object 'xxxobj' not found`. Make sure that you have typed the names of the dataframe and the variables correctly. Each of these is a data object. The error message will tell you which object seems to be missing.
<br>
## Your Turn to Debug a Plot
<br>
Before hashtag-debugging the plot below, we will cap the plot code with an additional final line, by adding a `+` to the final line `theme_minimal()` and a new following line: `NULL`. This functions like `return` does for pipes - we can now use hashtags to turn off lines without causing errors because of missing pipes.<br>
Go ahead and add the `+` and `NULL` to the plot in the code chunk below.


```
## Error in theme_mnimal(): could not find function "theme_mnimal"
```

Now use the same hashtag approach to run the lines of the plot code sequentially, adding one line at a time, with a hashtag placed just before the pipe, and using the Cmd-Shift-Return key combination. When you hit an error, use the hashtag at the beginning of each line that is a suspect in this Bug Hunt, and turn off one line at a time until you isolate the Bug.
Then try to fix it, and run the whole plot chunk one line at a time.

## Hashtag Debugging

The elements of **Hashtag Debugging** of a code chunk are simply stated in 7 steps:

1. Add a placeholder line to the end of the code chunk
  a. `%>% return()` for data pipes
  b. `+ NULL` for plots
2. Insert a hashtag just before the line extender (`%>%` for datapipes, `+` for plots) near the top of the code chunk
3. Use Cmd-Shift-Return or Ctrl-Shift-Enter to run the code up to the hashtag.
4. Keep running more lines by moving the hashtag down one line until you hit an error.
5. Try to find and fix the error in that line.
6. If needed, put a hashtag at the beginning of a line to turn off that line and run the rest of the pipe.
7. If the error IS resolved (or changes), you have fixed the first error. Now run incrementally more lines (steps 2-4) until you have found a new error or completely fixed the pipe.

Use your new skills.    
Figure out which Star Wars characters are overweight (by human standards)
<br>
Try debugging the data pipe below.
Work through each step in the process.

## Pipe 2

``` r
starwars %>% 
  filter(height <180) %>% 
  select(name, height, mass, gender homeworld, species) %>% 
  mtate(bmi = mass^2/height) %>% 
  filter(bmi>=25) %<% 
  select(name, height, mass, bmi) %>% 
  arrange(dsc(bmi)) %>% 
  slice(1:15) 
```

```
## Error in parse(text = input): <text>:3:37: unexpected symbol
## 2:   filter(height <180) %>% 
## 3:   select(name, height, mass, gender homeworld
##                                        ^
```

Good work!

Now try debugging the problematic plotting code chunk below. 
There are multiple errors.
Work through each step in the process.

## Plot 2

``` r
murders %>% 
  ggplot(x = population/10^6, y = total, label = abb) +
  geom_abline(intercept = log10(r), lty=2, col=darkgrey) +
  geom_point(aes(color==region), size = 3) +
  geom_text_repel() +
  scale_x_log10() +
  scale_y_log10() +
  xlab("Populations in millions (log scale)") +
  ylab("Total number of murders (log scale)") 
```

```
## Error: object 'darkgrey' not found
```

``` r
  ggtitle("US Gun Murders in 2010") +
  scale_color_discrete(name="Region")
```

```
## NULL
```


Here is another complex plot.
Work through each step to completely debug this one.
When it works, it will make a heatmap of measles cases in the US
by month and year, with the introduction of the measles vaccine 
marked as an important event.

## Plot3

``` r
us_contagious_diseases %>%
  filter(!state%in%c("Hawaii","Alaska") & disease ==  the_disease) %>%
  mutate(rate = count / population * 10000 * 52 / weeks_reporting) %>%
  mutate(state = reorder(state, rate) %>%
  ggplot(aes(year state,  fill = rate)) %>%
  geom_tile(color = "grey50") +
  scale_x_cntinuous(expand=c(0,0)) +
  scale_fill_gradientn(colors = brewer.pal(9, "Reds"), trans = "sqrt") +
  geom_vline(xintercept=1963, col = "blue") +
  theme_minimal() +  
  theme(panel.grid = element_blank()) +
  ggttle(the_disease) +
  ylab("") +
  xlab("")
```

```
## Error in parse(text = input): <text>:5:19: unexpected symbol
## 4:   mutate(state = reorder(state, rate) %>%
## 5:   ggplot(aes(year state
##                      ^
```

Now let's try a final data pipe debugging.

Use your skills to make this one work.

## Pipe 3

``` r
gapminder %>% 
  filter(year == 1965) %>% 
  filter(!is.na(infant_mortality) %>% 
  mutate(adult_survival = life_expectancy/infant_mortality) %>% 
  select(country, adultsurvival, continent) %>% 
  group_by(continent) %>% 
  summarize(mean_adult_surv = mean(adult_survival),
            sd_adult_surv = stdev(adult_survival)) %>% 
  arrange(mean_adult_surv)
```

```
## Error in parse(text = input): <text>:11:0: unexpected end of input
## 9:   arrange(mean_adult_surv)
## 10:   
##    ^
```
