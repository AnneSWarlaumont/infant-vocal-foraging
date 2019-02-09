%Ritwika UC Merced
%IVFCR

%Step sizes in pitch/frequency, amplitude, time and acoustic space are sorted as WR (following a response) and WOR (following a
%non-response). WR and WOR vocalisations are fitted to the best
%candidate distribution based on AIC criterion. The candidate distributions
%are normal, lognormal, exponential, and pareto. 

%Adult vocalisations

clear all
clc

%AIC: 1 normal, 2 lognormal, 3 exponential, 4 pareto
load('chresp_zkm_match.mat')

%we'll find distances in f space, d space, vocal space, and time
for j = 1:length(chr2ad_en)

clear dis_f dis_d dis_sp dis_t

st = chr2ad_st{j};
en = chr2ad_en{j};
r = chr2ad{j}; 
f = chr2ad_zlogf{j};
d = chr2ad_zd{j};

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
%So, we need to add a 1 s threshold. So that shorter time stepsof less than 1 s etc are not
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
ch_distf_subrec{j} = dis_f(r == 1);%WR when response is received
ch_distd_subrec{j} = dis_d(r == 1);
ch_distsp_subrec{j} = dis_sp(r == 1);
ch_disttim_subrec{j} = dis_t(r == 1);

noch_distf_subrec{j} = dis_f(r == 0);
noch_distd_subrec{j} = dis_d(r == 0);
noch_distsp_subrec{j} = dis_sp(r == 0);
noch_disttim_subrec{j} = dis_t(r == 0); %WOR when response is not received

end
end

%Now, we organise the distances - from each subrecording at this point -
%into single recordings per day per id.

%We need to check for empty matrices and also club together data from same
%id and age, by clubbing subrecordings (_day)

%first, we concatenate age and id
for i = 1:length(chr2ad_id)  
    id_age{i} = sprintf('%s_%d',chr2ad_id{i},chr2ad_age(i));
end

%pick out unique combinations
id_age = unique(id_age);

%subrecordings from he same infant on the same day are bundled together -
%note that doing so after generating step size vectors eliminate bogus step
%sizes from the end of onde subrecoding to the beginning of the next
for i  = 1:length(id_age)
    distf_ch_day{i} = [];
    distd_ch_day{i} = [];
    distsp_ch_day{i} = [];
    disttim_ch_day{i} = [];
    
    distf_noch_day{i} = [];
    distd_noch_day{i} = [];
    distsp_noch_day{i} = [];
    disttim_noch_day{i} = [];
    
    for j = 1:length(noch_distf_subrec)
        %check which id and age combinations match elements of id_age; also
        %check for empty matrices
    if (strcmp(id_age{i},sprintf('%s_%d',chr2ad_id{j},chr2ad_age(j))) == 1) && (isempty(noch_distsp_subrec{j}) == 0) && (isempty(ch_distsp_subrec{j}) == 0) 
        
        distf_ch_day{i} = [distf_ch_day{i} ch_distf_subrec{j}];%once we identify the ones that belong to same id and age, we concatenate them
        distd_ch_day{i} = [distd_ch_day{i} ch_distd_subrec{j}];
        distsp_ch_day{i} = [distsp_ch_day{i} ch_distsp_subrec{j}];
        disttim_ch_day{i} = [disttim_ch_day{i} ch_disttim_subrec{j}];
        
        distf_noch_day{i} = [distf_noch_day{i} noch_distf_subrec{j}];
        distd_noch_day{i} = [distd_noch_day{i} noch_distd_subrec{j}];
        distsp_noch_day{i} = [distsp_noch_day{i} noch_distsp_subrec{j}];
        disttim_noch_day{i} = [disttim_noch_day{i} noch_disttim_subrec{j}];        
    end
    end
    
    
end

jj = 0;

%find aic values
for j = 1:length(distf_noch_day)
if (length(distsp_noch_day{j}) > 2 ) && (length(distsp_ch_day{j}) > 2) %need more than 2 points (at least) to fit

jj = jj + 1;
    
[aic_fch{jj},fch_fit(jj,1),p] = aicnew(distf_ch_day{j},[0 0 0 0],0);
[aic_dch{jj},dch_fit(jj,1),p] = aicnew(distd_ch_day{j},[0 0 0 0],0);
[aic_spch{jj},spch_fit(jj,1),p] = aicnew(distsp_ch_day{j},[0 0 0 0],0);
[aic_timch{jj},timch_fit(jj,1),p] = aicnew(disttim_ch_day{j},[0 0 0 0],0);

