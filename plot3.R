# read data
library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Baltimore city, Maryland
baltimore <- subset(NEI, fips == "24510")
grp <- group_by(baltimore, type, year)
tot <- summarize(grp, sum(Emissions))
result <- data.frame(type=tot[[1]], year=tot[[2]], sumEmission=tot[[3]])

dev.copy(png, file="plot3.png")

ggplot(subset(result, result$type %in% unique(result$type)),
       aes(x=year, y=sumEmission, colour=type)) + geom_point() + geom_smooth()

dev.off()
