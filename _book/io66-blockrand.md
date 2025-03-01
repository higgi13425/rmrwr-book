---
title: "Randomization with blockrand in R"
author: "Peter Higgins"
date: "4/22/2021"
output: html_document
---



# Randomization for Clinical Trials with R

There are a number of packages for doing key functions for clinical trials in R. You can find many of these on the CRAN Task View for Clinical Trials, at <https://cran.r-project.org/web/views/ClinicalTrials.html>.

This is a curated list of packages that anyone might find useful in designing, monitoring, or analyzing clinical trials, and is often a good place to start in looking for packages that might be relevant for clinical trials.

If you use `Ctrl-F` to search the web page for "rand", several packages address randomization, including

-   blockrand

-   randomizeR

-   pwr

-   experiment

-   clusterPower

-   CRTSize

-   cosa

-   PowerupR

Several of these are specifically for more complex designs, including cluster and multilevel randomization (clusterPower, cosa, CRTSize). For today, we will focus on the straightforward randomization packages including {blockrand} and {randomizer}. The {blockrand} package creates randomizations for clinical trials with can include stratified enrollment and permuted block randomization, and can produce a PDF file of randomization cards.

Let's start with an example in {blockrand}.

Details on the package can be found at <https://cran.r-project.org/web/packages/blockrand/blockrand.pdf>

or by running `help(blockrand)` in your Console.

You want to randomize 180 inpatients with severe ulcerative colitis to one of 3 arms: corticosteroids alone (control), corticosteroids + tofacitinib, or corticosteroids + upadacitinib. You want to stratify the participants by (1) prior biologic failure and (2) Albumin level above or below 3.0. To be prepared for dropouts and imbalanced enrollment, you want to have a randomization list with at least 60 assignments available for each arm and stratum. To avoid a recognizable pattern in the randomization, you want to have a permuted block design with blocks of sizes 3, 6, and 9.\
Below, you will see how to do this for the biologic failure - low albumin stratum.


``` r
bfla <- blockrand(n = 60, 
                     num.levels = 3, # three treatments
                     levels = c("CS", "CS/Tofa", "CS/Upa"), # arm names
                     stratum = "Bfail.LowAlb", # stratum name
                     id.prefix = "BfLA", # stratum abbrev
                     block.sizes = c(1,2,3), # times arms = 3,6,9
                     block.prefix = "BfLA") # stratum abbrev
bfla
```

