clear all
clc

%ritwika VPS< UC MERCED
%finding median of distributions for LENA data

load('adresp2ch_arearest_stepsizes.mat') %adultresponses to child, subsequent vocalisations

[median_sp,median_d,median_f,median_t,median_vsp,age,id,withad,samplesi] = median_fn(distsp_ad_day,distsp_noad_day,distd_ad_day,distd_noad_day,distf_ad_day,...
                                                                distf_noad_day,disttim_ad_day,disttim_noad_day,velsp_ad_day,velsp_noad_day,id_age);

T = table(median_sp,median_f,median_t,median_d,median_vsp,age,id,withad,samplesi);                                                            
writetable(T,'median_adresp2ch_1v.csv')

clear all

%----------------------------------------------
load('adresp2ch_timewin_stepsizes.mat') %adultresponses to child, time window

[median_sp,median_d,median_f,median_t,median_vsp,age,id,withad,samplesi] = median_fn(distsp_ad_day,distsp_noad_day,distd_ad_day,distd_noad_day,distf_ad_day,...
                                                                distf_noad_day,disttim_ad_day,disttim_noad_day,velsp_ad_day,velsp_noad_day,id_age);

T = table(median_sp,median_f,median_t,median_d,median_vsp,age,id,withad,samplesi); 
writetable(T,'median_adresp2ch_tw.csv') 


%----------------------------------------------
clear all
load('chresp2ad_arearest_stepsizes.mat') %child responses to adult, subsequent voc only

[median_sp,median_d,median_f,median_t,median_vsp,age,id,withch,samplesi] = median_fn(distsp_ch_day,distsp_noch_day,distd_ch_day,distd_noch_day,distf_ch_day,...
                                                                distf_noch_day,disttim_ch_day,disttim_noch_day,velsp_ch_day,velsp_noch_day,id_age);

T = table(median_sp,median_f,median_t,median_d,median_vsp,age,id,withch,samplesi);                                                            
writetable(T,'median_chresp2ad_1v.csv')


%----------------------------------------------
clear all 
load('chresp2ad_timewin_stepsizes.mat') %child responses to adult, time window

[median_sp,median_d,median_f,median_t,median_vsp,age,id,withch,samplesi] = median_fn(distsp_ch_day,distsp_noch_day,distd_ch_day,distd_noch_day,distf_ch_day,...
                                                                distf_noch_day,disttim_ch_day,disttim_noch_day,velsp_ch_day,velsp_noch_day,id_age);

T = table(median_sp,median_f,median_t,median_d,median_vsp,age,id,withch,samplesi);                                                            
writetable(T,'median_chresp2ad_tw.csv')