###### Projet stat spatiale et stat avancée ############

              ##### Janvier 2020 ######


# Importation des fichiers
getwd()
setwd("G:/M2/stat_spatiale/Dabo/projet")
remove(val_2015)
library(readr)
val_foncieres_2015 <- read_delim("https://static.data.gouv.fr/resources/demandes-de-valeurs-foncieres/20191030-114704/valeursfoncieres-2015.txt", 
                delim = "|", locale=locale(decimal_mark = ",")) #, quote = "'"

val_foncieres_2016 <- read_delim("https://static.data.gouv.fr/resources/demandes-de-valeurs-foncieres/20191030-115604/valeursfoncieres-2016.txt", 
                       delim = "|", locale=locale(decimal_mark = ","))
val_foncieres_2017 <- read_delim("https://static.data.gouv.fr/resources/demandes-de-valeurs-foncieres/20191030-121712/valeursfoncieres-2017.txt", 
                       delim = "|", locale=locale(decimal_mark = ","))
val_foncieres_2018 <- read_delim("https://static.data.gouv.fr/resources/demandes-de-valeurs-foncieres/20191030-122610/valeursfoncieres-2018.txt", 
                       delim = "|", locale=locale(decimal_mark = ","))
val_foncieres_2019 <- read_delim("https://static.data.gouv.fr/resources/demandes-de-valeurs-foncieres/20191030-122930/valeursfoncieres-2019.txt", 
                       delim = "|", locale=locale(decimal_mark = ","))








######### NETTOYAGE BASE 2015 ##################

# vérification de la présence de doublons dans les bases
# suppresion des doublons
# Pour supprimer les doublons, on utilise la fonction
# distinct de la librairie 
# duplicated(val_foncieres_2015)
library(dplyr)
val_foncieres_2015_2 <- distinct(val_foncieres_2015)
dim(val_foncieres_2015_2)


# Nettoyage de données
dim(val_foncieres_2015_2)
str(val_foncieres_2015_2)

colnames(val_foncieres_2015_2)
sapply(val_foncieres_2015_2, summary)

# Les colonnes avec que des NA sont supprimées
# `Code service CH`
# `Reference document`
# `1 Articles CGI`
# `2 Articles CGI`

# `3 Articles CGI`
# `4 Articles CGI`
# `5 Articles CGI`
# `Surface Carrez du 3eme lot`
# `Surface Carrez du 5eme lot`
# `Identifiant local`
# 
val_foncieres_2015 <- select(val_foncieres_2015_2, -c("Code service CH", "Reference document", "1 Articles CGI",
                                                      "2 Articles CGI", "3 Articles CGI", "4 Articles CGI",
                                                      "5 Articles CGI", "Surface Carrez du 3eme lot",
                                                      "Surface Carrez du 5eme lot", "Identifiant local"))


table(val_foncieres_2015$`B/T/Q`)

table(val_foncieres_2015$`No voie`)
table(val_foncieres_2015$`Type de voie`)
table(val_foncieres_2015$Voie)
table(val_foncieres_2015$`Code postal`)
table(val_foncieres_2015$Commune)

# Pour
val_foncieres_2015$Pays <- "France"
val_foncieres_2015$Adresse <- paste(paste(val_foncieres_2015$`No voie`, val_foncieres_2015$`Type de voie`, val_foncieres_2015$Voie, sep = " "), 
                 paste(val_foncieres_2015$`Code postal`, val_foncieres_2015$Commune, sep = " "), val_foncieres_2015$Pays, sep = ", ")

library(devtools)
devtools::install_github(repo = 'rCarto/photon',force=TRUE)
library(photon)

#13
locgeo <- geocode(val_foncieres_2015$Adresse[5], limit = 1, key = "place")

# library(tidyverse)
# A présent on cherche à supprimer les lignes des colonnes
# utilisées dans Adresse contenant des NA
# On utilise pour se faire la fonction na.rm du
# Package questionr
# remarque --> on ne peut pas calculer les coordonnées gps sinon
library(questionr)
val_foncieres_2015_3 <- na.rm(val_foncieres_2015, c("No voie", "Type de voie", "Voie", "Code postal", "Commune"))

# On peut à présent calculer les gps
locgeo <- geocode(val_foncieres_2015_3$Adresse, limit = 1, key = "place")[, 13:14]


val_foncieres_2015_3 <- read.csv("val_foncieres_2015.csv", header = T, sep = ";", dec = ",")
val_foncieres_2015_3 <- select(val_foncieres_2015_3, -"X")
write.csv2(val_foncieres_2015_3, "val_foncieres_2015.csv")

val_foncieres_2015_3$No.voie
val_foncieres_2015_3$Type.de.voie
val_foncieres_2015_3$Voie
val_foncieres_2015_3$Code.postal
val_foncieres_2015_3$Commune
val_foncieres_2015_3



### on ajoute 0 à des codes postaux à 4 chiffres
# sur 2015
# il faudra faire pareil sur pour les autres années

val_foncieres_2015_3$Code.postal <- as.character(val_foncieres_2015_3$Code.postal)
for(i in 1:nrow(val_foncieres_2015_3)){
  val_foncieres_2015_3$Code.postal[i]<-ifelse(nchar(val_foncieres_2015_3$Code.postal[i])<5,paste("0",val_foncieres_2015_3$Code.postal[i],sep=""),val_foncieres_2015_3$Code.postal[i])
}


data_gouv_geocod <- select(val_foncieres_2015_3, c("No.voie", "Type.de.voie", "Voie", "Code.postal", "Commune"))

write.csv2(data_gouv_geocod[1:650000, ], "data_gouv_geocod.csv", row.names = F)
write.csv2(data_gouv_geocod[650001:1300793, ], "data_gouv_geocod2.csv", row.names = F)

class(val_foncieres_2015_3$Valeur.fonciere)














######### NETTOYAGE BASE 2016 ##################

# vérification de la présence de doublons dans les bases
# suppresion des doublons
# Pour supprimer les doublons, on utilise la fonction
# distinct de la librairie 
# duplicated(val_foncieres_2015)
library(dplyr)
val_foncieres_2016_2 <- distinct(val_foncieres_2016)
# Nettoyage de données
str(val_foncieres_2016_2)

# Les colonnes avec que des NA sont supprimées
# `Code service CH`
# `Reference document`
# `1 Articles CGI`
# `2 Articles CGI`

# `3 Articles CGI`
# `4 Articles CGI`
# `5 Articles CGI`
# `Surface Carrez du 3eme lot`
# `Surface Carrez du 5eme lot`
# `Identifiant local`
# 
val_foncieres_2016 <- select(val_foncieres_2016_2, -c("Code service CH", "Reference document", "1 Articles CGI",
                                                      "2 Articles CGI", "3 Articles CGI", "4 Articles CGI",
                                                      "5 Articles CGI", "Surface Carrez du 3eme lot",
                                                      "Surface Carrez du 5eme lot", "Identifiant local"))



