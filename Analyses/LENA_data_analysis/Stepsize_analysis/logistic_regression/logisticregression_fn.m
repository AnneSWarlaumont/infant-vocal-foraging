function T = logisticregression_fn(adr_id,adr_zd,adr_zlogf,adresponse,adr_age)

%Ritwika VPS, UC Merced

%generate table with data for logistic regression with freq and amplitudes as
%independent variables - what vocalisations in terms of pitch and amplitude are likely to egt
%responses

for i = 1:length(adr_id)
    clear placeholderforid
    if isempty(adr_zd{i}) == 0
        [placeholderforid{1:length(adr_zd{i})}] = deal(adr_id{i}); %creates a cell array of specified length with adr_id{i} as all the elements
        idcell{i,1} = transpose(placeholderforid);
        agecell{i,1} = adr_age(i)*ones(size(adr_zd{i}));
    end
    
end

amplitude = cell2mat(transpose(adr_zd));
frequency = cell2mat(transpose(adr_zlogf));
infantage = cell2mat(agecell);
response = transpose(cell2mat(adresponse));
id = vertcat(idcell{:});

T = table(amplitude,frequency,infantage,response,id);

%remove rows with response = 100 (NA) - those correspond to "not
%applicable" response

toDelete = T.response > 30;
T(toDelete,:) = [];
toDelete = isnan(T.frequency) == 1;%remove rows that have either freq or amplitude isnt defined - is NaN
T(toDelete,:) = [];
toDelete = isnan(T.amplitude) == 1;
T(toDelete,:) = [];

end

