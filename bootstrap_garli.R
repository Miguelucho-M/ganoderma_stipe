install.packages("ape")
install.packages("phangorn")

library(ape)
library(phangorn)

setwd("C:/Users/migue/OneDrive/Documentos/Miguel/Universidad/Semestre VIII/Evolución/Trabajo final/Prueba bootstrap")

#Llamar el árbol y las bootreps
tre1 <- read.nexus("garli_run.run00.best.tre")
tre2 <- read.nexus("garli_run.run01.best.tre")
bootreps <- read.nexus("allBootTrees.tre")

#estos es para saber si están enraizados o no
is.rooted.multiPhylo(bootreps) 
is.rooted(tre1)

tre1$tip.label

plot(tre1, cex=0.8)
#enraizar
root(tre1,outgroup = "A_rugosum", resolve.root = TRUE) -> tree_root1
plot(tree_root1)
nodelabels() #esto no sé qué significa

par(mar=c(1,1,3,1))
#mostrar los bootstraps
plotBS(tree_root1, bootreps, p=50, type="p", cex=0.8) #enraizado

plotBS(tre1, bootreps, p=50, type="p", cex=0.7) #sin enraizar
nodelabels()

plotBS(tree_root1, bootreps, p=50, type="p", bs.col = "red", frame = c("rect"), cex=0.8 )#otra manera de representar los bootstraps


#para tre2

tre1$tip.label

plot(tre2, cex=0.8)
#enraizar
root(tre2,outgroup = "A_rugosum", resolve.root = TRUE) -> tree_root2
plot(tree_root2)
nodelabels()

par(mar=c(1,1,3,1))
#mostrar los bootstraps
plotBS(tree_root2, bootreps, p=50, type="p", cex=0.8) #enraizado

plotBS(tre2, bootreps, p=50, type="p", cex=0.7) #sin enraizar
nodelabels()