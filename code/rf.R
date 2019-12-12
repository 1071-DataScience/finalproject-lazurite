library(randomForest)

data <- read.csv("/Users/Lazurite/Desktop/DSproject/voice.csv")
set.seed(22)

n <- nrow(data)
t_idx <- sample(seq_len(n), size = round(0.8 * n))
traindata <- data[t_idx,]
testdata <- data[ - t_idx,]
trainLabels <- traindata$label


rf_model = randomForest(label~.,
                        data=traindata,
                        ntree=60,
                        mtry=6
)
rf_y = predict(rf_model, testdata)
#plot(rf_model)
#tuneRF(traindata[,-9], traindata[,9])
confMat<-table(testdata$label,rf_y)
confMat
acc<-sum(diag(confMat)/sum(confMat))
print(acc)#0.971