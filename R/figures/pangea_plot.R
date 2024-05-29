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
df <- readRDS("./grids/TC16/resolution_2.RDS")
gpm <- read_sf("https://gws.gplates.org/reconstruct/static_polygons/?&time=1&model=TorsvikCocks2017&anchor_plate_id=1")
gpm_rot <- read_sf("https://gws.gplates.org/reconstruct/static_polygons/?&time=250&model=TorsvikCocks2017&anchor_plate_id=1")
# Prepare data ----------------------------------------------------------
# Set up bounding box
ras <- raster::raster(res = 5, val = 1)
ras <- rasterToPolygons(x = ras, dissolve = TRUE)
# Robinson projection
bb <- sf::st_as_sf(x = ras)
bb <- st_transform(x = bb, crs = sf::st_crs(4326))

# Modern coordinates
xy <- df[, c("lng", "lat")]
xy <- na.omit(xy)
xy <- st_as_sf(x = xy, coords = c("lng", "lat"), crs = sf::st_crs(4326))

# Reconstructed coordinates
xy_rot <- df[, c("lng_250", "lat_250")]
xy_rot <- na.omit(xy_rot)
xy_rot <- st_as_sf(x = xy_rot, coords = c("lng_250", "lat_250"), crs = sf::st_crs(4326))

bbox <- st_graticule(crs = st_crs("ESRI:54030"), lat = c(-89.9, 89.9), lon = c(-179.9, 179.9))

modern <- ggplot() +
  geom_sf(data = bb, fill = "lightblue", colour = NA) +
  geom_sf(data = gpm, fill = "darkgrey", colour = "black", alpha = 1) +
  geom_sf(data = xy, fill = "#1B9E77", colour = "black", size = 1, shape = 21) +
  geom_sf(data = bbox) +
  coord_sf(crs = sf::st_crs("ESRI:54030")) +
  theme_void() +
  theme(
    plot.margin = margin(5, 5, 5, 5, "mm"),
    axis.text = element_blank(),
    plot.title = element_text(hjust = 0.5))

palaeo <- ggplot() +
  geom_sf(data = bb, fill = "lightblue", colour = NA) +
  geom_sf(data = gpm_rot, fill = "darkgrey", colour = "black", alpha = 1) +
  geom_sf(data = xy_rot, fill = "#1B9E77", colour = "black", size = 1, shape = 21) +
  geom_sf(data = bbox) +
  coord_sf(crs = sf::st_crs("ESRI:54030")) +
  theme_void() +
  theme(
    plot.margin = margin(5, 5, 5, 5, "mm"),
    axis.text = element_blank(),
    plot.title = element_text(hjust = 0.5))

# Save ------------------------------------------------------------------
ggarrange(modern, palaeo, labels = "auto", nrow = 2, font.label = list(size = 30))
ggsave("./figures/pangea_plot.png", units = "mm", height = 150, width = 150,
       dpi = 600, scale = 2)
ggsave("./figures/pangea_plot.pdf", units = "mm", height = 150, width = 150,
       dpi = 600, scale = 2)


