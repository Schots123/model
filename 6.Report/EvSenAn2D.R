######################################################
#Combination of 2 dimensional plots for farm 151 & 162
######################################################
library(patchwork)

PsenAn2D <- (PsenAn_162_PestEff1 + plot_spacer() + PsenAn_162_repair1 + plot_spacer() + PsenAn_162_time1 + plot_spacer() + PsenAn_162_numPassag1 +
                        plot_spacer() + plot_spacer() + plot_spacer() + plot_spacer() + plot_spacer() + plot_spacer() +  plot_spacer() + 
                        PsenAn_162_PestEff2 + plot_spacer() + PsenAn_162_repair2 + plot_spacer() + PsenAn_162_time2 + plot_spacer() + PsenAn_162_numPassag2 +
                        plot_spacer() + plot_spacer() + plot_spacer() + plot_spacer() + plot_spacer() + plot_spacer() +  plot_spacer() + 
                        PsenAn_151_PestEff2 + plot_spacer() + PsenAn_151_repair2 + plot_spacer() + PsenAn_151_numPassag1 + plot_spacer() + PsenAn_151_numPassag2 +
    plot_layout(ncol = 7, nrow = 5) +
    plot_layout(widths=unit(c(3.5,-0.2,3.5,-0.2,3.5,-0.2,3.5,-0.2,3.5),"cm"), height = unit(c(3.5,-0.5,3.5,-0.5,3.5),"cm")) +
    #plot_layout(axis_titles = "collect") +
    plot_layout(guides = "collect")) &
    theme(legend.position="right", legend.box = "vertical", legend.direction = "vertical") &
    theme(legend.title = element_text(face = "bold", size = 8, hjust=0.5)) &
    theme(legend.text = element_text(size = 8)) &
    theme(legend.key.size = unit(0.5, "cm")) &
    theme(legend.spacing.x = unit(0.2, "cm"))
PsenAn2D
ggsave("PsenAn2D.png")




PsenAn2DApp <- (PsenAn_162_fuel1 + plot_spacer() + PsenAn_162_fuel2 + plot_spacer() + PsenAn_151_fuel1 + plot_spacer() + PsenAn_151_fuel2 +
                        plot_spacer() + plot_spacer() + plot_spacer() + plot_spacer() + plot_spacer() + plot_spacer() +  plot_spacer() + 
                        PsenAn_151_PestEff1 + plot_spacer() + PsenAn_151_repair1 + plot_spacer() + PsenAn_151_time1 + plot_spacer() + PsenAn_151_time2 +
    plot_layout(ncol = 7, nrow = 3) +
    plot_layout(widths=unit(c(3.5,-0.2,3.5,-0.2,3.5,-0.2,3.5,-0.2,3.5),"cm"), height = unit(c(3.5,-0.5,3.5),"cm")) +
    #plot_layout(axis_titles = "collect") +
    plot_layout(guides = "collect")) &
    theme(legend.position="right", legend.box = "vertical", legend.direction = "vertical") &
    theme(legend.title = element_text(face = "bold", size = 8, hjust=0.5)) &
    theme(legend.text = element_text(size = 8)) &
    theme(legend.key.size = unit(0.5, "cm")) &
    theme(legend.spacing.x = unit(0.2, "cm"))
PsenAn2DApp
ggsave("PsenAn2DApp.png")
dev.off()
