% Osada Krzysztof, 2019
%
% Mamy do czynienia ze zmiennymi powiazanymi:
% kazda waluta wystepuje dokladnie 3 razy

clc; clear all; close all

M   = csvread('kursy_walut.csv', 1, 1)
C1  = M(:, 1) 
C2  = M(:, 2) 
C3  = M(:, 3)

[swh1, swp1, swstats1] = swtest(C1)
[swh2, swp2, swstats2] = swtest(C2)
[swh3, swp3, swstats3] = swtest(C3)

if swh1 > 0 && swh2 > 0 && swh3 > 0
    disp('Co najmniej jedna z populacji nie pochodzi z rozkladu normalnego')

    stats_12 = mwwtest(C1, C2)
    stats_23 = mwwtest(C2, C3)
    stats_13 = mwwtest(C1, C3)

    if stats_12.p(1) < 0.05 || stats_12.p(2) < 0.05
        disp('Probki z populacji 1. i 2. nie sa jednakowo duze')
    end
    
    if stats_23.p(1) < 0.05 || stats_23.p(2) < 0.05
        disp('Probki z populacji 2. i 3. nie sa jednakowo duze')
    end

    if stats_13.p(1) < 0.05 || stats_13.p(2) < 0.05
        disp('Probki z populacji 1. i 3. nie sa jednakowo duze')
    end
end