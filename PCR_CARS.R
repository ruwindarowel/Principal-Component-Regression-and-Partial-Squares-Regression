#load pls package for fitting a pcr model
library(pls)

#In this example we'll be using the mtcars dataset
head(mtcars)

#RESPONSE VARIABLES
#hp
#disp
#drat
#wt
#qsec

#Predictor
#mpg

#define training and testing sets
train <- mtcars[1:25, c("hp", "mpg", "disp", "drat", "wt", "qsec")]
y_test <- mtcars[26:nrow(mtcars), c("mpg")]
test <- mtcars[26:nrow(mtcars), c("hp", "disp", "drat", "wt", "qsec")]

#make the example reproducible
set.seed(1)

#fit the PCR Model
model=pcr(mpg~hp+disp+drat+wt+qsec, data=train, scale=TRUE, validation="CV")

#VIEWING A SUMMARY OF THE MODELS
summary(model)

#cross validation
validationplot(model, main="CV RMSEP vs. no. of components")

#use model to make predictions on a test set
model <- pcr(mpg~hp+disp+drat+wt+qsec, data=train, scale=TRUE, validation="CV")
pcr_pred <- predict(model, test, ncomp=1)

#calculate RMSE
sqrt(mean((pcr_pred - y_test)^2))