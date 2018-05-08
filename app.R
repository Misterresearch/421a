library(shiny)
library(dplyr)
library(tidyr)
library(stats)
library(data.table)
library(scales)
library(googleway)
library(ggmap)
library(ggplot2)

#must setwd()

#Data Retrieval
#FY2018
bronx18<-"https://raw.githubusercontent.com/Misterresearch/421a/master/421a_1718_bronx.csv"

brooklyn18 <-"https://raw.githubusercontent.com/Misterresearch/421a/master/421a_1718_brooklyn.csv"

queens18<-"https://raw.githubusercontent.com/Misterresearch/421a/master/421a_1718_queens.csv"

manhattan18<-"https://raw.githubusercontent.com/Misterresearch/421a/master/421a_1718_manhattan.csv"

si18 <-"https://raw.githubusercontent.com/Misterresearch/421a/master/421a_1718_statenisland.csv"

manhattantable18 <- read.csv(manhattan18, header = FALSE, sep = ",")
manhattantable18 <-manhattantable18[-c(1:5),]
colnames(manhattantable18)<- c("Borough", "Neighborhood", "Building Class", "Tax Class", "Block", "Lot", "Present Building Class", "Address", "Zip Code", "Residential Units", "Commercial Units", "Total Units", "Land Square Feet", "Gross Square Feet", "Year Built")

bronxtable18 <- read.csv(bronx18, header = FALSE, sep = ",")
bronxtable18 <-bronxtable18[-c(1:5),]
colnames(bronxtable18)<- c("Borough", "Neighborhood", "Building Class", "Tax Class", "Block", "Lot", "Present Building Class", "Address", "Zip Code", "Residential Units", "Commercial Units", "Total Units", "Land Square Feet", "Gross Square Feet", "Year Built")

brooklyntable18 <- read.csv(brooklyn18, header = FALSE, sep = ",")
brooklyntable18 <-brooklyntable18[-c(1:5),]
colnames(brooklyntable18)<- c("Borough", "Neighborhood", "Building Class", "Tax Class", "Block", "Lot", "Present Building Class", "Address", "Zip Code", "Residential Units", "Commercial Units", "Total Units", "Land Square Feet", "Gross Square Feet", "Year Built")
queenstable18 <- read.csv(queens18, header = FALSE, sep = ",")
queenstable18 <-queenstable18[-c(1:5),]
colnames(queenstable18)<- c("Borough", "Neighborhood", "Building Class", "Tax Class", "Block", "Lot", "Present Building Class", "Address", "Zip Code", "Residential Units", "Commercial Units", "Total Units", "Land Square Feet", "Gross Square Feet", "Year Built")
sitable18 <- read.csv(si18, header = FALSE, sep = ",")
sitable18 <-sitable18[-c(1:5),]
colnames(sitable18)<- c("Borough", "Neighborhood", "Building Class", "Tax Class", "Block", "Lot", "Present Building Class", "Address", "Zip Code", "Residential Units", "Commercial Units", "Total Units", "Land Square Feet", "Gross Square Feet", "Year Built")

allnyc18 <- rbind(manhattantable18,bronxtable18,brooklyntable18,queenstable18, sitable18)
allnyc18$Borough <- as.character(allnyc18$Borough)
colnames(allnyc18)[10] <- "Zip"
allnyc18$Borough[allnyc18$Borough==1] <- "Manhattan"
allnyc18$Borough[allnyc18$Borough==2] <- "Bronx"
allnyc18$Borough[allnyc18$Borough==3] <- "Brooklyn"
allnyc18$Borough[allnyc18$Borough==4] <- "Queens"
allnyc18$Borough[allnyc18$Borough==5] <- "SI"
allnyc18$CountYear <- NA
allnyc18$CountYear <- rep("2018", each = NROW(allnyc18))

#FY2017

bronx17<-"https://raw.githubusercontent.com/Misterresearch/421a/master/421a_1617_bronx.csv"

brooklyn17 <-"https://raw.githubusercontent.com/Misterresearch/421a/master/421a_1617_brooklyn.csv"

queens17<-"https://raw.githubusercontent.com/Misterresearch/421a/master/421a_1617_queens.csv"

manhattan17<-"https://raw.githubusercontent.com/Misterresearch/421a/master/421a_1617_manhattan.csv"

si17 <-"https://raw.githubusercontent.com/Misterresearch/421a/master/421a_1617_statenisland.csv"

manhattantable17 <- read.csv(manhattan17, header = FALSE, sep = ",")
manhattantable17 <-manhattantable17[-c(1:5),]
colnames(manhattantable17)<- c("Borough", "Neighborhood", "Building Class", "Tax Class", "Block", "Lot", "Present Building Class", "Address", "Zip Code", "Residential Units", "Commercial Units", "Total Units", "Land Square Feet", "Gross Square Feet", "Year Built")

bronxtable17 <- read.csv(bronx17, header = FALSE, sep = ",")
bronxtable17 <-bronxtable17[-c(1:5),]
colnames(bronxtable17)<- c("Borough", "Neighborhood", "Building Class", "Tax Class", "Block", "Lot", "Present Building Class", "Address", "Zip Code", "Residential Units", "Commercial Units", "Total Units", "Land Square Feet", "Gross Square Feet", "Year Built")

