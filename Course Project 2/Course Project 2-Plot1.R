NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
# Extracting the sum of emissions for each year
emisData<-with (NEI,aggregate(NEI[,'Emissions'],by=list(year), sum, na.rm=TRUE))
# Seting the name of each column in the new ectraced dataset
names(emisData)<-c("Year", "Emission")
# Converting ton to kton
emisData$Emission<-emisData$Emission/1000
# Instal package for better looking barplot
install.packages("plotrix")
library(plotrix)
# Creating png file in workign directory
png(file = "./plot1.png", width = 480, height = 480, units = "px", bg="transparent")
barp(emisData$Emission, names.arg = emisData$Year,col="grey", xlab="Year", main="Total PM2.5 Emission", ylab="PM2.5 Emission (kilotons)")
dev.off()

