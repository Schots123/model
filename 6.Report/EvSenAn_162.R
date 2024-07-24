library(gamstransfer)
library(tidyverse)
setwd("E:\\Studium\\Master of Science Agricultural and Food Economics\\04. Master Thesis\\8. GitHub\\Fruchtfolge Model\\model\\6.Report\\gdxFiles")
getwd()
m162senAn = Container$new("ResultsSenAnSmall_162.141.gdx")
# following containter is filled with 500 solutions for SST value for each scenario
m162senAn = Container$new("ResultsSenAnPesti_162.141.gdx")
#showing parameter names stored in container
m162senAn$listSymbols()

#quick overview over parameters 
m162senAn$describeParameters()

#assign records of specific parameter in containter to dataframe
senAn_farm162 <- m162senAn["summarySenAn"]$records

senAn_farm162$value <- replace(senAn_farm162$value, senAn_farm162$value > 0.99 & senAn_farm162$value < 1.01, 1)


#showing overview about specific parameter
view(senAn_farm162)
glimpse(senAn_farm162)
view(senAn_farm162)
senAn_farm162[["value"]]

#lists names of variables in dataframe
names(senAn_farm162)



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

#smaller subsets for assignment of values to each sensitivity analysis
senAn_162_teValue <- subset(senAn_farm162, allItems_1 == "%SSTValue")
senAn_162_algoCosts <- subset(senAn_farm162, allItems_1 == "%algCosts")
senAn_162_annFee <- subset(senAn_farm162, allItems_1 == "%anFee")
senAn_162_PestEff <- subset(senAn_farm162, allItems_1 == "%pestiSav")
senAn_162_time <- subset(senAn_farm162, allItems_1 == "%timeReq")
senAn_162_fuel <- subset(senAn_farm162, allItems_1 == "%fuelCons")
senAn_162_repair <- subset(senAn_farm162, allItems_1 == "%repCosts")


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

colnames(senAn_162_teValue)[5] <- "SSTValue"
colnames(senAn_162_algoCosts)[5] <- "algCosts"
colnames(senAn_162_annFee)[5] <- "annFee"
colnames(senAn_162_PestEff)[5] <- "PestEff"
colnames(senAn_162_time)[5] <- "timeReq"
colnames(senAn_162_fuel)[5] <- "fuelCons"
colnames(senAn_162_repair)[5] <- "repCosts"

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

senAn_162_teValue$allItems_1 <- NULL
senAn_162_algoCosts$allItems_1 <- NULL
senAn_162_annFee$allItems_1 <- NULL
senAn_162_PestEff$allItems_1 <- NULL
senAn_162_time$allItems_1 <- NULL
senAn_162_fuel$allItems_1 <- NULL
senAn_162_repair$allItems_1 <- NULL

#create new combined dataframes for each sensitivity analysis seperately 
senAn_162_teValue <- senAn_162_teValue %>%
    left_join(senAn_162_landAv, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_landUsed, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_WW, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_WG, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_SB, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_BA45kW, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_BA67kW, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_BA83kW, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_BA_102kW, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_BA_120kW, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_BA_200kW, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_BA_230kW, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_spot6m, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_spot27m, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_avgAnProf, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_diCostsPesti, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_fuelCostsSprayer, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_repCostsSprayer, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_labCostsSprayer, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_deprecSprayer, by =c("uni_2","uni_3","uni_4"))


senAn_162_algoCosts <- senAn_162_algoCosts %>%
    left_join(senAn_162_landAv, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_landUsed, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_WW, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_WG, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_SB, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_BA45kW, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_BA67kW, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_BA83kW, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_BA_102kW, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_BA_120kW, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_BA_200kW, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_BA_230kW, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_spot6m, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_spot27m, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_avgAnProf, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_diCostsPesti, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_fuelCostsSprayer, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_repCostsSprayer, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_labCostsSprayer, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_deprecSprayer, by =c("uni_2","uni_3","uni_4"))


senAn_162_annFee <- senAn_162_annFee %>%
    left_join(senAn_162_landAv, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_landUsed, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_WW, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_WG, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_SB, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_BA45kW, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_BA67kW, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_BA83kW, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_BA_102kW, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_BA_120kW, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_BA_200kW, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_BA_230kW, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_spot6m, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_spot27m, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_avgAnProf, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_diCostsPesti, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_fuelCostsSprayer, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_repCostsSprayer, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_labCostsSprayer, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_deprecSprayer, by =c("uni_2","uni_3","uni_4"))

senAn_162_PestEff <- senAn_162_PestEff %>%
    left_join(senAn_162_landAv, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_landUsed, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_WW, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_WG, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_SB, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_BA45kW, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_BA67kW, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_BA83kW, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_BA_102kW, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_BA_120kW, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_BA_200kW, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_BA_230kW, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_spot6m, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_spot27m, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_avgAnProf, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_diCostsPesti, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_fuelCostsSprayer, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_repCostsSprayer, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_labCostsSprayer, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_deprecSprayer, by =c("uni_2","uni_3","uni_4"))

senAn_162_time <- senAn_162_time %>%
    left_join(senAn_162_landAv, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_landUsed, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_WW, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_WG, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_SB, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_BA45kW, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_BA67kW, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_BA83kW, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_BA_102kW, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_BA_120kW, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_BA_200kW, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_BA_230kW, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_spot6m, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_spot27m, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_avgAnProf, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_diCostsPesti, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_fuelCostsSprayer, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_repCostsSprayer, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_labCostsSprayer, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_deprecSprayer, by =c("uni_2","uni_3","uni_4"))

senAn_162_fuel <- senAn_162_fuel %>%
    left_join(senAn_162_landAv, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_landUsed, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_WW, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_WG, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_SB, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_BA45kW, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_BA67kW, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_BA83kW, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_BA_102kW, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_BA_120kW, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_BA_200kW, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_BA_230kW, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_spot6m, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_spot27m, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_avgAnProf, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_diCostsPesti, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_fuelCostsSprayer, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_repCostsSprayer, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_labCostsSprayer, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_deprecSprayer, by =c("uni_2","uni_3","uni_4"))

