clear all
clc

%cd '/Users/ritu/Google Drive/research/vocalisation/clean_code_thats_used/csv_files_vfinal'

aa = dir('rsq*');

counter = 0;

for i = 1:length(aa)
dtaa = readtable(aa(i).name);

hasMatch_ss = ~cellfun('isempty', regexp(dtaa.Properties.VariableNames, 'smplsi')) ; %picks out only columns that have smplsi in the column name
dtaa_ss = dtaa(:, dtaa.Properties.VariableNames(hasMatch_ss));

[ss_m,ss_n] = size(dtaa_ss);

    if ss_n == 1 %sample sizse can be unsplit (only 1 column) or WR/WOR (2 columns); note that the order of these columns is WR fllowed by WOR
        mean_ss = mean(dtaa_ss{:,1}); %these means would be the same for each aa(i)
    elseif ss_n == 2
        mean_ss_WR = mean(dtaa_ss{:,1});
        mean_ss_WOR = mean(dtaa_ss{:,2});
    end
    
len_vec = length(dtaa_ss{:,1}); %find how many distributions were analysed

hasMatch = ~cellfun('isempty', regexp(dtaa.Properties.VariableNames, 'rsq')) ; %picks out only columns that have rsq in the column name
dtaa = dtaa(:, dtaa.Properties.VariableNames(hasMatch));

tabnames = dtaa.Properties.VariableNames; %names of columns

[m,n] = size(dtaa);

for j = 1:n %we need means of all columns
   counter = counter + 1;  %counts for each relevant column in each .csv file
   varname{counter,1} = tabnames{j};
   average(counter,1) = mean(dtaa{:,j}); %mean of j th column
   std_dev(counter,1) = std(dtaa{:,j}); %stddev of jth column
   
   if (ss_n == 2) && (contains(tabnames{j},'_no') == 0) %if WR
       mean_samplsi(counter,1) = mean_ss_WR;
   elseif (ss_n == 2)
       mean_samplsi(counter,1) = mean_ss_WOR; %if WOR
   else
       mean_samplsi(counter,1) = mean_ss; %if unsplit
   end
   
   num_of_dist(counter,1) = len_vec; 
   
   if contains(aa(i).name,'LENAsubset') == 1 %checks if listener is hum or LENA
      listenertype{counter,1} = 'LENA_hum_subset';
      aa(i).list = 'LENA_hum_subset'; %updates the strcture aa so these new labels can be used in creating a summary rsq mean and std. dev table (below)
   elseif contains(aa(i).name,'humlab') == 1 %checks if listener is hum or LENA
      listenertype{counter,1} = 'hum';
      aa(i).list = 'hum'; %updates the strcture aa so these new labels can be used in creating a summary rsq mean and std. dev table (below)
   else
      listenertype{counter,1} = 'LENA';
      aa(i).list = 'lena';
   end
   
   if contains(aa(i).name,'noWR_WOR') == 1 %checks if distribution is unsplit or not
      dist_type{counter,1} = 'unsplit';
      aa(i).dist = 'unsplit';
   else
       dist_type{counter,1} = 'WR/WOR';
       aa(i).dist = 'WR/WOR';
   end
   
   if (contains(aa(i).name,'chvoc') == 1) || (contains(aa(i).name,'adresp') == 1) %checks if voc is by adult or infant (adresp means adresp to child)
      voc_type{counter,1} = 'infant';
      aa(i).voc = 'infant';
   else
       voc_type{counter,1} = 'adult';
       aa(i).voc = 'adult';
   end
   
end

end

tt = table(listenertype,voc_type,dist_type,varname,average, std_dev,mean_samplsi,num_of_dist);
writetable(tt,'r_sq_aicfits.csv')


clearvars -except aa

%generate a summary of summary table with just Lena WR, WOR, and unsplit
%(chvoc and advoc seperately) and similarly for hum label

counter = 0;

for i = 1:length(aa)
    dtaa = readtable(aa(i).name);
    
    hasMatch_ss = ~cellfun('isempty', regexp(dtaa.Properties.VariableNames, 'smplsi')) ; %picks out only columns that have smplsi in the column name
    dtaa_ss = dtaa(:, dtaa.Properties.VariableNames(hasMatch_ss));

    [ss_m,ss_n] = size(dtaa_ss);

        if ss_n == 1 %sample sizse can be unsplit (only 1 column) or WR/WOR (2 columns); note that the order of these columns is WR fllowed by WOR
            mean_ss = mean(dtaa_ss{:,1}); %these means would be the same for each aa(i)
        elseif ss_n == 2
            mean_ss_WR = mean(dtaa_ss{:,1});
            mean_ss_WOR = mean(dtaa_ss{:,2});
        end

    len_vec = length(dtaa_ss{:,1}); %find how many distributions were analysed

    hasMatch = ~cellfun('isempty', regexp(dtaa.Properties.VariableNames, 'rsq')) ; %picks out only columns with rsq in clumn name
    dtaa = dtaa(:, dtaa.Properties.VariableNames(hasMatch));
    
    %there are 8 datafiles: unsplit child, WR/WOR child, unsplit adult;
    %WR?WOR adult (for LENA and human)
          
    if strcmp(aa(i).dist,'unsplit') == 1 %check if thsi is unsplit type
        
        counter = counter + 1;
        
        dd = dtaa{:,:}; %pick out the whole table - mean and std dev of all unsplit fits of that listener and vocalisation type (infant/adult)
        
        average(counter,1) = mean(dd(:)); %mean of the whoel table
        std_dev(counter,1) = std(dd(:));
        
        listenertype{counter,1} = aa(i).list;
        disttype{counter,1} = aa(i).dist;
        voctype{counter,1} = aa(i).voc;
        
        mean_samplsi(counter,1) = mean_ss; %if unsplit
        num_of_dist(counter,1) = 4*len_vec;
       
    else %if distributions is not unsplit
        hasMatch = ~cellfun('isempty', regexp(dtaa.Properties.VariableNames, 'no')) ; %WOR distributions have a noad or noch in their names
        dtaa1 = dtaa(:, dtaa.Properties.VariableNames(hasMatch)); %picks out only WOR 
        
        dd = dtaa1{:,:}; %pick out the whole table
        
        counter = counter + 1;
        average(counter,1) = mean(dd(:)); %mean of the whole table
        std_dev(counter,1) = std(dd(:));
        
        listenertype{counter,1} = aa(i).list;
        disttype{counter,1} = 'WOR';
        voctype{counter,1} = aa(i).voc;
        
        mean_samplsi(counter,1) = mean_ss_WOR; %if WOR
        num_of_dist(counter,1) = 4*len_vec;
        
        hasMatch = cellfun('isempty', regexp(dtaa.Properties.VariableNames, 'no')) ; %WR distributions have a noad or noch in their names
        dtaa1 = dtaa(:, dtaa.Properties.VariableNames(hasMatch)); %picks out only WR
        
        dd = dtaa1{:,:}; %pick out the whole table
        
        counter = counter + 1;
        average(counter,1) = mean(dd(:)); %mean of the whole table
        std_dev(counter,1) = std(dd(:));
        
        listenertype{counter,1} = aa(i).list;
        disttype{counter,1} = 'WR';
        voctype{counter,1} = aa(i).voc;
        
        mean_samplsi(counter,1) = mean_ss_WR;
        num_of_dist(counter,1) = 4*len_vec;
    end   
end

tt = table(listenertype,voctype,disttype,average, std_dev,mean_samplsi,num_of_dist);
writetable(tt,'r_sq_aicfits_summary.csv')











