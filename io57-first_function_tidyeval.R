# writing a function for a Drob plot
library(tidyverse)
library(purrr)

#simple math function

# type in fun, hit return - get function skeleton
#try this out yourself
name <- function(variables) {

}

cels_to_fahr <- function(cels_temp) {
  temp_F <- cels_temp * 9/5 + 32
  return(temp_F)
}

#try out the function, one value at a time
cels_to_fahr(10)
cels_to_fahr(20)
cels_to_fahr(30)

# try miles to km
miles_to_km <- function(miles) {
  miles*8/5
}

miles_to_km(100)

# your turn
# try meters to feet (* 3.28)

meters_to_feet <- function(meters) {
  meters*3.28
}

meters_to_feet(20)


# now run these functions over multiple values
# start with cels_to_fahr

#vector of celsius temps
temp_vec <- c(-15, -5, 5, 15, 25, 35, 45)

# let's run this function over all of them,
# with purrr package function, `map`
# using the map_dbl version, which will return only dbl numbers
map_dbl(temp_vec, cels_to_fahr)


# Okay, now try this with the miles_to_km function

miles_vec <- c(20, 50, 80, 150, 300)

map_dbl(miles_vec, miles_to_km)
# note that this would also work if miles_vec
# were a column in a dataframe


# Your turn - use your meters_to_feet function

vec_meters <- c(25, 50, 100, 400, 800)


# In the tidyverse, things get a bit more complicated.
# Nonstandard evaluation means you need to slow down evaluation
# of variables with curly-curly {{var}}
# or the .data[[var]] pronoun construction

# Basic Drob Plot
# to get a look at counts of categorical variables

load('OPT_Study_PersonLevel_Data.Rdata')
head(opt)

opt %>%
  count(Clinic) %>%
  mutate(Clinic = fct_reorder(Clinic, n)) %>%
  ggplot(aes(Clinic, n, fill= Clinic)) +
  geom_col() +
  coord_flip() +
  theme_minimal() +
  scale_fill_brewer() +
  theme(legend.position = 'none')


# now as a function - type in fun, hit return - get skeleton
drob_plot <- function(data, catvar) {
  data %>%
    count({{catvar}}) %>%
    mutate({{catvar}} := fct_reorder({{catvar}}, n)) %>%
    ggplot(aes({{catvar}}, n, fill := {{catvar}})) +
    geom_col() +
    coord_flip() +
    theme_minimal() +
    scale_fill_brewer() +
    theme(legend.position = 'none')
}

drob_plot(opt, Clinic)
drob_plot(opt, Use.Tob)


# now for multiples - works better with .data pronoun
# works better with purrr
drob_plot_mult <- function(data, catvar) {
  data %>%
    count(.data[[catvar]]) %>%
    mutate({{catvar}} := fct_reorder(.data[[catvar]], n)) %>%
    ggplot(aes(.data[[catvar]], n, fill = .data[[catvar]])) +
    geom_col() +
    coord_flip() +
    theme_minimal() +
    scale_fill_brewer() +
    theme(legend.position = 'none')
}

#make a vector of the categorical variables
vars <- c('Birth.outcome' , 'Use.Tob' ,
          'UTI', 'Gest.diab')

map(vars, ~drob_plot_mult(data = opt, catvar = .x))









### example with mtcars
library(tidyverse)
data(mtcars)

my_graph_single <- function(data, groupvar){
  data %>%
    group_by(vs, {{groupvar}}, am) %>%
    summarise(n=n()) %>%
    mutate(sum = sum(n)) %>%
    rowwise %>%
    mutate(xx = list(broom::tidy(prop.test(n, sum, conf.level=0.95)))) %>%
    unnest(xx) %>%
    ggplot() +
    geom_bar(aes(x=factor(vs), y=estimate, fill={{groupvar}}), stat = "identity") +
    geom_errorbar(aes(x=factor(vs), ymin=conf.low, ymax = conf.high), width = 0.2) +
    scale_y_continuous(labels = scales::percent_format(accuracy = 1)) +
    facet_wrap(vars({{groupvar}}))+
    theme(legend.position = "none")
}

my_graph_single(data = mtcars, groupvar = gear)


my_graph_mult <- function(data, groupvar){
  data %>%
    group_by(vs, .data[[groupvar]], am) %>%
    summarise(n=n()) %>%
    mutate(sum = sum(n)) %>%
    rowwise %>%
    mutate(xx = list(broom::tidy(prop.test(n, sum, conf.level=0.95)))) %>%
    unnest(xx) %>%
    ggplot() +
    geom_bar(aes(x=factor(vs), y=estimate, fill=.data[[groupvar]]), stat = "identity") +
    geom_errorbar(aes(x=factor(vs), ymin=conf.low, ymax = conf.high), width = 0.2) +
    scale_y_continuous(labels = scales::percent_format(accuracy = 1)) +
    facet_wrap(vars(.data[[groupvar]]))+
    theme(legend.position = "none")
}

plot_vars <- mtcars %>%
  select(am, gear, carb) %>%
  names()

# plot multiples
map(.x = plot_vars, .f = ~my_graph_mult(data = mtcars, groupvar = .x))
# does not work with curly curly version of function,
# does work with .data pronoun version

#plot single
my_graph_single(data= mtcars, groupvar = am)
# does not work with .data pronoun version,
# does work with curly curly version

