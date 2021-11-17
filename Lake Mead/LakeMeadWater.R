library(tidyverse)
library(rvest)
library(lubridate)

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
  pivot_longer(-c(Year), names_to = "Month", values_to = "Elevation") %>% 
  mutate(date = ymd(paste(Year, Month, "1"))) 

water_levels_year <- water_levels %>% 
  group_by(Year) %>% 
  summarise(
    Avg_Elevation = mean(Elevation)
  )

ggplot(water_levels_year, aes(x = Year, y = Avg_Elevation)) +
  geom_line() +
  theme_classic() +
  labs(y = "Average Yearly Water Elevation")
