library(tidyverse)

data_birthrates<-data.frame(births=c(160,158,155,150,140,130,127,113,103,102,96)*1000,stork_pairs=c(67,68,47,52,42,34,32,26,22,19,15),year=c(1966,1965,1967,1968,1969,1970,1971,1972,1973,1974,1975))

ggplot(data=data_birthrates,mapping = aes(x=data_birthrates[,1],y=data_birthrates[,2],label=data_birthrates[,3])) +
  geom_smooth(method='lm', formula= y ~ x, se = F) +
  geom_point(size=3) +
  geom_text(hjust=1.2,vjust=0) +
  scale_color_brewer(type = "qual", palette = "Dark2") +
  scale_x_reverse() +
  labs(x = "Number of live births in Baden-Württemberg", y = "Number of stork pairs in Baden-Württemberg",
      title = "Correlation between the decrease in stork pairs and the decrease in births in Baden-Württemberg") #labs(x = "Zahl der Lebendgeborenen in Baden-Württemberg", y = "Zahl der Storchenpaare in Baden-Württemberg", title = "Korrelation zwischen dem Rückgang der Storchenpopulation und der Abnahme der Geburtenzahl in Baden-Württemberg") 



  