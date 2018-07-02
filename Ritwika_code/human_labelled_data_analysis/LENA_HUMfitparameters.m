function [param1_lam_mu_xmin_HUM,prama2_sig_alpha_HUM,param1_lam_mu_xmin_LENA,prama2_sig_alpha_LENA] = LENA_HUMfitparameters(aic_fad_HUM_tw_i,...
                                                                                                    fad_fit_LENA_tw_i,aic_fad_LENA_tw_i)
%Ritwika VPS, UC Merced

%finding parameters of step size distribution curves based on AIC best fit
%for human labelled data

%note, we are fitting human labelled data to the same family of curves as
%the corresponding LENA data is fit to, to compare parameters

if (fad_fit_LENA_tw_i == 3) %if lena is exponential
    aa = {aic_fad_HUM_tw_i.mle};
    param1_lam_mu_xmin_HUM = aa{3}.params;
    prama2_sig_alpha_HUM = 'NA';
    
    aa = {aic_fad_LENA_tw_i.mle};
    param1_lam_mu_xmin_LENA = aa{3}.params;
    prama2_sig_alpha_LENA = 'NA';
    
elseif (fad_fit_LENA_tw_i == 2) %if lena is lognormal
    aa = {aic_fad_HUM_tw_i.mle};
    parameters1 = aa{2}.params;
    param1_lam_mu_xmin_HUM = parameters1(1);
    prama2_sig_alpha_HUM = parameters1(2);
    
    aa = {aic_fad_LENA_tw_i.mle};
    parameters1 = aa{2}.params;
    param1_lam_mu_xmin_LENA = parameters1(1);
    prama2_sig_alpha_LENA = parameters1(2);
    
elseif (fad_fit_LENA_tw_i == 1) %if lena is normal
    
    aa = {aic_fad_HUM_tw_i.mle};
    parameters1 = aa{1}.params;
    param1_lam_mu_xmin_HUM = parameters1(1);
    prama2_sig_alpha_HUM = parameters1(2);
    
    aa = {aic_fad_LENA_tw_i.mle};
    parameters1 = aa{1}.params;
    param1_lam_mu_xmin_LENA = parameters1(1);
    prama2_sig_alpha_LENA = parameters1(2);
    
elseif (fad_fit_LENA_tw_i == 4) %if lena is pareto
    
    aa = {aic_fad_HUM_tw_i.mle};
    parameters1 = aa{4}.params;
    param1_lam_mu_xmin_HUM = parameters1(1);
    prama2_sig_alpha_HUM = parameters1(2);
    
    aa = {aic_fad_LENA_tw_i.mle};
    parameters1 = aa{4}.params;
    param1_lam_mu_xmin_LENA = parameters1(1);
    prama2_sig_alpha_LENA = parameters1(2);
    
end

end