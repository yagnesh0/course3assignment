## This program takes in two sets of data, training and testing data of the Human
## Activity Recognition Using Smartphone Datset and combines the two sets. After 
## combining the data, headers are added from a txt file and the activity IDs are
## transformed via mapping with another txt file. Out of the measureables, only the
## columns with 'mean()' and 'std()' are kept. The table is then manipulated to
## show the averages of each of the measureable columns based on unique pairs of
## subjectID and activity.


## Activity names and feature names are acquired via txt files. Feature names
## will be used as headers for the measureables. 
activityNames <- readLines("./UCI HAR Dataset/activity_labels.txt")
featureNames <- readLines("./UCI HAR Dataset/features.txt")

## Both lists are then split from their numeric and corresponding descriptive name
activityNamesSplit <-strsplit(activityNames," ")
featureNamesSplit <-strsplit(featureNames," ")

## Each list's descriptive names are placed into another vector
featureNamesCol <- character()
for(i in 1:length(featureNamesSplit)){
    featureNamesCol[i] <- featureNamesSplit[[i]][2]
}

activityNamesFactor <- character()
for(j in 1:length(activityNamesSplit)){
    activityNamesFactor[j] <- activityNamesSplit[[j]][2]
}

## All training data is loaded.
subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt") #Train Subject ID
xTrain <- read.table("./UCI HAR Dataset/train/X_train.txt") #Train Subject Data
yTrain <- read.table("./UCI HAR Dataset/train/Y_train.txt") #Train Activity ID

## Training data gets combined in the order below to make a large train data table
## column-wise.
trainDataTable <- cbind(subjectTrain,yTrain,xTrain)

## All testing data is loaded.
subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt") #Test Subject ID
xTest <- read.table("./UCI HAR Dataset/test/X_test.txt") #Test Subject Data
yTest <- read.table("./UCI HAR Dataset/test/Y_test.txt")  #Test Activity ID

## Testing data gets combined in the order below to make a large train data table
## column-wise.
testDataTable <- cbind(subjectTest,yTest,xTest)

## The training and testing data sets gets merged into one data table
tidyDataTable <- rbind(trainDataTable,testDataTable)

## Headers are added to the merged data table
names(tidyDataTable) <- c("subjectID","activity",featureNamesCol)

## Column 'activity' gets mapped to its descriptive names and serves as a factor
tidyDataTable$activity <- factor(x = tidyDataTable$activity, levels = c(1,2,3,4,5,6), labels = activityNamesFactor)

## The columns with the subjectID, activity, means, and std are located added into
## a vector
meanCols <- grep("mean\\(\\)",names(tidyDataTable))
stdCols <- grep("std\\(\\)",names(tidyDataTable))
keepCols <-c(1,2,meanCols,stdCols)

## Only those required columns are now stored (subjectID, activity, means, and stds)
tidyDataTable<-tidyDataTable[,keepCols]

## The tidyDataTable gets melted by id pairs of subjectID and activity
meltedTidyDataTable <- melt(tidyDataTable,id=c("subjectID","activity"))

## The melted tidyDataTable gets reorganized by averaging each of the measureables
## over unique pairs of subjectID and activity
tidyDataTable2 <- dcast(meltedTidyDataTable, subjectID + activity ~ variable, mean)

## This new tidy dataTable gets exported to a text file in csv-style.
write.table(tidyDataTable2,"tidyDataTable2toSubmit.txt",row.names = FALSE)

tidyDataTable2
