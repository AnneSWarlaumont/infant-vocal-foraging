clear all
clc

%Ritwika VPS, UC Merced
%finding mean step sizes at nth vocaisation since last response for human
%labelled data, and corresponding LENA data group

%-------------------------------------------------------------------------------
%adult data - hum
load('humanlab_addat.mat')

%create table with mean step sizes, standard deviation,s 95% CI for
%distance in acoustic space, f, d, and time, as well as velocity 

[ad_mean_steps_hum,T_binary,T_2voc] = meanstsizes_fn(adst_humlab,aden_humlab,chresp2ad_humlab,adlogf_humlab,addb_humlab,childid_ad,age_adhumlab,listenerid_ad);

%write table
writetable(T_binary,'chresp2ad_mean_stepsize_binary_HUM.csv')
writetable(T_2voc,'chresp2ad_mean_stepsize_2voc_HUM.csv')
%writetable(ad_mean_steps_hum,'chresp2ad_mean_stepsize_HUM.csv')

%-------------------------------------------------------------------------------
%adult data - lena
load('chresp_zkm_match.mat')

%find lena data matching human labelled
kk = 0;
for i = 1:length(chr2ad_age)
    for j = 1:3 %only 3 unique ids in human label - 274-82,340-183, 530-95: these are the first three elements - match the corresponding lena labels
        if (age_adhumlab(j) == chr2ad_age(i)) && (strcmp(childid_ad{j},chr2ad_id{i}) == 1)
            kk = kk + 1;
            st_chr{kk} = chr2ad_st{i};
            en_chr{kk} = chr2ad_en{i};
            db_chr{kk} = chr2ad_zd{i};
            f_chr{kk} = chr2ad_zlogf{i};
            r_chr{kk} = chr2ad{i};  
            age_chr(kk) = chr2ad_age(i);
            id_chr{kk} = chr2ad_id{i};
        end
    end
end

%create table with mean step sizes, standard deviation,s 95% CI for
%distance in acoustic space, f, d, and time, as well as velocity 

[ad_mean_steps_lena,T_binary,T_2voc] = meanstsizes_fn_LENA(st_chr,en_chr,r_chr,f_chr,db_chr,id_chr,age_chr);

writetable(T_binary,'chresp2ad_mean_stepsize_binary_LENA.csv')
writetable(T_2voc,'chresp2ad_mean_stepsize_2voc_LENA.csv')
%writetable(ad_mean_steps_lena,'chresp2ad_mean_stepsize_LENA.csv')

%-------------------------------------------------------------------------------
%child data - hum
load('humanlab_chdat.mat')

%create table with mean step sizes, standard deviation,s 95% CI for
%distance in acoustic space, f, d, and time, as well as velocity 

[chn_mean_steps_hum,T_binary,T_2voc] = meanstsizes_fn(chst_humlab,chen_humlab,adresponse_humlab,chlogf_humlab,chdb_humlab,childid,chage,listenerid);

writetable(T_binary,'adresp2ch_mean_stepsize_binary_HUM.csv')
writetable(T_2voc,'adresp2ch_mean_stepsize_2voc_HUM.csv')
%writetable(chn_mean_steps_hum,'adresp2ch_mean_stepsize_HUM.csv')                                                                    

%-------------------------------------------------------------------------------
%child data - lena
load('adresp_zkm_match.mat')

%find lena data matching human labelled
kk = 0;

for i = 1:length(adr_age)
    for j = 1:3%only 3 unique ids in human label - 274-82,340-183, 530-95: these are the first three elements - match the corresponding lena labels
        if (chage(j) == adr_age(i)) && (strcmp(childid{j},adr_id{i}) == 1)
            kk = kk + 1;
            st_adr{kk} = adr_st{i};
            en_adr{kk} = adr_en{i};
            db_adr{kk} = adr_zd{i};
            f_adr{kk} = adr_zlogf{i};
            r_adr{kk} = adresponse{i}; 
            age_adr(kk) = adr_age(i);
            id_adr{kk} = adr_id{i};
        end
    end
end

%create table with mean step sizes, standard deviation,s 95% CI for
%distance in acoustic space, f, d, and time, as well as velocity 

[chn_mean_steps_lena,T_binary,T_2voc] = meanstsizes_fn_LENA(st_adr,en_adr,r_adr,f_adr,db_adr,id_adr,age_adr);

writetable(T_binary,'adresp2ch_mean_stepsize_binary_LENA.csv')
writetable(T_2voc,'adresp2ch_mean_stepsize_2voc_LENA.csv')
%writetable(chn_mean_steps_lena,'adresp2ch_mean_stepsize_LENA.csv')


