% Osada Krzysztof, 2018
% https://www.mathworks.com/help/stats/ranksum.html
% https://www.mathworks.com/help/matlab/ref/readtable.html

clc; clear all; close all

T = readtable('koronografia.csv')

g_1 = T(T.group == 1, :).time
g_2 = T(T.group == 2, :).time

clc

% H0: mediana jest rowna 0 (czas cwiczenia jest taki sam w obu grupach)
% H1: mediana jest wieksza od 0 (czas cwiczenia jest wiekszy w grupie 1.)

[p, h, stats] = ranksum(g_1, g_2, 'Tail', 'right', 'Alpha', 0.1)

%{
plot_1 = plot(g_1, '-s')
hold on

plot_2 = plot(g_2, '-s')

set(plot_1, 'linewidth', 2)
set(plot_2, 'linewidth', 2)

title('Czas cwiczenia a stan zdrowia')

legend('Grupa 1', 'Grupa 2', 'Location', 'best')
ylabel('Czas')
xlabel('Indeks porzadkowy pacjenta')
%}