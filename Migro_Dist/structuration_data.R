getwd()
library("jsonlite")
library('tidyverse')
library('ggvoronoi')
data_file <- fromJSON('../MyMStores.json')
summary(data_file$location$zip)
plot(data_file$location$geo$lon, data_file$location$geo$lat)
dat <- data.frame()
dat <- data.frame(data_file$name, data_file$type,
                  data_file$location$geo$lon,
                  data_file$location$geo$lat, data_file$location$address,
                  data_file$location$zip)
colnames(dat) <- c("name", "type", "lon", "lat", "address", "zip")
str(dat)
summary(dat$type)
plot(data_file$location$geo$lon, data_file$location$geo$lat)

ggplot(dat,aes(lon, lat)) +
  stat_voronoi(geom = "path") +
  geom_point()

summary(dat[dat[,2] != 'voi',]$type)

fin_dat <- dat %>%
  filter(!type %in% c('alna', 'dmp', 'fm', 'mr', 'mta', 'spez' ,'voi'))

summary(fin_dat$type)

write.csv(fin_dat, file = "../final_data.csv")



