---
title: "Dplyr Verbs Tutorial"
output: learnr::tutorial
runtime: shiny_prerendered
---




## Take a look at Candy data. 
Edit the code below to
Glimpse candy_rankings

<div class="tutorial-exercise" data-label="candyhead" data-caption="Code" data-completion="1" data-diagnostics="1" data-startover="1" data-lines="0">

```text
glimpse(bechdel)
```

<script type="application/json" data-opts-chunk="1">{"fig.width":6.5,"fig.height":4.5,"fig.retina":1,"fig.align":"default","fig.keep":"high","fig.show":"asis","warning":true,"error":false,"message":true,"exercise.df_print":"default","exercise.checker":"NULL"}</script></div>


## Topic 1 : SeleCting Columns 
Note the C in seleCt - that is how you remember that it selects columns.

*Here's a simple exercise with select*

Edit the R code below to select only the columns:
competitor name, chocolate, and caramel:

<div class="tutorial-exercise" data-label="select" data-caption="Code" data-completion="1" data-diagnostics="1" data-startover="1" data-lines="0">

```text
candy_rankings %>% 
  select(peanutyalmondy)
```

<script type="application/json" data-opts-chunk="1">{"fig.width":6.5,"fig.height":4.5,"fig.retina":1,"fig.align":"default","fig.keep":"high","fig.show":"asis","warning":true,"error":false,"message":true,"exercise.df_print":"default","exercise.checker":"NULL"}</script></div>

### More selecting!
The select function has a number of helpers.
You can use the colon to select from varx:vary, including all the columns in between.
YOu can use select(starts_with("c")), or select(ends_with('fraction')).
You can use select(contains("rd"))
You can use select(one_of(c("chocolate", "caramel"))), or
matches(regular expressions), or
num_range(), or everything()

*Here's an exercise with some prepopulated code as well as `exercise.lines = 5` to provide a bit more initial room to work.*

Now select in the code block below:
4 different challenges

1. competitor_name, chocolate, crispedricewafer, and caramel using starts_with
2. the variables that end in percent
3. caramel, hard, bar, and sugarpercent ("ar")
4. variables in a one_of('varname') vector

<div class="tutorial-exercise" data-label="select2" data-caption="Code" data-completion="1" data-diagnostics="1" data-startover="1" data-lines="5">

```text
candy_rankings %>% 
  select(competitorname, chocolate, fruity, caramel)
```

<script type="application/json" data-opts-chunk="1">{"fig.width":6.5,"fig.height":4.5,"fig.retina":1,"fig.align":"default","fig.keep":"high","fig.show":"asis","warning":true,"error":false,"message":true,"exercise.df_print":"default","exercise.checker":"NULL"}</script></div>

## Topic 2 : FilteRing

### Filter
the filteR command has an R in it so that you can remember that you are filtering for Rows.

* Filter for certain rows*

Modify the following code to filter for:

1. candy with a sugar percent > 0.75

<div class="tutorial-exercise" data-label="filter" data-caption="Code" data-completion="1" data-diagnostics="1" data-startover="1" data-lines="0">

```text
candy_rankings %>% 
  filter(peanutyalmondy == TRUE)
```

```
# A tibble: 14 x 13
   competitorname chocolate fruity caramel peanutyalmondy
   <chr>          <lgl>     <lgl>  <lgl>   <lgl>         
 1 Almond Joy     TRUE      FALSE  FALSE   TRUE          
 2 Baby Ruth      TRUE      FALSE  TRUE    TRUE          
 3 Boston Baked ~ FALSE     FALSE  FALSE   TRUE          
 4 Peanut butter~ TRUE      FALSE  FALSE   TRUE          
 5 Mr Good Bar    TRUE      FALSE  FALSE   TRUE          
 6 Nestle Butter~ TRUE      FALSE  FALSE   TRUE          
 7 Payday         FALSE     FALSE  FALSE   TRUE          
 8 Peanut M&Ms    TRUE      FALSE  FALSE   TRUE          
 9 Reese's Minia~ TRUE      FALSE  FALSE   TRUE          
10 Reese's Peanu~ TRUE      FALSE  FALSE   TRUE          
11 Reese's pieces TRUE      FALSE  FALSE   TRUE          
12 Reese's stuff~ TRUE      FALSE  FALSE   TRUE          
13 Snickers       TRUE      FALSE  TRUE    TRUE          
14 Snickers Cris~ TRUE      FALSE  TRUE    TRUE          
# ... with 8 more variables: nougat <lgl>,
#   crispedricewafer <lgl>, hard <lgl>, bar <lgl>,
#   pluribus <lgl>, sugarpercent <dbl>, pricepercent <dbl>,
#   winpercent <dbl>
```

