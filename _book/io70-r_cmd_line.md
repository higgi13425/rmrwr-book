---
title: "Running R from the UNIX Command Line"
author: "Peter Higgins"
date: "9/6/2020"
output: html_document
---



# Running R from the UNIX Command Line {#cmd-line}

## What is the UNIX Command line?
The command line is a simple Terminal window with a prompt at which you can type commands, And do primitive but powerful things to your files. The UNIX computing environment was developed in the 1960s, and is still beloved and fetishized by brogrammers, who believe you are not truly a programmmer if you can't code from the command line. This is silly.
<br><br>
The major attraction to UNIX in the 1960s is that it was much better than punch cards.  Which isn't saying much. We have had 60 years of software advancement and user interface improvements, so we really should not have to put up with the inherent user hostility of the UNIX environment.
<br><br>
UNIX is an early operating system, which is built around a 'kernel' which executes operating system commands, and a 'shell' which interprets your commands and sends them to the kernel for execution. The most common shell these days is named 'bash', which is a silly recursive brogrammer joke. You will sometimes see references to shell scripts or shell or bash programming. These are the same thing as command line programming.
<br><br>
UNIX is a common under-the-hood language across many computers today, as the Apple iOS is built on top of UNIX, and the various versions of the LinuxOS are built on a UNIX-like kernel, with a similar command shell. 
<br><br>
The command line is often the least common denominator between different pieces of open-source software that were not designed to work together. It can occasionally be helpful to build a data pipeline from mismatched parts.
 However, there is a lot of low-quality user-hostile command line work involved to get it done, often referred to as "command-line bullshittery". This is a common bottleneck that slows scientific productivity, and there is a vigorous discussion of it on the interwebs [here](https://pg.ucsd.edu/command-line-bullshittery.htm) and [here (counterpoint)](https://medium.com/@eytanadar/on-the-value-of-command-line-bullshittery-94dc19ec8c61). Essentially, some argue that it is largely a waste of time and effort, while others see it as a valuable learning experience, like doing least squares regression by hand with a pencil.
<br><br>
Running R from the command line is a bit like spending a day tuning your car's engine by yourself. There is a case to be made that this will improve the efficiency and performance of your car, but it is also usually more efficient to pay someone else to do it, unless you are a car expert with a lot of free time.

## Why run R from the command line?

You can run R from the command line. It has none of the bells and whistles, nor any of the user conveniences of the RStudio Interactive Developer Environment (IDE). But it is how R was originally expected to be used when it was developed back in 2000 in New Zealand.
<br><br>
Running R from the command line allows you to do powerful things, like process multiple files at once, which can be handy when you have multiple files of sequencing data from distinct observations, or you have a multistep data wrangling pipeline with several slow steps. For many years, this was the only way to easily apply code across multiple files to build a complex data pipeline.
<br><br>
This is much less true today, with tools to handle file paths like the {here} and {fs} packages, run Python scripts from R with the {reticulate} package, run C++ scripts with Rcpp, and run bash, python, SQL, D3, and Stan scripts from Rmarkdown. You can use the {drake} package to manage multi-step data pipelines in different languages (similar to _make_). But some labs have been doing things at the command line for years, and find it hard to change.

## How do you get started?
First, you need to open a terminal window.
And to do that, you need to find it. This is akin to getting under the hood of a car, and computer makers don't exactly encourage it.

### On a Mac

- Go to Finder/Applications/Utilities/Terminal

### On a Windows PC

- Go to Applications/Terminal


## The Yawning Blackness of the Terminal Window
So, you have managed to open a terminal window, which has a standard UNIX prompt, ending in something like `%` or `$`. Not terribly helpful, is it? The bash shell is waiting for you to enter a command. <br>
No user interface for you!
<br><br>

:::tryit
Let's start with a simple one, which can't do any harm. Run the command below:<br>
`whoami`


```bash
whoami
```

```
## peterhiggins
```
:::

Remember that UNIX started out as an operating system for terminals, and knowing who was logged in was a helpful thing.
<br><br>
You can string together two commands with a semicolon between them. <br>

:::tryit
Try the following:

```bash
whoami;date
```

```
## peterhiggins
## Mon Jun  7 13:08:50 EDT 2021
```
:::

OK, fine. This is sort of helpful. It was really important when you were on a terminal and paying by the minute for time on a mainframe back in 1969. And, on occasion, if you will need to use an entire computer cluster to run a script (or scripts) on a lot of data, you will likely have to use some of this command line knowledge. You can even schedule jobs (scripts) to run when your time is scheduled on the cluster with `cron` and `crontab`.
<br><br>
At this point, it would be helpful to open a window with your Documents folder, and keep it side by side with the window in which you are reading this e-book. We will start working with files and directories, and it is helpful to see changes in your file/folder structure in real time. As we run commands in the bash shell, check them against what you see in the folder window. You may find that some files (dotfiles, starting with a period) are hidden from the user to prevent problems that occur when these are deleted. 
<br><br>

## Where Are We?

OK, let's start looking at files and directories. Start with the `pwd` command, which does **not** stand for password, but for `print working directory`.<br>


:::tryit
Run the code below in your Terminal window.


```bash
pwd
```

```
## /Users/peterhiggins/Documents/Rcode/rmrwr-book
```
:::

You can see the full path to your current directory. This can be a bit obscure if you are just looking at your folder structure, particularly at the beginning of the path. Fortunately, the {here} package handles a lot of this for you when you are working in Rstudio projects. <br>
We think of the directory as a tree, with a root - in this case, `Users`, and various branches as you build out folders and subfolders.<br>
We can move up and down the folders of the directory paths with the `cd` command, for `change directory`.
<br><br>

:::tryit
Try this command in your Terminal Window, and see if you can figure out what it does.


```bash
cd ..
```
:::

It changes the directory `up` one level closer to the root directory. It is straightforward to go up the directory tree, as each folder only has one `parent`. But it is tricky to go down the directory tree, as there are many possible branches/children, and you do not inherently know the names of these branches. We need to list the contents of your current directory with `ls` to know what is there. 

:::tryit
Try the `ls` command in your Terminal window


```bash
cd /Users/peterhiggins/Documents/;
ls
```

```
## 01 ECCO 2018 PRO Symposia_Higgins 15Feb2018 Final.pptx
## 03 ECCO 2018 PRO Symposia_Irving 15Feb2018 Final.pptx
## 1-s2.0-S0016508514012682-main.pdf
## 12_2018_MLR01_Higgins_Waljee_ResearchPlan.docx
## 2016IBDClinTrialsforMDsDearborn.pptx
## 2017_drugR01_research-plan_DRAFT.docx
## 2018UCLABuildingCareer.pptx
## 2018UCLAOptimizingIBDMedications.pptx
## 2018UCLAOptimizingIBDMedications2.pptx
## 3SlidesFibrosis.pptx
## 44 days.docx
## 5asa abstractSCM_PDRH.docx
## 65LV163_IBD AMCP_Flint MI_2.27.17.pptx
## 65LV1720 IBD Rural _ Kalamazoo.pptx
## ABT-737 in vitro data.pptx
## ACD Introduction 1.10.2017.pptx
## ACD Introduction.pptx
## ACD_CTSU_Nov2016.pptx
## AGA symposium Management of non-responders 2017 5-6-17.pptx
## AIBD_Quality_PRO_Higgins_2017.pptx
## AJG_Vedo Prediction in UC_2.docx
## AbstractCCFEntrepreneur.docx
## Academic Teams Fund.docx
## Acute Severe Colitis Cases.pptx
## Advisory Board Meeting 6.16.2017.pptx
## Allergan IBSD IBD Advisory Board Agenda and Participants.pdf
## Aspire tofa TURANDOT clinical protocol.docx
## Aspire tofa TURANDOT clinical protocol_KLS.docx
## Aspire tofacitinib fibrosis protocol.docx
## BE LGD Dearborn 2016.04.13.pptx
## BP fistulas.pptx
## BP story summary stem cells.docx
## Bcl2 inhibitors R01 data.pptx
## Bcl2_inhibs_tissuedistrib_MCTI_Feb2017.pptx
## Bcl2_inhibs_tissuedistrib_MCTI_Feb2017Higgins_ER.pptx
## Beaumont Medicine GR 2020.pptx
## BiofireDDW2018
## BiofireDDW2018.pdf
## BiofireDDW2018.pptx
## Brainstorming for CCFA speech ideas[1].docx
## Buhlmann_Waljee.docx
## C.Steiner.Ch34.docx
## CC360 Title Page.docx
## CCF CRA 2018
## CCFA DDx NewIBD3.ppt
## CCFA Fibrosis 2017.jpg
## CCFA Fibrosis 2017.pptx
## CCFA speech.docx
## CCFA_Partners_Higgins_Insurance_v1_2017_02_10_ML.docx
## CDPRO Version 6.1.docx
## CRA 2018
## CTSU Introduction Overview 4.11.17.pptx
## CTSU Introduction Overview 6.9.17.pptx
## CTSU intro.pptx
## CareerDevTrain-Govani 2016 K.docx
## Case IBD comorbidity_MS PDRH2016 AIBD.pptx
## Chemlab Note Sheets.docx
## Clinical Trials Academy
## Clinical Trials Subcommittee - ACD_CTSU Progress Report 2017.pptx
## ClinicalUsePROs.pptx
## Confident Vedo Decision Making in Practice Brazil 2016.2.pptx
## Confident Vedo Decision Making in Practice Brazil 2016.pptx
## Current IBD Studies_15Jun2016.pptx
## DDW Presentation-JB-Capture.pptx
## DDWIntestinalOrganoids3.pptx
## Dan Sharp.jpg
## DeEscalationACG2016.pptx
## Dearborn2017TalkHowToChooseIBDMed.pptx
## Dillman2015T2MT.pdf
## Documents.Rproj
## DonorTalk2016.pptx
## Draft Postop IBD Surgery Care Protocols.docx
## DrugDevInIBD.pptx
## ECCO2016Lycera30937.pptx
## ECCO_Axl_2017_handout.pdf
## ECCO_BIOFIRE_poster_2017.pdf
## ECCO_VedoUC_2017_handout.pdf
## ENDING CLIP.mp4
## Eclipse Pics
## Editorial Commentary on biosimilar.docx
## FALK2016FibrosisManuscript.docx
## Fail FastDenver2018RxPrediction.pdf
## Fail FastDenver2018RxPrediction.pptx
## FalkNewTricksKnownDrugs2017.pptx
## Fibrosis workshop_agenda_V5.docx
## FibrosisAbbvieMatter2016.pptx
## FibrosisIBDCedars2016.pptx
## Figures List for Research Plan (1).docx
## Fundraising Pitches.docx
## GI T32 Application 2017 v2.docx
## GailBetsy.jpg
## GailGrandkids.jpg
## GailPat.jpg
## Getting to and Using IBD Epidemiology Server.docx
## GoToMeeting Chats
## GossetPhoto.jpg
## GrantWriting.pptx
## HBV testing before biologic use.pptx
## HGI1016Higgins.docx
## HS movie.docx
## Harlan_Kids.jpg
## Health Insurance Consumer Satisfaction DDW abstract 2016.docx
## Higgins - DeEscalationACG2016.pptx
## Higgins Beijing 2017The Gut Microbiota and the Pathophysiology of IBD.pptx
## Higgins CCFA CTPROs in IBD.pptx
## Higgins CCFACT2017FundingClinicalResearch.pptx
## Higgins HK 2017IBD Nursing and Quality of Care.pptx
## Higgins HK 2017The Gut Microbiota and the Pathophysiology of IBD.pptx
## Higgins Introduction.docx
## Higgins Lab Generic research proposal 030916.docx
## Higgins Microbiota for IBD Patient Ed2.pptx
## Higgins-peter.jpg
## HigginsAI talk for DDW2019.pdf
## HigginsDubaiWhenHowFirstBiologic.pptx
## HigginsDubaiiAntiTNFExit.pptx
## HigginsDubaiiFactors2ndBiologic.pptx
## HigginsDubaiiMucHealing.pptx
## HigginsDubaiiUpdatesCDManagement.pptx
## HigginsFALKFibrosis2015.pptx
## HigginsFALKMadridThioMtx2017.pptx
## HigginsFam.jpg
## HigginsUCBFibrosisMarkers2016.pptx
## IBD COVID Infographic.pdf
## IBD COVID Infographic.pptx
## IBD COVID Infographic.tiff
## IBD Organoid CrossTalk 2016.pptx
## IBD Risk PDF.pdf
## IBD map pics michigan.pptx
## IBDDeckPtEdRoad2016 8-11-16.pptx
## IBDDeckPtEdRoad2016_Frankenmuth.pptx
## IBDDeckPtEdRoad2016_Frankenmuthv2.pptx
## IBD_Deescalation_2016_11_15.docx
## IBD_manuscript.docx
## IBD_pt_ed_Liver_14DEC2017-2.ppt
## IBDforPrimaryCare.pptx
## IBS Biofire GI panel Protocol v1 PDRH edits.docx
## IMGP2847.JPG
## IOIBD.Fibrosis.Higgins.2018.Amsterdam.pptx
## Imaging of Fibrosis Review - Draft 5PH.docx
## ImagingIBD.Data
## ImagingIBD.enl
## Imaging_Fibrosis_Review_StidhamHiggins_Revision_31Jan2016.docx
## Instructions on using the pivot table and vlook up for task list reports[1].docx
## Intro for P2PEP.docx
## JeffCole_on_phone.jpg
## June-2017 MCTI Tx Fund Q2 Proj-update.pptx
## K CANDIDATE INFORMATION.CAS.docx
## K23 Review Questions for Candidate Score.docx
## KC.PDRH.Mentor Letter of Support.docx
## KEH fistulas.pptx
## Kay Greveson.jpg
## Kelly Referee AA SCM edits.docx
## Keystone Intro Thursday.pptx
## Lexi Brown.jpg
## Lexi Brown2.jpg
## Lycera_LYC30937-2001 Clinical Study Protocol_01Mar2016_Tracked.docx
## MC PRO DDW abstract draft 1.docx
## MER Stress Management Dearborn 4-14.pptx
## ML and AF WisconsinJuly17.pptx
## MLforPrecisionMed2018.pptx
## MLinGI.pptx
## MLinIBDBeijing2017.pptx
## MachineLearning26Sep2016.docx
## MarnieKids.jpg
## Meeting with Abbvie.pptx
## Meta analysis TB vs CD version 3.4.docx
## MohamedNoureldin.jpeg
## Mscan adherence paper v4.docx
## My EndNote Library.Data
## My EndNote Library.enl
## NewIBDTherapiesUtah2018.pptx
## Notes on blogdown package.docx
## Olorinab - ECCO 2019 Abstract - Higgins - Tolerability and analgesic efficacy_D6a_KG_PDRH.docx
## Organoid slides for Peter.pptx
## P2PEP Up-To-Date Topics.docx
## P2PEPWrapUp2016.pptx
## PDRH_FibrosisImaging_Congress_2019.2.pptx
## PDRH_FibrosisImaging_Congress_2019.jpg
## PDRH_FibrosisImaging_Congress_2019.pdf
## PHNutritionBasicsofIBDAug2016.pptx
## PHcv2016.docx
## PHcv2017Prof.docx
## PPT
## PROsJanssen2017.pptx
## PennIBDFistulizingCD2017Higgins.pptx
## PennThioMTX2017Higgins.pptx
## Pomish Story.docx
## Pomish Tweets.pptx
## Poppy Eulogy backup.docx
## Poppy Eulogy.docx
## Possible collaborations with UCB.docx
## Poster Welcome.doc
## Poster Welcome.docx
## PragueRefractoryRisingBar2017.pptx
## PragueRefractoryRisingBar2017_2.pptx
## Predicting Steroid Use.docx
## Predicting Therapeutic Outcomes in IBD.pptx
## Prediction of Future IBD Health Care Utilization and Peter FINAL.docx
## Prediction of Future IBD Health Care Utilization and Peter clean.docx
## Presentation1.png
## Presentation3.pptx
## PtEdRdDeckFrankenmuth2017.pptx
## PtEdRdDeckGrandRapids2018.pptx
## QAFunctionalRequirements_GI_IBD Dashboard_DRAFT_v5.docx
## R session Fri PM.docx
## REDCapTableOne.pptx
## RFModelsInEpicEMR2018.pptx
## RUBIN - Diagnosis and Management of Nutritional Deficiencies and Anemia.FINAL.pptx
## Rcode
## Recordings
## RimolaDelayGadEnh2015.pdf
## Rlibs
## S is for Saffron 3.3.docx
## SCENIC Chicago2017.pptx
## SCENIC DDW16.pptx
## SPARC IBD Study China.V3.pptx
## SPARC IBD Study China.pptx
## SWV US R01 DDW abstract 2016.docx
## SWVUSRadiology2013.pdf
## Scientific Review Committee SALTYFOOD.pdf
## Screen Shot 2017-09-03 at 5.51.16 PM.png
## Screen Shot 2018-05-28 at 8.32.19 AM.png
## Screen Shot 2018-05-31 at 10.58.08 AM.png
## Senior Slide Show.ppsx
## Sept2017-Higgins-MCTI Tx Fund Q3_update.pptx
## Social Media for GI.pptx
## Stidham_Higgins_BroadMar2016.pptx
## Supplementary documents v2.docx
## Syllabus DS4P.docx
## TOPPICData Request Form v1.0 06Jan2017.docx
## Table practice with flextable.docx
## TakedaAug2017.pdf
## TakedaAug2017.pptx
## Task-Based GI Fellow Evaluation.docx
## Test_Rmd_PPT.Rmd
## Test_Rmd_PPT.pptx
## The ABC IBD Management-RN.pptx
## Thiopurine Update2014.pptx
## Tofa inpatient induction Protocol_RCT_11Jun2019_Pfizer.docx
## Tofacitinib for Patient Binder.v1SCM.docx
## UC-PRO-SS Manuscript Draft 1Feb2016.docx
## UC-PRO-SS Manuscript DraftPH.docx
## UCPRO Version 6.1.docx
## UEGW CD PRO SS_oral presentation 18Oct19.pptx
## UEIStidhamGastro2011.pdf
## UM Hospital.jpg
## UMCME_Management of CD.pptx
## UMHS Talk- Moving Beyond AntiTNF 4-2016 FINAL v2.pptx
## UMHSaerial_3.jpg
## UMNonDegreeApp2016.pdf
## US Nonlinear for Surgeons.pptx
## US R01.pdf
## Ulcerative_colitis_Cases_AIBD_Baidoo_Mahadevan_Higgins.pptx
## Ustekinumab for Patient Binder[1].docx
## Utah2018HowToChooseIBDMed.pptx
## UtahNewIBDTherapiesHiggins20182.pptx
## Vedo Prediction in CD.docx
## VedoUCDDW2017.pptx
## Viberzi Allergan SlidesHiggins.pptx
## Viberzi for Crohns without inflammation protocol Higgins.docx
## VindicoMed Agenda.doc
## Visual Abstract BMJ Steroids[1].jpg
## Wellspringboard.png
## Why IBD Training.pptx
## Xenoestrogen budget- final.xlsx
## Xenoestrogen proposal2.docx
## XmasLetter2015.docx
## Xu Photoacoustic 2015.pdf
## Zoom
## ]GI Clinical Protocols 3.7.19_RWS.xlsx
## abtdataRfiles
## ahorst_broom_package.png
## ajg20168a.pdf
## biomakers_fibrosis_text_draft_07MAR2016-4.docx
## command_line_R.pptx
## day1_s1_explore-libraries
## day1_s2_copy-files
## explore-libraries
## healthInsSatPredictors.xlsx
## human_cases-Xu_PA-09-28-18[1].tiff
## images SWV, MTMRI.pptx
## intern pic.png
## mmc1.pdf
## nejmStatinHiggins.pdf
## not easy.jpg
## p2pep.jpg
## phiggins.jpg
## phiggins2.jpg
## phiggins3.jpg
## ppt_from_Rmarkdown.docx
## tablet.JPG
## university-of-michigan-hospital.jpg
## unknown_solicit.xlsx
## volvulus.ppt
## ~$llabus DS4P.docx
## ~$ster Welcome.doc
```
:::

You will see a listing of all files and folders in the current directory. You can get more details by adding the option (sometimes called a `flag`) `-l`


```bash
cd /Users/peterhiggins/Documents/;
ls -l
```

The full listing will give you more details, including read & write permissions, file size, date last saved, etc. <br>
Many commands have options, or flags, that modify what they do.
<br><br>
Find a folder inside of your Documents folder. We will now go `down` a level in the directory tree. In my case, I will use the `Powerpoint` folder. <br>
In your Terminal window:

:::tryit
- change the directory to the Powerpoint directory
- list the contents of this folder

```bash
cd /Users/peterhiggins/Documents/Powerpoint;
ls
```

```
## bash: line 0: cd: /Users/peterhiggins/Documents/Powerpoint: No such file or directory
## -1.png
## DESCRIPTION
## LICENSE
## README.md
## _book
## _bookdown.yml
## _bookdown_files
## _build.sh
## _deploy.sh
## _output.yml
## boxes_ggconsort.R
## current_image.Rdata
## data_MST-41.xlsx
## data_UC_BIOPSY_ALL_2018.csv
## data_USDemand_ParrotAnalytics.xlsx
## data_fcp.csv
## data_rad.csv
## file2.txt
## file_name
## france.png
## images
## index.Rmd
## index.md
## io02-getting-started.Rmd
## io02-getting-started.md
## io02-getting-started_files
## io03-tasting.Rmd
## io03-tasting.md
## io04-updating.Rmd
## io04-updating.md
## io05-importing.Rmd
## io06-data collection.Rmd
## io06a-filter.Rmd
## io06a-filter.md
## io07-major-updates.Rmd
## io07-major-updates.md
## io08-data-validation.Rmd
## io09-timeseries.Rmd
## io10-tableOne.Rmd
## io10-tableOne.knit.md
## io11-ggplot-single-var.Rmd
## io12-ggplot-cont-vs-catvar.Rmd
## io13-ggplot-cont-vs-cont.Rmd
## io14-presenting-Rmarkdown.Rmd
## io15-reproducible-research.Rmd
## io16-study-design.Rmd
## io17-sample-size.Rmd
## io18-sources-bias.Rmd
## io19_randomization_blockrand_CAPTURE.Rmd
## io20-one-var-1group-tests.Rmd
## io21-one-var-2group-tests.Rmd
## io22-one-var-Multgroup-tests.Rmd
## io23-linear-regression.Rmd
## io24-sharing-shiny.Rmd
## io25-logistic-regression.Rmd
## io26-meta-analysis.Rmd
## io27-learn_consort.Rmd
## io27-learn_consort.knit.md
## io28-mockstudy_analysis_chisq.Rmd
## io28-mockstudy_analysis_chisq_files
## io29-learn_chisq.Rmd
## io29a-chisq_example.Rmd
## io29a-chisq_example_files
## io2a-alt_intro.Rmd
## io30-ttest.Rmd
## io30-ttest.md
## io30-ttest_files
## io30a-ttest.Rmd
## io30a-ttest_files
## io30b-ttest.Rmd
## io31-ttest_part2.Rmd
## io31-ttest_part2_files
## io32-table_ttest_broom.R
## io33-tableone_arsenal.Rmd
## io34-mockstudy_analysis.Rmd
## io34-mockstudy_analysis_files
## io35-making-univariate-model-tables.Rmd
## io36-tidyr1.Rmd
## io37-tidyr2.Rmd
## io37-tidyr2_files
## io38-tidylog.Rmd
## io39-dplyr_verbs_demo.Rmd
## io39-dplyr_verbs_demo.knit.md
## io39a-dplyr_verbs_demo.Rmd
## io40-more_dplyr.Rmd
## io41-draw_consort.Rmd
## io41-draw_consort_files
## io42-randomization_demo_CAPTURE.Rmd
## io42a-blockrand_CAPTURE.Rmd
## io43-rand_block.Rmd
## io44-UM_poster.Rmd
## io44-UM_poster_cache
## io44-UM_poster_files
## io45-begin_scatterplots.Rmd
## io45-begin_scatterplots_files
## io46-begin_boxplots.Rmd
## io46-begin_boxplots_files
## io47-begin_bars.Rmd
## io47-begin_bars_files
## io48-learn_distrib_histo.Rmd
## io48-learn_distrib_histo_files
## io49a-multipanel_with_tables.Rmd
## io49a-multipanel_with_tables_files
## io50-strings_intro_learnr.Rmd
## io50a-strings_intro.Rmd
## io50a-strings_intro.html
## io50b-strings_intro.Rmd
## io50b-strings_intro.html
## io51-string_2.Rmd
## io51-string_2.knit.md
## io51a-strings_2.Rmd
## io53-strings_3._learnr.Rmd
## io53-strings_3._learnr.html
## io53a-Sample_colonoscopy_text_parse.R
## io55-ForkBranchCollaboration.Rmd
## io56-FormattingRmd2Word.Rmd
## io56-FormattingRmd2Word_files
## io57-first_function_tidyeval.R
## io58-debug_pipes_plots.Rmd
## io59-hashtag_debugging.Rmd
## io60-help_in_R.Rmd
## io60-help_in_R_files
## io61-learnr_lm.Rmd
## io62-leaps_demo.R
## io63-logistic_regression.Rmd
## io64-GAM.Rmd
## io64-GAM_files
## io65-error_messages.Rmd
## io65-error_messages.md
## io65-error_messages_files
## io66-base_r.Rmd
## io66-base_r.md
## io70-r_cmd_line.Rmd
## io97-publishing.Rmd
## io98-title-holder.Rmd
## io99-references.Rmd
## ioAnalysis.Rmd
## ioHow to Install R.docx
## ioHow to Install Rstudio.docx
## ioarsenal tableby gt.Rmd
## iobar_plot in ggplot with value labels.R
## iobibliometrix.R
## iocleaning list of insplans.R
## iocovid animation.R
## iofcp.csv
## ioparrot animate bar chart race.R
## iopower_calc_proportions.R
## iorad.csv
## ioropenaq demo map.R
## notes-on-how-to-publish-to-bookdown-org.html
## now.json
## packages.bib
## preamble.tex
## render17bc728cef263.rds
## render7f3925ade8dd.rds
## renv
## renv.lock
## rmrwr-book.Rproj
## rmrwr.rds
## rmrwr_files
## style.css
## table-one.R
## table-one.Rmd
## table-one.html
## table1.docx
## toc.css
```
:::

Great!<br>
You moved to a new directory and listed it.<br>
Now we will get fancy, and make a new directory within this directory with the `mkdir` command.<br>

:::tryit
Try this in your Terminal window:


```bash
pwd;
mkdir new_files;
ls
```
:::

You have now made a new directory (folder) within the previous directory, named `new_files`. Verify this in your Documents folder.<br> 
You can now change to this directory <br>
and list the contents (it should be empty).<br>


:::tryit
Try this out in your Terminal Window (**note** edit the `cd` command to your own directory path).


```bash
cd /Users/peterhiggins/Documents/Powerpoint/new_files;
ls
```
:::

Note that you can abbreviate the current directory with `.`, so that you could have also used `cd ./new_files`
<br><br>

You can create a new (empty) file in this directory with the `touch` command.
Sometimes you need to create a new file, then write data to it.

:::tryit
Try this out

```bash
touch file_name;
ls
```
:::

You can also create a file with data inside it with the `cat >` command.

:::tryit
Type in the following lines into your Terminal window. When complete, type control-D to be done and return to the Terminal prompt.
`cat` stands for concatenate.


```bash
cat > file2.txt
cat1
cat2
cat3
```
:::

Now you can list the contents of this file with the `cat` command below.

:::tryit
Give this a try

```bash
cat file2.txt
```
:::

You can also list the directory of your `new_files` folder with ls to see the new folder contents.

:::tryit
Try this

```bash
ls
```
:::

Note that you don't need to use the Terminal to run bash commands. You can do this from an Rmarkdown file. <br>
Take a moment to run `pwd` in your Terminal, to get the current directory.<br>
<br>

:::tryit
Now open Rstudio, and a new Rmarkdown document.<br>
Copy the path to the current directory from the Terminal.<br>
Switch back to the Rmarkdown document.<br>
Select one of the R code chunks (note the {r} at the top) and delete it.<br>
Now click on the Insert dropdown at the top of the document, and insert a Bash chunk.<br>
Now add UNIX commands (separated by a semicolon), like


```bash
cd (paste in path here);
pwd;
ls;
cat file2.txt
```
Then run this chunk. <br>
:::

Now you can run terminal commands directly from Rmarkdown!

## Cleaning Up

OK, now we are done with the file `file2.txt` and the directory `new_files`.
Let's get rid of them with `rm` (for removing files) and `rmdir` for removing directories. <br>
In order, we will 
- Make sure we are in the right directory
- remove the file with `rm file2.txt`
- go up one level of the directory with `cd ..`
- remove the directory with `rmdir new_files`

:::tryit
Give this a try

```bash
pwd;
rm file2.txt;
cd ..;
rmdir new_files
```
:::

Verify all of this in your Documents window.<br>
This is great. But you can imagine a situation in which you mistakenly `rm` a file (or directory) that you actually needed. Unlike your usual user interface, when a file is removed at the command line, it is gone. It is not in the trash folder. It is gone. There is something to be said for modern user interfaces, which are built for humans, who occasionally make mistakes. Sometimes we do want files or folders back.

## Other helpful file commands
Here are some file commands worth knowing

- `cat filename` - to print out whole file to your monitor
- `less filename` - to print out the first page of a file, and you can scroll through each page one at a time
- `head filename` - print first 10 lines of a file
- `tail filename` - print last 10 lines of a file
- `cp file1 file2` - copy file1 to file2
- `mv file1.txt file.2.txt file3.txt new_folder` - move 3 files to a new folder

## What about R?
So now you can get around directories, and find your files in the Terminal window, but you really want to run R.<br>
You can launch an R session from the Terminal Window (if you have R installed on your computer) by typing the letter `R` at the Terminal prompt

:::tryit
Launch R

```bash
R
```
:::

You get the usual R intro, including version number, and the `R>` prompt.<br>
Now you can run R in interactive mode with available datasets, or your own datasets.<br>


:::tryit
Try a few simple commands with the mtcars dataset.<br>
Give the examples below a try.<br>     

You can use `q()` to quit back to the terminal (and reply "n" to **not** save the workplace image).

```r
head(mtcars)
```

```
##                    mpg cyl disp  hp drat    wt  qsec vs am
## Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1
## Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1
## Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1
## Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0
## Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0
## Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0
##                   gear carb
## Mazda RX4            4    4
## Mazda RX4 Wag        4    4
## Datsun 710           4    1
## Hornet 4 Drive       3    1
## Hornet Sportabout    3    2
## Valiant              3    1
```

```r
mtcars %>% 
  filter(mpg > 25) %>% 
  select(starts_with('m')|starts_with('c'))
```

```
##                 mpg cyl carb
## Fiat 128       32.4   4    1
## Honda Civic    30.4   4    2
## Toyota Corolla 33.9   4    1
## Fiat X1-9      27.3   4    1
## Porsche 914-2  26.0   4    2
## Lotus Europa   30.4   4    2
```
:::

## What about just a few lines of R?
Sometimes you will want to call R, run some code, and be done with R.<br>
You can call R, run a few lines, and quit in one go.<br>
Just add the flag `-e` (for _evaluate_) to the call to R,<br>
and put the R commands in quotes.<br>

:::tryit
Try the example below
(**note** that this will not work if you are still in R - be sure you are back in the terminal with the `%` or `$` prompt)

```bash
R -e "head(mtcars)"
```
:::
or this example - note that single or double quotes does not matter - as long as they match.

:::tryit
Try this

```bash
R -e 'install(palmerpenguins)'
```
:::
You can also string together several commands with the semicolon between them. 

:::tryit
Try the example below.


```bash
R -e 'library(palmerpenguins);data(penguins);tail(penguins)'
```
:::
## Running an R Script from the Terminal
Now we are stepping up a level - you have an R script that you have carefully created and saved as the `myscript.R` file. How do you run this from the Terminal?<br>
This is easy - just call the `Rscript` command with your file name. 

:::tryit
Pick out a short R file you have written, make sure you are in the right directory where the file is, and use it as in the example below.


```bash
Rscript myscript.R
```
:::
This launches R, runs your script, saves resulting output (if your script includes save or ggsave commands), closes R, and sends you back to the Terminal. Very simple.

## Rendering an Rmarkdown file from the Terminal
This is a little different, as you can't just run an Rmarkdown file. Normally you would use the dropdown button to knit your file from Rstudio. But you can use the `rmarkdown::render` command to render your files to HTML, PDF, Word, Powerpoint, etc. Pick out a simple Rmd file like `output_file.Rmd` below, make sure you are in the right directory where the file is, and try something like the example below. <br>
Note that this is one case where nesting different types of quotes (single vs. double) can come in handy.<br>
It helps to use single quotes around your filename and double quotes around the `rmarkown::render` command.

:::tryit
Try it out

```bash
Rscript -e "rmarkdown::render('output_file.Rmd')"
```
:::
So there you have it! <br>
Just enough to get you started with R from the command line.
<br>
<br>

:::explore
For further reading, check out these helpful links:

1. [Data Science at the Command line (e-book)](https://www.datascienceatthecommandline.com/1e/)
1. [R in Batch mode on Linux](http://www.cureffi.org/2014/01/15/running-r-batch-mode-linux/) 
1. [R tutorial for a Unix Environment](https://uwaterloo.ca/statistics-and-actuarial-science/research/resources/r-tutorial-unix-environment)
1. [The Linux Command Line: A Complete Introduction - a whole book on the topic](https://www.amazon.com/Linux-Command-Line-2nd-Introduction/dp/1593279523/ref=sr_1_12?crid=13X90SPNPT377&dchild=1&keywords=shell+scripting&qid=1599228400&s=books&sprefix=shell+scripting%2Caps%2C154&sr=1-12)
1. [Software Carpentry Command-Line Programs](https://swcarpentry.github.io/r-novice-inflammation/05-cmdline/)
1. [Scheduling jobs with cron](https://ole.michelsen.dk/blog/schedule-jobs-with-crontab-on-mac-osx/)
:::
