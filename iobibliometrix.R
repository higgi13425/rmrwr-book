## from https://cran.r-project.org/web/packages/bibliometrix/vignettes/bibliometrix-vignette.html

library(bibliometrix)
#read a bibtex file saved from Web of Science
D <- readFiles("H:/My Documents/BibliometricsR/savedrecs (3).bib")
M <- convert2df(D, dbsource = "isi", format = "bibtex")


#read a bibtex file exported from Scopus
D <- readFiles("H:/My Documents/BibliometricsR/scopus.bib")
M <- convert2df(D, dbsource = "scopus", format = "bibtex")

#now look at results
results <- biblioAnalysis(M, sep = ";")

S=summary(object = results, k = 10, pause = FALSE)

plot(x = results, k = 10, pause = FALSE)


CR <- citations(M, field = "article", sep = ".  ")
CR$Cited[1:10]

CR <- citations(M, field = "author", sep = ".  ")
CR$Cited[1:10]

DF <- dominance(results, k = 10)
DF

indices <- Hindex(M, authors="HIGGINS P", sep = ";",years=10)

# Bornmann's impact indices:
indices$H


L <- lotka(results)

# Author Productivity. Empirical Distribution
L$AuthorProd
L$Beta



A <- cocMatrix(M, Field = "SO", sep = ";")

NetMatrix <- biblioNetwork(M, analysis = "coupling", network = "authors", sep = ";")
S <- couplingSimilarity(NetMatrix, type="jaccard")
net=networkPlot(S, n = 20, Title = "Authors' Coupling", type = "fruchterman", size=FALSE,remove.multiple=TRUE)


NetMatrix <- biblioNetwork(M, analysis = "co-occurrences", network = "keywords", sep = ";")

# Plot the network
net=networkPlot(NetMatrix, n = 20, Title = "Keyword Co-occurrences", type = "kamada", size=T)


CS <- conceptualStructure(M,field="ID", minDegree=4, k.max=5, stemming=FALSE)


library(dplyr)
library(tidytext)
library(tidyverse)
#start with titles
M %>% select(TI ) -> ti

tidytitles <- ti %>% tidytext::unnest_tokens(word, TI)

#work on abstracts
M %>% select(AB) -> ab

tidyabstracts <- ab %>% tidytext::unnest_tokens(word, AB)

stopwords <- data.frame("word" = c("1", "95", "2", "5", "ci", "6", "10", "NA", "rr", "3", "2015", "2016", "4"))
data(stop_words)
cleaned_abstracts <- tidyabstracts %>%
  anti_join(stop_words) %>%
  anti_join(stopwords)

cleaned_abstracts %>% count(word, sort=TRUE)

cleaned_abstracts  %>%
  count(word, sort = TRUE) %>%
  filter (n >35) %>% 
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n)) +
  geom_col() +
  xlab(NULL) +
  coord_flip()


#make word cloud
#set up colors
#official michican colors at http://med.umich.edu/branding/color.html
# andy grogan-kaylor michigan colors at http://www.rpubs.com/agrogan/213454 

michigan_blues=c("#174992", # South U Blue
                  "#21c1bc", # taubman teal
                  "#465E85", # gray blue
                  "#7207a5", # ann arbor amethyst
                  "#20657E", # teal
                  "#2878ba", # arboretum blue
                  "#514E86", # matthei violet
                  "#00274c") # blue

michigan_colors=c("#00274c", # blue
                  "#ffcb05", # maize
                  "#a4270b", # tappan red
                  "#e96300", # ross school orange
                  "#beb300", # wave field green
                  "#21c1bc", # taubman teal
                  "#2878ba", # arboretum blue
                  "#7207a5") # ann arbor amethyst

#libraries
library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")
#count frequency, put in tdm
tdm<-cleaned_abstracts  %>%
  count(word, sort = TRUE) %>%
  filter (n >10)  


wordcloud(words = tdm$word, freq = tdm$n, 
          min.freq=11, max.words=200, random.order=FALSE,
          scale = c(4.5,0.5), use.r.layout=FALSE, 
          rot.per=0.30, colors= michigan_blues)

