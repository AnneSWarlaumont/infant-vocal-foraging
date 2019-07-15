# You will need to install the lme4 and lmerTest packages.
# See http://derekogle.com/IFAR/supplements/installations/InstallPackagesRStudio.html
#linear mixed effects model to test the effect of age effect on measures that do not have response received as an indepednent variable (eg. mean, std.dev of individual acoustic dimensions)

library(lme4)
library(lmerTest)

# Set the working directory to the directory containing the csv file
# Modify the line below for your own file system
setwd("/Users/ritu/Google Drive/research/vocalisation/clean_code_thats_used/csv_files_vfinal")

desiredfiles = dir(path=".", pattern="*corrltn_mean.csv")

vocaliser = c()

age_effect = c()
age_pval = c()
dpdt_var = c()

counter = 0; #counts each lmer test

colnum <- c(1,2,5,6) #these are the column number for each table that contains the dependent variables we are interested in  (mean and std of f and d)

# Load the data in the csv file into a data frame variable - change file as necessary
for (i in 1:length(desiredfiles)){
	
	ss <- strsplit(desiredfiles[i],"_",fixed=TRUE) #splits file name
	ss = as.matrix(unlist(ss))
	
	mydata = read.csv(desiredfiles[i], header = TRUE)
	
	attach(mydata)
	
	# Make ID and response be treated as a categorial variable instead of a numeric variable
	mydata$id = as.factor(mydata$id)
	
	for (j in colnum){#these are the relevant columns in mydata 
		
		counter = counter + 1 #update counter
		
		mydata_lmer_model = lmer(scale(mydata[,j]) ~ (1|id) + scale(age), data= mydata) 
		
		sumary = summary(mydata_lmer_model)
	
		vocaliser[counter] = ss[1] #save vocaliser part of file name
		dpdt_var[counter] = colnames(mydata)[j] #save dependent variable name
		age_effect[counter] = sumary$coefficients[2,1]
		age_pval[counter] = sumary$coefficients[2,5]
		
		}
		
	detach(mydata)
	}
	
	
	setwd("/Users/ritu/Google Drive/research/vocalisation/clean_code_thats_used/csv_files_vfinal/Reported_results") #cd into folder to save into

mean_std_acousticdim_stats <- list(as.data.frame(vocaliser), 
 as.data.frame(dpdt_var),
 as.data.frame(age_effect),
 as.data.frame(age_pval)) #creates a list
 
 write.csv(mean_std_acousticdim_stats, file = "mean_std_acousticdim_stats.csv",row.names=FALSE) #writes list to csv


	
	
	
	
	
	
	
	
	

