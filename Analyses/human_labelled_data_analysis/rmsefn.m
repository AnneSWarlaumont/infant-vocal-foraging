function [rsq] = rmsefn(y,fit_y)

%Ritwika VPS, UC Merced

%finds rms error of 2 curves - note, we are not using this for a curve y,
%and its fitted values. We are using thsi to compare mean step size curves
%for human labelled data and the correpsonding LENA clabelled data
a = (y-fit_y).^2;
rsq = sqrt(mean(a));
end

