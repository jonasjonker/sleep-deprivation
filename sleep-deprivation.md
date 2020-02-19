R Notebook
================

This is an [R Markdown](http://rmarkdown.rstudio.com) Notebook. When you
execute code within the notebook, the results appear beneath the code.

Try executing this chunk by clicking the *Run* button within the chunk
or by placing your cursor inside it and pressing *Ctrl+Shift+Enter*.

``` r
library(tidyverse)
```

    ## ── Attaching packages ────────────────────────────────────────────────────────────────────── tidyverse 1.3.0 ──

    ## ✔ ggplot2 3.2.1     ✔ purrr   0.3.3
    ## ✔ tibble  2.1.3     ✔ dplyr   0.8.3
    ## ✔ tidyr   1.0.0     ✔ stringr 1.4.0
    ## ✔ readr   1.3.1     ✔ forcats 0.4.0

    ## ── Conflicts ───────────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

``` r
sleep <- readr::read_tsv("sleep.txt",
                         col_names  = c("id", "reaction", "days", "subject"),
                         col_types  = cols(
                           reaction = col_double(),
                           days     = col_integer(),
                           subject  = col_factor()
                           ),
                         skip = 1,
                         ) %>% dplyr::select(reaction, days, subject)
sleep
```

    ## # A tibble: 180 x 3
    ##    reaction  days subject
    ##       <dbl> <int> <fct>  
    ##  1     250.     0 308    
    ##  2     259.     1 308    
    ##  3     251.     2 308    
    ##  4     321.     3 308    
    ##  5     357.     4 308    
    ##  6     415.     5 308    
    ##  7     382.     6 308    
    ##  8     290.     7 308    
    ##  9     431.     8 308    
    ## 10     466.     9 308    
    ## # … with 170 more rows
