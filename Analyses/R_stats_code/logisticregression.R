# You will need to install the lme4 and lmerTest packages.
# See http://derekogle.com/IFAR/supplements/installations/InstallPackagesRStudio.html
#logistic regression to test the effect of step sizes in frequency, amplitude, and time, on probability of a vocalisation receiveing a response, for both infants and adults.
#This exmaple is demonstrated using probablity of infant vocalistion receiving adult response with amplitude and frequency as independant variables. Change files and variables as necessary
#this script can also be used to do a logistic regression on the probability of a response with z-scored frequency and amplitude, and time, as independent variables.

# Set the working directory to the directory containing the csv file
# Modify the line below for your own file system
setwd('/Users/ritu/Desktop/csv_files_Apr172018')

library(lme4)
library(lmerTest)

# Load the data in the csv file into a data frame variable - change file as necessary
ch_fst = read.csv('chvoc_logisticreg_HUM.csv', header = TRUE)

attach(ch_fst)

# Make ID and whetehr or not a response was recieved to be treated as a categorial variable instead of a numeric variable
id= as.factor(id)
response = as.factor(response)
#listener = as.factor(listener) #Uncomment for human labelled data

# Run a mixed effects regression - change dependent and independent variables as necessary
chn_fstep_lmer_model = glmer(response ~ (1|id) + scale(infantage) + scale(frequency) + scale(amplitude) + (1|listener), data = ch_fst, family=binomial())
summary(chn_fstep_lmer_model)

detach(ch_fst)

#################
#to test the same for human labelled data, add id of human listener as a random effect
#for human label: + (1|listener) :listenerid as random effect

#for step sizes as independent variables
#glmer(response ~ (1|id) + scale(freq_dist) + scale(infantage) + scale(amp_dist) + scale(time_dist), data = ch_fst, family=binomial())

#for amplitude and frequency as independent variables
#glmer(response ~ (1|id) + scale(amplitude) + scale(frequency) + scale(infantage), data = ch_fst, family=binomial())