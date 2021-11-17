library(tidyverse)
library(rvest)

lcr_web <- read_html("https://www.usbr.gov/lc/region/g4000/hourly/mead-elv.html")
lcr_web

water_tables <- lcr_web %>% 
  html_table()

waterTo2011 <- water_tables[[2]] 
waterTo2011$JAN[waterTo2011$JAN == "---"] <- NA
water2011to2021 <- water_tables[[3]]

water_levels <- waterTo2011 %>% 
  rbind(water2011to2021) %>% 
  mutate(JAN = as.numeric(JAN)) %>% 
  pivot_longer(-c(Year), names_to = "Months", values_to = "Elevation")
