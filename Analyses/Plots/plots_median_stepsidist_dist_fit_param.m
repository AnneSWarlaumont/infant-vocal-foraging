clear all
clc
set(0,'defaulttextinterpreter','tex') %set default text interpreter to latex

%plots AIC best fit distributions, distributions fit parameters, as well as medians of step size
%distributions
%Medians were determined based on raw data
%For each distributions class - infant fequency step WR, infant freuqency
%step WOR, etc - only distributions that fit to the predominant fit for
%that category are plotted for both AIC best fit distribution plots as well
%as fit parameter plots.


%median and distributions:
for sec = 1
    
%--------------------------------------------------------------------------------
%1: space :  %child: lognormal
%------------------------------------------
aa = readtable('median_adresp2ch.csv');

figure;
set(gcf,'color','w');

subplot(2,2,1)
hold all
title('\bf{(child a)}')
plot(aa.age(aa.withad == 1),aa.median_sp(aa.withad == 1),'bs','MarkerSize',15) %wr is b, wor is r
plot(aa.age(aa.withad == 0),aa.median_sp(aa.withad == 0),'rs','MarkerSize',15)
ylabel('\bf{Median}','FontSize',40)
xlabel('\bf{Infant age (days)}')

subplot(2,2,3)
hold all
title('\bf{(c)}')
load('adresp2ch_stepsizes.mat')

for i = 1:length(id_age)
if (length(distsp_ad_day{i}) > 2) && (length(distsp_noad_day{i}) > 2)  %we club the ages from same child, discrete only
[aic_param,aic_fit,p] = aicnew(distsp_noad_day{i},[0 0 0 0],0);
if aic_fit == 2 %check that best fit is lognormal
[xaxis,yaxis_fit,yaxis_dat] = aicplots(distsp_noad_day{i},[0 1 0 0],0); %wor is r, wr is b
Area=trapz(xaxis,yaxis_fit);
plot(xaxis,yaxis_fit/Area,'r','LineWidth',1)
end
[aic_param,aic_fit,p] = aicnew(distsp_ad_day{i},[0 0 0 0],0);
if aic_fit == 2 %check that best fit is lognormal
[xaxis,yaxis_fit,yaxis_dat] = aicplots(distsp_ad_day{i},[0 1 0 0],0);
Area=trapz(xaxis,yaxis_fit);
plot(xaxis,yaxis_fit/Area,'b','LineWidth',1)
end
end
end


ll = legend({'\bf{WOR}','\bf{WR}'},'FontSize',24);
ylabel('\bf{Probability Density}','FontSize',40)
xlabel('\bf{Acoustic space step size}')

clear all

%--------------------------------------------------------------------------------
%1: time:  %child: lognormal
%------------------------------------------
aa = readtable('median_adresp2ch.csv');

set(gcf,'color','w');

subplot(2,2,2)
hold all
title('\bf{(b)}')
plot(aa.age(aa.withad == 1),aa.median_t(aa.withad == 1),'bs','MarkerSize',15) %wr is b, wor is r
plot(aa.age(aa.withad == 0),aa.median_t(aa.withad == 0),'rs','MarkerSize',15)

subplot(2,2,4)
hold all
title('\bf{(d)}')
load('adresp2ch_stepsizes.mat')

for i = 1:length(id_age)
if (length(disttim_ad_day{i}) > 2) && (length(disttim_noad_day{i}) > 2)  
[aic_param,aic_fit,p] = aicnew(disttim_noad_day{i},[0 0 0 0],0);
if aic_fit == 2 %check that best fit is lognormal
[xaxis,yaxis_fit,yaxis_dat] = aicplots(disttim_noad_day{i},[0 1 0 0],0); %wor is r, wr is b
Area=trapz(xaxis,yaxis_fit);
plot(xaxis,yaxis_fit/Area,'r','LineWidth',1)
end
[aic_param,aic_fit,p] = aicnew(disttim_ad_day{i},[0 0 0 0],0);
if aic_fit == 2 %check that best fit is lognormal
[xaxis,yaxis_fit,yaxis_dat] = aicplots(disttim_ad_day{i},[0 1 0 0],0);
Area=trapz(xaxis,yaxis_fit);
plot(xaxis,yaxis_fit/Area,'b','LineWidth',1)
end
end
end