# Pour
val_foncieres_2016$Pays <- "France"
val_foncieres_2016$Adresse <- paste(paste(val_foncieres_2016$`No voie`, val_foncieres_2016$`Type de voie`, val_foncieres_2016$Voie, sep = " "), 
                                    paste(val_foncieres_2016$`Code postal`, val_foncieres_2016$Commune, sep = " "), val_foncieres_2016$Pays, sep = ", ")

library(devtools)
devtools::install_github(repo = 'rCarto/photon',force=TRUE)
library(photon)

#13
locgeo <- geocode(val_foncieres_2016$Adresse[5], limit = 1, key = "place")

# library(tidyverse)
# A présent on cherche à supprimer les lignes des colonnes
# utilisées dans Adresse contenant des NA
# On utilise pour se faire la fonction na.rm du
# Package questionr
# remarque --> on ne peut pas calculer les coordonnées gps sinon
library(questionr)
val_foncieres_2016_3 <- na.rm(val_foncieres_2016, c("No voie", "Type de voie", "Voie", "Code postal", "Commune"))

# On peut à présent calculer les gps
locgeo <- geocode(val_foncieres_2015_3$Adresse, limit = 1, key = "place")[, 13:14]

write.csv2(val_foncieres_2016_3, "val_foncieres_2016.csv")

##### On divise la base pour utiliser la base du gouvernement
# pour le geocodage
val_foncieres_2016_3 <- read.csv("val_foncieres_2016.csv", header = T, sep = ";", dec = ",")
val_foncieres_2016_3 <- select(val_foncieres_2016_3, -"X")
data_gouv_geocod <- select(val_foncieres_2016_3, c("No.voie", "Type.de.voie", "Voie", "Code.postal", "Commune"))

dim(val_foncieres_2016_3)
write.csv2(data_gouv_geocod[1:650000, ], "data_gouv_geocod.csv", row.names = F)
write.csv2(data_gouv_geocod[650001:1419682, ], "data_gouv_geocod2.csv", row.names = F)


























######### NETTOYAGE BASE 2017 ##################

# vérification de la présence de doublons dans les bases
# suppresion des doublons
# Pour supprimer les doublons, on utilise la fonction
# distinct de la librairie 
# duplicated(val_foncieres_2017)
library(dplyr)
val_foncieres_2017_2 <- distinct(val_foncieres_2017)
dim(val_foncieres_2017_2)


# Nettoyage de données

# Les colonnes avec que des NA sont supprimées
# `Code service CH`
# `Reference document`
# `1 Articles CGI`
# `2 Articles CGI`

# `3 Articles CGI`
# `4 Articles CGI`
# `5 Articles CGI`
# `Surface Carrez du 3eme lot`
# `Surface Carrez du 5eme lot`
# `Identifiant local`
# 
val_foncieres_2017 <- select(val_foncieres_2017_2, -c("Code service CH", "Reference document", "1 Articles CGI",
                                                      "2 Articles CGI", "3 Articles CGI", "4 Articles CGI",
                                                      "5 Articles CGI", "Surface Carrez du 3eme lot",
                                                      "Surface Carrez du 5eme lot", "Identifiant local"))

# Pour
val_foncieres_2017$Pays <- "France"
val_foncieres_2017$Adresse <- paste(paste(val_foncieres_2017$`No voie`, val_foncieres_2017$`Type de voie`, val_foncieres_2017$Voie, sep = " "), 
                                    paste(val_foncieres_2017$`Code postal`, val_foncieres_2017$Commune, sep = " "), val_foncieres_2017$Pays, sep = ", ")

library(devtools)
devtools::install_github(repo = 'rCarto/photon',force=TRUE)
library(photon)

#13
locgeo <- geocode(val_foncieres_2015$Adresse[5], limit = 1, key = "place")

# library(tidyverse)
# A présent on cherche à supprimer les lignes des colonnes
# utilisées dans Adresse contenant des NA
# On utilise pour se faire la fonction na.rm du
# Package questionr
# remarque --> on ne peut pas calculer les coordonnées gps sinon
library(questionr)
val_foncieres_2017_3 <- na.rm(val_foncieres_2017, c("No voie", "Type de voie", "Voie", "Code postal", "Commune"))

# On peut à présent calculer les gps
locgeo <- geocode(val_foncieres_2015_3$Adresse, limit = 1, key = "place")[, 13:14]

class(val_foncieres_2017_3$latitude)
class(val_foncieres_2017_3$longitude)
write.csv2(val_foncieres_2017_3, "val_foncieres_2017.csv", row.names = F)


############
library(dplyr)
val_foncieres_2017_3 <- read.csv("val_foncieres_2017.csv", header = T, sep = ";", dec = ",")
val_foncieres_2017_3 <- select(val_foncieres_2017_3, -"X")
data_gouv_geocod <- select(val_foncieres_2017_3, c("No.voie", "Type.de.voie", "Voie", "Code.postal", "Commune"))

write.csv2(data_gouv_geocod[1:650000, ], "data_gouv_geocod.csv", row.names = F)
write.csv2(data_gouv_geocod[650001:1300793, ], "data_gouv_geocod2.csv", row.names = F)

val_foncieres_2017_3$longitude
write.csv2(val_foncieres_2017_3[, 36:37], file = "lat_lon_2017.csv", row.names = F)
class(val_foncieres_2017_3$latitude)







######### NETTOYAGE BASE 2018 ##################

# vérification de la présence de doublons dans les bases
# suppresion des doublons
# Pour supprimer les doublons, on utilise la fonction
# distinct de la librairie 
# duplicated(val_foncieres_2018)
library(dplyr)
val_foncieres_2018_2 <- distinct(val_foncieres_2018)


# Nettoyage de données
# Les colonnes avec que des NA sont supprimées
# `Code service CH`
# `Reference document`
# `1 Articles CGI`
# `2 Articles CGI`

# `3 Articles CGI`
# `4 Articles CGI`
# `5 Articles CGI`
# `Surface Carrez du 3eme lot`
# `Surface Carrez du 5eme lot`
# `Identifiant local`
# 
val_foncieres_2018 <- select(val_foncieres_2018_2, -c("Code service CH", "Reference document", "1 Articles CGI",
                                                      "2 Articles CGI", "3 Articles CGI", "4 Articles CGI",
                                                      "5 Articles CGI", "Surface Carrez du 3eme lot",
                                                      "Surface Carrez du 5eme lot", "Identifiant local"))


# Pour
val_foncieres_2018$Pays <- "France"
val_foncieres_2018$Adresse <- paste(paste(val_foncieres_2018$`No voie`, val_foncieres_2018$`Type de voie`, val_foncieres_2018$Voie, sep = " "), 
                                    paste(val_foncieres_2018$`Code postal`, val_foncieres_2018$Commune, sep = " "), val_foncieres_2018$Pays, sep = ", ")

library(devtools)
devtools::install_github(repo = 'rCarto/photon',force=TRUE)
library(photon)

#13
locgeo <- geocode(val_foncieres_2015$Adresse[5], limit = 1, key = "place")

