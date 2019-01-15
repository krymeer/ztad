% Osada Krzysztof, 2019
%
% Parametry rozkladu poszczegolnych populacji: 
% srednia, odchylenie standardowe, minimum, maksimum, 
% mediana, pierwszy kwartyl i trzeci kwartyl

clc; clear all; close all

M = csvread('kursy_walut.csv', 1, 1)

mean_               = mean(M)
standard_deviation  = std(M)
minimum             = min(M)
maximum             = max(M)
median_             = median(M)
first_quartile      = quantile(M, 0.25)
third_quartile      = quantile(M, 0.75)