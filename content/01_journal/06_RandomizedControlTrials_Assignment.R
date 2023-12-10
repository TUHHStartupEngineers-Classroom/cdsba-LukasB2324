# Load packages
library(tidyverse)
library(dagitty)
library(ggdag)

# Load data
setwd("D:/CausalDataScience/cdsba-LukasB2324/content/01_journal")
abtest_data<-readRDS("Data/abtest_online.rds")



# Assignment 1
abtest_data_mod<-abtest_data
abtest_data_mod["mobile_device"]<-abtest_data_mod["mobile_device"]*1 # convert logical values to numeric vauels 0 and 1
abtest_data_mod["chatbot"]<-abtest_data_mod["chatbot"]*1
abtest_data_mod<-abtest_data_mod[,2:6]# exclude ip adress

compare_previousVisit <- 
  ggplot(abtest_data, 
         aes(x = chatbot, 
             y = previous_visit, 
             color = as.factor(chatbot))) +
  stat_summary(geom = "errorbar", 
               width = .5,
               fun.data = "mean_se", 
               fun.args = list(mult=1.96),
               show.legend = F) +
  labs(x = "chatbot", y = "previous_visit", title = "Number of previous visits")

compare_mobileDevice <- 
  ggplot(abtest_data_mod, 
         aes(x = chatbot, 
             y = mobile_device, 
             color = as.factor(chatbot))) +
  stat_summary(geom = "errorbar", 
               width = .5,
               fun.data = "mean_se", 
               fun.args = list(mult=1.96),
               show.legend = F) +
  labs(x = "chatbot", y = "mobile_device", title = "Number of users of a mobile device")

compare_purchase <- 
  ggplot(abtest_data, 
         aes(x = chatbot, 
             y = purchase, 
             color = as.factor(chatbot))) +
  stat_summary(geom = "errorbar", 
               width = .5,
               fun.data = "mean_se", 
               fun.args = list(mult=1.96),
               show.legend = F) +
  labs(x = "chatbot", y = "purchase", title = "Number of customers who purchase")

compare_purchase_amount <- 
  ggplot(abtest_data, 
         aes(x = chatbot, 
             y = purchase_amount, 
             color = as.factor(chatbot))) +
  stat_summary(geom = "errorbar", 
               width = .5,
               fun.data = "mean_se", 
               fun.args = list(mult=1.96),
               show.legend = F) +
  labs(x = "chatbot", y = "purchase_amount", title = "Purchase amount")

compare_previousVisit
compare_mobileDevice
compare_purchase
compare_purchase_amount

Answer1<-c("The number of users of a mobile device is balanced between the two groups chatbot==TRUE and chatbot==FALSE. In terms of pervious_visits there is an overlap of the 95%-confidence intervals of the two groups, but they still show a noticable difference. The outcome purchase and purchase_amount show no overlap of the 95%-confidence intervals of the two groups.")
Answer1



# Assignment 2
lm_2<-lm(purchase_amount~previous_visit+mobile_device+chatbot,abtest_data_mod)
summary(lm_2)
Answer2<-c("The chatbot interacting with the customer correlates negatively with the purchase_amount. The effect is highly significant.")



# Assignment 3
## Include interaction for subgroup mobile users
lm_3 <- lm(purchase_amount ~ chatbot * mobile_device, abtest_data_mod)
summary(lm_3)
Answer3<-c("The calculated CATE for the subgroup mobile_device is -0.1526, but it is statistically not significant.")
Answer3



# Assignment 4
lm_4<-glm(purchase~chatbot, family=binomial(link='logit'), data=abtest_data_mod)
summary(lm_4)
log_coefficient_chatbot<-lm_4[["coefficients"]][["chatbot"]]
odds_ratio_chatbot<-exp(log_coefficient_chatbot)
Answer4<-c("The chatbot reduces the chance of a website visitor actually purchasing by ",round((1-odds_ratio_chatbot)*100,1),"%.")
Answer4<-paste(Answer4,collapse="")
Answer4

