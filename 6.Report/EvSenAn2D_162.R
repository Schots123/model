library(gamstransfer)
library(tidyverse)
setwd("E:\\Studium\\Master of Science Agricultural and Food Economics\\04. Master Thesis\\8. GitHub\\Fruchtfolge Model\\model\\6.Report\\gdxFiles")
getwd()
#showing parameter names stored in container
m162senAn$listSymbols()
#quick overview over parameters 
m162senAn$describeParameters()
#showing overview about specific parameter
view(senAn_farm162)
glimpse(senAn_farm162)
view(senAn_farm162)
senAn_farm162[["value"]]
#lists names of variables in dataframe
names(senAn_farm162)

m162senAn = Container$new("ResultsSenAn_162.141.gdx")
#assign records of specific parameter in containter to dataframe
senAn_farm162 <- m162senAn["summarySenAn"]$records
senAn_farm162$value <- replace(senAn_farm162$value, senAn_farm162$value > 0.99 & senAn_farm162$value < 1.01, 1)
senAn_farm162$value <- replace(senAn_farm162$value, senAn_farm162$value > -0.01 & senAn_farm162$value < 0.01, 0)

##################
#DATA MANIPULATION
##################
#creating subsets of main dataframe for later recombination
senAn_162_landAv <- subset(senAn_farm162, allItems_1 == "landAv")
senAn_162_landUsed <- subset(senAn_farm162, allItems_1 == "landUsedAvg")
senAn_162_WW <- subset(senAn_farm162, allItems_1 == "Winterweizen")
senAn_162_WG <- subset(senAn_farm162, allItems_1 == "Wintergerste")
senAn_162_SB <- subset(senAn_farm162, allItems_1 == "Zuckerrueben")
senAn_162_BA45kW <- subset(senAn_farm162, allItems_1 == "BA_45kW")
senAn_162_BA67kW <- subset(senAn_farm162, allItems_1 == "BA_67kW")
senAn_162_BA83kW <- subset(senAn_farm162, allItems_1 == "BA_83kW")
senAn_162_BA_102kW <- subset(senAn_farm162, allItems_1 == "BA_102kW")
senAn_162_BA_120kW <- subset(senAn_farm162, allItems_1 == "BA_120kW")
senAn_162_BA_200kW <- subset(senAn_farm162, allItems_1 == "BA_200kW")
senAn_162_BA_230kW <- subset(senAn_farm162, allItems_1 == "BA_230kW")
senAn_162_spot6m <- subset(senAn_farm162, allItems_1 == "spot6m")
senAn_162_spot27m <- subset(senAn_farm162, allItems_1 == "spot27m")
senAn_162_avgAnProf <- subset(senAn_farm162, allItems_1 == "avgAnnFarmProf")
senAn_162_diCostsPesti <- subset(senAn_farm162, allItems_1 == "diCostsPesti")
senAn_162_fuelCostsSprayer <- subset(senAn_farm162, allItems_1 == "fuelCostsSprayer")
senAn_162_repCostsSprayer <- subset(senAn_farm162, allItems_1 == "repCostsSprayer")
senAn_162_labCostsSprayer <- subset(senAn_farm162, allItems_1 == "labCostsSprayer")
senAn_162_deprecSprayer <- subset(senAn_farm162, allItems_1 == "deprecSprayer")
senAn_162_varCostsSprayer <- subset(senAn_farm162, allItems_1 == "varCostsSprayer")
senAn_162_fixCostsSprayer <- subset(senAn_farm162, allItems_1 == "fixCostsSprayer")

#smaller subsets for assignment of values to each sensitivity analysis
senAn_162_PestEff <- subset(senAn_farm162, allItems_1 == "%pestiSav")
senAn_162_time <- subset(senAn_farm162, allItems_1 == "%timeReq")
senAn_162_fuel <- subset(senAn_farm162, allItems_1 == "%fuelCons")
senAn_162_repair <- subset(senAn_farm162, allItems_1 == "%repCosts")
senAn_162_numPassag <- subset(senAn_farm162, allItems_1 == "%numPassages")


#rename header of value
colnames(senAn_162_landAv)[5] <- "landAv"
colnames(senAn_162_landUsed)[5] <- "landUsedAvg"
colnames(senAn_162_WW)[5] <- "Winterweizen"
colnames(senAn_162_WG)[5] <- "Wintergerste"
colnames(senAn_162_SB)[5] <- "Zuckerrueben"
colnames(senAn_162_BA45kW)[5] <- "BA_45kW"
colnames(senAn_162_BA67kW)[5] <- "BA_67kW"
colnames(senAn_162_BA83kW)[5] <- "BA_83kW"
colnames(senAn_162_BA_102kW)[5] <- "BA_102kW"
colnames(senAn_162_BA_120kW)[5] <- "BA_120kW"
colnames(senAn_162_BA_200kW)[5] <- "BA_200kW"
colnames(senAn_162_BA_230kW)[5] <- "BA_230kW"
colnames(senAn_162_spot6m)[5] <- "spot6m"
colnames(senAn_162_spot27m)[5] <- "spot27m"
colnames(senAn_162_avgAnProf)[5] <- "avgAnProf"
colnames(senAn_162_diCostsPesti)[5] <- "diCostsPesti"
colnames(senAn_162_fuelCostsSprayer)[5] <- "fuelCostsSprayer"
colnames(senAn_162_repCostsSprayer)[5] <- "repCostsSprayer"
colnames(senAn_162_labCostsSprayer)[5] <- "labCostsSprayer"
colnames(senAn_162_deprecSprayer)[5] <- "deprecSprayer"
colnames(senAn_162_varCostsSprayer)[5] <- "varCostsSprayer"
colnames(senAn_162_fixCostsSprayer)[5] <- "fixCostsSprayer"

colnames(senAn_162_PestEff)[5] <- "PestEff"
colnames(senAn_162_time)[5] <- "timeReq"
colnames(senAn_162_fuel)[5] <- "fuelCons"
colnames(senAn_162_repair)[5] <- "repCosts"
colnames(senAn_162_numPassag)[5] <- "numPassag"


#delete allItems column
senAn_162_landAv$allItems_1 <- NULL
senAn_162_landUsed$allItems_1 <- NULL
senAn_162_WW$allItems_1 <- NULL
senAn_162_WG$allItems_1 <- NULL
senAn_162_SB$allItems_1 <- NULL
senAn_162_BA45kW$allItems_1 <- NULL
senAn_162_BA67kW$allItems_1 <- NULL
senAn_162_BA83kW$allItems_1 <- NULL
senAn_162_BA_102kW$allItems_1 <- NULL
senAn_162_BA_120kW$allItems_1 <- NULL
senAn_162_BA_200kW$allItems_1 <- NULL
senAn_162_BA_230kW$allItems_1 <- NULL
senAn_162_spot6m$allItems_1 <- NULL
senAn_162_spot27m$allItems_1 <- NULL
senAn_162_avgAnProf$allItems_1 <- NULL
senAn_162_diCostsPesti$allItems_1 <- NULL
senAn_162_fuelCostsSprayer$allItems_1 <- NULL
senAn_162_repCostsSprayer$allItems_1 <- NULL
senAn_162_labCostsSprayer$allItems_1 <- NULL
senAn_162_deprecSprayer$allItems_1 <- NULL
senAn_162_varCostsSprayer$allItems_1 <- NULL
senAn_162_fixCostsSprayer$allItems_1 <- NULL

