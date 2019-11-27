getwd()
library("jsonlite")
library('tidyverse')
library('ggvoronoi')
data_file <- fromJSON('../MData.json')
summary(data_file$location$zip)
plot(data_file$location$geo$lon, data_file$location$geo$lat)
dat <- data.frame()
dat <- data.frame(data_file$name, data_file$location$geo$lon,
                  data_file$location$geo$lat, data_file$location$address,
                  data_file$location$zip)
colnames(dat) <- c("name", "lon", "lat", "address", "zip")
str(dat)

ggplot(dat,aes(lon, lat)) +
  stat_voronoi(geom = "path") +
  geom_point()

write.csv(dat, file = "../data/data.csv")


