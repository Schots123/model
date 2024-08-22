getwd()
setwd("E:\\Studium\\Master of Science Agricultural and Food Economics\\04. Master Thesis\\8. GitHub\\Fruchtfolge Model\\model\\6.Report\\gdxFiles")
library(gamstransfer)
library(tidyverse)
library(scatterplot3d)
?scatterplot3d

view(senAn_farm162)
glimpse(senAn_farm162)
view(senAn_farm162)
senAn_farm162[["value"]]
names(senAn162)

m162senAn = Container$new("ResultsSenAn3D_162.141.gdx")
senAn_farm162 <- m162senAn["summarySenAn3D"]$records
senAn_farm162$value <- replace(senAn_farm162$value, senAn_farm162$value > 0.99 & senAn_farm162$value < 1.01, 1)

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
senAn_162_teValue <- subset(senAn_farm162, allItems_1 == "%SSTValue")
senAn_162_algoCosts <- subset(senAn_farm162, allItems_1 == "%algCosts")
senAn_162_annFee <- subset(senAn_farm162, allItems_1 == "%anFee")
senAn_162_pestPrice <- subset(senAn_farm162, allItems_1 == "%pestCosts")

#rename header of value
colnames(senAn_162_landAv)[6] <- "landAv"
colnames(senAn_162_landUsed)[6] <- "landUsedAvg"
colnames(senAn_162_WW)[6] <- "Winterweizen"
colnames(senAn_162_WG)[6] <- "Wintergerste"
colnames(senAn_162_SB)[6] <- "Zuckerrueben"
colnames(senAn_162_BA45kW)[6] <- "BA_45kW"
colnames(senAn_162_BA67kW)[6] <- "BA_67kW"
colnames(senAn_162_BA83kW)[6] <- "BA_83kW"
colnames(senAn_162_BA_102kW)[6] <- "BA_102kW"
colnames(senAn_162_BA_120kW)[6] <- "BA_120kW"
colnames(senAn_162_BA_200kW)[6] <- "BA_200kW"
colnames(senAn_162_BA_230kW)[6] <- "BA_230kW"
colnames(senAn_162_spot6m)[6] <- "spot6m"
colnames(senAn_162_spot27m)[6] <- "spot27m"
colnames(senAn_162_avgAnProf)[6] <- "avgAnProf"
colnames(senAn_162_diCostsPesti)[6] <- "diCostsPesti"
colnames(senAn_162_fuelCostsSprayer)[6] <- "fuelCostsSprayer"
colnames(senAn_162_repCostsSprayer)[6] <- "repCostsSprayer"
colnames(senAn_162_labCostsSprayer)[6] <- "labCostsSprayer"
colnames(senAn_162_deprecSprayer)[6] <- "deprecSprayer"
colnames(senAn_162_varCostsSprayer)[6] <- "varCostsSprayer"
colnames(senAn_162_fixCostsSprayer)[6] <- "fixCostsSprayer"

colnames(senAn_162_teValue)[6] <- "SSTValue"
colnames(senAn_162_algoCosts)[6] <- "algCosts"
colnames(senAn_162_annFee)[6] <- "annFee"
colnames(senAn_162_pestPrice)[6] <- "pestPrice"

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

senAn_162_teValue$allItems_1 <- NULL
senAn_162_algoCosts$allItems_1 <- NULL
senAn_162_annFee$allItems_1 <- NULL
senAn_162_pestPrice$allItems_1 <- NULL

