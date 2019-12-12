library(e1071)
data <- read.csv("/Users/Lazurite/Desktop/DSproject/voice.csv")

set.seed(1111)
folds<-createFolds(y = data[,21],k=20)
testdata<-data[folds[[13]],]
traindata<-data[-folds[[13]],]
#n <- nrow(data)
#t_idx <- sample(seq_len(n), size = round(0.8 * n))
#traindata <- data[t_idx,]
#testdata <- data[ - t_idx,]
trainLabels <- traindata$label

nbcm <- naiveBayes(label ~ ., data = traindata)
results <- predict(nbcm, testdata)

cm <- table(x = testdata$label, y = results)
cm
naiveBayesaccuracy <- sum(diag(cm)) / sum(cm)
naiveBayesaccuracy #0.88