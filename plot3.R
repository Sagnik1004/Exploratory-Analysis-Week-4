#reading the pm emission and classification datasets 
pm<- readRDS('summarySCC_PM25.rds')
source<- readRDS('Source_Classification_Code.rds')
#plot3/question 3

#First subsetting the Baltimore city data out of the original dataset
baltimore<- subset(pm, pm$fips== '24510') #the baltimore dataframe

#Now subsetting the Baltimore city data by each of the 4 sources: point, non point, on road, non road
point_df<- subset(baltimore, type== 'POINT')
nonpoint_df<- subset(baltimore, type== 'NONPOINT')
on_road_df<- subset(baltimore, type== 'ON-ROAD')
non_road_df<- subset(baltimore, type== 'NON-ROAD')

#now finding the sum/total emission for each source for each year
sum_point<- tapply(point_df$Emissions, point_df$year, sum)
sum_nonpoint<- tapply(nonpoint_df$Emissions, nonpoint_df$year, sum)
sum_on_road<- tapply(on_road_df$Emissions, on_road_df$year, sum)
sum_non_road<- tapply(non_road_df$Emissions, non_road_df$year, sum)

#now changing the total emission results into dataframes and giving appropriate column names
sum_point<- as.data.frame(sum_point)
sum_point$Year<- rownames(sum_point)

sum_nonpoint<- as.data.frame(sum_nonpoint)
sum_nonpoint$Year<- rownames(sum_nonpoint)

sum_on_road<- as.data.frame(sum_on_road)
sum_on_road$Year<- rownames(sum_on_road)

sum_non_road<- as.data.frame(sum_non_road)
sum_non_road$Year<- rownames(sum_non_road)

library(ggplot2)
library(gridExtra) #for using the grid.arrange func for plotting multiplt ggplots

#using barplots here
point_plot<- ggplot(sum_point, aes(Year, sum_point, col= Year))+ geom_bar(stat = 'identity')+ ylab(label = 'Total Emission')+ ggtitle(label = 'Point sources')
nonpoint_plot<- ggplot(sum_nonpoint, aes(Year, sum_nonpoint, col= Year))+ geom_bar(stat = 'identity')+ ylab(label = 'Total Emission')+ ggtitle(label = 'Non point sources')
on_road_plot<- ggplot(sum_on_road, aes(Year, sum_on_road, col= Year))+ geom_bar(stat = 'identity')+ ylab(label = 'Total Emission')+ ggtitle(label = 'On road sources')
non_road_plot<- ggplot(sum_non_road, aes(Year, sum_non_road, col= Year))+ geom_bar(stat = 'identity')+ ylab(label = 'Total Emission')+ ggtitle(label = 'Non road sources')

#plotting the 4 barplots in 1 window
grid.arrange(point_plot, nonpoint_plot, on_road_plot, non_road_plot, nrow= 2, ncol= 2)
dev.copy(png, file= 'plot3.png')
dev.off()