```
##        id      stratum block.id block.size treatment
## 1  BfLA01 Bfail.LowAlb   BfLA01          9    CS/Upa
## 2  BfLA02 Bfail.LowAlb   BfLA01          9        CS
## 3  BfLA03 Bfail.LowAlb   BfLA01          9    CS/Upa
## 4  BfLA04 Bfail.LowAlb   BfLA01          9    CS/Upa
## 5  BfLA05 Bfail.LowAlb   BfLA01          9   CS/Tofa
## 6  BfLA06 Bfail.LowAlb   BfLA01          9        CS
## 7  BfLA07 Bfail.LowAlb   BfLA01          9   CS/Tofa
## 8  BfLA08 Bfail.LowAlb   BfLA01          9        CS
## 9  BfLA09 Bfail.LowAlb   BfLA01          9   CS/Tofa
## 10 BfLA10 Bfail.LowAlb   BfLA02          9   CS/Tofa
## 11 BfLA11 Bfail.LowAlb   BfLA02          9   CS/Tofa
## 12 BfLA12 Bfail.LowAlb   BfLA02          9    CS/Upa
## 13 BfLA13 Bfail.LowAlb   BfLA02          9        CS
## 14 BfLA14 Bfail.LowAlb   BfLA02          9        CS
## 15 BfLA15 Bfail.LowAlb   BfLA02          9   CS/Tofa
## 16 BfLA16 Bfail.LowAlb   BfLA02          9        CS
## 17 BfLA17 Bfail.LowAlb   BfLA02          9    CS/Upa
## 18 BfLA18 Bfail.LowAlb   BfLA02          9    CS/Upa
## 19 BfLA19 Bfail.LowAlb   BfLA03          9        CS
## 20 BfLA20 Bfail.LowAlb   BfLA03          9   CS/Tofa
## 21 BfLA21 Bfail.LowAlb   BfLA03          9    CS/Upa
## 22 BfLA22 Bfail.LowAlb   BfLA03          9   CS/Tofa
## 23 BfLA23 Bfail.LowAlb   BfLA03          9    CS/Upa
## 24 BfLA24 Bfail.LowAlb   BfLA03          9        CS
## 25 BfLA25 Bfail.LowAlb   BfLA03          9   CS/Tofa
## 26 BfLA26 Bfail.LowAlb   BfLA03          9    CS/Upa
## 27 BfLA27 Bfail.LowAlb   BfLA03          9        CS
## 28 BfLA28 Bfail.LowAlb   BfLA04          6        CS
## 29 BfLA29 Bfail.LowAlb   BfLA04          6   CS/Tofa
## 30 BfLA30 Bfail.LowAlb   BfLA04          6    CS/Upa
## 31 BfLA31 Bfail.LowAlb   BfLA04          6    CS/Upa
## 32 BfLA32 Bfail.LowAlb   BfLA04          6        CS
## 33 BfLA33 Bfail.LowAlb   BfLA04          6   CS/Tofa
## 34 BfLA34 Bfail.LowAlb   BfLA05          3        CS
## 35 BfLA35 Bfail.LowAlb   BfLA05          3   CS/Tofa
## 36 BfLA36 Bfail.LowAlb   BfLA05          3    CS/Upa
## 37 BfLA37 Bfail.LowAlb   BfLA06          6        CS
## 38 BfLA38 Bfail.LowAlb   BfLA06          6    CS/Upa
## 39 BfLA39 Bfail.LowAlb   BfLA06          6        CS
## 40 BfLA40 Bfail.LowAlb   BfLA06          6    CS/Upa
## 41 BfLA41 Bfail.LowAlb   BfLA06          6   CS/Tofa
## 42 BfLA42 Bfail.LowAlb   BfLA06          6   CS/Tofa
## 43 BfLA43 Bfail.LowAlb   BfLA07          3   CS/Tofa
## 44 BfLA44 Bfail.LowAlb   BfLA07          3        CS
## 45 BfLA45 Bfail.LowAlb   BfLA07          3    CS/Upa
## 46 BfLA46 Bfail.LowAlb   BfLA08          3   CS/Tofa
## 47 BfLA47 Bfail.LowAlb   BfLA08          3        CS
## 48 BfLA48 Bfail.LowAlb   BfLA08          3    CS/Upa
## 49 BfLA49 Bfail.LowAlb   BfLA09          6    CS/Upa
## 50 BfLA50 Bfail.LowAlb   BfLA09          6   CS/Tofa
## 51 BfLA51 Bfail.LowAlb   BfLA09          6   CS/Tofa
## 52 BfLA52 Bfail.LowAlb   BfLA09          6        CS
## 53 BfLA53 Bfail.LowAlb   BfLA09          6        CS
## 54 BfLA54 Bfail.LowAlb   BfLA09          6    CS/Upa
## 55 BfLA55 Bfail.LowAlb   BfLA10          6    CS/Upa
## 56 BfLA56 Bfail.LowAlb   BfLA10          6        CS
## 57 BfLA57 Bfail.LowAlb   BfLA10          6   CS/Tofa
## 58 BfLA58 Bfail.LowAlb   BfLA10          6        CS
## 59 BfLA59 Bfail.LowAlb   BfLA10          6   CS/Tofa
## 60 BfLA60 Bfail.LowAlb   BfLA10          6    CS/Upa
```

You can see the `id` for each participant, their `stratum`, the `block.id` for their permuted block, the `block.size`, and their assigned `treatment`. You can imagine this as a randomization list, or as assignments that you could print out on cards and seal in security envelopes for the time of randomization. Of course, this is only one of our four strata. We should do the same for the 3 other strata.


``` r
bfha <- blockrand(n = 60, 
                     num.levels = 3, # three treatments
                     levels = c("CS", "CS/Tofa", "CS/Upa"), # arm names
                     stratum = "Bfail.HiAlb", # stratum name
                     id.prefix = "BfHA", # stratum abbrev
                     block.sizes = c(1,2,3), # times arms = 3,6,9
                     block.prefix = "BfHA") # stratum abbrev
bfha
```

