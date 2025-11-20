---
title: "Running R from the UNIX Command Line"
author: "Peter Higgins"
date: "9/6/2020"
output: html_document
---



# Running R from the UNIX Command Line {#cmd-line}

## What is the UNIX Command line?
The command line is a very basic Terminal window with a prompt at which you can type commands, And do primitive but powerful things to your files. The UNIX computing environment was developed in the 1960s, and is still beloved and fetishized by brogrammers, who believe you are not truly a programmmer if you can't code from the command line. This is silly.
<br><br>
The major attraction to UNIX in the 1960s is that it was much better than punch cards.  Which isn't saying much. We have had 60 years of software advancement and user interface improvements, so we (most of time) should not have to put up with the inherent user hostility of the UNIX environment.
<br><br>
UNIX is an early operating system, which is built around a 'kernel' which executes operating system commands, and a 'shell' which interprets your commands and sends them to the kernel for execution. The most common shell these days is named 'bash', which is a silly recursive brogrammer joke. You will sometimes see references to shell scripts or shell or bash programming. These are the same thing as command line programming.
<br><br>
UNIX is a common under-the-hood language across many computers today, as the Apple iOS is built on top of UNIX, and the various versions of the LinuxOS are built on a UNIX-like kernel, with a similar command shell. 
<br><br>
The command line is often the least common denominator between different pieces of open-source software that were not designed to work together. It can occasionally be helpful to build a data pipeline from mismatched parts.
 However, there is a lot of low-quality user-hostile command line work involved to get it done, commonly referred to as "command-line bullshittery". This is a common bottleneck that slows scientific productivity, and there is a vigorous discussion of it on the interwebs [here](https://pg.ucsd.edu/command-line-bullshittery.htm) and [here (a counterpoint)](https://medium.com/@eytanadar/on-the-value-of-command-line-bullshittery-94dc19ec8c61). Essentially, some argue that it is largely a waste of time and effort, while others see it as a valuable learning experience, like doing least squares regression by hand with a pencil.
<br><br>
Running R from the command line is a bit like spending a day tuning your car's engine by yourself. There is a case to be made that this will improve the efficiency and performance of your car, but it is also usually more efficient to pay someone else to do it, unless you are a car expert with a lot of free time.

## Why run R from the command line?

You can run R from the command line. It has none of the bells and whistles, nor any of the user conveniences of the RStudio Interactive Developer Environment (IDE). But it is how R was originally expected to be used when it was developed back in 2000 in New Zealand.
<br><br>
Running R from the command line allows you to do powerful things, like process multiple files at once, which can be handy when you have multiple files of sequencing data from distinct observations, or you have a multistep data wrangling pipeline with several slow steps. For many years, this was the only way to easily apply code across multiple files to build a complex data pipeline.
<br><br>
This is much less true today, with tools to handle file paths like the {here} and {fs} packages, run Python scripts from R with the {reticulate} package, run C++ scripts with Rcpp, and run bash, python, SQL, D3, and Stan scripts from Rmarkdown. You can use the {targets} package to manage multi-step data pipelines in different languages (similar to _make_). But some labs have been doing things at the command line for years, and find it hard to change.

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
Let's start with a introductory command, which can't do any harm. Run the command below:<br>
`whoami`


``` bash
whoami
```

```
## peterhiggins
```
:::

Remember that UNIX started out as an operating system for terminals, and knowing who was logged in was a helpful thing, especially if the person logged in was being charged for mainframe time by the minute.
<br><br>
You can string together two commands with a semicolon between them. <br>

:::tryit
Try the following:

``` bash
whoami;date
```

```
## peterhiggins
## Thu Oct  9 16:39:42 EDT 2025
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


``` bash
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


``` bash
cd ..
```
:::

`cd ..` changes the directory `up` one level closer to the root directory. Note that there is a **required** space between `cd` and the `..`. You can also go directly to the root directory with `cd /`. It is straightforward to go up the directory tree, as each folder only has one `parent`. But it is tricky to go down the directory tree, as there are many possible branches/children, and you do not inherently know the names of these branches. We need to list the contents of your current directory with `ls` to know what is there. 

:::tryit
Try the `ls` command in your Terminal window


``` bash
cd /Users/peterhiggins/Documents/;
ls
```

```
## (19) Higgins-Peter_Efficacy-and-Safety-of-Upadacitinib-recorded.mp4
## (19) Higgins-Peter_Efficacy-and-Safety-of-Upadacitinib-recorded.pptx
## (19) Higgins-Peter_Efficacy-and-Safety-of-Upadacitinib-with-BackupBioIR.pdf
## (19) Higgins-Peter_Efficacy-and-Safety-of-Upadacitinib-with-BackupBioIR.pptx
## {"Attachments"-[{"__type"-"F.textClipping
## ~$ Severe UC Protocol.docx
## ~$Big data with Arrow and DuckDB with demo.pptx
## ~$cipeTin Lentil Chickpea Coconut Curry.docx
## ~$e crust recipe.docx
## ~$Jun2021_ibdTrials.pptx
## ~$sk List 2020-5.docx
## ~$sk List 2020.docx
## ~$sk List 2021.docx
## ~$T Review Higgins.docx
## 1FQ_Crohn's Disease_23Oct2020 (002).doc
## 2 - AbbVie UC Core - Unmet Need_C2 (14) 738 PM ET.pptx
## 2 - AbbVie UC Core - Unmet Need_C2 (14) 954PM ET.pptx
## 2 - AbbVie UC Core - Unmet Need_C2 (7)  Dr. H_PDRH_15Nov.pptx
## 2 - AbbVie UC Core - Unmet Need_C2_PDRH_29Sep.pptx
## 2012 resubmission
## 2020_Higgins_ClinResIBD_biosketch.doc
## 2020-Jun-05 AGA IMIBD meeting notest.docx
## 2021 AGA Invited Speaker Session Basic Hybrid Example.pdf
## 2021-07-13_Higgins_WH_signed_letter.docx
## 2021.Biobanking Program_InVivo_DRAFT-6.14.2021.docx
## 2021.Biobanking Program_InVivo_PDRH-6.21.docx
## 2021.Higgins AGA Distinguished Clinician.CO.docx
## 2022.10.19_MH_CCC_V2_PDRH.docx
## 203ClareScenes080119 copy.pdf
## 26NovEdits PDRH_Databank_Protocol v7_14Nov2016_Clean_.doc
## 2PM talks
## A Disease Monitoring Smart Set_PDRH.pptx
## A is for Allspice.2.0.docx
## A is for Allspice.docx
## A_Woodward_Score Sheet_PDRH.docx
## Abbott PtVideo 2010 Grant App
## Abbott Talks
## Abbvie 2021.xlsx
## AbbVie_Contract_2021_K000013379_-_Peter_Higgins.pdf
## AbbVie_Contract_K000013378_-_Peter_Higgins_2021_adhoc.pdf
## Abbvie_DocuSign_Dr_Higgins_Invoice.docx.pdf
## Abstract examples
## ABT combo proposal Bcl2:JAK
## ABT263_HIO_report_toWord.docx
## Accounts and Access (1) (1).docx
## ACG abstracts
## ACG U-ACHIEVE and U-ACCOMPLISH.docx
## ACG_slideformat_ACG22_White_Background.pptx
## ACG21_P19_Efficacy and Safety of Upadacitinib Induction Therapy in Patients With Moderately to Severely Active Ulcerative Col_vSub.pptx
## ACLS eCard Peter Higgins.pdf
## Advice for participants in webinars.docx
## Advice for young mentors.docx
## AGA DDW 2021
## AGA IMIBD
## AGA IMIBD Councilor Career Discussion Guide.docx
## AGA IMIBD Webinar Outline.docx
## aga institute council july 2020 meeting.pdf
## AIBD agreement.docx
## AIBD CAM Higgins.pdf
## AIBD CAM Higgins.pptx
## AIBD SoMe Higgins.pdf
## AIBD SoMe Higgins.pptx
## AIBD20Template.pptx
## AJGeditorial w Fletcher MRI 2015
## algorithms_thiopurine.pdf
## AMAG DDW Clear draft_PDRH comments.docx
## Animation of NSAID.pptx
## APG1244_Milestone_report.docx
## Apple Pie Day 1.docx
## Apple Pie Day 2.docx
## Apple Pie Filling Nov 2024.docx
## Apple Pie ingredients.docx
## Applicant Research Design Task T32.docx
## Applying for Fellowship in Gastroenterology and Hepatology.docx
## ARead_RAC-Review_PHiggins.docx
## AS Propsal outline.docx
## ASatishchandran Propsal outline.docx
## Ashley_Simone letter rec.docx
## ASUC_UC_protocol_comments_2020.docx
## Autoimmune Summit.pptx
## Awais Chapter Stenosis
## AXL_fibrosis_Nov_2021.pptx
## AXL_Helmsley_pre-proposal_Higgins.docx
## AxlI data for Helmsely.pptx
## B2. US Accomplishments.docx
## B4_IBD_pdrh.docx
## B4_IBD_pdrh.pdf
## Base R Notes.docx
## base-r-cheatsheet.pdf
## Beginners_GuideToR.pdf
## Best Practices Perils Excel
## Big data with Arrow and DuckDB with cameo.pptx
## Big data with Arrow and DuckDB with demo.pptx
## Big data with Arrow and DuckDB.pptx
## biomakers_fibrosisPDRH.docx
## Biorepository rebuttal for P30 Core.docx
## Biosketch for K.pptx
## Biosketch_2020_Higgins_ClinResIBD_biosketch.doc
## BKochar_Frailty.pdf
## blue_down_arrow - Gravit Designer.html
## BM recommendation.docx
## bmj_imputation.pdf
## Book1.csv
## bowel disease_2108_PDRH.docx
## Brazil 2015
## Brazil.ItineraryNov2015.docx
## Butter BCS Chicken.docx
## CADHUM
## CalenK08referenceLetter_PDRH_2023.docx
## CalenK08referenceLetter_PDRH_2023.pdf
## CaltechCampus Tour & Information Session.webarchive
## Cancel Appt Epic.ppt
## CAS.career.goals.obj.development.training_PDRH.docx
## CAS.K.candidate.background_SB_PDRH.docx
## CAS.T32.Project.Description-JS.docx
## Causal.png
## CB6 and JAK_stat.pptx
## CB6 manuscript YF.docx
## CC360_The Risk of SARS.docx
## CC360_The Risk of SARS.R1.docx
## CCC_AZ_UC Case 1_COMPLETE.pptx
## CCF IBD Webcast 2020 Draft Deck_For Review.pptx
## ccf_verily.docx
## CCFA EIC Candidate Interview Questions (candidates) jobin[1].doc
## CCFA Microbiota grant
## CCFA Reviewing
## CCFA SRA Microbiome 2011
## CDC_proposal1.1.docx
## CellDeath_DDW_2021_ISS.pdf
## cgh_factors_utilization.pdf
## Chat and links from R.docx
## Chu RPG Review_PDRH.docx
## CIMI revise
## Clare Higgins Final
## Clare Investment Summary.docx
## CLARE STOCKS.docx
## clare_stocks_long_term.xlsx
## Cleaning Medical Data.docx
## Cleveland.2010Trip
## Clinical Coordination and Intense Proactive Monitoring to Improve Utilization of Resources and Reduce Expenditures in High.docx
## Clinical Research Alliance
## Closing remarks.docx
## Copy of Crohns Colitis Congress 2023 Pediatric Session Agenda 07.17.2022_pdrh.xlsx
## Council Conversations Author Chat Guide.docx
## Coursera_Programming in R Notes.docx
## Cover Letter.docx
## Cover Letter.pdf
## CoverLetterPlus.pptx
## COVID Trials Feasibility
## COVID_MPox_P2PEP22.pptx
## Crash&Burn_ScriptV2_100318 copy.pdf
## CTSU Protocol Checklist_v1_PDRH_Jan2022.docx
## CU104 UC Synopsis v0.4 15Nov2022_PDRH.docx
## Curacle CDA Higgins_20221011.docx
## cycling core exercises.docx
## CYSIF.pdf
## Data workflow resources.docx
## DataCamp Courses by Topic.docx
## DDW 2012 MTP Immunomodulator Talk
## DDW 2022 AGA Space Grid.xlsx
## DDW 2023 Fibrosis Talk.pptx
## DDW 2023 SoMe Talk- hellhole section.pptx
## DDW 2023 SoMe Talk.pptx
## DDW JAK for UC.pptx
## DDW2014SD16
## DDW2021 CB6 powerpoint-2.pptx
## DDW2021_CB6_Antifibrotic_Higgins.pdf
## DDW21_JAK_Higgins.pdf
## DeEscalationACG2016.pptx
## Demographics.pdf
## Documents
## Documents.Rproj
## draft letter to patients.docx
## Draft Postop IBD Surgery Care Protocols v2_SERedit.docx
## draft_GUILD_abstract.docx
## draft_tokenization letter Risa_Uste.docx
## DrHiggins IBD Data Request.xlsx
## early-career-faculty_Dec-2020.xlsx
## ECCO 2016 Amsterdam Schedule.docx
## ECCO 2019 UC PRO SS Abstract D1f_JP_UA_YO_AM_PDRH.docx
## ECCO 2022 abstract^LN2 UPA-UC P3 Disease DurationExtent_v3.0_18Oct2021_PDRH.docx
## ECCO 2022 UPA-UC Ext ind resp abstract_29Oct2021_PDRH.docx
## ECCO IHA3
## ECCO2016Lycera30937.pptx
## EDI statement.docx
## EDI statement.pdf
## Editing your Rprofile.docx
## Efava.pptx
## Effect of medications on the recurrence of cancer in IBD patients.docx
## Electrical engineering interview questions.docx
## Employee Evaluations
## Endpoints in IBD talks
## epic cancel_reschedule appointments.ppt
## epic schedule viewing_close.ppt
## escalator.html
## Europe Talks
## exercise1.xlsx
## exercise2.xlsx
## Exploring Docker.docx
## Faculty Covering Kinnucan Inbox.xlsx
## Faculty CV Review PPB Nov 2023.docx
## Faculty CV Reviewer Template_PDRH.docx
## Falk Symposium Miami 3.09
## FCP Sensor proposal draft.docx
## FDAtofaResponse.docx
## Feasibility and Pilot Studies.pptx
## Feb2021_ibdTrials.pptx
## fellow graduation 2020.docx
## FellowshipRec_Janson Jacob_Higgins_JB.docx
## FellowshipRec_Janson Jacob_Higgins_JB.pdf
## FFMI Kickstart-FinalReport 5-20-16-LJ.docx
## Fibrosis
## Fibrosis lab talks
## Fibrosis Symposium
## FibrosisIBDCedars2016.pptx
## Figures for PractGast_Higgins_ASUC_2023.pptx
## Figures-KC-JAMA.pptx
## Finance and Retirement Plans.docx
## Financial Priorities.docx
## FITBITProtocol_28NOV2016_AbbVie.docx
## FITBITProtocol_4DEC2016_AbbVie.docx
## flag_contest_submission_PDRH.pdf
## Flexdashboard notes.docx
## FMT_DDW_2021_ISS.pdf
## Future_IBD_P2PEP22.pptx
## Garmin Notes.docx
## GCPcitiCompletionReport8018282.pdf
## General format for Chapters in RMRWR.docx
## General Social Media Tips.docx
## General thoughts about query letters.docx
## Getting Started with REDCap.docx
## GI T32 Competitive Renewal FINAL 05242017.docx
## Gibson_accel_IFX.pdf
## Gibson-Doherty_Editorial_2020_Article_FastAndCuriousAnAlgorithmicApp.pdf
## Git for MDs_2.pptx
## Git Fork and branch workflow.docx
## GitHub
## Github for MDs_1.pptx
## Github for MDs_3.pptx
## Glover_RPG_Review_PDRH.docx
## GoToMeeting Chats
## Govani2020_Article_UseOfAcceleratedInductionStrat.pdf
## GradPartyHigginsInvites.xlsx
## GrandRounds
## GREAT3 slides
## GreatLakesDiscovery PCS Axl Higgins Clasby.docx
## Helmsley Application Nov 2023.docx
## hershey_long_term.xlsx
## hexStickers.jpg
## Higgins AGA Webinar Slides.pptx
## Higgins Bio.docx
## Higgins Biosketch 2022.docx
## Higgins biosketch2015KRao.doc
## Higgins biosketch2016KRao.doc
## Higgins New IBD.pptx
## Higgins Other Support 2021-2.docx
## Higgins Other Support 2021.docx
## Higgins Other Support.docx
## Higgins Refractory Proctitis.pptx
## Higgins_ACG2021.docx
## Higgins_Annual_Review_2024.docx
## Higgins_Assessment_Promotion_AReinink_letterhead_sig.docx
## Higgins_Assessment_Promotion_AReinink_letterhead_sig.pdf
## Higgins_IBD_AtoZ.pptx
## Higgins_LOS_IBDBiobank_Shah_Nusrat_2019.docx
## Higgins_LOS_KNewmanAGA_PDRH.docx
## Higgins_LOS_KNewmanAGA_PDRH.pdf
## Higgins_LOS_KNewmanF32_letterhead_sig.docx
## Higgins_LOS_KNewmanF32_letterhead_sig.pdf
## Higgins_PCORI_COMET-UC_Short.pdf
## Higgins_Peter-The-Janus-Kinase-Inhibitors-Two-Faces-for-Efficacy-and-Safety.pptx
## higgins_signature.docx
## Higgins_UM_CME_Pregnancy in IBD.pptx
## Higgins-Peter_Efficacy-and-Safety-of-Upadacitinib-recorded.mp4
## Higgins-peter.jpg
## higgins2x3.jpg
## HigginsACGMidwest2019_PerioperativeIBD.pptx
## Higginslab server.pptx
## HigginsP_FY22_CY21 Faculty Eval_pdrh.docx
## HigginsPeter_ CY 2022 Faculty Evaluation .docx
## Histosonics article MLive 2023 .docx
## How To Assign PRO questionnaires -  Inpatient ASUC.docx
## How To Log in to IBD Server.docx
## How To Log in to RStudio Server for HigginsLab.docx
## How To Log in to RStudio Server for Shiny.docx
## HPI-5016 IBD Patient Contact Info.xlsx
## HS movie.docx
## IBD 2020 - Honorarium reimbursement Form.docx
## IBD and biologics tweets.docx
## IBD Biobank Cryostor.pptx
## IBD Center presentations
## IBD Clinical Chief Position.docx
## IBD Clinical Trials for MDsDearborn2017.pptx
## IBD Databank Talks on the Road
## IBD Drug Names.docx
## IBD House Call and Readmission Data .xlsx
## IBD in 20 years.pptx
## IBD inbox coverage.docx
## IBD Insurance Pilot Results.docx
## IBD Insurance Survey for CCFA Partners Existing.docx
## IBD J Club Miri extended induction.pptx
## IBD J Club Tofa in TNFexp.pptx
## IBD Jclub Nov22 Cyclo_Vedo ASUC.pptx
## IBD Journal Club 13Feb2017.docx
## IBD Journal Club July 11.docx
## IBD Options.pptx
## IBD Osteoporosis 1 27 2022_PDRH.docx
## IBD Plexus meeting 21 Sep 2015 notes.docx
## IBD School
## IBD School 322 Script.docx
## IBD School 324 Script.docx
## IBD School 325 Script.docx
## IBD video scripts ppt
## IBD_Deescalation_Apr_2019_PDRH.docx
## IBD_Endo_PDRH.docx
## IBDforLansing2017.pptx
## IBDInsuranceSurvey3.docx
## IBDMentoringConferenceCall4AbstractsPH.docx
## IBDSkinCa Copy.Data
## iBike Rides
## Ideas for CTA Phase 2.docx
## Image functions target.ai
## Image functions target.png
## imaging_stricture.xlsx
## IMG_0006.jpg
## IMG_0008.jpg
## IMG_1523st.jpg
## IMIBD Councilors 2020-21.docx
## IMIBD Partners insurance 2020DDW.pptx
## IMIBD Plenary Intro.pptx
## IMIBD_expanded_descriptors.xlsx
## INTERNAL_BUDGET_Abbvie_Nav_Rux_Sept_2021.xlsx
## introduce_clare.docx
## Introduction to Application Supplement Photoacoustic.docx
## Invoice 401 to Buhlmann.docx
## Invoice 401 to Buhlmann.pdf
## Invoice AV50559_Abbvie_PDRH_Dec2021.doc
## Invoice AV50559_Abbvie_PDRH_Dec2021.pdf
## Invoice_6.2.22_AV53797_PDRH.docx
## JAK_DDW_2021_ISS.pdf
## JAMA Review on CD.docx
## jama_cushing_crohn_review_2021.pdf
## JAMA_KC_Second JAMA.docx
## JAMA_Review_on_CD_Revisions_Tracked_Changes with edits_PDRH.docx
## JAMA.CD.Highlights_PDRH.docx
## JB_V1 Career Goals and Objectives 7.8.2020_PDRH.docx
## JB_V10 K23 Running Document.docx
## JB_V2 Candidate’s Background 7.7.2020_PDRH.docx
## JDix_Study_update.docx
## Jessica Sheehan Rec Letter Fellowship.docx
## Jessica Sheehan Rec Letter Fellowship.pdf
## Jessie Pfizer materials.docx
## Jessie Sheehan Projects
## Jordan_MH_Slides[72]  - PDRH.pptx
## Jun2021_ibdTrials [Autosaved].pptx
## Jun2021_ibdTrials.pptx
## Jun2023Vacation.docx
## K Award Institutional Letter of Commitment.pptx
## K Candidate Section.pptx
## K_R_NIH_biosketches_2022.pptx
## K105_Melmed_PROs in Practice_MB_bb_JLS.pptx
## K23 Aims - Shirley Cohen-Mekelburg 11.14.19.docx
## K23_morph_measurements_MockupManuscript_21JAN2019.docx
## KCRN Higgins Consulting Agreement for Curacle 7Oct2022.docx
## Kelli Porzondek_Performance_Review_Sep_2021.docx
## KP pdfs
## LASSO.pptx
## Learning R discussion Jeremy Louissaint.docx
## learnr app diagram.jpg
## learnr app diagram.pptx
## letter Lowrimore.docx
## Letter to Frank Hamilton.docx
## Letter_KNewman_K_MentorKamadaHiggins_PDRH_NK.docx
## Library
## Lin_Reviewer Score_PDRH.docx
## Links to drop during talk.docx
## Links to publications of Peter DR Higgins with AbbVie since 2020.docx
## List of Useful R Packages.docx
## Log in to IBD Server.docx
## LOI for CSI for RMed.docx
## LoR for Vitchapong Observer.doc
## LoR for Vitchapong Observer.pdf
## Low Enrollers ACD.xlsx
## Machine Learning Seville
## Managment of CD.pptx
## Manuscript v1.docx
## Manuscript v2.PDRH.docx
## McDonald, Nancy.pdf
## MCTSU QC Time to Activation (002).pptx
## MDOutReachIBDSlides
## medicaldata_image_hex.ai
## medicaldata_NHS_R_2021.pptx
## medicaldata_Rmedicine21.pdf
## medicaldata_Rmedicine21.pptx
## Megan McLeod Rec Letter Residency.docx
## MEI_2020_PH_W9.pdf
## MEI_2021_PH_W9.pdf
## MEI_2021_W9.pdf
## MEI_2022_PDRH_W9.PDF
## MEI_ACH_Wire Transfer Form.docx
## MEI_W9_2024.pdf
## MentoringAgendaDraftPH.docx
## Mertens_GUILD_LOR_PH.docx
## Mertens_GUILD_LOR_PH.pdf
## messy_bp.xlsx
## Meta analysis TB vs CD version 3.5.docx
## Michigan Medicine Gastroenterology Social Media Initiative.docx
## Michigan Medicine Model for COVID-19 Clinical Trial Oversight DRAFT (KSB 04.17.20)-AL-PDRH.docx
## Microbiota Forceps
## Microsoft User Data
## MIM-TESRIC PROTOCOL_Higgins_14Apr2020.docx
## MIM-TESRIC PROTOCOL_Higgins_26Aug2020.docx
## MM letterhead UMICH.docx
## mockstudy manuscript draft.docx
## MultidisciplinaryIBDClinicPHv2.docx
## nejm_indomethacin.pdf
## nejm_statins.pdf
## nejm1966_beecher_ethics.pdf
## NordicTrackTC9iTreadmillManual.pdf
## Noro paper
## NoStairs.docx
## Notes on Spatial data workshop.docx
## Oct2019payPDRH.PDF
## Odd college lists.docx
## orange_green_down_arrow - Gravit Designer.html
## orange_green_down_arrow- Gravit Designer.pdf
## Orzo Salad from Kathryn and Bob.docx
## Orzo salad.docx
## P Singh K grant aims 8-25_PDRH.docx
## P2PEP slide 2020
## P2PEP slide 2020.pptx
## P2PEP2021_IBD_COVID.pptx
## P2PEP2021_Intro.pptx
## P2PEP2021_Spatial.pptx
## Package List recruit
## Pain in IBD.pptx
## Patient Reported Outcome DomainsCCF_Feb2025.docx
## Patient Reported Outcomes Plan.docx
## PDRH endowed chair bio.docx
## PDRH short bio.docx
## pdrh_IBD_email.xlsx
## Pearson 5 Notes.docx
## Ped trial draft.docx
## Perils of Excel.pptx
## personal statement fellowship_PDRH.docx
## Personal statement version 3!.docx
## Peter Higgins 2021 Vision Statment for the NSAC.docx
## Peter Higgins_Annual_Review.docx
## Peter_Higgins_photo_headshot.jpg
## peterhiggins.jpg
## Pfizer_Contract_for_Peter_Higgins_-_RD-20-D11.pdf
## PHcv2019.docx
## PHcv2020.docx
## PHcv2022.docx
## PHcv2022.pdf
## Pictures
## Pie crust recipe.docx
## pink_down_arrow - Gravit Designer.html
## pink_up_arrow - Gravit Designer.pdf
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
## Prj21015 UPA UC Other PROs manuscript D1 jp_JOL wz-di_JT_PDRH.docx
## PRO agenda videos VINDICO.docx
## PRO letter.docx
## Proposal for MCTSU Study Accrual Monitoring.docx
## PROs and Endpoints
## PS_K grant aims 6-25_PDRH.docx
## PtEdOnRoad
## PTM LOS From PDRH.docx
## PTM LOS From PDRH.pdf
## Purdue Disclosure Form_Higgins.docx
## Pyoderma Case
## Question 16.docx
## Quiros SRA- Higgins LoS draft_PDRH.docx
## Quiros SRA- Higgins LoS draft_PDRH.pdf
## R_Medicine 2023 - Friday intro slides.pptx
## R_Medicine 2023 - Thursday intro slides.pptx
## R_Medicine 2024 - Friday intro slides.pptx
## R_Medicine 2024 - Thursday intro slides.pptx
## R-medicine2024 sponsor prospectus text.docx
## R01 Fibrosis 2012
## R01 MachineLearn2010
## R01 ML revision
## R01.US.Revision
## RAC Update form.docx
## Ramp up clinical research_PH.xlsx
## Ramping up human subject research - MM 6-1-20 _KDA_PDRH_suggestions.docx
## RCode
## Rec_Letter_Simone_Ashley.docx
## RecipeTin Lentil Chickpea Coconut Curry.docx
## Recordings
## Regueiro Chapter
## rehab schedule.docx
## Reply_JAMA_Thiopurines.docx
## Research Statement.docx
## Research Statement.pdf
## Review Criteria for COVID Clinical Trials.docx
## Review guidelines_2017.docx
## Rice recipes
## RMed 2023 Meeting 15 Mar.docx
## RMed21- Intro to Spatial.pptx
## RMed21-Opening remarks Day 1.pptx
## RMed21-Opening remarks Day 2.pptx
## RMRWR chapters.docx
## Roasted Salted Cashews.docx
## RPPR Checklist .docx
## Ryan CDA
## Ryan K
## S is for Saffron 3.0.docx
## S is for Saffron 3.1.docx
## S is for Saffron 3.2.docx
## S is for Saffron.2.0.docx
## SAINI-LOK-HIGGINS_T32 GI Fellowship Research Presentation 08292021.pptx
## Scanner pictures
## Scheduling Epic Schedule.pptx
## Scheduling Epic Schedules.pptx
## SCM Mentor Letters.docx
## Scoring Sheet Ames_pdrh.docx
## Scoring Sheet_Albin_PDRHiggins.docx
## Scoring Sheet_Hayek_pdrh.docx
## Scoring Sheet_Janda_PDRHiggins.docx
## Screenshot 2025-06-15 at 6.06.29 PM.png
## Screenwriting Contests.docx
## SDOH.png
## Sean Common App academic honors list.docx
## Sean Common App activities list.docx
## Sean Higgins Bordogni.mp4
## Sean Higgins Brag Sheet.docx
## Sean Investment Summary.docx
## Sean Resume Tabular VBorder.docx
## Sean Resume Tabular.docx
## Sean Resume.docx
## SEAN STOCKS.docx
## Sean Summer Priorities 2016.docx
## Seattle Talk Dec 2012
## SecureIBD.pptx
## seq-6.pdf
## Severe UC protocol
## SevereUC_Tofa_Presentation_IBD_Forum.pptx
## SevereUC_Tofa_Presentation_Pfizer.pptx
## Shail CT
## ShareRmd.html
## Sheehan Pfizer IBD Fellowship.docx
## Sherman Prize Nominee Questions.docx
## Shoreline West Tour Information.docx
## Short PA slides.pptx
## Shotwave thread.docx
## Should we accel IFX - survey.pdf
## SIG_Template_IBD Program_FINAL.docx
## signature.docx
## signature.fld
## signature.html
## signature.pdf
## signature.png
## Signing Clinical Research Infusion Orders.pdf
## SingleCell_DDW_2021_ISS.pdf
## SkinCancer.IBD.Gentics_Yanhua_PDRH.docx
## Slade UC review Walter
## SMART Figure.png
## Social Media for GI.pptx
## SoMe_use_2020.png
## SOP for Samples for IBD Biobank.docx
## sorted_steno.xlsx
## Soulfege t shirts
## Source Code PT1.docx
## Specialty Pharmacist Referral Process_11162021.pptx
## SPECIFIC AIMS 2_PDRH.docx
## Specific Aims.pdf
## SPir abstract 2700
## Stairs.docx
## starting biologics.pptx
## Stelara paper_revised_PDRH_KCC.docx
## Stelara paper.docx
## stiff_bcl.R
## Structure of Aim 3.docx
## submitJanssen_IBD School Videos_12Jul2018.pdf
## Surgery Topics
## Surveys
## T32 Competitive Renewal 2017 FINAL WM.pdf
## T32 Fellowship Annual Orientation 2022.pptx
## T32 summary statement.pdf
## T32_current_text_14June2019.docx
## TabaCrohn IBD J club.docx
## Tables.docx
## Taiwan talks
## Takeda Grants_Letter of Request_IBD School Videos_Medication Series_2018_.docx
## Takeda_IBD School Videos_Submission.pdf
## Task List 2020-2.docx
## Task List 2020-5.docx
## Task List 2020.docx
## Task List 2021.docx
## Task List 2022.docx
## Task List 2024.docx
## Tenure Plan
## Testing signatures with Adobe.pdf
## The Innovative IBD Center.docx
## The Risk of SARS.R1.Markup.docx
## Thiopurine talks Manitoba 2011
## Thiopurines talks Vandy
## Tidymodels.docx
## tidyr_pivot.png
## tidyr_pivot.xcf
## Timelines for K submission.pdf
## Timelines for K submission.pptx
## Tips for Submitting DDW Abstracts for 2022.docx
## Tofa in ICI Figure Legends_Final Draft_V2.docx
## Tofa Inpatient
## Tofa inpatient induction Protocol_02NOV2018_PHforEdits.docx
## tofa_checkpoint.pdf
## Tofa_Presentation_2_10_2021.pptx
## Toffee Separation Tips.docx
## Topics to Discuss with Bill.docx
## TOPPIC ML draft v5SCM_YL_AKW_PDRH.docx
## Trip to Hawaii 2023 GUILD.docx
## twitter.com.webarchive
## UC and CD Impact Manuscript_Draft 2_9Jan2022_PDRH.docx
## UC and CD Impact Manuscript_Draft1_19Feb2021_PDRH.docx
## UC CD Impact Manuscript Tables__19Feb2021_PDRH.docx
## UC_protocol_comments_2020.docx
## UC2.jpg
## UCB Pt video 2010 Grant App
## ucla1.jpg
## UCRx_DDW_2021_ISS.pdf
## UEGW 2010
## UEI stidham files
## UM IBD Clinical Trials IBD referral form.docx
## UM Severe UC Protocol.docx
## UM Severe UC Protocolv3.0.docx
## untidy_sheets.pptx
## Untitled.docx
## Upa ASUC Concept Page.docx
## Upa IBD J Club.pdf
## Upa IBD J Club.pptx
## Upa M14-234 SS3 maintenance  Q and A ECCO 2022.docx
## Upa outpatient vs Prednisone_PDRH.docx
## UPA_U_ACHIEVE 1st draft_PDRH.docx
## Urgent care clinic IBD.docx
## US_R01 outcomes I.1_Dillman.docx
## US_R01 outcomes I.1.docx
## user_testing_learnr tutorials.pptx
## V8 Infliximab Outcomes_PDRH.docx
## VideoVisitSchedulingQuickApptsforProviders.pdf
## VincentChen_K specific aims 2020-10-25.docx
## VINDICO IBD
## VINDICO_PRO.pptx
## VirtualPtEdMar2020.v2.pdf
## Walk Letter of Reference.docx
## Walk Letter of Reference.pdf
## WebEx
## Wedding Dance Songs.docx
## Weekly Clinical T32 Seminar 2023.docx
## weiser_topics.docx
## wga_min20.pdf
## Why not excel.docx
## Zoom
## Zwift
## zwift_training_pacepartner.xlsx
## Zwift-Gift-Card.pdf
```
:::

You will see a listing of all files and folders in the current directory. You can get more details by adding the option (sometimes called a `flag`) `-l`


``` bash
cd /Users/peterhiggins/Documents/;
ls -l
```

The full listing will give you more details, including read & write permissions, file size, date last saved, etc. <br>
Many UNIX commands have options, or flags, that modify what they do.
<br><br>
Find a folder inside of your Documents folder. We will now go `down` a level in the directory tree. In my case, I will use the `Powerpoint` folder. <br>
In your Terminal window:

:::tryit
- change the directory to the Powerpoint directory
- list the contents of this folder

``` bash
cd /Users/peterhiggins/Documents/Powerpoint;
ls
```

```
## 2016IBDClinTrialsforMDsDearborn.pptx
## 2016IntegratedDeckorMDsGB.pptx
## 2019 SCSG GI Symposium IBD SoA  -  Read-Only.pptx
## Acutely Ill IBD Patient protocol for ADTC-RWS.docx
## ADTC Flowchart-draft-RWS_14FEB2015.docx
## Annual Research Career Review 2021PH.pptx
## BE LGD Dearborn 2016.04.12.pptx
## CCF_Clinical_Trials.pptx
## CP1_Higgins Intro.pptx
## CP2_DiagnosingIBD_KC.pptx
## CP3_FMT_MMM.pptx
## CP4_SurgeryRegenbogen.pptx
## CP5_NutritionIBD_EH.pptx
## CP6_Infections2018.pptx
## CP7_PsychologicalStress_Riehl IBDFlint2018.pptx
## CP8_SteroidsWaljee.pptx
## CP9_ClinicalTrials2018.pptx
## ECCO 2022 UPA-UC ext duration oral_v2.0_3Feb2022_for QC.pptx
## ECCO22_Template.pptx
## Feasibility and Pilot Studies CTA.pptx
## FibrosisIBDCedars2016.pdf
## Getting Started in RStudio.pptx
## Higgins CCFA CTPROs in IBD.pptx
## Higgins CCFACT2017FundingClinicalResearch.pptx
## Higgins HK 2017IBD Nursing and Quality of Care.pptx
## Higgins HK 2017The Gut Microbiota and the Pathophysiology of IBD.pptx
## Higgins Microbiota for IBD Patient Ed.pptx
## Higgins_CCC_2018_Refractory_Rising_Bar_v3.pptx
## HigginsAI talk for DDW2019.pptx
## HigginsDec2018AJG_SmokingStatus.pptx
## HigginsFALKMadridThioMtx2017.pptx
## IBD and PTSD.pptx
## IBD Part 1 Higgins USMN.pptx
## IBD Part 2 Higgins USMN.pptx
## IBD Part 3 Higgins USMN.pptx
## IBD Part 4 Higgins USMN.pptx
## ibd_meds_surgery_metan.pptx
## IBDUpdate.pptx
## Integrated Slide Deck Dearborn 2016.04.12.pptx
## IOIBD.Fibrosis.Higgins.2018.Amsterdam.pptx
## MER Stress Management Dearborn 4-14.pptx
## MichiganMedicine-IBDTemplate.potx
## Outcome Measures CTA.pptx
## PDR_Higgins_DeficienciesInIBD_AIBD2021.pptx
## PDRH RCR 2020.pptx
## PennThioMTX2017Higgins.pptx
## Pilot Feasibility Studies.pptx
## PragueRefractoryRisingBar2017.pptx
## Pregnancy in IBD.pptx
## Presentation1.pptx
## Regenbogen CRS for GI CME Course2016.pptx
## Senior Slide Show.pptx
## Social Media for GI.pptx
## SuperRough AI.pptx
## T32 Fellowship Annual Orientation 2023.pptx
## T32 GI Clinical Pink Sheet analysis.pptx
## T32 GI Fellowship Presentation 2023.pptx
## ThomsonRectalStumpComplicationsIBD2_13.pptx
## UEGweek2020.pptx
## UMHS IBD ADTC Encounter Note-DRAFT-RWS_15FEV2015.docx
## UMHS Talk- Moving Beyond AntiTNF 4-2016 FINAL v2.pptx
## UMich COVID-19  IBD.pptx
## Update on COVID and IBD.pptx
## Vertebrate Animals for K.pptx
## VirtualPtEd_2022_Deck.pptx
## VirtualPtEd_2022_Feb.pptx
## VirtualPtEdMar2020.v2.pptx
## VirtualPtEdMar2022Jan.pptx
## Writers Room.pptx
```
:::

Great!<br>
You moved to a new directory and listed it.<br>
Now we will get fancy, and make a new directory within this directory with the `mkdir` command.<br>

:::tryit
Try this in your Terminal window:


``` bash
pwd;
mkdir new_files;
ls
```
:::

You have now made a new directory (folder) within the previous directory (`pwd` = present working directory), named `new_files`. Verify this in your Documents folder.<br> 
You can now make changes to this directory <br>
and list the contents (it should currently be empty).<br>


:::tryit
Try this out in your Terminal Window (**note** edit the `cd` command to your own directory path).


``` bash
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

``` bash
touch file_name;
ls
```
:::

You can also create a file with data inside it with the `cat >` command.

:::tryit
Type in the following lines into your Terminal window. When complete, type control-D to be done and return to the Terminal prompt.
`cat` stands for concatenate.


``` bash
cat > file2.txt
cat1
cat2
cat3
```
:::

Now you can list the contents of this file with the `cat` command below.

:::tryit
Give this a try

``` bash
cat file2.txt
```
:::

You can also list the directory of your `new_files` folder with ls to see the new folder contents.

:::tryit
Try this

``` bash
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
Now you can add UNIX commands (separated by a semicolon) to this code chunk, like


``` bash
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

``` bash
pwd;
rm file2.txt;
cd ..;
rmdir new_files
```
:::

Verify all of this in your Documents window.<br>
This is great. But you can imagine a situation in which you mistakenly `rm` a file (or directory) that you actually needed. Unlike your usual user interface, when a file is removed at the command line, it is gone. It is not in the trash folder. It is **really** gone. There is something to be said for modern user interfaces, which are built for humans, who occasionally make mistakes. Sometimes we do want files or folders back.

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

``` bash
R
```
:::

You get the usual R intro, including version number, and the `R>` prompt.<br>
Now you can run R in interactive mode with available datasets, or your own datasets.<br>


:::tryit
Try a few standard tidyverse commands with the mtcars dataset.<br>
Give the examples below a try.<br>     

You can use `q()` to quit back to the terminal (and reply "n" to **not** save the workplace image).

``` r
head(mtcars)
```

```
##                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
## Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
## Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
## Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
## Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
```

``` r
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
You can add the flag `-e` (for _evaluate_) to the call to R,<br>
and put the R commands in quotes.<br>

:::tryit
Try the example below
(**note** that this will not work if you are still in R - be sure you are back in the terminal with the `%` or `$` prompt)

``` bash
R -e "head(mtcars)"
```
:::
or this example - note that single or double quotes does not matter - as long as they match.

:::tryit
Try this

``` bash
R -e 'install.packages(palmerpenguins)'
```
:::

You can also string together several commands with the semicolon between them. 

:::tryit
Try the example below.


``` bash
R -e 'library(palmerpenguins);data(penguins);tail(penguins)'
```
:::
## Running an R Script from the Terminal
Now we are stepping up a level - you have an R script that you have carefully created and saved as the `myscript.R` file. How do you run this from the Terminal?<br>
This is straightforward - you can call the `Rscript` command with your file name. 

:::tryit
Pick out a short R file you have written, make sure you are in the right directory where the file is, and use it as in the example below.


``` bash
Rscript myscript.R
```
:::
This launches R, runs your script, saves resulting output (if your script includes save or ggsave commands), closes R, and sends you back to the Terminal. Very nice!

## Rendering an Rmarkdown file from the Terminal
This is a little different, as you can't just run an Rmarkdown file. Normally you would use the dropdown button to knit your file from Rstudio. But you can use the `rmarkdown::render` command to render your files to HTML, PDF, Word, Powerpoint, etc. Pick out a small Rmd file like `output_file.Rmd` below, make sure you are in the right directory where the file is, and try something like the example below. <br>
Note that this is one case where nesting different types of quotes (single vs. double) can come in handy.<br>
It helps to use single quotes around your filename and double quotes around the `rmarkown::render` command.

:::tryit
Try it out

``` bash
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
