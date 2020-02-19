# sleep-deprivation
A statistics project on sleep deprivation.

## tools
For this project we use R for all statistical analysis. Within R the use of packages from the [Tidyverse](https://www.tidyverse.org/) package collection is prefered for data wrangling, analysis and visualization.

Reports are written in [R Notebooks](https://rmarkdown.rstudio.com/lesson-10.html) using [R Markdown](https://rmarkdown.rstudio.com/lesson-1.html).

Additional documentation (like this document) are written in normal [Markdown](https://guides.github.com/features/mastering-markdown/)

## basics git workflow
To work on this project on your own machine you should clone it

```bash
git clone https://github.com/jonasjonker/sleep-deprivation.git
``` 

If you want to change a file in sthis project it is generally a good idea to: create a new branch, start working in that branch, make/change files, and then send a pull request. After code review the changes can be merged into the master branch. Since this project is quit small, you should feel free to just add new files direclty to the master branch if you don't want your code reviewed.
```bash
# make a new branch
git branch <branch_name>

# set branch to work in
git checkout <branch_name>

# show branches available
git branch --all
```
```bash
s
```


## Links
- [git workflow overview (youtube)](https://www.youtube.com/watch?v=8UguQzmswC4)
- [git tutorial series (youtube)](https://www.youtube.com/watch?v=BCQHnlnPusY)
- [git cheatsheet](https://github.github.com/training-kit/downloads/github-git-cheat-sheet.pdf)
- [git documentation](https://git-scm.com/book/en/v2/Git-Basics-Getting-a-Git-Repository)
- [markdown cheatsheet](https://guides.github.com/features/mastering-markdown/)
- [paper on sleep deprivation](https://onlinelibrary.wiley.com/doi/epdf/10.1046/j.1365-2869.2003.00337.x)
