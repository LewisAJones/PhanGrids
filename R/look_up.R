# Header ----------------------------------------------------------------
# Project: GPM-reconstruction-grids
# File name: look_up.R
# Last updated: 2023-06-19
# Author: Lewis A. Jones
# Email: LewisA.Jones@outlook.com
# Repository: https://github.com/LewisAJones/GPM-reconstruction-grids
# -----------------------------------------------------------------------

# This script provides an example of how to generate palaeocoordinates for
# fossil occurrences using the reconstruction files.

# Load libraries --------------------------------------------------------
#install.packages("h3jsr")
library(h3jsr)
#install.packages("palaeoverse")
library(palaeoverse)

# Load table ------------------------------------------------------------
# Let's use the Merdith et al. (2021) reconstruction file at h3 resolution 
# 2 for an example
df <-readRDS(file = "./R/resolution_2.RDS")

# Load fossil data ------------------------------------------------------
# Let's load example fossil occurrence data from the palaeoverse R package
data("tetrapods")

# Assign h3 address to fossil occurrence data ---------------------------
tetrapods$h3 <- point_to_cell(input = tetrapods[ , c("lng", "lat")], res = 2)

# Match palaeocoordinates -----------------------------------------------
# We need an age estimate for our fossil occurrence
# Let's use the age midpoint for simplicity
tetrapods$age <- (tetrapods$min_ma + tetrapods$max_ma) / 2
# And it should be rounded to the nearest whole number
tetrapods$age <- round(tetrapods$age)
# Now let's match!
# First we get the appropriate rows
row_match <- match(x = tetrapods$h3, table = df$h3)
# Next, the appropriate columns
lng_match <- match(x = paste0("lng_", tetrapods$age), table = colnames(df))
lat_match <- match(x = paste0("lat_", tetrapods$age), table = colnames(df))
# Get the coordinates
p_lng <- sapply(1:length(row_match), function(x) df[row_match[x], lng_match[x]])
p_lat <- sapply(1:length(row_match), function(x) df[row_match[x], lat_match[x]])
# Bind data
coords <- cbind.data.frame(p_lng, p_lat)
# Add the coordinates!
tetrapods <- cbind.data.frame(tetrapods, coords)

