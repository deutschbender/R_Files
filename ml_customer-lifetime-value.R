library(rms)
library(readr)
library(dplyr)
library(corrplot)
library(ggplot2)

library(readr)
salesData <- read_csv("C:/Users/Julien/Desktop/salesData.csv")



# Structure of dataset
str(salesData, give.attr = FALSE)

# Visualization of correlations
salesData %>% select_if(is.numeric) %>%
  select(-id) %>%
  cor () %>% corrplot()


# Frequent stores
ggplot(salesData) +
  geom_boxplot(aes(x = mostFreqStore, y = salesThisMon))

# Preferred brand
ggplot(salesData) +
  geom_boxplot(aes(x = preferredBrand, y = salesThisMon))

# Model specification using lm
salesSimpleModel <- lm(salesThisMon ~ salesLast3Mon, 
                       data = salesData)

# Looking at model summary
summary(salesSimpleModel)

# Estimating the full model
salesModel1 <- lm(salesThisMon ~ . - id, 
                  data = salesData)

# Checking variance inflation factors
vif(salesModel1)

# Estimating new model by removing information on brand
salesModel2 <- lm(salesThisMon ~ . - id - preferredBrand - nBrands, 
                  data = salesData)

# Checking variance inflation factors
vif(salesModel2)


Exercice

Call:
  lm(formula = salesThisMon ~ nItems + ... + customerDuration, data = salesData)

Residuals:
  Min      1Q  Median      3Q     Max 
-322.66  -51.26    0.60   51.28  399.10 

Coefficients:
  Estimate Std. Error t value Pr(>|t|)    
(Intercept)                   -2.828e+02  1.007e+01 -28.079  < 2e-16 ***
  nItems                         1.470e-01  2.093e-02   7.023 2.45e-12 ***
  mostFreqStoreColorado Springs -7.829e+00  4.351e+00  -1.799 0.072047 .  
mostFreqStoreColumbus          5.960e-01  3.682e+00   0.162 0.871391    
...
mostFreqCatBaby               -3.496e+00  3.469e+00  -1.008 0.313594    
mostFreqCatBakery             -9.908e+00  5.451e+00  -1.818 0.069188 .  
...   
nCats                         -9.585e-01  1.956e-01  -4.900 9.90e-07 ***
  nPurch                         5.092e-01  1.513e-01   3.364 0.000773 ***
  salesLast3Mon                  3.782e-01  8.480e-03  44.604  < 2e-16 ***
  daysSinceLastPurch             1.712e-01  1.526e-01   1.122 0.262022    
meanItemPrice                  2.253e-01  9.168e-02   2.457 0.014034 *  
  meanShoppingCartValue          2.584e-01  2.620e-02   9.861  < 2e-16 ***
  customerDuration               5.708e-01  7.162e-03  79.707  < 2e-16 ***
  
  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 77.56 on 5095 degrees of freedom
Multiple R-squared:  0.8236,    Adjusted R-squared:  0.8227 
F-statistic: 914.9 on 26 and 5095 DF,  p-value: < 2.2e-16

## Good job! The Multiple R-squared of 0.8236 tells you that 82.36% of the dependent variable's variation is explained by the explanatory variables.
# getting an overview of new data
summary(salesData2_4)

# predicting sales
predSales5 <- predict(salesModel2, newdata = salesData2_4)

# calculating mean of future sales
mean(predSales5)
