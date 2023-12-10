# Assignment 3

P_B_after_A<-0.97
P_B_after_notA<-0.01
P_A<-0.04

P_notA<-1-P_A

P_notA_after_B<-(P_B_after_notA*P_notA/(P_B_after_notA*P_notA+P_B_after_A*P_A))
P_notA_after_B

P_A_after_B<-(P_B_after_A*P_A/(P_B_after_A*P_A+P_B_after_notA*P_notA))
P_A_after_B

Answer_vect<-c("These results show that in case the alarm is triggered, there is a possibility of about ", round(P_notA_after_B*100,digits=1), "% that the product is flawless and a probability of ", round(P_A_after_B*100,digits=1), "% that the product is faulty.")
Answer<-paste(Answer_vect,collapse="")
Answer

