function [meanval,CI_neg,CI_pos,num,numofvoc] = mean_std_binary(x,n)

%Ritwika VPS, UC Merced

%step sizes from 0 to 1st voc after response are labelled zero, meaning
%they happen at the 0th vocalisation since last response. In general, i to
%i+1 steps are labelled by i.

%The 'n' variable is used to determine where the boundary is - that is,
%for all i >= n, steps from i to i+1 will be labelled as n. This is since in other analyses, we don't not distingusih
%between vocalistaions in terms of how far they are from responses - tehre
%is only close to responses or far from responses. This avoids the problem
%of lack of data points for larger stretches that go without responses as
%well, by bundling mean steps for i's with fewer data points, and we are
%able to make a flexible distinction between what is close to responses and
%what is not

%mean and standard deviation ignoring NaN; also outputs the confidence
%intervals, and the number of points for nth voc after last response, and
%the vector of 0 to n vocalisations since last response. 

%mean step sizes, CI values, etc, for steps from i to i+1, for all i = 0,
%1, ..., n-1. Each of these are labelled sepeartely with the corresponding
%i.

%Note that since our labels are from 0 to n, but indexing is from 1, we
%need to translate indices by 1, as shown in code below. 

for i = 1:n %0 to n-1 labels; that is, all steps till n-1 to n
    xi = x(i,:);
    meanval(i,1) = nanmean(xi);
    xi = xi(isnan(xi) == 0);
    stddev = std(xi);
    SEM = stddev/sqrt(length(xi));               % Standard Error
    ts = tinv([0.025  0.975],length(xi)-1);      % T-Score
    CI= meanval(i) + ts*SEM; %CI 95%
    CI_neg(i,1) = CI(1);
    CI_pos(i,1)= CI(2);
    num(i,1) = length(xi);
end

xi = x(n+1:end,:); %all steps from i to i+1, for i >= n.
xi = xi(:);
meanval(n+1,1) = nanmean(xi);
xi = xi(isnan(xi) == 0);
stddev = std(xi);
SEM = stddev/sqrt(length(xi));               % Standard Error
ts = tinv([0.025  0.975],length(xi)-1);      % T-Score
CI= meanval(n) + ts*SEM; %CI 95%
CI_neg(n+1,1) = CI(1);
CI_pos(n+1,1)= CI(2);
num(n+1,1) = length(xi);

numofvoc = 0:n;

end