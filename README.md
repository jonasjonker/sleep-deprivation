# sleep-deprivation
A statistics project on sleep deprivation.

## tools
For this project we use R for all statistical analysis. Within R the use of packages from the [Tidyverse](https://www.tidyverse.org/) package collection is prefered for data wrangling, analysis and visualization.

Reports are written in [R Notebooks](https://rmarkdown.rstudio.com/lesson-10.html) using [R Markdown](https://rmarkdown.rstudio.com/lesson-1.html).

https://r4ds.had.co.nz/r-markdown.html (an introduction chapter)

Additional documentation (like this document) are written in normal [Markdown](https://guides.github.com/features/mastering-markdown/)

## Style guide
To make R code look uniform (and therefore readable) you should try to adhere to the [Tidyverse styleguide](https://style.tidyverse.org/)

## basics git workflow
To work on this project on your own machine you should clone it

```bash
git clone https://github.com/jonasjonker/sleep-deprivation.git
``` 

If you want to change a file in this project it is generally a good idea to: create a new branch, start working in that branch, make/change files, and then send a pull request. After code review the changes can be merged into the master branch. Since this project is quite small, you should feel free to just add new files direclty to the master branch if you don't want your code reviewed. 

So step by step the procedure should be:

##### make a new branch
```bash
# make a new branch
git branch <branch_name>

# change the branch you are working in
git checkout <branch_name>

### add, remove, change things to some file(s)

# add and commit files
git add <file_name>
git add .              # all changed files at once
git commit -m "short descriptive message"

# push files to origin (or to another remote)
git push origin <branch_name>

### repeat add, commit push cycle until happy with result

### go to github page and click on "create pull request" to add your files to the master branch.
```

Some usefull commands
```bash
# check if there are files that need adding or committing
git status

# get changes with original
git fetch

# show differences between your file(s) and the original
git diff <branch_name> origin/<branch_name>

# check for changes in original and update your files
git pull
```


## Links
- [git workflow overview (youtube)](https://www.youtube.com/watch?v=8UguQzmswC4)
- [git tutorial series (youtube)](https://www.youtube.com/watch?v=BCQHnlnPusY)
- [git cheatsheet](https://github.github.com/training-kit/downloads/github-git-cheat-sheet.pdf)
- [git documentation](https://git-scm.com/book/en/v2/Git-Basics-Getting-a-Git-Repository)
- [markdown cheatsheet](https://guides.github.com/features/mastering-markdown/)
- [paper on sleep deprivation](https://onlinelibrary.wiley.com/doi/epdf/10.1046/j.1365-2869.2003.00337.x)
