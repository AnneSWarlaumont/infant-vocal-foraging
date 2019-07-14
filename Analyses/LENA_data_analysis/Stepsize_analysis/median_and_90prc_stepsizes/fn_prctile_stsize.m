function [prcval,num,numofvoc] = fn_prctile_stsize(x,percentile)

%Ritwika VPS, UC Merced

%median and 90th percentile values ignoring NaN; also outputs the confidence
%intervals, and the number of points for nth voc after last response
prcval = prctile(x,percentile,2); %prctile treats NaN values as missing.Also, the 2 is for the dimension along which percentile value is calculated, 
%so we get prcentile value for each row. percentile is the percentile value
%we want - so 50 would give us the 50th percentile value
numofvoc= 0:length(prcval)-1; %number of vocalisations since last response - 0 to n-1, because 0 is the voc that received response
for i = 1:length(prcval)
x1 = x(i,:);
x1 = x1(isnan(x1) == 0);
num(i,1) = length(x1); %number of points for nth voc after last response
end

end