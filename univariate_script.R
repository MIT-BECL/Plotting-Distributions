# Author:       Josh Peters
# Compiled:     07 Aug 2018 
# Updated:      1 Nov 2018
# Description:  Plotting univariate distributions and comparisons walkthrough
# R version 3.5.1 (2018-07-02)
# Platform: x86_64-apple-darwin15.6.0 (64-bit)
# Running under: macOS  10.14

# ---- 
rm(list = ls())  # clear current workspace

# import libraries and set working directory
library(tidyverse) # provides primary data wrangling and visualization packages
library(viridis)   # provides an easy function to generate color schemes outside of ggplot2

# [CRITICAL] set working directory
wd <- # set your working directory here
setwd(wd)

cmap <- c("#4473B0", "#C15436", "#6E348C", "#E4AC43") # colors used in the publication
current_theme <- theme_set(theme_classic()) # sets a starting theme for plotting
theme_update(aspect.ratio = 1/1)
# you can= view theme variables with theme_get()

# ----
# load data
raw_data <- read.table("nature25479_f2_formatted.csv", header = TRUE, sep=",", stringsAsFactors = FALSE) 
summary(raw_data)        # view quick summary of data
head(raw_data, n = 5)    # view top 5 entries

## group the data by species and compute + store mean, standard deviation, and standard error in "summary_data"
summary_data <- raw_data %>%  # take raw data
  group_by(Species) %>% # group it by the species
  summarize( # and summarize it by length, mean, standard deviation, and standard error
    N = length(Peak_Power),
    mean = mean(Peak_Power),
    sd = sd(Peak_Power),
    se = sd / sqrt(N)
  ) # and store it in summary_data

head(summary_data, n = 4)
# looking at our data, we see > 30 samples per species with means around 75-100


# [CRITICAL]
# Below are the functions to create various plots highlighted in the cheatsheet.
# Use ?geom_col or ?scale_shape_manual to understand what each function added to the ggplot objects mean
# Reach out the MIT BE Communication Lab with any questions


# ----
# iteration 1: default visualization

## initializes a ggplot object then subsequently adds elements
i1 <- ggplot(data = summary_data, aes(x = Species, y = mean)) + 
  geom_col() + geom_errorbar(aes(ymin = mean - se, ymax = mean + se))

i1

ggsave(file="i1_default.svg", plot = i1, width = 8, height = 6, units = "in")
ggsave(file="i1_default.png", plot = i1, width = 8, height = 6, units = "in", dpi = 360)

# ----
# iteration 2: resizing and coloring default

i2 <- ggplot(data = summary_data, aes(x = Species, y = mean, fill = Species)) + 
  geom_col(width = 0.5, alpha = 0.8) + 
  geom_errorbar(aes(ymin = mean - se, ymax = mean + se), size = 0.75, width = 0.1, position = position_dodge()) +
  scale_fill_viridis(discrete = TRUE, alpha = 0.8, end = 0.75, option = "viridis")

i2

ggsave(file="i2_color_resize.svg", plot = i2, width = 8, height = 6, units = "in")
ggsave(file="i2_color_resize.png", plot = i2, width = 8, height = 6, units = "in", dpi = 360)

# ----
# iteration 3: remove legend, add labels, and increase font sizing
i3 <-  ggplot(data = summary_data, aes(x = Species, y = mean, fill = Species)) + 
  geom_col(width = 0.5, alpha = 0.8) + 
  geom_errorbar(aes(ymin = mean - se, ymax = mean + se), size = 0.75, width = 0.1) +
  scale_fill_viridis(guide = FALSE, discrete = TRUE, alpha = 0.8, end = 0.75, option = "viridis") +
  labs(x = "Species", y = bquote("Peak Power (W" ~kg^-1 ~ ")")) + 
  scale_y_continuous(expand = c(0, 0), limits = c(0, 120)) +
  theme(
    axis.title = element_text(size = rel(1.25)),
    axis.text.x = element_text(color = "black", margin = margin(t = 5), size = rel(1.5)),
    axis.text.y = element_text(color = "black", margin = margin(r = 5), size = rel(1.5)))

i3

ggsave(file="i3_cleanup_default.svg", plot = i3, width = 8, height = 6, units = "in")
ggsave(file="i3_cleanup_default.png", plot = i3, width = 8, height = 8, units = "in", dpi = 360)

