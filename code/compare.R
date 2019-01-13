df <- data.frame(perf = c(knnaccuracy, SVMaccuracy, naiveBayesaccuracy), name = c("KNN", "SVM", "naiveBay"));

ggplot(df, aes(x = name, y = perf, color = name, label = perf)) +
  geom_point(size = 5) + geom_text(vjust = 2)