% Osada Krzysztof, 2018
% https://www.mathworks.com/help/stats/ranksum.html
% https://www.mathworks.com/help/matlab/ref/readtable.html

clc; clear all; close all

T = readtable('chmiel.csv')

clc

% H0: mediana jest rowna 0 (zapylenie nie ma wplywu na mase nasion)
% H1: mediana jest wieksza od 0 (zapylenie ma wplyw na mase nasion)

[p, h, stats] = ranksum(T.zapylona, T.niezapyl, 'Tail', 'right')

%{
plot_1 = plot(T.zapylona, '-s')
hold on

plot_2 = plot(T.niezapyl, '-s')

set(plot_1, 'linewidth', 2)
set(plot_2, 'linewidth', 2)

title('Wplyw zapylenia rosliny na mase nasion')

legend('Zapylona czesc', 'Niezapylona czesc', 'Location', 'best')
ylabel('Masa nasion [g/10 g chmielu]')
xlabel('Indeks porzadkowy rosliny')
%}