senAn_162_PestEff$allItems_1 <- NULL
senAn_162_time$allItems_1 <- NULL
senAn_162_fuel$allItems_1 <- NULL
senAn_162_repair$allItems_1 <- NULL
senAn_162_numPassag$allItems_1 <- NULL


#create new combined dataframes for each sensitivity analysis seperately 
senAn_162_PestEff <- senAn_162_PestEff %>%
    left_join(senAn_162_landAv, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_landUsed, by =c("uni_2","uni_3","uni_4")) %>% 
#    left_join(senAn_162_WW, by =c("uni_2","uni_3","uni_4")) %>% 
#    left_join(senAn_162_WG, by =c("uni_2","uni_3","uni_4")) %>% 
#    left_join(senAn_162_SB, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_BA45kW, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_BA67kW, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_BA83kW, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_BA_102kW, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_BA_120kW, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_BA_200kW, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_BA_230kW, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_spot6m, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_spot27m, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_avgAnProf, by =c("uni_2","uni_3","uni_4"))
#    left_join(senAn_162_diCostsPesti, by =c("uni_2","uni_3","uni_4")) %>%
#    left_join(senAn_162_fuelCostsSprayer, by =c("uni_2","uni_3","uni_4")) %>%
#    left_join(senAn_162_repCostsSprayer, by =c("uni_2","uni_3","uni_4")) %>%
#    left_join(senAn_162_labCostsSprayer, by =c("uni_2","uni_3","uni_4")) %>%
#    left_join(senAn_162_deprecSprayer, by =c("uni_2","uni_3","uni_4")) %>%
#    left_join(senAn_162_varCostsSprayer, by =c("uni_2","uni_3","uni_4")) %>%
#    left_join(senAn_162_fixCostsSprayer, by =c("uni_2","uni_3","uni_4"))

senAn_162_time <- senAn_162_time %>%
     left_join(senAn_162_landAv, by =c("uni_2","uni_3","uni_4")) %>% 
     left_join(senAn_162_landUsed, by =c("uni_2","uni_3","uni_4")) %>% 
#    left_join(senAn_162_WW, by =c("uni_2","uni_3","uni_4")) %>% 
#    left_join(senAn_162_WG, by =c("uni_2","uni_3","uni_4")) %>% 
#    left_join(senAn_162_SB, by =c("uni_2","uni_3","uni_4")) %>% 
     left_join(senAn_162_BA45kW, by =c("uni_2","uni_3","uni_4")) %>% 
     left_join(senAn_162_BA67kW, by =c("uni_2","uni_3","uni_4")) %>% 
     left_join(senAn_162_BA83kW, by =c("uni_2","uni_3","uni_4")) %>% 
     left_join(senAn_162_BA_102kW, by =c("uni_2","uni_3","uni_4")) %>% 
     left_join(senAn_162_BA_120kW, by =c("uni_2","uni_3","uni_4")) %>%
     left_join(senAn_162_BA_200kW, by =c("uni_2","uni_3","uni_4")) %>%
     left_join(senAn_162_BA_230kW, by =c("uni_2","uni_3","uni_4")) %>%
     left_join(senAn_162_spot6m, by =c("uni_2","uni_3","uni_4")) %>% 
     left_join(senAn_162_spot27m, by =c("uni_2","uni_3","uni_4")) %>% 
     left_join(senAn_162_avgAnProf, by =c("uni_2","uni_3","uni_4"))
#    left_join(senAn_162_diCostsPesti, by =c("uni_2","uni_3","uni_4")) %>%
#    left_join(senAn_162_fuelCostsSprayer, by =c("uni_2","uni_3","uni_4")) %>%
#    left_join(senAn_162_repCostsSprayer, by =c("uni_2","uni_3","uni_4")) %>%
#    left_join(senAn_162_labCostsSprayer, by =c("uni_2","uni_3","uni_4")) %>%
#    left_join(senAn_162_deprecSprayer, by =c("uni_2","uni_3","uni_4")) %>%
#    left_join(senAn_162_varCostsSprayer, by =c("uni_2","uni_3","uni_4")) %>%
#    left_join(senAn_162_fixCostsSprayer, by =c("uni_2","uni_3","uni_4"))

senAn_162_fuel <- senAn_162_fuel %>%
     left_join(senAn_162_landAv, by =c("uni_2","uni_3","uni_4")) %>% 
     left_join(senAn_162_landUsed, by =c("uni_2","uni_3","uni_4")) %>% 
#    left_join(senAn_162_WW, by =c("uni_2","uni_3","uni_4")) %>% 
#    left_join(senAn_162_WG, by =c("uni_2","uni_3","uni_4")) %>% 
#    left_join(senAn_162_SB, by =c("uni_2","uni_3","uni_4")) %>% 
     left_join(senAn_162_BA45kW, by =c("uni_2","uni_3","uni_4")) %>% 
     left_join(senAn_162_BA67kW, by =c("uni_2","uni_3","uni_4")) %>% 
     left_join(senAn_162_BA83kW, by =c("uni_2","uni_3","uni_4")) %>% 
     left_join(senAn_162_BA_102kW, by =c("uni_2","uni_3","uni_4")) %>% 
     left_join(senAn_162_BA_120kW, by =c("uni_2","uni_3","uni_4")) %>%
     left_join(senAn_162_BA_200kW, by =c("uni_2","uni_3","uni_4")) %>%
     left_join(senAn_162_BA_230kW, by =c("uni_2","uni_3","uni_4")) %>%
     left_join(senAn_162_spot6m, by =c("uni_2","uni_3","uni_4")) %>% 
     left_join(senAn_162_spot27m, by =c("uni_2","uni_3","uni_4")) %>% 
     left_join(senAn_162_avgAnProf, by =c("uni_2","uni_3","uni_4"))
#    left_join(senAn_162_diCostsPesti, by =c("uni_2","uni_3","uni_4")) %>%
#    left_join(senAn_162_fuelCostsSprayer, by =c("uni_2","uni_3","uni_4")) %>%
#    left_join(senAn_162_repCostsSprayer, by =c("uni_2","uni_3","uni_4")) %>%
#    left_join(senAn_162_labCostsSprayer, by =c("uni_2","uni_3","uni_4")) %>%
#    left_join(senAn_162_deprecSprayer, by =c("uni_2","uni_3","uni_4")) %>%
#    left_join(senAn_162_varCostsSprayer, by =c("uni_2","uni_3","uni_4")) %>%
#    left_join(senAn_162_fixCostsSprayer, by =c("uni_2","uni_3","uni_4"))

