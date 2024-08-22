library(gamstransfer)
library(tidyverse)
library(patchwork)

#showing parameter names stored in container
m162technoComp$listSymbols()
m151technoComp$listSymbols()
#quick overview over parameters 
m162technoComp$describeParameters()
m151technoComp$describeParameters()
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

setwd("E:\\Studium\\Master of Science Agricultural and Food Economics\\04. Master Thesis\\8. GitHub\\Fruchtfolge Model\\model\\6.Report\\gdxFiles")
getwd()

m162technoComp = Container$new("Results_162.141.gdx")
m151technoComp = Container$new("Results_151.142.gdx")
#assign records of specific parameter in containter to dataframe
technoComp_farm162 <- m162technoComp["summary"]$records
technoComp_farm151 <- m151technoComp["summary"]$records


#Replace data mistakes by GAMS
technoComp_farm162$value <- replace(technoComp_farm162$value, technoComp_farm162$value > 0.99 & technoComp_farm162$value < 1.01, 1)
technoComp_farm162$value <- replace(technoComp_farm162$value, technoComp_farm162$value > -0.01 & technoComp_farm162$value < 0.01, 0)
technoComp_farm151$value <- replace(technoComp_farm151$value, technoComp_farm151$value > 0.99 & technoComp_farm151$value < 1.01, 1)
technoComp_farm151$value <- replace(technoComp_farm151$value, technoComp_farm151$value > -0.01 & technoComp_farm151$value < 0.01, 0)

#############
#Farm 162.141
#############

