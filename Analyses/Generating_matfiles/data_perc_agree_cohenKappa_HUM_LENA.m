%ritwika vps
%UC Merced
%November 28, 2018

%IVFCR code - to find LENA labelled data that has been labelled by human
%listeners - generate data to use for cohen's kappa and percent agreement
%analysis (to compare between human and LENA listeners)

%we have 3 sets of lena labelled data that were labelled by human
%listeners. Human listeners listened to sounds which had labels FAN, MAN,
%CXN, CHNSP, and CHNNSP according to LENA. In addition, human listeners
%sometimes skipped some portion of the recordings and although the
%labelling program was supposed to take them back to those we think there
%was a bug such that that did not always happen. We only used CHNSP, MAN
%and FAN data in our analysis of LENA data. So, in this code, we go back to
%the LENA-based files to identify all LENA-identified CHNSP, FAN and MAN
%labels from each human-labelled recording, and then we compare start times
%to see which of these were actually labelled by human listeners.

%The human labelling did not distinguish between CHNSP (speech-related
%vocalization by the child wearing the recorder) and CHNNSP (cry, laugh, or
%vegetative vocalization by the child wearing the recorder). Because we do
%not have a plausible way to seperate CHN labels by human listeners into
%CHNSP and CHNNSP without relying on LENA labels, we will rely on LENA to
%determine if a human-labelled CHN was CHNSP and CHNNSP. Segments labeled
%CHN by a human will be labelled CHNSP if LENA labelled them as CHNSP, MAN,
%or FAN. Otherwise, i.e. if LENA labelled the segment as CXN or CHNNSP, the
%human-labelled CHN will be excluded from analyses.

%So, this will be our approach: We will isolate only vocs labelled by human
%as MAN, FAN or CHN AND not given multiple labels by human listerns (REJ,
%i.e. Reject due to other noise, is ok because otherwise almost all data
%will be eliminated; see further down in the code for examples). We will
%then match start times between the CHNSP, MAN, and FAN LENA-labelled
%segments from the recording to human listener segments labelled MAN,
%CHNSP, or FAN with no other human voices identified. We then compare the
%LENA vs. human listener labels for each corresponding segment pair for
%inter-rater reliability.

clear all
clc

%cd to folder with the segments file from LENA 
% Assuming you have downloaded "postitsfiles_foraging_for_rvps.zip"
% from OSF, at https://osf.io/zn2jw/
% and that you have unzipped it
% and that the resulting folder is in a "Downloads" folder in your home directory
cd '~/Downloads/postitsfiles_foraging_for_rvps/seg';
% cd '/Users/ritu/Google Drive/research/vocalisation/clean_code_thats_used/data/postitsfiles_foraging_for_rvpm/seg' % Ritwika's path

%since there are only 3 infant datsets that have been labelled by humans, I
%found it easier to list them up rather than creating a text file with the
%details of those filenames and automatically reading them off using dir or
%something simliar. As the repertoire of human labelled data increases,
%this would have to be altered

%headers for these files are: segtype (speaker or sound type: eg: CHNSP
%(child speech related), SIL (silence), etc.), startsec (start time in
%seconds),endsec (end time in seconds)

inf_274_82days = readtable('0274_000221_Segments1.txt');
inf_340_183days = readtable('0340_000601_Segments1.txt');

%infant 530 at 95 days has multiple segments so we will use dir
%pick out all files that are segments for infant 530 at 95 days
aa = dir('0530_000304*.txt');
inf_530_95days = [];
for i  = 1:length(aa)
    inf_530_95days = [inf_530_95days  
    readtable(aa(i).name)]; %readtable sequentially reads those files in and we stack them in a matrix.
end

%create structure files with child ad and datafiles as labelled by LENA
lena_data(1).childid = '274';
lena_data(1).datafiles = inf_274_82days;

lena_data(2).childid = '340';
lena_data(2).datafiles = inf_340_183days;

lena_data(3).childid = '530';
lena_data(3).datafiles = inf_530_95days;

%We will now select only those entries from LENA segments data that are
%labelled MAN, FAN or CHNSP

