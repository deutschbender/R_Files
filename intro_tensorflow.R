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