senAn_162_repair <- senAn_162_repair %>%
    left_join(senAn_162_landAv, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_landUsed, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_WW, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_WG, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_SB, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_BA45kW, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_BA67kW, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_BA83kW, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_BA_102kW, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_BA_120kW, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_BA_200kW, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_BA_230kW, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_spot6m, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_spot27m, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_avgAnProf, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_diCostsPesti, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_fuelCostsSprayer, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_repCostsSprayer, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_labCostsSprayer, by =c("uni_2","uni_3","uni_4")) %>%
    left_join(senAn_162_deprecSprayer, by =c("uni_2","uni_3","uni_4"))

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

#####################################
#Column Preperation for Visualization
#####################################
###################Technology Value 

#combine all BA sprayer columns to one
senAn_162_teValue$numberSST6m <- senAn_162_teValue$spot6m
senAn_162_teValue$numberSST27m <- senAn_162_teValue$spot27m
senAn_162_teValue$BA_45kWNum <- senAn_162_teValue$BA_45kW
senAn_162_teValue$BA_67kWNum <- senAn_162_teValue$BA_67kW
senAn_162_teValue$BA_83kWNum <- senAn_162_teValue$BA_83kW
senAn_162_teValue$BA_102kWNum <- senAn_162_teValue$BA_102kW
senAn_162_teValue$BA_120kWNum <- senAn_162_teValue$BA_120kW
senAn_162_teValue$BA_200kWNum <- senAn_162_teValue$BA_200kW
senAn_162_teValue$BA_230kWNum <- senAn_162_teValue$BA_230kW
senAn_162_teValue[is.na(senAn_162_teValue)] <- ""
senAn_162_teValue <- senAn_162_teValue %>%
#rename number values to respective BA Sprayer used
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
senAn_162_teValue$Technology[senAn_162_teValue$Technology==""]<-"BA Sprayer"


###################Algorithm Costs
senAn_162_algoCosts$numberSST6m <- senAn_162_algoCosts$spot6m
senAn_162_algoCosts$numberSST27m <- senAn_162_algoCosts$spot27m
senAn_162_algoCosts$BA_45kWNum <- senAn_162_algoCosts$BA_45kW
senAn_162_algoCosts$BA_67kWNum <- senAn_162_algoCosts$BA_67kW
senAn_162_algoCosts$BA_83kWNum <- senAn_162_algoCosts$BA_83kW
senAn_162_algoCosts$BA_102kWNum <- senAn_162_algoCosts$BA_102kW
senAn_162_algoCosts$BA_120kWNum <- senAn_162_algoCosts$BA_120kW
senAn_162_algoCosts$BA_200kWNum <- senAn_162_algoCosts$BA_200kW
senAn_162_algoCosts$BA_230kWNum <- senAn_162_algoCosts$BA_230kW
senAn_162_algoCosts[is.na(senAn_162_algoCosts)] <- ""
senAn_162_algoCosts <- senAn_162_algoCosts %>%
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
senAn_162_algoCosts$Technology[senAn_162_algoCosts$Technology==""]<-"BA Sprayer"


###################Annual Fee
senAn_162_annFee$numberSST6m <- senAn_162_annFee$spot6m
senAn_162_annFee$numberSST27m <- senAn_162_annFee$spot27m
senAn_162_annFee$BA_45kWNum <- senAn_162_annFee$BA_45kW
senAn_162_annFee$BA_67kWNum <- senAn_162_annFee$BA_67kW
senAn_162_annFee$BA_83kWNum <- senAn_162_annFee$BA_83kW
senAn_162_annFee$BA_102kWNum <- senAn_162_annFee$BA_102kW
senAn_162_annFee$BA_120kWNum <- senAn_162_annFee$BA_120kW
senAn_162_annFee$BA_200kWNum <- senAn_162_annFee$BA_200kW
senAn_162_annFee$BA_230kWNum <- senAn_162_annFee$BA_230kW
senAn_162_annFee[is.na(senAn_162_annFee)] <- ""
senAn_162_annFee <- senAn_162_annFee %>%
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
senAn_162_annFee$Technology[senAn_162_annFee$Technology==""]<-"BA Sprayer"



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


####################
#Scenario Seperation
####################
senAn_162_teValue1 <- subset(senAn_162_teValue, uni_4 == "Base|FH")
senAn_162_teValue2 <- subset(senAn_162_teValue, uni_4 == "Base|FHBonus")
rm(senAn_162_teValue)

senAn_162_algoCosts100_1 <- subset(senAn_162_algoCosts, uni_4 == "Base|FH" & uni_3 == "100%AlgoVar")
senAn_162_algoCosts100_2 <- subset(senAn_162_algoCosts, uni_4 == "Base|FHBonus" & uni_3 == "100%AlgoVar")
senAn_162_algoCosts50_1 <- subset(senAn_162_algoCosts, uni_4 == "Base|FH" & uni_3 == "50%AlgoVar")
senAn_162_algoCosts50_2 <- subset(senAn_162_algoCosts, uni_4 == "Base|FHBonus" & uni_3 == "50%AlgoVar")
rm(senAn_162_algoCosts)

senAn_162_annFee100_1 <- subset(senAn_162_annFee, uni_4 == "Base|FH" & uni_3 == "100%AnFeeVar")
senAn_162_annFee100_2 <- subset(senAn_162_annFee, uni_4 == "Base|FHBonus" & uni_3 == "100%AnFeeVar")
senAn_162_annFee50_1 <- subset(senAn_162_annFee, uni_4 == "Base|FH" & uni_3 == "50%AnFeeVar")
senAn_162_annFee50_2 <- subset(senAn_162_annFee, uni_4 == "Base|FHBonus" & uni_3 == "50%AnFeeVar")
rm(senAn_162_annFee)

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


###################
#DATA VISUALIZATION
###################

###################Technology Value 
PsenAn_162_teValue1 <- senAn_162_teValue1 %>%
#aes tells R which variables are mapped against which visual characteristics on the canvas 
    ggplot(aes(x = landAv,
               y = SSTValue,
               colour = Technology))+
#    geom_smooth(se = F)+
#geom_point tells R to use points as the geometry (scatter plot)
    geom_point(aes(alpha = numberSST,
                    shape = BA_Sprayer_Num), size = 3, show.legend = TRUE)+
