library(ggplot2)
library(pxR)
library(tidyverse)
library(hrbrthemes)

data_dir <- '~/Code/R/Surnames/Data/'
image_dir <- '~/Code/R/Surnames/Images/'

import_roboto_condensed()

female_names_file <- paste(data_dir,'px-x-0104050000_102_ann.px',sep="")
male_names_file <- paste(data_dir,'px-x-0104050000_101_ann.px',sep="")

fm.px.object <- read.px(female_names_file)
fm.px.data <- as.data.frame(fm.px.object)

ma.px.object <- read.px(male_names_file)
ma.px.data <- as.data.frame(ma.px.object)

#sarah_stats <- filter(fm.px.data, Kanton == "Schweiz" & Masseinheit == "Anzahl" & Vorname  %in% c("Sara", "Sarah"))
all_fm_stats <- filter(fm.px.data, Kanton == "Schweiz" & Masseinheit == "Anzahl")
all_ma_stats <- filter(ma.px.data, Kanton == "Schweiz" & Masseinheit == "Anzahl")

dsc_fm_stats <- all_fm_stats %>% arrange(desc(value))
dsc_ma_stats <- all_ma_stats %>% arrange(desc(value))

asc_fm_stats <- all_fm_stats %>% arrange(value)
asc_ma_stats <- all_ma_stats %>% arrange(value)

nrow(dsc_fm_stats)
nrow(dsc_ma_stats)

nrow(filter(asc_fm_stats,value == 2))
nrow(filter(asc_ma_stats,value == 2))

#png(file = paste(image_dir,"fm_names_density_native.png",sep=""),width=1024,height=1024)
#d <- density(all_fm_stats$value)
#plot(d, main="Kernel Density for Swiss Female Surnames",col = 'pink')
#polygon(d, col="pink")
png(file = paste(image_dir,"fm_names_density.png",sep=""),width=1024,height=1024)
ggplot(data=dsc_fm_stats,aes(x = value, group=Jahr)) + geom_density(fill = 'pink',col='red') + facet_wrap(~Jahr)
dev.off()
#png(file = paste(image_dir,"ma_names_density_native.png",sep=""),width=1024,height=1024)
#e <- density(all_ma_stats$value)
#plot(e, main="Kernel Density for Swiss Male Surnames",col = 'lightblue')
#polygon(e, col="lightblue")
png(file = paste(image_dir,"ma_names_density.png",sep=""),width=1024,height=1024)
ggplot(data=dsc_ma_stats,aes(x = value, group=Jahr)) + geom_density(fill = 'lightblue',col = 'blue') + facet_wrap(~Jahr)
dev.off()