```
##        id     stratum block.id block.size treatment
## 1  BfHA01 Bfail.HiAlb    BfHA1          3    CS/Upa
## 2  BfHA02 Bfail.HiAlb    BfHA1          3        CS
## 3  BfHA03 Bfail.HiAlb    BfHA1          3   CS/Tofa
## 4  BfHA04 Bfail.HiAlb    BfHA2          9        CS
## 5  BfHA05 Bfail.HiAlb    BfHA2          9    CS/Upa
## 6  BfHA06 Bfail.HiAlb    BfHA2          9   CS/Tofa
## 7  BfHA07 Bfail.HiAlb    BfHA2          9        CS
## 8  BfHA08 Bfail.HiAlb    BfHA2          9   CS/Tofa
## 9  BfHA09 Bfail.HiAlb    BfHA2          9    CS/Upa
## 10 BfHA10 Bfail.HiAlb    BfHA2          9        CS
## 11 BfHA11 Bfail.HiAlb    BfHA2          9   CS/Tofa
## 12 BfHA12 Bfail.HiAlb    BfHA2          9    CS/Upa
## 13 BfHA13 Bfail.HiAlb    BfHA3          9    CS/Upa
## 14 BfHA14 Bfail.HiAlb    BfHA3          9        CS
## 15 BfHA15 Bfail.HiAlb    BfHA3          9    CS/Upa
## 16 BfHA16 Bfail.HiAlb    BfHA3          9   CS/Tofa
## 17 BfHA17 Bfail.HiAlb    BfHA3          9        CS
## 18 BfHA18 Bfail.HiAlb    BfHA3          9   CS/Tofa
## 19 BfHA19 Bfail.HiAlb    BfHA3          9   CS/Tofa
## 20 BfHA20 Bfail.HiAlb    BfHA3          9    CS/Upa
## 21 BfHA21 Bfail.HiAlb    BfHA3          9        CS
## 22 BfHA22 Bfail.HiAlb    BfHA4          6        CS
## 23 BfHA23 Bfail.HiAlb    BfHA4          6   CS/Tofa
## 24 BfHA24 Bfail.HiAlb    BfHA4          6    CS/Upa
## 25 BfHA25 Bfail.HiAlb    BfHA4          6   CS/Tofa
## 26 BfHA26 Bfail.HiAlb    BfHA4          6        CS
## 27 BfHA27 Bfail.HiAlb    BfHA4          6    CS/Upa
## 28 BfHA28 Bfail.HiAlb    BfHA5          9   CS/Tofa
## 29 BfHA29 Bfail.HiAlb    BfHA5          9        CS
## 30 BfHA30 Bfail.HiAlb    BfHA5          9    CS/Upa
## 31 BfHA31 Bfail.HiAlb    BfHA5          9        CS
## 32 BfHA32 Bfail.HiAlb    BfHA5          9    CS/Upa
## 33 BfHA33 Bfail.HiAlb    BfHA5          9   CS/Tofa
## 34 BfHA34 Bfail.HiAlb    BfHA5          9   CS/Tofa
## 35 BfHA35 Bfail.HiAlb    BfHA5          9    CS/Upa
## 36 BfHA36 Bfail.HiAlb    BfHA5          9        CS
## 37 BfHA37 Bfail.HiAlb    BfHA6          3   CS/Tofa
## 38 BfHA38 Bfail.HiAlb    BfHA6          3    CS/Upa
## 39 BfHA39 Bfail.HiAlb    BfHA6          3        CS
## 40 BfHA40 Bfail.HiAlb    BfHA7          6   CS/Tofa
## 41 BfHA41 Bfail.HiAlb    BfHA7          6        CS
## 42 BfHA42 Bfail.HiAlb    BfHA7          6        CS
## 43 BfHA43 Bfail.HiAlb    BfHA7          6    CS/Upa
## 44 BfHA44 Bfail.HiAlb    BfHA7          6   CS/Tofa
## 45 BfHA45 Bfail.HiAlb    BfHA7          6    CS/Upa
## 46 BfHA46 Bfail.HiAlb    BfHA8          6    CS/Upa
## 47 BfHA47 Bfail.HiAlb    BfHA8          6    CS/Upa
## 48 BfHA48 Bfail.HiAlb    BfHA8          6   CS/Tofa
## 49 BfHA49 Bfail.HiAlb    BfHA8          6        CS
## 50 BfHA50 Bfail.HiAlb    BfHA8          6   CS/Tofa
## 51 BfHA51 Bfail.HiAlb    BfHA8          6        CS
## 52 BfHA52 Bfail.HiAlb    BfHA9          9        CS
## 53 BfHA53 Bfail.HiAlb    BfHA9          9        CS
## 54 BfHA54 Bfail.HiAlb    BfHA9          9   CS/Tofa
## 55 BfHA55 Bfail.HiAlb    BfHA9          9   CS/Tofa
## 56 BfHA56 Bfail.HiAlb    BfHA9          9   CS/Tofa
## 57 BfHA57 Bfail.HiAlb    BfHA9          9    CS/Upa
## 58 BfHA58 Bfail.HiAlb    BfHA9          9    CS/Upa
## 59 BfHA59 Bfail.HiAlb    BfHA9          9        CS
## 60 BfHA60 Bfail.HiAlb    BfHA9          9    CS/Upa
```

