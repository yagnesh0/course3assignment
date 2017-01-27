# course3assignment

## Summary

####This program takes in two sets of data, training and testing data of the Human Activity Recognition Using Smartphone Datset and combines the two sets. After combining the data, headers are added from a txt file and the activity IDs are transformed via mapping with another txt file. Out of the measureables, only the columns with 'mean()' and 'std()' are kept. The table is then manipulated to show the averages of each of the measureable columns based on unique pairs of subjectID and activity.

## Loading in “Activity Names” and “Feature Names”
###Activity names and feature names are acquired via txt files. Feature names will be used as headers for the measureables. 
`<activityNames <- readLines("./UCI HAR Dataset/activity_labels.txt")
featureNames <- readLines("./UCI HAR Dataset/features.txt”)>`