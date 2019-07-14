function [median_sp,median_d,median_f,median_t,age,id,response,samplesi] = median_fn(distsp_ad_day,distsp_noad_day,distd_ad_day,distd_noad_day,...
                                                                    distf_ad_day,distf_noad_day,disttim_ad_day,disttim_noad_day,id_age)

%Ritwika VPS, UC Merced
                                                                
%finds median of different step size distributions - with or without responses - and summarises in a table with child id, age, and response recieved or no             

j = 0;
for i = 1:length(distsp_ad_day)
if (isempty(distsp_ad_day{i}) == 0) && (isempty(distsp_noad_day{i}) == 0) %checks that both are not empty
j = j + 1;  

median_ch_sp(j,1) = median(distsp_ad_day{i}); %finds median
median_noch_sp(j,1) = median(distsp_noad_day{i});

median_ch_d(j,1) = median(distd_ad_day{i});
median_noch_d(j,1) = median(distd_noad_day{i});

median_ch_f(j,1) = median(distf_ad_day{i});
median_noch_f(j,1) = median(distf_noad_day{i});

median_ch_t(j,1) = median(disttim_ad_day{i});
median_noch_t(j,1) = median(disttim_noad_day{i});

aa = strsplit(id_age{i},'_');
age(j,1) = str2num(aa{2});

samplesi(j,1) = length(distsp_ad_day{i}) + length(distsp_noad_day{i}); %samplesieze

id{j,1} = aa{1};
end
end

median_sp = [median_ch_sp
    median_noch_sp];

median_d = [median_ch_d
    median_noch_d];

median_f = [median_ch_f
    median_noch_f];

median_t = [median_ch_t
    median_noch_t];

age = [age
    age];

id = [id
    id];

samplesi = [samplesi
    samplesi];

yesch = ones(length(median_ch_d),1);
noch = zeros(size(yesch));

response = [yesch
    noch];

end

 




