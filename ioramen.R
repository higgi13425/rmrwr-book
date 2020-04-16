library(tidyverse)
library(DataExplorer)
library(janitor)

# ramen ratings
ramen_ratings <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-06-04/ramen_ratings.csv")


plot_bar(ramen_ratings)
ramen_ratings %>% 
  mutate(style = as_factor(fct_lump(style, 6))) %>% 
  mutate(country = as_factor(fct_lump(country, 15))) %>% 
  mutate(brand = as_factor(fct_lump(brand, 40))) ->
ramen_ratings

plot_histogram(ramen_ratings$stars^2)
plot_histogram(ramen_ratings$stars^2)

ramen_ratings %>% 
  group_by(country) %>% 
  summarize(stars = round(mean(stars), digits=2)) %>% 
  arrange(desc(stars)) %>% 
  slice(1:12) %>% 
  ggplot(aes(x = fct_reorder(country, stars), y = stars, fill=stars)) +
  geom_bar(stat="identity") +
  geom_text(aes(label = stars), nudge_y = 0.13) +
  geom_text(aes(label = country, y=0.1), hjust=0) +
  ylim(0,5) +
  scale_fill_gradient(low = "darkgoldenrod", high = "gold", guide = "none") +
  labs(title = "Top Ramen",
       subtitle = "Average Ramen Ratings by Country",
       x = "",
       y = "Average Ratings on a 5 Star Scale",
       caption = "Data from TidyTuesday") +
  theme_bw(base_size = 14) +
  theme(axis.text.y  = element_blank(),
        axis.ticks.y = element_blank()) +
  coord_flip()


ramen_ratings %>% 
  group_by(brand ) %>% 
  ggplot(aes(x=fct_reorder(brand, stars), y=stars, color=stars)) +
  geom_violin() +
  coord_flip()

ramen_ratings %>% 
  group_by(style) %>% 
  filter(style %in% c("Cup", "Bowl", "Tray", "Box", "Pack")) %>% 
  ggplot(aes(x=fct_reorder(style, stars), y=stars, color=stars)) +
  geom_violin(alpha=0.1) +
  geom_jitter(alpha=0.4) +
  labs(title = "Which is the Best Ramen?",
       subtitle = "Hint: buy the box",
       x = "Style of Package",
       y = "Stars" ,
       caption = "Data from TidyTuesday") +
  scale_color_continuous(guide = "none") +
  theme_minimal(base_size = 14)

ramen_ratings %>% 
  group_by(style) %>% 
  summarize(stars = mean(stars)) %>% 
  arrange(desc(stars))

summary(lm( stars ~ style + country, data = ramen_ratings))
