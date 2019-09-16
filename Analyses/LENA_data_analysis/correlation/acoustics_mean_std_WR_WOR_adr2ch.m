%Ritwika UC Merced
%IVFCR

%Mean pitch and amplitude values for WR and WOR - for lmer test 

%Child vocalisations

clear all
clc

load('adresp_zkm_match.mat')

for j = 1:length(adr_st)

clear dis_t

st = adr_st{j};
en = adr_en{j};
r = adresponse{j}; 
f = adr_zlogf{j};
d = adr_zd{j};

if length(st) > 1 %need at least two elements to make a distance
   
%We will use steps in time to control for the 1 s delay in determining
%response = 1
for i = 1:length(d)-1 
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

%Now, we want to see what happens to mean and std f and d values following
%and not following response. So, we need to collect the f and d values for
%vocs following each r(i). That is, if r(i) = 1, then f(i+1) would be WR,
%and so on. To do this, we could shift r forward by adding an NAN to the
%beginning of r and then trim it to fit the length of f and d
r = [NaN r];

f = f(2:end); %we don't know if the first value in each subrecording is WR or WOR
d = d(2:end);
r = r(2:end-1); %end-1 here is to account for the NaN shift

%Note that each set of f or d values are from a subrecording (ergo the _subrec)
ad_f_subrec{j} = f(r == 1);%WR when response is received (note that this is for if ith vocs recieved response, we are counting i+1 f/d as WR
ad_d_subrec{j} = d(r == 1);

noad_f_subrec{j} = f(r == 0);%WOR when response is not received
noad_d_subrec{j} = d(r == 0);

end
end

%Now, we organise the acoustic measure values - from each subrecording at this point -
%into single recordings per day per id.

%We need to check for empty matrices and also club together data from same
%id and age, by clubbing subrecordings (_day)

%first, we concatenate age and id
for i = 1:length(adr_id)  
    id_age{i} = sprintf('%s_%d',adr_id{i},adr_age(i));
end

%pick out unique combinations
id_age = unique(id_age);

%subrecordings from he same infant on the same day are bundled together 
jj = 0;

for i  = 1:length(id_age)
    f_ad_day{i} = [];
    d_ad_day{i} = [];
    
    f_noad_day{i} = [];
    d_noad_day{i} = [];
     
    for j = 1:length(noad_f_subrec)
        %check which id and age combinations match elements of id_age; also
        %check for empty matrices
    if (strcmp(id_age{i},sprintf('%s_%d',adr_id{j},adr_age(j))) == 1) && (isempty(noad_f_subrec{j}) == 0) && (isempty(ad_f_subrec{j}) == 0) 
        
        f_ad_day{i} = [f_ad_day{i} 
            ad_f_subrec{j}];%once we identify the ones that belong to same id and age, we concatenate them
        d_ad_day{i} = [d_ad_day{i} 
            ad_d_subrec{j}];
        
        f_noad_day{i} = [f_noad_day{i} 
            noad_f_subrec{j}];
        d_noad_day{i} = [d_noad_day{i} 
            noad_d_subrec{j}];
           
    end
    end
    
    if (isempty(f_noad_day{i}) == 0 ) && (isempty(f_ad_day{i}) == 0) %if they are both not empty
        
        jj = jj + 1;
        
        f_mean_ad(jj,1) = nanmean(f_ad_day{i});
        d_mean_ad(jj,1) = nanmean(d_ad_day{i});
        f_mean_noad(jj,1) = nanmean(f_noad_day{i});
        d_mean_noad(jj,1) = nanmean(d_noad_day{i});
        
        f_std_ad(jj,1) = nanstd(f_ad_day{i});
        d_std_ad(jj,1) = nanstd(d_ad_day{i});
        f_std_noad(jj,1) = nanstd(f_noad_day{i});
        d_std_noad(jj,1) = nanstd(d_noad_day{i});
        
        agestr = strsplit(id_age{i},'_');  %finds age by splitting the id_age string
        id{jj,1} = agestr{1};
        age(jj,1) = str2num(agestr{2});
    
    end
    
end


%putting the child and no child responses together for the table 

fmean = [f_mean_ad
    f_mean_noad];
dmean = [d_mean_ad
    d_mean_noad];

fstd = [f_std_ad
    f_std_noad];
dstd = [d_std_ad
    d_std_noad];

age = [age
    age];
id = [id
    id];
yesch = ones(size(f_std_ad));
noch = zeros(size(f_std_noad));
response = [yesch
    noch];

T_disc = table(id,age,response,fmean,dmean,fstd,dstd);

writetable(T_disc,'acoustics_meanstd_WR_WOR_adr2ch.csv')






