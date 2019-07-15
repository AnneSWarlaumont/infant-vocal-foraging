function T = logisticregression_fn_HUM(adr_id,adr_zd,adr_zlogf,adresponse,adr_age,listenerid)

%Ritwika VPS, UC Merced

%for human labelled data

%generate table with data for logistic regression with freq and amplitudes as
%independent variables - what vocalisations in terms of pitch and amplitude are likely to egt
%responses

for i = 1:length(adr_id)
    clear placeholderforid placeholderforlistener
    if isempty(adr_zd{i}) == 0
        [placeholderforid{1:length(adr_zd{i})}] = deal(adr_id{i}); %creates a cell array of specified length with adr_id{i} as all the elements
        idcell{i,1} = transpose(placeholderforid);
        agecell{i,1} = adr_age(i)*ones(size(adr_zd{i}));
        [placeholderforlistener{1:length(adr_zd{i})}] = deal(listenerid{i}); %creates a cell array of specified length with listenerid{i} as all the elements
        listenercell{i,1} = transpose(placeholderforlistener); %has extra listener id as random effect
    end
    
end

amplitude = cell2mat(transpose(adr_zd));
frequency = cell2mat(transpose(adr_zlogf));
infantage = cell2mat(agecell);
response = transpose(cell2mat(adresponse));
id = vertcat(idcell{:});
listener = vertcat(listenercell{:});
infantid_listener = strcat(id,'_',listener); %concatenates infant id and listener id

T = table(amplitude,frequency,infantage,response,infantid_listener);

%remove rows with response = 100 (NA) - those correspond to "not
%applicable" response

toDelete = T.response > 30;
T(toDelete,:) = [];
toDelete = isnan(T.frequency) == 1; %remove rows that have either freq or amplitude isnt defined - is NaN
T(toDelete,:) = [];
toDelete = isnan(T.amplitude) == 1;
T(toDelete,:) = [];

end