##################
#DATA MANIPULATION
##################
#creating subsets of main dataframe for later recombination
teComp_162_landAv <- subset(technoComp_farm162,allItems_1 == "landAv")
teComp_162_landUsed <- subset(technoComp_farm162,allItems_1 == "landUsedAvg")
teComp_162_WW <- subset(technoComp_farm162,allItems_1 == "Winterweizen")
teComp_162_WG <- subset(technoComp_farm162,allItems_1 == "Wintergerste")
teComp_162_SB <- subset(technoComp_farm162,allItems_1 == "Zuckerrueben")
teComp_162_BA45kW <- subset(technoComp_farm162,allItems_1 == "BA_45kW" & value > 0)
teComp_162_BA67kW <- subset(technoComp_farm162,allItems_1 == "BA_67kW" & value > 0)
teComp_162_BA83kW <- subset(technoComp_farm162,allItems_1 == "BA_83kW" & value > 0)
teComp_162_BA_102kW <- subset(technoComp_farm162,allItems_1 == "BA_102kW" & value > 0)
teComp_162_BA_120kW <- subset(technoComp_farm162,allItems_1 == "BA_120kW" & value > 0)
teComp_162_BA_200kW <- subset(technoComp_farm162,allItems_1 == "BA_200kW" & value > 0)
teComp_162_BA_230kW <- subset(technoComp_farm162,allItems_1 == "BA_230kW" & value > 0)
teComp_162_spot6m <- subset(technoComp_farm162,allItems_1 == "spot6m" & value > 0)
teComp_162_spot27m <- subset(technoComp_farm162,allItems_1 == "spot27m" & value > 0)
teComp_162_avgAnProf <- subset(technoComp_farm162,allItems_1 == "avgAnnFarmProf")
teComp_162_diCostsPesti <- subset(technoComp_farm162,allItems_1 == "diCostsPesti")
teComp_162_fuelCostsSprayer <- subset(technoComp_farm162,allItems_1 == "fuelCostsSprayer") 
teComp_162_repCostsSprayer <- subset(technoComp_farm162,allItems_1 == "repCostsSprayer") 
teComp_162_labCostsSprayer <- subset(technoComp_farm162,allItems_1 == "labCostsSprayer") 
teComp_162_varCostsSprayer <- subset(technoComp_farm162,allItems_1 == "varCostsSprayer") 
teComp_162_fixCostsSprayer <- subset(technoComp_farm162,allItems_1 == "fixCostsSprayer") 




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
colnames(teComp_162_BA_120kW)[4] <- "BA_120kW"
colnames(teComp_162_BA_200kW)[4] <- "BA_200kW"
colnames(teComp_162_BA_230kW)[4] <- "BA_230kW"
colnames(teComp_162_spot6m)[4] <- "spot6m"
colnames(teComp_162_spot27m)[4] <- "spot27m"
colnames(teComp_162_avgAnProf)[4] <- "avgAnnFarmProf"
colnames(teComp_162_diCostsPesti)[4] <- "diCostsPesti"
colnames(teComp_162_fuelCostsSprayer)[4] <- "fuelCostsSprayer"
colnames(teComp_162_repCostsSprayer)[4] <- "repCostsSprayer"
colnames(teComp_162_labCostsSprayer)[4] <- "labCostsSprayer"
colnames(teComp_162_varCostsSprayer)[4] <- "varCostsSprayer"
colnames(teComp_162_fixCostsSprayer)[4] <- "fixCostsSprayer"

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
teComp_162_BA_120kW$allItems_1 <- NULL
teComp_162_BA_200kW$allItems_1 <- NULL
teComp_162_BA_230kW$allItems_1 <- NULL
teComp_162_spot6m$allItems_1 <- NULL
teComp_162_spot27m$allItems_1 <- NULL
teComp_162_avgAnProf$allItems_1 <- NULL
teComp_162_diCostsPesti$allItems_1 <- NULL
teComp_162_fuelCostsSprayer$allItems_1 <- NULL
teComp_162_repCostsSprayer$allItems_1 <- NULL
teComp_162_labCostsSprayer$allItems_1 <- NULL
teComp_162_varCostsSprayer$allItems_1 <- NULL
teComp_162_fixCostsSprayer$allItems_1 <- NULL




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
    left_join(teComp_162_BA_120kW, by =c("uni_2","uni_3")) %>% 
    left_join(teComp_162_BA_200kW, by =c("uni_2","uni_3")) %>% 
    left_join(teComp_162_BA_230kW, by =c("uni_2","uni_3")) %>% 
    left_join(teComp_162_spot6m, by =c("uni_2","uni_3")) %>% 
    left_join(teComp_162_spot27m, by =c("uni_2","uni_3")) %>% 
    left_join(teComp_162_avgAnProf, by =c("uni_2","uni_3")) %>% 
    left_join(teComp_162_diCostsPesti, by =c("uni_2","uni_3")) %>% 
    left_join(teComp_162_fuelCostsSprayer, by =c("uni_2","uni_3")) %>% 
    left_join(teComp_162_repCostsSprayer, by =c("uni_2","uni_3")) %>% 
    left_join(teComp_162_labCostsSprayer, by =c("uni_2","uni_3")) %>% 
    left_join(teComp_162_varCostsSprayer, by =c("uni_2","uni_3")) %>% 
    left_join(teComp_162_fixCostsSprayer, by =c("uni_2","uni_3"))

#Rename columns
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
rm(teComp_162_BA_120kW)
rm(teComp_162_BA_200kW)
rm(teComp_162_BA_230kW)
rm(teComp_162_spot6m)
rm(teComp_162_spot27m)
rm(teComp_162_avgAnProf)
rm(teComp_162_diCostsPesti)
rm(teComp_162_fuelCostsSprayer)
rm(teComp_162_repCostsSprayer)
rm(teComp_162_labCostsSprayer)
rm(teComp_162_varCostsSprayer)
rm(teComp_162_fixCostsSprayer)


#delete all NA entries and replace them with blankets
technoComp_farm162[is.na(technoComp_farm162)] <- ""

#Copy BA sprayer columns for two unite operations in the next step
technoComp_farm162$BA_45kWNum <- technoComp_farm162$BA_45kW
technoComp_farm162$BA_67kWNum <- technoComp_farm162$BA_67kW
technoComp_farm162$BA_83kWNum <- technoComp_farm162$BA_83kW
technoComp_farm162$BA_102kWNum <- technoComp_farm162$BA_102kW
technoComp_farm162$BA_120kWNum <- technoComp_farm162$BA_120kW
technoComp_farm162$BA_200kWNum <- technoComp_farm162$BA_200kW
technoComp_farm162$BA_230kWNum <- technoComp_farm162$BA_230kW 


