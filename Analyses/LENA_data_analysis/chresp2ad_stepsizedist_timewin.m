%Ritwika UC Merced
%IVFCR
%2 feb, 2018 - post discussions about paper, we decided to use the
%following metrics: velocity in space + step sizes, all for only the immediate first vocalisation
%follwoing one

clear all
clc
%An attempt to find patterns in step sizes with and without child responses

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

%populate by time window: Essentially, all vocalisations that fall within
%15 s after a response is designated to be in the vicinity of a response.
%The rest are not. Note that we have NaN values for responses, and in the f
%and d matrices sometimes.

%have a matrix corresponding to indices of response matrix
indexmat = 1:length(r);

%zeros to fill up with assignations for voalisations: 0 (away from
%repsonse), 1 (close to response - 15 s window), NA response (100), if time
%step is less than 1 s (-1)
zeromat = zeros(size(r));

%find all vocalisations that lay in a 15 s window after adult response:
%essentially, anything that is 15 seconds or less after the end of a
%vocalisation that received response
for i = 1:length(r)
    %if a response has been received, then define endpoints: end of
    %vocalisation, and 15s after the end. If there are other vocalisations
    %starting within that time frame, tag them as in the vicinity of
    %responses in zeromat
   if r(i) == 1 
       endi = en(i);
       endi15 = en(i) + 15;
       nearresp = st(st > endi);
       nearresp = nearresp(nearresp < endi15);
       [cc,iin,inearresp] = intersect(st,nearresp);
       zeromat(iin) = 1;
   end    
end

%find where all the NAs (100) are, less than 1 s time steps (-1) are; fill corresponding indices 
zeromat(r == 100) = 100;
zeromat(r == -1) = -1;

zeromat = zeromat(1:end-1); %there cant be a distance correspoding to teh last vocalisation

%remove nan values - space steps would have any nan values fork bth f and
%d, so that is teh ideal standard to remove nans based on 
dis_t = dis_t(isnan(dis_sp) == 0);
dis_f = dis_f(isnan(dis_sp) == 0);
dis_d = dis_d(isnan(dis_sp) == 0);
zeromat = zeromat(isnan(dis_sp) == 0);
dis_sp = dis_sp(isnan(dis_sp) == 0);
    
ch_distf_subrec{j} = dis_f(zeromat == 1);
ch_distd_subrec{j} = dis_d(zeromat == 1);
ch_distsp_subrec{j} = dis_sp(zeromat == 1);
ch_disttim_subrec{j} = dis_t(zeromat == 1);
ch_velsp_subrec{j} = dis_sp(zeromat == 1)./dis_t(zeromat == 1);

noch_distf_subrec{j} = dis_f(zeromat == 0);
noch_distd_subrec{j} = dis_d(zeromat == 0);
noch_distsp_subrec{j} = dis_sp(zeromat == 0);
noch_disttim_subrec{j} = dis_t(zeromat == 0); 
noch_velsp_subrec{j} = dis_sp(zeromat == 0)./dis_t(zeromat == 0);   

end
end

%Now, we organise the distances - from each subrecording at this point -
%into single recordings per day per id.
%We need to check for empty matrices and also club together data from same
%id and age, by clubbing subrecordings

%first, we concatenate age and id
for i = 1:length(chr2ad_id)  
    id_age{i} = sprintf('%s_%d',chr2ad_id{i},chr2ad_age(i));
end