#create new combined dataframes for each sensitivity analysis seperately 
senAn_162_Total <- senAn_162_teValue %>% 
    left_join(senAn_162_landAv, by =c("uni_2","uni_3","uni_4","uni_5")) %>% 
    left_join(senAn_162_landUsed, by =c("uni_2","uni_3","uni_4","uni_5")) %>% 
    left_join(senAn_162_WW, by =c("uni_2","uni_3","uni_4","uni_5")) %>% 
    left_join(senAn_162_WG, by =c("uni_2","uni_3","uni_4","uni_5")) %>% 
    left_join(senAn_162_SB, by =c("uni_2","uni_3","uni_4","uni_5")) %>% 
    left_join(senAn_162_BA45kW, by =c("uni_2","uni_3","uni_4","uni_5")) %>% 
    left_join(senAn_162_BA67kW, by =c("uni_2","uni_3","uni_4","uni_5")) %>% 
    left_join(senAn_162_BA83kW, by =c("uni_2","uni_3","uni_4","uni_5")) %>% 
    left_join(senAn_162_BA_102kW, by =c("uni_2","uni_3","uni_4","uni_5")) %>% 
    left_join(senAn_162_BA_120kW, by =c("uni_2","uni_3","uni_4","uni_5")) %>%
    left_join(senAn_162_BA_200kW, by =c("uni_2","uni_3","uni_4","uni_5")) %>%
    left_join(senAn_162_BA_230kW, by =c("uni_2","uni_3","uni_4","uni_5")) %>%
    left_join(senAn_162_spot6m, by =c("uni_2","uni_3","uni_4","uni_5")) %>% 
    left_join(senAn_162_spot27m, by =c("uni_2","uni_3","uni_4","uni_5")) %>% 
    left_join(senAn_162_avgAnProf, by =c("uni_2","uni_3","uni_4","uni_5")) %>%
    left_join(senAn_162_diCostsPesti, by =c("uni_2","uni_3","uni_4","uni_5")) %>%
    left_join(senAn_162_fuelCostsSprayer, by =c("uni_2","uni_3","uni_4","uni_5")) %>%
    left_join(senAn_162_repCostsSprayer, by =c("uni_2","uni_3","uni_4","uni_5")) %>%
    left_join(senAn_162_labCostsSprayer, by =c("uni_2","uni_3","uni_4","uni_5")) %>%
    left_join(senAn_162_deprecSprayer, by =c("uni_2","uni_3","uni_4","uni_5")) %>%
    left_join(senAn_162_varCostsSprayer, by =c("uni_2","uni_3","uni_4","uni_5")) %>%
    left_join(senAn_162_fixCostsSprayer, by =c("uni_2","uni_3","uni_4","uni_5")) %>%
    left_join(senAn_162_algoCosts, by =c("uni_2","uni_3","uni_4","uni_5")) %>%
    left_join(senAn_162_annFee, by =c("uni_2","uni_3","uni_4","uni_5")) %>%
    left_join(senAn_162_pestPrice, by =c("uni_2","uni_3","uni_4","uni_5"))



senAn_162_teValuePestPrice <- senAn_162_Total[str_detect(senAn_162_Total$uni_3, "pestCostStep"), ]
senAn_162_teValueAnnFee <- senAn_162_Total[str_detect(senAn_162_Total$uni_3, "annFeeStep"), ]
senAn_162_teValueAlgoCosts <- senAn_162_Total[str_detect(senAn_162_Total$uni_3, "algoCostStep"), ]
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
rm(senAn_162_pestPrice)
rm(senAn_162_annFee)
rm(senAn_162_algoCosts)
rm(senAn_162_teValue)

#####################################
#Column Preperation for Visualization
#####################################
###################SST Value & Pesticide price variation
senAn_162_teValuePestPrice$numberSST6m <- senAn_162_teValuePestPrice$spot6m
senAn_162_teValuePestPrice$numberSST27m <- senAn_162_teValuePestPrice$spot27m
senAn_162_teValuePestPrice$BA_45kWNum <- senAn_162_teValuePestPrice$BA_45kW
senAn_162_teValuePestPrice$BA_67kWNum <- senAn_162_teValuePestPrice$BA_67kW
senAn_162_teValuePestPrice$BA_83kWNum <- senAn_162_teValuePestPrice$BA_83kW
senAn_162_teValuePestPrice$BA_102kWNum <- senAn_162_teValuePestPrice$BA_102kW
senAn_162_teValuePestPrice$BA_120kWNum <- senAn_162_teValuePestPrice$BA_120kW
senAn_162_teValuePestPrice$BA_200kWNum <- senAn_162_teValuePestPrice$BA_200kW
senAn_162_teValuePestPrice$BA_230kWNum <- senAn_162_teValuePestPrice$BA_230kW
senAn_162_teValuePestPrice[is.na(senAn_162_teValuePestPrice)] <- ""
senAn_162_teValuePestPrice <- senAn_162_teValuePestPrice %>%
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
senAn_162_teValuePestPrice$Technology[senAn_162_teValuePestPrice$Technology==""] <- "BA Sprayer"
senAn_162_teValuePestPrice$BA_SprayerNumeric[senAn_162_teValuePestPrice$BA_SprayerNumeric=="1"] <- "2"
senAn_162_teValuePestPrice$BA_SprayerNumeric[senAn_162_teValuePestPrice$BA_SprayerNumeric==""] <- "1"
senAn_162_teValueAnnFee$annFee[senAn_162_teValueAnnFee$annFee==""] <- "0"
#Create new column where numeric values represent technology used for later visualization
senAn_162_teValuePestPrice$TechnologyNumeric <- senAn_162_teValuePestPrice$Technology
senAn_162_teValuePestPrice <- senAn_162_teValuePestPrice %>%
    mutate(TechnologyNumeric = str_replace(TechnologyNumeric, "BA Sprayer", "1")) %>%
    mutate(TechnologyNumeric = str_replace(TechnologyNumeric, "SST6m", "2")) %>%
    mutate(TechnologyNumeric = str_replace(TechnologyNumeric, "SST27m", "3")) %>%
    mutate(TechnologyNumeric = str_replace(TechnologyNumeric, "2 & 3", "4"))


