# read data
library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

grp <- group_by(NEI, year)
tot <- summarize(grp, sum(Emissions))
result <- data.frame(year=tot[[1]],sumemi=tot[[2]])
barplot(result$sumemi, main="Total PM2.5 Emissions", xlab="year", names.arg=c(result$year))

dev.copy(png, file="plot1.png")
dev.off()

