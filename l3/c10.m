% Osada Krzysztof, 2018
% https://www.mathworks.com/help/matlab/ref/readtable.html
% https://www.mathworks.com/help/stats/kstest.html
% https://www.mathworks.com/matlabcentral/fileexchange/13964-shapiro-wilk-and-shapiro-francia-normality-tests

clc; clear all; close all;

T                   = readtable('absolwenci.csv')
farm_s              = T(strcmp(T.COLLEGE, 'Rolnictwo'), :).SALARY
teach_s             = T(strcmp(T.COLLEGE, 'Pedagogika'), :).SALARY

[ksh, ksp, ksstat]  = kstest(farm_s)
[sh, sp, sstat]     = swtest(teach_s)