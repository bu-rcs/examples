# ---------------------------------------#
#                                        #
#  R script for SCV tutorial             #
#  Katia Oleinik                         #
# ---------------------------------------#


# lm() - Lenear regression
# glm() - generalised linear model
# coxph() - Cox model (survival package)
# clogit()  -Conditioanl logistic regression (survival package)
# gee() - Generalised Estimating Equations (in gee and geepack packages)
# lme() Linear mixed models ( in nlme package)
# polr() Proportional odds model (in MASS package)

#------------------------------------------------------ #
#               Examples of linear regression           #
#------------------------------------------------------ #
## A few of the exploratory graphs we might draw
library(MASS)
data(birthwt)
pairs(birthwt[,c("age","lwt","ptl","bwt")])
boxplot(bwt~ftv,data=birthwt)
boxplot(bwt~race,data=birthwt)
## A linear model
model1<-lm(bwt~age+lwt+factor(race)+ptl+ftv+ht,data=birthwt)
anova(model1)
par(mfrow=c(2,2)) ##2x2 table of plots
plot(model1)
# There is no suggestion that age is important, or preterm visits.
# Two points (labelled â188â and â226â) seem influential.

#Examining beta's computed by lm.influence() shows that removing
#one of these points would have a fairly important effect on the
#coefficient for ptl. This is a large infant born to a small woman
#who smoked and had had three previous preterm deliveries.
dbeta<-lm.influence(model1)$coef
strange<-which(row.names(birthwt) %in% c("188","226"))
round(dbeta[strange,],2)
birthwt[strange,]
#We may be more interested in identifying risk factors for low birth
#weight (defined as < 2500g) than in predicting actual weights.
#It may be more productive to fit a logistic regression model to
#the binary variable bwt< 2500g
model2<-glm(I(bwt<2500)~age+lwt+factor(race)+ptl+ftv+ht,
            data=birthwt,family=binomial())
anova(model2)
plot(model2) ## pretty useless plots
#The same infant is still influential: normal birth weight despite
#being very high risk.
par(mfrow=c(1,1))


#------------------------------------------------------ #
#                  Decision Trees                       #
#------------------------------------------------------ #
library("party")
str(iris)

#Call function ctree to build a decision tree. The first parameter is a formula,
# which defines a target variable and a list of independent variables.
iris_ctree <- ctree(Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width, data=iris)
print(iris_ctree)
plot(iris_ctree)
plot(iris_ctree, type="simple")

#------------------------------------------------------ #
#                  Hierarchial Clustering               #
#------------------------------------------------------ #
# Sample of 40 records from iris data and remove variable Species
idx <- sample(1:dim(iris)[1], 40)
irisSample <- iris[idx,]
irisSample$Species <- NULL

#Hierarchial clustering
hc <- hclust(dist(irisSample), method="ave")
plot(hc, hang = -1, labels=iris$Species[idx])

#------------------------------------------------------ #
#                  K means                              #
#------------------------------------------------------ #
newiris <- iris
newiris$Species <- NULL

#Apply kmeans to newiris, and store the clustering result in kc. The cluster number is set to 3.
(kc <- kmeans(newiris, 3))

#Compare the Species label with the clustering result
plot(newiris[c("Sepal.Length", "Sepal.Width")], col=kc$cluster)
points(kc$centers[,c("Sepal.Length", "Sepal.Width")], col=1:3, pch=8, cex=2)
table(iris$Species, kc$cluster)




#------------------------------------------------------ #
#                   Classical Tests                     #
#------------------------------------------------------ #