#combine all BA sprayer columns to one
technoComp_farm162 <- technoComp_farm162 %>%
#rename number values to respective BA Sprayer used
    mutate(BA_67kW = str_replace(BA_67kW, "1", "BA_67kW")) %>%
    mutate(BA_45kW = str_replace(BA_45kW,"1", "BA_45kW")) %>%
    mutate(BA_83kW = str_replace(BA_83kW,"1", "BA_83kW")) %>%
    mutate(BA_102kW = str_replace(BA_102kW,"1", "BA_102kW")) %>%
    mutate(BA_120kW = str_replace(BA_120kW,"1", "BA_120kW")) %>%
    mutate(BA_200kW = str_replace(BA_200kW,"1", "BA_200kW")) %>%
    mutate(BA_230kW = str_replace(BA_230kW,"1", "BA_230kW")) %>%
#combine columns of BA Sprayer and SST
    unite(BA_Sprayer, BA_45kW, BA_67kW, BA_83kW, BA_102kW, BA_120kW, BA_200kW, BA_230kW,
        sep ="") %>%
    unite(BA_Sprayer_Num, BA_45kWNum, BA_67kWNum, BA_83kWNum, BA_102kWNum, BA_120kWNum, BA_200kWNum, BA_230kWNum, 
        sep="") %>%
    unite(SST, spot6m, spot27m, sep ="")

#change scale of farm profit 
technoComp_farm162 <- technoComp_farm162 %>%
    mutate(avgAnnFarmProf = avgAnnFarmProf / 1000)



#############
#Farm 151.142
#############

##################
#DATA MANIPULATION
##################
#creating subsets of main dataframe for later recombination
teComp_151_landAv <- subset(technoComp_farm151,allItems_1 == "landAv")
teComp_151_landUsed <- subset(technoComp_farm151,allItems_1 == "landUsedAvg")
teComp_151_WW <- subset(technoComp_farm151,allItems_1 == "Winterweizen")
teComp_151_WG <- subset(technoComp_farm151,allItems_1 == "Wintergerste")
teComp_151_WR <- subset(technoComp_farm151,allItems_1 == "Winterraps")
teComp_151_BA45kW <- subset(technoComp_farm151,allItems_1 == "BA_45kW")
teComp_151_BA67kW <- subset(technoComp_farm151,allItems_1 == "BA_67kW")
teComp_151_BA83kW <- subset(technoComp_farm151,allItems_1 == "BA_83kW")
teComp_151_BA_102kW <- subset(technoComp_farm151,allItems_1 == "BA_102kW")
teComp_151_BA_120kW <- subset(technoComp_farm151,allItems_1 == "BA_120kW")
teComp_151_BA_200kW <- subset(technoComp_farm151,allItems_1 == "BA_200kW")
teComp_151_BA_230kW <- subset(technoComp_farm151,allItems_1 == "BA_230kW")
teComp_151_spot6m <- subset(technoComp_farm151,allItems_1 == "spot6m")
teComp_151_spot27m <- subset(technoComp_farm151,allItems_1 == "spot27m")
teComp_151_avgAnProf <- subset(technoComp_farm151,allItems_1 == "avgAnnFarmProf")


#rename header of value
colnames(teComp_151_landAv)[4] <- "landAv"
colnames(teComp_151_landUsed)[4] <- "landUsedAvg"
colnames(teComp_151_WW)[4] <- "Winterweizen"
colnames(teComp_151_WG)[4] <- "Wintergerste"
colnames(teComp_151_WR)[4] <- "Winterraps"
colnames(teComp_151_BA45kW)[4] <- "BA_45kW"
colnames(teComp_151_BA67kW)[4] <- "BA_67kW"
colnames(teComp_151_BA83kW)[4] <- "BA_83kW"
colnames(teComp_151_BA_102kW)[4] <- "BA_102kW"
colnames(teComp_151_BA_120kW)[4] <- "BA_120kW"
colnames(teComp_151_BA_200kW)[4] <- "BA_200kW"
colnames(teComp_151_BA_230kW)[4] <- "BA_230kW"
colnames(teComp_151_spot6m)[4] <- "spot6m"
colnames(teComp_151_spot27m)[4] <- "spot27m"
colnames(teComp_151_avgAnProf)[4] <- "avgAnnFarmProf"