xlabel('\bf{Time step size (s)}')

clear all

end


for sec = 1
figure;
hold all
%--------------------------------------------------------------------------------
%2: space : adult: lognormal
%------------------------------------------
subplot(2,2,1)
hold all
aa = readtable('median_chresp2ad.csv');
title('\bf{(a)}')
plot(aa.age(aa.withch == 1),aa.median_sp(aa.withch == 1),'ks','MarkerSize',15)
plot(aa.age(aa.withch == 0),aa.median_sp(aa.withch == 0),'gs','MarkerSize',15)

ylabel('\bf{Median}','FontSize',40)
xlabel('\bf{Infant age (days)}')

load('chresp2ad_stepsizes.mat')

subplot(2,2,3)
hold all
title('\bf{(c)}')

for i = 1:length(id_age)
if (length(distsp_ch_day{i}) > 2) && (length(distsp_noch_day{i}) > 2)  %we club the ages from same child, discrete only
[aic_param,aic_fit,p] = aicnew(distsp_noch_day{i},[0 0 0 0],0);
if aic_fit == 2 %check that best fit is lognormal
[xaxis,yaxis_fit,yaxis_dat] = aicplots(distsp_noch_day{i},[0 1 0 0],0);
Area=trapz(xaxis,yaxis_fit);
plot(xaxis,yaxis_fit/Area,'g','LineWidth',1)
end
[aic_param,aic_fit,p] = aicnew(distsp_ch_day{i},[0 0 0 0],0);
if aic_fit == 2 %check that best fit is lognormal
[xaxis,yaxis_fit,yaxis_dat] = aicplots(distsp_ch_day{i},[0 1 0 0],0);
Area=trapz(xaxis,yaxis_fit);
plot(xaxis,yaxis_fit/Area,'k','LineWidth',1)
end
end
end

ll = legend({'\bf{WOR}','\bf{WR}'},'FontSize',24);
ylabel('\bf{Probability Density}','FontSize',40)
xlabel('\bf{Acoustic space step size}')

clear all

% - median and distributions
%---------------------------------
%time: adult: pareto
%---------------------------------
subplot(2,2,2)
hold all
aa = readtable('median_chresp2ad.csv');
title('\bf{(b)}')
plot(aa.age(aa.withch == 1),aa.median_t(aa.withch == 1),'ks','MarkerSize',15)
plot(aa.age(aa.withch == 0),aa.median_t(aa.withch == 0),'gs','MarkerSize',15)

load('chresp2ad_stepsizes.mat')

subplot(2,2,4)
hold all
title('\bf{(d)}')

for i = 1:length(id_age)
if (length(disttim_ch_day{i}) > 2) && (length(disttim_noch_day{i}) > 2)  %we club the ages from same child, discrete only
[aic_param,aic_fit,p] = aicnew(disttim_noch_day{i},[0 0 0 0],0);
if aic_fit == 4 %check that best fit is lognormal
[xaxis,yaxis_fit,yaxis_dat] = aicplots(disttim_noch_day{i},[0 0 0 1],0);
Area=trapz(xaxis,yaxis_fit);
plot(xaxis,yaxis_fit/Area,'g','LineWidth',1)
end
[aic_param,aic_fit,p] = aicnew(disttim_ch_day{i},[0 0 0 0],0);
if aic_fit == 4 %check that best fit is lognormal
[xaxis,yaxis_fit,yaxis_dat] = aicplots(disttim_ch_day{i},[0 0 0 1],0);
Area=trapz(xaxis,yaxis_fit);
plot(xaxis,yaxis_fit/Area,'k','LineWidth',1)
end
end
end

xlabel('\bf{Time step size (s)}')

end

clear all

