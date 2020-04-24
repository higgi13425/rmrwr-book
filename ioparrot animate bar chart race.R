#bar chart race
library(tidyverse)
library(hrbrthemes)
library(gganimate)
library(gifski)
library(readxl)

# guides on how to animate bar charts at
# https://emilykuehler.github.io/bar-chart-race/
# https://michaeltoth.me/how-to-create-a-bar-chart-race-in-r-mapping-united-states-city-population-1790-2010.html
# https://towardsdatascience.com/how-to-do-that-animated-race-bar-chart-57f3a8ff27a8
# https://towardsdatascience.com/create-animated-bar-charts-using-r-31d09e5841da

# import data
demand <- read_xlsx('US Demand Parrot Analytics.xlsx')

# wrangle data in ranks
graph_data <- demand %>%
  group_by(Week) %>%
  mutate(rank = rank(-demand_expressions),
         Value_rel = demand_expressions/demand_expressions[rank==1],
         Value_lbl = paste0(" ",round(demand_expressions/1e6))) %>%
  ungroup()



#Create Static Bar Chart

staticplot = ggplot(graph_data,
            aes(rank, group = Show,
             fill = as.factor(Show), color = NULL)) +
  geom_tile(aes(y = demand_expressions/2,
                height = demand_expressions,
                width = 0.9), alpha = 0.7, color = NA) +
  geom_text(aes(label = paste(" ", Show), y = demand_expressions),
            color = 'black',
            hjust = "right", fontface = 'bold',
            size = 12) +
  geom_text(aes(y=demand_expressions, label = Value_lbl),
                hjust='left', nudge_y = 10,
            color= 'black',
            size = 10) +
  coord_flip(clip = 'off', expand = TRUE) +
  scale_y_continuous(labels = scales::comma) +
  scale_x_reverse() +
  guides(color = FALSE, fill = FALSE) +
  theme(axis.line=element_blank(),
        axis.text.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        legend.position="none",
        panel.background=element_blank(),
        panel.border=element_blank(),
        panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),
        panel.grid.major.x = element_line( size=.3, color="grey" ),
        panel.grid.minor.x = element_line( size=.3, color="grey" ),
        plot.title=element_text(size=30,  face="bold", colour="black", vjust=3),
        plot.subtitle=element_text(size=28, face="italic", color="black"),
        plot.caption =element_text(size=40, hjust=0.6,  color="black"),
        plot.margin= unit(c(1,2,1,10),"cm"),
        plot.background=element_blank())



# Now animate
anim = staticplot +
  transition_states(Week, wrap = FALSE,
    transition_length = 4, state_length = 2) +
  view_follow(fixed_x = TRUE)  +
  labs(title = '2019 Was The Year of Game of Thrones and Stranger Things \nWeek : {closest_state}',
       subtitle = 'Data from Parrot Analytics',
       caption  = "US Demand Expressions in Millions")  +
  ease_aes('cubic-in-out') +
  enter_fade() +
  exit_shrink()

#render
animate(anim, nframes = 318, fps = 20,
        width = 1200, height = 900,
        start_pause = 10, end_pause = 23,
        renderer = gifski_renderer("gganim.gif"))
