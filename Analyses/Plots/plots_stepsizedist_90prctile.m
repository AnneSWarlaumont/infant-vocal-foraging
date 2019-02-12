clear all
clc
set(0,'defaulttextinterpreter','tex') %set default text interpreter to latex

%90th percentile values plots for infant and adult vocalisations: LENA
%only. Based on raw step size data (NOT AIC fits).
%--------------------------------------------------------------------------------
%1: space 
%------------------------------------------
for sec = 1
%child: lognormal
aa = readtable('prctile90_adresp2ch.csv');

figure;
set(gcf,'color','w');

subplot(2,2,1)
hold all
title('\bf{(e ch sp)}')
plot(aa.age(aa.withad == 1),aa.prctile90_sp(aa.withad == 1),'bs','MarkerSize',15) %wr is b, wor is r
plot(aa.age(aa.withad == 0),aa.prctile90_sp(aa.withad == 0),'rs','MarkerSize',15)
ylabel('\bf{90\textsuperscript{th} percentile}','Interpreter','latex','FontSize',40)

ll = legend({'\bf{WR}','\bf{WOR}'},'FontSize',24);
set(ll,'Interpreter','Latex');

clear all

%adult: lognormal
subplot(2,2,2)
hold all
aa = readtable('prctile90_chresp2ad.csv');
title('\bf{(f ad )}')
plot(aa.age(aa.withch == 1),aa.prctile90_sp(aa.withch == 1),'ks','MarkerSize',15)
plot(aa.age(aa.withch == 0),aa.prctile90_sp(aa.withch == 0),'gs','MarkerSize',15)

ll = legend({'\bf{WR}','\bf{WOR}'},'FontSize',24);
set(ll,'Interpreter','Latex');

clear all

xlabel('\bf{Infant age (days)}','Interpreter','latex','FontSize',40)

end

clear all

%--------------------------------------------------------------------------------
%2: Time 
%------------------------------------------
for sec = 1
%child: lognormal
aa = readtable('prctile90_adresp2ch.csv');

figure;
set(gcf,'color','w');

subplot(2,2,1)
hold all
title('\bf{(e ch time)}')
plot(aa.age(aa.withad == 1),aa.prctile90_t(aa.withad == 1),'bs','MarkerSize',15) %wr is b, wor is r
plot(aa.age(aa.withad == 0),aa.prctile90_t(aa.withad == 0),'rs','MarkerSize',15)
ylabel('\bf{90\textsuperscript{th} percentile}','Interpreter','latex','FontSize',40)

ll = legend({'\bf{WR}','\bf{WOR}'},'FontSize',24);
set(ll,'Interpreter','Latex');

clear all

%adult: pareto
subplot(2,2,2)
hold all
aa = readtable('prctile90_chresp2ad.csv');
title('\bf{(f ad )}')
plot(aa.age(aa.withch == 1),aa.prctile90_t(aa.withch == 1),'ks','MarkerSize',15)
plot(aa.age(aa.withch == 0),aa.prctile90_t(aa.withch == 0),'gs','MarkerSize',15)

ll = legend({'\bf{WR}','\bf{WOR}'},'FontSize',24);
set(ll,'Interpreter','Latex');

clear all

xlabel('\bf{Infant age (days)}','Interpreter','latex','FontSize',40)

end

clear all

%--------------------------------------------------------------------------------
%3: frequency steps
%--------------------------------------------------------------------------------
for sec = 1

figure;
set(gcf,'color','w');

%ch  
subplot(2,2,1)
hold all

title('\bf{(g ch pitch)}')
aa = readtable('prctile90_adresp2ch.csv');

plot(aa.age(aa.withad == 1),aa.prctile90_f(aa.withad == 1),'bs','MarkerSize',15) %wr is b, wor is r
plot(aa.age(aa.withad == 0),aa.prctile90_f(aa.withad == 0),'rs','MarkerSize',15)
ylabel('\bf{90\textsuperscript{th} percentile}','Interpreter','latex','FontSize',40)

ll = legend({'\bf{WR}','\bf{WOR}'},'FontSize',24);
set(ll,'Interpreter','Latex');

clear all

%adult  
subplot(2,2,2)
hold all

title('\bf{(h ad )}')
aa = readtable('prctile90_chresp2ad.csv');

plot(aa.age(aa.withch == 1),aa.prctile90_f(aa.withch == 1),'ks','MarkerSize',15)
plot(aa.age(aa.withch == 0),aa.prctile90_f(aa.withch == 0),'gs','MarkerSize',15)

ll = legend({'\bf{WR}','\bf{WOR}'},'FontSize',24);
set(ll,'Interpreter','Latex');

clear all

xlabel('\bf{Infant age (days)}','Interpreter','latex','FontSize',40)
end

clear all

%--------------------------------------------------------------------------------
%4 amplitude steps
%--------------------------------------------------------------------------------
for sec = 1

figure;
set(gcf,'color','w');

%ch  
subplot(2,2,1)
hold all

title('\bf{(g ch amp)}')
aa = readtable('prctile90_adresp2ch.csv');

plot(aa.age(aa.withad == 1),aa.prctile90_d(aa.withad == 1),'bs','MarkerSize',15) %wr is b, wor is r
plot(aa.age(aa.withad == 0),aa.prctile90_d(aa.withad == 0),'rs','MarkerSize',15)
ylabel('\bf{90\textsuperscript{th} percentile}','Interpreter','latex','FontSize',40)

ll = legend({'\bf{WR}','\bf{WOR}'},'FontSize',24);
set(ll,'Interpreter','Latex');

clear all

%adult  
subplot(2,2,2)
hold all

title('\bf{(h ad )}')
aa = readtable('prctile90_chresp2ad.csv');

plot(aa.age(aa.withch == 1),aa.prctile90_d(aa.withch == 1),'ks','MarkerSize',15)
plot(aa.age(aa.withch == 0),aa.prctile90_d(aa.withch == 0),'gs','MarkerSize',15)

ll = legend({'\bf{WR}','\bf{WOR}'},'FontSize',24);
set(ll,'Interpreter','Latex');

clear all

xlabel('\bf{Infant age (days)}','Interpreter','latex','FontSize',40)
end

clear all
