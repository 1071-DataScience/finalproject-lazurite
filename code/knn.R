library(class)
library(dplyr)
library(rpart)
library(ggplot2)
data <- read.csv("/Users/Lazurite/Desktop/DSproject/voice.csv")

set.seed(1111)
folds<-createFolds(y = data[,21],k=10)

max=0
num=0
auc_value<-as.numeric()
for(i in 1:10){
  fold_test <- data[folds[[i]],]
  fold_train <- data[-folds[[i]],]
  fold_pre <- lm(fold_train$label~.,data=fold_train)
  fold_predict <- predict(fold_pre,type='response',newdata=fold_test)
  auc_value<- append(auc_value,as.numeric(auc(as.numeric(fold_test[,21]),fold_predict)))
}
num<-which.max(auc_value)
print(auc_value)
testdata<-data[folds[[3]],]
traindata<-data[-folds[[3]],]

#n <- nrow(data)
#t_idx <- sample(seq_len(n), size = round(0.8 * n))
#traindata <- data[t_idx,]
#testdata <- data[ - t_idx,]
trainLabels <- traindata$label
knnTrain <- traindata[,-c(21)]
knnTest <- testdata[,-c(21)]


kv <- round(sqrt(n))
kv

prediction <- knn(train = knnTrain, test = knnTest, cl = trainLabels, k = 3)
cm <- table(x = testdata$label, y = prediction, dnn = c("now", "pred"))
cm
knnaccuracy <- sum(diag(cm)) / sum(cm)
knnaccuracy #0.72(max)


klist <- seq(1:(kv + kv))
knnFunction <- function(x, knnTrain, knnTest, trainLabels, testLabels) {
  prediction <- knn(train = knnTrain, test = knnTest, cl = trainLabels, k = x)
  cm <- table(x = testLabels, y = prediction)
  accuracy <- sum(diag(cm)) / sum(cm)
}
accuracies <- sapply(klist, knnFunction, knnTrain = knnTrain, knnTest = knnTest, trainLabels = trainLabels, testLabels = testdata$label)

df <- data.frame(
  kv = klist, accuracy = accuracies)

ggplot(df, aes(x = kv, y = accuracy, label = kv, color = accuracy)) +
  geom_point(size = 5) + geom_text(vjust = 2)