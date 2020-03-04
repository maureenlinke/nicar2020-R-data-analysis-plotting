# install.packages(c("dplyr", "ggplot2"))
library(gapminder)
library("ggalt")
library("tidyr")
library(Cairo)

#Prepare data
dumbbell_df <- gapminder %>%
  filter(year == 1967 | year == 2007) %>%
  select(country, year, lifeExp) %>%
  spread(year, lifeExp) %>%
  mutate(gap = `2007` - `1967`) %>%
  arrange(desc(gap)) %>%
  head(10)

#Make plot
dumbellplot <- ggplot(dumbbell_df, aes(x = `1967`, xend = `2007`, y = reorder(country, gap), group = country)) + 
  geom_dumbbell(colour = "#dddddd",
                size = 3,
                colour_x = "#FAAB18",
                colour_xend = "#1380A1") +
  labs(title="We're living longer",
       subtitle="Biggest life expectancy rise, 1967-2007")


#Save plot as PDF for exporting to Adobe Illustrator
ggsave(dumbellplot, filename = "Documents/histogram.pdf", device = cairo_pdf,
       width = 5, height = 4, units = "in")