brooklyntable17 <- read.csv(brooklyn17, header = FALSE, sep = ",")
brooklyntable17 <-brooklyntable17[-c(1:5),]
colnames(brooklyntable17)<- c("Borough", "Neighborhood", "Building Class", "Tax Class", "Block", "Lot", "Present Building Class", "Address", "Zip Code", "Residential Units", "Commercial Units", "Total Units", "Land Square Feet", "Gross Square Feet", "Year Built")
queenstable17 <- read.csv(queens17, header = FALSE, sep = ",")
queenstable17 <-queenstable17[-c(1:5),]
colnames(queenstable17)<- c("Borough", "Neighborhood", "Building Class", "Tax Class", "Block", "Lot", "Present Building Class", "Address", "Zip Code", "Residential Units", "Commercial Units", "Total Units", "Land Square Feet", "Gross Square Feet", "Year Built")
sitable17 <- read.csv(si17, header = FALSE, sep = ",")
sitable17 <-sitable17[-c(1:5),]
colnames(sitable17)<- c("Borough", "Neighborhood", "Building Class", "Tax Class", "Block", "Lot", "Present Building Class", "Address", "Zip Code", "Residential Units", "Commercial Units", "Total Units", "Land Square Feet", "Gross Square Feet", "Year Built")

allnyc17 <- rbind(manhattantable17,bronxtable17,brooklyntable17,queenstable17, sitable17)
allnyc17$Borough <- as.character(allnyc17$Borough)
colnames(allnyc17)[10] <- "Zip"
allnyc17$Borough[allnyc17$Borough==1] <- "Manhattan"
allnyc17$Borough[allnyc17$Borough==2] <- "Bronx"
allnyc17$Borough[allnyc17$Borough==3] <- "Brooklyn"
allnyc17$Borough[allnyc17$Borough==4] <- "Queens"
allnyc17$Borough[allnyc17$Borough==5] <- "SI"
allnyc17$CountYear <- NA
allnyc17$CountYear <- rep("2017", each = NROW(allnyc17))

#FY2016

bronx16<-"https://raw.githubusercontent.com/Misterresearch/421a/master/421a_1516_bronx.csv"

brooklyn16 <-"https://raw.githubusercontent.com/Misterresearch/421a/master/421a_1516_brooklyn.csv"

queens16<-"https://raw.githubusercontent.com/Misterresearch/421a/master/421a_1516_queens.csv"

manhattan16<-"https://raw.githubusercontent.com/Misterresearch/421a/master/421a_1516_manhattan.csv"

si16 <-"https://raw.githubusercontent.com/Misterresearch/421a/master/421a_1516_statenisland.csv"

manhattantable16 <- read.csv(manhattan16, header = FALSE, sep = ",")
manhattantable16 <-manhattantable16[-c(1:5),]
colnames(manhattantable16)<- c("Borough", "Neighborhood", "Building Class", "Tax Class", "Block", "Lot", "Present Building Class", "Address", "Zip Code", "Residential Units", "Commercial Units", "Total Units", "Land Square Feet", "Gross Square Feet", "Year Built")

bronxtable16 <- read.csv(bronx16, header = FALSE, sep = ",")
bronxtable16 <-bronxtable16[-c(1:5),]
colnames(bronxtable16)<- c("Borough", "Neighborhood", "Building Class", "Tax Class", "Block", "Lot", "Present Building Class", "Address", "Zip Code", "Residential Units", "Commercial Units", "Total Units", "Land Square Feet", "Gross Square Feet", "Year Built")

brooklyntable16 <- read.csv(brooklyn16, header = FALSE, sep = ",")
brooklyntable16 <-brooklyntable16[-c(1:5),]
colnames(brooklyntable16)<- c("Borough", "Neighborhood", "Building Class", "Tax Class", "Block", "Lot", "Present Building Class", "Address", "Zip Code", "Residential Units", "Commercial Units", "Total Units", "Land Square Feet", "Gross Square Feet", "Year Built")
queenstable16 <- read.csv(queens16, header = FALSE, sep = ",")
queenstable16 <-queenstable16[-c(1:5),]
colnames(queenstable16)<- c("Borough", "Neighborhood", "Building Class", "Tax Class", "Block", "Lot", "Present Building Class", "Address", "Zip Code", "Residential Units", "Commercial Units", "Total Units", "Land Square Feet", "Gross Square Feet", "Year Built")
sitable16 <- read.csv(si16, header = FALSE, sep = ",")
sitable16 <-sitable16[-c(1:5),]
colnames(sitable16)<- c("Borough", "Neighborhood", "Building Class", "Tax Class", "Block", "Lot", "Present Building Class", "Address", "Zip Code", "Residential Units", "Commercial Units", "Total Units", "Land Square Feet", "Gross Square Feet", "Year Built")

allnyc16 <- rbind(manhattantable16,bronxtable16,brooklyntable16,queenstable16, sitable16)
allnyc16$Borough <- as.character(allnyc16$Borough)
colnames(allnyc16)[10] <- "Zip"
allnyc16$Borough[allnyc16$Borough==1] <- "Manhattan"
allnyc16$Borough[allnyc16$Borough==2] <- "Bronx"
allnyc16$Borough[allnyc16$Borough==3] <- "Brooklyn"
allnyc16$Borough[allnyc16$Borough==4] <- "Queens"
allnyc16$Borough[allnyc16$Borough==5] <- "SI"
allnyc16$CountYear <- NA
allnyc16$CountYear <- rep("2016", each = NROW(allnyc16))

#FY2015

bronx15<-"https://raw.githubusercontent.com/Misterresearch/421a/master/421a_1415_bronx.csv"

brooklyn15 <-"https://raw.githubusercontent.com/Misterresearch/421a/master/421a_1415_brooklyn.csv"

queens15<-"https://raw.githubusercontent.com/Misterresearch/421a/master/421a_1415_queens.csv"

manhattan15<-"https://raw.githubusercontent.com/Misterresearch/421a/master/421a_1415_manhattan.csv"

si15 <-"https://raw.githubusercontent.com/Misterresearch/421a/master/421a_1415_statenisland.csv"

