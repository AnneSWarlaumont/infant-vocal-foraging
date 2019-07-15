# You will need to install the lme4 and lmerTest packages.
# See http://derekogle.com/IFAR/supplements/installations/InstallPackagesRStudio.html
#linear mixed effects model to test the effect of response, age, and optional sample size and age-response interaction on parameters of step size distributions in frequency, amplitude, acoustic space, and time, for adults and infants

library(lme4)
library(lmerTest)

# Set the working directory to the directory containing the csv file
# Modify the line below for your own file system
setwd("/Users/ritu/Google Drive/research/vocalisation/clean_code_thats_used/csv_files_vfinal")

source("/Users/ritu/Google Drive/research/vocalisation/clean_code_thats_used/codes_Github_vfinal/stats_R_and_matlab/newest_code/makenewdf_stepsiparam_lmer.R") #source the function to process mydata into new dataframe for analysis

desiredfiles = dir(path=".", pattern="*stepsizedist.csv") #only files taht start with median

vocaliser = c()

age_effect = c()
age_pval = c()
response_effect = c()
response_pval = c()
samplsi_effect = c()
samplsi_pval = c()
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
	
	for (j in 3:8){ #these are the columns that contain dependent variables
		
		dpdtvar = mydata[j] #gets the dependent variable
		
		df_foranalysis = makenewdf_stepsiparam_lmer(mydata,dpdtvar,j) #j is dependent variable index
		
		###############################
		#model with response and age ONLY
		counter = counter + 1 #update counter
		
		mydata_lmer_model = lmer(scale(df_foranalysis[1]) ~ (1|id) + response + scale(age), data= df_foranalysis)
		
		sumary = summary(mydata_lmer_model)
	
		vocaliser[counter] = ss[1] #save vocaliser part of file name
		dpdt_var[counter] = colnames(mydata)[j] #save dependent variable name
		response_effect[counter] = sumary$coefficients[2,1]
		response_pval[counter] = sumary$coefficients[2,5]
		age_effect[counter] = sumary$coefficients[3,1]
		age_pval[counter] = sumary$coefficients[3,5]
		samplsi_effect[counter] = "_"
		samplsi_pval[counter] = "_"
		age_resp_interac_effect[counter] = "_"
		age_resp_interac_pval[counter] = "_" 
		
		###############################
		#model with response, age, and samplesize ONLY
		counter = counter + 1 #update counter
		
		mydata_lmer_model = lmer(scale(df_foranalysis[1]) ~ (1|id) + response + scale(age) + scale(smplsize), data= df_foranalysis) 
		
		sumary = summary(mydata_lmer_model)
	
		vocaliser[counter] = ss[1] #save vocaliser part of file name
		dpdt_var[counter] = colnames(mydata)[j] #save dependent variable name
		response_effect[counter] = sumary$coefficients[2,1]
		response_pval[counter] = sumary$coefficients[2,5]
		age_effect[counter] = sumary$coefficients[3,1]
		age_pval[counter] = sumary$coefficients[3,5]
		samplsi_effect[counter] = sumary$coefficients[4,1]
		samplsi_pval[counter] = sumary$coefficients[4,5]
		age_resp_interac_effect[counter] = "_"
		age_resp_interac_pval[counter] = "_"
		
		###############################
		#model with response, age, and age-response interac ONLY
		counter = counter + 1 #update counter
		
		mydata_lmer_model = lmer(scale(df_foranalysis[1]) ~ (1|id) + response + scale(age) + scale(age)*response, data= df_foranalysis) 
		
		sumary = summary(mydata_lmer_model)
	
		vocaliser[counter] = ss[1] #save vocaliser part of file name
		dpdt_var[counter] = colnames(mydata)[j] #save dependent variable name
		response_effect[counter] = sumary$coefficients[2,1]
		response_pval[counter] = sumary$coefficients[2,5]
		age_effect[counter] = sumary$coefficients[3,1]
		age_pval[counter] = sumary$coefficients[3,5]
		samplsi_effect[counter] = "_"
		samplsi_pval[counter] = "_"
		age_resp_interac_effect[counter] = sumary$coefficients[4,1]
		age_resp_interac_pval[counter] = sumary$coefficients[4,5]
		
		###############################
		#model with response, age, samplesize, and age-response interac 
		counter = counter + 1 #update counter
		
		mydata_lmer_model = lmer(scale(df_foranalysis[1]) ~ (1|id) + response + scale(age) + scale(smplsize) + scale(age)*response, data= df_foranalysis) 
		
		sumary = summary(mydata_lmer_model)
	
		vocaliser[counter] = ss[1] #save vocaliser part of file name
		dpdt_var[counter] = colnames(mydata)[j] #save dependent variable name
		response_effect[counter] = sumary$coefficients[2,1]
		response_pval[counter] = sumary$coefficients[2,5]
		age_effect[counter] = sumary$coefficients[3,1]
		age_pval[counter] = sumary$coefficients[3,5]
		samplsi_effect[counter] = sumary$coefficients[4,1]
		samplsi_pval[counter] = sumary$coefficients[4,5]
		age_resp_interac_effect[counter] = sumary$coefficients[5,1]
		age_resp_interac_pval[counter] = sumary$coefficients[5,5]
		
	
	}

detach(mydata)

}

setwd("/Users/ritu/Google Drive/research/vocalisation/clean_code_thats_used/csv_files_vfinal/Reported_results") #cd into folder to save into

stsiparam_stats <- list(as.data.frame(vocaliser), 
 as.data.frame(dpdt_var),
 as.data.frame(response_effect),
 as.data.frame(response_pval),
 as.data.frame(age_effect),
 as.data.frame(age_pval),
 as.data.frame(samplsi_effect),
 as.data.frame(samplsi_pval),
 as.data.frame(age_resp_interac_effect),
 as.data.frame(age_resp_interac_pval)) #creates a list
 
 write.csv(stsiparam_stats, file = "stsiparam_stats.csv",row.names=FALSE) 












