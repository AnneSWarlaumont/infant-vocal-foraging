clear all
clc

%Ritwika VPS, UC Merced

%we find parameters of AIC best fits of step size distributions

%adult responses to child vocalisationsm, TW
load('adresp2ch_stepsizes_timwin_humlab.mat')

for i = 1:length(HUM_idage_tw) 
idmat_hum = strsplit(HUM_idage_tw{i},'_');

[aic_fad_HUM_tw{i},fad_fit_HUM_tw(i,1),p] = aicnew(HUMad_distf_tw{i},[0 0 0 0],0) ;  %find aic values for human labelled data
[aic_dad_HUM_tw{i},dad_fit_HUM_tw(i,1),p] = aicnew(HUMad_distd_tw{i},[0 0 0 0],0) ; 
[aic_spad_HUM_tw{i},spad_fit_HUM_tw(i,1),p] = aicnew(HUMad_distsp_tw{i},[0 0 0 0],0) ;  
[aic_tad_HUM_tw{i},tad_fit_HUM_tw(i,1),p] = aicnew(HUMad_distt_tw{i},[0 0 0 0],0) ; 
[aic_vad_HUM_tw{i},vad_fit_HUM_tw(i,1),p] = aicnew(HUMad_velsp_tw{i},[0 0 0 0],0) ; 

[aic_fnoad_HUM_tw{i},fnoad_fit_HUM_tw(i,1),p] = aicnew(HUMnoad_distf_tw{i},[0 0 0 0],0) ;  
[aic_dnoad_HUM_tw{i},dnoad_fit_HUM_tw(i,1),p] = aicnew(HUMnoad_distd_tw{i},[0 0 0 0],0) ; 
[aic_spnoad_HUM_tw{i},spnoad_fit_HUM_tw(i,1),p] = aicnew(HUMnoad_distsp_tw{i},[0 0 0 0],0) ;  
[aic_tnoad_HUM_tw{i},tnoad_fit_HUM_tw(i,1),p] = aicnew(HUMnoad_distt_tw{i},[0 0 0 0],0) ; 
[aic_vnoad_HUM_tw{i},vnoad_fit_HUM_tw(i,1),p] = aicnew(HUMnoad_velsp_tw{i},[0 0 0 0],0) ;

age_HUM_tw_chvoc(i,1) = str2num(idmat_hum{2}); 
id_HUM_tw_chvoc{i,1} = idmat_hum{1};
listener_HUM_tw_chvoc{i,1} = idmat_hum{3};
type_HUM_tw_chvoc{i,1} = 'HUM';
WR_HUM_tw_chvoc(i,1) = 1;
WOR_HUM_tw_chvoc(i,1) = 0;

for j = 1:length(LENA_idage_tw)
idmat_lena = strsplit(LENA_idage_tw{j},'_');
if (strcmp(idmat_lena{1},idmat_hum{1}) == 1) && (strcmp(idmat_lena{2},idmat_hum{2}) == 1) %matches child age and id for LENA and HUM label
    
[aic_fad_LENA_tw{j},fad_fit_LENA_tw(j,1),p] = aicnew(LENAad_distf_tw{j},[0 0 0 0],0) ;  %find aic values for LENA
%huma labelled data is then fit to the same curve as the corresponding LENA
%data to compare parameters
[param1_lam_mu_xmin_HUM_fad_tw(i,1),param2_sig_alpha_HUM_fad_tw{i,1},param1_lam_mu_xmin_LENA_fad_tw(j,1),param2_sig_alpha_LENA_fad_tw{j,1}] =...
                                                                                    LENA_HUMfitparameters(aic_fad_HUM_tw{i},fad_fit_LENA_tw(j,1),aic_fad_LENA_tw{j});
