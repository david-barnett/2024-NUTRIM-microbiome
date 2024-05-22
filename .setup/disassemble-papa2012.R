library(microViz)
library(readr)
library(here)
library(phyloseq)
library(corncob)
library(writexl)
library(dplyr)

ibd
# samdat_tbl(ibd) # mangled
# ?ibd

data("ibd_phylo_sample")
data("ibd_phylo_taxa")
data("ibd_phylo_otu")

ps <- ibd

taxtab <- ibd %>% tax_mutate(Species = NULL) %>% tt_get()
otu <- as.data.frame(t(ibd_phylo_otu))
all.equal(rownames(taxtab), colnames(otu)) # sanity check

# put OTU table in descending abundance order
colnames(otu) <- paste0("OTU_", sprintf("%05d", rank(-colSums(otu), ties.method = "first")))
taxtab <- cbind(OTU = colnames(otu), taxtab)
taxtab <- taxtab %>% as.data.frame %>% arrange(OTU) %>% as_tibble()
otu <- otu[, taxtab$OTU]
otu <- cbind(sample = ibd_phylo_sample$sample, otu)
otu$sample <- gsub(x = otu$sample, pattern = "-", replacement = "_")

meta <- cbind(ID = rownames(ibd_phylo_sample), ibd_phylo_sample)

# write tables to disk
setup_data_dir <- here(".setup", "data_papa2012")
dir.create(setup_data_dir)
write_tsv(otu, file = here(setup_data_dir, "papa2012_OTU_count_table.txt"))
write_tsv(as.data.frame(taxtab), file = here(setup_data_dir, "papa2012_taxonomy_table.txt"))
write_xlsx(meta, path = here(setup_data_dir, "papa2012_metadata_messy.xlsx"))
# messy metadata needs some manual cleaning - somehow the source has entries mixed up across columns.


