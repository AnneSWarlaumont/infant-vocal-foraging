clear all
clc

%Ritwika UC Merced

%plot sample data for visualising adult and infant vocalisations in 2d
%acoustic space, frequency-time space, and amplitude-time space: extended
%vocalisation sequence

load('data_zkm.mat')
f = z_logfall{1}; %picks the same dataset as for smaller vocalisation sequence figure; all corrresponds to both infant and adult data combined
d = z_dall{1};
t = start_all{1};

d_ch = z_dch{1}; %ch corresponds to infant data
f_ch = z_logfch{1};
t_ch = start_ch{1};

%note that # adult voc > infant voc
t = t(50:100); %picks out an interval during which there is a reasonable number of infant and adult data points
f = f(50:100);
d = d(50:100);

[cc,i_all,i_ch] = intersect(t,t_ch); %finds intersection of start times from 'all' dataset for the chosen interval and the 'ch' dataset

t_ch = t_ch(i_ch); %picks out the relevant child data points from the chosen interval based on the indices outputed by the intersect function.
f_ch = f_ch(i_ch);
d_ch = d_ch(i_ch);

ind = 1:length(t);
newindad = setdiff(ind,i_all); %finds indices of 'all' dataset of the chosen interval that are not child data points

t_ad = t(newindad); %picks out adult data points form the chosen interval
f_ad = f(newindad);
d_ad = d(newindad);

figure
set(gcf,'color','w');
hold all
subplot(1,3,1)
hold all
xlabel('\bf{Frequency}','FontSize',30)
ylabel('\bf{Amplitude}','FontSize',30)

title('\bf{(d)}','FontSize',30)

%plots trajectory of vocalisations
for k = 1:length(d_ad)-1
quiver(f_ad(k),d_ad(k),f_ad(k+1)-f_ad(k),d_ad(k+1)-d_ad(k),0,'b','LineWidth',2)
end
for k = 1:length(d_ch)-1
quiver(f_ch(k),d_ch(k),f_ch(k+1)-f_ch(k),d_ch(k+1)-d_ch(k),0,'Color',[0.929411768913269 0.694117665290833 0.125490203499794],'LineWidth',2)
end

%plots points 
plot(f_ad,d_ad,'bo','MarkerSize',10)
plot(f_ch,d_ch,'Color',[0.929411768913269 0.694117665290833 0.125490203499794],'MarkerSize',10,'Marker','o')

%frequency time space
subplot(1,3,2)
title('\bf{(e)}','FontSize',30)
xlabel('\bf{Time (s)}','FontSize',30)
ylabel('\bf{Frequency}','FontSize',30)
hold all

plot(t_ad,f_ad,'b','LineWidth',2)
plot(t_ch,f_ch,'Color',[0.929411768913269 0.694117665290833 0.125490203499794],'LineWidth',2)

%plots points 
plot(t_ad,f_ad,'bo','MarkerSize',10)
plot(t_ch,f_ch,'Color',[0.929411768913269 0.694117665290833 0.125490203499794],'MarkerSize',10,'Marker','o')

%amplitude time space
subplot(1,3,3)
title('\bf{(f)}','FontSize',30)
xlabel('\bf{Time (s)}','FontSize',30)
ylabel('\bf{Amplitude}','FontSize',30')
hold all

plot(t_ad,d_ad,'b','LineWidth',2)
plot(t_ch,d_ch,'Color',[0.929411768913269 0.694117665290833 0.125490203499794],'LineWidth',2)

%plots points 
plot(t_ad,d_ad,'bo','MarkerSize',10)
plot(t_ch,d_ch,'Color',[0.929411768913269 0.694117665290833 0.125490203499794],'MarkerSize',10,'Marker','o')


