# You will need to install the irr package.
# See http://derekogle.com/IFAR/supplements/installations/InstallPackagesRStudio.html
#R code to determine interrater reliability for human labelled data and coresponding LENA labelled data

library(irr)

setwd('/Users/ritu/Desktop/csv_files_Apr172018/interraterreliab')

# Load the data in the csv file into a data frame variable - change file as necessary

aa = dir() #read all csv files

#the for loop iteratively goes through each file and calculates cohen's kappa and percent agreement values
#each file contains the speaker labels as labelled by LENA and human listener for a child at a given age, for a given human listener. For eg, 274_L1_interraterreliability.csv contains LENA and human listener labels for child 274 (at this point, there aren't human validations for the same child at different ages, so the child id is sufficient for identification) by listener L1 as well as LENA. 

kappa_value=c()
perc_agree = c()
childid = c()
listener = c()

for (i in 1:length(aa)){
	datamat = read.csv(aa[i], header = TRUE) #reads ith .csv file
	attach(datamat)
	dat <- datamat[,2:3] #the speaker labels are in columns 2 and 3
	kappa_value[i] = kappa2(dat, "unweighted")$value #unweighted kappa value for 2 raters
	perc_agree[i] = agree(dat)$value #simple percent agreement
	childid[i] = strsplit(aa[i],"_",fixed=TRUE) [[1]] [1]
	listener[i] = strsplit(aa[i],"_",fixed=TRUE) [[1]] [2]
	detach(datamat)
}

reliability_stats <- list(as.data.frame(kappa_value), 
 as.data.frame(perc_agree),
 as.data.frame(childid),
 as.data.frame(listener)) #creates a list
 
 write.csv(reliability_stats, file = "reliability_stats.csv",row.names=FALSE) #writes list to csv
 

