# You will need to install the lme4 and lmerTest packages.
# See http://derekogle.com/IFAR/supplements/installations/InstallPackagesRStudio.html
#linear mixed effects model to test the effect of response and age, on mean and std dev of acoustic features for adults and infants

library(lme4)
library(lmerTest)

# Set the working directory to the directory containing the csv file
# Modify the line below for your own file system
setwd("/Users/ritu/Google Drive/research/vocalisation/clean_code_thats_used")#/csv_files_vfinal")

desiredfiles = dir(path=".", pattern="*meanstd_WR_WOR*") #only files taht start with median

vocaliser = c()

age_effect = c()
age_pval = c()
response_effect = c()
response_pval = c()
age_resp_interac_effect = c()
age_resp_interac_pval = c()
dpdt_var = c()

counter = 0; #counts each lmer test

for (i in 1:length(desiredfiles)){ 
	ss <- strsplit(desiredfiles[i],"_",fixed=TRUE) #splits file name
	ss = as.matrix(unlist(ss))
	
	mydata = read.csv(desiredfiles[i], header = TRUE)
	
	attach(mydata)
	
	# Make ID and response be treated as a categorial variable instead of a numeric variable
	mydata$id = as.factor(mydata$id)
	mydata$response = as.factor(mydata$response)
	
	for (j in 4:7){ #these columns contain median variables
		
		###############################
		#model with response and age ONLY
		counter = counter + 1 #update counter
		
		mydata_lmer_model = lmer(scale(mydata[,j]) ~ (1|id) + response + scale(age), data= mydata) 
		
		sumary = summary(mydata_lmer_model)
		
		vocaliser[counter] = ss[5] #save vocaliser part of file name
		dpdt_var[counter] = colnames(mydata)[j] #save dependent variable name
		response_effect[counter] = sumary$coefficients[2,1]
		response_pval[counter] = sumary$coefficients[2,5]
		age_effect[counter] = sumary$coefficients[3,1]
		age_pval[counter] = sumary$coefficients[3,5]
		age_resp_interac_effect[counter] = "_"
		age_resp_interac_pval[counter] = "_"
		
		###############################
		#model with response, age, and age-response interac 
		counter = counter + 1 #update counter
		
		mydata_lmer_model = lmer(scale(mydata[,j]) ~ (1|id) + response + scale(age) + scale(age)*response, data= mydata) 
		
		sumary = summary(mydata_lmer_model)
	
		vocaliser[counter] = ss[5] #save vocaliser part of file name
		dpdt_var[counter] = colnames(mydata)[j] #save dependent variable name
		response_effect[counter] = sumary$coefficients[2,1]
		response_pval[counter] = sumary$coefficients[2,5]
		age_effect[counter] = sumary$coefficients[3,1]
		age_pval[counter] = sumary$coefficients[3,5]
		age_resp_interac_effect[counter] = sumary$coefficients[4,1]
		age_resp_interac_pval[counter] = sumary$coefficients[4,5]
		
		###############################
		
		}

detach(mydata)

}

#setwd("/Users/ritu/Google Drive/research/vocalisation/clean_code_thats_used/csv_files_vfinal/Reported_results") #cd into folder to save into

meanstd_WRWOR_stats <- list(as.data.frame(vocaliser), 
 as.data.frame(dpdt_var),
 as.data.frame(response_effect),
 as.data.frame(response_pval),
 as.data.frame(age_effect),
 as.data.frame(age_pval),
 as.data.frame(age_resp_interac_effect),
 as.data.frame(age_resp_interac_pval)) #creates a list
 
 write.csv(meanstd_WRWOR_stats, file = "meanstd_WRWOR_stats.csv",row.names=FALSE) 




