library(dplyr)
library(tidyverse)
library(scales)
library(Cairo)
library(readr)

#Set your working directory to where you will save your files
#setwd("Users/linkem/Sites/nicar2020-R-data-analysis-plotting/data/ia-nh-towns.csv")

dfa <- read_csv("data/ia-nh-towns.csv")

dfa<-gather(dfa,candidates,value,Buttigieg:Steyer)



dfa$share= (dfa$value/dfa$totalVotes)*100

View(dfa)

#histogram_data <-gather(df, key="text", value="value")

p <- dfa %>%
  ggplot( aes(x=share, color=state)) +
  geom_histogram(alpha=1, fill="white", binwidth = 8, position="dodge") +
  scale_color_manual(values=c("#0098db","#9399ad")) +
  scale_fill_manual(values=c("#f3f3f3", "#f3f3f3")) +
  theme_minimal()+
  theme(axis.ticks = element_blank())+
  theme(panel.grid.major.x=element_line(size=0.02)) +
  theme(panel.grid.minor.y=element_line(size=0)) +
  #scale_y_continuous(breaks = seq(0, 300, by = 50))+
  scale_x_continuous(limits = c(0, 40),
  breaks = seq(0, 40, by = 10),
  labels = c("0%", "10", "20","30", "40")) +
  theme(strip.text.x = element_text(family = "RetinaMedium", size=15))+
  theme(text=element_text(size=14, family="RetinaNarrowLight",face="plain", color="#231F20"))+
  theme(axis.ticks = element_blank())+
  theme(panel.border = element_blank(),
        panel.grid.minor = element_blank(), axis.line = element_line(colour = "transparent"))+
  labs(fill=" ")+
  theme(legend.position = "none")+
  labs(x=" ", y=" ") + 
  facet_wrap(~candidates, scales='free_x', nrow =2)


plot(p)

ggsave(p, filename = "histogram.pdf", device = cairo_pdf,
       width = 4, height = 5, units = "in")
