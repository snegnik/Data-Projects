# Analysing data of the telecom operator
__[pandas, numpy, math, scipy, plotly, matplotlib, seaborn]__

## determine profitability of two prepaid plans

This study aims to study the behavior of subscribers of a given telecom operator. Compare the behavior of subscribers connected to different plans. Explore if there are certain patterns? Track how the behavior changes from month to month. And most importantly, to find out which plan is most profitable for a mobile operator? Which tariff plan brings more profit and puts less load on the network.

### analysis plan:
1. describe data in general
2. fix data
    * NA 
    * outliers
    * anomalies
3. prepare data
    * create supporting variables
4. analyze clients' behavior
    * explore some correlations
    * build plots
    * find measures of average and variance
6. test hypotheses
    * find the average profit difference of two plans
    * find the average profit difference from the users form two regions
7. and determine which prepaid plan is more profitable

# Summary

I have conducted an analysis of a sample of clients of a mobile operator’s network. 

Preliminary analysis showed that:
- Users of the "surf" plan are twice as many 
- Users "surf" brougth 42% more profit then users on utimate plan
- "ultimate" plan brought 23 dollars more profit per user
Correlation test showed that:
- The greatest contribution to profit is made by payments for the overspending of Internet traffic.

Further research indicated that users in general, regardless of the tariff plan, use the same amount of traffic. 
Student's test partly confirms the identity of the behavior of two groups of users. 
A comparison of the average traffic usage and calls indicates that their differences are within the statistical error. 
For users of a more expensive tariff plan, the limit is higher, so they overpay less. 
In other words, lowering the tariff bar should not affect user behavior. 
Further, it was revealed how, from month to month, tariff plan "surf" overtook the frozen plan "ultimate". 
Profits from tariff plan "surf" became more and more. 

**Recommendations**

Based on the data obtained, to get more income you need, it is necessary to attract more users to a "cheaper" tariff. Or expand the number of tariff plans within the normal distribution of the use of Internet traffic.
