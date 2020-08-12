# Bank Clients Behavior
**Tools kit**: [Decision Tree Classifier, Random Forest Classifier, Logistic Regression, Threshold, Upsampling, Recall, Precision, F1 score, ROC curve, ROC AUC] <br>
**Libraries**: [sklearn, pandas, numpy, seaborn, matplotlib]

## Description
Bank data is used on existing customers who have remained or gone. There are fewer of those who left than those who stayed. Because of this imbalance the model may work worse. To improve the quality of the model, it is necessary to balance the number of those who left to the number of those who stay.

## Problem
Find a model that best predicts client behavior: whether the client leaves or remains.

## Сonclusions
The best model is a Random Forest with a combination of the balanced methods. With a maximum F1 of 0.604 - the number of correct classifications of the total number, with a maximum depth of 45, and 50 of estimators. <br>
**Final F1 for the test set is 0.599**