senAn_162_repair <- senAn_162_repair %>%
     left_join(senAn_162_landAv, by =c("uni_2","uni_3","uni_4")) %>% 
     left_join(senAn_162_landUsed, by =c("uni_2","uni_3","uni_4")) %>% 
#    left_join(senAn_162_WW, by =c("uni_2","uni_3","uni_4")) %>% 
#    left_join(senAn_162_WG, by =c("uni_2","uni_3","uni_4")) %>% 
#    left_join(senAn_162_SB, by =c("uni_2","uni_3","uni_4")) %>% 
     left_join(senAn_162_BA45kW, by =c("uni_2","uni_3","uni_4")) %>% 
     left_join(senAn_162_BA67kW, by =c("uni_2","uni_3","uni_4")) %>% 
     left_join(senAn_162_BA83kW, by =c("uni_2","uni_3","uni_4")) %>% 
     left_join(senAn_162_BA_102kW, by =c("uni_2","uni_3","uni_4")) %>% 
     left_join(senAn_162_BA_120kW, by =c("uni_2","uni_3","uni_4")) %>%
     left_join(senAn_162_BA_200kW, by =c("uni_2","uni_3","uni_4")) %>%
     left_join(senAn_162_BA_230kW, by =c("uni_2","uni_3","uni_4")) %>%
     left_join(senAn_162_spot6m, by =c("uni_2","uni_3","uni_4")) %>% 
     left_join(senAn_162_spot27m, by =c("uni_2","uni_3","uni_4")) %>% 
     left_join(senAn_162_avgAnProf, by =c("uni_2","uni_3","uni_4"))
#    left_join(senAn_162_diCostsPesti, by =c("uni_2","uni_3","uni_4")) %>%
#    left_join(senAn_162_fuelCostsSprayer, by =c("uni_2","uni_3","uni_4")) %>%
#    left_join(senAn_162_repCostsSprayer, by =c("uni_2","uni_3","uni_4")) %>%
#    left_join(senAn_162_labCostsSprayer, by =c("uni_2","uni_3","uni_4")) %>%
#    left_join(senAn_162_deprecSprayer, by =c("uni_2","uni_3","uni_4")) %>%
#    left_join(senAn_162_varCostsSprayer, by =c("uni_2","uni_3","uni_4")) %>%
#    left_join(senAn_162_fixCostsSprayer, by =c("uni_2","uni_3","uni_4"))

senAn_162_numPassag <- senAn_162_numPassag %>%
     left_join(senAn_162_landAv, by =c("uni_2","uni_3","uni_4")) %>% 
     left_join(senAn_162_landUsed, by =c("uni_2","uni_3","uni_4")) %>% 
#    left_join(senAn_162_WW, by =c("uni_2","uni_3","uni_4")) %>% 
#    left_join(senAn_162_WG, by =c("uni_2","uni_3","uni_4")) %>% 
#    left_join(senAn_162_SB, by =c("uni_2","uni_3","uni_4")) %>% 
     left_join(senAn_162_BA45kW, by =c("uni_2","uni_3","uni_4")) %>% 
     left_join(senAn_162_BA67kW, by =c("uni_2","uni_3","uni_4")) %>% 
     left_join(senAn_162_BA83kW, by =c("uni_2","uni_3","uni_4")) %>% 
     left_join(senAn_162_BA_102kW, by =c("uni_2","uni_3","uni_4")) %>% 
     left_join(senAn_162_BA_120kW, by =c("uni_2","uni_3","uni_4")) %>%
     left_join(senAn_162_BA_200kW, by =c("uni_2","uni_3","uni_4")) %>%
     left_join(senAn_162_BA_230kW, by =c("uni_2","uni_3","uni_4")) %>%
     left_join(senAn_162_spot6m, by =c("uni_2","uni_3","uni_4")) %>% 
     left_join(senAn_162_spot27m, by =c("uni_2","uni_3","uni_4")) %>% 
     left_join(senAn_162_avgAnProf, by =c("uni_2","uni_3","uni_4"))
#    left_join(senAn_162_diCostsPesti, by =c("uni_2","uni_3","uni_4")) %>%
#    left_join(senAn_162_fuelCostsSprayer, by =c("uni_2","uni_3","uni_4")) %>%
#    left_join(senAn_162_repCostsSprayer, by =c("uni_2","uni_3","uni_4")) %>%
#    left_join(senAn_162_labCostsSprayer, by =c("uni_2","uni_3","uni_4")) %>%
#    left_join(senAn_162_deprecSprayer, by =c("uni_2","uni_3","uni_4")) %>%
#    left_join(senAn_162_varCostsSprayer, by =c("uni_2","uni_3","uni_4")) %>%
#    left_join(senAn_162_fixCostsSprayer, by =c("uni_2","uni_3","uni_4"))


#removal of subsets (not needed anymore)
rm(senAn_162_landAv)
rm(senAn_162_landUsed)
rm(senAn_162_WW)
rm(senAn_162_WG)
rm(senAn_162_SB)
rm(senAn_162_BA45kW)
rm(senAn_162_BA67kW)
rm(senAn_162_BA83kW)
rm(senAn_162_BA_102kW)
rm(senAn_162_BA_120kW)
rm(senAn_162_BA_200kW)
rm(senAn_162_BA_230kW)
rm(senAn_162_spot6m)
rm(senAn_162_spot27m)
rm(senAn_162_avgAnProf)
rm(senAn_162_diCostsPesti)
rm(senAn_162_fuelCostsSprayer)
rm(senAn_162_repCostsSprayer)
rm(senAn_162_labCostsSprayer)
rm(senAn_162_deprecSprayer)
rm(senAn_162_varCostsSprayer)
rm(senAn_162_fixCostsSprayer)

#####################################
#Column Preperation for Visualization
#####################################
###################Technology Value 

###################Pesticide Efficiency
senAn_162_PestEff$numberSST6m <- senAn_162_PestEff$spot6m
senAn_162_PestEff$numberSST27m <- senAn_162_PestEff$spot27m
senAn_162_PestEff$BA_45kWNum <- senAn_162_PestEff$BA_45kW
senAn_162_PestEff$BA_67kWNum <- senAn_162_PestEff$BA_67kW
senAn_162_PestEff$BA_83kWNum <- senAn_162_PestEff$BA_83kW
senAn_162_PestEff$BA_102kWNum <- senAn_162_PestEff$BA_102kW
senAn_162_PestEff$BA_120kWNum <- senAn_162_PestEff$BA_120kW
senAn_162_PestEff$BA_200kWNum <- senAn_162_PestEff$BA_200kW
senAn_162_PestEff$BA_230kWNum <- senAn_162_PestEff$BA_230kW
senAn_162_PestEff[is.na(senAn_162_PestEff)] <- ""
senAn_162_PestEff <- senAn_162_PestEff %>%
    mutate(BA_45kW = str_replace(BA_45kW,"1", "BA_45kW")) %>%
    mutate(BA_67kW = str_replace(BA_67kW,"1", "BA_67kW")) %>%
    mutate(BA_83kW = str_replace(BA_83kW,"1", "BA_83kW")) %>%
    mutate(BA_102kW = str_replace(BA_102kW,"1", "BA_102kW")) %>%
    mutate(BA_120kW = str_replace(BA_120kW,"1", "BA_120kW")) %>%
    mutate(BA_200kW = str_replace(BA_200kW,"1", "BA_200kW")) %>%
    mutate(BA_230kW = str_replace(BA_230kW,"1", "BA_230kW")) %>%
