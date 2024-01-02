#### ----- Step 1: Load Necessary Packages ----- ####

install.packages("pls")
library(pls)


#### ----- Step 2: Fit Partial Least Squares Model ---- ####

#      For this example we’ll be using the ' mtcars ' data set          #
#      will use 'mpg' as the response variable &                        #
#      'hp', 'disp', 'drat', 'wt', 'qsec' as  predictor variables:      #


# make this example reproducible
set.seed(1)

# fit PLS model
model <- plsr(mpg~hp+disp+drat+wt+qsec, data=mtcars, scale=TRUE, validation="CV")


#### ---- Step 3: Choose the Number of PLS Components ---- ####

# view summary of model fitting
summary(model)

# visualize CV plots
validationplot(model, main = "Cross-Validation RMSEP Vs No.of Components" , xlab = "Number of Components" )
validationplot(model, val.type="MSEP", main = "Cross-Validation MSEP Vs No.of Components" , xlab = "Number of Components" , ylab = " MSEP (Mean Squared Error of Prediction) ")
validationplot(model, val.type="R2" , main = "Cross-Validation R^2 Vs No.of Components" , xlab = "Number of Components")



#### ---- Step 4: Use the Final Model to Make Predictions ---- ####

#define training and testing sets
train <- mtcars[1:25, c("mpg", "hp", "disp", "drat", "wt", "qsec")]
y_test <- mtcars[26:nrow(mtcars), c("mpg")]
test <- mtcars[26:nrow(mtcars), c("hp", "disp", "drat", "wt", "qsec")]

#use model to make predictions on a test set
model <- plsr(mpg~hp+disp+drat+wt+qsec, data = train, scale =TRUE, validation = "CV")
pcr_pred <- predict(model, test, ncomp = 2)

#calculate RMSE
sqrt(mean((pcr_pred - y_test)^2))





