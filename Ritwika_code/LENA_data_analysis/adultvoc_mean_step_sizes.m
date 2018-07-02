%Ritwika, UC Merced
%March 20, 2018 - code to look at mean step size between
%vocalisations for different measures (amplitude, log frequency, acoustic
%space, time, velocities, etc.) as a function of distance from last
%response - in terms of number of responses.

clear all
clc

%we also stop seperating discrete and continuous datasets

%AIC: 1 normal, 2 lognormal, 3 exponential, 4 pareto
load('chresp_zkm_match.mat')

%we'll find distances in f space, d space, vocal space, and time
for j = 1:length(chr2ad_en)

clear dis_f dis_d dis_sp dis_t r_mirr

st = chr2ad_st{j};
en = chr2ad_en{j};
r = chr2ad{j}; 
f = chr2ad_zlogf{j};
d = chr2ad_zd{j};

if length(st) > 1 %need at least two elements to make a distance

%find distance
for i = 1:length(r)-1
    dis_f(i) = sqrt((f(i+1)-f(i))^2);
    dis_d(i) = sqrt((d(i+1)-d(i))^2);
    dis_sp(i) = sqrt((d(i+1)-d(i))^2 + (f(i+1)-f(i))^2);
    dis_t(i) = st(i+1) - en(i);
end

%Here, we create a mirror matrix for r (Response) so that it counts the
%number of occurences of no response after each response. So, if
%vocalisation i recives a response, and then the next 3 do not, the mirror
%matrix will count 1,2,3, for i+1, i+2, i+3, and then reset to zero for
%i+4, which is where the next response is

%mirror is assigned NaN till the first response is received.
%Then, at the first response, mirror resets to zero, and counts till the
%next response is received and so on
r_count = NaN;
for i = 1:length(r)
   if r(i) == 1
       r_count = 0;
   end
   r_mirr(i) = r_count;
   r_count = r_count + 1;   
end

%Now, we need to find where the first response is received 
r_ind = 1:length(r_mirr);
r_ind = r_ind(r_mirr == 0); %find indices of all responses, because responses => r_mirr = 0
r_ind = min(r_ind); %The minimum if this index gives the first response received, and this is where the analysis should start
%since there is no way to know how many vocalisations have pccured before
%the last response, given that there is no record of taht in the given
%dataset

r = r(r_ind:end);
r_mirr = r_mirr(r_ind:end);

r_max = max(r_mirr(1:end-1)); %So that we know what is the maximum stretch that goes without a response
%we have an end-1 since the last vocalisation does not have a distance
%associated with it, and hence, if the maximum value of non-responses occur
%at the last vocalisation, it wouldn't have a corresponding distance

%Now, we go ahead and take only distances corresponding to the redefined
%response matrix

if isempty(r) ==0 %make sure that updated response matrix is not empty

r_mirrmax(j) = max(r_mirr);

dis_f = dis_f(r_ind:end); %cut down distance and velocuty matrices to the size of updated response matrix
dis_d = dis_d(r_ind:end);
dis_sp = dis_sp(r_ind:end);
dis_t = dis_t(r_ind:end);

%remove nan values - space steps would have any nan values fork bth f and
%d, so that is teh ideal standard to remove nans based on 
dis_t = dis_t(isnan(dis_sp) == 0);
dis_f = dis_f(isnan(dis_sp) == 0);
dis_d = dis_d(isnan(dis_sp) == 0);
r_mirr = r_mirr(isnan(dis_sp) == 0);
dis_sp = dis_sp(isnan(dis_sp) == 0);

vel_sp = dis_sp./dis_t;

%Create an empty array with size r_max+1. Essentially, if the longest
%stretch of non responses after a response (for the given data set) is n,
%then there are n+1 possible options - 0 (0 vocalisations after response -
%for consective responses, for eg), 1, 2, ...,n non-responses after
%response. So, if the step size between i nonresponses to the next
%vocalisation is some d, then it gets stored in the matrix corresponding to
% i (indexed by i+1, since zero is indexed at 1), in the cell array, and so
% on
sortedmatrix_disf = cell(r_max+1,1); 
sortedmatrix_disd = cell(r_max+1,1);
sortedmatrix_dissp = cell(r_max+1,1);
sortedmatrix_dist = cell(r_max+1,1);
sortedmatrix_velsp = cell(r_max+1,1);

