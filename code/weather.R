library(rpart)
library(rpart.plot)
library(rattle)
library(caret)

data <- read.csv("/Users/Lazurite/Desktop/DSproject/voice.csv")
set.seed(1111)

#folds<-createFolds(y = data[,21],k=10)

#max=0
#num=0
#auc_value<-as.numeric()
#for(i in 1:10){
#  fold_test <- data[folds[[i]],]
#  fold_train <- data[-folds[[i]],]
#  fold_pre <- lm(fold_train$label~.,data=fold_train)
#  fold_predict <- predict(fold_pre,type='response',newdata=fold_test)
#  auc_value<- append(auc_value,as.numeric(auc(as.numeric(fold_test[,21]),fold_predict)))
#}
#num<-which.max(auc_value)
#print(auc_value)
#testdata<-data[folds[[3]],]
#traindata<-data[-folds[[3]],]

train.index <- sample(x=1:nrow(data), size=ceiling(0.8*nrow(data) ))
train <- data[train.index, ]
test <- data[-train.index, ]

##RainTomorrow
##Marital_Status
dtreeM <- rpart(formula = label ~ ., data = train, method = "class", control = rpart.control(cp = 0.001))
#cart.model<- rpart(RainTomorrow ~. , 
#                   data=train)

fancyRpartPlot(dtreeM)
result <- predict(dtreeM, newdata = testdata, type = "class")

cm <- table(testdata$label, result, dnn = c("now", "pred"))
cm
cm[4] / sum(cm[, 2])
cm[1] / sum(cm[, 1])

accuracy <- sum(diag(cm)) / sum(cm)
accuracy#0.979


#t_pred=predict(dtreeM,test,type="class")
#confMat<-table(test$label,t_pred)
#confMat
#acc<-sum(diag(confMat)/sum(confMat))
#print(acc)