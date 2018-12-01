% Osada Krzysztof, 2018
% https://www.mathworks.com/help/matlab/ref/readtable.html
% https://www.mathworks.com/help/stats/kstest.html
% https://www.mathworks.com/help/stats/kstest2.html
% https://www.mathworks.com/help/matlab/matlab_prog/find-array-elements-that-meet-a-condition.html

clc; clear all; close all;

T           = readtable('pacjenci.csv')
mezczyzni   = T(strcmp(T.plec, 'M'), :)
kobiety     = T(strcmp(T.plec, 'K'), :)
w_m         = sort(mezczyzni.wzrost)
w_w         = sort(kobiety.wzrost)

[h_m, p_m]  = kstest(w_m)
[h_w, p_w]  = kstest(w_w)
[h, p]      = kstest2(w_m, w_w)


cdf_m       = cdf('Normal', w_m, mean(w_m), std(w_m))
cdf_w       = cdf('Normal', w_w, mean(w_w), std(w_w))

subplot(2, 1, 1)
cdfp_m      = cdfplot(w_m)
set(cdfp_m, 'linewidth', 2)

hold on
plot(w_m, cdf_m, 'linewidth', 2, 'color', [1 0 0])
hold off
title('Dystrybuanta wieku mezczyzn')
legend('Dystrybuanta empiryczna','Dystrybuanta rozkladu normalnego','Location','best')

subplot(2, 1, 2)
cdfp_w      = cdfplot(w_w)
set(cdfp_w, 'linewidth', 2, 'color', [0.13 0.69 0.25])

hold on
plot(w_w, cdf_w, 'linewidth', 2, 'color', [0.72 0.47 0.34])
title('Dystrybuanta wieku kobiet')
legend('Dystrybuanta empiryczna','Dystrybuanta rozkladu normalnego','Location','best')