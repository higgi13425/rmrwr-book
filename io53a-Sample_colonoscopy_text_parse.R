#IBD Colonoscopy results
# retrieved colonscopy data from HSDW (most data w/in text blob "LAB_RESULT_STRING_VALUE")
#note: path report formatting changed June 2013

library(tidyverse)
library(modelr)
library(dplyr)
library(tidyr)
library(stringr)
library(lubridate)
library (sqldf)

#example use UC_BIOPSY_ALL_2018.csv


df2 <- NULL

df <- read.csv(file.choose(),  sep = ",", stringsAsFactors=FALSE, strip.white = TRUE) 
df2 <- sqldf('Select * from df where LAB_RESULT_STRING_VALUE like "%colon%"')
  
  
#extract accession #
loc <- str_locate(df2$LAB_RESULT_STRING_VALUE, "Order Number:   ")
df2$access <- str_sub(df2$LAB_RESULT_STRING_VALUE, start = loc[,2] )
df2$access <- str_sub(df2$access, start = 3, end = 18) 

#strip boilerplate
loc <- str_locate(df2$LAB_RESULT_STRING_VALUE, "  Laboratory Accrediting Agency") #delete QA boilerplate;
loc2 <- ifelse(is.na(loc[,1]), 4000, loc[,1] ) # for extra-long reports
df2$text <- str_sub(df2$LAB_RESULT_STRING_VALUE, start = 1, end = loc2)

#Diagnosis
loc <- str_locate(df2$text, "Diagnosis: ")
loc2 <-str_locate (df2$text, " Signing Pathologist")
df2$dx <- str_sub(df2$text, start = loc[,2], end = loc2[,1])

#History
loc <- str_locate(df2$text, "History: ")
loc2 <-str_locate (df2$text, " Gross Description")
df2$hx <- str_sub(df2$text, start = loc[,2], end = loc2[,1])

#Procedure
loc <- str_locate(df2$text, " Procedure: ")
loc2 <-str_locate (df2$text, " Indications")
df2$procedure <- str_sub(df2$text, start = loc[,2], end = loc2[,1])

#Indications
loc <- str_locate(df2$text, "Indications: ")
loc2 <-str_locate (df2$text, " Gross Description")
df2$indications <- str_sub(df2$text, start = loc[,2], end = loc2[,1])

#Gross Description
loc <- str_locate(df2$text, "Gross Description: ")
loc2 <-str_locate (df2$text, " Electronically Signed ")
df2$gross <- str_sub(df2$text, start = loc[,2], end = loc2[,1])

#Date Received:   12/29/2017
loc <- str_locate(df2$text, "Date Received: ")
loc2 <-str_locate (df2$text, " Date Completed: ")
df2$date_recd <- str_sub(df2$text, start = loc[,2], end = loc2[,1])
df2$year <- year(as.Date(df2$date_recd, format = "%m/%d/%Y"))

savename = "UC_biopsy_test_"  #change 
savename = paste0 (savename, today(), ".csv")
write.csv(df2, savename)