``` r
bnha <- blockrand(n = 60, 
                     num.levels = 3, 
                     levels = c("CS", "CS/Tofa", "CS/Upa"),
                     stratum = "Bnaive.HiAlb",
                     id.prefix = "BnHA",
                     block.sizes = c(1,2,3, 4), 
                     block.prefix = "BnHA")
bnha
```

```
##        id      stratum block.id block.size treatment
## 1  BnHA01 Bnaive.HiAlb    BnHA1          6        CS
## 2  BnHA02 Bnaive.HiAlb    BnHA1          6   CS/Tofa
## 3  BnHA03 Bnaive.HiAlb    BnHA1          6    CS/Upa
## 4  BnHA04 Bnaive.HiAlb    BnHA1          6        CS
## 5  BnHA05 Bnaive.HiAlb    BnHA1          6   CS/Tofa
## 6  BnHA06 Bnaive.HiAlb    BnHA1          6    CS/Upa
## 7  BnHA07 Bnaive.HiAlb    BnHA2         12   CS/Tofa
## 8  BnHA08 Bnaive.HiAlb    BnHA2         12    CS/Upa
## 9  BnHA09 Bnaive.HiAlb    BnHA2         12        CS
## 10 BnHA10 Bnaive.HiAlb    BnHA2         12        CS
## 11 BnHA11 Bnaive.HiAlb    BnHA2         12   CS/Tofa
## 12 BnHA12 Bnaive.HiAlb    BnHA2         12        CS
## 13 BnHA13 Bnaive.HiAlb    BnHA2         12   CS/Tofa
## 14 BnHA14 Bnaive.HiAlb    BnHA2         12    CS/Upa
## 15 BnHA15 Bnaive.HiAlb    BnHA2         12    CS/Upa
## 16 BnHA16 Bnaive.HiAlb    BnHA2         12   CS/Tofa
## 17 BnHA17 Bnaive.HiAlb    BnHA2         12    CS/Upa
## 18 BnHA18 Bnaive.HiAlb    BnHA2         12        CS
## 19 BnHA19 Bnaive.HiAlb    BnHA3          6    CS/Upa
## 20 BnHA20 Bnaive.HiAlb    BnHA3          6        CS
## 21 BnHA21 Bnaive.HiAlb    BnHA3          6        CS
## 22 BnHA22 Bnaive.HiAlb    BnHA3          6    CS/Upa
## 23 BnHA23 Bnaive.HiAlb    BnHA3          6   CS/Tofa
## 24 BnHA24 Bnaive.HiAlb    BnHA3          6   CS/Tofa
## 25 BnHA25 Bnaive.HiAlb    BnHA4          3        CS
## 26 BnHA26 Bnaive.HiAlb    BnHA4          3    CS/Upa
## 27 BnHA27 Bnaive.HiAlb    BnHA4          3   CS/Tofa
## 28 BnHA28 Bnaive.HiAlb    BnHA5         12    CS/Upa
## 29 BnHA29 Bnaive.HiAlb    BnHA5         12    CS/Upa
## 30 BnHA30 Bnaive.HiAlb    BnHA5         12    CS/Upa
## 31 BnHA31 Bnaive.HiAlb    BnHA5         12        CS
## 32 BnHA32 Bnaive.HiAlb    BnHA5         12        CS
## 33 BnHA33 Bnaive.HiAlb    BnHA5         12        CS
## 34 BnHA34 Bnaive.HiAlb    BnHA5         12   CS/Tofa
## 35 BnHA35 Bnaive.HiAlb    BnHA5         12   CS/Tofa
## 36 BnHA36 Bnaive.HiAlb    BnHA5         12   CS/Tofa
## 37 BnHA37 Bnaive.HiAlb    BnHA5         12   CS/Tofa
## 38 BnHA38 Bnaive.HiAlb    BnHA5         12    CS/Upa
## 39 BnHA39 Bnaive.HiAlb    BnHA5         12        CS
## 40 BnHA40 Bnaive.HiAlb    BnHA6          9   CS/Tofa
## 41 BnHA41 Bnaive.HiAlb    BnHA6          9    CS/Upa
## 42 BnHA42 Bnaive.HiAlb    BnHA6          9   CS/Tofa
## 43 BnHA43 Bnaive.HiAlb    BnHA6          9        CS
## 44 BnHA44 Bnaive.HiAlb    BnHA6          9   CS/Tofa
## 45 BnHA45 Bnaive.HiAlb    BnHA6          9    CS/Upa
## 46 BnHA46 Bnaive.HiAlb    BnHA6          9        CS
## 47 BnHA47 Bnaive.HiAlb    BnHA6          9        CS
## 48 BnHA48 Bnaive.HiAlb    BnHA6          9    CS/Upa
## 49 BnHA49 Bnaive.HiAlb    BnHA7          3   CS/Tofa
## 50 BnHA50 Bnaive.HiAlb    BnHA7          3    CS/Upa
## 51 BnHA51 Bnaive.HiAlb    BnHA7          3        CS
## 52 BnHA52 Bnaive.HiAlb    BnHA8         12   CS/Tofa
## 53 BnHA53 Bnaive.HiAlb    BnHA8         12   CS/Tofa
## 54 BnHA54 Bnaive.HiAlb    BnHA8         12    CS/Upa
## 55 BnHA55 Bnaive.HiAlb    BnHA8         12   CS/Tofa
## 56 BnHA56 Bnaive.HiAlb    BnHA8         12        CS
## 57 BnHA57 Bnaive.HiAlb    BnHA8         12   CS/Tofa
## 58 BnHA58 Bnaive.HiAlb    BnHA8         12    CS/Upa
## 59 BnHA59 Bnaive.HiAlb    BnHA8         12    CS/Upa
## 60 BnHA60 Bnaive.HiAlb    BnHA8         12        CS
## 61 BnHA61 Bnaive.HiAlb    BnHA8         12        CS
## 62 BnHA62 Bnaive.HiAlb    BnHA8         12    CS/Upa
## 63 BnHA63 Bnaive.HiAlb    BnHA8         12        CS
```

