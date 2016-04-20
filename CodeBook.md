Source Data
The datasets used here are available for download as a compressed (.zip) file by following the link below:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Metadata associated with these datasets can be found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Data Set Information
Various parameters were measured through the use of the embedded accelerometer and gyroscope of a Samsung Galaxy S II smartphone worn by 30 volunteers aged between 19-48 years undergoing 6 different activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING). 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.
Attribute Information
For each record in the dataset the below information provided: 
.	Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
.	Triaxial Angular velocity from the gyroscope. 
.	A 561-feature vector with time and frequency domain variables. 
.	Its activity label. 
.	An identifier of the subject who carried out the experiment.

Operations performed on the datasets
Downloading and merging the datasets
The datasets were downloaded and store into a local file named "Data" before the relevant measurements and variable names files being extracted. Data from the training and test dataset (obtained from the files subject_train.txt, x_train.txt, y_train.txt, subject_test.txt, x_test.txt and y_test.txt) were then merged into the data.table "xmerge" with column names obtained from the second variable of the "features.txt" file.

Create a dataframe containing only the mean and standard deviation values
Use grep to extract the mean and std columns out of "xmerge". Create a new dataframe called "meanandstd" containing these measurements and add the participants and activities columns from "xmerge" using the data.table function of the data.table library.

Replace the numbers in the "activities" column by labels
Use the "activity_labels" file to extract the activity labels and substitute the numbers in the "activities" column of "meanandstd" with these labels.

Improve the variable names
tolower was used to turn the column names into lower case. The "." Were removed from the column names using the gsub function from the tidyr library.

Create a new tidy dataset with the average of each variable for each activity and participant
Using the melt functions from reshape2 library, the participant and activities columns were declared ids while the other columns were declared measure variables. Then, a new dataframe was created using the dcast function to reorganise the data as a function of activities and participant.

