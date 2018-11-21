%Ritwika UC Merced
%IVFCR

clear all
clc
set(0,'defaulttextinterpreter','latex') %set default text interpreter to latex
%An attempt to find patterns in step sizes with and without adult responses

%AIC: 1 normal, 2 lognormal, 3 exponential, 4 pareto
load('adresp_zkm_match.mat')

%we'll find distances in f space, d space, vocal space, and time
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
    
ad_distf_subrec{j} = dis_f(zeromat == 1);
ad_distd_subrec{j} = dis_d(zeromat == 1);
ad_distsp_subrec{j} = dis_sp(zeromat == 1);
ad_disttim_subrec{j} = dis_t(zeromat == 1);
ad_velsp_subrec{j} = dis_sp(zeromat == 1)./dis_t(zeromat == 1);

noad_distf_subrec{j} = dis_f(zeromat == 0);
noad_distd_subrec{j} = dis_d(zeromat == 0);
noad_distsp_subrec{j} = dis_sp(zeromat == 0);
noad_disttim_subrec{j} = dis_t(zeromat == 0); 
noad_velsp_subrec{j} = dis_sp(zeromat == 0)./dis_t(zeromat == 0);   

end
end

%Now, we organise the distances - from each subrecording at this point -
%into single recordings per day per id.

%We need to check for empty matrices and also club together data from same
%id and age, by clubbing subrecordings

%first, we concatenate age and id
for i = 1:length(adr_id)  
    id_age{i} = sprintf('%s_%d',adr_id{i},adr_age(i));
end

%pick out unique combinations
id_age = unique(id_age);

for i  = 1:length(id_age)
    distf_ad_day{i} = [];
    distd_ad_day{i} = [];
    distsp_ad_day{i} = [];
    disttim_ad_day{i} = [];
    velsp_ad_day{i} = [];
    
    distf_noad_day{i} = [];
    distd_noad_day{i} = [];
    distsp_noad_day{i} = [];
    disttim_noad_day{i} = [];
    velsp_noad_day{i} = [];
    
    for j = 1:length(noad_distf_subrec)
        %check which id and age combinations match elements of id_age; also
        %check for empty matrices
    if (strcmp(id_age{i},sprintf('%s_%d',adr_id{j},adr_age(j))) == 1) && (isempty(noad_distsp_subrec{j}) == 0) && (isempty(ad_distsp_subrec{j}) == 0) 
        
        distf_ad_day{i} = [distf_ad_day{i} ad_distf_subrec{j}];%once we identify the ones that belong to same id and age, we concatenate them
        distd_ad_day{i} = [distd_ad_day{i} ad_distd_subrec{j}];
        distsp_ad_day{i} = [distsp_ad_day{i} ad_distsp_subrec{j}];
        disttim_ad_day{i} = [disttim_ad_day{i} ad_disttim_subrec{j}];
        velsp_ad_day{i} = [velsp_ad_day{i} ad_velsp_subrec{j}];
        
        distf_noad_day{i} = [distf_noad_day{i} noad_distf_subrec{j}];
        distd_noad_day{i} = [distd_noad_day{i} noad_distd_subrec{j}];
        distsp_noad_day{i} = [distsp_noad_day{i} noad_distsp_subrec{j}];
        disttim_noad_day{i} = [disttim_noad_day{i} noad_disttim_subrec{j}];
        velsp_noad_day{i} = [velsp_noad_day{i} noad_velsp_subrec{j}];
    end
    end
    
    
end

jj = 0;

%find aic values
for j = 1:length(distf_noad_day)
if (length(velsp_noad_day{j}) > 2 ) && (length(velsp_ad_day{j}) > 2) %need more than 2 points (at least) to fit

jj = jj + 1;
    
