##Introduction to Tensorflow with R

# Create your session
sess <- tf$Session()

# Define a constant (you'll learn this next!)
HiThere <- tf$constant('Hi DataCamp Student!')

# Run your session with the HiThere constant
print(sess$run(HiThere))

# Close the session
sess$close()


# Create two constant tensors
myfirstconstanttensor <- tf$constant(152)
mysecondconstanttensor <- tf$constant('I am a tensor master!')

# Create a matrix of zeros
myfirstvariabletensor <- tf$Variable(tf$zeros(shape(5,1)))



# Set up your session
EmployeeSession <- tf$Session()

# Add your constants
female <- tf$constant(150, name = "FemaleEmployees")
male <- tf$constant(135, name = "MaleEmployees")
total <- tf$add(female, male)
print(EmployeeSession$run(total))

# Write to file
towrite <- tf$summary$FileWriter('./graphs', EmployeeSession$graph)

# Open Tensorboard
tensorboard(log_dir = './graphs')



# From last exercise
total <- tf$add(female,male)

# Multiply your allemps by growth projections
growth <- tf$constant(1.32, name = "EmpGrowth")
EmpGrowth <- tf$math$multiply(total, growth)
print(EmployeeSession$run(EmpGrowth))

# Write to file
towrite <- tf$summary$FileWriter('./graphs', EmployeeSession$graph)

# Open Tensorboard
tensorboard(log_dir = './graphs')


# Start Session
sess <- tf$Session()

# Create 2 constants
a <- tf$constant(10)
b <- tf$constant(32)

# Add your two constants together
sess$run(a + b)

# Create a Variable
mytestvariable <- tf$Variable(tf$zeros(shape(1L)))

# Run the last line
mytestvariable

# chapter 2 Linear regression ---- 


# Parse out the minimum study time and final percent in x_data and y_data variables
x_data <- studentgradeprediction_train$minstudytime
y_data <- studentgradeprediction_train$Finalpercent

# Define your w variable
w <- tf$Variable(tf$random_uniform(shape(1L), -1.0, 1.0))

# Define your b variable
b <- tf$Variable(tf$zeros(shape(1L)))

# Define your linear equation
y <- w * x_data + b






## Defining a cost function

# Define cost function
loss <- tf$reduce_mean((y-y_data)^2)

# Use the Gradient Descent Optimizer
optimizer <- tf$train$GradientDescentOptimizer(0.0001)

# Minimize MSE loss
train <- optimizer$minimize(loss)


## Launching the graph and initializing the variable

# Launch new session
final_grades_session <- tf$Session()

# Initialize (run) global variables
final_grades_session$run(tf$global_variables_initializer())



# Launch new session
final_grades_session <- tf$Session()

# Initialize (run) global variables
final_grades_session$run(tf$global_variables_initializer())


## Training your model
# Train your model
for (step in 1:3750) {
	Finalgradessession$run(train)
    if (step %% 750 == 0)
    	cat("Step = ", step, "Estimate w = ", Finalgradessession$run(w), 
        "Estimate b =", Finalgradessession$run(b), "\n")
}

## Evaluating your model
# Calculate the predicted grades
grades_actual <- studentgradeprediction_test$Finalpercent
grades_predicted <- as.vector(Finalgradessession$run(w)) * 
                    studentgradeprediction_test$minstudytime +
                    as.vector(Finalgradessession$run(b))
grades_predicted
# Plot the actual and predicted grades
plot(grades_actual, grades_predicted, pch=19, col='red')

# Run a correlation 
cor(grades_actual, grades_predicted)

## Linear with estmator API

## Defining feature columns
# Define all four of your feature columns
ftr_colns <- feature_columns(
	tf$feature_column$numeric_column("minstudytime"),
  	tf$feature_column$numeric_column("absences"),
  	tf$feature_column$numeric_column("failures"),
  	tf$feature_column$categorical_column_with_identity("Rural",2)
)

# Choose the correct model
grademodel <- linear_regressor(feature_columns = ftr_colns)

# Define your input function
grade_input_fn <- function(data){
  	input_fn(data,
            features = c("minstudytime", "absences", "failures", "Rural"),
  			response = "Finalpercent")
}


