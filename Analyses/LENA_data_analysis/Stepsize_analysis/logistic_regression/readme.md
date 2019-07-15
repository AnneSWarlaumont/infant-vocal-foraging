This folder contains .m files used to generate data for carrying out logistic regression in R to determine whether certain 
pitch/amplitude values were more likely to receive responses. We also looked at whether specific vocalisation patterns (in 
terms of steps in freuqency, amplitude, and time) were more likley to receive responses.

logisticregression_fn.m is a function file that creates a table with data for logistic regression analysis to determine which 
vocalisations are more likely to get a response - pitch, amplitude, and infant age are independent variables.

logisticregression_fn_stsiz.m is a function file that creates a table with data for logistic regression analysis to determine 
which vocalisations are more likely to get a response - pitch, amplitude, and infant age are independent variables. In 
addition, step sizes in pitch, freuqency, and time immediately preceding the vocalistaion of interest are also independent 
variables

data_forlogisticregression.m uses these functions to generate these .csv files for both adult and infant vocalisations.

Note that all infant data were pooled together, and all adult data were pooled together.
