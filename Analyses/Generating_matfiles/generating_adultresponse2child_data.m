%Ritwika, UC merced
clear all
clc

%get all filenames from metadata - cd into adult responses foler if
%necessary
tbl = readtable('metanopauses_foraging_simplified.txt');
id_ch = tbl.id; %stores child id
ageindays = tbl.ageindays; %child age
name = tbl.filebase; %file base name
seg = tbl.subrecnum; %subrecording number

aa1 = dir ('*.txt'); %get all files from the folder - all adult resp files

%get filenames
for i  = 1:length(aa1)
filenames{i} = aa1(i).name;
end

%We will now match the filenames from the folder to file names from
%metadata and read them

%the first bit is the id - file base-, and the second bit 
%is the recording segment number
for i = 1:length(filenames)
   boo = strsplit(filenames{i},'_AdultResponsesToChild_');
   
   bb = strsplit(boo{2},'.txt');
   boo(2) = bb(1);
  newfilenames{i} = boo;%stores filenames split into name and subrecording number
end

%run through through names from folder and try and match to metadata
for i  = 1:length(newfilenames)
    
    fn = newfilenames{i};
    
    %Run through file names form metadata
    for j = 1:length(name)
        
        fntxt = name{j};
        
        
        if (strcmp(fn(1),fntxt) == 1) && (str2num(fn{2}) == seg(j))%checks to match filebase and subrecnum
         
            age_adresp(i) = ageindays(j);
            id_adresp(i) = id_ch(j); %stores as a string
            segm_adresp(i) = seg(j);
         
            %once we match that, we import the data from that file
            aa = readtable(filenames{i});
           
            if isempty(aa) == 0 %checks that data is not empty
            
            start = aa.chnStartTime;
            endd = aa.chnEndTime;
            resp = aa.childReceivedAdultResponse;
            
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
            adstart{i} = start;
            aden{i} = endd; 
            adresp{i} = resp1;
    
    
            clear start 
            clear endd
            clear resp1
            clear resp
    
            else %if table is empty, leave that blank
            adstart{i} = {};
            aden{i} = {}; 
            adresp{i} = {}; 
            %filenames{i}
            %i
    
            end
        end
        
        
    end
    
    
end

save('addata_raw.mat','adstart','aden','adresp','age_adresp','id_adresp','segm_adresp')
     

