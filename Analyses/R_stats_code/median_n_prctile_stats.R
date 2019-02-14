# You will need to install the lme4 and lmerTest packages.
# See http://derekogle.com/IFAR/supplements/installations/InstallPackagesRStudio.html
#linear mixed effects model to test the effect of response, age, and optional sample size and age-response interaction on median of step size distributions in frequency, amplitude, acoustic space, andtime, for adults and infants
#This exmaple is demonstrated using median of step sizes in acoustic space for infant vocalisations. Change files and variables as necessary
#this script can also be used to do linear mixed effects model stats for nth percentile values. 

library(lme4)
library(lmerTest)

# Set the working directory to the directory containing the csv file
# Modify the line below for your own file system
setwd('/Users/ritu/Desktop/csv_files_Apr172018')

# Load the data in the csv file into a data frame variable - change file as necessary
ch_fst = read.csv('median_adresp2ch.csv', header = TRUE)

attach(ch_fst)

# Make ID and withad/withch (binary variable for response received or not) be treated as a categorial variable instead of a numeric variable
id = as.factor(id)
withad = as.factor(withad) #for infant response, this would be withch

# Run a mixed effects regression - change dependent variable as necessary
chn_fstep_lmer_model = lmer(scale(median_sp) ~ (1|id) + withad + scale(age), data = ch_fst)
summary(chn_fstep_lmer_model)

#add or remove sample size and interaction effects
#plot(age, expf, col=c("red","blue")[withad])
#+ scale(samplesi) + scale(age)*withad

detach(ch_fst)