``` r
bnla <- blockrand(n = 60, 
                     num.levels = 3, 
                     levels = c("CS", "CS/Tofa", "CS/Upa"),
                     stratum = "Bnaive.LoAlb",
                     id.prefix = "BnLA",
                     block.sizes = c(1,2,3), 
                     block.prefix = "BnLA")
bnla
```

```
##        id      stratum block.id block.size treatment
## 1  BnLA01 Bnaive.LoAlb   BnLA01          6    CS/Upa
## 2  BnLA02 Bnaive.LoAlb   BnLA01          6        CS
## 3  BnLA03 Bnaive.LoAlb   BnLA01          6    CS/Upa
## 4  BnLA04 Bnaive.LoAlb   BnLA01          6   CS/Tofa
## 5  BnLA05 Bnaive.LoAlb   BnLA01          6   CS/Tofa
## 6  BnLA06 Bnaive.LoAlb   BnLA01          6        CS
## 7  BnLA07 Bnaive.LoAlb   BnLA02          3        CS
## 8  BnLA08 Bnaive.LoAlb   BnLA02          3   CS/Tofa
## 9  BnLA09 Bnaive.LoAlb   BnLA02          3    CS/Upa
## 10 BnLA10 Bnaive.LoAlb   BnLA03          3    CS/Upa
## 11 BnLA11 Bnaive.LoAlb   BnLA03          3   CS/Tofa
## 12 BnLA12 Bnaive.LoAlb   BnLA03          3        CS
## 13 BnLA13 Bnaive.LoAlb   BnLA04          9   CS/Tofa
## 14 BnLA14 Bnaive.LoAlb   BnLA04          9        CS
## 15 BnLA15 Bnaive.LoAlb   BnLA04          9    CS/Upa
## 16 BnLA16 Bnaive.LoAlb   BnLA04          9   CS/Tofa
## 17 BnLA17 Bnaive.LoAlb   BnLA04          9        CS
## 18 BnLA18 Bnaive.LoAlb   BnLA04          9        CS
## 19 BnLA19 Bnaive.LoAlb   BnLA04          9   CS/Tofa
## 20 BnLA20 Bnaive.LoAlb   BnLA04          9    CS/Upa
## 21 BnLA21 Bnaive.LoAlb   BnLA04          9    CS/Upa
## 22 BnLA22 Bnaive.LoAlb   BnLA05          3   CS/Tofa
## 23 BnLA23 Bnaive.LoAlb   BnLA05          3        CS
## 24 BnLA24 Bnaive.LoAlb   BnLA05          3    CS/Upa
## 25 BnLA25 Bnaive.LoAlb   BnLA06          3    CS/Upa
## 26 BnLA26 Bnaive.LoAlb   BnLA06          3   CS/Tofa
## 27 BnLA27 Bnaive.LoAlb   BnLA06          3        CS
## 28 BnLA28 Bnaive.LoAlb   BnLA07          3    CS/Upa
## 29 BnLA29 Bnaive.LoAlb   BnLA07          3        CS
## 30 BnLA30 Bnaive.LoAlb   BnLA07          3   CS/Tofa
## 31 BnLA31 Bnaive.LoAlb   BnLA08          6   CS/Tofa
## 32 BnLA32 Bnaive.LoAlb   BnLA08          6        CS
## 33 BnLA33 Bnaive.LoAlb   BnLA08          6   CS/Tofa
## 34 BnLA34 Bnaive.LoAlb   BnLA08          6    CS/Upa
## 35 BnLA35 Bnaive.LoAlb   BnLA08          6        CS
## 36 BnLA36 Bnaive.LoAlb   BnLA08          6    CS/Upa
## 37 BnLA37 Bnaive.LoAlb   BnLA09          9   CS/Tofa
## 38 BnLA38 Bnaive.LoAlb   BnLA09          9        CS
## 39 BnLA39 Bnaive.LoAlb   BnLA09          9   CS/Tofa
## 40 BnLA40 Bnaive.LoAlb   BnLA09          9    CS/Upa
## 41 BnLA41 Bnaive.LoAlb   BnLA09          9    CS/Upa
## 42 BnLA42 Bnaive.LoAlb   BnLA09          9        CS
## 43 BnLA43 Bnaive.LoAlb   BnLA09          9        CS
## 44 BnLA44 Bnaive.LoAlb   BnLA09          9    CS/Upa
## 45 BnLA45 Bnaive.LoAlb   BnLA09          9   CS/Tofa
## 46 BnLA46 Bnaive.LoAlb   BnLA10          9    CS/Upa
## 47 BnLA47 Bnaive.LoAlb   BnLA10          9        CS
## 48 BnLA48 Bnaive.LoAlb   BnLA10          9   CS/Tofa
## 49 BnLA49 Bnaive.LoAlb   BnLA10          9   CS/Tofa
## 50 BnLA50 Bnaive.LoAlb   BnLA10          9   CS/Tofa
## 51 BnLA51 Bnaive.LoAlb   BnLA10          9    CS/Upa
## 52 BnLA52 Bnaive.LoAlb   BnLA10          9        CS
## 53 BnLA53 Bnaive.LoAlb   BnLA10          9        CS
## 54 BnLA54 Bnaive.LoAlb   BnLA10          9    CS/Upa
## 55 BnLA55 Bnaive.LoAlb   BnLA11          9        CS
## 56 BnLA56 Bnaive.LoAlb   BnLA11          9        CS
## 57 BnLA57 Bnaive.LoAlb   BnLA11          9        CS
## 58 BnLA58 Bnaive.LoAlb   BnLA11          9    CS/Upa
## 59 BnLA59 Bnaive.LoAlb   BnLA11          9    CS/Upa
## 60 BnLA60 Bnaive.LoAlb   BnLA11          9   CS/Tofa
## 61 BnLA61 Bnaive.LoAlb   BnLA11          9   CS/Tofa
## 62 BnLA62 Bnaive.LoAlb   BnLA11          9   CS/Tofa
## 63 BnLA63 Bnaive.LoAlb   BnLA11          9    CS/Upa
```

