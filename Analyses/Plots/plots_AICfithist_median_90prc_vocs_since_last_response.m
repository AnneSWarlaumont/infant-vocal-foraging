clear all
clc
set(0,'defaulttextinterpreter','tex') %set default text interpreter to tex


%11 AIC fit histograms
for sec = 1
clear all

%generate bar plot-able data for all step size distributions in 6 categories: infant WR, infant WOR,
%infant unsplit, adult WR, adult WOR, adult unsplit. (Step Distributions of
%pitch, amplitude, acoustic space, and time )
aa = readtable('adresp2ch_stepsizedist.csv');
fad2ch = fittypesum(aa.f_fit(aa.withad == 1));
fnoad2ch = fittypesum(aa.f_fit(aa.withad == 0));
dad2ch = fittypesum(aa.d_fit(aa.withad == 1));
dnoad2ch = fittypesum(aa.d_fit(aa.withad == 0));
spad2ch = fittypesum(aa.sp_fit(aa.withad == 1));
spnoad2ch = fittypesum(aa.sp_fit(aa.withad == 0));
timad2ch = fittypesum(aa.tim_fit(aa.withad == 1));
timnoad2ch = fittypesum(aa.tim_fit(aa.withad == 0));
clear aa

aa = readtable('chr2ad_stepsizedist.csv');
fch2ad = fittypesum(aa.f_fit(aa.withch == 1));
fnoch2ad = fittypesum(aa.f_fit(aa.withch == 0));
dch2ad = fittypesum(aa.d_fit(aa.withch == 1));
dnoch2ad = fittypesum(aa.d_fit(aa.withch == 0));
spch2ad = fittypesum(aa.sp_fit(aa.withch == 1));
spnoch2ad = fittypesum(aa.sp_fit(aa.withch == 0));
timch2ad = fittypesum(aa.tim_fit(aa.withch == 1));
timnoch2ad = fittypesum(aa.tim_fit(aa.withch == 0));

aa = readtable('fittypes_advoc_noWR_WOR.csv');
f_alladvoc = fittypesum(aa.f_fit);
d_alladvoc = fittypesum(aa.d_fit);
sp_alladvoc = fittypesum(aa.sp_fit);
t_alladvoc = fittypesum(aa.tim_fit);

aa = readtable('fittypes_chvoc_noWR_WOR.csv');
f_allchvoc = fittypesum(aa.f_fit);
d_allchvoc = fittypesum(aa.d_fit);
sp_allchvoc = fittypesum(aa.sp_fit);
t_allchvoc = fittypesum(aa.tim_fit);

%group them to have bar plots
Y_f = [fad2ch;fnoad2ch;f_allchvoc;fch2ad; fnoch2ad;f_alladvoc];
Y_d = [dad2ch; dnoad2ch;d_allchvoc;dch2ad; dnoch2ad;d_alladvoc];
Y_sp = [spad2ch;spnoad2ch;sp_allchvoc;spch2ad; spnoch2ad;sp_alladvoc];
Y_tim = [timad2ch; timnoad2ch;t_allchvoc;timch2ad; timnoch2ad;t_alladvoc];

%plot
figure;

subplot(2,2,1)
hold all
bar(transpose(Y_f),'grouped')
title('a f')
%xticks([Normal Lognormal Exp Pareto])
set(gcf,'color','w');

subplot(2,2,2)
hold all
bar(transpose(Y_d),'grouped')
title('c d')
set(gcf,'color','w');

subplot(2,2,3)
hold all
bar(transpose(Y_sp),'grouped')
title('b sp')
ll = legend('Ch-WR','Ch-WOR','Ch-unsplit','Ad-WR','Ad-WOR','Ad-unsplit');
set(ll,'Interpreter','tex');
set(gcf,'color','w');

subplot(2,2,4)
hold all
bar(transpose(Y_tim),'grouped')
title('d tim')
set(gcf,'color','w');

%close all

end

%--------------------------------------------------------------------------------
clear all

%2 Plots of Median and 90th percentile values of step sizes 
for sec = 1
%plots - amplitude

aa_ch_med = readtable('adresp2ch_median_stepsize_alldatatogether.csv');
aa_ad_med = readtable('chresp2ad_median_stepsize_alldatatogether.csv');

