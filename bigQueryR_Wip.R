## loading library
library(bigrquery)
billing <- bq_test_project("jvann-bigqr") # replace this with your project ID 
sql <- "SELECT year, month, day, weight_pounds FROM `publicdata.samples.natality`"

tb <- bq_project_query(billing, sql)
#> Auto-refreshing stale OAuth token.
bq_table_download(tb, max_results = 10)

library(DBI)

con <- dbConnect(
  bigrquery::bigquery(),
  project = "jvann-bigqr",
  dataset = "catalogue",
  billing = billing
)
con 
#> <BigQueryConnection>
#>   Dataset: publicdata.samples
#>   Billing: bigrquery-examples

dbListTables(con)


project <- "jvann-bigqr" # put your project ID here

# Example query - select copies of files with content containing "TODO"
sql <- "SELECT
 id
, deleted
FROM
[bigquery-public-data:hacker_news.comments]
WHERE
deleted = TRUE
LIMIT
1000"

# Execute the query and store the result
comment_deleted <- query_exec(sql, project = project, useLegacySql = FALSE)
class(comment_deleted)
list_cmt <- as.list(comment_deleted)

summary(salesData)
salesData2 <- salesData[salesData$nItems >= 150,]

cmt <- as_bq_table(list_cmt)
install.packages("bigQueryR", repos = "https://cran.microsoft.com/")
library(bigQueryR)

bqr_auth()
head(salesData2)
bqr_create_table(projectId="jvann-bigqr", datasetId="jvann_test", "salesData", salesData)
bqr_upload_data(projectId = "jvann-bigqr",
                datasetId = "jvann_test",
                tableId = "salesData",
                upload_data = salesData2,
                overwrite = T)
