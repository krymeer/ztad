% Osada Krzysztof, 2018
clc; clear

mu      = 3                                                                     % Weryfikowana wartosc
x       = [1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 6, 6, 6, 7, 7]    % Zbior danych
[h, p]  = ttest(x, mu)                                                          % Sprawdzenie hipotezy