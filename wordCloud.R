
## Chargement des librairies

library("tm", lib.loc="C:/Program Files/Microsoft/MRO/R-3.2.3/library")
library("wordcloud", lib.loc="C:/Program Files/Microsoft/MRO/R-3.2.3/library")


## chargement du corpus
setwd("C:/Users/Julien/Desktop/Temp/R/tm")
getwd()
reponses <- Corpus (DirSource("temp/"))

reponses <- tm_map(reponses, content_transformer(tolower))
reponses <- tm_map(reponses, removeWords, stopwords("french"))
reponses <- tm_map(reponses, content_transformer(stripWhitespace))
reponses <- tm_map(reponses, removePunctuation)

reponses <- tm_map(reponses, stemDocument)

wordcloud(reponses, scale=c(5,0.5), max.words=200, random.order=FALSE, rot.per=0.35, use.r.layout=FALSE, colors=brewer.pal(8, "Dark2"))


dtm <- TermDocumentMatrix(reponses)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 10)


  
  set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))


findAssocs(dtm, terms = "livraison", corlimit = 0.8)
