clear all
clc

%Ritwika VPS
%UC Merced

%Sample plot for fit vs. data

load('adresp2ch_stepsizes.mat')

%randomly choose a dataset: there are 143 day level recordings, so we find
%a random number between 1 and 143, and round it down. We use an upper
%limit of 144 so that there is a chance that teh 143rd step sze
%distribution may also be randomly chosen.
ind = floor(1 + (144-1).*rand(1,1));

figure;
hold all
[aic_fad,ffit,p] = aicnew(distsp_ad_day{ind},[0 0 0 0],0);
aicmat = zeros(1,4);
aicmat(ffit) = 1; %indicates best fit
[xaxis,yaxis_fit,yaxis_dat] = aicplots(distsp_ad_day{ind},aicmat,0); %generates fit data for best fit
Area_dat=trapz(xaxis,yaxis_dat);
Area_fit=trapz(xaxis,yaxis_fit);
plot(xaxis,yaxis_dat/Area_dat,'DisplayName','\bf{Data}','LineWidth',2,'LineStyle','-',...
    'Color','r'); %data
plot(xaxis,yaxis_fit/Area_fit,'DisplayName','\bf{Fit}','LineWidth',2,'LineStyle','-',...
    'Color','b'); %fit

xlabel('\bf{Acoustic space step size}')
ylabel('\bf{Probability density}')

%plot sample data for visualising adult and infant vocalisations in 2d
%acoustic space, frequency-time space, and amplitude-time space
load('data_zkm.mat')
aa = start_all{1};
figure
set(gcf,'color','w');
hold all
f = z_logfall{1};
d = z_dall{1};
t = start_all{1};

sp = [0 0 0 0 1 0 1 0 0 0 0]; %corresponds to which vocalisation is adult and which one is infant
%1 is infant voc and 0 is adult
%note that # adult voc > infant voc
t = t(18:28);
f = f(18:28);
d = d(18:28);

%seperate infant and adult voc
t_ch = t(sp == 1);
f_ch = f(sp == 1);
d_ch = d(sp == 1);

t_ad = t(sp == 0);
f_ad = f(sp == 0);
d_ad = d(sp == 0);

subplot(1,3,1)
hold all
xlabel('Frequency')
ylabel('Amplitude')

%plots trajectory of vocalisations
for k = 1:length(d_ad)-1%length(r)-1
quiver(f_ad(k),d_ad(k),f_ad(k+1)-f_ad(k),d_ad(k+1)-d_ad(k),0,'b','LineWidth',1)
end
%since there are only 2 infant vocs, we don't need to loop quiver 
quiver(f_ch(1),d_ch(1),f_ch(2)-f_ch(1),d_ch(2)-d_ch(1),0,'y','LineWidth',1)

%plots points 
for k = 1:length(d)
if sp(k) == 0
plot(f(k),d(k),'bo')
else
plot(f(k),d(k),'yo')
end
end

%frequency time space
subplot(1,3,2)
xlabel('Time (s)')
ylabel('Frequency')
hold all

plot(t_ad,f_ad,'b','LineWidth',1)
plot(t_ch,f_ch,'y','LineWidth',1)

for k = 1:length(d)
if sp(k) == 0
plot(t(k),f(k),'bo')
else
plot(t(k),f(k),'yo')
end
end

%amplitude time space
subplot(1,3,3)
xlabel('Time (s)')
ylabel('Amplitude')
hold all

plot(t_ad,d_ad,'b','LineWidth',1)
plot(t_ch,d_ch,'y','LineWidth',1)

for k = 1:length(d)
if sp(k) == 0
plot(t(k),d(k),'bo')
else
plot(t(k),d(k),'yo')
end
end
