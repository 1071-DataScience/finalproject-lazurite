library(e1071)
library(caret)
library(pROC)
data <- read.csv("/Users/Lazurite/Desktop/DSproject/voice.csv")
set.seed(1111)
#folds<-createFolds(y = data[,21],k=20)

#max=0
#num=0
#auc_value<-as.numeric()
#for(i in 1:20){
#  fold_test <- data[folds[[i]],]
#  fold_train <- data[-folds[[i]],]
#  fold_pre <- lm(fold_train$label~.,data=fold_train)
#  fold_predict <- predict(fold_pre,type='response',newdata=fold_test)
#  auc_value<- append(auc_value,as.numeric(auc(as.numeric(fold_test[,21]),fold_predict)))
#}
#num<-which.max(auc_value)
#print(auc_value)
#testdata<-data[folds[[13]],]
#traindata<-data[-folds[[13]],]


n <- nrow(data)
t_idx <- sample(seq_len(n), size = round(0.8 * n))
traindata <- data[t_idx,]
testdata <- data[ - t_idx,]
trainLabels <- traindata$label

svmM <- svm(label ~ ., data = traindata, probability = TRUE)
results <- predict(svmM, testdata, probability = TRUE)

cm <- table(x = testdata$label, y = results)
cm
SVMaccuracy <- sum(diag(cm)) / sum(cm)
SVMaccuracy #0.98