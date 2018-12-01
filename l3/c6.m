% Osada Krzysztof, 2018
% https://www.mathworks.com/help/matlab/ref/readtable.html
% https://www.mathworks.com/help/stats/lillietest.html
% https://www.mathworks.com/help/stats/kstest.html
% https://www.mathworks.com/help/matlab/matlab_prog/find-array-elements-that-meet-a-condition.html

clc; clear all; close all;

T           = readtable('pacjenci.csv')
mezczyzni   = T(strcmp(T.plec, 'M'), :)
kobiety     = T(strcmp(T.plec, 'K'), :)
w_m         = sort(mezczyzni.wzrost)
w_w         = sort(kobiety.wzrost)

[h_m, p_m]    = lillietest(w_m)
[h_w, p_w]    = lillietest(w_w)

[h_ma, p_ma]  = kstest(w_m)
[h_wa, p_wa]  = kstest(w_w)

% p is computed using inverse interpolation into the table of critical values, and is returned as a scalar value in the range [0.001,0.50]. lillietest warns when p is not found within the tabulated range and returns either the smallest or largest tabulated value.