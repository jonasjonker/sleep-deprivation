install.packages("rmarkdown")
data.dt <- read.table(file=file.choose(),header = TRUE)

#we should analyse Level1 and Level2 models:Changes within individuals and Changes between individuals- in our case is just 
#within individuals? 
#Longitudinal Studies: Repeated measurements over time (Waves) - balanced

#Explore the data carefully using graphical tools and descriptive statistics:#Spaghettiplot,#Descriptive tables
#Box plots,#Mean plots.,#Individual regressions.

#spaghetti plot
attach(data.dt)
n=length(unique(data.dt$Subject))
par(mfrow=c(1,1))
interaction.plot(data.dt$Days,data.dt$Subject,data.dt$Reaction, xlab="Days", ylab="Reaction", col = 1:18,legend=F)

#Descriptive tables
sleep.mean = tapply(data.dt$Reaction,data.dt$Days,mean)
sleep.sd = tapply(data.dt$Reaction,data.dt$Days,sd)
sleep.var = tapply(data.dt$Reaction,data.dt$Days,var)
nrOfDays=unique(data.dt$Days)
sleep.desc <- data.frame(nrOfDays,sleep.mean,sleep.sd,sleep.var)

#boxplots - outliers on last day
boxplot(data.dt$Reaction~data.dt$Days,xlab="Days",ylab="Reaction")

#Mean plots
plot(nrOfDays,sleep.desc$sleep.mean)
scatter.smooth(x=nrOfDays, y=sleep.desc$sleep.mean, main="Days ~ Reaction")

#Individual regressions
#reshaping data
sleep.reshaped <- reshape(data.dt,timevar="Days",idvar="Subject",direction = "wide")
#checking correlation between Reaction and Days without sleep
cor(sleep.reshaped[,2:11])
#looks like there is some correlation betwwen one and the next days ?
data.dt

## Linear regression per individual of reaction on each day 

## Displaying the linear regression per person 
cf<-sapply(data.dt$Subject, function(x) coef(lm(Reaction~Days, data=subset(data.dt, Subject==x)))) 
Sx<-reorder(data.dt$Subject, cf[1,])
xyplot(Reaction ~ Days|Sx,data=data.dt,type=c('p','r'),auto.key=T,aspect="xy",
            par.settings=list(axis.text=list(cex=0.6),
                                fontsize=list(text=8, points=10)), scales=list(
                                  x=list(
                                    at=c(0,1,2,3,4,5,6,7,8,9),
                                    labels=c("0","1","2","3","4","5","6","7","8","9"))) )

## Coefficients
lin.reg.coef <- by(data.dt, data.dt$Subject, function(data) coef(lm(Reaction ~ Days, data=data)))
lin.reg.coef1 <- unlist(lin.reg.coef)
names(lin.reg.coef1) <- NULL

lin.reg.coef2=matrix(lin.reg.coef1,length(lin.reg.coef1)/2,2,byrow = TRUE) 


lin.reg.r.squared <- by(data.dt, data.dt$Subject,
     function(data) summary(lm(Reaction ~ Days, data=data))$r.squared ) 
lin.reg.r.squared1<- as.vector(unlist(lin.reg.r.squared))

par(mfrow=c(3,1))
#how they start
hist(lin.reg.coef2[,1],xlab="Intercept",col="lightblue",main="Histogram of individual intercepts")
#how they evolve
hist(lin.reg.coef2[,2],xlab="Slope",col="lightblue",main="Histogram of individual slopes")
#for most of the Subjects the model seems to be liniar, but for some it is not
hist(lin.reg.r.squared1,xlab="R squared",col="lightblue",main="Histogram of individual R squared")

## Plotting individual regression lines 

reg.coef=cbind(lin.reg.coef2, data.dt[data.dt$Days==9,])
lin.reg.coef1
mean.int<-tapply(reg.coef[,1],reg.coef[,3],mean)
mean.slope<-tapply(reg.coef[,2],reg.coef[,3],mean) 
#??
plot(Days,Reaction,type="n",xlim=c(0,9),ylim=c(200,400),main="Liniar regression",xlab="Days",ylab="Reaction",axes=F)
axis(side=1,at=c(0,1,2,3,4,5,6,7,8,9),labels=c(0,1,2,3,4,5,6,7,8,9))
axis(side=2,at=seq(40,160,20))
box()
for (i in 1:103)
 if (reg.coef[i,3]==0) 
   curve(cbind(1,x)%*%reg.coef[i,1:2],add=T,col="gray")
curve(cbind(1,x)%*%c(mean.int[1],mean.slope[1]),add=T,lwd=2)

##Yij =γ00 +γ10(Ageij −1)+b0i +b1i(Ageij −1)+εij
#E(Yij|PROGi) = 0 = γ00 + γ10(Ageij − 1)



#Yi - Reaction; Zi-Days;Bi- subject-specific regression coefficients; Ei-residuals
#
install.packages("lme4")
install.packages("arm")
install.packages("pbkrtest") 
install.packages("MASS")
install.packages("Matrix")
## Loading the packages >
library(lme4)
library(lattice)
library(arm)
library(car)
library(pbkrtest)

data.dt
## Fitting the model with ML >
data.lmer1<-lmer(Reaction~1+(1 + Days|Subject), REML = FALSE,data=data.dt)

#Fixed effects - our fixed effects are represented by the intercept?
summary(data.lmer1)

display(data.lmer1)

anova(data.lmer1)

#Estimating the fixed effects via bootstrap ?? looks wierd -> we dont have fixed effects
fixed.boot=bootMer(data.lmer1, fixef, use.u = TRUE, nsim = 250) 
fixed.boot
summary(fixed.boot)

## Calculating confidence intervals for the fixed effects via Wald, bootstrap and profile likelihood
#confint(early.lmer1,par=5:8,method="Wald",oldNames = FALSE) 


#Assessing random effects
## Random effects covariance matrix
D.sleep=unclass(VarCorr(data.lmer1))$Subject
D.sleep

## Predicted random effects
data.lmer1.re=ranef(data.lmer1)$Subject
head(data.lmer1.re,10)

plot(data.lmer1.re, main="Random intercept (b0i) versus random slope (b1i)")
