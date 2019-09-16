
(copied from README in folder LENA_data_analysis)

Files in this subfolder can be executed in any order.

Here, you will find .m files used to determine the correlation between step sizes in acoustic space 
and time using MATLAB's corrcoef function: corrltn_range_advoc.m (for adult vocalisations), corrltn_range_chvoc.m 
(for infant vocalisations). In addition, these files also outuput the mean, std. deviation, min and max of the 
individual acoustic dimensions. These correlations were found at the recording day level.

acoustics_mean_std_WR_WOR_adr2ch.m and acoustics_mean_std_WR_WOR_chr2ad.m are .m files used to generate .csv files to test whether receiving a response has any effect on adult/infant aocustic measures.

You will also find .m files used to generate .csv files to be used in a linear mixed effects model (lmer)
(in R) to determine the correlation between steps in acoustic space and time by accouting for effects 
of infant age and effects of having multiple datasets from the same infant: data_4_lmer_corrleation_time_and_space_st.m 
and the function used in it (lmer_corrltn_data.m). Data for lmer correlations were pooled together - all infant data, and all adult data, seperately. Finally, we also generate data to test correlations between steps in time and acoustic space for WR and WOR subsets of data. 

