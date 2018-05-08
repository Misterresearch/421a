library(gdata)
library(ggmap)
library(googleway)
library(readr)
library(dplyr)
library(ggplot2)
library(data.table)


#setwd()
allnyc <- read.csv("allnyc.csv", header = TRUE, sep = ",")
allnyc$Borough[allnyc$Borough==1] <- "Manhattan"
allnyc$Borough[allnyc$Borough==2] <- "Bronx"
allnyc$Borough[allnyc$Borough==3] <- "Brooklyn"
allnyc$Borough[allnyc$Borough==4] <- "Queens"
allnyc$Borough[allnyc$Borough==5] <- "SI"

allnyc$fulladdress <- paste(allnyc$Address," ",allnyc$Borough,",","NY", " ",allnyc$Zip.Code, sep="")


geokey<- 'AIzaSyAhH_6014s0bMwIDVbpn36BekqtpCm2eNM'
#geokey <- "API key"

register_google(key = geokey, account_type = "premium", day_limit = 100000)
#singleaddress<-unique(allnyc$fulladdress)
       
coordinates <- geocode(allnyc$fulladdress)

allnyc$lon <- coordinates$lon
allnyc$lat <- coordinates$lat

taxloc <- data.frame(allnyc$Borough,allnyc$lon,allnyc$lat)
colnames(taxloc)[1] <- "Borough"
colnames(taxloc)[2] <- "lon"
colnames(taxloc)[3] <- "lat"

taxloc <- distinct(taxloc)
taxloc <- data.table(taxloc)
taxlocA <- taxloc[sample(.N, 500)]

write_csv(taxloc, "geocoded421a.csv", append = FALSE)

google_map(key = geokey, data = taxlocA) %>% 
  add_heatmap(lat = "lat", lon = "lon",option_radius = 0.01)