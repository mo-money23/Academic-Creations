# Question 1:
library(data.table)
ad = read.csv('ad.csv')
ad
dim(ad)

# a)
# No, since we are clustering the data so we can better understand the ad campaigns. There also is no output variable in the case of unsupervised learning.
# So nothing to train the model on, and nothing to test since we do not know the best case.

# b)
set.seed(1)
scaled_ad = scale(ad) # scaled the data since some of the values are variably different and could skew the dataset
scaled_ad
km1 = kmeans(scaled_ad, 3, nstart = 10)
km1
km2 = kmeans(scaled_ad, 4, nstart = 10)
km2

# c)
plot(ad, col = (km1$cluster), main = "K-means Clustering, K=3", pch = 19, cex = 1)
# With respect to each of the four clusters we can see that green is mostly if not all the time on the lower end and closer to x or even y, with black being more in between and pink being on the higher end of x and y. 
# For some plots like radio and X we can see that the cluster is very spread out over the entire plot. 

# d) 
ratio_km2 = km2$tot.withinss - km2$withinss
plot(ad, col = (ratio_km2), main = "Within-cluster error, pch , K=4", pch = 19, cex = 1)
# From the above plot we can see that newspaper has one of the most homogeneous clusters. More specifically the newspaper and sales cluster.

# e)
A = dist(ad)
hc_comp = hclust(dist(ad), method = "complete")
plot(hc_comp, main = "Complete Linkage", xlab = "", ylab = "")
cutree(hc_comp, 4)

# f)
cutree(hc_comp, h=3)
abline(h = 3, col = "red") #plotting a line for ease of viewing
# 200 clusters since the dissimilarity is placed so low, if it was higher there would be less clusters.


# Question 2:
install.packages('arules')
install.packages('arulesViz')
library(arules)
library(arulesViz)
library(data.table)

# a)
data("Groceries")
apriori(Groceries)
rules2 = apriori(Groceries, parameter = list(support = 0.02, confidence = 0.4))
arules::inspect(rules2)

# b)
is.redundant(rules2) # removing redundancies

# c)
arules::inspect(rules2)
rules2[13] # the example chosen is the 13 row of the rules, since it has a total of 3 items in lhs and rhs
# the measures of support illustrates how frequent those associated are together. For rule 13 how frequent are root veggies, other veggies, and milk in one transaction.
# the confidence shows the strength of the association rule, how often items in Y appear within those transactions that contain X. For rule 13 how often does milk show up in transactions that have root veggies and other veggies.
# the lift displays association rule is the ratio of observed support to the expected support, how much the presence of X lifts the probability of Y. For rule 13 when root veggies and other veggies are purchased whats the probability milk is purhcased as well.


# Question 3:
install.packages("tm")
library("tm")
x = read.csv("TextData.csv")
docs = VCorpus(DataframeSource(x))
docs

writeLines(as.character(x))
docs = tm_map(docs, removePunctuation) #removing punctuation marks
tm::inspect(docs)

docs = tm_map(docs, content_transformer(tolower)) # making it all lower case
inspect(docs)

docs = tm_map(docs, removeWords, stopwords("english")) # removing words ad stop words
tm::inspect(docs)

docs = tm_map(docs, removeNumbers) # removing numbers
tm::inspect(docs)

docs = tm_map(docs, stripWhitespace) # removing whitespace
tm::inspect(docs)

docs = tm_map(docs, stemDocument) # stemming document
tm::inspect(docs)

# b)
dtm = DocumentTermMatrix(docs)
tm::inspect(dtm)
findFreqTerms(dtm, 15) # Words that have been used 15 or more times
findAssocs(dtm, "cheap", 0.5)
findAssocs(dtm, "high", 0.5)

# c)
install.packages('wordcloud')
library(wordcloud)
tdm = TermDocumentMatrix(docs, control = list(wordLengths = c(1,Inf)))

m = as.matrix(tdm)
wordFreq = sort(rowSums(m), decreasing = TRUE)
set.seed(375)
wordcloud(words = names(wordFreq), freq = wordFreq, min.freq = 40, random.order = F)

# d)
tdm2 = removeSparseTerms(tdm, sparse = 0.95)
m2 = as.matrix(tdm2)

distMatrix = dist(scale(m2))
fit = hclust(distMatrix) # hierarchal cluster for the terms
plot(fit)
rect.hclust(fit, k = 5)
groups = cutree(fit, k = 5)

# e)
m3 = t(m2)
dim(m3)
set.seed(122)
kmeansResult = kmeans(m3, 5) #k means cluster for documents
kmeansResult$cluster # showing the clusters

# f)
install.packages('syuzhet')
library(syuzhet)
get_sentiment(x$text, method = "syuzhet") # getting sentiment the syuzhet method
d = get_nrc_sentiment(x$text) # nrc sentiment
t_sum = colSums(d)
barplot(t_sum, las = 2)
