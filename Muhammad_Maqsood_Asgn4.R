# Question 1:
install.packages("forecast") # install packages if nt loaded in R
install.packages("TTR") 
install.packages("aTSA")
install.packages("neuralnet")


# a)

library(forecast)
prsa = read.csv("PRSA_DataSample.csv")
tsTemp = ts(prsa$TEMP, frequency = 12)
tsTemp = na.interp(tsTemp)

# b)
library(TTR)
plot(tsTemp)
plot(runMean(tsTemp, 2)) # plotting the moving average of the last 2 observations

# c)
library(aTSA)
acf(tsTemp)
# From the acf we can see that there is auto-correlation between some if not most of the lags, but this follows the data as there are up and down fluctuating trends.
acf(diff(tsTemp)) # we can take the acf of the difference between the lags
# this gives us a better understanding of which values have auto-correlation, here its with lag of 1, 11, 12, 13 months

pacf(tsTemp)
pacf(diff(tsTemp))
# here we can see in terms of partial auto-correlation that only the first lag of 1 month has a positive correlation.

adf.test(tsTemp)
# here we can see that the p-values are relatively high so we can take the difference to determine if the data is stationary.
adf.test(diff(tsTemp))
# Yes, we do take the difference of the data as we can now see that the data is stationary.

# d)
fit = auto.arima(diff(tsTemp))
summary(fit)
# the orders used are 0 and 1 for both AR and MA models, the data is differenced. And a seasonal model is used.
pred = predict(fit, 2*12)
pred$pred
layout(matrix(c(1,1,2,2), 2,2))
ts.plot(tsTemp, exp(1)^pred$pred, log = "y", lty = c(1, 3))
plot(diff(tsTemp))

# e)
decompose(tsTemp)
fit2 = HoltWinters(tsTemp)
pred2 = forecast::forecast(fit2, h = 24)
layout(matrix(c(1,2,1,2), 2,2))
plot(pred2)
plot(tsTemp)

layout(matrix(c(1,1,1,1), 2,2)) # reset the plot layout

# f)
x = ts(prsa$TEMP)
y = ts(prsa$WSPM)
y = na.interp(y)
plot.ts(x, y, xy.lines = F, xy.labels = F)

regmodel = auto.arima(y, xreg = x)
summary(regmodel)
pvalues = (1 - pnorm(abs(regmodel$coef)/sqrt(diag(regmodel$var.coef)))) *
  2
pvalues
library(lmtest)
coeftest(regmodel)
# since the p-value is more than the significance level (0.05) the relationship is not significant, so temperature does not have an impact on WMSE.


# Question 2:
library(MASS)
library(neuralnet)
Boston

# a)
set.seed(1)
index = sample(nrow(Boston), 400, replace = FALSE)
maxs = apply(Boston[index, ], 2, max)
mins = apply(Boston[index, ], 2, min)
scaled = data.frame(scale(Boston, center = mins, scale = maxs -
                            mins))
trainNN = scaled[index, ]
testNN = scaled[-index, ]

NN = neuralnet(medv ~ ., trainNN, hidden = c(3,5), linear.output = T)
plot(NN)


# b)
predict_testNN = compute(NN, testNN)
predict_testNN = (predict_testNN$net.result * (maxs[6] - mins[6])) +
  mins[6]

# Plotting the data for a clear illustration to improve understanding 
plot(Boston$medv[-index], predict_testNN, col = "blue", pch = 16,
     ylab = "predicted rating NN", xlab = "real rating") 

MSE = sum((Boston$medv[-index] - predict_testNN)^2)/nrow(Boston[-index, ])
MSE # The accuracy in terms of MSE is ~296.12