<script type="application/json" data-opts-chunk="1">{"fig.width":6.5,"fig.height":4.5,"fig.retina":1,"fig.align":"default","fig.keep":"high","fig.show":"asis","warning":true,"error":false,"message":true,"exercise.df_print":"default","exercise.checker":"NULL"}</script></div>

### More filtering

Now filter for

1. candy with chocolate in it (note double equals ==)
2. candy with either caramel or nougat (or with | pipe)
3. a bar with a pricepercent >= 0.8
4. a crispedricewafer with a winpercent >0.4
5. a fruity candy with a sugarpercent > 0.7
6. A candy with neither chocolate, caramel, or a fruity component

<div class="tutorial-exercise" data-label="filtermore" data-caption="Code" data-completion="1" data-diagnostics="1" data-startover="1" data-lines="0">

```text
candy_rankings %>% 
  filter(chocolate == FALSE & caramel == FALSE)
```

<script type="application/json" data-opts-chunk="1">{"fig.width":6.5,"fig.height":4.5,"fig.retina":1,"fig.align":"default","fig.keep":"high","fig.show":"asis","warning":true,"error":false,"message":true,"exercise.df_print":"default","exercise.checker":"NULL"}</script></div>

## Topic 3 : Mutating

### Mutate
the Mutate command lets you make new variables. For example
mutate(bmi = wt_kg/ht_m^2)

You can do several mutate operations in one set of parentheses, 
separated by commas.

mutate(bmi = wt_kg/ht_m^2,
        risk_score = bmi * total_chol)
        
When you create a new variable with mutate, you can use it immediately in the next statement or in the same data pipe.

Run the code below to see what it does, then
Modify the code to mutate to create:
1. a fruity_caramel variable for candies that have both fruity and caramel ==TRUE

<div class="tutorial-exercise" data-label="mutate" data-caption="Code" data-completion="1" data-diagnostics="1" data-startover="1" data-lines="0">

```text
candy_rankings %>% 
  mutate(nutty_nougat = round((peanutyalmondy + nougat)/2)) %>% 
  select(peanutyalmondy, nougat, nutty_nougat) %>% 
  arrange(desc(nutty_nougat))
```

```
# A tibble: 85 x 3
   peanutyalmondy nougat nutty_nougat
   <lgl>          <lgl>         <dbl>
 1 TRUE           TRUE              1
 2 TRUE           TRUE              1
 3 TRUE           TRUE              1
 4 FALSE          FALSE             0
 5 FALSE          TRUE              0
 6 FALSE          FALSE             0
 7 FALSE          FALSE             0
 8 FALSE          FALSE             0
 9 TRUE           FALSE             0
10 TRUE           FALSE             0
# ... with 75 more rows
```

<script type="application/json" data-opts-chunk="1">{"fig.width":6.5,"fig.height":4.5,"fig.retina":1,"fig.align":"default","fig.keep":"high","fig.show":"asis","warning":true,"error":false,"message":true,"exercise.df_print":"default","exercise.checker":"NULL"}</script></div>
 
 If you only want to keep the new variables, use the transmute verb.
<div class="tutorial-exercise" data-label="transmute" data-caption="Code" data-completion="1" data-diagnostics="1" data-startover="1" data-lines="0">

```text
candy_rankings %>% 
  transmute(nutty_nougat = round((peanutyalmondy + nougat)/2)) %>% 
  arrange(desc(nutty_nougat))
```

```
# A tibble: 85 x 1
   nutty_nougat
          <dbl>
 1            1
 2            1
 3            1
 4            0
 5            0
 6            0
 7            0
 8            0
 9            0
10            0
# ... with 75 more rows
```

