getwd()
setwd("E:\\Studium\\Master of Science Agricultural and Food Economics\\04. Master Thesis\\8. GitHub\\Fruchtfolge Model\\model\\6.Report\\gdxFiles")
library(gamstransfer)
library(tidyverse)
library(scatterplot3d)

view(senAn_farm151)
glimpse(senAn_farm151)
view(senAn_farm151)
senAn_farm151[["value"]]
names(senAn151)

m151senAn = Container$new("ResultsSenAn3D_151.142.gdx")
senAn_farm151 <- m151senAn["summarySenAn3D"]$records
senAn_farm151$value <- replace(senAn_farm151$value, senAn_farm151$value > 0.99 & senAn_farm151$value < 1.01, 1)

senAn_151_landAv <- subset(senAn_farm151, allItems_1 == "landAv")
senAn_151_landUsed <- subset(senAn_farm151, allItems_1 == "landUsedAvg")
senAn_151_WW <- subset(senAn_farm151, allItems_1 == "Winterweizen")
senAn_151_WG <- subset(senAn_farm151, allItems_1 == "Wintergerste")
senAn_151_WR <- subset(senAn_farm151, allItems_1 == "Winterraps")
senAn_151_BA45kW <- subset(senAn_farm151, allItems_1 == "BA_45kW")
senAn_151_BA67kW <- subset(senAn_farm151, allItems_1 == "BA_67kW")
senAn_151_BA83kW <- subset(senAn_farm151, allItems_1 == "BA_83kW")
senAn_151_BA_102kW <- subset(senAn_farm151, allItems_1 == "BA_102kW")
senAn_151_BA_120kW <- subset(senAn_farm151, allItems_1 == "BA_120kW")
senAn_151_BA_200kW <- subset(senAn_farm151, allItems_1 == "BA_200kW")
senAn_151_BA_230kW <- subset(senAn_farm151, allItems_1 == "BA_230kW")
senAn_151_spot6m <- subset(senAn_farm151, allItems_1 == "spot6m")
senAn_151_spot27m <- subset(senAn_farm151, allItems_1 == "spot27m")
senAn_151_avgAnProf <- subset(senAn_farm151, allItems_1 == "avgAnnFarmProf")
senAn_151_diCostsPesti <- subset(senAn_farm151, allItems_1 == "diCostsPesti")
senAn_151_fuelCostsSprayer <- subset(senAn_farm151, allItems_1 == "fuelCostsSprayer")
senAn_151_repCostsSprayer <- subset(senAn_farm151, allItems_1 == "repCostsSprayer")
senAn_151_labCostsSprayer <- subset(senAn_farm151, allItems_1 == "labCostsSprayer")
senAn_151_deprecSprayer <- subset(senAn_farm151, allItems_1 == "deprecSprayer")
senAn_151_varCostsSprayer <- subset(senAn_farm151, allItems_1 == "varCostsSprayer")
senAn_151_fixCostsSprayer <- subset(senAn_farm151, allItems_1 == "fixCostsSprayer")

#smaller subsets for assignment of values to each sensitivity analysis
senAn_151_teValue <- subset(senAn_farm151, allItems_1 == "%SSTValue")
senAn_151_algoCosts <- subset(senAn_farm151, allItems_1 == "%algCosts")
senAn_151_annFee <- subset(senAn_farm151, allItems_1 == "%anFee")
senAn_151_pestPrice <- subset(senAn_farm151, allItems_1 == "%pestCosts")

