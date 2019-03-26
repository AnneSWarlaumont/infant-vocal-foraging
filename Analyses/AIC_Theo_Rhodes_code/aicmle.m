function [mlevals] = aicmle(timeSeries,distribution)

% rewritten mle functions because matlabs lack transperancy and the pareto 
% doesn't match the number of parameters in the likelihood function because
% one is the generalized pareto and the other is just pareto

if strcmp(distribution,'pareto') == 1
	mlevals.paramnames{1} = 'xmin';
	mlevals.params(1) = min(timeSeries);
	mlevals.paramnames{2} = 'mu';
	mlevals.params(2) = 1 - length(timeSeries) / (length(timeSeries) * log(mlevals.params(1)) - sum(log(timeSeries)));
end

if strcmp(distribution,'lognormal') == 1
	mlevals.paranames{1} = 'mu';
	mlevals.params(1) = sum(log(timeSeries))/length(timeSeries);
	mlevals.paranames{2} = 'sigma';
	mlevals.params(2) = sqrt(sum((log(timeSeries) - mlevals.params(1)).^2) / length(timeSeries));	
end

if strcmp(distribution,'normal') == 1
	mlevals.paranames{1} = 'mu';
	mlevals.params(1) = mean(timeSeries);
	mlevals.paranames{2} = 'sigma';
	mlevals.params(2) = sqrt(sum((timeSeries - mean(timeSeries)).^2)/length(timeSeries));

end

if strcmp(distribution,'exponential') == 1
	mlevals.paranames{1} = 'lambda';
	mlevals.params(1) = 1/mean(timeSeries);
end

if strcmp(distribution,'gamma') == 1
	% just renaming and formatting the matlab estimates 'cause gamma distributions are hard
	gammamle = mle(timeSeries,'distribution','gamma');
	mlevals.paranames{1} = 'k';
	mlevals.params(1) = gammamle(1);
	mlevals.paranames{2} = 'theta';
	mlevals.params(2) = gammamle(2);
end

if strcmp(distribution,'exgaussian') == 1
	% using Lacouture's routine
	exgmle = simple_egfit(timeSeries);
	mlevals.paramnames{1} = 'mu';
	mlevals.params(1) = exgmle(1);
	mlevals.paramnames{2} = 'sigma';
	mlevals.params(2) = exgmle(2);
	mlevals.paramnames{3} = 'tau';
	mlevals.params(3) = exgmle(3);
end