%pick out unique combinations
id_age = unique(id_age);
for i  = 1:length(id_age)
    distf_ch_day{i} = [];
    distd_ch_day{i} = [];
    distsp_ch_day{i} = [];
    disttim_ch_day{i} = [];
    velsp_ch_day{i} = [];
    
    distf_noch_day{i} = [];
    distd_noch_day{i} = [];
    distsp_noch_day{i} = [];
    disttim_noch_day{i} = [];
    velsp_noch_day{i} = [];
    
    for j = 1:length(noch_distf_subrec)
        %check which id and age combinations match elements of id_age; also
        %check for empty matrices
    if (strcmp(id_age{i},sprintf('%s_%d',chr2ad_id{j},chr2ad_age(j))) == 1) && (isempty(noch_distsp_subrec{j}) == 0) && (isempty(ch_distsp_subrec{j}) == 0) 
        
        distf_ch_day{i} = [distf_ch_day{i} ch_distf_subrec{j}];%once we identify the ones that belong to same id and age, we concatenate them
        distd_ch_day{i} = [distd_ch_day{i} ch_distd_subrec{j}];
        distsp_ch_day{i} = [distsp_ch_day{i} ch_distsp_subrec{j}];
        disttim_ch_day{i} = [disttim_ch_day{i} ch_disttim_subrec{j}];
        velsp_ch_day{i} = [velsp_ch_day{i} ch_velsp_subrec{j}];
        
        distf_noch_day{i} = [distf_noch_day{i} noch_distf_subrec{j}];
        distd_noch_day{i} = [distd_noch_day{i} noch_distd_subrec{j}];
        distsp_noch_day{i} = [distsp_noch_day{i} noch_distsp_subrec{j}];
        disttim_noch_day{i} = [disttim_noch_day{i} noch_disttim_subrec{j}];
        velsp_noch_day{i} = [velsp_noch_day{i} noch_velsp_subrec{j}];
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
[aic_velspch{jj},velspch_fit(jj,1),p] = aicnew(velsp_ch_day{j},[0 0 0 0],0);

[aic_fnoch{jj},fnoch_fit(jj,1),p] = aicnew(distf_noch_day{j},[0 0 0 0],0);
[aic_dnoch{jj},dnoch_fit(jj,1),p] = aicnew(distd_noch_day{j},[0 0 0 0],0);
[aic_spnoch{jj},spnoch_fit(jj,1),p] = aicnew(distsp_noch_day{j},[0 0 0 0],0);
[aic_timnoch{jj},timnoch_fit(jj,1),p] = aicnew(disttim_noch_day{j},[0 0 0 0],0);
[aic_velspnoch{jj},velspnoch_fit(jj,1),p] = aicnew(velsp_noch_day{j},[0 0 0 0],0);

[r,p] = corrcoef(distsp_noch_day{j},disttim_noch_day{j});
corrltn_noch(jj,1) = r(1,2);
corrpval_noch(jj,1) = p(1,2);
    
[r,p] = corrcoef(distsp_ch_day{j},disttim_ch_day{j});
corrltn_ch(jj,1) = r(1,2);
corrpval_ch(jj,1) = p(1,2);

smplsi_ch(jj,1) = length(distf_ch_day{j})+length(distf_noch_day{j});
agestr = strsplit(id_age{j},'_');  %finds age by splitting the id_age string
id{jj,1} = agestr{1};
age(jj,1) = str2num(agestr{2});

end
end

clear jj

%genefating aic criterion tables - we need best fit aic values, and aic
%values for the family of majority fits - for example, frequency steps are generally best
%fit to exponential, so if an individual frequency curve is best fit to
%lognormal, we will need info about the aic of lognormal and exponential
%for that one to compare - aicdiff is the difference between bestfit model
%and the family fit model

%freq, amp, speed - exp
%sp - lognormal
%time - pareto