#--------------------------------------------------------------------------------------------------------------
#                      |     Observations Independent or Correlated    |                                      |
#                      |-----------------------------------------------|   Alternative tests                  |
#   Outcome variable   |                      |                        | ( non-normal distribution,           |
#                      |  independent         | correlated             |   small sample size, etc.   )        |
#                      |                      |                        |                                      |
#------------------------------------------------------------------------------------------------------------
#                      | Ttest, ANOVA         | Paired ttest           | Wilcoxon rank-sum test(alt. ttest)   |
#  Continuous          | linear correlation   | Repeated-measures ANOVA| Wilcoxon sign-rank test (alt. paired)|
#                      | linear regression    | Mixed models/GEE       | Kruskal-Wallis test  (alt. ANOVA)    |
#                      |                      |                        | Spearman rank (alt. Pearson' corr.)  |
#------------------------------------------------------------------------------------------------------------
#                      | Risk differ. (2x2)   | McNemar's test (2x2)   | Fisher's exact test                  |
#  Binary    or        | Chi-square test (RxC)| Conditional logistic   | McNemar's exact test                 |
#  Categorical         | Logistic regression  |     regression (mult.) |                                      |
#                      |   (multivariate regr)| GEE modelling (mult.)  |                                      |
#-------------------------------------------------------------------------------------------------------------
#                      | Rate Ratio           | Frailty model          | Time-varying effects                 |
# Time to event        | Kaplan-Meier stat.   |                        |                                      |
# (time to get disease)| Cox regression       |                        |                                      |
#--------------------------------------------------------------------------------------------------------------


# Tests for normality
# if the variable is normally distributed, the graph should be close to the straight line
qqnorm(dt$cigar)  
qqline(dt$cigar, lty=2)
shapiro.test(dt$cigar)  
# p-value is large so we cannot reject the hypothesis that the data
# is normally distributed

qqnorm(dt$area)  
qqline(dt$area, lty=2)
shapiro.test(dt$area) 
# This time the variable is not normally distributed

# Fisher F test: compare  if 2 sample variances are significantly different
var.test (dt$traffic[dt$ed ==0], dt$traffic[dt$ed==1] ) 
# p-value (large) and 95-confidence interval (includes 1) suggests
# that we cannot reject the hypothesis that variances are the same for 2 samples

# Comparing 2 means: Student's t test
t.test (dt$traffic[dt$ed ==0], dt$traffic[dt$ed==1] ) 
# we reject null-hypothesis based on the confidence interval and p value

# Paired t test
# Let's simulate another variable "number of traffic fatalities after after some law was implemented"
dt$traffic.after <- dt$traffic - rnorm(length(dt$traffic), mean=0.2, sd=.2)
( t.result<- t.test (dt$traffic, dt$traffic.after, paired=TRUE ) )
# as we expected the difference in means is not equal to 0 based on 95 percent conf. interval and p value
str(t.result)
# the output of this function is a list, we can access each individual element of the list by name
t.result$p.value
t.result$conf.int
# we can also access list elements by the index:
t.result[[3]]

# Binomial test - compare 2 proportions
# let's split the dataset into 2 groups and check if the proportion of "ed"=1 is the same among 2 groups
dt.group1 <- subset( dt, location =="N" | location =="NE" | location =="NW", select=c(state, traffic, ed))
dt.group2 <- subset( dt, location =="S" | location =="C" | location =="E"  | location =="S" | location =="SE" | location =="SW", select=c(state, traffic, ed))
prop.test(c(sum(dt.group1$ed==1),sum(dt.group2$ed==1)),c(length(dt.group1$ed),length(dt.group2$ed)))


#--------------------------------- #
#     Statistical Models           #
#--------------------------------- #
#
#  y ~ x    - regression
#  y ~ x-1  - regression through the origin
#  y ~ x + z - multiple regression
#  y ~ x * z - multiple regression with interaction
#  y ~ xc   - one way ANOVA (xc is a categorical variable)
#  y ~ xc1 + xc2  - two way ANOVA (xc1, xc2)
#  ...
#
lm.fit <- lm(dt$ap ~ dt$pop)
summary(lm.fit )
anova(lm.fit )
qf(0.95,1,48) 
par(mfrow=c(2,2))  # display 4 graphs at once
plot(lm.fit )
par(mfrow=c(1,1))  # return to the default mode - 1 graph at  a time
# first plot should not show any structure or pattern
# second (upper right) -should be close to the straight line
# third (bottom left) - we should not see a triangular shape
# last one - highlight the points that have the largest effect on the parameter estimates
# It displays Cook's distance contour lines , which is another measure of the importance of each observation in the regression. 
# Distances larger than 1 suggest the presence of a possible outlier or a poor model


# Multiple regression
# Suppose Y = dt$ap - number of AP tests in the state
# Predictors are X1 = dt$pop - population
#                X2 = dt$area - land area
#                X3 = dt$cigar - cigarettes sold
#         Y = FUN(X1, X2) + err
lm.fit <- lm(dt$ap ~ dt$pop + dt$area + dt$cigar)
summary(lm.fit)
