%Ritwika, UC Merced

%looking at median/90th percentile step sizes between
%vocalisations for different measures (amplitude, log frequency, acoustic
%space, time) as a function of distance from last
%response - in terms of number of responses.

%NOTE: the name of the .csv file needs to be changed according to whether
%median or 90th percentile value is being determined. Accordingly, the
%second argument  for the fn_prctile_stsize(<matrix of distances>,<desired percentile>)
%function should also be changed

%for child vocalisations (AD responses)

clear all
clc

load('adresp_zkm_match.mat')

%we'll find distances in f space, d space, vocal space, and time
for j = 1:length(adr_en)

clear dis_f dis_d dis_sp dis_t r_mirr

st = adr_st{j};
en = adr_en{j};
r = adresponse{j}; 
f = adr_zlogf{j};
d = adr_zd{j};

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

r_max = max(r_mirr(1:end));%finds maximum length of stretch of non-responses

%Now, we go ahead and take only distances corresponding to the redefined
%response matrix

if isempty(r) ==0 %make sure that updated response matrix is not empty

r_mirrmax(j) = max(r_mirr);

dis_f = dis_f(r_ind:end); %cut down distance matrices to the sizes compatible with updated response matrix
dis_d = dis_d(r_ind:end);
dis_sp = dis_sp(r_ind:end);
dis_t = dis_t(r_ind:end);

%remove nan values - space steps would have any nan values fork bth f and
%d, so that is teh ideal standard to remove nans based on 

%Note that since length(dis_sp) < length(r_mirr), this operation removes
%the last element of r_mirr and makes them equal length
dis_t = dis_t(isnan(dis_sp) == 0);
dis_f = dis_f(isnan(dis_sp) == 0);
dis_d = dis_d(isnan(dis_sp) == 0);
r_mirr = r_mirr(isnan(dis_sp) == 0);
dis_sp = dis_sp(isnan(dis_sp) == 0);

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

%Here, if distance d corresponds to i nonresponses, then it
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
        end
    end
end

distance_f{j} = sortedmatrix_disf;
distance_d{j} = sortedmatrix_disd;
distance_sp{j} = sortedmatrix_dissp;
distance_t{j} = sortedmatrix_dist;

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

%The easiest way to find the median/90prc and standard deviation across all
%datasets is to simply match the length n+1 for the cell arrays
%corresponding to the datasets, and match teh length of the matrices inside
%each individual cell array for each dataset, by padding with NaN values.
%These can tehen be stacked together into a single matrix to find median/90prc and
%std. So, a cell array corresponding to one data set will have matrices of the
%same length. These cell arrays will then be padded by NaN matrices so that
%the cell arrays themselves have the same length

%Now, we have to stack these measures of distances
%as a  median/90prc of n voclisations after a response kind of format.
for i = 1:length(distance_sp)
    if isempty(distance_sp{i}) == 0 
        max_l(i) = max(cellfun(@length,distance_sp{i})); %This is the length of the most populated bin in distance_sp{i} 
        %- ie, whatever number of vocalisations occured most after the last
        %response - should be the length of the matrices within a cell
        %array for a given dataset, after padding
    end
end

%This is the longest number of vocalisations any datset has had after the
%last response - should be the length of all cell arrays after padding
max_num_nonresponse = max(cellfun(@length,distance_sp));

%to stack cell array with matching length (which have matrices of matching
%length)

distance_sp_mat = [];
distance_f_mat = [];
distance_d_mat = [];
distance_t_mat = [];

for i = 1:length(distance_sp)
   if isempty(distance_sp{i}) == 0 
   
   max_l_all = max_l(i); %length that matrices should be padded to, for a given dataset
   
   dsp = distance_sp{i};
   df = distance_f{i};
   dd = distance_d{i};
   dt = distance_t{i}; 
   
   for j = 1:length(dsp) %padding matrices within a given cell array
   if isempty(dsp{j}) == 0    
   dsp{j} = padarray(dsp{j},[0 max_l_all-length(dsp{j})],NaN,'post');
   df{j} = padarray(df{j},[0 max_l_all-length(df{j})],NaN,'post');
   dd{j} = padarray(dd{j},[0 max_l_all-length(dd{j})],NaN,'post');
   dt{j} = padarray(dt{j},[0 max_l_all-length(dt{j})],NaN,'post');
   else
   dsp{j} =  NaN*zeros(1,max_l_all);
   df{j} =  NaN*zeros(1,max_l_all);
   dd{j} =  NaN*zeros(1,max_l_all);
   dt{j} =  NaN*zeros(1,max_l_all);
   end
   
   end
   
   for j = length(dsp)+1:max_num_nonresponse %padding each cell array to the desired length
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
  
   %stacking everything together
   distance_sp_mat = [distance_sp_mat cell2mat(dsp)];
   distance_f_mat = [distance_f_mat cell2mat(df)];
   distance_d_mat = [distance_d_mat cell2mat(dd)];
   distance_t_mat = [distance_t_mat cell2mat(dt)];
   
   clear dsp df dd dt
   
   end 
end

%Each entry in the distance matrix corresponds to a single dataset. So,
%these individual entries themselves have n bins, where the nth bin has all
%the steps from n-1 to nth vocalisation after last response. 

%Before anything else, we need to group data from the same infant at the
%same age.  

%first, we concatenate age and id
for i = 1:length(adr_age)  
    id_age{i} = sprintf('%s_%d',adr_id{i},adr_age(i));
end

%pick out unique combinations
id_age = unique(id_age);

%put together ones from same infant at the same age
for i  = 1:length(id_age)
    f_dist{i} = [];
    d_dist{i} = [];
    sp_dist{i} = [];
    t_dist{i} = [];
    
    for j = 1:length(distf_subrec)
        %check which id and age combinations match elements of id_age; also
        %check for empty matrices
    if (strcmp(id_age{i},sprintf('%s_%d',adr_id{j},adr_age(j))) == 1) && (isempty(distf_subrec{j}) == 0) 
        
        f_dist{i} = [f_dist{i} cell2mat(distf_subrec{j})];%once we identify the ones that belong to same id and age, we concatenate them
        d_dist{i} = [d_dist{i} cell2mat(distd_subrec{j})];
        sp_dist{i} = [sp_dist{i} cell2mat(distsp_subrec{j})];
        t_dist{i} = [t_dist{i} cell2mat(distt_subrec{j})];
    end
    end
end

%calculating  median/90prc note that any NaN originating from
%the raw data will also be excluded in this next step - this is for all
%data stacked together. We can use the second argiment of the function as
%50 for median, and 90 for 90th percentile

%numvoc is the number of vocalisations since the last response, and num_d_sp
%(or num_d_f, num_d_d etc. all num_d_<> matrices are the same here.)
%is the number of non-NAN data points for the 'nth vocalisations since last
%response' entry.

[median_d_sp,num_d_sp,numvoc] = fn_prctile_stsize(distance_sp_mat,50);
[median_d_f,num_d_f,numvoc] = fn_prctile_stsize(distance_f_mat,50);
[median_d_d,num_d_d,numvoc] = fn_prctile_stsize(distance_d_mat,50);
[median_d_t,num_d_t,numvoc] = fn_prctile_stsize(distance_t_mat,50);

chn_prctile_steps = table(median_d_sp,num_d_sp,median_d_f,num_d_f,median_d_d,num_d_d,median_d_t,num_d_t);

writetable(chn_prctile_steps,'adresp2ch_median_stepsize_alldatatogether.csv')