<script type="application/json" data-opts-chunk="1">{"fig.width":6.5,"fig.height":4.5,"fig.retina":1,"fig.align":"default","fig.keep":"high","fig.show":"asis","warning":true,"error":false,"message":true,"exercise.df_print":"default","exercise.checker":"NULL"}</script></div>
### More mutating

Now modify the mutate code below to create

1. sugar_value - the ratio of sugarpercent to pricepercent
2. caramel_bar -candy with both caramel and bar
3. log_winpercent - normalized winpercent by taking natural log
4. sqrt_sugarpercent - normalize this left-tailed variable
5. sugar_pct - convert from a decimal to a percentage.

<div class="tutorial-exercise" data-label="mutatemore" data-caption="Code" data-completion="1" data-diagnostics="1" data-startover="1" data-lines="0">

```text
candy_rankings %>% 
  mutate(nuttinessperdollar = peanutyalmondy/pricepercent)
```

```
# A tibble: 85 x 14
   competitorname chocolate fruity caramel peanutyalmondy
   <chr>          <lgl>     <lgl>  <lgl>   <lgl>         
 1 100 Grand      TRUE      FALSE  TRUE    FALSE         
 2 3 Musketeers   TRUE      FALSE  FALSE   FALSE         
 3 One dime       FALSE     FALSE  FALSE   FALSE         
 4 One quarter    FALSE     FALSE  FALSE   FALSE         
 5 Air Heads      FALSE     TRUE   FALSE   FALSE         
 6 Almond Joy     TRUE      FALSE  FALSE   TRUE          
 7 Baby Ruth      TRUE      FALSE  TRUE    TRUE          
 8 Boston Baked ~ FALSE     FALSE  FALSE   TRUE          
 9 Candy Corn     FALSE     FALSE  FALSE   FALSE         
10 Caramel Apple~ FALSE     TRUE   TRUE    FALSE         
# ... with 75 more rows, and 9 more variables:
#   nougat <lgl>, crispedricewafer <lgl>, hard <lgl>,
#   bar <lgl>, pluribus <lgl>, sugarpercent <dbl>,
#   pricepercent <dbl>, winpercent <dbl>,
#   nuttinessperdollar <dbl>
```

<script type="application/json" data-opts-chunk="1">{"fig.width":6.5,"fig.height":4.5,"fig.retina":1,"fig.align":"default","fig.keep":"high","fig.show":"asis","warning":true,"error":false,"message":true,"exercise.df_print":"default","exercise.checker":"NULL"}</script></div>

## Topic 4 : Arranging (Sorting)

### Arrange
the arrange command lets you sort your dataset by particular variables.

You can arrange by several variables in order.
arrange(caramel, chocolate, sugarpercent)

The default is ascending order, but you can use desc() to change that.
arrange(desc(pricepercent))

Run the code below to see what it does, then
Modify the code to arrange the data by:

1. descending winpercent

Note that a select command is added to make it easier to see the result. You can also see this in the whole dataset with View()

<div class="tutorial-exercise" data-label="arrange" data-caption="Code" data-completion="1" data-diagnostics="1" data-startover="1" data-lines="0">

```text
candy_rankings %>% 
  arrange(sugarpercent) %>% 
  select(competitorname, sugarpercent)
```

```
# A tibble: 85 x 2
   competitorname        sugarpercent
   <chr>                        <dbl>
 1 One dime                    0.011 
 2 One quarter                 0.011 
 3 Reese's Miniatures          0.0340
 4 Chiclets                    0.046 
 5 Lemonhead                   0.046 
 6 Sour Patch Kids             0.0690
 7 Sour Patch Tricksters       0.0690
 8 Jawbusters                  0.0930
 9 Pixie Sticks                0.0930
10 Warheads                    0.0930
# ... with 75 more rows
```

<script type="application/json" data-opts-chunk="1">{"fig.width":6.5,"fig.height":4.5,"fig.retina":1,"fig.align":"default","fig.keep":"high","fig.show":"asis","warning":true,"error":false,"message":true,"exercise.df_print":"default","exercise.checker":"NULL"}</script></div>


