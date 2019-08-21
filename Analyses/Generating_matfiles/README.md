
This folder contains code used to generate .mat files used for all further analyses, from data labelled by LENA as well as human listeners. It also contains code used to generate interraterreliability measures (I put it here because I felt it fit better here than in the stats folder). Note that we keep subrecordings from the same day seperate at this point. Subrecordings are usually collated together within individual scripts as necessary. Code (i-v) in this folder should be executed in the order below:

i) **Generating_TimeSeries_data.m** extracts start and end times, speaker id, and mean frequency and amplitude values for each CHNSP, MAN and FAN utterance for each subrecording. Child utterances are then extracted from this superset of utterances. Child id and age at start of recording is also stored. From this point on, all frequency values are on a log scale.  

ii) **Generating_Adultresponse2child_data.m** extracts start and end times of child speech-related (CHNSP) utterances, and whether or not an adult response was received, for each subrecording. **Generating_childresponses2adult_data.m** does the same for child responses to adult utterances.

iii) **zscore_data.m** zscores the log frequency and amplitude values seperately, for all available data pooled together. That is, all available log frequency values (for adult and child utterances for all ages and child ids) are zscored together. The same procedure is repeated for amplitude values.  

iv) **chresp_and_adresp.m** matches the log frequency and amplitude values for child utterances that have adult response data (yes, no, NA), and for adult utterances that have child response data.

v) **generating_humanlabelleddata.m** extracts the speaker id as determined by a human listener for a subset of recordings. This is used to extract start and end times, mean frequency and amplitude values, as well as adult and child response data, based on the human listener validation. 

vi) **data_perc_agree_cohenKappa_HUM_LENA.m** generates interraterreliability measures for human labelled data wrt corresponding LENA data (percent agreement, Cohen's Kappa, confusion matrices). This uses a user-defined MATLAB function in the stats folder, so make sure the stats folder is in the path.  

vii) **data_perc_agree_cohenKappa_HUM_HUM.m** generates interraterreliability measures for data from infant 340 at age 183 days labelled by listeners 1 and 3 (percent agreement, Cohen's Kappa, confusion matrices). This uses a user-defined MATLAB function in the stats folder, so make sure the stats folder is in the path.  

viii) **LENA_vs_HUM_labels_proportions.m** generates tables for human labelled data and corresponding LENA labelled data, describing what proportion of each LENA label type of our interest (CHNSP, MAN, FAN) falls into human-labelled categories of our interest. (Table S11 in SI)
