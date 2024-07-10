library(gamstransfer)
library(tidyverse)
library(ggplot2)
library(dplyr)
setwd("E:\\Studium\\Master of Science Agricultural and Food Economics\\04. Master Thesis\\8. GitHub\\Fruchtfolge Model\\model\\6.Report\\gdxFiles")
getwd()
m1 = Container$new("Results_162.141.gdx")
m2 = Container$new("Results_151_142.gdx")
#showing parameter names stored in container
m162$listSymbols()
m151$listSymbols()

#quick overview over parameters 
m162$describeParameters()
m151$describeParameters()

#assign records of specific parameter in containter to dataframe
technoComp_farm162 <- m1["summary"]$records
technoComp_farm151 <- m2["summary"]$records

#showing overview about specific parameter
view(technoComp_farm162)
glimpse(technoComp_farm162)
view(technoComp_farm162)
technoComp_farm162[["value"]]
view(technoComp_farm151)
glimpse(technoComp_farm151)
view(technoComp_farm151)
technoComp_farm151[["value"]]

#lists names of variables in dataframe
names(technoComp_farm162)
names(technoComp_farm151)

##################
#DATA MANIPULATION
##################
#creating subsets of main dataframe for later recombination
teComp_162_landAv <- subset(technoComp_farm162,allItems_1 == "landAv")
teComp_162_landUsed <- subset(technoComp_farm162,allItems_1 == "landUsedAvg")
teComp_162_WW <- subset(technoComp_farm162,allItems_1 == "Winterweizen")
teComp_162_WG <- subset(technoComp_farm162,allItems_1 == "Wintergerste")
teComp_162_SB <- subset(technoComp_farm162,allItems_1 == "Zuckerrueben")
teComp_162_BA45kW <- subset(technoComp_farm162,allItems_1 == "BA_45kW")
teComp_162_BA67kW <- subset(technoComp_farm162,allItems_1 == "BA_67kW")
teComp_162_BA83kW <- subset(technoComp_farm162,allItems_1 == "BA_83kW")
teComp_162_BA_102kW <- subset(technoComp_farm162,allItems_1 == "BA_102kW")
teComp_162_spot6m <- subset(technoComp_farm162,allItems_1 == "spot6m")
teComp_162_spot27m <- subset(technoComp_farm162,allItems_1 == "spot27m")
teComp_162_avgAnProf <- subset(technoComp_farm162,allItems_1 == "avgAnnFarmProf")
#rename header of value
colnames(teComp_162_landAv)[4] <- "landAv"
colnames(teComp_162_landUsed)[4] <- "landUsedAvg"
colnames(teComp_162_WW)[4] <- "Winterweizen"
colnames(teComp_162_WG)[4] <- "Wintergerste"
colnames(teComp_162_SB)[4] <- "Zuckerrueben"
colnames(teComp_162_BA45kW)[4] <- "BA_45kW"
colnames(teComp_162_BA67kW)[4] <- "BA_67kW"
colnames(teComp_162_BA83kW)[4] <- "BA_83kW"
colnames(teComp_162_BA_102kW)[4] <- "BA_102kW"
colnames(teComp_162_spot6m)[4] <- "spot6m"
colnames(teComp_162_spot27m)[4] <- "spot27m"
colnames(teComp_162_avgAnProf)[4] <- "avgAnnFarmProf"

#delete allItems column
teComp_162_landAv$allItems_1 <- NULL
teComp_162_landUsed$allItems_1 <- NULL
teComp_162_WW$allItems_1 <- NULL
teComp_162_WG$allItems_1 <- NULL
teComp_162_SB$allItems_1 <- NULL
teComp_162_BA45kW$allItems_1 <- NULL
teComp_162_BA67kW$allItems_1 <- NULL
teComp_162_BA83kW$allItems_1 <- NULL
teComp_162_BA_102kW$allItems_1 <- NULL
teComp_162_spot6m$allItems_1 <- NULL
teComp_162_spot27m$allItems_1 <- NULL
teComp_162_avgAnProf$allItems_1 <- NULL

