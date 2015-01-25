setwd("/Users/lee/machine/JOHN03cleanDataProject")
library(dplyr)


testDataX <- read.table("./data/test/X_test.txt")
testDataY <- read.table("./data/test/y_test.txt")
testDataS <- read.table("./data/test/subject_test.txt")
testData <- cbind(testDataX, testDataY, testDataS)

trainDataX <- read.table("./data/train/X_train.txt")
trainDataY <- read.table("./data/train/y_train.txt")
trainDataS <- read.table("./data/train/subject_train.txt")
trainData <- cbind(trainDataX, trainDataY, trainDataS)

totData <- rbind(testData, trainData)
dim(totData)
means <- sapply(totData,mean)
sds <- sapply(totData,sd)

summaryData <- rbind(means, sds)

activityLabels <- read.table("./data/activity_labels.txt")
#rank3 = factor(rank2, labels=c("1","2","3","4","5") )
#ordered2 <- mutate(ordered2, rank3 = factor(rank2, labels=c("1","2","3","4","5") ))

colnames(totData)[length(totData) - 1] <- 'activity'
totData <- cbind(totData,factor(totData$activity, labels=activityLabels$V2))


featureLabels <- read.table("./data/features.txt")
featureLabels <- rbind(featureLabels, data.frame(V1 = NA, V2 = 'activity'))
featureLabels <- rbind(featureLabels, data.frame(V1 = NA, V2 = 'subject'))
featureLabels <- rbind(featureLabels, data.frame(V1 = NA, V2 = 'activityName'))

#colnames(summaryData) <- featureLabels$V2
featureLabels$V2

dim(totData)
colnames(totData) <- featureLabels$V2
head(totData)

length(names(totData))
length(unique(names(totData)))
t <- table(names(totData))
t[t > 1]


#featureLabels <- mutate(featureLabels, idx =  as.numeric(rownames(featureLabels)))
#featureLabels <- mutate(featureLabels, l2 =  paste(featureLabels$V2, featureLabels$idx, sep="_"))
#colnames(totData) <- featureLabels$l2
#names(totData)

#totData <- mutate(totData, subject_activity = paste(subject_563,activity_562))
head(totData)


#gData = group_by(totData, subject_563, activity_562)
#names(gData)
#summarize(gData)
#install.packages("ddply")
library(plyr)

ddply(totData, .(subject), numcolwise(mean))
ddply(totData, .(activity), numcolwise(mean))
result <- ddply(totData, .(activity, subject), numcolwise(mean))
write.table(result, "result.txt", row.name=FALSE )




