function [meanval,stdval,CI_neg,CI_pos,num,numofvoc] = mean_std_95CI(x)

%Ritwika VPS, UC Merced

%mean and standard deviation ignoring NaN; also outputs the confidence
%intervals, and the number of points for nth voc after last response
meanval = nanmean(x,2);
stdval = nanstd(x,0,2);
numofvoc= 0:length(meanval)-1; %number of vocalisations since last response - 0 to n-1, because 0 is the voc that received response
for i = 1:length(stdval)
x1 = x(i,:);
x1 = x1(isnan(x1) == 0);
SEM = stdval(i)/sqrt(length(x1));               % Standard Error
ts = tinv([0.025  0.975],length(x1)-1);      % T-Score
CI= meanval(i) + ts*SEM; %CI 95%
CI_neg(i,1) = CI(1);
CI_pos(i,1)= CI(2);
num(i,1) = length(x1); %number of points for nth voc after last response
end

end