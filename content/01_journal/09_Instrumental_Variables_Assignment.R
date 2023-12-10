# Load packages
library(tidyverse)
library(dagitty)
library(ggdag)
library(MatchIt)
library(estimatr)

# Load data
setwd("D:/CausalDataScience/cdsba-LukasB2324/content/01_journal")
rand_enc_data<-readRDS("Data/rand_enc.rds")



# Assignment 1
rand_enc_DAG <- dagify(
  Y ~ D,
  Y ~ U,
  D ~ U,
  D ~ Z,
  exposure = "D",
  latent = "U",
  outcome = "Y",
  coords = list(x = c(U = 1, D = 0, Y = 2, Z = -1),
                y = c(U = 1, D = 0, Y = 0, Z = 0)),
  labels = c("D" = "Used new feature", 
             "Y" = "Time spent", 
             "U" = "Unknown confounders",
             "Z" = "Popup")
)
ggdag(rand_enc_DAG, text = T) +
  guides(color = "none") + 
  #geom_dag_point(color = ggthemr::swatch()[2]) +
  geom_dag_text(color = "white") +
  geom_dag_edges(edge_color = "black") +
  geom_dag_label_repel(aes(label = label)) +
  theme_dag_blank()



# Assignment 2
lm_2<-lm(time_spent~used_ftr,rand_enc_data)
summary(lm_2)
sprintf("The naive estimate of the effect of the new feature is about %.2f.",lm_2[["coefficients"]][["used_ftr"]])



# Assignment 3
cor_matrix <- cor(rand_enc_data) %>% round(2)
cor_matrix

plot_instrument_treat <- ggplot(rand_enc_data[,c(1,2)], aes(x = rand_enc, y = used_ftr)) +
  geom_point(alpha = .8) +
  stat_smooth(method = "lm", se = F)
plot_treat_outcome <- ggplot(rand_enc_data[,c(2,3)], aes(x = used_ftr, y = time_spent)) +
  geom_point(alpha = .8) +
  stat_smooth(method = "lm", se = F)
plot_instrument_outcome <- ggplot(rand_enc_data[,c(1,3)], aes(x = rand_enc, y = time_spent)) +
  geom_point(alpha = .8) +
  stat_smooth(method = "lm", se = F)
plot_instrument_treat
plot_treat_outcome
plot_instrument_outcome

sprintf("The plots show that the effect of the instrument on the treatment and on the outcome goes in the same direction (prerequisite 5 fullfilled). There is a correlation between the instrument 'rand_enc' and the treatment 'used_ftr', so the 4th prerequisite is fullfilled, altough the correlation is rather low (about %.2f). There is also a small correlation between the instrument 'rand_enc' and the outcome 'time_spent' of about %.2f. The correlation between the instrument and the treatment is only a little higher (%.2f) than the correlation between the treatment and the outcome, so the combination of treatment and instrument is not very suiting and the instrumental variable estimation is not a very adequate procedure in the given case.", cor_matrix[1,2],cor_matrix[1,3],  cor_matrix[1,2]-cor_matrix[1,3])



# Assignement 4
iv_estimate<-iv_robust(time_spent~used_ftr|rand_enc, rand_enc_data)
summary(iv_estimate)

sprintf("The naive estimate (%.2f) has an upward bias compared to the instrumental variable estimate (%.2f). Though the validity of the instrumental variable estimate can also be questioned (see Assginment 3).", lm_2[["coefficients"]][["used_ftr"]], iv_estimate[["coefficients"]][["used_ftr"]])

