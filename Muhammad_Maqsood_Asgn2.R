# Question 1
ether = read.csv('transaction_dataset.csv')
ether # To show the dataset
dim(ether) # checking the dimensions

# a)
set.seed(1)
ether_train = sample(nrow(ether), 2000, replace = FALSE)
logistic1 = glm(FLAG ~ .-Index, data=ether, subset = ether_train, family=binomial)
summary(logistic1)

# b) 
ether_test = ether[-ether_train ,]
summary(ether_test)
pred_data = predict(logistic1, ether_test, type = "response")
pred_data

pred_data2 = rep(0,7841)
pred_data2[pred_data>0.5]=1
pred_data2

mean(pred_data2==ether_test$FLAG)

# c)
table(pred_data2, ether_test$FLAG)
pred_data3 = rep(0,7841)
pred_data3[pred_data>0.25]=1
pred_data3

mean(pred_data3==ether_test$FLAG)
table(pred_data3, ether_test$FLAG)

# d)
# The classifier cannot properly predict the type I and type II errors, the dataset's test all provides the same number. Making the mean the same. The dataset itself needs to be modified.
# The dataset has not formulated observations to provide a proper conclusion on fraudulent transactions.

# Question 2
mfc = read.csv("accent-mfcc-data-1.csv")
mfc
dim(mfc)
library(MASS)

# a) 
set.seed(1)
mfc_train = sample(nrow(mfc), 250, replace = FALSE)
lda0 = lda(language ~ ., data = mfc, subset = mfc_train)
lda0

# b)
mfc_test = mfc[-mfc_train ,]
summary(mfc_test)
lda0_pred = predict(lda0, mfc_test)
names(lda0_pred)

# c) 
mean(lda0_pred$class==mfc_test$language)
table(lda0_pred$class, mfc_test$language)

# d)
qda0 = qda(language ~ ., data = mfc, subset = mfc_train)
qda0

# e)
qda0_pred = predict(qda0, mfc_test)
names(qda0_pred)

# f)
mean(qda0_pred$class==mfc_test$language)
table(qda0_pred$class, mfc_test$language)
# The lda accuracy mean is slightly higher, this tells us that the structure of the data has a lesser variance as in LDA all the predictors share one covariance matrix
# This also means that the dataset is slightly more linear than quadratic
# To ensure the answer is correct we can create a partition plot to cheack its classification.

# g)
train_in = mfc[mfc_train, c(2:12)]
test_in = mfc[-mfc_train, c(2:12)]

train_out = mfc$language[mfc_train]
test_out = mfc$language[-mfc_train]

train_inSC = scale(train_in)
means = attr(train_inSC, "scaled:center")
sds = attr(train_inSC, "scaled:scale")

test_inSC = scale(test_in, center = means, scale = sds)

set.seed(1)
library(class)
knn_pred = knn(train_inSC, test_inSC, train_out, k=5)
knn_pred2 = knn(train_inSC, test_inSC, train_out, k=10)

knn_pred
mean(knn_pred ==  test_out)

knn_pred2
mean(knn_pred2 == test_out)

# The accuracy of the first model (K=5) is significantly higher, this makes sense as a lower K score would mean that the results will be closer to the training data.
# We can see that the higher the K value the less accurate the model becomes as it moves further from the training data.

# Question 3
library(data.table)
CarEval = fread("CarEvals.csv", header = TRUE, 
                colClasses = c("factor", "factor", "factor", "factor", "factor", "factor", "factor"))
summary(CarEval)
dim(CarEval)
str(CarEval)
attach(CarEval)

# a) 
library(tree)
tree_careval = tree(Class ~ ., CarEval)
summary(tree_careval)
par(mfrow=c(1,1))
plot(tree_careval)
text(tree_careval,pretty = 0)
tree_careval

# b)
set.seed(1)
train = sample(nrow(CarEval), 1000, replace = FALSE)
careval_test = CarEval[-train ,]
tree_careval2 = tree(Class~. , CarEval, subset = train)
tree_careval2
tree_pred = predict(tree_careval2, careval_test, type = "class")

# c)
mean(tree_pred==careval_test$Class)
table(tree_pred, careval_test$Class)

# d)
cv_careval = cv.tree(tree_careval2, FUN = prune.misclass)
names(cv_careval)
cv_careval

par(mfrow=c(1,2))
plot(cv_careval$size, cv_careval$dev, type = "b")
plot(cv_careval$size, cv_careval$k, type = "b")
# The best tree size here is the tuning parameter, which means the best size is 13.

# e)
prune_careval = prune.misclass(tree_careval2, best = 13)
par(mfrow=c(1,1))
plot(prune_careval)
text(prune_careval, pretty =0)

tree_pred2 = predict(prune_careval, careval_test, type = "class")
table(tree_pred2, careval_test$Class)

mean(tree_pred2==careval_test$Class)

# Question 4
# a)
AQdata = fread("AirQualityUCI.csv", header = TRUE)
AQdata1 = ts(AQdata)
AQdata1
AQdataFULL = na.exclude(AQdata1)
AQdataFULL

# b)
# Yes, that can remove all of the other given values within that row. In this specific case I think its best to leave the NAs in the data.
# as it would not interfere with the hourly time and give us hours where data is all missing. Or we can clean it in a way that simply removes the NA but leaves the rest.
# still there is no point because there will be holes, so leave the NAs

# c)
plot(AQdataFULL)
lag.plot(AQdata1)
hist(AQdata1)
# based on these plots the data is flawed and jumps from one value to the next

# d)
qqnorm(AQdata1)
qqline(AQdata1)
# the distribution shows that the data does not follow a normal trend as it jumps from oe value to another.


