
# Chargement des données de log

library(data.table)
logTrackingSemaine <- read.delim("/logTrackingSemaine.txt")

# transformation de l'id en factor 

logTrackingSemaine$idDiffusion <- as.factor(logTrackingSemaine$idDiffusion)
logTrackingSemaine$idDiffusion <- as.factor(paste("id",as.character(logTrackingSemaine$idDiffusion),sep=""))

# Création des populations ciblÃ©es 

envoi <- aggregate(idAbonne~idDiffusion, data = logTrackingSemaine, length)
envoi$cleDiffusion <- row.names(envoi)

# Crération de la table de contigence client / id news
tableLog <- dcast(logTrackingSemaine, idAbonne~idDiffusion, fun=length)

#Redressement des length pour variable binaire

for (i in 2:length(tableLog)) {
  tableLog[,i] <- ifelse(tableLog[,i] >=1,1,0)
}

# Suppression de la colonne d'id client
tableLog <-tableLog[,2:10]


# Création de la table des effectifs de contingence News 2/2 

dataLength <- data.frame()
k <- 1
for (i in 1:9) {
  for (j in 1:9) {
    dataLength <- rbind(dataLength,
                        cbind(length(tableLog[tableLog[,i] ==1 & tableLog[,j]==1,1])
                              , paste(i, sep="")
                              , paste(j,sep="")))
    rownames(dataLength)[k] <- paste(i,j, sep="-")
    k <- k+1
  }
}

## Transformatuion de la table de contingence News x/x

dataLength$effectif <- as.numeric(as.character(dataLength$V1))
tableContNews <- dcast(dataLength, V2~V3,  value.var = "effectif")
tableContNews <-tableContNews[,2:10]
row.names(tableContNews) <- envoi$idDiffusion
colnames(tableContNews) <- envoi$idDiffusion

View(tableContNews)



