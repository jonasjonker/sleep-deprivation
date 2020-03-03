library(lattice)
library(lme4)
library(arm)
library(car)
library(pbkrtest)

################################
#### Descriptive Statistics ####
################################

#### load the data ####
sleep <- read.delim("~/Desktop/MSc BioInf/2nd sem/statistics/sleep.txt")

#### number of subjects studied in the data frame ####
n=length(unique(sleep$Subject))

#### make a spaghetti plot of the data, evolution of every subject in time ####
interaction.plot(sleep$Days,sleep$Subject,sleep$Reaction,xlab="days", ylab="reaction time",legend=F, col="grey")
# from a first look you can see that the reaction time generally increases as the days pass by

#### descriptive statistics of the reaction time grouped by days and make a summary table ####
sleepMean<-tapply(sleep$Reaction,sleep$Days,mean)
sleepSD<-tapply(sleep$Reaction,sleep$Days,sd)
sleepVar<-tapply(sleep$Reaction,sleep$Days,var)
sleep.n<-table(sleep$Days)
descriptive<-cbind(sleepMean,sleepSD,sleepVar,sleep.n)
# the mean of the reaction time increases as the spaghetti plot had indicated, but the SD as well

# add the mean line on the existing spaghetti plot in "red"
lines(c(0:9),sleepMean,col="red")

#### Mean evolution (with 1 SE intervals)
# condifigurations for error bars
errbar=function(x,y,height,width,lty=1,col="black"){
  arrows(x,y,x,y-height,angle=90,length=width,lty=lty,col=col)
  arrows(x,y,x,y-height,angle=90,length=width,lty=lty,col=col)
}
# plot mean evolution
plot(c(0:9),descriptive[,1],type="b",xlim=c(0,10),ylim=c(100,500),xlab="Days",ylab="Reaction Time",axes=T,main="Mean evolution (with 1 SE intervals)")
axis(side=1,at=c(0:9),labels=c(0:9))
axis(side=2,at=seq(200,450,50))
# display error bars
box()
errbar(c(0:9),descriptive[,1],descriptive[,2],.1,col = "red")


#### boxplot of the reaction time for every day ####
boxplot(sleep$Reaction~sleep$Days,xlab="days",ylab = "reaction time")
# as we saw from the above the table, the reaction time increases, but the variance increases as well


#############################################
#### Reshaping the data into a wide form ####
#############################################

# If direction= "wide" and no varying or v.names arguments are supplied it is assumed that all variables except idvar and timevar are time-varying. They are all expanded into multiple variables in wide format
sleep.reshaped<-reshape(sleep,timevar = "Days",idvar = "Subject", direction = "wide")

#### Correlation between the reaction time at different days
correlationSleep<-cor(sleep.reshaped[,2:11])

#### LEVEL 1 #### - (within subject variability)
# The suggested model at first stage is: Yij = π0i + π1i*Days + εij or *(Days - 1)
# π0i: the intercept for subject i at Dayij = 1 (mean reaction time when Day=0, the real initial status)
# π1i: slope for subject i
# εij: error term εij ~ N(0, σε^2) (How individuals deviate from their own evolution)

## Display linear regression for every subject
# intercept and slope for every linear model made for every subject
cf<-sapply(sleep$Subject, function(x) coef(lm(sleep$Reaction~sleep$Days, data=subset(sleep, Subject==x))))
Sx<-reorder(sleep$Subject, cf[1,])
# create the trellis graph
xyplot(sleep$Reaction ~ sleep$Days|Sx,data=sleep,type=c('p','r'),auto.key=T,aspect="xy", par.settings=list(axis.text=list(cex=0.6), fontsize=list(text=8, points=10)),scales=list( x=list(at=c(0:9),labels=c("0","1","2","3","4","5","6","7","8","9"))),xlab = "days",ylab = "reaction time")
# generally there is a increasing trend on the reaction time as the days pass for all the subjects. Some have a bigger slope and some a smaller                                                                                                                                                                                          

# Make a list of the regression models produced for every subject to take :
# 1. The coefficients 
# take the intercept of every regression model
lin.reg.coef<-by(sleep,Subject,function(data) coef(lm(Reaction~Days,data=data)))
lin.reg.coef1<-unlist(lin.reg.coef)
names(lin.reg.coef1)<-NULL
lin.reg.coef2=matrix(lin.reg.coef1,length(lin.reg.coef1)/2,2,byrow =TRUE)
# 2.R^2
lin.reg.r.squared <- by(sleep, Subject,function(data) summary(lm(Reaction~Days, data=data))$r.squared)
lin.reg.r.squared1<- as.vector(unlist(lin.reg.r.squared))
# Generally the slope seems to be normally distributed
par(mfrow=c(3,1))
# there is quite a big variability in intercept, which shows the random selection of data (=real initial status)
hist(lin.reg.coef2[,1],xlab="Intercept",col="lightblue",main="Histogram of individual intercepts")
## to make corresponding histograms
hist(lin.reg.coef2[,2],xlab="Slope",col="lightblue",main="Histogram of individual slopes")
hist(lin.reg.r.squared1,xlab="R squared",col="lightblue",main="Histogram of individual R squared")


#### LEVEL 2 #### - (between-subject variability) - making the Hierarhical model
# π0ι = γ00 + b0i (explaining the intercept)
# π1i = γ10 + b1i (explaining the slope)
# R uses the marginal model instead the hierarchical

#### Fitting the model(Marginal Model) ####
# Parameters are estimated via: restricted maximum likelihood (REML)
sleep.lmer1<-lmer(Reaction~1+Days+(1+Days|Subject), data=sleep)
summary(sleep.lmer1)

#### Testing the fixed effects 
# via Wald, bootstrap and profile likelihood
confint(sleep.reml,  par=5:6, method='Wald', oldNames=F)
confint(sleep.reml, method='boot', boot.type='perc', oldNames=F, nsim=500)
confint(sleep.reml, level=0.95, method='profile',   oldNames=F)




