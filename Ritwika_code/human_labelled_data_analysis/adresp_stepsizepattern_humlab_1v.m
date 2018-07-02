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
load('adresp2ch_arearest_stepsizes.mat')

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
            LENAad_distf_1v{i} = distf_ad_day{j};
            LENAnoad_distf_1v{i} = distf_noad_day{j};
            LENAad_distd_1v{i} = distd_ad_day{j};
            LENAnoad_distd_1v{i} = distd_noad_day{j};
            LENAad_distsp_1v{i} = distsp_ad_day{j};
            LENAnoad_distsp_1v{i} = distsp_noad_day{j};
            LENAad_distt_1v{i} = disttim_ad_day{j};
            LENAnoad_distt_1v{i} = disttim_noad_day{j};
            LENAad_velsp_1v{i} = velsp_ad_day{j};
            LENAnoad_velsp_1v{i} = velsp_noad_day{j};
            LENA_idage_1v{i} = id_age{j};
        end
    end
end

%finds distances and groups subrecs from same day and same infant. Only
%subsequent vocalisation considered.

[HUMad_distf_1v,HUMnoad_distf_1v,HUMad_distd_1v,HUMnoad_distd_1v,HUMad_distsp_1v,HUMnoad_distsp_1v,...
    HUMad_distt_1v,HUMnoad_distt_1v,HUMad_velsp_1v,HUMnoad_velsp_1v,HUM_idage_1v] = finddist_andgroup_onevoc(chst_humlab,...
                                                               chen_humlab,chdb_humlab,chlogf_humlab,adresponse_humlab,chage,childid,listenerid);

for i = 1:length(HUMnoad_distsp_1v)
     [r,p] = corrcoef(HUMnoad_distsp_1v{i},HUMnoad_distt_1v{i});
     corrltn_noad_HUM(i,1) = r(1,2);
     corrpval_noad_HUM(i,1) = p(1,2);
    
     [r,p] = corrcoef(HUMad_distsp_1v{i},HUMad_distt_1v{i});
     corrltn_ad_HUM(i,1) = r(1,2);
     corrpval_ad_HUM(i,1) = p(1,2);
 
     mmat = strsplit(HUM_idage_1v{i},'_');
     age_hum(i,1) = str2num(mmat{2});
     id_hum(i,1) = str2num(mmat{1});
         
end

for i = 1:length(LENAnoad_distsp_1v)
     [r,p] = corrcoef(LENAnoad_distsp_1v{i},LENAnoad_distt_1v{i});
     corrltn_noad_LENA(i,1) = r(1,2);
     corrpval_noad_LENA(i,1) = p(1,2);
    
     [r,p] = corrcoef(LENAad_distsp_1v{i},LENAad_distt_1v{i});
     corrltn_ad_LENA(i,1) = r(1,2);
     corrpval_ad_LENA(i,1) = p(1,2);  
     
     mmat = strsplit(LENA_idage_1v{i},'_');
     age_lena(i,1) = str2num(mmat{2});
     id_lena(i,1) = str2num(mmat{1});
end

T_hum = table(corrltn_noad_HUM,corrpval_noad_HUM,corrltn_ad_HUM,corrpval_ad_HUM,age_hum,id_hum);
T_lena = table(corrltn_noad_LENA,corrpval_noad_LENA,corrltn_ad_LENA,corrpval_ad_LENA,age_lena,id_lena);

writetable(T_hum,'corrltn_humadresp_1v.csv')
writetable(T_lena,'corrltn_lenaadresp_1v.csv')
                                                           
save('adresp2ch_stepsizes_1v_humlab.mat','LENAad_distf_1v','LENAnoad_distf_1v','LENAad_distd_1v','LENAnoad_distd_1v',...
    'LENAad_distsp_1v','LENAnoad_distsp_1v','LENAad_distt_1v','LENAnoad_distt_1v','LENAad_velsp_1v','LENAnoad_velsp_1v'...
   ,'LENA_idage_1v','HUMad_distf_1v','HUMnoad_distf_1v','HUMad_distd_1v','HUMnoad_distd_1v','HUMad_distsp_1v','HUMnoad_distsp_1v',...
   'HUMad_distt_1v','HUMnoad_distt_1v','HUMad_velsp_1v','HUMnoad_velsp_1v','HUM_idage_1v')

