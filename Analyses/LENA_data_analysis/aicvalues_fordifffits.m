function [aicdiff,famfit_bestfit] = aicvalues_fordifffits(aicstruct,familyid)

%Ritwika VPS, UC Merced

%outputs the aic value for the best fit for the curve, as well as (if best fit curve is 
%not the same as the family of curves that majority of the step size distributions, for eg, frequency steps
%fall into) the aic value for the fit for the family of curves

%famfit_bestfit tells if family fit is equal to the best fit (1) or not (0)

%for example, frequency steps are generally best
%fit to exponential, so if an individual frequency curve is best fit to
%lognormal, we will need info about the aic of lognormal and exponential
%for that one to compare - then best fit would be lognormal, and family fit
%would be exponential for that specific dataset

aicmat = {aicstruct.aic}; %get aic values from structure
aicmat = cell2mat(aicmat); %covert to array

[bestfit,bestindex] = min(aicmat); %find best fit aic value, and the corresponding index

if bestindex ~= familyid %family id tells the majority type the family of curves is fit to (1 - normal, 2 - lognormal, 3 - exp, 4 - pareto)
    %if familyid is not the same as the bestfit id (index of min value),
    %then store aic value of the fanily fit type
    familyfit = aicmat(familyid);
    famfit_bestfit = 0;
else %else family fit is the same as the best fit
    familyfit = bestfit;
    famfit_bestfit = 1;
end

aicdiff = abs(bestfit - familyfit); %we find the difference b/n the aic fits since exp((bestfitaic - otheraicvalue)/2) 
%is proportional to the propbability that other model minimisises info loss
%(relative likelihood of other model)
end




