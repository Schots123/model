library(gamstransfer)
library(tidyverse)
library(ggplot2)
library(dplyr)
setwd("E:\\Studium\\Master of Science Agricultural and Food Economics\\04. Master Thesis\\8. GitHub\\Fruchtfolge Model\\model\\6.Report\\gdxFiles")
getwd()
m162senAn = Container$new("Results_162.141.gdx")
m151senAn = Container$new("Results_151_142.gdx")
#showing parameter names stored in container
m162senAn$listSymbols()
m151senAn$listSymbols()

#quick overview over parameters 
m162senAn$describeParameters()
m151senAn$describeParameters()

#assign records of specific parameter in containter to dataframe
senAn_farm162 <- m162senAn["summarySenAn"]$records
senAn_farm151 <- m151senAn["summarySenAn"]$records

#showing overview about specific parameter
view(senAn_farm162)
glimpse(senAn_farm162)
view(senAn_farm162)
senAn_farm162[["value"]]
view(senAn_farm151)
glimpse(senAn_farm151)
view(senAn_farm151)
senAn_farm151[["value"]]

#lists names of variables in dataframe
names(senAn162)
names(senAn151)

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
senAn_162_spot6m <- subset(senAn_farm162, allItems_1 == "spot6m")
senAn_162_spot27m <- subset(senAn_farm162, allItems_1 == "spot27m")
senAn_162_avgAnProf <- subset(senAn_farm162, allItems_1 == "avgAnnFarmProf")
#smaller subsets for assignment of values to each sensitivity analysis
senAn_162_teValue <- subset(senAn_farm162, allItems_1 == "%SSTvalue")
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
colnames(senAn_162_spot6m)[5] <- "spot6m"
colnames(senAn_162_spot27m)[5] <- "spot27m"
colnames(senAn_162_teValue)[5] <- "avgAnnFarmProf"
colnames(senAn_162_algoCosts)[5] <- "%algCosts"
colnames(senAn_162_annFee)[5] <- "%anFee"
colnames(senAn_162_PestEff)[5] <- "%pestiSav"
colnames(senAn_162_time)[5] <- "%timeReq"
colnames(senAn_162_fuel)[5] <- "%fuelCons"
colnames(senAn_162_repair)[5] <- "%repCosts"

#delete allItems column
senAn_landAv$allItems_1 <- NULL
senAn_landUsed$allItems_1 <- NULL
senAn_WW$allItems_1 <- NULL
senAn_WG$allItems_1 <- NULL
senAn_SB$allItems_1 <- NULL
senAn_BA45kW$allItems_1 <- NULL
senAn_BA67kW$allItems_1 <- NULL
senAn_BA83kW$allItems_1 <- NULL
senAn_BA_102kW$allItems_1 <- NULL
senAn_spot6m$allItems_1 <- NULL
senAn_spot27m$allItems_1 <- NULL
senAn_avgAnProf$allItems_1 <- NULL

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
    left_join(senAn_162_spot6m, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_spot27m, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_avgAnProf, by =c("uni_2","uni_3","uni_4"))


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
    left_join(senAn_162_spot6m, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_spot27m, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_avgAnProf, by =c("uni_2","uni_3","uni_4"))


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
    left_join(senAn_162_spot6m, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_spot27m, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_avgAnProf, by =c("uni_2","uni_3","uni_4"))

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
    left_join(senAn_162_spot6m, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_spot27m, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_avgAnProf, by =c("uni_2","uni_3","uni_4"))

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
    left_join(senAn_162_spot6m, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_spot27m, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_avgAnProf, by =c("uni_2","uni_3","uni_4"))

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
    left_join(senAn_162_spot6m, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_spot27m, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_avgAnProf, by =c("uni_2","uni_3","uni_4"))

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
    left_join(senAn_162_spot6m, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_spot27m, by =c("uni_2","uni_3","uni_4")) %>% 
    left_join(senAn_162_avgAnProf, by =c("uni_2","uni_3","uni_4"))

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
rm(senAn_162_spot6m)
rm(senAn_162_spot27m)
rm(senAn_162_avgAnProf)

####################################
#Preperation of sensitivity analysis
####################################