manhattantable15 <- read.csv(manhattan15, header = FALSE, sep = ",")
manhattantable15 <-manhattantable15[-c(1:5),]
colnames(manhattantable15)<- c("Borough", "Neighborhood", "Building Class", "Tax Class", "Block", "Lot", "Present Building Class", "Address", "Zip Code", "Residential Units", "Commercial Units", "Total Units", "Land Square Feet", "Gross Square Feet", "Year Built")

bronxtable15 <- read.csv(bronx15, header = FALSE, sep = ",")
bronxtable15 <-bronxtable15[-c(1:5),]
colnames(bronxtable15)<- c("Borough", "Neighborhood", "Building Class", "Tax Class", "Block", "Lot", "Present Building Class", "Address", "Zip Code", "Residential Units", "Commercial Units", "Total Units", "Land Square Feet", "Gross Square Feet", "Year Built")

brooklyntable15 <- read.csv(brooklyn15, header = FALSE, sep = ",")
brooklyntable15 <-brooklyntable15[-c(1:5),]
colnames(brooklyntable15)<- c("Borough", "Neighborhood", "Building Class", "Tax Class", "Block", "Lot", "Present Building Class", "Address", "Zip Code", "Residential Units", "Commercial Units", "Total Units", "Land Square Feet", "Gross Square Feet", "Year Built")
queenstable15 <- read.csv(queens15, header = FALSE, sep = ",")
queenstable15 <-queenstable15[-c(1:5),]
colnames(queenstable15)<- c("Borough", "Neighborhood", "Building Class", "Tax Class", "Block", "Lot", "Present Building Class", "Address", "Zip Code", "Residential Units", "Commercial Units", "Total Units", "Land Square Feet", "Gross Square Feet", "Year Built")
sitable15 <- read.csv(si15, header = FALSE, sep = ",")
sitable15 <-sitable15[-c(1:5),]
colnames(sitable15)<- c("Borough", "Neighborhood", "Building Class", "Tax Class", "Block", "Lot", "Present Building Class", "Address", "Zip Code", "Residential Units", "Commercial Units", "Total Units", "Land Square Feet", "Gross Square Feet", "Year Built")

allnyc15 <- rbind(manhattantable15,bronxtable15,brooklyntable15,queenstable15, sitable15)
allnyc15$Borough <- as.character(allnyc15$Borough)
colnames(allnyc15)[10] <- "Zip"
allnyc15$Borough[allnyc15$Borough==1] <- "Manhattan"
allnyc15$Borough[allnyc15$Borough==2] <- "Bronx"
allnyc15$Borough[allnyc15$Borough==3] <- "Brooklyn"
allnyc15$Borough[allnyc15$Borough==4] <- "Queens"
allnyc15$Borough[allnyc15$Borough==5] <- "SI"
allnyc15$CountYear <- NA
allnyc15$CountYear <- rep("2015", each = NROW(allnyc15))

#FY2014

bronx14<-"https://raw.githubusercontent.com/Misterresearch/421a/master/bronx_421a.csv"

brooklyn14 <-"https://raw.githubusercontent.com/Misterresearch/421a/master/brooklyn_421a.csv"

queens14<-"https://raw.githubusercontent.com/Misterresearch/421a/master/queens_421a.csv"

manhattan14<-"https://raw.githubusercontent.com/Misterresearch/421a/master/manhattan_421a.csv"

si14 <-"https://raw.githubusercontent.com/Misterresearch/421a/master/statenisland_421a.csv"

manhattantable14 <- read.csv(manhattan14, header = FALSE, sep = ",")
manhattantable14 <-manhattantable14[-c(1:5),]
colnames(manhattantable14)<- c("Borough", "Neighborhood", "Building Class", "Tax Class", "Block", "Lot", "Present Building Class", "Address", "Zip Code", "Residential Units", "Commercial Units", "Total Units", "Land Square Feet", "Gross Square Feet", "Year Built")

bronxtable14 <- read.csv(bronx14, header = FALSE, sep = ",")
bronxtable14 <-bronxtable14[-c(1:5),]
colnames(bronxtable14)<- c("Borough", "Neighborhood", "Building Class", "Tax Class", "Block", "Lot", "Present Building Class", "Address", "Zip Code", "Residential Units", "Commercial Units", "Total Units", "Land Square Feet", "Gross Square Feet", "Year Built")

brooklyntable14 <- read.csv(brooklyn14, header = FALSE, sep = ",")
brooklyntable14 <-brooklyntable14[-c(1:5),]
colnames(brooklyntable14)<- c("Borough", "Neighborhood", "Building Class", "Tax Class", "Block", "Lot", "Present Building Class", "Address", "Zip Code", "Residential Units", "Commercial Units", "Total Units", "Land Square Feet", "Gross Square Feet", "Year Built")
queenstable14 <- read.csv(queens14, header = FALSE, sep = ",")
queenstable14 <-queenstable14[-c(1:5),]
colnames(queenstable14)<- c("Borough", "Neighborhood", "Building Class", "Tax Class", "Block", "Lot", "Present Building Class", "Address", "Zip Code", "Residential Units", "Commercial Units", "Total Units", "Land Square Feet", "Gross Square Feet", "Year Built")
sitable14 <- read.csv(si14, header = FALSE, sep = ",")
sitable14 <-sitable14[-c(1:5),]
colnames(sitable14)<- c("Borough", "Neighborhood", "Building Class", "Tax Class", "Block", "Lot", "Present Building Class", "Address", "Zip Code", "Residential Units", "Commercial Units", "Total Units", "Land Square Feet", "Gross Square Feet", "Year Built")

