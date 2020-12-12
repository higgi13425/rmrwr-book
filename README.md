[![Netlify Status](https://api.netlify.com/api/v1/badges/acb42178-12c8-4ca2-ae3a-d596bd3c568e/deploy-status)](https://app.netlify.com/sites/rmrwr-book/deploys)

![bookdown](https://github.com/higgi13425/rmrwr-book/workflows/bookdown/badge.svg)

This is the Github repository for Reproducible Medical Research with R, a book about working toward more reproducible medical research using R and associated tools, particularly those developed by RStudio.

The book itself can be found [here](https://bookdown.org/pdr_higgins/rmrwr/)

## Goals

Making it easier to share data.     
Making it easier to create literate code, and share this code.     
Training the next generation of medical researchers to use ROpenSci tools, open research, and to encourage others to evaluate their data and their code to improve it.     


## Secondary Gains

A repository of Things I have Learned (TILs) that I might want to reference in the future.     
A repository of things I want to teach and share with medical research trainees.     

## Notes on how to publish to bookdown.org

1. Edit an existing chapter .Rmd file - naming convention is io##-Topic.Rmd
2. Create a new chapter .Rmd file - naming convention is io##-Topic.Rmd
3. Knit to check that everything works.
4. If a new chapter has been added and is ready for public viewing (not just draft form), add it to the list of chapters in order in `_bookdown.yml`, somwehere in between     
- index.Rmd and     
- io98-title_holder.Rmd
4. Render the book with `bookdown::render_book('index.html')`
5. Publish the book with `bookdown::publish_book(account = 'pdr_higgins')`
6. Then commit changes and push to github
7. Within a minute or three, the updated book will appear at https://bookdown.org/pdr_higgins/rmrwr/

More details can be found at https://bookdown.org/yihui/bookdown/rstudio-connect.html
and at
https://bookdown.org/home/about/ 
