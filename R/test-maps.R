# Header ----------------------------------------------------------------
# Project: GPM-reconstruction-grids
# File name: pangea_plot.R
# Last updated: 2023-06-21
# Author: Lewis A. Jones
# Email: LewisA.Jones@outlook.com
# Repository: https://github.com/LewisAJones/GPM-reconstruction-grids
# Load libraries --------------------------------------------------------
library(h3jsr)
library(ggplot2)
library(ggpubr)
library(sf)
library(raster)

# Load data -------------------------------------------------------------
df <- readRDS("./grids/SC16/resolution_2.RDS")

ages <- seq(10, 540, 10)

# Prepare data ----------------------------------------------------------
# Set up bounding box
ras <- raster::raster(res = 5, val = 1)
ras <- rasterToPolygons(x = ras, dissolve = TRUE)
# Robinson projection
bb <- sf::st_as_sf(x = ras)
bb <- st_transform(x = bb, crs = sf::st_crs(4326))

# Bounding box
bbox <- st_graticule(crs = st_crs("ESRI:54030"), lat = c(-89.9, 89.9), lon = c(-179.9, 179.9))

for (i in ages) {
  url <- paste0("https://gws.gplates.org/reconstruct/coastlines/?&",
                "time=", i, "&model=PALEOMAP")

  gpm_rot <- read_sf(url)
  # Reconstructed coordinates
  cols <- c(paste0("lng_", i), paste0("lat_", i))
  xy_rot <- df[, cols]
  xy_rot <- na.omit(xy_rot)
  xy_rot <- st_as_sf(x = xy_rot, coords = cols, crs = sf::st_crs(4326))
  
  ggplot() +
    geom_sf(data = bb, fill = "lightblue", colour = NA) +
    geom_sf(data = gpm_rot, fill = "darkgrey", colour = "black", alpha = 1) +
    geom_sf(data = xy_rot, fill = "#1B9E77", colour = "black", size = 1, shape = 21) +
    geom_sf(data = bbox) +
    coord_sf(crs = sf::st_crs("ESRI:54030")) +
    labs(title = paste0("SC16 - ", i, " Ma")) +
    theme_void() +
    theme(
      plot.margin = margin(5, 5, 5, 5, "mm"),
      axis.text = element_blank(),
      plot.title = element_text(hjust = 0.5))
  
  # Save ------------------------------------------------------------------
  file <- paste0("./figures/SC16/plot_", i, ".png")
  ggsave(file, units = "mm", height = 75, width = 150,
         dpi = 600, scale = 2, bg = "white")
}