[aic_fad{jj},fad_fit(jj,1),p] = aicnew(distf_ad_day{j},[0 0 0 0],0);
[aic_dad{jj},dad_fit(jj,1),p] = aicnew(distd_ad_day{j},[0 0 0 0],0);
[aic_spad{jj},spad_fit(jj,1),p] = aicnew(distsp_ad_day{j},[0 0 0 0],0);
[aic_timad{jj},timad_fit(jj,1),p] = aicnew(disttim_ad_day{j},[0 0 0 0],0);
[aic_velspad{jj},velspad_fit(jj,1),p] = aicnew(velsp_ad_day{j},[0 0 0 0],0);

[aic_fnoad{jj},fnoad_fit(jj,1),p] = aicnew(distf_noad_day{j},[0 0 0 0],0);
[aic_dnoad{jj},dnoad_fit(jj,1),p] = aicnew(distd_noad_day{j},[0 0 0 0],0);
[aic_spnoad{jj},spnoad_fit(jj,1),p] = aicnew(distsp_noad_day{j},[0 0 0 0],0);
[aic_timnoad{jj},timnoad_fit(jj,1),p] = aicnew(disttim_noad_day{j},[0 0 0 0],0);
[aic_velspnoad{jj},velspnoad_fit(jj,1),p] = aicnew(velsp_noad_day{j},[0 0 0 0],0);

[r,p] = corrcoef(distsp_noad_day{j},disttim_noad_day{j});
corrltn_noad(jj,1) = r(1,2);
corrpval_noad(jj,1) = p(1,2);
    
[r,p] = corrcoef(distsp_ad_day{j},disttim_ad_day{j});
corrltn_ad(jj,1) = r(1,2);
corrpval_ad(jj,1) = p(1,2);

smplsi_ad(jj,1) = length(distf_ad_day{j})+length(distf_noad_day{j});
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

%freq, amp - exp
%sp, speed - lognormal
%time - with response is pareto, without is lognormal

for jj = 1:length(aic_fad)
    [aicdiff_fad(jj,1),fitindicator_fad(jj,1)] = aicvalues_fordifffits(aic_fad{jj},3); %frequency is exp
    [aicdiff_dad(jj,1),fitindicator_dad(jj,1)] = aicvalues_fordifffits(aic_dad{jj},3); %amplitude is exp
    [aicdiff_spad(jj,1),fitindicator_spad(jj,1)] = aicvalues_fordifffits(aic_spad{jj},2); % space is lognormal
    [aicdiff_timad(jj,1),fitindicator_timad(jj,1)] = aicvalues_fordifffits(aic_timad{jj},4); % time is preto (WR)
    [aicdiff_velspad(jj,1),fitindicator_velspad(jj,1)] = aicvalues_fordifffits(aic_velspad{jj},2); % speed is lognormal
    
    [aicdiff_fnoad(jj,1),fitindicator_fnoad(jj,1)] = aicvalues_fordifffits(aic_fnoad{jj},3); %frequency is exp
    [aicdiff_dnoad(jj,1),fitindicator_dnoad(jj,1)] = aicvalues_fordifffits(aic_dnoad{jj},3); %amplitude is exp
    [aicdiff_spnoad(jj,1),fitindicator_spnoad(jj,1)] = aicvalues_fordifffits(aic_spnoad{jj},2); % space is lognormal
    [aicdiff_timnoad(jj,1),fitindicator_timnoad(jj,1)] = aicvalues_fordifffits(aic_timnoad{jj},2); % time is lognormal (WOR)
    [aicdiff_velspnoad(jj,1),fitindicator_velspnoad(jj,1)] = aicvalues_fordifffits(aic_velspnoad{jj},2); % speed is lognormal
end

%store aicdifferences
T_aic = table(aicdiff_fad,aicdiff_dad,aicdiff_spad,aicdiff_timad,aicdiff_velspad,aicdiff_fnoad,aicdiff_dnoad,aicdiff_spnoad,aicdiff_timnoad,aicdiff_velspnoad,age,...
    fitindicator_fad,fitindicator_dad,fitindicator_spad,fitindicator_timad,fitindicator_velspad,fitindicator_fnoad,fitindicator_dnoad,fitindicator_spnoad,...
    fitindicator_timnoad,fitindicator_velspnoad);
