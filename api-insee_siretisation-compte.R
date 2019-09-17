library(stringi)
library(digest)
library(caTools)
library(jsonlite)
library(httr)


insee_api <- fromJSON("C:/Users/julien.vanneau/Documents/R/api.json")[[1]]

insee_api_base_url <- insee_api[insee_api$name =="insee", c("base_url")]
insee_api_key <- insee_api[insee_api$name =="insee", c("keyname")]
insee_api_secret <- insee_api[insee_api$name =="insee", c("secret")]
# emarsys_api <- fromJSON("emarsys_api.json")

basic_auth = c('Authorization' = paste0('Basic ', caTools::base64encode(paste0(insee_api_key,":",insee_api_secret))))

 
# get token ----
token_r <- POST(insee_api_base_url, "token?grant_type=client_credentials&validity_period=86400",
  add_headers('', .headers = basic_auth))

##  retreive access token content
access_token <- content(token_r)$access_token
## remove temp data
rm(token_r)



# Get siret from a name ----
api_headers <- c('Accept' = 'application/json', 'Authorization' = paste0('Bearer ', access_token))

multicrit_query <- URLencode("denominationUniteLegale:premiere vision", reserved = TRUE)
query_fieds <- URLencode("siret,denominationUniteLegale", reserved = FALSE)

siret_r <- GET(paste0(insee_api_base_url,
                     'entreprises/sirene/V3/siret?q=',
                     multicrit_query,
                     '"%22&champs=',
                     query_fieds),
              add_headers('', .headers = api_headers))



# revoke token ----
revoke_r <- POST(paste0(insee_api_base_url, "revoke?token=", access_token),
                 add_headers('', .headers = basic_auth))

##  retreive revoke token content
revoke_content <- content(revoke_r)
## remove temp data
rm(basic_auth, revoke_r)