#rename number values to respective SST used
    mutate(spot6m = str_replace(spot6m,"1", "SST6m")) %>%
    mutate(spot27m = str_replace(spot27m,"1", "SST27m")) %>%
#combine columns of BA Sprayer and SST
    unite(BA_Sprayer, BA_45kW, BA_67kW, BA_83kW, BA_102kW, BA_120kW, BA_200kW, BA_230kW, sep ="") %>%
    unite(BA_Sprayer_Num, BA_45kWNum, BA_67kWNum, BA_83kWNum, BA_102kWNum, BA_120kWNum, BA_200kWNum, BA_230kWNum, sep="") %>%
    unite(numberSST, numberSST6m, numberSST27m, sep ="") %>%
    unite(Technology, spot6m, spot27m, sep ="")
senAn_162_PestEff$Technology[senAn_162_PestEff$Technology==""]<-"BA Sprayer"


###################Time Requirement
senAn_162_time$numberSST6m <- senAn_162_time$spot6m
senAn_162_time$numberSST27m <- senAn_162_time$spot27m
senAn_162_time$BA_45kWNum <- senAn_162_time$BA_45kW
senAn_162_time$BA_67kWNum <- senAn_162_time$BA_67kW
senAn_162_time$BA_83kWNum <- senAn_162_time$BA_83kW
senAn_162_time$BA_102kWNum <- senAn_162_time$BA_102kW
senAn_162_time$BA_120kWNum <- senAn_162_time$BA_120kW
senAn_162_time$BA_200kWNum <- senAn_162_time$BA_200kW
senAn_162_time$BA_230kWNum <- senAn_162_time$BA_230kW
senAn_162_time[is.na(senAn_162_time)] <- ""
senAn_162_time <- senAn_162_time %>%
    mutate(BA_45kW = str_replace(BA_45kW,"1", "BA_45kW")) %>%
    mutate(BA_67kW = str_replace(BA_67kW,"1", "BA_67kW")) %>%
    mutate(BA_83kW = str_replace(BA_83kW,"1", "BA_83kW")) %>%
    mutate(BA_102kW = str_replace(BA_102kW,"1", "BA_102kW")) %>%
    mutate(BA_120kW = str_replace(BA_120kW,"1", "BA_120kW")) %>%
    mutate(BA_200kW = str_replace(BA_200kW,"1", "BA_200kW")) %>%
    mutate(BA_230kW = str_replace(BA_230kW,"1", "BA_230kW")) %>%
#rename number values to respective SST used
    mutate(spot6m = str_replace(spot6m,"1", "SST6m")) %>%
    mutate(spot27m = str_replace(spot27m,"1", "SST27m")) %>%
#combine columns of BA Sprayer and SST
    unite(BA_Sprayer, BA_45kW, BA_67kW, BA_83kW, BA_102kW, BA_120kW, BA_200kW, BA_230kW, sep ="") %>%
    unite(BA_Sprayer_Num, BA_45kWNum, BA_67kWNum, BA_83kWNum, BA_102kWNum, BA_120kWNum, BA_200kWNum, BA_230kWNum, sep="") %>%
    unite(numberSST, numberSST6m, numberSST27m, sep ="") %>%
    unite(Technology, spot6m, spot27m, sep ="")
senAn_162_time$Technology[senAn_162_time$Technology==""]<-"BA Sprayer"



###################Fuel Consumption
senAn_162_fuel$numberSST6m <- senAn_162_fuel$spot6m
senAn_162_fuel$numberSST27m <- senAn_162_fuel$spot27m
senAn_162_fuel$BA_45kWNum <- senAn_162_fuel$BA_45kW
senAn_162_fuel$BA_67kWNum <- senAn_162_fuel$BA_67kW
senAn_162_fuel$BA_83kWNum <- senAn_162_fuel$BA_83kW
senAn_162_fuel$BA_102kWNum <- senAn_162_fuel$BA_102kW
senAn_162_fuel$BA_120kWNum <- senAn_162_fuel$BA_120kW
senAn_162_fuel$BA_200kWNum <- senAn_162_fuel$BA_200kW
senAn_162_fuel$BA_230kWNum <- senAn_162_fuel$BA_230kW
senAn_162_fuel[is.na(senAn_162_fuel)] <- ""
senAn_162_fuel <- senAn_162_fuel %>%
    mutate(BA_45kW = str_replace(BA_45kW,"1", "BA_45kW")) %>%
    mutate(BA_67kW = str_replace(BA_67kW,"1", "BA_67kW")) %>%
    mutate(BA_83kW = str_replace(BA_83kW,"1", "BA_83kW")) %>%
    mutate(BA_102kW = str_replace(BA_102kW,"1", "BA_102kW")) %>%
    mutate(BA_120kW = str_replace(BA_120kW,"1", "BA_120kW")) %>%
    mutate(BA_200kW = str_replace(BA_200kW,"1", "BA_200kW")) %>%
    mutate(BA_230kW = str_replace(BA_230kW,"1", "BA_230kW")) %>%
#rename number values to respective SST used
    mutate(spot6m = str_replace(spot6m,"1", "SST6m")) %>%
    mutate(spot27m = str_replace(spot27m,"1", "SST27m")) %>%
#combine columns of BA Sprayer and SST
    unite(BA_Sprayer, BA_45kW, BA_67kW, BA_83kW, BA_102kW, BA_120kW, BA_200kW, BA_230kW, sep ="") %>%
    unite(BA_Sprayer_Num, BA_45kWNum, BA_67kWNum, BA_83kWNum, BA_102kWNum, BA_120kWNum, BA_200kWNum, BA_230kWNum, sep="") %>%
    unite(numberSST, numberSST6m, numberSST27m, sep ="") %>%
    unite(Technology, spot6m, spot27m, sep ="")
senAn_162_fuel$Technology[senAn_162_fuel$Technology==""]<-"BA Sprayer"


###################Repair Costs
senAn_162_repair$numberSST6m <- senAn_162_repair$spot6m
senAn_162_repair$numberSST27m <- senAn_162_repair$spot27m
senAn_162_repair$BA_45kWNum <- senAn_162_repair$BA_45kW
senAn_162_repair$BA_67kWNum <- senAn_162_repair$BA_67kW
senAn_162_repair$BA_83kWNum <- senAn_162_repair$BA_83kW
senAn_162_repair$BA_102kWNum <- senAn_162_repair$BA_102kW
senAn_162_repair$BA_120kWNum <- senAn_162_repair$BA_120kW
senAn_162_repair$BA_200kWNum <- senAn_162_repair$BA_200kW
senAn_162_repair$BA_230kWNum <- senAn_162_repair$BA_230kW
senAn_162_repair[is.na(senAn_162_repair)] <- ""
senAn_162_repair <- senAn_162_repair %>%
    mutate(BA_45kW = str_replace(BA_45kW,"1", "BA_45kW")) %>%
    mutate(BA_67kW = str_replace(BA_67kW,"1", "BA_67kW")) %>%
    mutate(BA_83kW = str_replace(BA_83kW,"1", "BA_83kW")) %>%
    mutate(BA_102kW = str_replace(BA_102kW,"1", "BA_102kW")) %>%
    mutate(BA_120kW = str_replace(BA_120kW,"1", "BA_120kW")) %>%
    mutate(BA_200kW = str_replace(BA_200kW,"1", "BA_200kW")) %>%
    mutate(BA_230kW = str_replace(BA_230kW,"1", "BA_230kW")) %>%