allnyc14 <- rbind(manhattantable14,bronxtable14,brooklyntable14,queenstable14, sitable14)
allnyc14$Borough <- as.character(allnyc14$Borough)
colnames(allnyc14)[10] <- "Zip"
allnyc14$Borough[allnyc14$Borough==1] <- "Manhattan"
allnyc14$Borough[allnyc14$Borough==2] <- "Bronx"
allnyc14$Borough[allnyc14$Borough==3] <- "Brooklyn"
allnyc14$Borough[allnyc14$Borough==4] <- "Queens"
allnyc14$Borough[allnyc14$Borough==5] <- "SI"
allnyc14$CountYear <- NA
allnyc14$CountYear <- rep("2014", each = NROW(allnyc14))

#ggplot visualization

nyc_total_units <- c(NROW(allnyc14),NROW(allnyc15),NROW(allnyc16),NROW(allnyc17),NROW(allnyc18))
my_years <- c("2014","2015","2016","2017","2018")

allnyc <- rbind(allnyc14,allnyc15,allnyc16,allnyc17,allnyc18)

total_nyc_421a = data.frame(my_years,nyc_total_units)
predict421a<-predict(lm(nyc_total_units ~ my_years, data = total_nyc_421a))

total_nyc_plot <- ggplot(data = total_nyc_421a,aes(x=my_years, y=nyc_total_units)) + geom_point(color="yellow") + geom_line(aes(y=predict421a))+ylim(0,100000)+ggtitle("Total Citywide 421a Tax Abated Units")+theme(plot.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size = 14, hjust = 0)) + geom_text(aes(label = comma(round(nyc_total_units), digits = 0), sep=","), position = position_dodge(0.9), size=5, vjust=-0.25) + theme(axis.text.x = element_text(angle = 0, hjust = .5, size = 10))


byboro18 <- allnyc18 %>%
  na.omit() %>%
  group_by(Borough) %>%
  summarise(allcounts = NROW(Address)) %>%
  arrange(desc(allcounts))

boro421a_18 <- ggplot(data = byboro18,aes(x = reorder(Borough,desc(allcounts)), y = allcounts)) + geom_histogram(fill="blue", stat = "identity") + scale_x_discrete(labels = c("Brooklyn", "Queens", "Manhattan", "Bronx", "Staten Island"), name = "")+ scale_y_continuous(name = "") + ggtitle("FY 2017/18 421a Units By Borough") + theme(plot.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=14, hjust=0)) + geom_text(aes(label = comma(round(allcounts), digits = 0), sep=","), position = position_dodge(0.9), size=5, vjust=-0.25) + theme(axis.text.x = element_text(angle = 0, hjust = .5, size = 10))



byboro17 <- allnyc17 %>%
  na.omit() %>%
  group_by(Borough) %>%
  summarise(allcounts = NROW(Address)) %>%
  arrange(desc(allcounts))

boro421a_17 <- ggplot(data = byboro17,aes(x = reorder(Borough,desc(allcounts)), y = allcounts)) + geom_histogram(fill="blue", stat = "identity") + scale_x_discrete(labels = c("Brooklyn", "Queens", "Manhattan", "Bronx", "Staten Island"), name = "")+ scale_y_continuous(name = "") + ggtitle("FY 2016/17 421a Units By Borough") + theme(plot.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=14, hjust=0)) + geom_text(aes(label = comma(round(allcounts), digits = 0), sep=","), position = position_dodge(0.9), size=5, vjust=-0.25) + theme(axis.text.x = element_text(angle = 0, hjust = .5, size = 10))



byboro16 <- allnyc16 %>%
  na.omit() %>%
  group_by(Borough) %>%
  summarise(allcounts = NROW(Address)) %>%
  arrange(desc(allcounts))

boro421a_16 <- ggplot(data = byboro16,aes(x = reorder(Borough,desc(allcounts)), y = allcounts)) + geom_histogram(fill="blue", stat = "identity") + scale_x_discrete(labels = c("Brooklyn", "Queens", "Manhattan", "Bronx", "Staten Island"), name = "")+ scale_y_continuous(name = "") + ggtitle("FY 2015/16 421a Units By Borough") + theme(plot.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=14, hjust=0)) + geom_text(aes(label = comma(round(allcounts), digits = 0), sep=","), position = position_dodge(0.9), size=5, vjust=-0.25) + theme(axis.text.x = element_text(angle = 0, hjust = .5, size = 10))



byboro15 <- allnyc15 %>%
  na.omit() %>%
  group_by(Borough) %>%
  summarise(allcounts = NROW(Address)) %>%
  arrange(desc(allcounts))

boro421a_15 <- ggplot(data = byboro15,aes(x = reorder(Borough,desc(allcounts)), y = allcounts)) + geom_histogram(fill="blue", stat = "identity") + scale_x_discrete(labels = c("Brooklyn", "Queens", "Manhattan", "Bronx", "Staten Island"), name = "")+ scale_y_continuous(name = "") + ggtitle("FY 2014/15 421a Units By Borough") + theme(plot.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=14, hjust=0)) + geom_text(aes(label = comma(round(allcounts), digits = 0), sep=","), position = position_dodge(0.9), size=5, vjust=-0.25) + theme(axis.text.x = element_text(angle = 0, hjust = .5, size = 10))


byboro14 <- allnyc14 %>%
  na.omit() %>%
  group_by(Borough) %>%
  summarise(allcounts = NROW(Address)) %>%
  arrange(desc(allcounts))

boro421a_14 <- ggplot(data = byboro14,aes(x = reorder(Borough,desc(allcounts)), y = allcounts)) + geom_histogram(fill="blue", stat = "identity") + scale_x_discrete(labels = c("Brooklyn", "Queens", "Manhattan", "Bronx", "Staten Island"), name = "")+ scale_y_continuous(name = "") + ggtitle("FY 2013/14 421a Units By Borough") + theme(plot.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=14, hjust=0)) + geom_text(aes(label = comma(round(allcounts), digits = 0), sep=","), position = position_dodge(0.9), size=5, vjust=-0.25) + theme(axis.text.x = element_text(angle = 0, hjust = .5, size = 10))
myboro_chart <- list("2014"=boro421a_14,"2015"=boro421a_15,"2016"=boro421a_16,"2017"=boro421a_17,"2018"=boro421a_18)
years <-c("2014", "2015","2016","2017","2018")



