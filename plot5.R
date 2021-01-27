#reading the pm emission and classification datasets 
pm<- readRDS('summarySCC_PM25.rds')
source<- readRDS('Source_Classification_Code.rds')

#plot5/question 5

#First subsetting the Baltimore city data out of the original dataset
baltimore<- subset(pm, pm$fips== '24510') #the baltimore dataframe

#finding all motor vehicle sources from the classification dataset i.e source
motor<- source[grep('motor|Motor', source$Short.Name),]

#subsetting baltimore dataframe by all motor vehicle sources  
motor_balti<- baltimore[baltimore$SCC %in% motor$SCC,] 

#finding the sum/total emission for motor sources in Baltimore for each year and converting it into a data frame 
motor_balti_sum<-tapply(motor_balti$Emissions, motor_balti$year, sum)
motor_balti_sum<- as.data.frame(motor_balti_sum)
motor_balti_sum$Year<- rownames(motor_balti_sum)

#creating the plot
#using barplot
library(ggplot2)
plot5<- ggplot(motor_balti_sum, aes(Year, motor_balti_sum, col= Year))+ geom_bar(stat = 'identity')+ ylab(label = 'Total Emission')+ ggtitle(label = 'Comparison of motor vehicle emission in Baltimore city over the years')
dev.copy(png, file= 'plot5.png')
dev.off()