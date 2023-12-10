# Load tidyerse package
library(tidyverse)

# Load data
setwd("D:/CausalDataScience/cdsba-LukasB2324/content/01_journal")
car_prices<-readRDS("Data/car_prices.rds")

# View data
View(car_prices)



# Assignment 1
dim_car_prices<-dim(car_prices)
Answer1<-paste(c("The data has ",dim_car_prices[1]," rows and ",dim_car_prices[2]," columns."), collapse="")
Answer1



# Assignment 2
data_glimpse<-glimpse(car_prices)
data_glimpse
data_summary<-summary(car_prices)
data_summary
Answer2<-c("Referring to the provided data, numbers have the data type double and strings the data type character. For columns that contain strings, the function summary() only gives their length, class and mode. For columns that contain numbers the function summary() gives a statistical overview including the minimum value, the maximum value, the mean value, the median and quartiles.")
Answer2



# Assignment 3
## Fit model and print summary
lm_mod <- lm(price~., car_prices)
summary(lm_mod)



# Assignment 4
Answer4<-c("The enginesize is chosen for a closer look. It is of the type double and can take on values between 61 and 326. It has a positive impact on the price. Changing the value of the enginesize by one results in an increase in price of 125.93 with a standard deviation of 26.54. The result is highly significant with a significance level of 0.001 (***).")
Answer4



# Assignment 5
car_prices_expanded<-car_prices %>% mutate(seat_heating=TRUE)
lm_mod_2<-lm(price~., car_prices_expanded)
summary(lm_mod_2)

car_prices_expanded[2,23]<-FALSE # test, if seat_heating having the same value in every row causes the coefficients of the regression to be 'NA'
lm_mod_3<-lm(price~., car_prices_expanded)
summary(lm_mod_3)

Answer5<-c("For the parameter seat_heating the coefficients of the linear regression are NA. This is caused by seat_heating having the same value in every row. Therefore, it is not possible to determine the influence of the parameter seat_heating on the price. If seat_heating=FALSE is set for one of the rows, the regression renders numerical results for the coefficents instead of NA. ")
Answer5