#geom_smooth connects points 
#rename graph labels 
    labs(x = "Farm size (in ha)",
         y = "Proportion of initial SST acquisition costs (in %)")+
#Formatting of graph
#Formatting of graph tite
#    ggtitle("Acquisition costs")+
#    theme(plot.title = element_text(lineheight =.8, face="bold", size=9, hjust=0.5))+
#title & subtitle
    ggtitle(label ="", subtitle = "Root crop farm")+
    theme(plot.subtitle = element_text(face = "bold", size = 11, colour ="#CC3300"))+
#Formatting of legend
    scale_colour_manual(name = "Technology adoption in scenario 1",
                        breaks = c("BA Sprayer", "SST6m", "SST27m"),
                        labels = c("BA Sprayer", "SST6m", "SST27m"),
                        values = c("#333333", "#006600", "#33FF00"))+
    scale_shape_manual(name = "BA Sprayer",
                        breaks = c("", "1"),
                        labels = c("No", "Yes"),
                        values=c(1,19))+
    scale_alpha_manual(name = "SST",
                            breaks = c("", "1", "2"),
                            labels = c("None", "1 Sprayer", "2 Sprayer"),
                            values=c(0.7,0.7,1))+
#formatting of axis
    scale_y_continuous(breaks=seq(50,200,30), limits = c(50,200), expand = expansion(mult = 0, add = 0))+
    scale_x_continuous(breaks=seq(100,400,100), limits = c(50,400), expand = expansion(mult = 0, add = 0))+
    theme(
        panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(colour = "grey", linetype = "dashed"),
        plot.margin = margin(t =0, r =0, b=0, l=0)
    )+
    theme(
        axis.title.y = element_text(vjust=2, size = 9),
        axis.title.x = element_text(vjust=0.3, size = 9),
        axis.text = element_text(size = 9),
        axis.line = element_line(size = 0.2, colour = "#CC3300", linetype =1),
        axis.ticks = element_line(size = 0.4, colour = "#CC3300"),
        axis.ticks.length = unit(0.15, "cm")
    )+
    guides(shape = "none", alpha ="none")
PsenAn_162_teValue1


PsenAn_162_teValue2 <- senAn_162_teValue2 %>%
    ggplot(aes(x = landAv,
               y = SSTValue,
               colour = Technology))+
    geom_point(aes(alpha = numberSST,
                    shape = BA_Sprayer_Num), size = 3, show.legend = FALSE)+
    labs(x = "Farm size (in ha)",
         y = "Proportion of initial SST acquisition costs (in %)")+
    #theme(plot.title = element_text(lineheight =.8, face="bold", size=9, hjust=0.5))+
    ggtitle(label ="", subtitle = "Root crop farm")+
    theme(plot.subtitle = element_text(face = "bold", size = 11, colour ="#CC3300"))+
    scale_colour_manual(name = "Technology",
                        breaks = c("BA Sprayer", "SST6m", "SST27m"),
                        labels = c("BA Sprayer", "SST6m", "SST27m"),
                        values = c("#333333", "#000099", "#0099FF"))+
    scale_shape_manual(name = "BA Sprayer",
                        breaks = c("", "1"),
                        labels = c("No", "Yes"),
                        values=c(1,19))+
    scale_alpha_manual(name = "SST",
                            breaks = c("", "1", "2"),
                            labels = c("None", "1 Sprayer", "2 Sprayer"),
                            values=c(0.7,0.7,1))+
    scale_y_continuous(breaks=seq(50,200,30), limits = c(50,200), expand = expansion(mult = 0, add = 0))+
    scale_x_continuous(breaks=seq(100,400,100), limits = c(50,400), expand = expansion(mult = 0, add = 0))+
    theme(
        panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(colour = "grey", linetype = "dashed"),
        plot.margin = margin(t =0, r =0, b=0, l=0)
    )+
    theme(
        axis.title.y = element_text(vjust=2, size = 9),
        axis.title.x = element_text(vjust=0.3, size = 9),
        axis.text = element_text(size = 9),
        axis.line = element_line(size = 0.2, colour = "#CC3300", linetype =1),
        axis.ticks = element_line(size = 0.4, colour = "#CC3300"),
        axis.ticks.length = unit(0.15, "cm")
    )
PsenAn_162_teValue2


###################Algorithm Costs
PsenAn_162_algoCosts100_1 <- senAn_162_algoCosts100_1 %>%
    ggplot(aes(x = landAv,
               y = algCosts,
               colour = Technology))+
    geom_point(aes(alpha = numberSST,
                    shape = BA_Sprayer_Num), size = 3, show.legend = FALSE)+
    labs(x = "Farm size (in ha)",
         y = "Algorithm costs per ha with SSPA (in €)")+
    scale_colour_manual(name = "Technology",
                        breaks = c("BA Sprayer", "SST6m", "SST27m"),
                        labels = c("BA Sprayer", "SST6m", "SST27m"),
                        values = c("#333333", "#006600", "#33FF00"))+
    scale_shape_manual(name = "BA Sprayer",
                        breaks = c("", "1"),
                        labels = c("No", "Yes"),
                        values=c(1,19))+
    scale_alpha_manual(name = "SST",
                            breaks = c("", "1", "2"),
                            labels = c("None", "1 Sprayer", "2 Sprayer"),
                            values=c(0.7,0.7,1))+
    scale_y_continuous(breaks=seq(0,10,2), limits = c(0,10), expand = expansion(mult = 0, add = 0))+
    scale_x_continuous(breaks=seq(100,400,100), limits = c(50,400), expand = expansion(mult = 0, add = 0))+
    theme(
        panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(colour = "grey", linetype = "dashed"),
        plot.margin = margin(t =0, r =0, b=0, l=0)
    )+
    theme(
        axis.title.y = element_text(vjust=2, size = 9),
        axis.title.x = element_text(vjust=0.3, size = 9),
        axis.text = element_text(size = 9),
        axis.line = element_line(size = 0.2, colour = "#CC3300", linetype =1),
        axis.ticks = element_line(size = 0.4, colour = "#CC3300"),
        axis.ticks.length = unit(0.15, "cm")
    )
PsenAn_162_algoCosts100_1

