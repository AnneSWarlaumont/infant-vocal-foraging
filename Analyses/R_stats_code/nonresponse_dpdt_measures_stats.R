# You will need to install the lme4 and lmerTest packages.
# See http://derekogle.com/IFAR/supplements/installations/InstallPackagesRStudio.html
#linear mixed effects model to test the effect of age, and optional sample size on measures that do not have response received as an indepednent variable (eg. mean, std.dev of individual acoustic dimensions)
#This exmaple is demonstrated using std deviation of amplitude values of infant. Change files and variables as necessary
library(lme4)
library(lmerTest)

# Set the working directory to the directory containing the csv file
# Modify the line below for your own file system
setwd('/Users/ritu/Desktop/csv_files_Apr172018')

# Load the data in the csv file into a data frame variable - change file as necessary
ch_fst = read.csv('chvoc_corrltn_mean.csv', header = TRUE)

attach(ch_fst)

# Make infant ID be treated as a categorial variable instead of a numeric variable
id = as.factor(id)

# Run a mixed effects regression - change dependent variable as necessary
chn_fstep_lmer_model = lmer(scale(std_d_ch) ~ (1|id) + scale(age), data = ch_fst)
summary(chn_fstep_lmer_model)

#add or remove sample size and interaction effects
#plot(age, expf, col=c("red","blue")[withad])
#+ scale(samplsi)

detach(ch_fst)
