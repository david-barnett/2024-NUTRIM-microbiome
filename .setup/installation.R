
# Install sometimes pesky Bioc dependencies up front
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install(c("phyloseq", "microbiome", "ComplexHeatmap"), update = FALSE)

# Install latest microViz
install.packages(
  "microViz",
  repos = c(davidbarnett = "https://david-barnett.r-universe.dev", getOption("repos"))
)

# Install suggested dependencies - necessary for workshop
install.packages("ggraph") # for taxatree_plots()
install.packages("DT") # for tax_fix_interactive()
install.packages("ggtext") # for rotated text on ord_plot PCA figures
# install.packages("GUniFrac") # for (generalised) unifrac distances

# more useful stuff
install.packages("tidyverse")
install.packages("writexl")
install.packages("readxl")
install.packages("broom")
install.packages("here")
install.packages("patchwork")
install.packages("ggstatsplot")


