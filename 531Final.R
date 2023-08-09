
### Required Libraries: 
library(data.table)
library(class)
library(mltools)
library(MASS)
library(ISLR)
library(dplyr)
library(plotly)
library(flightplot)
library(RColorBrewer)

### Runsize must be defined before running regression/classification analysis. 
runsize <- 10000 # How many rows of the dataset you want to use for the training and test sets, 10,000 is the default (most stable). 

# Functions: 

data_cleaning <- function(runsize){
  set.seed(1)
  
  data <- fread('flights.csv')
  
  cancelled <- data[data$CANCELLED == 1,] # Splits data into cancelled and non-cancelled flights
  noncancelled <- data[data$CANCELLED == 0,]
  
  cancelled_training <- cancelled[sample(nrow(cancelled), runsize/4),] # Creates training and test sets, maintains ratio of 75% non-cancelled flights and 25% cancelled flights
  cancelled_test <- cancelled[sample(nrow(cancelled), runsize/4),]
  noncancelled_training <- noncancelled[sample(nrow(noncancelled), (runsize/4)*3),]
  noncancelled_test <- noncancelled[sample(nrow(noncancelled), (runsize/4)*3),]
  flight_training <- rbind(noncancelled_training, cancelled_training)
  flight_test <- rbind(noncancelled_test, cancelled_test)
  
  reg_input <- data.frame(flight_training$MONTH) # Creates dataframe for logistic regression analysis
  reg_input$MONTH <- flight_training$MONTH
  reg_input$DAY <- flight_training$DAY
  reg_input$DAY_OF_WEEK <- flight_training$DAY_OF_WEEK
  reg_input$SCHEDULED_DEPARTURE <- flight_training$SCHEDULED_DEPARTURE
  reg_input$SCHEDULED_ARRIVAL <- flight_training$SCHEDULED_ARRIVAL
  reg_input$SCHEDULED_TIME <- flight_training$SCHEDULED_TIME
  reg_input$CANCELLED <- flight_training$CANCELLED
  reg_input <- reg_input[2:8]
  
  one_hot_training <- data.frame(as.factor(flight_training$AIRLINE), as.factor(flight_training$ORIGIN_AIRPORT), as.factor(flight_training$DESTINATION_AIRPORT)) # One-hot encoding
  colnames(one_hot_training) <- c('Airline', 'Origin_Airport', 'Destination_Airport')
  
  one_hot_training <- one_hot(as.data.table(one_hot_training))
  one_hot_training$MONTH <- flight_training$MONTH
  one_hot_training$DAY_OF_WEEK <- flight_training$DAY_OF_WEEK
  one_hot_training$DEPARTURE_TIME <- flight_training$SCHEDULED_DEPARTURE
  one_hot_training$SCHEDULED_TIME <- flight_training$SCHEDULED_TIME
  one_hot_training$CANCELLED <- flight_training$CANCELLED
  one_hot_training <- as.data.frame(one_hot_training)
  
  one_hot_test <- data.frame(as.factor(flight_test$AIRLINE), as.factor(flight_test$ORIGIN_AIRPORT), as.factor(flight_test$DESTINATION_AIRPORT)) # One-hot encoding
  colnames(one_hot_test) <- c('Airline', 'Origin_Airport', 'Destination_Airport')
  
  one_hot_test <- one_hot(as.data.table(one_hot_test))
  one_hot_test$MONTH <- flight_test$MONTH
  one_hot_test$DAY_OF_WEEK <- flight_test$DAY_OF_WEEK
  one_hot_test$DEPARTURE_TIME <- flight_test$SCHEDULED_DEPARTURE
  one_hot_test$SCHEDULED_TIME <- flight_test$SCHEDULED_TIME
  one_hot_test$CANCELLED <- flight_test$CANCELLED
  one_hot_test <- as.data.frame(one_hot_test)
  
  # Ensures the training and test sets have the same number of columns so they can be used in classification analysis. 
  cols_to_keep <- intersect(colnames(one_hot_training),colnames(one_hot_test)) #https://stackoverflow.com/questions/36886972/remove-columns-from-two-data-frames-if-not-contained-in-one-another-in-r
  one_hot_training <- one_hot_training[,cols_to_keep, drop=FALSE]
  one_hot_training <- one_hot_training[complete.cases(one_hot_training),]
  one_hot_test <- one_hot_test[,cols_to_keep, drop=FALSE]
  one_hot_test <- one_hot_test[complete.cases(one_hot_test),]
  
  return(list(one_hot_training, one_hot_test, reg_input))
}

