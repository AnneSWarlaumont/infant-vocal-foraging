clear all
clc

%ritwika
%uc merced

%ivfcr

%generating data to do linear mixed effects model on step sizes to find correlation b/n acoustic and time step size, 
%by seperating effects of age - we need to
%generate data for both adult and child data 

%-0----------------------------------------0----------------------------------------0----------------------------------------
%child data
%-0----------------------------------------0----------------------------------------0----------------------------------------
load('adresp_zkm_match.mat')

T = lmer_corrltn_data(adr_id,adr_zd,adr_zlogf,adr_age,adr_st,adr_en,adresponse);

writetable(T,'chvoc_lmercorrltn.csv')

clear all

%-0----------------------------------------0----------------------------------------0----------------------------------------
%-0----------------------------------------0----------------------------------------0----------------------------------------
%adult data
%-0----------------------------------------0----------------------------------------0----------------------------------------
load('chresp_zkm_match.mat')

T = lmer_corrltn_data(chr2ad_id,chr2ad_zd,chr2ad_zlogf,chr2ad_age,chr2ad_st,chr2ad_en,chr2ad);

writetable(T,'advoc_lmercorrltn.csv')

clear all

