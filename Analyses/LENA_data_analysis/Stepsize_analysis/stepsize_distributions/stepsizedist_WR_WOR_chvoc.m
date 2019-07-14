%Ritwika UC Merced
%IVFCR

%Step sizes in pitch/frequency, amplitude, time and acoustic space are sorted as WR (following a response) and WOR (following a
%non-response). WR and WOR vocalisations are fitted to the best
%candidate distribution based on AIC criterion. The candidate distributions
%are normal, lognormal, exponential, and pareto. 

%Child vocalisations

clear all
clc

%AIC: 1 normal, 2 lognormal, 3 exponential, 4 pareto
load('adresp_zkm_match.mat')

%we'll find step sizes in f space, d space, vocal space, and time
for j = 1:length(adr_en)

clear dis_f dis_d dis_sp dis_t

st = adr_st{j};
en = adr_en{j};
r = adresponse{j}; 
f = adr_zlogf{j};
d = adr_zd{j};

if length(st) > 1 %need at least two elements to make a distance
   
%find distance
for i = 1:length(d)-1
    dis_f(i) = sqrt((f(i+1)-f(i))^2);
    dis_d(i) = sqrt((d(i+1)-d(i))^2);
    dis_sp(i) = sqrt((d(i+1)-d(i))^2 + (f(i+1)-f(i))^2);
    dis_t(i) = st(i+1) - en(i);
end

%There is a 1 s wait between the end of
%vocalisation i and the beginning of vocalisation i+1 to make sure that
%vocalisation i did not receive a response. But receiving a response does not have this restriction
%So, we need to add a 1 s threshold. So that shorter time steps of less than 1 s etc are not
%counted into the with response category

%Note: a good test to make sure that this is working is to check the length
%of matrices of distances away from responses - since the 1 s threshold
%shouldn't filter those, they should have the same number of elements with
%or without the filter

for i = 1:length(r) - 1
    if dis_t(i) < 1
        r(i) = -1;
    end
end

%So, by designating vocalisations with distances in time less than 1 s as
%corresponding to -1 in responses, we can filter these out

r = r(1:end-1);

%remove nan values - space steps would have any nan values fork bth f and
%d, so that is teh ideal standard to remove nans based on 
dis_t = dis_t(isnan(dis_sp) == 0);
dis_f = dis_f(isnan(dis_sp) == 0);
dis_d = dis_d(isnan(dis_sp) == 0);
r = r(isnan(dis_sp) == 0);
dis_sp = dis_sp(isnan(dis_sp) == 0);

%Note that each set of distances is from a subrecording (ergo the _subrec)
ad_distf_subrec{j} = dis_f(r == 1); %WR when response is received
ad_distd_subrec{j} = dis_d(r == 1);
ad_distsp_subrec{j} = dis_sp(r == 1);
ad_disttim_subrec{j} = dis_t(r == 1);

noad_distf_subrec{j} = dis_f(r == 0); %WOR when response is not received
noad_distd_subrec{j} = dis_d(r == 0);
noad_distsp_subrec{j} = dis_sp(r == 0);
noad_disttim_subrec{j} = dis_t(r == 0); 

end
end

%Now, we organise the distances - from each subrecording at this point -
%into single recordings per day per id.

%We need to check for empty matrices and also club together data from same
%id and age, by clubbing subrecordings (_day)

%first, we concatenate age and id
for i = 1:length(adr_id)  
    id_age{i} = sprintf('%s_%d',adr_id{i},adr_age(i));
end

%pick out unique combinations
id_age = unique(id_age);