log_regression <- function(reg_input){
  flight_reg <- glm(CANCELLED ~ MONTH + DAY_OF_WEEK + SCHEDULED_DEPARTURE + SCHEDULED_ARRIVAL + SCHEDULED_TIME + DAY, data = reg_input, family = binomial) #https://www.datacamp.com/community/tutorials/logistic-regression-R
  summary(flight_reg)
}

classification <- function(one_hot_training, one_hot_test){
  knn_accent_training_out <- one_hot_training$CANCELLED
  
  knn_test_response <- one_hot_test$CANCELLED
  
  other_training <- one_hot_training
  
  other_test <- one_hot_test
  
  one_hot_test <- one_hot_test[,(1:(ncol(one_hot_test) - 1))]
  
  one_hot_training <- one_hot_training[,(1:(ncol(one_hot_training) - 1))]
  
  flight_lda <- lda(CANCELLED ~ ., data = other_training)
  lda_pred <- predict(flight_lda, other_test)
  lda_avg <- mean(lda_pred$class==other_test$CANCELLED)
  
  knn_data_2 <- knn(one_hot_training, one_hot_test, knn_accent_training_out, k = 2)
  knn_data_9 <- knn(one_hot_training, one_hot_test, knn_accent_training_out, k = 9)
  knn_2_avg <- mean(knn_data_2==knn_test_response)
  knn_9_avg <- mean(knn_data_9==knn_test_response)
  
  print(paste0('The overall accuracy of LDA was: ', lda_avg))
  print(paste0('The overall accuracy of KNN at K = 2 was: ', knn_2_avg))
  print(paste0('The overall accuracy of KNN at K = 9 was: ', knn_9_avg))
  
  print("LDA Confusion Matrix:")
  print(table(lda_pred$class, other_test$CANCELLED))
  print(table(knn_data_9, knn_test_response))
  print(table(knn_data_2, knn_test_response))
}

### Function calls: ###

# Regression + Classification Prediction Analysis:
  data <- data_cleaning(runsize)
  one_hot_training <- data[[1]]
  one_hot_test <- data[[2]]
  reg_input <- data[[3]]
  log_regression(reg_input)
  classification(one_hot_training, one_hot_test)


