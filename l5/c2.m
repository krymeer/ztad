% Osada Krzysztof, 2018
% https://www.mathworks.com/help/stats/signtest.html
% https://www.mathworks.com/help/matlab/ref/readtable.html

clc; clear all; close all

T = readtable('czytelnictwo.csv')

clc

% H0: mediana jest rowna 0 (czas poswiecany na codzienna lekture prasy nie zmienil sie)
% H1: mediana jest wieksza od 0 (czas poswiecany na codzienna lekture prasy zmalal)

[p, h, stats] = signtest(T.przed, T.po, 'Tail', 'right')

%{
plot_1 = plot(T.przed, '-s')
hold on

plot_2 = plot(T.po, '-s')

set(plot_1, 'linewidth', 2)
set(plot_2, 'linewidth', 2)

title('Czas poswiecany na codzienna lekture pracy')

legend('Przed zatrudnieniem', 'Po zatrudneniu', 'Location', 'best')
ylabel('Czas [min]')
xlabel('Indeks porzadkowy pracownika')
%}