%parameters: child
for sec = 1
figure;
%child: subsequent vocalisation
aa =  readtable('adresp2ch_stepsizedist.csv');

%space steps: lognormal for child; mu
subplot(2,2,1)
hold all

plot(aa.age(aa.withad == 1 & aa.sp_fit == 2),aa.lognspmu(aa.withad == 1 & aa.sp_fit == 2),'bs','MarkerSize',15)
plot(aa.age(aa.withad == 0 & aa.sp_fit == 2),aa.lognspmu(aa.withad == 0 & aa.sp_fit == 2),'rs','MarkerSize',15)
ylabel('\bf{$\mu$}','Interpreter','latex','FontSize',40)

ll =legend({'\bf{WR}','\bf{WOR}'},'FontSize',24);

set(gcf,'color','w');

title('\bf{(a mu)}')

%Space steps: sigma
subplot(2,2,3)
hold all

plot(aa.age(aa.withad == 1 & aa.sp_fit == 2),aa.lognspsig(aa.withad == 1 & aa.sp_fit == 2),'bs','MarkerSize',15)
plot(aa.age(aa.withad == 0 & aa.sp_fit == 2),aa.lognspsig(aa.withad == 0 & aa.sp_fit == 2),'rs','MarkerSize',15)
ylabel('\bf{$\sigma$}','Interpreter','latex','FontSize',40)

set(gcf,'color','w');
xlabel('\bf{Infant age (days)}')

title('\bf{(c sig)}')

clear all


clear all

%parameters: adult - space is lognormal 
% adult: 
aa =  readtable('chr2ad_stepsizedist.csv');

%Space steps: : lognormal for both adult and child: mu
subplot(2,2,2)
hold all

plot(aa.age(aa.withch == 1 & aa.sp_fit == 2),aa.lognspmu(aa.withch == 1 & aa.sp_fit == 2),'ks', 'MarkerSize',15)
plot(aa.age(aa.withch == 0 & aa.sp_fit == 2),aa.lognspmu(aa.withch == 0 & aa.sp_fit == 2),'gs', 'MarkerSize',15)
ll =legend({'\bf{WR}','\bf{WOR}'},'FontSize',24);

set(gcf,'color','w');

title('\bf{(b mu)}')

%Space steps: sigma
subplot(2,2,4)
hold all

plot(aa.age(aa.withch == 1 & aa.sp_fit == 2),aa.lognspsig(aa.withch == 1 & aa.sp_fit == 2),'ks','MarkerSize',15)
plot(aa.age(aa.withch == 0 & aa.sp_fit == 2),aa.lognspsig(aa.withch == 0 & aa.sp_fit == 2),'gs','MarkerSize',15)

set(gcf,'color','w');

title('\bf{(d sig)}')

clear all

end

clear all
%--------------------------------------------------------------------------------
%2: Time 
%------------------------------------------

%parameters: child
for sec = 1
%time steps: , child: lognormal
aa =  readtable('adresp2ch_stepsizedist.csv');

figure;

%Time steps: lognormal for child voc

subplot(2,2,1)
hold all

plot(aa.age(aa.withad == 1 & aa.tim_fit == 2),aa.logntimmu(aa.withad == 1 & aa.tim_fit == 2),'bs','MarkerSize',15)
plot(aa.age(aa.withad == 0 & aa.tim_fit == 2),aa.logntimmu(aa.withad == 0 & aa.tim_fit == 2),'rs','MarkerSize',15)
ylabel('\bf{\mu}','Interpreter','tex','FontSize',40)
ll = legend({'\bf{WR}','\bf{WOR}'},'FontSize',20);

set(gcf,'color','w');

title('\bf{(a mu)}')

%Time: sigma
subplot(2,2,3)
hold all

plot(aa.age(aa.withad == 1 & aa.tim_fit == 2),aa.logntimsig(aa.withad == 1 & aa.tim_fit == 2),'bs','MarkerSize',15)
plot(aa.age(aa.withad == 0 & aa.tim_fit == 2),aa.logntimsig(aa.withad == 0 & aa.tim_fit == 2),'rs','MarkerSize',15)
ylabel('\bf{\sigma}','Interpreter','tex','FontSize',40)

