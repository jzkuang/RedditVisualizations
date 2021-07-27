install.packages("remotes")
install.packages("ggplot2")
install.packages("extrafont")
install.packages("RCurl")
install.packages("jsonlite")
install.packages("showtext")

library(ggplot2)
library(tidyverse)
library(remotes)
install_github('bldavies/nberwp')
library(nberwp)
library(extrafont)
loadfonts(device = "win")
library(showtext)
font_add_google("PT Sans")


papers <- papers
publicationDateFrequency <- papers %>% 
  group_by(year) %>% 
  count() %>% 
  filter(year != 2021)

showtext_auto()
windows()
ggplot(publicationDateFrequency, aes(x = year, y=n)) +
  geom_point(shape = 19, color = "deepskyblue2", size = 2.5) +
  theme_bw() +
  labs(y = "Number of Papers", x = "Year") +
  ggtitle("Number of NBER Papers Produced Per Year")  +
  theme( text = element_text(family = "PT Sans", face = "bold"),
         plot.title = element_text(hjust = 0.5, face = "bold", size = 20))