PsenAn_162_algoCosts100_2 <- senAn_162_algoCosts100_2 %>%
    ggplot(aes(x = landAv,
               y = algCosts,
               colour = Technology))+
    geom_point(aes(alpha = numberSST,
                    shape = BA_Sprayer_Num), size = 3, show.legend = FALSE)+
    labs(x = "Farm size (in ha)",
         y = "Algorithm costs per ha with SSPA (in €)")+
    scale_colour_manual(name = "Technology",
                        breaks = c("BA Sprayer", "SST6m", "SST27m"),
                        labels = c("BA Sprayer", "SST6m", "SST27m"),
                        values = c("#333333", "#000099", "#0099FF"))+
    scale_shape_manual(name = "BA Sprayer",
                        breaks = c("", "1"),
                        labels = c("No", "Yes"),
                        values=c(1,19))+
    scale_alpha_manual(name = "SST",
                            breaks = c("", "1", "2"),
                            labels = c("None", "1 Sprayer", "2 Sprayer"),
                            values=c(0.7,0.7,1))+
    scale_y_continuous(breaks=seq(0,10,2), limits = c(0,10), expand = expansion(mult = 0, add = 0))+
    scale_x_continuous(breaks=seq(100,400,100), limits = c(50,400), expand = expansion(mult = 0, add = 0))+
    theme(
        panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(colour = "grey", linetype = "dashed"),
        plot.margin = margin(t =0, r =0, b=0, l=0)
    )+
    theme(
        axis.title.y = element_text(vjust=2, size = 9),
        axis.title.x = element_text(vjust=0.3, size = 9),
        axis.text = element_text(size = 9),
        axis.line = element_line(size = 0.2, colour = "#CC3300", linetype =1),
        axis.ticks = element_line(size = 0.4, colour = "#CC3300"),
        axis.ticks.length = unit(0.15, "cm")
    )
PsenAn_162_algoCosts100_2


PsenAn_162_algoCosts50_1 <- senAn_162_algoCosts50_1 %>%
    ggplot(aes(x = landAv,
               y = algCosts,
               colour = Technology))+
    geom_point(aes(alpha = numberSST,
                    shape = BA_Sprayer_Num), size = 3, show.legend = TRUE)+
    labs(x = "Farm size (in ha)",
         y = "Algorithm costs per ha with SSPA (in €)")+
    ggtitle(label ="", subtitle = "Root crop farm")+
    theme(plot.subtitle = element_text(face = "bold", size = 11, colour ="#CC3300"))+
    scale_colour_manual(name = "Technology adoption in scenario 1",
                        breaks = c("BA Sprayer", "SST6m", "SST27m"),
                        labels = c("BA Sprayer", "SST6m", "SST27m"),
                        values = c("#333333", "#006600", "#33FF00"))+
    scale_shape_manual(name = "BA Sprayer",
                        breaks = c("", "1"),
                        labels = c("No", "Yes"),
                        values=c(1,19))+
    scale_alpha_manual(name = "SST",
                            breaks = c("", "1", "2"),
                            labels = c("None", "1 Sprayer", "2 Sprayer"),
                            values=c(0.7,0.7,1))+
    scale_y_continuous(breaks=seq(0,10,2), limits = c(0,10), expand = expansion(mult = 0, add = 0))+
    scale_x_continuous(breaks=seq(100,400,100), limits = c(50,400), expand = expansion(mult = 0, add = 0))+
    theme(
        panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(colour = "grey", linetype = "dashed"),
        plot.margin = margin(t =0, r =0, b=0, l=0)
    )+
    theme(
        axis.title.y = element_text(vjust=2, size = 9),
        axis.title.x = element_text(vjust=0.3, size = 9),
        axis.text = element_text(size = 9),
        axis.line = element_line(size = 0.2, colour = "#CC3300", linetype =1),
        axis.ticks = element_line(size = 0.4, colour = "#CC3300"),
        axis.ticks.length = unit(0.15, "cm")
    )
PsenAn_162_algoCosts50_1


PsenAn_162_algoCosts50_2 <- senAn_162_algoCosts50_2 %>%
    ggplot(aes(x = landAv,
               y = algCosts,
               colour = Technology))+
    geom_point(aes(alpha = numberSST,
                    shape = BA_Sprayer_Num), size = 3, show.legend = TRUE)+
    labs(x = "Farm size (in ha)",
         y = "Algorithm costs per ha with SSPA (in €)")+
    ggtitle(label ="", subtitle = "Root crop farm")+
    theme(plot.subtitle = element_text(face = "bold", size = 11, colour ="#CC3300"))+
    scale_colour_manual(name = "Technology adoption in scenario 2",
                        breaks = c("BA Sprayer", "SST6m", "SST27m"),
                        labels = c("BA Sprayer", "SST6m", "SST27m"),
                        values = c("#333333", "#000099", "#0099FF"))+
    scale_shape_manual(name = "BA Sprayer",
                        breaks = c("", "1"),
                        labels = c("No", "Yes"),
                        values=c(1,19))+
    scale_alpha_manual(name = "SST",
                            breaks = c("", "1", "2"),
                            labels = c("None", "1 Sprayer", "2 Sprayer"),
                            values=c(0.7,0.7,1))+
    scale_y_continuous(breaks=seq(0,10,2), limits = c(0,10), expand = expansion(mult = 0, add = 0))+
    scale_x_continuous(breaks=seq(100,400,100), limits = c(50,400), expand = expansion(mult = 0, add = 0))+
    theme(
        panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(colour = "grey", linetype = "dashed"),
        plot.margin = margin(t =0, r =0, b=0, l=0)
    )+
    theme(
        axis.title.y = element_text(vjust=2, size = 9),
        axis.title.x = element_text(vjust=0.3, size = 9),
        axis.text = element_text(size = 9),
        axis.line = element_line(size = 0.2, colour = "#CC3300", linetype =1),
        axis.ticks = element_line(size = 0.4, colour = "#CC3300"),
        axis.ticks.length = unit(0.15, "cm")
    )
PsenAn_162_algoCosts50_2