#delete allItems column
teComp_151_landAv$allItems_1 <- NULL
teComp_151_landUsed$allItems_1 <- NULL
teComp_151_WW$allItems_1 <- NULL
teComp_151_WG$allItems_1 <- NULL
teComp_151_WR$allItems_1 <- NULL
teComp_151_BA45kW$allItems_1 <- NULL
teComp_151_BA67kW$allItems_1 <- NULL
teComp_151_BA83kW$allItems_1 <- NULL
teComp_151_BA_102kW$allItems_1 <- NULL
teComp_151_BA_120kW$allItems_1 <- NULL
teComp_151_BA_200kW$allItems_1 <- NULL
teComp_151_BA_230kW$allItems_1 <- NULL
teComp_151_spot6m$allItems_1 <- NULL
teComp_151_spot27m$allItems_1 <- NULL
teComp_151_avgAnProf$allItems_1 <- NULL


#create new combined dataframe
technoComp_farm151 <- 
    teComp_151_landAv %>% 
    left_join(teComp_151_landUsed, by =c("uni_2","uni_3")) %>% 
    left_join(teComp_151_WW, by =c("uni_2","uni_3")) %>% 
    left_join(teComp_151_WG, by =c("uni_2","uni_3")) %>% 
    left_join(teComp_151_WR, by =c("uni_2","uni_3")) %>% 
    left_join(teComp_151_BA45kW, by =c("uni_2","uni_3")) %>% 
    left_join(teComp_151_BA67kW, by =c("uni_2","uni_3")) %>% 
    left_join(teComp_151_BA83kW, by =c("uni_2","uni_3")) %>% 
    left_join(teComp_151_BA_102kW, by =c("uni_2","uni_3")) %>%
    left_join(teComp_151_BA_120kW, by =c("uni_2","uni_3")) %>% 
    left_join(teComp_151_BA_200kW, by =c("uni_2","uni_3")) %>% 
    left_join(teComp_151_BA_230kW, by =c("uni_2","uni_3")) %>% 
    left_join(teComp_151_spot6m, by =c("uni_2","uni_3")) %>% 
    left_join(teComp_151_spot27m, by =c("uni_2","uni_3")) %>% 
    left_join(teComp_151_avgAnProf, by =c("uni_2","uni_3"))
#Rename columns
colnames(technoComp_farm151)[2] <- "Scenario"
colnames(technoComp_farm151)[1] <- "sizeStep"


#removal of subsets (not needed anymore)
rm(teComp_151_landAv)
rm(teComp_151_landUsed)
rm(teComp_151_WW)
rm(teComp_151_WG)
rm(teComp_151_WR)
rm(teComp_151_BA45kW)
rm(teComp_151_BA67kW)
rm(teComp_151_BA83kW)
rm(teComp_151_BA_102kW)
rm(teComp_151_BA_120kW)
rm(teComp_151_BA_200kW)
rm(teComp_151_BA_230kW)
rm(teComp_151_spot6m)
rm(teComp_151_spot27m)
rm(teComp_151_avgAnProf)



#replace 0 with blanekts
technoComp_farm151 <- technoComp_farm151 %>%
    mutate(BA_67kW = str_replace(BA_67kW, "0", "")) %>%
    mutate(BA_45kW = str_replace(BA_45kW,"0", "")) %>%
    mutate(BA_83kW = str_replace(BA_83kW,"0", "")) %>%
    mutate(BA_102kW = str_replace(BA_102kW,"0", "")) %>%
    mutate(BA_120kW = str_replace(BA_120kW,"0", "")) %>%
    mutate(BA_200kW = str_replace(BA_200kW,"0", "")) %>%
    mutate(BA_230kW = str_replace(BA_230kW,"0", ""))
