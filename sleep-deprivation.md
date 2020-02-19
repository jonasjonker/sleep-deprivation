R Notebook
================

This is an [R Markdown](http://rmarkdown.rstudio.com) Notebook. When you
execute code within the notebook, the results appear beneath the code.

Try executing this chunk by clicking the *Run* button within the chunk
or by placing your cursor inside it and pressing *Ctrl+Shift+Enter*.

``` r
sleep <- readr::read_tsv("sleep.txt",
                         col_names    = c("id", "reaction", "days", "subject"),
                         col_types    = cols(
                             reaction = col_double(),
                             days     = col_factor(),
                             subject  = col_factor()),
                         skip         = 1) %>%
        dplyr::select(reaction, days, subject)
```

| reaction | days | subject |
| -------: | :--- | :------ |
| 249.5600 | 0    | 308     |
| 258.7047 | 1    | 308     |
| 250.8006 | 2    | 308     |
| 321.4398 | 3    | 308     |
| 356.8519 | 4    | 308     |

first 5 entries sleep dataset.

![](sleep-deprivation_files/figure-gfm/first%20plot-1.png)<!-- -->
