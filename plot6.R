# read data
library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Baltimore city, Maryland  or Los Angeles County, California
fipstarget <- c("24510","06037")
data <- subset(NEI, fips %in% fipstarget)

# find the SCC code for motor vehicle sources
motor <- grepl(".*Motor.*", SCC$Short.Name)
motorscc <- subset(SCC$SCC, motor)

motordata <- subset(data, data$SCC %in% factor(motorscc))
grp <- group_by(motordata, fips, year)
tot <- summarize(grp, sum(Emissions))
result <- data.frame(fips=tot[[1]], year=tot[[2]], sumEmission=tot[[3]])

dev.copy(png, file="plot6.png")

ggplot(subset(result, result$fips %in% fipstarget),
       aes(x=year, y=sumEmission, colour=fips)) + geom_point() + geom_smooth()

dev.off()