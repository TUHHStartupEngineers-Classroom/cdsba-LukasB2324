# Load data
setwd("D:/CausalDataScience/cdsba-LukasB2324/content/01_journal")
random_vars<-readRDS("Data/random_vars.rds")

# View data
View(random_vars)

# Assignment 1
age_data<-random_vars[,1,drop=TRUE]
income_data<-random_vars[,2,drop=TRUE]

age_expect<-mean(age_data)
income_expect<-mean(income_data)

age_standardDev<-sd(age_data)
income_standardDev<-sd(income_data)

age_variance<-age_standardDev^2
income_variance<-income_standardDev^2

# Assignment 2
Answer2<-c("It does not make sense to compare the standard deviations of the two variables age and income, because their units do not match. The standard deviation has the unit of the corresponding data. So the unit of age_standardDev is years and the unit of income_standardDev is a currency like Euro or Pound.")
Answer2

# Assignment 3
covariance<-cov(age_data,income_data)
correlation<-cor(age_data,income_data)

# Assignment 4
Answer4<-c("The correlation is easier to interpret, because it is dimensionless and bound between -1 and 1. The correlation of about 0.55 indicates that the variables of age and income have a certain linear relationship, but it is rather moderate than very strong.")
Answer4

# Assignment 5
age_dataFrame<-data.frame(age_data)
income_dataFrame<-data.frame(income_data)

income_upto18<-filter(income_dataFrame,age_dataFrame<=18)
expected_income_upto18<-mean(income_upto18[,,drop=TRUE])

income_from18under65<-filter(income_dataFrame,(age_dataFrame>=18)&(age_dataFrame<65))
expect_income_from18under65<-mean(income_from18under65[,,drop=TRUE])

income_from65up<-filter(income_dataFrame,age_dataFrame>=65)
expected_income_from65up<-mean(income_from65up[,,drop=TRUE])

