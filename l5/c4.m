% Osada Krzysztof, 2018
% https://www.mathworks.com/help/stats/ranksum.html
% https://www.mathworks.com/help/matlab/ref/readtable.html

clc; clear all; close all

T = readtable('czytelnictwo.csv')

clc

% H0: mediana jest rowna 0 (czas poswiecany na codzienna lekture prasy nie zmienil sie)
% H1: mediana jest wieksza od 0 (czas poswiecany na codzienna lekture prasy zmalal)
% Uwaga: wynik jest inny niz w cw. 2.

[p, h, stats] = ranksum(T.przed, T.po, 'Tail', 'right')