# library(tidyverse)
# A présent on cherche à supprimer les lignes des colonnes
# utilisées dans Adresse contenant des NA
# On utilise pour se faire la fonction na.rm du
# Package questionr
# remarque --> on ne peut pas calculer les coordonnées gps sinon
library(questionr)
val_foncieres_2018_3 <- na.rm(val_foncieres_2018, c("No voie", "Type de voie", "Voie", "Code postal", "Commune"))

# On peut à présent calculer les gps
locgeo <- geocode(val_foncieres_2015_3$Adresse, limit = 1, key = "place")[, 13:14]

write.csv2(val_foncieres_2018_3, "val_foncieres_2018.csv", row.names = F)

##### On divise la base pour utiliser la base du gouvernement
# pour le geocodage
val_foncieres_2018_3 <- read.csv("val_foncieres_2018.csv", header = T, sep = ";", dec = ",")
val_foncieres_2018_3 <- select(val_foncieres_2018_3, -"X")
data_gouv_geocod <- select(val_foncieres_2018_3, c("No.voie", "Type.de.voie", "Voie", "Code.postal", "Commune"))

dim(val_foncieres_2018_3)
write.csv2(data_gouv_geocod[1:700000, ], "data_gouv_geocod.csv", row.names = F)
write.csv2(data_gouv_geocod[700001:1506232, ], "data_gouv_geocod2.csv", row.names = F)
1506232-700001




######### NETTOYAGE BASE 2019 ##################

# vérification de la présence de doublons dans les bases
# suppresion des doublons
# Pour supprimer les doublons, on utilise la fonction
# distinct de la librairie 
# duplicated(val_foncieres_2019)
library(dplyr)
val_foncieres_2019_2 <- distinct(val_foncieres_2019)
dim(val_foncieres_2015_2)


# Nettoyage de données

# Les colonnes avec que des NA sont supprimées
# `Code service CH`
# `Reference document`
# `1 Articles CGI`
# `2 Articles CGI`

# `3 Articles CGI`
# `4 Articles CGI`
# `5 Articles CGI`
# `Surface Carrez du 3eme lot`
# `Surface Carrez du 5eme lot`
# `Identifiant local`
# 
val_foncieres_2019 <- select(val_foncieres_2019_2, -c("Code service CH", "Reference document", "1 Articles CGI",
                                                      "2 Articles CGI", "3 Articles CGI", "4 Articles CGI",
                                                      "5 Articles CGI", "Surface Carrez du 3eme lot",
                                                      "Surface Carrez du 5eme lot", "Identifiant local"))



# Pour
val_foncieres_2019$Pays <- "France"
val_foncieres_2019$Adresse <- paste(paste(val_foncieres_2019$`No voie`, val_foncieres_2019$`Type de voie`, val_foncieres_2019$Voie, sep = " "), 
                                    paste(val_foncieres_2019$`Code postal`, val_foncieres_2019$Commune, sep = " "), val_foncieres_2019$Pays, sep = ", ")

library(devtools)
devtools::install_github(repo = 'rCarto/photon',force=TRUE)
library(photon)

#13
locgeo <- geocode(val_foncieres_2015$Adresse[5], limit = 1, key = "place")

# library(tidyverse)
# A présent on cherche à supprimer les lignes des colonnes
# utilisées dans Adresse contenant des NA
# On utilise pour se faire la fonction na.rm du
# Package questionr
# remarque --> on ne peut pas calculer les coordonnées gps sinon
library(questionr)
val_foncieres_2019_3 <- na.rm(val_foncieres_2019, c("No voie", "Type de voie", "Voie", "Code postal", "Commune"))

# On peut à présent calculer les gps
locgeo <- geocode(val_foncieres_2015_3$Adresse, limit = 1, key = "place")[, 13:14]

write.csv2(val_foncieres_2019_3, "val_foncieres_2019.csv", row.names = F)
##### On divise la base pour utiliser la base du gouvernement
# pour le geocodage
remove(val_foncieres_2019_3)
val_foncieres_2019_3 <- read.csv("val_foncieres_2019.csv", header = T, sep = ";", dec = ",")
val_foncieres_2019_3 <- select(val_foncieres_2019_3, -"X")
data_gouv_geocod <- select(val_foncieres_2018_3, c("No.voie", "Type.de.voie", "Voie", "Code.postal", "Commune"))

write.csv2(data_gouv_geocod[1:650000, ], "data_gouv_geocod.csv", row.names = F)
write.csv2(data_gouv_geocod[650001:1300793, ], "data_gouv_geocod2.csv", row.names = F)


remove(val_foncieres_2015, val_foncieres_2016, val_foncieres_2017, val_foncieres_2018, val_foncieres_2019, val_foncieres_2015_2, val_foncieres_2016_2, val_foncieres_2017_2, val_foncieres_2018_2, val_foncieres_2019_2)


# On récupère les fichiers obtenus à partir de 
# Data gouv pour copier la latitude et la longitude

remove(f2015_2)
f2018_1 <- read.csv("lat_lon_2018_1.csv", header = T, sep = ";", dec = ".")
f2018_2 <- read.csv("lat_lon_2018_2.csv", header = T, sep = ";", dec = ".")

class(f2018_1$latitude)
class(f2018_1$longitude)
f2018_1$longitude <- as.numeric(levels(f2018_1$longitude))[f2018_1$longitude]
summary(as.numeric(levels(f2018_1$longitude))[f2018_1$longitude])
summary(f2018_2$longitude)


val_foncieres_2018_3$longitude <- 1
val_foncieres_2018_3$latitude <- 1
dim(f2018_1)
dim(f2018_2)
700000+806232
806231



dim(val_foncieres_2018_3)
val_foncieres_2018_3[1:700000, "longitude"] <- f2018_1$longitude
val_foncieres_2018_3[1:700000, "latitude"] <- f2018_1$latitude


val_foncieres_2018_3[700001:1506232, "longitude"] <- f2018_2$longitude
val_foncieres_2018_3[700001:1506232, "latitude"] <- f2018_2$latitude

summary(f2018_1$latitude)


summary(val_foncieres_2018_3$latitude)
val_foncieres_2015_3


dim(val_foncieres_2015_3)

dim(f2015_1)


lat_lon_2018 <- select(val_foncieres_2018_3, c("longitude", "latitude"))
write.csv2(lat_lon_2018, "lat_lon_2018.csv", row.names = F)

lat_lon_2016 <- select(val_foncieres_2016_3, c("longitude", "latitude"))
write.csv2(lat_lon_2016, "lat_lon_2016.csv")
########
dim(val_foncieres_2018_3)




# 2017 et 2019
f2017_1 <- read.csv("lat_lon_2017_1.csv", header = T, sep = ";", dec = ".")
f2017_2 <- read.csv("lat_lon_2017_2.csv", header = T, sep = ";", dec = ".")
f2019 <- read.csv("lat_lon_2019.csv", header = T, sep = ";", dec = ".")
class(f2017_1$latitude)
class(f2017_1$longitude)
class(f2017_2$latitude)
class(f2017_2$longitude)

