# read data
library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# find the SCC code for coal combustion-related sources
coal <- grepl(".*Coal.*",SCC$EI.Sector)
coalscc <- subset(SCC$SCC, coal)
coalnei <- subset(NEI, NEI$SCC %in% factor(coalscc))

grp <- group_by(coalnei, year)
tot <- summarize(grp, sum(Emissions))
result <- data.frame(year=tot[[1]],sumemi=tot[[2]])

barplot(result$sumemi, main="Total PM2.5 Emissions for coal-related sources", xlab="year", names.arg=c(result$year))

dev.copy(png, file="plot4.png")
dev.off()