#BY NEIGHBORHOOD

byneighb18 <- allnyc18 %>%
  na.omit() %>%
  group_by(Borough,Neighborhood) %>%
  summarise(allcounts = NROW(Address)) %>%
  arrange(desc(allcounts)) 


byneighb17 <- allnyc17 %>%
  na.omit() %>%
  group_by(Borough,Neighborhood) %>%
  summarise(allcounts = NROW(Address)) %>%
  arrange(desc(allcounts))

byneighb16 <- allnyc16 %>%
  na.omit() %>%
  group_by(Borough,Neighborhood) %>%
  summarise(allcounts = NROW(Address)) %>%
  arrange(desc(allcounts))

byneighb15 <- allnyc15 %>%
  na.omit() %>%
  group_by(Neighborhood) %>%
  summarise(allcounts = NROW(Address)) %>%
  arrange(desc(allcounts)) 

byneighb14 <- allnyc14 %>%
  na.omit() %>%
  group_by(Borough,Neighborhood) %>%
  summarise(allcounts = NROW(Address)) %>%
  arrange(desc(allcounts)) 

byboroandneighb <- as.data.frame(byneighb14)



#myneighborhood_chart <- list("2014"=allnyc14,"2015"=allnyc15,"2016"=allnyc16,"2017"=allnyc17,"2018"=allnyc18)
nbyears <-c("byneighb14", "byneighb15","byneighb16","byneighb17","byneighb18")



#Googlway Heatmap
nyccoordinates <- read.csv("geocoded421a.csv", header = TRUE, sep = ",")
nyccoordinates <- data.table(nyccoordinates)
nyccoordinatesA <- nyccoordinates[sample(.N, 500)]
nyccoordinatesB <- nyccoordinatesA[ which(nyccoordinatesA$Borough=="Brooklyn"), ]

geokey <- "AIzaSyAhH_6014s0bMwIDVbpn36BekqtpCm2eNM"
google_map(key = geokey, data = nyccoordinatesA) %>% 
  add_heatmap(data = nyccoordinatesA, lat = "lat", lon = "lon",option_radius = 0.01)




myboro <-c("Manhattan", "Bronx", "Brooklyn", "Queens", "SI")



#US Census 2000 through 2010

nyc_district_viz <- "https://raw.githubusercontent.com/Misterresearch/421a/master/nyc_district_census.csv"
nyc_district_viz <- read.csv(nyc_district_viz , header = TRUE, sep = ",")

nyc_district_viz$Demo1<-as.character(nyc_district_viz$District)
nyc_district_viz$Demo1[grep("Bronx", nyc_district_viz$Demo1)] <- "Bronx"
nyc_district_viz$Demo1[grep("Brooklyn", nyc_district_viz$Demo1)] <- "Brooklyn"
nyc_district_viz$Demo1[grep("Manhattan", nyc_district_viz$Demo1)] <- "Manhattan"
nyc_district_viz$Demo1[grep("Queens", nyc_district_viz$Demo1)] <- "Queens"
nyc_district_viz$Demo1[grep("Staten", nyc_district_viz$Demo1)] <- "Staten Island"
colnames(nyc_district_viz)[3] <- "Borough"

nyc_district_viz$Year.2000.Number <- as.numeric(as.character(gsub(",", "",nyc_district_viz$Year.2000.Number)))

nyc_district_viz$Year.2000.Percent <- as.numeric(as.character(gsub(",", "",nyc_district_viz$Year.2000.Percent)))

nyc_district_viz$Year.2010.Number <- as.numeric(as.character(gsub(",", "",nyc_district_viz$Year.2010.Number)))

nyc_district_viz$Year.2010.Percent <- as.numeric(as.character(gsub(",", "",nyc_district_viz$Year.2010.Percent)))

nyc_district_viz$Number.Change <- as.numeric(as.character(gsub(",", "",nyc_district_viz$Number.Change)))

nyc_district_viz$Percent.Change <- as.numeric(as.character(gsub(",", "",nyc_district_viz$Percent.Change)))



year2000_vector <- rep("2000", each = 6)
year2010_vector <- rep("2010", each = 6)

census_blk_2000 <- nyc_district_viz %>%
  filter(Race.Ethnicity=="Black Nonhispanic") %>%
  group_by(Borough) %>%
  summarise(mycounts = sum(Year.2000.Number)) %>%
  arrange(desc(mycounts))

census_blk_2000 = data.frame(year2000_vector,census_blk_2000)
colnames(census_blk_2000)[1]<-"Year"

census_blk_2010 <- nyc_district_viz %>%
  filter(Race.Ethnicity=="Black Nonhispanic") %>%
  group_by(Borough) %>%
  summarise(mycounts = sum(Year.2010.Number)) %>%
  arrange(desc(mycounts))

census_blk_2010 = data.frame(year2010_vector,census_blk_2010)
colnames(census_blk_2010)[1]<-"Year"

census_blk_boro = rbind(census_blk_2000,census_blk_2010)
blk_borocensus_chart <- ggplot(census_blk_boro, aes(fill=Year, y=mycounts, x=reorder(Borough,desc(mycounts)))) + scale_x_discrete(name = "") + geom_bar(position="dodge", stat="identity") + ggtitle("US Census - NYC Black Pop 2000 vs 2010 Borough (000)")+ geom_text(aes(label = comma(round(mycounts/1000), digits = 0), sep=","), position = position_dodge(0.9), size=3, vjust=-0.25) + theme(axis.text.x = element_text(angle = 0, hjust = .5, size = 6))



