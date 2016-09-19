library(ggmap)
library(dplyr)

# set working directory
setwd('~/Data/hit-and-run/')

# https://data.austintexas.gov/Public-Safety/APD-Incident-Extract-YTD/b4y9-5x39
d<-read.csv("APD_Incident_Extract_YTD.csv")

# remove out of range data point
d<-d[d$LONGITUDE < - 80,]

attach(d)


# create DWI dataset by using filter
#d<-filter(d, Crime.Type == "DWI" | Crime.Type == "DWI 2ND" | Crime.Type == "DWI .15 BAC OR ABOVE" | Crime.Type == "DWI - DRUG RECOGNITION EXPERT" | Crime.Type == "CRASH/INTOXICATION ASSAULT" | Crime.Type == "PUBLIC INTOXICATION"  | Crime.Type == "DRIVING WHILE INTOX / FELON" | Crime.Type == "DUI - AGE 17 TO 20")
d<-filter(d, Crime.Type == "CRASH/LEAVING THE SCENE")
# set the device as a dpf file
png(width = 1020, height=1020, units="px", filename="map_hirez_hitnrun.png")

# Downloads map from google maps
imagedata<-get_map(location=c(-97.7431, 30.2672), maptype = c("roadmap"), zoom=14)

# use the downloaded image and plot over it
ggmap(imagedata) + geom_point(aes(LONGITUDE, LATITUDE), data=d, alpha=0.2, col='blue', size=7)

# save the file to working directory
dev.off()
