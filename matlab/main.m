%% global variables
global int
global lat
int = 'interpreter';
lat = 'latex';
R = 10000;% Ratio of noise to signal
n = 512;% number of terms of filter
H = @H1;% function to calculate the optimum frf
t = 0 : 20000;% time
%% ideal H
figure(1)
N = 1000;
alpha = pi / 3;
omega = linspace(0, pi, N);
H_ideal = heaviside(omega) - heaviside(omega - alpha);
plot(omega, H_ideal);
set(gca,'XTick',[0,pi/3,pi]);xticklabels={'0','\alpha','\pi'};
set(gca,'xticklabel',xticklabels);
set(gca,'yTick',[0, 1]);yticklabels={'0', '1'};
ylim([0 1.5]);
set(gca,'yticklabel',yticklabels);
xlabel('\omega');
ylabel('H(e^{j\omega})')
title('理想低通滤波器幅频特性');
saveas(gcf, 'ideal_H.pdf')
%% signal
figure(2)
S_t = 0.1 *cos(2 * pi * t / 10);
% subplot(2, 2, 1);
stem(t, S_t, 'filled', 'MarkerSize', 3);
xlim([0, 100]);
xlabel('$t$', int, lat);
ylabel('$S[t]$', int, lat);
grid on;
figure()
n_t = R * 0.1 * (cos(2*pi*t/3) + cos(2*pi*t/4) + cos(2*pi*t/5));
% subplot(2, 2, 2);
stem(t, n_t, 'filled', 'MarkerSize', 3);
xlabel('$t$', int, lat);
ylabel('$n[t]$', int, lat);
xlim([0, 100]);
x_t = S_t + n_t;
grid on;
figure()
% subplot(2, 1, 2);
stem(t, x_t, 'filled', 'MarkerSize', 3);
xlabel('$t$', int, lat);
ylabel('$x[t]$', int, lat);
xlim([0, 100]);
grid on;

%% ht
k = -n : n;
h_t = IRFh(k);
grid on;
stem(k(n+1 : end), h_t(n+1 : end), 'filled', 'MarkerSize', 3);
xlabel('$t$', int, lat);
ylabel('$h[t]$', int, lat);
set(gca,'yTick',[0,1/3]);yticklabels={'0','1/3'};
set(gca,'yticklabel',yticklabels);
grid on;
%% H when n = 64
H_0 = H0(omega, 0);
plot(omega, H_0);
set(gca,'XTick',[0,pi/3,pi]);xticklabels={'0','\alpha','\pi'};
set(gca,'xticklabel',xticklabels);
set(gca,'yTick',[0, 1]);yticklabels={'0', '1'};
set(gca,'yticklabel',yticklabels);
xlabel('\omega');
ylabel('H(e^{j\omega})')
grid on;

%% using ideal filter
figure(2)
% subplot(3, 1, 1);
[t_plot, y_t] = filter1(x_t, h_t);
stem_plot(t_plot, y_t(t_plot));
axis tight;
xlabel('$t$', int, lat)
ylabel('$y[t]$', int, lat)
figure()
% subplot(3, 1, 2);
stem_plot(t_plot, S_t(t_plot));
axis tight;
figure()
% subplot(3, 1, 3)
delta_t = y_t - S_t;
stem_plot(t_plot, delta_t(t_plot));
xlabel('$t$', int, lat)
ylabel('$\Delta[t]$', int, lat)
axis tight;
%% using the optimized irf
% h_t = oirf(H, 16, 7, pi / 3, pi / 5, 1);
h_t = oirf(H, 30, 13, pi / 3, pi / 5, 1);
figure(3)
% subplot(3, 1, 1);
[t_plot, y_t] = filter1(x_t, h_t);
stem_plot(t_plot, y_t(t_plot));
xlabel('$t$', int, lat)
ylabel('$y[t]$', int, lat)
axis tight;
figure()
% subplot(3, 1, 2);
stem_plot(t_plot, S_t(t_plot));
axis tight;
figure()
% subplot(3, 1, 3)
delta_t = y_t - S_t;
stem_plot(t_plot, delta_t(t_plot));
xlabel('$t$', int, lat)
ylabel('$\Delta[t]$', int, lat)
axis tight;

%% multiple noise case
S_t = 0.1 * cos(2 * pi * t / 8);
n_t = R * 0.1 * (1 * cos(2 * pi * t/ 24) + 1 * cos(2 * pi * t/ 3));
x_t = S_t + n_t;

h1_t = oirf(H, 20, 13, pi  / 2, pi / 4, 1);
[t_1, y1_t] = filter1(x_t, h1_t);
S1_t = S_t(t_1);
figure(4)

subplot(3, 1, 1);
stem_plot(t_1, y1_t(t_1));
axis tight;
subplot(3, 1, 2);
stem_plot(t_1, S_t(t_1));
axis tight;
subplot(3, 1, 3)
delta_t = y1_t - S_t;
stem_plot(t_1, delta_t(t_1));
axis tight;


figure()
h2_t = oirf(H, 30, 13, pi / 6, pi / 4, 2);
pause
[t_2, y_t] = filter1(y1_t(t_1), h2_t);
% subplot(3, 1, 1);
stem_plot(t_2, y_t(t_2));
axis tight;
xlabel('$t$', int, lat)
ylabel('$y[t]$', int, lat)
% subplot(3, 1, 2);
figure()
stem_plot(t_2, S1_t(t_2));
axis tight;
% subplot(3, 1, 3)
figure()
delta_t = y_t - S1_t;
stem_plot(t_2, delta_t(t_2));
xlabel('$t$', int, lat)
ylabel('$\Delta[t]$', int, lat)
% axis tight;