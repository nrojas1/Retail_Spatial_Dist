library('sp')
library('raster')
library('rasterVis')
library('units')
library('maptools')
library('rgeos')
library('zoom')
library('spatstat')
library('sf')
library('spatial')

set.seed(1000101)
migros <- read.csv('../final_data.csv')
# grille <- readShapePoints(fn = '../GIS/GRID_CLIP.shp')
# suisse <- rgdal::readOGR('../GIS/CH_POLY2.shp', pointDropZ = T)

u <- ppp(migros$lon, migros$lat, c(5.9, 10), c(45.7, 47.9))
plot(u)
zm()
plot(distmap(u))
contour(distmap(u))

#####
N <- 100
p <- runifpoint(n = N, win = u)
X <- distfun(u)(p)
d <- pairdist(u)
Nconfig <- u[[2]] # nombre de migros
dplus <- d + max(d) * diag(Nconfig) # dplus est symetrique
# diag represente max distance entre deux migros.
index <- sample(c(1:Nconfig), size = N, replace = T)
W <- matrix(0, N, 1)

for (i in 1:N) {
  W[i] <- min(dplus[index[i],]) # W est la distance du plus proche voisin
}
H <- sum(X^2)/sum(W^2)


##### Distribution poissionniene
# Lois de F
H
qf(p = 0.05/2, df1 = 2*N, df2 = 2*N, lower.tail = F)
qf(p = 0.05/2, df1 = 2*N, df2 = 2*N, lower.tail = T) # densite

# Loi normale
Htilde <- sum(X^2/(X^2 + W^2))/N
Htilde
qnorm(p = 0.05/2, mean = 0.5, sd = 1/sqrt(12*N), lower.tail = F) # test normal d'uniformité
qnorm(p = 0.05/2, mean = 0.5, sd = 1/sqrt(12*N), lower.tail = T) # test normal d'uniformité

# K de Ripley
K <- Kest(u)
plot(K)

# Indice de regroupement ICS
fit <- clusterfit(K, 'Cauchy')
if ( interactive() ) {
  plot(fit)
}
#### plot #####
plotdf <- data.frame(u$x, u$y)
plotdf$Colour = 'black'
plotdf[index,]$Colour <- 'red'

a <- ggplot(plotdf, aes(u.x, u.y)) +
  geom_point()
a

plot(plotdf$u.x,plotdf$u.y, col = plotdf$Colour)
plot(u[index,], col = )