###################Technology Value 
#combine all BA sprayer columns to one
senAn_162_teValue <- senAn_162_teValue %>%
#rename number values to respective BA Sprayer used
    mutate(BA_67kW = str_replace(BA_67kW, "1", "BA_67kW")) %>%
    mutate(BA_45kW = str_replace(BA_45kW,"1", "BA_45kW")) %>%
    mutate(BA_83kW = str_replace(BA_83kW,"1", "BA_83kW")) %>%
    mutate(BA_102kW = str_replace(BA_102kW,"1", "BA_102kW")) %>%
#combine columns of BA Sprayer and SST
    unite(BA_Sprayer, BA_45kW, BA_67kW, BA_83kW, BA_102kW,
        sep ="") %>%
    unite(SST, spot6m, spot27m, sep ="") %>%
#make corrections after combination of columns
    mutate(SST = str_replace(SST," 1", "1")) %>%
    mutate(SST = str_replace(SST,"1 ", "1")) %>%
    mutate(BA_Sprayer = str_replace(BA_Sprayer,"BA_45kW   ", "BA_45kW")) %>%
    mutate(BA_Sprayer = str_replace(BA_Sprayer," BA_67kW  ", "BA_67kW")) %>%
    mutate(BA_Sprayer = str_replace(BA_Sprayer,"  BA_83kW ", "BA_83kW")) %>%
    mutate(BA_Sprayer = str_replace(BA_Sprayer,"   BA_102kW", "BA_102kW")) %>%
    mutate(SST = str_replace(SST,"2 ", "2"))

#change scale of farm profit 
senAn_162_teValue <- senAn_162_teValue %>%
    mutate(avgAnnFarmProf = avgAnnFarmProf / 1000)



###################
#DATA VISUALIZATION
###################

###################Technology Value 
PsenAn162_teValue <- technoComp_farm162 %>%
#aes tells R which variables are mapped against which visual characteristics on the canvas 
    ggplot(aes(x = landAv,
           y = avgAnnFarmProf,
           colour = Scenario)) +
#    geom_smooth(se = F)+
#geom_point tells R to use points as the geometry (scatter plot)
    geom_point(aes(size = SST,
                    shape = BA_Sprayer))+
#geom_smooth connects points 
#rename graph labels 
    labs(x = "Farm size (in ha)",
         y = "Average annual net farm profit (in 1,000€)")

#Formatting of graph
#Formatting of graph tite
PsenAn162_teValue <- PsenAn162_teValue + ggtitle("Comparison of both SSTs (spot6m & spot27m)\nand scenarios (FH & FHBonus) with the baseline scenario") +
    theme(plot.title = element_text(lineheight =.8, face="bold", size=20, hjust=0.5))+
#Formatting of things which have to do with the legend
    scale_colour_manual(name = "Used Technology\nin Scenario",
                        breaks = c("Base", "SST6m_FH", "SST27m_FH", "SST6m_FHBonus", "SST27m_FHBonus"),
                        labels = c("Base", "Scenario 1: SST6m", "Scenario 1: SST27m", "Scenario 2: SST6m", "Scenario 2: SST27m"),
                        values = c("#FF0000", "#3333FF", "#339900", "#66CCFF", "#33FF66"))+
    scale_shape_manual(name = "Used BA sprayer",
                        breaks = c("    ", "BA_45kW", "BA_67kW", "BA_83kW", "BA_102kW"),
                        labels = c("None", "45kW Sprayer", "67kW Sprayer", "83kW Sprayer", "102kW Sprayer"),
                        values=c(8,15,16,17,18))+
    scale_size_manual(name = "Number of SST used",
                            breaks = c("  ", "1", "2"),
                            labels = c("None", "1 Sprayer", "2 Sprayer"),
                            values=c(3,6,12))+
#legend appearance
    theme(legend.title = element_text(face = "bold", size = 14, hjust=.5))+
    theme(legend.justification=c(1,0), legend.position=c(1,0))+
    theme(legend.background = element_rect(fill="gray90", size =.5, linetype = "dotted"))+
    theme(legend.text = element_text(size = 12))+
#formatting of axis
    scale_y_continuous(breaks=seq(0,350,25))+
    theme(axis.title.y = element_text(face="bold", vjust=2, size = 20))+
        theme(axis.title.x = element_text(face="bold", vjust=0.3, size = 20))


###################Algorithm Costs