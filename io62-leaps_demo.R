library(leaps)
library(tidyverse)
library(readxl)
library(broom)
library(MASS)
bwt_df<- birthwt
bwt_df$race <- factor(bwt_df$race, labels = c("white", "black", "other"))
bwt_df$ptd <- factor(bwt_df$ptl >0)
bwt_df$ftv <- factor(bwt_df$ftv)
levels(bwt_df$ftv)[-(1:2)] <- "2+"
bwt_df$low = factor(bwt_df$low)
bwt_df$smoke = (smoke>0)
bwt_df$ht = (bwt_df$ht>0)
bwt_df$ui = (bwt_df$ui>0)
pred <- dplyr::select(bwt_df, -bwt) %>% as.matrix()
model <- glm(low  ~ ., binomial, data = bwt_df)
tidy(model)

leaps(x=pred, y=bwt_df$bwt, int=TRUE, method = "Cp")
