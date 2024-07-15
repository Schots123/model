########################################
#Combination of plots for farm 151 & 162
########################################
library(patchwork)
#####################Group 1: TeValue, PestEff & AlgoCosts
PsenAn_ValuePestAlgo_1 <- (PsenAn_162_teValue1 + PsenAn_162_PestEff1 + PsenAn_162_algoCosts100_1 + PsenAn_151_teValue1 + PsenAn_151_PestEff1 + PsenAn_151_algoCosts100_1)+
#controlling the grid
    plot_layout(ncol = 3, nrow = 2)+
    plot_layout(axis_titles = "collect")
PsenAn_ValuePestAlgo_1


PsenAn_ValuePestAlgo_2 <- (PsenAn_162_teValue2 + PsenAn_162_PestEff2 + PsenAn_162_algoCosts100_2 + PsenAn_151_teValue2 + PsenAn_151_PestEff2 + PsenAn_151_algoCosts100_2)+
#controlling the grid
    plot_layout(ncol = 3, nrow = 2)+
    plot_layout(axis_titles = "collect")
PsenAn_ValuePestAlgo_2


PsenAn_ValuePestAlgo <- (PsenAn_ValuePestAlgo_1 / PsenAn_ValuePestAlgo_2)+
    plot_layout(axis_titles = "collect") +
    plot_layout(guides = "collect") & 
#    theme_minimal() &
    theme(legend.position="bottom", legend.box = "horizontal", legend.direction = "vertical") &
    theme(legend.title = element_text(face = "bold", size = 11, hjust=.5)) &
    theme((legend.text = element_text(size = 3))) & 
    guides(colour = guide_legend(order=2, override.aes = list(size=3)), alpha = guide_legend(order=3, override.aes = list(size=3)), shape = guide_legend(order=4, override.aes = list(size = 3)))&
    theme(legend.key.size = unit(1.5,"line"))
#    plot_annotation(title = "Sprayer adoption ",
#        theme = theme(plot.title  = element_text(face = "bold", size = 12, hjust = 0.5)))
PsenAn_ValuePestAlgo
ggsave("PsenAn_ValuePestAlgo.png")



#####################Group 2: Time, Fuel, Repair
PsenAn_TimeFuelRep_1 <- (PsenAn_162_time1 + PsenAn_162_fuel1 + PsenAn_162_repair1 + PsenAn_151_time1 + PsenAn_151_fuel1 + PsenAn_151_repair1)+
#controlling the grid
    plot_layout(ncol = 3, nrow = 2)+
    plot_layout(axis_titles = "collect")
PsenAn_TimeFuelRep_1


PsenAn_TimeFuelRep_2 <- (PsenAn_162_time2 + PsenAn_162_fuel2 + PsenAn_162_repair2 + PsenAn_151_time2 + PsenAn_151_fuel2 + PsenAn_151_repair2)+
#controlling the grid
    plot_layout(ncol = 3, nrow = 2)+
    plot_layout(axis_titles = "collect")


#Title of grid
    #plot_annotation(title = "Sensitivity analysis for scenario 2",
    #    theme = theme(plot.title  = element_text(face = "bold", size = 12, hjust = 0.5)))+
#Creation of shared legend 
    plot_layout(guides = "collect") & 
    theme(legend.position="bottom", legend.box = "horizontal", legend.direction = "horizontal") &
    theme(legend.title = element_text(face = "bold", size = 11, hjust=.5)) &
    theme((legend.text = element_text(size = 3))) & 
    guides(colour = guide_legend(order=1, override.aes = list(size=3)), alpha = guide_legend(order=2, override.aes = list(size=3)), shape = guide_legend(order=3, override.aes = list(size = 3)))&
    theme(legend.key.size = unit(1.5,"line"))
PsenAn_TimeFuelRep_2


PsenAn_TimeFuelRep <- (PsenAn_TimeFuelRep_1 / PsenAn_TimeFuelRep_2)+
    plot_layout(axis_titles = "collect") +
    plot_layout(guides = "collect") & 
#    theme_minimal() &
    theme(legend.position="bottom", legend.box = "horizontal", legend.direction = "vertical") &
    theme(legend.title = element_text(face = "bold", size = 11, hjust=.5)) &
    theme((legend.text = element_text(size = 3))) & 
    guides(colour = guide_legend(order=2, override.aes = list(size=3)), alpha = guide_legend(order=3, override.aes = list(size=3)), shape = guide_legend(order=4, override.aes = list(size = 3)))&
    theme(legend.key.size = unit(1.5,"line"))
#    plot_annotation(title = "Sprayer adoption ",
#        theme = theme(plot.title  = element_text(face = "bold", size = 12, hjust = 0.5)))
PsenAn_TimeFuelRep
ggsave("PsenAn_TimeFuelRep.png")



#####################Group 3: Algorithm and annual fee
PsenAn_algoAnnFee_1 <- (PsenAn_162_algoCosts50_1 + PsenAn_162_annFee100_1 + PsenAn_162_annFee50_1 + PsenAn_151_algoCosts50_1 + PsenAn_151_annFee100_1 + PsenAn_151_annFee50_1)+
#controlling the grid
    plot_layout(ncol = 3, nrow = 2)+
    plot_layout(axis_titles = "collect")
PsenAn_algoAnnFee_1

PsenAn_algoAnnFee_2 <- (PsenAn_162_algoCosts50_2 + PsenAn_162_annFee100_2 + PsenAn_162_annFee50_2 + PsenAn_151_algoCosts50_2 + PsenAn_151_annFee100_2 + PsenAn_151_annFee50_2)+
#controlling the grid
    plot_layout(ncol = 3, nrow = 2)+
    plot_layout(axis_titles = "collect")
PsenAn_algoAnnFee_2

PsenAn_algoAnnFee <- (PsenAn_algoAnnFee_1 / PsenAn_algoAnnFee_2)+
    plot_layout(axis_titles = "collect") +
    plot_layout(guides = "collect") & 
#    theme_minimal() &
    theme(legend.position="bottom", legend.box = "horizontal", legend.direction = "vertical") &
    theme(legend.title = element_text(face = "bold", size = 11, hjust=.5)) &
    theme((legend.text = element_text(size = 3))) & 
    guides(colour = guide_legend(order=2, override.aes = list(size=3)), alpha = guide_legend(order=3, override.aes = list(size=3)), shape = guide_legend(order=4, override.aes = list(size = 3)))&
    theme(legend.key.size = unit(1.5,"line"))
#    plot_annotation(title = "Sprayer adoption ",
#        theme = theme(plot.title  = element_text(face = "bold", size = 12, hjust = 0.5)))
PsenAn_algoAnnFee
ggsave("PsenAn_algoAnnFee.png")

######################################################################
#Combining groups of scenarios to have both farms in one combined plot
######################################################################
