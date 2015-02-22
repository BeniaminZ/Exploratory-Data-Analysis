NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Extracting motor vehicle reltaed sources
Vehicle <- grepl("Vehicle",SCC$EI.Sector, ignore.case=TRUE)
VehicleSCC <- SCC[Vehicle,]$SCC
VehicleData<-NEI[NEI$SCC %in% VehicleSCC&NEI$fips == "24510",]

VehicleEmisByYr <- tapply(VehicleData$Emissions, VehicleData$year, sum)

install.packages("plotrix")
library(plotrix)
# Creating png file in workign directory
png(file = "./plot5.png", width = 480, height = 480, units = "px", bg="transparent")
barp(VehicleEmisByYr, names.arg = rownames(VehicleEmisByYr),col="grey", xlab="Year",
     ylab="PM2.5 Emission (tons)")
title(main="PM2.5 Motor Vehicle Source Emissions in Baltimore City", cex.main=1)
dev.off()
