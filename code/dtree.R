library(rpart)
library(rpart.plot)
library(rattle)
library(caret)

data <- read.csv("/Users/Lazurite/Desktop/voice.csv")
set.seed(1111)

folds<-createFolds(y = data[,21],k=10)

testdata<-data[folds[[3]],]
traindata<-data[-folds[[3]],]

dtreeM <- rpart(formula = label ~ ., data = traindata, method = "class", control = rpart.control(cp = 0.001))

##find features#########
fancyRpartPlot(dtreeM)
########################

result <- predict(dtreeM, newdata = testdata, type = "class")

cm <- table(testdata$label, result, dnn = c("now", "pred"))
cm
cm[4] / sum(cm[, 2])
cm[1] / sum(cm[, 1])

accuracy <- sum(diag(cm)) / sum(cm)
accuracy#0.969