### More arranging

Now modify the arrange code below to sort by

1. pricepercent
2. caramel, nougat, desc(sugarpercent)
3. chocolate, descending winpercent 
4. nougat, peanutyalmondy, pricepercent
5. hard, desc(bar), pluribus

<div class="tutorial-exercise" data-label="arrangemore" data-caption="Code" data-completion="1" data-diagnostics="1" data-startover="1" data-lines="0">

```text
candy_rankings %>% 
  arrange(fruity, desc(sugarpercent))
```

```
# A tibble: 85 x 13
   competitorname chocolate fruity caramel peanutyalmondy
   <chr>          <lgl>     <lgl>  <lgl>   <lgl>         
 1 Reese's stuff~ TRUE      FALSE  FALSE   TRUE          
 2 Milky Way Sim~ TRUE      FALSE  TRUE    FALSE         
 3 Sugar Babies   FALSE     FALSE  TRUE    FALSE         
 4 Candy Corn     FALSE     FALSE  FALSE   FALSE         
 5 Whoppers       TRUE      FALSE  FALSE   FALSE         
 6 Rolo           TRUE      FALSE  TRUE    FALSE         
 7 Peanut butter~ TRUE      FALSE  FALSE   TRUE          
 8 M&M's          TRUE      FALSE  FALSE   FALSE         
 9 100 Grand      TRUE      FALSE  TRUE    FALSE         
10 Milky Way Mid~ TRUE      FALSE  TRUE    FALSE         
# ... with 75 more rows, and 8 more variables:
#   nougat <lgl>, crispedricewafer <lgl>, hard <lgl>,
#   bar <lgl>, pluribus <lgl>, sugarpercent <dbl>,
#   pricepercent <dbl>, winpercent <dbl>
```

<script type="application/json" data-opts-chunk="1">{"fig.width":6.5,"fig.height":4.5,"fig.retina":1,"fig.align":"default","fig.keep":"high","fig.show":"asis","warning":true,"error":false,"message":true,"exercise.df_print":"default","exercise.checker":"NULL"}</script></div>

## Topic 5 : Grouping with group_by, then summarize

### group_by
the group_by command lets you group or subset your data by particular variables.
This allows you to easily calculate subgroup summaries or statistics.

You can group by several categorical variables in order.
group_by(caramel, chocolate)

Note that you can't group by continuous variables.

Run the code below to see what it does, then
Modify the code to group the data by chocolate, then calculate the mean winpercent:

Note that a select command is added to make it easier to see the result. You can also see this in the whole dataset with View()

<div class="tutorial-exercise" data-label="group" data-caption="Code" data-completion="1" data-diagnostics="1" data-startover="1" data-lines="0">

```text
candy_rankings %>% 
  group_by(peanutyalmondy) %>% 
  summarize(mean_win = mean(winpercent))
```

```
# A tibble: 2 x 2
  peanutyalmondy mean_win
* <lgl>             <dbl>
1 FALSE              47.7
2 TRUE               63.7
```

<script type="application/json" data-opts-chunk="1">{"fig.width":6.5,"fig.height":4.5,"fig.retina":1,"fig.align":"default","fig.keep":"high","fig.show":"asis","warning":true,"error":false,"message":true,"exercise.df_print":"default","exercise.checker":"NULL"}</script></div>


### More grouping

Now modify the arrange code below to 

1. group_by fruity, summarize median pricepercent
2. group_by caramel, summarize max winpercent
3. group_by caramel, then chocolate, summarize mean winpercent
4. group_by bar, then nougat, summarize mean sugarpercent
5. group_by hard, then pluribus, summarize mean winpercent

<div class="tutorial-exercise" data-label="groupmore" data-caption="Code" data-completion="1" data-diagnostics="1" data-startover="1" data-lines="0">

```text
candy_rankings %>% 
  group_by(bar) %>% 
  summarize(mean_sugar = mean(sugarpercent))
```

```
# A tibble: 2 x 2
  bar   mean_sugar
* <lgl>      <dbl>
1 FALSE      0.463
2 TRUE       0.528
```

