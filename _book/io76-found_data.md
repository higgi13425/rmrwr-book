---
title: "Using Found (Web) Data"
author: "Peter Higgins"
date: "10/20/2024"
output: html_document
---



# Using Found (Web) Data

## Found Poetry

You will, on occasion, find a useful table of data online, already in electronic format, that would be useful for you to use as an outcome or as an independent variable in an analysis. It would be silly to re-type these data, as they are already in electronic format.

I call this 'Found Data', as opposed to data you generate, collect, and curate yourself, in part as a reference to the concept of 'Found Poetry', where a poet finds a text, and then adds line breaks to put it into verse form.

Several classic examples were intermittently published in the *Village Voice* in New York City, championing the "Found Poetry" of the New York Yankees' announcer Phil Rizzuto. From an April 21, 1991 broadcast:

**Field of Butterflies**

*Absolutely! If you don't get a little* <br> *A few butterflies* <br> *No matter what you do* <br> *On the first day of anything* <br> *You're not human*

::: warning
It is **important** to check and validate any data you find on the web. It may be out of date, or simply wrong. Be careful to use reliable sources (The CDC, the Census Bureau, or sites like KFF) as often as you can.
:::

## Found Data

You might find data on population, income, or socioeconomic markers organized by geography (state, city, province), or other data that you can use to enrich your analysis.

There are **four major options** to bring these found data onto your local computer and into your local project.

1)  Download the data, usually as a .csv or .xlsx file, and read it into R using read_csv() or read_excel(). **Look for a download button first**. A good example is the KFF (Kaiser Family Foundation) website, which has a lot of useful data on health care, and often has a download button for the data. One insurance example [**here**](https://www.kff.org/other/state-indicator/total-population/). Look for the download button (downward arrow into a file tray) at the top right of the data frame.

2)  Particularly for small, one-off tables, copy the table and use the `{datapasta}` package to paste it into R. You may need to do a bit of data cleaning, but this is pretty straightforward, and you can save the table as a csv once it is cleaned, and just re-load this with `read_csv()` in the future.

3)  Use the `{rvest}` package to scrape the data from a website. This is a bit more advanced, but can be very useful if the data are updated frequently on a website, and it is important (e.g. for a dashboard) to have the freshest, up-to-date data.

4)  Look for a package that uses an API (Application Programming Interface) to the data website, and you can use the package to access the data directly (like {tidycensus} for US Census data).

## Download Example

You will find datasets that are really useful (and often really big) online, and you generally will want to download these along with the documentation to help you understand the data. Documentation often supplies details and meta-data about how the data were collected, organized, and cleaned. One good example from the Centers of Disease Control (CDC) in the US is the Social Vulnerability Index (SVI). This is a dataset that is updated every two years, and is used to help identify vulnerable communities that may need extra support in the event of a disaster. The data are available at the CDC website **here**. You can choose a single state, or the whole US to download. New data are available every 2 years. You can also select the SVI data in the US by county or census tract. The documentation files for these datasets are also available in links on the right side of this page. You can just download a table of the data, or include the shapefiles for the geographic units (counties, states, census tracts) that will allow you to create maps of the data.

## Datapasta (small table) Example

You will on occasion find a smallish table that could be helpful for your analysis. I often use population by state for US data. It can be useful to normalize state-level data by the state population, and it can be helpful to pull in a table of these data.

An example of a table of state populations is available at the online Encyclopedia Brittanica, at <https://www.britannica.com/topic/largest-U-S-state-by-population>.

You can copy the entire table (Cmd-C / Ctrl-C), then use the datapasta package add-in to paste it into R.

First, make sure you have loaded {datapasta}, by running the code chunk below.


``` r
library(datapasta)
```

1.  Start by copying the table from the website (Ctrl-C / Cmd-C).

2.  Recreate the code: `pop_data <- paste_from_datapasta_here` from the code chunk below in your local version of R Studio.