#rename header of value
colnames(senAn_151_landAv)[6] <- "landAv"
colnames(senAn_151_landUsed)[6] <- "landUsedAvg"
colnames(senAn_151_WW)[6] <- "Winterweizen"
colnames(senAn_151_WG)[6] <- "Wintergerste"
colnames(senAn_151_WR)[6] <- "Winterraps"
colnames(senAn_151_BA45kW)[6] <- "BA_45kW"
colnames(senAn_151_BA67kW)[6] <- "BA_67kW"
colnames(senAn_151_BA83kW)[6] <- "BA_83kW"
colnames(senAn_151_BA_102kW)[6] <- "BA_102kW"
colnames(senAn_151_BA_120kW)[6] <- "BA_120kW"
colnames(senAn_151_BA_200kW)[6] <- "BA_200kW"
colnames(senAn_151_BA_230kW)[6] <- "BA_230kW"
colnames(senAn_151_spot6m)[6] <- "spot6m"
colnames(senAn_151_spot27m)[6] <- "spot27m"
colnames(senAn_151_avgAnProf)[6] <- "avgAnProf"
colnames(senAn_151_diCostsPesti)[6] <- "diCostsPesti"
colnames(senAn_151_fuelCostsSprayer)[6] <- "fuelCostsSprayer"
colnames(senAn_151_repCostsSprayer)[6] <- "repCostsSprayer"
colnames(senAn_151_labCostsSprayer)[6] <- "labCostsSprayer"
colnames(senAn_151_deprecSprayer)[6] <- "deprecSprayer"
colnames(senAn_151_varCostsSprayer)[6] <- "varCostsSprayer"
colnames(senAn_151_fixCostsSprayer)[6] <- "fixCostsSprayer"

colnames(senAn_151_teValue)[6] <- "SSTValue"
colnames(senAn_151_algoCosts)[6] <- "algCosts"
colnames(senAn_151_annFee)[6] <- "annFee"
colnames(senAn_151_pestPrice)[6] <- "pestPrice"

#delete allItems column
senAn_151_landAv$allItems_1 <- NULL
senAn_151_landUsed$allItems_1 <- NULL
senAn_151_WW$allItems_1 <- NULL
senAn_151_WG$allItems_1 <- NULL
senAn_151_WR$allItems_1 <- NULL
senAn_151_BA45kW$allItems_1 <- NULL
senAn_151_BA67kW$allItems_1 <- NULL
senAn_151_BA83kW$allItems_1 <- NULL
senAn_151_BA_102kW$allItems_1 <- NULL
senAn_151_BA_120kW$allItems_1 <- NULL
senAn_151_BA_200kW$allItems_1 <- NULL
senAn_151_BA_230kW$allItems_1 <- NULL
senAn_151_spot6m$allItems_1 <- NULL
senAn_151_spot27m$allItems_1 <- NULL
senAn_151_avgAnProf$allItems_1 <- NULL
senAn_151_diCostsPesti$allItems_1 <- NULL
senAn_151_fuelCostsSprayer$allItems_1 <- NULL
senAn_151_repCostsSprayer$allItems_1 <- NULL
senAn_151_labCostsSprayer$allItems_1 <- NULL
senAn_151_deprecSprayer$allItems_1 <- NULL
senAn_151_varCostsSprayer$allItems_1 <- NULL
senAn_151_fixCostsSprayer$allItems_1 <- NULL

senAn_151_teValue$allItems_1 <- NULL
senAn_151_algoCosts$allItems_1 <- NULL
senAn_151_annFee$allItems_1 <- NULL
senAn_151_pestPrice$allItems_1 <- NULL


