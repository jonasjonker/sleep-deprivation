Presentation of the case study
------------------------------

We are analysing the effect of sleep deprivation on reaction time of
long distance truck drivers. There are 18 subjects in the dataset and
for each subject, the reaction time was measured for 10 days. The
subjects were allowed only a limited amount of sleep for these 10
subsequent days.Each subject’s reaction time was measured several times
on each day of the trial and an average was taken.

Reaction time is measured with a psychomotor vigilance task (PVT), which
measures the speed with which subjects respond to a visual stimulus.

Is there any relation between reaction time and the number of days of
sleep deprivation?

Exploratory analysis
--------------------

    ##    Reaction Days Subject
    ## 1  249.5600    0     308
    ## 2  258.7047    1     308
    ## 3  250.8006    2     308
    ## 4  321.4398    3     308
    ## 5  356.8519    4     308
    ## 6  414.6901    5     308
    ## 7  382.2038    6     308
    ## 8  290.1486    7     308
    ## 9  430.5853    8     308
    ## 10 466.3535    9     308
    ## 11 222.7339    0     309
    ## 12 205.2658    1     309

This dataset contains multiple measurements for each subject on
consecutive days, with as response variable the continuous variable
reaction time and explanatory variable Days. Since there are 10
measurements for each subject, it is a longitudinal study. The dataset
of 18 subjects is balanced with an equal amount of measurements for each
subject.

### Spaghetti Plot

To visualise the individual reaction times and how they compare to the
mean, a spaghetti plot was created. This revealed that there was a
variation in intercepts or starting reaction times on day 0 between
subjects. This variation increased with subsequent days.

For most subjects, the reaction time increased with the amount of days
of sleep deprivation. This increase is also visible in the mean.

<img src="Common_sleep_files/figure-markdown_github/spaghetti-1.png" width="80%" height="60% " style="display: block; margin: auto;" />

Boxplot
-------

The following boxplot was created to get a quick summary of the
dataset’s characteristics. The mean and median seem to show a similar
increase throughout the study. For day nr 6, 7 and 10, outliers are
observed. The variance increases with an increase in days of sleep
deprivation but the interquartile range appears to expand not as
strongly as the minimum and maximum of the boxplot.

To put together, some subjects deviate more from the mean with an
increase in days of sleep deprivation (see outliers on both sides) while
most others stay around the mean (see slower increase in interquartile
range).

The violin plot supports the above observations of the distribution of
the data around the mean with outliers.

<img src="Common_sleep_files/figure-markdown_github/boxplot-1.png" width="80%" style="display: block; margin: auto;" />

Violin plot
-----------

<img src="Common_sleep_files/figure-markdown_github/violinplot-1.png" width="80%" style="display: block; margin: auto;" />

Summary
-------

|       |     Days|       Mean|        SD|       Var|                                                                                                                                                                                                      n|
|-------|--------:|----------:|---------:|---------:|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|
| 0     |        0|     256.65|     32.13|   1032.30|                                                                                                                                                                                                     18|
| 1     |        1|     264.50|     33.43|   1117.59|                                                                                                                                                                                                     18|
| 2     |        2|     265.36|     29.47|    868.68|                                                                                                                                                                                                     18|
| 3     |        3|     282.99|     38.86|   1509.92|                                                                                                                                                                                                     18|
| 4     |        4|     288.65|     42.54|   1809.47|                                                                                                                                                                                                     18|
| 5     |        5|     308.52|     51.77|   2680.09|                                                                                                                                                                                                     18|
| 6     |        6|     312.18|     63.17|   3990.92|                                                                                                                                                                                                     18|
| 7     |        7|     318.75|     50.10|   2510.41|                                                                                                                                                                                                     18|
| 8     |        8|     336.63|     60.20|   3624.01|                                                                                                                                                                                                     18|
| 9     |        9|     350.85|     66.99|   4487.15|                                                                                                                                                                                                     18|
| The c |  alculat|  ions of t|  he mean,|  standard|  deviation and variance of the reaction time for each day of all subjects, further support our exploratory plots: we observe an increase in the mean and variance with more days of sleep deprivation.|

Mean evolution
--------------