set(gcf,'color','w');
xlabel('\bf{Infant age (days)}')

title('\bf{(c sigma)}')

clear all


%parameters: adult
% adult
aa =  readtable('chr2ad_stepsizedist.csv');

%Time steps: pareto for adult voc: xmin
subplot(2,2,2)
hold all

plot(aa.age(aa.withch == 1 & aa.tim_fit == 4),aa.paretotimxmin(aa.withch == 1 & aa.tim_fit == 4),'ks', 'MarkerSize',15)
plot(aa.age(aa.withch == 0 & aa.tim_fit == 4),aa.paretotimxmin(aa.withch == 0 & aa.tim_fit == 4),'gs', 'MarkerSize',15)

ll = legend({'\bf{WR}','\bf{WOR}'},'FontSize',20);

ylabel('\bf{x_{min}}','Interpreter','tex','FontSize',40)
set(gcf,'color','w');

title('\bf{(b xmin)}')

%Time steps: alpha
subplot(2,2,4)
hold all

plot(aa.age(aa.withch == 1 & aa.tim_fit == 4),aa.paretotimsig(aa.withch == 1 & aa.tim_fit == 4),'ks','MarkerSize',15)
plot(aa.age(aa.withch == 0 & aa.tim_fit == 4),aa.paretotimsig(aa.withch == 0 & aa.tim_fit == 4),'gs','MarkerSize',15)

set(gcf,'color','w');
ylabel('\bf{\alpha}','Interpreter','tex','FontSize',40)
title('\bf{(d alpha)}')
end

clear all

%--------------------------------------------------------------------------------
%4: frequency steps
%--------------------------------------------------------------------------------
%child:  and tw
for sec = 1

figure;
set(gcf,'color','w');

%ch  median
subplot(2,3,2)
hold all

title('\bf{(a)}')
aa = readtable('median_adresp2ch.csv');

plot(aa.age(aa.withad == 1),aa.median_f(aa.withad == 1),'bs','MarkerSize',15) %wr is b, wor is r
plot(aa.age(aa.withad == 0),aa.median_f(aa.withad == 0),'rs','MarkerSize',15)
ylabel('\bf{Median}','FontSize',40)

clear all

%child : frequency steps: exponential, lambda
aa =  readtable('adresp2ch_stepsizedist.csv');
subplot(2,3,5)
hold all

plot(aa.age(aa.withad == 1  & aa.f_fit == 3),aa.expf(aa.withad == 1 & aa.f_fit == 3),'bs','MarkerSize',15)
plot(aa.age(aa.withad == 0 & aa.f_fit == 3),aa.expf(aa.withad == 0 & aa.f_fit == 3),'rs','MarkerSize',15)
ylabel('\bf{\lambda}','FontSize',40)

title('\bf{(b lambda)}')

clear all

%child : step size distribution curves: exponential
load('adresp2ch_stepsizes.mat')

subplot(2,3,1)
hold all

title('\bf{(c)}')

for i = 1:length(id_age)
if (length(distf_ad_day{i}) > 2) && (length(distf_noad_day{i}) > 2) 
[aic_param,aic_fit,p] = aicnew(distf_noad_day{i},[0 0 0 0],0);
if aic_fit == 3 %check that best fit is exp    
[xaxis,yaxis_fit,yaxis_dat] = aicplots(distf_noad_day{i},[0 0 1 0],0);
Area=trapz(xaxis,yaxis_fit);
plot(xaxis,yaxis_fit/Area,'r','LineWidth',1)
end
[aic_param,aic_fit,p] = aicnew(distf_ad_day{i},[0 0 0 0],0);
if aic_fit == 3 %check that best fit is exp
[xaxis,yaxis_fit,yaxis_dat] = aicplots(distf_ad_day{i},[0 0 1 0],0);
Area=trapz(xaxis,yaxis_fit);
plot(xaxis,yaxis_fit/Area,'b','LineWidth',1)
end
end
end