###################Annual Fee
PsenAn_162_annFee100_1 <- senAn_162_annFee100_1 %>%
    ggplot(aes(x = landAv,
               y = annFee,
               colour = Technology))+
    geom_point(aes(alpha = numberSST,
                    shape = BA_Sprayer_Num), size = 3, show.legend = FALSE)+
    labs(x = "Farm size (in ha)",
         y = "Annual fee for SST (in €)")+
    ggtitle("Scenario 1")+
    theme(plot.title = element_text(face="bold", size=11, hjust=0.5, colour = "#009933"))+
    scale_colour_manual(name = "Technology",
                        breaks = c("BA Sprayer", "SST6m", "SST27m"),
                        labels = c("BA Sprayer", "SST6m", "SST27m"),
                        values = c("#333333", "#006600", "#33FF00"))+
    scale_shape_manual(name = "BA Sprayer",
                        breaks = c("", "1"),
                        labels = c("No", "Yes"),
                        values=c(1,19))+
    scale_alpha_manual(name = "SST",
                            breaks = c("", "1", "2"),
                            labels = c("None", "1 Sprayer", "2 Sprayer"),
                            values=c(0.7,0.7,1))+
    scale_y_continuous(breaks=seq(0,15000,3000), limits = c(0,15000), expand = expansion(mult = 0, add = 0))+
    scale_x_continuous(breaks=seq(100,400,100), limits = c(50,400), expand = expansion(mult = 0, add = 0))+
    theme(
        panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(colour = "grey", linetype = "dashed"),
        plot.margin = margin(t =0, r =0, b=0, l=0)
    )+
    theme(
        axis.title.y = element_text(vjust=2, size = 9),
        axis.title.x = element_text(vjust=0.3, size = 9),
        axis.text = element_text(size = 9),
        axis.line = element_line(size = 0.2, colour = "#CC3300", linetype =1),
        axis.ticks = element_line(size = 0.4, colour = "#CC3300"),
        axis.ticks.length = unit(0.15, "cm")
    )
PsenAn_162_annFee100_1


PsenAn_162_annFee100_2 <- senAn_162_annFee100_2 %>%
    ggplot(aes(x = landAv,
               y = annFee,
               colour = Technology))+
    geom_point(aes(alpha = numberSST,
                    shape = BA_Sprayer_Num), size = 3, show.legend = FALSE)+
    labs(x = "Farm size (in ha)",
         y = "Annual fee for SST (in €)")+
    ggtitle("Scenario 2")+
    theme(plot.title = element_text(face="bold", size=11, hjust=0.5, colour = "#0099FF"))+
    scale_colour_manual(name = "Technology",
                        breaks = c("BA Sprayer", "SST6m", "SST27m"),
                        labels = c("BA Sprayer", "SST6m", "SST27m"),
                        values = c("#333333", "#000099", "#0099FF"))+
    scale_shape_manual(name = "BA Sprayer",
                        breaks = c("", "1"),
                        labels = c("No", "Yes"),
                        values=c(1,19))+
    scale_alpha_manual(name = "SST",
                            breaks = c("", "1", "2"),
                            labels = c("None", "1 Sprayer", "2 Sprayer"),
                            values=c(0.7,0.7,1))+
    scale_y_continuous(breaks=seq(0,15000,3000), limits = c(0,15000), expand = expansion(mult = 0, add = 0))+
    scale_x_continuous(breaks=seq(100,400,100), limits = c(50,400), expand = expansion(mult = 0, add = 0))+
    theme(
        panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(colour = "grey", linetype = "dashed"),
        plot.margin = margin(t =0, r =0, b=0, l=0)
    )+
    theme(
        axis.title.y = element_text(vjust=2, size = 9),
        axis.title.x = element_text(vjust=0.3, size = 9),
        axis.text = element_text(size = 9),
        axis.line = element_line(size = 0.2, colour = "#CC3300", linetype =1),
        axis.ticks = element_line(size = 0.4, colour = "#CC3300"),
        axis.ticks.length = unit(0.15, "cm")
    )
PsenAn_162_annFee100_2 


PsenAn_162_annFee50_1 <- senAn_162_annFee50_1 %>%
    ggplot(aes(x = landAv,
               y = annFee,
               colour = Technology))+
    geom_point(aes(alpha = numberSST,
                    shape = BA_Sprayer_Num), size = 3, show.legend = FALSE)+
    labs(x = "Farm size (in ha)",
         y = "Annual fee for SST (in €)")+
    #ggtitle("Annual fee at 50 % SST acquisition costs")+
    #theme(plot.title = element_text(lineheight =.8, face="bold", size=9, hjust=0.5))+
    scale_colour_manual(name = "Technology",
                        breaks = c("BA Sprayer", "SST6m", "SST27m"),
                        labels = c("BA Sprayer", "SST6m", "SST27m"),
                        values = c("#333333", "#006600", "#33FF00"))+
    scale_shape_manual(name = "BA Sprayer",
                        breaks = c("", "1"),
                        labels = c("No", "Yes"),
                        values=c(1,19))+
    scale_alpha_manual(name = "SST",
                            breaks = c("", "1", "2"),
                            labels = c("None", "1 Sprayer", "2 Sprayer"),
                            values=c(0.7,0.7,1))+
    scale_y_continuous(breaks=seq(0,15000,3000), limits = c(0,15000), expand = expansion(mult = 0, add = 0))+
    scale_x_continuous(breaks=seq(100,400,100), limits = c(50,400), expand = expansion(mult = 0, add = 0))+
    theme(
        panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(colour = "grey", linetype = "dashed"),
        plot.margin = margin(t =0, r =0, b=0, l=0)
    )+
    theme(
        axis.title.y = element_text(vjust=2, size = 9),
        axis.title.x = element_text(vjust=0.3, size = 9),
        axis.text = element_text(size = 9),
        axis.line = element_line(size = 0.2, colour = "#CC3300", linetype =1),
        axis.ticks = element_line(size = 0.4, colour = "#CC3300"),
        axis.ticks.length = unit(0.15, "cm")
    )
PsenAn_162_annFee50_1