#rename number values to respective SST used
    mutate(spot6m = str_replace(spot6m,"1", "SST6m")) %>%
    mutate(spot27m = str_replace(spot27m,"1", "SST27m")) %>%
#combine columns of BA Sprayer and SST
    unite(BA_Sprayer, BA_45kW, BA_67kW, BA_83kW, BA_102kW, BA_120kW, BA_200kW, BA_230kW, sep ="") %>%
    unite(BA_Sprayer_Num, BA_45kWNum, BA_67kWNum, BA_83kWNum, BA_102kWNum, BA_120kWNum, BA_200kWNum, BA_230kWNum, sep="") %>%
    unite(numberSST, numberSST6m, numberSST27m, sep ="") %>%
    unite(Technology, spot6m, spot27m, sep ="")
senAn_162_repair$Technology[senAn_162_repair$Technology==""]<-"BA Sprayer"



###################Number SST passages
senAn_162_numPassag$numberSST6m <- senAn_162_numPassag$spot6m
senAn_162_numPassag$numberSST27m <- senAn_162_numPassag$spot27m
senAn_162_numPassag$BA_45kWNum <- senAn_162_numPassag$BA_45kW
senAn_162_numPassag$BA_67kWNum <- senAn_162_numPassag$BA_67kW
senAn_162_numPassag$BA_83kWNum <- senAn_162_numPassag$BA_83kW
senAn_162_numPassag$BA_102kWNum <- senAn_162_numPassag$BA_102kW
senAn_162_numPassag$BA_120kWNum <- senAn_162_numPassag$BA_120kW
senAn_162_numPassag$BA_200kWNum <- senAn_162_numPassag$BA_200kW
senAn_162_numPassag$BA_230kWNum <- senAn_162_numPassag$BA_230kW
senAn_162_numPassag[is.na(senAn_162_numPassag)] <- ""
senAn_162_numPassag <- senAn_162_numPassag %>%
    mutate(BA_45kW = str_replace(BA_45kW,"1", "BA_45kW")) %>%
    mutate(BA_67kW = str_replace(BA_67kW,"1", "BA_67kW")) %>%
    mutate(BA_83kW = str_replace(BA_83kW,"1", "BA_83kW")) %>%
    mutate(BA_102kW = str_replace(BA_102kW,"1", "BA_102kW")) %>%
    mutate(BA_120kW = str_replace(BA_120kW,"1", "BA_120kW")) %>%
    mutate(BA_200kW = str_replace(BA_200kW,"1", "BA_200kW")) %>%
    mutate(BA_230kW = str_replace(BA_230kW,"1", "BA_230kW")) %>%
#rename number values to respective SST used
    mutate(spot6m = str_replace(spot6m,"1", "SST6m")) %>%
    mutate(spot27m = str_replace(spot27m,"1", "SST27m")) %>%
#combine columns of BA Sprayer and SST
    unite(BA_Sprayer, BA_45kW, BA_67kW, BA_83kW, BA_102kW, BA_120kW, BA_200kW, BA_230kW, sep ="") %>%
    unite(BA_Sprayer_Num, BA_45kWNum, BA_67kWNum, BA_83kWNum, BA_102kWNum, BA_120kWNum, BA_200kWNum, BA_230kWNum, sep="") %>%
    unite(numberSST, numberSST6m, numberSST27m, sep ="") %>%
    unite(Technology, spot6m, spot27m, sep ="")
senAn_162_numPassag$Technology[senAn_162_numPassag$Technology==""]<-"BA Sprayer"

####################
#Scenario Seperation
####################
senAn_162_PestEff1 <- subset(senAn_162_PestEff, uni_4 == "Base|FH")
senAn_162_PestEff2 <- subset(senAn_162_PestEff, uni_4 == "Base|FHBonus")
rm(senAn_162_PestEff)

senAn_162_time1 <- subset(senAn_162_time, uni_4 == "Base|FH")
senAn_162_time2 <- subset(senAn_162_time, uni_4 == "Base|FHBonus")
rm(senAn_162_time)

senAn_162_fuel1 <- subset(senAn_162_fuel, uni_4 == "Base|FH")
senAn_162_fuel2 <- subset(senAn_162_fuel, uni_4 == "Base|FHBonus")
rm(senAn_162_fuel)

senAn_162_repair1 <- subset(senAn_162_repair, uni_4 == "Base|FH")
senAn_162_repair2 <- subset(senAn_162_repair, uni_4 == "Base|FHBonus")
rm(senAn_162_repair)

senAn_162_numPassag1 <- subset(senAn_162_numPassag, uni_4 == "Base|FH")
senAn_162_numPassag2 <- subset(senAn_162_numPassag, uni_4 == "Base|FHBonus")
rm(senAn_162_numPassag)

###################
#DATA VISUALIZATION
###################
###################Pesticide Efficiency
PsenAn_162_PestEff1 <- senAn_162_PestEff1 %>%
    ggplot(aes(x = landAv,
               y = PestEff,
               colour = Technology))+
    geom_point(aes(size = numberSST,
                    shape = BA_Sprayer_Num), show.legend = FALSE)+
    labs(x = "Farm size (ha)",
         y = "Pesticide savings SSPAs (%-points)")+
    ggtitle(label = "Sugar beet farm")+
    theme(plot.title = element_text(face = "bold", size = 8, colour ="#CC3300"))+
    scale_colour_manual(name = "Technology",
                        breaks = c("BA Sprayer", "SST6m", "SST27m"),
                        labels = c("No SST", "SST6m", "SST27m"),
                        values = c("#333333", "#006600", "#33FF00"))+
    scale_shape_manual(name = "BA Sprayer",
                        breaks = c("", "1"),
                        labels = c("No", "Yes"),
                        values=c(1,19))+
    scale_size_manual(name = "SST",
                            breaks = c("", "1", "2"),
                            labels = c("None", "1 Sprayer", "2 Sprayer"),
                            values=c(1,1,2))+
    scale_y_continuous(breaks=seq(-20,20,10), limits = c(-20,20), expand = expansion(mult = 0, add = 0))+
    scale_x_continuous(breaks=seq(100,400,100), limits = c(50,400), expand = expansion(mult = 0, add = 0))+
    theme(
        panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(colour = "grey", linetype = "dashed"),
        plot.margin = margin(t =0, r =0, b=0, l=0)
    )+
    theme(
        axis.title.y = element_text(face = "bold", vjust = -0.1, size = 7, color = "black"),
        axis.title.x = element_text(face = "bold", vjust=0.3, size = 7),
        axis.text = element_text(size = 7),
        axis.line = element_line(size = 0.2, colour = "#CC3300", linetype =1),
        axis.ticks = element_line(size = 0.4, colour = "#CC3300"),
        axis.ticks.length = unit(0.15, "cm")
    )