aa_ch_90 = readtable('adresp2ch_90prc_stepsize_alldatatogether.csv');
aa_ad_90 = readtable('chresp2ad_90prc_stepsize_alldatatogether.csv');
set(0,'defaulttextinterpreter','tex')

figure;
subplot(2,2,1)
title('\bf{(a amp)}')
hold all
plot(0:10,aa_ch_med.median_d_d(1:11),'bs-')
plot(0:10,aa_ad_med.median_d_d(1:11),'ks-')

ylabel('\bf{Median}','Interpreter','tex','FontSize',40)
ll = legend({'\bf{Infant}','\bf{Adult}'},'FontSize',35);
set(ll,'Interpreter','tex');

subplot(2,2,2)
title('\bf{(b)}')
hold all
plot(0:10,aa_ch_90.median_d_d(1:11),'bs-')
plot(0:10,aa_ad_90.median_d_d(1:11),'ks-')

ylabel('\bf{90^{th} percentile value}','Interpreter','tex','FontSize',40)

set(gcf,'color','w');

%we also create subplot to show how many vocalisations occur as the nth
%vocalisation since the last response
subplot(2,2,3)
title('\bf{(c)}')
hold all
bar(0:10,aa_ch_med.num_d_d(1:11),'b')

set(gcf,'color','w');

subplot(2,2,4)
title('\bf{(d)}')
hold all
bar(0:10,aa_ad_med.num_d_d(1:11),'k')

set(gcf,'color','w');


xlabel('\bf{Number of vocalisations since last response}','Interpreter','tex','FontSize',40)

set(gcf,'color','w');
end

for sec = 1
%plots - frequency

figure;
subplot(1,2,1)
title('\bf{(a pitch)}')
hold all
plot(0:10,aa_ch_med.median_d_f(1:11),'bs-')
plot(0:10,aa_ad_med.median_d_f(1:11),'ks-')

ylabel('\bf{Median}','Interpreter','tex','FontSize',40)
ll = legend({'\bf{Infant}','\bf{Adult}'},'FontSize',35);
set(ll,'Interpreter','tex');

subplot(1,2,2)
title('\bf{(b)}')
hold all
plot(0:10,aa_ch_90.median_d_f(1:11),'bs-')
plot(0:10,aa_ad_90.median_d_f(1:11),'ks-')

ylabel('\bf{90^{th} percentile value}','Interpreter','tex','FontSize',40)

xlabel('\bf{Number of vocalisations since last response}','Interpreter','tex','FontSize',40)

set(gcf,'color','w');
end

for sec = 1
%plots - acoustic space

figure;
subplot(1,2,1)
title('\bf{(a sp)}')
hold all
plot(0:10,aa_ch_med.median_d_sp(1:11),'bs-')
plot(0:10,aa_ad_med.median_d_sp(1:11),'ks-')

ylabel('\bf{Median}','Interpreter','tex','FontSize',40)
ll = legend({'\bf{Infant}','\bf{Adult}'},'FontSize',35);
set(ll,'Interpreter','tex');

subplot(1,2,2)
title('\bf{(b)}')
hold all
plot(0:10,aa_ch_90.median_d_sp(1:11),'bs-')
plot(0:10,aa_ad_90.median_d_sp(1:11),'ks-')

ylabel('\bf{90^{th} percentile value}','Interpreter','tex','FontSize',40)

xlabel('\bf{Number of vocalisations since last response}','Interpreter','tex','FontSize',40)

set(gcf,'color','w');
end

for sec = 1
%plots - frequency

figure;
subplot(1,2,1)
title('\bf{(a time)}')
hold all
plot(0:10,aa_ch_med.median_d_t(1:11),'bs-')
plot(0:10,aa_ad_med.median_d_t(1:11),'ks-')

ylabel('\bf{Median}','Interpreter','tex','FontSize',40)
ll = legend({'\bf{Infant}','\bf{Adult}'},'FontSize',35);
set(ll,'Interpreter','tex');

subplot(1,2,2)
title('\bf{(b)}')
hold all
plot(0:10,aa_ch_90.median_d_t(1:11),'bs-')
plot(0:10,aa_ad_90.median_d_t(1:11),'ks-')

ylabel('\bf{90^{th} percentile value}','Interpreter','tex','FontSize',40)

xlabel('\bf{Number of vocalisations since last response}','Interpreter','tex','FontSize',40)

set(gcf,'color','w');
end


