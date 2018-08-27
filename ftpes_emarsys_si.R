library(RCurl)
ftpUpload(what = "/test.txt", to = "ftpes://exchange.si.emarsys.net/test.txt",
          userpwd =  "", 
          .opt = list(verbose = T, ftp.ssl = T))

lco <- listCurlOptions()
coc <- getCurlOptionsConstants()
