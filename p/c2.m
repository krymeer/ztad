% Osada Krzysztof, 2019
%
% Mamy do czynienia ze zmiennymi powiazanymi:
% kazda waluta wystepuje dokladnie 3 razy

clc; clear all; close all

M   = csvread('kursy_walut.csv', 2, 1)
C1  = M(:, 1) 
C2  = M(:, 2) 
C3  = M(:, 3)

[swh1, swp1, swstats1] = swtest(C1)
[swh2, swp2, swstats2] = swtest(C2)
[swh3, swp3, swstats3] = swtest(C3)

if swh1 > 0 && swh2 > 0 && swh3 > 0
    disp('Co najmniej jedna z populacji nie pochodzi z rozkladu normalnego')
end

pkw     = kruskalwallis(M, [], 'off')
prs12   = ranksum(C1, C2)
prs23   = ranksum(C2, C3)
prs13   = ranksum(C1, C3)

if pkw < 0.05
    disp('Kruskal-Wallis: dane nie pochodza z tego samego rozkladu')
end

if prs12 < 0.05 || prs13 < 0.05 || prs23 < 0.05
    disp('Wilcoxon: populacje nie maja rownych median');
end