<img src="Common_sleep_files/figure-markdown_github/mean_err-1.png" width="80%" style="display: block; margin: auto;" />
To further support our previous findings, we looked at the mean
evolution. Here, an increasing trend of reaction time with increasing
number of days is also observed, together with expanding standard
deviations (see errorbars).

Correlation
-----------

<img src="Common_sleep_files/figure-markdown_github/spearman_tile-1.png" width="80%" style="display: block; margin: auto;" />

We used the Shapiro-Wilk test to check for normality of the reaction
times per day.

The test revealed a non normal distribution of day 9. Thus, we performed
the spearman correlation method instead of pearson to check for a
correlation of the reaction times between days.

Looking at the correlation matrix, there is a correlation higher then
0.6 between subsequent days (e.g. between Day 8 and 9, between Day 3 and
4, …). However, the further the days are apart, the lower the
correlation (e.g. low correlation between Day 1 and Day 8).

Aligning nicely with our previous results, there is a linear trend
between the number of Days and reaction time.

Regression per person
---------------------

<img src="Common_sleep_files/figure-markdown_github/trellis-1.png" width="80%" style="display: block; margin: auto;" />
We performed a linear regression model on each subject based on the
function: reaction time = *b*<sub>0</sub> + *b*<sub>*i*</sub> \* Days.

We then created a trellis graph to visualise the intercepts and slopes
of these subject-specific linear regression models.

The graph suggests that the slope and intercept of each subject’s linear
model are independent of each other as there is no observable trend
between the height of the intercept and the steepness of the slope. This
is further supported by plotting the intercept against the slope.
Overall, all subjects have a positive slope besides subject 335.

The linear regression lines fit the datapoints closely, suggesting that
a linear model is appropriate to represent this dataset.

Between subject variability
---------------------------

<img src="Common_sleep_files/figure-markdown_github/histograms-1.png" width="80%" style="display: block; margin: auto;" />

The individual intercepts shown in the first histogram correspond to the
initial reaction time and are non normally distributed. Given the small
data set, this is not surprising as it shows a variety of their initial
reaction time. However, if this data came from a large dataset, it would
be surprising that even the initial data points are not normally
distributed and could suggest a wrong data sample compared to the
population.

Looking at the histogram of individual slopes, we see a normal
distribution. As seen on the previous graph showcasing the individual
linear regressions, very little slopes are negative. This shows again
that reaction time increases by days of sleep deprivation.

Finally, looking at the histogram of R squared, we see that the majority
of subjects have a R squared of above 0.6. This shows that the linear
model is appropriate for this data set. However, sometimes the
individual linear model does not fit the specific data of some subjects,
specifically 7 of the 18 subjects.

Fitting the model - with REML
-----------------------------

    ## Linear mixed model fit by REML ['lmerMod']
    ## Formula: Reaction ~ 1 + Days + (1 + Days | Subject)
    ##    Data: sleep
    ## 
    ## REML criterion at convergence: 1743.6
    ## 
    ## Scaled residuals: 
    ##     Min      1Q  Median      3Q     Max 
    ## -3.9536 -0.4634  0.0231  0.4633  5.1793 
    ## 
    ## Random effects:
    ##  Groups   Name        Variance Std.Dev. Corr
    ##  Subject  (Intercept) 611.90   24.737       
    ##           Days         35.08    5.923   0.07
    ##  Residual             654.94   25.592       
    ## Number of obs: 180, groups:  Subject, 18
    ## 
    ## Fixed effects:
    ##             Estimate Std. Error t value
    ## (Intercept)  251.405      6.824  36.843
    ## Days          10.467      1.546   6.771
    ## 
    ## Correlation of Fixed Effects:
    ##      (Intr)
    ## Days -0.138

Values
------

$$\\begin{align}
\\gamma\_{0}  &= 251.405 \\\\
\\gamma\_{1}  &= 10.467  \\\\
\\\\
\\sigma\_{\\epsilon}^{2} &= 654.94 \\\\
\\sigma\_{0}^{2} &= 611.90 \\\\
\\sigma\_{1}^{2} &= 35.08 \\\\
corr(b\_{0i}, b\_{1i}) &= 0.07
\\end{align}$$

\#\#Mathematical description

