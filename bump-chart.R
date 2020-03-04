###
# Source for Bump Chart Tutorial with ggplot2 on FlowingData: 
# https://flowingdata.com/2019/11/14/r-ggplot-bump-chart/
###

#
# Set up.
#

# install.packages(c("dplyr", "ggplot2"))
library(dplyr)
library(ggplot2)

#
# Load the data.
#

meeting <- read.csv("data/how_met_decade.tsv", sep="\t", stringsAsFactors=FALSE)

#
# Multi-line chart.
#

ggplot(meeting, aes(x = year, y = p, color = waymet)) +
  geom_line() +
  theme_minimal()

#
# Bump chart.
#

# Calculate ranks for each decade.
meeting <- group_by(meeting, year) %>%
  mutate(rank = row_number(-p))

#
# Make the bump chart.
#

ggplot(meeting, aes(x = year, y = rank, color = waymet)) +
  geom_line() + 
  geom_point(shape = 21, fill = "white") +
  theme_minimal() +
  scale_y_reverse(breaks = c(1:19)) +
  geom_text(data = filter(meeting, year == 2010), aes(label = waymet), color = "black", hjust = 0, nudge_x = 2) +
  theme(panel.grid = element_blank(), legend.position = "none") +
  scale_x_continuous(breaks = seq(1960,2010,10), expand = expand_scale(add = c(2, 20)))

#
# Save.
#

ggsave(filename = "bumpchart.png", units = "cm", width = 18, height = 16)
  