###################SST Value & Annual Fee variation
senAn_162_teValueAnnFee$numberSST6m <- senAn_162_teValueAnnFee$spot6m
senAn_162_teValueAnnFee$numberSST27m <- senAn_162_teValueAnnFee$spot27m
senAn_162_teValueAnnFee$BA_45kWNum <- senAn_162_teValueAnnFee$BA_45kW
senAn_162_teValueAnnFee$BA_67kWNum <- senAn_162_teValueAnnFee$BA_67kW
senAn_162_teValueAnnFee$BA_83kWNum <- senAn_162_teValueAnnFee$BA_83kW
senAn_162_teValueAnnFee$BA_102kWNum <- senAn_162_teValueAnnFee$BA_102kW
senAn_162_teValueAnnFee$BA_120kWNum <- senAn_162_teValueAnnFee$BA_120kW
senAn_162_teValueAnnFee$BA_200kWNum <- senAn_162_teValueAnnFee$BA_200kW
senAn_162_teValueAnnFee$BA_230kWNum <- senAn_162_teValueAnnFee$BA_230kW
senAn_162_teValueAnnFee[is.na(senAn_162_teValueAnnFee)] <- ""
senAn_162_teValueAnnFee <- senAn_162_teValueAnnFee %>%
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
senAn_162_teValueAnnFee$Technology[senAn_162_teValueAnnFee$Technology==""] <- "BA Sprayer"
senAn_162_teValueAnnFee$BA_SprayerNumeric[senAn_162_teValueAnnFee$BA_SprayerNumeric=="1"] <- "2"
senAn_162_teValueAnnFee$BA_SprayerNumeric[senAn_162_teValueAnnFee$BA_SprayerNumeric==""] <- "1"
senAn_162_teValueAnnFee$annFee[senAn_162_teValueAnnFee$annFee==""] <- "0"
#Create new column where numeric values represent technology used for later visualization
senAn_162_teValueAnnFee$TechnologyNumeric <- senAn_162_teValueAnnFee$Technology
senAn_162_teValueAnnFee <- senAn_162_teValueAnnFee %>%
    mutate(TechnologyNumeric = str_replace(TechnologyNumeric, "BA Sprayer", "1")) %>%
    mutate(TechnologyNumeric = str_replace(TechnologyNumeric, "SST6m", "2")) %>%
    mutate(TechnologyNumeric = str_replace(TechnologyNumeric, "SST27m", "3")) %>%
    mutate(TechnologyNumeric = str_replace(TechnologyNumeric, "2 & 3", "4"))