writetable(T_aic,'adresp2ch_tw_aicdiff.csv')

%now, knowing that frequency and amplitude spaces fit best - by and large -
%to exponential, vocal space and time to lognormal, etc. we will consider
%those corresponding fits for all distributions, depending on whetehr they
%are in f, d, acoustic, or temporal space, etc.

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
        
        [a b c d] = aic_timad{i}.mle; %pick out the fourth value - pareto 
        paretotim_ad{i} = d.params;
        
        [a b c d] = aic_timnoad{i}.mle; %pick out the second value - lognormal
        logntim_noad{i} = b.params;
        
        [a b c d] = aic_velspad{i}.mle; %pick out the second value - lognormal
        lognvelsp_ad{i} = b.params;
        
        [a b c d] = aic_velspnoad{i}.mle; %pick out the third value - lognormal
        lognvelsp_noad{i} = b.params;
        
         
end

 
for i = 1:length(expf_ad) %putting it all together to write into a csv file
   
    lognspad = lognsp_ad{i};
    lognspnoad = lognsp_noad{i};
    paretotimad = paretotim_ad{i};
    logntimnoad = logntim_noad{i};
    lognvelspad = lognvelsp_ad{i};
    lognvelspnoad = lognvelsp_noad{i};
   
    lognspmu_ad(i,1) = lognspad(1);
    lognspsig_ad(i,1) = lognspad(2);
    lognspmu_noad(i,1) = lognspnoad(1);
    lognspsig_noad(i,1) = lognspnoad(2);
    paretotimxmin_ad(i,1) = paretotimad(1);
    paretotimsig_ad(i,1) = paretotimad(2);
    logntimmu_noad(i,1) = logntimnoad(1);
    logntimsig_noad(i,1) = logntimnoad(2);
    lognvelspmu_ad(i,1) = lognvelspad(1);
    lognvelspsig_ad(i,1) = lognvelspad(2);
    lognvelspmu_noad(i,1) = lognvelspnoad(1);
    lognvelspsig_noad(i,1) = lognvelspnoad(2);

end

%recording the kind of fits for each category

numberoffits_disc = table(age,id,fad_fit,dad_fit,spad_fit,timad_fit,velspad_fit,fnoad_fit,dnoad_fit,spnoad_fit,timnoad_fit,velspnoad_fit);

%putting the responses and no responses together for the table 

expf = [expf_ad
    expf_noad];
expd = [expd_ad
    expd_noad];

lognspmu = [lognspmu_ad
    lognspmu_noad];
lognspsig = [lognspsig_ad
    lognspsig_noad];

lognvelspmu = [lognvelspmu_ad
    lognvelspmu_noad];
lognvelspsig = [lognvelspsig_ad
    lognvelspsig_noad];

timmu_xmin = [paretotimxmin_ad
    logntimmu_noad];
timsig = [paretotimsig_ad
    logntimsig_noad];
smplsize = [smplsi_ad
    smplsi_ad];
age = [age
    age];
id = [id
    id];
yesad = ones(size(expf_ad));
noad = zeros(size(expf_noad));
withad = [yesad
    noad];

corrltn = [corrltn_ad
    corrltn_noad];
corrpval = [corrpval_ad
    corrpval_noad];

save('adresp2ch_timewin_stepsizes.mat','distf_ad_day','distd_ad_day','distsp_ad_day','disttim_ad_day','velsp_ad_day'...
    ,'distf_noad_day','distd_noad_day','distsp_noad_day','disttim_noad_day','velsp_noad_day','id_age')

T_disc = table(id,age,expf,expd,corrltn,corrpval,lognspmu,lognspsig,lognvelspmu,lognvelspsig,timmu_xmin,timsig,smplsize,withad);
writetable(T_disc,'adresp2ch_stepsizedist_timewin.csv')
writetable(numberoffits_disc,'fittypes_adresp2ch_timewin.csv')