%subrecordings from he same infant on the same day are bundled together -
%note that doing so after generating step size vectors eliminate bogus step
%sizes from the end of onde subrecoding to the beginning of the next
for i  = 1:length(id_age)
    distf_ad_day{i} = [];
    distd_ad_day{i} = [];
    distsp_ad_day{i} = [];
    disttim_ad_day{i} = [];
    
    distf_noad_day{i} = [];
    distd_noad_day{i} = [];
    distsp_noad_day{i} = [];
    disttim_noad_day{i} = [];
    
    for j = 1:length(noad_distf_subrec)
        %check which id and age combinations match elements of id_age; also
        %check for empty matrices
    if (strcmp(id_age{i},sprintf('%s_%d',adr_id{j},adr_age(j))) == 1) && (isempty(noad_distf_subrec{j}) == 0) && (isempty(ad_distf_subrec{j}) == 0) 
        
        distf_ad_day{i} = [distf_ad_day{i} ad_distf_subrec{j}];%once we identify the ones that belong to same id and age, we concatenate them
        distd_ad_day{i} = [distd_ad_day{i} ad_distd_subrec{j}];
        distsp_ad_day{i} = [distsp_ad_day{i} ad_distsp_subrec{j}];
        disttim_ad_day{i} = [disttim_ad_day{i} ad_disttim_subrec{j}];
        
        distf_noad_day{i} = [distf_noad_day{i} noad_distf_subrec{j}];
        distd_noad_day{i} = [distd_noad_day{i} noad_distd_subrec{j}];
        distsp_noad_day{i} = [distsp_noad_day{i} noad_distsp_subrec{j}];
        disttim_noad_day{i} = [disttim_noad_day{i} noad_disttim_subrec{j}];
    end
    end
    
    
end

jj = 0;

%find aic values
for j = 1:length(distf_noad_day)
if (length(distsp_noad_day{j}) > 2 ) && (length(distsp_ad_day{j}) > 2) %need more than 2 points (at least) to fit

jj = jj + 1;
    
[aic_fad{jj},fad_fit(jj,1),p] = aicnew(distf_ad_day{j},[0 0 0 0],0); %aic_fad  stores details of aic fits, fad_fit stores the best fit. 
[aic_dad{jj},dad_fit(jj,1),p] = aicnew(distd_ad_day{j},[0 0 0 0],0);
[aic_spad{jj},spad_fit(jj,1),p] = aicnew(distsp_ad_day{j},[0 0 0 0],0);
[aic_timad{jj},timad_fit(jj,1),p] = aicnew(disttim_ad_day{j},[0 0 0 0],0);

[aic_fnoad{jj},fnoad_fit(jj,1),p] = aicnew(distf_noad_day{j},[0 0 0 0],0);
[aic_dnoad{jj},dnoad_fit(jj,1),p] = aicnew(distd_noad_day{j},[0 0 0 0],0);
[aic_spnoad{jj},spnoad_fit(jj,1),p] = aicnew(distsp_noad_day{j},[0 0 0 0],0);
[aic_timnoad{jj},timnoad_fit(jj,1),p] = aicnew(disttim_noad_day{j},[0 0 0 0],0);

smplsi(jj,1) = length(distf_ad_day{j})+length(distf_noad_day{j});
smplsi_WR(jj,1) = length(distf_ad_day{j}); %for rsq table
smplsi_WOR(jj,1) = length(distf_noad_day{j}); %for rsq table
agestr = strsplit(id_age{j},'_');  %finds age by splitting the id_age string
id{jj,1} = agestr{1};
age(jj,1) = str2num(agestr{2});

rsq_f_ad(jj,1) = aicfit_rsq(distf_ad_day{j}); %calculates rms error for fits
rsq_d_ad(jj,1) = aicfit_rsq(distd_ad_day{j});
rsq_sp_ad(jj,1) = aicfit_rsq(distsp_ad_day{j});  
rsq_t_ad(jj,1) = aicfit_rsq(disttim_ad_day{j});

rsq_f_noad(jj,1) = aicfit_rsq(distf_noad_day{j}); %calculates rms error for fits
rsq_d_noad(jj,1) = aicfit_rsq(distd_noad_day{j});
rsq_sp_noad(jj,1) = aicfit_rsq(distsp_noad_day{j});  
rsq_t_noad(jj,1) = aicfit_rsq(disttim_noad_day{j});

end
end

