# You will need to install the lme4 and lmerTest packages.
# See http://derekogle.com/IFAR/supplements/installations/InstallPackagesRStudio.html

#linear mixed effects model to test the effect of (adult/infant) response, infant age, and optional sample size on median, 90th percentile value, and fit parameters of step size distributions. Interaction b/n infant age and response can be added optionally.
#This exmaple is demonstrated using exponential parameter lambda of amplitude step sizes of infant vocalisations. library(lme4)
library(lmerTest)

# Set the working directory to the directory containing the csv file
# Modify the line below for your own file system
setwd('/Users/ritu/Desktop/csv_files_Apr172018')

# Load the data in the csv file into a data frame variable
ch_fst = read.csv('chr2ad_stepsizedist.csv', header = TRUE)

attach(ch_fst)

# Make ID and withad be treated as a categorial variable instead of a numeric variable
id = as.factor(id)
withch = as.factor(withch) #withad for adult responses; withch for child responses

#Note that for fit-based analysis (eg. exponential parameter lambda, lognormal parameters sigma and mu, etc.) we only use datasets that were best to fit to a given fit family per AIC criterion. For eg. Infant frequency steps were predomninatly fit to exponential. However, datsets of infant frequency step sizes that were not best fit to exponential would be excluded from thsi analysis. This particular line of code should be excluded for non-fit-dependenat stats

#we are analysing frequency fits for infant - frequency fits are predominantly exponential, so only pick those. 
#amplitude and frequency (inf and adult) - exponential, 3
#space(infant and adult) - lognormal, 2
#time (infant) - logn, 2
#time (adult) - pareto, 4
#[1 - normal; 2 - lognormal; 3 - exp; 4 - pareto]

id = id[d_fit == 3] 
withch = withch[d_fit == 3]
age = age[d_fit == 3] 
expd = expd[d_fit == 3] 
smplsize = smplsize[d_fit == 3] 

# Run a mixed effects regression
chn_fstep_lmer_model = lmer(scale(expd) ~ (1|id) + withch + scale(age), data = ch_fst)
summary(chn_fstep_lmer_model)

#plot(age, expf, col=c("red","blue")[withad])
#+ scale(smplsize) + scale(age)*withad  - optional add sample size and/or age-response interactions

detach(ch_fst)
