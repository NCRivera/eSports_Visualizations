library(tidyverse)
library(janitor)

OverwatchData <- read.csv(file = "data/overwatch_competitive_6_months.csv") %>% 
    tibble() %>% 
    clean_names()

# OverwatchData %>% head()

BarPlot <- OverwatchData %>% 
    ggplot(mapping = aes(x = hero, y = pick_rate_a, fill = hero_type)) + 
    geom_col(width = 0.75, color = "black") +
    facet_wrap(. ~ system) + 
    scale_fill_manual(values = c("orange", "red", "green", "blue")) +
    scale_x_discrete(expand = c(0.01, 0.01)) +
    scale_y_continuous(labels = scales::percent) + 
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 90)) + 
    labs(
        title = "Overwatch Characters Pick Rate, Competitive Play", 
        subtitle = "Barchart: Percentage per System (6 Months)", 
        x = "Character",
        y = "Pick Rate Percentage",
        fill = "Hero Type", 
        caption = "Source: https://www.overbuff.com/heroes"
    )
BarPlot

DotPlot <- OverwatchData %>% 
    ggplot(mapping = aes(x = win_rate, y = hero, fill = system)) + 
    geom_point(size = 2, shape = 21, color = "black")  +
    geom_segment(mapping = aes(yend = hero), xend = 0, color = "black") +
    scale_fill_manual(values = c("coral", "navy", "springgreen", "firebrick")) +
    scale_y_discrete(limits = rev, expand = c(0.01, 0.01)) +
    scale_x_continuous(labels = scales::percent) + 
    facet_wrap(. ~ system) + 
    theme_minimal() + 
    theme(axis.line.y = element_line(colour = "black", size = 1)) +
    theme(axis.text.x = element_text(angle = 45)) + 
    labs(
        title = "Character Win Rates", 
        subtitle = "Dotplot: Win Percentage by System", 
        x = "Percentage", 
        y = "Hero", 
        fill = "System"
    )
DotPlot