for i = 1:length(lena_data)
    pattern = ["MAN","FAN","CHNSP"]; %either MAN or FAN or CHNSP
     
    l_data = lena_data(i).datafiles; %gets the table from the structure file
    l_sp = l_data.segtype; %gets the column of speaker labels
    
    lena_data(i).childid
    for j = 1:length(l_sp)
        if contains(l_sp{j},pattern) == 0
            l_sp{j} = 'NA'; %relabels anything other than MAN or FAN or CHNSP as NA
        end 
    end
    
    l_data.segtype = l_sp; 
    
    table_select = strcmp(l_data.segtype,"NA") == 1; %remove all NA labels
    l_data(table_select,:) = [];
    
    lena_data(i).datafiles = l_data; %stores the new table in the structure file
    
end

% cd to folder with human labels
% Assuming you have downloaded "Human_labels" as zip
% from OSF, at https://osf.io/8ern6/files/
% and that you have unzipped it
% and that the resulting folder is in a "Downloads" folder in your home directory
cd '~/Downloads/Human_labels';
% cd '/Users/ritu/Google Drive/research/vocalisation/clean_code_thats_used/data/human_labels' % Ritwika's path

hum = dir('*.csv');

%now, we need to match the data in hum to the LENA labelled data by infant
%id. We also need to isolate listener id. Then, we will compare start times
%from, for example infant 530 at 95 days, from the LENA data and human
%labelled data to see which segements were labelled by the human listeners.
%We will also store the speaker type as identified by LENA and human
%listener, and this will the final output file.

%headers in human labelled files: start, end (MATLAB will change this to
%end1 or end<a number> or xend to make it a valid MATLAB identifier),
%recording_id, child_id, speaker (as identified by human listener), coder,
%method.

%We will use child_id to match child id, coder to match listener, and start
%to match start times

%create structure file for human labelled data
for i = 1:length(hum)
    hum_data(i).data = readtable(hum(i).name);
    hum_data(i).listener = cell2mat(unique(hum_data(i).data.coder)); %the hum_data(i).data.coder isolates the coder column from the table. 
    %Unique picks our the unique values which gives the listenerid, and
    %cell2mat converts it to a matrix. Note that the listener id is still a
    %string
    %we cannot use the same to store child ids because at least one human
    %label file has 2 different child ids.
end

%now, we will relabel Human labelled files, and only select the ones
%where there are no overlaps: eg. 'CHN,FAN, REJ' woud, be
%rejected. Further, CHN would be recoded as CHNSP, and any REJ
%labels in human labelled segments of FAN, MAN or CHN with no
%overlaps would be removed. Eg: 'CHN, REJ' would be recoded as
%'CHNSP'. This is so that the human labels match LENA labels.
             
for i = 1:length(hum_data)
    temp_data_table = hum_data(i).data;
    
    chexp = '^(.(?<!CXN|MAN|FAN))*CHN(.(?!CXN|MAN|FAN))*$'; 
    adexpf = '^(.(?<!CXN|MAN|CHN))*FAN(.(?!CXN|MAN|CHN))*$';
    adexpm = '^(.(?<!CXN|FAN|CHN))*MAN(.(?!CXN|FAN|CHN))*$';
    
    spsp = temp_data_table.speaker; %note that this is a vertical array of cell arrays
    
    %relabelling of speaker labels
    for k = 1:length(spsp)
        if isempty(regexp(spsp{k},chexp)) == 0 %check if result of regexp is empty -> if empty, there is no match
            newspsp{k} = 'CHNSP'; %note that at this point not all relabelled CHNSP labels in human 
            %labelled data arent CHNSP - some of them might be CHNNSP.
            %Further in this process, we will use LENA labelled data to
            %filter CHNSP from CHNNSP
        elseif isempty(regexp(spsp{k},adexpf)) == 0
            newspsp{k} = 'FAN';
        elseif isempty(regexp(spsp{k},adexpm)) == 0
            newspsp{k} = 'MAN';  
        else
            newspsp{k} = 'NA';
        end
    end
    
    temp_data_table.speaker = transpose(newspsp); %assigns the new labels for the speaker column
    table_select = strcmp(temp_data_table.speaker,'NA') == 1; %remove all NA labels
    %NA labels are either double labelled entries - eg: CHN, MAN; or
    %entries that are only labelled REJ
    temp_data_table(table_select,:) = [];
    hum_data(i).data = temp_data_table; %replaces the old table with the new tables with new speaker labels

    clear temp_data_table spsp newspsp