f2017_2$longitude <- as.numeric(levels(f2017_2$longitude))[f2017_2$longitude]
f2017_1$longitude <- as.numeric(levels(f2017_1$longitude))[f2017_1$longitude]
summary(f2017_1$longitude)





dim(f2017_1)
dim(f2017_2)
836705+836712

dim(val_foncieres_2019_3)
dim(val_foncieres_2017_3)
val_foncieres_2017_3[1:836705, "longitude"] <- f2017_1$longitude
val_foncieres_2017_3[1:836705, "latitude"] <- f2017_1$latitude


val_foncieres_2017_3[836706:1673417, "longitude"] <- f2017_2$longitude
val_foncieres_2017_3[836706:1673417, "latitude"] <- f2017_2$latitude







val_foncieres_2019_3$latitude <- f2019$latitude
val_foncieres_2019_3$longitude <- f2019$longitude


dim(f2018_1)
dim(f2018_2)
700000+806232
806231



dim(val_foncieres_2018_3)
val_foncieres_2018_3[1:700000, "longitude"] <- f2018_1$longitude
val_foncieres_2018_3[1:700000, "latitude"] <- f2018_1$latitude


val_foncieres_2018_3[700001:1506232, "longitude"] <- f2018_2$longitude
val_foncieres_2018_3[700001:1506232, "latitude"] <- f2018_2$latitude





# valeur fonciere
val_foncieres_2015_3$`Valeur fonciere`
val_foncieres_2015_3$Valeur.fonciere
top10 <- val_foncieres_2015_3[order(val_foncieres_2015_3$Valeur.fonciere, decreasing = T), 
               ][1:10, ]

top10$Valeur.fonciere



#setdiff(HdF$INSEE_COM,df.indice$CODE.VARIABLE)
#intersect(HdF$INSEE_COM,df.indice$CODE.VARIABLE)

# Pour ajouter des observation à notre table 2019
# La fonction bind_rows de dplyr permet d'ajouter 
# des lignes à une table à partir d'une ou 
# plusieurs autres tables.


# La colonne No Volume est de type logique pour les années 2015 et 2018
# On ne peut pas concaténer deux variables de différents types
# C'est pourquoi on supprime la colonne en question avant de 
# Les concaténer

library(dplyr)
valeurs_foncieres <- bind_rows(select(val_foncieres_2019_3, -"No Volume"), select(val_foncieres_2018_3, -"No Volume"), select(val_foncieres_2017_3, -"No Volume"), select(val_foncieres_2016_3, -"No Volume"), select(val_foncieres_2015_3, -"No Volume"))
str(val_foncieres_2015)
class(val_foncieres_2015$`No Volume`)
class(val_foncieres_2016$`No Volume`)
class(val_foncieres_2017$`No Volume`)
class(val_foncieres_2018$`No Volume`)
class(val_foncieres_2019$`No Volume`)
table(val_foncieres_2015$`Valeur fonciere`)
summary(val_foncieres_2015$`Valeur fonciere`)
summary(val_foncieres_2016$`Valeur fonciere`)
summary(val_foncieres_2017$`Valeur fonciere`)
summary(val_foncieres_2018$`Valeur fonciere`)
summary(val_foncieres_2019$`Valeur fonciere`)

# On sauvegarde la base ainsi obtenue
write.csv2(valeurs_foncieres, "valeurs_foncieres.csv")


dim(val_foncieres_2015)
2750121-2634382



# visualisation des valeurs manquantes
# visualisation des valeurs manquantes

# valeur foncière 2015
rm(list=ls())
valeurs_foncieres2015 <- read.csv("val_foncieres_2015.csv", header = T, sep = ";", dec = ",")

install.packages("funModeling")
library(funModeling)
x11()
library(Amelia)
missmap(valeurs_foncieres2015, main = "Valeurs manquantes vs valeurs observées")

# La fonction df_status de la librairie FunModeling
# renvoit, pour chaque variable, le nombre de valeurs 
#égales à zéro, le nombre de valeurs manquantes, et le 
#nombre de valeurs infinies (par exemple 1/0), ainsi que 
#les pourcentages correspondant. Ici, appliquée au jeu 
#de données valeurs_foncieres2015 :

# Certaines variables présentent des nombre très élevés
# de valeurs manquantes (plus des 3/4 des données)
# Ces variables seront supprimées.


df_status(valeurs_foncieres2015)
summary(valeurs_foncieres2015$Surface.Carrez.du.1er.lot)

library(dplyr)


# Les latitudes et longitude obtenues contiennent des valeurs
# Manquantes. On les supprime avant de continuer
library(questionr)
valeurs_foncieres2015 <- na.rm(valeurs_foncieres2015, c("longitude", "latitude"))



# On peut sélectionner à présent les colonnes qui nous 
# intéressent.


valeurs_foncieres2015 <- select(na.rm(valeurs_foncieres2015, c("Valeur.fonciere", "latitude", "longitude")), c("Code.departement", "Commune", "Valeur.fonciere", "latitude", "longitude"))


x11()
boxplot(valeurs_foncieres2015_2$Valeur.fonciere)

# Les outlier
outlier <- boxplot.stats(valeurs_foncieres2015_2$Valeur.fonciere)$out
outlier

# ici, on a 118883 outlier, c'est-à-dire des valeurs qui sont
# en dehors de l'intervalle interquartile
# La majorité des outliers sont des locaux industriels
# localisés pour la plupart à Puteaux et à La Défense, ce qui semble logique

# Cependant, 2 outliers attirent particulièrement l'attention
# Il s'agit d'un appartement et d'une dépendance localisés
# au 69 avenue du roi Albert 1er à Cannes, avec une valeur 
# de 641855000. Nous supprimerons ces deux valeurs

valeurs_foncieres2015 <- valeurs_foncieres2015[ !(valeurs_foncieres2015$Valeur.fonciere) > 500000000, ]
valeurs_foncieres2015 <- valeurs_foncieres2015[ !(valeurs_foncieres2015$Code.departement) %in% c(971, 972, 973, 974, 976), ]


summary(valeurs_foncieres2019$Code.departement)
remove(newdata)
valeurs0 <- valeurs_foncieres2015[ !(valeurs_foncieres2015$Valeur.fonciere) > 0, ]
valeurs0 <- na.rm(valeurs0, c("Valeur.fonciere", "longitude", "latitude"))
summary(valeurs0$Nature.mutation)
summary(valeurs0$Commune)
table(valeurs0$Code.departement)
summary(valeurs0$Type.local)
summary(valeurs0$Surface.terrain)

library(ggplot2)
g <- ggplot(valeurs0, aes(Nature.mutation))
# Number of cars in each class:
g + geom_bar()
g + geom_bar(aes(fill = Commune))


write.csv2(valeurs_foncieres2015, "val2015.csv", row.names = F)
write.csv2(valeurs0, "valeurs02015.csv", row.names = F)


# Dans valeur foncière, il y'a 10362 NA et 3840 0
summary(valeurs_foncieres2015_2bis$Valeur.fonciere)





setwd("G:/M2/stat_spatiale/Dabo/projet")

