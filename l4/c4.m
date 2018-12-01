% Osada Krzysztof, 2018
% https://www.mathworks.com/help/matlab/ref/readtable.html
% https://www.mathworks.com/help/stats/ttest.html

clc; clear all; close all;

T           = readtable('absolwenci.csv')
salary_m    = T(strcmp(T.GENDER, 'Mezczyzna'), :).SALARY
salary_w    = T(strcmp(T.GENDER, 'Kobieta'), :).SALARY

% Zalozenie: roznice miedzy parami pomiarow powinny miec rozklad normalny
% Nie mozna jednak przeprowadzic testu z uwagi na to, ze licznosci grup nie sa takie same

salary_m_s  = salary_m(1:469)

clc

%qqplot(salary_m_s-salary_w)
%title('Roznice w zarobkach mezczyzn i kobiet')
%ylabel('Roznica (na rzecz mezczyzn)')
%xlabel('Kwantyle normalne')

% H0 roznica miedzy zarobkami mezczyzn i kobiet nie jest znaczaca
% H1 roznica miedzy zarobkami mezczyzn i kobiet jest niezerowa
% H1' roznica miedzy zarobkami mezczyzn i kobiet dziala na korzysc pierwszej grupy

[h_m, pval_m, swstat_m] = swtest(salary_m)
[h_w, pval_w, swstat_w] = swtest(salary_w)

%[h, p, ci, stats]           = ttest(salary_m_s, salary_w)
%[h_a, p_a, ci_a, stats_a]   = ttest(salary_m_s, salary_w, 'Tail', 'right')