# ----
# iteration 4: add points
i4 <- ggplot(data = summary_data, aes(x = Species, y = mean, fill = Species)) + 
  geom_col(color = "black", width = 0.4, alpha = 0.6) + 
  geom_errorbar(aes(ymin = mean - se, ymax = mean + se), size = 0.75, width = 0.1) +
  geom_point(data = raw_data, aes(x = Species, y = Peak_Power, color = Species, shape = Species), size = 3,
             position = position_jitter(width = 0.1)) +
  scale_color_viridis(guide = FALSE, discrete = TRUE, alpha = 0.8, end = 0.75, option = "viridis") +
  scale_shape_manual(values=c(21, 22, 23, 25), guide = FALSE) +
  scale_fill_viridis(guide = FALSE, discrete = TRUE, alpha = 0.8, end = 0.75, option = "viridis") +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 190))

i4 <- i4 +
  labs(x = "Species", y = bquote("Peak Power (W" ~kg^-1 ~ ")")) + 
  theme(
    axis.title = element_text(size = rel(1.25)),
    axis.text.x = element_text(color = "black", margin = margin(t = 5), size = rel(1.5)),
    axis.text.y = element_text(color = "black", margin = margin(r = 5), size = rel(1.5)))

i4 

ggsave(file="i4_points.svg", plot = i4, width = 8, height = 6, units = "in")
ggsave(file="i4_points.png", plot = i4, width = 8, height = 6, units = "in", dpi = 360)

# ----
# iteration 5: turn horizontal
i5 <- ggplot(data = summary_data, aes(x = Species, y = mean, fill = Species)) + 
  geom_col(color = "black", width = 0.4, alpha = 0.6) + 
  geom_errorbar(aes(ymin = mean - se, ymax = mean + se), size = 0.75, width = 0.1) +
  geom_point(data = raw_data, aes(x = Species, y = Peak_Power, color = Species, shape = Species), size = 3,
             position = position_jitter(width = 0.1)) +
  scale_color_viridis(guide = FALSE, discrete = TRUE, alpha = 0.8, end = 0.75, option = "viridis") +
  scale_shape_manual(values=c(21, 22, 23, 25), guide = FALSE) + 
  scale_fill_viridis(guide = FALSE, discrete = TRUE, alpha = 0.8, end = 0.75, option = "viridis") +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 190)) +
  scale_x_discrete(name = "Species", limits = c("Zebra", "Lion", "Impala", "Cheetah"), 
                   labels = c("Cheetah" = "Cheetah", "Impala" = "Impala", "Lion" = "Lion", "Zebra" = "Zebra")) 


i5 <- i5 +
  labs(x = "Species", y = bquote(bold("Peak Power (W" ~kg^-1 ~ ")"))) + 
  coord_flip() + theme(
    axis.title.x = element_text(face = "bold", margin = margin(t = 10), size = rel(1.5)),
    axis.title.y = element_text(face = "bold", size = rel(1.25), angle = 0, vjust = 0.5),
    axis.text.x = element_text(color = "black", margin = margin(t = 5), size = rel(1.75)),
    axis.text.y = element_text(color = "black", margin = margin(r = 5), size = rel(1.75)),
    axis.line = element_line(size = 1),
    axis.ticks.length = unit(10, "pt"),
    axis.ticks = element_line(size  = 1),
    axis.ticks.y = element_blank())

i5

ggsave(file="i5_horz_bargraph.svg", plot = i5, width = 8, height = 6, units = "in")
ggsave(file="i5_horz_bargraph.png", plot = i5, width = 8, height = 6, units = "in", dpi = 360)

# ----
# iteration 6: turn into boxplot
i6 <- ggplot(data = raw_data, aes(x = Species, y = Peak_Power, fill = Species, shape = Species)) + 
  geom_boxplot(outlier.shape = NA, varwidth = TRUE, notch = TRUE, coef = 1.5,
               width = 0.4, color = "black", alpha = 0.6) + 
  geom_point(size = 3, position = position_jitter(width = 0.1)) +
  scale_fill_viridis(guide = FALSE, discrete = TRUE, alpha = 0.8, end = 0.75, option = "viridis") +
  scale_shape_manual(values=c(21, 22, 23, 25), guide = FALSE) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 190)) +
  scale_x_discrete(name = "Species", limits = c("Zebra", "Lion", "Impala", "Cheetah"), 
                   labels = c("Cheetah" = "Cheetah", "Impala" = "Impala", "Lion" = "Lion", "Zebra" = "Zebra"))

