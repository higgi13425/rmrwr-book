library(tidyverse)
library(flextable)
library(broom)
library(here)
library(readxl)
library(kableExtra)

df <- read_excel(here::here("MST-41.xlsx"), sheet = "gross", skip =4)

#clean up names
names(df) <- c('rx', 'mouse_num', 'group', 'length','junk', 'gross_wt',
               'tare', 'colon_wt', 'junk1', 'junk2', 'junk3', 'junk4',
               'junk5', 'junk6', 'junk7', 'body_wt', 'junk8','junk9',
               'junk10','junk11','junk12')

#select, filter, mutate
df <- df %>% select(-starts_with('junk'), -gross_wt, -tare) %>%
  filter(!is.na(length)) %>%
  mutate(colon_density = colon_wt/length,
         colon_fraction = colon_wt/body_wt)

# do a t test, get results into a df with broom::tidy
t12 <- tidy(with(df, t.test(colon_wt[group==1], colon_wt[group==2])))
t13 <- tidy(with(df, t.test(colon_wt[group==1], colon_wt[group==3])))
t34 <- tidy(with(df, t.test(colon_wt[group==3], colon_wt[group==4])))
t35 <- tidy(with(df, t.test(colon_wt[group==3], colon_wt[group==5])))

table <- bind_rows(t12, t13, t34, t35)

table$test <- c('un vs drug control', 'un vs S. typh',
                'S. typh vs. low dose ABT263',
                'S. typh vs. high dose ABT263')

table <- table %>% select(test, estimate, p.value) %>%
  rename("Comparison" = test,
          "Mean weight difference (g)" = estimate,
          "p value" = p.value)

knitr::kable(table)

table