PsenAn_162_PestEff1

PsenAn_162_PestEff2 <- senAn_162_PestEff2 %>%
    ggplot(aes(x = landAv,
               y = PestEff,
               colour = Technology))+
    geom_point(aes(size = numberSST,
                    shape = BA_Sprayer_Num), show.legend = TRUE)+
    labs(x = "Farm size (ha)",
         y = "Pesticide savings SSPAs (%-points)")+
    ggtitle(label = "Sugar beet farm")+
    theme(plot.title = element_text(face = "bold", size = 8, colour ="#CC3300"))+
    scale_colour_manual(name = "Technology\nadoption:\nScenario 2",
                        breaks = c("BA Sprayer", "SST6m", "SST27m"),
                        labels = c("No SST", "SST6m", "SST27m"),
                        values = c("#333333", "#000099", "#0099FF"))+
    scale_shape_manual(name = "BA Sprayer\nused:",
                        breaks = c("", "1"),
                        labels = c("No", "Yes"),
                        values=c(1,19))+
    scale_size_manual(name = "SST",
                            breaks = c("", "1", "2"),
                            labels = c("None", "1 Sprayer", "2 Sprayer"),
                            values=c(1,1,2))+
    scale_y_continuous(breaks=seq(-20,20,10), limits = c(-20,20), expand = expansion(mult = 0, add = 0))+
    scale_x_continuous(breaks=seq(100,400,100), limits = c(50,400), expand = expansion(mult = 0, add = 0))+
    theme(
        panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(colour = "grey", linetype = "dashed"),
        plot.margin = margin(t =0, r =0, b=0, l=0)
    )+
    theme(
        axis.title.y = element_text(face = "bold", vjust = -0.1, size = 7, color = "black"),
        axis.title.x = element_text(face = "bold", vjust=0.3, size = 7),
        axis.text = element_text(size = 7),
        axis.line = element_line(size = 0.2, colour = "#CC3300", linetype =1),
        axis.ticks = element_line(size = 0.4, colour = "#CC3300"),
        axis.ticks.length = unit(0.15, "cm")
    )+
    theme(legend.position="bottom", legend.box = "vertical", legend.direction = "vertical") +
    theme(legend.title = element_text(face = "bold", colour = "#0000FF", size = 8, hjust=.5)) +
    theme((legend.text = element_text(size = 8))) +
    guides(colour = guide_legend(override.aes = list(size=1.5))) +
    guides(size = "none", shape = "none")
PsenAn_162_PestEff2

###################Time Requirements
PsenAn_162_time1 <- senAn_162_time1 %>%
    ggplot(aes(x = landAv,
               y = timeReq,
               colour = Technology))+
    geom_point(aes(size = numberSST,
                    shape = BA_Sprayer_Num), show.legend = FALSE)+
    labs(x = "Farm size (ha)",
         y = "Labor input SSPAs (%)")+
    ggtitle(label = "Sugar beet farm")+
    theme(plot.title = element_text(face = "bold", size = 8, colour ="#CC3300"))+
    scale_colour_manual(name = "Technology\nadoption:\nScenario 1",
                        breaks = c("BA Sprayer", "SST6m", "SST27m"),
                        labels = c("No SST", "SST6m", "SST27m"),
                        values = c("#333333", "#006600", "#33FF00"))+
    scale_shape_manual(name = "BA Sprayer",
                        breaks = c("", "1"),
                        labels = c("No", "Yes"),
                        values=c(1,19))+
    scale_size_manual(name = "SST",
                            breaks = c("", "1", "2"),
                            labels = c("None", "1 Sprayer", "2 Sprayer"),
                            values=c(1,1,2))+
    scale_y_continuous(breaks=seq(50,200,50), limits = c(50,200), expand = expansion(mult = 0, add = 0))+
    scale_x_continuous(breaks=seq(100,400,100), limits = c(50,400), expand = expansion(mult = 0, add = 0))+
    theme(
        panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(colour = "grey", linetype = "dashed"),
        plot.margin = margin(t =0, r =0, b=0, l=0)
    )+
    theme(
        axis.title.y = element_text(face = "bold", vjust = -0.1, size = 7, color = "black"),
        axis.title.x = element_text(face = "bold", vjust=0.3, size = 7),
        axis.text = element_text(size = 7),
        axis.line = element_line(size = 0.2, colour = "#CC3300", linetype =1),
        axis.ticks = element_line(size = 0.4, colour = "#CC3300"),
        axis.ticks.length = unit(0.15, "cm")
    )
PsenAn_162_time1

PsenAn_162_time2 <- senAn_162_time2 %>%
    ggplot(aes(x = landAv,
               y = timeReq,
               colour = Technology))+
    geom_point(aes(size = numberSST,
                    shape = BA_Sprayer_Num), show.legend = FALSE)+
    labs(x = "Farm size (ha)",
         y = "Labor input SSPAs (%)")+
    ggtitle(label = "Sugar beet farm")+
    theme(plot.title = element_text(face = "bold", size = 8, colour ="#CC3300"))+
    scale_colour_manual(name = "Technology adoption in scenario 2",
                        breaks = c("BA Sprayer", "SST6m", "SST27m"),
                        labels = c("No SST", "SST6m", "SST27m"),
                        values = c("#333333", "#000099", "#0099FF"))+
    scale_shape_manual(name = "BA Sprayer",
                        breaks = c("", "1"),
                        labels = c("No", "Yes"),
                        values=c(1,19))+
    scale_size_manual(name = "SST",
                            breaks = c("", "1", "2"),
                            labels = c("None", "1 Sprayer", "2 Sprayer"),
                            values=c(1,1,2))+
    scale_y_continuous(breaks=seq(50,200,50), limits = c(50,200), expand = expansion(mult = 0, add = 0))+
    scale_x_continuous(breaks=seq(100,400,100), limits = c(50,400), expand = expansion(mult = 0, add = 0))+
    theme(
        panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(colour = "grey", linetype = "dashed"),
        plot.margin = margin(t =0, r =0, b=0, l=0)
    )+
    theme(
        axis.title.y = element_text(face = "bold", vjust = -0.1, size = 7, color = "black"),
        axis.title.x = element_text(face = "bold", vjust=0.3, size = 7),
        axis.text = element_text(size = 7),
        axis.line = element_line(size = 0.2, colour = "#CC3300", linetype =1),
        axis.ticks = element_line(size = 0.4, colour = "#CC3300"),
        axis.ticks.length = unit(0.15, "cm")
    )
PsenAn_162_time2


