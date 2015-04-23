setwd("~/Documents/QMSS/2015spring/DataViz/4NYDine/data/")
features_mtx <- read.csv("business_features_mtx.csv",head=F)
features_mtx$V1 <- seq(1,nrow(features_mtx),1)
refer <-  read.csv("business_refer.csv",head=F)
refer <- t(refer)

# euclidean distance
d1 <- dist(as.matrix(features_mtx[,c(-1,-2)]))
hc1 <- hclust(d1) 
hc1$labels <- refer
plot(hc1, main="Hierarchical Clustering of 50 businesses: euclidean distance",cex=.65)


# jaccard index
install.packages("vegan")
library(vegan)

d2<-vegdist(features_mtx,method="jaccard")
hc2 <- hclust(d2)
hc2$labels <- refer
plot(hc2, main="Hierarchical Clustering of 50 businesses: jaccard index",cex=.65)


# hierarchical clustering with p value
install.packages("pvclust")
library(pvclust)

result <- pvclust(t(features_mtx), method.dist="binary", method.hclust="ward.D", nboot=1000)
result[[1]]$labels <- refer
plot(result, main="Hierarchical Clustering of 50 businesses: Bootstrap",cex=.65)

