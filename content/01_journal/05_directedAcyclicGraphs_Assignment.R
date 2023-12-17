# Load packages
library(tidyverse)
library(dagitty)
library(ggdag)

setwd("D:/CausalDataScience/cdsba-LukasB2324/content/01_journal")




# Assignment 1
## Confounder
confounding <- dagify(
  X ~ Z,
  Y ~ Z,
  Y ~ X,
  coords = list(x = c(Y = 3, Z = 2, X = 1),
                y = c(Y = 0, Z = 1, X = 0)),
  labels = list(X = "parking spots",
                Y = "sales",
                Z = "location")
)

## Plot DAG
ggdag(confounding) +
  geom_dag_point() +
  geom_dag_text() +
  geom_dag_edges() +
  geom_dag_label_repel(aes(label = label)) +
  theme_dag_blank()



# Assignment 2
customer_sat<-readRDS("Data/customer_sat.rds")
### NOT conditioning on subscription
lm_2_1<-lm(satisfaction~., customer_sat[,1:2])
summary(lm_2_1)
### Conditioning on subscription
lm_2_2<-lm(satisfaction~., customer_sat_mod)
summary(lm_2_2)



# Assignment 3
Answer3<-c("For the regression without conditioning on the subscription, there is a negative correlation of about 3.3 between the follow_ups and the satisfaction, so the follow_ups seem to annoy the customers. When conditioning the regression on the subscription, a positive correlation of about 2.2 between the satisfaction and the follow_ups can be observed. This indicates, that the satisfaction correlates negatively with the level of subscription. Therefore, the customers seem to value the follow_ups but not the benefits of a higher subscription level.")
Answer3


# Assignment 4
## NOT conditioning on subscription
simps_not_cond <- ggplot(customer_sat[,1:2], aes(x = follow_ups, y = satisfaction)) +
  geom_point(alpha = .8) +
  stat_smooth(method = "lm", se = F)

## Conditioning on subscription  
simps_cond <- ggplot(customer_sat, aes(x = follow_ups, y = satisfaction, color = subscription)) +
  geom_point(alpha = .8) +
  stat_smooth(method = "lm", se = F) +
  theme(legend.position = "right")

# Plot both plots
simps_not_cond
simps_cond

