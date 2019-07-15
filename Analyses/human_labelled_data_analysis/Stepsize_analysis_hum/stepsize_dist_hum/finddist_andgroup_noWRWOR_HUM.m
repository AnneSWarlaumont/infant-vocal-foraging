function[distfday,distdday,distspday,disttday,id_age] = finddist_andgroup_noWRWOR_HUM(start1,end1,d1,f1,age1,id1,humlist1)

%Ritwika VPS, UC Merced

%finds step sizes and concatenates subrecordngs from same infant on same
%day without WR and WOR categories 

%ONLY USE FOR humanlabelled data

%we'll find distances in f space, d space, vocal space, and time
for j = 1:length(start1)

clear dis_f dis_d dis_sp dis_t

st = start1{j};
en = end1{j}; 
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

%remove nan values - space steps would have any nan values fork bth f and
%d, so that is teh ideal standard to remove nans based on 
dis_t = dis_t(isnan(dis_sp) == 0);
dis_f = dis_f(isnan(dis_sp) == 0);
dis_d = dis_d(isnan(dis_sp) == 0);
dis_sp = dis_sp(isnan(dis_sp) == 0);

distfsubrec{j} = dis_f;
distdsubrec{j} = dis_d;
distspsubrec{j} = dis_sp;
disttimsubrec{j} = dis_t;

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
    distfday{i} = [];
    distdday{i} = [];
    distspday{i} = [];
    disttday{i} = [];
    
    for j = 1:length(distfsubrec)
        %check which id and age combinations match elements of id_age; also
        %check for empty matrices
    if (strcmp(id_age{i},sprintf('%s_%d_%s',id1{j},age1(j),humlist1{j})) == 1) && (isempty(distspsubrec{j}) == 0) 
        
        distfday{i} = [distfday{i} distfsubrec{j}];%once we identify the ones that belong to same id and age, we concatenate them
        distdday{i} = [distdday{i} distdsubrec{j}];
        distspday{i} = [distspday{i} distspsubrec{j}];
        disttday{i} = [disttday{i} disttimsubrec{j}];
        
    end
    end
    
    
end
end
