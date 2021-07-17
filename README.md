# R-Sloan-Digital-Survey
The Objective is to understand different factors responsible for distinguishing a celestial object, 
whether it be a star, galaxy or quasars by building a model. The model uses various independent variables 
to predict if the celestial body. The goal is to achieve highest accuracy as possible by using the data to
train the model on different algorithms so as to choose the best one.

## Model Building
The data is tested on five different classification model to isolate the one with highest accuracy.
The subsequent ROC curve is observed for all the models and some concrete conclusions are made.
The Model with highest accuracy is choosen in the end.
### Logistic Regression
The model has a near perfect Accuracy of 0.99 or 99%.
The model as P-Value  of less than 2.2×10-16 
As can be understood from the ROC Curve, the model has sensitivity closer to 1 for all classes at specificity 1. Hence, the model has good measure for separability.

![image](https://user-images.githubusercontent.com/37978451/126048342-b7b0eae4-31a6-48b7-bad4-13795b8c5346.png)
### KNN Classifier
The model has a accuracy of 0.8012 or 80.12% with p value less than 2.2×10-16 .
From the ROC curve we can determine that the sensitivity for quasar is really low, whereas for galaxy and star it is moderate.
The model doesn’t have good measure of separability. Hence, the model is doesn’t perform well compared with other models.

![image](https://user-images.githubusercontent.com/37978451/126048349-aa4f04d5-89a7-4790-bcdc-1dd7715ca915.png)
### Naive Bayes Classifier
The model has a accuracy of 0.9584 or 95.84% with p value less than 2.2×10-16.
From ROC curve it can be understood that the model has good judgment of separability for the classes galaxy and star but has little sensitivity for Quasars.
Overall with good accuracy and low p value combined with good sensitivity at lower specificity, the model performs well.

![image](https://user-images.githubusercontent.com/37978451/126048355-daddf823-9cbd-4664-aee1-a6be405426b4.png)
### Support Vector Machine Linear Classifier
The model has a accuracy of 0.9848 or 98.48% with p value less than 2.2×10-16 .
From the ROC curve we can determine that the sensitivity for all the three classes combined with low specificity is closer to ideal.
The model have good measure of separability. Hence, the model performs well.

![image](https://user-images.githubusercontent.com/37978451/126048368-387fb195-f04c-4a40-85d3-41bd63837d85.png)

### Support Vector Machine Sigmoid Classifier
The model has a accuracy of 0.9564 or 95.64% with p value less than 2.2×10-16 .
From the ROC curve we can determine that the sensitivity for all the three classes is high at lower specificity. For class quasar it is a little lower.
The model have good measure of separability for two classes but it lacks behind the Linear SVM in quasar class.
It can be concluded that the data is more linearly separable.
![image](https://user-images.githubusercontent.com/37978451/126048374-7434bb11-7e3f-4b05-b26d-df7984754b38.png)


## Observations
By observing on different models, we can conclude that the data is more suitable for logistic regression model.
The Highest accuracy achieved is 99% with the logistic regression model, while other models like SVM linear performing well enough.
KNN classifier has the poorest accuracy, it doesn’t perform well for quasar class specifically.