#delete all NA entries and replace them with blankets
technoComp_farm151[is.na(technoComp_farm151)] <- ""


#Copy BA sprayer columns for two unite operations in the next step
technoComp_farm151$BA_45kWNum <- technoComp_farm151$BA_45kW
technoComp_farm151$BA_67kWNum <- technoComp_farm151$BA_67kW
technoComp_farm151$BA_83kWNum <- technoComp_farm151$BA_83kW
technoComp_farm151$BA_102kWNum <- technoComp_farm151$BA_102kW
technoComp_farm151$BA_120kWNum <- technoComp_farm151$BA_120kW
technoComp_farm151$BA_200kWNum <- technoComp_farm151$BA_200kW
technoComp_farm151$BA_230kWNum <- technoComp_farm151$BA_230kW 


#combine all BA sprayer columns to one
technoComp_farm151 <- technoComp_farm151 %>%
#rename number values to respective BA Sprayer used
    mutate(BA_67kW = str_replace(BA_67kW, "1", "BA_67kW")) %>%
    mutate(BA_45kW = str_replace(BA_45kW,"1", "BA_45kW")) %>%
    mutate(BA_83kW = str_replace(BA_83kW,"1", "BA_83kW")) %>%
    mutate(BA_102kW = str_replace(BA_102kW,"1", "BA_102kW")) %>%
    mutate(BA_120kW = str_replace(BA_120kW,"1", "BA_120kW")) %>%
    mutate(BA_200kW = str_replace(BA_200kW,"1", "BA_200kW")) %>%
    mutate(BA_230kW = str_replace(BA_230kW,"1", "BA_230kW")) %>%
#combine columns of BA Sprayer and SST
    unite(BA_Sprayer, BA_45kW, BA_67kW, BA_83kW, BA_102kW, BA_120kW, BA_200kW, BA_230kW,
        sep ="") %>%
    unite(BA_Sprayer_Num, BA_45kWNum, BA_67kWNum, BA_83kWNum, BA_102kWNum, BA_120kWNum, BA_200kWNum, BA_230kWNum, 
        sep="") %>%
    unite(SST, spot6m, spot27m, sep ="")

#change scale of farm profit 
technoComp_farm151 <- technoComp_farm151 %>%
    mutate(avgAnnFarmProf = avgAnnFarmProf / 1000)

view(technoComp_farm162)
view(technoComp_farm151)
###################
#DATA VISUALIZATION
###################
PteComp162 <- technoComp_farm162 %>%
#aes tells R which variables are mapped against which visual characteristics on the canvas 
    ggplot(aes(x = landAv,
           y = avgAnnFarmProf,
           colour = Scenario))+ 
#    geom_smooth(se = F)+
#geom_point tells R to use points as the geometry (scatter plot)
    geom_point(aes(alpha = SST,
                    shape = BA_Sprayer_Num), size = 0.5)+
#rename graph labels 
    labs(x = "Farm size (in ha)",
         y = "(in 1,000€)")+
#Formatting of graph
#Formatting of graph tite
    ggtitle(label ="Farm profit", subtitle = "Root crop farm")+
    theme(
            plot.title = element_text(face ="bold", size =12, hjust=0.5),
            plot.subtitle = element_text(face ="bold", size =12, colour ="#CC3300")
    )+
#Formatting of legend
    scale_shape_manual(name = "BA Sprayer used",
                            breaks = c("", "1"),
                            labels = c("No", "Yes"),
                            values=c(1,19))+
    scale_colour_manual(name = "Scenario & technology\nused",
                            breaks = c("Base", "SST6m_FH", "SST27m_FH", "SST6m_FHBonus", "SST27m_FHBonus"),
                            labels = c("Base", "Scenario 1: SST6m", "Scenario 1: SST27m", "Scenario 2: SST6m", "Scenario 2: SST27m"),
                            values = c("#333333", "#006600", "#33FF00", "#000099", "#0099FF"))+
    scale_alpha_manual(name = "Number of SSTs used",
                            breaks = c("", "1", "2"),
                            labels = c("None", "1 Sprayer", "2 Sprayer"),
                            values = c(0.55, 0.55, 1))+           