Level 1 model explains the evolution of Reaction time for each subject
$$\\begin{align}
Y\_{ij}&= \\pi\_{0i} + \\pi\_{1i}\* \\text{Days}\_{ij} && \\text{how do individuals evolve} \\\\
          &+ \\epsilon\_{ij} &&\\text{how the individuals deviate from their own evolution}
\\end{align}$$

Level 2 model tries to explain why the Subjects differ from each other
$$\\begin{align}
\\pi\_{0i} &= \\gamma\_{0} + b\_{0i} &&\\text{model for explaining the intercept} \\\\
\\pi\_{1i} &= \\gamma\_{1} + b\_{1i} &&\\text{model for explaining the slope}
\\end{align}$$

*σ*<sub>0</sub><sup>2</sup> - Level 2 residual variance in true
intercept *π*<sub>0*i*</sub> across all individuals in the population
*σ*<sub>1</sub><sup>2</sup> - Level 2 residual variance in true slope
*π*<sub>1*i*</sub> across all individuals in the population

With level 2 model we are trying to see why there is variation between
individuals by looking at the intercept and at the slope.
*b*<sub>0*i*</sub> and *b*<sub>1*i*</sub> are the unexplained
variability

The full model describes the evolution observed in spaghetti plot:
$$\\begin{align}
Y\_{ij} =& γ\_{0} + b\_{0i} + γ\_{1}\* \\text{Days}\_{ij} &&\\text{fixed effects}\\\\
          &+ b\_{0i} + b\_{1i}\*\\text{Days}\_{ij} &&\\text{random effect}\\\\
          &+ \\epsilon\_{ij} &&\\text{error}
\\end{align}$$

$$
\\begin{cases}
Y\_{ij}&= \\pi\_{0i} + \\pi\_{1i}\* \\text{Days}\_{ij} + \\epsilon\_{ij} \\\\
\\pi\_{0i} &= \\gamma\_{0} + b\_{0i} &&\\text{intercept} \\\\
\\pi\_{1i} &= \\gamma\_{1} + b\_{1i} &&\\text{slope}
\\end{cases}
$$

Following is the average evolution of the population:
*E*(*Y*<sub>*i**j*</sub>) = *γ*<sub>0</sub> + *γ*<sub>1</sub> \* Days<sub>*i**j*</sub>

The general liniar mixed model is given by:
$Y\_i &= X\_i\\beta + Z\_i b\_i + ε\_i$ with
*b*<sub>*i*</sub> ∼ *N*(0, *D*),
*ε*<sub>*i*</sub> ∼ *N*(0, *Σ*<sub>*i*</sub>)
*b*<sub>1</sub>⋯, *b*<sub>*N*</sub>, *ε*<sub>1</sub>⋯, *ε*<sub>*N*</sub>

