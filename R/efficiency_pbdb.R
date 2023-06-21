# Header ----------------------------------------------------------------
# Project: GPM-reconstruction-grids
# File name: efficiency_pbdb.R
# Last updated: 2023-06-20
# Author: Lewis A. Jones
# Email: LewisA.Jones@outlook.com
# Repository: https://github.com/LewisAJones/GPM-reconstruction-grids
# Load libraries --------------------------------------------------------
library(h3jsr)

# Load data -------------------------------------------------------------
df <- readRDS("./grids/ME21/resolution_4.RDS")
pbdb <- read.csv("./data/pbdb_data.csv")
pbdb$age <- (pbdb$max_ma + pbdb$min_ma) / 2

# Benchmark -------------------------------------------------------------

benchmark <- lapply(1:100, function(x) {
  start <- Sys.time()
  # Assign h3 address to fossil occurrence data 
  pbdb$h3 <- point_to_cell(input = pbdb[ , c("lng", "lat")], res = 2)
  # Now let's match!
  # First we get the appropriate rows
  row_match <- match(x = pbdb$h3, table = df$h3)
  # Next, the appropriate columns
  lng_match <- match(x = paste0("lng_", pbdb$age), table = colnames(df))
  lat_match <- match(x = paste0("lat_", pbdb$age), table = colnames(df))
  # Get the coordinates
  p_lng <- sapply(1:length(row_match), function(j) df[row_match[j], lng_match[j]])
  p_lat <- sapply(1:length(row_match), function(j) df[row_match[j], lat_match[j]])
  # Bind data
  coords <- cbind(p_lng, p_lat)
  # Add the coordinates!
  test <- cbind.data.frame(pbdb, coords)
  end <- as.numeric(Sys.time() - start)
  end
})
bench <- quantile(x = unlist(benchmark), prob = c(0.025, 0.5, 0.975))
bench <- round(bench, 3)
message(paste0("For ", nrow(pbdb), " collections, it takes ", bench[2],
               " seconds."))