census_wht_2000 <- nyc_district_viz %>%
  filter(Race.Ethnicity=="White Nonhispanic") %>%
  group_by(Borough) %>%
  summarise(mycounts = sum(Year.2000.Number)) %>%
  arrange(desc(mycounts))

census_wht_2000 = data.frame(year2000_vector,census_wht_2000)
colnames(census_wht_2000)[1]<-"Year"

census_wht_2010 <- nyc_district_viz %>%
  filter(Race.Ethnicity=="White Nonhispanic") %>%
  group_by(Borough) %>%
  summarise(mycounts = sum(Year.2010.Number)) %>%
  arrange(desc(mycounts))

census_wht_2010 = data.frame(year2010_vector,census_wht_2010)
colnames(census_wht_2010)[1]<-"Year"

census_wht_boro = rbind(census_wht_2000,census_wht_2010)

wht_borocensus_chart <- ggplot(census_wht_boro, aes(fill=Year, y=mycounts, x=reorder(Borough,desc(mycounts)))) + scale_x_discrete(name = "") + geom_bar(position="dodge", stat="identity") + ggtitle("US Census - White Pop 2000 vs 2010 Borough (000)") + geom_text(aes(label = comma(round(mycounts/1000), digits = 0), sep=","), position = position_dodge(0.9), size=3, vjust=-0.25) + theme(axis.text.x = element_text(angle = 0, hjust = .5, size = 6))

census_hsp_2000 <- nyc_district_viz %>%
  filter(Race.Ethnicity=="Hispanic Origin") %>%
  group_by(Borough) %>%
  summarise(mycounts = sum(Year.2000.Number)) %>%
  arrange(desc(mycounts))

census_hsp_2000 = data.frame(year2000_vector,census_hsp_2000)
colnames(census_hsp_2000)[1]<-"Year"

census_hsp_2010 <- nyc_district_viz %>%
  filter(Race.Ethnicity=="Hispanic Origin") %>%
  group_by(Borough) %>%
  summarise(mycounts = sum(Year.2010.Number)) %>%
  arrange(desc(mycounts))

census_hsp_2010 = data.frame(year2010_vector,census_hsp_2010)
colnames(census_hsp_2010)[1]<-"Year"

census_hsp_boro = rbind(census_hsp_2000,census_hsp_2010)

hsp_borocensus_chart <- ggplot(census_hsp_boro, aes(fill=Year, y=mycounts, x=reorder(Borough,desc(mycounts)))) + scale_x_discrete(name = "") + geom_bar(position="dodge", stat="identity") + ggtitle("US Census - NYC Hispanic Origin Pop 2000 vs 2010 Borough (000)") + geom_text(aes(label = comma(round(mycounts/1000), digits = 0), sep=","), position = position_dodge(0.9), size=3, vjust=-0.25) + theme(axis.text.x = element_text(angle = 0, hjust = .5, size = 6))

census_azn_2000 <- nyc_district_viz %>%
  filter(Race.Ethnicity=="Asian and Pacific Islander Nonhispanic") %>%
  group_by(Borough) %>%
  summarise(mycounts = sum(Year.2000.Number)) %>%
  arrange(desc(mycounts))

census_azn_2000 = data.frame(year2000_vector,census_azn_2000)
colnames(census_azn_2000)[1]<-"Year"

census_azn_2010 <- nyc_district_viz %>%
  filter(Race.Ethnicity=="Asian and Pacific Islander Nonhispanic") %>%
  group_by(Borough) %>%
  summarise(mycounts = sum(Year.2010.Number)) %>%
  arrange(desc(mycounts))

census_azn_2010 = data.frame(year2010_vector,census_azn_2010)
colnames(census_azn_2010)[1]<-"Year"

census_azn_boro = rbind(census_azn_2000,census_azn_2010)

azn_borocensus_chart <- ggplot(census_azn_boro, aes(fill=Year, y=mycounts, x=reorder(Borough,desc(mycounts)))) + scale_x_discrete(name = "") + geom_bar(position="dodge", stat="identity") + ggtitle("US Census - NYC Asian Pop 2000 vs 2010 Borough (000)") + geom_text(aes(label = comma(round(mycounts/1000), digits = 0), sep=","), position = position_dodge(0.9), size=3, vjust=-0.25) + theme(axis.text.x = element_text(angle = 0, hjust = .5, size = 6))

census_multi_2000 <- nyc_district_viz %>%
  filter(Race.Ethnicity=="Two or More Races Nonhispanic") %>%
  group_by(Borough) %>%
  summarise(mycounts = sum(Year.2000.Number)) %>%
  arrange(desc(mycounts))

census_multi_2000 = data.frame(year2000_vector,census_multi_2000)
colnames(census_multi_2000)[1]<-"Year"

census_multi_2010 <- nyc_district_viz %>%
  filter(Race.Ethnicity=="Two or More Races Nonhispanic") %>%
  group_by(Borough) %>%
  summarise(mycounts = sum(Year.2010.Number)) %>%
  arrange(desc(mycounts))

census_multi_2010 = data.frame(year2010_vector,census_multi_2010)
colnames(census_multi_2010)[1]<-"Year"

census_multi_boro = rbind(census_multi_2000,census_multi_2010)

multi_borocensus_chart <- ggplot(census_multi_boro, aes(fill=Year, y=mycounts, x=reorder(Borough,desc(mycounts)))) + scale_x_discrete(name = "") + geom_bar(position="dodge", stat="identity") + ggtitle("US Census - NYC Multi-Racial Pop 2000 vs 2010 Borough (000)")+ geom_text(aes(label = comma(round(mycounts/1000), digits = 0), sep=","), position = position_dodge(0.9), size=3, vjust=-0.25) + theme(axis.text.x = element_text(angle = 0, hjust = .5, size = 6))