$$Y\_i \\tilde{} N(X\_i\\beta, Z\_iDZ\_i'+\\Sigma\_i)$$

R uses the marginal model and our calcuation are based on that. Next
step is to check if the values we retrieved are actually significant so
does the number of days have a significant effect on the reaction time?
We tested this with Bootstrap and Likelihood Ratio tests because th
sample zise wasn’t large enough(excluding Wald test).

Testing fixed effects - with bootstrap
--------------------------------------

Computing bootstrap confidence intervals …

4 message(s): boundary (singular) fit: see ?isSingular 179 warning(s):
Model failed to converge with max\|grad\| = 0.00200787 (tol = 0.002,
component 1) (and others)

|                                    |  2.5 %  | 97.5 % |
|:----------------------------------:|:-------:|:------:|
|    **sd\_(Intercept)\|Subject**    |  12.21  |  35.39 |
| **cor\_Days.(Intercept)\|Subject** | -0.4942 | 0.9067 |
|        **sd\_Days\|Subject**       |  3.493  |  8.315 |
|              **sigma**             |  22.67  |  28.8  |
|           **(Intercept)**          |  236.8  |  265.6 |
|              **Days**              |  7.573  |  13.53 |

Confidence interval of the intercept and days does not include 0
therefore both of them have a significant effect on reaction time.

likelihood ratio test with anova
--------------------------------

|                     |  Df |  AIC |  BIC | logLik | deviance | Chisq | Chi Df |
|:-------------------:|:---:|:----:|:----:|:------:|:--------:|:-----:|:------:|
| **sleep.intercept** |  3  | 1917 | 1926 | -955.3 |   1911   |   NA  |   NA   |
|    **sleep.full**   |  6  | 1764 | 1783 |  -876  |   1752   | 158.6 |    3   |

|                     | Pr(\>Chisq) |
|:-------------------:|:-----------:|
| **sleep.intercept** |      NA     |
|    **sleep.full**   |  3.672e-34  |

We compared an intercept only model with a model that includes days as
well and we concluded that adding days as covariate it improves our
model significantly. Days have have a significant effect on the reaction
time with the p-value smaller than 0.05. The decrease in AIC value also
supports this conclusion.

### OLS vs LMM estimates

\#plot random intercept and random slope

|                 | (Intercept) |  Days |
|:---------------:|:-----------:|:-----:|
| **(Intercept)** |    611.9    | 9.614 |
|     **Days**    |    9.614    | 35.08 |

$$\\begin{pmatrix}
b\_{0i} \\\\
b\_{1i}
\\end{pmatrix}
\\sim
N\\begin{pmatrix}
\\begin{pmatrix}
0 \\\\
0
\\end{pmatrix},
\\begin{pmatrix}
\\sigma\_{0}^2 & \\sigma\_{01} \\\\
\\sigma\_{01} & \\sigma\_{1}^2 
\\end{pmatrix}
\\end{pmatrix}\\\\
\\begin{pmatrix}
b\_{0i} \\\\
b\_{1i}
\\end{pmatrix}
\\sim
N\\begin{pmatrix}
\\begin{pmatrix}
0 \\\\
0
\\end{pmatrix},
\\begin{pmatrix}
611.9 & 9.61 \\\\
9.61 & 35.08 
\\end{pmatrix}
\\end{pmatrix}
$$
D: Random effects covariance matrix The model is built on the assumption
that the b’s come from a normal distribution with mean 0 and the
residual variance in true intercept *π*<sub>0*i*</sub> across all
individuals in the population of 611.9, the residual variance in true
slope for all individuals is 35.08 and residual covariance between the
intercept and the slope of 9.61.

    ##     (Intercept)        Days
    ## 308   2.2575329   9.1992737
    ## 309 -40.3942719  -8.6205161
    ## 310 -38.9563542  -5.4495796
    ## 330  23.6888704  -4.8141448
    ## 331  22.2585409  -3.0696766
    ## 332   9.0387625  -0.2720535
    ## 333  16.8389833  -0.2233978
    ## 334  -7.2320462   1.0745075
    ## 335  -0.3326901 -10.7524799
    ## 337  34.8865253   8.6290208

This table preditcs the random effect for each subject.Almost all values
lay within two standard devation from the mean.

![](Common_sleep_files/figure-markdown_github/unnamed-chunk-8-1.png)

    ##     (Intercept)      Days
    ## 308    253.6626 19.666560
    ## 309    211.0108  1.846770
    ## 310    212.4488  5.017706
    ## 330    275.0940  5.653141
    ## 331    273.6636  7.397609
    ## 332    260.4439 10.195232

![](Common_sleep_files/figure-markdown_github/unnamed-chunk-8-2.png)![](Common_sleep_files/figure-markdown_github/unnamed-chunk-8-3.png)
![](Common_sleep_files/figure-markdown_github/unnamed-chunk-9-1.png)![](Common_sleep_files/figure-markdown_github/unnamed-chunk-9-2.png)

### to do: compare the two models by creating the mean!

From our analysis on the effect of sleep deprivation on the reaction
time of long distance truck drivers, we concluded that there is a
significant positive correlation between them. More precisely, as the
sleep deprivation proceeds, the time needed for a driver to respond to a
visual stimulus is increasing. Several groups of drivers with different
conditions of restricted sleep deprivation or a control group would
additionally help us draw a more concrete conclusion. From the existing
literature, mathematical models predicting alertness from preceding
sleep-wake history typically involve four factors, sleep homeostasis,
circadian rhythm, sleep inertia and neuromodulatory changes. Thus, we
can conclude that there is a relation between reaction time and sleep
deprivation, but it is not the only factor that can fully describe the
relationship of sleep deprivation and the reaction time.
