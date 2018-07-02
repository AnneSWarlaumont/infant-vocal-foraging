%Ritwika UC Merced
%IVFCR
%Human labelled data and corresponding LENA data - find step sizes for
%adult vocalisations wrt chilt responses and sort into inthe viciinity of
%response, and away from response, per the 1V scheme

clear all
clc

%AIC: 1 normal, 2 lognormal, 3 exponential, 4 pareto

load('humanlab_addat.mat')
load('chresp2ad_arearest_stepsizes.mat')

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
            LENAch_distf_1v{i} = distf_ch_day{j};
            LENAnoch_distf_1v{i} = distf_noch_day{j};
            LENAch_distd_1v{i} = distd_ch_day{j};
            LENAnoch_distd_1v{i} = distd_noch_day{j};
            LENAch_distsp_1v{i} = distsp_ch_day{j};
            LENAnoch_distsp_1v{i} = distsp_noch_day{j};
            LENAch_distt_1v{i} = disttim_ch_day{j};
            LENAnoch_distt_1v{i} = disttim_noch_day{j};
            LENAch_velsp_1v{i} = velsp_ch_day{j};
            LENAnoch_velsp_1v{i} = velsp_noch_day{j};
            LENA_idage_1v{i} = id_age{j};
        end
    end
end

%finds distances and groups subrecs from same day and same infant. Only
%subsequent vocalisation considered.

[HUMch_distf_1v,HUMnoch_distf_1v,HUMch_distd_1v,HUMnoch_distd_1v,HUMch_distsp_1v,HUMnoch_distsp_1v,...
    HUMch_distt_1v,HUMnoch_distt_1v,HUMch_velsp_1v,HUMnoch_velsp_1v,HUM_idage_1v] = finddist_andgroup_onevoc(adst_humlab,...
                                                               aden_humlab,addb_humlab,adlogf_humlab,chresp2ad_humlab,age_adhumlab,childid_ad,listenerid_ad);
for i = 1:length(HUMnoch_distsp_1v)
     [r,p] = corrcoef(HUMnoch_distsp_1v{i},HUMnoch_distt_1v{i});
     corrltn_noch_HUM(i,1) = r(1,2);
     corrpval_noch_HUM(i,1) = p(1,2);
    
     [r,p] = corrcoef(HUMch_distsp_1v{i},HUMch_distt_1v{i});
     corrltn_ch_HUM(i,1) = r(1,2);
     corrpval_ch_HUM(i,1) = p(1,2);
 
     mmat = strsplit(HUM_idage_1v{i},'_');
     age_hum(i,1) = str2num(mmat{2});
     id_hum(i,1) = str2num(mmat{1});
         
end

for i = 1:length(LENAnoch_distsp_1v)
     [r,p] = corrcoef(LENAnoch_distsp_1v{i},LENAnoch_distt_1v{i});
     corrltn_noch_LENA(i,1) = r(1,2);
     corrpval_noch_LENA(i,1) = p(1,2);
    
     [r,p] = corrcoef(LENAch_distsp_1v{i},LENAch_distt_1v{i});
     corrltn_ch_LENA(i,1) = r(1,2);
     corrpval_ch_LENA(i,1) = p(1,2);  
     
     mmat = strsplit(LENA_idage_1v{i},'_');
     age_lena(i,1) = str2num(mmat{2});
     id_lena(i,1) = str2num(mmat{1});
end

T_hum = table(corrltn_noch_HUM,corrpval_noch_HUM,corrltn_ch_HUM,corrpval_ch_HUM,age_hum,id_hum);
T_lena = table(corrltn_noch_LENA,corrpval_noch_LENA,corrltn_ch_LENA,corrpval_ch_LENA,age_lena,id_lena);

writetable(T_hum,'corrltn_humchresp_1v.csv')
writetable(T_lena,'corrltn_lenachresp_1v.csv')
                                                           
save('chresp2ad_stepsizes_1v_humlab.mat','LENAch_distf_1v','LENAnoch_distf_1v','LENAch_distd_1v','LENAnoch_distd_1v',...
    'LENAch_distsp_1v','LENAnoch_distsp_1v','LENAch_distt_1v','LENAnoch_distt_1v','LENAch_velsp_1v','LENAnoch_velsp_1v'...
   ,'LENA_idage_1v','HUMch_distf_1v','HUMnoch_distf_1v','HUMch_distd_1v','HUMnoch_distd_1v','HUMch_distsp_1v','HUMnoch_distsp_1v',...
   'HUMch_distt_1v','HUMnoch_distt_1v','HUMch_velsp_1v','HUMnoch_velsp_1v','HUM_idage_1v')