census_plots <- list("Asian"=azn_borocensus_chart,"Black"=blk_borocensus_chart,"Hispanic/Latino"=hsp_borocensus_chart,"Multi"=multi_borocensus_chart,"White"=wht_borocensus_chart)
my_race <-c("Asian", "Black", "Hispanic/Latino", "Multi", "White")

# ACS 2013-2016

nyc_neighb_viz <-"https://raw.githubusercontent.com/Misterresearch/421a/master/nyc_neighborhood_acs.csv"
nyc_neighb_viz<- read.csv(nyc_neighb_viz, header = TRUE, sep = ",")

nyc_neighb_viz$Borough <- gsub("The Bronx", "Bronx",nyc_neighb_viz$Borough)

nyc_neighb_viz$TotalPop <- as.numeric(as.character(gsub(",", "",nyc_neighb_viz$TotalPop)))

nyc_neighb_viz$Hispanic.Latino <- as.numeric(as.character(gsub(",", "",nyc_neighb_viz$Hispanic.Latino)))

nyc_neighb_viz$White <- as.numeric(as.character(gsub(",", "",nyc_neighb_viz$White)))
nyc_neighb_viz$Black <- as.numeric(as.character(gsub(",", "",nyc_neighb_viz$Black)))

nyc_neighb_viz$AmericanIndian <- as.numeric(as.character(gsub(",", "",nyc_neighb_viz$AmericanIndian)))

nyc_neighb_viz$Asian <- as.numeric(as.character(gsub(",", "",nyc_neighb_viz$Asian)))
nyc_neighb_viz$Puerto.Rican <- as.numeric(as.character(gsub(",", "",nyc_neighb_viz$Puerto.Rican)))

nyc_blk_boro <- nyc_neighb_viz %>%
  na.omit() %>%
  group_by(Year,Borough) %>%
  summarise(mycounts = sum(Black)) %>%
  arrange(desc(mycounts)) 

blk_borotrend_chart <- ggplot(nyc_blk_boro, aes(fill=Borough, y=mycounts, x=Year)) + 
  geom_bar(position="dodge", stat="identity") + ggtitle("NYC Black Pop by Year & Borough (000)") + geom_text(aes(label = comma(round(mycounts/1000), digits = 0), sep=","), position = position_dodge(0.9), size=3, vjust=-0.25) + theme(axis.text.x = element_text(angle = 0, hjust = .5, size = 10))


nyc_pr_boro <- nyc_neighb_viz %>%
  na.omit() %>%
  group_by(Year,Borough) %>%
  summarise(mycounts = sum(Puerto.Rican)) %>%
  arrange(desc(mycounts)) 

pr_borotrend_chart <- ggplot(nyc_pr_boro, aes(fill=Borough, y=mycounts, x=Year)) + 
  geom_bar(position="dodge", stat="identity") + ggtitle("NYC Puerto Rican Pop by Year & Borough (000)") + geom_text(aes(label = comma(round(mycounts/1000), digits = 0), sep=","), position = position_dodge(0.9), size=3, vjust=-0.25) + theme(axis.text.x = element_text(angle = 0, hjust = .5, size = 10))

nyc_hsp_boro <- nyc_neighb_viz %>%
  na.omit() %>%
  group_by(Year,Borough) %>%
  summarise(mycounts = sum(Hispanic.Latino)) %>%
  arrange(desc(mycounts)) 

hsp_borotrend_chart <- ggplot(nyc_hsp_boro, aes(fill=Borough, y=mycounts, x=Year)) + 
  geom_bar(position="dodge", stat="identity") + ggtitle("NYC Latino Pop by Year & Borough (000)") + geom_text(aes(label = comma(round(mycounts/1000), digits = 0), sep=","), position = position_dodge(0.9), size=3, vjust=-0.25)+ theme(axis.text.x = element_text(angle = 0, hjust = .5, size = 10))

nyc_wht_boro <- nyc_neighb_viz %>%
  na.omit() %>%
  group_by(Year,Borough) %>%
  summarise(mycounts = sum(White)) %>%
  arrange(desc(mycounts)) 

wht_borotrend_chart <- ggplot(nyc_wht_boro, aes(fill=Borough, y=mycounts, x=Year)) + 
  geom_bar(position="dodge", stat="identity") + ggtitle("NYC White Pop by Year & Borough (000)") + geom_text(aes(label = comma(round(mycounts/1000), digits = 0), sep=","), position = position_dodge(0.9), size=3, vjust=-0.25)+ theme(axis.text.x = element_text(angle = 0, hjust = .5, size = 10))

nyc_azn_boro <- nyc_neighb_viz %>%
  na.omit() %>%
  group_by(Year,Borough) %>%
  summarise(mycounts = sum(Asian)) %>%
  arrange(desc(mycounts)) 

azn_borotrend_chart <-ggplot(nyc_azn_boro, aes(fill=Borough, y=mycounts, x=Year)) + 
  geom_bar(position="dodge", stat="identity") + ggtitle("NYC Asian Pop by Year & Borough (000)") + geom_text(aes(label = comma(round(mycounts/1000), digits = 0), sep=","), position = position_dodge(0.9), size=3, vjust=-0.25)+ theme(axis.text.x = element_text(angle = 0, hjust = .5, size = 10))

acs_plots <- list("Asian"=azn_borotrend_chart,"Black"=blk_borotrend_chart,"Hispanic/Latino"=hsp_borotrend_chart,"Puerto Rican"=pr_borotrend_chart,"White"=wht_borotrend_chart)
my_raceA <-c("Asian", "Black", "Hispanic/Latino", "Puerto Rican", "White")

