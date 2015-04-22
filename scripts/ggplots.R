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


library(ggplot2)
d <- data.frame(topic = rep(1:30, 5), 
                star = rep(c("1 star", "2 star", "3 star", "4 star", "5 star"), each = 30),
                distribution = c(dist[ , 5], dist[ , 4], dist[ , 3], dist[ , 2], dist[ , 1]))
p <- ggplot(data = d, aes(x = topic, y = distribution, fill = star)) + scale_fill_grey() + 
    geom_bar(stat = "identity") + ggtitle("Distribution of Reviews on Topics")
print(p)

d1 <- data.frame(topic = 1:30, frequency = dist[ ,5])
p1 <- ggplot(data = d1, aes(x = topic, y = frequency)) + 
    geom_bar(stat="identity", fill="#339999") + 
    ggtitle("Distribution of 1 Star Reviews on Topics") + 
    geom_text(data = NULL, x = 14, y = 15000, label = "Topic 14 \n time \n service \n order \n minutes \n ordered \n table \n asked \n took \n server \n wait")
print(p1)

d2 <- data.frame(topic = 1:30, frequency = dist[ ,4])
p2 <- ggplot(data = d2, aes(x = topic, y = frequency)) + 
    geom_bar(stat="identity", fill="#FF6600") + 
    ggtitle("Distribution of 2 Star Reviews on Topics") +
    geom_text(data = NULL, x = 14, y = 9000, label = paste("Topic 14" , paste(lda[ , 14], collapse = "\n"), sep = "\n"))
print(p2)

d3 <- data.frame(topic = 1:30, frequency = dist[ ,3])
p3 <- ggplot(data = d3, aes(x = topic, y = frequency)) + 
    geom_bar(stat="identity", fill="#9999FF") + 
    ggtitle("Distribution of 3 Star Reviews on Topics") + 
    geom_text(data = NULL, x = 14, y = 5000, label = paste("Topic 14" , paste(lda[ , 14], collapse = "\n"), sep = "\n")) + 
    geom_text(data = NULL, x = 18, y = 5200, label = paste("Topic 18" , paste(lda[ , 18], collapse = "\n"), sep = "\n"))
print(p3)

d4 <- data.frame(topic = 1:30, frequency = dist[ ,2])
p4 <- ggplot(data = d4, aes(x = topic, y = frequency)) + 
    geom_bar(stat="identity", fill="#FF33CC") + 
    ggtitle("Distribution of 4 Star Reviews on Topics") +
    geom_text(data = NULL, x = 23, y = 4500, label = paste("Topic 23" , paste(lda[ , 23], collapse = "\n"), sep = "\n"))
print(p4)

d5 <- data.frame(topic = 1:30, frequency = dist[ ,1])
p5 <- ggplot(data = d5, aes(x = topic, y = frequency)) + 
    geom_bar(stat="identity", fill="#99CC66") + 
    ggtitle("Distribution of 5 Star Reviews on Topics")
print(p5)