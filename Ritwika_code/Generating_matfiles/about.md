
This folder contains code used to generate .mat files used for all further analyses, from data labelled by LENA as well as human listeners.

Generating_TimeSeries_data.m extracts start and end times, speaker id, mean frequency and amplitude values for each utterance for each subrecording. Child utterances are then extracted from this superset of utterances. Child id and age at start of recording is also stored.

Generating_Adultresponse2child_data.m extracts start and end times of child utterances, and whether or not an adult response was received, for each subrecording. Generating_childresponses2adult_data.m does the same for child responses to adult utterances

chresp_and_adresp.m matches the log frequency and amplitude values for child utterances that has adult response data (yes, no, NA), and for adult utterances that has child response data.

kmeanzscore.m zscores the log frequency and amplitude values seperately, for all available data pooled together. That is, all available log frequency values (for adult and child utterances for allages and child ids) are zscored together. The same procedure is repeated for amplitude values. A kmeans clustering procedure is also carried out, with log frequency and amplitude as the two axes, with 10 clusters. 

generating_humanlabelleddata.m extracts the speaker id as determined by a human listener for a subset of recordings. This is used to extract start and end times, mean frequency and amplitude values, as well as adult and child response data, based on the human listener validation. 




