This folder contains R and matlab code for the stats we report. The code for the linear mixed effects model and the logistic regression was adapted from code written by co-authors Anne Warlaumont and Gina Pretzer.

Also note, function cohensKappa.m was written by Elliot Layden and downloaded from MATLAB file exchange: https://www.mathworks.com/matlabcentral/fileexchange/69943-simple-cohen-s-kappa. You will need this function to run interraterreliability calculations

These files can be executed in any order.

correlation_lmer.r tests whether steps in acoustic space and time for infants and adults are positively correlated using a linear mixed effects model by accouting for effects of infant age and optional response, and infantage-response interaction effects, and using infant id as a random effect.

logistic_regression_Rcode.R uses a logistic regression model to test whether some vocalisations or vocalisation patterns are more likely to recieve responses for LENA data.

stepsize_dist_param_stats.R runs a linear mixed effects model for step size distribution parameters (lambda of exponential distribution, mu and sigma of lognormal distribution, etc.) with infant ID as a random effect; infant age and response as fixed efefcts; and sample size, and infantage-response interaction as optional fixed effects. 

makenewdf_stepsiparam_lmer.R is a function required to run stepsize_dist_param_stats.R, where only teh majority fit type curves are selected for the analyses for a given distribution type. For example, the majority best fit type for infant pitch step size distributions (WR) is exponential. This function writes a dataframe that only contains infant pitch step size distributions (WR) that are determined to best fit to an exponential per AIC to perform the linear mixed effects analysis on. 

median_lmer_stats.R and prctile90_lmer_stats.R use a linear mixed effects model runs a linear mixed effects model on median and 90th percentile value of step size distributions (computed before AIC-based fitting) with infant ID as a random effect; infant age and response as fixed efefcts; and sample size, and infantage-response interaction as optional fixed effects. 

mean_stddev_acoustic_features_stats.R uses a linear mixed effects model runs a linear mixed effects model on mean and std. dev of acoustic features (normalised amplitude and log pitch) with infant ID as a random effect and infant age as a fixed effect.


