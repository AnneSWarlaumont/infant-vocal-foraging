function [nloglval] = aiclike(timeSeries,params,distribution);

if strcmp(distribution,'pareto') == 1
	nloglval = -(length(timeSeries) * log(params(2)) + length(timeSeries) * params(2) * log(params(1)) - (params(1)+1) * sum(log(timeSeries)));
end

if strcmp(distribution,'lognormal') == 1
	nloglval = sum(log(timeSeries .* params(2) * sqrt(2*pi)) + (log(timeSeries) - params(1)).^2 / (2* params(2)^2));
end

if strcmp(distribution,'normal') == 1
	nloglval = sum(log(params(2)*sqrt(2*pi)) + (timeSeries - params(1)).^2 / (2 * params(2)^2));
end

if strcmp(distribution,'exponential') == 1
	nloglval = sum(params(1) * timeSeries - log(params(1)));
end

if strcmp(distribution,'gamma') == 1
	nloglval = gamlike(params,timeSeries);
end

if strcmp(distribution,'exgaussian') == 1
	nloglval = eglike(params,timeSeries);
end