end

%now, we will match the child ids from LENA segments data and human
%labelled data so we can match start times between human and LENA data. 

childid_counter = 0;

for ll = 1:length(lena_data)
    l_child = lena_data(ll).childid; %note that child id in lena data is unique
    
    for hh = 1:length(hum_data)
        h_table = hum_data(hh).data; 
        aa = unique(h_table.child_id); %child id for hum data is not unique. 
        %we need to find child id matching that of lena to generate
        %datafiles for comparison
        
        for ii = 1:length(aa) 
         strsplit_results = strsplit(aa{ii},'IVFCR'); %child_ids in human labelled data is in the form IVFCR<childid>
         h_child = strsplit_results{2};
         
         if strcmp(h_child,l_child) == 1 %compare if child ids from lena and human labelled data are the same
             childid_counter = childid_counter + 1; %increment counter if YES
             %select only rows of table from human labelled data that
             %correspond to the child id in question
             table_select = strcmp(h_table.child_id,aa{ii}) ~= 1;
             h_table(table_select,:) = []; %all rows where child id is not the 
             %same as lena child id are removed; hence the ~=1
             
             humdata_childidmatch(childid_counter).data = h_table;
             humdata_childidmatch(childid_counter).childid = h_child;
             humdata_childidmatch(childid_counter).listener = hum_data(hh).listener;
         
         end
        end
    end
end

%note that the last entry in the human data - child 530 by L3 is incomplete
%and we are not including this in our analyses. So from now on, all for
%loops will be for length(humdata_childidmatch) - 1.

%the final step now is to match the start times of lena data and the
%corresponding human label data.

% Modify the path below for your own system. If you have downloaded
% cohensKappa.m from https://github.com/elayden/cohensKappa.git
% and unzipped in your Downloads folder then the line below should work as
% is.
addpath('~/Downloads/cohensKappa-master/');

for ll = 1:length(lena_data)
    l_child = lena_data(ll).childid;
    l_table = lena_data(ll).datafiles;
    
    for hh = 1:length(humdata_childidmatch)-1 %exclude 530 by L3
        h_table = humdata_childidmatch(hh).data; 
        h_listener = humdata_childidmatch(hh).listener;
        h_child = humdata_childidmatch(hh).childid;
        
        if strcmp(h_child,l_child) == 1 %compare if child ids from lena and human labelled data are the same
            [cc,i_l,i_h] = intersect(l_table.startsec,h_table.start);
            %here, i_l is the matching index set for lena, and i_h is for
            %human
            
            new_start = l_table.startsec(i_l);
            new_lena_speaker = l_table.segtype(i_l);
            new_hum_speaker = h_table.speaker(i_h);
            
            percag(hh,1) = sum(strcmp(new_lena_speaker,new_hum_speaker))/length(strcmp(new_lena_speaker,new_hum_speaker)); %calculates percent agreement
            cohens(hh,1) = cohensKappa(new_lena_speaker,new_hum_speaker); %calculates cohens kappa (uses function)
            childid{hh,1} = l_child;
            listenerid{hh,1} = h_listener;
            
            [confusionmatrix{hh},order{hh}] = confusionmat(new_lena_speaker,new_hum_speaker,'Order',["CHNSP" "MAN" "FAN"]); %creates confusion matrix with the order specified
            %confusionchart(C{hh}) %creates confusion chart
            
            %note that first vector in confusionmat argument is known
            %group, and second vector is predicted - so lena is true class
            %and hum is predicted class here
            
        end
        
    end
end

T = table(childid,listenerid,percag,cohens);
writetable(T,'~/Downloads/interraterreliab_HUM_LENA.csv')
save('~/Downloads/confusionmat_HUM_LENA.mat','confusionmatrix','order','childid','listenerid')


