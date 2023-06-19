# Get models
models <- list.files("./grids/", full.names = TRUE)
# Drop H3
models <- models[-which(models == "./grids//H3")]

for (i in models) {
  files <- list.files(i, full.names = TRUE)
  for (j in files) {
    df <- read.csv(j)
    df[, c("lat", "lng")] <- df[, c("lng", "lat")]
    colnames(df)[2:3] <- c("lng", "lat")
    write.csv(df, j, row.names = FALSE)
    j <- sub(pattern = ".csv", replacement = ".RDS", x = j)
    saveRDS(df, j, compress = "xz")
  }
}