### EDA ----------------------------------------------------------------------------------------------------------------------------------------

  
  flights <- fread("flights.csv", header = TRUE)
  flights <- flights[,-(26:31)]
  #   Removes Reasons for Flight Cancellation
  
  flights.s <- flights[sample(nrow(flights), 500, replace = FALSE, prob = NULL),]
  View(flights.s)
  #   subsetting dataset... Helpful for testing functions before using full dataset
  
  
  ##    Objective 1: Filter Data by Cancelled flights
  cancelledtrips <- numeric()
  #   Fill empty vector
  cancelledtrips <- filter(flights, CANCELLED == 1)
  #   filter function from DPLYR, we want to only analyze cancelled flights
  View(cancelledtrips)
  
  ##    Find top 5 most cancelled by airline
  
  df <- cancelledtrips %>%
    group_by(AIRLINE) %>%
    summarise(Freq = sum(CANCELLED))
  #   Taken from dplyr, groups by airline and then takes the sum of Cancelled flights
  
  
  
  df <- df %>% arrange(desc(Freq))
  View(df)
  #   Arranges plot in descending order
  
  ##    Barplot of top cancelled flights
  
  fig <- plot_ly( hovertemplate = paste('%{x}', '<br>lifeExp: %{text:.2s}<br>'),
                  texttemplate = '%{y:.2s}', textposition = 'outside') %>% 
    # Taken from: https://plotly.com/r/text-and-annotations/
    # https://plotly.com/r/figure-labels/
    add_trace(type = "bar",
              x = ~df$AIRLINE,
              y = ~df$Freq,
              mode = "markers",
              marker = list(size = 10,
                            color = colorRampPalette(brewer.pal(10,"Spectral"))(20))) %>%
    #Add Colorwave to BarPlot
    #https://rpubs.com/juanhklopper/color_in_Plotly_for_R
    layout(title = list(text = "Cancelled Flights, by Airline", 
                        y = 0.97), #lower title
           xaxis = list(categoryorder = "total descending",
                        # Creates Plot by descending order
                        title = "Airline"),
           yaxis = list(title = "Frequency"))
  fig
  #   top 5 are WN, EV, MQ, AA, and OO
  
  
  #WN
  cancelledtrips.WN <- filter(cancelledtrips, AIRLINE == "WN")
  
  cancelledtrips.WN <- cancelledtrips.WN[,8:9]
  
  plot_flights(cancelledtrips.WN,
               # crop = "48States", 
               land_color = "#fdae6b", 
               water_color = "#9ecae1", 
               dom_color = "white", 
               int_color = "black", 
               alpha = 1,
               times_as_thickness = FALSE)
  
  #EV
  cancelledtrips.EV <- filter(cancelledtrips, AIRLINE == "EV")
  
  cancelledtrips.EV <- cancelledtrips.EV[,8:9]
  
  plot_flights(cancelledtrips.EV,
               # crop = "48States", 
               land_color = "#fdae6b", 
               water_color = "#9ecae1", 
               dom_color = "white", 
               int_color = "black", 
               alpha = 1,
               times_as_thickness = FALSE)
  
  #MQ
  cancelledtrips.MQ <- filter(cancelledtrips, AIRLINE == "MQ")
  
  cancelledtrips.MQ <- cancelledtrips.MQ[,8:9]
  
  plot_flights(cancelledtrips.MQ,
               # crop = "48States", 
               land_color = "#fdae6b", 
               water_color = "#9ecae1", 
               dom_color = "white", 
               int_color = "black", 
               alpha = 1,
               times_as_thickness = FALSE)
  
  #AA
  cancelledtrips.AA <- filter(cancelledtrips, AIRLINE == "AA")
  
  cancelledtrips.AA <- cancelledtrips.AA[,8:9]
  
  plot_flights(cancelledtrips.AA,
               # crop = "48States", 
               land_color = "#fdae6b", 
               water_color = "#9ecae1", 
               dom_color = "white", 
               int_color = "black", 
               alpha = 1,
               times_as_thickness = FALSE)
  
  #OO
  cancelledtrips.OO <- filter(cancelledtrips, AIRLINE == "OO")
  
  cancelledtrips.OO <- cancelledtrips.OO[,8:9]
  
  plot_flights(cancelledtrips.OO,
               # crop = "48States", 
               land_color = "#fdae6b", 
               water_color = "#9ecae1", 
               dom_color = "white", 
               int_color = "black", 
               alpha = 1,
               times_as_thickness = FALSE)
  
  ## Objective 2: Monthly Flights cancelled by month
  
  df <- cancelledtrips %>%
    group_by(MONTH) %>%
    summarise(Freq = sum(CANCELLED))
  #   Group Cancelled trips by Months, summarized by cancelled flights
  df.ts <- ts(df, frequency = 12, start = 2015)
  df.ts <- df.ts[,-1]
  plot(df.ts)
  
  months <- c('January', 'February', 'March', 'April', 'May', 'June', 'July',
              'August',"September", "October",'November',"December")
  #   XLabels for plot
  
  xform <- list(categoryorder = "array",
                categoryarray = months)
  #https://stackoverflow.com/questions/40701491/plot-ly-in-r-unwanted-alphabetical-sorting-of-x-axis
  #   Unarranges plot by Alphabetical Order
  
  
  fig <- plot_ly(
    x = months,
    y = df.ts,
    name = "Cancelled flights by month, 2015",
    type = "bar",
    marker = list(
      size = seq(min(df.ts),max(df.ts)),
      color = seq(min(df.ts),max(df.ts)),
      colorbar = list(
        title = 'Colorbar'
      ),
      colorscale = 'Viridis',
      reversescale = T
    )) %>%
    layout(title = list(text = "Cancelled Flights by Month, 2015",
                        y = 0.97),
           xaxis = xform)
  
  
  fig <- plot_ly(
    x = months,
    y = df.ts,
    name = "Cancelled flights by month, 2015",
    type = "bar"
  ) %>%
    layout(title = list(text = "Cancelled Flights by Month, 2015",
                        y = 0.97),
           xaxis = xform)
  
  #   https://plotly.com/r/figure-labels/
  
  fig
  #Objective : Top Cancelled flights by City (Origin)
  City <- cancelledtrips %>%
    group_by(ORIGIN_AIRPORT) %>%
    summarise(Freq = sum(CANCELLED))
  
  
  City <- filter(City, Freq > 1000)
  #   Due to abundance, filter to see TOP ones.
  View(City)
  
  City <- City %>% arrange(desc(Freq))
  # For color-code to function properly
  
  fig <- plot_ly( hovertemplate = paste('%{x}', '<br>lifeExp: %{text:.2s}<br>'),
                  texttemplate = '%{y:.2s}', textposition = 'outside') %>% 
    add_trace(type = "bar",
              x = ~City$ORIGIN_AIRPORT,
              y = ~City$Freq,
              mode = "markers",
              marker = list(size = 10,
                            color = colorRampPalette(brewer.pal(10,"Spectral"))(20))) %>%
    layout(title = list(text = "Cancelled Flights, by Airport", 
                        y = 0.97), #lower title
           xaxis = list(categoryorder = "total descending",
                        # Creates Plot by descending order
                        title = "Airport"),
           yaxis = list(title = "Frequency"))
  fig
  
  
  
  #Correlation Matrix
  # https://towardsdatascience.com/beautiful-correlation-plots-in-r-a-new-approach-d3b93d9c77be
  df <- subset(flights, select = c("DAY_OF_WEEK", "MONTH", "ELAPSED_TIME",
                                   "AIR_TIME", "DISTANCE","WHEELS_ON",
                                   "TAXI_IN","SCHEDULED_ARRIVAL",
                                   "ARRIVAL_TIME", "ARRIVAL_DELAY", "DIVERTED",
                                   "CANCELLED"))
  
  df[is.na(df)] = 0
  View(df)
  
  corrdata <- cor(df)
  View(corrdata)
  plot(corrdata)
  
  #Before Transformation: removes unnecessary data and correlation
  corrdata[upper.tri(corrdata, diag = TRUE)] <- NA
  corrdata <- corrdata[-1, -ncol(corrdata)]
  
  #Store variable names for later use...
  x_labels <- colnames(corrdata)
  y_labels <- rownames(corrdata)
  
  #Change variable names to numeric for grid
  colnames(corrdata) <- 1:ncol(corrdata)
  rownames(corrdata) <- nrow(corrdata):1
  
  #Melt the data into the desired format
  plotdata <- melt(corrdata)
  
  fig <- plot_ly(data = plotdata, width = 500, height = 500)
  fig <- fig %>% add_trace(x = ~Var2, y = ~Var1, type = "scatter",   
                           mode = "markers", color = ~value, symbol = I("square"))
  fig
  
  #Adding the size variable & scaling it
  plotdata$size <-(abs(plotdata$value))
  scaling <- 500 / ncol(corrdata) / 2
  plotdata$size <- plotdata$size * scaling
  
  fig <- plot_ly(data = plotdata, width = 500, height = 500)
  fig <- fig %>% add_trace(x = ~Var2, y = ~Var1, type = "scatter", 
                           mode = "markers", color = ~value, 
                           marker = list(size = ~size, opacity = 1), symbol = I("square"))
  
  fig
  
  xAx1 <- list(showgrid = FALSE,
               showline = FALSE,
               zeroline = FALSE,
               tickvals = colnames(corrdata),
               ticktext = x_labels,
               title = FALSE)
  yAx1 <- list(autoaxis = FALSE,
               showgrid = FALSE,
               showline = FALSE,
               zeroline = FALSE,
               tickvals = rownames(corrdata),
               ticktext = y_labels,
               title = FALSE)
  fig <- plot_ly(data = plotdata, width = 500, height = 500)
  fig <- fig %>% add_trace(x = ~Var2, y = ~Var1, type = "scatter", mode = "markers", 
                           color = ~value, marker = list(size = ~size, opacity = 1), symbol = I("square"))
  fig <- fig %>% layout(xaxis = xAx1, yaxis = yAx1)
  fig <- fig %>% colorbar(title = "", limits = c(-1,1), x = 1.1, y = 0.75)
  
  fig
  
  
  
  
  
  
  #Objective: look at cancellation reasons
  flights <- fread("flights.csv", header = TRUE)
  df <- subset(flights, select = c("CANCELLATION_REASON", "MONTH"))
  View(df)
  
  #Arrange cancellation reasons by month
  #https://stackoverflow.com/questions/36700028/count-number-of-occurrences-of-categorical-variables-in-data-frame-r
  setDT(df)
  df <- dcast(setDT(df), MONTH~CANCELLATION_REASON, length)
  
  #remove empty (N/A) Values
  df <- subset(df, select = -V1)
  View(df)
  
  fig <- plot_ly(data = df,
                 x = df$MONTH,
                 y = df$A,
                 name = "Airline/Carrier",
                 type = "bar") %>%
    layout(title = list(text = "Cancellation Reasons (By Months)", y = 0.97))
  #add each category, rename by its code
  fig <- fig %>% add_trace(y = df$B, name = "Weather")
  fig <- fig %>% add_trace(y = df$C, name = "National Air System")
  fig <- fig %>% add_trace(y = df$D, name = "Security")
  fig
  
  #Add labels:
  ##https://plotly.com/r/tick-formatting/
  fig <- fig %>% layout(
    xaxis = list(
      categoryorder = "total descending",
      ticktext = list("January","February","March","April","May","June","July",
                      "August","September","October","November","December"),
      tickvals = list(1,2,3,4,5,6,7,8,9,10,11,12),
      tickmode = "array"
    )
  )
  # add y axis label
  fig <- fig %>% layout(
    yaxis = list(
      title = "# of Flights"
    )
  )
  
  fig
  
  #Arrange cancellation reasons by day of week...
  flights <- fread("flights.csv", header = TRUE)
  df <- subset(flights, select = c("CANCELLATION_REASON", "DAY_OF_WEEK"))
  View(df)
  
  #Group Cancellations
  setDT(df)
  df <- dcast(setDT(df), DAY_OF_WEEK~CANCELLATION_REASON, length)
  
  #remove empty (N/A) Values
  df <- subset(df, select = -V1)
  View(df)
  
  fig <- plot_ly(data = df,
                 x = df$DAY_OF_WEEK,
                 y = df$A,
                 name = "Airline/Carrier",
                 type = "bar") %>%
    layout(title = list(text = "Cancellation Reasons (By Day of Week)", y = 0.97))
  #add each category, rename by its code
  fig <- fig %>% add_trace(y = df$B, name = "Weather")
  fig <- fig %>% add_trace(y = df$C, name = "National Air System")
  fig <- fig %>% add_trace(y = df$D, name = "Security")
  fig
  
  #Add labels:
  ##https://plotly.com/r/tick-formatting/
  fig <- fig %>% layout(
    xaxis = list(
      categoryorder = "total descending",
      ticktext = list("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday",
                      "Saturday"),
      tickvals = list(1,2,3,4,5,6,7),
      tickmode = "array"
    )
  )
  # add y axis label
  fig <- fig %>% layout(
    yaxis = list(
      title = "# of Flights"
    )
  )
  
  fig
  
  #### References Used ####
  #   https://stackoverflow.com/questions/40224892/r-plotly-barplot-sort-by-value
  #       How to filter graphs in descending order 
  #   https://plotly.com/r/bar-charts/
  #       Reference Guide for Bar Charts
  #   https://www.statology.org/sum-by-group-in-r/#:~:text=Method%201%3A%20Use%20base%20R.%20aggregate%20%28df%24col_to_aggregate%2C%20list,library%28dplyr%29%20df%20%25%3E%25%20group_by%28col_to_group_by%29%20%25%3E%25%20summarise%28Freq%20%3D%20sum%28col_to_aggregate%29%29
  #       How to group categories by Sum
  #   https://github.com/xmc811/flightplot
  #       Flightplot Introduction
  #   https://cran.r-project.org/web/packages/flightplot/flightplot.pdf
  #       Flightplot pdf Guide



























