%Ritwika VPS
%UC Merced
%June 2019

clear all
clc

%note that we use FAN/MAN and ADULT interchanagebly in the comments below

%Generating a percent agrEement-esque matrix of the form
%           |CHN_H   |MAN/FAN_H     |CHN_OLP_H  |MAN/FAN_OLP_H       |CHN+MAN/FAN_OLP_H     |No_CHN_MAN/FAN_H
%CHNSP_L    |        |              |           |                    |                      |
%MAN/FAN_L  |        |              |           |                    |                      |

%This reports the proportion of CHNSP and MAN/FAN labels by LENA that fall
%into each human label category.

% The human-labelled categories include infant speaker label (CHN) only (Ch
% only, column 2); adult (MAN or FAN or both) speaker only (Ad only, column
% 3); infant speaker with possible non-adult speaker overlap, where the
% overlapping speaker label could be anything except MAN or FAN (column 4);
% adult speaker with possible non-infant speaker overlap, where the
% overlapping speaker label could be anything except CHN (column 5); infant
% (CHN) and/or adult (MAN or FAN) speakers with possible other child overlap
% (column 6); and any speaker label except infant (CHN) or adult (MAN or
% FAN).

% cd to folder with the segments file from LENA
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

    for j = 1:length(l_sp)
        if contains(l_sp{j},pattern) == 0
            l_sp{j} = 'NA'; %relabels anything other than MAN or FAN or CHNSP as NA
        end 
    end
    
    l_data.segtype = l_sp; 
    
    table_select = strcmp(l_data.segtype,"NA") == 1; %remove all NA labels
    l_data(table_select,:) = [];
    
    table_ch = strcmp(l_data.segtype,"CHNSP") == 1;
    l_chnsplabels = l_data(table_ch,:); %picks out only CHNSP labels
    
    l_data(table_ch,:) = []; %all CHNSP labels are removed and remianing data is stored in the adult labels table
    l_adlabels = l_data;
    
    lena_data(i).chnsplabels = l_chnsplabels; %stores the new (CHNSP data) table in the structure file
    lena_data(i).adlabels = l_adlabels; %stores the new (adult data) table in the structure file
    
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
%labelled data to see which segments were labelled by the human listeners.
%We will also store the speaker type as identified by LENA and human
%listener, and this will go in the final output file.

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

%now, we will match the child ids from LENA segments data and human
%labelled data so we can match start times between human and LENA data. We
%will do this seperately for LENA_CHNSP labels, and LENA_AD labels.

%we will also sort out data from different infants labelled by the same
%listener

childid_counter = 0;

for ll = 1:length(lena_data)
    l_child = lena_data(ll).childid; %note that child id in lena data is unique
    l_chn = lena_data(ll).chnsplabels;
    l_ad = lena_data(ll).adlabels;
    
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
             
             [cc,i_l_chn,i_h_chn] = intersect(l_chn.startsec,h_table.start); %match start times of vocs labelled as CHNSP by LENA to hum labels
             humdata_childidmatch(childid_counter).lenachn = h_table(i_h_chn,:);
             
             [cc,i_l_ad,i_h_ad] = intersect(l_ad.startsec,h_table.start);%match start times of vocs labelled as adult by LENA to hum labels
             humdata_childidmatch(childid_counter).lenaad = h_table(i_h_ad,:);
             
             humdata_childidmatch(childid_counter).childid = h_child;
             humdata_childidmatch(childid_counter).listener = hum_data(hh).listener;
         
         end
        end
    end
end

%note that the last entry in the human data - child 530 by L3 is incomplete
%and we are not including this in our analyses. So from now on, all for
%loops will be for length(humdata_childidmatch) - 1.

chexp = '^(.(?<!CXN|MAN|FAN))*CHN(.(?!CXN|MAN|FAN))*$'; %CHN labels only
adexp = '^(.(?<!CXN|CHN))*[FM]AN(.(?!CXN|CHN))*$'; %adult labels only (FAN or MAN)
cholp = '^(.(?<!MAN|FAN))*CHN(.(?!MAN|FAN))*$'; %CHN or CHN overlapped with CXN, but no MAN/FAN
adolp = '^(.(?<!CHN))*[FM]AN(.(?!CHN))*$'; %MAN/FAN or MAN/FAN overlapped with MAN/FAN or CXN but no CHN
ch_adolp = '[CFM][HA]N'; %has CHN, MAN or FAN

%Note that to find labels without adult or child labels, we can simply
%check if the chn_adolp result is an empty set or not. If the chn_adolp
%result is non-empty, that means that the label has either CHN or MAN or
%FAN or combos of these. If the result is empty, then none of those labels
%are present