senAn_151_Total <- senAn_151_teValue %>%
    left_join(senAn_151_landAv, by =c("uni_2","uni_3","uni_4","uni_5")) %>% 
    left_join(senAn_151_landUsed, by =c("uni_2","uni_3","uni_4","uni_5")) %>% 
    left_join(senAn_151_WW, by =c("uni_2","uni_3","uni_4","uni_5")) %>% 
    left_join(senAn_151_WG, by =c("uni_2","uni_3","uni_4","uni_5")) %>% 
    left_join(senAn_151_WR, by =c("uni_2","uni_3","uni_4","uni_5")) %>% 
    left_join(senAn_151_BA45kW, by =c("uni_2","uni_3","uni_4","uni_5")) %>% 
    left_join(senAn_151_BA67kW, by =c("uni_2","uni_3","uni_4","uni_5")) %>% 
    left_join(senAn_151_BA83kW, by =c("uni_2","uni_3","uni_4","uni_5")) %>% 
    left_join(senAn_151_BA_102kW, by =c("uni_2","uni_3","uni_4","uni_5")) %>% 
    left_join(senAn_151_BA_120kW, by =c("uni_2","uni_3","uni_4","uni_5")) %>%
    left_join(senAn_151_BA_200kW, by =c("uni_2","uni_3","uni_4","uni_5")) %>%
    left_join(senAn_151_BA_230kW, by =c("uni_2","uni_3","uni_4","uni_5")) %>%
    left_join(senAn_151_spot6m, by =c("uni_2","uni_3","uni_4","uni_5")) %>% 
    left_join(senAn_151_spot27m, by =c("uni_2","uni_3","uni_4","uni_5")) %>% 
    left_join(senAn_151_avgAnProf, by =c("uni_2","uni_3","uni_4","uni_5")) %>%
    left_join(senAn_151_diCostsPesti, by =c("uni_2","uni_3","uni_4","uni_5")) %>%
    left_join(senAn_151_fuelCostsSprayer, by =c("uni_2","uni_3","uni_4","uni_5")) %>%
    left_join(senAn_151_repCostsSprayer, by =c("uni_2","uni_3","uni_4","uni_5")) %>%
    left_join(senAn_151_labCostsSprayer, by =c("uni_2","uni_3","uni_4","uni_5")) %>%
    left_join(senAn_151_deprecSprayer, by =c("uni_2","uni_3","uni_4","uni_5")) %>%
    left_join(senAn_151_varCostsSprayer, by =c("uni_2","uni_3","uni_4","uni_5")) %>%
    left_join(senAn_151_fixCostsSprayer, by =c("uni_2","uni_3","uni_4","uni_5")) %>%
    left_join(senAn_151_algoCosts, by =c("uni_2","uni_3","uni_4","uni_5")) %>%
    left_join(senAn_151_annFee, by =c("uni_2","uni_3","uni_4","uni_5")) %>%
    left_join(senAn_151_pestPrice, by =c("uni_2","uni_3","uni_4","uni_5"))



senAn_151_teValuePestPrice <- senAn_151_Total[str_detect(senAn_151_Total$uni_3, "pestCostStep"), ]
senAn_151_teValueAnnFee <- senAn_151_Total[str_detect(senAn_151_Total$uni_3, "annFeeStep"), ]
senAn_151_teValueAlgoCosts <- senAn_151_Total[str_detect(senAn_151_Total$uni_3, "algoCostStep"), ]

#removal of subsets (not needed anymore)
rm(senAn_151_landAv)
rm(senAn_151_landUsed)
rm(senAn_151_WW)
rm(senAn_151_WG)
rm(senAn_151_WR)
rm(senAn_151_BA45kW)
rm(senAn_151_BA67kW)
rm(senAn_151_BA83kW)
rm(senAn_151_BA_102kW)
rm(senAn_151_BA_120kW)
rm(senAn_151_BA_200kW)
rm(senAn_151_BA_230kW)
rm(senAn_151_spot6m)
rm(senAn_151_spot27m)
rm(senAn_151_avgAnProf)
rm(senAn_151_diCostsPesti)
rm(senAn_151_fuelCostsSprayer)
rm(senAn_151_repCostsSprayer)
rm(senAn_151_labCostsSprayer)
rm(senAn_151_deprecSprayer)
rm(senAn_151_varCostsSprayer)
rm(senAn_151_fixCostsSprayer)
rm(senAn_151_pestPrice)
rm(senAn_151_annFee)
rm(senAn_151_algoCosts)
rm(senAn_151_teValue)

