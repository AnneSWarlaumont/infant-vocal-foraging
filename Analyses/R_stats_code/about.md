This folder contains R code for the stats we report. The code for the linear mixed effects model and the logistic regression 
was adapted from code written by co-authors Anne Warlaumont and Gina Pretzer. 

These files can be executed in any order.

correlation_lmer.r tests whether steps in acoustic space and time for infants and adults are positively correlated using a linear mixed effects model by accouting for effects of infant age and using infant id as a random effect.

inter_rater_reliability_stats.r computes interrater reliability measures for human labelled data and corresponding LENA labelled data, and writes the results to a .csv file

logisticregression.r uses a logistic regression model to test whether some vocalisations or vocalisation patterns are more likely to recieve responses.

median_n_prctile_stats.r uses a linear mixed effects model to test the effect of response, infant age and optional sample size on median and 90th percentile value of step size distributions (computed before AIC-based fitting) with infant id as a random effect.

stepsize_dist_param_stats.r uses a linear mixed effects model to test the effect of response, infant age and optional sample size on parameters of step size distributions (computed using AIC) with infant id as a random effect. Can also be optionally used for the same functionality as median_n_prctile_stats.r

nonresponse_dpdt_measures_stats.r uses a linear mixed effects model to test the effect of infant age on mean and std dev of amplitude and frequency for infant and adult vocalisations, with infant id as a random effect.

***Note that some code in this directory might require .csv files that are analysed to be grouped into folders.
