---
title: "A Bit of Base R"
author: "Peter Higgins"
date: "6/7/2021"
output: html_document
---



# The Basics of Base R

While there are many great features of the *tidyverse*, one should not throw out the base R with the bathwater. The functions and packages of base R are stable and slow to change (unlike the dynamic packages and functions of the tidyverse), and many are helpful and important building blocks for using R. Some of the functions in base R tend to fail silently, and have unhelpful error messages, but they are embedded in a lot of R scripts. When you search for help with R on websites like RStudio Community and Stack Overflow, you will often find base R code, and you will need to know how to interpret it.

There are many really basic and important functions in base R that are worth knowing about.

Once you have a handle on these basic functions, you can say

![Obscure base R / video game meme](~/Documents/Rcode/rmrwr-book/images/baseRmeme.png)

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
## # A tibble: 235 × 19
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
## # … with 225 more rows, and 10 more variables: `10` <dbl>,
## #   `11` <dbl>, `12` <dbl>, `13` <dbl>, `14` <dbl>,
## #   `15` <dbl>, `16` <dbl>, `17` <dbl>, `18` <dbl>,
## #   `19` <dbl>
## # ℹ Use `print(n = ...)` to see more rows, and `colnames()` to see all variable names
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

    ::: {.warning}
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

## Concatenation

One of the simplest, but most common early functions in R is c(). The c() function concatenates items together into a vector. This can be helpful for building a vector of items to iterate over, or to build a vector which will become a variable in a dataframe, or even a vector of options for a function.

You simply write the items, separated by commas, in order inside the parentheses of c(). Remember that strings need to be enclosed in matching quotes.


```r
fib_numbers <- c(1, 1, 2, 3, 5, 8, 13, 21, 34)
fruit_vec <- c("apple", "banana", "coconut", "dragonfruit", "elderberry")

fib_numbers
```

```
## [1]  1  1  2  3  5  8 13 21 34
```

```r
fruit_vec
```

```
## [1] "apple"       "banana"      "coconut"     "dragonfruit"
## [5] "elderberry"
```

## Sequences

There are times when you want to create a sequence of numbers (i.e. 1 to 10, or 1 to 100), without manually concatenating a vector. The easiest way to do this is with the colon (:). You can assign 1:12 to an object, or 77:83, if you prefer.


```r
1:12
```

```
##  [1]  1  2  3  4  5  6  7  8  9 10 11 12
```

```r
77:83
```

```
## [1] 77 78 79 80 81 82 83
```

## Constants

Note that base R has some handy constants that may help in making vectors - LETTERS (vector of letters (string) from A to Z) - letters (vector of letters (string) from a to z) - month.abb (vector of 3 letter (English) month abbreviations from Jan to Dec) - month.name (vector of 3 letter (English) month abbreviations from January to December) - pi (the irrational number for relating diameter to circumference)

You can select subsets of these with the bracket notation, i.e letters[1:13]. You can also format number for printing as strings with sprintf() (for print formatting) to include the desired number of decimals.


```r
LETTERS[7:12]
```

```
## [1] "G" "H" "I" "J" "K" "L"
```

```r
letters[5:10]
```

```
## [1] "e" "f" "g" "h" "i" "j"
```

```r
month.abb[10:12]
```

```
## [1] "Oct" "Nov" "Dec"
```

```r
pi %>% sprintf(fmt = "%1.5f", .)
```

```
## [1] "3.14159"
```

## Fancier Sequences

You can make more complex sequences with the seq() function. The main arguments (parameters) of seq() are

-   from (default =1)

-   to (default =1)