###################SST Value & Algorithm costs variation
senAn_162_teValueAlgoCosts$numberSST6m <- senAn_162_teValueAlgoCosts$spot6m
senAn_162_teValueAlgoCosts$numberSST27m <- senAn_162_teValueAlgoCosts$spot27m
senAn_162_teValueAlgoCosts$BA_45kWNum <- senAn_162_teValueAlgoCosts$BA_45kW
senAn_162_teValueAlgoCosts$BA_67kWNum <- senAn_162_teValueAlgoCosts$BA_67kW
senAn_162_teValueAlgoCosts$BA_83kWNum <- senAn_162_teValueAlgoCosts$BA_83kW
senAn_162_teValueAlgoCosts$BA_102kWNum <- senAn_162_teValueAlgoCosts$BA_102kW
senAn_162_teValueAlgoCosts$BA_120kWNum <- senAn_162_teValueAlgoCosts$BA_120kW
senAn_162_teValueAlgoCosts$BA_200kWNum <- senAn_162_teValueAlgoCosts$BA_200kW
senAn_162_teValueAlgoCosts$BA_230kWNum <- senAn_162_teValueAlgoCosts$BA_230kW
senAn_162_teValueAlgoCosts[is.na(senAn_162_teValueAlgoCosts)] <- ""
senAn_162_teValueAlgoCosts <- senAn_162_teValueAlgoCosts %>%
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
senAn_162_teValueAlgoCosts$Technology[senAn_162_teValueAlgoCosts$Technology==""] <- "BA Sprayer"
senAn_162_teValueAlgoCosts$BA_SprayerNumeric[senAn_162_teValueAlgoCosts$BA_SprayerNumeric=="1"] <- "2"
senAn_162_teValueAlgoCosts$BA_SprayerNumeric[senAn_162_teValueAlgoCosts$BA_SprayerNumeric==""] <- "1"
senAn_162_teValueAlgoCosts$algCosts[senAn_162_teValueAlgoCosts$algCosts==""] <- "0"
#Create new column where numeric values represent technology used for later visualization
senAn_162_teValueAlgoCosts$TechnologyNumeric <- senAn_162_teValueAlgoCosts$Technology
senAn_162_teValueAlgoCosts <- senAn_162_teValueAlgoCosts %>%
    mutate(TechnologyNumeric = str_replace(TechnologyNumeric, "BA Sprayer", "1")) %>%
    mutate(TechnologyNumeric = str_replace(TechnologyNumeric, "SST6m", "2")) %>%
    mutate(TechnologyNumeric = str_replace(TechnologyNumeric, "SST27m", "3")) %>%
    mutate(TechnologyNumeric = str_replace(TechnologyNumeric, "2 & 3", "4"))



#######Only for table creation!!!
#senAn_162_teValueAnnFee$landUsedAvg <- NULL
#senAn_162_teValueAnnFee$Winterweizen <- NULL
#senAn_162_teValueAnnFee$Wintergerste <- NULL
#senAn_162_teValueAnnFee$Zuckerrueben <- NULL
#senAn_162_teValueAnnFee$BA_Sprayer <- NULL
#senAn_162_teValueAnnFee$avgAnProf <- NULL
#senAn_162_teValueAnnFee$diCostsPesti <- NULL
#senAn_162_teValueAnnFee$fuelCostsSprayer <- NULL
#senAn_162_teValueAnnFee$repCostsSprayer <- NULL
#senAn_162_teValueAnnFee$labCostsSprayer <- NULL
#senAn_162_teValueAnnFee$deprecSprayer <- NULL
#senAn_162_teValueAnnFee$varCostsSprayer <- NULL
#senAn_162_teValueAnnFee$fixCostsSprayer <- NULL
#senAn_162_teValueAnnFee$algCosts <- NULL
#view(senAn_162_teValueAnnFee)

#senAn_162_teValueAlgoCosts$landUsedAvg <- NULL
#senAn_162_teValueAlgoCosts$Winterweizen <- NULL
#senAn_162_teValueAlgoCosts$Wintergerste <- NULL
#senAn_162_teValueAlgoCosts$Zuckerrueben <- NULL
#senAn_162_teValueAlgoCosts$BA_Sprayer <- NULL
#senAn_162_teValueAlgoCosts$avgAnProf <- NULL
#senAn_162_teValueAlgoCosts$diCostsPesti <- NULL
#senAn_162_teValueAlgoCosts$fuelCostsSprayer <- NULL
#senAn_162_teValueAlgoCosts$repCostsSprayer <- NULL
#senAn_162_teValueAlgoCosts$labCostsSprayer <- NULL
#senAn_162_teValueAlgoCosts$deprecSprayer <- NULL
#senAn_162_teValueAlgoCosts$varCostsSprayer <- NULL
#senAn_162_teValueAlgoCosts$fixCostsSprayer <- NULL
#senAn_162_teValueAlgoCosts$annFee <- NULL
#view(senAn_162_teValueAlgoCosts)

#senAn_162_teValuePestPrice$BA_Sprayer <- NULL
#senAn_162_teValuePestPrice$avgAnProf <- NULL
#senAn_162_teValuePestPrice$diCostsPesti <- NULL
#senAn_162_teValuePestPrice$fuelCostsSprayer <- NULL
#senAn_162_teValuePestPrice$repCostsSprayer <- NULL
#senAn_162_teValuePestPrice$labCostsSprayer <- NULL
#senAn_162_teValuePestPrice$deprecSprayer <- NULL
#senAn_162_teValuePestPrice$varCostsSprayer <- NULL
#senAn_162_teValuePestPrice$fixCostsSprayer <- NULL
#senAn_162_teValuePestPrice$annFee <- NULL
#senAn_162_teValuePestPrice$algCosts <- NULL


