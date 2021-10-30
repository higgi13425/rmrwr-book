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
## Fri Oct 29 18:59:08 EDT 2021
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
## /Users/peterhiggins/Documents/RCode/rmrwr-book
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
## (19) Higgins-Peter_Efficacy-and-Safety-of-Upadacitinib-recorded.mp4
## (19) Higgins-Peter_Efficacy-and-Safety-of-Upadacitinib-recorded.pptx
## (19) Higgins-Peter_Efficacy-and-Safety-of-Upadacitinib-with-BackupBioIR.pdf
## (19) Higgins-Peter_Efficacy-and-Safety-of-Upadacitinib-with-BackupBioIR.pptx
## 1FQ_Crohn's Disease_23Oct2020 (002).doc
## 2 - AbbVie UC Core - Unmet Need_C2 (14) 738 PM ET.pptx
## 2 - AbbVie UC Core - Unmet Need_C2 (14) 954PM ET.pptx
## 2 - AbbVie UC Core - Unmet Need_C2_PDRH_29Sep.pptx
## 2020-Jun-05 AGA IMIBD meeting notest.docx
## 2020_Higgins_ClinResIBD_biosketch.doc
## 2021 AGA Invited Speaker Session Basic Hybrid Example.pdf
## 2021-07-13_Higgins_WH_signed_letter.docx
## 2021.Biobanking Program_InVivo_DRAFT-6.14.2021.docx
## 2021.Biobanking Program_InVivo_PDRH-6.21.docx
## 2021.Higgins AGA Distinguished Clinician.CO.docx
## 203ClareScenes080119 copy.pdf
## A is for Allspice.2.0.docx
## A is for Allspice.docx
## ABT combo proposal Bcl2:JAK
## ABT263_HIO_report_toWord.docx
## ACG U-ACHIEVE and U-ACCOMPLISH.docx
## ACG21_P19_Efficacy and Safety of Upadacitinib Induction Therapy in Patients With Moderately to Severely Active Ulcerative Col_vSub.pptx
## ACLS eCard Peter Higgins.pdf
## AGA DDW 2021
## AGA IMIBD
## AGA IMIBD Councilor Career Discussion Guide.docx
## AGA IMIBD Webinar Outline.docx
## AIBD CAM Higgins.pdf
## AIBD CAM Higgins.pptx
## AIBD SoMe Higgins.pdf
## AIBD SoMe Higgins.pptx
## AIBD agreement.docx
## AIBD20Template.pptx
## AMAG DDW Clear draft_PDRH comments.docx
## APG1244_Milestone_report.docx
## ARead_RAC-Review_PHiggins.docx
## ASUC_UC_protocol_comments_2020.docx
## A_Woodward_Score Sheet_PDRH.docx
## AbbVie_Contract_2021_K000013379_-_Peter_Higgins.pdf
## AbbVie_Contract_K000013378_-_Peter_Higgins_2021_adhoc.pdf
## Abbvie_DocuSign_Dr_Higgins_Invoice.docx.pdf
## Accounts and Access (1) (1).docx
## Advice for participants in webinars.docx
## Animation of NSAID.pptx
## Applicant Research Design Task T32.docx
## Autoimmune Summit.pptx
## BKochar_Frailty.pdf
## BM recommendation.docx
## Base R Notes.docx
## Beginners_GuideToR.pdf
## Best Practices Perils Excel
## Biosketch for K.pptx
## Biosketch_2020_Higgins_ClinResIBD_biosketch.doc
## Book1.csv
## Brazil.ItineraryNov2015.docx
## Butter BCS Chicken.docx
## CAS.K.candidate.background_SB_PDRH.docx
## CAS.T32.Project.Description-JS.docx
## CAS.career.goals.obj.development.training_PDRH.docx
## CB6 and JAK_stat.pptx
## CC360_The Risk of SARS.R1.docx
## CC360_The Risk of SARS.docx
## CCF IBD Webcast 2020 Draft Deck_For Review.pptx
## CCFA EIC Candidate Interview Questions (candidates) jobin[1].doc
## CDC_proposal1.1.docx
## CLARE STOCKS.docx
## COVID Trials Feasibility
## CYSIF.pdf
## CaltechCampus Tour & Information Session.webarchive
## Cancel Appt Epic.ppt
## Causal.png
## CellDeath_DDW_2021_ISS.pdf
## Chu RPG Review_PDRH.docx
## Clare Investment Summary.docx
## Clinical Coordination and Intense Proactive Monitoring to Improve Utilization of Resources and Reduce Expenditures in High.docx
## Council Conversations Author Chat Guide.docx
## Coursera_Programming in R Notes.docx
## CoverLetterPlus.pptx
## Crash&Burn_ScriptV2_100318 copy.pdf
## DDW 2022 AGA Space Grid.xlsx
## DDW JAK for UC.pptx
## DDW2021 CB6 powerpoint.pptx
## DDW2021_CB6_Antifibrotic_Higgins.pdf
## DDW21_JAK_Higgins.pdf
## Data workflow resources.docx
## DataCamp Courses by Topic.docx
## DeEscalationACG2016.pptx
## Demographics.pdf
## Documents.Rproj
## DrHiggins IBD Data Request.xlsx
## Draft Postop IBD Surgery Care Protocols v2_SERedit.docx
## ECCO 2016 Amsterdam Schedule.docx
## ECCO 2019 UC PRO SS Abstract D1f_JP_UA_YO_AM_PDRH.docx
## ECCO 2022 UPA-UC Ext ind resp abstract_29Oct2021_PDRH.docx
## ECCO 2022 abstract^LN2 UPA-UC P3 Disease DurationExtent_v3.0_18Oct2021_PDRH.docx
## ECCO2016Lycera30937.pptx
## Editing your Rprofile.docx
## Effect of medications on the recurrence of cancer in IBD patients.docx
## Electrical engineering interview questions.docx
## FCP Sensor proposal draft.docx
## FDAtofaResponse.docx
## FFMI Kickstart-FinalReport 5-20-16-LJ.docx
## FITBITProtocol_28NOV2016_AbbVie.docx
## FITBITProtocol_4DEC2016_AbbVie.docx
## FMT_DDW_2021_ISS.pdf
## Feasibility and Pilot Studies.pptx
## Feb2021_ibdTrials.pptx
## FellowshipRec_Janson Jacob_Higgins_JB.docx
## FellowshipRec_Janson Jacob_Higgins_JB.pdf
## FibrosisIBDCedars2016.pptx
## Figures-KC-JAMA.pptx
## Finance and Retirement Plans.docx
## Financial Priorities.docx
## Flexdashboard notes.docx
## GCPcitiCompletionReport8018282.pdf
## Garmin Notes.docx
## General Social Media Tips.docx
## General format for Chapters in RMRWR.docx
## General thoughts about query letters.docx
## Getting Started with REDCap.docx
## Gibson-Doherty_Editorial_2020_Article_FastAndCuriousAnAlgorithmicApp.pdf
## Gibson_accel_IFX.pdf
## Git for MDs_2.pptx
## GitHub
## Github for MDs_1.pptx
## Github for MDs_3.pptx
## Glover_RPG_Review_PDRH.docx
## GoToMeeting Chats
## Govani2020_Article_UseOfAcceleratedInductionStrat.pdf
## GradPartyHigginsInvites.xlsx
## HPI-5016 IBD Patient Contact Info.xlsx
## HS movie.docx
## Higgins AGA Webinar Slides.pptx
## Higgins Bio.docx
## Higgins New IBD.pptx
## Higgins Other Support 2021-2.docx
## Higgins Other Support 2021.docx
## Higgins Refractory Proctitis.pptx
## Higgins biosketch2015KRao.doc
## Higgins biosketch2016KRao.doc
## Higgins-Peter_Efficacy-and-Safety-of-Upadacitinib-recorded.mp4
## Higgins-peter.jpg
## HigginsACGMidwest2019_PerioperativeIBD.pptx
## Higgins_ACG2021.docx
## Higgins_LOS_IBDBiobank_Shah_Nusrat_2019.docx
## Higgins_UM_CME_Pregnancy in IBD.pptx
## Higginslab server.pptx
## How To Assign PRO questionnaires -  Inpatient ASUC.docx
## How To Log in to IBD Server.docx
## How To Log in to RStudio Server for HigginsLab.docx
## How To Log in to RStudio Server for Shiny.docx
## IBD 2020 - Honorarium reimbursement Form.docx
## IBD Biobank Cryostor.pptx
## IBD Clinical Trials for MDsDearborn2017.pptx
## IBD Insurance Pilot Results.docx
## IBD Insurance Survey for CCFA Partners Existing.docx
## IBD Journal Club 13Feb2017.docx
## IBD Journal Club July 11.docx
## IBD Plexus meeting 21 Sep 2015 notes.docx
## IBD School 322 Script.docx
## IBD School 324 Script.docx
## IBD School 325 Script.docx
## IBD and biologics tweets.docx
## IBD inbox coverage.docx
## IBDInsuranceSurvey3.docx
## IBDMentoringConferenceCall4AbstractsPH.docx
## IBD_Deescalation_Apr_2019_PDRH.docx
## IBDforLansing2017.pptx
## IMG_0006.jpg
## IMG_0008.jpg
## IMG_1523st.jpg
## IMIBD Councilors 2020-21.docx
## IMIBD Partners insurance 2020DDW.pptx
## IMIBD Plenary Intro.pptx
## IMIBD_expanded_descriptors.xlsx
## INTERNAL_BUDGET_Abbvie_Nav_Rux_Sept_2021.xlsx
## Introduction to Application Supplement Photoacoustic.docx
## JAK_DDW_2021_ISS.pdf
## JAMA Review on CD.docx
## JAMA.CD.Highlights_PDRH.docx
## JAMA_KC_Second JAMA.docx
## JAMA_Review_on_CD_Revisions_Tracked_Changes with edits_PDRH.docx
## JB_V1 Career Goals and Objectives 7.8.2020_PDRH.docx
## JB_V2 Candidate’s Background 7.7.2020_PDRH.docx
## JDix_Study_update.docx
## Jessica Sheehan Rec Letter Fellowship.docx
## Jessica Sheehan Rec Letter Fellowship.pdf
## Jun2021_ibdTrials [Autosaved].pptx
## Jun2021_ibdTrials.pptx
## K Award Institutional Letter of Commitment.pptx
## K Candidate Section.pptx
## K105_Melmed_PROs in Practice_MB_bb_JLS.pptx
## K23 Aims - Shirley Cohen-Mekelburg 11.14.19.docx
## K23_morph_measurements_MockupManuscript_21JAN2019.docx
## K_R_NIH_biosketches_2022.pptx
## Kelli Porzondek_Performance_Review_Sep_2021.docx
## Learning R discussion Jeremy Louissaint.docx
## Letter to Frank Hamilton.docx
## Library
## Lin_Reviewer Score_PDRH.docx
## List of Useful R Packages.docx
## Log in to IBD Server.docx
## Low Enrollers ACD.xlsx
## MCTSU QC Time to Activation (002).pptx
## MEI_2020_PH_W9.pdf
## MEI_2021_PH_W9.pdf
## MEI_2021_W9.pdf
## MEI_ACH_Wire Transfer Form.docx
## MIM-TESRIC PROTOCOL_Higgins_14Apr2020.docx
## MIM-TESRIC PROTOCOL_Higgins_26Aug2020.docx
## MM letterhead UMICH.docx
## Managment of CD.pptx
## Manuscript v1.docx
## Manuscript v2.PDRH.docx
## McDonald, Nancy.pdf
## Megan McLeod Rec Letter Residency.docx
## MentoringAgendaDraftPH.docx
## Meta analysis TB vs CD version 3.5.docx
## Michigan Medicine Gastroenterology Social Media Initiative.docx
## Michigan Medicine Model for COVID-19 Clinical Trial Oversight DRAFT (KSB 04.17.20)-AL-PDRH.docx
## Microsoft User Data
## MultidisciplinaryIBDClinicPHv2.docx
## NordicTrackTC9iTreadmillManual.pdf
## Notes on Spatial data workshop.docx
## Oct2019payPDRH.PDF
## Odd college lists.docx
## P Singh K grant aims 8-25_PDRH.docx
## P2PEP slide 2020
## P2PEP slide 2020.pptx
## P2PEP2021_IBD_COVID.pptx
## P2PEP2021_Intro.pptx
## P2PEP2021_Spatial.pptx
## PDRH short bio.docx
## PHcv2019.docx
## PHcv2020.docx
## PRO agenda videos VINDICO.docx
## PRO letter.docx
## PS_K grant aims 6-25_PDRH.docx
## PTM LOS From PDRH.docx
## PTM LOS From PDRH.pdf
## Patient Reported Outcomes Plan.docx
## Pearson 5 Notes.docx
## Perils of Excel.pptx
## Personal statement version 3!.docx
## Peter Higgins 2021 Vision Statment for the NSAC.docx
## Peter Higgins_Annual_Review.docx
## Peter_Higgins_photo_headshot.jpg
## Pfizer_Contract_for_Peter_Higgins_-_RD-20-D11.pdf
## Pictures
## Pitch Letter - S is for Saffron.docx
## Pitching Notes.docx
## Poppy Eulogy backup.docx
## Poppy Eulogy.docx
## Possible Eastern College Tour.docx
## Powerpoint
## Prashant Rec Letter.docx
## Prashant Rec Letter.pdf
## PredictingIBD_DDW_2021_ISS.html
## PredictingIBD_DDW_2021_ISS.pdf
## Proposal for MCTSU Study Accrual Monitoring.docx
## Purdue Disclosure Form_Higgins.docx
## Question 16.docx
## Quiros SRA- Higgins LoS draft_PDRH.docx
## Quiros SRA- Higgins LoS draft_PDRH.pdf
## RCode
## RMed21- Intro to Spatial.pptx
## RMed21-Opening remarks Day 1.pptx
## RMed21-Opening remarks Day 2.pptx
## Ramp up clinical research_PH.xlsx
## Ramping up human subject research - MM 6-1-20 _KDA_PDRH_suggestions.docx
## Recordings
## Reply_JAMA_Thiopurines.docx
## Review Criteria for COVID Clinical Trials.docx
## Review guidelines_2017.docx
## Roasted Salted Cashews.docx
## S is for Saffron 3.0.docx
## S is for Saffron 3.1.docx
## S is for Saffron 3.2.docx
## S is for Saffron.2.0.docx
## SAINI-LOK-HIGGINS_T32 GI Fellowship Research Presentation 08292021.pptx
## SCM Mentor Letters.docx
## SEAN STOCKS.docx
## SIG_Template_IBD Program_FINAL.docx
## SPECIFIC AIMS 2_PDRH.docx
## Scoring Sheet_Albin_PDRHiggins.docx
## Scoring Sheet_Janda_PDRHiggins.docx
## Screenwriting Contests.docx
## Sean Common App academic honors list.docx
## Sean Common App activities list.docx
## Sean Higgins Bordogni.mp4
## Sean Higgins Brag Sheet.docx
## Sean Investment Summary.docx
## Sean Resume Tabular VBorder.docx
## Sean Resume Tabular.docx
## Sean Resume.docx
## Sean Summer Priorities 2016.docx
## SecureIBD.pptx
## SevereUC_Tofa_Presentation_IBD_Forum.pptx
## ShareRmd.html
## Sherman Prize Nominee Questions.docx
## Shoreline West Tour Information.docx
## Short PA slides.pptx
## Shotwave thread.docx
## Should we accel IFX - survey.pdf
## Signing Clinical Research Infusion Orders.pdf
## SingleCell_DDW_2021_ISS.pdf
## SkinCancer.IBD.Gentics_Yanhua_PDRH.docx
## SoMe_use_2020.png
## Social Media for GI.pptx
## Source Code PT1.docx
## Specific Aims.pdf
## Stelara paper.docx
## Stelara paper_revised_PDRH_KCC.docx
## Structure of Aim 3.docx
## T32_current_text_14June2019.docx
## TOPPIC ML draft v5SCM_YL_AKW_PDRH.docx
## TabaCrohn IBD J club.docx
## Tables.docx
## Takeda_IBD School Videos_Submission.pdf
## Task List 2020-2.docx
## Task List 2020-5.docx
## Task List 2020.docx
## Task List 2021.docx
## Testing signatures with Adobe.pdf
## The Risk of SARS.R1.Markup.docx
## Tidymodels.docx
## Timelines for K submission.pdf
## Timelines for K submission.pptx
## Tips for Submitting DDW Abstracts for 2022.docx
## Tofa Inpatient
## Tofa in ICI Figure Legends_Final Draft_V2.docx
## Tofa inpatient induction Protocol_02NOV2018_PHforEdits.docx
## Tofa_Presentation_2_10_2021.pptx
## Toffee Separation Tips.docx
## UC CD Impact Manuscript Tables__19Feb2021_PDRH.docx
## UC and CD Impact Manuscript_Draft1_19Feb2021_PDRH.docx
## UCRx_DDW_2021_ISS.pdf
## UC_protocol_comments_2020.docx
## UM IBD Clinical Trials IBD referral form.docx
## UM Severe UC Protocol.docx
## UPA_U_ACHIEVE 1st draft_PDRH.docx
## Upa ASUC Concept Page.docx
## Upa M14-234 SS3 maintenance  Q and A ECCO 2022.docx
## VINDICO_PRO.pptx
## VideoVisitSchedulingQuickApptsforProviders.pdf
## VincentChen_K specific aims 2020-10-25.docx
## VirtualPtEdMar2020.v2.pdf
## Walk Letter of Reference.docx
## Walk Letter of Reference.pdf
## WebEx
## Why not excel.docx
## Zoom
## Zwift
## Zwift-Gift-Card.pdf
## aga institute council july 2020 meeting.pdf
## algorithms_thiopurine.pdf
## base-r-cheatsheet.pdf
## biomakers_fibrosisPDRH.docx
## blue_down_arrow - Gravit Designer.html
## bmj_imputation.pdf
## cgh_factors_utilization.pdf
## clare_stocks_long_term.xlsx
## cycling core exercises.docx
## draft_tokenization letter Risa_Uste.docx
## early-career-faculty_Dec-2020.xlsx
## epic cancel_reschedule appointments.ppt
## epic schedule viewing_close.ppt
## escalator.html
## exercise1.xlsx
## exercise2.xlsx
## fellow graduation 2020.docx
## hershey_long_term.xlsx
## hexStickers.jpg
## higgins2x3.jpg
## iBike Rides
## introduce_clare.docx
## jama_cushing_crohn_review_2021.pdf
## learnr app diagram.jpg
## learnr app diagram.pptx
## letter Lowrimore.docx
## medicaldata_NHS_R_2021.pptx
## medicaldata_Rmedicine21.pdf
## medicaldata_Rmedicine21.pptx
## medicaldata_image_hex.ai
## mockstudy manuscript draft.docx
## nejm1966_beecher_ethics.pdf
## nejm_indomethacin.pdf
## nejm_statins.pdf
## orange_green_down_arrow - Gravit Designer.html
## orange_green_down_arrow- Gravit Designer.pdf
## pdrh_IBD_email.xlsx
## personal statement fellowship_PDRH.docx
## peterhiggins.jpg
## pink_down_arrow - Gravit Designer.html
## pink_up_arrow - Gravit Designer.pdf
## seq-6.pdf
## signature.docx
## signature.fld
## signature.html
## signature.pdf
## signature.png
## stiff_bcl.R
## submitJanssen_IBD School Videos_12Jul2018.pdf
## tidyr_pivot.png
## tidyr_pivot.xcf
## tofa_checkpoint.pdf
## twitter.com.webarchive
## ucla1.jpg
## untidy_sheets.pptx
## user_testing_learnr tutorials.pptx
## wga_min20.pdf
## zwift_training_pacepartner.xlsx
## {"Attachments"-[{"__type"-"F.textClipping
## ~$ Severe UC Protocol.docx
## ~$Jun2021_ibdTrials.pptx
## ~$T Review Higgins.docx
## ~$sk List 2020-5.docx
## ~$sk List 2020.docx
## ~$sk List 2021.docx
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
## 2016IBDClinTrialsforMDsDearborn.pptx
## 2016IntegratedDeckorMDsGB.pptx
## 2019 SCSG GI Symposium IBD SoA  -  Read-Only.pptx
## Annual Research Career Review 2021PH.pptx
## BE LGD Dearborn 2016.04.12.pptx
## CCF_Clinical_Trials.pptx
## Feasibility and Pilot Studies.pptx
## Getting Started in RStudio.pptx
## Higgins Microbiota for IBD Patient Ed.pptx
## HigginsDec2018AJG_SmokingStatus.pptx
## IBDUpdate.pptx
## Integrated Slide Deck Dearborn 2016.04.12.pptx
## MER Stress Management Dearborn 4-14.pptx
## MichiganMedicine-IBDTemplate.potx
## PDRH RCR 2020.pptx
## PennThioMTX2017Higgins.pptx
## Pregnancy in IBD.pptx
## Regenbogen CRS for GI CME Course2016.pptx
## Senior Slide Show.pptx
## Social Media for GI.pptx
## ThomsonRectalStumpComplicationsIBD2_13.pptx
## UEGweek2020.pptx
## UMHS Talk- Moving Beyond AntiTNF 4-2016 FINAL v2.pptx
## UMich COVID-19  IBD.pptx
## Vertebrate Animals for K.pptx
## VirtualPtEdMar2020.v2.pptx
## Writers Room.pptx
## ibd_meds_surgery_metan.pptx
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