ll = legend({'\bf{WOR}','\bf{WR}'},'FontSize',24);
ylabel('\bf{Probability Density}','Interpreter','tex','FontSize',40)

clear all

xlabel('\bf{Pitch step size}','Interpreter','tex','FontSize',40)

%adult

%adult  median
subplot(2,3,3)
hold all

title('\bf{(a)}')
aa = readtable('median_chresp2ad.csv');

plot(aa.age(aa.withch == 1),aa.median_f(aa.withch == 1),'ks','MarkerSize',15)
plot(aa.age(aa.withch == 0),aa.median_f(aa.withch == 0),'gs','MarkerSize',15)
ylabel('\bf{Median}','Interpreter','latex','FontSize',40)

clear all

%adult : frequency steps: exponential, lambda
aa =  readtable('chr2ad_stepsizedist.csv');
subplot(2,3,6)
hold all

plot(aa.age(aa.withch == 1 & aa.f_fit == 3),aa.expf(aa.withch == 1 & aa.f_fit == 3),'ks', 'MarkerSize',15)
plot(aa.age(aa.withch == 0 & aa.f_fit == 3),aa.expf(aa.withch == 0 & aa.f_fit == 3),'gs', 'MarkerSize',15)
ylabel('\bf{\lambda}','Interpreter','tex','FontSize',40)

title('\bf{(b lambda)}')

clear all

%adult : step size distribution curves
load('chresp2ad_stepsizes.mat')

subplot(2,3,4)
hold all

title('\bf{(c)}')

for i = 1:length(id_age)
if (length(distf_ch_day{i}) > 2) && (length(distf_noch_day{i}) > 2)  
[aic_param,aic_fit,p] = aicnew(distf_noch_day{i},[0 0 0 0],0);
if aic_fit == 3 %check that best fit is exp
[xaxis,yaxis_fit,yaxis_dat] = aicplots(distf_noch_day{i},[0 0 1 0],0);
Area=trapz(xaxis,yaxis_fit);
plot(xaxis,yaxis_fit/Area,'g','LineWidth',1)
end
[aic_param,aic_fit,p] = aicnew(distf_ch_day{i},[0 0 0 0],0);
if aic_fit == 3 %check that best fit is exp
[xaxis,yaxis_fit,yaxis_dat] = aicplots(distf_ch_day{i},[0 0 1 0],0);
Area=trapz(xaxis,yaxis_fit);
plot(xaxis,yaxis_fit/Area,'k','LineWidth',1)
end
end
end


ll = legend({'\bf{WOR}','\bf{WR}'},'FontSize',24);
ylabel('\bf{Probability Density}','Interpreter','tex','FontSize',40)

clear all

xlabel('\bf{Pitch step size}','FontSize',40)

end

clear all

%--------------------------------------------------------------------------------
%5 amplitude steps
%--------------------------------------------------------------------------------

%child:  and tw
for sec = 1

figure;
set(gcf,'color','w');

%ch  median
subplot(2,3,2)
hold all

title('\bf{(a)}')
aa = readtable('median_adresp2ch.csv');

plot(aa.age(aa.withad == 1),aa.median_d(aa.withad == 1),'bs','MarkerSize',15) %wr is b, wor is r
plot(aa.age(aa.withad == 0),aa.median_d(aa.withad == 0),'rs','MarkerSize',15)
ylabel('\bf{Median}','FontSize',40)

clear all

%child : amplitude steps: exponential, lambda
aa =  readtable('adresp2ch_stepsizedist.csv');
subplot(2,3,5)
hold all

plot(aa.age(aa.withad == 1  & aa.d_fit == 3),aa.expd(aa.withad == 1 & aa.d_fit == 3),'bs','MarkerSize',15)
plot(aa.age(aa.withad == 0 & aa.d_fit == 3),aa.expd(aa.withad == 0 & aa.d_fit == 3),'rs','MarkerSize',15)
ylabel('\bf{\lambda}','FontSize',40)

