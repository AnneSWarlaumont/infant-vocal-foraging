clear all
clc

%Ritwika UC Merced
%IVFCR

%AIC best fit parameters are found for human labelled data and
%corresponding LENA labelled data at the recording day level, for both
%adult and child vocalistaions. Here, step size distributions following a
%response (WR) and following a non-response (WOR) are best fit to
%distributions based on AIC.

%note, we are fitting human labelled data to the same family of curves as
%the corresponding LENA data is fit to, to compare parameters. However, if aic best fit for human and corresponding LENA data are not the same
%then that information is indicated under the fittype column in the
%resultant table

clear all
clc

%AIC: 1 normal, 2 lognormal, 3 exponential, 4 pareto

%------------------------------------
%infant vocalistaions - adult response to infant
%------------------------------------

load('humanlab_chdat.mat')
load('adresp2ch_stepsizes.mat') %uses step sizes slotted into WR and WOR for LENA data (already generated from code in folder LENA_data_analysis)

%find LENA datsets that match human labelled datasets
%first, we concatenate age and id
for i = 1:length(childid)  
    id_age_hum{i} = sprintf('%s_%d',childid{i},chage(i));
end 

%pick out unique combinations
id_age_hum = unique(id_age_hum);

for i = 1:length(id_age_hum)
    for j = 1:length(id_age)
        if (strcmp(id_age_hum{i},id_age{j}) == 1) %if id_age combos match
            LENAad_distf{i} = distf_ad_day{j};
            LENAnoad_distf{i} = distf_noad_day{j};
            LENAad_distd{i} = distd_ad_day{j};
            LENAnoad_distd{i} = distd_noad_day{j};
            LENAad_distsp{i} = distsp_ad_day{j};
            LENAnoad_distsp{i} = distsp_noad_day{j};
            LENAad_distt{i} = disttim_ad_day{j};
            LENAnoad_distt{i} = disttim_noad_day{j};
            LENA_idage{i} = id_age{j};
        end
    end
end

%finds distances and groups subrecordings from same day and same infant. Only
%for human labelled data (uses function)

[HUMad_distf,HUMnoad_distf,HUMad_distd,HUMnoad_distd,HUMad_distsp,HUMnoad_distsp,...
    HUMad_distt,HUMnoad_distt,HUM_idage] = finddist_andgroup_HUM(chst_humlab,...
                                                               chen_humlab,chdb_humlab,chlogf_humlab,adresponse_humlab,chage,childid,listenerid);

%we find parameters of AIC best fits of step size distributions
%for adult responses to child vocalisations (WR and WOR step sizes, in pitch, amplitude, 2d acoustic space, and time)

for i = 1:length(HUM_idage) 
idmat_hum = strsplit(HUM_idage{i},'_');

[aic_fad_HUM{i},fad_fit_HUM(i,1),p] = aicnew(HUMad_distf{i},[0 0 0 0],0) ;  
[aic_dad_HUM{i},dad_fit_HUM(i,1),p] = aicnew(HUMad_distd{i},[0 0 0 0],0) ; 
[aic_spad_HUM{i},spad_fit_HUM(i,1),p] = aicnew(HUMad_distsp{i},[0 0 0 0],0) ;  
[aic_tad_HUM{i},tad_fit_HUM(i,1),p] = aicnew(HUMad_distt{i},[0 0 0 0],0) ; 

[aic_fnoad_HUM{i},fnoad_fit_HUM(i,1),p] = aicnew(HUMnoad_distf{i},[0 0 0 0],0) ;  
[aic_dnoad_HUM{i},dnoad_fit_HUM(i,1),p] = aicnew(HUMnoad_distd{i},[0 0 0 0],0) ; 
[aic_spnoad_HUM{i},spnoad_fit_HUM(i,1),p] = aicnew(HUMnoad_distsp{i},[0 0 0 0],0) ;  
[aic_tnoad_HUM{i},tnoad_fit_HUM(i,1),p] = aicnew(HUMnoad_distt{i},[0 0 0 0],0) ; 

