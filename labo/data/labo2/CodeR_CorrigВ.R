
# Voici une ligne de commentaires
# Il est très important de bien documenter son code !


# INSTALLATION D'EXTENSIONS -------------------------------------------------------------
# On installe une fois les extensions, puis on peut mettre la ligne en commentaires
# Voici comment procéder : install.packages("nom_du_paquet")
install.packages("foreign")      ## Read Data Stored by Minitab, S, SAS, SPSS, Stata, Systat, dBase
install.packages("nortest")      ## Tests de normalité supp.
install.packages("sas7bdat")     ## SAS Database Reader (experimental)
install.packages("Hmisc")        ## The Hmisc package contains many functions useful for data analysis
install.packages("pastecs")      ## Statistiques descriptives
install.packages("Rcmdr", dependencies = TRUE) ## R Commander

# CHARGEMENT D'EXTENSIONS (PAQUETS) -----------------------------------------------------
library(foreign)
library(nortest)
library(sas7bdat)
library(Hmisc)
library(pastecs)

# DEFINITION D'UN DOSSIER DE TRAVAIL (RÉPERTOIRE DE VOTRE DISQUE DUR) -------------------
## Nettoyer l'espace de travail
rm(list=ls())
## Définir le répertoire de travail
setwd("C:/Cours/2015/EUR8217 Metho Quanti/labo/Labo2/R")
## Vérifier le répertoire de travail
getwd()

# IMPORTATION DE FICHIERS EXTERNES AVEC LE PAQUET FOREIGN ------------------------------------------------------
# 1. Importation d'un fichier EXCEL
# Il faut préalablement exporter votre fichier Excel en fichier texte
# Aller dans Excel; ouvrir le fichier SR_Data.xls; Fichier Enregister sous SR_Data.txt (changer l'extension)
help(read.table)
fichierTexte <- read.table("SR_Data.txt", header = TRUE)
head(fichierTexte)

# 2. Importation d'un fichier DBF
help(read.dbf)
fichierDBF <- read.dbf("SR_Data.dbf")
head(fichierDBF)

# 3. Importation d'un fichier SPSS
help(read.spss)
fichierSPSS <- read.spss("Data_SPSS.sav", to.data.frame=TRUE)
head(fichierSPSS)

# 4. Importation d'un fichier SAS avec le paquet ‘sas7bdat
fichierSAS <- read.sas7bdat("tableau1.sas7bdat", debug=FALSE)
head(fichierSAS)

# VISUALISATION D'UN TABLEAU AVEC R COMMANDER -------------------------------------
# Chargement de R Commander
library(Rcmdr)
# Dans R cliquer sur le bouton données, choisissez un tableau, puis cliquez sur le bouton visualiser

# STRUCTURATION D'UN TABLEAU ------------------------------------------------------
# 1. Visualiser les noms des variables
names(fichierDBF)
# 2. Supprimer une variable
fichierDBF$Shape_Leng <- NULL
names(fichierDBF)
# 3. Renommer une variable (ici la première variable)
names(fichierDBF)[1] <- "POPTOT"
names(fichierDBF)

# 4. Créer des variables
  # La densité : habitants au km2
fichierDBF$km <- fichierDBF$Shape_Area/ 1000000
fichierDBF$HabKm2 <- fichierDBF$POPTOT/ fichierDBF$km
head(fichierDBF)

# 5a. Transformation de la variable densité
fichierDBF$SqrtDens <- sqrt(fichierDBF$HabKm2)   # Racine carrée
fichierDBF$LogDens <- log(fichierDBF$HabKm2)     # Logarithme

# 5b. Transformation de la variable immigrants récents
# ATTENTION: 	le minimum de la variable IMMREC_PCT est égal à 0.
# Or Log(0) est impossible, donc calculer plutôt: Log(IMMREC_PCT+1)
fichierDBF$SqrtImg <- sqrt(fichierDBF$IMMREC_PCT)     # Racine carrée
fichierDBF$LogImg <- log(fichierDBF$IMMREC_PCT+1)     # Logarithme
summary(fichierDBF)


# VARIABLES CENTREES REDUITES (MOYENNE=0; VARIANCE = 1) ------------------------------
# Créer un tableau à partir d'une sous-sélection d'un tableau de départ
names(fichierDBF)
ZScores <-fichierDBF[,c(12:15)]
names(ZScores)
# Centrage et réduction avec la fonction scale
help(scale)
ZScores$INDICE_PAU <- scale(fichierDBF[1], center = TRUE, scale = TRUE)
ZScores$Dist_Min   <- scale(fichierDBF[2], center = TRUE, scale = TRUE)
ZScores$N_1000     <- scale(fichierDBF[3], center = TRUE, scale = TRUE)
ZScores$Dist_Moy_3 <- scale(fichierDBF[4], center = TRUE, scale = TRUE)
help(sapply)
sapply(ZScores,mean)
sapply(ZScores,sd)

# STATISTIQUES DESCRIPTIVES ------------------------------
# moyenne, médiane, quartiles,min, max
summary(fichierDBF)

# FONCTION sapply: mean, sd, var, min, max, median, range, and quantile
sapply(fichierDBF, mean)
sapply(fichierDBF, sd)
sapply(fichierDBF, min)
sapply(fichierDBF, max)
sapply(fichierDBF, median)
sapply(fichierDBF, range)
sapply(fichierDBF, quantile)

# Avec la fonction describe du paquet Hmisc
describe(fichierDBF)

# Avec la fonction stat.desc du paquet pastecs
stat.desc(fichierDBF, basic=TRUE, norm=TRUE)

# Normalité Kolmogorov-Smirnov et Sahpiro Wilk
sapply(fichierDBF[18:20],lillie.test)
sapply(fichierDBF[18:20],shapiro.test)

# Histogramme
hist(fichierDBF$HabKm2, main = "Histogramme", xlab = "Habitants au km2", ylab = "Effectif", breaks=10, col="lightblue")
hist(fichierDBF$SqrtDens, main = "Histogramme", xlab = "Habitants au km2 (racine)", ylab = "Effectif", breaks=10, col="gold")
hist(fichierDBF$LogDens, main = "Histogramme", xlab = "Habitants au km2 (log)", ylab = "Effectif", breaks=10, col="coral")

# Histogramme avec la courbe normale
x <- fichierDBF$HabKm2
h<-hist(x, breaks=10, col="lightblue", xlab="Habitants au km2", ylab = "Effectif", main="Histogramme avec courbe normale") 
xfit<-seq(min(x),max(x),length=40) 
yfit<-dnorm(xfit,mean=mean(x),sd=sd(x)) 
yfit <- yfit*diff(h$mids[1:2])*length(x) 
lines(xfit, yfit, col="blue", lwd=2)

x <- fichierDBF$SqrtDens
h<-hist(x, breaks=10, col="red", xlab="Habitants au km2 (racine)", ylab = "Effectif", main="Histogramme avec courbe normale") 
xfit<-seq(min(x),max(x),length=40) 
yfit<-dnorm(xfit,mean=mean(x),sd=sd(x)) 
yfit <- yfit*diff(h$mids[1:2])*length(x) 
lines(xfit, yfit, col="blue", lwd=2)


x <- fichierDBF$LogDens
h<-hist(x, breaks=10, col="coral", xlab="Habitants au km2 (log)", ylab = "Effectif", main="Histogramme avec courbe normale") 
xfit<-seq(min(x),max(x),length=40) 
yfit<-dnorm(xfit,mean=mean(x),sd=sd(x)) 
yfit <- yfit*diff(h$mids[1:2])*length(x) 
lines(xfit, yfit, col="blue", lwd=2)
