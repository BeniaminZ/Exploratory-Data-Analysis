library(plyr)
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
# Extracting Baltimore data
BaltData<-NEI[NEI$fip=="24510",]
# Sum of emissions based on year and type
emisDataTpYr <- aggregate(Emissions ~ type + year, data = BaltData,FUN = sum)

# Creating png file in workign directory
png(file = "./plot3.png", width = 480, height = 480, units = "px", bg="transparent")
qplot(y = Emissions, x = year, data = emisDataTpYr, color = type, 
    facets = . ~ type)+theme_bw()+scale_x_continuous(breaks=c(1999,2002,2005,2008))+
    geom_line()+labs(y = "PM2.5 Emission") +labs(x = "Year") +
    labs(title ="Total PM2.5 Emission in Baltimore City")+
    theme(axis.text = element_text(size = 8),panel.margin = unit(1, "lines"),
          panel.border = element_rect(linetype = "dashed", colour = "black"))
dev.off()


