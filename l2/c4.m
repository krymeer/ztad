% Osada Krzysztof, 2018
clc; clear

m       = 5                             % Srednia populacji
n       = 25                            % Liczba elementow proby rozkladu normalnego
sd      = 1.5                           % Odchylenie standardowe proby
x       = normrnd(m, sd, n, 1)          % Proba z populacji
v       = 1.6                           % Domniemana wariancja proby
a       = 0.1                           % Poziom istotnosci

[h0, p] = vartest(x, v, 'Tail', 'left')                 % 'left': Test the alternative hypothesis that the population variance is less than v
[h1, p] = vartest(x, v, 'Tail', 'left', 'Alpha', a)     % Zmieniony poziom istotnosci

% H0 rowne