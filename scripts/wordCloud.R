dist <- read.table("TopicDistribution.txt", sep = ",")
row.names(dist) <- dist$V1
dist <- dist[ , -1]
dist <- t(dist)
row.names(dist) <- NULL
ndist <- dist/colSums(dist)

lda <- read.table("lda_topics.txt", sep = ",")
row.names(lda) <- lda$V1
lda <- lda[ , -1]
lda <- t(lda)
row.names(lda) <- NULL


library(wordcloud)
t <- matrix(nrow = 300, ncol = 5)
rn <- c()
for (i in 1:30){
    rn <- c(rn, lda[ , i])
}
row.names(t) <- rn
colnames(t) <- c("1 star", "2 star", "3 star", "4 star", "5 star")
for (j in 1:5){
    t[ , j] <- rep(dist[ , 6 - j], each = 10)
}
comparison.cloud(t, title.size = 2)

pal1 <- brewer.pal(9, "PuBuGn")
pal1 <- pal1[-c(1, 2, 8, 9)]
wordcloud(rn, t[ ,1], colors = pal1)

pal2 <- brewer.pal(9, "YlOrRd")
pal2 <- pal2[-c(1, 2, 8, 9)]
wordcloud(rn, t[ ,2], colors = pal2)

pal3 <- brewer.pal(9, "Purples")
pal3 <- pal3[-c(1, 2, 9)]
wordcloud(rn, t[ ,3], colors = pal3)

pal4 <- brewer.pal(9, "PuRd")
pal4 <- pal4[-c(1, 2, 9)]
wordcloud(rn, t[ ,4], colors = pal4)

pal5 <- brewer.pal(9, "YlGn")
pal5 <- pal5[-c(1, 2, 3, 4, 8, 9)]
wordcloud(rn, t[ ,5], colors = pal5)