i6 <- i6 +
  labs(x = "Species", y = bquote(bold("Peak Power (W" ~kg^-1 ~ ")"))) + 
  coord_flip() + 
  theme(
    axis.title.x = element_text(face = "bold", margin = margin(t = 10), size = rel(1.5)),
    axis.title.y = element_text(face = "bold", size = rel(1.25), angle = 0, vjust = 0.5),
    axis.text.x = element_text(color = "black", margin = margin(t = 5), size = rel(1.75)),
    axis.text.y = element_text(color = "black", margin = margin(r = 5), size = rel(1.75)),
    axis.line = element_line(size = 1),
    axis.ticks.length = unit(10, "pt"),
    axis.ticks = element_line(size  = 1),
    axis.ticks.y = element_blank())

i6

ggsave(file="i6_boxplot_plot.svg", plot = i6, width = 8, height = 6, units = "in")
ggsave(file="i6_boxplot_plot.png", plot = i6, width = 8, height = 6, units = "in", dpi = 360)

# ----
# iteration 7: turn into violin plot
i7 <- ggplot(data = raw_data, aes(x = Species, y = Peak_Power, fill = Species, shape = Species)) + 
  geom_violin(draw_quantiles = c(0.5), color = "black", alpha = 0.6) + 
  geom_point(size = 3, position = position_jitter(width = 0.1)) +
  scale_fill_viridis(guide = FALSE, discrete = TRUE, alpha = 0.8, end = 0.75, option = "viridis") +
  scale_shape_manual(values=c(21, 22, 23, 25), guide = FALSE) +
  scale_y_continuous(breaks = c(25, 50, 75, 100, 125, 150), expand = c(0, 0), limits = c(0, 190)) + 
  scale_x_discrete(name = "Species", limits = c("Zebra", "Lion", "Impala", "Cheetah"), 
                   labels = c("Cheetah" = "Cheetah", "Impala" = "Impala", "Lion" = "Lion", "Zebra" = "Zebra"))

i7 <- i7 + 
  labs(x = "Species", y = bquote(bold("Peak Power (W" ~kg^-1 ~ ")"))) + 
  coord_flip() + 
  theme(
    axis.title.x = element_text(face = "bold", margin = margin(t = 10), size = rel(1.5)),
    axis.title.y = element_text(face = "bold", size = rel(1.25), angle = 0, vjust = 0.5),
    axis.text.x = element_text(color = "black", margin = margin(t = 20), size = rel(1.75)),
    axis.text.y = element_text(color = "black", margin = margin(r = 20), size = rel(1.75)),
    axis.line = element_line(size = rel(1.5)),
    axis.ticks.length = unit(-7.5, "pt"),
    axis.ticks = element_line(size = rel(1.5)),
    axis.ticks.y = element_blank(),
    panel.grid.major.x = element_line(color = "grey90", size = rel(0.5)))

i7
ggsave(file="i7_violin_plot.svg", plot = i7, width = 8, height = 8, units = "in")
ggsave(file="i7_violin_plot.png", plot = i7, width = 8, height = 8, units = "in", dpi = 360)

# ----
# replication of paper figure
r <- ggplot(data = raw_data, aes(x = Species, y = Peak_Power, fill = Species, color = Species)) + 
  geom_boxplot(outlier.shape = NA, varwidth = FALSE, notch = FALSE, coef = 10, width = 0.4, 
               lwd = rel(1), fatten = rel(1), color = "black") +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 190)) +
  scale_fill_manual(values = cmap, guide = FALSE) +
  
  geom_point(size = 3, stroke = 0, position = position_jitterdodge(jitter.width = 0.2, seed = 7)) +
  scale_color_manual(values = cmap, guide = FALSE) +
  scale_x_discrete(name = "Species", limits = c("Cheetah", "Impala", "Lion", "Zebra"), 
                   labels = c("Cheetah" = "C", "Impala" = "I", "Lion" = "L", "Zebra" = "Z"))
r <- r +
  labs(x = "Species", y = bquote("Peak Power (W" ~kg^-1 ~ ")")) + 
  theme(
    axis.title = element_text(size = rel(3)),
    axis.title.x = element_text(margin = margin(t = 25)),
    axis.title.y = element_text(margin = margin(r = 25)),
    axis.text.x = element_text(color = "black", margin = margin(t = 10), size = rel(3)),
    axis.text.y = element_text(color = "black", margin = margin(r = 10), size = rel(3)),
    axis.ticks.length = unit(-2, "pt"),
    axis.line = element_line(size = rel(2)))

r
ggsave(file="replicate.svg", plot = r, width = 8, height = 8, units = "in")