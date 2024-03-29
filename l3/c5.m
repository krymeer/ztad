% Osada Krzysztof, 2018
% https://www.mathworks.com/help/stats/ttest.html
% https://www.mathworks.com/help/stats/ttest2.html
% https://www.mathworks.com/help/stats/cdfplot.html
% https://www.mathworks.com/help/stats/kstest.html


clc; clear all; close all

delikates   = [23.4, 30.9, 18.8, 23.0, 21.4, 1, 24.6, 23.8, 24.1, 18.7, 16.3, 20.3, 14.9, 35.4, 21.6, 21.2, 21.0, 15.0, 15.6, 24.0, 34.6, 40.9, 30.7, 24.5, 16.6, 1, 21.7, 1, 23.6, 1, 25.7, 19.3, 46.9, 23.3, 21.8, 33.3, 24.9, 24.4, 1, 19.8, 17.2, 21.5, 25.5, 23.3, 18.6, 22.0, 29.8, 33.3, 1, 21.3, 18.6, 26.8, 19.4, 21.1, 21.2, 20.5, 19.8, 26.3, 39.3, 21.4, 22.6, 1, 35.3, 7.0, 19.3, 21.3, 10.1, 20.2, 1, 36.2, 16.7, 21.1, 39.1, 19.9, 32.1, 23.1, 21.8, 30.4, 19.62, 15.5]

renety      = [16.5, 1, 22.6, 25.3, 23.7, 1, 23.3, 23.9, 16.2, 23.0, 21.6, 10.8, 12.2, 23.6, 10.1, 24.4, 16.4, 11.7, 17.7, 34.3, 24.3, 18.7, 27.5, 25.8, 22.5, 14.2, 21.7, 1, 31.2, 13.8, 29.7, 23.1, 26.1, 25.1, 23.4, 21.7, 24.4, 13.2, 22.1, 26.7, 22.7, 1, 18.2, 28.7, 29.1, 27.4, 22.3, 13.2, 22.5, 25.0, 1, 6.6, 23.7, 23.5, 17.3, 24.6, 27.8, 29.7, 25.3, 19.9, 18.2, 26.2, 20.4, 23.3, 26.7, 26.0, 1, 25.1, 33.1, 35.0, 25.3, 23.6, 23.2, 20.2, 24.7, 22.6, 39.1, 26.5, 22.7]

% Funkcja ttest sluzy do okreslania, czy: a) srednia jest rowna 0; b) srednia jest rowna m.
% Z kolei ttest2 pozwala okresic, czy wektory pochodza z prob z rozkladu normalnego o rownych srednich i nieznanych wariancjach
% Przy uzyciu ttest nie mozna stwierdzic, czy dane pochodza z rozkladu normalnego
% h = 0 => nie jest wykluczone, ze dane pochodza z tego samego rozkladu

hold on

ecdf_d  = cdfplot(delikates)
ecdf_r  = cdfplot(renety)

set(ecdf_d, 'linewidth', 2, 'color', [0 0 1])
set(ecdf_r, 'linewidth', 2, 'color', [1 0 0])
title('Wykres empirycznych dystrybuant')

% Weryfikacja hipotezy, czy probki pochodza z rozkladow normalnych
[h_d, p_d]  = kstest(delikates)
[h_r, p_r]  = kstest(renety)
[h, p]      = kstest2(delikates, renety)

legend('Delikates', 'Reneta', 'Location', 'best')

[h, p]  = ttest2(delikates, renety)