rsq_tab = table(age,id,smplsi_WR,smplsi_WOR,rsq_f_ad,rsq_d_ad,rsq_sp_ad,rsq_t_ad,rsq_f_noad,rsq_d_noad,rsq_sp_noad,rsq_t_noad); %writes rsq table
writetable(rsq_tab,'rsq_adresp2ch.csv') %writes table to file

clear jj

%now, knowing that frequency and amplitude spaces fit best - by and large -
%to exponential, vocal space and time to lognormal, etc. we will consider
%those corresponding fits for all distributions, depending on whetehr they
%are in f, d, acoustic, or temporal space, etc.

%However, in our analyses and plots, note that we only consider fits that
%are the same as the best fit for that family of distributions. For
%instance, frequency steps are overwhelmingly best fit to exponential. So, only those
%frequency step distributions that are best fit to exponential
%distributions are considered in further analyses. This is taken care of in
%downstream .r and .m files.

for i  = 1:length(fad_fit)
            
        [a b c d] = aic_fad{i}.mle; %pick out the third value - exponential
        expf_ad(i,1) = c.params;
        
        [a b c d] = aic_fnoad{i}.mle; %pick out the third value - exponential
        expf_noad(i,1) = c.params;
        
        [a b c d] = aic_dad{i}.mle; %pick out the third value - exponential
        expd_ad(i,1) = c.params;
        
        [a b c d] = aic_dnoad{i}.mle; %pick out the third value - exponential
        expd_noad(i,1) = c.params;
        
        [a b c d] = aic_spad{i}.mle; %pick out the second value - lognormal
        lognsp_ad{i} = b.params;
        
        [a b c d] = aic_spnoad{i}.mle; %pick out the second value - lognormal
        lognsp_noad{i} = b.params;
        
        [a b c d] = aic_timad{i}.mle; %pick out the second value - lognormal 
        logntim_ad{i} = b.params;
        
        [a b c d] = aic_timnoad{i}.mle; %pick out the second value - lognormal
        logntim_noad{i} = b.params;
end

 
for i = 1:length(expf_ad) %putting it all together to write into a csv file
   
    lognspad = lognsp_ad{i};
    lognspnoad = lognsp_noad{i};
    logntimad = logntim_ad{i};
    logntimnoad = logntim_noad{i};
    
    lognspmu_ad(i,1) = lognspad(1);
    lognspsig_ad(i,1) = lognspad(2);
    lognspmu_noad(i,1) = lognspnoad(1);
    lognspsig_noad(i,1) = lognspnoad(2);
    logntimmu_ad(i,1) = logntimad(1);
    logntimsig_ad(i,1) = logntimad(2);
    logntimmu_noad(i,1) = logntimnoad(1);
    logntimsig_noad(i,1) = logntimnoad(2);
    
end

%putting the responses and no responses together for the table 

expf = [expf_ad
    expf_noad];
expd = [expd_ad
    expd_noad];

lognspmu = [lognspmu_ad
    lognspmu_noad];
lognspsig = [lognspsig_ad
    lognspsig_noad];

logntimmu = [logntimmu_ad
    logntimmu_noad];
logntimsig = [logntimsig_ad
    logntimsig_noad];
smplsize = [smplsi
    smplsi];
age = [age
    age];
id = [id
    id];
yesad = ones(size(expf_ad));
noad = zeros(size(expf_noad));
response = [yesad
    noad];

%recording the kind of fits for each category
f_fit = [fad_fit %this is so that we can pick out only those datasets that have best AIC fits the same as the most common fit for that family of datasets
    fnoad_fit];

d_fit = [dad_fit
    dnoad_fit];

sp_fit = [spad_fit
    spnoad_fit];

tim_fit = [timad_fit
    timnoad_fit];

T_disc = table(id,age,expf,expd,lognspmu,lognspsig,logntimmu,logntimsig,smplsize,response,f_fit,d_fit,sp_fit,tim_fit);

writetable(T_disc,'adresp2ch_stepsizedist.csv')
save('adresp2ch_stepsizes.mat','distf_ad_day','distd_ad_day','distsp_ad_day','disttim_ad_day',...
    'distf_noad_day','distd_noad_day','distsp_noad_day','disttim_noad_day','id_age')



