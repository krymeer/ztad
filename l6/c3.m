% Osada Krzysztof, 2018
% https://www.mathworks.com/help/stats/friedman.html
% https://www.mathworks.com/help/stats/kruskalwallis.html

clc; clear all; close all

data    = [3415 4556 5772 5432; 1593 1937 2242 2794; 1976 2056 2240 2085; 1526 1594 1644 1705; 1538 1634 1866 1769; 983 1086 1135 1177; 1050 1209 1245 977; 1861 2087 2054 2018; 1714 2415 2361 2424; 1320 1621 1624 1551; 1276 1377 1522 1412; 1263 1279 1350 1490; 1271 1417 1583 1513; 1436 1310 1357 1468]

[h_1, pval_1, swstat_1] = swtest(data(:,1))
[h_2, pval_2, swstat_2] = swtest(data(:,2))
[h_3, pval_3, swstat_3] = swtest(data(:,3))
[h_4, pval_4, swstat_4] = swtest(data(:,4))

if h_1 > 0 || h_2 > 0 || h_3 > 0 || h_4 > 0
    disp("Ostrzezenie: zestaw danych nie pochodzi z rozkladu normalnego")
end

% friedman(x, reps), gdzie reps oznacza liczbe replikacji na jedna komorke [?]
% "The number of rows must be a multiple of REPS." 

% H0: wielkosc sprzedazy nie zalezy od kwartalu
% H1: wielkosc sprzedazy jest rozna w zaleznosci od kwartalu
p       = friedman(data)

%{

Source      SS      df     MS      Chi-sq   Prob>Chi-sq
-------------------------------------------------------
Columns   39.8571    3   13.2857   23.91    2.60307e-05
Error     30.1429   39    0.7729                       
Total     70        55                                 

%}

% kruskalwallis(x) zwraca p-value dla hipotezy gloszacej, ze dane z kazdej kolumny macierzy pochodza z tego samego rozkladu
p       = kruskalwallis(data)