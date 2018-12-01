% Osada Krzysztof, 2018
clc; clear

u   = 0.49                      % Weryfikowana wartosc (srednia populacji)
X   = 0.38                      % Srednia proby
s   = 0.14                      % Ochylenie standardowe proby
a   = 0.01                      % Poziom istotnosci
n   = 18                        % Licznosc proby
t   = (X - u)/(s / sqrt(n))     % Wartosc statystyki testowej
p   = 2*tcdf(t, n-1)            % p-value

p <= a                          % Jesli p <= a,to odrzucamy H0

x       = normrnd(X, s, n, 1)   % Proba z rozkladu normalnego o zadanych parametrach
[h, p_] = ttest(x, u)           % Weryfikacja hipotezy