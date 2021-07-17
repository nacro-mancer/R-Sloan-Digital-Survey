##Classification of Stars, Galaxy, and Quasars

#### IMPORT THE LIBRARIES ###
library(ggplot2)
library(caTools)
library(caret)
library(e1071)
library(class)

### SELECT DATASET ###

getwd()
setwd("C:/Users/Priya Patle/Desktop/Class/R/Passion Projects/Project 1")
getwd()

### SELECT DATASET ###

data <- read.csv("Data.csv")
head(data)

dim(data)
str(data)
names(data)
### REMOVING INSIFGINIFICANT COLUMNS ###
unique(data$class)
unique(data$camcol)
unique(data$ra)
unique(data$rerun)
unique(data$run)
unique(data$fiberid)
data_cleaned <- data[,-c(1,10,13,18)]
str(data_cleaned)
dim(data_cleaned)
names(data_cleaned)
### CHECK FOR MISSING DATA ###
colSums(is.na(data_cleaned))
# No MISSING DATA


### CONVERTING TO FACTOR  ####
data_cleaned$class <- factor(data_cleaned$class)
data_cleaned$class <- as.numeric(data_cleaned$class)

### BIVARIATE DATA VISUALIZATION ###

ggplot(mapping = aes(x =data$class , y=data_cleaned$ra))+
  geom_boxplot(notch = TRUE)+xlab('class')+ylab('Right Ascesion')
ggplot(mapping = aes(x =data$class , y=data_cleaned$dec))+
  geom_boxplot(notch = TRUE)+xlab('class')+ylab('Declination')
ggplot(mapping = aes(x =data$class , y=data_cleaned$u))+
  geom_boxplot(notch = TRUE)+xlab('class')+ylab('u')
ggplot(mapping = aes(x =data$class , y=data_cleaned$g))+
  geom_boxplot(notch = TRUE)+xlab('class')+ylab('g')
ggplot(mapping = aes(x =data$class , y=data_cleaned$r))+
  geom_boxplot(notch = TRUE)+xlab('class')+ylab('r')
ggplot(mapping = aes(x =data$class , y=data_cleaned$i))+
  geom_boxplot(notch = TRUE)+xlab('class')+ylab('i')
ggplot(mapping = aes(x =data$class , y=data_cleaned$z))+
  geom_boxplot(notch = TRUE)+xlab('class')+ylab('z')
ggplot(mapping = aes(x =data$class , y=data_cleaned$run))+
  geom_boxplot(notch = TRUE)+xlab('class')+ylab('Run No.')
ggplot(mapping = aes(x =data$class , y=data_cleaned$camcol))+
  geom_boxplot(notch = TRUE)+xlab('class')+ylab('Camera Column')
ggplot(mapping = aes(x =data$class , y=data_cleaned$field))+
  geom_boxplot(notch = TRUE)+xlab('class')+ylab('field')
ggplot(mapping = aes(x =data$class , y=data_cleaned$redshift))+
  geom_boxplot(notch = TRUE)+xlab('class')+ylab('Redshift')
ggplot(mapping = aes(x =data$class , y=data_cleaned$plate))+
  geom_boxplot(notch = TRUE)+xlab('class')+ylab('Plate')
ggplot(mapping = aes(x =data$class , y=data_cleaned$mjd))+
  geom_boxplot(notch = TRUE)+xlab('class')+ylab('Modified Julian Date')


### UNIVARIATE DATA ANALYSIS ###
ggplot(data_cleaned,aes(x=ra))+geom_histogram()+
  geom_vline(xintercept = mean(data_cleaned$ra), lwd = 2)
ggplot(data_cleaned,aes(x=dec))+geom_histogram()+
  geom_vline(xintercept = mean(data_cleaned$dec), lwd = 2)
ggplot(data_cleaned,aes(x=u))+geom_histogram()+
  geom_vline(xintercept = mean(data_cleaned$u), lwd = 2)
ggplot(data_cleaned,aes(x=g))+geom_histogram()+
  geom_vline(xintercept = mean(data_cleaned$g), lwd = 2)
ggplot(data_cleaned,aes(x=r))+geom_histogram()+
  geom_vline(xintercept = mean(data_cleaned$r), lwd = 2)
ggplot(data_cleaned,aes(x=i))+geom_histogram()+
  geom_vline(xintercept = mean(data_cleaned$i), lwd = 2)
ggplot(data_cleaned,aes(x=z))+geom_histogram()+
  geom_vline(xintercept = mean(data_cleaned$z), lwd = 2)
ggplot(data_cleaned,aes(x=run))+geom_histogram()+
  geom_vline(xintercept = mean(data_cleaned$run), lwd = 2)
ggplot(data_cleaned,aes(x=camcol))+geom_histogram()+
  geom_vline(xintercept = mean(data_cleaned$camcol), lwd = 2)
