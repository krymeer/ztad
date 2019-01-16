% Osada Krzysztof, 2019
%
% Mamy do czynienia ze zmiennymi powiazanymi:
% kazda waluta wystepuje dokladnie 3 razy

clc; clear all; close all

M   = csvread('kursy_walut.csv', 1, 1)
C1  = M(:, 1) 
C2  = M(:, 2) 
C3  = M(:, 3)

%{
qqplot(C3)
title('Kurs sredni walut obcych - populacja nr 3')
ylabel('Kwantyle probek wejsciowych')
xlabel('Kwantyle normalne')
%}