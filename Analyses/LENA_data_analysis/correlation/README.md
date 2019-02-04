
(copied from README in folder LENA_data_analysis)

Files in this subfolder can be executed in any order.

Here, you will find .m files used to determine the correlation between step sizes in acoustic space 
and time using MATLAB's corrcoef function: corrltn_range_advoc.m (for adult vocalisations), corrltn_range_chvoc.m 
(for infant vocalisations). In addition, these files also outuput the mean, std. deviation, min and max of the 
individual acoustic dimensions.

You will also find .m files used to generate .csv files to be used in a linear mixed effects model 
(in R) to determine the correlation between steps in acoustic space and time by accouting for effects 
of infant age and effects of having multiple datasets from the same infant: data_4_lmer_corrleation_time_and_space_st.m 
and the function used in it (lmer_corrltn_data.m).

