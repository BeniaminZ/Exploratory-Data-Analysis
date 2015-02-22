NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Extracting coal and comustion reltaed sources
CoalComb <- grepl("(Comb.+Coal)",SCC$Short.Name, ignore.case=TRUE)
CoalCombSCC <- SCC[CoalComb,]$SCC
CoalCombData<-NEI[NEI$SCC %in% CoalCombSCC,]
CoalEmisByYr <- tapply(CoalCombData$Emissions, CoalCombData$year, sum)

install.packages("plotrix")
library(plotrix)
# Creating png file in workign directory
png(file = "./plot4.png", width = 480, height = 480, units = "px", bg="transparent")
barp(CoalEmisByYr/1000, names.arg = rownames(CoalEmisByYr),col="grey", xlab="Year",
     ylab="PM2.5 Emission (kilotons)")
title(main="PM2.5 Coal Combustion Source Emissions Across US from 1999-2008", cex.main=1)
dev.off()
