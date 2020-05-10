# Create the k-means model: km.out
km.out <- kmeans(x, centers = 3, nstart = 20)

# Inspect the result
summary(km.out)

# Scatter plot of x
plot(x, col = km.out$cluster, main = "k-means with 3 clusters", xlab = "", ylab = "")
