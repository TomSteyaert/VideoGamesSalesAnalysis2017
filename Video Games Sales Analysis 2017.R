
#Here I import video game data from January 2017
videoGameData<-read.table(file="C:/Users/Tom/Desktop/Video_Game_Sales_as_of_Jan_2017.csv",header=T,sep=",",fill = T,quote="")

#We look at the head and tail of the data just to see what may be typical
#values or missing values in our data set
head(videoGameData)
tail(videoGameData)

#We take a subset of our data that only includes rows with no missing values,
#i.e., rows that are complete
completeData<-videoGameData[complete.cases(videoGameData), ]

#in order to observe this data on a smaller and more manageable scale, I take 
#a subset of just the first 300 entries of our complete data. Notice that the games
#near the tail end of the data have much smaller values, so looking at a subset
#with more similar values highlights trends more accurately.
first300<-completeData[1:300, ]
first300


#from eyeballing this plot we can guess that user score and critic score probably 
#don't correlate, even though I thought that they would
plot(first300$Critic_Score,first300$User_Score,xlab="Critic Score",ylab="User Score", main = "Critic VS User Scores",type = "p")

#when we run this correlation we see that there's only a .385 correlation
#coefficient, which suggests that critic score and user score do not 
#correlate with each other
cor(first300$Critic_Score, first300$User_Score)