age_HUM_chvoc(i,1) = str2num(idmat_hum{2});
id_HUM_chvoc{i,1} = idmat_hum{1};
listener_HUM_chvoc{i,1} = idmat_hum{3};
type_HUM_chvoc{i,1} = 'HUM';
WR_HUM_chvoc(i,1) = 1;
WOR_HUM_chvoc(i,1) = 0;

%finds best fit parameters for human labelled and corresponding LENA data:
%uses function LENA_HUMfitparameters
for j = 1:length(LENA_idage)
idmat_lena = strsplit(LENA_idage{j},'_');
if (strcmp(idmat_lena{1},idmat_hum{1}) == 1) && (strcmp(idmat_lena{2},idmat_hum{2}) == 1) %matches child age and id for LENA and HUM label
    
[aic_fad_LENA{j},fad_fit_LENA(j,1),p] = aicnew(LENAad_distf{j},[0 0 0 0],0) ;  
[param1_lam_mu_xmin_HUM_fad(i,1),param2_sig_alpha_HUM_fad{i,1},param1_lam_mu_xmin_LENA_fad(j,1),param2_sig_alpha_LENA_fad{j,1}] =...
                                                                                    LENA_HUMfitparameters(aic_fad_HUM{i},fad_fit_LENA(j,1),aic_fad_LENA{j});
