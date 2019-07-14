 %Ritwika, UC merced
clear all
clc

%Human labelled data contains start time, end time, listener id, child id,
%speaker type, recording id, and method of labelling (the last two are not relevant to the subsequent data analyses 
%so we will not be extracting those)

%Only vocalisations that has a single speaker type are considered for
%further analyses. 

%email notes:
%L3 completed 340 at 6 months. part of 530 at 3 months (not using L3 530 at 3 months because it is only partial)  
%L1:340 at 6 months, 274 at 3 months.
%L2: 530 at 3 months.

%cd into human labelled data folder if necessary
cd '/Users/ritu/Google Drive/research/vocalisation/clean_code_thats_used/data/human_labels'

aa = dir ('*.csv'); %reads all human labelled data - filenames
%get filenames 
for i  = 1:length(aa)
filenames{i} = aa(i).name;
ff = strsplit(filenames{i},'_Labels.csv');
filetag{i} = ff{1}; %gets listeners name
end


for j = 1:length(filetag)
    
clear cha adma adfa newsp  
da = readtable(filenames{j});

sttime{j} = da.start; %stores starttime, child id, and speaker id
id{j} = da.child_id; 
sp{j} = da.speaker;

length(sp{j})

spp = sp{j};

%this is an option for a more relaxed criterion where any labels that
%contain CHN is considered for child vocalisations, and any labels that
%contain MAN or FAN are considered for adult vocalisations. This does have
%the disadvantage that labels such as MAN, CHN will be counted as both
%adult and child vocalisation, which could be an issue when generating
%response data (unless you are comfortable with mixed labels and consequent
%mixed responses. We chose not to do this)
%chexp = '.*CHN.*'; %search for CHN speakers
%adexpf = '.*FAN.*'; %searches for adult speakers
%adexpm = '.*MAN.*';

chexp = '^(.(?<!CXN|MAN|FAN))*CHN(.(?!CXN|MAN|FAN))*$'; %search for child speakers only, no CXN, FAN, or MAN;
%only additional label allowed is REJ
adexpf = '^(.(?<!CXN|MAN|CHN))*FAN(.(?!CXN|MAN|CHN))*$'; %search for FAN only
adexpm = '^(.(?<!CXN|FAN|CHN))*MAN(.(?!CXN|FAN|CHN))*$'; %search for MAN only
for k = 1:length(spp)
    cha(k) = regexp(spp(k),chexp);
    adma(k) = regexp(spp(k),adexpm);
    adfa(k) = regexp(spp(k),adexpf);
end

chntag{j} = cha;
fantag{j} = adfa;
mantag{j} = adma;
end

%now, we need to sort this into child speaker and adult speaker
for i = 1:length(filetag)
    spp = sp{i};
    ch = chntag{i};
    fad = fantag{i};
    mad = mantag{i};
    st = sttime{i};
    idd = id{i}; %child id: for eg: IVFCR274
    
    counterch = 0;
    counterad = 0;
    for j = 1:length(spp) 
        if (isempty(cell2mat(fad(j))) == 0) || (isempty(cell2mat(mad(j))) == 0) %for adult speaker
            counterad = counterad+1; %if either adult speaker present
            adst(counterad) = st(j);
            adid(counterad) = idd(j);
        end
        
        if isempty(cell2mat(ch(j))) == 0  %for child speaker
            counterch = counterch+1; %if child speaker present
            chst(counterch) = st(j);
            chid(counterch) = idd(j);
        end
        
    end
    
    chstart{i} = chst;
    adstart{i} = adst;
    childid{i} = chid;
    adultid{i} = adid;
    
    clear chst adst chid adid
end

%Now, we need to sort through the child ids, then match to adult and
%child db, f values and store them
aages = [82 183 95 183 95];
%these ages correspond to childid: 274 and 340 (L1), 530 (L2), 340 and 530
%(L3)

counterj = 0;
for i = 1:length(filetag) %we have the three separate ids of the form {human listener,IVFCR<childid>}. eg: L1, IVFCR274
    uniqid = unique(childid{i}); %finds unique childid
    for j = 1:length(uniqid)
    counterj = counterj+1;
    idmat{counterj,1} = filetag{i};
    idmat{counterj,2} = uniqid{j};
    idmat{counterj,3} = aages(counterj);
    end
end

%Now, we need to sort the adstart and chstart matrices into these ids of the form {human listener,IVFCR<childid>}
%thsi is because some human listeners listened to multiple infant id data,
%and all of that is in a single file labelled by the human listener id

for i = 1:length(idmat)
    for j = 1:length(filetag)
        chnid = childid{j};
        chnst = chstart{j};
        adtid = adultid{j};
        adtst = adstart{j};
        if (strcmp(filetag{j},idmat{i,1}) == 1) 
            chst_factch{i} = chnst(strcmp(chnid,idmat{i,2})==1); %matches the child ids from chnid and idmat, after matching listener id
            adst_factch{i} = adtst(strcmp(adtid,idmat{i,2})==1);
        end
    end
end

%we now have adult and child starttimes labelled by human listeners. We now compare that to automated data 
%to get labels that match the automatedd ata, and the db and f values. In
%doing this, we will keep the subrecordings separate


load('data_zkm.mat')

datafactch_count = 0;

