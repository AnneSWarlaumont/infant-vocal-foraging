function [rsq] = aicfit_rsq(disttim_noad_day)

if length(disttim_noad_day) > 2 %make sure that there are at least 2 data points to generate fit
    
[aic_param,aic_fit,p] = aicnew(disttim_noad_day,[0 0 0 0],0); %finds best fit distribution type
aicplotin = [0 0 0 0];
aicplotin(aic_fit) = 1;
[xaxis,yaxis_fit,yaxis_dat] = aicplots(disttim_noad_day,aicplotin,0); %finds fit points and data points for the best distribution type

sstot = sum((yaxis_dat- mean(yaxis_dat)).^2); 
ssres = sum((yaxis_dat-yaxis_fit).^2);
rsq = 1-(ssres/sstot);%finds rsquared = 1 - ssres/sstot
else
    
rsq = NaN;  %if there aren't at least two data points, the rmse is NaN
end


