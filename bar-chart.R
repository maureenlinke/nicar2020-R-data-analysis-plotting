
# Set up.
# install.packages(c("dplyr", "ggplot2"))

library(ggplot2)
library(dplyr)
library(gapminder)
library(scales)


#See your data frame
View(gapminder)


#Prepare data
bar_df <- gapminder %>%
  filter(year == 2007 & continent == "Asia") %>%
  arrange(desc(lifeExp)) %>%
  head(5)

View(bar_df)

#Make plot
bars <- ggplot(bar_df, aes(x = country, y = lifeExp)) +
  geom_bar(stat="identity", 
           position="identity", 
           fill="#1380A1") +
  geom_hline(yintercept = 0, size = 1, colour="#333333") +
  theme_bw() +
  xlab("")+
  ylab("")+
  theme(axis.ticks = element_blank())+
  theme(panel.grid.major.y  = element_blank()) +
  theme(panel.border = element_blank())+
  theme(panel.grid.minor = element_blank())+
  labs(title="Highest Asian life expectancy, 2007")+
  theme(panel.grid.minor = element_blank())+
  theme(panel.grid.major.y = element_line(color="#cbcbcb"))+
  theme(panel.grid.major.x = element_blank())


plot(bars)
