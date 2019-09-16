This folder contains R and matlab code for the stats we report. The code for the linear mixed effects model and the logistic regression was adapted from code written by co-authors Anne Warlaumont and Gina Pretzer.

Also note, function cohensKappa.m was written by Elliot Layden and downloaded from MATLAB file exchange: https://www.mathworks.com/matlabcentral/fileexchange/69943-simple-cohen-s-kappa. You will need this function to run interraterreliability calculations

These files can be executed in any order (except for makenewdf_stepsiparam_lmer.R, which is a function called by stepsize_dist_param_stats.R).

**mean_stddev_acoustic_features_stats.R** uses a linear mixed effects model on mean and std. dev of acoustic features (normalised amplitude and log pitch) with infant ID as a random effect and infant age as a fixed effect. Outputs "mean_std_acousticdim_stats.csv".

**correlation_lmer.R** tests whether steps in acoustic space and time for infants and adults are positively correlated using a linear mixed effects model by accounting for effects of infant age and using infant id as a random effect. Outputs "lmer_correlation_stats.csv".

**median_lmer_stats.R** and **prctile90_lmer_stats.R** use a linear mixed effects model runs a linear mixed effects model on median and 90th percentile value of step size distributions (computed before AIC-based fitting) with infant ID as a random effect; infant age and response as fixed effects; and sample size, and infantage-response interaction as optional fixed effects. Output "median_stats.csv" and "prctile90_stats.csv", respectively.  

**stepsize_dist_param_stats.R** runs a linear mixed effects model for step size distribution parameters (lambda of exponential distribution, mu and sigma of lognormal distribution, etc.) with infant ID as a random effect; infant age and response as fixed efefcts; and sample size, and infantage-response interaction as optional fixed effects. Outputs "stsiparam_stats.csv".

**makenewdf_stepsiparam_lmer.R** is a function required to run stepsize_dist_param_stats.R, where only the majority fit type curves are selected for the analyses for a given distribution type. For example, the majority best fit type for infant pitch step size distributions (WR) is exponential. This function writes a dataframe that only contains infant pitch step size distributions (WR) that are determined to best fit to an exponential per AIC to perform the linear mixed effects analysis on. It is assumed that the input csv files have columns where the parameters for each step type distribution are the ones appropriate for the majority fit type.

**logistic_regression_Rcode.R** uses a logistic regression model to test whether some vocalisations or vocalisation patterns are more likely to recieve responses for LENA data. Outputs "logistic_regression_results.csv".

**meanstd_WRWOR_acousticdim_stats.R** uses alinear mixed effects model on mean and std. dev of acoustic features (normalised amplitude and log pitch) with infant ID as a random effect and infant age, reception of a response, and optional age-response interaction as fixed effects. Outputs "meanstd_WRWOR_stats.csv".