for jj = 1:length(aic_fch)
    [aicdiff_fch(jj,1),fitindicator_fch(jj,1)] = aicvalues_fordifffits(aic_fch{jj},3); %frequency is exp
    [aicdiff_dch(jj,1),fitindicator_dch(jj,1)] = aicvalues_fordifffits(aic_dch{jj},3); %amplitude is exp
    [aicdiff_spch(jj,1),fitindicator_spch(jj,1)] = aicvalues_fordifffits(aic_spch{jj},2); % space is lognormal
    [aicdiff_timch(jj,1),fitindicator_timch(jj,1)] = aicvalues_fordifffits(aic_timch{jj},4); % time is pareto
    [aicdiff_velspch(jj,1),fitindicator_velspch(jj,1)] = aicvalues_fordifffits(aic_velspch{jj},3); % speed is exponential
    
    [aicdiff_fnoch(jj,1),fitindicator_fnoch(jj,1)] = aicvalues_fordifffits(aic_fnoch{jj},3); %frequency is exp
    [aicdiff_dnoch(jj,1),fitindicator_dnoch(jj,1)] = aicvalues_fordifffits(aic_dnoch{jj},3); %amplitude is exp
    [aicdiff_spnoch(jj,1),fitindicator_spnoch(jj,1)] = aicvalues_fordifffits(aic_spnoch{jj},2); % space is lognormal
    [aicdiff_timnoch(jj,1),fitindicator_timnoch(jj,1)] = aicvalues_fordifffits(aic_timnoch{jj},4); % time is pareto
    [aicdiff_velspnoch(jj,1),fitindicator_velspnoch(jj,1)] = aicvalues_fordifffits(aic_velspnoch{jj},3); % speed is exponential
end

%store aicdifferences
T_aic = table(aicdiff_fch,aicdiff_dch,aicdiff_spch,aicdiff_timch,aicdiff_velspch,aicdiff_fnoch,aicdiff_dnoch,aicdiff_spnoch,aicdiff_timnoch,aicdiff_velspnoch,age,...
    fitindicator_fch,fitindicator_dch,fitindicator_spch,fitindicator_timch,fitindicator_velspch,fitindicator_fnoch,fitindicator_dnoch,fitindicator_spnoch,...
    fitindicator_timnoch,fitindicator_velspnoch);
writetable(T_aic,'chresp2ad_tw_aicdiff.csv')

%now, knowing that frequency and amplitude spaces fit best - by and large -
%to exponential, vocal space and time to lognormal, etc. we will consider
%those corresponding fits for all distributions, depending on whetehr they
%are in f, d, acoustic, or temporal space, etc.

for i  = 1:length(fch_fit)
        
        [a b c d] = aic_fch{i}.mle; %pick out the third value - exponential
        expf_ch(i,1) = c.params;
        
        [a b c d] = aic_fnoch{i}.mle; %pick out the third value - exponential
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
        
        [a b c d] = aic_timnoch{i}.mle; %pick out the fourth value - pareto
        paretotim_noch{i} = d.params;
        
        [a b c d] = aic_velspch{i}.mle; %pick out the third value - exponential
        expvelsp_ch(i,1) = c.params;
        
        [a b c d] = aic_velspnoch{i}.mle; %pick out the third value - exponential
        expvelsp_noch(i,1) = c.params;
        
                  
end

for i = 1:length(expvelsp_ch) %putting it all together to write into a csv file
   
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

%recording the kind of fits for each category

numberoffits_disc = table(age,id,fch_fit,dch_fit,spch_fit,timch_fit,velspch_fit,fnoch_fit,dnoch_fit,spnoch_fit,timnoch_fit,velspnoch_fit);

%putting the response and no responses together for the table 

expf = [expf_ch
    expf_noch];
expd = [expd_ch
    expd_noch];
expvelsp = [expvelsp_ch
    expvelsp_noch];

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

corrltn = [corrltn_ch
    corrltn_noch];
corrpval = [corrpval_ch
    corrpval_noch];

T_disc = table(id,age,expf,expd,expvelsp,corrltn,corrpval,lognspmu,lognspsig,paretotimxmin,paretotimsig,smplsize,withch);
writetable(T_disc,'chr2ad_stepsizedist_timewin.csv')
save('chresp2ad_timewin_stepsizes.mat','distf_ch_day','distd_ch_day','distsp_ch_day','disttim_ch_day','velsp_ch_day'...
    ,'distf_noch_day','distd_noch_day','distsp_noch_day','disttim_noch_day','velsp_noch_day','id_age')
writetable(numberoffits_disc,'fittypes_chr2ad_timewin.csv')