###################Fuel Consumption
PsenAn_162_fuel1 <- senAn_162_fuel1 %>%
    ggplot(aes(x = landAv,
               y = fuelCons,
               colour = Technology))+
    geom_point(aes(size = numberSST,
                    shape = BA_Sprayer_Num), show.legend = TRUE)+
    labs(x = "Farm size (ha)",
         y = "Fuel input SSPAs (%)")+
    ggtitle(label = "Sugar beet farm")+
    theme(plot.title = element_text(face = "bold", size = 8, colour ="#CC3300"))+
    scale_colour_manual(name = "Technology\nadoption:\nScenario 1",
                        breaks = c("BA Sprayer", "SST6m", "SST27m"),
                        labels = c("No SST", "SST6m", "SST27m"),
                        values = c("#333333", "#006600", "#33FF00"))+
    scale_shape_manual(name = "BA Sprayer",
                        breaks = c("", "1"),
                        labels = c("No", "Yes"),
                        values=c(1,19))+
    scale_size_manual(name = "SST",
                            breaks = c("", "1", "2"),
                            labels = c("None", "1 Sprayer", "2 Sprayer"),
                            values=c(1,1,2))+
    scale_y_continuous(breaks=seq(50,200,50), limits = c(50,200), expand = expansion(mult = 0, add = 0))+
    scale_x_continuous(breaks=seq(100,400,100), limits = c(50,400), expand = expansion(mult = 0, add = 0))+
    theme(
        panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(colour = "grey", linetype = "dashed"),
        plot.margin = margin(t =0, r =0, b=0, l=0)
    )+
    theme(
        axis.title.y = element_text(face = "bold", vjust = -0.1, size = 7, color = "black"),
        axis.title.x = element_text(face = "bold", vjust=0.3, size = 7),
        axis.text = element_text(size = 7),
        axis.line = element_line(size = 0.2, colour = "#CC3300", linetype =1),
        axis.ticks = element_line(size = 0.4, colour = "#CC3300"),
        axis.ticks.length = unit(0.15, "cm")
    )+
    theme(legend.position="bottom", legend.box = "horizontal", legend.direction = "horizontal") +
    theme(legend.title = element_text(face = "bold", color = "#009933", size = 8, hjust=.5)) +
    theme((legend.text = element_text(size = 8))) +
    guides(colour = guide_legend(override.aes = list(size=1.5))) +
    guides(shape = "none", size ="none")
PsenAn_162_fuel1

PsenAn_162_fuel2 <- senAn_162_fuel2 %>%
    ggplot(aes(x = landAv,
               y = fuelCons,
               colour = Technology))+
    geom_point(aes(size = numberSST,
                    shape = BA_Sprayer_Num), show.legend = TRUE)+
    labs(x = "Farm size (ha)",
         y = "Fuel input SSPAs (%)")+
    ggtitle(label = "Sugar beet farm")+
    theme(plot.title = element_text(face = "bold", size = 8, colour ="#CC3300"))+
    scale_colour_manual(name = "Technology\nadoption:\nScenario 2",
                        breaks = c("BA Sprayer", "SST6m", "SST27m"),
                        labels = c("No SST", "SST6m", "SST27m"),
                        values = c("#333333", "#000099", "#0099FF"))+
    scale_shape_manual(name = "BA Sprayer",
                        breaks = c("", "1"),
                        labels = c("No", "Yes"),
                        values=c(1,19))+
    scale_size_manual(name = "SST",
                            breaks = c("", "1", "2"),
                            labels = c("None", "1 Sprayer", "2 Sprayer"),
                            values=c(1,1,2))+
    scale_y_continuous(breaks=seq(50,200,50), limits = c(50,200), expand = expansion(mult = 0, add = 0))+
    scale_x_continuous(breaks=seq(100,400,100), limits = c(50,400), expand = expansion(mult = 0, add = 0))+
    theme(
        panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(colour = "grey", linetype = "dashed"),
        plot.margin = margin(t =0, r =0, b=0, l=0)
    )+
    theme(
        axis.title.y = element_text(face = "bold", vjust = -0.1, size = 7, color = "black"),
        axis.title.x = element_text(face = "bold", vjust=0.3, size = 7),
        axis.text = element_text(size = 7),
        axis.line = element_line(size = 0.2, colour = "#CC3300", linetype =1),
        axis.ticks = element_line(size = 0.4, colour = "#CC3300"),
        axis.ticks.length = unit(0.15, "cm")
    )+
    theme(legend.position="bottom", legend.box = "vertical", legend.direction = "vertical") +
    theme(legend.title = element_text(face = "bold", colour = "#0000FF", size = 8, hjust=.5)) +
    theme((legend.text = element_text(size = 8))) +
    guides(colour = guide_legend(override.aes = list(size=1.5))) +
    guides(colour = guide_legend(order = 1)) +
    guides(size = "none")
PsenAn_162_fuel2



###################Repair
PsenAn_162_repair1 <- senAn_162_repair1 %>%
    ggplot(aes(x = landAv,
               y = repCosts,
               colour = Technology))+
    geom_point(aes(size = numberSST,
                    shape = BA_Sprayer_Num), show.legend = TRUE)+
    labs(x = "Farm size (ha)",
         y = "SST repair costs (%)")+
    ggtitle(label = "Sugar beet farm")+
    theme(plot.title = element_text(face = "bold", size = 8, colour ="#CC3300"))+
    scale_colour_manual(name = "Technology\nadoption:\nScenario 1",
                        breaks = c("BA Sprayer", "SST6m", "SST27m"),
                        labels = c("No SST", "SST6m", "SST27m"),
                        values = c("#333333", "#006600", "#33FF00"))+
    scale_shape_manual(name = "BA Sprayer",
                        breaks = c("", "1"),
                        labels = c("No", "Yes"),
                        values=c(1,19))+
    scale_size_manual(name = "SST",
                            breaks = c("", "1", "2"),
                            labels = c("None", "1 Sprayer", "2 Sprayer"),
                            values=c(1,1,2))+
    scale_y_continuous(breaks=seq(50,200,50), limits = c(50,200), expand = expansion(mult = 0, add = 0))+
    scale_x_continuous(breaks=seq(100,400,100), limits = c(50,400), expand = expansion(mult = 0, add = 0))+
    theme(
        panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(colour = "grey", linetype = "dashed"),
        plot.margin = margin(t =0, r =0, b=0, l=0)
    )+
    theme(
        axis.title.y = element_text(face = "bold", vjust = -0.1, size = 7, color = "black"),
        axis.title.x = element_text(face = "bold", vjust=0.3, size = 7),
        axis.text = element_text(size = 7),
        axis.line = element_line(size = 0.2, colour = "#CC3300", linetype =1),
        axis.ticks = element_line(size = 0.4, colour = "#CC3300"),
        axis.ticks.length = unit(0.15, "cm")
    )+
    theme(legend.position="bottom", legend.box = "horizontal", legend.direction = "horizontal") +
    theme(legend.title = element_text(face = "bold", color = "#009933", size = 8, hjust=.5)) +
    theme((legend.text = element_text(size = 8))) +
    guides(colour = guide_legend(override.aes = list(size=1.5))) +
    guides(shape = "none", size ="none")
