This folder contains .m files used to determine median and 90th percentile values for infant and adult step sizes as a function
of of number of vocalisations since a response was last received. Here, the step from the vocalisation that received a 
response to the next vocalization was assigned 0, the following step (assuming no response to the second vocalization) was 
designated 1, and so on. This continued until the next response was received at whichpoint the count resets to 0 (see paper 
and supplementary information for details). These were prelimiary analyses only and resultant plots can be found in SI. Also 
not that these analyses were carried out with all infant data pooled together (and similarly for adult data).

Also note that here, all infant vocalisation data are pooled together- that is, median and 90 percentile values are calculated 
for all infant vocalisations data across all infants at all ages (and similarly for adult vocalisation data). However, as 
always, we take care to make sure that step sizes from the end of one subrecording to the beginning of the next are excluded.

fn_prctile_stsiz.m is a function file used to calculate the nth percentile values of all step sizes at the ith vocalisation 
since last response, for all available i and desired n. For now, we limit n to 90 and 50 (median).

prctile_stepsizes_adultvoc.m and prctile_stepsizes_chnvoc.m sorts the data into step sizes at nth vocalisation since last 
response across all available data for adult and infant vocalisations, respectively, and then calculates the median/90th 
percentile value for each n.

Note that in the generated .csv files, all columns are named as median_<> regardless of whether it is the median or the 90th 
percentile value that is being calculated. Please make note of this.
