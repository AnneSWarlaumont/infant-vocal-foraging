# You will need to install the lme4 and lmerTest packages.
# See http://derekogle.com/IFAR/supplements/installations/InstallPackagesRStudio.html
#logistic regression to test the effect of step sizes in frequency, amplitude, and time, on probability of a vocalisation receiveing a response, for both infants and adults with i) amplitude and pitch as independent variables, ii) amplitude, pitch, amplitude step size, as well as pitch step size and time step size from previous vocalisation to the current one as independent  variables


# Set the working directory to the directory containing the csv file
# Modify the line below for your own file system
setwd('/Users/ritu/Desktop/csv_files_vfinal/logisticreg')#this folder should only contain data for inter rater reliability stats


library(lme4)
library(lmerTest)
library(pracma)

# Read all file sin folder
aa = dir()

voc_type <- c() #assign vectors to be filled in
measure <- c()
datatype <- c()
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

for (i in 1:length(aa)){ #initiate for loop to read all .csv files 
	datamat = read.csv(aa[i], header = TRUE) #reads ith .csv file
	ss <- strsplit(aa[i],"_",fixed=TRUE) #gets adresp2ch.csv or chresp2ad.csv part of file name
	ss = as.matrix(unlist(ss))
	
	attach(datamat)
	id= as.factor(id)
response = as.factor(response)

if ((dim(ss)[1] > 3)&(strcmp(ss[3],"stepsizes") == TRUE)) { #for step size lmer
	if ((strcmp(ss[4],"HUM.csv") == TRUE)) { #for hum stepsizes
	
	chnmod = glmer(response ~ (1|id) + (1|listener) + scale(infantage) + scale(frequency) + scale(amplitude)  + scale(freq_dist) + scale(amp_dist)  + scale(time_dist), data = datamat, family=binomial())
		
		voc_type[i] <- ss[1] #gets chresp2ad, adresp2ch etc.
	measure[i] <- 'stepsizes' 
	datatype[i] <- 'HUM'
	
	age_effect[i] <- summary(chnmod)$coefficients [2,1]
	age_pval[i] <- summary(chnmod)$coefficients [2,4]
	
	freq_effect[i] <- summary(chnmod)$coefficients [3,1]
	freq_pval[i] <- summary(chnmod)$coefficients [3,4]	
	
	amp_effect[i] <- summary(chnmod)$coefficients [4,1]
	amp_pval[i] <- summary(chnmod)$coefficients [4,4]
	
	freqst_effect[i] <- summary(chnmod)$coefficients [5,1]
	freqst_pval[i] <- summary(chnmod)$coefficients [5,4]	
	
	ampst_effect[i] <- summary(chnmod)$coefficients [6,1]
	ampst_pval[i] <- summary(chnmod)$coefficients [6,4]
	
	timst_effect[i] <- summary(chnmod)$coefficients [7,1]
	timst_pval[i] <- summary(chnmod)$coefficients [7,4]
	
	
	
}else if ((strcmp(ss[4],"LENA.csv") == TRUE)){ #for lena subset stepsizes
	chnmod = glmer(response ~ (1|id) + scale(infantage) + scale(frequency) + scale(amplitude)  + scale(freq_dist) + scale(amp_dist)  + scale(time_dist), data = datamat, family=binomial())
		voc_type[i] <- ss[1] #gets chresp2ad, adresp2ch etc.
	measure[i] <- 'stepsizes' 
	datatype[i] <- 'LENA subset'
	
	age_effect[i] <- summary(chnmod)$coefficients [2,1]
	age_pval[i] <- summary(chnmod)$coefficients [2,4]
	
	freq_effect[i] <- summary(chnmod)$coefficients [3,1]
	freq_pval[i] <- summary(chnmod)$coefficients [3,4]	
	
	amp_effect[i] <- summary(chnmod)$coefficients [4,1]
	amp_pval[i] <- summary(chnmod)$coefficients [4,4]
	
	freqst_effect[i] <- summary(chnmod)$coefficients [5,1]
	freqst_pval[i] <- summary(chnmod)$coefficients [5,4]	
	
	ampst_effect[i] <- summary(chnmod)$coefficients [6,1]
	ampst_pval[i] <- summary(chnmod)$coefficients [6,4]
	
	timst_effect[i] <- summary(chnmod)$coefficients [7,1]
	timst_pval[i] <- summary(chnmod)$coefficients [7,4]
	
	
	
}	
	
} else if ((dim(ss)[1] == 3)&(strcmp(ss[3],"stepsizes.csv") == TRUE)) { #for all lena stepsizes
	chnmod = glmer(response ~ (1|id) + scale(infantage) + scale(frequency) + scale(amplitude)  + scale(freq_dist) + scale(amp_dist)  + scale(time_dist), data = datamat, family=binomial())
		voc_type[i] <- ss[1] #gets chresp2ad, adresp2ch etc.
	measure[i] <- 'stepsizes' 
	datatype[i] <- 'LENA all'
	
	age_effect[i] <- summary(chnmod)$coefficients [2,1]
	age_pval[i] <- summary(chnmod)$coefficients [2,4]
	
	freq_effect[i] <- summary(chnmod)$coefficients [3,1]
	freq_pval[i] <- summary(chnmod)$coefficients [3,4]	
	
	amp_effect[i] <- summary(chnmod)$coefficients [4,1]
	amp_pval[i] <- summary(chnmod)$coefficients [4,4]
	
	freqst_effect[i] <- summary(chnmod)$coefficients [5,1]
	freqst_pval[i] <- summary(chnmod)$coefficients [5,4]	
	
	ampst_effect[i] <- summary(chnmod)$coefficients [6,1]
	ampst_pval[i] <- summary(chnmod)$coefficients [6,4]
	
	timst_effect[i] <- summary(chnmod)$coefficients [7,1]
	timst_pval[i] <- summary(chnmod)$coefficients [7,4]
	
	
	} else if ((dim(ss)[1] == 2)&(strcmp(ss[2],"logisticreg.csv") == TRUE)) { #for all lena, no stepsizes
	chnmod = glmer(response ~ (1|id) + scale(infantage) + scale(frequency) + scale(amplitude), data = datamat, family=binomial())
		voc_type[i] <- ss[[1]] [1] #gets chresp2ad, adresp2ch etc.
	measure[i] <- 'pitch and amp' 
	datatype[i] <- 'LENA all'
	
	age_effect[i] <- summary(chnmod)$coefficients [2,1]
	age_pval[i] <- summary(chnmod)$coefficients [2,4]
	
	freq_effect[i] <- summary(chnmod)$coefficients [3,1]
	freq_pval[i] <- summary(chnmod)$coefficients [3,4]	
	
	amp_effect[i] <- summary(chnmod)$coefficients [4,1]
	amp_pval[i] <- summary(chnmod)$coefficients [4,4]
	
	freqst_effect[i] <- '-'
	freqst_pval[i] <- '-'	
	
	ampst_effect[i] <- '-'
	ampst_pval[i] <- '-'
	
	timst_effect[i] <- '-'
	timst_pval[i] <- '-'	
		


	
	}else if ((dim(ss)[1] == 3)&(strcmp(ss[3],"HUM.csv") == TRUE)) { #for hum, no stepsizes
	chnmod = glmer(response ~ (1|id) + + (1|listener) + scale(infantage) + scale(frequency) + scale(amplitude) , data = datamat, family=binomial())
		voc_type[i] <- ss[[1]] [1] #gets chresp2ad, adresp2ch etc.
	measure[i] <- 'pitch and amp' 
	datatype[i] <- 'HUM'
	
	age_effect[i] <- summary(chnmod)$coefficients [2,1]
	age_pval[i] <- summary(chnmod)$coefficients [2,4]
	
	freq_effect[i] <- summary(chnmod)$coefficients [3,1]
	freq_pval[i] <- summary(chnmod)$coefficients [3,4]	
	
	amp_effect[i] <- summary(chnmod)$coefficients [4,1]
	amp_pval[i] <- summary(chnmod)$coefficients [4,4]
	
	freqst_effect[i] <- '-'
	freqst_pval[i] <- '-'	
	
	ampst_effect[i] <- '-'
	ampst_pval[i] <- '-'
	
	timst_effect[i] <- '-'
	timst_pval[i] <- '-'	
	
	}else if ((dim(ss)[1] == 3)&(strcmp(ss[3],"LENA.csv") == TRUE)) { #for subset lena, no stepsizes
	chnmod = glmer(response ~ (1|id) + scale(infantage) + scale(frequency) + scale(amplitude) , data = datamat, family=binomial())
		voc_type[i] <- ss[[1]] [1] #gets chresp2ad, adresp2ch etc.
	measure[i] <- 'pitch and amp' 
	datatype[i] <- 'LENA subset'
	
	age_effect[i] <- summary(chnmod)$coefficients [2,1]
	age_pval[i] <- summary(chnmod)$coefficients [2,4]
	
	freq_effect[i] <- summary(chnmod)$coefficients [3,1]
	freq_pval[i] <- summary(chnmod)$coefficients [3,4]	
	
	amp_effect[i] <- summary(chnmod)$coefficients [4,1]
	amp_pval[i] <- summary(chnmod)$coefficients [4,4]
	
	freqst_effect[i] <- '-'
	freqst_pval[i] <- '-'	
	
	ampst_effect[i] <- '-'
	ampst_pval[i] <- '-'
	
	timst_effect[i] <- '-'
	timst_pval[i] <- '-'
	
	}
	






}

datf <- cbind(voc_type,measure,datatype,age_effect,age_pval,freq_effect,freq_pval,amp_effect,amp_pval,freqst_effect,freqst_pval,ampst_effect,ampst_pval,timst_effect,timst_pval) #make dataframe

write.csv(datf, file = "logistic_regression_results.csv",row.names=FALSE) #writes list to csv

