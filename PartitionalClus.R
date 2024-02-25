# loading data, wp = water potability
wp <- read.csv("water_potability.csv")
summary(wp)

# explore structure of data
str(wp)

# remove rows with missing values
wp <- na.omit(wp)
str(wp)

# standardizing the data
wp <- scale(wp)
head(wp, n=3)

# installing required library packages
install.packages("factoextra")

# use subset of the data
set.seed(123)
ss <- sample(1:100, 50)	# take 50 random rows among 100
wp.ss <- wp[ss,]		# subset of 50 rows

library(factoextra)
fviz_nbclust(wp.ss, kmeans, method="wss")+
		geom_vline(xintercept=4, linetype=2)

# compute kmeans with k=3
km.ss <- kmeans(wp.ss[, -1], centers = 4, nstart=250)

# print the results
print(km.ss)

# cluster number for each of the obs.   
km.ss$cluster
head(km.ss$cluster, 5)

# cluster size
km.ss$size

# cluster means
km.ss$centers

fviz_cluster(km.ss, data = wp.ss[, -1],
		pallete = c("#2E9FDF", "00AFBB", "#E7B800", "black"),
		ellipse.type= "euclid", 
		star.plot = TRUE,
		repel = TRUE,
		ggtheme = theme_minimal(),
		geom = "point",
		stand = FALSE
		)