ggplot(data_cleaned,aes(x=class))+geom_histogram()+
  geom_vline(xintercept = mean(data_cleaned$class), lwd = 2)
ggplot(data_cleaned,aes(x=field))+geom_histogram()+
  geom_vline(xintercept = mean(data_cleaned$field), lwd = 2)
ggplot(data_cleaned,aes(x=redshift))+geom_histogram()+
  geom_vline(xintercept = mean(data_cleaned$redshift), lwd = 2)
ggplot(data_cleaned,aes(x=plate))+geom_histogram()+
  geom_vline(xintercept = mean(data_cleaned$plate), lwd = 2)
ggplot(data_cleaned,aes(x=mjd))+geom_histogram()+
  geom_vline(xintercept = mean(data_cleaned$mjd), lwd = 2)


### SPLIT THE DATA ###
split <- sample.split(data_cleaned$class, SplitRatio = 0.75)
split

table(split)

train <- subset(data_cleaned, split==TRUE)
test <- subset(data_cleaned, split==FALSE)
nrow(train)
nrow(test)


###### BUILDING THE MODEL- MULTINOMIAL LOGISTIC REGRESSION ######
log_model <- nnet::multinom(class~.,data = data_cleaned)
log_model
summary(log_model)


### PREDICT THE MODEL ###
log_model_predict <- predict(log_model, newdata = test)
head(log_model_predict)
cm <- table(test[,11], log_model_predict)

### MODEL ACCURACY ###
mean(log_model_predict == test$class)

confusionMatrix(cm)
## ACCURACY - 99 %
library(pROC)
log_order <- as.ordered(log_model_predict)
roc_curve <- multiclass.roc(test$class, log_order, levels = c(1,2,3))
rs <- roc_curve[['rocs']]
plot.roc(rs[[1]])
sapply(2:length(rs),function(i) lines.roc(rs[[i]],col=i))



###### BUILDING THE MODEL- KNN CLASSIFIER ######
knn_model <- knn(train = train[,-11], test = test[,-11],
                      cl=train[,11], k= 10, prob = TRUE)

### PREDICT THE MODEL ###
cm <- table(test[,11], knn_model)


### MODEL ACCURACY ###
confusionMatrix(cm)
## ACCURACY - 79.72 %
library(pROC)
log_order <- as.ordered(knn_model)
roc_curve <- multiclass.roc(test$class, log_order, levels = c(1,2,3))
rs <- roc_curve[['rocs']]
plot.roc(rs[[1]])
sapply(2:length(rs),function(i) lines.roc(rs[[i]],col=i))

###### BUILDING THE MODEL- NAIVE BAYES CLASSIFIER ######

naive_model <- naiveBayes(x= train[-11], y = train$class)
naive_model

### PREDICT THE MODEL ###

naive_pred <- predict(naive_model, newdata = test[-11])
naive_pred


### PREDICT THE MODEL ###
cm <- table(test[,11],naive_pred )

### MODEL ACCURACY ###
confusionMatrix(cm)
## ACCURACY 95.92 %
library(pROC)
log_order <- as.ordered(naive_pred)
roc_curve <- multiclass.roc(test$class, log_order, levels = c(1,2,3))
rs <- roc_curve[['rocs']]
plot.roc(rs[[1]])
sapply(2:length(rs),function(i) lines.roc(rs[[i]],col=i))





###### BUILDING THE MODEL- SVM LINEAR CLASSIFIER ######

svm_model <- svm(class~.,data = train, type = 'C-classification',
                 kernel = 'linear')
svm_model


### PREDICT THE MODEL ###
svm_pred <- predict(svm_model, newdata = test)
svm_pred


### PREDICT THE MODEL ###
cm <- table(test$class, svm_pred)

### MODEL ACCURACY ###
confusionMatrix(cm)
### ACCURACY 98.56 %
log_order <- as.ordered(svm_pred)
roc_curve <- multiclass.roc(test$class, log_order, levels = c(1,2,3))
rs <- roc_curve[['rocs']]
plot.roc(rs[[1]])
sapply(2:length(rs),function(i) lines.roc(rs[[i]],col=i))



###### BUILDING THE MODEL- SVM SIGMOID CLASSIFIER ######
svm_sig_model <- svm(class~., data = train, type = 'C-classification',
                     kernal = 'sigmoid')
svm_sig_model


### PREDICT THE MODEL ###
svm_sig_pred <- predict(svm_sig_model, newdata = test)
svm_sig_pred

cm <- table(test$class, svm_sig_pred)



### MODEL ACCURACY ###
confusionMatrix(cm)
### ACCURACY 95.72 %
log_order <- as.ordered(svm_sig_pred)
roc_curve <- multiclass.roc(test$class, log_order, levels = c(1,2,3))
rs <- roc_curve[['rocs']]
plot.roc(rs[[1]])
sapply(2:length(rs),function(i) lines.roc(rs[[i]],col=i))

