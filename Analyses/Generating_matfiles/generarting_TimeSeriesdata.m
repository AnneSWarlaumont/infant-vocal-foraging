%Ritwika, UC Merced

%This is the first .m file that should be run - it generates all the LENA
%labelled data used in subsequent analyses based on the time series data
%from LENA. Time series (TS) data only contains speaker types CHNSP, FAN, and
%MAN. We get speaker id, start and stop times of vocalisations, duration of vocalisations, mean pitch
%and amplitude of vocalisations. These details are extracted for further
%analyses.

%Note that subrecordngs from the same day are not put together into a
%single file here, to avoid the inclusion of bogus steps (from the end of one subrecording to the beginning of the next, despite there
% potentially being a large time interval and several unrecorded
% vocalisations between the two.). We take care of this issue in later data
% analyses seperately.

clear all
clc

%cd into relevant folder 
% Assuming you have downloaded "postitsfiles_foraging_for_rvps.zip"
% from OSF, at https://osf.io/zn2jw/
% and that you have unzipped it
% and that the resulting folder is in a "Downloads" folder in your home directory
cd '~/Downloads/postitsfiles_foraging_for_rvps'

% cd '/Users/ritu/Google
% Drive/research/vocalisation/clean_code_thats_used/data/postitsfiles_foraging_for_rvpm/TS' % Ritwika's path

%get all filenames from metadata
tbl = readtable('metanopauses_foraging_simplified.txt');
id_ch = tbl.id; %stores child id
ageindays = tbl.ageindays; %child age
name = tbl.filebase; %file base name
seg = tbl.subrecnum; %subrecording number

aa1 = dir ('TS/*.csv'); %get all files from the folder - all TS files - have to be in the TS folder

%get filenames 
for i  = 1:length(aa1)
filenames{i} = aa1(i).name;
end


%We will now match the filenames from the folder to file names from
%metadata and read them

%the first bit is the id - file base-, and the second bit 
%is the recording segment number
for i = 1:length(filenames)
   boo = strsplit(filenames{i},'_acousticsTS_');
   
   bb = strsplit(boo{2},'.csv');
   boo(2) = bb(1);
   newfilenamesfromfolder{i} = boo; %stores filenames split into name and subrecording number
end

%run through through names from folder and match to metadata
for i  = 1:length(newfilenamesfromfolder)
    
    filefromfolder = newfilenamesfromfolder{i};
   
    %Run through file names from metadata
    for j = 1:length(name)
        
        fntxt = name{j};
        
        if (strcmp(filefromfolder(1),fntxt) == 1) && (str2num(filefromfolder{2}) == seg(j)) %checks to match filebase and subrecnum
          
            ss = seg(j);
            
            %once we match that, we import the data from that file
            aa = readtable(filenames{i}); 
            headers = aa.Properties.VariableNames;
            if strcmp(headers{2},'speaker') == 1 %make sure that the table is read in correctly - that headers exist
            
            %size(aa) - this serves as a check to see if the size of each
            %dataset is the same - uncomment for check
          
            spkr = aa.speaker;
            starttime = aa.start;
            endtime = aa.xEnd;
            freq = aa.meanf0;
            
            %check if freq and db are cells, and the values are strings. If yes, convert the string
            %values to numerical values
            if iscell(freq) == 1
            if isstr(freq{1})  == 1
                freq = str2double(freq);
            end
            end
            db = aa.dB;
            if iscell(db) == 1
            if isstr(db{1})  == 1
                db = str2double(db);
            end
            end
            %size(db) %- this serves as a check to see if the size of each
            %dataset is the same - uncomment for check
            %Note that we are not removing NaN values and will write
            %appropriate code to deal with them during analyeses
            
            start_all{i} = starttime; % _all indicates all speaker types from time series data
            end_all{i} = endtime;
            logf_all{i} = log(freq);
            d_all{i} = db;
            
            %match to CHNSP labels %stores data
            start_ch{i} = starttime(strcmp(spkr,'CHNSP') == 1); % _ch indicates CHNSP speaker types only
            end_ch{i} = endtime(strcmp(spkr,'CHNSP') == 1);
            f_ch{i} = freq(strcmp(spkr,'CHNSP') == 1);
            logf_ch{i} = log(f_ch{i});
            d_ch{i} = db(strcmp(spkr,'CHNSP') == 1);
            
            age(i) = ageindays(j);
            id(i) = id_ch(j); %stores as a string
            segm(i) = ss; %subrecording number - so 2nd segement in a day will have seg = 2


            else %if headers don't exist, we leave that blank and fill those in manually later
            
            start_all{i} = {};
            end_all{i} = {};
            logf_all{i} = {};
            d_all{i} = {};
            
            start_ch{i} = {};
            end_ch{i} = {};
            f_ch{i} = {};
            logf_ch{i} = {};
            d_ch{i} = {};
            
            age(i) = ageindays(j);
            id(i) = id_ch(j); %stores as a string
            segm(i) = ss;
            filenames{i} %to see which filenames are read in as scrambled and need to be manually entered
            i %indices of those
            end

         clear speaker
        end
        
        
    end
    



    
end

%Note that a few datasets get read in scrambled - I have chosen to fill
%these in manually using the following: (change i as necessary) (first open
%corresponding dataset and import)
% 
%indices that are genuinely empty -  [13  27 31 32 62 71 181 ] 
%indices that get in read scrambled -    
%[25 0583_000305_acousticsTS_1.csv 45 0848_000307_acousticsTS_1.csv 52 0857_000301_acousticsTS_2.csv 181 e20110225_124231_007541_acousticsTS_1.csv]
% i = 181;
% f_ch{i} %check if the entry is empty
%  %set i to fill in
% 
% %%%%% load data here
% speaker{1:2} %check if entries are correct
% start(1:10)
% meanf0(1:10)
% end1(1:10)
% dB(1:10)
% 
% i %check for i again
% 
% start_ch{i} = start(strcmp(speaker,'CHNSP') == 1); %pick out chn speaker
% end_ch{i} = end1(strcmp(speaker,'CHNSP') == 1);
% f_ch{i} = meanf0(strcmp(speaker,'CHNSP') == 1);
% d_ch{i} = dB(strcmp(speaker,'CHNSP') == 1);
% logf_ch{i} = log(f_ch{i});
% 
% start_all{i} = start;
% end_all{i} = end1;
% logf_all{i} = log(meanf0);
% d_all{i} = dB;
% age(i) %check for age, id, and segment
% id(i)
% segm(i)

%save everything
%save('datachn_raw.mat','start_ch','end_ch','logf_ch','d_ch','start_all','end_all','logf_all','d_all','id','segm','age')



       
 
    

