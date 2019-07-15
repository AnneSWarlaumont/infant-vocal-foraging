clear all
clc

%Here, we compare between WR and WOR step size distributiions based on
%human labelled and corresponding LENA labelled data, as well as unsplit
%distributions - we use the Kolmogorov Smirnov 2 sample test to do this.

%"The Kolmogorov?Smirnov statistic quantifies a distance between the empirical distribution function of 
%the sample and the cumulative distribution function of the reference distribution, or between the 
%empirical distribution functions of two samples. The null distribution of this statistic is calculated under 
%the null hypothesis that the sample is drawn from the reference distribution that the 
%samples are drawn from the same distribution (in the two-sample case). 
%In the two-sample case, the distribution considered under the null hypothesis is a continuous distribution but is otherwise unrestricted.
%The two-sample K?S test is one of the most useful and general nonparametric methods 
%for comparing two samples, as it is sensitive to differences in both location and shape of the 
%empirical cumulative distribution functions of the two samples." Source: https://en.wikipedia.org/wiki/Kolmogorov?Smirnov_test

%"kstest2(x1,x2) returns a test decision for the null hypothesis that the data in vectors 
%x1 and x2 are from the same continuous distribution, using the two-sample Kolmogorov-Smirnov test. 
%The alternative hypothesis is that x1 and x2 are from different continuous distributions. 
%The result h is 1 if the test rejects the null hypothesis at the 5%
%significance level, and 0 otherwise."
%Source: https://www.mathworks.com/help/stats/kstest2.html#btno0gd-ks2stat

%ie, if the test returns false (logical 0) then null hypothesis (that the vectors x1 and x2 are from rge same contonuous distribution)
%is not rejected. If the test rreturns true (logical 1), then the vectors
%are from different distributions at the 5% significant level (ie: the
%chance of the vectors being from the same distribution is 5% or less).
%The p value associated with the test tells the probability fo the vectors
%as from being the same distribution

%For a description of the KS 2 sample test statistic, Also see: http://www.physics.csbsju.edu/stats/KS-test.html

%since there are only 4 .mat files (chresp2ad, advoc_unsplit, and similarly forchild vocs) , it is easier to do this in a brute
%force way

%adult responses to child vocs - WR/WOR
load('adresp2ch_stepsizes_humlab.mat')

counter = 0;

for ii = 1:length(HUM_idage) %4 hum datasets
for jj = 1:length(LENA_idage) %3 lena datasets
    
humsplit = strsplit(HUM_idage{ii},'_'); %splits into child id and child age
lenasplit = strsplit(LENA_idage{jj},'_');

if (strcmp(humsplit{1},lenasplit{1}) == 1) && (strcmp(humsplit{2},lenasplit{2}) == 1) %checks if child id and age matches
    
counter = counter + 1;

[h_distf_ad(counter,1),p_distf_ad(counter,1),ks2stat_distf_ad(counter,1)] = kstest2(HUMad_distf{ii},LENAad_distf{jj}); %ktest2 test results, p value and statistic, 
[h_distd_ad(counter,1),p_distd_ad(counter,1),ks2stat_distd_ad(counter,1)] = kstest2(HUMad_distd{ii},LENAad_distd{jj});
[h_distsp_ad(counter,1),p_distsp_ad(counter,1),ks2stat_distsp_ad(counter,1)] = kstest2(HUMad_distsp{ii},LENAad_distsp{jj});
[h_distt_ad(counter,1),p_distt_ad(counter,1),ks2stat_distt_ad(counter,1)] = kstest2(HUMad_distt{ii},LENAad_distt{jj});
[h_distf_noad(counter,1),p_distf_noad(counter,1),ks2stat_distf_noad(counter,1)] = kstest2(HUMnoad_distf{ii},LENAnoad_distf{jj});
[h_distd_noad(counter,1),p_distd_noad(counter,1),ks2stat_distd_noad(counter,1)] = kstest2(HUMnoad_distd{ii},LENAnoad_distd{jj});
[h_distsp_noad(counter,1),p_distsp_noad(counter,1),ks2stat_distsp_noad(counter,1)] = kstest2(HUMnoad_distsp{ii},LENAnoad_distsp{jj});
[h_distt_noad(counter,1),p_distt_noad(counter,1),ks2stat_distt_noad(counter,1)] = kstest2(HUMnoad_distt{ii},LENAnoad_distt{jj});

chid{counter,1} = humsplit{1};
chage{counter,1} = humsplit{2};
listener{counter, 1} = humsplit{3};
end
end
end

