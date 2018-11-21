# You will need to install the lme4 and lmerTest packages.
# See http://derekogle.com/IFAR/supplements/installations/InstallPackagesRStudio.html
#linear mixed effects model to test the effect of age, step sizes in time, and optional response, and age-response interaction on step sizes in acoustic space, for both infants and adults
#If response is considered an independent variable, 
#This exmaple is demonstrated using infant vocalisations. Change files and variables as necessary

library(lme4)
library(lmerTest)

# Set the working directory to the directory containing the csv file
# Modify the line below for your own file system
setwd('/Users/ritu/Desktop/csv_files_Apr172018')

# Load the data in the csv file into a data frame variable - change file as necessary
ch_fst = read.csv('chvoc_logisticreg_stepsizes.csv', header = TRUE)

attach(ch_fst)

# Make ID be treated as a categorial variable instead of a numeric variable
id = as.factor(id)

#to find step size in acoustic space, we can simply do sqrt(freq step^2 + amplitude step^2)

sp_dist <- sqrt((freq_dist)^2 + (amp_dist)^2)

# Run a mixed effects regression - change dependent variable as necessary
chn_fstep_lmer_model = lmer(scale(sp_dist) ~ (1|id) + scale(infantage) + scale(time_dist), data = ch_fst)
summary(chn_fstep_lmer_model)

#to test these for human labelled data, add (1|listenerid) as a random effect

#plot(age, expf, col=c("red","blue")[withad])

detach(ch_fst)