%Here, if distance (or velocity) d corresponds to i nonresponses, then it
%gets sorted into the i+1th bin of the corresponding sortedmatrix cell
%array (given that the time step to the next vocalisation is greater than
%or equal to 1 s, since we need to add this control so that steps aren't biased wrt adult responses received - you have to wait 1 whole s
%before determining that a response was not received) - note, even if a
%given dataset has no vocalisations for ith after response, there will be
%an empty matrix corresponding to that
for i = 1:r_max+1
    for jj = 1:length(dis_f)
        if r_mirr(jj) == i-1 && dis_t(jj) >= 1
            sortedmatrix_disf{i} = [sortedmatrix_disf{i} dis_f(jj)];
            sortedmatrix_disd{i} = [sortedmatrix_disd{i} dis_d(jj)];
            sortedmatrix_dissp{i} = [sortedmatrix_dissp{i} dis_sp(jj)];
            sortedmatrix_dist{i} = [sortedmatrix_dist{i} dis_t(jj)];
            sortedmatrix_velsp{i} = [sortedmatrix_velsp{i} vel_sp(jj)];
        end
    end
end

distance_f{j} = sortedmatrix_disf;
distance_d{j} = sortedmatrix_disd;
distance_sp{j} = sortedmatrix_dissp;
distance_t{j} = sortedmatrix_dist;

velocity_sp{j} = sortedmatrix_velsp;

end
end
end

%Now, note, we have a matrices for different step sizes. Using distance in
%acoustic space as an example, let's try to look at what the cell arrays
%containing these matrices look like. For each dataset, the step sizes in
%acoustic space distance can correspond to 0 to n vocalisations after
%the last response. ie, these step sizes can fall into any of these n+1
%bins. So, that is a cell array of n+1 matrices, each with different
%lengths based on how many times i vocalisations occur after the last
%response. Then, these call arrays are themselves collated into cell arrays
% - that is, for each dataset, there is a cell array of length n+1. These
% call arrays are then stacked into a bigger cell array where n can be
% different

%The easiest way to find the mean and standard deviation across all
%datasets is to simply match the length n+1 for the cell arrays
%corresponding to the datasets, and match teh length of the matrices inside
%each individual cell array for each dataset, by padding with NaN values.
%These can tehen be stacked together into a single matrix to find mean and
%std. So, a cell array corresponding to one data set will have matrices of the
%same length. These cell arrays will then be padded by NaN matrices so that
%the cell arrays themselves have the same length

%Now, we have to stack these measures of distances, velocities
%as a mean n voclisations after a response kind of format.
for i = 1:length(velocity_sp)
    if isempty(velocity_sp{i}) == 0 
        max_l(i) = max(cellfun(@length,velocity_sp{i})); %This is the length of the most populated bin in velocity_sp{i} 
        %- ie, whatever number of vocalisations occured most after the last
        %response - should be the length of the matrices within a cell
        %array for a given dataset, after padding
    end
end

%This is the longest number of vocalisations any datset has had after the
%last response - should be the length of all cell arrays after padding
max_num_nonresponse = max(cellfun(@length,velocity_sp));

%to stack cell array with matching length (which have matrices of matching
%length)
velocity_sp_mat = [];

distance_sp_mat = [];
distance_f_mat = [];
distance_d_mat = [];
distance_t_mat = [];

