% Osada Krzysztof, 2018
clc; clear

mx      = 27.7                      % Srednia dla pierwszej populacji
my      = 32.1                      % Srednia dla drugiej populacji
sdx     = 5.5                       % Odchylenie standardowe dla pierwszej populacji
sdy     = 6.3                       % Odchylenie standardowe dla drugiej populacji
nx      = 20                        % Liczebnosc pierwszej populajji
ny      = 22                        % Liczebnosc drugiej populacji

x       = normrnd(mx, sdx, nx, 1)   % Populacja pierwsza
y       = normrnd(my, sdy, ny, 1)   % Populacja druga

[h, p]  = vartest2(x, y)            % Test na rownosc wariancji populacji
