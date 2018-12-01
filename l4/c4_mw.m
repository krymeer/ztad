% Osada Krzysztof, 2018
% https://www.mathworks.com/help/matlab/ref/readtable.html

clc; clear all; close all;

T                   = readtable('absolwenci.csv')
salary_m            = T(strcmp(T.GENDER, 'Mezczyzna'), :).SALARY
salary_w            = T(strcmp(T.GENDER, 'Kobieta'), :).SALARY

clc

subplot(2, 1, 1)
qqplot(salary_m)
title('Mezczyzni')
ylabel('Liczba osob')
xlabel('Kwantyle normalne')

subplot(2, 1, 2)
qqplot(salary_w)
title('Kobiety')
ylabel('Liczba osob')
xlabel('Kwantyle normalne')

suptitle('Porownanie zarobkow absolwentow wg plci')