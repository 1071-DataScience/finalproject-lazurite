# < Gender Recognition by Voice >

### Groups
* < 鄭博仁, 107753017 >
* < 鄺芷君, 107753045 >

### Goal
*The final goal of this project is to Identify a voice as male or female

### demo 
*commend: Rscript Rscript sum.R voice.csv train/test

*on-line visualization: shiny

### docs
* presentation: 1071_datascience_FP_<107753017,107753045>.pptx
* related document for the final project
  * papers
        https://www.csie.ntu.edu.tw/~cjlin/papers/libsvm.pdf

### data
* voice.csv
* Input format: .csv

### code
* method: libsvm
* comparison?: ROC curve and other methods of machine learning
* perform evaluation? 10 folds Cross-validation, extra separated data

### results

* metric: Sensitivity, Specificity,Accuracy
* challenge: lack of datas, and cross validation didn’t work as well as we thought.