PsenAn_162_annFee50_2 <- senAn_162_annFee50_2 %>%
    ggplot(aes(x = landAv,
               y = annFee,
               colour = Technology))+
    geom_point(aes(alpha = numberSST,
                    shape = BA_Sprayer_Num), size = 3, show.legend = FALSE)+
    labs(x = "Farm size (in ha)",
         y = "Annual fee for SST (in €)")+
    #ggtitle("Annual fee at 50 % SST acquisition costs")+
    #theme(plot.title = element_text(lineheight =.8, face="bold", size=9, hjust=0.5))+
    scale_colour_manual(name = "Technology",
                        breaks = c("BA Sprayer", "SST6m", "SST27m"),
                        labels = c("BA Sprayer", "SST6m", "SST27m"),
                        values = c("#333333", "#000099", "#0099FF"))+
    scale_shape_manual(name = "BA Sprayer",
                        breaks = c("", "1"),
                        labels = c("No", "Yes"),
                        values=c(1,19))+
    scale_alpha_manual(name = "SST",
                            breaks = c("", "1", "2"),
                            labels = c("None", "1 Sprayer", "2 Sprayer"),
                            values=c(0.7,0.7,1))+
    scale_y_continuous(breaks=seq(0,15000,3000), limits = c(0,15000), expand = expansion(mult = 0, add = 0))+
    scale_x_continuous(breaks=seq(100,400,100), limits = c(50,400), expand = expansion(mult = 0, add = 0))+
    theme(
        panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(colour = "grey", linetype = "dashed"),
        plot.margin = margin(t =0, r =0, b=0, l=0)
    )+
    theme(
        axis.title.y = element_text(vjust=2, size = 9),
        axis.title.x = element_text(vjust=0.3, size = 9),
        axis.text = element_text(size = 9),
        axis.line = element_line(size = 0.2, colour = "#CC3300", linetype =1),
        axis.ticks = element_line(size = 0.4, colour = "#CC3300"),
        axis.ticks.length = unit(0.15, "cm")
    )
PsenAn_162_annFee50_2 


###################Pesticide Efficiency
PsenAn_162_PestEff1 <- senAn_162_PestEff1 %>%
    ggplot(aes(x = landAv,
               y = PestEff,
               colour = Technology))+
    geom_point(aes(alpha = numberSST,
                    shape = BA_Sprayer_Num), size = 3, show.legend = FALSE)+
    labs(x = "Farm size (in ha)",
         y = "Pesticide saving deviations for SSPAs (in deviating %-points)")+
    ggtitle("Scenario 1")+
    theme(plot.title = element_text(face="bold", size=11, hjust=0.5, colour = "#009933"))+
    scale_colour_manual(name = "Technology",
                        breaks = c("BA Sprayer", "SST6m", "SST27m"),
                        labels = c("BA Sprayer", "SST6m", "SST27m"),
                        values = c("#333333", "#006600", "#33FF00"))+
    scale_shape_manual(name = "BA Sprayer",
                        breaks = c("", "1"),
                        labels = c("No", "Yes"),
                        values=c(1,19))+
    scale_alpha_manual(name = "SST",
                            breaks = c("", "1", "2"),
                            labels = c("None", "1 Sprayer", "2 Sprayer"),
                            values=c(0.7,0.7,1))+
    scale_y_continuous(breaks=seq(-20,20,5), limits = c(-20,20), expand = expansion(mult = 0, add = 0))+
    scale_x_continuous(breaks=seq(100,400,100), limits = c(50,400), expand = expansion(mult = 0, add = 0))+
    theme(
        panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(colour = "grey", linetype = "dashed"),
        plot.margin = margin(t =0, r =0, b=0, l=0)
    )+
    theme(
        axis.title.y = element_text(vjust=2, size = 9),
        axis.title.x = element_text(vjust=0.3, size = 9),
        axis.text = element_text(size = 9),
        axis.line = element_line(size = 0.2, colour = "#CC3300", linetype =1),
        axis.ticks = element_line(size = 0.4, colour = "#CC3300"),
        axis.ticks.length = unit(0.15, "cm")
    )
PsenAn_162_PestEff1



PsenAn_162_PestEff2 <- senAn_162_PestEff2 %>%
    ggplot(aes(x = landAv,
               y = PestEff,
               colour = Technology))+
    geom_point(aes(alpha = numberSST,
                    shape = BA_Sprayer_Num), size = 3, show.legend = TRUE)+
    labs(x = "Farm size (in ha)",
         y = "Pesticide saving deviations for SSPAs (in deviating %-points)")+
    ggtitle("Scenario 2")+
    theme(plot.title = element_text(face="bold", size=11, hjust=0.5, colour = "#0099FF"))+
    scale_colour_manual(name = "Technology adoption in scenario 2",
                        breaks = c("BA Sprayer", "SST6m", "SST27m"),
                        labels = c("BA Sprayer", "SST6m", "SST27m"),
                        values = c("#333333", "#000099", "#0099FF"))+
    scale_shape_manual(name = "BA Sprayer",
                        breaks = c("", "1"),
                        labels = c("No", "Yes"),
                        values=c(1,19))+
    scale_alpha_manual(name = "SST",
                            breaks = c("", "1", "2"),
                            labels = c("None", "1 Sprayer", "2 Sprayer"),
                            values=c(0.7,0.7,1))+
    scale_y_continuous(breaks=seq(-20,20,5), limits = c(-20,20), expand = expansion(mult = 0, add = 0))+
    scale_x_continuous(breaks=seq(100,400,100), limits = c(50,400), expand = expansion(mult = 0, add = 0))+
    theme(
        panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(colour = "grey", linetype = "dashed"),
        plot.margin = margin(t =0, r =0, b=0, l=0)
    )+
    theme(
        axis.title.y = element_text(vjust=2, size = 9),
        axis.title.x = element_text(vjust=0.3, size = 9),
        axis.text = element_text(size = 9),
        axis.line = element_line(size = 0.2, colour = "#CC3300", linetype =1),
        axis.ticks = element_line(size = 0.4, colour = "#CC3300"),
        axis.ticks.length = unit(0.15, "cm")
    )
PsenAn_162_PestEff2

