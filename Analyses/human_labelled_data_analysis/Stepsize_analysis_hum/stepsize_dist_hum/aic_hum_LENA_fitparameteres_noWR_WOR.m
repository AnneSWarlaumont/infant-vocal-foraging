clear all
%clc

%Ritwika UC Merced
%IVFCR

%AIC best fit parameters are found for human labelled data and
%corresponding LENA labelled data at the recording day level, for both
%adult and child vocalistaions. Here, step size distributions are not split
%into WR and WOR categories

%note, we are fitting human labelled data to the same family of curves as
%the corresponding LENA data is fit to, to compare parameters. However, if aic best fit for human and corresponding LENA data are not the same
%then that information is indicated under the fittype column in the
%resultant table

clear all
clc

%AIC: 1 normal, 2 lognormal, 3 exponential, 4 pareto

%------------------------------------
%infant vocalistaions 
%------------------------------------

load('humanlab_chdat.mat')
load('chvoc_stepsizes_noWR_WOR.mat')

%find LENA datsets that match human labelled datasets
%first, we concatenate age and id for human labelled datasets
for i = 1:length(childid)  
    id_age_hum{i} = sprintf('%s_%d',childid{i},chage(i));
end 

%pick out unique combinations
id_age_hum = unique(id_age_hum);

for i = 1:length(id_age_hum)
    for j = 1:length(id_age)
        if (strcmp(id_age_hum{i},id_age{j}) == 1) %if id_age combos match; id_age is from LENA data mat
            LENA_distf_chvoc{i} = distf_day{j};
            LENA_distd_chvoc{i} = distd_day{j};
            LENA_distsp_chvoc{i} = distsp_day{j};
            LENA_distt_chvoc{i} = disttim_day{j};
            LENA_idage{i} = id_age{j};
        end
    end
end

%finds distances and groups subrecordings from same day and same infant. Only
%for human labelled data (uses function)

[HUM_distf_chvoc,HUM_distd_chvoc,HUM_distsp_chvoc,HUM_distt_chvoc,HUM_idage] = finddist_andgroup_noWRWOR_HUM(chst_humlab,chen_humlab,chdb_humlab,...
                                                                chlogf_humlab,chage,childid,listenerid);

save('chvoc_stepsizes_humlab_noWRWOR.mat','HUM_distf_chvoc','HUM_distd_chvoc','HUM_distsp_chvoc','HUM_distt_chvoc','HUM_idage',...
    'LENA_distf_chvoc','LENA_distd_chvoc','LENA_distsp_chvoc','LENA_distt_chvoc','LENA_idage')
%we find parameters of AIC best fits of step size distributions
%for child vocalisations (unsplit step sizes, in pitch, amplitude, 2d acoustic space, and time)

for i = 1:length(HUM_idage) 
idmat_hum = strsplit(HUM_idage{i},'_');

[aic_f_HUM{i},f_fit_HUM(i,1),p] = aicnew(HUM_distf_chvoc{i},[0 0 0 0],0) ;  
[aic_d_HUM{i},d_fit_HUM(i,1),p] = aicnew(HUM_distd_chvoc{i},[0 0 0 0],0) ; 
[aic_sp_HUM{i},sp_fit_HUM(i,1),p] = aicnew(HUM_distsp_chvoc{i},[0 0 0 0],0) ;  
[aic_t_HUM{i},t_fit_HUM(i,1),p] = aicnew(HUM_distt_chvoc{i},[0 0 0 0],0) ; 

age_HUM_chvoc(i,1) = str2num(idmat_hum{2});
id_HUM_chvoc{i,1} = idmat_hum{1};
listener_HUM_chvoc{i,1} = idmat_hum{3};
type_HUM_chvoc{i,1} = 'HUM';

%finds best fit parameters for human labelled and corresponding LENA data:
%uses function LENA_HUMfitparameters
for j = 1:length(LENA_idage)
idmat_lena = strsplit(LENA_idage{j},'_');
if (strcmp(idmat_lena{1},idmat_hum{1}) == 1) && (strcmp(idmat_lena{2},idmat_hum{2}) == 1) %matches child age and id for LENA and HUM label
    
[aic_f_LENA{j},f_fit_LENA(j,1),p] = aicnew(LENA_distf_chvoc{j},[0 0 0 0],0) ;  
[param1_lam_mu_xmin_HUM_f(i,1),param2_sig_alpha_HUM_f{i,1},param1_lam_mu_xmin_LENA_f(j,1),param2_sig_alpha_LENA_f{j,1}] =...
                                                                                    LENA_HUMfitparameters(aic_f_HUM{i},f_fit_LENA(j,1),aic_f_LENA{j});
