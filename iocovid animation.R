library(tidyverse)
library(shadowtext)
library(gganimate)
library(gifski)

options(scipen = 20)
read_csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Confirmed.csv") %>%
  gather(date, cases, 5:ncol(.)) %>%
  mutate(date = as.Date(date, "%m/%d/%y")) %>%
  group_by(country = `Country/Region`, date) %>%
  summarise(cases = sum(cases)) %>%
  filter(country != "Others" & country != "Mainland China") %>%
  bind_rows(
    tibble(country = "Republic of Korea", date = as.Date("2020-03-11"), cases = 7755)
  ) %>%
  group_by(country) %>%
  mutate(days_since_100 = as.numeric(date-min(date[cases >= 100]))) %>%
  ungroup() %>%
  filter(is.finite(days_since_100)) %>% 
  group_by(country) %>%
  mutate(new_cases = cases-cases[days_since_100 == 0]) %>%
  filter(sum(cases >= 100) >= 5) %>%
  filter(cases >= 100) %>% 
  bind_rows(
    tibble(country = "33% daily rise", days_since_100 = 0:18) %>%
      mutate(cases = 100*1.33^days_since_100)
  ) %>% 
  ungroup() %>%
  mutate(
    country = country %>% str_replace_all("( SAR)|( \\(.+)|(Republic of )", "")
  ) %>% 
  # filter(days_since_100 <= 10) %>%
  ggplot(aes(days_since_100, cases, col = country)) +
  geom_hline(yintercept = 100) +
  geom_vline(xintercept = 0) +
  geom_line(size = 0.8) +
  geom_point(pch = 21, size = 1) +
  scale_y_log10(expand = expand_scale(add = c(0,0.1)), breaks=c(100, 200, 500, 1000, 2000, 5000, 10000,100000)) +
  # scale_y_continuous(expand = expand_scale(add = c(0,100))) +
  scale_x_continuous(expand = expand_scale(add = c(0,1))) +
  theme_minimal() +
  theme(
    panel.grid.minor = element_blank(),
    legend.position = "none",
    plot.margin = margin(3,15,3,3,"mm")
  ) +
  coord_cartesian(clip = "off") +
  scale_colour_manual(values = c("United Kingdom" = "#ce3140", "US" = "#EB5E8D", "Italy" = "black", 
          "France" = "#c2b7af", "Germany" = "#c2b7af", "Hong Kong" = "blue", 
          "Iran" = "springgreen3", "Japan" = "royalblue3", "Singapore" = "blue", 
          "Korea, South" = "slateblue3", "Belgium" = "#c2b7af", "Netherlands" = "#c2b7af", 
          "Norway" = "#c2b7af", "Spain" = "#c2b7af", "Sweden" = "#c2b7af", 
          "Switzerland" = "#c2b7af", "33% daily rise" = "gray35", "Austria" = "#c2b7af",
          "China" = 'red', "Cruise Ship" = 'purple')) +
  #geom_shadowtext(aes(label = paste0(" ",country)), hjust=0, vjust = 0, data = . %>% 
                    #group_by(country) %>% 
                    #top_n(1, days_since_100), bg.color = "white") +
  labs(x = "Number of days since 100th case", y = "",
       title = "Total number of COVID-19 Cases per Country"       ) +
  geom_segment(aes(xend = 48, yend = cases), linetype = 2, colour = 'grey') + 
  geom_point(size = 2) + 
  geom_text(aes(x = 48.1, label = country), hjust = 0) ->
static_plot

plt <- static_plot +
  transition_reveal(days_since_100) +
  ease_aes('cubic-in-out') +
  labs(subtitle = "Starting at Day on which 100th Case Occurred")

#rendering the animation for gif
final_animation <- animate(plt, nframes = 100, fps = 10,
                         #duration = 30, 
                         width = 600, 
                         height = 400, renderer = gifski_renderer())

#saving the animation
anim_save('covid_animate.gif', animation = final_animation)
