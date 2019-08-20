# You will need to install the lme4 and lmerTest packages.
# See http://derekogle.com/IFAR/supplements/installations/InstallPackagesRStudio.html
#logistic regression to test the effect of step sizes in frequency, amplitude, and time, on probability of a vocalisation receiveing a response, for both infants and adults with i) amplitude and pitch as independent variables, ii) amplitude, pitch, amplitude step size, as well as pitch step size and time step size from previous vocalisation to the current one as independent  variables


# Set the working directory to the directory containing the csv file
# Modify the line below for your own file system
# setwd("/Users/ritu/Google Drive/research/vocalisation/clean_code_thats_used/csv_files_vfinal")
# desiredfiles = dir(path=".", pattern="*logisticreg") # Read all files that contain "logisticreg"

# Or, get the files from OSF (https://osf.io/8ern6/files/
# You will need the osfr package, https://centerforopenscience.github.io/osfr/)
# To get set up, run the following three lines of code:
# install.packages("remotes")
# library(remotes)
# remotes::install_github("centerforopenscience/osfr")
library(osfr)
# If needed, modify the line below for your own file system
setwd("~/Downloads")
osf_retrieve_file("https://osf.io/vz9qy/") %>% osf_download() # Downloads advoc_logisticreg_stepsizes.csv
osf_retrieve_file("https://osf.io/sp2d7/") %>% osf_download() # Downloads advoc_logisticreg.csv
osf_retrieve_file("https://osf.io/wamzy/") %>% osf_download() # Downloads chvoc_logisticreg_stepsizes.csv
osf_retrieve_file("https://osf.io/8bn4t/") %>% osf_download() # Downloads chvoc_logisticreg.csv
desiredfiles = c("advoc_logisticreg_stepsizes.csv","advoc_logisticreg.csv","chvoc_logisticreg_stepsizes.csv","chvoc_logisticreg.csv")

library(lme4)
library(lmerTest)
library(pracma)

vocaliser <- c() #assign vectors to be filled in
measure <- c()
age_effect <- c()
age_pval <- c()
freq_effect <- c()
freq_pval <- c()
amp_effect <- c()
amp_pval <- c()
freqst_effect <- c()
freqst_pval <- c()
ampst_effect <- c()
ampst_pval <- c()
timst_effect <- c()
timst_pval <- c()

for (i in 1:length(desiredfiles)){ #initiate for loop to read all .csv files 
	
	mydata = read.csv(desiredfiles[i], header = TRUE) #reads ith .csv file
	
	ss <- strsplit(desiredfiles[i],"_",fixed=TRUE) #gets adresp2ch.csv or chresp2ad.csv part of file name
	ss = as.matrix(unlist(ss))
	
	attach(mydata)
	
	# Make ID and response be treated as a categorial variable instead of a numeric variable
	mydata$id = as.factor(mydata$id)
	mydata$response = as.factor(mydata$response)
	
if ((dim(ss)[1] == 3)&(strcmp(ss[3],"stepsizes.csv") == TRUE)) { #for all lena stepsizes
	
	mydata_lmer_model = glmer(response ~ (1|id) + scale(infantage) + scale(frequency) + scale(amplitude)  + scale(freq_dist) + scale(amp_dist)  + scale(time_dist), data = mydata, family=binomial())
	
	vocaliser[i] <- ss[1] #gets chresp2ad, adresp2ch etc.
	measure[i] <- 'stepsizes' 
		
	age_effect[i] <- summary(mydata_lmer_model)$coefficients [2,1]
	age_pval[i] <- summary(mydata_lmer_model)$coefficients [2,4]
	
	freq_effect[i] <- summary(mydata_lmer_model)$coefficients [3,1]
	freq_pval[i] <- summary(mydata_lmer_model)$coefficients [3,4]	
	
	amp_effect[i] <- summary(mydata_lmer_model)$coefficients [4,1]
	amp_pval[i] <- summary(mydata_lmer_model)$coefficients [4,4]
	
	freqst_effect[i] <- summary(mydata_lmer_model)$coefficients [5,1]
	freqst_pval[i] <- summary(mydata_lmer_model)$coefficients [5,4]	
	
	ampst_effect[i] <- summary(mydata_lmer_model)$coefficients [6,1]
	ampst_pval[i] <- summary(mydata_lmer_model)$coefficients [6,4]
	
	timst_effect[i] <- summary(mydata_lmer_model)$coefficients [7,1]
	timst_pval[i] <- summary(mydata_lmer_model)$coefficients [7,4]
	
	
	} else if ((dim(ss)[1] == 2)&(strcmp(ss[2],"logisticreg.csv") == TRUE)) { #for all lena, no stepsizes
		
	mydata_lmer_model = glmer(response ~ (1|id) + scale(infantage) + scale(frequency) + scale(amplitude), data = mydata, family=binomial())
	
	vocaliser[i] <- ss[[1]] [1] #gets chresp2ad, adresp2ch etc.
	measure[i] <- 'pitch and amp only' 
	
	age_effect[i] <- summary(mydata_lmer_model)$coefficients [2,1]
	age_pval[i] <- summary(mydata_lmer_model)$coefficients [2,4]
	
	freq_effect[i] <- summary(mydata_lmer_model)$coefficients [3,1]
	freq_pval[i] <- summary(mydata_lmer_model)$coefficients [3,4]	
	
	amp_effect[i] <- summary(mydata_lmer_model)$coefficients [4,1]
	amp_pval[i] <- summary(mydata_lmer_model)$coefficients [4,4]
	
	freqst_effect[i] <- '-'
	freqst_pval[i] <- '-'	
	
	ampst_effect[i] <- '-'
	ampst_pval[i] <- '-'
	
	timst_effect[i] <- '-'
	timst_pval[i] <- '-'	
		


	
	}





}

# setwd("/Users/ritu/Google Drive/research/vocalisation/clean_code_thats_used/csv_files_vfinal/Reported_results") #cd into folder to save into

logistic_regression_results <- cbind(vocaliser,measure,age_effect,age_pval,freq_effect,freq_pval,amp_effect,amp_pval,freqst_effect,freqst_pval,ampst_effect,ampst_pval,timst_effect,timst_pval) #make dataframe

write.csv(logistic_regression_results, file = "logistic_regression_results.csv",row.names=FALSE) #writes list to csv

