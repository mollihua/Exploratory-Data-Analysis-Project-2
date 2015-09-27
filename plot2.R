# read data
library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Baltimore city, Maryland
baltimore <- subset(NEI, fips == "24510")

grp <- group_by(baltimore, year)
tot <- summarize(grp, sum(Emissions))
result <- data.frame(year=tot[[1]],sumemi=tot[[2]])
barplot(result$sumemi, main="Total PM2.5 Emissions of Baltimore City", xlab="year", names.arg=c(result$year))

dev.copy(png, file="plot2.png")
dev.off()