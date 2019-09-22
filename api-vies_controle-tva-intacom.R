# load Packages ----
library(jsonlite)
library(XML)
library(methods)
library(httr)
library(base64enc)
library(data.table)
library(dplyr)
library(dtplyr)
library(purrr)
library(lubridate)
library(splitstackshape)
library(caTools)
library(readr)

# define vat number ----

country <- 'FR'
vatnum <- '74403131956'

# perform vies webservice call ---- 

## xml body definition
checkvat_body <- paste('<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns="urn:ec.europa.eu:taxud:vies:services:checkVat:types">
<soapenv:Header/><soapenv:Body><tns1:checkVat xmlns:tns1="urn:ec.europa.eu:taxud:vies:services:checkVat:types">
  <tns1:countryCode>',country,'</tns1:countryCode>
  <tns1:vatNumber>',vatnum,'</tns1:vatNumber>
  </tns1:checkVat></soapenv:Body>
                    </soapenv:Envelope>'
                   ,sep="")

## perform soap 
reader = basicTextGatherer()
curlPerform(url = "http://ec.europa.eu/taxation_customs/vies/services/checkVatService",
            postfields = checkvat_body,
            verbose = TRUE,
            writefunction = reader$update
)
checkvat_response <- xmlToList(reader$value())
