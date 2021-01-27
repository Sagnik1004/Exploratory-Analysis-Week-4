#reading the pm emission and classification datasets 
pm<- readRDS('summarySCC_PM25.rds')
source<- readRDS('Source_Classification_Code.rds')

#plot1/question 1

#subsetting the emission dataset pm by each of the 4 years
pm1999<- subset(pm, year== 1999)
pm2002<- subset(pm, year== 2002)
pm2005<- subset(pm, year== 2005)
pm2008<- subset(pm, year== 2008)

#finding the sum/total emission for each year
sum1999<- sum(pm1999$Emissions)
sum2002<- sum(pm2002$Emissions)
sum2005<- sum(pm2005$Emissions)
sum2008<- sum(pm2008$Emissions)

#creating the plot. 
#Using a bar plot to show the different total emission levels for each year
par(mar= c(4.5,4.5,4.5,4.5))
barplot(height = c(sum1999, sum2002, sum2005, sum2008), col = c(sum1999, sum2002, sum2005, sum2008), ylim = range(sum1999, sum2008), main = 'Comparison of total PM emissions over the years', xlab = 'Years', ylab = 'Total emissions', names.arg = c('1999', '2002','2005','2008'))
dev.copy(png, file= 'plot1.png')
dev.off()