## Printing these on Cards

Ideally, you will print out each randomization on a card, and seal it in a security envelope, with the outside of the envelope labeled with the id. You can do this with the *plotblockrand()* function. This function creates a pdf file of randomization cards for printing. These are designed so that the middle text will show in a standard letter sized envelope with a window, and the top text (the assignment) can be folded over to increase security (against anyone trying to peek through the security envelope to guess the assignment).


``` r
uc_study <- bind_rows(bfha, bfla, bnha, bnla) # bind together the four strata into one dataframe

blockrand::plotblockrand(uc_study, # input dataframe
                    file = "uc_study.pdf", # output pdf
                    # top hidden text with assignment
      top=list(text=c('My Study','Patient: %ID%','Treatment: %TREAT%'),
                col=c('black','black','red'),font=c(1,1,4)),
      # middle text to show through window of # 10 envelope 
    middle=list(text=c("My Study","Stratum: %STRAT%","Patient: %ID%"),
               col=c('black','blue','orange'),font=c(1,2,3)),
    # bottom text- any instructions to study coordinator
   bottom="Call 123-4567 to report patient entry",
   cut.marks=TRUE) # add cut marks - 4 per page
```

Open up the file `uc_study.pdf` in your Files tab to see the output pdf file, with assorted fonts and colors.

