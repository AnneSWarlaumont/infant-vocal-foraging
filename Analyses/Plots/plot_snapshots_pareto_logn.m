clear all
clc

%Ritwika VPS, UC MERCED
%IVFCR - plots to demonstrate how lognormal and pareto distributions vary
%as a fn of parameters within the parameter range in the papr

%2d sp stsz - lognormal distributions, infants and adults

figure;
subplot(1,3,1)
title('2d sp st siz logn')
hold all
x = 0:0.001:8;
y1 = lognpdf(x,-0.4,0.4);
plot(x,y1/trapz(x,y1))
y1 = lognpdf(x,-0.1,0.4);
plot(x,y1/trapz(x,y1))
y1 = lognpdf(x,0,0.4);
plot(x,y1/trapz(x,y1))
y1 = lognpdf(x,0.2,0.4);
plot(x,y1/trapz(x,y1))
y1 = lognpdf(x,0.2,0.6);
plot(x,y1/trapz(x,y1))
y1 = lognpdf(x,0.2,0.8);
plot(x,y1/trapz(x,y1))
y1 = lognpdf(x,0.2,1);
plot(x,y1/trapz(x,y1))
legend('mu = -0.4, sigma = 0.4','mu = -0.1, sigma = 0.4','mu = 0, sigma = 0.4','mu = 0.2, sigma = 0.4',...
'mu = 0.2, sigma = 0.6','mu = 0.2, sigma = 0.8','mu = 0.2, sigma = 1')


%time sts iz logn - infants
subplot(1,3,2)
title('time st siz logn')
hold all
x = 0:20000;
y1 = lognpdf(x,2,1);
plot(x,y1/trapz(x,y1))
y1 = lognpdf(x,3,1);
plot(x,y1/trapz(x,y1))
y1 = lognpdf(x,4,1);
plot(x,y1/trapz(x,y1))
y1 = lognpdf(x,4,1.5);
plot(x,y1/trapz(x,y1))
y1 = lognpdf(x,4,2);
plot(x,y1/trapz(x,y1))
legend('mu = 2, sigma = 1','mu = 3, sigma = 1','mu = 4, sigma = 1','mu = 4, sigma = 1.5','mu = 4, sigma = 2')

%time stsz pareto - adults
subplot(1,3,3)
hold all
title('time st siz pareto')

alpha = 1.3; %make sure that the condition on the range of x values: x element of [xm, infinity] is met.
xm = 1;
x = xm:20000;
y1 = alpha*(xm^alpha)./(x.^(alpha + 1));
plot(x,y1/trapz(x,y1))

alpha = 1.5;
y1 = alpha*(xm^alpha)./(x.^(alpha + 1));
plot(x,y1/trapz(x,y1))

alpha = 2;
y1 = alpha*(xm^alpha)./(x.^(alpha + 1));
plot(x,y1/trapz(x,y1))

xm = 1.1;
x = xm:20000;
y1 = alpha*(xm^alpha)./(x.^(alpha + 1));
plot(x,y1/trapz(x,y1))

xm = 1.3;
x = xm:20000;
y1 = alpha*(xm^alpha)./(x.^(alpha + 1));
plot(x,y1/trapz(x,y1))

xm = 100; %this is just to show the effect of xm scaling

x = xm:20000;
y1 = alpha*(xm^alpha)./(x.^(alpha + 1));
plot(x,y1/trapz(x,y1))
legend('xmin = 1, alpha = 1.3','xmin = 1, alpha = 1.5','xmin = 1, alpha = 2','xmin = 1.1, alpha = 2','xmin = 1.3, alpha = 2','xmin =100, alpha = 2')

