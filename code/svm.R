library(e1071)
library(caret)
library(ROCR)
args=commandArgs(trailingOnly =TRUE)
CSV <- args[1] 
data <- read.csv(CSV)

set.seed(1111)


n <- nrow(data)
t_idx <- sample(seq_len(n), size = round(0.9 * n))
traindata<-data[t_idx,]
#folds<-createFolds(y = train[,21],k=10)
#traindata<-train[-folds[[9]],]
testdata <- data[ - t_idx,]
trainLabels <- traindata$label

svmM <- svm(label ~ ., data = traindata, probability = TRUE)
if(args[2]=="train"){
  results <- predict(svmM, traindata, probability = TRUE)
  confusionMatrix(results, traindata$label)
}else{
  results <- predict(svmM, testdata, probability = TRUE)
  confusionMatrix(results, testdata$label)
}