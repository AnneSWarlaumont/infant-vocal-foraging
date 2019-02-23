All additional information that might be helpful is here:

- A .cdf file showing how exponential, pareto, and lognormal distributions vary as a 
function of their mean and standard deviation (Distribution_tails.cdf). Note that this requires mathematica or other .cdf player. 

- A .cdf file showing how lognormal and pareto distributions vary as a function of their parameters (lognormal_pareto_distributions.cdf). once again, this will require a .cdf player

- .csv files (generated using MATLAB code aic_hum_LENA_fitparameters_main.m) summarising how best fit AIC distributions vary for step size distributions in pitch, amplitude, 2d acoustic space, and time for human labelled and corresponding LENA labelled data. HUM_LENA_fitparameters_adresp2ch has results for infant vocalisations (with adult responses) and HUM_LENA_fitparameters_chresp2ad has results for adult vocs with infant responses. Response indicates whether the distributionwas for steps following a response (value 1) or not (value 0). Fit type 1 is normal (parameter 1 is mu, parameter 2 is sigma, where P(x) = (1/sqrt(2*pi*sigma*sigma))*exp{- ((x- mu)^2)/(2*sigma*sigma)}), 2 is lognormal (parameter 1 is mu, parameter 2 is sigma), 3 is exponential (parameter 1 is lambda), 4 is pareto (parameter 1 is x_min, parameter 2 is alpha). 

- .csv file (reliability_stats.csv) showing interrater reliability stats for human labelled and corresponding LENA data, from interrater reliability stats code (inter_rater_reliability_stats.R)

- .csv file with logistic regression stats (logistic_regression_results.csv) generated using logistic_regression_Rcode.R