3.  Delete the "`paste_from_datapasta_here`" in your local R Studio and leave your cursor there.

4.  Now go to the top of your RStudio window, and find the "Addins" dropdown. Click on this dropdown and find the DATAPASTA commands section. Use the 'Paste as data.frame' add-in to paste the data into R.

5.  Paste it into the indicated spot in the code chunk below.

6, Then run this code. This will create a data frame called `pop_data` with the data you pasted in, which will appear in your Environment tab.


``` r
pop_data <- paste_from_datapasta_here
```

Now you have the data in, but it is still a bit icky and in need of some data cleaning. Open up the pop_data dataframe by clicking on the name in the Environment tab, and look at the data. What needs to be cleaned up?


<div class='webex-solution'><button>Click here to see the solution</button>


1.  The first row is the header, but the names are icky, and not in standard lower case with underscores (snake_case). You can use the `janitor::clean_names()` function to fix this.

2.  The state names have ranking numbers before them, which need to be removed. You can use the `mutate()` and `str_remove("\\d+\\. ")` function to remove these. Note the double backslashes in the `str_remove()` function to use escape characters for d (digits) and the period (used for all punctuation).

3.  The population estimates include "(2023 est.) ", which also needs to be removed. Use the `mutate()` and `str_remove("\\(2023 est.\\) ")` function to remove these. Note the double backslashes in the `str_remove()` function to use escape characters for parentheses.

4.  The population census numbers include "(2020) ", which also needs to be removed, with `mutate()` and `str_remove("\\(2020\\) ")` functions.

5.  The population numbers are in a character format, and need to be converted to numeric. You can use the `dplyr::mutate()` and `as.numeric()` functions to convert these.

6.  the cleaned `u_s_state` variable name is still a bit icky - go ahead and use `rename(new_name = old_name)` to rename it to `state`.


</div>


Take a few minutes to clean up these data. If needed, websearch str_remove() and as.numeric() to see how they work. Details on how to match digits and punctuation in regular expressions can be found at <https://www.regular-expressions.info/quickstart.html>.

## Your Turn

