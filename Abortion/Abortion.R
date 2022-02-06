library(tidyverse)
library(lubridate)

abortion <- read_csv("Abortion/abortiondistances_countyxmonth_2009to2021.csv") 

abortion <- abortion %>% 
  separate(origin_county_name, c("county", "state"), sep = "\\(") 
abortion["state"] <- gsub("\\)", "", abortion["state"])

abortion %>% 
  group_by(year, month) %>% 
  summarise(
    mean_tt = mean(tt)
  ) %>% 
  mutate(
    date = make_date(year, month)
  ) %>% 
  ggplot(aes(x= date, y = mean_tt)) +
  geom_line() +
  theme_bw() +
  labs(
    x = "Date",
    y = "Travel Time to the Nearest Abortion Facility (Minutes)"
  )
  