#Create subsets for each scenario and remove dataset including both subsets
senAn_162_teValuePestPrice1 <- subset(senAn_162_teValuePestPrice, uni_5 == "Base|FH")
senAn_162_teValuePestPrice2 <- subset(senAn_162_teValuePestPrice, uni_5 == "Base|FHBonus")
rm(senAn_162_teValuePestPrice)

senAn_162_teValueAnnFee1 <- subset(senAn_162_teValueAnnFee, uni_5 == "Base|FH")
senAn_162_teValueAnnFee2 <- subset(senAn_162_teValueAnnFee, uni_5 == "Base|FHBonus")
rm(senAn_162_teValueAnnFee)

senAn_162_teValueAlgoCosts1 <- subset(senAn_162_teValueAlgoCosts, uni_5 == "Base|FH")
senAn_162_teValueAlgoCosts2 <- subset(senAn_162_teValueAlgoCosts, uni_5 == "Base|FHBonus")
rm(senAn_162_teValueAlgoCosts)
view(senAn_162_teValuePestPrice1)
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

colors1teValuePestPrice_162 <- colors1[as.numeric(senAn_162_teValuePestPrice1$TechnologyNumeric)]
shapes1teValuePestPrice_162 <- shapes1[as.numeric(senAn_162_teValuePestPrice1$BA_SprayerNumeric)]
colors2teValuePestPrice_162 <- colors2[as.numeric(senAn_162_teValuePestPrice2$TechnologyNumeric)]
shapes2teValuePestPrice_162 <- shapes2[as.numeric(senAn_162_teValuePestPrice2$BA_SprayerNumeric)]

colors1teValueAnnFee_162 <- colors1[as.numeric(senAn_162_teValueAnnFee1$TechnologyNumeric)]
shapes1teValueAnnFee_162 <- shapes1[as.numeric(senAn_162_teValueAnnFee1$BA_SprayerNumeric)]
shapes2teValueAnnFee_162 <- shapes2[as.numeric(senAn_162_teValueAnnFee2$BA_SprayerNumeric)]
colors2teValueAnnFee_162 <- colors2[as.numeric(senAn_162_teValueAnnFee2$TechnologyNumeric)]

colors1teValueAlgoCosts_162 <- colors1[as.numeric(senAn_162_teValueAlgoCosts1$TechnologyNumeric)]
shapes1teValueAlgoCosts_162 <- shapes1[as.numeric(senAn_162_teValueAlgoCosts1$BA_SprayerNumeric)]
shapes2teValueAlgoCosts_162 <- shapes2[as.numeric(senAn_162_teValueAlgoCosts2$BA_SprayerNumeric)]
colors2teValueAlgoCosts_162 <- colors2[as.numeric(senAn_162_teValueAlgoCosts2$TechnologyNumeric)]
rm(shapes1)
rm(shapes2)
rm(colors1)
rm(colors2)

view(senAn_162_teValuePestPrice1)
###Visualization
layout(matrix(c(1,2,3,4,5,6), nrow = 2, ncol = 3))
PsenAn_162_teValuePestPrice1 <- scatterplot3d(senAn_162_teValuePestPrice1$SSTValue, senAn_162_teValuePestPrice1$pestPrice,
    main = "\nRoot crop farm",
    col.main = "#CC3300",
    angle = 78,
    xlab = "",
    ylab = "Pesticide costs (%)",
    zlab = "",
    scale.y = 1.25,
    axis = TRUE,
    tick.marks = TRUE,
    label.tick.marks = TRUE,
    xlim = c(50,150),
    ylim = c(100,400),
    zlim = c(50,400),
    lab = c(4,4),
    lab.z = c(5),
    cex.axis = 0.9,
    y.axis.offset = 0.3,
    col.axis = "#CC3300",
    col.lab = "#000000",
    pch = shapes1teValuePestPrice_162,
    #type ="h",
    color = colors1teValuePestPrice_162,
    #grid = FALSE,
    box = FALSE)