for i  = 1:length(chst_factch)-1 %ignoring L3's 530 data, because only partly completed
    stst_ch = chst_factch{i};
    for j = 1:length(start_all)
        if (strcmp(regexp(idmat{i,2},'[0-9]+','match'),id{j}) == 1) && (age(j) == idmat{i,3}) %pick out just the child id from the idmat
            %Note that we are only finding db and f labels of vocalisations
            %that match the start time - that is, we are not bothering
            %whetehr the speaker labels match for the human label and LENA
            [cc,idat,ifact] = intersect(start_all{j},stst_ch); %intersect with matching child ids
            if isempty(cc) == 0 %find child vocal details
                datafactch_count = datafactch_count + 1;
                datachst = start_all{j};
                datachen = end_all{j};
                datachlogf = z_logfall{j};
                datachdb = z_dall{j};
                %datachk = km_all{j};
                chst_humlab{datafactch_count} = datachst(idat);
                chen_humlab{datafactch_count} = datachen(idat);
                chlogf_humlab{datafactch_count} = datachlogf(idat);
                chdb_humlab{datafactch_count} = datachdb(idat);
                %chkm_humlab{datafactch_count} = datachk(idat);
                chage(datafactch_count) = age(j);
                listenerid{datafactch_count} = idmat{i,1};
                childid(datafactch_count) = regexp(idmat{i,2},'[0-9]+','match');
                speakerseg(datafactch_count) = segm(j);
                
            end 
        end    
    end
end

%Now, we pick out corresponding adult data - both human
%labelled and corresponding autolabelled

datafactch_count = 0;

for i  = 1:length(adst_factch)-1 %ignoring L3's 530 data
    stst_ad = adst_factch{i};
    for j = 1:length(start_all)
        if (strcmp(regexp(idmat{i,2},'[0-9]+','match'),id{j}) == 1) && (age(j) == idmat{i,3}) %pick out just the child id from the idmat
            [cc,idat,ifact] = intersect(start_all{j},stst_ad); %intersect with matching child ids
            if isempty(cc) == 0 %find child vocal details
                datafactch_count = datafactch_count + 1;
                datachst = start_all{j};
                datachen = end_all{j};
                datachlogf = z_logfall{j};
                datachdb = z_dall{j};
                %datachk = km_all{j};
                adst_humlab{datafactch_count} = datachst(idat);
                aden_humlab{datafactch_count} = datachen(idat);
                adlogf_humlab{datafactch_count} = datachlogf(idat);
                addb_humlab{datafactch_count} = datachdb(idat);
                %adkm_humlab{datafactch_count} = datachk(idat);
                age_adhumlab(datafactch_count) = age(j);
                listenerid_ad{datafactch_count} = idmat{i,1};
                childid_ad(datafactch_count) = regexp(idmat{i,2},'[0-9]+','match');
                speakerseg_ad(datafactch_count) = segm(j);

            end 
        end    
    end
end


%as a final step, we need to extract adult/chlid response data based on
%human labelling

%Now, we get adult response data based on human labels

for i = 1:length(chst_humlab)
     clear adr 
     sch = chst_humlab{i};
     ech = chen_humlab{i};
     sad = adst_humlab{i};
     ead = aden_humlab{i};
        %If there is an onset of a vocalization by the responder within 1 s or less from the offset of the initiator. 
        %If so, a response is said to have occurred. If not, then if the initiator had a vocalization onset within 1 s or 
        %less from the offset of the initiator, a response is not applicable. Otherwise, a response is said not to have occurred.
        for j = 1:length(sch)
            offset1 = ech(j);
            offset1plus1sec = ech(j) + 1;
            
            child_set = sch(sch >= offset1);
            child_set = child_set(child_set <= offset1plus1sec);
            
            adult_set = sad(sad >= offset1);
            adult_set = adult_set(adult_set <= offset1plus1sec);
            
            if isempty(adult_set) == 0 %if responder has a voc
                adr(j) = 1;
            elseif isempty(child_set) == 0 %if initiaor has a voc within 1 s
                adr(j) = 100; %for not applicable
            elseif isempty(adult_set) == 1 %if neither is applicable
                adr(j) = 0;
            end
        end
        adresponse_humlab{i} = adr;
        clear adr
end

%find child responses to adult
for i = 1:length(chst_humlab)
     clear chresp
     sch = chst_humlab{i};
     ech = chen_humlab{i};
     sad = adst_humlab{i};
     ead = aden_humlab{i};
        %If there is an onset of a vocalization by the responder within 1 s or less from the offset of the initiator. 
        %If so, a response is said to have occurred. If not, then if the initiator had a vocalization onset within 1 s or 
        %less from the offset of the initiator, a response is not applicable. Otherwise, a response is said not to have occurred.
        for j = 1:length(sad)
            offset1 = ead(j);
            offset1plus1sec = ead(j) + 1;
            
            child_set = sch(sch >= offset1);
            child_set = child_set(child_set <= offset1plus1sec);
            
            adult_set = sad(sad >= offset1);
            adult_set = adult_set(adult_set <= offset1plus1sec);
            
            if isempty(child_set) == 0 %if responder has a voc
                chresp(j) = 1;
            elseif isempty(adult_set) == 0 %if initiaor has a voc within 1 s
                chresp(j) = 100; %for not applicable
            elseif isempty(child_set) == 1 %if neither is applicable
                chresp(j) = 0;
            end
        end
        chresp2ad_humlab{i} = chresp;
        clear chresp
end


save('humanlab_addat.mat','adst_humlab','aden_humlab','adlogf_humlab','addb_humlab','chresp2ad_humlab','listenerid_ad','childid_ad','speakerseg_ad','age_adhumlab')
%,'adkm_humlab'
save('humanlab_chdat.mat','childid','speakerseg','listenerid','chage','chst_humlab','chen_humlab','chlogf_humlab','chdb_humlab','adresponse_humlab')%,'chkm_humlab'


