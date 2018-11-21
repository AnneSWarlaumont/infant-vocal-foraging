function output1 = fittypesum(input1)

%Ritwika VPS, UC Merced

%finding the inputs for bar plots to demonstrate number of each fit types
%for a given kind of data, for eg. f_no_ch

%1 is normal, 2 is lognormal, 3 is exponential, 4 is pareto

output1 = [sum(input1 == 1) sum(input1 == 2) sum(input1 == 3) sum(input1 == 4)];