<script type="application/json" data-opts-chunk="1">{"fig.width":6.5,"fig.height":4.5,"fig.retina":1,"fig.align":"default","fig.keep":"high","fig.show":"asis","warning":true,"error":false,"message":true,"exercise.df_print":"default","exercise.checker":"NULL"}</script></div>

## Topic 6 : Tallying, Counting and recounting

### tally
Tally will count the number of observations 
<br>
candy_rankings %>% tally() gives 85
<br>
count will do group_by(var), then tally()
<br>
candy_rankings %>% count(chocolate) counts the number in each subgroup

### count 
the count() command lets you count the number of observations in a particular level of a variable. This is helpful for quickly exploring what you have in each variable, and if there are any strange outliers. You can set sort=TRUE to get a descending sorted table of levels
<br>
count() without a variable argument is the same as tally()
<br>
You can also count() after a count() function to count the number of levels (which can be helpful if you have many of them)

You may want to glimpse the starwars dataset, then
Run the code below to see what it does, then
Modify the code to count by levels of homeworld.

You can also add a denominator variable to your dataset with add_tally() or a count per level by add_count(chocolate)

<div class="tutorial-exercise" data-label="count" data-caption="Code" data-completion="1" data-diagnostics="1" data-startover="1" data-lines="0">

```text
glimpse(starwars)
```

```
Rows: 87
Columns: 14
$ name       <chr> "Luke Skywalker", "C-3PO", "R2-D2", ...
$ height     <int> 172, 167, 96, 202, 150, 178, 165, 97...
$ mass       <dbl> 77, 75, 32, 136, 49, 120, 75, 32, 84...
$ hair_color <chr> "blond", NA, NA, "none", "brown", "b...
$ skin_color <chr> "fair", "gold", "white, blue", "whit...
$ eye_color  <chr> "blue", "yellow", "red", "yellow", "...
$ birth_year <dbl> 19.0, 112.0, 33.0, 41.9, 19.0, 52.0,...
$ sex        <chr> "male", "none", "none", "male", "fem...
$ gender     <chr> "masculine", "masculine", "masculine...
$ homeworld  <chr> "Tatooine", "Tatooine", "Naboo", "Ta...
$ species    <chr> "Human", "Droid", "Droid", "Human", ...
$ films      <list> [<"The Empire Strikes Back", "Reven...
$ vehicles   <list> [<"Snowspeeder", "Imperial Speeder ...
$ starships  <list> [<"X-wing", "Imperial shuttle">, <>...
```

```text
starwars %>% 
  count(eye_color, sort = TRUE)
```

```
# A tibble: 15 x 2
   eye_color         n
 * <chr>         <int>
 1 brown            21
 2 blue             19
 3 yellow           11
 4 black            10
 5 orange            8
 6 red               5
 7 hazel             3
 8 unknown           3
 9 blue-gray         1
10 dark              1
11 gold              1
12 green, yellow     1
13 pink              1
14 red, blue         1
15 white             1
```

<script type="application/json" data-opts-chunk="1">{"fig.width":6.5,"fig.height":4.5,"fig.retina":1,"fig.align":"default","fig.keep":"high","fig.show":"asis","warning":true,"error":false,"message":true,"exercise.df_print":"default","exercise.checker":"NULL"}</script></div>


### More counting

Now modify the counting code below to 

1. count the number of each species
2. tally the number of observations, and add to dataset with add_tally
3. count the number by eye_color, then add_count to the dataset.
4. count by skin_color and sort
5. count the number by homeworld, and sort

<div class="tutorial-exercise" data-label="countmore" data-caption="Code" data-completion="1" data-diagnostics="1" data-startover="1" data-lines="0">

```text
starwars %>% 
  count(birth_year, sort=TRUE) 
```

```
# A tibble: 37 x 2
   birth_year     n
 *      <dbl> <int>
 1       NA      44
 2       19       2
 3       41.9     2
 4       48       2
 5       52       2
 6       72       2
 7       82       2
 8       92       2
 9        8       1
10       15       1
# ... with 27 more rows
```