#####################################
#Column Preperation for Visualization
#####################################
###################SST Value & Pesticide price variation
senAn_151_teValuePestPrice$numberSST6m <- senAn_151_teValuePestPrice$spot6m
senAn_151_teValuePestPrice$numberSST27m <- senAn_151_teValuePestPrice$spot27m
senAn_151_teValuePestPrice$BA_45kWNum <- senAn_151_teValuePestPrice$BA_45kW
senAn_151_teValuePestPrice$BA_67kWNum <- senAn_151_teValuePestPrice$BA_67kW
senAn_151_teValuePestPrice$BA_83kWNum <- senAn_151_teValuePestPrice$BA_83kW
senAn_151_teValuePestPrice$BA_102kWNum <- senAn_151_teValuePestPrice$BA_102kW
senAn_151_teValuePestPrice$BA_120kWNum <- senAn_151_teValuePestPrice$BA_120kW
senAn_151_teValuePestPrice$BA_200kWNum <- senAn_151_teValuePestPrice$BA_200kW
senAn_151_teValuePestPrice$BA_230kWNum <- senAn_151_teValuePestPrice$BA_230kW
senAn_151_teValuePestPrice[is.na(senAn_151_teValuePestPrice)] <- ""
senAn_151_teValuePestPrice <- senAn_151_teValuePestPrice %>%
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
    mutate(spot6m = str_replace(spot6m,"2", "SST6m")) %>%
    mutate(spot27m = str_replace(spot27m,"1", "SST27m")) %>%
#combine columns of BA Sprayer and SST
    unite(BA_Sprayer, BA_45kW, BA_67kW, BA_83kW, BA_102kW, BA_120kW, BA_200kW, BA_230kW, sep ="") %>%
    unite(BA_SprayerNumeric, BA_45kWNum, BA_67kWNum, BA_83kWNum, BA_102kWNum, BA_120kWNum, BA_200kWNum, BA_230kWNum, sep="") %>%
    unite(numberSST, numberSST6m, numberSST27m, sep ="") %>%
    unite(Technology, spot6m, spot27m, sep ="") %>%
    mutate(numberSST = str_replace(numberSST,"11", "2")) %>%
    mutate(Technology = str_replace(Technology,"SST6mSST27m", "SST6m & SST27m"))
senAn_151_teValuePestPrice$Technology[senAn_151_teValuePestPrice$Technology==""] <- "BA Sprayer"
senAn_151_teValuePestPrice$BA_SprayerNumeric[senAn_151_teValuePestPrice$BA_SprayerNumeric=="1"] <- "2"
senAn_151_teValuePestPrice$BA_SprayerNumeric[senAn_151_teValuePestPrice$BA_SprayerNumeric==""] <- "1"
#Create new column where numeric values represent technology used for later visualization
senAn_151_teValuePestPrice$TechnologyNumeric <- senAn_151_teValuePestPrice$Technology
senAn_151_teValuePestPrice <- senAn_151_teValuePestPrice %>%
    mutate(TechnologyNumeric = str_replace(TechnologyNumeric, "BA Sprayer", "1")) %>%
    mutate(TechnologyNumeric = str_replace(TechnologyNumeric, "SST6m", "2")) %>%
    mutate(TechnologyNumeric = str_replace(TechnologyNumeric, "SST27m", "3")) %>%
    mutate(TechnologyNumeric = str_replace(TechnologyNumeric, "2 & 3", "4"))


###################SST Value & Annual Fee variation
senAn_151_teValueAnnFee$numberSST6m <- senAn_151_teValueAnnFee$spot6m
senAn_151_teValueAnnFee$numberSST27m <- senAn_151_teValueAnnFee$spot27m
senAn_151_teValueAnnFee$BA_45kWNum <- senAn_151_teValueAnnFee$BA_45kW
senAn_151_teValueAnnFee$BA_67kWNum <- senAn_151_teValueAnnFee$BA_67kW
senAn_151_teValueAnnFee$BA_83kWNum <- senAn_151_teValueAnnFee$BA_83kW
senAn_151_teValueAnnFee$BA_102kWNum <- senAn_151_teValueAnnFee$BA_102kW
senAn_151_teValueAnnFee$BA_120kWNum <- senAn_151_teValueAnnFee$BA_120kW
senAn_151_teValueAnnFee$BA_200kWNum <- senAn_151_teValueAnnFee$BA_200kW
senAn_151_teValueAnnFee$BA_230kWNum <- senAn_151_teValueAnnFee$BA_230kW
senAn_151_teValueAnnFee[is.na(senAn_151_teValueAnnFee)] <- ""
senAn_151_teValueAnnFee <- senAn_151_teValueAnnFee %>%
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
    mutate(spot6m = str_replace(spot6m,"2", "SST6m")) %>%
    mutate(spot27m = str_replace(spot27m,"1", "SST27m")) %>%
