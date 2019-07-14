function T = lmer_corrltn_data(adr_id,adr_zd,adr_zlogf,adr_age,adr_st,adr_en,adresponse)

%Ritwika VPS, UC Merced

%generate table with data for linear mixed effects model with time step sizes as
%independent variables and acoustic space step size as dependent

for i = 1:length(adr_id)
    clear placeholderforid
    if length(adr_zd{i}) >=2 %need at least two points to form a distance
    dist_d{i,1} = diff(adr_zd{i});
    dist_f{i,1} = diff(adr_zlogf{i});
    st = adr_st{i};
    st = st(2:end); %step sizes in time is the difference between the start of the i+1 th vo and the end of the ith voc. 
    %So only the second start time and onwards is relevant. And similarly,
    %only the end time before the last one is relevant
    en = adr_en{i};
    en = en(1:end-1);
    dist_t{i,1} = st-en;
    [placeholderforid{1:length(dist_t{i,1})}] = deal(adr_id{i}); %creates a vector with the child id
    idcell{i,1} = transpose(placeholderforid);
    agecell{i,1} = adr_age(i)*ones(size(dist_t{i,1}));
    adr = transpose(adresponse{i});
    adresp_cell{i,1} = adr(1:end-1); %we are interested in whether correlation changes wrt steps following response or not
    end
end

infantage = cell2mat(agecell);
id = vertcat(idcell{:});
amp_dist = cell2mat((dist_d));
freq_dist = cell2mat((dist_f));
time_dist = cell2mat((dist_t));
response = cell2mat(adresp_cell);

T = table(amp_dist,freq_dist,time_dist,infantage,id,response);

toDelete = T.response > 30; %remove rows that have response NA
T(toDelete,:) = [];
toDelete = T.time_dist < 1; %remove rows that have time step sizes < 1 (control for NA)
T(toDelete,:) = [];
toDelete = isnan(T.freq_dist) == 1; %remove rows that have step sizes as NaN, either freq or amplitude isnt defined
T(toDelete,:) = [];
toDelete = isnan(T.amp_dist) == 1;
T(toDelete,:) = [];

end