#formatting of grid
    theme(
        panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(colour = "grey", linetype = "dashed"),
        plot.margin = margin(t =0, r =0, b=0, l=0)
    )+
#formatting of axis
    scale_y_continuous(breaks=seq(50,315,50), limits = c(0,315), expand = expansion(mult = 0, add = 0))+
    scale_x_continuous(breaks=seq(50,400,50), limits = c(50,400), expand = expansion(mult = 0, add = 0))+
    theme(
        axis.title.y = element_text(face="bold", vjust=2, size = 10), 
        axis.title.x = element_text(face="bold", vjust=0.3, size = 10),
        axis.text = element_text(size = 10),
        axis.line = element_line(size = 0.3, colour ="#CC3300", linetype =1),
        axis.ticks = element_line(size = 0.5, colour ="#CC3300"),
        axis.ticks.length = unit(0.2, "cm")
    )
PteComp162
ggsave("teComp162.png")



PteComp151 <- technoComp_farm151 %>%
    ggplot(aes(x = landAv,
           y = avgAnnFarmProf,
           colour = Scenario))+ 
    geom_point(aes(alpha = SST,
                    shape = BA_Sprayer_Num), size = 0.5)+
    labs(x = "Farm size (in ha)",
         y = "(in 1,000€)")+
    ggtitle(label ="", subtitle = "Cereal farm")+
    theme(
            plot.subtitle = element_text(face ="bold", size =12, colour = "#CC9900"),
            plot.title = element_text(size = 0)
    )+
    scale_shape_manual(name = "BA Sprayer used",
                            breaks = c("", "1"),
                            labels = c("No", "Yes"),
                            values=c(1,19))+
    scale_colour_manual(name = "Scenario & technology\nused",
                            breaks = c("Base", "SST6m_FH", "SST27m_FH", "SST6m_FHBonus", "SST27m_FHBonus"),
                            labels = c("Base", "Scenario 1: SST6m", "Scenario 1: SST27m", "Scenario 2: SST6m", "Scenario 2: SST27m"),
                            values = c("#333333", "#006600", "#33FF00", "#000099", "#0099FF"))+
    scale_alpha_manual(name = "Number of SSTs used",
                            breaks = c("", "1", "2"),
                            labels = c("None", "1 Sprayer", "2 Sprayer"),
                            values = c(0.55, 0.55, 1))+           
    theme(
        panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(colour = "grey", linetype = "dashed"),
        plot.margin = margin(t =0, r =0, b=0, l=0)
    )+
    scale_y_continuous(breaks=seq(50,250,50), limits = c(0,250), expand = expansion(mult = 0, add = 0))+
    scale_x_continuous(breaks=seq(50,400,50), limits = c(50,400), expand = expansion(mult = 0, add = 0))+
    theme(
        axis.title.y = element_text(face="bold", vjust=2, size = 10), 
        axis.title.x = element_text(face="bold", vjust=0.3, size = 10),
        axis.text = element_text(size = 10),
        axis.line = element_line(size = 0.3, colour = "#CC9900", linetype =1),
        axis.ticks = element_line(size = 0.5, colour = "#CC9900"),
        axis.ticks.length = unit(0.2, "cm")
    )
PteComp151
ggsave("teComp151.png")

view(technoComp_farm162)
###########################################
#Plots for average annual net profit per ha
###########################################
#Create column for net profit per ha
technoComp_farm162$farmProfHa <- technoComp_farm162$avgAnnFarmProf / technoComp_farm162$landAv * 1000
technoComp_farm151$farmProfHa <- technoComp_farm151$avgAnnFarmProf / technoComp_farm151$landAv * 1000
view(technoComp_farm162)
PteComp162Ha <- technoComp_farm162 %>%
#aes tells R which variables are mapped against which visual characteristics on the canvas 
    ggplot(aes(x = landAv,
           y = farmProfHa,
           colour = Scenario))+ 
