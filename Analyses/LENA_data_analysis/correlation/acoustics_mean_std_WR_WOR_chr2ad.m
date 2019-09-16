%Ritwika UC Merced
%IVFCR

%Mean pitch and amplitude values for WR and WOR - for lmer test 

%Adult vocalisations

clear all
clc

load('chresp_zkm_match.mat')

%we'll find distances in f space, d space, vocal space, and time
for j = 1:length(chr2ad_en)

clear dis_t

st = chr2ad_st{j};
en = chr2ad_en{j};
r = chr2ad{j}; 
f = chr2ad_zlogf{j};
d = chr2ad_zd{j};

if length(st) > 1 %need at least two elements to make a distance
   
%find distance
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
ch_f_subrec{j} = f(r == 1);%WR when response is received (note that this is for if ith vocs recieved response, we are counting i+1 f/d as WR
ch_d_subrec{j} = d(r == 1);

noch_f_subrec{j} = f(r == 0);
noch_d_subrec{j} = d(r == 0);

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

%subrecordings from he same infant on the same day are bundled together 
jj = 0;

for i  = 1:length(id_age)
    f_ch_day{i} = [];
    d_ch_day{i} = [];
     
    f_noch_day{i} = [];
    d_noch_day{i} = [];
    
    for j = 1:length(noch_f_subrec)
        %check which id and age combinations match elements of id_age; also
        %check for empty matrices
    if (strcmp(id_age{i},sprintf('%s_%d',chr2ad_id{j},chr2ad_age(j))) == 1) && (isempty(noch_f_subrec{j}) == 0) && (isempty(ch_f_subrec{j}) == 0) 
        
        f_ch_day{i} = [f_ch_day{i} 
            ch_f_subrec{j}];%once we identify the ones that belong to same id and age, we concatenate them
        d_ch_day{i} = [d_ch_day{i} 
            ch_d_subrec{j}];
        
        f_noch_day{i} = [f_noch_day{i} 
            noch_f_subrec{j}];
        d_noch_day{i} = [d_noch_day{i} 
            noch_d_subrec{j}];
           
    end
    end
    
    if (isempty(f_noch_day{i}) == 0 ) && (isempty(f_ch_day{i}) == 0)
        
        jj = jj + 1;
        
        f_mean_ch(jj,1) = nanmean(f_ch_day{i});
        d_mean_ch(jj,1) = nanmean(d_ch_day{i});
        f_mean_noch(jj,1) = nanmean(f_noch_day{i});
        d_mean_noch(jj,1) = nanmean(d_noch_day{i});
        
        f_std_ch(jj,1) = nanstd(f_ch_day{i});
        d_std_ch(jj,1) = nanstd(d_ch_day{i});
        f_std_noch(jj,1) = nanstd(f_noch_day{i});
        d_std_noch(jj,1) = nanstd(d_noch_day{i});
        
        agestr = strsplit(id_age{i},'_');  %finds age by splitting the id_age string
        id{jj,1} = agestr{1};
        age(jj,1) = str2num(agestr{2});
    
    end
    
end


%putting the child and no child responses together for the table 

fmean = [f_mean_ch
    f_mean_noch];
dmean = [d_mean_ch
    d_mean_noch];

fstd = [f_std_ch
    f_std_noch];
dstd = [d_std_ch
    d_std_noch];

age = [age
    age];
id = [id
    id];
yesch = ones(size(f_std_ch));
noch = zeros(size(f_std_noch));
response = [yesch
    noch];

T_disc = table(id,age,response,fmean,dmean,fstd,dstd);

writetable(T_disc,'acoustics_meanstd_WR_WOR_chr2ad.csv')