for i = 1:length(humdata_childidmatch)-1
    
    clear final1
    hum_spkrlabs_lenach = humdata_childidmatch(i).lenachn.speaker; %Humnan listener speaker labels from data labelled as CHNSP by LENA
    hum_spkrlabs_lenaad = humdata_childidmatch(i).lenaad.speaker; %Humnan listener speaker labels from data labelled as ADULT by LENA

    %create label elements for the table
    final1(1,1)="_";final1(1,2)="CHN_H";final1(1,3)="MAN/FAN_H";final1(1,4)="CHN_OLP_H";final1(1,5)="MAN/FAN_OLP_H";final1(1,6)="CHN/FAN/MAN_OLP_H";final1(1,7)="No_CHN/MAN/FAN_H";
    final1(2,1)="CHN_L";
    final1(3,1)="MAN/FAN_L";
    
    %proportion of vocs labelled as CHNSP by LENA that fall into different
    %hum label categories.
    final1(2,2) = sum(uint8(~cellfun(@isempty,regexp(hum_spkrlabs_lenach,chexp))))/length(hum_spkrlabs_lenach);%Hum label category: CHN only
    % In the line above, regexp tests whether the speaker labels by human
    % listener for vocs labelled by LENA as CHNSP fraction contains only
    % CHN as labelled by human listener. If there i a match, a non-empty
    % matrix is returned and if not, an empty matrix is retunred. @isempty
    % converts thsi information to logical 1s and 0s -> if the human
    % labelled a voc as CHN only, then it would be a logical 0, because the
    % result of regexp is not empty. The negation (~) converts logical 1s
    % to 0s and vice-versa. uint8 converts the logicals to numbers so that
    % it can be summed over. Dividing this sum by the total number of vocs
    % that LENA identified as CHNSP (which is what we were comparing with
    % HUM labels) gives the fraction of vocs that LENA labelled as CHNSP
    % that ended up being labelled by HUM as CHN only.
    final1(2,3) = sum(uint8(~cellfun(@isempty,regexp(hum_spkrlabs_lenach,adexp))))/length(hum_spkrlabs_lenach); %Hum label category: adlt only
    final1(2,4) = sum(uint8(~cellfun(@isempty,regexp(hum_spkrlabs_lenach,cholp))))/length(hum_spkrlabs_lenach);%Hum label: CHN + other overlap allowed, no adult
    final1(2,5) = sum(uint8(~cellfun(@isempty,regexp(hum_spkrlabs_lenach,adolp))))/length(hum_spkrlabs_lenach);%Hum label: adlt + other overlap allowed, no CHN
    final1(2,6) = sum(uint8(~cellfun(@isempty,regexp(hum_spkrlabs_lenach,ch_adolp))))/length(hum_spkrlabs_lenach);%Hum label: CHN or adult + other overlap allowed
    final1(2,7) = sum(uint8(cellfun(@isempty,regexp(hum_spkrlabs_lenach,ch_adolp))))/length(hum_spkrlabs_lenach);%Hum label: no CHN, FAN OR MAN (here, we don't use
    %negation on the @isempty results - so here, if regexp for 'CHN or ADULT + overlap allowed' returns 0, that means that either CHN or ADULT labels are present.
    %So this gives us the fraction of human labels that are not CHN or ADULT labels, for data that LENA labelled as CHNSP)
    
    %proportion of vocs labelled as FAN/MAN by LENA that fall into different
    %hum label categories
    final1(3,2) = sum(uint8(~cellfun(@isempty,regexp(hum_spkrlabs_lenaad,chexp))))/length(hum_spkrlabs_lenaad);
    final1(3,3) = sum(uint8(~cellfun(@isempty,regexp(hum_spkrlabs_lenaad,adexp))))/length(hum_spkrlabs_lenaad);
    final1(3,4) = sum(uint8(~cellfun(@isempty,regexp(hum_spkrlabs_lenaad,cholp))))/length(hum_spkrlabs_lenaad);
    final1(3,5) = sum(uint8(~cellfun(@isempty,regexp(hum_spkrlabs_lenaad,adolp))))/length(hum_spkrlabs_lenaad);
    final1(3,6) = sum(uint8(~cellfun(@isempty,regexp(hum_spkrlabs_lenaad,ch_adolp))))/length(hum_spkrlabs_lenaad);
    final1(3,7) = sum(uint8(cellfun(@isempty,regexp(hum_spkrlabs_lenaad,ch_adolp))))/length(hum_spkrlabs_lenaad);
    
    %saves everything in structure
    hum_lena_labels_proportions(i).listener = humdata_childidmatch(i).listener;
    hum_lena_labels_proportions(i).childid = humdata_childidmatch(i).childid;
    hum_lena_labels_proportions(i).data = final1;
    
%     humdata_childidmatch(i).listener
%     humdata_childidmatch(i).childid
%     final1
  
end

save('~/Downloads/hum_lena_labels_proportions.mat','hum_lena_labels_proportions')

    



    
