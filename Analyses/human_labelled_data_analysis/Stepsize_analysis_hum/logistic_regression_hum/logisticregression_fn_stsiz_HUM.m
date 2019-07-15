function T_stsiz = logisticregression_fn_stsiz_HUM(adr_id,adr_zd,adr_zlogf,adresponse,adr_age,adr_st,adr_en,listenerid)

%Ritwika VPS, UC Merced

%generate table with data for logistic regression with step sizes leading to the vocalisation of interest as
%independent variables - what vocalisation patterns are likely to egt
%responses. In addition, the acoustic dimension - pitch and amplitude - are
%also treated as independent variables.

%for human labelled data

%here, if voc i receives a response, the step size to voc i is the
%corresponding step size value. 
for i = 1:length(adr_id)
    clear placeholderforid placeholderforlistener
    if length(adr_zd{i}) >=2 %need at least two points to form a distance
    resp = adresponse{i};
    respcell{i,1} = resp(2:end);
        
    %so, we start from the second element of response matrix, so, the first element of 
    %dist_d would correspond to the difference between the second and first
    %voc (taht is, step in d to the vocalisation that is relevant to the second element of the response matrix)    
    dist_d{i,1} = abs(diff(adr_zd{i})); %diff(i) = (i+1)-(i).
    dist_f{i,1} = abs(diff(adr_zlogf{i}));
    st = adr_st{i};
    st = st(2:end); %so, the first voc cannot have a step size to it: that is for the second element of the 
    %response matrix, we have the temporal distance between the start of
    %the second voc and the end of the first voc - ie, the temporal
    %distance from the end of the first voc to the start of the second. So
    %on and so forth.
    en = adr_en{i};
    en = en(1:end-1); 
    fr = adr_zlogf{i};
    fr = fr(2:end);
    amp = adr_zd{i};
    amp = amp(2:end);
    freq_cell{i,1} = fr;
    amp_cell{i,1} = amp;
    dist_t{i,1} = st-en;
    [placeholderforid{1:length(dist_t{i,1})}] = deal(adr_id{i});
    idcell{i,1} = transpose(placeholderforid);
    agecell{i,1} = adr_age(i)*ones(size(dist_t{i,1}));
    [placeholderforlistener{1:length(dist_t{i,1})}] = deal(listenerid{i});
    listenercell{i,1} = transpose(placeholderforlistener);
    end
end

infantage = cell2mat(agecell);
response = transpose(cell2mat(transpose(respcell)));
id = vertcat(idcell{:});
amp_dist = cell2mat((dist_d));
freq_dist = cell2mat((dist_f));
time_dist = cell2mat((dist_t));
listener = vertcat(listenercell{:});
frequency = cell2mat(freq_cell);
amplitude = cell2mat(amp_cell);
infantid_listener = strcat(id,'_',listener); %concatenates infant id and listener id

T_stsiz = table(amp_dist,freq_dist,frequency,amplitude,time_dist,infantage,response,infantid_listener);

%remove rows with response = 100 (NA) - those correspond to "not
%applicable" response

toDelete = T_stsiz.response > 30;
T_stsiz(toDelete,:) = [];
toDelete = isnan(T_stsiz.freq_dist) == 1; %remove rows that have step sizes as NaN, either freq or amplitude isnt defined
T_stsiz(toDelete,:) = [];
toDelete = isnan(T_stsiz.amp_dist) == 1;
T_stsiz(toDelete,:) = [];
toDelete = isnan(T_stsiz.frequency) == 1; %remove rows that have step sizes as NaN, either freq or amplitude isnt defined
T_stsiz(toDelete,:) = [];
toDelete = isnan(T_stsiz.amplitude) == 1;
T_stsiz(toDelete,:)= [];

end
