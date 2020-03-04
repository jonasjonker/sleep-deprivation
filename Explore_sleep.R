#Try and use tidyverse!
library(tidyverse)
library(doBy)
library(lattice)

#Read the data and attach dataset
sleep_data <- read.table("sleep_data.txt", header=TRUE)
attach(sleep_data)
#Make the Subject a factor
sleep_data <- within(sleep_data, {Subject <- factor(Subject)})

#Spaghetti plot
plot0 <- ggplot(sleep_data) 
plot0 + geom_line(aes(x=Days, y=Reaction, group=Subject, color=Subject),show.legend=FALSE) +
  labs(title = "Spaghetti plot", y="Reaction time [ms]", x="Days of sleep-deprivation") +
  stat_summary(aes(x=Days, y=Reaction), geom = "point", fun.y = mean, shape=17) +
  stat_smooth(aes(x=Days, y=Reaction),method = "lm", se = FALSE)

#Box plot
plot0 + geom_boxplot(aes(x=Days, y=Reaction, group=Subject))+
  labs(title= "Boxplot", y= "Reaction time [ms]", x= "Days of sleep deprivation")

#Individual reactions in order of Subject
qplot(Days, Reaction, data = sleep_data, geom="line") + facet_wrap(~ Subject)

#Descriptive table
sleep_summary <- summaryBy(Reaction ~ Days , data=sleep_data, FUN=c(mean,sd))

#Mean plots
ggplot(sleep_summary, aes(x=Days, y=Reaction.mean)) +
  geom_errorbar(aes(ymin=Reaction.mean-Reaction.sd, ymax=Reaction.mean+Reaction.sd))+
  geom_line() +
  geom_point() +
  labs(title="Mean and standard deviation",y="Reaction time [ms]", x="Days of sleep-deprivation")

#Regression per person
cf <- sapply(sleep_data$Subject, function(x) coef(lm(Reaction~Days, data=subset(sleep_data, Subject==x))))
Sx <- reorder(sleep_data$Subject, cf[1,])

## Displaying the linear regression per person (Trellis graph?) used lattice :(
xyplot(Reaction ~ Days|Sx, data=sleep, 
       type=c('p', 'r'), 
       auto.key=T,aspect="xy", 
       par.settings=list(axis.text=list(cex=0.6), fontsize=list(text=10, points=10)), 
       scales=list(x=list(at=seq(0,9, by=2),labels=c("0","2", "4", "6", "8"))))

#Intercept, slope
lin.reg.coef <- by(sleep_data, sleep_data$Subject, function(data) coef(lm(Reaction ~ Days, data=data)))
lin.reg.coef1 <- unlist(lin.reg.coef)
names(lin.reg.coef1) <- NULL
lin.reg.coef2=matrix(lin.reg.coef1,length(lin.reg.coef1)/2,2,byrow = TRUE)
#R squared
lin.reg.r.squared <- by(sleep_data, sleep_data$Subject, function(data) summary(lm(Reaction ~ Days, data=data))$r.squared )
lin.reg.r.squared1<- as.vector(unlist(lin.reg.r.squared))

# Histograms
par(mar=c(4,4,2,2))
par(mfrow=c(3,1))
hist(lin.reg.coef2[,1],xlab="Intercept",col="lightblue",main="Histogram of individual intercepts")
hist(lin.reg.coef2[,2],xlab="Slope",col="lightblue",main="Histogram of individual slopes")
hist(lin.reg.r.squared1,xlab="R squared",col="lightblue",main="Histogram of individual R squared")