Just for fun, change (and then re-run) the

-   text "My Study" to something more interesting

-   change "Patient" to "Participant"

-   change "Treatment" to "Arm" or "Assignment"

-   change some of the colors to standard R colors

-   change some of the fonts (within 1-4)

Sometimes with equal blocks, and clear treatment effects or side effects, nurses or study coordinators can guess the randomization pattern. If you want to get fancy, and make it even harder to guess treatment assignments, you can add one of the unequal blocks options, to make it hard to find patterns in treatment or in side effects. Set `uneq.beg = TRUE` for an unequal block in the beginning, or `uneq.mid = TRUE` for an unequal block in the middle.

## Now, try this yourself

You want to randomize 80 outpatients with Crohn's disease to one of 8 arms, as part of a 2\^3 factorial design to increase patient activation. These arms involve using (A,B, C) or not using (a,b,c) 3 intervention components. The 8 arms then become:

-   abc

-   abC

-   aBc

-   aBC

-   Abc

-   AbC

-   ABc

-   ABC

Then we want to stratify the participants by baseline PAM score (a measure of patient activation) with levels of low, medium, and high PAM.

To be prepared for dropouts and imbalanced enrollment, you want to have a randomization list with at least 32 assignments available for each arm and stratum. To avoid a recognizable pattern in the randomization, you want to have a permuted block design with blocks of sizes 8 and 16.

::: {.tryit}
You can hover over top right corner of the code chunk below, and a copy icon will appear - click this to copy the code to your clipboard.
You can then paste it into your local version of RStudio, edit it, and run it.
:::

In the code block below, fill in the blanks to complete the code to make a dataframe for the `low_pam` stratum.


``` r
low_pam <- blockrand(n = __, 
                     num.levels = __, #eight treatments
  levels = c("abc", "abC", "aBc", "aBC",
             "Abc", "AbC", "ABc", "ABC"), # arm names
                     stratum = "__", # stratum name
                     id.prefix = "lp", # stratum abbrev
                     block.sizes = c(1,2,3), # times arms 
                     block.prefix = "LP") # stratum abbrev
low_pam
```

Now that you have one stratum sorted, edit the code block below to create the `med_pam` and `high_pam` strata.


``` r
med_pam <- blockrand(n = __, 
                     num.levels = __, #eight treatments
  levels = c("abc", "abC", "aBc", "aBC",
             "Abc", "AbC", "ABc", "ABC"), # arm names
                     stratum = "__", # stratum name
                     id.prefix = "__", # stratum abbrev
                     block.sizes = c(__), # times arms 
                     block.prefix = "__") # stratum abbrev
med_pam

high_pam <- blockrand(n = __, 
                     num.levels = __, #eight treatments
  levels = c("abc", "abC", "aBc", "aBC",
             "Abc", "AbC", "ABc", "ABC"), # arm names
                     stratum = "__", # stratum name
                     id.prefix = "__", # stratum abbrev
                     block.sizes = c(__), # times arms 
                     block.prefix = "__") # stratum abbrev
high_pam
```