[aic_dad_LENA_tw{j},dad_fit_LENA_tw(j,1),p] = aicnew(LENAad_distd_tw{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_dad_tw(i,1),param2_sig_alpha_HUM_dad_tw{i,1},param1_lam_mu_xmin_LENA_dad_tw(j,1),param2_sig_alpha_LENA_dad_tw{j,1}] =...
                                                                                    LENA_HUMfitparameters(aic_dad_HUM_tw{i},dad_fit_LENA_tw(j,1),aic_dad_LENA_tw{j});
[aic_spad_LENA_tw{j},spad_fit_LENA_tw(j,1),p] = aicnew(LENAad_distsp_tw{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_spad_tw(i,1),param2_sig_alpha_HUM_spad_tw{i,1},param1_lam_mu_xmin_LENA_spad_tw(j,1),param2_sig_alpha_LENA_spad_tw{j,1}] =...
                                                                                 LENA_HUMfitparameters(aic_spad_HUM_tw{i},spad_fit_LENA_tw(j,1),aic_spad_LENA_tw{j});
[aic_tad_LENA_tw{j},tad_fit_LENA_tw(j,1),p] = aicnew(LENAad_distt_tw{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_tad_tw(i,1),param2_sig_alpha_HUM_tad_tw{i,1},param1_lam_mu_xmin_LENA_tad_tw(j,1),param2_sig_alpha_LENA_tad_tw{j,1}] =...
                                                                                    LENA_HUMfitparameters(aic_tad_HUM_tw{i},tad_fit_LENA_tw(j,1),aic_tad_LENA_tw{j});
[aic_vad_LENA_tw{j},vad_fit_LENA_tw(j,1),p] = aicnew(LENAad_velsp_tw{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_vad_tw(i,1),param2_sig_alpha_HUM_vad_tw{i,1},param1_lam_mu_xmin_LENA_vad_tw(j,1),param2_sig_alpha_LENA_vad_tw{j,1}] =...
                                                                                    LENA_HUMfitparameters(aic_vad_HUM_tw{i},vad_fit_LENA_tw(j,1),aic_vad_LENA_tw{j});

                                                                                
[aic_fnoad_LENA_tw{j},fnoad_fit_LENA_tw(j,1),p] = aicnew(LENAnoad_distf_tw{j},[0 0 0 0],0) ;
[param1_lam_mu_xmin_HUM_fnoad_tw(i,1),param2_sig_alpha_HUM_fnoad_tw{i,1},param1_lam_mu_xmin_LENA_fnoad_tw(j,1),param2_sig_alpha_LENA_fnoad_tw{j,1}] =...
                                                                               LENA_HUMfitparameters(aic_fnoad_HUM_tw{i},fnoad_fit_LENA_tw(j,1),aic_fnoad_LENA_tw{j});
[aic_dnoad_LENA_tw{j},dnoad_fit_LENA_tw(j,1),p] = aicnew(LENAnoad_distd_tw{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_dnoad_tw(i,1),param2_sig_alpha_HUM_dnoad_tw{i,1},param1_lam_mu_xmin_LENA_dnoad_tw(j,1),param2_sig_alpha_LENA_dnoad_tw{j,1}] =...
                                                                               LENA_HUMfitparameters(aic_dnoad_HUM_tw{i},dnoad_fit_LENA_tw(j,1),aic_dnoad_LENA_tw{j});
[aic_spnoad_LENA_tw{j},spnoad_fit_LENA_tw(j,1),p] = aicnew(LENAnoad_distsp_tw{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_spnoad_tw(i,1),param2_sig_alpha_HUM_spnoad_tw{i,1},param1_lam_mu_xmin_LENA_spnoad_tw(j,1),param2_sig_alpha_LENA_spnoad_tw{j,1}] =...
                                                                           LENA_HUMfitparameters(aic_spnoad_HUM_tw{i},spnoad_fit_LENA_tw(j,1),aic_spnoad_LENA_tw{j});
[aic_tnoad_LENA_tw{j},tnoad_fit_LENA_tw(j,1),p] = aicnew(LENAnoad_distt_tw{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_tnoad_tw(i,1),param2_sig_alpha_HUM_tnoad_tw{i,1},param1_lam_mu_xmin_LENA_tnoad_tw(j,1),param2_sig_alpha_LENA_tnoad_tw{j,1}] =...
                                                                              LENA_HUMfitparameters(aic_tnoad_HUM_tw{i},tnoad_fit_LENA_tw(j,1),aic_tnoad_LENA_tw{j});
[aic_vnoad_LENA_tw{j},vnoad_fit_LENA_tw(j,1),p] = aicnew(LENAnoad_velsp_tw{j},[0 0 0 0],0) ;
[param1_lam_mu_xmin_HUM_vnoad_tw(i,1),param2_sig_alpha_HUM_vnoad_tw{i,1},param1_lam_mu_xmin_LENA_vnoad_tw(j,1),param2_sig_alpha_LENA_vnoad_tw{j,1}] =...
                                                                              LENA_HUMfitparameters(aic_vnoad_HUM_tw{i},vnoad_fit_LENA_tw(j,1),aic_vnoad_LENA_tw{j});

age_LENA_tw_chvoc(j,1) = str2num(idmat_lena{2});
id_LENA_tw_chvoc{j,1} = idmat_lena{1};
type_LENA_tw_chvoc{j,1} = 'LENA';
listener_LENA_tw_chvoc{j,1} = 'NA';
WR_LENA_tw_chvoc(j,1) = 1;
WOR_LENA_tw_chvoc(j,1) = 0;

end
end
end

age = [age_HUM_tw_chvoc
    age_LENA_tw_chvoc
    age_HUM_tw_chvoc
    age_LENA_tw_chvoc];
id = [id_HUM_tw_chvoc
    id_LENA_tw_chvoc
    id_HUM_tw_chvoc
    id_LENA_tw_chvoc];
type = [type_HUM_tw_chvoc
    type_LENA_tw_chvoc
    type_HUM_tw_chvoc
    type_LENA_tw_chvoc];
listener = [listener_HUM_tw_chvoc
    listener_LENA_tw_chvoc
    listener_HUM_tw_chvoc
    listener_LENA_tw_chvoc];
response = [WR_HUM_tw_chvoc
    WR_LENA_tw_chvoc
    WOR_HUM_tw_chvoc
    WOR_LENA_tw_chvoc];

f_param1 = [param1_lam_mu_xmin_HUM_fad_tw
    param1_lam_mu_xmin_LENA_fad_tw
    param1_lam_mu_xmin_HUM_fnoad_tw
    param1_lam_mu_xmin_LENA_fnoad_tw];
f_param2 = [param2_sig_alpha_HUM_fad_tw
    param2_sig_alpha_LENA_fad_tw
    param2_sig_alpha_HUM_fnoad_tw
    param2_sig_alpha_LENA_fnoad_tw];


d_param1 = [param1_lam_mu_xmin_HUM_dad_tw
    param1_lam_mu_xmin_LENA_dad_tw
    param1_lam_mu_xmin_HUM_dnoad_tw
    param1_lam_mu_xmin_LENA_dnoad_tw];
d_param2 = [param2_sig_alpha_HUM_dad_tw
    param2_sig_alpha_LENA_dad_tw
    param2_sig_alpha_HUM_dnoad_tw
    param2_sig_alpha_LENA_dnoad_tw];


sp_param1 = [param1_lam_mu_xmin_HUM_spad_tw
    param1_lam_mu_xmin_LENA_spad_tw
    param1_lam_mu_xmin_HUM_spnoad_tw
    param1_lam_mu_xmin_LENA_spnoad_tw];
sp_param2 = [param2_sig_alpha_HUM_spad_tw
    param2_sig_alpha_LENA_spad_tw
    param2_sig_alpha_HUM_spnoad_tw
    param2_sig_alpha_LENA_spnoad_tw];

t_param1 = [param1_lam_mu_xmin_HUM_tad_tw
    param1_lam_mu_xmin_LENA_tad_tw
    param1_lam_mu_xmin_HUM_tnoad_tw
    param1_lam_mu_xmin_LENA_tnoad_tw];
t_param2 = [param2_sig_alpha_HUM_tad_tw
    param2_sig_alpha_LENA_tad_tw
    param2_sig_alpha_HUM_tnoad_tw
    param2_sig_alpha_LENA_tnoad_tw];

v_param1 = [param1_lam_mu_xmin_HUM_vad_tw
    param1_lam_mu_xmin_LENA_vad_tw
    param1_lam_mu_xmin_HUM_vnoad_tw
    param1_lam_mu_xmin_LENA_vnoad_tw];
v_param2 = [param2_sig_alpha_HUM_vad_tw
    param2_sig_alpha_LENA_vad_tw
    param2_sig_alpha_HUM_vnoad_tw
    param2_sig_alpha_LENA_vnoad_tw];

f_fittype = [fad_fit_HUM_tw
    fad_fit_LENA_tw
    fnoad_fit_HUM_tw
    fnoad_fit_LENA_tw];

d_fittype = [dad_fit_HUM_tw
    dad_fit_LENA_tw
    dnoad_fit_HUM_tw
    dnoad_fit_LENA_tw];

sp_fittype = [spad_fit_HUM_tw
    spad_fit_LENA_tw
    spnoad_fit_HUM_tw
    spnoad_fit_LENA_tw];

t_fittype = [tad_fit_HUM_tw
    tad_fit_LENA_tw
    tnoad_fit_HUM_tw
    tnoad_fit_LENA_tw];

v_fittype = [vad_fit_HUM_tw
    vad_fit_LENA_tw
    vnoad_fit_HUM_tw
    vnoad_fit_LENA_tw];

T = table(age,id,type,listener,response,f_fittype,f_param1,f_param2,d_fittype,d_param1,d_param2,...
    sp_fittype,sp_param1,sp_param2,t_fittype,t_param1,t_param2,v_fittype,v_param1,v_param2);
writetable(T,'HUM_LENA_fitparameters_adresp2ch_TW.csv')

clear all
clc

%for adult responses to child vocalisations, subsequent vocalisation only
load('adresp2ch_stepsizes_1v_humlab.mat')

for i = 1:length(HUM_idage_1v) 
idmat_hum = strsplit(HUM_idage_1v{i},'_');

[aic_fad_HUM_1v{i},fad_fit_HUM_1v(i,1),p] = aicnew(HUMad_distf_1v{i},[0 0 0 0],0) ;  
[aic_dad_HUM_1v{i},dad_fit_HUM_1v(i,1),p] = aicnew(HUMad_distd_1v{i},[0 0 0 0],0) ; 
[aic_spad_HUM_1v{i},spad_fit_HUM_1v(i,1),p] = aicnew(HUMad_distsp_1v{i},[0 0 0 0],0) ;  
[aic_tad_HUM_1v{i},tad_fit_HUM_1v(i,1),p] = aicnew(HUMad_distt_1v{i},[0 0 0 0],0) ; 
[aic_vad_HUM_1v{i},vad_fit_HUM_1v(i,1),p] = aicnew(HUMad_velsp_1v{i},[0 0 0 0],0) ; 

[aic_fnoad_HUM_1v{i},fnoad_fit_HUM_1v(i,1),p] = aicnew(HUMnoad_distf_1v{i},[0 0 0 0],0) ;  
[aic_dnoad_HUM_1v{i},dnoad_fit_HUM_1v(i,1),p] = aicnew(HUMnoad_distd_1v{i},[0 0 0 0],0) ; 
[aic_spnoad_HUM_1v{i},spnoad_fit_HUM_1v(i,1),p] = aicnew(HUMnoad_distsp_1v{i},[0 0 0 0],0) ;  
[aic_tnoad_HUM_1v{i},tnoad_fit_HUM_1v(i,1),p] = aicnew(HUMnoad_distt_1v{i},[0 0 0 0],0) ; 
[aic_vnoad_HUM_1v{i},vnoad_fit_HUM_1v(i,1),p] = aicnew(HUMnoad_velsp_1v{i},[0 0 0 0],0) ;

age_HUM_1v_chvoc(i,1) = str2num(idmat_hum{2});
id_HUM_1v_chvoc{i,1} = idmat_hum{1};
listener_HUM_1v_chvoc{i,1} = idmat_hum{3};
type_HUM_1v_chvoc{i,1} = 'HUM';
WR_HUM_1v_chvoc(i,1) = 1;
WOR_HUM_1v_chvoc(i,1) = 0;

for j = 1:length(LENA_idage_1v)
idmat_lena = strsplit(LENA_idage_1v{j},'_');
if (strcmp(idmat_lena{1},idmat_hum{1}) == 1) && (strcmp(idmat_lena{2},idmat_hum{2}) == 1) %matches child age and id for LENA and HUM label
    
[aic_fad_LENA_1v{j},fad_fit_LENA_1v(j,1),p] = aicnew(LENAad_distf_1v{j},[0 0 0 0],0) ;  
[param1_lam_mu_xmin_HUM_fad_1v(i,1),param2_sig_alpha_HUM_fad_1v{i,1},param1_lam_mu_xmin_LENA_fad_1v(j,1),param2_sig_alpha_LENA_fad_1v{j,1}] =...
                                                                                    LENA_HUMfitparameters(aic_fad_HUM_1v{i},fad_fit_LENA_1v(j,1),aic_fad_LENA_1v{j});
[aic_dad_LENA_1v{j},dad_fit_LENA_1v(j,1),p] = aicnew(LENAad_distd_1v{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_dad_1v(i,1),param2_sig_alpha_HUM_dad_1v{i,1},param1_lam_mu_xmin_LENA_dad_1v(j,1),param2_sig_alpha_LENA_dad_1v{j,1}] =...
                                                                                    LENA_HUMfitparameters(aic_dad_HUM_1v{i},dad_fit_LENA_1v(j,1),aic_dad_LENA_1v{j});
[aic_spad_LENA_1v{j},spad_fit_LENA_1v(j,1),p] = aicnew(LENAad_distsp_1v{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_spad_1v(i,1),param2_sig_alpha_HUM_spad_1v{i,1},param1_lam_mu_xmin_LENA_spad_1v(j,1),param2_sig_alpha_LENA_spad_1v{j,1}] =...
                                                                                 LENA_HUMfitparameters(aic_spad_HUM_1v{i},spad_fit_LENA_1v(j,1),aic_spad_LENA_1v{j});
[aic_tad_LENA_1v{j},tad_fit_LENA_1v(j,1),p] = aicnew(LENAad_distt_1v{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_tad_1v(i,1),param2_sig_alpha_HUM_tad_1v{i,1},param1_lam_mu_xmin_LENA_tad_1v(j,1),param2_sig_alpha_LENA_tad_1v{j,1}] =...
                                                                                    LENA_HUMfitparameters(aic_tad_HUM_1v{i},tad_fit_LENA_1v(j,1),aic_tad_LENA_1v{j});
[aic_vad_LENA_1v{j},vad_fit_LENA_1v(j,1),p] = aicnew(LENAad_velsp_1v{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_vad_1v(i,1),param2_sig_alpha_HUM_vad_1v{i,1},param1_lam_mu_xmin_LENA_vad_1v(j,1),param2_sig_alpha_LENA_vad_1v{j,1}] =...
                                                                                    LENA_HUMfitparameters(aic_vad_HUM_1v{i},vad_fit_LENA_1v(j,1),aic_vad_LENA_1v{j});

                                                                                
[aic_fnoad_LENA_1v{j},fnoad_fit_LENA_1v(j,1),p] = aicnew(LENAnoad_distf_1v{j},[0 0 0 0],0) ;
[param1_lam_mu_xmin_HUM_fnoad_1v(i,1),param2_sig_alpha_HUM_fnoad_1v{i,1},param1_lam_mu_xmin_LENA_fnoad_1v(j,1),param2_sig_alpha_LENA_fnoad_1v{j,1}] =...
                                                                               LENA_HUMfitparameters(aic_fnoad_HUM_1v{i},fnoad_fit_LENA_1v(j,1),aic_fnoad_LENA_1v{j});
[aic_dnoad_LENA_1v{j},dnoad_fit_LENA_1v(j,1),p] = aicnew(LENAnoad_distd_1v{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_dnoad_1v(i,1),param2_sig_alpha_HUM_dnoad_1v{i,1},param1_lam_mu_xmin_LENA_dnoad_1v(j,1),param2_sig_alpha_LENA_dnoad_1v{j,1}] =...
                                                                               LENA_HUMfitparameters(aic_dnoad_HUM_1v{i},dnoad_fit_LENA_1v(j,1),aic_dnoad_LENA_1v{j});
[aic_spnoad_LENA_1v{j},spnoad_fit_LENA_1v(j,1),p] = aicnew(LENAnoad_distsp_1v{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_spnoad_1v(i,1),param2_sig_alpha_HUM_spnoad_1v{i,1},param1_lam_mu_xmin_LENA_spnoad_1v(j,1),param2_sig_alpha_LENA_spnoad_1v{j,1}] =...
                                                                           LENA_HUMfitparameters(aic_spnoad_HUM_1v{i},spnoad_fit_LENA_1v(j,1),aic_spnoad_LENA_1v{j});
[aic_tnoad_LENA_1v{j},tnoad_fit_LENA_1v(j,1),p] = aicnew(LENAnoad_distt_1v{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_tnoad_1v(i,1),param2_sig_alpha_HUM_tnoad_1v{i,1},param1_lam_mu_xmin_LENA_tnoad_1v(j,1),param2_sig_alpha_LENA_tnoad_1v{j,1}] =...
                                                                              LENA_HUMfitparameters(aic_tnoad_HUM_1v{i},tnoad_fit_LENA_1v(j,1),aic_tnoad_LENA_1v{j});
[aic_vnoad_LENA_1v{j},vnoad_fit_LENA_1v(j,1),p] = aicnew(LENAnoad_velsp_1v{j},[0 0 0 0],0) ;
[param1_lam_mu_xmin_HUM_vnoad_1v(i,1),param2_sig_alpha_HUM_vnoad_1v{i,1},param1_lam_mu_xmin_LENA_vnoad_1v(j,1),param2_sig_alpha_LENA_vnoad_1v{j,1}] =...
                                                                              LENA_HUMfitparameters(aic_vnoad_HUM_1v{i},vnoad_fit_LENA_1v(j,1),aic_vnoad_LENA_1v{j});

age_LENA_1v_chvoc(j,1) = str2num(idmat_lena{2});
id_LENA_1v_chvoc{j,1} = idmat_lena{1};
type_LENA_1v_chvoc{j,1} = 'LENA';
listener_LENA_1v_chvoc{j,1} = 'NA';
WR_LENA_1v_chvoc(j,1) = 1;
WOR_LENA_1v_chvoc(j,1) = 0;

end
end
end

age = [age_HUM_1v_chvoc
    age_LENA_1v_chvoc
    age_HUM_1v_chvoc
    age_LENA_1v_chvoc];
id = [id_HUM_1v_chvoc
    id_LENA_1v_chvoc
    id_HUM_1v_chvoc
    id_LENA_1v_chvoc];
type = [type_HUM_1v_chvoc
    type_LENA_1v_chvoc
    type_HUM_1v_chvoc
    type_LENA_1v_chvoc];
listener = [listener_HUM_1v_chvoc
    listener_LENA_1v_chvoc
    listener_HUM_1v_chvoc
    listener_LENA_1v_chvoc];
response = [WR_HUM_1v_chvoc
    WR_LENA_1v_chvoc
    WOR_HUM_1v_chvoc
    WOR_LENA_1v_chvoc];

f_param1 = [param1_lam_mu_xmin_HUM_fad_1v
    param1_lam_mu_xmin_LENA_fad_1v
    param1_lam_mu_xmin_HUM_fnoad_1v
    param1_lam_mu_xmin_LENA_fnoad_1v];
f_param2 = [param2_sig_alpha_HUM_fad_1v
    param2_sig_alpha_LENA_fad_1v
    param2_sig_alpha_HUM_fnoad_1v
    param2_sig_alpha_LENA_fnoad_1v];

d_param1 = [param1_lam_mu_xmin_HUM_dad_1v
    param1_lam_mu_xmin_LENA_dad_1v
    param1_lam_mu_xmin_HUM_dnoad_1v
    param1_lam_mu_xmin_LENA_dnoad_1v];
d_param2 = [param2_sig_alpha_HUM_dad_1v
    param2_sig_alpha_LENA_dad_1v
    param2_sig_alpha_HUM_dnoad_1v
    param2_sig_alpha_LENA_dnoad_1v];

sp_param1 = [param1_lam_mu_xmin_HUM_spad_1v
    param1_lam_mu_xmin_LENA_spad_1v
    param1_lam_mu_xmin_HUM_spnoad_1v
    param1_lam_mu_xmin_LENA_spnoad_1v];
sp_param2 = [param2_sig_alpha_HUM_spad_1v
    param2_sig_alpha_LENA_spad_1v
    param2_sig_alpha_HUM_spnoad_1v
    param2_sig_alpha_LENA_spnoad_1v];

t_param1 = [param1_lam_mu_xmin_HUM_tad_1v
    param1_lam_mu_xmin_LENA_tad_1v
    param1_lam_mu_xmin_HUM_tnoad_1v
    param1_lam_mu_xmin_LENA_tnoad_1v];
t_param2 = [param2_sig_alpha_HUM_tad_1v
    param2_sig_alpha_LENA_tad_1v
    param2_sig_alpha_HUM_tnoad_1v
    param2_sig_alpha_LENA_tnoad_1v];

v_param1 = [param1_lam_mu_xmin_HUM_vad_1v
    param1_lam_mu_xmin_LENA_vad_1v
    param1_lam_mu_xmin_HUM_vnoad_1v
    param1_lam_mu_xmin_LENA_vnoad_1v];
v_param2 = [param2_sig_alpha_HUM_vad_1v
    param2_sig_alpha_LENA_vad_1v
    param2_sig_alpha_HUM_vnoad_1v
    param2_sig_alpha_LENA_vnoad_1v];

f_fittype = [fad_fit_HUM_1v
    fad_fit_LENA_1v
    fnoad_fit_HUM_1v
    fnoad_fit_LENA_1v];

d_fittype = [dad_fit_HUM_1v
    dad_fit_LENA_1v
    dnoad_fit_HUM_1v
    dnoad_fit_LENA_1v];

sp_fittype = [spad_fit_HUM_1v
    spad_fit_LENA_1v
    spnoad_fit_HUM_1v
    spnoad_fit_LENA_1v];

t_fittype = [tad_fit_HUM_1v
    tad_fit_LENA_1v
    tnoad_fit_HUM_1v
    tnoad_fit_LENA_1v];

v_fittype = [vad_fit_HUM_1v
    vad_fit_LENA_1v
    vnoad_fit_HUM_1v
    vnoad_fit_LENA_1v];

T = table(age,id,type,listener,response,f_fittype,f_param1,f_param2,d_fittype,d_param1,d_param2,...
    sp_fittype,sp_param1,sp_param2,t_fittype,t_param1,t_param2,v_fittype,v_param1,v_param2);
writetable(T,'HUM_LENA_fitparameters_adresp2ch_1V.csv')

clear all
clc

clear all
clc

%for child repsonses to adult vocalisations, TW
load('chresp2ad_stepsizes_tw_humlab.mat')

for i = 1:length(HUM_idage_tw) 
idmat_hum = strsplit(HUM_idage_tw{i},'_');

[aic_fch_HUM_tw{i},fch_fit_HUM_tw(i,1),p] = aicnew(HUMch_distf_tw{i},[0 0 0 0],0) ;  
[aic_dch_HUM_tw{i},dch_fit_HUM_tw(i,1),p] = aicnew(HUMch_distd_tw{i},[0 0 0 0],0) ; 
[aic_spch_HUM_tw{i},spch_fit_HUM_tw(i,1),p] = aicnew(HUMch_distsp_tw{i},[0 0 0 0],0) ;  
[aic_tch_HUM_tw{i},tch_fit_HUM_tw(i,1),p] = aicnew(HUMch_distt_tw{i},[0 0 0 0],0) ; 
[aic_vch_HUM_tw{i},vch_fit_HUM_tw(i,1),p] = aicnew(HUMch_velsp_tw{i},[0 0 0 0],0) ; 

[aic_fnoch_HUM_tw{i},fnoch_fit_HUM_tw(i,1),p] = aicnew(HUMnoch_distf_tw{i},[0 0 0 0],0) ;  
[aic_dnoch_HUM_tw{i},dnoch_fit_HUM_tw(i,1),p] = aicnew(HUMnoch_distd_tw{i},[0 0 0 0],0) ; 
[aic_spnoch_HUM_tw{i},spnoch_fit_HUM_tw(i,1),p] = aicnew(HUMnoch_distsp_tw{i},[0 0 0 0],0) ;  
[aic_tnoch_HUM_tw{i},tnoch_fit_HUM_tw(i,1),p] = aicnew(HUMnoch_distt_tw{i},[0 0 0 0],0) ; 
[aic_vnoch_HUM_tw{i},vnoch_fit_HUM_tw(i,1),p] = aicnew(HUMnoch_velsp_tw{i},[0 0 0 0],0) ;

age_HUM_tw_chvoc(i,1) = str2num(idmat_hum{2});
id_HUM_tw_chvoc{i,1} = idmat_hum{1};
listener_HUM_tw_chvoc{i,1} = idmat_hum{3};
type_HUM_tw_chvoc{i,1} = 'HUM';
WR_HUM_tw_chvoc(i,1) = 1;
WOR_HUM_tw_chvoc(i,1) = 0;

for j = 1:length(LENA_idage_tw)
idmat_lena = strsplit(LENA_idage_tw{j},'_');
if (strcmp(idmat_lena{1},idmat_hum{1}) == 1) && (strcmp(idmat_lena{2},idmat_hum{2}) == 1) %matches child age and id for LENA and HUM label
    
[aic_fch_LENA_tw{j},fch_fit_LENA_tw(j,1),p] = aicnew(LENAch_distf_tw{j},[0 0 0 0],0) ;  
[param1_lam_mu_xmin_HUM_fch_tw(i,1),param2_sig_alpha_HUM_fch_tw{i,1},param1_lam_mu_xmin_LENA_fch_tw(j,1),param2_sig_alpha_LENA_fch_tw{j,1}] =...
                                                                                    LENA_HUMfitparameters(aic_fch_HUM_tw{i},fch_fit_LENA_tw(j,1),aic_fch_LENA_tw{j});
[aic_dch_LENA_tw{j},dch_fit_LENA_tw(j,1),p] = aicnew(LENAch_distd_tw{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_dch_tw(i,1),param2_sig_alpha_HUM_dch_tw{i,1},param1_lam_mu_xmin_LENA_dch_tw(j,1),param2_sig_alpha_LENA_dch_tw{j,1}] =...
                                                                                    LENA_HUMfitparameters(aic_dch_HUM_tw{i},dch_fit_LENA_tw(j,1),aic_dch_LENA_tw{j});
[aic_spch_LENA_tw{j},spch_fit_LENA_tw(j,1),p] = aicnew(LENAch_distsp_tw{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_spch_tw(i,1),param2_sig_alpha_HUM_spch_tw{i,1},param1_lam_mu_xmin_LENA_spch_tw(j,1),param2_sig_alpha_LENA_spch_tw{j,1}] =...
                                                                                 LENA_HUMfitparameters(aic_spch_HUM_tw{i},spch_fit_LENA_tw(j,1),aic_spch_LENA_tw{j});
[aic_tch_LENA_tw{j},tch_fit_LENA_tw(j,1),p] = aicnew(LENAch_distt_tw{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_tch_tw(i,1),param2_sig_alpha_HUM_tch_tw{i,1},param1_lam_mu_xmin_LENA_tch_tw(j,1),param2_sig_alpha_LENA_tch_tw{j,1}] =...
                                                                                    LENA_HUMfitparameters(aic_tch_HUM_tw{i},tch_fit_LENA_tw(j,1),aic_tch_LENA_tw{j});
[aic_vch_LENA_tw{j},vch_fit_LENA_tw(j,1),p] = aicnew(LENAch_velsp_tw{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_vch_tw(i,1),param2_sig_alpha_HUM_vch_tw{i,1},param1_lam_mu_xmin_LENA_vch_tw(j,1),param2_sig_alpha_LENA_vch_tw{j,1}] =...
                                                                                    LENA_HUMfitparameters(aic_vch_HUM_tw{i},vch_fit_LENA_tw(j,1),aic_vch_LENA_tw{j});

                                                                                
[aic_fnoch_LENA_tw{j},fnoch_fit_LENA_tw(j,1),p] = aicnew(LENAnoch_distf_tw{j},[0 0 0 0],0) ;
[param1_lam_mu_xmin_HUM_fnoch_tw(i,1),param2_sig_alpha_HUM_fnoch_tw{i,1},param1_lam_mu_xmin_LENA_fnoch_tw(j,1),param2_sig_alpha_LENA_fnoch_tw{j,1}] =...
                                                                               LENA_HUMfitparameters(aic_fnoch_HUM_tw{i},fnoch_fit_LENA_tw(j,1),aic_fnoch_LENA_tw{j});
[aic_dnoch_LENA_tw{j},dnoch_fit_LENA_tw(j,1),p] = aicnew(LENAnoch_distd_tw{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_dnoch_tw(i,1),param2_sig_alpha_HUM_dnoch_tw{i,1},param1_lam_mu_xmin_LENA_dnoch_tw(j,1),param2_sig_alpha_LENA_dnoch_tw{j,1}] =...
                                                                               LENA_HUMfitparameters(aic_dnoch_HUM_tw{i},dnoch_fit_LENA_tw(j,1),aic_dnoch_LENA_tw{j});
[aic_spnoch_LENA_tw{j},spnoch_fit_LENA_tw(j,1),p] = aicnew(LENAnoch_distsp_tw{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_spnoch_tw(i,1),param2_sig_alpha_HUM_spnoch_tw{i,1},param1_lam_mu_xmin_LENA_spnoch_tw(j,1),param2_sig_alpha_LENA_spnoch_tw{j,1}] =...
                                                                           LENA_HUMfitparameters(aic_spnoch_HUM_tw{i},spnoch_fit_LENA_tw(j,1),aic_spnoch_LENA_tw{j});
[aic_tnoch_LENA_tw{j},tnoch_fit_LENA_tw(j,1),p] = aicnew(LENAnoch_distt_tw{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_tnoch_tw(i,1),param2_sig_alpha_HUM_tnoch_tw{i,1},param1_lam_mu_xmin_LENA_tnoch_tw(j,1),param2_sig_alpha_LENA_tnoch_tw{j,1}] =...
                                                                              LENA_HUMfitparameters(aic_tnoch_HUM_tw{i},tnoch_fit_LENA_tw(j,1),aic_tnoch_LENA_tw{j});
[aic_vnoch_LENA_tw{j},vnoch_fit_LENA_tw(j,1),p] = aicnew(LENAnoch_velsp_tw{j},[0 0 0 0],0) ;
[param1_lam_mu_xmin_HUM_vnoch_tw(i,1),param2_sig_alpha_HUM_vnoch_tw{i,1},param1_lam_mu_xmin_LENA_vnoch_tw(j,1),param2_sig_alpha_LENA_vnoch_tw{j,1}] =...
                                                                              LENA_HUMfitparameters(aic_vnoch_HUM_tw{i},vnoch_fit_LENA_tw(j,1),aic_vnoch_LENA_tw{j});

age_LENA_tw_chvoc(j,1) = str2num(idmat_lena{2});
id_LENA_tw_chvoc{j,1} = idmat_lena{1};
type_LENA_tw_chvoc{j,1} = 'LENA';
listener_LENA_tw_chvoc{j,1} = 'NA';
WR_LENA_tw_chvoc(j,1) = 1;
WOR_LENA_tw_chvoc(j,1) = 0;

end
end
end

age = [age_HUM_tw_chvoc
    age_LENA_tw_chvoc
    age_HUM_tw_chvoc
    age_LENA_tw_chvoc];
id = [id_HUM_tw_chvoc
    id_LENA_tw_chvoc
    id_HUM_tw_chvoc
    id_LENA_tw_chvoc];
type = [type_HUM_tw_chvoc
    type_LENA_tw_chvoc
    type_HUM_tw_chvoc
    type_LENA_tw_chvoc];
listener = [listener_HUM_tw_chvoc
    listener_LENA_tw_chvoc
    listener_HUM_tw_chvoc
    listener_LENA_tw_chvoc];
response = [WR_HUM_tw_chvoc
    WR_LENA_tw_chvoc
    WOR_HUM_tw_chvoc
    WOR_LENA_tw_chvoc];

f_param1 = [param1_lam_mu_xmin_HUM_fch_tw
    param1_lam_mu_xmin_LENA_fch_tw
    param1_lam_mu_xmin_HUM_fnoch_tw
    param1_lam_mu_xmin_LENA_fnoch_tw];
f_param2 = [param2_sig_alpha_HUM_fch_tw
    param2_sig_alpha_LENA_fch_tw
    param2_sig_alpha_HUM_fnoch_tw
    param2_sig_alpha_LENA_fnoch_tw];

d_param1 = [param1_lam_mu_xmin_HUM_dch_tw
    param1_lam_mu_xmin_LENA_dch_tw
    param1_lam_mu_xmin_HUM_dnoch_tw
    param1_lam_mu_xmin_LENA_dnoch_tw];
d_param2 = [param2_sig_alpha_HUM_dch_tw
    param2_sig_alpha_LENA_dch_tw
    param2_sig_alpha_HUM_dnoch_tw
    param2_sig_alpha_LENA_dnoch_tw];

sp_param1 = [param1_lam_mu_xmin_HUM_spch_tw
    param1_lam_mu_xmin_LENA_spch_tw
    param1_lam_mu_xmin_HUM_spnoch_tw
    param1_lam_mu_xmin_LENA_spnoch_tw];
sp_param2 = [param2_sig_alpha_HUM_spch_tw
    param2_sig_alpha_LENA_spch_tw
    param2_sig_alpha_HUM_spnoch_tw
    param2_sig_alpha_LENA_spnoch_tw];

t_param1 = [param1_lam_mu_xmin_HUM_tch_tw
    param1_lam_mu_xmin_LENA_tch_tw
    param1_lam_mu_xmin_HUM_tnoch_tw
    param1_lam_mu_xmin_LENA_tnoch_tw];
t_param2 = [param2_sig_alpha_HUM_tch_tw
    param2_sig_alpha_LENA_tch_tw
    param2_sig_alpha_HUM_tnoch_tw
    param2_sig_alpha_LENA_tnoch_tw];

v_param1 = [param1_lam_mu_xmin_HUM_vch_tw
    param1_lam_mu_xmin_LENA_vch_tw
    param1_lam_mu_xmin_HUM_vnoch_tw
    param1_lam_mu_xmin_LENA_vnoch_tw];
v_param2 = [param2_sig_alpha_HUM_vch_tw
    param2_sig_alpha_LENA_vch_tw
    param2_sig_alpha_HUM_vnoch_tw
    param2_sig_alpha_LENA_vnoch_tw];

f_fittype = [fch_fit_HUM_tw
    fch_fit_LENA_tw
    fnoch_fit_HUM_tw
    fnoch_fit_LENA_tw];

d_fittype = [dch_fit_HUM_tw
    dch_fit_LENA_tw
    dnoch_fit_HUM_tw
    dnoch_fit_LENA_tw];

sp_fittype = [spch_fit_HUM_tw
    spch_fit_LENA_tw
    spnoch_fit_HUM_tw
    spnoch_fit_LENA_tw];

t_fittype = [tch_fit_HUM_tw
    tch_fit_LENA_tw
    tnoch_fit_HUM_tw
    tnoch_fit_LENA_tw];

v_fittype = [vch_fit_HUM_tw
    vch_fit_LENA_tw
    vnoch_fit_HUM_tw
    vnoch_fit_LENA_tw];

T = table(age,id,type,listener,response,f_fittype,f_param1,f_param2,d_fittype,d_param1,d_param2,...
    sp_fittype,sp_param1,sp_param2,t_fittype,t_param1,t_param2,v_fittype,v_param1,v_param2);
writetable(T,'HUM_LENA_fitparameters_chresp2ad_TW.csv')

clear all
clc

%child repsonses to adult vocalistaions, subseuqent voc only
load('chresp2ad_stepsizes_1v_humlab.mat')

for i = 1:length(HUM_idage_1v) 
idmat_hum = strsplit(HUM_idage_1v{i},'_');

[aic_fch_HUM_1v{i},fch_fit_HUM_1v(i,1),p] = aicnew(HUMch_distf_1v{i},[0 0 0 0],0) ;  
[aic_dch_HUM_1v{i},dch_fit_HUM_1v(i,1),p] = aicnew(HUMch_distd_1v{i},[0 0 0 0],0) ; 
[aic_spch_HUM_1v{i},spch_fit_HUM_1v(i,1),p] = aicnew(HUMch_distsp_1v{i},[0 0 0 0],0) ;  
[aic_tch_HUM_1v{i},tch_fit_HUM_1v(i,1),p] = aicnew(HUMch_distt_1v{i},[0 0 0 0],0) ; 
[aic_vch_HUM_1v{i},vch_fit_HUM_1v(i,1),p] = aicnew(HUMch_velsp_1v{i},[0 0 0 0],0) ; 

[aic_fnoch_HUM_1v{i},fnoch_fit_HUM_1v(i,1),p] = aicnew(HUMnoch_distf_1v{i},[0 0 0 0],0) ;  
[aic_dnoch_HUM_1v{i},dnoch_fit_HUM_1v(i,1),p] = aicnew(HUMnoch_distd_1v{i},[0 0 0 0],0) ; 
[aic_spnoch_HUM_1v{i},spnoch_fit_HUM_1v(i,1),p] = aicnew(HUMnoch_distsp_1v{i},[0 0 0 0],0) ;  
[aic_tnoch_HUM_1v{i},tnoch_fit_HUM_1v(i,1),p] = aicnew(HUMnoch_distt_1v{i},[0 0 0 0],0) ; 
[aic_vnoch_HUM_1v{i},vnoch_fit_HUM_1v(i,1),p] = aicnew(HUMnoch_velsp_1v{i},[0 0 0 0],0) ;

age_HUM_1v_chvoc(i,1) = str2num(idmat_hum{2});
id_HUM_1v_chvoc{i,1} = idmat_hum{1};
listener_HUM_1v_chvoc{i,1} = idmat_hum{3};
type_HUM_1v_chvoc{i,1} = 'HUM';
WR_HUM_1v_chvoc(i,1) = 1;
WOR_HUM_1v_chvoc(i,1) = 0;

for j = 1:length(LENA_idage_1v)
idmat_lena = strsplit(LENA_idage_1v{j},'_');
if (strcmp(idmat_lena{1},idmat_hum{1}) == 1) && (strcmp(idmat_lena{2},idmat_hum{2}) == 1) %matches child age and id for LENA and HUM label
    
[aic_fch_LENA_1v{j},fch_fit_LENA_1v(j,1),p] = aicnew(LENAch_distf_1v{j},[0 0 0 0],0) ;  
[param1_lam_mu_xmin_HUM_fch_1v(i,1),param2_sig_alpha_HUM_fch_1v{i,1},param1_lam_mu_xmin_LENA_fch_1v(j,1),param2_sig_alpha_LENA_fch_1v{j,1}] =...
                                                                                    LENA_HUMfitparameters(aic_fch_HUM_1v{i},fch_fit_LENA_1v(j,1),aic_fch_LENA_1v{j});
[aic_dch_LENA_1v{j},dch_fit_LENA_1v(j,1),p] = aicnew(LENAch_distd_1v{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_dch_1v(i,1),param2_sig_alpha_HUM_dch_1v{i,1},param1_lam_mu_xmin_LENA_dch_1v(j,1),param2_sig_alpha_LENA_dch_1v{j,1}] =...
                                                                                    LENA_HUMfitparameters(aic_dch_HUM_1v{i},dch_fit_LENA_1v(j,1),aic_dch_LENA_1v{j});
[aic_spch_LENA_1v{j},spch_fit_LENA_1v(j,1),p] = aicnew(LENAch_distsp_1v{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_spch_1v(i,1),param2_sig_alpha_HUM_spch_1v{i,1},param1_lam_mu_xmin_LENA_spch_1v(j,1),param2_sig_alpha_LENA_spch_1v{j,1}] =...
                                                                                 LENA_HUMfitparameters(aic_spch_HUM_1v{i},spch_fit_LENA_1v(j,1),aic_spch_LENA_1v{j});
[aic_tch_LENA_1v{j},tch_fit_LENA_1v(j,1),p] = aicnew(LENAch_distt_1v{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_tch_1v(i,1),param2_sig_alpha_HUM_tch_1v{i,1},param1_lam_mu_xmin_LENA_tch_1v(j,1),param2_sig_alpha_LENA_tch_1v{j,1}] =...
                                                                                    LENA_HUMfitparameters(aic_tch_HUM_1v{i},tch_fit_LENA_1v(j,1),aic_tch_LENA_1v{j});
[aic_vch_LENA_1v{j},vch_fit_LENA_1v(j,1),p] = aicnew(LENAch_velsp_1v{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_vch_1v(i,1),param2_sig_alpha_HUM_vch_1v{i,1},param1_lam_mu_xmin_LENA_vch_1v(j,1),param2_sig_alpha_LENA_vch_1v{j,1}] =...
                                                                                    LENA_HUMfitparameters(aic_vch_HUM_1v{i},vch_fit_LENA_1v(j,1),aic_vch_LENA_1v{j});

                                                                                
[aic_fnoch_LENA_1v{j},fnoch_fit_LENA_1v(j,1),p] = aicnew(LENAnoch_distf_1v{j},[0 0 0 0],0) ;
[param1_lam_mu_xmin_HUM_fnoch_1v(i,1),param2_sig_alpha_HUM_fnoch_1v{i,1},param1_lam_mu_xmin_LENA_fnoch_1v(j,1),param2_sig_alpha_LENA_fnoch_1v{j,1}] =...
                                                                               LENA_HUMfitparameters(aic_fnoch_HUM_1v{i},fnoch_fit_LENA_1v(j,1),aic_fnoch_LENA_1v{j});
[aic_dnoch_LENA_1v{j},dnoch_fit_LENA_1v(j,1),p] = aicnew(LENAnoch_distd_1v{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_dnoch_1v(i,1),param2_sig_alpha_HUM_dnoch_1v{i,1},param1_lam_mu_xmin_LENA_dnoch_1v(j,1),param2_sig_alpha_LENA_dnoch_1v{j,1}] =...
                                                                               LENA_HUMfitparameters(aic_dnoch_HUM_1v{i},dnoch_fit_LENA_1v(j,1),aic_dnoch_LENA_1v{j});
[aic_spnoch_LENA_1v{j},spnoch_fit_LENA_1v(j,1),p] = aicnew(LENAnoch_distsp_1v{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_spnoch_1v(i,1),param2_sig_alpha_HUM_spnoch_1v{i,1},param1_lam_mu_xmin_LENA_spnoch_1v(j,1),param2_sig_alpha_LENA_spnoch_1v{j,1}] =...
                                                                           LENA_HUMfitparameters(aic_spnoch_HUM_1v{i},spnoch_fit_LENA_1v(j,1),aic_spnoch_LENA_1v{j});
[aic_tnoch_LENA_1v{j},tnoch_fit_LENA_1v(j,1),p] = aicnew(LENAnoch_distt_1v{j},[0 0 0 0],0) ; 
[param1_lam_mu_xmin_HUM_tnoch_1v(i,1),param2_sig_alpha_HUM_tnoch_1v{i,1},param1_lam_mu_xmin_LENA_tnoch_1v(j,1),param2_sig_alpha_LENA_tnoch_1v{j,1}] =...
                                                                              LENA_HUMfitparameters(aic_tnoch_HUM_1v{i},tnoch_fit_LENA_1v(j,1),aic_tnoch_LENA_1v{j});
[aic_vnoch_LENA_1v{j},vnoch_fit_LENA_1v(j,1),p] = aicnew(LENAnoch_velsp_1v{j},[0 0 0 0],0) ;
[param1_lam_mu_xmin_HUM_vnoch_1v(i,1),param2_sig_alpha_HUM_vnoch_1v{i,1},param1_lam_mu_xmin_LENA_vnoch_1v(j,1),param2_sig_alpha_LENA_vnoch_1v{j,1}] =...
                                                                              LENA_HUMfitparameters(aic_vnoch_HUM_1v{i},vnoch_fit_LENA_1v(j,1),aic_vnoch_LENA_1v{j});

age_LENA_1v_chvoc(j,1) = str2num(idmat_lena{2});
id_LENA_1v_chvoc{j,1} = idmat_lena{1};
type_LENA_1v_chvoc{j,1} = 'LENA';
listener_LENA_1v_chvoc{j,1} = 'NA';
WR_LENA_1v_chvoc(j,1) = 1;
WOR_LENA_1v_chvoc(j,1) = 0;

end
end
end

age = [age_HUM_1v_chvoc
    age_LENA_1v_chvoc
    age_HUM_1v_chvoc
    age_LENA_1v_chvoc];
id = [id_HUM_1v_chvoc
    id_LENA_1v_chvoc
    id_HUM_1v_chvoc
    id_LENA_1v_chvoc];
type = [type_HUM_1v_chvoc
    type_LENA_1v_chvoc
    type_HUM_1v_chvoc
    type_LENA_1v_chvoc];
listener = [listener_HUM_1v_chvoc
    listener_LENA_1v_chvoc
    listener_HUM_1v_chvoc
    listener_LENA_1v_chvoc];
response = [WR_HUM_1v_chvoc
    WR_LENA_1v_chvoc
    WOR_HUM_1v_chvoc
    WOR_LENA_1v_chvoc];

f_param1 = [param1_lam_mu_xmin_HUM_fch_1v
    param1_lam_mu_xmin_LENA_fch_1v
    param1_lam_mu_xmin_HUM_fnoch_1v
    param1_lam_mu_xmin_LENA_fnoch_1v];
f_param2 = [param2_sig_alpha_HUM_fch_1v
    param2_sig_alpha_LENA_fch_1v
    param2_sig_alpha_HUM_fnoch_1v
    param2_sig_alpha_LENA_fnoch_1v];

d_param1 = [param1_lam_mu_xmin_HUM_dch_1v
    param1_lam_mu_xmin_LENA_dch_1v
    param1_lam_mu_xmin_HUM_dnoch_1v
    param1_lam_mu_xmin_LENA_dnoch_1v];
d_param2 = [param2_sig_alpha_HUM_dch_1v
    param2_sig_alpha_LENA_dch_1v
    param2_sig_alpha_HUM_dnoch_1v
    param2_sig_alpha_LENA_dnoch_1v];

sp_param1 = [param1_lam_mu_xmin_HUM_spch_1v
    param1_lam_mu_xmin_LENA_spch_1v
    param1_lam_mu_xmin_HUM_spnoch_1v
    param1_lam_mu_xmin_LENA_spnoch_1v];
sp_param2 = [param2_sig_alpha_HUM_spch_1v
    param2_sig_alpha_LENA_spch_1v
    param2_sig_alpha_HUM_spnoch_1v
    param2_sig_alpha_LENA_spnoch_1v];

t_param1 = [param1_lam_mu_xmin_HUM_tch_1v
    param1_lam_mu_xmin_LENA_tch_1v
    param1_lam_mu_xmin_HUM_tnoch_1v
    param1_lam_mu_xmin_LENA_tnoch_1v];
t_param2 = [param2_sig_alpha_HUM_tch_1v
    param2_sig_alpha_LENA_tch_1v
    param2_sig_alpha_HUM_tnoch_1v
    param2_sig_alpha_LENA_tnoch_1v];

v_param1 = [param1_lam_mu_xmin_HUM_vch_1v
    param1_lam_mu_xmin_LENA_vch_1v
    param1_lam_mu_xmin_HUM_vnoch_1v
    param1_lam_mu_xmin_LENA_vnoch_1v];
v_param2 = [param2_sig_alpha_HUM_vch_1v
    param2_sig_alpha_LENA_vch_1v
    param2_sig_alpha_HUM_vnoch_1v
    param2_sig_alpha_LENA_vnoch_1v];

f_fittype = [fch_fit_HUM_1v
    fch_fit_LENA_1v
    fnoch_fit_HUM_1v
    fnoch_fit_LENA_1v];

d_fittype = [dch_fit_HUM_1v
    dch_fit_LENA_1v
    dnoch_fit_HUM_1v
    dnoch_fit_LENA_1v];

sp_fittype = [spch_fit_HUM_1v
    spch_fit_LENA_1v
    spnoch_fit_HUM_1v
    spnoch_fit_LENA_1v];

t_fittype = [tch_fit_HUM_1v
    tch_fit_LENA_1v
    tnoch_fit_HUM_1v
    tnoch_fit_LENA_1v];

v_fittype = [vch_fit_HUM_1v
    vch_fit_LENA_1v
    vnoch_fit_HUM_1v
    vnoch_fit_LENA_1v];

T = table(age,id,type,listener,response,f_fittype,f_param1,f_param2,d_fittype,d_param1,d_param2,...
    sp_fittype,sp_param1,sp_param2,t_fittype,t_param1,t_param2,v_fittype,v_param1,v_param2);
writetable(T,'HUM_LENA_fitparameters_chresp2ad_1V.csv')


%all LENA f, d - exp
%LENA velocity tw chvoc WR (vad_fit_LENA_tw) - exponential
%LENA velocity all other chvoc - lognormal
%LENA velocity advoc - exponential (except vnoch_fit_LENA_tw 274-82 is lognormal)
%all LENA Space - lognormal


%%frechet distance
% load('adresp2ch_stepsizes_timwin_humlab.mat')
% 
% for i = 1:length(HUM_idage_tw) 
% idmat_hum = strsplit(HUM_idage_tw{i},'_');
% for j = 1:length(LENA_idage_tw)
% idmat_lena = strsplit(LENA_idage_tw{j},'_');
% if (strcmp(idmat_lena{1},idmat_hum{1}) == 1) && (strcmp(idmat_lena{2},idmat_hum{2}) == 1) %matches child age and id for LENA and HUM label
%     
% [xaxis_LENAad,yaxis_fit,yaxis_dat_LENAad] = aicplots(LENAad_distf_tw{j},[1 0 0 0],0);
% yaxis_dat_LENAad = yaxis_dat_LENAad/trapz(xaxis_LENAad,yaxis_dat_LENAad);
% [xaxis_HUMad,yaxis_fit,yaxis_dat_HUMad] = aicplots(HUMad_distf_tw{i},[1 0 0 0],0); %gets data for bestfit
% yaxis_dat_HUMad = yaxis_dat_HUMad/trapz(xaxis_HUMad,yaxis_dat_HUMad);
% [cm_fadr_tw(i), cSq] = DiscreteFrechetDist([transpose(xaxis_LENAad) transpose(yaxis_dat_LENAad)],[transpose(xaxis_HUMad) transpose(yaxis_dat_HUMad)]);
% 
% [xaxis_LENAad,yaxis_fit,yaxis_dat_LENAad] = aicplots(LENAad_distd_tw{j},[1 0 0 0],0);
% yaxis_dat_LENAad = yaxis_dat_LENAad/trapz(xaxis_LENAad,yaxis_dat_LENAad);
% [xaxis_HUMad,yaxis_fit,yaxis_dat_HUMad] = aicplots(HUMad_distd_tw{i},[1 0 0 0],0); %gets data for bestfit
% yaxis_dat_HUMad = yaxis_dat_HUMad/trapz(xaxis_HUMad,yaxis_dat_HUMad);
% [cm_dadr_tw(i), cSq] = DiscreteFrechetDist([transpose(xaxis_LENAad) transpose(yaxis_dat_LENAad)],[transpose(xaxis_HUMad) transpose(yaxis_dat_HUMad)]);
% 
% [xaxis_LENAad,yaxis_fit,yaxis_dat_LENAad] = aicplots(LENAad_distsp_tw{j},[1 0 0 0],0);
% yaxis_dat_LENAad = yaxis_dat_LENAad/trapz(xaxis_LENAad,yaxis_dat_LENAad);
% [xaxis_HUMad,yaxis_fit,yaxis_dat_HUMad] = aicplots(HUMad_distsp_tw{i},[1 0 0 0],0); %gets data for bestfit
% yaxis_dat_HUMad = yaxis_dat_HUMad/trapz(xaxis_HUMad,yaxis_dat_HUMad);
% [cm_spadr_tw(i), cSq] = DiscreteFrechetDist([transpose(xaxis_LENAad) transpose(yaxis_dat_LENAad)],[transpose(xaxis_HUMad) transpose(yaxis_dat_HUMad)]);
% 
% [xaxis_LENAad,yaxis_fit,yaxis_dat_LENAad] = aicplots(LENAad_distt_tw{j},[1 0 0 0],0);
% yaxis_dat_LENAad = yaxis_dat_LENAad/trapz(xaxis_LENAad,yaxis_dat_LENAad);
% [xaxis_HUMad,yaxis_fit,yaxis_dat_HUMad] = aicplots(HUMad_distt_tw{i},[1 0 0 0],0); %gets data for bestfit
% yaxis_dat_HUMad = yaxis_dat_HUMad/trapz(xaxis_HUMad,yaxis_dat_HUMad);
% [cm_tadr_tw(i), cSq] = DiscreteFrechetDist([transpose(xaxis_LENAad) transpose(yaxis_dat_LENAad)],[transpose(xaxis_HUMad) transpose(yaxis_dat_HUMad)]);
% 
% [xaxis_LENAad,yaxis_fit,yaxis_dat_LENAad] = aicplots(LENAad_velsp_tw{j},[1 0 0 0],0);
% yaxis_dat_LENAad = yaxis_dat_LENAad/trapz(xaxis_LENAad,yaxis_dat_LENAad);
% [xaxis_HUMad,yaxis_fit,yaxis_dat_HUMad] = aicplots(HUMad_velsp_tw{i},[1 0 0 0],0); %gets data for bestfit
% yaxis_dat_HUMad = yaxis_dat_HUMad/trapz(xaxis_HUMad,yaxis_dat_HUMad);
% [cm_vadr_tw(i), cSq] = DiscreteFrechetDist([transpose(xaxis_LENAad) transpose(yaxis_dat_LENAad)],[transpose(xaxis_HUMad) transpose(yaxis_dat_HUMad)]);
% 
% end
% end
% end