clear all
clc

%ritwika
%uc merced

%ivfcr

%generating data to do logistic regression - f, d (normalised, f is log) as
%independent variables, response (or probability of repsonse) as dependenat
%id as random effect, age as another independent variable - we need to
%generate data for both adult and child data 

%-0----------------------------------------0----------------------------------------0----------------------------------------
%child data
%-0----------------------------------------0----------------------------------------0----------------------------------------
load('adresp_zkm_match.mat')

T = logisticregression_fn(adr_id,adr_zd,adr_zlogf,adresponse,adr_age);

writetable(T,'chvoc_logisticreg.csv')

clear T

%-0----------------------------------------0----------------------------------------0----------------------------------------
%check for patterns in steps are response receiving - as in, do shorter
%steps in f, d or time get more response probability: immediately preceding steps in time, f, and
%d, as well as d and f values as independent variables
%-0----------------------------------------0----------------------------------------0----------------------------------------
T = logisticregression_fn_stsiz(adr_id,adr_zd,adr_zlogf,adresponse,adr_age,adr_st,adr_en);

writetable(T,'chvoc_logisticreg_stepsizes.csv')

clear all

%-0----------------------------------------0----------------------------------------0----------------------------------------
%-0----------------------------------------0----------------------------------------0----------------------------------------
%adult data
%-0----------------------------------------0----------------------------------------0----------------------------------------
load('chresp_zkm_match.mat')

T = logisticregression_fn(chr2ad_id,chr2ad_zd,chr2ad_zlogf,chr2ad,chr2ad_age);

writetable(T,'advoc_logisticreg.csv')

clear all

%-0----------------------------------------0----------------------------------------0----------------------------------------
%check for patterns in steps are response receiving - as in, do shorter
%steps in f, d or time get more response probability: immediately preceding steps in time, f, and
%d, as well as d and f values as independent variables
%-0----------------------------------------0----------------------------------------0----------------------------------------

load('chresp_zkm_match.mat')

T = logisticregression_fn_stsiz(chr2ad_id,chr2ad_zd,chr2ad_zlogf,chr2ad,chr2ad_age,chr2ad_st,chr2ad_en);

writetable(T,'advoc_logisticreg_stepsizes.csv')
