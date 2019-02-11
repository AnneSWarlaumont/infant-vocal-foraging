clear all
clc

%ritwika
%uc merced

%ivfcr

%generating data to do logistic regression - f, d (normalised, f is log) as
%independent variables, response (or probability of repsonse) as dependenat
%id as random effect, age as another independent variable - we need to
%generate data for both adult and child data 

%we will generate data for human labelled data and the corresponding subset
%of lena labelled data

%-0----------------------------------------0----------------------------------------0----------------------------------------
%child data - LENA
%-0----------------------------------------0----------------------------------------0----------------------------------------
load('humanlab_chdat.mat')
load('adresp_zkm_match.mat')

%find lena data corresponding to the human labelled data
kk = 0;

for i = 1:length(adr_age)
    for j = 1:3 %only 3 unique ids in human label - 274-82,340-183, 530-95: 
        %These correspond to the first three elements of chage and chlidid. Match the corresponding lena labels. 
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

T = logisticregression_fn(id_adr,db_adr,f_adr,r_adr,age_adr);

writetable(T,'chvoc_logisticreg_LENA.csv')

%-0----------------------------------------0----------------------------------------0----------------------------------------
%check for patterns in steps are response receiving - as in, do shorter
%steps in f, d or time get more response probability
%-0----------------------------------------0----------------------------------------0----------------------------------------
T_stsiz = logisticregression_fn_stsiz(id_adr,db_adr,f_adr,r_adr,age_adr,st_adr,en_adr);

writetable(T_stsiz,'chvoc_logisticreg_stepsizes_LENA.csv')

clear all

%-0----------------------------------------0----------------------------------------0----------------------------------------
%-0----------------------------------------0----------------------------------------0----------------------------------------
%child data - HUM
%-0----------------------------------------0----------------------------------------0----------------------------------------
load('humanlab_chdat.mat')
T = logisticregression_fn_HUM(childid,chdb_humlab,chlogf_humlab,adresponse_humlab,chage,listenerid);
                                                        
writetable(T,'chvoc_logisticreg_HUM.csv')

%-0----------------------------------------0----------------------------------------0----------------------------------------
%check for patterns in steps are response receiving - as in, do shorter
%steps in f, d or time get more response probability
%-0----------------------------------------0----------------------------------------0----------------------------------------
T_stsiz = logisticregression_fn_stsiz_HUM(childid,chdb_humlab,chlogf_humlab,adresponse_humlab,chage,chst_humlab,chen_humlab,listenerid);

writetable(T_stsiz,'chvoc_logisticreg_stepsizes_HUM.csv')

clear all

%-0----------------------------------------0----------------------------------------0----------------------------------------
%-0----------------------------------------0----------------------------------------0----------------------------------------
%adult data - LENA
%-0----------------------------------------0----------------------------------------0----------------------------------------
load('humanlab_addat.mat')
load('chresp_zkm_match.mat')

%find lena data matching human labelled
kk = 0;

for i = 1:length(chr2ad_age)
    for j = 1:3 %only 3 unique ids in human label - 274-82,340-183, 530-95: 
        %These correspond to the first three elements of chage and chlidid. Match the corresponding lena labels. 
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

T = logisticregression_fn(id_chr,db_chr,f_chr,r_chr,age_chr);

writetable(T,'advoc_logisticreg_LENA.csv')

%-0----------------------------------------0----------------------------------------0----------------------------------------
%check for patterns in steps are response receiving - as in, do shorter
%steps in f, d or time get more response probability
%-0----------------------------------------0----------------------------------------0----------------------------------------
T_stsiz = logisticregression_fn_stsiz(id_chr,db_chr,f_chr,r_chr,age_chr,st_chr,en_chr);

writetable(T_stsiz,'advoc_logisticreg_stepsizes_LENA.csv')

clear all

%-0----------------------------------------0----------------------------------------0----------------------------------------
%-0----------------------------------------0----------------------------------------0----------------------------------------
%adult data - HUM
%-0----------------------------------------0----------------------------------------0----------------------------------------
load('humanlab_addat.mat')
T = logisticregression_fn_HUM(childid_ad,addb_humlab,adlogf_humlab,chresp2ad_humlab,age_adhumlab,listenerid_ad);

writetable(T,'advoc_logisticreg_HUM.csv')

%-0----------------------------------------0----------------------------------------0----------------------------------------
%check for patterns in steps are response receiving - as in, do shorter
%steps in f, d or time get more response probability
%-0----------------------------------------0----------------------------------------0----------------------------------------
T_stsiz = logisticregression_fn_stsiz_HUM(childid_ad,addb_humlab,adlogf_humlab,chresp2ad_humlab,age_adhumlab,adst_humlab,aden_humlab,listenerid_ad);

writetable(T_stsiz,'advoc_logisticreg_stepsizes_HUM.csv')

clear all


