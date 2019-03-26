function [pvals] = aicpdf(xvals,distribution,params)

% generates values for probability distributions
if strcmp(distribution,'pareto') == 1
	pvals = (params(2) * params(1) .^ params(2)) ./ (xvals .^ (params(2) + 1));
end

if strcmp(distribution,'lognormal') == 1
	pvals = exp(-(log(xvals) - params(1)).^2 / (2 * params(2)^2)) ./ (xvals * params(2) * sqrt(2*pi));
end

if strcmp(distribution,'normal') == 1
	pvals = exp(-(xvals - params(1)).^2 / (2 * params(2)^2)) ./ (params(2) * sqrt(2*pi));
end

if strcmp(distribution,'exponential') == 1
	pvals = params(1) * exp(-params(1) * xvals);
end

if strcmp(distribution,'gamma') == 1
	pvals = xvals .^ (params(1) - 1) .* exp(-xvals/params(2)) / (gamma(params(1)) * params(2)^params(1));
end

if strcmp(distribution,'exgaussian') == 1
	pvals = exgausspdf(params(1),params(2),params(3),xvals);
end