Take a look at the web page at [**US state poverty data**](https://en.wikipedia.org/wiki/List_of_U.S._states_and_territories_by_poverty_rate). This is a website with 3 tables on poverty in US states and territories. Inspect this web page a bit. Take a look at these from the datapasta perspective, and try to copy the US Census Bureau table (the first one, but compy without the messy headers) to your local RStudio. You can use the {datapasta} Addin menu to paste the data into R and assign it to an object. Then clean up the data as needed.

Give this a try in your local RStudio, using the instructions below to scrape the US Census Bureau table. Check your solution by clicking on the "Click here to see the solutions" button below.

1.  Copy the US Census Bureau table (the first table) by selecting and Cmd-C/Ctrl-C. Since the headers are a bit messy, skip these (we will use `purrr::set_names` later).You may also choose to skip the summary line for the United States at the end (or filter it out later).

2.  Go to your local RStudio, be sure {datapasta} is loaded, and select the Addin to paste a data.frame. Assign the data with the assignment arrow to a new data_poverty object.

3.  Clean up the data as needed. You will need to set the names of the columns, remove the summary line for the US, remove the `%` symbol from the percentage with `str_remove()`, and then convert the numeric columns from character to numeric. See below for a data cleaning solution.


<div class='webex-solution'><button>Click here to see the solutions</button>



``` r
data_poverty <- data.frame(
  stringsAsFactors = FALSE,
                V1 =  c("Mississippi","Louisiana",
                       "New Mexico","West Virginia","Kentucky","Arkansas",
                       "Alabama","District of Columbia","Oklahoma",
                       "South Carolina","Tennessee","Georgia","Texas","Arizona",
                       "North Carolina","Michigan","Ohio","New York","Florida",
                       "Missouri","Indiana","South Dakota","Montana","Nevada",
                       "California","Oregon","Illinois","Pennsylvania","Idaho",
                       "Rhode Island","Kansas","Delaware","Iowa","Maine",
                       "Wisconsin","Vermont","Wyoming","North Dakota",
                       "Nebraska","Alaska","Washington","Virginia","Massachusetts",
                       "Connecticut","Colorado","New Jersey","Minnesota",
                       "Hawaii","Utah","Maryland","New Hampshire"),
                V2 = c(2883074,4532187,2053909,
                       1755591,4322881,2923585,4771614,669089,3833712,4950181,
                       6603468,10238369,28013446,7012999,10098330,9753541,
                       11350378,19009098,20793628,5942813,6491632,849910,
                       1036490,2987817,38589882,4096744,12418504,12387061,
                       1722972,1017028,2828498,941266,3051284,1304038,
                       5659485,599938,566858,735842,1869467,719445,7372433,
                       8255575,6637329,3466935,5563823,8713792,5476956,
                       1381577,3102049,5894835,1312770),
                V3 = c(564439,845230,381026,300152,
                       717895,470190,762642,103391,585520,726470,965213,
                       1461572,3984260,990528,1411939,1337256,1546011,
                       2581048,2772939,772992,838149,108863,132476,381695,
                       4853434,506558,1488670,1480430,205676,117785,323644,
                       107641,339090,144384,620947,64700,61006,77491,
                       193820,74369,751044,826708,653454,339156,544232,842704,
                       511185,127971,283360,531553,97418),
                V4 = c("19.58%","18.65%","18.55%",
                       "17.10%","16.61%","16.08%","15.98%","15.45%","15.27%",
                       "14.68%","14.62%","14.28%","14.22%","14.12%",
                       "13.98%","13.71%","13.62%","13.58%","13.34%","13.01%",
                       "12.91%","12.81%","12.78%","12.78%","12.58%","12.36%",
                       "11.99%","11.95%","11.94%","11.58%","11.44%",
                       "11.44%","11.11%","11.07%","10.97%","10.78%","10.76%",
                       "10.53%","10.37%","10.34%","10.19%","10.01%","9.85%",
                       "9.78%","9.78%","9.67%","9.33%","9.26%","9.13%",
                       "9.02%","7.42%")
) |> 
  set_names(c("state","pop","pop_poverty",
              "pct_poverty")) |> 
  filter(state != "United States") |>   
  mutate(pct_poverty = str_remove(pct_poverty, "%")) |> 
  mutate(across(c(pop, pop_poverty, pct_poverty), as.numeric))
```


</div>


## {rvest} Example

The {rvest} package is a powerful tool for scraping ('harvesting') data from websites. It is a bit more advanced, but can be very useful if the data are updated frequently on a website, and fresh data are important.

First, make sure that you have loaded the {rvest} package by running the code chunk below.


``` r
library(rvest)
```

The general workflow is to:

1.  Find a website with a useful table of data that is not in a viewport (dynamically generated by javascript - these are ones that you can not select or copy). This is true for most tables, particularly on Wikipedia, and is generally true of any table that you can select to copy.
2.  Copy the URL of the website and put it (in quotes) into the `read_html()` function. Assign this result to an object, like `webpage`.
3.  Use the `html_nodes('table')` function to get a list of the nodes of the html that contain the tabular data you want. Generally, you will get a node for anything that looks like a table with cells on the webpage. Many of these will not be what you want. But if it clearly is a table or a 'wikitable', it will work.
4.  You can then use the `html_table()` function to convert these nodes into a list of data frames.
5.  You can then use the `pluck(N)` function from the {purrr} package to extract the Nth data frame from the list of data frames.

Let's try this out. The URL "<https://en.wikipedia.org/wiki/Health_insurance_coverage_in_the_United_States>" has a table of US states and their health insurance coverage. We can use the {rvest} package to scrape this data.

First, copy the URL of the website, and put it into the `read_html()` function. Assign this result to an object, like `wiki_page`.


``` r
wiki_page <- read_html("https://en.wikipedia.org/wiki/Health_insurance_coverage_in_the_United_States")
```

Next, ask {rvest} to find all the tables on the page. You can do this by using the `html_nodes()` function with the argument `'table'`. Assign this result to an object, like `tables`.


``` r
tables <- wiki_page %>% 
  html_nodes("table")
```

Go ahead and inspect this by clicking on the tables object in the Environment tab. You will see a list of nodes, each of which is a table on the webpage. You can click on the blue arrow to the left of each one to see more detail about the header and body to help determine which one you want. As a general rule, a box or sidebar or 'nowraplinks' are not helpful. But if you see a wikitable with a header and body, that is likely the one you want. In this case, node 5 looks promising. Take a peek at the actual webpage and see if you can figure out what each of the other box, sidebar, or nowraplinks actually are. If you are not sure, you can also convert all of these nodes to tables with `html_table()` and then decide which one you want. Copy and run the code chunk below to help you decide which of the 8 "tables" is useful.


``` r
wiki_page %>% 
  html_nodes("table") |> 
  html_table()
```

```
## [[1]]
## # A tibble: 9 × 1
##   X1                                                        
##   <chr>                                                     
## 1 "This article is part of a series on"                     
## 2 "Healthcare reform in theUnited States"                   
## 3 "History\nDebate"                                         
## 4 "Legislation\nPrecedingSocial Security Amendments of 1965…
## 5 "Reforms\nObama administration proposals\nPublic opinion\…
## 6 "Systems\nFree market\nHealth insurance exchange\nNationa…
## 7 "Third-party payment models\nAll-payer rate setting\nCapi…
## 8 "United States portal Health care portal"                 
## 9 ".mw-parser-output .navbar{display:inline;font-size:88%;f…
## 
## [[2]]
## # A tibble: 9 × 3
##   Year           Number Uninsured (Mil…¹ `Uninsured Percent`
##   <chr>                            <dbl> <chr>              
## 1 2010                              48.2 18.2%              
## 2 2013 (Pre-ACA)                    44.3 16.6%              
## 3 2016                              28.2 10.4%              
## 4 2017                              28.9 10.7%              
## 5 2018                              30.1 11.1%              
## 6 2019                              32.8 12.1%              
## 7 2020                              31.2 11.5%              
## 8 2021                              29.6 11.0%              
## 9 2022H                             27   9.9%               
## # ℹ abbreviated name: ¹​`Number Uninsured (Mil)`
## 
## [[3]]
## # A tibble: 1 × 2
##   X1    X2                                                  
##   <lgl> <chr>                                               
## 1 NA    This section relies largely or entirely upon a sing…
## 
## [[4]]
## # A tibble: 1 × 2
##   X1    X2                                                  
##   <lgl> <chr>                                               
## 1 NA    This section relies largely or entirely upon a sing…
## 
## [[5]]
## # A tibble: 52 × 17
##    Division `1999` `2000` `2001` `2002` `2003` `2004` `2005`
##    <chr>     <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>
##  1 United …   13.6   13.1   13.5   13.9   14.6   14.3   14.6
##  2 Alabama    12     12.5   12.4   12.2   12.5   12     14  
##  3 Alaska     18.3   17.4   14.8   18     17.5   15.3   16.9
##  4 Arizona    19.4   16.4   16.7   16.4   16.4   16.2   19.1
##  5 Arkansas   13.9   14.1   16.4   16.5   17.2   15.9   17.2
##  6 Califor…   19     17.5   18     16.5   17.3   17.5   18  
##  7 Colorado   14.1   12.9   14.6   14.5   15.3   15.2   16.2
##  8 Connect…    7.3    8.9    8.2    8.6    9.4   10.3   10.1
##  9 Delaware    9.7    8.5    8.5    9.2    9.6   13.1   11.6
## 10 Distric…   14     12.8   12.3   13     12.7   12     12.4
## # ℹ 42 more rows
## # ℹ 9 more variables: `2006` <dbl>, `2007` <dbl>,
## #   `2008` <dbl>, `2009` <dbl>, `2010` <dbl>, `2011` <dbl>,
## #   `2012` <dbl>, `2013` <dbl>, `2014` <dbl>
## 
## [[6]]
## # A tibble: 1 × 2
##   X1    X2                                                  
##   <lgl> <chr>                                               
## 1 NA    This section relies largely or entirely upon a sing…
## 
## [[7]]
## # A tibble: 11 × 14
##    vteInsurance   vteInsurance ``    ``    ``    ``    ``   
##    <chr>          <chr>        <chr> <chr> <chr> <chr> <chr>
##  1 "Types of ins… "Health\nAc… Heal… "Acc… Life  "Lon… Busi…
##  2 "Health"       "Accident\n… <NA>   <NA> <NA>   <NA> <NA> 
##  3 "Life"         "Longevity … <NA>   <NA> <NA>   <NA> <NA> 
##  4 "Business"     "Bond\nBusi… <NA>   <NA> <NA>   <NA> <NA> 
##  5 "Residential"  "Boiler\nBu… <NA>   <NA> <NA>   <NA> <NA> 
##  6 "Transport/Co… "Aviation\n… <NA>   <NA> <NA>   <NA> <NA> 
##  7 "Other"        "Reinsuranc… <NA>   <NA> <NA>   <NA> <NA> 
##  8 "Insurance po… "Act of God… <NA>   <NA> <NA>   <NA> <NA> 
##  9 "Insurance by… "Australia\… <NA>   <NA> <NA>   <NA> <NA> 
## 10 "History"      "Mesopotami… <NA>   <NA> <NA>   <NA> <NA> 
## 11 "Category\nLi… "Category\n… <NA>   <NA> <NA>   <NA> <NA> 
## # ℹ 7 more variables: `` <chr>, `` <chr>, `` <chr>,
## #   `` <chr>, `` <chr>, `` <chr>, `` <chr>
## 
## [[8]]
## # A tibble: 6 × 2
##   X1                      X2                                
##   <chr>                   <chr>                             
## 1 Health                  "Accident\nAccidental death and d…
## 2 Life                    "Longevity insurance\nMortgage li…
## 3 Business                "Bond\nBusiness interruption\nBus…
## 4 Residential             "Boiler\nBuilder's risk\nContents…
## 5 Transport/Communication "Aviation\nGAP insurance\nInland …
## 6 Other                   "Reinsurance\nCatastrophe bond\nI…
```

Now we can pluck out table 5, convert it to an html_table, and then convert it to a tibble. We can then use the `set_names()` function to assign the column names, and assign this to a new object, like `data_ins`. Run the code chunk in your local RStudio and take a look at the resulting data_ins object.


``` r
library(tidyverse) 
tables %>% 
  html_table() |> 
  pluck(5) |>  
  as_tibble() |> 
  purrr::set_names(c('state', 1999:2014)) ->
data_ins
```

Open and inspect the `data_ins` object. Note that we brought along a 'United States' weighted summary row from the original web table, which may or may not be something you want. You can use the `filter()` function to remove this row if you want.

## Your Turn

Take a look at the web page at "<https://en.wikipedia.org/wiki/List_of_epidemics_and_pandemics>" to find two interesting tables on pandemics. Inspect this web page a bit. You will see that there are two tables that are of interest (out of 22 nodes identified by `html_nodes()`. The first is on the top 10 pandemics by death toll, and the second contains a long chronology of pandemics. Also, look out for other boxes and sidebars that {rvest} might consider as tables.

Give this a try in your local RStudio, using the instructions below to scrape the 2 interesting tables. Check your solution by clicking on the "Click here to see the solutions" button below.

Use the {rvest} package to scrape these two tables. Read the html from the URL and assign the result to an object called `wiki_pandemic`. Use the `html_nodes()` function with the argument `'table'` to find all the tables on the page. Use the `html_table()` function to convert this node into a list of data frames. Use the `pluck()` function to pick out the table you want (scrape these one at a time). Use the `as_tibble()` function to convert these data frames into tibbles. Use the `set_names()` or `janitor::clean_names()` function to assign the column names. Then scrape the second (chronology) table. Assign these to the objects `pandemic_data` and `chron_pandemics`.


<div class='webex-solution'><button>Click here to see the solutions</button>



``` r
wiki_pandemic <- read_html("https://en.wikipedia.org/wiki/List_of_epidemics_and_pandemics")

wiki_pandemic %>% 
  html_nodes("table") %>% 
  pluck(1) |>  
  html_table() |> 
  as_tibble() |> 
  purrr::set_names(c('rank', 'epidemic', 'disease', 'death_toll', 'percent_lost', 'years', 'location')) ->
pandemic_data

wiki_pandemic %>% 
  html_nodes("table") %>% 
  pluck(2) |>  
  html_table() |> 
  as_tibble() |> 
  janitor::clean_names() ->
chron_pandemics
```


</div>


## API example with {tidycensus}

An API (Application Programming Interface) is a way to access data from a website. The data are generally in a structured format, like JSON or XML, and can be accessed by sending a request to a URL. The {httr} package is a powerful (general) tool for working with APIs. Folks who use a particular API often find it easier to make custom functions to access the data, and when generally useful, share these in an R packages. The {tidycensus} package is a wrapper around the US Census API that makes it easier to access data from the US Census. Kyle Walker, a Professor of Geography at Texas A&M, created and maintains this package.

To use {tidycensus}, you need to sign up for a (free) API KEY from the US Census bureau. The [**tidycensus website**](https://walker-data.com/tidycensus/articles/basic-usage.html) has instructions on how to do this. Once you have your API key, you can use the `census_api_key()` function to set your API key in your R environment. You only need to do this once.

For each of the thousands of variables collected by the US Census Bureau, you can get an estimate and a margin of error (MOE) by the geographical division you request (from national down to census block). The {tidycensus} package makes it easy to get these estimates and margins of error for a given geography. The `get_acs()` function is the workhorse of the package. It takes a geography, a list of variables, and a year as arguments, and returns a tibble with the estimates and margins of error for each variable from the American Community Survey (ACS).

Note that the variables have icky names (`variable ids`) like "P001001" for total population. Finding the variables you want can be a bit of a project. See section 2.3 of the TidyCensus book **[here]**(<https://walker-data.com/census-r/an-introduction-to-tidycensus.html>) for strategies on how to load the list of variables into a dataset and then search for the concepts (income, population, etc) that you want. The Census Bureau explainer on variable ids can be found **[here]**(<https://www.census.gov/content/dam/Census/library/publications/2021/acs/acs_summary_file_handbook_2021_ch03.pdf>)

Explore the tidycensus webpage a bit, especially the articles tab. This can be very helpful if you have US health data divided by a geographical unit. You may also want to map these data, and the {tigris} and {mapgl} packages can help you with that.

We will save the deep dive on these for a later chapter.

## Challenges

Try to use the {datapasta} or the {rvest} approaches on the following webpages:

1.  [**life_expectancy by county**](https://en.wikipedia.org/wiki/List_of_countries_by_life_expectancy)

2.  [**hospital beds data by county**](https://en.wikipedia.org/wiki/List_of_countries_by_hospital_beds)

3.  [**gun deaths by state**](https://en.wikipedia.org/wiki/Gun_death_and_violence_in_the_United_States_by_state)

4.  [**COVID Deaths by City**](http://www.citymayors.com/coronavirus/us-cities-covid-19-cases-2.html)

5.  [**US state population data**](https://en.wikipedia.org/wiki/List_of_U.S._states_and_territories_by_population)

6.  [**US state GDP data**](https://en.wikipedia.org/wiki/List_of_U.S._states_and_territories_by_GDP)
