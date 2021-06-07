---
title: "A Bit of Base R"
author: "Peter Higgins"
date: "6/7/2021"
output: html_document
---



# The Basics of Base R

While there are many great features of the *tidyverse*, one should not throw out the base R with the bathwater.

There are many really basic and important functions in base R that are worth knowing about.

Once you have a handle on these basic functions, you can say

![Obscure baseR video game meme](~/Documents/Rcode/rmrwr-book/images/baseRmeme.png)
[meme details](https://en.wikipedia.org/wiki/All_your_base_are_belong_to_us)

## Dimensions of Data Rectangles

Whether you have a data.frame, a tibble, or a matrix, it can be helpful to know the dimensions of what you have. You can get at these dimensions with

-   dim()

-   nrow()

-   ncol()

    You may want to know how many rows to loop over, or how many columns need names, but you will frequently need to access these numbers. The dim() function returns two numbers - the rows first, then the columns. Let's try this on the ***licorice*** dataset from the {medicaldata} package.


```r
dim(licorice)
```

```
## [1] 235  19
```

This is great, as long as you know that the first number is the number of rows, and the 2nd number is the number of columns (standard notation is R x C, so rows first, columns second). But if you want to get the number of rows out, and store it in a variable, you need to use the brackets [n] notation. Brackets allow you to pull out the ***nth*** item in a vector or a list. Let's pull out the first item (the number of rows), and the second item (the number of columns) separately. We will store these in the 2 variables *rows* and *columns*, then print them out.


```r
rows <- dim(licorice)[1]
rows
```

```
## [1] 235
```

```r
columns <- dim(licorice)[2]
columns
```

```
## [1] 19
```

You can also do this more directly with the *nrow*() and *ncol*() functions.


```r
rows <- nrow(licorice)
rows
```

```
## [1] 235
```

```r
columns <- ncol(licorice)
columns
```

```
## [1] 19
```

A similar approach can give you the length of a vector with the *length*() function. Here we will check the length of the **treat** vector in the **licorice** tibble.


```r
length(licorice$treat)
```

```
## [1] 235
```

::: {.warning}
The *length*() function works a bit differently on dataframes or tibbles - it returns the number of *variables/columns*. This can be surprising if you don't expect it, and you are expecting the number of rows.
:::


```r
length(licorice)
```

```
## [1] 19
```

## Naming columns

Sometimes you want to take a quick look at the names of all of you columns in a dataframe. The *names*() function is a quick solution.


```r
names(licorice)
```

```
##  [1] "preOp_gender"           "preOp_asa"             
##  [3] "preOp_calcBMI"          "preOp_age"             
##  [5] "preOp_mallampati"       "preOp_smoking"         
##  [7] "preOp_pain"             "treat"                 
##  [9] "intraOp_surgerySize"    "extubation_cough"      
## [11] "pacu30min_cough"        "pacu30min_throatPain"  
## [13] "pacu30min_swallowPain"  "pacu90min_cough"       
## [15] "pacu90min_throatPain"   "postOp4hour_cough"     
## [17] "postOp4hour_throatPain" "pod1am_cough"          
## [19] "pod1am_throatPain"
```

You can also use *names*() to re-set the names if you want to change a bunch of column names, by assigning a vector of names (of the same length).


```r
names(licorice) <- c("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S")
licorice[1:10, ]
```

```
##    A B     C  D E F G H I J K L M N O P Q R S
## 1  0 3 32.98 67 2 1 0 1 2 0 0 0 0 0 0 0 0 0 0
## 2  0 2 23.66 76 2 2 0 1 1 0 0 0 0 0 0 0 0 0 0
## 3  0 2 26.83 58 2 1 0 1 2 0 0 0 0 0 0 0 0 0 0
## 4  0 2 28.39 59 2 1 0 1 3 0 0 0 0 0 0 0 0 0 0
## 5  0 1 30.45 73 1 2 0 1 2 0 0 0 0 0 0 0 0 0 0
## 6  0 2 35.49 61 3 1 0 1 3 0 0 0 0 0 0 0 0 0 0
## 7  0 3 25.50 66 1 1 0 1 3 0 0 0 0 0 0 0 0 0 0
## 8  0 2 31.10 61 2 1 0 1 1 0 0 0 0 0 0 0 0 0 0
## 9  0 3 21.22 83 1 1 0 1 1 0 0 0 0 0 0 0 0 0 0
## 10 0 3 27.16 69 2 3 0 1 2 0 0 0 0 0 0 0 0 0 0
```

Note that you can use the *set_names()* function in the {purrr} package to conveniently change variable/column names within a data pipeline, and the *rename()* function in the dplyr package to change particular variable/column names.


```r
licorice %>% 
  purrr::set_names(1:19) %>% 
  dplyr::rename("purple" = 2) %>% 
  # note rename(new_name = old_name)
  tibble()
```

```
## # A tibble: 235 x 19
##      `1` purple   `3`   `4`   `5`   `6`   `7`   `8`   `9`
##    <dbl>  <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
##  1     0      3  33.0    67     2     1     0     1     2
##  2     0      2  23.7    76     2     2     0     1     1
##  3     0      2  26.8    58     2     1     0     1     2
##  4     0      2  28.4    59     2     1     0     1     3
##  5     0      1  30.4    73     1     2     0     1     2
##  6     0      2  35.5    61     3     1     0     1     3
##  7     0      3  25.5    66     1     1     0     1     3
##  8     0      2  31.1    61     2     1     0     1     1
##  9     0      3  21.2    83     1     1     0     1     1
## 10     0      3  27.2    69     2     3     0     1     2
## # … with 225 more rows, and 10 more variables: 10 <dbl>,
## #   11 <dbl>, 12 <dbl>, 13 <dbl>, 14 <dbl>, 15 <dbl>,
## #   16 <dbl>, 17 <dbl>, 18 <dbl>, 19 <dbl>
```


```r
licorice[1:10, ]
```

```
##    A B     C  D E F G H I J K L M N O P Q R S
## 1  0 3 32.98 67 2 1 0 1 2 0 0 0 0 0 0 0 0 0 0
## 2  0 2 23.66 76 2 2 0 1 1 0 0 0 0 0 0 0 0 0 0
## 3  0 2 26.83 58 2 1 0 1 2 0 0 0 0 0 0 0 0 0 0
## 4  0 2 28.39 59 2 1 0 1 3 0 0 0 0 0 0 0 0 0 0
## 5  0 1 30.45 73 1 2 0 1 2 0 0 0 0 0 0 0 0 0 0
## 6  0 2 35.49 61 3 1 0 1 3 0 0 0 0 0 0 0 0 0 0
## 7  0 3 25.50 66 1 1 0 1 3 0 0 0 0 0 0 0 0 0 0
## 8  0 2 31.10 61 2 1 0 1 1 0 0 0 0 0 0 0 0 0 0
## 9  0 3 21.22 83 1 1 0 1 1 0 0 0 0 0 0 0 0 0 0
## 10 0 3 27.16 69 2 3 0 1 2 0 0 0 0 0 0 0 0 0 0
```

Note also that we used the bracket notation above to print just the first 10 rows of the renamed version of the *licorice* dataframe. This was done with brackets that define which [rows, columns] we want to use (in this case for printing).

-   By using the sequence 1:10, we choose the first 10 rows.

-   By putting nothing after the comma, we select ***all*** columns.

    :::{.warning}

    You might be wondering why the column names reverted to alphabetical letters after we used set_names to change them to numbers. <br>\
    This is because we did set the names, and printed the result out to the console, but did **not** assign the result back to the licorice object with an assignment arrow, so it is transient, rather than a lasting change to the licorice object. This is a common pitfall for beginners.

    :::

We can use also use brackets to choose exactly which rows and columns we want.


```r
licorice[4:7, c(2,5,10)]
```

```
##   B E J
## 4 2 2 0
## 5 1 1 0
## 6 2 3 0
## 7 3 1 0
```

Here we have selected 4 particular rows with a sequence (4:7), and 3 particular columns (by concatenating these into a vector with the *c()* function).