<script type="application/json" data-opts-chunk="1">{"fig.width":6.5,"fig.height":4.5,"fig.retina":1,"fig.align":"default","fig.keep":"high","fig.show":"asis","warning":true,"error":false,"message":true,"exercise.df_print":"default","exercise.checker":"NULL"}</script></div>

### Quiz

*You can include any number of single or multiple choice questions as a quiz. Use the `question` function to define a question and the `quiz` function for grouping multiple questions together.*

Some questions to verify that you understand the purposes of various base and recommended R packages:

<!--html_preserve--><div class="panel-heading tutorial-quiz-title">Quiz</div><!--/html_preserve--><!--html_preserve--><div class="panel panel-default">
<div data-label="quiz-1" class="tutorial-question panel-body">
<div id="quiz-1-answer_container" class="shiny-html-output"></div>
<div id="quiz-1-message_container" class="shiny-html-output"></div>
<div id="quiz-1-action_button_container" class="shiny-html-output"></div>
<script>if (Tutorial.triggerMathJax) Tutorial.triggerMathJax()</script>
</div>
</div><!--/html_preserve--><!--html_preserve--><div class="panel panel-default">
<div data-label="quiz-2" class="tutorial-question panel-body">
<div id="quiz-2-answer_container" class="shiny-html-output"></div>
<div id="quiz-2-message_container" class="shiny-html-output"></div>
<div id="quiz-2-action_button_container" class="shiny-html-output"></div>
<script>if (Tutorial.triggerMathJax) Tutorial.triggerMathJax()</script>
</div>
</div><!--/html_preserve-->

<!--html_preserve-->
<script type="application/shiny-prerendered" data-context="server-start">
library(learnr)
knitr::opts_chunk$set(echo = FALSE)
library(tidyverse)
library(fivethirtyeight)
data("candy_rankings")
data("starwars")
glimpse(starwars)
glimpse(candy_rankings)
</script>
<!--/html_preserve-->
<!--html_preserve-->
<script type="application/shiny-prerendered" data-context="server">
learnr:::register_http_handlers(session, metadata = NULL)
</script>
<!--/html_preserve-->
<!--html_preserve-->
<script type="application/shiny-prerendered" data-context="server">
session$onSessionEnded(function() {
        learnr:::session_stop_event(session)
      })
