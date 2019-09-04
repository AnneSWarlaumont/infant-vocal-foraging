%ritwika vps
%UC Merced
%June 2019

%IVFCR code - to find LENA labelled data that has been labelled by human
%listeners - generate data to use for cohen's kappa and percent agreement
%analysis (to compare between two human listeenrs for the same - 340 -
%data)

%We have one vocal dataset that was listened to by two human listeners - we
%will use this, infant 340, to test interraterreliabilty between the two
%human listeners

%Human listeners listened to sounds which had labels FAN, MAN, CXN, CHNSP,
%and CHNNSP according to LENA. In addition, human listeners sometimes
%skipped some portion of the recordings and although the labelling program
%was supposed to take them back to those we think there was a bug such that
%that did not always happen. However, we only used CHNSP, MAN and FAN data
%in our analysis of LENA data. Hence, since we are only interested in the
%human listenrs' reliability when it comes to CHNSP, MAN and FAN data, we
%will proceed as follows:

%First, we will isolate CHN, MAN and FAN labels from labels by both human
%listeners for infant 340. We will then retrieve CHNSP, MAN, FAN labels
%from LENA-labelled segments. Then since human CHN labels include both
%CHNSP and CHNNSP, and we are only interested in reliabilty for CHNSP, MAN,
%and FAN labels, we will match start times from the LENA segment labels
%extracted before (this also works because all human labelled data analyses
%are carried out on start times matched to relevant LENA labels).

%Finally, to compare with each other, the human labelled datasets
%themselves should only be compared for matching start times.

clear all
clc

%cd to folder with the segments file from LENA 
% Assuming you have downloaded "postitsfiles_foraging_for_rvps.zip"
% from OSF, at https://osf.io/zn2jw/
% and that you have unzipped it
% and that the resulting folder is in a "Downloads" folder in your home directory
cd '~/Downloads/postitsfiles_foraging_for_rvps/seg';
% cd '/Users/ritu/Google Drive/research/vocalisation/clean_code_thats_used/data/postitsfiles_foraging_for_rvpm/seg' % Ritwika's path

%there is only 1 infant recording that has been labelled by two human listeners

%headers for this LENA-based label file are: segtype (speaker or sound type: eg: CHNSP
%(child speech related), SIL (silence), etc.), startsec (start time in
%seconds),endsec (end time in seconds)

inf_340_183days = readtable('0340_000601_Segments1.txt');

%create structure files with child ad and datafiles as labelled by LENA
lena_data.childid = '340';
lena_data.datafiles = inf_340_183days;

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

%Now, we need to match the data in hum to the LENA labelled data by infant
%id. We also need to isolate listener id. Then, we will compare start times
%from the LENA data and human labelled data to see which segements were
%labelled by the human listeners. We will also store the speaker type as
%identified by LENA and human listener, and this will the final output
%file.

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
            %Further in thsi process, we will use LENA labelled data to
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
    %entreis that are only labelled REJ
    temp_data_table(table_select,:) = [];
    hum_data(i).data = temp_data_table; %replaces the old table with the new tables with new speaker labels

    clear temp_data_table spsp newspsp
end

%now, we will match the child ids from LENA segments data and human
%labelled data so we can match start times between human and LENA data. 
%Note that since we are only dealing with infant id 340 (2 human
%listeners), we will only have a single child id and two datasets for that
%corresponding to the two human listeners.

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

%matching start times of hum labelled data for 340: there are only 2 human
%labelled datasets corresponding to 340
tab1 = humdata_childidmatch(1).data;
tab2 = humdata_childidmatch(2).data;

[cc,i_1,i_2] = intersect(tab1.start,tab2.start);

newt1 = tab1(i_1,:); %generate new tables based on matching start values (human label start times matched)
newt2 = tab2(i_2,:);

%now we match the start times of lena data and the
%corresponding human label data. 

l_table = lena_data(ll).datafiles;
    
[cc,i_1,i_lena] = intersect(newt1.start,l_table.startsec);
[cc,i_2,i_lena] = intersect(newt2.start,l_table.startsec);

new_h1_speaker = newt1.speaker(i_1); %generate new tables based on matching start values (human label start time matched with lena start time). 
%This is because we are only interested in the data that we are analysing
%in the larger LENA dataset - CHNSP, MAN, and FAN. 
new_h2_speaker = newt2.speaker(i_2);

% Modify the path below for your own system. If you have downloaded
% cohensKappa.m from https://github.com/elayden/cohensKappa.git
% and unzipped in your Downloads folder then the line below should work as
% is.
addpath('~/Downloads/cohensKappa-master/');

%compute percent agreement, cohens kappa
percag = sum(strcmp(new_h1_speaker,new_h2_speaker))/length(strcmp(new_h1_speaker,new_h2_speaker));
cohens = cohensKappa(new_h1_speaker,new_h2_speaker);
childid = h_child;
[Confusionmat_HUM_HUM,order] = confusionmat(new_h1_speaker,new_h2_speaker,'Order',["CHNSP" "MAN" "FAN"]); %creates confusion matrix with the order specified

%confusionchart(C{hh}) %creates confusion chart
%note that first vector in confusionmat argument is known group, and second
%vector is predicted

%also note listener 1 is L1, AND listener 2 IS L3
listener1id = humdata_childidmatch(1).listener;
listener2id = humdata_childidmatch(2).listener;

C = {childid,listener1id,listener2id,percag,cohens};
T = cell2table(C,'VariableNames',{'childid','listener1id','listener2id','percag','cohens'});
writetable(T,'~/Downloads/interraterreliab_HUM_HUM.csv')
save('~/Downloads/confusionmat_HUM_HUM.mat','Confusionmat_HUM_HUM','order','childid')

             
             
