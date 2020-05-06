#### CHAPTER 1 : KNN ####
##################

# Load the 'class' package
library(class)

# Create a vector of labels
sign_types <- signs$sign_type

# Classify the next sign observed
knn(train = signs[-1], test = next_sign, cl = sign_types)

# Examine the structure of the signs dataset
str(signs)

# Count the number of signs of each type
table(signs$sign_type)

# Check r10's average red level by sign type
aggregate(r10 ~ sign_type, data = signs, mean)

# Use kNN to identify the test road signs
sign_types <- signs$sign_type
signs_pred <- knn(train = signs[-1], test = test_signs[-1], cl = sign_types)

# Create a confusion matrix of the predicted versus actual values
signs_actual <- test_signs$sign_type
table(signs_pred, signs_actual)

# Compute the accuracy
mean(signs_pred == signs_actual)

# Compute the accuracy of the baseline model (default k = 1)
k_1 <- knn(train = signs[-1], test = signs_test[-1], cl = sign_types)
mean(k_1 == signs_actual)

# Modify the above to set k = 7
k_7 <- knn(train = signs[-1], test = signs_test[-1], cl = sign_types, k = 7)
mean(k_7 == signs_actual)

# Set k = 15 and compare to the above
k_15 <- knn(train = signs[-1], test = signs_test[-1], cl = sign_types, k = 15)
mean(k_15 == signs_actual)

# Use the prob parameter to get the proportion of votes for the winning class
sign_pred <- knn(train = signs[-1], test = signs_test[-1], cl = sign_types, k = 7, prob = T)

# Get the "prob" attribute from the predicted classes
sign_prob <- attr(sign_pred, "prob")

# Examine the first several predictions
head(sign_pred)

# Examine the proportion of votes for the winning class
head(sign_prob)

#### CHAPTER 2 : NAIVE BAYES ####
################################

# Compute P(A) 
p_A <- nrow(subset(where9am, location == "office"))/nrow(where9am)

# Compute P(B)
p_B <- nrow(subset(where9am, daytype == "weekday"))/nrow(where9am)

# Compute the observed P(A and B)
p_AB <- nrow(subset(where9am, daytype == "weekday" & location == "office"))/nrow(where9am)

# Compute P(A | B) and print its value
p_A_given_B <- p_AB/p_B
p_A_given_B


# Load the naivebayes package
library(naivebayes)

# Build the location prediction model
locmodel <- naive_bayes(location ~ daytype, data = where9am)

# Predict Thursday's 9am location
predict(locmodel, thursday9am)

# Predict Saturdays's 9am location
predict(locmodel, saturday9am)


# The 'naivebayes' package is loaded into the workspace already

# Build a NB model of location
locmodel <- naive_bayes(location ~daytype+hourtype, locations)

# Predict Brett's location on a weekday afternoon
predict(locmodel, weekday_afternoon)

# Predict Brett's location on a weekday evening
predict(locmodel, weekday_evening)

# The 'naivebayes' package is loaded into the workspace already
# The Naive Bayes location model (locmodel) has already been built

# Observe the predicted probabilities for a weekend afternoon
predict(locmodel, weekend_afternoon, type = "prob")

# Build a new model using the Laplace correction
locmodel2 <- naive_bayes(location ~ daytype+hourtype, locations,laplace = 1)

# Observe the new predicted probabilities for a weekend afternoon
predict(locmodel2, weekend_afternoon, type = "prob")
