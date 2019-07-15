# You will need to install the lme4 and lmerTest packages.
# See http://derekogle.com/IFAR/supplements/installations/InstallPackagesRStudio.html
#linear mixed effects model to test the effect of age, step sizes in time, and optional response and age-response interaction on step sizes in acoustic space, for both infants and adults
#Change files and variables as necessary

library(lme4)
library(lmerTest)

# Set the working directory to the directory containing the csv file
# Modify the line below for your own file system
setwd("/Users/ritu/Google Drive/research/vocalisation/clean_code_thats_used/csv_files_vfinal")

desiredfiles = dir(path=".", pattern="*_lmercorrltn*")

vocaliser = c()

time_effect = c()
time_pval = c()
age_effect = c()
age_pval = c()
resp_effect = c()
resp_pval = c()
resp_age_interac_effect = c()
resp_age_interac_pval = c()

counter = 0; #counts each lmer test

# Load the data in the csv file into a data frame variable - change file as necessary
for (i in 1:length(desiredfiles)){
	
	ss <- strsplit(desiredfiles[i],"_",fixed=TRUE) #splits file name
	ss = as.matrix(unlist(ss))
	
	mydata = read.csv(desiredfiles[i], header = TRUE)
	
	attach(mydata)
	
	# Make ID and response be treated as a categorial variable instead of a numeric variable
	mydata$id = as.factor(mydata$id)
	mydata$response = as.factor(mydata$response)
	
	#to find step size in acoustic space, we can simply do sqrt(freq step^2 + amplitude step^2)
	
	sp_dist <- sqrt((freq_dist)^2 + (amp_dist)^2)
	
	#############################################
	# do model with no age-response interaction; only age effect and steps in time
	counter = counter + 1
	
	# Run a mixed effects regression - change dependent variable as necessary
	mydata_lmer_model = lmer(scale(sp_dist) ~ (1|id) + scale(infantage) + scale(time_dist) + response, data = mydata)
	
	sumary = summary(mydata_lmer_model)
	
	vocaliser[counter] = ss[1] #save vocaliser part of file name
	age_effect[counter] = sumary$coefficients[2,1]
	age_pval[counter] = sumary$coefficients[2,5]
	time_effect[counter] = sumary$coefficients[3,1]
	time_pval[counter] = sumary$coefficients[3,5]
	resp_effect[counter] = sumary$coefficients[4,1]
	resp_pval[counter] = sumary$coefficients[4,5]
	resp_age_interac_effect[counter] = '_'
	resp_age_interac_pval[counter] = '_'
	
	###############################################
	# do model with age-response interaction
	counter = counter + 1
	
	# Run a mixed effects regression - change dependent variable as necessary
	mydata_lmer_model = lmer(scale(sp_dist) ~ (1|id) + scale(infantage) + scale(time_dist) + response + scale(infantage)*response, data = mydata)
	
	sumary = summary(mydata_lmer_model)
	
	vocaliser[counter] = ss[1] #save vocaliser part of file name
	age_effect[counter] = sumary$coefficients[2,1]
	age_pval[counter] = sumary$coefficients[2,5]
	time_effect[counter] = sumary$coefficients[3,1]
	time_pval[counter] = sumary$coefficients[3,5]
	resp_effect[counter] = sumary$coefficients[4,1]
	resp_pval[counter] = sumary$coefficients[4,5]
	resp_age_interac_effect[counter] = sumary$coefficients[5,1]
	resp_age_interac_pval[counter] = sumary$coefficients[5,5]
	
	###############################################
	# do model with no response or interaction
	counter = counter + 1
	
	# Run a mixed effects regression - change dependent variable as necessary
	mydata_lmer_model = lmer(scale(sp_dist) ~ (1|id) + scale(infantage) + scale(time_dist), data = mydata)
	
	sumary = summary(mydata_lmer_model)
	
	vocaliser[counter] = ss[1] #save vocaliser part of file name
	age_effect[counter] = sumary$coefficients[2,1]
	age_pval[counter] = sumary$coefficients[2,5]
	time_effect[counter] = sumary$coefficients[3,1]
	time_pval[counter] = sumary$coefficients[3,5]
	resp_effect[counter] = '_'
	resp_pval[counter] = '_'
	resp_age_interac_effect[counter] = '_'
	resp_age_interac_pval[counter] = '_'
	
	###############################################
		
	detach(mydata)
}

setwd("/Users/ritu/Google Drive/research/vocalisation/clean_code_thats_used/csv_files_vfinal/Reported_results") #cd into folder to save into

lmer_correlation_stats <- list(as.data.frame(vocaliser), 
 as.data.frame(time_effect),
 as.data.frame(time_pval),
 as.data.frame(age_effect),
 as.data.frame(age_pval),
 as.data.frame(resp_effect),
 as.data.frame(resp_pval),
 as.data.frame(resp_age_interac_effect),
 as.data.frame(resp_age_interac_pval)) #creates a list
 
 write.csv(lmer_correlation_stats, file = "lmer_correlation_stats.csv",row.names=FALSE) #writes list to csv

