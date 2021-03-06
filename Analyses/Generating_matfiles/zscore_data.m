 %Ritwika, UC Merced

%sorting raw data into zscored versions (there is optional kmeans
%clustering which has been commented out)

%Raw data - CHNSP, FAN, MAN only - are bundled together and zscored so that
%all available data is normalised. The normalised data is then sorted back
%to get corresponding zscored values for each infant at a given day and
%subrecording.

clear all
clc

load('datachn_raw.mat')

%empty entries in data are designated as empty cells, let's recast them as
%empty matrices

for i = 1:length(d_all)
    if isempty(d_all{i}) == 1
      d_all{i} = [];
      logf_all{i} = [];
    end
end


%find zscored and kmeans values - we are zscoring the entire cumulative
%data, including adult and child recordings, and then separating that out
%into adult and child

%note that some f and d values are Nan, so take that into account while
%z-scoring

dmatrix = cell2mat(transpose(d_all));
logfmatrix = cell2mat(transpose(logf_all));

z_d = (dmatrix - nanmean(dmatrix))/nanstd(dmatrix); 
z_logf = (logfmatrix - nanmean(logfmatrix))/nanstd(logfmatrix); 

%rng(1); %set a seed for kmeans
%[kmeanall,kmcent] = kmeans([z_logf z_d], 10,'MaxIter',10000); %note that frequency forms the x axis and amplitude forms the y axis

%put back data together into matrices, separately
 
%for all data
for i  = 1:length(d_all) %length of each entry
    l_all(i) = length(d_all{i});
end

csum_all = [0 cumsum(l_all)]; %cumulative sum matrix of lengths

for i  = 1:length(csum_all)-1 %each matrix can be put back together by picking out the cumsum(i) + 1 to cumsum(i+1) elements together
   z_logfall{i} =  z_logf(csum_all(i)+1:csum_all(i+1));
   z_dall{i} =  z_d(csum_all(i)+1:csum_all(i+1));
   %km_all{i} = kmeanall(csum_all(i)+1:csum_all(i+1));
end

%--------------------------------------------------------------------------

%now, we pick out the zscored values for just the child vocalisations, by
%going through the raw data, and matching start times of CHN vocalisations
%to start times in the 'all' data, and then matching the indices to the
%zscored and kmeans-d values

%first, recast empty cells in the start time array as matrices
for i = 1:length(start_all)
    if isempty(start_all{i}) == 1
      start_all{i} = [];
    end
    if isempty(start_ch{i}) == 1
      start_ch{i} = [];
    end
end

%now, we match start values and pick out those indices to determine which
%zscored values go into the child's data

for i = 1:length(start_all)
   if isempty(start_all{i}) == 0
      sall = start_all{i};
      sch = start_ch{i};
      [ss,iall,ich] = intersect(sall,sch); %iall corresponds to indices of all data, and ich to child data
      alllogfz = z_logfall{i};
      alldz = z_dall{i};
      %allkm = km_all{i};
      z_logfch{i} = alllogfz(iall);
      z_dch{i} =  alldz(iall);
      %km_ch{i} = allkm(iall);
   end 
end

save('data_zkm.mat','start_all','start_ch','end_all','end_ch','z_logfch','z_dch','z_logfall','z_dall','age','id','segm')%'km_ch','km_all','kmcent'














 