PsenAn_162_teValuePestPrice2 <- scatterplot3d(senAn_162_teValuePestPrice2$SSTValue, senAn_162_teValuePestPrice2$pestPrice, senAn_162_teValuePestPrice2$landAv,
    main = "\nRoot crop farm",
    col.main = "#CC3300", 
    angle = 78,
    xlab = "",
    ylab = "Pesticide costs (in %)",
    zlab = "",
    scale.y = 1.25,
    axis = TRUE,
    tick.marks = TRUE,
    label.tick.marks = TRUE,
    xlim = c(50,150),
    ylim = c(100,400),
    zlim = c(50,400),
    lab = c(4,4),
    lab.z = c(5),
    cex.axis = 0.9,
    y.axis.offset = 0.3,
    col.axis = "#CC3300",
    col.lab = "#000000",
    pch = shapes2teValuePestPrice_162,
    type ="h",
    color = colors2teValuePestPrice_162,
    #grid = FALSE,
    box = FALSE)
PsenAn_162_teValueAnnFee1 <- scatterplot3d(senAn_162_teValueAnnFee1$SSTValue, senAn_162_teValueAnnFee1$annFee, senAn_162_teValueAnnFee1$landAv,
    main = "Scenario 1",
    sub = "Scenario 1",
    col.main = "#009933",
    angle = 78,
    xlab = "SST acquisition costs (%)",
    ylab = "Annual fee (€)",
    zlab = "Farm size (ha)",
    scale.y = 2,
    axis = TRUE,
    tick.marks = TRUE,
    label.tick.marks = TRUE,
    xlim = c(50,150),
    ylim = c(0,15000),
    zlim = c(50,400),
    lab = c(4,4),
    lab.z = c(5),
    cex.axis = 0.9,
    y.axis.offset = 0.3,
    col.axis = "#CC3300",
    col.lab = "#000000",
    pch = shapes1teValueAnnFee_162,
    type ="h",
    color = colors1teValueAnnFee_162,
    #grid = FALSE,
    box = FALSE)
PsenAn_162_teValueAnnFee2 <- scatterplot3d(senAn_162_teValueAnnFee2$SSTValue, senAn_162_teValueAnnFee2$annFee, senAn_162_teValueAnnFee2$landAv,
    main = "Scenario 2",
    col.main = "#0099FF",
    angle = 78,
    xlab = "SST acquisition costs (%)",
    ylab = "Annual fee (€)",
    zlab = "Farm size (ha)",
    scale.y = 2,
    axis = TRUE,
    tick.marks = TRUE,
    label.tick.marks = TRUE,
    xlim = c(50,150),
    ylim = c(0,15000),
    zlim = c(50,400),
    lab = c(4,4),
    lab.z = c(5),
    cex.axis = 0.9,
    y.axis.offset = 0.3,
    col.axis = "#CC3300",
    col.lab = "#000000",
    pch = shapes2teValueAnnFee_162,
    type ="h",
    color = colors2teValueAnnFee_162,
    #grid = FALSE,
    box = FALSE)
PsenAn_162_teValueAlgoCosts1 <- scatterplot3d(senAn_162_teValueAlgoCosts1$SSTValue, senAn_162_teValueAlgoCosts1$algCosts, senAn_162_teValueAlgoCosts1$landAv,
    angle = 78,
    xlab = "",
    ylab = "Ha fee (€)",
    zlab = "",
    scale.y = 1.25,
    axis = TRUE,
    tick.marks = TRUE,
    label.tick.marks = TRUE,
    xlim = c(50,150),
    ylim = c(0,12),
    zlim = c(50,400),
    lab = c(4,6),
    lab.z = c(5),
    cex.axis = 0.9,
    y.axis.offset = 0.3,
    col.axis = "#CC3300",
    col.lab = "#000000",
    pch = shapes1teValueAlgoCosts_162,
    type ="h",
    color = colors1teValueAlgoCosts_162,
    #grid = FALSE,
    box = FALSE)
PsenAn_162_teValueAlgoCosts2 <- scatterplot3d(senAn_162_teValueAlgoCosts2$SSTValue, senAn_162_teValueAlgoCosts2$algCosts, senAn_162_teValueAlgoCosts2$landAv,
    angle = 78,
    xlab = "",
    ylab = "Ha fee (€)",
    zlab = "",
    scale.y = 1.25,
    axis = TRUE,
    tick.marks = TRUE,
    label.tick.marks = TRUE,
    xlim = c(50,150),
    ylim = c(0,12),
    zlim = c(50,400),
    lab = c(4,6),
    lab.z = c(5),
    cex.axis = 0.9,
    y.axis.offset = 0.3,
    col.axis = "#CC3300",
    col.lab = "#000000",
    pch = shapes2teValueAlgoCosts_162,
    type ="h",
    color = colors2teValueAlgoCosts_162,
    #grid = FALSE,
    box = FALSE)
dev.off()


view(senAn_162_teValueAlgoCosts2)