#combine columns of BA Sprayer and SST
    unite(BA_Sprayer, BA_45kW, BA_67kW, BA_83kW, BA_102kW, BA_120kW, BA_200kW, BA_230kW, sep ="") %>%
    unite(BA_SprayerNumeric, BA_45kWNum, BA_67kWNum, BA_83kWNum, BA_102kWNum, BA_120kWNum, BA_200kWNum, BA_230kWNum, sep="") %>%
    unite(numberSST, numberSST6m, numberSST27m, sep ="") %>%
    unite(Technology, spot6m, spot27m, sep ="") %>%
    mutate(numberSST = str_replace(numberSST,"11", "2")) %>%
    mutate(Technology = str_replace(Technology,"SST6mSST27m", "SST6m & SST27m"))
senAn_151_teValueAnnFee$Technology[senAn_151_teValueAnnFee$Technology==""] <- "BA Sprayer"
senAn_151_teValueAnnFee$BA_SprayerNumeric[senAn_151_teValueAnnFee$BA_SprayerNumeric=="1"] <- "2"
senAn_151_teValueAnnFee$BA_SprayerNumeric[senAn_151_teValueAnnFee$BA_SprayerNumeric==""] <- "1"
senAn_151_teValueAnnFee$annFee[senAn_151_teValueAnnFee$annFee==""] <- "0"
#Create new column where numeric values represent technology used for later visualization
senAn_151_teValueAnnFee$TechnologyNumeric <- senAn_151_teValueAnnFee$Technology
senAn_151_teValueAnnFee <- senAn_151_teValueAnnFee %>%
    mutate(TechnologyNumeric = str_replace(TechnologyNumeric, "BA Sprayer", "1")) %>%
    mutate(TechnologyNumeric = str_replace(TechnologyNumeric, "SST6m", "2")) %>%
    mutate(TechnologyNumeric = str_replace(TechnologyNumeric, "SST27m", "3")) %>%
    mutate(TechnologyNumeric = str_replace(TechnologyNumeric, "2 & 3", "4"))


###################SST Value & Algorithm costs variation
senAn_151_teValueAlgoCosts$numberSST6m <- senAn_151_teValueAlgoCosts$spot6m
senAn_151_teValueAlgoCosts$numberSST27m <- senAn_151_teValueAlgoCosts$spot27m
senAn_151_teValueAlgoCosts$BA_45kWNum <- senAn_151_teValueAlgoCosts$BA_45kW
senAn_151_teValueAlgoCosts$BA_67kWNum <- senAn_151_teValueAlgoCosts$BA_67kW
senAn_151_teValueAlgoCosts$BA_83kWNum <- senAn_151_teValueAlgoCosts$BA_83kW
senAn_151_teValueAlgoCosts$BA_102kWNum <- senAn_151_teValueAlgoCosts$BA_102kW
senAn_151_teValueAlgoCosts$BA_120kWNum <- senAn_151_teValueAlgoCosts$BA_120kW
senAn_151_teValueAlgoCosts$BA_200kWNum <- senAn_151_teValueAlgoCosts$BA_200kW
senAn_151_teValueAlgoCosts$BA_230kWNum <- senAn_151_teValueAlgoCosts$BA_230kW
senAn_151_teValueAlgoCosts[is.na(senAn_151_teValueAlgoCosts)] <- ""
senAn_151_teValueAlgoCosts <- senAn_151_teValueAlgoCosts %>%
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
    mutate(spot6m = str_replace(spot6m,"2", "SST6m")) %>%
    mutate(spot27m = str_replace(spot27m,"1", "SST27m")) %>%