runsize <- 10000

# ONESHOT ENCODING NOT VIABLE AT THIS SIZE, theoretically would need 60+ gigs of ram, reduce training and test sets to 100,000

data <- fread('flights.csv')

cancelled <- data[data$CANCELLED == 1,]

noncancelled <- data[data$CANCELLED == 0,]

cancelled_training <- cancelled[sample(nrow(cancelled), runsize/4),]

cancelled_test <- cancelled[sample(nrow(cancelled), runsize/4),]

noncancelled_training <- noncancelled[sample(nrow(noncancelled), (runsize/4)*3),]

noncancelled_test <- noncancelled[sample(nrow(noncancelled), (runsize/4)*3),]

flight_training <- rbind(noncancelled_training, cancelled_training)

flight_test <- rbind(noncancelled_test, cancelled_test)

one_hot_training <- data.frame(as.factor(flight_training$AIRLINE), as.factor(flight_training$ORIGIN_AIRPORT), as.factor(flight_training$DESTINATION_AIRPORT))
colnames(one_hot_training) <- c('Airline', 'Origin_Airport', 'Destination_Airport')

one_hot_training <- one_hot(as.data.table(one_hot_training))
one_hot_training$MONTH <- flight_training$MONTH
one_hot_training$DAY_OF_WEEK <- flight_training$DAY_OF_WEEK
one_hot_training$DEPARTURE_TIME <- flight_training$SCHEDULED_DEPARTURE
one_hot_training$CANCELLED <- flight_training$CANCELLED
one_hot_training <- as.data.frame(one_hot_training)

