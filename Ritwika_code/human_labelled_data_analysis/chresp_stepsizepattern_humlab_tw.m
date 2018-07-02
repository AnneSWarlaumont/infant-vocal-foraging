%Ritwika UC Merced
%IVFCR
%Human labelled data and corresponding LENA data - step sizes for adult
%vocalisations wrt childlt responses-  find step sizes for adult
%vocalisations wrt chult responses and sort into inthe viciinity of
%response, and away from response, per the TW scheme

clear all
clc
%An attempt to find patterns in step sizes with and without chult responses

%AIC: 1 normal, 2 lognormal, 3 exponential, 4 pareto

load('humanlab_addat.mat')
load('chresp2ad_timewin_stepsizes.mat')

%find LENA datsets that match human labelled datasets
%first, we concatenate age and id and listenerid
for i = 1:length(childid_ad)  
    id_age_hum{i} = sprintf('%s_%d',childid_ad{i},age_adhumlab(i));
end 
%pick out unique combinations
id_age_hum = unique(id_age_hum);

for i = 1:length(id_age_hum)
    for j = 1:length(id_age)
        if (strcmp(id_age_hum{i},id_age{j}) == 1)
            LENAch_distf_tw{i} = distf_ch_day{j};
            LENAnoch_distf_tw{i} = distf_noch_day{j};
            LENAch_distd_tw{i} = distd_ch_day{j};
            LENAnoch_distd_tw{i} = distd_noch_day{j};
            LENAch_distsp_tw{i} = distsp_ch_day{j};
            LENAnoch_distsp_tw{i} = distsp_noch_day{j};
            LENAch_distt_tw{i} = disttim_ch_day{j};
            LENAnoch_distt_tw{i} = disttim_noch_day{j};
            LENAch_velsp_tw{i} = velsp_ch_day{j};
            LENAnoch_velsp_tw{i} = velsp_noch_day{j};
            LENA_idage_tw{i} = id_age{j};
        end
    end
end

%finds distances and groups subrecs from same day and same infant. Only
%subsequent vocalisation considered.

[HUMch_distf_tw,HUMnoch_distf_tw,HUMch_distd_tw,HUMnoch_distd_tw,HUMch_distsp_tw,HUMnoch_distsp_tw,...
    HUMch_distt_tw,HUMnoch_distt_tw,HUMch_velsp_tw,HUMnoch_velsp_tw,HUM_idage_tw] = finddist_andgroup_timewin(adst_humlab,...
                                                               aden_humlab,addb_humlab,adlogf_humlab,chresp2ad_humlab,age_adhumlab,childid_ad,listenerid_ad);
for i = 1:length(HUMnoch_distsp_tw)
     [r,p] = corrcoef(HUMnoch_distsp_tw{i},HUMnoch_distt_tw{i});
     corrltn_noch_HUM(i,1) = r(1,2);
     corrpval_noch_HUM(i,1) = p(1,2);
    
     [r,p] = corrcoef(HUMch_distsp_tw{i},HUMch_distt_tw{i});
     corrltn_ch_HUM(i,1) = r(1,2);
     corrpval_ch_HUM(i,1) = p(1,2);
 
     mmat = strsplit(HUM_idage_tw{i},'_');
     age_hum(i,1) = str2num(mmat{2});
     id_hum(i,1) = str2num(mmat{1});
         
end

for i = 1:length(LENAnoch_distsp_tw)
     [r,p] = corrcoef(LENAnoch_distsp_tw{i},LENAnoch_distt_tw{i});
     corrltn_noch_LENA(i,1) = r(1,2);
     corrpval_noch_LENA(i,1) = p(1,2);
    
     [r,p] = corrcoef(LENAch_distsp_tw{i},LENAch_distt_tw{i});
     corrltn_ch_LENA(i,1) = r(1,2);
     corrpval_ch_LENA(i,1) = p(1,2);  
     
     mmat = strsplit(LENA_idage_tw{i},'_');
     age_lena(i,1) = str2num(mmat{2});
     id_lena(i,1) = str2num(mmat{1});
end

T_hum = table(corrltn_noch_HUM,corrpval_noch_HUM,corrltn_ch_HUM,corrpval_ch_HUM,age_hum,id_hum);
T_lena = table(corrltn_noch_LENA,corrpval_noch_LENA,corrltn_ch_LENA,corrpval_ch_LENA,age_lena,id_lena);

writetable(T_hum,'corrltn_humchresp_tw.csv')
writetable(T_lena,'corrltn_lenachresp_tw.csv')
                                                           
save('chresp2ad_stepsizes_tw_humlab.mat','LENAch_distf_tw','LENAnoch_distf_tw','LENAch_distd_tw','LENAnoch_distd_tw',...
    'LENAch_distsp_tw','LENAnoch_distsp_tw','LENAch_distt_tw','LENAnoch_distt_tw','LENAch_velsp_tw','LENAnoch_velsp_tw'...
   ,'LENA_idage_tw','HUMch_distf_tw','HUMnoch_distf_tw','HUMch_distd_tw','HUMnoch_distd_tw','HUMch_distsp_tw','HUMnoch_distsp_tw',...
   'HUMch_distt_tw','HUMnoch_distt_tw','HUMch_velsp_tw','HUMnoch_velsp_tw','HUM_idage_tw')

