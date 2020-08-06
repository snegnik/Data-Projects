# Bank Clients Behavior
#### to predict whether clients leave the bank or stay

#### PLAN:
1. Data preprocessing
    * Checking variables
    * Class ratio
2. Logistic model (F1 and ROC AUC Metric)
    * Before balancing
        * Splitting the source data
        * Checking original data using ROC AUC score
        * Logistic Regression and Threshold
    * Balanced
        * Checking original data using ROC AUC score
        * Logistic Regression and Threshold
    * Upsampling
        * Checking original data using ROC AUC score
        * Logistic Regression and Threshold
    * Upsampling and balanced
        * Checking original data using ROC AUC score
        * Logistic Regression and Threshold
3. Decision tree and F1 test
    * Before balancing
    * Balanced
    * Upsampling
        * Moving threshold
    * After upsampling and balanced
        * Moving threshold
4. Random forest and F1 test
    * Before balancing
    * Balanced
    * Upsampling
        * Moving threshold
    * After upsampling and balanced
        * Moving threshold
5. Visualization and comparison
6. The construction of the final model

## INTRODUCTION 

The main goal of the task is to learn how to accurately predict the behavior of the bank client, in particular, to predict whether the client will leave or not. For this, data is used on existing customers who have remained or gone. Those that have gone much less then stay, so the model may work worse. To improve the quality of the model, it is necessary to balance the number of those who left to the number of those who stay.

Three methods and one combination of them will be used for balancing. One of the methods will be the introduction of the *hyperparameter* `(class_weight = 'balanced')` in the parameters of the models. **Logistic regression** will be used to create the model. Next, the *Upsampling* method and the *Threshold* offset will be applied. Then a combination of the first and second methods. To verify the quality of the model, the ROC AUC metric will be used.

Next, I will build models using the **Decision Tree** and **Random Forest** methods. The harmonized indicator F1 will be used as the main metric. I will apply all four methods of balancing the model to find the best indicator of F1.

## GENERAL CONCLUSION

As can been see, balancing has a significant affects the quality of the model. The decision tree turned out to be the best method on this dataset. But not by a large margin. Upsampling and Сombination show an equally high F1 for Decision Tree and Random Forest. But for Logistic Regression Upsampling shows lower results than Balanced method. Changing the cut-off line show a vary small affect.

Because of tests, it was revealed that the best model is a Random Forest with a combination of the balanced methods. With a maximum F1 of 0.604 - the number of correct classifications of the total number, with a maximum depth of 45, and 50 of estimators.

**Final F1 for the test set is 0.599**