h_distf_ad = double(h_distf_ad); %convert to double
h_distd_ad = double(h_distd_ad);
h_distsp_ad = double(h_distsp_ad);
h_distt_ad = double(h_distt_ad);
h_distf_noad = double(h_distf_noad);
h_distd_noad = double(h_distd_noad);
h_distsp_noad = double(h_distsp_noad);
h_distt_noad = double(h_distt_noad);

tt = table(h_distf_ad,p_distf_ad,ks2stat_distf_ad,h_distd_ad,p_distd_ad,ks2stat_distd_ad,h_distsp_ad,p_distsp_ad,ks2stat_distsp_ad,...
h_distt_ad,p_distt_ad,ks2stat_distt_ad,h_distf_noad,p_distf_noad,ks2stat_distf_noad,h_distd_noad,p_distd_noad,ks2stat_distd_noad,...
h_distsp_noad,p_distsp_noad,ks2stat_distsp_noad,h_distt_noad,p_distt_noad,ks2stat_distt_noad,chid,chage,listener); %write table
    
%count number of 1's and 0's of test results for each listener-childid
%combo and keep track of that through all four .mats
inmat = transpose(find(contains(tt.Properties.VariableNames,'h_'))); %find columns that contain results of kstest2 (h value)
inmat_p = transpose(find(contains(tt.Properties.VariableNames,'p_d'))); %find columns that contain pvalues of kstest2 