######## 2016 ###############"
# valeur foncière 2015
remove(valeurs_foncieres2015)
valeurs_foncieres2016 <- read.csv("val_foncieres_2016.csv", header = T, sep = ";", dec = ",")
# On peut sélectionner à présent les colonnes qui nous 
# intéressent.



library(dplyr)
library(questionr)
valeurs_foncieres2016 <- select(na.rm(valeurs_foncieres2016, c("Valeur.fonciere", "latitude", "longitude")), c("Code.departement", "Commune", "Valeur.fonciere", "latitude", "longitude"))


x11()
boxplot(valeurs_foncieres2016_2$Valeur.fonciere)

# Les outlier
outlier <- boxplot.stats(valeurs_foncieres2016_2$Valeur.fonciere)$out
outlier


valeurs_foncieres2016 <- valeurs_foncieres2016[ !(valeurs_foncieres2016$Valeur.fonciere) > 500000000, ]
valeurs_foncieres2016 <- valeurs_foncieres2016[ !(valeurs_foncieres2016$Code.departement) %in% c(971, 972, 973, 974, 976), ]



remove(newdata)
valeurs0 <- valeurs_foncieres2016[ !(valeurs_foncieres2016$Valeur.fonciere) > 0, ]
valeurs0 <- na.rm(valeurs0, c("Valeur.fonciere", "longitude", "latitude"))
summary(valeurs0$Nature.mutation)
summary(valeurs0$Commune)
table(valeurs0$Code.departement)
summary(valeurs0$Type.local)
summary(valeurs0$Surface.terrain)

library(ggplot2)
g <- ggplot(valeurs0, aes(Nature.mutation))
# Number of cars in each class:
g + geom_bar()
g + geom_bar(aes(fill = Commune))


write.csv2(valeurs_foncieres2016, "val2016.csv", row.names = F)
write.csv2(valeurs0, "valeurs02016.csv", row.names = F)












######## 2017 ###############"
# valeur foncière 2017
remove(valeurs_foncieres2016)
valeurs_foncieres2017 <- read.csv("val_foncieres_2017.csv", header = T, sep = ";", dec = ",")
# On peut sélectionner à présent les colonnes qui nous 
# intéressent.

remove(valeurs_foncieres2016)
remove(valeurs_foncieres2016_2)

library(dplyr)
library(questionr)
valeurs_foncieres2017 <- select(na.rm(valeurs_foncieres2017, c("Valeur.fonciere", "latitude", "longitude")), c("Code.departement", "Commune", "Valeur.fonciere", "latitude", "longitude"))


x11()
boxplot(valeurs_foncieres2017_2$Valeur.fonciere)
summary(valeurs_foncieres2017_2$Valeur.fonciere)
# Les outlier
outlier <- boxplot.stats(valeurs_foncieres2017_2$Valeur.fonciere)$out
outlier


valeurs_foncieres2017 <- valeurs_foncieres2017[ !(valeurs_foncieres2017$Valeur.fonciere) > 500000000, ]
valeurs_foncieres2017 <- valeurs_foncieres2017[ !(valeurs_foncieres2017$Code.departement) %in% c(971, 972, 973, 974, 976), ]

remove(newdata)
valeurs0 <- valeurs_foncieres2017[ !(valeurs_foncieres2017$Valeur.fonciere) > 0, ]
valeurs0 <- na.rm(valeurs0, c("Valeur.fonciere", "longitude", "latitude"))
summary(valeurs0$Nature.mutation)
summary(valeurs0$Commune)
table(valeurs0$Code.departement)
summary(valeurs0$Type.local)
summary(valeurs0$Surface.terrain)

library(ggplot2)
g <- ggplot(valeurs0, aes(Nature.mutation))
# Number of cars in each class:
g + geom_bar()
g + geom_bar(aes(fill = Commune))


write.csv2(valeurs_foncieres2017, "val2017.csv", row.names = F)
write.csv2(valeurs0, "valeurs02017.csv", row.names = F)










######## 2018 ###############"
# valeur foncière 2018
remove(valeurs_foncieres2017)
valeurs_foncieres2018 <- read.csv("val_foncieres_2018.csv", header = T, sep = ";", dec = ",")
# On peut sélectionner à présent les colonnes qui nous 
# intéressent.

remove(valeurs_foncieres2017)
remove(valeurs_foncieres2017_2)

library(dplyr)
library(questionr)
valeurs_foncieres2018 <- select(na.rm(valeurs_foncieres2018, c("Valeur.fonciere", "latitude", "longitude")), c("Code.departement", "Commune", "Valeur.fonciere", "latitude", "longitude"))


x11()
boxplot(valeurs_foncieres2018_2$Valeur.fonciere)
summary(valeurs_foncieres2018_2$Valeur.fonciere)
# Les outlier
outlier <- boxplot.stats(valeurs_foncieres2018_2$Valeur.fonciere)$out
outlier


# On peut constater la présence de bcp d'outlier,
# pour la plupart il s'agit de ventes réalisées à chatillon
# Ces propriétés sont vendues à plus de 800000 euros
# Le prix de l'immobilier étant à 6500 euros le m2 en moyenne à
# chatillon, on décide de supprimer les biens avec une valeur
# suppérieure à 500000 euros


valeurs_foncieres2018 <- valeurs_foncieres2018[ !(valeurs_foncieres2018$Valeur.fonciere) > 500000000, ]
valeurs_foncieres2018 <- valeurs_foncieres2018[ !(valeurs_foncieres2018$Code.departement) %in% c(971, 972, 973, 974, 976), ]



remove(newdata)
valeurs0 <- valeurs_foncieres2018[ !(valeurs_foncieres2018$Valeur.fonciere) > 0, ]
valeurs0 <- na.rm(valeurs0, c("Valeur.fonciere", "longitude", "latitude"))

library(ggplot2)
g <- ggplot(valeurs0, aes(Nature.mutation))
# Number of cars in each class:
g + geom_bar()
g + geom_bar(aes(fill = Commune))


write.csv2(valeurs_foncieres2018, "val2018.csv", row.names = F)
write.csv2(valeurs0, "valeurs02018.csv", row.names = F)





######## 2019 ###############"
# valeur foncière 2019
remove(valeurs_foncieres2018)
valeurs_foncieres2019 <- read.csv("val_foncieres_2019.csv", header = T, sep = ";", dec = ",")
# On peut sélectionner à présent les colonnes qui nous 
# intéressent.

remove(valeurs_foncieres2018)
remove(valeurs_foncieres2018_2bis)

library(dplyr)
library(questionr)
valeurs_foncieres2019 <- select(na.rm(valeurs_foncieres2019, c("Valeur.fonciere", "latitude", "longitude")), c("Code.departement", "Commune", "Valeur.fonciere", "latitude", "longitude"))


x11()
boxplot(valeurs_foncieres2019_2$Valeur.fonciere)
summary(valeurs_foncieres2019_2$Valeur.fonciere)
# Les outlier
outlier <- boxplot.stats(valeurs_foncieres2019_2$Valeur.fonciere)$out
outlier


