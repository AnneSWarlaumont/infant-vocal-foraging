%Ritwika VPS, UC Merced
%miscellaneous findings: correlation b/n space and time, range of acoustic
%space with age

clear all
clc

load('chresp_zkm_match.mat')

%find distances
for j = 1:length(chr2ad_zlogf)

clear dis_sp dis_t 

st = chr2ad_st{j};
en = chr2ad_en{j}; 
f = chr2ad_zlogf{j};
d = chr2ad_zd{j};

if length(st) > 1 %need at least two elements to make a distance

%find distance
for i = 1:length(st)-1
    dis_sp(i) = sqrt((d(i+1)-d(i))^2 + (f(i+1)-f(i))^2);
    dis_t(i) = st(i+1) - en(i);
end

dis_sp_subrec{j} = dis_sp;
dis_t_subrec{j} = dis_t;

end
end

%We need to check for empty matrices and also club together data from same
%id and age, by clubbing subrecordings

%first, we concatenate age and id
for i = 1:length(chr2ad_id)  
    id_age{i} = sprintf('%s_%d',chr2ad_id{i},chr2ad_age(i));
end

%pick out unique combinations
id_age = unique(id_age);

for i  = 1:length(id_age)
    distsp_day{i} = [];
    disttim_day{i} = [];
    f_day{i} = [];
    d_day{i} = [];
    
    for j = 1:length(dis_sp_subrec)
        %check which id and age combinations match elements of id_age; also
        %check for empty matrices
    if (strcmp(id_age{i},sprintf('%s_%d',chr2ad_id{j},chr2ad_age(j))) == 1) && (isempty(dis_sp_subrec{j}) == 0)  
        
        distsp_day{i} = [distsp_day{i} dis_sp_subrec{j}];
        disttim_day{i} = [disttim_day{i} dis_t_subrec{j}];
        f_day{i} = [f_day{i} transpose(chr2ad_zlogf{j})];
        d_day{i} = [d_day{i} transpose(chr2ad_zd{j})];
        
    end
    end
        
end

i_count = 0;
%finding correlation etc.
for i = 1:length(id_age)
    if isempty(f_day{i}) == 0
    i_count = i_count+1;
    mean_f_ad(i_count,1) = nanmean(f_day{i});
    std_f_ad(i_count,1) = nanstd(f_day{i});
    max_f_ad(i_count,1) = max(f_day{i});
    min_f_ad(i_count,1) = min(f_day{i});
    
    mean_d_ad(i_count,1) = nanmean(d_day{i});
    std_d_ad(i_count,1) = nanstd(d_day{i});
    max_d_ad(i_count,1) = max(d_day{i});
    min_d_ad(i_count,1) = min(d_day{i});
    
    sp = distsp_day{i};
    tim = disttim_day{i};
    tim = tim(isnan(sp) == 0);
    sp = sp(isnan(sp) == 0);
    [r,p] = corrcoef(sp,tim);
    corrltn_ad(i_count,1) = r(1,2);
    corrpval_ad(i_count,1) = p(1,2);
    
    samplsi(i_count,1) = length(d_day{i});
    agestr = strsplit(id_age{i},'_');  %finds age by splitting the id_age string
    id{i_count,1} = agestr{1};
    age(i_count,1) = str2num(agestr{2});
    end
end


T = table(mean_f_ad,std_f_ad,max_f_ad,min_f_ad,mean_d_ad,std_d_ad,max_d_ad,min_d_ad,corrltn_ad,corrpval_ad,samplsi,id,age);
writetable(T,'advoc_corrltn_mean.csv')