Great!

Now try to

-   bind these 3 strata into one dataframe

-   print these as cards to a pdf file

Edit the code chunk below to produce the pdf file


``` r
cd_study <- bind_rows(__,__,__) # bind together the 3 strata into one dataframe

blockrand::plotblockrand(__, # input dataframe
                    file = "cd_study.pdf", # output pdf
                    # top hidden text with assignment
      top=list(text=c('CD Study','Patient: %ID%','Treatment: %__%'),
                col=c('orange','blue','red'),font=c(1,1,4)),
      # middle text to show through window of # 10 envelope 
    middle=list(text=c("CD Study","Stratum: %STRAT%","Patient: %__%"),
               col=c('black','red','cadetblue'),font=c(1,2,3)),
    # bottom text- any instructions to study coordinator
   bottom="Call 123-4567 to report patient entry",
   cut.marks=TRUE) # add cut marks - 4 per page
```

## Now Freestyle

Your turn. Create randomization tables and a pdf file of cards for a study of 2 microbiome interventions to reduce the formation of colon adenomas.

-   your 3 study arms will be - placebo, Streptococcus thermophilus, and S.thermo plus lactose (a preferred sugar for S.t, making this arm a synbiotic, while arm 2 is a probiotic) - aka 3 arms called: pbo, probiotic, synbiotic.

-   Your stratifications will be by

    -   prior polyps being MSI_hi or MSI_lo (for microsatellite instability mutations)

    -   BMI above or below 35. BMI_hi, BMI_low

-   block sizes of 4,8,12,16

-   160 per arm

Edit the code block below for the first stratum


``` r
mhbh <- blockrand(n = __, # treatment arms
                     num.levels = __, # of treatments
  levels = c("placebo", "probiotic", "synbiotic"), # arm names
                     stratum = "__,__", # stratum name
                     id.prefix = "mhbh", # stratum abbrev
                     block.sizes = c(__,__,__,__), # times arms 
                     block.prefix = "__") # stratum abbrev
mhbh
```

Edit the code block below for the remaining strata


``` r
mhbl <- blockrand(n = __, # treatment arms
                     num.levels = 3, # of treatments
  levels = c("placebo", "probiotic", "__"), # arm names
                     stratum = "msi_hi.bmi_lo", # stratum name
                     id.prefix = "__", # stratum abbrev
                     block.sizes = c(1,2,__,__), # times arms 
                     block.prefix = "MHBL") # stratum abbrev
mhbl

mlbl <- blockrand(n = 160, # treatment arms
                     num.levels = __, # of treatments
  levels = c("placebo", "__", "synbiotic"), # arm names
                     stratum = "__", # stratum name
                     id.prefix = "mlbl", # stratum abbrev
                     block.sizes = c(__,__,3,4), # times arms 
                     block.prefix = "MLBL") # stratum abbrev
mlbl

mlbh <- blockrand(n = __, # treatment arms
                     num.levels = 3, # of treatments
  levels = c("__", "probiotic", "synbiotic"), # arm names
                     stratum = "msi_lo.bmi_hi", # stratum name
                     id.prefix = "__", # stratum abbrev
                     block.sizes = c(1,2,3,4), # times arms 
                     block.prefix = "MLBH") # stratum abbrev
mlbh
```

Edit the code block below to bind the strata together and print the cards


``` r
adenoma_study <- bind_rows(mlbl, mlbh, mhbh, mhbl) # bind together the strata into one dataframe

blockrand::plotblockrand(__, # input dataframe
                    file = "adenoma_cards.pdf", # output pdf
                    # top hidden text with assignment
top=list(text=c('Adenoma Study','Patient: %__%','Treatment: %TREAT%'),
                col=c('orange','blue','red'),font=c(1,1,4)),
      # middle text to show through window of # 10 envelope 
    middle=list(text=c("Adenoma Study","Stratum: %__%","Patient: %ID%"),
               col=c('black','red','cadetblue'),font=c(1,2,3)),
    # bottom text- any instructions to study coordinator
   bottom="Call 123-4567 to report patient entry. \nInstruct participant to avoid antibiotics and stop aspirin",
   cut.marks=TRUE) # add cut marks - 4 per page
```
