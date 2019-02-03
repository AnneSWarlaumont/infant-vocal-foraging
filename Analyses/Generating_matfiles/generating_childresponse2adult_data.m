%Ritwika, UC Merced

%Generates all the child response data for adult vocalisations based on LENA
%labelled data. This .m file only gives whether a child response was received (Y), not received (N),
% or was not applicable (NA), as well as start and end times of the adult
% vocalisation that the Y, N or NA response is applicable to. 
% We use ChildResponsestoAdult files for this. Note that both MAN and FAN
% speaker types are considered as adult and as such, these files do not
% contain speaker type details.

%From the manuscript:
%We also used the timestamps of the automatically obtained vocaliser labels to determine whether 
%each infant vocalisation was followed within 1 s by an adult vocalisation, in which case we (operationally) 
%say that the infant vocalisation received a response, and to determine whether each adult vocalisation was 
%followed within 1 s by an infant vocalisation, in which case we say that the adult vocalisation received a 
%response. In cases where two infant vocalisations occurred with less than 1 s separation intervening and no adult 
%vocalisation occupied the intervening time, we marked adult response to the first infant vocalisation as ``not applicable'', 
%and the same was done for two adult vocalisations occurring with less than 1 s separating intervening and no infant 
%vocalisation occupying the intervening time (also see figure 1 in the main text)


%Note that subrecordngs from the same day are not put together into a
%single file here, to avoid the inclusion of bogus steps (from the end of one subrecording to the beginning of the next, despite there
% potentially being a large time interval and several unrecorded
% vocalisations between the two.). We take care of this issue in later data
% analyses seperately.
clear all
clc

%get all filenames from metadata - cd into chresponses folder if necessary
cd '/Users/ritu/Google Drive/research/vocalisation/clean_code_thats_used/data/postitsfiles_foraging_for_rvpm/chresp'

tbl = readtable('metanopauses_foraging_simplified.txt');
id_ch = tbl.id; %stores child id
ageindays = tbl.ageindays; %child age
name = tbl.filebase; %file base name
seg = tbl.subrecnum; %subrecording number

aa1 = dir ('*.txt'); %get all files from the folder - all chresp files files

%get filenames
for i  = 1:length(aa1)
filenames{i} = aa1(i).name;
end


%We will now match the filenames from the folder to file names from
%metadata and read them

%the first bit is the id - file base-, and the second bit 
%is the recording segment number
for i = 1:length(filenames)
   boo = strsplit(filenames{i},'_ChildResponsesToAdult_');
   
   bb = strsplit(boo{2},'.txt');
   boo(2) = bb(1);
  newfilenamesfromfolder{i} = boo; %stores filenames split into name and subrecording number
end


%run through through names from folder and try and match to metadata
for i  = 1:length(newfilenamesfromfolder)
    
    filefromfolder = newfilenamesfromfolder{i};
    
     %Run through file names form metadata
     for j = 1:length(name)
        
        fntxt = name{j};
        
        
        if (strcmp(filefromfolder(1),fntxt) == 1) && (str2num(filefromfolder{2}) == seg(j))%checks to match filebase and subrecnum
          
         age_chresp(i) = ageindays(j);
         id_chresp(i) = id_ch(j); %stores as a string
         segm_chresp(i) = seg(j); %subrecording number
            
            %once we match that, we import the data from that file
            aa = readtable(filenames{i}); 
          
            %size(aa)
            if isempty(aa) == 0 %checks that data is not empty
            start = aa.anStartTime;
            endd = aa.anEndTime;          
            resp = aa.adultReceivedChildResponse;
            
                for k = 1:length(resp) %sorts for NA, no and yes
                    if strcmp('no',resp(k)) == 1
                        resp1(k) = 0;
                    elseif strcmp('yes',resp(k)) == 1
                        resp1(k) = 1;
                    else
                        resp1(k) = 100; %note that NA responses are stored as 100
                    end
                end
         

             %stores data
             chrespst{i} = start;
             chrespen{i} = endd; 
             chresp{i} = resp1;

             clear start 
             clear endd
             clear resp1
             clear resp

            else %if table is empty, leave that blank
            chrespst{i} = {};
            chrespen{i} = {}; 
            chresp{i} = {};
%             filenames{i} %gives filenames and indices of empty entries
%             i
            end
        end
        
        
    end
    
    
    
end


save('chrespdata_raw.mat','chrespst','chrespen','chresp','age_chresp','id_chresp','segm_chresp')
    
