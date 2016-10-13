# Getting and cleaning Data Course Project
____________________________________________________________________________________________________
#1. Merge the training and the test sets to create one data set.

#All training and datasets provided were moved into one folder. 

#load in all files to use for this assignment
#---------------
Xtrain<-read.table("X_train.txt")
Ytrain<-read.table("Y_train.txt")
subjecttrain<-subjecttest<-read.table("Subject_train.txt")
#--------------
Xtest<-read.table("X_test.txt")
Ytest<-read.table("Y_test.txt")
subjecttest<-read.table("Subject_test.txt")
#----------
labels<-read.table("activity_labels.txt")
features<-read.table("features.txt")

#Create a two datasets that contain 1) all the training data and 2) all the test data
TrainData<-data.frame(cbind(Ytrain,subjecttrain,Xtrain))
TestData<-data.frame(cbind(Ytest,subjecttest,Xtest))

#check
head(TrainData)
head(TestData)

#Create a vector to identify test and train sets
DataID<-c(rep("test",nrow(Ytest)),rep("train",nrow(Ytrain)))
DataID

#merge datasets by row so that the test data appears before the train data
mergedata<-data.frame(rbind(TestData,TrainData))
#Check that this worked. The column number is conserved but the rows = sum (train + test set rows) - looks good
head(mergedata)
tail(mergedata)
#add an identifier for the merged dataset to specify trainig or test set. Check  - looks good
mergedata[564]<-DataID
head(mergedata)

____________________________________________________________________________________________________
2. Extracts only the measurements on the mean and standard deviation for each measurement.

# find columns with names that contain mean in the features file. 
features
featuresMean <- grep(".*mean.*", features[,2])
featuresMean
#Check that the first three features identifed,  have mean in the name and that features 5-20 do not have mean in the name.
#looks good 
features[,2][1:20]


# find columns with names that contain std in the features file.
#Check that the features 4,5,6 have std in the name and that all other features in the first 20 listed do not have std in the name.
#looks good  
featuresSD <- grep(".*std.*", features[,2])
featuresSD
features[,2][1:20]


#add column names to the merged dataset using the features information and the additonal data columns from step 1.
colnames(mergedata)<-c("activity","subject",as.character(features[,2]),"Purpose")
head(mergedata)

#Restrict the dataset to extract only columns that have the mean and Standard devaiaiton values for each measurement
# Remeber that the first two columns were added to the dataset so the columns identified by the featuresMean and featuresSD vectors
#need to be increased by two
featuresMean<- featuresMean + 2
featuresSD <-featuresSD +2

#Create one vector containing all column numbers wanted
select.me<-sort(c(1,2,featuresMean,featuresSD,564))
select.me

#subset the datafame for columns of interest and check the dataframe
mergedata<-mergedata[,select.me]
head(mergedata)
tail(mergedata)
___________________________________________________________________________________
_______________________________________________________________________________________________
3. Uses descriptive activity names to name the activities in the data set
_______________________________________________________________________________________________
#The descriptive activity names are in the activy_lables.txt document that was saved as labels in step 1.
#This variable Links the class labels with their activity name. 
#The traiing and test values that that proivide the class labels are Y _train and Y_test located in the first
#column of the mergedata dataframe

# rename the data based on the labels, Y_train, and Y _test sets.
mergedata$activity[mergedata$activity ==1]<- "walking"
mergedata$activity[mergedata$activity==2] <- "Walking_upstairs"
mergedata$activity[mergedata$activity==3] <- "Walking_downstairs"
mergedata$activity[mergedata$activity==4] <- "Sitting"
mergedata$activity[mergedata$activity==5] <- "Standing"
mergedata$activity[mergedata$activity==6] <- "Laying"

#Check - looks good
mergedata$activity 
head(mergedata$activity)

_______________________________________________________________________________________________
4. Appropriately labels the data set with descriptive variable names.
_______________________________________________________________________________________________
#The variable names are provided in the features vector
# This was completed in step 2 and used to check that only variables with the name mean and std remained in the dataset
colnames(mergedata)
__________________________________________________________________________________
5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

newdata<-aggregate(mergedata,by=list(activity = mergedata$activity,subject = mergedata$subject), FUN=mean, na.action = na.omit)
#remove the last two columns that do not contain measured information
newdata<-newdata[,1:83]

#remove columns 3 and 4 since they are not important to this new dataset
newdata<-newdata[,c(1:2,5:83)]

#check   - values calculated individually match the values calculated using the aggregate funciton - looks good
Check<- subset(mergedata,mergedata$subject ==1& mergedata$activity =="Standing")
colnames(Check[3:5])
mean(Check[,3])
mean(Check[,4])
mean(Check[,5])
head(newdata[1:6,1:6])

 #Save data
write.table(newdata, "tidy_data.txt",row.names=FALSE)

_______________________________________________________________________________________

