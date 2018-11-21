# You will need to install the lme4 and lmerTest packages.
# See http://derekogle.com/IFAR/supplements/installations/InstallPackagesRStudio.html
#linear mixed effects model to test the effect of vocalisations since last response, age, and optional sample size and age-vocalisations since last response interaction on mean step size in frequency, amplitude, acoustic space, time, speed in aocustic space, for adults and infants
#Mean step size stats were calculated for 3 different schemes - Binary, 2S, and 4B. 
#This exmaple is demonstrated using mean step sizes in speed in acoustic space for adult vocalisations per the Binary scheme. Change files and variables as necessary

library(lme4)
library(lmerTest)

# Set the working directory to the directory containing the csv file
# Modify the line below for your own file system
setwd('/Users/ritu/Desktop/csv_files_Apr172018')

# Load the data in the csv file into a data frame variable - change file as necessary
ch_fst = read.csv('ad_meansteps_binary_forstats.csv', header = TRUE)

attach(ch_fst)

# Make infant ID and vocalistaions sine last response (binary scheme) be treated as a categorial variable instead of a numeric variable
id_binary = as.factor(id_binary)
vocslastrep_mat_binary = as.factor(vocslastrep_mat_binary)

# Run a mixed effects regression - change dependent variable as necessary
chn_fstep_lmer_model = lmer(scale(vel_avg_binary) ~ (1|id_binary) + vocslastrep_mat_binary + scale(infantage_binary)+ scale(infantage_binary)*vocslastrep_mat_binary, data = ch_fst)
summary(chn_fstep_lmer_model)

#plot(age, expf, col=c("red","blue")[withad])

#add or remove sample size and interaction effects
#+ scale(smplsi_binary) + scale(infantage_binary)*vocslastrep_mat_binary


detach(ch_fst)
