library(tidyverse)
library(lubridate)

abortion <- read_csv("Abortion/abortiondistances_countyxmonth_2009to2021.csv") 

abortion <- abortion %>% 
  separate(origin_county_name, c("county", "state"), sep = "\\(") 
abortion["state"] <- gsub("\\)", "", abortion["state"])
