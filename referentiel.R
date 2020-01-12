
## write multiple file based on a column value
mydata[, fwrite(copy(.SD)[, var1 := var1] paste0("output", var1,".csv")), by = var1]
