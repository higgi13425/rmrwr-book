 trial %>% 
   select(trt, age, marker, stage, grade) %>% 
   tbl_summary(
     by = trt,
     statistic = list(all_continuous() ~ "{mean} ({sd})",
       all_categorical() ~ "{n} / {N} ({p}%)"),
     digits = all_continuous() ~ 2,
     label = grade ~ "Tumor Grade",
     missing_text = "(Missing)") %>% 
   add_overall() %>% 
   add_n() %>% 
  add_stat_label() %>% 
   add_p()
