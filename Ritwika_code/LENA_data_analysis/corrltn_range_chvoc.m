%Ritwika VPS, UC Merced
%miscellaneous findings: correlation b/n space and time, range of acoustic
%space with age

clear all
clc

load('data_zkm.mat')

%find distances
for j = 1:length(z_logfch)

clear dis_sp dis_t 

st = start_ch{j};
en = end_ch{j};
f = z_logfch{j};
d = z_dch{j};

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
for i = 1:length(id)  
    id_age{i} = sprintf('%s_%d',id{i},age(i));
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
    if (strcmp(id_age{i},sprintf('%s_%d',id{j},age(j))) == 1) && (isempty(dis_sp_subrec{j}) == 0)  
        
        distsp_day{i} = [distsp_day{i} dis_sp_subrec{j}];
        disttim_day{i} = [disttim_day{i} dis_t_subrec{j}];
        f_day{i} = [f_day{i} transpose(z_logfch{j})];
        d_day{i} = [d_day{i} transpose(z_dch{j})];
        
    end
    end
        
end


%finding correlation etc.
for i = 1:length(id_age)
    mean_f_ch(i,1) = nanmean(f_day{i});
    std_f_ch(i,1) = nanstd(f_day{i});
    max_f_ch(i,1) = max(f_day{i});
    min_f_ch(i,1) = min(f_day{i});
    
    mean_d_ch(i,1) = nanmean(d_day{i});
    std_d_ch(i,1) = nanstd(d_day{i});
    max_d_ch(i,1) = max(d_day{i});
    min_d_ch(i,1) = min(d_day{i});
    
    sp = distsp_day{i};
    tim = disttim_day{i};
    tim = tim(isnan(sp) == 0);
    sp = sp(isnan(sp) == 0);
    [r,p] = corrcoef(sp,tim);
    corrltn_ch(i,1) = r(1,2);
    corrpval_ch(i,1) = p(1,2);
    
    samplsi(i,1) = length(d_day{i});
    agestr = strsplit(id_age{i},'_');  %finds age by splitting the id_age string
    id_ch{i,1} = agestr{1};
    age_ch(i,1) = str2num(agestr{2});
end

age = age_ch;
id = id_ch;

T = table(mean_f_ch,std_f_ch,max_f_ch,min_f_ch,mean_d_ch,std_d_ch,max_d_ch,min_d_ch,corrltn_ch,corrpval_ch,samplsi,id,age);
writetable(T,'chvoc_corrltn_mean.csv')