# On peut constater la présence de bcp d'outlier,
# pour la plupart il s'agit de ventes réalisées à chatillon
# Ces propriétés sont vendues à plus de 800000 euros
# Le prix de l'immobilier étant à 6500 euros le m2 en moyenne à
# chatillon, on décide de supprimer les biens avec une valeur
# suppérieure à 500000 euros


valeurs_foncieres2019 <- valeurs_foncieres2019[ !(valeurs_foncieres2019$Valeur.fonciere) > 500000000, ]
valeurs_foncieres2019 <- valeurs_foncieres2019[ !(valeurs_foncieres2019$Code.departement) %in% c(971, 972, 973, 974, 976), ]

remove(newdata)
valeurs0 <- valeurs_foncieres2019[ !(valeurs_foncieres2019$Valeur.fonciere) > 0, ]
valeurs0 <- na.rm(valeurs0, c("Valeur.fonciere", "longitude", "latitude"))

library(ggplot2)
g <- ggplot(valeurs0, aes(Nature.mutation))
# Number of cars in each class:
g + geom_bar()
g + geom_bar(aes(fill = Commune))


write.csv2(valeurs_foncieres2019, "val2019.csv", row.names = F)
write.csv2(valeurs0, "valeurs02019.csv", row.names = F)






#--------------------------------------------------------------


######## Analyse exploratoire du prix des biens ################


#---------------------------------------------------------------
remove(outlier)
rm(list = ls())
setwd("G:/M2/stat_spatiale/Dabo/projet")
val2015 <- read.csv("val2015.csv", header = T, sep = ";", dec = ",")
val2016 <- read.csv("val2016.csv", header = T, sep = ";", dec = ",")
val2017 <- read.csv("val2017.csv", header = T, sep = ";", dec = ",")
val2018 <- read.csv("val2018.csv", header = T, sep = ";", dec = ",")
val2019 <- read.csv("val2019.csv", header = T, sep = ";", dec = ",")

library(tidyverse)
val2015 <- select(val2015, c("longitude", "latitude", "Valeur.fonciere"))
val2016 <- select(val2016, c("longitude", "latitude", "Valeur.fonciere"))
val2017 <- select(val2017, c("longitude", "latitude", "Valeur.fonciere"))
val2018 <- select(val2018, c("longitude", "latitude", "Valeur.fonciere"))
val2019 <- select(val2019, c("longitude", "latitude", "Valeur.fonciere"))


library(geoR)
library(fields)
remove(y)



y = val2015$latitude
x = val2015$longitude
#----graphique du champs--------
summary(x)
summary(y)
summary(val2015$Valeur.fonciere)
boxplot(val2015$Valeur.fonciere)


dim(val2015)

grx = seq(min(x),max(x), by = 0.081)
gry = seq(min(y),max(y), by = 0.081)

x11()
Z = matrix(val2015$Valeur.fonciere, nrow = length(grx), ncol = length(gry), byrow=F)
titre = paste("Champ")
image.plot(grx, gry, Z, main=titre,asp=1)
points(x, y, pch=19)
summary(val2015$Valeur.fonciere)
class(x)
class(y)



######## Plot 2015 #########

data2015 <- val2015[,3:5]
data2015$val <- data2015$Valeur.fonciere
data2015 <- data2015[, -1]

x11()
par(mfrow = c(1, 2))
boxplot(data2015$latitude, xlab = "latitude 2015")
boxplot(data2015$longitude, xlab = "longitude 2015")

# Présence de valeurs extrèmes dans les coordonnées géographiques
# On les supprime pour éviter des problèmes de représentation
val2015 <- val2015[ !(val2015$latitude) < 20, ]
val2015 <- val2015[ !(val2015$longitude) > 40, ]
val2015 <- val2015[ !(val2015$longitude) < -40, ]


# Il faut aussi supprimer les doublons présents dans
# les coordonnées géographiques pour bien voir la carte
duplicated(val_foncieres_2015)
library(dplyr)
data2015$latitude
data2015$longitude
val2015 <- distinct(val2015, longitude, latitude,  .keep_all = TRUE)

summary(val2015$longitude)

geodata = as.geodata(val2015)#convertir les observations en geodata

x11()
plot.geodata(as.geodata(val2015))



x = data2015_2$latitude
y = data2015_2$longitude
#----graphique du champs--------
summary(x)
summary(y)
summary(val2016$Valeur.fonciere)
boxplot(data2015_2$val)


dim(data2015_2)

grx = seq(min(x)-1,max(x)+1, by = 0.017)
gry = seq(min(y)-1,max(y)+1, by = 0.017)

x11()
Z = matrix(data2015_2$val, nrow = length(grx), ncol = length(gry), byrow=F)
titre = paste("Champ")
image.plot(grx, gry, Z,main=titre,asp=1)
points(x, y, pch=19)
summary(val2015$Valeur.fonciere)
class(x)
class(y)




# Plot 2016
rm(list=ls())

x11()
par(mfrow = c(1, 2))
boxplot(data2016$latitude, xlab = "latitude 2016")
boxplot(data2016$longitude, xlab = "longitude 2016")

# Présence de valeurs extrèmes dans les coordonnées géographiques
# On les supprime pour éviter des problèmes de représentation
val2016 <- val2016[ !(val2016$latitude) < 20, ]
val2016 <- val2016[ !(val2016$longitude) > 40, ]
val2016 <- val2016[ !(val2016$longitude) < -40, ]


# Il faut aussi supprimer les doublons présents dans
# les coordonnées géographiques pour bien voir la carte
# duplicated(val_foncieres_2016)
library(dplyr)
data2016$latitude
data2016$longitude
val2016 <- distinct(val2016, longitude, latitude, .keep_all = TRUE)

geodata = as.geodata(data2016_2)#convertir les observations en geodata

x11()
plot.geodata(as.geodata(val2016))
plot(geodata)




###########################

x11()
par(mfrow = c(1, 2))
boxplot(data2017$latitude, xlab = "latitude 2017")
boxplot(data2017$longitude, xlab = "longitude 2017")

# Présence de valeurs extrèmes dans les coordonnées géographiques
# On les supprime pour éviter des problèmes de représentation
val2017 <- val2017[ !(val2017$latitude) < 20, ]
val2017 <- val2017[ !(val2017$longitude) > 40, ]
val2017 <- val2017[ !(val2017$longitude) < -40, ]


# Il faut aussi supprimer les doublons présents dans
# les coordonnées géographiques pour bien voir la carte
duplicated(val_foncieres_2017)
library(dplyr)
val2017 <- distinct(val2017, longitude, latitude, .keep_all = TRUE)
#convertir les observations en geodata
x11()
plot.geodata(as.geodata(val2017))




######################

x11()
par(mfrow = c(1, 2))
boxplot(data2018$latitude, xlab = "latitude 2018")
boxplot(data2018$longitude, xlab = "longitude 2018")

