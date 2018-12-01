% Osada Krzysztof, 2018
clc; clear

m       = 31.5                      % Srednia populacji
sig     = 5                         % Odchylenie standardowe populacji
n       = 100                       % Rozmiar proyby
x       = normrnd(m, sig, n, 1)     % Proba z populacji
mu      = 28                        % Weryfikowana srednia proby
[h, p]  = ttest(x, mu)              % Test hipotezy