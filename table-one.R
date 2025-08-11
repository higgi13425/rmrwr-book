# Section One -----

trial %>%
  select(trt, age, marker, stage, grade)

# Section Two =============


trial %>%
  select(trt, age, marker, stage, grade) %>%
  add_overall() %>%
  add_n() %>%
  add_stat_label() %>%
  add_p()
