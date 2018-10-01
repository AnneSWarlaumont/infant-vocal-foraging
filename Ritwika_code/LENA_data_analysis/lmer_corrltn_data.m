function T = lmer_corrltn_data(adr_id,adr_zd,adr_zlogf,adr_age,adr_st,adr_en)

%Ritwika VPS, UC Merced

%generate table with data for linear mixed effects model with time step sizes as
%independent variables and acoustic space step size as dependent

for i = 1:length(adr_id)
    clear placeholderforid
    if length(adr_zd{i}) >=2 %need at least two points to form a distance
    dist_d{i,1} = diff(adr_zd{i});
    dist_f{i,1} = diff(adr_zlogf{i});
    st = adr_st{i};
    st = st(2:end); %so, the first voc cannot have a step size to it
    en = adr_en{i};
    en = en(1:end-1);
    dist_t{i,1} = st-en;
    [placeholderforid{1:length(dist_t{i,1})}] = deal(adr_id{i});
    idcell{i,1} = transpose(placeholderforid);
    agecell{i,1} = adr_age(i)*ones(size(dist_t{i,1}));
    smplcell{i,1} = length(dist_t{i,1})*ones(size(dist_t{i,1}));
    end
end

infantage = cell2mat(agecell);
smplsi = cell2mat(smplcell); %note that sample size here is before removing NaN entries
id = vertcat(idcell{:});
amp_dist = cell2mat((dist_d));
freq_dist = cell2mat((dist_f));
time_dist = cell2mat((dist_t));

T = table(amp_dist,freq_dist,time_dist,infantage,smplsi,id);

toDelete = isnan(T.freq_dist) == 1; %remove rows that have step sizes as NaN, either freq or amplitude isnt defined
T(toDelete,:) = [];
toDelete = isnan(T.amp_dist) == 1;
T(toDelete,:) = [];

end



