NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Extracting motor vehicle reltaed sources
Vehicle <- grepl("Vehicle",SCC$EI.Sector, ignore.case=TRUE)
VehicleSCC <- SCC[Vehicle,]$SCC
VehicleBalt<-NEI[NEI$SCC %in% VehicleSCC&NEI$fips == "24510",]
VehicleLA<-NEI[NEI$SCC %in% VehicleSCC&NEI$fips == "06037",]

TotBalt<-aggregate(VehicleBalt[,"Emissions"], by=list(VehicleBalt$year), sum)
names(TotBalt)<-c("Year", "Emission")
TotBalt$City <- paste(rep("Baltimore", 4))

TotLA<-aggregate(VehicleLA[,"Emissions"], by=list(VehicleLA$year), sum)
names(TotLA)<-c("Year", "Emission")
TotLA$City <- paste(rep("Los Angeles", 4))
TotalEmis<-rbind(TotBalt,TotLA)

# Creating png file in workign directory
png(file = "./plot6.png", width = 480, height = 480, units = "px", bg="transparent")
qplot(y = Emission, x = Year, data = TotalEmis, color = City, 
      facets = . ~ City)+theme_bw()+scale_x_continuous(breaks=c(1999,2002,2005,2008))+
    geom_line()+labs(y = "PM2.5 Emission (tons)") +labs(x = "Year") +
    labs(title ="Total PM2.5 Emission in Baltimore City vs LA")+
    theme(axis.text = element_text(size = 8),panel.margin = unit(1, "lines"),
          panel.border = element_rect(linetype = "dashed", colour = "black"))
dev.off()

install.packages("plotrix")
library(plotrix)
# Creating png file in workign directory
png(file = "./plot5.png", width = 480, height = 480, units = "px", bg="transparent")
barp(VehicleEmisByYr, names.arg = rownames(VehicleEmisByYr),col="grey", xlab="Year",
     ylab="PM2.5 Emission (tons)")
title(main="PM2.5 Motor Vehicle Source Emissions in Baltimore City", cex.main=1)
dev.off()
