function T = logisticregression_fn_HUM(adr_id,adr_zd,adr_zlogf,adresponse,adr_age,listenerid)

%Ritwika VPS, UC Merced

%generate table with data logistic regression for wit freq and amplitudes as
%independent variables - what vocalisations are likely to egt
%responses - for human labelled data

for i = 1:length(adr_id)
    clear placeholderforid placeholderforlistener
    if isempty(adr_zd{i}) == 0
        [placeholderforid{1:length(adr_zd{i})}] = deal(adr_id{i});
        idcell{i,1} = transpose(placeholderforid);
        agecell{i,1} = adr_age(i)*ones(size(adr_zd{i}));
        smplcell{i,1} = length(adr_zd{i})*ones(size(adr_zd{i}));
        [placeholderforlistener{1:length(adr_zd{i})}] = deal(listenerid{i});
        listenercell{i,1} = transpose(placeholderforlistener); %has extra listener id as random effect
    end
    
end

amplitude = cell2mat(transpose(adr_zd));
frequency = cell2mat(transpose(adr_zlogf));
infantage = cell2mat(agecell);
smplsi = cell2mat(smplcell);
response = transpose(cell2mat(adresponse));
id = vertcat(idcell{:});
listener = vertcat(listenercell{:});

T = table(amplitude,frequency,infantage,response,smplsi,id,listener);

%remove rows with response = 100 (NA) - those correspond to "not
%applicable" response

toDelete = T.response > 30;
T(toDelete,:) = [];
toDelete = isnan(T.frequency) == 1; %remove rows that have either freq or amplitude isnt defined - is NaN
T(toDelete,:) = [];
toDelete = isnan(T.amplitude) == 1;
T(toDelete,:) = [];

end