###################Time Requirements
PsenAn_162_time1 <- senAn_162_time1 %>%
    ggplot(aes(x = landAv,
               y = timeReq,
               colour = Technology))+
    geom_point(aes(alpha = numberSST,
                    shape = BA_Sprayer_Num), size = 3, show.legend = TRUE)+
    labs(x = "Farm size (in ha)",
         y = "Proportion of initial time requirements for each SST operation (in %)")+
    ggtitle(label ="", subtitle = "Root crop farm")+
    theme(plot.subtitle = element_text(face = "bold", size = 11, colour ="#CC3300"))+
    scale_colour_manual(name = "Technology adoption in scenario 1",
                        breaks = c("BA Sprayer", "SST6m", "SST27m"),
                        labels = c("BA Sprayer", "SST6m", "SST27m"),
                        values = c("#333333", "#006600", "#33FF00"))+
    scale_shape_manual(name = "BA Sprayer",
                        breaks = c("", "1"),
                        labels = c("No", "Yes"),
                        values=c(1,19))+
    scale_alpha_manual(name = "SST",
                            breaks = c("", "1", "2"),
                            labels = c("None", "1 Sprayer", "2 Sprayer"),
                            values=c(0.7,0.7,1))+
    scale_y_continuous(breaks=seq(50,200,30), limits = c(50,200), expand = expansion(mult = 0, add = 0))+
    scale_x_continuous(breaks=seq(100,400,100), limits = c(50,400), expand = expansion(mult = 0, add = 0))+
    theme(
        panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(colour = "grey", linetype = "dashed"),
        plot.margin = margin(t =0, r =0, b=0, l=0)
    )+
    theme(
        axis.title.y = element_text(vjust=2, size = 9),
        axis.title.x = element_text(vjust=0.3, size = 9),
        axis.text = element_text(size = 9),
        axis.line = element_line(size = 0.2, colour = "#CC3300", linetype =1),
        axis.ticks = element_line(size = 0.4, colour = "#CC3300"),
        axis.ticks.length = unit(0.15, "cm")
    )
PsenAn_162_time1

PsenAn_162_time2 <- senAn_162_time2 %>%
    ggplot(aes(x = landAv,
               y = timeReq,
               colour = Technology))+
    geom_point(aes(alpha = numberSST,
                    shape = BA_Sprayer_Num), size = 3, show.legend = TRUE)+
    labs(x = "Farm size (in ha)",
         y = "Proportion of initial time requirements for each SST operation (in %)")+
    ggtitle(label ="", subtitle = "Root crop farm")+
    theme(plot.subtitle = element_text(face = "bold", size = 11, colour ="#CC3300"))+
    #ggtitle("Time requirements")+
    #theme(plot.title = element_text(lineheight =.8, face="bold", size=9, hjust=0.5))+
    scale_colour_manual(name = "Technology adoption in scenario 2",
                        breaks = c("BA Sprayer", "SST6m", "SST27m"),
                        labels = c("BA Sprayer", "SST6m", "SST27m"),
                        values = c("#333333", "#000099", "#0099FF"))+
    scale_shape_manual(name = "BA Sprayer",
                        breaks = c("", "1"),
                        labels = c("No", "Yes"),
                        values=c(1,19))+
    scale_alpha_manual(name = "SST",
                            breaks = c("", "1", "2"),
                            labels = c("None", "1 Sprayer", "2 Sprayer"),
                            values=c(0.7,0.7,1))+
    scale_y_continuous(breaks=seq(50,200,30), limits = c(50,200), expand = expansion(mult = 0, add = 0))+
    scale_x_continuous(breaks=seq(100,400,100), limits = c(50,400), expand = expansion(mult = 0, add = 0))+
    theme(
        panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(colour = "grey", linetype = "dashed"),
        plot.margin = margin(t =0, r =0, b=0, l=0)
    )+
    theme(
        axis.title.y = element_text(vjust=2, size = 9),
        axis.title.x = element_text(vjust=0.3, size = 9),
        axis.text = element_text(size = 9),
        axis.line = element_line(size = 0.2, colour = "#CC3300", linetype =1),
        axis.ticks = element_line(size = 0.4, colour = "#CC3300"),
        axis.ticks.length = unit(0.15, "cm")
    )
PsenAn_162_time2
ggsave("PsenAn_Time.png")

###################Fuel Consumption
PsenAn_162_fuel1 <- senAn_162_fuel1 %>%
    ggplot(aes(x = landAv,
               y = fuelCons,
               colour = Technology))+
    geom_point(aes(alpha = numberSST,
                    shape = BA_Sprayer_Num), size = 3, show.legend = FALSE)+
    labs(x = "Farm size (in ha)",
         y = "Proportion of initial fuel consumption for each SST operation (in %)")+
    ggtitle("Scenario 1")+
    theme(plot.title = element_text(face="bold", size=11, hjust=0.5, colour = "#009933"))+
    scale_colour_manual(name = "Technology",
                        breaks = c("BA Sprayer", "SST6m", "SST27m"),
                        labels = c("BA Sprayer", "SST6m", "SST27m"),
                        values = c("#333333", "#006600", "#33FF00"))+
    scale_shape_manual(name = "BA Sprayer",
                        breaks = c("", "1"),
                        labels = c("No", "Yes"),
                        values=c(1,19))+
    scale_alpha_manual(name = "SST",
                            breaks = c("", "1", "2"),
                            labels = c("None", "1 Sprayer", "2 Sprayer"),
                            values=c(0.7,0.7,1))+
    scale_y_continuous(breaks=seq(50,200,30), limits = c(50,200), expand = expansion(mult = 0, add = 0))+
    scale_x_continuous(breaks=seq(100,400,100), limits = c(50,400), expand = expansion(mult = 0, add = 0))+
    theme(
        panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(colour = "grey", linetype = "dashed"),
        plot.margin = margin(t =0, r =0, b=0, l=0)
    )+
    theme(
        axis.title.y = element_text(vjust=2, size = 9),
        axis.title.x = element_text(vjust=0.3, size = 9),
        axis.text = element_text(size = 9),
        axis.line = element_line(size = 0.2, colour = "#CC3300", linetype =1),
        axis.ticks = element_line(size = 0.4, colour = "#CC3300"),
        axis.ticks.length = unit(0.15, "cm")
    )
PsenAn_162_fuel1

