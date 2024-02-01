# Header ----------------------------------------------------------------
# Project: GPM-reconstruction-grids
# File name: grid_plot.R
# Last updated: 2023-06-20
# Author: Lewis A. Jones
# Email: LewisA.Jones@outlook.com
# Repository: https://github.com/LewisAJones/GPM-reconstruction-grids
# Load libraries --------------------------------------------------------
library(h3jsr)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)
library(ggplot2)
library(ggpubr)
library(dplyr)

# World -----------------------------------------------------------------
world <- ne_countries(scale = "medium", returnclass = "sf")
grid <- get_res0()
grid2 <- get_children(h3_address = grid, res = 2)
# Cell to polygon
grid2 <- cell_to_polygon(input = grid2)

country <- ne_countries(country = "brazil", 
                        returnclass = "sf", scale = "large")

globe <- ggplot() +
  geom_sf(data = world, colour = "darkgrey", fill = "darkgrey") +
  geom_sf(data = country, colour = "#7570B3", fill = "#7570B3") +
  geom_sf(data = grid2, fill = NA, colour = "#1B9E77") +
  #coord_sf(crs= "+proj=ortho +lat_0=0 +lon_0=0") +
  coord_sf(crs = "+proj=laea +y_0=0 +lon_0=0 +lat_0=0 +ellps=WGS84 +no_defs") +
  #coord_sf(crs = st_crs("ESRI:54030")) +
  theme_void() +
  theme(panel.border = element_blank())
globe
# Country ---------------------------------------------------------------
# Get grids within country for resolutions 2, 3, and 4
grid2 <- h3jsr::polygon_to_cells(country, res = 2)
grid3 <- h3jsr::polygon_to_cells(country, res = 3)
grid4 <- h3jsr::polygon_to_cells(country, res = 4)
grid2 <- cell_to_polygon(grid2)
grid3 <- cell_to_polygon(grid3)
grid4 <- cell_to_polygon(grid4)
# Make data
country <- ggplot() +
  geom_sf(data = country, colour = "darkgrey", fill = "darkgrey") +
  geom_sf(data = grid4, fill = "#7570B3", colour = "black", alpha = 1) +
  geom_sf(data = grid3, fill = "#D95F02", colour = "black", alpha = 0.5) +
  geom_sf(data = grid2, fill = "#1B9E77", colour = "black", alpha = 0.5) +
  theme_void() 

# Save plot -------------------------------------------------------------
ggarrange(globe, country, labels = "auto")
ggsave("./figures/grid_plot.png", units = "mm", width = 150, height = 75, dpi = 600)

