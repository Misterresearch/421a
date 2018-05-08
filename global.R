library(dplyr)
library(tidyr)
library(stats)
library(prophet)
library(pROC)
library(ggplot2)
library(forecast)
library(tseries)
library(segmented)
library(data.table)
library(RCurl)
library(XML)
library(rvest)
library(scales)
library(MASS)

# must setwd()
allnyc<- read.csv("allnyc.csv", header = TRUE, sep = ",")
colnames(allnyc)[9] <- "Zip"

byboro <- allnyc %>%
  na.omit() %>%
  group_by(Borough) %>%
  summarise(allcounts = NROW(Address)) %>%
  arrange(desc(allcounts))

byneighb <- allnyc %>%
  na.omit() %>%
  group_by(Neighborhood) %>%
  summarise(allcounts = NROW(Address)) %>%
  arrange(desc(allcounts)) 

byboroandneighb <- allnyc %>%
  na.omit() %>%
  group_by(Borough,Neighborhood) %>%
  summarise(allcounts = NROW(Address)) %>%
  arrange(desc(allcounts))

byboroandzip <- allnyc %>%
  na.omit() %>%
  group_by(Neighborhood,Zip) %>%
  summarise(allcounts = NROW(Address)) %>%
  arrange(desc(allcounts)) 

ggplot(data = byboro,aes(x = reorder(Borough,desc(allcounts)), y = allcounts)) + geom_histogram(fill="blue", stat = "identity") + scale_x_discrete(labels = c("Brooklyn", "Queens", "Manhattan", "Bronx", "Staten Island"), name = "Borough")+ scale_y_continuous(name = "# of Units") + ggtitle("FY 2017/18 421a Units By Borough") + theme(plot.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=14, hjust=0)) + geom_text(aes(label = comma(round(allcounts)), sep=","), position = position_dodge(0.9), size=3, color="black", vjust=-0.25)

ggplot(data = byneighb[c(1:20),], aes(x=reorder(Neighborhood, desc(allcounts)), y = allcounts)) + geom_histogram(fill="grey", stat = "identity", color="blue") + scale_x_discrete(name ="Neighborhood") + scale_y_continuous(name = "# of Units") + ggtitle("FY 2017/18 421a Units Top 20 Neighborhood") + theme(plot.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=14, hjust=0)) + geom_text(aes(label = comma(round(allcounts)), sep=","), position = position_dodge(0.9), size=3, vjust=-0.25) + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 6))
