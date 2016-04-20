#Download the zip file and store it into Data
download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile="./Data")

#Unzip Data and display the list of files
unzip("Data", list = TRUE)

#Read the relevant files using file paths shown from the previous display
ytest <- read.table(unzip("Data", "UCI HAR Dataset/test/y_test.txt"))
xtest <- read.table(unzip("Data", "UCI HAR Dataset/test/X_test.txt"))
subjecttest <- read.table(unzip("Data", "UCI HAR Dataset/test/subject_test.txt"))
ytrain <- read.table(unzip("Data", "UCI HAR Dataset/train/y_train.txt"))
xtrain <- read.table(unzip("Data", "UCI HAR Dataset/train/X_train.txt"))
subjecttrain <- read.table(unzip("Data", "UCI HAR Dataset/train/subject_train.txt"))
features <- read.table(unzip("Data", "UCI HAR Dataset/features.txt"))

#ASSIGNMENT PART 1
#Append the column names contained in the Features file to the X sets
#The names are in the second column of Features and therefore neead to be transposed to be the column names of the X sets
colnames(xtrain) <- t(features[2])
colnames(xtest) <- t(features[2])

#Add columns for "participants" and "activities" from the "Y"  and "SubjectTrain" sets to the "X" sets
library(data.table)
xtrain<-data.table(xtrain, "activities"=ytrain[,1], "participant"=subjecttrain[,1])
xtest<-data.table(xtest, "activities"=ytest[,1], "participant"=subjecttest[,1])

#Merge the train and test sets
xmerge<-rbind(xtrain,xtest)

#ASSIGNMENT PART 2
#Extract the measurements on mean() and std() and create a dataframe named meanandstd containing those measurements

meandata<-grep("mean()", colnames(xmerge), fixed = TRUE)
stdata<-grep("std()", colnames(xmerge), fixed = TRUE)
xmerge<-data.frame(xmerge)
meanandstd<-data.frame(xmerge[,c(563, 562, meandata, stdata)]) #A check with duplicated(colnames(meanandstd)) reveals no duplicated column names so all is fine

#Make all the column names to lower case for ease of use
colnames(meanandstd)=tolower(colnames(meanandstd))

#ASSIGNMENT PART 3
#Change numbers in the activities column of xmerge to activity names
meanandstd$activities[meanandstd$activities==1]<-"walking"
meanandstd$activities[meanandstd$activities==2]<-"walking upstairs"
meanandstd$activities[meanandstd$activities==3]<-"walking downstairs"
meanandstd$activities[meanandstd$activities==4]<-"sitting"
meanandstd$activities[meanandstd$activities==5]<-"standing"
meanandstd$activities[meanandstd$activities==6]<-"laying"

#ASSIGNMENT PART 4
#Remove the dots from the column names
library(tidyr)
colnames(meanandstd)<-gsub("\\.", "", colnames(meanandstd))

#ASSIGNMENT PART 5
#Create a new dataset called "tidydf" with the average of each variable for each activity and participant
library(reshape2)
meltdf<-melt(meanandstd,id=c("participant", "activities"), measure.vars = colnames(meanandstd[,3:68])) #separates the id variables and the measure variables
tidydf<-dcast(meltdf, activities + participant ~variable, mean) #casts the dataframe as a function of activities and participant

#write the new dataset to a .txt file
write.table(tidydf, file = "tidy.txt", row.names = FALSE)