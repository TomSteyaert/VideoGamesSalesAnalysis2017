
#I got my data from this URL: https://www.kaggle.com/kendallgillies/video-game-sales-and-ratings

#Here I import video game data from January 2017
videoGameData<-read.table(file="C:/Users/Tom/Desktop/Video_Game_Sales_as_of_Jan_2017.csv",header=T,sep=",",fill = T,quote="")

#Here I multiplied the user score by 10 so that it would be on a 0-100 scale
#likw the critic score is.
videoGameData$User_Score<-videoGameData$User_Score*10

#We look at the head and tail of the data just to see what may be typical
#values or missing values in our data set
head(videoGameData)
tail(videoGameData)


#We take a subset of our data that only includes rows with no missing values,
#i.e., rows that are complete
completeData<-videoGameData[complete.cases(videoGameData), ]

#We convert European, North American, and Japan sales to numeric values
#because they were incorrectly imported as factors.
completeData$EU_Sales <- as.numeric(as.character(completeData$EU_Sales))
completeData$NA_Sales <- as.numeric(as.character(completeData$NA_Sales))
completeData$JP_Sales <- as.numeric(as.character(completeData$JP_Sales))



#in order to observe this data on a smaller and more manageable scale, I take 
#a subset of just the first 300 entries of our complete data. Notice that the games
#near the tail end of the data have much smaller values, so looking at a subset
#with more similar values highlights trends more accurately.
first300<-completeData[1:300, ]
first300
head(first300)

#from eyeballing this plot we can guess that user score and critic score probably 
#don't correlate, even though I thought that they would
plot(first300$Critic_Score,first300$User_Score,xlab="Critic Score",ylab="User Score", main = "Critic VS User Scores",type = "p")

#when we run this correlation we see that there's only a .385 correlation
#coefficient, which suggests that critic score and user score do not 
#correlate with each other
cor(first300$Critic_Score, first300$User_Score)


cor(first300$NA_Sales, first300$EU_Sales)
cor(first300$JP_Sales, first300$EU_Sales)
cor(first300$NA_Sales, first300$JP_Sales)

#after running a few correlations above we see that North America sales and European
#sales are correlated with each other (correlation coefficient=.785), so we won't
#include both in our regression model for predicting Global sales, to prevent
#multicollinearity.

#below we run a simple regression to see how well North American sales data
#predicts Global Sales data.
simpleReg <-lm(first300$Global_Sales ~ first300$NA_Sales, data=first300)
summary(simpleReg)
#Global Sales=1.86*NA_Sales+.96103
#Our adjusted R-squared value is .8797, which means that our model explains 87.97%
#of the variability of the variable Global sales.



