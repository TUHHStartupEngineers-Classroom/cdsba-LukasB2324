# Assignment 2

P_S_notT_notC<-0.423
P_T_notS_notC<-0.278
P_C_notT_notS<-0.1

P_SandT_notSandTandC<-0.073
P_TandC_notSandTandC<-0.033
P_SandC_notSandTandC<-0.088

P_SandTandC<-0.005
  
## Percentage of customers using ALL three devices
P_allDevices<-P_SandTandC
P_allDevices

## Percentage of customers using AT LEAST two devices
P_atLeastTwoDevices<-P_SandT_notSandTandC+P_TandC_notSandTandC+P_SandC_notSandTandC+P_SandTandC
P_atLeastTwoDevices

## Percentage of customers using ONLY one device
P_onlyOneDevice<-P_S_notT_notC+P_T_notS_notC+P_C_notT_notS
P_onlyOneDevice

## Check total probability (has to be 1)
P_total<-P_atLeastTwoDevices+P_onlyOneDevice
P_total

