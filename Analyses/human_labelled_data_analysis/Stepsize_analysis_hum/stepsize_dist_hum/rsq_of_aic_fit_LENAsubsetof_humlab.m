clear all
clc

%create rsq values tables for fits of LENA data subset corresponding to human labelled child and adult step size distributions - unsplit, WR and
%WOR

%-----------------------------------------
load('adresp2ch_stepsizes_humlab.mat') %child vocs, WR and WOR

for i = 1:length(LENA_idage)
    
    rsq_f_ad(i,1) = aicfit_rsq(LENAad_distf{i}); %WR
    rsq_d_ad(i,1) = aicfit_rsq(LENAad_distd{i});
    rsq_sp_ad(i,1) = aicfit_rsq(LENAad_distsp{i});
    rsq_t_ad(i,1) = aicfit_rsq(LENAad_distt{i});
    smplsi_WR(i,1) = length(LENAad_distf{i});
    
    rsq_f_noad(i,1) = aicfit_rsq(LENAnoad_distf{i}); %WR
    rsq_d_noad(i,1) = aicfit_rsq(LENAnoad_distd{i});
    rsq_sp_noad(i,1) = aicfit_rsq(LENAnoad_distsp{i});
    rsq_t_noad(i,1) = aicfit_rsq(LENAnoad_distt{i});
    smplsi_WOR(i,1) = length(LENAnoad_distf{i});
    
end

LENA_idage = transpose(LENA_idage);

T = table(LENA_idage,smplsi_WR,smplsi_WOR,rsq_f_ad,rsq_d_ad,rsq_sp_ad,rsq_t_ad,rsq_f_noad,rsq_d_noad,rsq_sp_noad,rsq_t_noad);
writetable(T,'rsq_adresp2ch_LENAsubsetof_humlab.csv')

%-----------------------------------------
clear all
clc

load('chresp2ad_stepsizes_humlab.mat') %adult vocs, WR and WOR

for i = 1:length(LENA_idage)
    
    rsq_f_ch(i,1) = aicfit_rsq(LENAch_distf{i}); %WR
    rsq_d_ch(i,1) = aicfit_rsq(LENAch_distd{i});
    rsq_sp_ch(i,1) = aicfit_rsq(LENAch_distsp{i});
    rsq_t_ch(i,1) = aicfit_rsq(LENAch_distt{i});
    smplsi_WR(i,1) = length(LENAch_distf{i});
    
    rsq_f_noch(i,1) = aicfit_rsq(LENAnoch_distf{i}); %WR
    rsq_d_noch(i,1) = aicfit_rsq(LENAnoch_distd{i});
    rsq_sp_noch(i,1) = aicfit_rsq(LENAnoch_distsp{i});
    rsq_t_noch(i,1) = aicfit_rsq(LENAnoch_distt{i});
    smplsi_WOR(i,1) = length(LENAnoch_distf{i});
    
end

LENA_idage = transpose(LENA_idage);

T = table(LENA_idage,smplsi_WR,smplsi_WOR,rsq_f_ch,rsq_d_ch,rsq_sp_ch,rsq_t_ch,rsq_f_noch,rsq_d_noch,rsq_sp_noch,rsq_t_noch);
writetable(T,'rsq_chresp2ad_LENAsubsetof_humlab.csv')

%-----------------------------------------
clear all
clc

load('advoc_stepsizes_humlab_noWRWOR.mat') %adult vocs, unsplit distributions

for i = 1:length(LENA_idage)
    
    rsq_f_advoc(i,1) = aicfit_rsq(LENA_distf_advoc{i}); %WR
    rsq_d_advoc(i,1) = aicfit_rsq(LENA_distd_advoc{i});
    rsq_sp_advoc(i,1) = aicfit_rsq(LENA_distsp_advoc{i});
    rsq_t_advoc(i,1) = aicfit_rsq(LENA_distt_advoc{i});
    smplsi(i,1) = length(LENA_distf_advoc{i});
    
end

LENA_idage = transpose(LENA_idage);

T = table(LENA_idage,smplsi,rsq_f_advoc,rsq_d_advoc,rsq_sp_advoc,rsq_t_advoc);
writetable(T,'rsq_advoc_noWR_WOR_LENAsubsetof_humlab.csv')

%-----------------------------------------
clear all
clc

load('chvoc_stepsizes_humlab_noWRWOR.mat') %child vocs, unsplit distributions

for i = 1:length(LENA_idage)
    
    rsq_f_chvoc(i,1) = aicfit_rsq(LENA_distf_chvoc{i}); %WR
    rsq_d_chvoc(i,1) = aicfit_rsq(LENA_distd_chvoc{i});
    rsq_sp_chvoc(i,1) = aicfit_rsq(LENA_distsp_chvoc{i});
    rsq_t_chvoc(i,1) = aicfit_rsq(LENA_distt_chvoc{i});
    smplsi(i,1) = length(LENA_distf_chvoc{i});
    
end

LENA_idage = transpose(LENA_idage);

T = table(LENA_idage,smplsi,rsq_f_chvoc,rsq_d_chvoc,rsq_sp_chvoc,rsq_t_chvoc);
writetable(T,'rsq_chvoc_noWR_WOR_LENAsubsetof_humlab.csv')