one_hot_test <- data.frame(as.factor(flight_test$AIRLINE), as.factor(flight_test$ORIGIN_AIRPORT), as.factor(flight_test$DESTINATION_AIRPORT))
colnames(one_hot_test) <- c('Airline', 'Origin_Airport', 'Destination_Airport')

one_hot_test <- one_hot(as.data.table(one_hot_test))
one_hot_test$MONTH <- flight_test$MONTH
one_hot_test$DAY_OF_WEEK <- flight_test$DAY_OF_WEEK
one_hot_test$DEPARTURE_TIME <- flight_test$SCHEDULED_DEPARTURE
one_hot_test$CANCELLED <- flight_test$CANCELLED
one_hot_test <- as.data.frame(one_hot_test)

cols_to_keep <- intersect(colnames(one_hot_training),colnames(one_hot_test)) #https://stackoverflow.com/questions/36886972/remove-columns-from-two-data-frames-if-not-contained-in-one-another-in-r

one_hot_training <- one_hot_training[,cols_to_keep, drop=FALSE]

one_hot_training <- one_hot_training[complete.cases(one_hot_training),]

one_hot_test <- one_hot_test[,cols_to_keep, drop=FALSE]

one_hot_test <- one_hot_test[complete.cases(one_hot_test),]

knn_accent_training_out <- one_hot_training$CANCELLED

knn_test_response <- one_hot_test$CANCELLED

other_training <- one_hot_training

other_test <- one_hot_test

one_hot_test <- one_hot_test[,(1:(ncol(one_hot_test) - 1))]

one_hot_training <- one_hot_training[,(1:(ncol(one_hot_training) - 1))]

flight_lda <- lda(CANCELLED ~ ., data = other_training)
lda_pred <- predict(flight_lda, other_test)
lda_avg <- mean(lda_pred$class==other_test$CANCELLED)

knn_data_2 <- knn(one_hot_training, one_hot_test, knn_accent_training_out, k = 2)
knn_data_9 <- knn(one_hot_training, one_hot_test, knn_accent_training_out, k = 9)
knn_2_avg <- mean(knn_data_2==knn_test_response)
knn_9_avg <- mean(knn_data_9==knn_test_response)

table(lda_pred$class, other_test$CANCELLED)
table(knn_data_9, knn_test_response)
table(knn_data_2, knn_test_response)

flight_reg <- glm(CANCELLED ~ MONTH + DAY_OF_WEEK + DEPARTURE_TIME, data = other_training, family = binomial) #https://www.datacamp.com/community/tutorials/logistic-regression-R
summary(flight_reg)