# Header ----------------------------------------------------------------
# Project: GPM-reconstruction-grids
# File name: efficiency_graph.R
# Last updated: 2023-06-19
# Author: Lewis A. Jones
# Email: LewisA.Jones@outlook.com
# Repository: https://github.com/LewisAJones/GPM-reconstruction-grids
# Load libraries --------------------------------------------------------
library(ggplot2)
library(dplyr)
library(h3jsr)

# Load table ------------------------------------------------------------
df <- readRDS("./grids/ME21/resolution_4.RDS")

# Sample size sequence --------------------------------------------------
# Generate logarithmic sequence
seq <- exp(seq(from = log(1), to = log(1000000), length.out = 7))
#seq <- seq(from = 1, to = 1000000, length.out = 10)

# Sample rows -----------------------------------------------------------
samp_df <- lapply(seq, function(x) sample_n(tbl = df[, c("lng", "lat")],
                                            size = x, replace = TRUE))

# Assign age to occurrences ---------------------------------------------
ages <- 1:540
samp_df <- lapply(samp_df, function(x) {
  x$age <- sample(x = ages, size = nrow(x), replace = TRUE)
  x
})

# Get palaecoordinates -------------------------------------------------
benchmark <- lapply(samp_df, function(x) {
  time <- lapply(1:100, function (i) {
    start <- Sys.time()
    # Assign h3 address to fossil occurrence data 
    x$h3 <- point_to_cell(input = x[ , c("lng", "lat")], res = 2)
    # Now let's match!
    # First we get the appropriate rows
    row_match <- match(x = x$h3, table = df$h3)
    # Next, the appropriate columns
    lng_match <- match(x = paste0("lng_", x$age), table = colnames(df))
    lat_match <- match(x = paste0("lat_", x$age), table = colnames(df))
    # Get the coordinates
    p_lng <- sapply(1:length(row_match), function(j) df[row_match[j], lng_match[j]])
    p_lat <- sapply(1:length(row_match), function(j) df[row_match[j], lat_match[j]])
    # Bind data
    coords <- cbind.data.frame(p_lng, p_lat)
    # Add the coordinates!
    x <- cbind.data.frame(x, coords)
    end <- as.numeric(Sys.time() - start)
  })
  n <- nrow(x)
  names(n) <- "n"
  cat(n)
  append(n, quantile(x = unlist(time), prob = c(0.025, 0.5, 0.975)))
})
# Bind data
benchmark <- bind_rows(benchmark)
colnames(benchmark) <- c("n", "lci", "median", "uci")

ggplot(data = benchmark, aes(x = n, y = median, ymin = lci, ymax = uci)) +
  geom_ribbon(fill = "#016c59", alpha = 0.5) +
  geom_line(linewidth = 1, colour = "#016c59") +
  geom_point(fill = "#016c59", colour = "black", shape = 21) +
  scale_x_continuous(trans = "log10") +
  scale_y_continuous(trans = "log10") +
  labs(x = "Number of points", y = "Time (s)") +
  theme_bw()

# Save ------------------------------------------------------------------
ggsave("./figures/efficiency_graph.png",
       height = 100, width = 100, units = "mm",
       dpi = 600)

 