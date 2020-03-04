library(ggplot2)
library(tidyr)
library(tidyverse)
library(scales)
#source('~/Documents/styles.R')
library(reshape2)
library(extrafont)
library(Cairo)

#theme_set(my_theme)

senators <- read.csv("~/Documents/senators_scotus_bydate_all.csv", sep=",")

View(senators)
senators <- senators[order(-senators$trump_margin),]


senators <-as.data.frame.matrix(senators)


senators <-subset(senators, select=last_name:trump_margin)

View(senators)

senators.long <- melt(senators, id = c("last_name", "trump_margin"))


#senators.long <- subset(senators.long, select = c(last_name, variable, value))

colnames(senators.long) <- c("last_name",	"trump_margin", "justice", "vote")

View(senators.long)



by_yes <-senators.long %>% 
  filter(vote == "yes")%>%
  group_by(last_name,trump_margin, vote) %>% summarize(count=n())

View(by_yes)

heatmap.plot <- ggplot(data = senators.long, aes(x = justice, y = reorder(last_name,trump_margin, order=TRUE))) +
  geom_tile(aes(fill = vote), color = "white") +theme_bw()+
  scale_fill_manual(values=c("#fdc47c","#eeeff0", "#95cbee","#669999","#CC0066"), 
                    name="Vote\nBreakdown",
                    breaks=c("NV", "yes", "no"))+
                    #labels=c("No vote", "Yes", "No"))+
                        
  xlab("Circuit court justices by confirmation date") +
  ylab("Senators by Trump margin of victory") +
  theme(axis.text.y = element_text(vjust=.25))+   
  theme(axis.text.x = element_text(angle=45, hjust=.75))+   
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), axis.line = element_line(colour = "transparent"))+
  theme(text=element_text(size=11, family="DJ5RetinaCd-Medium",face="plain", color="#231F20"))+
  theme(axis.ticks = element_blank())

chart<- plot(heatmap.plot)

ggsave(heatmap.plot, filename = "~/Documents/heatmap-full.pdf", device = cairo_pdf,
       width = 10, height = 6, units = "in")

