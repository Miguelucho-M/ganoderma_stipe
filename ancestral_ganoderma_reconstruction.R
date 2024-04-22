# tomado de S.Price: http://www.evovert.com/R_using_Phylogenies_files/Intro2Phylo_S5.R
#http://www.evovert.com/R_using_Phylogenies_files/Intro2Phylo_S4.R

install.packages("geiger")
install.packages("phytools")
install.packages("maps")
install.packages("ape")
install.packages("xlsx")
install.packages("phangorn")



library(xlsx)
library(maps)
library(ape)
library(phytools)
library(geiger)
library(phangorn)

setwd("C:/Users/migue/OneDrive/Documentos/Miguel/Universidad/Semestre VIII/Evolución/Trabajo final/reconstruccion_crtr_ganoderma")

bootrep <- read.nexus("allBootTrees.tre")
tree_ganoderma<- read.nexus("figtreefinal.tre")

plot(tree_ganoderma)

#root(tree_ganoderma,outgroup=c("A_calcigenum","A_rugosum"), resolve.root = TRUE) -> tree_root
#plot(tree_root, cex=0.75)

# o podemos simular un árbol
#simulate a pure-birth tree with 1000 tips, scaled to a length of 1.0
#tree_sim <- pbtree(n=10,scale=1)
#plot(tree)sim

## to make it ultrametric
#s.ultrametric(tree_ganoderma)
#is.binary(tree_ganoderma)


# para estos análisis el árbol debe ser ultrametrico: la distancia de la raíz a la punta en todos los
# terminales debe ser la misma y dicotómicos, entonces:

#tree_ganoderma_chrono <- chronos(tree_ganoderma, lambda=1) 
#is.ultrametric(tree_ganoderma_chrono)
#plot(tree_ganoderma_chrono)

data <- read.csv("ganoderma_estipite_data1.csv",header=TRUE, row.names = 1)
# Crea un vector vacío
nueva_columna <- rep(1, nrow(data))

# Agrega la nueva columna al dataset
data <- cbind(data, nueva_columna)

View(data)

#vamos a reducir el dataset, porque es muy grande! Al azar escoger 30 spp

#list <- sample(1:22, 20, replace = F)
#data <- data[c(list),c(2,5)]
#plot(data)

## to drop the tips of the tree not included in the matrix! by comparing the tree tips and 
## the data in the matrix. Command in geiger
foo<-name.check(tree_ganoderma,data)
foo

tree <-drop.tip(tree_ganoderma, foo$tree_not_data)
plotTree(tree_ganoderma, type = "fan", fsize = 0.6)

foo2 <- name.check(tree_ganoderma,data)
foo2

## para revisar que el orden de especies en la base de datos es igual al orden del arbol 
data1 <- data[match(tree_ganoderma$tip.label,rownames(data)),]



#####################
##Discrete ch


gnd_estipite<-ace(data1$caracter, tree_ganoderma, type="discrete")

plot(tree_ganoderma, cex=0.8) 
plotBS(tree_ganoderma, bootrep, p=50, type="p", cex=0.7, pos = 4, label.offset=0.0025)
nodelabels(pie=gnd_estipite$lik.anc, piecol=c("#76b041", "#A30000", "#004777" ), cex=0.45, bg = "transparent")

#para colorear también los terminales
estipitecolor<-character(length(tree_ganoderma$tip.label))#creates a vector with the same length as the tip labels in the tree 
estipitecolor[data1$caracter=="estipite"] <- "#76b041" # then populates each element in the vector with a colour depending on character state in scrape
estipitecolor[data1$caracter=="sesil"] <- "#A30000"
estipitecolor[data1$caracter=="subestipite"] <- "#004777"


#plotTree(tree_ganoderma, type = "fan", show.tip.label=FALSE, fsize=0,7)
nodelabels(pie=gnd_estipite$lik.anc, piecol=c("#76b041", "#A30000", "#004777"), cex=0.45)
tiplabels(pch=20, col=estipitecolor, frame="none", bg="white", cex=1.5)

#Para ponerle leyenda
legend("bottomleft", legend = c("Estipite", "Sesil", "Subestipite"), fill = c("#76b041", "#A30000", "#004777"), 
       title = "Estado de caracter", box.col = "white", cex = 1
       , border ="transparent")
