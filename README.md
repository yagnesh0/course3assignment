# course3assignment

## Summary

####This program takes in two sets of data, training and testing data of the Human Activity Recognition Using Smartphone Datset and combines the two sets. After combining the data, headers are added from a txt file and the activity IDs are transformed via mapping with another txt file. Out of the measureables, only the columns with 'mean()' and 'std()' are kept. The table is then manipulated to show the averages of each of the measureable columns based on unique pairs of subjectID and activity.

## Loading in “Activity Names” and “Feature Names”
####Activity names and feature names are acquired via txt files. Feature names will be used as headers for the measureables. 

`activityNames <- readLines("./UCI HAR Dataset/activity_labels.txt")
featureNames <- readLines("./UCI HAR Dataset/features.txt”)`

## Splitting lists
#### Both lists are then split from their numeric and corresponding descriptive name
`activityNamesSplit <-strsplit(activityNames," ")
featureNamesSplit <-strsplit(featureNames," “)`

#### Each list's descriptive names are placed into another vector
`<featureNamesCol <- character()
for(i in 1:length(featureNamesSplit)){
    featureNamesCol[i] <- featureNamesSplit[[i]][2]
}`

`activityNamesFactor <- character()
for(j in 1:length(activityNamesSplit)){
    activityNamesFactor[j] <- activityNamesSplit[[j]][2]
}`

##Loading Data Sets
#### All training data is loaded.
`subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt") #Train Subject ID
xTrain <- read.table("./UCI HAR Dataset/train/X_train.txt") #Train Subject Data
yTrain <- read.table("./UCI HAR Dataset/train/Y_train.txt") #Train Activity ID`