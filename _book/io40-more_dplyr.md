---
title: "more_dplyr"
author: "Peter Higgins"
date: "8/15/2019"
output: html_document
---



# More dplyr

You have learned the big 7 verbs in dplyr, including
<br>

1. filteR
2. seleCt
3. mutate
4. group_by
5. summarize
6. arrange
7. count

<br>
You can review with this interactive tutorial: <br>
[click here](https://hgshiny.med.umich.edu/dplyr_wrangle1/)
<br>
But there is more!!

### Rename

when you don't need a full mutate, just better names.
This often comes up after you have used clean_names to improve the formatting of variable names, but you end up with long, long names.
<br>
First run the code chunk below to see what you have in the data frame

Then pipe tbl into a rename function, which has the format<br>
rename(new_name = old_name)
and rename the sbp as sbp_basel

``` r
name <- c("Bob", "Carla", "Dave")
the_value_of_sbp_at_baseline <- c(120, 134, 96)
tbl <- data.frame(name, the_value_of_sbp_at_baseline)
tbl %>% 
  rename(sbp_base = the_value_of_sbp_at_baseline)
```

```
##    name sbp_base
## 1   Bob      120
## 2 Carla      134
## 3  Dave       96
```

### Re-arrange your variables/columns

If you don't like the order of your variables, you can use *select* to reorder them.
use the format:
select(var1, var2, var3:var4, everything())

note that everything() puts all the other variables in at the end, in their previous order.
This is helpful for pulling interesting variables to the front of the line.

Run the chunk below,
then pipe the tbl into 
 select(pt_id, everything())


``` r
firstname <- c("Bob", "Carla", "Dave", "Elena")
pt_id <- c(001, 002, 003, 004)
lastname <- c("Edwards", "Frankel", "Genghis", "Harrison")
tbl <- data.frame(firstname, pt_id, lastname)
tbl %>% 
  select(pt_id, everything())
```

```
##   pt_id firstname lastname
## 1     1       Bob  Edwards
## 2     2     Carla  Frankel
## 3     3      Dave  Genghis
## 4     4     Elena Harrison
```

### Find distinct rows

If you want to list only the distinct, unique observations, you can use the distinct function.

Run the code chunk below to see the replicates by visit_num

Then pipe tbl into 
  distinct(var1, var2) - the variables you care about
  
  In this case, use firstname, lastname to find the distinct patients


``` r
firstname <- rep(c("Bob", "Carla", "Dave", "Elena"),3)
pt_id <- rep(c(001, 002, 003, 004),3)
lastname <- rep(c("Edwards", "Frankel", "Genghis", "Harrison"),3)
visit_num <- c(rep(1,4), rep(2, 4), rep(3,4))
tbl <- data.frame(pt_id, firstname, lastname, visit_num)
tbl %>% 
  distinct(firstname, lastname) ->
unique_pts
```

### Select a group of rows with slice()
Sometimes you just want a few contiguous rows, like with head(), or tail().
but you can also pick which rows with slice()

This is a simple command with 

slice(start_row:end_row) to select the rows you want

Run the chunk below to find out how many rows are in the starwars dataset.

Then look at head and tail functions

Then pipe starwars into a slice function.

Slice out rows 15:25
or
46:60


``` r
dim(starwars)
```

```
## [1] 87 14
```

``` r
starwars %>% 
  head(7)
```

```
## # A tibble: 7 × 14
##   name      height  mass hair_color skin_color eye_color birth_year sex   gender
##   <chr>      <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> <chr> 
## 1 Luke Sky…    172    77 blond      fair       blue            19   male  mascu…
## 2 C-3PO        167    75 <NA>       gold       yellow         112   none  mascu…
## 3 R2-D2         96    32 <NA>       white, bl… red             33   none  mascu…
## 4 Darth Va…    202   136 none       white      yellow          41.9 male  mascu…
## 5 Leia Org…    150    49 brown      light      brown           19   fema… femin…
## 6 Owen Lars    178   120 brown, gr… light      blue            52   male  mascu…
## 7 Beru Whi…    165    75 brown      light      blue            47   fema… femin…
## # ℹ 5 more variables: homeworld <chr>, species <chr>, films <list>,
## #   vehicles <list>, starships <list>
```

``` r
starwars %>% 
  tail(10)
```

```
## # A tibble: 10 × 14
##    name     height  mass hair_color skin_color eye_color birth_year sex   gender
##    <chr>     <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> <chr> 
##  1 Grievous    216   159 none       brown, wh… green, y…         NA male  mascu…
##  2 Tarfful     234   136 brown      brown      blue              NA male  mascu…
##  3 Raymus …    188    79 brown      light      brown             NA male  mascu…
##  4 Sly Moo…    178    48 none       pale       white             NA <NA>  <NA>  
##  5 Tion Me…    206    80 none       grey       black             NA male  mascu…
##  6 Finn         NA    NA black      dark       dark              NA male  mascu…
##  7 Rey          NA    NA brown      light      hazel             NA fema… femin…
##  8 Poe Dam…     NA    NA brown      light      brown             NA male  mascu…
##  9 BB8          NA    NA none       none       black             NA none  mascu…
## 10 Captain…     NA    NA none       none       unknown           NA fema… femin…
## # ℹ 5 more variables: homeworld <chr>, species <chr>, films <list>,
## #   vehicles <list>, starships <list>
```

``` r
starwars %>% 
  slice(15:35)
```

```
## # A tibble: 21 × 14
##    name    height   mass hair_color skin_color eye_color birth_year sex   gender
##    <chr>    <int>  <dbl> <chr>      <chr>      <chr>          <dbl> <chr> <chr> 
##  1 Greedo     173   74   <NA>       green      black           44   male  mascu…
##  2 Jabba …    175 1358   <NA>       green-tan… orange         600   herm… mascu…
##  3 Wedge …    170   77   brown      fair       hazel           21   male  mascu…
##  4 Jek To…    180  110   brown      fair       blue            NA   <NA>  <NA>  
##  5 Yoda        66   17   white      green      brown          896   male  mascu…
##  6 Palpat…    170   75   grey       pale       yellow          82   male  mascu…
##  7 Boba F…    183   78.2 black      fair       brown           31.5 male  mascu…
##  8 IG-88      200  140   none       metal      red             15   none  mascu…
##  9 Bossk      190  113   none       green      red             53   male  mascu…
## 10 Lando …    177   79   black      dark       brown           31   male  mascu…
## # ℹ 11 more rows
## # ℹ 5 more variables: homeworld <chr>, species <chr>, films <list>,
## #   vehicles <list>, starships <list>
```

### Randomly sample some rows with sample_n() or sample_frac()
Sometimes you want a smaller but representative sample of rows, 
which you can get with sample_n() or sample_frac()

sample_n needs a size (number of rows)

while sample_frac needs a size between 0 and 1.

You can also choose to sample with replacement (replace = TRUE)

Using the chunk below,
try to 

1. sample 30 records from starwars (without replacement)
2. take a 20% random sample (with replacement)


``` r
starwars %>% 
  sample_n(size =30, replace =TRUE)
```

```
## # A tibble: 30 × 14
##    name     height  mass hair_color skin_color eye_color birth_year sex   gender
##    <chr>     <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> <chr> 
##  1 IG-88       200   140 none       metal      red               15 none  mascu…
##  2 Rugor N…    206    NA none       green      orange            NA male  mascu…
##  3 Wicket …     88    20 brown      brown      brown              8 male  mascu…
##  4 BB8          NA    NA none       none       black             NA none  mascu…
##  5 Ric Olié    183    NA brown      fair       blue              NA male  mascu…
##  6 Yarael …    264    NA none       white      yellow            NA male  mascu…
##  7 Ayla Se…    178    55 none       blue       hazel             48 fema… femin…
##  8 Finis V…    170    NA blond      fair       blue              91 male  mascu…
##  9 Lama Su     229    88 none       grey       black             NA male  mascu…
## 10 Jango F…    183    79 black      tan        brown             66 male  mascu…
## # ℹ 20 more rows
## # ℹ 5 more variables: homeworld <chr>, species <chr>, films <list>,
## #   vehicles <list>, starships <list>
```

``` r
starwars %>% 
  sample_frac(size = 0.2, replace = TRUE)
```

```
## # A tibble: 17 × 14
##    name     height  mass hair_color skin_color eye_color birth_year sex   gender
##    <chr>     <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> <chr> 
##  1 Finis V…    170    NA blond      fair       blue            91   male  mascu…
##  2 Anakin …    188    84 blond      fair       blue            41.9 male  mascu…
##  3 Darth V…    202   136 none       white      yellow          41.9 male  mascu…
##  4 Poe Dam…     NA    NA brown      light      brown           NA   male  mascu…
##  5 Yarael …    264    NA none       white      yellow          NA   male  mascu…
##  6 Obi-Wan…    182    77 auburn, w… fair       blue-gray       57   male  mascu…
##  7 Taun We     213    NA none       grey       black           NA   fema… femin…
##  8 Saesee …    188    NA none       pale       orange          NA   male  mascu…
##  9 Nien Nu…    160    68 none       grey       black           NA   male  mascu…
## 10 Bail Pr…    191    NA black      tan        brown           67   male  mascu…
## 11 R4-P17       96    NA none       silver, r… red, blue       NA   none  femin…
## 12 Yarael …    264    NA none       white      yellow          NA   male  mascu…
## 13 Dexter …    198   102 none       brown      yellow          NA   male  mascu…
## 14 Jek Ton…    180   110 brown      fair       blue            NA   <NA>  <NA>  
## 15 Wat Tam…    193    48 none       green, gr… unknown         NA   male  mascu…
## 16 Lobot       175    79 none       light      blue            37   male  mascu…
## 17 Dooku       193    80 white      fair       brown          102   male  mascu…
## # ℹ 5 more variables: homeworld <chr>, species <chr>, films <list>,
## #   vehicles <list>, starships <list>
```

but you can also pick which rows with slice()
