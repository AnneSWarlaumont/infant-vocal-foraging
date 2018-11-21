function [smplsi_binary,vocslastrep_mat_binary,sp_avg_binary,sp_CIneg_binary,...
    sp_CIpos_binary,d_avg_binary,d_CIneg_binary,d_CIpos_binary,f_avg_binary,...
    f_CIneg_binary,f_CIpos_binary,t_avg_binary,t_CIneg_binary,t_CIpos_binary,...
    vel_avg_binary,vel_CIneg_binary,vel_CIpos_binary,infantage_binary,id_binary] = tableformeanststats(sp_vel,sp_dist,d_dist,f_dist,t_dist,id_age,n,binary_or_firsttwo)

%Ritwika VPS, UC Merced
%n specifies where the cut off of binning all steps for i to i+1 for i >= n
%should fall. And n is limited to length(vector) - 1. 

%binary_or_firsttwo decides the kind of analysis: binary loosely encompasses
%a seperation of means for i to i+1 for i <= n-1, and all steps/speeds after that
%being bundled into one single group

%firsttwo would mean that only the first two steps/velocities since last
%response is considered for analysis
if strcmp(binary_or_firsttwo,'binary') == 1 
counter = 0;

for i = 1:length(f_dist)
    
    if isempty(sp_vel{i}) == 0
    
    %find mean CI, etc of different measures 
    %numofobs is now many points that specific entry has
    %numofvoc is essentially 0 to n
    counter = counter + 1;
    [velmean_rec,vCIneg,vCIpos,num_ofobs,numofvoc] = mean_std_binary(sp_vel{i},n);
    [spmean_rec,spCIneg,spCIpos,num_ofobs,numofvoc] = mean_std_binary(sp_dist{i},n);
    [dmean_rec,dCIneg,dCIpos,num_ofobs,numofvoc] = mean_std_binary(d_dist{i},n);
    [fmean_rec,fCIneg,fCIpos,num_ofobs,numofvoc] = mean_std_binary(f_dist{i},n);
    [tmean_rec,tCIneg,tCIpos,num_ofobs,numofvoc] = mean_std_binary(t_dist{i},n);
    
    %remove NaN entries and entries corresponding to NaN
    num_ofobs = num_ofobs(isnan(velmean_rec) == 0);
    numofvoc = numofvoc(isnan(velmean_rec) == 0);
    spmean_rec = spmean_rec(isnan(velmean_rec) == 0);
    dmean_rec = dmean_rec(isnan(velmean_rec) == 0);
    fmean_rec = fmean_rec(isnan(velmean_rec) == 0);
    tmean_rec = tmean_rec(isnan(velmean_rec) == 0);
    velmean_rec = velmean_rec(isnan(velmean_rec) == 0);
    
    samplesize_binary{counter,1} = num_ofobs;
    vocsincelastresp_binary{counter,1} = transpose(numofvoc); %numofvoc is a row vector
    meanofspace_binary{counter,1} = spmean_rec;
    meanofd_binary{counter,1} = dmean_rec;
    meanoff_binary{counter,1} = fmean_rec;
    meanoft_binary{counter,1} = tmean_rec;
    meanofvel_binary{counter,1} = velmean_rec;
    
    vel_CIneg_bi{counter,1} = vCIneg;
    vel_CIpos_bi{counter,1} = vCIpos;
    sp_CIneg_bi{counter,1} = spCIneg;
    sp_CIpos_bi{counter,1} = spCIpos;
    f_CIneg_bi{counter,1} = fCIneg;
    f_CIpos_bi{counter,1} = fCIpos;
    d_CIneg_bi{counter,1} = dCIneg;
    d_CIpos_bi{counter,1} = dCIpos;
    t_CIneg_bi{counter,1} = tCIneg;
    t_CIpos_bi{counter,1} = tCIpos;
    
    %now, we need to add child id and age
    aa = strsplit(id_age{i},'_');
    age_binary{counter,1} = str2num(aa{2})*ones(size(samplesize_binary{counter,1}));
    [placeholderforid{1:length(samplesize_binary{counter,1})}] = deal(aa{1});
    id_binary{counter,1} = transpose(placeholderforid);
    clear placeholderforid
    end
end
%vertically concatenates id
id_binary = vertcat(id_binary{:});

smplsi_binary = cell2mat(samplesize_binary);
vocslastrep_mat_binary = cell2mat(vocsincelastresp_binary);
sp_avg_binary = cell2mat(meanofspace_binary);
t_avg_binary = cell2mat(meanoft_binary);
f_avg_binary = cell2mat(meanoff_binary);
d_avg_binary = cell2mat(meanofd_binary);
vel_avg_binary = cell2mat(meanofvel_binary);
infantage_binary = cell2mat(age_binary);

vel_CIneg_binary = cell2mat(vel_CIneg_bi);
vel_CIpos_binary = cell2mat(vel_CIpos_bi);
sp_CIneg_binary = cell2mat(sp_CIneg_bi);
sp_CIpos_binary = cell2mat(sp_CIpos_bi);
f_CIneg_binary = cell2mat(f_CIneg_bi);
f_CIpos_binary = cell2mat(f_CIpos_bi);
d_CIneg_binary = cell2mat(d_CIneg_bi);
d_CIpos_binary = cell2mat(d_CIpos_bi);
t_CIneg_binary = cell2mat(t_CIneg_bi);
t_CIpos_binary = cell2mat(t_CIpos_bi);



