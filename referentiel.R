
## write multiple file based on a column value
mydata[, fwrite(.SD, paste0("output", var1,".csv")), by = var1]

# duplicate var1 to keep in the output data file
mydata[, fwrite(copy(.SD)[, var1 := var1] paste0("output", var1,".csv")), by = var1]
