function[addistfday,noaddistfday,addistdday,noaddistdday,addistspday,noaddistspday,...
    addisttday,noaddisttday,advelspday,noadvelspday,id_age] = finddist_andgroup_timewin(start1,end1,d1,f1,r1,age1,id1,humlist1)

%Ritwika VPS, UC Merced

%finds step sizes and concatenates subrecordngs from same infant on same
%day - 15 s time window after responses and non responses

%we'll find distances in f space, d space, vocal space, and time
for j = 1:length(start1)

clear dis_f dis_d dis_sp dis_t

st = start1{j};
en = end1{j};
r = r1{j}; 
f = f1{j};
d = d1{j};

if length(st) > 1 %need at least two elements to make a distance
   
%find distance
for i = 1:length(d)-1
    dis_f(i) = sqrt((f(i+1)-f(i))^2);
    dis_d(i) = sqrt((d(i+1)-d(i))^2);
    dis_sp(i) = sqrt((d(i+1)-d(i))^2 + (f(i+1)-f(i))^2);
    dis_t(i) = st(i+1) - en(i);
end

%There is a 1 s wait between the end of
%vocalisation i and the beginning of vocalisation i+1 to make sure that
%vocalisation i did not receive a response. But receiving a response does not have this restriction
%So, we need to add a 1 s threshold. So that shorter time stepsof less than 1 s etc are not
%counted into the with response category

%Note: a good test to make sure that this is working is to check the length
%of matrices of distances away from responses - since the 1 s threshold
%shouldn't filter those, they should have the same number of elements with
%or without the filter

for i = 1:length(r) - 1
    if dis_t(i) < 1
        r(i) = -1;
    end
end

%populate by time window: Essentially, all vocalisations that fall within
%15 s after a response is designated to be in the vicinity of a response.
%The rest are not. Note that we have NaN values for responses, and in the f
%and d matrices sometimes.

%have a matrix corresponding to indices of response matrix
indexmat = 1:length(r);

%zeros to fill up with assignations for voalisations: 0 (away from
%repsonse), 1 (close to response - 15 s window), NA response (100), if time
%step is less than 1 s (-1)
zeromat = zeros(size(r));

%find all vocalisations that lay in a 15 s window after adult response:
%essentially, anything that is 15 seconds or less after the end of a
%vocalisation that received response
for i = 1:length(r)
    %if a response has been received, then define endpoints: end of
    %vocalisation, and 15s after the end. If there are other vocalisations
    %starting within that time frame, tag them as in the vicinity of
    %responses in zeromat
   if r(i) == 1 
       endi = en(i);
       endi15 = en(i) + 15;
       nearresp = st(st > endi);
       nearresp = nearresp(nearresp < endi15);
       [cc,iin,inearresp] = intersect(st,nearresp);
       zeromat(iin) = 1;
   end    
end

%find where all the NAs (100) are, less than 1 s time steps (-1) are; fill corresponding indices 
zeromat(r == 100) = 100;
zeromat(r == -1) = -1;

zeromat = zeromat(1:end-1); %there cant be a distance correspoding to teh last vocalisation

%remove nan values - space steps would have any nan values fork bth f and
%d, so that is teh ideal standard to remove nans based on 
dis_t = dis_t(isnan(dis_sp) == 0);
dis_f = dis_f(isnan(dis_sp) == 0);
dis_d = dis_d(isnan(dis_sp) == 0);
zeromat = zeromat(isnan(dis_sp) == 0);
dis_sp = dis_sp(isnan(dis_sp) == 0);

addistfsubrec{j} = dis_f(zeromat == 1);
addistdsubrec{j} = dis_d(zeromat == 1);
addistspsubrec{j} = dis_sp(zeromat == 1);
addisttimsubrec{j} = dis_t(zeromat == 1);
advelspsubrec{j} = dis_sp(zeromat == 1)./dis_t(zeromat == 1);

noaddistfsubrec{j} = dis_f(zeromat == 0);
noaddistdsubrec{j} = dis_d(zeromat == 0);
noaddistspsubrec{j} = dis_sp(zeromat == 0);
noaddisttimsubrec{j} = dis_t(zeromat == 0); 
noadvelspsubrec{j} = dis_sp(zeromat == 0)./dis_t(zeromat == 0);

end
end

%Now, we organise the distances - from each subrecording at this point -
%into single recordings per day per id. - use only for human labelled data

%We need to check for empty matrices and also club together data from same
%id and age, by clubbing subrecordings (_day)

%first, we concatenate age and id and listenerid
for i = 1:length(id1)  
    id_age{i} = sprintf('%s_%d_%s',id1{i},age1(i),humlist1{i});
end

%pick out unique combinations
id_age = unique(id_age);

for i  = 1:length(id_age)
    addistfday{i} = [];
    addistdday{i} = [];
    addistspday{i} = [];
    addisttday{i} = [];
    advelspday{i} = [];
    
    noaddistfday{i} = [];
    noaddistdday{i} = [];
    noaddistspday{i} = [];
    noaddisttday{i} = [];
    noadvelspday{i} = [];
    
    for j = 1:length(noaddistfsubrec)
        %check which id and age combinations match elements of id_age; also
        %check for empty matrices
    if (strcmp(id_age{i},sprintf('%s_%d_%s',id1{j},age1(j),humlist1{j})) == 1) && (isempty(noadvelspsubrec{j}) == 0) && (isempty(advelspsubrec{j}) == 0) 
        
        addistfday{i} = [addistfday{i} addistfsubrec{j}];%once we identify the ones that belong to same id and age, we concatenate them
        addistdday{i} = [addistdday{i} addistdsubrec{j}];
        addistspday{i} = [addistspday{i} addistspsubrec{j}];
        addisttday{i} = [addisttday{i} addisttimsubrec{j}];
        advelspday{i} = [advelspday{i} advelspsubrec{j}];
        
        noaddistfday{i} = [noaddistfday{i} noaddistfsubrec{j}];
        noaddistdday{i} = [noaddistdday{i} noaddistdsubrec{j}];
        noaddistspday{i} = [noaddistspday{i} noaddistspsubrec{j}];
        noaddisttday{i} = [noaddisttday{i} noaddisttimsubrec{j}];
        noadvelspday{i} = [noadvelspday{i} noadvelspsubrec{j}];
    end
    end
    
    
end
end