else %here,we accomodate for just the first two averages: ie, from 0 to 1 and 1 to 2, since last response

counter = 0;
for i = 1:length(f_dist)
    
    if isempty(sp_vel{i}) == 0
    
    counter = counter + 1;
    [velmean_rec,aa,vCIneg,vCIpos,num_ofobs,numofvoc] = mean_std_95CI(sp_vel{i});
    [spmean_rec,aa,spCIneg,spCIpos,num_ofobs,numofvoc] = mean_std_95CI(sp_dist{i});
    [dmean_rec,aa,dCIneg,dCIpos,num_ofobs,numofvoc] = mean_std_95CI(d_dist{i});
    [fmean_rec,aa,fCIneg,fCIpos,num_ofobs,numofvoc] = mean_std_95CI(f_dist{i});
    [tmean_rec,aa,tCIneg,tCIpos,num_ofobs,numofvoc] = mean_std_95CI(t_dist{i});
    
    %numvoc is a row vector
    %remove NaN entries and entries corresponding to NaN
    num_ofobs = num_ofobs(isnan(velmean_rec) == 0);
    numofvoc = transpose(numofvoc(isnan(velmean_rec) == 0));
    spmean_rec = spmean_rec(isnan(velmean_rec) == 0);
    dmean_rec = dmean_rec(isnan(velmean_rec) == 0);
    fmean_rec = fmean_rec(isnan(velmean_rec) == 0);
    tmean_rec = tmean_rec(isnan(velmean_rec) == 0);
    velmean_rec = velmean_rec(isnan(velmean_rec) == 0);
    
    %only keep entries that have 0 and 1 for num of vocs
    num_ofobs = num_ofobs(numofvoc <= 1);
    spmean_rec = spmean_rec(numofvoc <= 1);
    dmean_rec = dmean_rec(numofvoc <= 1);
    fmean_rec = fmean_rec(numofvoc <= 1);
    tmean_rec = tmean_rec(numofvoc <= 1);
    velmean_rec = velmean_rec(numofvoc <= 1);
    vCIneg = vCIneg(numofvoc <= 1);
    vCIpos = vCIpos(numofvoc <= 1);
    spCIneg = spCIneg(numofvoc <= 1);
    spCIpos = spCIpos(numofvoc <= 1);
    fCIneg = fCIneg(numofvoc <= 1);
    fCIpos = fCIpos(numofvoc <= 1);
    dCIneg = dCIneg(numofvoc <= 1);
    dCIpos = dCIpos(numofvoc <= 1);
    tCIneg = tCIneg(numofvoc <= 1);
    tCIpos = tCIpos(numofvoc <= 1);
    numofvoc = numofvoc(numofvoc <= 1);
    
    samplesize_binary{counter,1} = num_ofobs;
    vocsincelastresp_binary{counter,1} = numofvoc;
    meanofspace_binary{counter,1} = spmean_rec;
    meanofd_binary{counter,1} = dmean_rec;
    meanoff_binary{counter,1} = fmean_rec;
    meanoft_binary{counter,1} = tmean_rec;
    meanofvel_binary{counter,1} = velmean_rec;
    
    vel_CIneg{counter,1} = vCIneg;
    vel_CIpos{counter,1} = vCIpos;
    sp_CIneg{counter,1} = spCIneg;
    sp_CIpos{counter,1} = spCIpos;
    f_CIneg{counter,1} = fCIneg;
    f_CIpos{counter,1} = fCIpos;
    d_CIneg{counter,1} = dCIneg;
    d_CIpos{counter,1} = dCIpos;
    t_CIneg{counter,1} = tCIneg;
    t_CIpos{counter,1} = tCIpos;
    
    %now, we need to add child id and age
    aa = strsplit(id_age{i},'_');
    age_binary{counter,1} = str2num(aa{2})*ones(size(samplesize_binary{counter,1}));
    [placeholderforid{1:length(samplesize_binary{counter,1})}] = deal(aa{1});
    id_binary{counter,1} = transpose(placeholderforid);
    clear placeholderforid
    end
end
%vertically concatenates id
id_binary = vertcat(id_binary{:});

smplsi_binary = cell2mat(samplesize_binary);
vocslastrep_mat_binary = cell2mat(vocsincelastresp_binary);
sp_avg_binary = cell2mat(meanofspace_binary);
t_avg_binary = cell2mat(meanoft_binary);
f_avg_binary = cell2mat(meanoff_binary);
d_avg_binary = cell2mat(meanofd_binary);
vel_avg_binary = cell2mat(meanofvel_binary);
infantage_binary = cell2mat(age_binary);

vel_CIneg_binary = cell2mat(vel_CIneg);
vel_CIpos_binary = cell2mat(vel_CIpos);
sp_CIneg_binary = cell2mat(sp_CIneg);
sp_CIpos_binary = cell2mat(sp_CIpos);
f_CIneg_binary = cell2mat(f_CIneg);
f_CIpos_binary = cell2mat(f_CIpos);
d_CIneg_binary = cell2mat(d_CIneg);
d_CIpos_binary = cell2mat(d_CIpos);
t_CIneg_binary = cell2mat(t_CIneg);
t_CIpos_binary = cell2mat(t_CIpos);
    
    
    
    
end
end
