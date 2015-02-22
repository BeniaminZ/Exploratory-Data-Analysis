NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
# Extracting Baltimore data
BaltData<-NEI[NEI$fip=="24510",]
# Total PM2.5 emission for Baltimore for each year
BaltEmis<-tapply(BaltData$Emissions, BaltData$year,sum, na.rm=TRUE)
# Creating png file in workign directory
png(file = "./plot2.png", width = 480, height = 480, units = "px", bg="transparent")
barp(BaltEmis, names.arg = rownames(BaltEmis),col="grey", main="Total PM2.5 Emission in Baltimore City", xlab="Year", ylab="PM2.5 Emission (tons)")
dev.off()