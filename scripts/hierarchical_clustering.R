setwd("~/Documents/QMSS/2015spring/DataViz/4NYDine/data/")
features_mtx <- read.csv("business_features_mtx.csv",head=F)
features_mtx$V1 <- seq(1,nrow(features_mtx),1)
refer <-  read.csv("business_refer.csv",head=F)
refer <- t(refer)

d <- dist(as.matrix(features_mtx[,c(-1,-2)]))
hc <- hclust(d) 
hc$labels <- refer
plot(hc, main="Hierarchical Clustering of 50 businesses",cex=.75)
