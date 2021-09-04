install.packages("tmap")
install.packages("rworldmap")
install.packages("sp")
install.packages("sf")


library(sp)
library(rworldmap)

library(sf)
library(tmap)
library("tidyverse")

coords2country = function(points)
{  
  countriesSP <- getMap(resolution='low')
  #countriesSP <- getMap(resolution='high') #you could use high res map from rworldxtra if you were concerned about detail
  
  # convert our list of points to a SpatialPoints object
  
  # pointsSP = SpatialPoints(points, proj4string=CRS(" +proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs +towgs84=0,0,0"))
  
  #setting CRS directly to that from rworldmap
  pointsSP = SpatialPoints(points, proj4string=CRS(proj4string(countriesSP)))  
  
  
  # use 'over' to get indices of the Polygons object containing each point 
  indices = over(pointsSP, countriesSP)
  
  # return the ADMIN names of each country
  indices$ADMIN  
  #indices$ISO3 # returns the ISO3 code 
  #indices$continent   # returns the continent (6 continent model)
  #indices$REGION   # returns the continent (7 continent model)
}

# Loading in the witches data
witches <- read.csv(file = 'witches/location_data.csv') %>% 
  filter(event == "Witchcraft trial")
countries <- as.data.frame(coords2country(witches[2:3])) #setting it as countries
countries_freq <- (data.frame(table(countries))) 

# Loading the map
data("World")

europe <- World %>%
  filter(continent == "Europe") %>% 
  filter(name != "Russia") %>% 
  left_join(countries_freq, by = c("name" = "countries")) %>% 
  replace_na(list(Freq = 0))

europe_geom <- st_geometry(europe)
europe_geom[[14]][[1]] <- NULL
europe <- st_set_geometry(europe, europe_geom)

tm_shape(europe) +
  tm_fill("Freq", legend.show = FALSE) +
  tm_borders()

# Trying to get france's overseas territories to not show up
# france <- World %>%
#   filter(continent == "Europe") %>%
#   filter(name %in% c("France")) %>%
#   left_join(countries_freq, by = c("name" = "countries")) %>%
#   replace_na(list(Freq = 0))
# france_geom <- st_geometry(france)
# # france_geom[[1]][[1]][[1]] <- NULL
# france <- st_set_geometry(france, france_geom)
