########################################
#Combination of plots for farm 151 & 162
########################################
library(patchwork)
#####################Group 1: TeValue, PestEff & AlgoCosts
PsenAn_ValuePestAlgo <- (PsenAn_162_teValue1 + plot_spacer() + PsenAn_162_PestEff1 + plot_spacer() + PsenAn_162_algoCosts100_1 + 
                        PsenAn_151_teValue1 + plot_spacer() + PsenAn_151_PestEff1 + plot_spacer() + PsenAn_151_algoCosts100_1 + 
                        plot_spacer() + plot_spacer() + plot_spacer() + plot_spacer() + plot_spacer() +
                        PsenAn_162_teValue2 + plot_spacer() + PsenAn_162_PestEff2 + plot_spacer() + PsenAn_162_algoCosts100_2 + 
                        PsenAn_151_teValue2 + plot_spacer() + PsenAn_151_PestEff2 + plot_spacer() + PsenAn_151_algoCosts100_2) +
    plot_layout(ncol = 5, nrow = 5) +
    plot_layout(widths=unit(c(4,0.05,4,0.05,4),"cm"), height = unit(c(3.5,3.5,0,3.5,3.5),"cm")) +
    plot_layout(axis_titles = "collect") +
    plot_layout(guides = "collect") & 
#    theme_minimal() &
    theme(legend.position="bottom", legend.box = "horizontal", legend.direction = "vertical") &
    theme(legend.title = element_text(face = "bold", size = 10, hjust=.5)) &
    theme((legend.text = element_text(size = 2.5))) & 
    guides(colour = guide_legend(order=1, override.aes = list(size=2.5)), shape = guide_legend(order=2, override.aes = list(size = 2.5)))&
    theme(legend.key.size = unit(1,"line")) & 
    guides(alpha = "none")
PsenAn_ValuePestAlgo
ggsave("PsenAn_ValuePestAlgo.png")



#####################Group 2: Time, Fuel, Repair
PsenAn_TimeFuelRep <- (PsenAn_162_time1 + plot_spacer() + PsenAn_162_fuel1 + plot_spacer() + PsenAn_162_repair1 + 
                       PsenAn_151_time1 + plot_spacer() + PsenAn_151_fuel1 + plot_spacer() + PsenAn_151_repair1 +
                       plot_spacer() + plot_spacer() + plot_spacer() + plot_spacer() + plot_spacer() +
                       PsenAn_162_time2 + plot_spacer() + PsenAn_162_fuel2 + plot_spacer() + PsenAn_162_repair2 + 
                       PsenAn_151_time2 + plot_spacer() + PsenAn_151_fuel2 + plot_spacer() + PsenAn_151_repair2) +
    plot_layout(ncol = 5, nrow = 5) +
    plot_layout(widths=unit(c(4,0.05,4,0.05,4),"cm"), height = unit(c(3.5,3.5,0,3.5,3.5),"cm")) +
    plot_layout(axis_titles = "collect") +
    plot_layout(guides = "collect") & 
#    theme_minimal() &
    theme(legend.position="bottom", legend.box = "horizontal", legend.direction = "vertical") &
    theme(legend.title = element_text(face = "bold", size = 10, hjust=.5)) &
    theme((legend.text = element_text(size = 2.5))) & 
    guides(colour = guide_legend(order=2, override.aes = list(size=2.5)), alpha = guide_legend(order=3, override.aes = list(size=2.5)), shape = guide_legend(order=4, override.aes = list(size = 2.5)))&
    theme(legend.key.size = unit(1,"line")) & 
    guides(alpha = "none")
#    plot_annotation(title = "Sprayer adoption ",
#        theme = theme(plot.title  = element_text(face = "bold", size = 12, hjust = 0.5)))
PsenAn_TimeFuelRep
ggsave("PsenAn_TimeFuelRep.png")



#####################Group 3: Algorithm and annual fee
PsenAn_algoAnnFee <- (PsenAn_162_algoCosts50_1 + plot_spacer() + PsenAn_162_annFee100_1 + plot_spacer() + PsenAn_162_annFee50_1 + 
                      PsenAn_151_algoCosts50_1 + plot_spacer() + PsenAn_151_annFee100_1 + plot_spacer() + PsenAn_151_annFee50_1 +
                      plot_spacer() + plot_spacer() + plot_spacer() + plot_spacer() + plot_spacer() +
                      PsenAn_162_algoCosts50_2 + plot_spacer() + PsenAn_162_annFee100_2 + plot_spacer() + PsenAn_162_annFee50_2 + 
                      PsenAn_151_algoCosts50_2 + plot_spacer() + PsenAn_151_annFee100_2 + plot_spacer() + PsenAn_151_annFee50_2) +
    plot_layout(ncol = 5, nrow = 5) +
    plot_layout(widths=unit(c(4,0.05,4,0.05,4),"cm"), height = unit(c(3.5,3.5,0,3.5,3.5),"cm")) +
    plot_layout(axis_titles = "collect") +
    plot_layout(guides = "collect") & 
#    theme_minimal() &
    theme(legend.position="bottom", legend.box = "horizontal", legend.direction = "vertical") &
    theme(legend.title = element_text(face = "bold", size = 10, hjust=.5)) &
    theme((legend.text = element_text(size = 2.5))) & 
    guides(colour = guide_legend(order=2, override.aes = list(size=2.5)), alpha = guide_legend(order=3, override.aes = list(size=2.5)), shape = guide_legend(order=4, override.aes = list(size = 2.5)))&
    theme(legend.key.size = unit(1,"line"))
PsenAn_algoAnnFee
ggsave("PsenAn_algoAnnFee.png")