#combine columns of BA Sprayer and SST
    unite(BA_Sprayer, BA_45kW, BA_67kW, BA_83kW, BA_102kW, BA_120kW, BA_200kW, BA_230kW, sep ="") %>%
    unite(BA_SprayerNumeric, BA_45kWNum, BA_67kWNum, BA_83kWNum, BA_102kWNum, BA_120kWNum, BA_200kWNum, BA_230kWNum, sep="") %>%
    unite(numberSST, numberSST6m, numberSST27m, sep ="") %>%
    unite(Technology, spot6m, spot27m, sep ="") %>%
    mutate(numberSST = str_replace(numberSST,"11", "2")) %>%
    mutate(Technology = str_replace(Technology,"SST6mSST27m", "SST6m & SST27m"))
senAn_151_teValueAlgoCosts$Technology[senAn_151_teValueAlgoCosts$Technology==""] <- "BA Sprayer"
senAn_151_teValueAlgoCosts$BA_SprayerNumeric[senAn_151_teValueAlgoCosts$BA_SprayerNumeric=="1"] <- "2"
senAn_151_teValueAlgoCosts$BA_SprayerNumeric[senAn_151_teValueAlgoCosts$BA_SprayerNumeric==""] <- "1"
senAn_151_teValueAlgoCosts$algCosts[senAn_151_teValueAlgoCosts$algCosts==""] <- "0"
#Create new column where numeric values represent technology used for later visualization
senAn_151_teValueAlgoCosts$TechnologyNumeric <- senAn_151_teValueAlgoCosts$Technology
senAn_151_teValueAlgoCosts <- senAn_151_teValueAlgoCosts %>%
    mutate(TechnologyNumeric = str_replace(TechnologyNumeric, "BA Sprayer", "1")) %>%
    mutate(TechnologyNumeric = str_replace(TechnologyNumeric, "SST6m", "2")) %>%
    mutate(TechnologyNumeric = str_replace(TechnologyNumeric, "SST27m", "3")) %>%
    mutate(TechnologyNumeric = str_replace(TechnologyNumeric, "2 & 3", "4"))


#Only for table creation!!!
#senAn_151_teValueAnnFee$landUsedAvg <- NULL
#senAn_151_teValueAnnFee$Winterweizen <- NULL
#senAn_151_teValueAnnFee$Wintergerste <- NULL
#senAn_151_teValueAnnFee$Winterraps <- NULL
#senAn_151_teValueAnnFee$BA_Sprayer <- NULL
#senAn_151_teValueAnnFee$avgAnProf <- NULL
#senAn_151_teValueAnnFee$diCostsPesti <- NULL
#senAn_151_teValueAnnFee$fuelCostsSprayer <- NULL
#senAn_151_teValueAnnFee$repCostsSprayer <- NULL
#senAn_151_teValueAnnFee$labCostsSprayer <- NULL
#senAn_151_teValueAnnFee$deprecSprayer <- NULL
#senAn_151_teValueAnnFee$varCostsSprayer <- NULL
#senAn_151_teValueAnnFee$fixCostsSprayer <- NULL
#senAn_151_teValueAnnFee$algCosts <- NULL

#senAn_151_teValueAlgoCosts$landUsedAvg <- NULL
#senAn_151_teValueAlgoCosts$Winterweizen <- NULL
#senAn_151_teValueAlgoCosts$Wintergerste <- NULL
#senAn_151_teValueAlgoCosts$Winterraps <- NULL
#senAn_151_teValueAlgoCosts$BA_Sprayer <- NULL
#senAn_151_teValueAlgoCosts$avgAnProf <- NULL
#senAn_151_teValueAlgoCosts$diCostsPesti <- NULL
#senAn_151_teValueAlgoCosts$fuelCostsSprayer <- NULL
#senAn_151_teValueAlgoCosts$repCostsSprayer <- NULL
#senAn_151_teValueAlgoCosts$labCostsSprayer <- NULL
#senAn_151_teValueAlgoCosts$deprecSprayer <- NULL
#senAn_151_teValueAlgoCosts$varCostsSprayer <- NULL
#senAn_151_teValueAlgoCosts$fixCostsSprayer <- NULL
#senAn_151_teValueAlgoCosts$annFee <- NULL
#senAn_151_teValueAlgoCosts$pestPrice <- NULL

