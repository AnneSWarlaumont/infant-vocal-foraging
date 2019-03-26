function [xaxis, yaxis_fit,yaxis_dat] = aicplots(timeSeries,plots,ssc);

%This bit of code was adapted by Ritwika from code by Dr. Rhodes to
%generate plots

% function [aicvals] = aicnew(timeSeries,plots,ssc);
%
% Calculates Akaike's Information Criterion for the following distribtions:
%  		Guassian/Normal, Lognormal, Exponential, Pareto, Gamma
%       (ex-gaussian is included but not enabled due to lack of testing)
%
% Input: timeSeries [vector of positive values, >= 0 causes issues with gamma]
%        plots      [vector of plot flags for each distribution, [0 0 0 0 0] produces
%                    no plots, [1 1 1 1 1] produces a plot of the data distribution and
%                    the best fit for each candidate distribution]
%        ssc        [flag to force the small sample correction, which will be enabled
%                    regardless for less then 40 data points]
%
% Output: aicvals   [a structure with an entry for each candidate distribution]
%                   [plots: substructure containing the vectors used to generate plots]
%                   [mle: contains the maximum likelihood estimate parameters for each
%                         distribution (params) as well as their names (paranames)]
%                   [nll: negative log likelihood values for each candidate distribution]
%                   [aic: akaike's information criterion for each candidate distribution]
%                   [aicdiff: difference scores for the AIC estimates]
%                   [weight: AIC weights (1 is likely, 0 is unlikely)]
%
% Additional files: aiclike.m, aicmle.m, aicpdf.m
%
% Theo Rhodes (theorhodes@gmail.com)     6/30/2010

if min(timeSeries) <= 0
	timeSeries = timeSeries + -min(timeSeries) + .01;
end

% create histogram to determine plot values
[counts,plotvals] = hist(timeSeries,50);

pdfs(1).name = 'normal';
pdfs(2).name = 'lognormal';
pdfs(3).name = 'exponential';
pdfs(4).name = 'pareto';
%pdfs(5).name = 'gamma';
%pdfs(6).name = 'exgaussian';

colorList = ['m' 'g' 'r' 'b' 'c' 'k'];

% calculate maximum likelihood for core distributions
% calculate log likelihood value at maximum
% find k (number of params)
% generate probability density function using parameters
for i = 1:length(pdfs)
	aicvals(i).mle = aicmle(timeSeries,pdfs(i).name);
	aicvals(i).nll = aiclike(timeSeries,aicvals(i).mle.params,pdfs(i).name);
	kvals(i) = length(aicvals(i).mle.params);
	%if plots(i) >= 1
	pdfs(i).vals = aicpdf(plotvals,pdfs(i).name,aicvals(i).mle.params);
	%end
end

% plot histogram and mle pdf
for i = 1:length(pdfs)
	scaling = sum(counts) / sum(pdfs(i).vals);
	aicvals(i).plots.xvals = plotvals;
	aicvals(i).plots.datay = counts;
	aicvals(i).plots.aicy = pdfs(i).vals*scaling;
	
	if plots(i) == 1
		paramString = '';
		for j = 1:length(aicvals(i).mle.params)
			paramString = strcat(paramString,num2str(aicvals(i).mle.params(j)),';');
		end
		titleString = strcat(pdfs(i).name,' (',paramString,')');
		%figure;
		%plot(plotvals,counts);
		%hold;
		%plot(plotvals,pdfs(i).vals*scaling,'r');
		%title(titleString);
        yaxis_fit = pdfs(i).vals*scaling;
        xaxis = plotvals;
        yaxis_dat = counts;
	end
	if plots(i) == 2
		scaling = sum(counts) / sum(pdfs(i).vals);
		if i == 1
			figure;
			plot(plotvals,counts,'k');
		end
		hold;
		plot(plotvals,pdfs(i).vals*scaling,colorList(i));
		hold;
	end
end

% check for small sample correction
if length(timeSeries)/max(kvals) < 40
	ssc = 1;
end

% calculate akaike information criteria
for i = 1:length(pdfs)
	aicvals(i).aic = 2 * aicvals(i).nll + 2 * kvals(i);
	if ssc == 1
		aicvals(i).aic = aicvals(i).aic + 2 * kvals(i) * (kvals(i) + 1) / (length(timeSeries) - kvals(i) - 1);
	end
end

% calculate AIC differences and akaike weights
aicmin = min([aicvals(:).aic]);
for i = 1:length(pdfs)
	aicvals(i).aicdiff = aicvals(i).aic - aicmin;
end

aicsum = 0;
for i = 1:length(pdfs)
	aicsum = aicsum + exp(-aicvals(i).aicdiff / 2);
end

for i = 1:length(pdfs)
	aicvals(i).weight = exp(-aicvals(i).aicdiff / 2) / aicsum;
end

% max weight and parameters
maxwgt = find([aicvals(:).weight] == max([aicvals(:).weight]));
maxwgtparams = aicvals(maxwgt).mle.params;