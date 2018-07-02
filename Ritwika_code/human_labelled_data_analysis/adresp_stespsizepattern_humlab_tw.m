%Ritwika UC Merced
%IVFCR
%Human labelled data and corresponding LENA data - step sizes for child
%vocalisations wrt adult responses - find step sizes for child
%vocalisations wrt adult responses and sort into inthe viciinity of
%response, and away from response, per the 1V scheme

clear all
clc
%An attempt to find patterns in step sizes with and without adult responses

%AIC: 1 normal, 2 lognormal, 3 exponential, 4 pareto
load('humanlab_chdat.mat')
load('adresp2ch_timewin_stepsizes.mat')

%find LENA datsets that match human labelled datasets
%first, we concatenate age and id and listenerid
for i = 1:length(childid)  
    id_age_hum{i} = sprintf('%s_%d',childid{i},chage(i));
end 
%pick out unique combinations
id_age_hum = unique(id_age_hum);

for i = 1:length(id_age_hum)
    for j = 1:length(id_age)
        if (strcmp(id_age_hum{i},id_age{j}) == 1)
            LENAad_distf_tw{i} = distf_ad_day{j};
            LENAnoad_distf_tw{i} = distf_noad_day{j};
            LENAad_distd_tw{i} = distd_ad_day{j};
            LENAnoad_distd_tw{i} = distd_noad_day{j};
            LENAad_distsp_tw{i} = distsp_ad_day{j};
            LENAnoad_distsp_tw{i} = distsp_noad_day{j};
            LENAad_distt_tw{i} = disttim_ad_day{j};
            LENAnoad_distt_tw{i} = disttim_noad_day{j};
            LENAad_velsp_tw{i} = velsp_ad_day{j};
            LENAnoad_velsp_tw{i} = velsp_noad_day{j};
            LENA_idage_tw{i} = id_age{j};
        end
    end
end

%finds distances and groups subrecs from same day and same infant. 15 s timewindow wrt responses and no responses                           
[HUMad_distf_tw,HUMnoad_distf_tw,HUMad_distd_tw,HUMnoad_distd_tw,HUMad_distsp_tw,HUMnoad_distsp_tw,...
    HUMad_distt_tw,HUMnoad_distt_tw,HUMad_velsp_tw,HUMnoad_velsp_tw,HUM_idage_tw] = finddist_andgroup_timewin(chst_humlab,...
                                                              chen_humlab,chdb_humlab,chlogf_humlab,adresponse_humlab,chage,childid,listenerid);
for i = 1:length(HUMnoad_distsp_tw)
     [r,p] = corrcoef(HUMnoad_distsp_tw{i},HUMnoad_distt_tw{i});
     corrltn_noad_HUM(i,1) = r(1,2);
     corrpval_noad_HUM(i,1) = p(1,2);
    
     [r,p] = corrcoef(HUMad_distsp_tw{i},HUMad_distt_tw{i});
     corrltn_ad_HUM(i,1) = r(1,2);
     corrpval_ad_HUM(i,1) = p(1,2);
 
     mmat = strsplit(HUM_idage_tw{i},'_');
     age_hum(i,1) = str2num(mmat{2});
     id_hum(i,1) = str2num(mmat{1});
         
end

for i = 1:length(LENAnoad_distsp_tw)
     [r,p] = corrcoef(LENAnoad_distsp_tw{i},LENAnoad_distt_tw{i});
     corrltn_noad_LENA(i,1) = r(1,2);
     corrpval_noad_LENA(i,1) = p(1,2);
    
     [r,p] = corrcoef(LENAad_distsp_tw{i},LENAad_distt_tw{i});
     corrltn_ad_LENA(i,1) = r(1,2);
     corrpval_ad_LENA(i,1) = p(1,2);  
     
     mmat = strsplit(LENA_idage_tw{i},'_');
     age_lena(i,1) = str2num(mmat{2});
     id_lena(i,1) = str2num(mmat{1});
end

T_hum = table(corrltn_noad_HUM,corrpval_noad_HUM,corrltn_ad_HUM,corrpval_ad_HUM,age_hum,id_hum);
T_lena = table(corrltn_noad_LENA,corrpval_noad_LENA,corrltn_ad_LENA,corrpval_ad_LENA,age_lena,id_lena);

writetable(T_hum,'corrltn_humadresp_tw.csv')
writetable(T_lena,'corrltn_lenaadresp_tw.csv')


save('adresp2ch_stepsizes_timwin_humlab.mat','LENAad_distf_tw','LENAnoad_distf_tw',...
'LENAad_distd_tw','LENAnoad_distd_tw','LENAad_distsp_tw','LENAnoad_distsp_tw','LENAad_distt_tw','LENAnoad_distt_tw',...
'LENAad_velsp_tw','LENAnoad_velsp_tw','LENA_idage_tw','HUMad_distf_tw','HUMnoad_distf_tw','HUMad_distd_tw','HUMnoad_distd_tw',...
'HUMad_distsp_tw','HUMnoad_distsp_tw','HUMad_distt_tw','HUMnoad_distt_tw','HUMad_velsp_tw','HUMnoad_velsp_tw','HUM_idage_tw')






