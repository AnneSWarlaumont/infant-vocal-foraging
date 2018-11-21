function [prctile90_sp,prctile90_d,prctile90_f,prctile90_t,prctile90_vsp,age,id,withch,samplesi] = prctile90_fn(distsp_ad_day,distsp_noad_day,distd_ad_day,distd_noad_day,...
                                                                    distf_ad_day,distf_noad_day,disttim_ad_day,disttim_noad_day,velsp_ad_day,velsp_noad_day,id_age)
%Ritwika VPS, UC Merced

%finds 90th percentile of different step size distributions - with or without responses - and summarises in a table with child id, age, and response recieved or no             

j = 0;
for i = 1:length(distsp_ad_day)
if (isempty(distsp_ad_day{i}) == 0) && (isempty(distsp_noad_day{i}) == 0) %checks that both are not empty
j = j + 1;  

prctile90_ch_sp(j,1) = prctile(distsp_ad_day{i},90); %finds 90th percentile
prctile90_noch_sp(j,1) = prctile(distsp_noad_day{i},90);

prctile90_ch_d(j,1) = prctile(distd_ad_day{i},90);
prctile90_noch_d(j,1) = prctile(distd_noad_day{i},90);

prctile90_ch_f(j,1) = prctile(distf_ad_day{i},90);
prctile90_noch_f(j,1) = prctile(distf_noad_day{i},90);

prctile90_ch_t(j,1) = prctile(disttim_ad_day{i},90);
prctile90_noch_t(j,1) = prctile(disttim_noad_day{i},90);

prctile90_ch_vsp(j,1) = prctile(velsp_ad_day{i},90);
prctile90_noch_vsp(j,1) = prctile(velsp_noad_day{i},90);

aa = strsplit(id_age{i},'_');
age(j,1) = str2num(aa{2});

samplesi(j,1) = length(distsp_ad_day{i}) + length(distsp_noad_day{i}); %samplesieze

id{j,1} = aa{1};
end
end

prctile90_sp = [prctile90_ch_sp
    prctile90_noch_sp];

prctile90_d = [prctile90_ch_d
    prctile90_noch_d];

prctile90_f = [prctile90_ch_f
    prctile90_noch_f];

prctile90_t = [prctile90_ch_t
    prctile90_noch_t];

prctile90_vsp = [prctile90_ch_vsp
    prctile90_noch_vsp];

age = [age
    age];

id = [id
    id];

samplesi = [samplesi
    samplesi];

yesch = ones(length(prctile90_ch_d),1);
noch = zeros(size(yesch));

withch = [yesch
    noch];

 end




