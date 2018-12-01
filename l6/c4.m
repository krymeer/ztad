% Osada Krzysztof, 2018
% https://www.mathworks.com/help/stats/multcompare.html

clc; clear all; close all

load('popcorn')

% H01: srednia liczba kubkow dla kazdego z producentow jest jednakowa
% H02: srednia liczba kubkow jest niezalezna od typu maszyny
% H03: producent i typ maszyny nie maja synergicznego wpływu na srednie populacyjne

[~, ~, stats]   = anova2(popcorn, 3, 'off')
[c, m, h, nms]  = multcompare(stats)

[cellstr(nms) num2cell(m)]

%{

    a       b       c       d       e       f
    1.0000  2.0000  0.9260  1.5000  2.0740  0.0000
    1.0000  3.0000  1.6760  2.2500  2.8240  0.0000
    2.0000  3.0000  0.1760  0.7500  1.3240  0.0116

    a, b    – porownywane grupy
    d       – roznica srednich
    c, e    – 95% przedzial ufnosci dla faktycznej roznicy srednich
    f       – p-value

%}