[aic_d_LENA{j},d_fit_LENA(j,1),p] = aicnew(LENA_distd_chvoc{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_d(i,1),param2_sig_alpha_HUM_d{i,1},param1_lam_mu_xmin_LENA_d(j,1),param2_sig_alpha_LENA_d{j,1}] =...
                                                                                    LENA_HUMfitparameters(aic_d_HUM{i},d_fit_LENA(j,1),aic_d_LENA{j});
[aic_sp_LENA{j},sp_fit_LENA(j,1),p] = aicnew(LENA_distsp_chvoc{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_sp(i,1),param2_sig_alpha_HUM_sp{i,1},param1_lam_mu_xmin_LENA_sp(j,1),param2_sig_alpha_LENA_sp{j,1}] =...
                                                                                 LENA_HUMfitparameters(aic_sp_HUM{i},sp_fit_LENA(j,1),aic_sp_LENA{j});
[aic_t_LENA{j},t_fit_LENA(j,1),p] = aicnew(LENA_distt_chvoc{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_t(i,1),param2_sig_alpha_HUM_t{i,1},param1_lam_mu_xmin_LENA_t(j,1),param2_sig_alpha_LENA_t{j,1}] =...
                                                                                    LENA_HUMfitparameters(aic_t_HUM{i},t_fit_LENA(j,1),aic_t_LENA{j});
                                                                                                                                                             
age_LENA_chvoc(j,1) = str2num(idmat_lena{2});
id_LENA_chvoc{j,1} = idmat_lena{1};
type_LENA_chvoc{j,1} = 'LENA';
listener_LENA_chvoc{j,1} = 'NA';

end
end
end

%puts all of it together to write .csv file
age = [age_HUM_chvoc
    age_LENA_chvoc];
id = [id_HUM_chvoc
    id_LENA_chvoc];
type = [type_HUM_chvoc
    type_LENA_chvoc];
listener = [listener_HUM_chvoc
    listener_LENA_chvoc];

f_param1 = [param1_lam_mu_xmin_HUM_f
    param1_lam_mu_xmin_LENA_f];
f_param2 = [param2_sig_alpha_HUM_f
    param2_sig_alpha_LENA_f];

d_param1 = [param1_lam_mu_xmin_HUM_d
    param1_lam_mu_xmin_LENA_d];
d_param2 = [param2_sig_alpha_HUM_d
    param2_sig_alpha_LENA_d];

sp_param1 = [param1_lam_mu_xmin_HUM_sp
    param1_lam_mu_xmin_LENA_sp];
sp_param2 = [param2_sig_alpha_HUM_sp
    param2_sig_alpha_LENA_sp];

t_param1 = [param1_lam_mu_xmin_HUM_t
    param1_lam_mu_xmin_LENA_t];
t_param2 = [param2_sig_alpha_HUM_t
    param2_sig_alpha_LENA_t];

f_fittype = [f_fit_HUM
    f_fit_LENA];
d_fittype = [d_fit_HUM
    d_fit_LENA];
sp_fittype = [sp_fit_HUM
    sp_fit_LENA];
t_fittype = [t_fit_HUM
    t_fit_LENA];

T = table(age,id,type,listener,f_fittype,f_param1,f_param2,d_fittype,d_param1,d_param2,...
    sp_fittype,sp_param1,sp_param2,t_fittype,t_param1,t_param2);
writetable(T,'HUM_LENA_fitparameters_chvoc_noWR_WOR.csv')

%------------------------------------
%adult vocalistaions 
%------------------------------------
clear all

load('humanlab_addat.mat')
load('advoc_stepsizes_noWR_WOR.mat')

%find LENA datsets that match human labelled datasets
%first, we concatenate age and id
for i = 1:length(childid_ad)  
    id_age_hum{i} = sprintf('%s_%d',childid_ad{i},age_adhumlab(i));
end 
%pick out unique combinations
id_age_hum = unique(id_age_hum);

for i = 1:length(id_age_hum)
    for j = 1:length(id_age)
        if (strcmp(id_age_hum{i},id_age{j}) == 1)
            LENA_distf_advoc{i} = distf_day{j};
            LENA_distd_advoc{i} = distd_day{j};
            LENA_distsp_advoc{i} = distsp_day{j};
            LENA_distt_advoc{i} = disttim_day{j};
            LENA_idage{i} = id_age{j};
        end
    end
end

%finds distances and groups subrecordings from same day and same adult. Only
%for human labelled data (uses function)

[HUM_distf_advoc,HUM_distd_advoc,HUM_distsp_advoc,HUM_distt_advoc,HUM_idage] = finddist_andgroup_noWRWOR_HUM(adst_humlab,...
                                                               aden_humlab,addb_humlab,adlogf_humlab,age_adhumlab,childid_ad,listenerid_ad);

save('advoc_stepsizes_humlab_noWRWOR.mat','HUM_distf_advoc','HUM_distd_advoc','HUM_distsp_advoc','HUM_distt_advoc','HUM_idage',...
    'LENA_distf_advoc','LENA_distd_advoc','LENA_distsp_advoc','LENA_distt_advoc','LENA_idage')
%we find parameters of AIC best fits of step size distributions
%for adult vocalisations (unsplit step sizes, in pitch, amplitude, 2d acoustic space, and time)

for i = 1:length(HUM_idage) 
idmat_hum = strsplit(HUM_idage{i},'_');

[aic_f_HUM{i},f_fit_HUM(i,1),p] = aicnew(HUM_distf_advoc{i},[0 0 0 0],0) ;  
[aic_d_HUM{i},d_fit_HUM(i,1),p] = aicnew(HUM_distd_advoc{i},[0 0 0 0],0) ; 
[aic_sp_HUM{i},sp_fit_HUM(i,1),p] = aicnew(HUM_distsp_advoc{i},[0 0 0 0],0) ;  
[aic_t_HUM{i},t_fit_HUM(i,1),p] = aicnew(HUM_distt_advoc{i},[0 0 0 0],0) ; 

age_HUM_advoc(i,1) = str2num(idmat_hum{2});
id_HUM_advoc{i,1} = idmat_hum{1};
listener_HUM_advoc{i,1} = idmat_hum{3};
type_HUM_advoc{i,1} = 'HUM';

%finds best fit parameters for human labelled and corresponding LENA data:
%uses function LENA_HUMfitparameters
for j = 1:length(LENA_idage)
idmat_lena = strsplit(LENA_idage{j},'_');
if (strcmp(idmat_lena{1},idmat_hum{1}) == 1) && (strcmp(idmat_lena{2},idmat_hum{2}) == 1) %matches child age and id for LENA and HUM label
    
[aic_f_LENA{j},f_fit_LENA(j,1),p] = aicnew(LENA_distf_advoc{j},[0 0 0 0],0) ;  
[param1_lam_mu_xmin_HUM_f(i,1),param2_sig_alpha_HUM_f{i,1},param1_lam_mu_xmin_LENA_f(j,1),param2_sig_alpha_LENA_f{j,1}] =...
                                                                                    LENA_HUMfitparameters(aic_f_HUM{i},f_fit_LENA(j,1),aic_f_LENA{j});
[aic_d_LENA{j},d_fit_LENA(j,1),p] = aicnew(LENA_distd_advoc{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_d(i,1),param2_sig_alpha_HUM_d{i,1},param1_lam_mu_xmin_LENA_d(j,1),param2_sig_alpha_LENA_d{j,1}] =...
                                                                                    LENA_HUMfitparameters(aic_d_HUM{i},d_fit_LENA(j,1),aic_d_LENA{j});
[aic_sp_LENA{j},sp_fit_LENA(j,1),p] = aicnew(LENA_distsp_advoc{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_sp(i,1),param2_sig_alpha_HUM_sp{i,1},param1_lam_mu_xmin_LENA_sp(j,1),param2_sig_alpha_LENA_sp{j,1}] =...
                                                                                 LENA_HUMfitparameters(aic_sp_HUM{i},sp_fit_LENA(j,1),aic_sp_LENA{j});
[aic_t_LENA{j},t_fit_LENA(j,1),p] = aicnew(LENA_distt_advoc{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_t(i,1),param2_sig_alpha_HUM_t{i,1},param1_lam_mu_xmin_LENA_t(j,1),param2_sig_alpha_LENA_t{j,1}] =...
                                                                                    LENA_HUMfitparameters(aic_t_HUM{i},t_fit_LENA(j,1),aic_t_LENA{j});
                                                                                                                                                             
age_LENA_advoc(j,1) = str2num(idmat_lena{2});
id_LENA_advoc{j,1} = idmat_lena{1};
type_LENA_advoc{j,1} = 'LENA';
listener_LENA_advoc{j,1} = 'NA';

end
end
end

%puts all of it together to write .csv file
age = [age_HUM_advoc
    age_LENA_advoc];
id = [id_HUM_advoc
    id_LENA_advoc];
type = [type_HUM_advoc
    type_LENA_advoc];
listener = [listener_HUM_advoc
    listener_LENA_advoc];

f_param1 = [param1_lam_mu_xmin_HUM_f
    param1_lam_mu_xmin_LENA_f];
f_param2 = [param2_sig_alpha_HUM_f
    param2_sig_alpha_LENA_f];

d_param1 = [param1_lam_mu_xmin_HUM_d
    param1_lam_mu_xmin_LENA_d];
d_param2 = [param2_sig_alpha_HUM_d
    param2_sig_alpha_LENA_d];

sp_param1 = [param1_lam_mu_xmin_HUM_sp
    param1_lam_mu_xmin_LENA_sp];
sp_param2 = [param2_sig_alpha_HUM_sp
    param2_sig_alpha_LENA_sp];

t_param1 = [param1_lam_mu_xmin_HUM_t
    param1_lam_mu_xmin_LENA_t];
t_param2 = [param2_sig_alpha_HUM_t
    param2_sig_alpha_LENA_t];

f_fittype = [f_fit_HUM
    f_fit_LENA];
d_fittype = [d_fit_HUM
    d_fit_LENA];
sp_fittype = [sp_fit_HUM
    sp_fit_LENA];
t_fittype = [t_fit_HUM
    t_fit_LENA];

T = table(age,id,type,listener,f_fittype,f_param1,f_param2,d_fittype,d_param1,d_param2,...
    sp_fittype,sp_param1,sp_param2,t_fittype,t_param1,t_param2);
writetable(T,'HUM_LENA_fitparameters_advoc_noWR_WOR.csv')