[aic_fnoch{jj},fnoch_fit(jj,1),p] = aicnew(distf_noch_day{j},[0 0 0 0],0);
[aic_dnoch{jj},dnoch_fit(jj,1),p] = aicnew(distd_noch_day{j},[0 0 0 0],0);
[aic_spnoch{jj},spnoch_fit(jj,1),p] = aicnew(distsp_noch_day{j},[0 0 0 0],0);
[aic_timnoch{jj},timnoch_fit(jj,1),p] = aicnew(disttim_noch_day{j},[0 0 0 0],0);

smplsi_ch(jj,1) = length(distf_ch_day{j})+length(distf_noch_day{j});
agestr = strsplit(id_age{j},'_');  %finds age by splitting the id_age string
id{jj,1} = agestr{1};
age(jj,1) = str2num(agestr{2});

end
end

clear jj

%now, knowing that frequency and amplitude spaces fit best - by and large -
%to exponential, vocal space to lognormal, and time to pareto, etc. we will consider
%those corresponding fits for all distributions, depending on whetehr they
%are in f, d, acoustic, or temporal space, etc.

%However, in our analyses and plots, note that we only consider fits that
%are the same as the best fit for that family of distributions. For
%instance, frequency steps are overwhelmingly best fit to exponential. So, only those
%frequency step distributions that are best fit to exponential
%distributions are considered in further analyses. This is taken care of in
%downstream .r and .m files.

for i  = 1:length(fch_fit)
        
        [a b c d] = aic_fch{i}.mle; %pick out the third value - exponential fits best
        expf_ch(i,1) = c.params;
        
        [a b c d] = aic_fnoch{i}.mle; %pick out the third value - exponential fits best
        expf_noch(i,1) = c.params;
        
        [a b c d] = aic_dch{i}.mle; %pick out the third value - exponential
        expd_ch(i,1) = c.params;
        
        [a b c d] = aic_dnoch{i}.mle; %pick out the third value - exponential
        expd_noch(i,1) = c.params;
        
        [a b c d] = aic_spch{i}.mle; %pick out the second value - lognormal
        lognsp_ch{i} = b.params;
        
        [a b c d] = aic_spnoch{i}.mle; %pick out the second value - lognormal
        lognsp_noch{i} = b.params;
        
        [a b c d] = aic_timch{i}.mle; %pick out the fourth value - pareto
        paretotim_ch{i} = d.params;
        
        [a b c d] = aic_timnoch{i}.mle; %pick out the fourth value - pareto,
        paretotim_noch{i} = d.params;             
end

 
for i = 1:length(expf_noch) %putting it all together to write into a csv file
   
    lognspch = lognsp_ch{i};
    lognspnoch = lognsp_noch{i};
    paretotimch = paretotim_ch{i};
    paretotimnoch = paretotim_noch{i};
    
    lognspmu_ch(i,1) = lognspch(1);
    lognspsig_ch(i,1) = lognspch(2);
    lognspmu_noch(i,1) = lognspnoch(1);
    lognspsig_noch(i,1) = lognspnoch(2);
    paretotimxmin_ch(i,1) = paretotimch(1);
    paretotimsig_ch(i,1) = paretotimch(2);
    paretotimxmin_noch(i,1) = paretotimnoch(1);
    paretotimsig_noch(i,1) = paretotimnoch(2);
    
end

%putting the child and no child responses together for the table 

expf = [expf_ch
    expf_noch];
expd = [expd_ch
    expd_noch];

lognspmu = [lognspmu_ch
    lognspmu_noch];
lognspsig = [lognspsig_ch
    lognspsig_noch];

paretotimxmin = [paretotimxmin_ch
    paretotimxmin_noch];
paretotimsig = [paretotimsig_ch
    paretotimsig_noch];
smplsize = [smplsi_ch
    smplsi_ch];
age = [age
    age];
id = [id
    id];
yesch = ones(size(expf_ch));
noch = zeros(size(expf_noch));
withch = [yesch
    noch];

%recording the kind of fits for each category
f_fit = [fch_fit %this is so that we can pick out only those datasets that have best AIC fits the same as the most common fit for that family of datasets
    fnoch_fit];

d_fit = [dch_fit
    dnoch_fit];

sp_fit = [spch_fit
    spnoch_fit];

tim_fit = [timch_fit
    timnoch_fit];

T_disc = table(id,age,expf,expd,lognspmu,lognspsig,paretotimxmin,paretotimsig,smplsize,withch,f_fit,d_fit,sp_fit,tim_fit);

writetable(T_disc,'chr2ad_stepsizedist.csv')
save('chresp2ad_stepsizes.mat','distf_ch_day','distd_ch_day','distsp_ch_day','disttim_ch_day'...
    ,'distf_noch_day','distd_noch_day','distsp_noch_day','disttim_noch_day','id_age')



