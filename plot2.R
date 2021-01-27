#reading the pm emission and classification datasets 
pm<- readRDS('summarySCC_PM25.rds')
source<- readRDS('Source_Classification_Code.rds')

#plot2/question 2

#First subsetting the Baltimore city data out of the original dataset
baltimore<- subset(pm, pm$fips== '24510') #the baltimore dataframe
#subsetting the Baltimore data by each year
balti_1999<- subset(baltimore, year==1999)
balti_2002<- subset(baltimore, year==2002)
balti_2005<- subset(baltimore, year==2005)
balti_2008<- subset(baltimore, year==2008)

#finding the sum/total emission for each year
sum_balti_1999<- sum(balti_1999$Emissions)
sum_balti_2002<- sum(balti_2002$Emissions)
sum_balti_2005<- sum(balti_2005$Emissions)
sum_balti_2008<- sum(balti_2008$Emissions)

#creating the plot. 
#Using a bar plot to show the different Total emission levels for each year
par(mar= c(4.5,4.5,4.5,4.5))
barplot(height = c(sum_balti_1999, sum_balti_2002, sum_balti_2005, sum_balti_2008), names.arg = c('1999', '2002', '2005', '2008'), col = c(sum_balti_1999, sum_balti_2002, sum_balti_2005, sum_balti_2008), xlab = 'Years', ylab = 'Total emissions', ylim = range(sum_balti_1999, sum_balti_2008), main = 'Comparison of total PM emissions in Baltimore city over the years')
dev.copy(png, file= 'plot2.png')
dev.off()