# Présence de valeurs extrèmes dans les coordonnées géographiques
# On les supprime pour éviter des problèmes de représentation
val2018 <- val2018[ !(val2018$latitude) < 20, ]
val2018 <- val2018[ !(val2018$longitude) > 40, ]
val2018 <- val2018[ !(val2018$longitude) < -40, ]


# Il faut aussi supprimer les doublons présents dans
# les coordonnées géographiques pour bien voir la carte
duplicated(val_foncieres_2018)

val2018 <- distinct(val2018, longitude, latitude, .keep_all = TRUE)
plot.geodata(as.geodata(val2018))



###########################"
x11()
par(mfrow = c(1, 2))
boxplot(data2019$latitude, xlab = "latitude 2019")
boxplot(data2019$longitude, xlab = "longitude 2019")

# Présence de valeurs extrèmes dans les coordonnées géographiques
# On les supprime pour éviter des problèmes de représentation
val2019 <- val2019[ !(val2019$latitude) < 20, ]
val2019 <- val2019[ !(val2019$longitude) > 40, ]
val2019 <- val2019[ !(val2019$longitude) < -40, ]


# Il faut aussi supprimer les doublons présents dans
# les coordonnées géographiques pour bien voir la carte
duplicated(val_foncieres_2019)
val2019 <- distinct(val2019, longitude, latitude, .keep_all = TRUE)
#convertir les observations en geodata
x11()
plot.geodata(as.geodata(val2019))




# Etude variographique
library(automap)
##### 2015 #####
val2019 <- distinct(val2019, longitude, latitude, .keep_all = TRUE)
coordinates(val2015) = ~longitude + latitude
variogram = autofitVariogram(Valeur.fonciere~1,val2015) # , max_dist = 50
x11()
plot(variogram)



##### 2016 #####
coordinates(val2016) = ~ longitude + latitude
variogram = autofitVariogram(Valeur.fonciere~1,val2016)
x11()
plot(variogram)


##### 2017 #####
coordinates(val2017) = ~longitude + latitude
variogram = autofitVariogram(Valeur.fonciere~1, val2017)
x11()

plot(variogram)



##### 2018 #####
coordinates(val2018) = ~longitude + latitude
variogram = autofitVariogram(Valeur.fonciere~1,val2018)
x11()
plot(variogram)


##### 2019 #####
coordinates(val2019) = ~longitude + latitude
variogram = autofitVariogram(Valeur.fonciere~1,val2019)
x11()
plot(variogram)



######### Krigeage

rm(list = ls())
# 201
y = val2019$latitude
x = val2019$longitude
summary(x)
summary(y)
dim(val2019)

grx = seq(min(x)-1,max(x)+1, by = 0.026)
gry = seq(min(y)-1,max(y)+1, by = 0.026)

grille = expand.grid(grx,gry)# l'ensemble S
grille2=as.data.frame(grille)
colnames(grille2)=c("x","y")
coords=SpatialPoints(grille2)
kriging_result = autoKrige(Valeur.fonciere~1,val2019, coords)



# champs prédit
Z = matrix(kriging_result$krige_output$var1.pred,nrow=length(grx),ncol=length(gry),byrow=F)
titre2 = paste("Champ prédit")
image.plot(grx,gry,Z,zlim=c(-5,5),main=titre1,asp=1)
points(x,y,pch=19)



# Dans cette partie, on veut extraire les transactions 
# de la région haut de france pour faire le krigeage
rm(list = ls())


valeur_fonciere2019 <- read.csv("val_foncieres_2019.csv", header = T, sep = ";", dec = ",")

mean(valeur_fonciere2019$Valeur.fonciere)
# On récupère les info sur la région Hauts-de-France
HdF <- subset(valeur_fonciere2019, valeur_fonciere2019$Code.departement %in% c("59","62","02","60","80"))
library(tidyverse)
library(questionr)
val2019 <- select(HdF, c("longitude", "latitude", "Valeur.fonciere"))
val2019 <- na.rm(val2019, c("longitude", "latitude", "Valeur.fonciere"))
val2019 <- distinct(val2019, longitude, latitude, .keep_all = TRUE)

write.csv2(val2019, "val2019HdF.csv", row.names = F)

x11()
boxplot(val2019$latitude) # présence d'une valeur aberrante
boxplot(val2019$longitude) # présence d'une valeur aberrante
boxplot(val2019$Valeur.fonciere) # qq outliers


# suppression des valeurs aberrantes
val2019 <- val2019[ !(val2019$latitude) < 20, ]
val2019 <- val2019[ !(val2019$longitude) < -20, ]



# variogram
coordinates(val2019) = ~longitude + latitude
variogram = autofitVariogram(Valeur.fonciere~1,val2019)
x11()
plot(variogram)



######### Krigeage

rm(list = ls())
# 201
y = val2019$latitude
x = val2019$longitude
summary(x)
summary(y)
dim(val2019)

grx = seq(min(x)-1,max(x)+1, by = 0.065)
gry = seq(min(y)-1,max(y)+1, by = 0.065)

grille = expand.grid(grx,gry)# l'ensemble S
grille2=as.data.frame(grille)
colnames(grille2)=c("x","y")
coords=SpatialPoints(grille2)
kriging_result = autoKrige(Valeur.fonciere~1, val2019, coords)


# champs prédit
Z = matrix(kriging_result$krige_output$var1.pred,nrow=length(grx),ncol=length(gry),byrow=F)
#titre2 = paste("Valeurs foncières prédites")
image.plot(grx, gry, Z, main = "Valeurs foncières prédites", asp=1) # ,zlim=c(-5,5)
points(x,y,pch=19)




rm(list = ls())

# Partie statistique avancée
# Dans cette partie on ne travaille que sur la base 2019
valeur_fonciere2019$Date.mutation
remove(valeur_fonciere2019)
valeur_fonciere <- read.csv("valeurs_foncieres.csv", header = T, sep = ";", dec = ",")
valeur_fonciere2019 <- read.csv("val_foncieres_2019.csv", header = T, sep = ";", dec = ",")
valeur_fonciere <- na.rm(valeur_fonciere, c("Date.mutation", "Valeur.fonciere"))
library(questionr)
library(tidyverse)
library(funModeling)
library(lubridate)
library(ggplot2)

valeur_fonciere$Date.mutation <- dmy(valeur_fonciere$Date.mutation)

x11()

median(valeur_fonciere$Valeur.fonciere[year(valeur_fonciere$Date.mutation) == 2015] )
median(valeur_fonciere$Valeur.fonciere[year(valeur_fonciere$Date.mutation) == 2016] )
median(valeur_fonciere$Valeur.fonciere[year(valeur_fonciere$Date.mutation) == 2017] )
median(valeur_fonciere$Valeur.fonciere[year(valeur_fonciere$Date.mutation) == 2018] )
median(valeur_fonciere$Valeur.fonciere[year(valeur_fonciere$Date.mutation) == 2019] )

