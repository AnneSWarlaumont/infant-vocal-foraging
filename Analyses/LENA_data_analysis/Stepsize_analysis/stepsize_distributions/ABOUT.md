This folder contains .m files used to analyse step-size distributions near responses (WR) and away from responses (WOR) as defined in the paper, both in terms of fit-dependent parameters and fit-independent parameters (eg. median and 90th percentile values). These analyses were carried out at the recording day level.

1) .m files generating step size data, finding AIC best fit of distributions, and generating fit-dependent measures:

stepsizedist_noWR_WOR_advoc and stepsizedist_noWR_WOR_chvoc determines best fit distributions for step sizes in frequency, amplitude, 2d acoustic space and time, for adult and infant vocalisations, respectively. These analyses are carried out at the recording day level. 

stepsizedist_WR_WOR_advoc and stepsizedist_WR_WOR_chvoc determines best fit distributions for step sizes follwoing a response (WR) and not following a response (WOR) in frequency, amplitude, 2d acoustic space and time, for adult and infant vocalisations, respectively. These analyses are carried out at the recording day level. 

Function aicfit_rsq.m is used to find the rsq for the step size distribution data and the corresponding best fit AIC distribution

2) .m files using data from (1) to generate fit-independent measures

median_fn.m and prctile90_fn.m are functions to find median and 90th percentile values of pitch, amplitude, 2d acoustic space, and time step distributions of WR and WOR distributions.

median_90prc_WR_WOR_lena.m uses the functions described above to generate .csv files of median and 90 percentile values.


--------------
.m files in this folder sholud be executed in the order described above (1 followed by 2)