ui = fluidPage(title="NYC 421a Tax Abatement",
  titlePanel(p("NYC 421a Tax Abated Units, Gentrification and Race/Ethnicity",style = "color:#008000")),
  br(),
  br(),
  plotOutput("AllCity421a"),
  br(),
  br(),
  selectInput(inputId = "Year", 
              label = p(strong("Select Year", style = "color:navy; font-size: 18px")),
              choices = years,	selected = NULL, multiple = FALSE,
              selectize = TRUE, width = NULL, size = NULL),
  plotOutput("Borough421a"),
  br(),
  br(),
  selectInput(inputId = "myboro", 
              label = p(strong("Choose Borough 2017/18", style = "color:navy; font-size: 18px")),
              choices = myboro,	selected = NULL, multiple = TRUE,
              selectize = TRUE, width = NULL, size = NULL),
  google_mapOutput(outputId = "map"),
  br(),
  br(),
  selectInput(inputId = "YearNB", 
              label = p(strong("Select Year", style = "color:navy; font-size: 18px")),
              choices = years,	selected = NULL, multiple = FALSE,
              selectize = TRUE, width = NULL, size = NULL),
  selectInput(inputId = "Borough", 
              label = p(strong("Select Borough", style = "color:navy; font-size: 16px")),
              choices = myboro,	selected = NULL, multiple = FALSE,
              selectize = TRUE, width = NULL, size = NULL),
  plotOutput("Neighborhood"),
  br(),
  br(),
  titlePanel(p("NYC Race & Ethnicity Trends", style = "color:#008000")),
  br(),
  br(),
  selectInput(inputId = "Race", 
              label = p(strong("Select Group - US Census", style = "color:navy; font-size: 18px")),
              choices = my_race,	selected = NULL, multiple = FALSE,
              selectize = TRUE, width = NULL, size = NULL),
  plotOutput("USCensus"),
  br(),
  br(),
  selectInput(inputId = "RaceA", 
              label = p(strong("Select Group - Annual ACS", style = "color:navy; font-size: 18px")),
              choices = my_raceA,	selected = NULL, multiple = FALSE,
              selectize = TRUE, width = NULL, size = NULL),
  plotOutput("ACS")
)

server = function(input,output) {
  
  output$AllCity421a <-renderPlot({
  
    total_nyc_plot
  })
  
  output$Borough421a<-renderPlot({
  
    myboro_chart <- list("2014"=boro421a_14,"2015"=boro421a_15,"2016"=boro421a_16,"2017"=boro421a_17,"2018"=boro421a_18)
    myboro_chart[(input$Year)]  
  
  })
  
  
  geokey<- 'AIzaSyAhH_6014s0bMwIDVbpn36BekqtpCm2eNM'
  
  output$map <-renderGoogle_map({
    
    nyccoordinatesA <- nyccoordinates[sample(.N, 500)]
    nyccoordinatesB <- nyccoordinatesA
    nyccoordinatesB$lon<-as.numeric(nyccoordinatesB$lon)
    nyccoordinatesB$lat<-as.numeric(nyccoordinatesB$lat)
    
    google_map(key = geokey) %>% 
      add_heatmap(data = nyccoordinatesB, lat = "lat", lon = "lon",option_radius = 0.01) 
  })
  
  observeEvent(input$myboro, {
    
    nyccoordinatesA <- nyccoordinates[sample(.N, 500)]
    nyccoordinatesB <- nyccoordinatesA[ which(nyccoordinatesA$Borough==input$myboro), ]
    nyccoordinatesB$lon<-as.numeric(nyccoordinatesB$lon)
    nyccoordinatesB$lat<-as.numeric(nyccoordinatesB$lat)
    
    google_map_update(map_id = "map") %>%
      update_heatmap(data = nyccoordinatesB, lat = "lat", lon = "lon")
  })
  output$Neighborhood <-renderPlot({
    
    byneighb <- allnyc %>%
      na.omit() %>%
      group_by(Borough,Neighborhood,CountYear) %>%
      summarise(allcounts = NROW(Address)) %>%
      arrange(desc(allcounts))
    
    byboroandneighb <- as.data.frame(byneighb)
    byboroandneighb <-byboroandneighb[ which(byboroandneighb$CountYear==input$YearNB), ]
    byboroandneighb <-byboroandneighb[ which(byboroandneighb$Borough==input$Borough), ]
    
    ggplot(data = byboroandneighb[c(1:10),], aes(x=reorder(Neighborhood, desc(allcounts)), y = allcounts)) + geom_histogram(fill="grey", stat = "identity", color="blue") + scale_x_discrete(name ="") + scale_y_continuous(name = "") + ggtitle("421a Units Top 10 Neighborhood x Boro") + theme(plot.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=14, hjust=0)) + geom_text(aes(label = comma(round(allcounts)), sep=","), position = position_dodge(0.9), size=5, vjust=-0.25) + theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 9))
    
  })  
 
  output$USCensus<-renderPlot({
    
    census_plots <- list("Asian"=azn_borocensus_chart,"Black"=blk_borocensus_chart,"Hispanic/Latino"=hsp_borocensus_chart,"Multi"=multi_borocensus_chart,"White"=wht_borocensus_chart)
    census_plots[(input$Race)]
    
  }) 
  output$ACS<-renderPlot({
    
    acs_plots <- list("Asian"=azn_borotrend_chart,"Black"=blk_borotrend_chart,"Hispanic/Latino"=hsp_borotrend_chart,"Puerto Rican"=pr_borotrend_chart,"White"=wht_borotrend_chart)
    acs_plots[(input$RaceA)]
    
  })  

}
shinyApp(ui = ui, server = server)