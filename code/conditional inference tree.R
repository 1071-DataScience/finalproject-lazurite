library(party)
data <- read.csv("/Users/Lazurite/Desktop/DSproject/voice.csv")
set.seed(22)

ct <- ctree(label ~ ., data = data)
plot(ct, main = "tree")
cm<-table(data$label, predict(ct))

accuracy <- sum(diag(cm)) / sum(cm)
accuracy #0.97