for i = 1:length(velocity_sp)
   if isempty(velocity_sp{i}) == 0 
   
   max_l_all = max_l(i); %length that matrices should be padded to, for a given dataset
   
   vsp = velocity_sp{i};
   
   dsp = distance_sp{i};
   df = distance_f{i};
   dd = distance_d{i};
   dt = distance_t{i}; 
   
   for j = 1:length(vsp) %padding matrices within a given cell array
   if isempty(vsp{j}) == 0    
   vsp{j} = padarray(vsp{j},[0 max_l_all-length(vsp{j})],NaN,'post');
   dsp{j} = padarray(dsp{j},[0 max_l_all-length(dsp{j})],NaN,'post');
   df{j} = padarray(df{j},[0 max_l_all-length(df{j})],NaN,'post');
   dd{j} = padarray(dd{j},[0 max_l_all-length(dd{j})],NaN,'post');
   dt{j} = padarray(dt{j},[0 max_l_all-length(dt{j})],NaN,'post');
   else
   vsp{j} = NaN*zeros(1,max_l_all);
   dsp{j} =  NaN*zeros(1,max_l_all);
   df{j} =  NaN*zeros(1,max_l_all);
   dd{j} =  NaN*zeros(1,max_l_all);
   dt{j} =  NaN*zeros(1,max_l_all);
   end
   
   end
   
   for j = length(vsp)+1:max_num_nonresponse %padding each cell array to the desired length
   vsp{j} = NaN*zeros(size(vsp{1}));
   
   dsp{j} = NaN*zeros(size(dsp{1}));
   df{j} = NaN*zeros(size(df{1}));
   dd{j} = NaN*zeros(size(dd{1}));
   dt{j} = NaN*zeros(size(dt{1}));
   end
   
   %saving each processed subrecording distances
   distf_subrec{i} = df;
   distd_subrec{i} = dd;
   distsp_subrec{i} = dsp;
   distt_subrec{i} = dt;
   
   velsp_subrec{i} = vsp;
   
   %stacking everything together
   velocity_sp_mat = [velocity_sp_mat cell2mat(vsp)];
   
   distance_sp_mat = [distance_sp_mat cell2mat(dsp)];
   distance_f_mat = [distance_f_mat cell2mat(df)];
   distance_d_mat = [distance_d_mat cell2mat(dd)];
   distance_t_mat = [distance_t_mat cell2mat(dt)];
   
   clear vsp dsp df dd dt
   
   end 
end

%Here, we find the mean for each dataset, to do stats on - each entry in
%the distance and velocity matrix corresponds to a single dataset. So,
%these individual entries themselves have n bins, where the nth bin has all
%the steps from n-1 to nth vocalisation after last response. 

%Before anything else, we need to group data from the same infant at the
%same age. 

%first, we concatenate age and id
for i = 1:length(chr2ad_id)  
    id_age{i} = sprintf('%s_%d',chr2ad_id{i},chr2ad_age(i));
end

%pick out unique combinations
id_age = unique(id_age);

%put together ones from same infant at the same age
for i  = 1:length(id_age)
    f_dist{i} = [];
    d_dist{i} = [];
    sp_dist{i} = [];
    t_dist{i} = [];
    sp_vel{i} = [];
    
    for j = 1:length(distf_subrec)
        %check which id and age combinations match elements of id_age; also
        %check for empty matrices
    if (strcmp(id_age{i},sprintf('%s_%d',chr2ad_id{j},chr2ad_age(j))) == 1) && (isempty(distf_subrec{j}) == 0) 
        
        f_dist{i} = [f_dist{i} cell2mat(distf_subrec{j})];%once we identify the ones that belong to same id and age, we concatenate them
        d_dist{i} = [d_dist{i} cell2mat(distd_subrec{j})];
        sp_dist{i} = [sp_dist{i} cell2mat(distsp_subrec{j})];
        t_dist{i} = [t_dist{i} cell2mat(distt_subrec{j})];
        sp_vel{i} = [sp_vel{i} cell2mat(velsp_subrec{j})];
    end
    end
end

%we will have three types of csv tables for stats

%1: where everything except step from response to the next is binned
%together - that is, binary

%(note:binary loosely encompasses
%a seperation of averages for i to i+1 for i <= n-1, and all steps/speeds after that
%being bundled into one single group). 

[smplsi_binary,vocslastrep_mat_binary,sp_avg_binary,sp_CIneg_binary,...
    sp_CIpos_binary,d_avg_binary,d_CIneg_binary,d_CIpos_binary,f_avg_binary,...
    f_CIneg_binary,f_CIpos_binary,t_avg_binary,t_CIneg_binary,t_CIpos_binary,...
    vel_avg_binary,vel_CIneg_binary,vel_CIpos_binary,infantage_binary,id_binary] = tableformeanststats(sp_vel,sp_dist,d_dist,f_dist,t_dist,id_age,1,'binary');

T_binary = table(smplsi_binary,vocslastrep_mat_binary,sp_avg_binary,sp_CIneg_binary,sp_CIpos_binary,d_avg_binary,d_CIneg_binary,d_CIpos_binary,f_avg_binary,...
                f_CIneg_binary,f_CIpos_binary,t_avg_binary,t_CIneg_binary,t_CIpos_binary,vel_avg_binary,vel_CIneg_binary,vel_CIpos_binary,infantage_binary,id_binary);

writetable(T_binary,'ad_meansteps_binary_forstats.csv')

