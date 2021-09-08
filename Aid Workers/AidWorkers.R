library(tidyverse)
library(tmap)
library(ggmap)
library(magick)
library(OpenStreetMap)
library(ggplot2)

attacks <- read_csv("Aid Workers/security_incidents_2021-09-06.csv") 

filtered_attacks <- attacks %>% 
  filter(!is.na(Latitude) & !is.na(Longitude))

map <- openmap(c(70,-179),
               c(-70, 179),zoom=2)
map <- openproj(map)

years <- 1997:2021
for (x in years){
attacks_on_year <- filtered_attacks %>% 
  filter(Year <= x)
attack_map <- OpenStreetMap::autoplot.OpenStreetMap(map) + 
  geom_point(data = attacks_on_year, 
             aes(x=Longitude, y=Latitude, size = `Total affected`),
             color = "red", alpha = 0.15, shape = 16) +
  theme(axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks.x = element_blank(),
        axis.ticks.y = element_blank(),panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(),
        legend.position="bottom") +
  ggtitle(x) +  
  theme(plot.title = element_text(hjust = 0.5, size =15)) +
  scale_size(range=c(1,5),
             limits = c(0, 50),
             breaks=c(0,10,20,30,40),
             guide="legend")
ggsave(filename = paste0("attackMap", x, ".png"), attack_map, path= "Aid Workers/AidWorkersGif", 
       dpi = 320)
print(x)
}
images <- list.files(path= "Aid Workers/AidWorkersGif", pattern = '*.png', full.names = TRUE) %>% 
  image_read() %>% # reads each path file
  image_join() # joins image
animation <- image_animate(images, fps = 2) # animates, can opt for number of loops
image_write(animation, "AidWorkers.gif")
# path = "C:/Users/ihear/Documents/Reddit Data Visualizations/Aid Workers") # write to current dir