-   by (default = (*to*-*from*)/*length*)

-   length

You will generally need at least 3 of these to describe a sequence, or *seq()* will use the default *by* value of 1. Note that if the *by* increment does not match the *to* argument, the sequence will stop at the last number before the *to* number.

*seq_len(n)* is a shortcut that gives you a sequence from 1 to n, while *seq_along(vector)* is a shortcut that gives you a sequence from 1 to the length of a the vector.

See the examples below


```r
# leaving out "length"
seq(from = 2, to = 18, by = 2) 
```

```
## [1]  2  4  6  8 10 12 14 16 18
```

```r
# leaving out argument names
seq(3, 18, length=6) 
```

```
## [1]  3  6  9 12 15 18
```

```r
# 'length' and 'to' do not match
seq(from = 24, to = 4, by = -6) 
```

```
## [1] 24 18 12  6
```

```r
# leaving out "to"
seq(from = 5, by = 5, length = 6) 
```

```
## [1]  5 10 15 20 25 30
```

```r
# leaving out "by"
seq(from = 16, to = 128, length = 8) 
```

```
## [1]  16  32  48  64  80  96 112 128
```

```r
seq(from = 51, by = -3, length = 17)
```

```
##  [1] 51 48 45 42 39 36 33 30 27 24 21 18 15 12  9  6  3
```

```r
# using the seq_len() shortcut with n
seq_len(14)
```

```
##  [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14
```

```r
# using the seq_along() shortcut with a vector
seq_along(7:23)
```

```
##  [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17
```

```r
seq_along(licorice$C)
```

```
##   [1]   1   2   3   4   5   6   7   8   9  10  11  12  13
##  [14]  14  15  16  17  18  19  20  21  22  23  24  25  26
##  [27]  27  28  29  30  31  32  33  34  35  36  37  38  39
##  [40]  40  41  42  43  44  45  46  47  48  49  50  51  52
##  [53]  53  54  55  56  57  58  59  60  61  62  63  64  65
##  [66]  66  67  68  69  70  71  72  73  74  75  76  77  78
##  [79]  79  80  81  82  83  84  85  86  87  88  89  90  91
##  [92]  92  93  94  95  96  97  98  99 100 101 102 103 104
## [105] 105 106 107 108 109 110 111 112 113 114 115 116 117
## [118] 118 119 120 121 122 123 124 125 126 127 128 129 130
## [131] 131 132 133 134 135 136 137 138 139 140 141 142 143
## [144] 144 145 146 147 148 149 150 151 152 153 154 155 156
## [157] 157 158 159 160 161 162 163 164 165 166 167 168 169
## [170] 170 171 172 173 174 175 176 177 178 179 180 181 182
## [183] 183 184 185 186 187 188 189 190 191 192 193 194 195
## [196] 196 197 198 199 200 201 202 203 204 205 206 207 208
## [209] 209 210 211 212 213 214 215 216 217 218 219 220 221
## [222] 222 223 224 225 226 227 228 229 230 231 232 233 234
## [235] 235
```

## Mathematical functions

R has many mathematical functions, which can be used in a variety of calculations. These can be run on a vector, or on a variable in a dataframe. These include (and there are many more):

-   mean

-   median

-   var

-   sd

-   min

-   max

-   range

-   rank

-   sum

Examples are shown below


```r
mean(1:20)
```

```
## [1] 10.5
```

```r
median(licorice$C)
```

```
## [1] 25.91
```

```r
var(licorice$C)
```

```
## [1] 18.24933
```

```r
sd(licorice$C)
```

```
## [1] 4.271923
```

```r
min(licorice$C)
```

```
## [1] 15.6
```

```r
max(licorice$C)
```

```
## [1] 36.33
```

```r
range(licorice$C)[2] # selects 2nd value in range (max)
```

```
## [1] 36.33
```

```r
rank(licorice$C)[1] # ranks first 10 values
```

```
## [1] 225
```

```r
sum(licorice$C) # sum of values
```

```
## [1] 6013.99
```

## Handling missing data (NAs)

R designates missing values as the symbol NA (not available). NAs propagate through calculations, so that if you have a vector with at least one NA, and you try to calculate the mean, it will return NA.


```r
mean(licorice$J)
```

```
## [1] NA
```

You can handle this within many functions (including mean, median, sd, and var) with the argument **na.rm** = TRUE. The default for these is na.rm = FALSE, so that if you are trying to do an operation on missing data, R will tell you.

na.rm is an argument in a number of mathematical functions, in which **na** comes first, followed by the verb **rm** (remove).

Testing whether a value or values are missing (NA) is in the reverse order. You use the *is.na()* function, in which the verb comes first, and then followed by NA. You might reasonably think that you can just use a normal equality test for NA values, like


```r
licorice$J == NA
```

```
##   [1] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
##  [19] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
##  [37] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
##  [55] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
##  [73] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
##  [91] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## [109] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## [127] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## [145] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## [163] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## [181] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## [199] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## [217] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
## [235] NA
```

but, because NAs propagate, you get just NAs, rather than TRUE or FALSE.

You can use is.na() for this.


```r
licorice$J %>% is.na()
```

```
##   [1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [10] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [19] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [28] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [37] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [46] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [55] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [64] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [73] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [82] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [91] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [100] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [109] FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE
## [118] FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
## [127] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [136] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [145] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [154] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [163] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [172] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [181] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [190] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [199] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [208] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [217] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [226] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [235] FALSE
```

There are a few TRUEs in there (value is NA), but they can be hard to count. The sum() function can help, when combined with *is.na().* The *which()* function can help you figure out which values are missing.

The anyNA() function can tell you if there are any missing values in a vector (or a variable/column in a dataframe).


```r
licorice$J %>% is.na() %>% sum()
```

```
## [1] 2
```

```r
licorice$J %>% is.na() %>% which()
```

```
## [1] 113 123
```

```r
licorice$C %>% anyNA()
```

```
## [1] FALSE
```

```r
licorice$J %>% anyNA()
```

```
## [1] TRUE
```

There are two missing values, in rows 113 and 123.

The na.omit() function can remove all of the rows(cases, observations) from a dataframe that have at least one missing value in any column. This can be helpful for modeling, in which cases with missing data can cause problems. It is helpful to keep track of the number of rows before and after na.omit(), to know how many cases/observations/rows you are discarding.


```r
nrow(licorice)
```

```
## [1] 235
```

```r
licorice %>% 
  na.omit() %>% 
  # modeling would happen here if not too many cases discarded
  nrow()
```

```
## [1] 233
```

Note that this can also be done in the tidyverse with drop_na() in the {tidyr} package. You can include a particular column or columns as an argument in drop_na() to only drop observations if there are missing values in these particular columns.


```r
licorice %>% 
  drop_na(H:J) %>% 
  nrow()
```

```
## [1] 233
```

The code above takes the licorice dataset, looks for NA values in rows of (only) columns H through J, and drops 2 rows based on missing data, reducing the number of rows from 235 to 233.

## Cutting Continuous data into Levels

While there are good arguments for why **not** to do this (dichotomania, loss of granularity in data), it is common to cut continuous data into levels, like (mild, moderate, severe), or (normal weight, overweight, obese). This can, when there are already established standard levels, make the data easier to interpret. The cut() function in base R makes this easy to do.


```r
C_factor3 <- cut(licorice$C, breaks = 3)
table(C_factor3)
```

```
## C_factor3
## (15.6,22.5] (22.5,29.4] (29.4,36.4] 
##          59         130          46
```

```r
str(C_factor3)
```

```
##  Factor w/ 3 levels "(15.6,22.5]",..: 3 2 2 2 3 3 2 3 1 2 ...
```

This creates a new variable (C_factor), which is a factor with 3 levels. The levels are stored as 1, 2, 3, and range from 15.6-22.5 for 1, above 22.5-29.4 for 2, and above 29.4 to 36.4 for 3. The interval notation uses the square bracket for including the listed number, and parentheses for starting just after the listed number. It is a good practice to develop a standard way of naming these created variables, which are related to the original variable, are factors, and have a certain number of levels. One helpful shorthand is to take the original variable name, and to add the suffix "\_f4*"* for a factor with 4 levels. A dichotomized variable would be *"*varname_f2"
