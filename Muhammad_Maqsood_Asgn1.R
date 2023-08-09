# Question 1
# a)
object1 = seq(5,100, by = 3)
object1<-seq(5,100, by = 3)
seq(5,100, by = 3)->object1
object1
object1[14] # Answer is 44

# b)
objects() 
remove(object1)

# c)
install.packages("dplyr")
library(dplyr) # Loading the package (dplyr)

# d)
matrix1 = matrix(c(runif(n=10,1,2)), nrow = 10, ncol = 1)
matrix1 = cbind(matrix1, c(runif(n=10,2,3))) # bind the second column(variable) to the matrix
matrix1

# e)
plot(matrix1[,1], matrix1[,2], xlab = "Variable 1", ylab = "Variable 2")

# Question 2
# a)
install.packages("ISLR")
library(ISLR)
names(Wage) # List of variables in Wage datase, amount is 11.
# Using the class function we can find if the variables stored are either numeric/integer or factor.
class(Wage$wage) # Here since the value stored is an numeric, the variable is quantitative.
class(Wage$maritl) # Here since the value stored is an factor, the variable is qualitative.
# We can use this logic for all the other variables: 
# Qualitative/Categorical variables = 7, Quantitative Variables = 4 

# b) 
# Race, race should have no correlation to wage in reality or in the dataset. It also would not help in analyzing wage as you cannot determine its affect on wage.

# Question 3
Carseats # View of Dataset
advertGood = Carseats[Carseats$ShelveLoc == "Good",4] # Finds the advertising values of Good Shelf locations
mean(advertGood) # Calculates Average Advertising

advertBad = Carseats[Carseats$ShelveLoc == "Bad",4] # Finds the advertising values of Bad Shelf locations
mean(advertBad) # Calculates Average Advertising

# Question 4
# a)
plot(Carseats$Price, Carseats$Sales, xlab = "Price", ylab = "Sales")

# b)
abline(lm(Carseats$Sales ~ Carseats$Price)) 

# c)
install.packages("ggplot2")
cor(Carseats$Price, Carseats$Sales) # Finds the  correlation coefficient between the x and y.
# The above function returns a negative correlation coefficient, this means that the X and Y are inversely proportional. An increase in X will be a decrease in Y, and vice versa.

# d)
# Yes, in accordance to the correlation coefficient being negative the price can determine if sales will increase or decrease. Again this is because the relationship between the variables is a inverse relationship.

# Question 5
# a)
table(Carseats$ShelveLoc) # Table to show count of each shelf location
table(Carseats$Urban) # Table to show count of urban location (Yes = Urban, No = Not Urban)

# b)
attach(Carseats) # Places both plots together
layout(matrix(c(1,1,2,2), 2,2)) # Creating the layout
barplot(table(Carseats$ShelveLoc))
barplot(table(Carseats$Urban))

# c)
layout(matrix(c(1,1,1,1),1,1)) # Reset the Layout
hist(Carseats$Sales)

# Question 6
# a)
library(data.table)
AdData = read.csv('ad.csv')
AdData = fread('ad.csv')

# b)
class(AdData$radio)
AdData$radio=as.numeric(AdData$radio)
fit1 = lm(AdData$sales~AdData$radio)
summary(fit1) # Simple Regression Model
plot(AdData$radio, AdData$sales, main = "Sales versus radio advertising") # Created for ease of visualization
abline(fit1)
# Yes, Radio advertising definitely has an impact on sales. A positive correlation so when radio adverts increase so do sales.
# When radio advertising is 25 the sales is approximately 9.31164 + 0.20250(25) = 14.37414.

# c)
fit2 = lm(AdData$sales ~ AdData$TV + AdData$radio + AdData$newspaper) # Multiple Regression model
summary(fit2)

# d)
par(mfrow = c(1,2))
plot(predict(fit2), residuals(fit2))
qqnorm(rstandard(fit2), ylab = "Standardized Residuals", xlab = "Normal Scores")
qqline(rstandard(fit2))
# The normality plot of the residuals states that the relationship follows an approximate normal distribution.

# Question 7
# a)
model1 = lm(Sales ~ Advertising + Price + ShelveLoc, data = Carseats)
summary(model1)

# b)
seatData = data.frame(ShelveLoc = "Good", Advertising = 7, Price = 100)
predict(model1, seatData) 

# Question 8 
Carseats
# a) 
# From a business point of view the variable with the desired outcome is the sales, sales determines how much of the product has been sold.
# The number has many other variables reliant on it like: price, advertising, comp price, income. Basically every factor will affect or be affected by sales.

# b)
# The Carseats data-set captures a small portion of the finance aspects of the business with price, sales, advertising, income, and competitive price.
# Whats missing is at least a column or two with relations to expenses, this would help in drawing a full analysis of finances to form a proper conclusion.

# c)
# How does competitive price affect price and sales? Would an increase in population have an effect o the income? Whats the relation of shelf location and advertising?

# Question 9 
# Done on PowerBI
# e) The visual I created is a pie chart depicting the order size by book title, this can give library managers an insights into which book is ordered the most in comparison to others.
# Knowing the book title as opposed to the course name allows the library to easily put in large orders based off of the book versus placing an order based of courses, which can have the same book.
# In the visual you can clearly see which book needs a larger order and which might need a smaller one.











