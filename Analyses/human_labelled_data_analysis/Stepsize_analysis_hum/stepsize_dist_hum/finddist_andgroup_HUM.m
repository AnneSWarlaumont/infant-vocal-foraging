function[addistfday,noaddistfday,addistdday,noaddistdday,addistspday,noaddistspday,...
    addisttday,noaddisttday,id_age] = finddist_andgroup_HUM(start1,end1,d1,f1,r1,age1,id1,humlist1)

%Ritwika VPS, UC Merced

%finds step sizes and concatenates subrecordngs from same infant on same
%day - based on whether a vocalisation received a repsonse (WR) or not (WOR) - 

%ONLY USE FOR humanlabelled data

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

%So, by designating vocalisations with distances in time less than 1 s as
%corresponding to -1 in responses, we can filter these out

%take the vocalisation follwing each one to look at step sizes etc. Note
%that each set of distances is from a subrecording (ergo the _subrec)
r = r(1:end-1);

%remove nan values - space steps would have any nan values fork bth f and
%d, so that is teh ideal standard to remove nans based on 
dis_t = dis_t(isnan(dis_sp) == 0);
dis_f = dis_f(isnan(dis_sp) == 0);
dis_d = dis_d(isnan(dis_sp) == 0);
r = r(isnan(dis_sp) == 0);
dis_sp = dis_sp(isnan(dis_sp) == 0);

addistfsubrec{j} = dis_f(r == 1);
addistdsubrec{j} = dis_d(r == 1);
addistspsubrec{j} = dis_sp(r == 1);
addisttimsubrec{j} = dis_t(r == 1);

noaddistfsubrec{j} = dis_f(r == 0);
noaddistdsubrec{j} = dis_d(r == 0);
noaddistspsubrec{j} = dis_sp(r == 0);
noaddisttimsubrec{j} = dis_t(r == 0); 

end
end

%Now, we organise the distances - from each subrecording at this point -
%into single recordings per day per id.

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
   
    noaddistfday{i} = [];
    noaddistdday{i} = [];
    noaddistspday{i} = [];
    noaddisttday{i} = [];
    
    for j = 1:length(noaddistfsubrec)
        %check which id and age combinations match elements of id_age; also
        %check for empty matrices
    if (strcmp(id_age{i},sprintf('%s_%d_%s',id1{j},age1(j),humlist1{j})) == 1) && (isempty(noaddistspsubrec{j}) == 0) && (isempty(addistspsubrec{j}) == 0) 
        
        addistfday{i} = [addistfday{i} addistfsubrec{j}];%once we identify the ones that belong to same id and age, we concatenate them
        addistdday{i} = [addistdday{i} addistdsubrec{j}];
        addistspday{i} = [addistspday{i} addistspsubrec{j}];
        addisttday{i} = [addisttday{i} addisttimsubrec{j}];
        
        noaddistfday{i} = [noaddistfday{i} noaddistfsubrec{j}];
        noaddistdday{i} = [noaddistdday{i} noaddistdsubrec{j}];
        noaddistspday{i} = [noaddistspday{i} noaddistspsubrec{j}];
        noaddisttday{i} = [noaddisttday{i} noaddisttimsubrec{j}];
    end
    end
    
    
end
end