#senAn_151_teValuePestPrice$Winterweizen <- NULL
#senAn_151_teValuePestPrice$Wintergerste <- NULL
#senAn_151_teValuePestPrice$Winterraps <- NULL
#senAn_151_teValuePestPrice$BA_Sprayer <- NULL
#senAn_151_teValuePestPrice$avgAnProf <- NULL
#senAn_151_teValuePestPrice$diCostsPesti <- NULL
#senAn_151_teValuePestPrice$fuelCostsSprayer <- NULL
#senAn_151_teValuePestPrice$repCostsSprayer <- NULL
#senAn_151_teValuePestPrice$labCostsSprayer <- NULL
#senAn_151_teValuePestPrice$deprecSprayer <- NULL
#senAn_151_teValuePestPrice$varCostsSprayer <- NULL
#senAn_151_teValuePestPrice$fixCostsSprayer <- NULL
#senAn_151_teValuePestPrice$algCosts <- NULL
#senAn_151_teValuePestPrice$annFee <- NULL


#Create subsets for each scenario and remove dataset including both subsets
senAn_151_teValuePestPrice1 <- subset(senAn_151_teValuePestPrice, uni_5 == "Base|FH")
senAn_151_teValuePestPrice2 <- subset(senAn_151_teValuePestPrice, uni_5 == "Base|FHBonus")
rm(senAn_151_teValuePestPrice)

senAn_151_teValueAnnFee1 <- subset(senAn_151_teValueAnnFee, uni_5 == "Base|FH")
senAn_151_teValueAnnFee2 <- subset(senAn_151_teValueAnnFee, uni_5 == "Base|FHBonus")
rm(senAn_151_teValueAnnFee)

senAn_151_teValueAlgoCosts1 <- subset(senAn_151_teValueAlgoCosts, uni_5 == "Base|FH")
senAn_151_teValueAlgoCosts2 <- subset(senAn_151_teValueAlgoCosts, uni_5 == "Base|FHBonus")
rm(senAn_151_teValueAlgoCosts)

###################
#DATA VISUALIZATION
###################
############################
# 3 dimensions visualization
############################
#Assignment of color and shape values to each result
colors1 <- c("#333333", "#006600", "#33FF00","#666600")
shapes1 <- c(1,19)
colors2 <- c("#333333", "#000099", "#0099FF","#6600FF")
shapes2 <- c(1,19)

colors1teValuePestPrice_151 <- colors1[as.numeric(senAn_151_teValuePestPrice1$TechnologyNumeric)]
shapes1teValuePestPrice_151 <- shapes1[as.numeric(senAn_151_teValuePestPrice1$BA_SprayerNumeric)]
colors2teValuePestPrice_151 <- colors2[as.numeric(senAn_151_teValuePestPrice2$TechnologyNumeric)]
shapes2teValuePestPrice_151 <- shapes2[as.numeric(senAn_151_teValuePestPrice2$BA_SprayerNumeric)]

colors1teValueAnnFee_151 <- colors1[as.numeric(senAn_151_teValueAnnFee1$TechnologyNumeric)]
shapes1teValueAnnFee_151 <- shapes1[as.numeric(senAn_151_teValueAnnFee1$BA_SprayerNumeric)]
shapes2teValueAnnFee_151 <- shapes2[as.numeric(senAn_151_teValueAnnFee2$BA_SprayerNumeric)]
colors2teValueAnnFee_151 <- colors2[as.numeric(senAn_151_teValueAnnFee2$TechnologyNumeric)]

colors1teValueAlgoCosts_151 <- colors1[as.numeric(senAn_151_teValueAlgoCosts1$TechnologyNumeric)]
shapes1teValueAlgoCosts_151 <- shapes1[as.numeric(senAn_151_teValueAlgoCosts1$BA_SprayerNumeric)]
shapes2teValueAlgoCosts_151 <- shapes2[as.numeric(senAn_151_teValueAlgoCosts2$BA_SprayerNumeric)]
colors2teValueAlgoCosts_151 <- colors2[as.numeric(senAn_151_teValueAlgoCosts2$TechnologyNumeric)]

rm(shapes1)
rm(shapes2)
rm(colors1)
rm(colors2)