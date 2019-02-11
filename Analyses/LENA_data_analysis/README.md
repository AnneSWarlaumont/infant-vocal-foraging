This directory contains files to analyse the recordings as labelled by LENA. Run the files in generating_matfiles 
before running files here. 

--------------------------------
In folder correlation, you will find .m files used to determine the correlation between step sizes in acoustic space and time using MATLAB's corrcoef function: corrltn_range_advoc.m (for adult vocalisations), corrltn_range_chvoc.m (for infant vocalisations). In addition, these files also outuput the mean, std. deviation, min and max of the individual acoustic dimensions. 

In subfolder correlation, you will also find .m files used to generate .csv files to be used in a linear mixed effects model (in R) to determine the correlation between steps in acoustic space and time by accouting for effects of infant age and effects of having multiple datasets from the same infant: data_4_lmer_corrleation_time_and_space_st.m and the function used in it (lmer_corrltn_data.m). 

Files in subfolder correlation can be executed in any order.

------------------------------------------

Folder Stepsize_analysis contains folders of .m files used to analyse patterns in step sizes in pitch (frequency), amplitude, acoustic space, and time, for both infant and adult vocalisations. It contains three subfolders:

stepsize_distributions: contains .m files used to analyse step-size distributions near responses (WR) and away from responses (WOR) as defined in the paper, both in terms of fit-dependent parameters and fit-independent parameters (eg. median and 90th percentile values). These analyses were carried out at the recording day level.

median_and_90prc_stepsizes: contains .m files used to determine median and 90th percentile values for infant and adult step sizes as a function of of number of vocalisations since a response was last received.  Here, the step from the vocalisation that received a response to the next vocalization was assigned 0, the following step (assuming no response to the second vocalization) was designated 1, and so on.  This continued until the next response was received at whichpoint the count resets to 0 (see paper and supplementary information for details). These were prelimiary analyses only and resultant plots can be found in SI. Also not that these analyses were carried out with all infant data pooled together (and similarly for adult data)

logistic_regression: contains .m files used to generate data for carrying out logistic regression in R to determine whether certain pitch/amplitude values were more likely to receive responses. We also looked at whether specific vocalisation patterns (in terms of steps in freuqency, amplitude, and time) were more likley to receive responses. 

Subfolders in stepssize_analysis can be executed in any order. 