#    geom_smooth(se = F)+
#geom_point tells R to use points as the geometry (scatter plot)
    geom_point(aes(size = SST,
                    shape = BA_Sprayer_Num))+
#rename graph labels 
    labs(x = "Farm size (in ha)",
         y = "Farm profit per ha (€)")+
#Formatting of graph
#Formatting of graph tite
    ggtitle(label ="", subtitle = "Root crop farm")+
    theme(
            plot.title = element_text(face ="bold", size =12, hjust=0.5),
            plot.subtitle = element_text(face ="bold", size =12, colour ="#CC3300")
    )+
#Formatting of legend
    scale_shape_manual(name = "BA Sprayer used",
                            breaks = c("", "1"),
                            labels = c("No", "Yes"),
                            values=c(1,19))+
    scale_colour_manual(name = "Scenario &\nTechnology",
                            breaks = c("Base", "SST6m_FH", "SST27m_FH", "SST6m_FHBonus", "SST27m_FHBonus"),
                            labels = c("Base", "Scenario 1: SST6m", "Scenario 1: SST27m", "Scenario 2: SST6m", "Scenario 2: SST27m"),
                            values = c("#333333", "#006600", "#33FF00", "#000099", "#0099FF"))+
    scale_size_manual(name = "Number of SSTs used",
                            breaks = c("", "1", "2"),
                            labels = c("None", "1 Sprayer", "2 Sprayer"),
                            values = c(1.1, 1.1, 2))+           
    theme(
        panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(colour = "grey", linetype = "dashed"),
        plot.margin = margin(t =0, r =0, b=0, l=0)
    )+       
    scale_y_continuous(breaks=seq(600,1050,100), limits = c(600,1050), expand = expansion(mult = 0, add = 0))+
    scale_x_continuous(breaks=seq(50,400,50), limits = c(49,401), expand = expansion(mult = 0, add = 0))+
    theme(
        axis.title.y = element_text(face="bold", vjust=2, size = 10), 
        axis.title.x = element_text(face="bold", vjust=0.3, size = 10),
        axis.text = element_text(size = 10),
        axis.line = element_line(size = 0.3, colour ="#CC3300", linetype =1),
        axis.ticks = element_line(size = 0.5, colour ="#CC3300"),
        axis.ticks.length = unit(0.2, "cm")
    )
PteComp162Ha
dev.off()
ggsave("teCompHa162.png")
?scale_x_continuous
view(technoComp_farm151)

PteComp151Ha <- technoComp_farm151 %>%
    ggplot(aes(x = landAv,
           y = farmProfHa,
           colour = Scenario))+ 
    geom_point(aes(size = SST,
                    shape = BA_Sprayer_Num), show.legend = FALSE)+
    labs(x = "Farm size (in ha)",
         y = "Farm profit per ha (€)")+
    ggtitle(label ="", subtitle = "Cereal farm")+
    theme(
            plot.subtitle = element_text(face ="bold", size =12, colour ="#CC9900"),
    )+
    scale_shape_manual(name = "BA Sprayer used",
                            breaks = c("", "1"),
                            labels = c("No", "Yes"),
                            values=c(1,19))+
    scale_colour_manual(name = "Scenario &\nTechnology",
                            breaks = c("Base", "SST6m_FH", "SST27m_FH", "SST6m_FHBonus", "SST27m_FHBonus"),
                            labels = c("Base", "Scenario 1: SST6m", "Scenario 1: SST27m", "Scenario 2: SST6m", "Scenario 2: SST27m"),
                            values = c("#333333", "#006600", "#33FF00", "#000099", "#0099FF"))+
    scale_size_manual(name = "Number of SSTs used",
                            breaks = c("", "1", "2"),
                            labels = c("None", "1 Sprayer", "2 Sprayer"),
                            values = c(1.1, 1.1, 2))+
    theme(
        panel.background = element_rect(fill = "white"),
        panel.grid.major = element_line(colour = "grey", linetype = "dashed"),
        plot.margin = margin(t =0, r =0, b=0, l=0)
    )+       
    scale_y_continuous(breaks=seq(200,650,100), limits = c(200,650), expand = expansion(mult = 0, add = 0))+
    scale_x_continuous(breaks=seq(50,400,50), limits = c(49,400), expand = expansion(mult = 0, add = 0))+
    theme(
        axis.title.y = element_text(face="bold", vjust=2, size = 10), 
        axis.title.x = element_text(face="bold", vjust=0.3, size = 10),
        axis.text = element_text(size = 10),
        axis.line = element_line(size = 0.3, linetype =1, colour ="#CC9900"),
        axis.ticks = element_line(size = 0.5, colour ="#CC9900"),
        axis.ticks.length = unit(0.2, "cm")
    )
