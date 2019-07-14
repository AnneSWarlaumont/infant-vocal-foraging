%Ritwika UC Merced
%IVFCR

%child vocalisations  

%Step sizes in pitch/frequency, amplitude, time and acoustic space are analysed WITHOUTm
%sorting into WR (following a response) and WOR (following a
%non-response). Step size distributions are then fitted to the best
%candidate distribution based on AIC criterion. The candidate distributions
%are normal, lognormal, exponential, and pareto. 

%IMPORTANT: Here, step size distributions are categorised without splitting into WR
%and WOR

clear all
%clc

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

%remove nan values - space steps would have any nan values fork bth f and
%d, so that is teh ideal standard to remove nans based on 
dis_t = dis_t(isnan(dis_sp) == 0);
dis_f = dis_f(isnan(dis_sp) == 0);
dis_d = dis_d(isnan(dis_sp) == 0);
dis_sp = dis_sp(isnan(dis_sp) == 0);

%populate cell array for subrecordings 
distf_subrec{j} = dis_f;
distd_subrec{j} = dis_d;
distsp_subrec{j} = dis_sp;
disttim_subrec{j} = dis_t;
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

%subrecordings from he same infant on the same day are bundled together -
%note that doing so after generating step size vectors eliminate bogus step
%sizes from the end of onde subrecoding to the beginning of the next
for i  = 1:length(id_age)
    distf_day{i} = [];
    distd_day{i} = [];
    distsp_day{i} = [];
    disttim_day{i} = [];
    
    for j = 1:length(distf_subrec)
        %check which id and age combinations match elements of id_age; also
        %check for empty matrices
    if (strcmp(id_age{i},sprintf('%s_%d',adr_id{j},adr_age(j))) == 1) && (isempty(distsp_subrec{j}) == 0) 
        
        distf_day{i} = [distf_day{i} distf_subrec{j}];%once we identify the ones that belong to same id and age, we concatenate them
        distd_day{i} = [distd_day{i} distd_subrec{j}];
        distsp_day{i} = [distsp_day{i} distsp_subrec{j}];
        disttim_day{i} = [disttim_day{i} disttim_subrec{j}];

    end
    end
       
end

jj = 0;

%find aic values
for j = 1:length(distf_day)
if (length(distsp_day{j}) > 2 ) %need more than 2 points (at least) to fit

jj = jj + 1;
    
[aic_f{jj},f_fit(jj,1),p] = aicnew(distf_day{j},[0 0 0 0],0);
[aic_d{jj},d_fit(jj,1),p] = aicnew(distd_day{j},[0 0 0 0],0);
[aic_sp{jj},sp_fit(jj,1),p] = aicnew(distsp_day{j},[0 0 0 0],0);
[aic_tim{jj},tim_fit(jj,1),p] = aicnew(disttim_day{j},[0 0 0 0],0);

smplsi(jj,1) = length(distf_day{j});
agestr = strsplit(id_age{j},'_');  %finds age by splitting the id_age string
id{jj,1} = agestr{1};
age(jj,1) = str2num(agestr{2});

rsq_f_chvoc(jj,1) = aicfit_rsq(distf_day{j});
rsq_d_chvoc(jj,1) = aicfit_rsq(distd_day{j});
rsq_sp_chvoc(jj,1) = aicfit_rsq(distsp_day{j});  
rsq_t_chvoc(jj,1) = aicfit_rsq(disttim_day{j});

end
end

clear jj

%now, knowing that frequency and amplitude spaces fit best - by and large -
%to exponential, vocal space and time to lognormal, etc. we will consider
%those corresponding fits for all distributions, depending on whetehr they
%are in f, d, acoustic, or temporal space, etc.

for i  = 1:length(f_fit)
        
        [a b c d] = aic_f{i}.mle; %pick out the third value - exponential
        expf(i,1) = c.params;
        
        [a b c d] = aic_d{i}.mle; %pick out the third value - exponential
        expd(i,1) = c.params;
        
        [a b c d] = aic_sp{i}.mle; %pick out the second value - lognormal
        lognsp{i} = b.params;
        
        [a b c d] = aic_tim{i}.mle; %pick out the second value - lognoram
        logntim{i} = b.params;
                 
end

for i = 1:length(expf) %putting it all together to write into a csv file
   
    lognspch = lognsp{i};
    logntimch = logntim{i};
    
    lognspmu(i,1) = lognspch(1);
    lognspsig(i,1) = lognspch(2);
    logntimmu(i,1) = logntimch(1);
    logntimsig(i,1) = logntimch(2);
    
end

rsq_tab = table(age,id,smplsi, rsq_f_chvoc,rsq_d_chvoc,rsq_sp_chvoc,rsq_t_chvoc); %writs rsq table
writetable(rsq_tab,'rsq_chvoc_noWR_WOR.csv')  

save('chvoc_stepsizes_noWR_WOR.mat','distf_day','distd_day','distsp_day','disttim_day','id_age')

T_disc = table(id,age,expf,expd,lognspmu,lognspsig,logntimmu,logntimsig,smplsi);
writetable(T_disc,'chvoc_stepsizedist_noWR_WOR.csv')

%recording the kind of fits for each category
numberoffits_disc = table(age,id,f_fit,d_fit,sp_fit,tim_fit);
writetable(numberoffits_disc,'fittypes_chvoc_noWR_WOR.csv')



