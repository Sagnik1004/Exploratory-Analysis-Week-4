#reading the pm emission and classification datasets 
pm<- readRDS('summarySCC_PM25.rds')
source<- readRDS('Source_Classification_Code.rds')

#plot6/question 6

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

#Now subsetting the Los angeles  data out of the original dataset
Los_Angeles<- subset(pm, pm$fips== '06037')

#subsetting the Los_angeles dataframe by all motor vehicle sources  
motor_LA<- Los_Angeles[Los_Angeles$SCC %in% motor$SCC, ] #subsetting all motor sources from Los_Angeles dataframe

#finding the sum/total emission for motor sources in Los angeles for each year and converting it into a data frame 

motor_LA_sum<- tapply(motor_LA$Emissions, motor_LA$year, sum)
motor_LA_sum<- as.data.frame(motor_LA_sum)
motor_LA_sum$Year<- rownames(motor_LA_sum)

#we will be using standard deviation to find which city: Baltimore or Los Angeles had a bigger change in total motor emissions
sd_balti<- sd(motor_balti_sum$motor_balti_sum) #sd of total motor emission for Baltimore
sd_LA<- sd(motor_LA_sum$motor_LA_sum) #sd of total motor emission for Los Angeles

#now creating a dataframe with the standard deviation result for each city 
sd<- data.frame('sd'= c(sd_balti,sd_LA), 'City/County'= c('Baltimore', 'Los Angeles'))

#Creating the plot
#Using bar plot
par(mar= c(7,7,7,7))
plot6<- barplot(height = sd$sd, names.arg = sd$City.County, col = sd$sd, xlab = 'City/County', ylab = 'Standard Deviation', main = 'Comparing motor emission between Baltiore and LA', sub = 'LA showing a bigger change')
dev.copy(png, file= 'plot6.png')
dev.off()