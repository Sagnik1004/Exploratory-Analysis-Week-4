#reading the pm emission and classification datasets 
pm<- readRDS('summarySCC_PM25.rds')
source<- readRDS('Source_Classification_Code.rds')

#plot4/question 4

#finding all coal sources from the classification ('source') dataset
coal_sources<- source[grep('coal|Coal', source$Short.Name),]
coal_SCC<- coal_sources$SCC

#subsetting the emissions dataset by the coal-related sources
coal_df<- pm[pm$SCC %in% coal_SCC,] 
#finding the sum/total emission for coal related sources for each year and converting it into a dataframe
total_coal_emission<- tapply(coal_df$Emissions, coal_df$year, sum)
total_coal_emission<- as.data.frame(total_coal_emission)
total_coal_emission$Year<- rownames(total_coal_emission)

#creating the plot
plot(total_coal_emission$Year, total_coal_emission$total_coal_emission, type= 'o', col= 'blue', xlab = 'Year', ylab =  'Total emission', main = 'Comparison of emissions from coal realted sources over the years')
title(sub = 'Emissions from coal related sources have shown a decrease over the years')
dev.copy(png, file= 'plot4.png')
dev.off()
