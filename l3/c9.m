% Osada Krzysztof, 2018
% https://www.mathworks.com/help/matlab/ref/readtable.html
% https://www.mathworks.com/matlabcentral/fileexchange/13964-shapiro-wilk-and-shapiro-francia-normality-tests

clc; clear all; close all;

T               = readtable('kondensatory.csv')
[h, p, stat]    = swtest(T.pojemnosc)