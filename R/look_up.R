# Header ----------------------------------------------------------------
# Project: GPM-reconstruction-grids
# File name: look_up.R
# Last updated: 2023-11-03
# Author: Lewis A. Jones
# Email: LewisA.Jones@outlook.com
# Repository: https://github.com/LewisAJones/GPM-reconstruction-grids
# -----------------------------------------------------------------------

# This script provides an example of how to generate palaeocoordinates for
# fossil collections using the reconstruction files.

# Load libraries --------------------------------------------------------
#install.packages("h3jsr")
library(h3jsr)

# Load table ------------------------------------------------------------
# Let's use the Merdith et al. (2021) reconstruction file at h3 resolution 
# 2 for an example
df <-readRDS(file = "./data/resolution_2.RDS")

# Load fossil data ------------------------------------------------------
# Let's load example fossil collection data from the Paleobiology Database
pbdb <- read.csv(file = "./data/pbdb_data.csv")

# Assign h3 address to fossil collection data ---------------------------
pbdb$h3 <- point_to_cell(input = pbdb[ , c("lng", "lat")], res = 2)

# Match palaeocoordinates -----------------------------------------------
# We need an age estimate for our fossil collections
# Let's use the age midpoint for simplicity
pbdb$age <- (pbdb$min_ma + pbdb$max_ma) / 2
# And it should be rounded to the nearest whole number
pbdb$age <- round(pbdb$age)
# Now let's match!
# First we get the appropriate rows
row_match <- match(x = pbdb$h3, table = df$h3)
# Next, the appropriate columns
lng_match <- match(x = paste0("lng_", pbdb$age), table = colnames(df))
lat_match <- match(x = paste0("lat_", pbdb$age), table = colnames(df))
# Get the coordinates
p_lng <- sapply(1:length(row_match), function(x) df[row_match[x], lng_match[x]])
p_lat <- sapply(1:length(row_match), function(x) df[row_match[x], lat_match[x]])
# Bind data
coords <- cbind(p_lng, p_lat)
# Add the coordinates!
pbdb <- cbind.data.frame(pbdb, coords)

