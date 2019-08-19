# You will need to install the lme4 and lmerTest packages.
# See http://derekogle.com/IFAR/supplements/installations/InstallPackagesRStudio.html
#linear mixed effects model to test the effect of response, age, and optional sample size and age-response interaction on median of step size distributions in frequency, amplitude, acoustic space, andtime, for adults and infants

library(lme4)
library(lmerTest)

# Set the working directory to the directory containing the csv file
# Modify the line below for your own file system
# setwd("/Users/ritu/Google Drive/research/vocalisation/clean_code_thats_used/csv_files_vfinal")
# desiredfiles = dir(path=".", pattern="^median*") #only files taht start with median

# Or, get the files from OSF (https://osf.io/8ern6/files/
# You will need the osfr package, https://centerforopenscience.github.io/osfr/)
# To get set up, run the following three lines of code:
# install.packages("remotes")
# library(remotes)
# remotes::install_github("centerforopenscience/osfr")
library(osfr)
# If needed, modify the line below for your own file system
setwd("~/Downloads")
osf_retrieve_file("https://osf.io/7eg5y/") %>% osf_download() # Downloads median_adresp2ch.csv
osf_retrieve_file("https://osf.io/tyqu9/") %>% osf_download() # Downloads median_chresp2ad.csv
desiredfiles = c("median_adresp2ch.csv","median_chresp2ad.csv")

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
	
	for (j in 1:4){ #the first four columns contain median variables
		
		###############################
		#model with response and age ONLY
		counter = counter + 1 #update counter
		
		mydata_lmer_model = lmer(scale(mydata[,j]) ~ (1|id) + response + scale(age), data= mydata) 
		
		sumary = summary(mydata_lmer_model)
	
		vocaliser[counter] = ss[2] #save vocaliser part of file name
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
		
		mydata_lmer_model = lmer(scale(mydata[,j]) ~ (1|id) + response + scale(age) + scale(samplesi), data= mydata) 
		
		sumary = summary(mydata_lmer_model)
	
		vocaliser[counter] = ss[2] #save vocaliser part of file name
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
		
		mydata_lmer_model = lmer(scale(mydata[,j]) ~ (1|id) + response + scale(age) + scale(age)*response, data= mydata) 
		
		sumary = summary(mydata_lmer_model)
	
		vocaliser[counter] = ss[2] #save vocaliser part of file name
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
		
		mydata_lmer_model = lmer(scale(mydata[,j]) ~ (1|id) + response + scale(age) + scale(samplesi) + scale(age)*response, data= mydata) 
		
		sumary = summary(mydata_lmer_model)
	
		vocaliser[counter] = ss[2] #save vocaliser part of file name
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

# setwd("/Users/ritu/Google Drive/research/vocalisation/clean_code_thats_used/csv_files_vfinal/Reported_results") #cd into folder to save into

median_stats <- list(as.data.frame(vocaliser), 
 as.data.frame(dpdt_var),
 as.data.frame(response_effect),
 as.data.frame(response_pval),
 as.data.frame(age_effect),
 as.data.frame(age_pval),
 as.data.frame(samplsi_effect),
 as.data.frame(samplsi_pval),
 as.data.frame(age_resp_interac_effect),
 as.data.frame(age_resp_interac_pval)) #creates a list
 
 write.csv(median_stats, file = "median_stats.csv",row.names=FALSE) 