# Calculate the predictions
predictoutput <- predict(grademodel, input_fn = grademodel_input_fn(studentgradeprediction_test))

# Plot actual and predicted values
plot(studentgradeprediction_test$Finalpercent, as.numeric(predictoutput$predictions), xlab = "actual_grades", ylab = "predicted_grades", pch=19, col='red')

# Calculate the correlation
cor(as.numeric(predictoutput$predictions), studentgradeprediction_test$Finalpercent)

#Chapter 3 - Deep neural network with Keras API ----


## Define the model
model <-  keras_model_sequential()
model %>%
	layer_dense(units=15, activation = 'relu', input_shape = 8) %>%
	layer_dense(units=5, activation = 'relu') %>%
	layer_dense(units=1)

## Compile the model
model %>%
	compile (
        optimizer = 'rmsprop',
        loss = 'mse',
        metrics = c('accuracy')

## Fit the model
model %>%
	fit(
        x = train_x,
        y = train_y,
        epochs = 25, 
      	batch_size = 32,
      	validation_split = .2)
		
## Evaluate the model
score <- model %>%
  evaluate(
    test_x, 
    test_y)

# Call up the accuracy 
score$acc		

## Predict based on your model
predictedclasses <- model %>%
  predict_classes(newdata_x)

# Print predicted classes with customers' names
rownames(predictedclasses) <- c('Jasmit', 'Banjeet')
predictedclasses		
		

## Fit the model and define callbacks
model %>%
	fit (
        x = train_x, y = train_y,epochs = 25, 
      	batch_size = 32, validation_split = .2, 
      	callbacks = callback_tensorboard("logs/run_1")
    )

# Call TensorBoard
tensorboard("logs/run_1")

		
## Estimator API 
# Train the model
train(dnnclassifier, 
    input_fn = shopping_input_function(shopper_train))

# Evaluate the model by correcting the error
evaluate(dnnclassifier,
         input_fn = shopping_input_function(shopper_train))	
		
		
##Exercies complet 
		DNN classifier using Keras API
The Banknote_Authentication dataset contains information based on genuine and forged banknotes. Extracted image features from banknotes include kurtosis, wavelength, skewness, and entropy. The Class attribute signifies whether a banknote was real (0) or forged (1).

You'll use this data to create a DNN Classifier using the Keras API. In this activity, you'll create a sequential model and train, test, and evaluate the model using the Bank Note Authentication dataset to explore how accurately you can detect a forged banknote.

For this exercise, the training and testing datasets have been split for you (banknote_authentication_train and banknote_authentication_test).
		
# Create a sequential model and the network architecture
ourdnnmodel <- keras_model_sequential() %>%
  layer_dense(units = 10, activation = "relu", input_shape = ncol(train_x)) %>%
  layer_dense(units = 5, activation = 'relu') %>%
  layer_dense(units = 1)	

compile(optimizer = "rmsprop", loss = "mse", metrics = c("mae", "accuracy"))
		
# Fit your model
learn <- ourdnnmodel %>% fit(x = train_x, y = train_y, epochs = 25,
         batch_size = 32, validation_split = .2, verbose = FALSE)

# Run the learn function
learn
		
		
# CHAPITRE IV
		
		
		
# Define the model
model_lesson1 <-  keras_model_sequential()

# Add the regularizer
model_lesson1 %>%
  layer_dense(units=15, activation = 'relu', 
              input_shape = 8, 
              kernel_regularizer = regularizer_l2(l = 0.1)) %>%
  layer_dense(units=5, activation = 'relu') %>%
  layer_dense(units=1)

		# Compile the model
model_lesson1 %>%
  compile (
    optimizer = 'rmsprop',
    loss = 'mse',
    metrics = c('accuracy')
  )

# Fit the model
model_lesson1 %>%
  fit (
    x = train_x, y = train_y, epochs = 25, 
    batch_size = 32, validation_split = .2)
		
		
# Evaluate the model
score_lesson1 <- model_lesson1 %>%
  evaluate(
    test_x, 
    test_y)

# Call the accuracy and loss
score_lesson1$acc
score_lesson1$loss
		
		