</script>
<!--/html_preserve-->
<!--html_preserve-->
<script type="application/shiny-prerendered" data-context="server">
`tutorial-exercise-candyhead-result` <- learnr:::setup_exercise_handler(reactive(req(input$`tutorial-exercise-candyhead-code-editor`)), session)
output$`tutorial-exercise-candyhead-output` <- renderUI({
  `tutorial-exercise-candyhead-result`()
})
</script>
<!--/html_preserve-->
<!--html_preserve-->
<script type="application/shiny-prerendered" data-context="server">
`tutorial-exercise-select-result` <- learnr:::setup_exercise_handler(reactive(req(input$`tutorial-exercise-select-code-editor`)), session)
output$`tutorial-exercise-select-output` <- renderUI({
  `tutorial-exercise-select-result`()
})
</script>
<!--/html_preserve-->
<!--html_preserve-->
<script type="application/shiny-prerendered" data-context="server">
`tutorial-exercise-select2-result` <- learnr:::setup_exercise_handler(reactive(req(input$`tutorial-exercise-select2-code-editor`)), session)
output$`tutorial-exercise-select2-output` <- renderUI({
  `tutorial-exercise-select2-result`()
})
</script>
<!--/html_preserve-->
<!--html_preserve-->
<script type="application/shiny-prerendered" data-context="server">
`tutorial-exercise-filter-result` <- learnr:::setup_exercise_handler(reactive(req(input$`tutorial-exercise-filter-code-editor`)), session)
output$`tutorial-exercise-filter-output` <- renderUI({
  `tutorial-exercise-filter-result`()
})
</script>
<!--/html_preserve-->
<!--html_preserve-->
<script type="application/shiny-prerendered" data-context="server">
`tutorial-exercise-filtermore-result` <- learnr:::setup_exercise_handler(reactive(req(input$`tutorial-exercise-filtermore-code-editor`)), session)
output$`tutorial-exercise-filtermore-output` <- renderUI({
  `tutorial-exercise-filtermore-result`()
})
</script>
<!--/html_preserve-->
<!--html_preserve-->
<script type="application/shiny-prerendered" data-context="server">
`tutorial-exercise-mutate-result` <- learnr:::setup_exercise_handler(reactive(req(input$`tutorial-exercise-mutate-code-editor`)), session)
output$`tutorial-exercise-mutate-output` <- renderUI({
  `tutorial-exercise-mutate-result`()
})
</script>
<!--/html_preserve-->
<!--html_preserve-->
<script type="application/shiny-prerendered" data-context="server">
`tutorial-exercise-transmute-result` <- learnr:::setup_exercise_handler(reactive(req(input$`tutorial-exercise-transmute-code-editor`)), session)
output$`tutorial-exercise-transmute-output` <- renderUI({
  `tutorial-exercise-transmute-result`()
})
</script>
<!--/html_preserve-->
<!--html_preserve-->
<script type="application/shiny-prerendered" data-context="server">
`tutorial-exercise-mutatemore-result` <- learnr:::setup_exercise_handler(reactive(req(input$`tutorial-exercise-mutatemore-code-editor`)), session)
output$`tutorial-exercise-mutatemore-output` <- renderUI({
  `tutorial-exercise-mutatemore-result`()
})
</script>
<!--/html_preserve-->
<!--html_preserve-->
<script type="application/shiny-prerendered" data-context="server">
`tutorial-exercise-arrange-result` <- learnr:::setup_exercise_handler(reactive(req(input$`tutorial-exercise-arrange-code-editor`)), session)
output$`tutorial-exercise-arrange-output` <- renderUI({
  `tutorial-exercise-arrange-result`()
})
</script>
<!--/html_preserve-->
<!--html_preserve-->
<script type="application/shiny-prerendered" data-context="server">
`tutorial-exercise-arrangemore-result` <- learnr:::setup_exercise_handler(reactive(req(input$`tutorial-exercise-arrangemore-code-editor`)), session)
output$`tutorial-exercise-arrangemore-output` <- renderUI({
  `tutorial-exercise-arrangemore-result`()
})
</script>
<!--/html_preserve-->
<!--html_preserve-->
<script type="application/shiny-prerendered" data-context="server">
`tutorial-exercise-group-result` <- learnr:::setup_exercise_handler(reactive(req(input$`tutorial-exercise-group-code-editor`)), session)
output$`tutorial-exercise-group-output` <- renderUI({
  `tutorial-exercise-group-result`()
})
</script>
<!--/html_preserve-->
<!--html_preserve-->
<script type="application/shiny-prerendered" data-context="server">
`tutorial-exercise-groupmore-result` <- learnr:::setup_exercise_handler(reactive(req(input$`tutorial-exercise-groupmore-code-editor`)), session)
output$`tutorial-exercise-groupmore-output` <- renderUI({
  `tutorial-exercise-groupmore-result`()
})
</script>
<!--/html_preserve-->
<!--html_preserve-->
<script type="application/shiny-prerendered" data-context="server">
`tutorial-exercise-count-result` <- learnr:::setup_exercise_handler(reactive(req(input$`tutorial-exercise-count-code-editor`)), session)
output$`tutorial-exercise-count-output` <- renderUI({
  `tutorial-exercise-count-result`()
})
</script>
<!--/html_preserve-->
<!--html_preserve-->
<script type="application/shiny-prerendered" data-context="server">
`tutorial-exercise-countmore-result` <- learnr:::setup_exercise_handler(reactive(req(input$`tutorial-exercise-countmore-code-editor`)), session)
output$`tutorial-exercise-countmore-output` <- renderUI({
  `tutorial-exercise-countmore-result`()
})
</script>
<!--/html_preserve-->
<!--html_preserve-->
<script type="application/shiny-prerendered" data-context="server">
learnr:::question_prerendered_chunk(structure(list(type = "learnr_radio", label = "quiz-1", question = structure("What symbol do you use to test equality in a logical statement?", html = TRUE, class = c("html", "character")), answers = list(structure(list(id = "lnr_ans_22cb725",     option = " !! ", value = " !! ", label = structure("!! ", html = TRUE, class = c("html",     "character")), correct = FALSE, message = NULL), class = c("tutorial_question_answer", "tutorial_quiz_answer")), structure(list(id = "lnr_ans_f5ab848",     option = " $ ", value = " $ ", label = structure("$ ", html = TRUE, class = c("html",     "character")), correct = FALSE, message = NULL), class = c("tutorial_question_answer", "tutorial_quiz_answer")), structure(list(id = "lnr_ans_37c2570",     option = " == ", value = " == ", label = structure("== ", html = TRUE, class = c("html",     "character")), correct = TRUE, message = NULL), class = c("tutorial_question_answer", "tutorial_quiz_answer")), structure(list(id = "lnr_ans_bcf08a2",     option = " = ", value = " = ", label = structure("= ", html = TRUE, class = c("html",     "character")), correct = FALSE, message = NULL), class = c("tutorial_question_answer", "tutorial_quiz_answer"))), button_labels = list(submit = structure("Submit Answer", html = TRUE, class = c("html", "character")), try_again = structure("Try Again", html = TRUE, class = c("html", "character"))), messages = list(correct = structure("Correct!", html = TRUE, class = c("html", "character")), try_again = structure("Incorrect", html = TRUE, class = c("html", "character")), incorrect = structure("Incorrect", html = TRUE, class = c("html", "character")), message = NULL, post_message = NULL), ids = list(    answer = "quiz-1-answer", question = "quiz-1"), loading = structure("<strong>Loading:<\u002fstrong> \nWhat symbol do you use to test equality in a logical statement?\n<br/><br/><br/>", html = TRUE, class = c("html", "character")), random_answer_order = FALSE, allow_retry = FALSE,     seed = 1314882888.88771, options = list()), class = c("learnr_radio", "tutorial_question")))
</script>
<!--/html_preserve-->
<!--html_preserve-->
<script type="application/shiny-prerendered" data-context="server">
learnr:::question_prerendered_chunk(structure(list(type = "learnr_radio", label = "quiz-2", question = structure("What symbol do you use to combine two logical statements with AND?", html = TRUE, class = c("html", "character")), answers = list(structure(list(id = "lnr_ans_82d6c63",     option = " | ", value = " | ", label = structure("| ", html = TRUE, class = c("html",     "character")), correct = FALSE, message = NULL), class = c("tutorial_question_answer", "tutorial_quiz_answer")), structure(list(id = "lnr_ans_c0194c8",     option = " ^ ", value = " ^ ", label = structure("^ ", html = TRUE, class = c("html",     "character")), correct = FALSE, message = NULL), class = c("tutorial_question_answer", "tutorial_quiz_answer")), structure(list(id = "lnr_ans_7e847b5",     option = " % ", value = " % ", label = structure("% ", html = TRUE, class = c("html",     "character")), correct = FALSE, message = NULL), class = c("tutorial_question_answer", "tutorial_quiz_answer")), structure(list(id = "lnr_ans_2d08372",     option = " & ", value = " & ", label = structure("&amp; ", html = TRUE, class = c("html",     "character")), correct = TRUE, message = NULL), class = c("tutorial_question_answer", "tutorial_quiz_answer"))), button_labels = list(submit = structure("Submit Answer", html = TRUE, class = c("html", "character")), try_again = structure("Try Again", html = TRUE, class = c("html", "character"))), messages = list(correct = structure("Correct!", html = TRUE, class = c("html", "character")), try_again = structure("Incorrect", html = TRUE, class = c("html", "character")), incorrect = structure("Incorrect", html = TRUE, class = c("html", "character")), message = NULL, post_message = NULL), ids = list(    answer = "quiz-2-answer", question = "quiz-2"), loading = structure("<strong>Loading:<\u002fstrong> \nWhat symbol do you use to combine two logical statements with AND?\n<br/><br/><br/>", html = TRUE, class = c("html", "character")), random_answer_order = FALSE, allow_retry = FALSE,     seed = 1448870601.82532, options = list()), class = c("learnr_radio", "tutorial_question")))
</script>
<!--/html_preserve-->