title('\bf{(b lambda)}')

clear all

%child : step size distribution curves: exponential
load('adresp2ch_stepsizes.mat')

subplot(2,3,1)
hold all

title('\bf{(c)}')

for i = 1:length(id_age)
if (length(distd_ad_day{i}) > 2) && (length(distd_noad_day{i}) > 2) 
[aic_param,aic_fit,p] = aicnew(distd_noad_day{i},[0 0 0 0],0);
if aic_fit == 3 %check that best fit is exp    
[xaxis,yaxis_fit,yaxis_dat] = aicplots(distd_noad_day{i},[0 0 1 0],0);
Area=trapz(xaxis,yaxis_fit);
plot(xaxis,yaxis_fit/Area,'r','LineWidth',1)
end
[aic_param,aic_fit,p] = aicnew(distd_ad_day{i},[0 0 0 0],0);
if aic_fit == 3 %check that best fit is exp
[xaxis,yaxis_fit,yaxis_dat] = aicplots(distd_ad_day{i},[0 0 1 0],0);
Area=trapz(xaxis,yaxis_fit);
plot(xaxis,yaxis_fit/Area,'b','LineWidth',1)
end
end
end

ll = legend({'\bf{WOR}','\bf{WR}'},'FontSize',24);
ylabel('\bf{Probability Density}','Interpreter','tex','FontSize',40)

clear all

xlabel('\bf{Amplitude step size}','Interpreter','tex','FontSize',40)

%adult

%adult  median
subplot(2,3,3)
hold all

title('\bf{(a)}')
aa = readtable('median_chresp2ad.csv');

plot(aa.age(aa.withch == 1),aa.median_d(aa.withch == 1),'ks','MarkerSize',15)
plot(aa.age(aa.withch == 0),aa.median_d(aa.withch == 0),'gs','MarkerSize',15)
ylabel('\bf{Median}','Interpreter','latex','FontSize',40)

clear all

%adult : amplitude steps: exponential, lambda
aa =  readtable('chr2ad_stepsizedist.csv');
subplot(2,3,6)
hold all

plot(aa.age(aa.withch == 1 & aa.d_fit == 3),aa.expd(aa.withch == 1 & aa.d_fit == 3),'ks', 'MarkerSize',15)
plot(aa.age(aa.withch == 0 & aa.d_fit == 3),aa.expd(aa.withch == 0 & aa.d_fit == 3),'gs', 'MarkerSize',15)
ylabel('\bf{\lambda}','Interpreter','tex','FontSize',40)

title('\bf{(b lambda)}')

clear all

%adult : step size distribution curves
load('chresp2ad_stepsizes.mat')

subplot(2,3,4)
hold all

title('\bf{(c)}')

for i = 1:length(id_age)
if (length(distd_ch_day{i}) > 2) && (length(distd_noch_day{i}) > 2)  
[aic_param,aic_fit,p] = aicnew(distd_noch_day{i},[0 0 0 0],0);
if aic_fit == 3 %check that best fit is exp
[xaxis,yaxis_fit,yaxis_dat] = aicplots(distd_noch_day{i},[0 0 1 0],0);
Area=trapz(xaxis,yaxis_fit);
plot(xaxis,yaxis_fit/Area,'g','LineWidth',1)
end
[aic_param,aic_fit,p] = aicnew(distd_ch_day{i},[0 0 0 0],0);
if aic_fit == 3 %check that best fit is exp
[xaxis,yaxis_fit,yaxis_dat] = aicplots(distd_ch_day{i},[0 0 1 0],0);
Area=trapz(xaxis,yaxis_fit);
plot(xaxis,yaxis_fit/Area,'k','LineWidth',1)
end
end
end


ll = legend({'\bf{WOR}','\bf{WR}'},'FontSize',24);
ylabel('\bf{Probability Density}','Interpreter','tex','FontSize',40)

clear all

xlabel('\bf{Amplitude step size}','FontSize',40)

end