PsenAn_162_fuel2 <- senAn_162_fuel2 %>%
    ggplot(aes(x = landAv,
               y = fuelCons,
               colour = Technology))+
    geom_point(aes(alpha = numberSST,
                    shape = BA_Sprayer_Num), size = 3, show.legend = FALSE)+
    labs(x = "Farm size (in ha)",
         y = "Proportion of initial fuel consumption for each SST operation (in %)")+
    ggtitle("Scenario 2")+
    theme(plot.title = element_text(face="bold", size=11, hjust=0.5, colour = "#0099FF"))+
    scale_colour_manual(name = "Technology",
                        breaks = c("BA Sprayer", "SST6m", "SST27m"),
                        labels = c("BA Sprayer", "SST6m", "SST27m"),
                        values = c("#333333", "#000099", "#0099FF"))+
    scale_shape_manual(name = "BA Sprayer",
                        breaks = c("", "1"),
                        labels = c("No", "Yes"),
                        values=c(1,19))+
    scale_alpha_manual(name = "SST",
                            breaks = c("", "1", "2"),
                            labels = c("None", "1 Sprayer", "2 Sprayer"),
                            values=c(0.7,0.7,1))+
    scale_y_continuous(breaks=seq(50,200,30), limits = c(50,200), expand = expansion(mult = 0, add = 0))+
    scale_x_continuous(breaks=seq(100,400,100), limits = c(50,400), expand = expansion(mult = 0, add = 0))+
    theme(
        panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(colour = "grey", linetype = "dashed"),
        plot.margin = margin(t =0, r =0, b=0, l=0)
    )+
    theme(
        axis.title.y = element_text(vjust=2, size = 9),
        axis.title.x = element_text(vjust=0.3, size = 9),
        axis.text = element_text(size = 9),
        axis.line = element_line(size = 0.2, colour = "#CC3300", linetype =1),
        axis.ticks = element_line(size = 0.4, colour = "#CC3300"),
        axis.ticks.length = unit(0.15, "cm")
    )
PsenAn_162_fuel2

###################Repair
PsenAn_162_repair1 <- senAn_162_repair1 %>%
    ggplot(aes(x = landAv,
               y = repCosts,
               colour = Technology))+
    geom_point(aes(alpha = numberSST,
                    shape = BA_Sprayer_Num), size = 3, show.legend = FALSE)+
    labs(x = "Farm size (in ha)",
         y = "Proportion of initial repair costs for each SST (in %)")+
    scale_colour_manual(name = "Technology",
                        breaks = c("BA Sprayer", "SST6m", "SST27m"),
                        labels = c("BA Sprayer", "SST6m", "SST27m"),
                        values = c("#333333", "#006600", "#33FF00"))+
    scale_shape_manual(name = "BA Sprayer",
                        breaks = c("", "1"),
                        labels = c("No", "Yes"),
                        values=c(1,19))+
    scale_alpha_manual(name = "SST",
                            breaks = c("", "1", "2"),
                            labels = c("None", "1 Sprayer", "2 Sprayer"),
                            values=c(0.7,0.7,1))+
    scale_y_continuous(breaks=seq(50,200,30), limits = c(50,200), expand = expansion(mult = 0, add = 0))+
    scale_x_continuous(breaks=seq(100,400,100), limits = c(50,400), expand = expansion(mult = 0, add = 0))+
    theme(
        panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(colour = "grey", linetype = "dashed"),
        plot.margin = margin(t =0, r =0, b=0, l=0)
    )+
    theme(
        axis.title.y = element_text(vjust=2, size = 9),
        axis.title.x = element_text(vjust=0.3, size = 9),
        axis.text = element_text(size = 9),
        axis.line = element_line(size = 0.2, colour = "#CC3300", linetype =1),
        axis.ticks = element_line(size = 0.4, colour = "#CC3300"),
        axis.ticks.length = unit(0.15, "cm")
    )
PsenAn_162_repair1

PsenAn_162_repair2 <- senAn_162_repair2 %>%
    ggplot(aes(x = landAv,
               y = repCosts,
               colour = Technology))+
    geom_point(aes(alpha = numberSST,
                    shape = BA_Sprayer_Num), size = 3, show.legend = FALSE)+
    labs(x = "Farm size (in ha)",
         y = "Proportion of initial repair costs for each SST (in %)")+
    scale_colour_manual(name = "Technology",
                        breaks = c("BA Sprayer", "SST6m", "SST27m"),
                        labels = c("BA Sprayer", "SST6m", "SST27m"),
                        values = c("#333333", "#000099", "#0099FF"))+
    scale_shape_manual(name = "BA Sprayer",
                        breaks = c("", "1"),
                        labels = c("No", "Yes"),
                        values=c(1,19))+
    scale_alpha_manual(name = "SST",
                            breaks = c("", "1", "2"),
                            labels = c("None", "1 Sprayer", "2 Sprayer"),
                            values=c(0.7,0.7,1))+
    scale_y_continuous(breaks=seq(50,200,30), limits = c(50,200), expand = expansion(mult = 0, add = 0))+
    scale_x_continuous(breaks=seq(100,400,100), limits = c(50,400), expand = expansion(mult = 0, add = 0))+
    theme(
        panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(colour = "grey", linetype = "dashed"),
        plot.margin = margin(t =0, r =0, b=0, l=0)
    )+
    theme(
        axis.title.y = element_text(vjust=2, size = 9),
        axis.title.x = element_text(vjust=0.3, size = 9),
        axis.text = element_text(size = 9),
        axis.line = element_line(size = 0.2, colour = "#CC3300", linetype =1),
        axis.ticks = element_line(size = 0.4, colour = "#CC3300"),
        axis.ticks.length = unit(0.15, "cm")
    )
PsenAn_162_repair2


rm(senAn_162_teValue1)
rm(senAn_162_teValue2)
rm(senAn_162_algoCosts100_1)
rm(senAn_162_algoCosts100_2)
rm(senAn_162_algoCosts50_1)
rm(senAn_162_algoCosts50_2)
rm(senAn_162_annFee100_1)
rm(senAn_162_annFee100_2)
rm(senAn_162_annFee50_1)
rm(senAn_162_annFee50_2)
rm(senAn_162_PestEff1)
rm(senAn_162_PestEff2)
rm(senAn_162_time1)
rm(senAn_162_time2)
rm(senAn_162_fuel1)
rm(senAn_162_fuel2)
rm(senAn_162_repair1)
rm(senAn_162_repair2)


