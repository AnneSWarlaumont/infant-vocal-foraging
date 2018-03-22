# infant-vocal-foraging
This repository contains code for a scientific project analyzing infant and adult vocalization during daylong home recordings from a foraging perspective.

The primary authors of the code are Anne S. Warlaumont and Ritwika VPS.

batch_process_its_foraging.pl is a script that Anne ran to perform the pre-processing of LENA data.
* One of its inputs is a metadata file with one row per daylong recording and 7 columns: (1) particpant ID, (2) date of birth, (3) recording date, (4) age in days at start of recording, (5) name of the LENA files to be processed (without any file extension), (6) location where the .its file (the file that contains the LENA system's labels for what is happening at different points in the recording) can be found, (7) location where the .wav file can be found.
* It runs recorderpauses.pl, segments.pl, segmentsbysubrecording.pl, responses.pl, getIndividualAudioSegments.m, and getAcousticsTS.m for each daylong audio recording (or in some cases for each continuous subrecording within the daylong recording, if the daylong recording contained pauses).
* Its outputs are: metanopauses_foraging.txt (which contains identifying info. that is manually removed later to create metanopauses_foraging_simplified.txt), recordingname_pauseTimes.txt, recordingname_Segments.csv, recordingname_Segmentssubrecnum.txt, recordingname_AdultResponsesToChild_subrecnum.txt, recordingname_ChildResponsesToAdult_subrecnum.txt, a recordingname_individualSounds directory containing wav file clips corresponding to LENA-labeled human vocalizations, and recordingname_acousticsTS_subrecnum.csv.
