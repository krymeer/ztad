% Osada Krzysztof, 2018
% https://www.mathworks.com/help/stats/anova1.html
% https://www.mathworks.com/help/stats/multcompare.html

clc; clear all; close all

load('anova_data.mat')

% H0: probki zawarte w obu grupach pochodza z populacji o jednakowych wartosciach srednich
% H1: probki zawarte w obu grupach pochodza z populacji o roznych wartosciach srednich

[p, tbl, stats] = anova1(wombats, wombat_groups)
[c, m]          = multcompare(stats)