num_true = sum(tt{:,inmat},2); %number of '1's  (logical true's) from kstest2 for each chid and listener combo
num_test = length(inmat)*ones(4,1); %total number of kstest2 for each chid and listener combo
 
pChWRmean = mean(tt{:,inmat_p(1:4)},2); %2 specifis that mean should be taken along each row
pChWORmean = mean(tt{:,inmat_p(5:8)},2);
pChWRstd = std(tt{:,inmat_p(1:4)},0,2); %0 specifies the weight for the std devaitiaon calculation (sample std. dev, normaliased by N-1)
pChWORstd = std(tt{:,inmat_p(5:8)},0,2);

writetable(tt,'ktest2_adresp2ch_HUMLENA.csv')

%-----------------------------------------
clearvars -except num_true num_test pChWRmean pChWORmean pChWRstd pChWORstd 

%child responses to adult vocs - WR/WOR
load('chresp2ad_stepsizes_humlab.mat')

counter = 0;

for ii = 1:length(HUM_idage) %4 hum datasets
for jj = 1:length(LENA_idage) %3 lena datasets
    
humsplit = strsplit(HUM_idage{ii},'_');
lenasplit = strsplit(LENA_idage{jj},'_');

if (strcmp(humsplit{1},lenasplit{1}) == 1) && (strcmp(humsplit{2},lenasplit{2}) == 1) %checks if child id and age matches
    
counter = counter + 1;

[h_distf_ch(counter,1),p_distf_ch(counter,1),ks2stat_distf_ch(counter,1)] = kstest2(HUMch_distf{ii},LENAch_distf{jj}); %ktest2 test results, p value and statistic, 
[h_distd_ch(counter,1),p_distd_ch(counter,1),ks2stat_distd_ch(counter,1)] = kstest2(HUMch_distd{ii},LENAch_distd{jj});
[h_distsp_ch(counter,1),p_distsp_ch(counter,1),ks2stat_distsp_ch(counter,1)] = kstest2(HUMch_distsp{ii},LENAch_distsp{jj});
[h_distt_ch(counter,1),p_distt_ch(counter,1),ks2stat_distt_ch(counter,1)] = kstest2(HUMch_distt{ii},LENAch_distt{jj});
[h_distf_noch(counter,1),p_distf_noch(counter,1),ks2stat_distf_noch(counter,1)] = kstest2(HUMnoch_distf{ii},LENAnoch_distf{jj});
[h_distd_noch(counter,1),p_distd_noch(counter,1),ks2stat_distd_noch(counter,1)] = kstest2(HUMnoch_distd{ii},LENAnoch_distd{jj});
[h_distsp_noch(counter,1),p_distsp_noch(counter,1),ks2stat_distsp_noch(counter,1)] = kstest2(HUMnoch_distsp{ii},LENAnoch_distsp{jj});
[h_distt_noch(counter,1),p_distt_noch(counter,1),ks2stat_distt_noch(counter,1)] = kstest2(HUMnoch_distt{ii},LENAnoch_distt{jj});
chid{counter,1} = humsplit{1};

chage{counter,1} = humsplit{2};
listener{counter, 1} = humsplit{3};

end
end
end

h_distf_ch = double(h_distf_ch); %convert to double
h_distd_ch = double(h_distd_ch);
h_distsp_ch = double(h_distsp_ch);
h_distt_ch = double(h_distt_ch);
h_distf_noch = double(h_distf_noch);
h_distd_noch = double(h_distd_noch);
h_distsp_noch = double(h_distsp_noch);
h_distt_noch = double(h_distt_noch);

tt = table(h_distf_ch,p_distf_ch,ks2stat_distf_ch,h_distd_ch,p_distd_ch,ks2stat_distd_ch,h_distsp_ch,p_distsp_ch,ks2stat_distsp_ch,...
h_distt_ch,p_distt_ch,ks2stat_distt_ch,h_distf_noch,p_distf_noch,ks2stat_distf_noch,h_distd_noch,p_distd_noch,ks2stat_distd_noch,...
h_distsp_noch,p_distsp_noch,ks2stat_distsp_noch,h_distt_noch,p_distt_noch,ks2stat_distt_noch,chid,chage,listener);

%count number of 1's and 0's of test results for each listener-childid
%combo and keep track of that through all four .mats
inmat = transpose(find(contains(tt.Properties.VariableNames,'h_'))); %find columns that contain results of kstest2 (h value)
inmat_p = transpose(find(contains(tt.Properties.VariableNames,'p_d'))); %find columns that contain pvalues of kstest2

num_true = sum(tt{:,inmat},2)+num_true; %number of '1's  (logical true's) from kstest2 for each chid and listener combo - adds this to the pre-existing vector
num_test = length(inmat)*ones(4,1)+num_test; %total number of kstest2 for each chid and listener combo - adds this to the pre-existing vector

pAdWRmean = mean(tt{:,inmat_p(1:4)},2); %2 specifis that mean should be taken along each row
pAdWORmean = mean(tt{:,inmat_p(5:8)},2);
pAdWRstd = std(tt{:,inmat_p(1:4)},0,2); %0 specifies the weight for the std devaitiaon calculation (sample std. dev, normaliased by N-1)
pAdWORstd = std(tt{:,inmat_p(5:8)},0,2);

writetable(tt,'ktest2_chresp2ad_HUMLENA.csv')

%-----------------------------------------
clearvars -except num_true num_test pChWRmean pChWORmean pChWRstd pChWORstd ...
    pAdWRmean pAdWORmean pAdWRstd pAdWORstd

load('advoc_stepsizes_humlab_noWRWOR.mat') %adult vocs, unsplit

counter = 0;

for ii = 1:length(HUM_idage) %4 hum datasets
for jj = 1:length(LENA_idage) %3 lena datasets
    
humsplit = strsplit(HUM_idage{ii},'_');
lenasplit = strsplit(LENA_idage{jj},'_');

if (strcmp(humsplit{1},lenasplit{1}) == 1) && (strcmp(humsplit{2},lenasplit{2}) == 1) %checks if child id and age matches
    
counter = counter + 1;

[h_distf_advoc(counter,1),p_distf_advoc(counter,1),ks2stat_distf_advoc(counter,1)] = kstest2(HUM_distf_advoc{ii},LENA_distf_advoc{jj}); %ktest2 test results, p value and statistic, 
[h_distd_advoc(counter,1),p_distd_advoc(counter,1),ks2stat_distd_advoc(counter,1)] = kstest2(HUM_distd_advoc{ii},LENA_distd_advoc{jj});
[h_distsp_advoc(counter,1),p_distsp_advoc(counter,1),ks2stat_distsp_advoc(counter,1)] = kstest2(HUM_distsp_advoc{ii},LENA_distsp_advoc{jj});
[h_distt_advoc(counter,1),p_distt_advoc(counter,1),ks2stat_distt_advoc(counter,1)] = kstest2(HUM_distt_advoc{ii},LENA_distt_advoc{jj});

chid{counter,1} = humsplit{1};
chage{counter,1} = humsplit{2};
listener{counter, 1} = humsplit{3};
end
end
end

h_distf_advoc = double(h_distf_advoc); %convert to double
h_distd_advoc = double(h_distd_advoc);
h_distsp_advoc = double(h_distsp_advoc);
h_distt_advoc = double(h_distt_advoc);

tt = table(h_distf_advoc,p_distf_advoc,ks2stat_distf_advoc,h_distd_advoc,p_distd_advoc,ks2stat_distd_advoc,h_distsp_advoc,p_distsp_advoc,ks2stat_distsp_advoc,...
h_distt_advoc,p_distt_advoc,ks2stat_distt_advoc,chid,chage,listener);

%count number of 1's and 0's of test results for each listener-childid
%combo and keep track of that through all four .mats
inmat = transpose(find(contains(tt.Properties.VariableNames,'h_'))); %find columns that contain results of kstest2 (h value)
inmat_p = transpose(find(contains(tt.Properties.VariableNames,'p_d'))); %find columns that contain pvalues of kstest2

num_true = sum(tt{:,inmat},2)+num_true; %number of '1's  (logical true's) from kstest2 for each chid and listener combo - adds this to the pre-existing vector
num_test = length(inmat)*ones(4,1)+num_test; %total number of kstest2 for each chid and listener combo - adds this to the pre-existing vector

pAdmean = mean(tt{:,inmat_p},2); %2 specifis that mean should be taken along each row
pAdstd = std(tt{:,inmat_p},0,2);%0 specifies the weight for the std devaitiaon calculation (sample std. dev, normaliased by N-1)

writetable(tt,'ktest2_advoc_HUMLENA.csv')

%-----------------------------------------
clearvars -except num_true num_test pChWRmean pChWORmean pChWRstd pChWORstd ...
    pAdWRmean pAdWORmean pAdWRstd pAdWORstd pAdmean pAdstd

load('chvoc_stepsizes_humlab_noWRWOR.mat')

counter = 0;

for ii = 1:length(HUM_idage) %4 hum datasets
for jj = 1:length(LENA_idage) %3 lena datasets
    
humsplit = strsplit(HUM_idage{ii},'_');
lenasplit = strsplit(LENA_idage{jj},'_');

if (strcmp(humsplit{1},lenasplit{1}) == 1) && (strcmp(humsplit{2},lenasplit{2}) == 1) %checks if child id and age matches
    
counter = counter + 1;

[h_distf_chvoc(counter,1),p_distf_chvoc(counter,1),ks2stat_distf_chvoc(counter,1)] = kstest2(HUM_distf_chvoc{ii},LENA_distf_chvoc{jj});
[h_distd_chvoc(counter,1),p_distd_chvoc(counter,1),ks2stat_distd_chvoc(counter,1)] = kstest2(HUM_distd_chvoc{ii},LENA_distd_chvoc{jj});
[h_distsp_chvoc(counter,1),p_distsp_chvoc(counter,1),ks2stat_distsp_chvoc(counter,1)] = kstest2(HUM_distsp_chvoc{ii},LENA_distsp_chvoc{jj});
[h_distt_chvoc(counter,1),p_distt_chvoc(counter,1),ks2stat_distt_chvoc(counter,1)] = kstest2(HUM_distt_chvoc{ii},LENA_distt_chvoc{jj});

chid{counter,1} = humsplit{1};
chage{counter,1} = humsplit{2};
listener{counter, 1} = humsplit{3};
end
end
end

h_distf_chvoc = double(h_distf_chvoc); %convert to double
h_distd_chvoc = double(h_distd_chvoc);
h_distsp_chvoc = double(h_distsp_chvoc);
h_distt_chvoc = double(h_distt_chvoc);

tt = table(h_distf_chvoc,p_distf_chvoc,ks2stat_distf_chvoc,h_distd_chvoc,p_distd_chvoc,ks2stat_distd_chvoc,h_distsp_chvoc,p_distsp_chvoc,ks2stat_distsp_chvoc,...
h_distt_chvoc,p_distt_chvoc,ks2stat_distt_chvoc,chid,chage,listener);

%count number of 1's and 0's of test results for each listener-childid
%combo and keep track of that through all four .mats
inmat = transpose(find(contains(tt.Properties.VariableNames,'h_'))); %find columns that contain results of kstest2 (h value)
inmat_p = transpose(find(contains(tt.Properties.VariableNames,'p_d'))); %find columns that contain pvalues of kstest2

num_true = sum(tt{:,inmat},2)+num_true; %number of '1's  (logical true's) from kstest2 for each chid and listener combo - adds this to the pre-existing vector
num_test = length(inmat)*ones(4,1)+num_test; %total number of kstest2 for each chid and listener combo - adds this to the pre-existing vector

pChmean = mean(tt{:,inmat_p},2); %2 specifis that mean should be taken along each row
pChstd = std(tt{:,inmat_p},0,2); %0 specifies the weight for the std devaitiaon calculation (sample std. dev, normaliased by N-1)

writetable(tt,'ks2test_chvoc_HUMLENA.csv')

frac_of_0 = 1 - (num_true./num_test);

tab = table(chid,chage,listener,frac_of_0,pChmean,pChstd,pChWRmean,pChWRstd,pChWORmean,...
    pChWORstd,pAdmean, pAdstd,pAdWRmean,pAdWRstd, pAdWORmean  ,pAdWORstd); %summarises the number of times null hypotheis was rejected as a fraction of total number 
%of tests for each childid-listener combo
writetable(tab,'ktest2_summary_HUMLENA.csv')