#create new combined dataframe
technoComp_farm162 <- 
    teComp_162_landAv %>% 
    left_join(teComp_162_landUsed, by =c("uni_2","uni_3")) %>% 
    left_join(teComp_162_WW, by =c("uni_2","uni_3")) %>% 
    left_join(teComp_162_WG, by =c("uni_2","uni_3")) %>% 
    left_join(teComp_162_SB, by =c("uni_2","uni_3")) %>% 
    left_join(teComp_162_BA45kW, by =c("uni_2","uni_3")) %>% 
    left_join(teComp_162_BA67kW, by =c("uni_2","uni_3")) %>% 
    left_join(teComp_162_BA83kW, by =c("uni_2","uni_3")) %>% 
    left_join(teComp_162_BA_102kW, by =c("uni_2","uni_3")) %>% 
    left_join(teComp_162_spot6m, by =c("uni_2","uni_3")) %>% 
    left_join(teComp_162_spot27m, by =c("uni_2","uni_3")) %>% 
    left_join(teComp_162_avgAnProf, by =c("uni_2","uni_3"))

colnames(technoComp_farm162)[2] <- "Scenario"
colnames(technoComp_farm162)[1] <- "sizeStep"

#removal of subsets (not needed anymore)
rm(teComp_162_landAv)
rm(teComp_162_landUsed)
rm(teComp_162_WW)
rm(teComp_162_WG)
rm(teComp_162_SB)
rm(teComp_162_BA45kW)
rm(teComp_162_BA67kW)
rm(teComp_162_BA83kW)
rm(teComp_162_BA_102kW)
rm(teComp_162_spot6m)
rm(teComp_162_spot27m)
rm(teComp_162_avgAnProf)

#change variable type to combine BA sprayer and remove NA values
technoComp_farm162$BA_45kW <- as.character(technoComp_farm162$BA_45kW)
technoComp_farm162$BA_67kW <- as.character(technoComp_farm162$BA_67kW)
technoComp_farm162$BA_83kW <- as.character(technoComp_farm162$BA_83kW)
technoComp_farm162$BA_102kW <- as.character(technoComp_farm162$BA_102kW)

technoComp_farm162[is.na(technoComp_farm162)] <- " "

#combine all BA sprayer columns to one
technoComp_farm162 <- technoComp_farm162 %>%
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
technoComp_farm162 <- technoComp_farm162 %>%
    mutate(avgAnnFarmProf = avgAnnFarmProf / 1000)




###################
#DATA VISUALIZATION
###################
PteComp162 <- technoComp_farm162 %>%
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
PteComp162 <- PteComp162 + ggtitle("Comparison of both SSTs (spot6m & spot27m)\nand scenarios (FH & FHBonus) with the baseline scenario") +
    theme(plot.title = element_text(lineheight =.8, face="bold", size=20, hjust=0.5))
#Formatting of things which have to do with the legend
PteComp162 <- PteComp162 + scale_colour_manual(name = "Used Technology\nin Scenario",
                            breaks = c("Base", "SST6m_FH", "SST27m_FH", "SST6m_FHBonus", "SST27m_FHBonus"),
                            labels = c("Base", "Scenario 1: SST6m", "Scenario 1: SST27m", "Scenario 2: SST6m", "Scenario 2: SST27m"),
                            values = c("#FF0000", "#3333FF", "#339900", "#66CCFF", "#33FF66"))

PteComp162 <- PteComp162 + scale_shape_manual(name = "Used BA sprayer",
                            breaks = c("    ", "BA_45kW", "BA_67kW", "BA_83kW", "BA_102kW"),
                            labels = c("None", "45kW Sprayer", "67kW Sprayer", "83kW Sprayer", "102kW Sprayer"),
                            values=c(8,15,16,17,18))

PteComp162 <- PteComp162 + scale_size_manual(name = "Number of SST used",
                            breaks = c("  ", "1", "2"),
                            labels = c("None", "1 Sprayer", "2 Sprayer"),
                            values=c(3,6,12))
#legend appearance
PteComp162 <- PteComp162 + theme(legend.title = element_text(face = "bold", size = 14, hjust=.5))
PteComp162 <- PteComp162 + theme(legend.justification=c(1,0), legend.position=c(1,0))
PteComp162 <- PteComp162 + theme(legend.background = element_rect(fill="gray90", size =.5, linetype = "dotted"))
PteComp162 <- PteComp162 + theme(legend.text = element_text(size = 12))
#formatting of axis
PteComp162 <- PteComp162 + scale_y_continuous(breaks=seq(0,350,25))
PteComp162 <- PteComp162 + theme(axis.title.y = element_text(face="bold", vjust=2, size = 20))+
        theme(axis.title.x = element_text(face="bold", vjust=0.3, size = 20))