ggplot(valeur_fonciere, aes(Date.mutation, Valeur.fonciere)) +
  geom_line()+
  geom_hline(yintercept = median(valeur_fonciere$Valeur.fonciere[year(valeur_fonciere$Date.mutation) == 2015] ))+
  geom_hline(yintercept = median(valeur_fonciere$Valeur.fonciere[year(valeur_fonciere$Date.mutation) == 2016] )
             , color = "blue")+
  geom_hline(yintercept = median(valeur_fonciere$Valeur.fonciere[year(valeur_fonciere$Date.mutation) == 2017] )
             , linetype="dashed", color = "blue")+
  geom_hline(yintercept = median(valeur_fonciere$Valeur.fonciere[year(valeur_fonciere$Date.mutation) == 2018] )
             , color = "red")+
  geom_hline(yintercept = median(valeur_fonciere$Valeur.fonciere[year(valeur_fonciere$Date.mutation) == 2019] )
             , linetype="dashed", color = "red")

remove(valeur_fonciere)
#valeur_fonciere2019 <- distinct(valeur_fonciere2019, longitude, latitude, .keep_all = TRUE)


# On sépare variables quali et quanti
# --- fonction choix de variable quali, quanti

choix_var <- function(data, choix = c("quant", "qual")) {
  if (choix == "quant") {
    ind.quant <- sapply(data, function(x) is.numeric(x) | is.integer(x))
    if (!any(ind.quant)) {
      cat("Désolé vous n'avez pas de variables quantitatives\n")
    }
    else {
      data <- data[, ind.quant]
      data
    }
  }
  
  else {
    if (choix == "qual") {
      # ne marche que pour les variables de type factor
      # si les characters t interesse tu peux rajouter | is.character(x)
      ind.qual <- sapply(data, function(x) is.factor(x))
      if (!any(ind.qual)) {
        cat("Désolé vous n'avez pas de variables qualitatives\n")
      }
      else {
        data <- data[, ind.qual]
        data
      }
    }
    else stop("utilisez \"quant\" ou \"qual\" pour caracteriser vos variables\n")
  }
}

#---------------------





var_quant <- choix_var(valeur_fonciere2019, "quant")
var_quali <- choix_var(valeur_fonciere2019, "qual")


df_status(valeur_fonciere2019)



x11()
plot_num(var_quant)

library(xtable)
print(xtable(df_status(valeur_fonciere2019), label = "tab1", caption = "Table descriptive des variables", type = "latex"), file = "dfstatut.tex")


# % NA > 20%
# B.T.Q, Prefixe.de.section, No.Volume,
# X1er.lot, Surface.Carrez.du.1er.lot
# X2eme.lot Surface.Carrez.du.2eme.lot
# X3eme.lot X4eme.lot
# Surface.Carrez.du.4eme.lot X5eme.lot
# Nature.culture Nature.culture.speciale
# Surface.terrain

valeur_fonciere2019 <- select(valeur_fonciere2019, -c("B.T.Q", "Prefixe.de.section",
                                                     "No.Volume", "X1er.lot",
                                                     "Surface.Carrez.du.1er.lot", "X2eme.lot",
                                                     "Surface.Carrez.du.2eme.lot",
                                                     "X3eme.lot", "X4eme.lot",
                                                     "Surface.Carrez.du.4eme.lot", "X5eme.lot",
                                                     "Nature.culture", "Nature.culture.speciale", "Surface.terrain"))
str(var_quant)

# On supprime les NA contenus dans var_quant
names(var_quant)
paste(names(var_quant))
var_quant2 <- select(var_quant, c("No.disposition","No.plan",  "Nombre.de.lots", "Surface.reelle.bati", "Nombre.pieces.principales" , "longitude", "latitude", "Valeur.fonciere"))
var_quant2 <- na.rm(var_quant2, c("No.disposition","No.plan",  "Nombre.de.lots", "Surface.reelle.bati", "Nombre.pieces.principales" , "longitude", "latitude", "Valeur.fonciere"))



cor.mat <- cor(var_quant2, method = "spearman")
# corrélation
library(corrplot)
x11()
corrplot(cor.mat,type="upper",tl.srt=45,tl.col="black",tl.cex=1,diag=F,addCoef.col="black",addCoefasPercent=T)

var_quant2
names(var_quant2)
ggplot(data = var_quant2, aes(Surface.reelle.bati, Nombre.pieces.principales))+
  geom_point()

# On opptera pour une régression pénalisée

# pls

# mco
modele_lm <- lm(Valeur.fonciere ~ No.disposition + No.plan + Nombre.de.lots + Surface.reelle.bati + Nombre.pieces.principales + longitude + latitude,
              data = var_quant2)
summary(modele_lm)
remove(var_quali)
# tous les coef sont significatifs sauf
# No.disposition
# si on retourne voir la matrice de corrélation
# on voit bien que sa corrélation avec valeur fonciere est de 0
summary(var_quant2)



# régression pls
library(pls)
library(dplyr)

# échantillonnage
write.csv2(var_quant2, "var_quanti2.csv", row.names = F)
write.csv2(val.train, "val_train.csv", row.names = F)
write.csv2(val.test, "val_test.csv", row.names = F)
var_quant2$id <- 1:nrow(var_quant2)
val.train <- var_quant2 %>% dplyr::sample_frac(.70)
val.test  <- dplyr::anti_join(var_quant2, val.train, by = 'id')

val.train$Valeur.fonciere


# choix du paramètre
set.seed(87)
cvseg <- cvsegments(nrow(val.train), k = 8,type="random")


choix.kappa <- function(kappamax, cvseg, nbe=100){
  press=rep(0,nbe)
  for (i in 1:length(cvseg)){
    valid=val.train[unlist(cvseg[i]),]
    modele=lm.ridge(sucre~.,
                    data=val.train[unlist(cvseg[-i]),],
                    lambda=seq(0,kappamax,length=nbe))
    coeff=coef(modele)
    prediction=matrix(coeff[,1],nrow(coeff),
                      nrow(valid))+coeff[,-1]%*%
      t(data.matrix(valid[,-1]))
    press=press+rowSums((matrix(valid[,1],
                                nrow(coeff),nrow(valid),byrow=T)-
                           prediction)^2)
  }
}
  

#Création d'une fonction qui permet de représenter les
# résidus en fonctions des valeurs prédites de Y

x11()
plot.res=function(x,y,titre="titre")
{
  plot(x,y,col="blue",ylab="Résidus",
       xlab="Valeurs predites",main=titre)
  abline(h=0,col="green")
}





val.pls <- plsr(Valeur.fonciere~No.disposition + No.plan + Nombre.de.lots + Surface.reelle.bati + Nombre.pieces.principales + longitude + latitude, ncomp = 6, data = val.train, validation = "CV", segments = cvseg)
print(val.pls)
summary(val.pls)

msepcv.pls=MSEP(val.pls,estimate= c("train","CV"))
x11()
plot(val.pls)
plot(msepcv.pls,type="l")


val.train
var_quant2$Valeur.fonciere
fit.pls <- predict(val.pls, ncomp=1:6)[,,6]
res.pls <- fit.pls - val.train[,"Valeur.fonciere"]
x11()
plot.res(fit.pls,res.pls)

