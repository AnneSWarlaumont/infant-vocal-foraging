clear all
clc

%Ritwika VPS, UC Merced

%find rms error for mean step size/speed curves for human labelled data and
%the corresponding LENA labelled data

%child vocalistions
ahum = readtable('adresp2ch_mean_stepsize_HUM.csv');
alena = readtable('adresp2ch_mean_stepsize_LENA.csv');

sp = rmsefn(ahum.mean_d_sp(1:20),alena.mean_d_sp(1:20));

t = rmsefn(ahum.mean_d_t(1:20),alena.mean_d_t(1:20));

vsp = rmsefn(ahum.mean_v_sp(1:20),alena.mean_v_sp(1:20));

f = rmsefn(ahum.mean_d_f(1:20),alena.mean_d_f(1:20));

d = rmsefn(ahum.mean_d_d(1:20),alena.mean_d_d(1:20));

T = table(sp, t, vsp, f, d);
writetable(T,'adresp2ch_rmse_HUM_meanstsiz.csv')

%adult vocalistaions
clear all

ahum = readtable('chresp2ad_mean_stepsize_HUM.csv');
alena = readtable('chresp2ad_mean_stepsize_LENA.csv');

sp = rmsefn(ahum.mean_d_sp(1:20),alena.mean_d_sp(1:20));

t = rmsefn(ahum.mean_d_t(1:20),alena.mean_d_t(1:20));

vsp = rmsefn(ahum.mean_v_sp(1:20),alena.mean_v_sp(1:20));

f = rmsefn(ahum.mean_d_f(1:20),alena.mean_d_f(1:20));

d = rmsefn(ahum.mean_d_d(1:20),alena.mean_d_d(1:20));

T = table(sp, t, vsp, f, d);
writetable(T,'chresp2ad_rmse_HUM_meanstsiz.csv')