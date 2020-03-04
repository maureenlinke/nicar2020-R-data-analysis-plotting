# install.packages(c("dplyr", "ggplot2"))

library(ggplot2)
library(dplyr)
library(gapminder)
library(scales)


#
# Load the data and filter for United States

line_df <- gapminder %>%
  filter(country == "United States") 



#Make plot
line <- ggplot(line_df, aes(x = year, y = lifeExp)) +
  geom_line(colour = "#1380A1", size = 1) +
  geom_hline(yintercept = 0, size = 1, colour="#333333") +
  theme_bw() +
  labs(title="Living longer",
       subtitle = "Life expectancy in U.S. 1952-2007")+
  scale_y_continuous(limits=c(40,80), breaks = scales::pretty_breaks(n = 5))
  #theme(panel.grid.major.x=element_line(size=0)) +
  #theme(panel.grid.minor.y=element_line(size=0.05)) +
  #theme(text=element_text(size=13, family="RetinaLight",face="plain", color="#231F20"))+
  #theme(axis.ticks = element_blank())+
  #theme(panel.border = element_blank(),
        #panel.grid.minor = element_blank(), axis.line = element_line(colour = "transparent"))



plot(line)



