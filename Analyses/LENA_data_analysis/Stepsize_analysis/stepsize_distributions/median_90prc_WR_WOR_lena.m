clear all
clc

%ritwika VPS< UC MERCED
%finding median and 90th percentile of distributions (WR and WOR) for LENA data

%note that these measures are based on the raw data and not
%the fitted distributions

%----------------------------------------------
%median
%------------------------------------------
load('adresp2ch_stepsizes.mat') %adultresponses to child, 

[median_sp,median_d,median_f,median_t,age,id,withad,samplesi] = median_fn(distsp_ad_day,distsp_noad_day,distd_ad_day,distd_noad_day,distf_ad_day,...
                                                                distf_noad_day,disttim_ad_day,disttim_noad_day,id_age);

T = table(median_sp,median_f,median_t,median_d,age,id,withad,samplesi);                                                            
writetable(T,'median_adresp2ch.csv')

clear all

%----------------------------------------------
clear all
load('chresp2ad_stepsizes.mat') %child responses to adult,

[median_sp,median_d,median_f,median_t,age,id,withch,samplesi] = median_fn(distsp_ch_day,distsp_noch_day,distd_ch_day,distd_noch_day,distf_ch_day,...
                                                                distf_noch_day,disttim_ch_day,disttim_noch_day,id_age);

T = table(median_sp,median_f,median_t,median_d,age,id,withch,samplesi);                                                            
writetable(T,'median_chresp2ad.csv')
%----------------------------------------------

%----------------------------------------------
%90th percentile
%------------------------------------------

load('adresp2ch_stepsizes.mat') %adultresponses to child, 

[prctile90_sp,prctile90_d,prctile90_f,prctile90_t,age,id,withad,samplesi] = prctile90_fn(distsp_ad_day,distsp_noad_day,distd_ad_day,distd_noad_day,distf_ad_day,...
                                                                distf_noad_day,disttim_ad_day,disttim_noad_day,id_age);

T = table(prctile90_sp,prctile90_f,prctile90_t,prctile90_d,age,id,withad,samplesi);                                                            
writetable(T,'prctile90_adresp2ch.csv')

clear all
 
%----------------------------------------------
clear all
load('chresp2ad_stepsizes.mat') %child responses to adult, 

[prctile90_sp,prctile90_d,prctile90_f,prctile90_t,age,id,withch,samplesi] = prctile90_fn(distsp_ch_day,distsp_noch_day,distd_ch_day,distd_noch_day,distf_ch_day,...
                                                                distf_noch_day,disttim_ch_day,disttim_noch_day,id_age);

T = table(prctile90_sp,prctile90_f,prctile90_t,prctile90_d,age,id,withch,samplesi);                                                            
writetable(T,'prctile90_chresp2ad.csv')


%----------------------------------------------