PteComp151Ha
ggsave("teCompHa151.png")
view(technoComp_farm151)


##################4 plots grid with average annual net profit and average annual net profit per ha 
library(patchwork)

PteCompPlotComb <- (PteComp162 + plot_spacer() + PteComp162Ha + plot_spacer() + plot_spacer() + plot_spacer() + PteComp151 + plot_spacer() + PteComp151Ha) +
    plot_layout(ncol = 3, nrow = 3) +
    plot_layout(widths=unit(c(10,1,10),"cm"), height = unit(c(8,0,8),"cm")) +
#Creation of shared legend 
    plot_layout(guides = "collect") & 
    theme(legend.position="bottom", legend.box = "horizontal", legend.direction = "vertical") &
    theme(legend.title = element_text(face = "bold", size = 9, hjust=.5)) &
    theme((legend.text = element_text(size = 9))) & 
    #theme(legend.background = element_rect(colour =1)) &
    guides(colour = guide_legend(order=1, override.aes = list(size=4)), alpha = guide_legend(order=2, override.aes = list(size=4)), shape = guide_legend(order=3, override.aes = list(size = 4))) &
    theme(legend.key.size = unit(1,"line"))
PteCompPlotComb
ggsave("teCompProf&Ha.png")


PteCompPlot <- (PteComp162 + plot_spacer() + PteComp151) +
    plot_layout(ncol = 3, nrow = 1) +
    plot_layout(widths=unit(c(10,0.1,10),"cm"), height = unit(c(14),"cm")) +
#Creation of shared legend 
    plot_layout(guides = "collect") & 
    theme(legend.position="bottom", legend.box = "horizontal", legend.direction = "vertical") &
    theme(legend.title = element_text(face = "bold", size = 9, hjust=.5)) &
    theme((legend.text = element_text(size = 9))) & 
    #theme(legend.background = element_rect(colour =1)) &
    guides(colour = guide_legend(order=1, override.aes = list(size=4)), alpha = guide_legend(order=2, override.aes = list(size=4)), shape = guide_legend(order=3, override.aes = list(size = 4))) &
    theme(legend.key.size = unit(1,"line"))
PteCompPlot
ggsave("teCompProf.png")


PteCompPlotHa <- (PteComp162Ha + plot_spacer() + PteComp151Ha) +
    plot_layout(ncol = 3, nrow = 1) +
    plot_layout(widths=unit(c(9,0.1,9),"cm"), height = unit(c(9),"cm")) +
#Creation of shared legend 
    plot_layout(guides = "collect") & 
    theme(legend.position="right", legend.box = "vertical", legend.direction = "vertical") &
    theme(legend.title = element_text(face = "bold", size = 9, hjust=.5)) &
    theme((legend.text = element_text(size = 9))) & 
    #theme(legend.background = element_rect(colour =1)) &
    guides(colour = guide_legend(order=1, override.aes = list(size=4)), alpha = guide_legend(order=2, override.aes = list(size=4)), shape = guide_legend(order=3, override.aes = list(size = 4))) &
    theme(legend.key.size = unit(1,"line")) &
    guides(size = "none")
PteCompPlotHa
ggsave("teCompProfHa.png")


rm(PteComp151)
rm(PteComp151Ha)
rm(PteComp162)
rm(PteComp162Ha)
rm(PteCompPlotComb)

rm(m162technoComp)
rm(m151technoComp)
rm(technoComp_farm151)
rm(technoComp_farm162)
