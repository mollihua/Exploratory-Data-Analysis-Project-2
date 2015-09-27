# read data
library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Baltimore city, Maryland
baltimore <- subset(NEI, fips == "24510")

# find the SCC code for motor vehicle sources
motor <- grepl(".*Motor.*", SCC$Short.Name)
motorscc <- subset(SCC$SCC, motor)
motorbalt <- subset(baltimore, baltimore$SCC %in% factor(motorscc))

grp <- group_by(motorbalt, year)
tot <- summarize(grp, sum(Emissions))
result <- data.frame(year=tot[[1]],sumemi=tot[[2]])

barplot(result$sumemi, main="Total Emissions from motor vehicle sources in Baltimore City"
        , xlab="year", names.arg=c(result$year), cex.main=0.6)

dev.copy(png, file="plot5.png")
dev.off()