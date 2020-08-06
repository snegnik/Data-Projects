# Finding the best place for a new OilyGiant well

Within the framework of this project, it was necessary to find the most profitable regions in terms of profit for drilling oil wells. The data were given of oil production volumes by wells in three regions. Based on these data, I built a model - linear regression - and applied the bootstrap method to identify the most profitable region.

## PLAN:

##### INVESTIGETION
1. Download and prepare the data. Explain the procedure.
2. Train and test the model for each region:
    * Split the data into a training set and validation set at a ratio of 75:25.
    * Train the model and make predictions for the validation set.
    * Save the predictions and correct answers for the validation set.
    * Print the average volume of predicted reserves and model RMSE.
    * Analyze the results.
3. Prepare for profit calculation:
    * Store all key values for calculations in separate variables.
    * Calculate the volume of reserves sufficient for developing a new well without losses. Compare the obtained value with the average volume of reserves in each region.
    * Provide the findings about the preparation for profit calculation step.
4. Write a function to calculate profit from a set of selected oil wells and model predictions:
    * Pick the wells with the highest values of predictions.
    * Summarize the target volume of reserves in accordance with these predictions
    * Provide findings: suggest a region for oil wells' development and justify the choice. Calculate the profit for the obtained volume of reserves.
5. Calculate risks and profit for each region:
    * Use the bootstrapping technique with 1000 samples to find the distribution of profit.
    * Find average profit, 95% confidence interval and risk of losses. Loss is negative profit, calculate it as a probability and then express as a percentage.
    * Provide findings: suggest a region for development of oil wells and justify the choice.

## Conclusion
All three regions are suitable for development. Of the three, Region 1 looks the most interesting. Region 1 could bring the most profit with hight probability and its development carries the least risks. Region 2 follows Region 1. Region 1 data is not normally distributed.