PsenAn_162_repair1


PsenAn_162_repair2 <- senAn_162_repair2 %>%
    ggplot(aes(x = landAv,
               y = repCosts,
               colour = Technology))+
    geom_point(aes(size = numberSST,
                    shape = BA_Sprayer_Num), show.legend = TRUE)+
    labs(x = "Farm size (ha)",
         y = "SST repair costs (%)")+
    ggtitle(label = "Sugar beet farm")+
    theme(plot.title = element_text(face = "bold", size = 8, colour ="#CC3300"))+
    scale_colour_manual(name = "Technology",
                        breaks = c("BA Sprayer", "SST6m", "SST27m"),
                        labels = c("No SST", "SST6m", "SST27m"),
                        values = c("#333333", "#000099", "#0099FF"))+
    scale_shape_manual(name = "BA Sprayer",
                        breaks = c("", "1"),
                        labels = c("No", "Yes"),
                        values=c(1,19))+
    scale_size_manual(name = "SST",
                            breaks = c("", "1", "2"),
                            labels = c("None", "1 Sprayer", "2 Sprayer"),
                            values=c(1,1,2))+
    scale_y_continuous(breaks=seq(50,200,50), limits = c(50,200), expand = expansion(mult = 0, add = 0))+
    scale_x_continuous(breaks=seq(100,400,100), limits = c(50,400), expand = expansion(mult = 0, add = 0))+
    theme(
        panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(colour = "grey", linetype = "dashed"),
        plot.margin = margin(t =0, r =0, b=0, l=0)
    )+
    theme(
        axis.title.y = element_text(face = "bold", vjust = -0.1, size = 7, color = "black"),
        axis.title.x = element_text(face = "bold", vjust=0.3, size = 7),
        axis.text = element_text(size = 7),
        axis.line = element_line(size = 0.2, colour = "#CC3300", linetype =1),
        axis.ticks = element_line(size = 0.4, colour = "#CC3300"),
        axis.ticks.length = unit(0.15, "cm")
    )+
    theme(legend.position="bottom", legend.box = "vertical", legend.direction = "vertical") +
    theme(legend.title = element_text(face = "bold", size = 8, hjust=.5)) +
    theme((legend.text = element_text(size = 8))) +
    guides(shape = guide_legend(override.aes = list(size=1.5))) +
    guides(size = "none", color = "none")
PsenAn_162_repair2

###################Number Passages
PsenAn_162_numPassag1 <- senAn_162_numPassag1 %>%
    ggplot(aes(x = landAv,
               y = numPassag,
               colour = Technology))+
    geom_point(aes(size = numberSST,
                    shape = BA_Sprayer_Num), show.legend = FALSE)+
    labs(x = "Farm size (ha)",
         y = "Passages SSPAs (%)")+
    ggtitle(label = "Sugar beet farm")+
    theme(plot.title = element_text(face = "bold", size = 8, colour ="#CC3300"))+
    scale_colour_manual(name = "Technology",
                        breaks = c("BA Sprayer", "SST6m", "SST27m"),
                        labels = c("No SST", "SST6m", "SST27m"),
                        values = c("#333333", "#006600", "#33FF00"))+
    scale_shape_manual(name = "BA Sprayer",
                        breaks = c("", "1"),
                        labels = c("No", "Yes"),
                        values=c(1,19))+
    scale_size_manual(name = "SST",
                            breaks = c("", "1", "2"),
                            labels = c("None", "1 Sprayer", "2 Sprayer"),
                            values=c(1,1,2))+
    scale_y_continuous(breaks=seq(50,200,50), limits = c(50,200), expand = expansion(mult = 0, add = 0))+
    scale_x_continuous(breaks=seq(100,400,100), limits = c(50,400), expand = expansion(mult = 0, add = 0))+
    theme(
        panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(colour = "grey", linetype = "dashed"),
        plot.margin = margin(t =0, r =0, b=0, l=0)
    )+
    theme(
        axis.title.y = element_text(face = "bold", vjust=-0.1, size = 7, color = "black"),
        axis.title.x = element_text(face = "bold", vjust=0.3, size = 7),
        axis.text = element_text(size = 7),
        axis.line = element_line(size = 0.2, colour = "#CC9900", linetype =1),
        axis.ticks = element_line(size = 0.4, colour = "#CC9900"),
        axis.ticks.length = unit(0.15, "cm")
    )
PsenAn_162_numPassag1

PsenAn_162_numPassag2 <- senAn_162_numPassag2 %>%
    ggplot(aes(x = landAv,
               y = numPassag,
               colour = Technology))+
    geom_point(aes(size = numberSST,
                    shape = BA_Sprayer_Num), show.legend = FALSE)+
    labs(x = "Farm size (ha)",
         y = "Passages SSPAs (%)")+
    ggtitle(label = "Sugar beet farm")+
    theme(plot.title = element_text(face = "bold", size = 8, colour ="#CC3300"))+
    scale_colour_manual(name = "Technology",
                        breaks = c("BA Sprayer", "SST6m", "SST27m"),
                        labels = c("No SST", "SST6m", "SST27m"),
                        values = c("#333333", "#000099", "#0099FF"))+
    scale_shape_manual(name = "BA Sprayer",
                        breaks = c("", "1"),
                        labels = c("No", "Yes"),
                        values=c(1,19))+
    scale_size_manual(name = "SST",
                            breaks = c("", "1", "2"),
                            labels = c("None", "1 Sprayer", "2 Sprayer"),
                            values=c(1,1,2))+
    scale_y_continuous(breaks=seq(50,200,50), limits = c(50,200), expand = expansion(mult = 0, add = 0))+
    scale_x_continuous(breaks=seq(100,400,100), limits = c(50,400), expand = expansion(mult = 0, add = 0))+
    theme(
        panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(colour = "grey", linetype = "dashed"),
        plot.margin = margin(t =0, r =0, b=0, l=0)
    )+
    theme(
        axis.title.y = element_text(face = "bold", vjust=-0.1, size = 7, color = "black"),
        axis.title.x = element_text(face = "bold", vjust=0.3, size = 7),
        axis.text = element_text(size = 7),
        axis.line = element_line(size = 0.2, colour = "#CC9900", linetype =1),
        axis.ticks = element_line(size = 0.4, colour = "#CC9900"),
        axis.ticks.length = unit(0.15, "cm")
    )
PsenAn_162_numPassag2


rm(PsenAn_162_fuel1)
rm(PsenAn_162_fuel2)
rm(PsenAn_162_repair1)
rm(PsenAn_162_repair2)
rm(PsenAn_162_time1)
rm(PsenAn_162_time2)
rm(PsenAn_162_teValue1)
rm(PsenAn_162_teValue2)
rm(PsenAn_162_PestEff1)
rm(PsenAn_162_PestEff2)
rm(senAn_162_numPassag1)
rm(senAn_162_numPassag2)