[aic_dad_LENA{j},dad_fit_LENA(j,1),p] = aicnew(LENAad_distd{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_dad(i,1),param2_sig_alpha_HUM_dad{i,1},param1_lam_mu_xmin_LENA_dad(j,1),param2_sig_alpha_LENA_dad{j,1}] =...
                                                                                    LENA_HUMfitparameters(aic_dad_HUM{i},dad_fit_LENA(j,1),aic_dad_LENA{j});
[aic_spad_LENA{j},spad_fit_LENA(j,1),p] = aicnew(LENAad_distsp{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_spad(i,1),param2_sig_alpha_HUM_spad{i,1},param1_lam_mu_xmin_LENA_spad(j,1),param2_sig_alpha_LENA_spad{j,1}] =...
                                                                                 LENA_HUMfitparameters(aic_spad_HUM{i},spad_fit_LENA(j,1),aic_spad_LENA{j});
[aic_tad_LENA{j},tad_fit_LENA(j,1),p] = aicnew(LENAad_distt{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_tad(i,1),param2_sig_alpha_HUM_tad{i,1},param1_lam_mu_xmin_LENA_tad(j,1),param2_sig_alpha_LENA_tad{j,1}] =...
                                                                                    LENA_HUMfitparameters(aic_tad_HUM{i},tad_fit_LENA(j,1),aic_tad_LENA{j});
                                                                                
[aic_fnoad_LENA{j},fnoad_fit_LENA(j,1),p] = aicnew(LENAnoad_distf{j},[0 0 0 0],0) ;
[param1_lam_mu_xmin_HUM_fnoad(i,1),param2_sig_alpha_HUM_fnoad{i,1},param1_lam_mu_xmin_LENA_fnoad(j,1),param2_sig_alpha_LENA_fnoad{j,1}] =...
                                                                               LENA_HUMfitparameters(aic_fnoad_HUM{i},fnoad_fit_LENA(j,1),aic_fnoad_LENA{j});
[aic_dnoad_LENA{j},dnoad_fit_LENA(j,1),p] = aicnew(LENAnoad_distd{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_dnoad(i,1),param2_sig_alpha_HUM_dnoad{i,1},param1_lam_mu_xmin_LENA_dnoad(j,1),param2_sig_alpha_LENA_dnoad{j,1}] =...
                                                                               LENA_HUMfitparameters(aic_dnoad_HUM{i},dnoad_fit_LENA(j,1),aic_dnoad_LENA{j});
[aic_spnoad_LENA{j},spnoad_fit_LENA(j,1),p] = aicnew(LENAnoad_distsp{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_spnoad(i,1),param2_sig_alpha_HUM_spnoad{i,1},param1_lam_mu_xmin_LENA_spnoad(j,1),param2_sig_alpha_LENA_spnoad{j,1}] =...
                                                                           LENA_HUMfitparameters(aic_spnoad_HUM{i},spnoad_fit_LENA(j,1),aic_spnoad_LENA{j});
[aic_tnoad_LENA{j},tnoad_fit_LENA(j,1),p] = aicnew(LENAnoad_distt{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_tnoad(i,1),param2_sig_alpha_HUM_tnoad{i,1},param1_lam_mu_xmin_LENA_tnoad(j,1),param2_sig_alpha_LENA_tnoad{j,1}] =...
                                                                              LENA_HUMfitparameters(aic_tnoad_HUM{i},tnoad_fit_LENA(j,1),aic_tnoad_LENA{j});

age_LENA_chvoc(j,1) = str2num(idmat_lena{2});
id_LENA_chvoc{j,1} = idmat_lena{1};
type_LENA_chvoc{j,1} = 'LENA';
listener_LENA_chvoc{j,1} = 'NA';
WR_LENA_chvoc(j,1) = 1;
WOR_LENA_chvoc(j,1) = 0;

end
end
end

%puts all of it together to write .csv file
age = [age_HUM_chvoc
    age_LENA_chvoc
    age_HUM_chvoc
    age_LENA_chvoc];
id = [id_HUM_chvoc
    id_LENA_chvoc
    id_HUM_chvoc
    id_LENA_chvoc];
type = [type_HUM_chvoc
    type_LENA_chvoc
    type_HUM_chvoc
    type_LENA_chvoc];
listener = [listener_HUM_chvoc
    listener_LENA_chvoc
    listener_HUM_chvoc
    listener_LENA_chvoc];
response = [WR_HUM_chvoc
    WR_LENA_chvoc
    WOR_HUM_chvoc
    WOR_LENA_chvoc];

f_param1 = [param1_lam_mu_xmin_HUM_fad
    param1_lam_mu_xmin_LENA_fad
    param1_lam_mu_xmin_HUM_fnoad
    param1_lam_mu_xmin_LENA_fnoad];
f_param2 = [param2_sig_alpha_HUM_fad
    param2_sig_alpha_LENA_fad
    param2_sig_alpha_HUM_fnoad
    param2_sig_alpha_LENA_fnoad];

d_param1 = [param1_lam_mu_xmin_HUM_dad
    param1_lam_mu_xmin_LENA_dad
    param1_lam_mu_xmin_HUM_dnoad
    param1_lam_mu_xmin_LENA_dnoad];
d_param2 = [param2_sig_alpha_HUM_dad
    param2_sig_alpha_LENA_dad
    param2_sig_alpha_HUM_dnoad
    param2_sig_alpha_LENA_dnoad];

sp_param1 = [param1_lam_mu_xmin_HUM_spad
    param1_lam_mu_xmin_LENA_spad
    param1_lam_mu_xmin_HUM_spnoad
    param1_lam_mu_xmin_LENA_spnoad];
sp_param2 = [param2_sig_alpha_HUM_spad
    param2_sig_alpha_LENA_spad
    param2_sig_alpha_HUM_spnoad
    param2_sig_alpha_LENA_spnoad];

t_param1 = [param1_lam_mu_xmin_HUM_tad
    param1_lam_mu_xmin_LENA_tad
    param1_lam_mu_xmin_HUM_tnoad
    param1_lam_mu_xmin_LENA_tnoad];
t_param2 = [param2_sig_alpha_HUM_tad
    param2_sig_alpha_LENA_tad
    param2_sig_alpha_HUM_tnoad
    param2_sig_alpha_LENA_tnoad];

f_fittype = [fad_fit_HUM
    fad_fit_LENA
    fnoad_fit_HUM
    fnoad_fit_LENA];

d_fittype = [dad_fit_HUM
    dad_fit_LENA
    dnoad_fit_HUM
    dnoad_fit_LENA];

sp_fittype = [spad_fit_HUM
    spad_fit_LENA
    spnoad_fit_HUM
    spnoad_fit_LENA];

t_fittype = [tad_fit_HUM
    tad_fit_LENA
    tnoad_fit_HUM
    tnoad_fit_LENA];

T = table(age,id,type,listener,response,f_fittype,f_param1,f_param2,d_fittype,d_param1,d_param2,...
    sp_fittype,sp_param1,sp_param2,t_fittype,t_param1,t_param2);
writetable(T,'HUM_LENA_fitparameters_adresp2ch.csv')

%------------------------------------
%adult vocalistaions - child responses to adult
%------------------------------------
clear all

load('humanlab_addat.mat')
load('chresp2ad_stepsizes.mat')%uses step sizes slotted into WR and WOR for LENA data (already generated from code in folder LENA_data_analysis)

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
            LENAch_distf{i} = distf_ch_day{j};
            LENAnoch_distf{i} = distf_noch_day{j};
            LENAch_distd{i} = distd_ch_day{j};
            LENAnoch_distd{i} = distd_noch_day{j};
            LENAch_distsp{i} = distsp_ch_day{j};
            LENAnoch_distsp{i} = distsp_noch_day{j};
            LENAch_distt{i} = disttim_ch_day{j};
            LENAnoch_distt{i} = disttim_noch_day{j};
            LENA_idage{i} = id_age{j};
        end
    end
end

%finds distances and groups subrecordings from same day and same infant. Only
%for human labelled data (uses function)

[HUMch_distf,HUMnoch_distf,HUMch_distd,HUMnoch_distd,HUMch_distsp,HUMnoch_distsp,...
    HUMch_distt,HUMnoch_distt,HUM_idage] = finddist_andgroup_HUM(adst_humlab,...
                                                               aden_humlab,addb_humlab,adlogf_humlab,chresp2ad_humlab,age_adhumlab,childid_ad,listenerid_ad);
                                                           
%we find parameters of AIC best fits of step size distributions
%for child responses to adult vocalisations (WR and WOR step sizes, in pitch, amplitude, 2d acoustic space, and time)

for i = 1:length(HUM_idage) 
idmat_hum = strsplit(HUM_idage{i},'_');

[aic_fch_HUM{i},fch_fit_HUM(i,1),p] = aicnew(HUMch_distf{i},[0 0 0 0],0) ;  
[aic_dch_HUM{i},dch_fit_HUM(i,1),p] = aicnew(HUMch_distd{i},[0 0 0 0],0) ; 
[aic_spch_HUM{i},spch_fit_HUM(i,1),p] = aicnew(HUMch_distsp{i},[0 0 0 0],0) ;  
[aic_tch_HUM{i},tch_fit_HUM(i,1),p] = aicnew(HUMch_distt{i},[0 0 0 0],0) ; 

[aic_fnoch_HUM{i},fnoch_fit_HUM(i,1),p] = aicnew(HUMnoch_distf{i},[0 0 0 0],0) ;  
[aic_dnoch_HUM{i},dnoch_fit_HUM(i,1),p] = aicnew(HUMnoch_distd{i},[0 0 0 0],0) ; 
[aic_spnoch_HUM{i},spnoch_fit_HUM(i,1),p] = aicnew(HUMnoch_distsp{i},[0 0 0 0],0) ;  
[aic_tnoch_HUM{i},tnoch_fit_HUM(i,1),p] = aicnew(HUMnoch_distt{i},[0 0 0 0],0) ; 

age_HUM_chvoc(i,1) = str2num(idmat_hum{2});
id_HUM_chvoc{i,1} = idmat_hum{1};
listener_HUM_chvoc{i,1} = idmat_hum{3};
type_HUM_chvoc{i,1} = 'HUM';
WR_HUM_chvoc(i,1) = 1;
WOR_HUM_chvoc(i,1) = 0;

%finds best fit parameters for human labelled and corresponding LENA data:
%uses function LENA_HUMfitparameters
for j = 1:length(LENA_idage)
idmat_lena = strsplit(LENA_idage{j},'_');
if (strcmp(idmat_lena{1},idmat_hum{1}) == 1) && (strcmp(idmat_lena{2},idmat_hum{2}) == 1) %matches child age and id for LENA and HUM label
    
[aic_fch_LENA{j},fch_fit_LENA(j,1),p] = aicnew(LENAch_distf{j},[0 0 0 0],0) ;  
[param1_lam_mu_xmin_HUM_fch(i,1),param2_sig_alpha_HUM_fch{i,1},param1_lam_mu_xmin_LENA_fch(j,1),param2_sig_alpha_LENA_fch{j,1}] =...
                                                                                    LENA_HUMfitparameters(aic_fch_HUM{i},fch_fit_LENA(j,1),aic_fch_LENA{j});
[aic_dch_LENA{j},dch_fit_LENA(j,1),p] = aicnew(LENAch_distd{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_dch(i,1),param2_sig_alpha_HUM_dch{i,1},param1_lam_mu_xmin_LENA_dch(j,1),param2_sig_alpha_LENA_dch{j,1}] =...
                                                                                    LENA_HUMfitparameters(aic_dch_HUM{i},dch_fit_LENA(j,1),aic_dch_LENA{j});
[aic_spch_LENA{j},spch_fit_LENA(j,1),p] = aicnew(LENAch_distsp{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_spch(i,1),param2_sig_alpha_HUM_spch{i,1},param1_lam_mu_xmin_LENA_spch(j,1),param2_sig_alpha_LENA_spch{j,1}] =...
                                                                                 LENA_HUMfitparameters(aic_spch_HUM{i},spch_fit_LENA(j,1),aic_spch_LENA{j});
[aic_tch_LENA{j},tch_fit_LENA(j,1),p] = aicnew(LENAch_distt{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_tch(i,1),param2_sig_alpha_HUM_tch{i,1},param1_lam_mu_xmin_LENA_tch(j,1),param2_sig_alpha_LENA_tch{j,1}] =...
                                                                                    LENA_HUMfitparameters(aic_tch_HUM{i},tch_fit_LENA(j,1),aic_tch_LENA{j});
                                                                                
[aic_fnoch_LENA{j},fnoch_fit_LENA(j,1),p] = aicnew(LENAnoch_distf{j},[0 0 0 0],0) ;
[param1_lam_mu_xmin_HUM_fnoch(i,1),param2_sig_alpha_HUM_fnoch{i,1},param1_lam_mu_xmin_LENA_fnoch(j,1),param2_sig_alpha_LENA_fnoch{j,1}] =...
                                                                               LENA_HUMfitparameters(aic_fnoch_HUM{i},fnoch_fit_LENA(j,1),aic_fnoch_LENA{j});
[aic_dnoch_LENA{j},dnoch_fit_LENA(j,1),p] = aicnew(LENAnoch_distd{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_dnoch(i,1),param2_sig_alpha_HUM_dnoch{i,1},param1_lam_mu_xmin_LENA_dnoch(j,1),param2_sig_alpha_LENA_dnoch{j,1}] =...
                                                                               LENA_HUMfitparameters(aic_dnoch_HUM{i},dnoch_fit_LENA(j,1),aic_dnoch_LENA{j});
[aic_spnoch_LENA{j},spnoch_fit_LENA(j,1),p] = aicnew(LENAnoch_distsp{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_spnoch(i,1),param2_sig_alpha_HUM_spnoch{i,1},param1_lam_mu_xmin_LENA_spnoch(j,1),param2_sig_alpha_LENA_spnoch{j,1}] =...
                                                                           LENA_HUMfitparameters(aic_spnoch_HUM{i},spnoch_fit_LENA(j,1),aic_spnoch_LENA{j});
[aic_tnoch_LENA{j},tnoch_fit_LENA(j,1),p] = aicnew(LENAnoch_distt{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_tnoch(i,1),param2_sig_alpha_HUM_tnoch{i,1},param1_lam_mu_xmin_LENA_tnoch(j,1),param2_sig_alpha_LENA_tnoch{j,1}] =...
                                                                              LENA_HUMfitparameters(aic_tnoch_HUM{i},tnoch_fit_LENA(j,1),aic_tnoch_LENA{j});

age_LENA_chvoc(j,1) = str2num(idmat_lena{2});
id_LENA_chvoc{j,1} = idmat_lena{1};
type_LENA_chvoc{j,1} = 'LENA';
listener_LENA_chvoc{j,1} = 'NA';
WR_LENA_chvoc(j,1) = 1;
WOR_LENA_chvoc(j,1) = 0;

end
end
end

%puts all of it together to write .csv file
age = [age_HUM_chvoc
    age_LENA_chvoc
    age_HUM_chvoc
    age_LENA_chvoc];
id = [id_HUM_chvoc
    id_LENA_chvoc
    id_HUM_chvoc
    id_LENA_chvoc];
type = [type_HUM_chvoc
    type_LENA_chvoc
    type_HUM_chvoc
    type_LENA_chvoc];
listener = [listener_HUM_chvoc
    listener_LENA_chvoc
    listener_HUM_chvoc
    listener_LENA_chvoc];
response = [WR_HUM_chvoc
    WR_LENA_chvoc
    WOR_HUM_chvoc
    WOR_LENA_chvoc];

f_param1 = [param1_lam_mu_xmin_HUM_fch
    param1_lam_mu_xmin_LENA_fch
    param1_lam_mu_xmin_HUM_fnoch
    param1_lam_mu_xmin_LENA_fnoch];
f_param2 = [param2_sig_alpha_HUM_fch
    param2_sig_alpha_LENA_fch
    param2_sig_alpha_HUM_fnoch
    param2_sig_alpha_LENA_fnoch];

d_param1 = [param1_lam_mu_xmin_HUM_dch
    param1_lam_mu_xmin_LENA_dch
    param1_lam_mu_xmin_HUM_dnoch
    param1_lam_mu_xmin_LENA_dnoch];
d_param2 = [param2_sig_alpha_HUM_dch
    param2_sig_alpha_LENA_dch
    param2_sig_alpha_HUM_dnoch
    param2_sig_alpha_LENA_dnoch];

sp_param1 = [param1_lam_mu_xmin_HUM_spch
    param1_lam_mu_xmin_LENA_spch
    param1_lam_mu_xmin_HUM_spnoch
    param1_lam_mu_xmin_LENA_spnoch];
sp_param2 = [param2_sig_alpha_HUM_spch
    param2_sig_alpha_LENA_spch
    param2_sig_alpha_HUM_spnoch
    param2_sig_alpha_LENA_spnoch];

t_param1 = [param1_lam_mu_xmin_HUM_tch
    param1_lam_mu_xmin_LENA_tch
    param1_lam_mu_xmin_HUM_tnoch
    param1_lam_mu_xmin_LENA_tnoch];
t_param2 = [param2_sig_alpha_HUM_tch
    param2_sig_alpha_LENA_tch
    param2_sig_alpha_HUM_tnoch
    param2_sig_alpha_LENA_tnoch];

f_fittype = [fch_fit_HUM
    fch_fit_LENA
    fnoch_fit_HUM
    fnoch_fit_LENA];

d_fittype = [dch_fit_HUM
    dch_fit_LENA
    dnoch_fit_HUM
    dnoch_fit_LENA];

sp_fittype = [spch_fit_HUM
    spch_fit_LENA
    spnoch_fit_HUM
    spnoch_fit_LENA];

t_fittype = [tch_fit_HUM
    tch_fit_LENA
    tnoch_fit_HUM
    tnoch_fit_LENA];

T = table(age,id,type,listener,response,f_fittype,f_param1,f_param2,d_fittype,d_param1,d_param2,...
    sp_fittype,sp_param1,sp_param2,t_fittype,t_param1,t_param2);
writetable(T,'HUM_LENA_fitparameters_chresp2ad.csv')