%2: only consider steps from response, and steps immediately following response
%received - ie, vocs 0 and 1 only

[smplsi_2voc,vocslastrep_mat_2voc,sp_avg_2voc,sp_CIneg_2voc,...
    sp_CIpos_2voc,d_avg_2voc,d_CIneg_2voc,d_CIpos_2voc,f_avg_2voc,...
    f_CIneg_2voc,f_CIpos_2voc,t_avg_2voc,t_CIneg_2voc,t_CIpos_2voc,...
    vel_avg_2voc,vel_CIneg_2voc,vel_CIpos_2voc,infantage_2voc,id_2voc] = tableformeanststats(sp_vel,sp_dist,d_dist,f_dist,t_dist,id_age,0,'notbinary');

T_2voc = table(smplsi_2voc,vocslastrep_mat_2voc,sp_avg_2voc,sp_CIneg_2voc,sp_CIpos_2voc,d_avg_2voc,...
            d_CIneg_2voc,d_CIpos_2voc,f_avg_2voc,f_CIneg_2voc,f_CIpos_2voc,t_avg_2voc,t_CIneg_2voc,...
            t_CIpos_2voc,vel_avg_2voc,vel_CIneg_2voc,vel_CIpos_2voc,infantage_2voc,id_2voc);
writetable(T_2voc,'ad_meansteps_2voc_forstats.csv')


%3: Binning into 0, 1, 2, and 3 - where all steps for i to i+1 for i>= 3 go
%into the same bin

[smplsi_3bin,vocslastrep_mat_3bin,sp_avg_3bin,sp_CIneg_3bin,...
    sp_CIpos_3bin,d_avg_3bin,d_CIneg_3bin,d_CIpos_3bin,f_avg_3bin,...
    f_CIneg_3bin,f_CIpos_3bin,t_avg_3bin,t_CIneg_3bin,t_CIpos_3bin,...
    vel_avg_3bin,vel_CIneg_3bin,vel_CIpos_3bin,infantage_3bin,id_3bin] = tableformeanststats(sp_vel,sp_dist,d_dist,f_dist,t_dist,id_age,3,'binary');

T_3bin = table(smplsi_3bin,vocslastrep_mat_3bin,sp_avg_3bin,sp_CIneg_3bin,sp_CIpos_3bin,d_avg_3bin,d_CIneg_3bin,d_CIpos_3bin,f_avg_3bin,...
                f_CIneg_3bin,f_CIpos_3bin,t_avg_3bin,t_CIneg_3bin,t_CIpos_3bin,vel_avg_3bin,vel_CIneg_3bin,vel_CIpos_3bin,infantage_3bin,id_3bin);

writetable(T_3bin,'ad_meansteps_3bin_forstats.csv')

%calculating mean and std deviation - note that any NaN originating from
%the raw data will also be excluded in this next step - this is for all
%data stacked together

[mean_v_sp,std_v_sp,CI_v_sp_neg,CI_v_sp_pos,num_v_sp,numvoc] = mean_std_95CI(velocity_sp_mat);

[mean_d_sp,std_d_sp,CI_d_sp_neg,CI_d_sp_pos,num_d_sp,numvoc] = mean_std_95CI(distance_sp_mat);
[mean_d_f,std_d_f,CI_d_f_neg,CI_d_f_pos,num_d_f,numvoc] = mean_std_95CI(distance_f_mat);
[mean_d_d,std_d_d,CI_d_d_neg,CI_d_d_pos,num_d_d,numvoc] = mean_std_95CI(distance_d_mat);
[mean_d_t,std_d_t,CI_d_t_neg,CI_d_t_pos,num_d_t,numvoc] = mean_std_95CI(distance_t_mat);

ad_mean_steps = table(mean_v_sp,std_v_sp,CI_v_sp_neg,CI_v_sp_pos,num_v_sp,...
    mean_d_sp,std_d_sp,CI_d_sp_neg,CI_d_sp_pos,num_d_sp,...
    mean_d_f,std_d_f,CI_d_f_neg,CI_d_f_pos,num_d_f,...
    mean_d_d,std_d_d,CI_d_d_neg,CI_d_d_pos,num_d_d,...
    mean_d_t,std_d_t,CI_d_t_neg,CI_d_t_pos,num_d_t);

writetable(ad_mean_steps,'chresp2ad_mean_stepsize.csv')

