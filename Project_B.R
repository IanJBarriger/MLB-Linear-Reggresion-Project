print(MLBWINPCT)

library(car)
library(MASS)
library(olsrr)
library(Metrics)

df <- data.frame(MLBWINPCT)
print(df)

cols.dont.want <- c("G", "W")
df <- df[, ! names(df) %in% cols.dont.want, drop = F]
df$RUNDIFF<-as.factor(df$RUNDIFF)
df$lgID<-as.factor(df$lgID)

#Summary of data
summary(df)

attach(df)


plot(R, WIN.PCT)
plot((ERA)^-1, WIN.PCT)


fullmodel <- lm(WIN.PCT ~ ., data=df)
summary(fullmodel)
plot(fullmodel)

model <- lm(WIN.PCT ~ R, data=df)
summary(model)
plot(model)

#Numeric Graphs
hist(WIN.PCT)
boxplot(WIN.PCT, xlab="Win Percentage")

hist(R)
boxplot(R, xlab="Runs")

hist(H)
boxplot(H, xlab="Hits")

hist(ERA)
boxplot(ERA, xlab="ERA")

hist(AB)
boxplot(WIN.PCT, xlab="At Bats")

hist(HR)
boxplot(R, xlab="Home Runs")

hist(BB)
boxplot(H, xlab="Walks")

hist(SO)
boxplot(ERA, xlab="Strikeouts")

hist(SB)
boxplot(WIN.PCT, xlab="Stolen Bases")

hist(RA)
boxplot(R, xlab="Runs Allowed")

hist(HA)
boxplot(H, xlab="Hits Allowed")

hist(E)
boxplot(ERA, xlab="Errors")

hist(FP)
boxplot(FP, xlab="Fielding Percentage")

#Bar Chart for categorical variable
lg_table <- table(lgID)
barplot(lg_table, xlab="League Variable")

RD_table <- table(RUNDIFF)
barplot(RD_table, xlab="Run Differential")

#Boxplot for categorical variable
boxplot(WIN.PCT ~ lgID)

boxplot(WIN.PCT ~ RUNDIFF)

#Scatterplot Matrix of every variable compared to Wins
pairs(df[,c(3,4,5,6,7)])
pairs(df[,c(3,8,9,10,11)])
pairs(df[,c(3,12,13,14,15)])

#Correlation Matrix

cor(df[,-c(2,16)])


#Partial Regression Plots
library(car)

fullmodel <- lm(WIN.PCT ~ . + RUNDIFF*., data=df) #Test rundiff interaction with all variables as it is very related to all stats
crPlots(lm(WIN.PCT ~ ., data=df))

plot(fullmodel)
summary(fullmodel)

#Model Selection
library(olsrr)
ols_step_backward_p(fullmodel, 0.1)

ols_step_both_p(fullmodel, 0.1)

#Selection results
backwardSelection <- lm(WIN.PCT ~ R + AB + H + HR + ERA + HA + E + FP + RUNDIFF
                        + R*RUNDIFF + AB*RUNDIFF + ERA*RUNDIFF + E*RUNDIFF, data=df)

backwardSelectionNoInt <- lm(WIN.PCT ~ R + AB + H + HR + ERA + HA + E + FP + RUNDIFF, data=df)

summary(backwardSelection)

ols_coll_diag(backwardSelectionNoInt)

newBackwardSelectionNoInt <- lm(WIN.PCT ~ R + AB + H + HR + ERA + HA + E + RUNDIFF, data=df)

ols_coll_diag(newBackwardSelectionNoInt)

#Model after solving collinearity
finalModel <- lm(WIN.PCT ~ R + AB + H + HR + ERA + HA + E + RUNDIFF 
                 + R*RUNDIFF + AB*RUNDIFF + ERA*RUNDIFF + E*RUNDIFF , data=df)
summary(finalModel)

plot(finalModel)

boxCox(finalModel) #BoxCox does not suggest log transformation

tail(sort(hatvalues(finalModel)), 50) #5 entries over 0.0666 (hi)
print(df[c(55,101,13,71, 10),])
summary(df)
tail(sort(cooks.distance(finalModel))) #No values > 1
tail(sort(studres(finalModel)), 20) #12 values > 1.96
head(sort(studres(finalModel)), 20) #11 values > 1.96

#55 and 13 violate leverage and jackknife
#Still leave in the points as cooks not violated and plausible values

t <- qt(.025, 480-15-2, lower.tail=FALSE)
print(t)

shapiro.test(finalModel$residuals)

#Model Reliability
ols_mallows_cp(finalModel,fullmodel)
ols_mallows_cp(fullmodel,fullmodel)

BIC(finalModel)
BIC(fullmodel)
