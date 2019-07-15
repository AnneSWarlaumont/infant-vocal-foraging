This folder contains .m files used to generate a .csv file that contains AIC best fit parameters for Human labelled data 
and the corresponding LENA labelled data at the recording day level, for both infant and adult vocalistaions. We find AIC 
best fits for step sizes in pitch, amplitude, 2d acoustic space and time, based on whether they follwoed a response (WR) or 
followed a nonresponse (WOR)

findist_andgroup_HUM.m: this functions is for human labelled data ONLY. It finds step sizes in pitch, amplitude, acoustic 
space, and time and categorises them as WR and WOR (at the subrecording level). All NaN values are removed and these are then 
lumped together at the recording day level.

LENA_HUMfitparameters.m: this function finds the AIC best fit parameters for human labelled data and the corresponding LENA 
labelled data at the recording day level for both infant and adult vocalisations. Parameters are found for step size 
distributions in pitch, amplitude, acoustic space and time, categorised into WR and WOR. Note that for if the LENA and 
human labelled data for a given infant on a given day have different AIC best fits, then the LENA best fit is used for both 
to compare between the two.

aic_hum_LENA_fit_parameters_main.m: uses the functions described above to generate a .csv file with AIC best fit 
parameters for human labelled and corresponding LENA labelled data. Note that for if the LENA and human labelled data 
for a given infant on a given day have different AIC best fits, then the LENA best fit is used for both to compare between 
the two. The information about differeing best fits is provided in the fittype column in the .csv file.
