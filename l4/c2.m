% Osada Krzysztof, 2018

clc; clear all; close all;

nervous     = [3, 3, 4, 5, 5]
calm        = [4, 6, 7, 9, 9]

% Czy dane pochodza z rozkladu normalnego?
[hn, pvaln, swstatn] = swtest(nervous)
[hc, pvalc, swstatc] = swtest(calm)

clc

if hn == 0 && hc == 0
    % H0: srednia liczba gestow osoby nerwowej jest rowna sredniej liczbie gestow osoby spokojnej
    % H1: srednia liczba gestow osoby nerwowej jest mniejsza od sredniej liczby gestow osoby spokojnej
    [h, pval, ci, stats] = ttest2(nervous, calm, 'Tail', 'Left')
else
    disp('Przynajmniej jeden z zestawow danych nie pochodzi z rozkladu normalnego')
end